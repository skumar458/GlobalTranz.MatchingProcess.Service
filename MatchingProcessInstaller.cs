/******************************************************************************
* Copyright (C) 2010-2016 GlobalTranz - All Rights Reserved. 
*
* Proprietary and confidential. Unauthorized copying of this file, via any
* medium is strictly prohibited without the explicit permission of GlobalTranz. 
******************************************************************************/

namespace GlobalTranz.MatchingProcess.Service
{
    #region Namespaces

    using System.ComponentModel;

    #endregion Namespaces

    /// <summary>
    /// The installer class for matching process.
    /// </summary>
    /// <createDetail>
    /// <id>US4444</id> <by>Baljinder Dadyala</by> <date>20-08-2013</date>
    /// </createDetail>
    [RunInstaller(true)]
    public partial class MatchingProcessInstaller : System.Configuration.Install.Installer
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="MatchingProcessInstaller"/> class.
        /// </summary>
        public MatchingProcessInstaller()
        {
            InitializeComponent();
        }
    }
}