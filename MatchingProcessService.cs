/******************************************************************************
* Copyright (C) 2010-2016 GlobalTranz - All Rights Reserved. 
*
* Proprietary and confidential. Unauthorized copying of this file, via any
* medium is strictly prohibited without the explicit permission of GlobalTranz. 
******************************************************************************/

namespace GlobalTranz.MatchingProcess.Service
{
    #region Namespaces

    using System;
    using System.Configuration;
    using System.ServiceProcess;

    #endregion Namespaces

    /// <summary>
    /// The service class for matching process.
    /// </summary>
    /// <createDetail>
    /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
    /// </createDetail>
    partial class MatchingProcessService : ServiceBase
    {
        #region Private Members

        private MatchingProcess matchingProcess;
        private Logger.FileLogger logger;

        #endregion Private Members

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="MatchingProcessService"/> class.
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
        /// </createDetail>
        public MatchingProcessService()
        {
            InitializeComponent();

            this.logger = new Logger.FileLogger() { FileNameWithDate = MatchingProcess.Constants.DefaultLogFileName, FilePath = (string.IsNullOrEmpty(ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]) ? string.Empty : ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]), LogToConsole = Convert.ToBoolean(ConfigurationManager.AppSettings[MatchingProcess.Constants.IsLoggedToConsole]) };

            matchingProcess = new MatchingProcess();
        }

        #endregion Constructor

        #region Protected Methods

        /// <summary>
        /// When implemented in a derived class, executes when a Start command is sent to the service by the Service Control Manager (SCM) or when the operating system starts (for a service that starts automatically). Specifies actions to take when the service starts.
        /// </summary>
        /// <param name="args">Data passed by the start command.</param>
        protected override void OnStart(string[] args)
        {
            this.logger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            this.matchingProcess.OnStartService();

            this.logger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        /// <summary>
        /// When implemented in a derived class, executes when a Stop command is sent to the service by the Service Control Manager (SCM). Specifies actions to take when a service stops running.
        /// </summary>
        protected override void OnStop()
        {
            this.logger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            this.matchingProcess.OnStopService();

            this.logger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        #endregion Protected Methods
    }
}