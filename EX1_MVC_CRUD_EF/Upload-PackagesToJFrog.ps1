# === 設定區 ===
$packagesConfigPath = "packages.config" # 也可以改成絕對路徑
$downloadFolder = "nupkgs"              # 暫存下載套件資料夾
$jfrogSource = "http://10.75.3.222:9082/artifactory/api/nuget/frogjump-nuget-local"
$jfrogApiKeyOrPassword = "1qaz@WSX"
$jfrogUsername = "kevin.huang"

# === 初始化 ===
if (-Not (Test-Path $downloadFolder)) {
    New-Item -ItemType Directory -Path $downloadFolder | Out-Null
}

# === 載入 packages.config ===
[xml]$xml = Get-Content $packagesConfigPath
$packages = $xml.packages.package

foreach ($pkg in $packages) {
    $id = $pkg.id
    $version = $pkg.version
    Write-Host "📦 處理套件 $id $version ..."

    $nupkgPath = "$downloadFolder\$id.$version.nupkg"

    # === 若尚未下載，從 NuGet.org 下載 ===
    if (-Not (Test-Path $nupkgPath)) {
        Write-Host "⬇️  下載中..."
        nuget install $id -Version $version -OutputDirectory $downloadFolder -Source https://api.nuget.org/v3/index.json | Out-Null
        $downloadedFolder = Join-Path $downloadFolder $id.$version
        $downloadedNupkg = Join-Path $downloadedFolder "$id.$version.nupkg"
        if (Test-Path $downloadedNupkg) {
            Move-Item $downloadedNupkg $nupkgPath -Force
            Remove-Item $downloadedFolder -Recurse -Force
        } else {
            Write-Warning "❌ 套件 $id.$version 下載失敗"
            continue
        }
    }

    # === 上傳到 JFrog ===
    Write-Host "🚀 上傳中..."
    $pushResult = nuget push $nupkgPath -Source $jfrogSource -ApiKey $jfrogApiKeyOrPassword -NonInteractive 2>&1

    if ($pushResult -match "Response status code does not indicate success") {
        Write-Warning "⚠️ 上傳失敗: $pushResult"
    } else {
        Write-Host "✅ 已上傳：$id.$version"
    }
}
