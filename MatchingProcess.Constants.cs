/******************************************************************************
* Copyright (C) 2010-2016 GlobalTranz - All Rights Reserved. 
*
* Proprietary and confidential. Unauthorized copying of this file, via any
* medium is strictly prohibited without the explicit permission of GlobalTranz. 
******************************************************************************/

namespace GlobalTranz.MatchingProcess.Service
{
    /// <summary>
    /// Class for constants.
    /// </summary>
    /// <createDetail>
    /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
    /// </createDetail>
    public partial class MatchingProcess
    {
        /// <summary>
        /// Constants structure.
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
        /// </createDetail>
        public struct Constants
        {
            #region Application Constants

            public const string MatchingProcessServiceName = "GlobalTranzMatchingProcessService";
            public const string MatchingProcess = "MatchingProcess";
            public const string MatchingProcessServiceDisplayName = "GlobalTranz Matching Process Service";
            public const string MatchingProcessServiceDescription = "GlobalTranz Matching Process service for processing EDI";
            public const string DefaultLogFileName = "MatchingProcessLog";
            public const string SalesOrderLogFileName = "SalesOrderMatchingProcessLog";
            public const string VendorBillLogFileName = "VendorBillMatchingProcessLog";
            public const string EDI210LogFileName = "EDI210MatchingProcessLog";

            #endregion Application Constants

            #region Configuration Constants

            public const string ErrorLogFilePath = "ErrorLogFilePath";
            public const string IsLoggedToConsole = "IsLoggedToConsole";
            public const string MatchingProcessServiceUrl = "MatchingProcessServiceUrl";
            public const string MatchingProcessServicePort = "MatchingProcessServicePort";
            public const string PriorityThreadCount = "Priority1ThreadCount";

            public const string NETTCPMaxBufferPoolSize = "NETTCPMaxBufferPoolSize";
            public const string NETTCPMaxBufferSize = "NETTCPMaxBufferSize";
            public const string NETTCPMaxConnections = "NETTCPMaxConnections";
            public const string NETTCPMaxReceivedMessageSize = "NETTCPMaxReceivedMessageSize";
            public const string NETTCPPortSharingEnabled = "NETTCPPortSharingEnabled";
            public const string NETTCPTransactionFlow = "NETTCPTransactionFlow";
            public const string NETTCPListenBacklog = "NETTCPListenBacklog";

            public const string STMaxConcurrentCalls = "STMaxConcurrentCalls";
            public const string STMaxConcurrentSessions = "STMaxConcurrentSessions";
            public const string STMaxConcurrentInstances = "STMaxConcurrentInstances";

            #endregion Configuration Constants
        }
    }
}