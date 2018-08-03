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
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Text;
    using System.Threading;
    using System.Runtime.Serialization;
    using System.ServiceModel;
    using System.ServiceModel.Activation;
    using System.Configuration;
    using System.Workflow.Runtime;
    using System.Workflow.Runtime.Hosting;
    using GlobalTranz.EDI.Contracts;
    using workflow = GlobalTranz.EDI.Workflows;
    using GlobalTranz.Framework.Common.Models.Business.EDIAutomation;
    using GlobalTranz.Framework.Common.Enum;
    using GlobalTranz.EDI.BusinessLogic;
    using GlobalTranz.Common.BusinessLogic;

    #endregion Namespaces

    /// <summary>
    /// Class for implementation of service logic.
    /// </summary>
    /// <createDetail>
    /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
    /// </createDetail>
    public partial class MatchingProcess : IMatchingProcess
    {
        #region Static Members

        private static AutoResetEvent waitHandle = new AutoResetEvent(false);
        private static WorkflowRuntime workflowRuntime = new WorkflowRuntime();
        private static EDICarrierSettings carrierSettingsDataset;

        #endregion Static Members

        #region Public Method Implementation

        /// <summary>
        /// Starts the Sales Order Matching Process.
        /// </summary>
        /// <param name="venderBillId">Vendor Bill Id</param>
        /// <param name="forceAttach">Force Attach</param>
        /// <param name="salesOrderId">Optional Parameter SalesOrder Id</param>
        /// <createDetail>
        /// <id>US4444</id> <by>Manoj Bhuyan</by> <date>20-08-2013</date>
        /// </createDetail>
        public void SaleOrderMatchingService(long venderBillId, long salesOrderId, Int16 forceAttach)
        {
            Logger.FileLogger soLogger = new Logger.FileLogger() { FileNameWithDateTime = Constants.SalesOrderLogFileName + (new Random()).Next(99999999).ToString(), FilePath = (string.IsNullOrEmpty(ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]) ? string.Empty : ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]), LogToConsole = Convert.ToBoolean(ConfigurationManager.AppSettings[MatchingProcess.Constants.IsLoggedToConsole]) };

            soLogger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
            soLogger.LogMessage(message: string.Format("Input parameter details. Vendor Bill Id: {0}; Is Force Attached: {1}; Sales Order Id: {2}", venderBillId, forceAttach, salesOrderId), logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            try
            {
                using (WorkflowRuntime workflowRuntime = new WorkflowRuntime())
                {
                    Dictionary<string, object> parameters = new Dictionary<string, object>();

                    parameters.Add("VendorBillIdParam", venderBillId);
                    parameters.Add("ForceAttachParam", forceAttach);
                    parameters.Add("SalesOrderIdParam", salesOrderId);

                    AutoResetEvent waitHandle = new AutoResetEvent(false);

                    workflowRuntime.WorkflowCompleted += delegate(object sender, WorkflowCompletedEventArgs e)
                    {
                        soLogger.LogMessage(message: "Workflow completed", logType: Logger.Logger.LogType.Information, logDate: true);
                        waitHandle.Set();
                    };
                    workflowRuntime.WorkflowTerminated += delegate(object sender, WorkflowTerminatedEventArgs e)
                    {
                        soLogger.LogException(e.Exception);
                        waitHandle.Set();
                    };
                    workflowRuntime.Stopped += delegate(object sender, WorkflowRuntimeEventArgs e)
                    {
                        soLogger.LogMessage("Workflow stopped", logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowAborted += delegate(object sender, WorkflowEventArgs e)
                    {
                        soLogger.LogMessage(message: "Workflow is aborted", logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowCreated += delegate(object sender, WorkflowEventArgs e)
                    {
                        soLogger.LogMessage(message: string.Format(" Workflow : {0} is created", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowStarted += delegate(object sender, WorkflowEventArgs e)
                    {
                        soLogger.LogMessage(message: string.Format(" Workflow : {0} is started", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowSuspended += delegate(object sender, WorkflowSuspendedEventArgs e)
                    {
                        soLogger.LogMessage(message: string.Format(" Workflow : {0} is suspended", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowResumed += delegate(object sender, WorkflowEventArgs e)
                    {
                        soLogger.LogMessage(message: string.Format(" Workflow : {0} is resuming", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowIdled += delegate(object sender, WorkflowEventArgs e)
                    {
                        soLogger.LogMessage(message: string.Format(" Workflow : {0} is idle", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };

                    WorkflowInstance workflowInstance = workflowRuntime.CreateWorkflow(typeof(workflow.SalesOrderMatchingProcess), parameters);
                    soLogger.LogMessage(string.Format("Process start time: {0}", DateTime.Now.ToLongTimeString()), logType: Logger.Logger.LogType.Information, logDate: true);
                    workflowInstance.Start();

                    waitHandle.WaitOne();
                    soLogger.LogMessage(string.Format("Process end time: {0}", DateTime.Now.ToLongTimeString()), logType: Logger.Logger.LogType.Information, logDate: true);
                }
            }
            catch (Exception ex)
            {
                soLogger.LogException(exception: ex, logType: Logger.Logger.LogType.Error);

                Contract matchingProcessFault = new Contract();
                matchingProcessFault.ErrorSource = "Error in Sales Order ";
                matchingProcessFault.ErrorDetail = ex.ToString();
            }

            soLogger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        /// <summary>
        /// Starts the Vendor Bill Matching Process
        /// </summary>
        /// <param name="salesOrderId">Sales Order Id</param>
        /// <createDetail>
        /// <id>US4444</id> <by>Manoj Bhuyan</by> <date>20-08-2013</date>
        /// </createDetail>
        public void VendorBillMatchingService(long salesOrderId)
        {
            Logger.FileLogger vbLogger = new Logger.FileLogger() { FileNameWithDateTime = Constants.VendorBillLogFileName + (new Random()).Next(99999999).ToString(), FilePath = (string.IsNullOrEmpty(ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]) ? string.Empty : ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]), LogToConsole = Convert.ToBoolean(ConfigurationManager.AppSettings[MatchingProcess.Constants.IsLoggedToConsole]) };

            vbLogger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
            vbLogger.LogMessage(message: string.Format("Input parameter details. Sales Order Id: {0}", salesOrderId), logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            try
            {
                using (WorkflowRuntime workflowRuntime = new WorkflowRuntime())
                {
                    Dictionary<string, object> parameters = new Dictionary<string, object>();

                    parameters.Add("SalesOrderId", salesOrderId);
                    AutoResetEvent waitHandle = new AutoResetEvent(false);

                    workflowRuntime.WorkflowCompleted += delegate(object sender, WorkflowCompletedEventArgs e)
                    {
                        vbLogger.LogMessage(message: "Workflow completed", logType: Logger.Logger.LogType.Information, logDate: true);
                        waitHandle.Set();
                    };
                    workflowRuntime.WorkflowTerminated += delegate(object sender, WorkflowTerminatedEventArgs e)
                    {
                        vbLogger.LogException(e.Exception);
                        waitHandle.Set();
                    };
                    workflowRuntime.Stopped += delegate(object sender, WorkflowRuntimeEventArgs e)
                    {
                        vbLogger.LogMessage("Workflow stopped", logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowAborted += delegate(object sender, WorkflowEventArgs e)
                    {
                        vbLogger.LogMessage(message: "Workflow is aborted", logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowCreated += delegate(object sender, WorkflowEventArgs e)
                    {
                        vbLogger.LogMessage(message: string.Format(" Workflow : {0} is created", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowStarted += delegate(object sender, WorkflowEventArgs e)
                    {
                        vbLogger.LogMessage(message: string.Format(" Workflow : {0} is started", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowSuspended += delegate(object sender, WorkflowSuspendedEventArgs e)
                    {
                        vbLogger.LogMessage(message: string.Format(" Workflow : {0} is suspended", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowResumed += delegate(object sender, WorkflowEventArgs e)
                    {
                        vbLogger.LogMessage(message: string.Format(" Workflow : {0} is resuming", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowIdled += delegate(object sender, WorkflowEventArgs e)
                    {
                        vbLogger.LogMessage(message: string.Format(" Workflow : {0} is idle", e.WorkflowInstance.GetWorkflowDefinition().Name), logType: Logger.Logger.LogType.Information, logDate: true);
                    };

                    WorkflowInstance workflowInstance = workflowRuntime.CreateWorkflow(typeof(workflow.VendorBillMatchingProcess), parameters);
                    vbLogger.LogMessage(string.Format("Process start time: {0}", DateTime.Now.ToLongTimeString()), logType: Logger.Logger.LogType.Information, logDate: true);
                    workflowInstance.Start();

                    waitHandle.WaitOne();
                    vbLogger.LogMessage(string.Format("Process end time: {0}", DateTime.Now.ToLongTimeString()), logType: Logger.Logger.LogType.Information, logDate: true);
                }
            }
            catch (Exception ex)
            {
                vbLogger.LogException(exception: ex, logType: Logger.Logger.LogType.Error);

                Contract matchingProcessFault = new Contract();
                matchingProcessFault.ErrorSource = "Error in VendorBillMatchingService ";
                matchingProcessFault.ErrorDetail = ex.ToString();
            }

            vbLogger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        /// <summary>
        /// Starts the EDI210 Matching Process
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Manoj Bhuyan</by> <date>20-08-2013</date>
        /// </createDetail>
        public void EDI210MatchingProcess()
        {
            Logger.FileLogger ediLogger = new Logger.FileLogger() { FileNameWithDateTime = Constants.EDI210LogFileName + (new Random()).Next(99999999).ToString(), FilePath = (string.IsNullOrEmpty(ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]) ? string.Empty : ConfigurationManager.AppSettings[MatchingProcess.Constants.ErrorLogFilePath]), LogToConsole = Convert.ToBoolean(ConfigurationManager.AppSettings[MatchingProcess.Constants.IsLoggedToConsole]) };
            ediLogger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            int PriorityCount = 0;
            PriorityCount = Convert.ToInt32(ConfigurationManager.AppSettings[Constants.PriorityThreadCount].ToString());

            //Get basic carrier settings
            carrierSettingsDataset = RetriveCarrierSetting(PriorityCount, ediLogger);
            var priorityCarriers = (from carriers in carrierSettingsDataset.Tables[carrierSettingsDataset._EDICarrierSettings.ToString()].AsEnumerable()
                                    where carriers.Field<int>(carrierSettingsDataset._EDICarrierSettings.PriorityColumn) == 1
                                    select carriers.Field<int>(carrierSettingsDataset._EDICarrierSettings.CarrierIDColumn));

            //Convert result to array
            int[] carrierlist = priorityCarriers.ToArray<int>();
            int[] carrierlist1 = { 108 };

            this.StartEDI210MatchingProcess(carrierlist, PriorityCount, ediLogger);
            ediLogger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        #endregion Public Method Implementation

        #region Private Method Implementation

        /// <summary>
        /// Start EDI210 Matching Process Workflow
        /// </summary>
        /// <param name="carriers">Int Array of Priority Carriers</param>
        /// <param name="priority">Priority Thread Count</param>
        /// <param name="ediLogger">Logger Object</param>
        /// <createDetail>
        /// <id>US4444</id> <by>Manoj Bhuyan</by> <date>20-08-2013</date>
        /// </createDetail>
        private void StartEDI210MatchingProcess(int[] carriers, int priority, Logger.FileLogger ediLogger)
        {
            ediLogger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            try
            {
                using (WorkflowRuntime workflowRuntime = new WorkflowRuntime())
                {
                    workflowRuntime.WorkflowStarted += delegate(object sender, WorkflowEventArgs e)
                    {
                        ediLogger.LogMessage(message: " EDI210 Workflow  is started", logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowCompleted += delegate(object sender, WorkflowCompletedEventArgs e)
                    {
                        ediLogger.LogMessage(message: " EDI210 Workflow  is completed", logType: Logger.Logger.LogType.Information, logDate: true);
                    };

                    workflowRuntime.WorkflowIdled += delegate(object sender, WorkflowEventArgs e)
                    {
                        ediLogger.LogMessage(message: " EDI210 Workflow  is idle", logType: Logger.Logger.LogType.Information, logDate: true);
                    };
                    workflowRuntime.WorkflowTerminated += delegate(object sender, WorkflowTerminatedEventArgs e)
                    {
                        ediLogger.LogException(e.Exception);
                    };

                    AutoResetEvent waitHandle = new AutoResetEvent(false);
                    workflowRuntime.WorkflowCompleted += delegate(object sender, WorkflowCompletedEventArgs e) { waitHandle.Set(); };
                    workflowRuntime.WorkflowTerminated += delegate(object sender, WorkflowTerminatedEventArgs e)
                    {
                        ediLogger.LogException(e.Exception);
                        waitHandle.Set();
                    };

                    WorkflowInstance instance = workflowRuntime.CreateWorkflow(typeof(workflow.EDI210MatchingProcess));
                    instance.Start();
                    waitHandle.WaitOne();
                }
            }
            catch (Exception ex)
            {
                ediLogger.LogException(exception: ex);

                Contract matchingProcessFault = new Contract();
                matchingProcessFault.ErrorSource = "Error in EDI210MatchingService ";
                matchingProcessFault.ErrorDetail = ex.ToString();
            }

            ediLogger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);
        }

        /// <summary>
        /// This function used to retrieve the basic carrier settings
        /// </summary>
        /// <returns></returns>
        /// <createDetail>
        /// <id>US4444</id> <by>Manoj Bhuyan</by> <date>20-08-2013</date>
        /// </createDetail>
        private static EDICarrierSettings RetriveCarrierSetting(int priority, Logger.FileLogger ediLogger)
        {
            ediLogger.LogMessage(message: "Method Entry", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            EdiAutomationController controller = new EdiAutomationController();
            EDICarrierSettings ediCarrierSettings = controller.RetriveCarrierSettings(0, priority, Convert.ToInt32(EDITypes.EDI210));

            ediLogger.LogMessage(message: "Method Exit", logType: Logger.Logger.LogType.Information, logDate: true, logTraceDetails: true);

            return ediCarrierSettings;
        }

        #endregion Private Method Implementation
    }
}