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
    using System.ServiceModel;

    #endregion Namespaces

    /// <summary>
    /// Interface for matching process contracts.
    /// </summary>
    /// <createDetail>
    /// <id>US4444</id> <by>Manoj Bhuyan</by> <date>20-08-2013</date>
    /// </createDetail>
    [ServiceContract]
    public interface IMatchingProcess
    {
        /// <summary>
        /// Calls the sales order matching service.
        /// </summary>
        /// <param name="venderBillId">The vender bill id.</param>
        /// <param name="salesOrderId">The sales order id.</param>
        /// <param name="forceAttach">The force attach.</param>
        [OperationContract]
        [FaultContract(typeof(Contract))]
        void SaleOrderMatchingService(long venderBillId, long salesOrderId, Int16 forceAttach);

        /// <summary>
        /// Calls the Vendor Bill matching service.
        /// </summary>
        /// <param name="salesOrderId">The sales order id.</param>
        [OperationContract]
        [FaultContract(typeof(Contract))]
        void VendorBillMatchingService(long salesOrderId);

        /// <summary>
        /// Calls the EDI210 matching process.
        /// </summary>
        [OperationContract]
        [FaultContract(typeof(Contract))]
        void EDI210MatchingProcess();
    }
}