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
    using System.Diagnostics;
    using System.Linq;
    using System.Net.Security;
    using System.ServiceModel;
    using System.ServiceModel.Description;
    using System.Threading;

    #endregion Namespaces

    /// <summary>
    /// The class for matching process service implementation.
    /// </summary>
    /// <createDetail>
    /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
    /// </createDetail>
    public partial class MatchingProcess
    {
        #region Private Members

        private ServiceHost matchingProcessServiceHost = null;
        private string matchingProcessServiceUrl = string.Empty;
        private string matchingProcessServiceUrlMeta = string.Empty;
        private Logger.FileLogger logger;

        #endregion Private Members

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="MatchingProcess"/> class.
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
        /// </createDetail>
        public MatchingProcess()
        {
            this.logger = new Logger.FileLogger() { FileNameWithDateTime = MatchingProcess.Constants.DefaultLogFileName, FilePath = (string.IsNullOrEmpty(ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]) ? string.Empty : ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]), LogToConsole = Convert.ToBoolean(ConfigurationManager.AppSettings[MatchingProcess.Constants.IsLoggedToConsole]) };
        }

        #endregion Constructor

        #region Public Methods

        /// <summary>
        /// Called when [start service].
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
        /// </createDetail>
        public void OnStartService()
        {
            this.logger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            try
            {
                Thread matchingProcessStartThread = new Thread(new ThreadStart(this.MatchingProcessWCFServiceActivator));
                matchingProcessStartThread.Start();

                this.logger.LogMessage(message: "Matching process WCF service started successfully", logType: Logger.Logger.LogType.Information, logDate: true);
            }
            catch (Exception exception)
            {
                this.logger.LogException(exception: exception);
                EventLog.WriteEntry("Error on starting the mtaching process windows service.", exception.Message, EventLogEntryType.Error);
            }

            this.logger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        /// <summary>
        /// Called when [stop service].
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
        /// </createDetail>
        public void OnStopService()
        {
            this.logger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            try
            {
                this.matchingProcessServiceHost.Close();
                this.logger.LogMessage(message: "Matching process WCF service stopped successfully", logType: Logger.Logger.LogType.Information, logDate: true);
            }
            catch (Exception exception)
            {
                this.logger.LogException(exception: exception);
            }

            this.logger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        #endregion Public Methods

        #region Private Method

        /// <summary>
        /// Matching process WCF service activator that hosts its implementation.
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
        /// </createDetail>
        private void MatchingProcessWCFServiceActivator()
        {
            this.logger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            try
            {
                string serviceUrl = System.Configuration.ConfigurationManager.AppSettings[Constants.MatchingProcessServiceUrl].ToString();
                string servicePort = ConfigurationManager.AppSettings[Constants.MatchingProcessServicePort].ToString();

                this.matchingProcessServiceUrl = "net.tcp://" + serviceUrl.ToString() + ":" + servicePort + "/" + Constants.MatchingProcess;
                this.logger.LogMessage(message: string.Format("Matching process service URL: {0}", this.matchingProcessServiceUrl), logDate: true);

                this.matchingProcessServiceHost = new ServiceHost(typeof(MatchingProcess), new Uri[0]);
                this.logger.LogMessage(message: "Initialized Matching process service host", logDate: true);

                NetTcpBinding netTcpBinding = new NetTcpBinding
                {
                    MaxBufferPoolSize = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.NETTCPMaxBufferPoolSize) ? Convert.ToInt64(ConfigurationManager.AppSettings[Constants.NETTCPMaxBufferPoolSize]) : Int32.MaxValue,
                    MaxBufferSize = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.NETTCPMaxBufferSize) ? Convert.ToInt32(ConfigurationManager.AppSettings[Constants.NETTCPMaxBufferSize]) : Int32.MaxValue,
                    MaxConnections = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.NETTCPMaxConnections) ? Convert.ToInt32(ConfigurationManager.AppSettings[Constants.NETTCPMaxConnections]) : Int32.MaxValue,
                    MaxReceivedMessageSize = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.NETTCPMaxReceivedMessageSize) ? Convert.ToInt32(ConfigurationManager.AppSettings[Constants.NETTCPMaxReceivedMessageSize]) : Int32.MaxValue,
                    PortSharingEnabled = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.NETTCPPortSharingEnabled) ? Convert.ToBoolean(ConfigurationManager.AppSettings[Constants.NETTCPPortSharingEnabled]) : false,
                    TransactionFlow = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.NETTCPTransactionFlow) ? Convert.ToBoolean(ConfigurationManager.AppSettings[Constants.NETTCPTransactionFlow]) : false,
                    ListenBacklog = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.NETTCPListenBacklog) ? Convert.ToInt32(ConfigurationManager.AppSettings[Constants.NETTCPListenBacklog]) : Int32.MaxValue
                };

                netTcpBinding.Security.Transport.ProtectionLevel = ProtectionLevel.None;
                netTcpBinding.Security.Transport.ClientCredentialType = TcpClientCredentialType.None;
                netTcpBinding.Security.Mode = SecurityMode.None;


                this.logger.LogMessage(message: string.Format("Matching process NetTcpBinding details. MaxBufferPoolSize: {0}; MaxBufferSize: {1}; MaxConnections: {2}; MaxReceivedMessageSize: {3}; PortSharingEnabled: {4}; TransactionFlow: {5}; ListenBacklog: {6}", netTcpBinding.MaxBufferPoolSize, netTcpBinding.MaxBufferSize, netTcpBinding.MaxConnections, netTcpBinding.MaxReceivedMessageSize, netTcpBinding.PortSharingEnabled, netTcpBinding.TransactionFlow, netTcpBinding.ListenBacklog), logDate: true);

                this.matchingProcessServiceHost.AddServiceEndpoint(typeof(IMatchingProcess), netTcpBinding, this.matchingProcessServiceUrl);
                this.logger.LogMessage(message: "Added Matching process service endpoint", logDate: true);

                if (this.matchingProcessServiceHost.Description.Behaviors.Find<ServiceMetadataBehavior>() == null)
                {
                    ServiceMetadataBehavior serviceMetadataBehavior = new ServiceMetadataBehavior
                    {
                        HttpGetUrl = new Uri("http://" + serviceUrl.ToString() + ":" + Convert.ToString(Convert.ToInt32(servicePort) + 1) + "/" + Constants.MatchingProcess),
                        HttpGetEnabled = true
                    };

                    this.matchingProcessServiceHost.Description.Behaviors.Add(serviceMetadataBehavior);
                    this.matchingProcessServiceUrlMeta = serviceMetadataBehavior.HttpGetUrl.ToString();
                }
                this.logger.LogMessage(message: "Added Matching process service metadata behaviour", logDate: true);

                ServiceThrottlingBehavior serviceThrottlingBehavior = matchingProcessServiceHost.Description.Behaviors.Find<ServiceThrottlingBehavior>();

                if (serviceThrottlingBehavior == null)
                {
                    serviceThrottlingBehavior = new ServiceThrottlingBehavior();

                    serviceThrottlingBehavior.MaxConcurrentCalls = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.STMaxConcurrentCalls) ? Convert.ToInt32(ConfigurationManager.AppSettings[Constants.STMaxConcurrentCalls]) : 500;
                    serviceThrottlingBehavior.MaxConcurrentSessions = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.STMaxConcurrentSessions) ? Convert.ToInt32(ConfigurationManager.AppSettings[Constants.STMaxConcurrentSessions]) : 200;
                    serviceThrottlingBehavior.MaxConcurrentInstances = ConfigurationManager.AppSettings.AllKeys.Contains(Constants.STMaxConcurrentInstances) ? Convert.ToInt32(ConfigurationManager.AppSettings[Constants.STMaxConcurrentInstances]) : 100;
                    matchingProcessServiceHost.Description.Behaviors.Add(serviceThrottlingBehavior);
                }
                this.logger.LogMessage(message: "Added Matching process service throttling behaviour", logDate: true);

                this.matchingProcessServiceHost.Open();
                this.logger.LogMessage(message: "Matching process service host opened", logDate: true);
            }
            catch (Exception exception)
            {
                this.logger.LogException(exception: exception);
            }

            this.logger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        #endregion Private Method
    }
}