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
    using System.Diagnostics;
    using System.ServiceProcess;
    using System.Windows.Forms;

    #endregion Namespaces

    /// <summary>
    /// The class containing the main method.
    /// </summary>
    /// <createDetail>
    /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
    /// </createDetail>
    internal static class Program
    {
        #region Private Methods

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        /// <createDetail>
        /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
        /// </createDetail>
        private static void Main()
        {
            AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(CurrentDomain_UnhandledException);
            Application.ThreadException += new System.Threading.ThreadExceptionEventHandler(Application_ThreadException);
            Application.SetUnhandledExceptionMode(UnhandledExceptionMode.CatchException);

            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[]
			{
				new MatchingProcessService()
			};
            ServiceBase.Run(ServicesToRun);
        }

        /// <summary>
        /// Handles the ThreadException event of the Application control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Threading.ThreadExceptionEventArgs"/> instance containing the event data.</param>
        private static void Application_ThreadException(object sender, System.Threading.ThreadExceptionEventArgs e)
        {
            EventLog.WriteEntry("Windows Matching Process Service Thread Exception Occured.", string.Concat(e.Exception, "\n ", e.Exception.StackTrace), EventLogEntryType.Error);
        }

        /// <summary>
        /// Handles the UnhandledException event of the CurrentDomain control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="UnhandledExceptionEventArgs"/> instance containing the event data.</param>
        private static void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            Exception ex = (Exception)e.ExceptionObject;
            EventLog.WriteEntry("Windows Matching Process Service Unhandled Exception Occured.", string.Concat(ex.Message, "\n ", ex.StackTrace), EventLogEntryType.Error);
        }

        #endregion Private Methods
    }
}