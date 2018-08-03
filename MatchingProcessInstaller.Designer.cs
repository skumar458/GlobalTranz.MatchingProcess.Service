namespace GlobalTranz.MatchingProcess.Service
{
    partial class MatchingProcessInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.MatchingProcessServiceProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.MatchingProcessServiceInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // MatchingProcessServiceProcessInstaller
            // 
            this.MatchingProcessServiceProcessInstaller.Account = System.ServiceProcess.ServiceAccount.LocalService;
            this.MatchingProcessServiceProcessInstaller.Password = null;
            this.MatchingProcessServiceProcessInstaller.Username = null;
            // 
            // MatchingProcessServiceInstaller
            // 
            this.MatchingProcessServiceInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // MatchingProcessInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.MatchingProcessServiceProcessInstaller,
            this.MatchingProcessServiceInstaller});
        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller MatchingProcessServiceProcessInstaller;
        private System.ServiceProcess.ServiceInstaller MatchingProcessServiceInstaller;
    }
}