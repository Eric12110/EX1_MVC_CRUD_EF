//------------------------------------------------------------------------------
// <auto-generated>
//     這個程式碼是由範本產生。
//
//     對這個檔案進行手動變更可能導致您的應用程式產生未預期的行為。
//     如果重新產生程式碼，將會覆寫對這個檔案的手動變更。
// </auto-generated>
//------------------------------------------------------------------------------

namespace EX1_MVC_CRUD_EF.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class spt_monitor
    {
        public System.DateTime lastrun { get; set; }
        public int cpu_busy { get; set; }
        public int io_busy { get; set; }
        public int idle { get; set; }
        public int pack_received { get; set; }
        public int pack_sent { get; set; }
        public int connections { get; set; }
        public int pack_errors { get; set; }
        public int total_read { get; set; }
        public int total_write { get; set; }
        public int total_errors { get; set; }
    }
}
