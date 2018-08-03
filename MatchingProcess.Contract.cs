/******************************************************************************
* Copyright (C) 2010-2016 GlobalTranz - All Rights Reserved. 
*
* Proprietary and confidential. Unauthorized copying of this file, via any
* medium is strictly prohibited without the explicit permission of GlobalTranz. 
******************************************************************************/

using System;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

/// <summary>
/// Data Contract for Matching Process Service
/// </summary>
/// <createDetail>
/// <id>US4444</id> <by>Manoj Bhuyan</by> <date>20-08-2013</date>
/// </createDetail>
[DataContract]
public class Contract
{
    [DataMember]
    public string ErrorSource { get; set; }

    [DataMember]
    public string ErrorDetail { get; set; }
}
