Return-Path: <linux-acpi+bounces-2566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACD81A12B
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 15:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07574285E26
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4F3B1B9;
	Wed, 20 Dec 2023 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="34mrCmWV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D093A29A;
	Wed, 20 Dec 2023 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itcJO5m3PH5nODRx6xZyvnL1VZJ7KEDgNrwMIEjqQ7LzkrbZO9x5GevYYtOR08Uhnf1PIBXFDX1sKkhEk0ESR7XaSvngeV10grH5qYypxy26RawIZ9JnVVBuVtPBmQB1nV5oNaavkVMLbzjKl7M1048JUkzw4DZgkVrbm4/w9AEEt+f9u/RUgOay1iMaXkRILEWzBl7whyfdZP4kisHEnQyGlZ2S5orLMPunnB5tS6q/AsXXzVcjRTnFbjAhsdrQYfIkwpg/56Ln0B5Pjfd6kEv22Zhv9WKuPAP8GKWx+jU611AdVeeajzXOa50eslaXy8wT3WBGXSmW74YEu1ggBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRfhl6u/jEHlMfV0viaySC+uMEFAdPusYowGdYCSN50=;
 b=GVCISasSFY3Y2bhqRvIslUxUuThFhfqoL/bIVTn4k1CkLwIlW8rwJJBiTU6ebHohS/tc1rIDuiEUjIZvAgidEX2PmNzvZRi7Rjy9lzxfp9AjQtn59u3xbGaBc/o9bEQkq2TEvuXbMmw3dRFugG/y6d+IOP7D55T4YEF3I5fsDAuKLz24rafVzcVfNlRcSk8zn/YqzCn9LW9lIAmFHQ4k/H6yOO73qz4ngmkQixc7LnJOghvXh48sc4GaUKdBf/BCVpWikvgzXGmhHGFxL7/FOWuaoi1Bjrf0JGHZ78wwYLsYrlhb1yuHAWRWh180qUjlSNZUzT23qvpRH5pL6fN9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRfhl6u/jEHlMfV0viaySC+uMEFAdPusYowGdYCSN50=;
 b=34mrCmWVTakzEJLkkf8VhfHCiHcKo+AtB1IdXIhTERyNlBoR8qWs0d1qFOEKQWUDe8BLs/N6cEC+ekqdH3+ubz2OPSAM3TJJbY8QXOasHDKIFar/5os01vZgydXdN1TPwiBlurEaDzm8oiSXVPtBCbfHeNtXQxFFhUS/ZBLzwbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3270.namprd12.prod.outlook.com (2603:10b6:a03:137::31)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:33:54 +0000
Received: from BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::fd8d:fd5d:e44:c61a]) by BYAPR12MB3270.namprd12.prod.outlook.com
 ([fe80::fd8d:fd5d:e44:c61a%3]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:33:53 +0000
Message-ID: <e67167c2-bb7f-418d-a94c-518d7965e319@amd.com>
Date: Wed, 20 Dec 2023 08:33:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] ACPI, APEI, EINJ: Add wrapper __init function
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, rafael@kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
 <20231213223702.543419-3-Benjamin.Cheatham@amd.com>
 <6580dcd03b49c_7154929487@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231219153955.0000473d@Huawei.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20231219153955.0000473d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::9) To BYAPR12MB3270.namprd12.prod.outlook.com
 (2603:10b6:a03:137::31)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3270:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 348b5920-86be-4bf3-dfe1-08dc0168b0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M7LCUM4dIPxDEKcdmKO8LqeDJ+eHKPAJTdxXQsjmqJsfNugLVh3FujDRzi1slSGaQzkS8FGLV+CXOwTKbFA1T+Oa0xJW2HL661YLPxDG+uACVqneXH05XetnIGVD/N/gHnfJ9IUVEPChur3UKKwTBpIjkq49ej2FIDu9arXBUskvCLR+40e2Rqn8o+oLcWZYl5o4OV5dvV2u4p4icSRk4INst45dpxeorYw795t1PpXN+5r821KwmQETuQWvgNZfMerJq053HLdq0pEC86C8tFEj6/YLQFti2FNqc1R2M8RFathnbvugW78WajLyYfNxSRwL/W7QZ9CkJ1vX7WCguTGqEqXEmGaGPqc5PhUQ1v3UIp8XCYdZ2Ghj9peltKBVMyXac5aEbiuIV63zEpD2k5PI3k4LfQrjgA+2w3XNR5wwxYxpx1aqtiuAa9T3VrHdv1+5qEod0ElZ9+azwjnEsbvMC+oD8K41iMMe51tYge6crUE7qO+JJG8Blp/+9eksOgfgtWkLdl0C0jogG2d5RHl5to420UgMFlBGAnXZmM054VeDn6GcuzGByMci3GzhctmalezIU390fD3m5Pyev3A8aniDDE9wYgGw8RsOTvUUvOUYPrnzIVIKAN1MiumLaZRQJY8x3z4L5b86pjYoTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3270.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(110136005)(66946007)(66556008)(66476007)(316002)(38100700002)(6666004)(41300700001)(31696002)(86362001)(53546011)(6512007)(36756003)(6506007)(5660300002)(26005)(4326008)(7416002)(8936002)(2616005)(8676002)(2906002)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhUQk81Ni8rRGMyQWtOK3dmZklLUzNaeTg1ZGNxQ1p5Z2tWMHc5UmkxcWdm?=
 =?utf-8?B?S2Rtc0hKMHpBdmtxREFDM1FwamJCcFZNbGg0azdoaCtKUjF0WTVTS0I4WWZ3?=
 =?utf-8?B?b3BmT2NHTll0cGpiQytqQzRzRmJzYzY4QTFBVUZBOVdyekMwNE9Eamo3RDIy?=
 =?utf-8?B?NkY2cjZRNy80S3duVG5JRW1nL2pMMGZGY2RzaHFQcVkxdEZwaVR3OTFndjAy?=
 =?utf-8?B?OHlqY1lmQTJ6THZJV1N6RjhFWjVjOGQzNFlTQWd5bUFZRnR3MU1YZ1FncXAz?=
 =?utf-8?B?UklRVlNDNE9tRU93b3FqNzdubVNxdkh0dzFsMk5oYWUzN1Z0VnF4Y3lvcXBt?=
 =?utf-8?B?eXVvOU85bDZyaDZtM3NYNUVhaXNMNUN5SDl0UUFzK3JEQ0hYODFXRXhDOHcv?=
 =?utf-8?B?YSs5YzY2b0JuRXgxZDdvQ0VESlJaL1JBL3BjMkdXUHozUXFWYnFmQlRFSlcy?=
 =?utf-8?B?MkdMcmhMSGo5M3BMUkhXMnFkNHNMRU4wOGY1eEJrWnhJMmxtblczWTZCc0RJ?=
 =?utf-8?B?OVAwUnhxQTBPL29wVzlJcnlJS2loRjQvRVRFOXl2dUozWnJEa3k1ZjdleGdh?=
 =?utf-8?B?VFBzVTh5T21JcTJ0clFjd0hoVFFoTGltVUlIdWRwUE9tVzdpeTR1UXgrSGtM?=
 =?utf-8?B?elVWUElWTHlrSkRjQ1JmaVVOZ1BybkM1Q1RrYTZ5VCtTS1hIQTRCTVZSaHBm?=
 =?utf-8?B?ZStONy9sR1FQWUhBazBSWTMvWFdwUDAwc1Bnb05rUC8vN09hVWtEeE1TbWJO?=
 =?utf-8?B?WEYwVDFaQmFOc09BRUZwU3BsUEpKUGMzbnZBeVA2Z2NTcmVBakRndHlEcjNa?=
 =?utf-8?B?SlBza20rRmlZc29LN0g0MDY2OTc0S0c1bHV0YWNhdUlOeWhlRFg3clJublMz?=
 =?utf-8?B?QkxLSzRQMnVqS3ZURVZ3K21nUnRmU0x0eHhZMlIvbmVYcXNuVllnL0F0Qi9l?=
 =?utf-8?B?Rkp2QXBGMG5mTHBOOUpwMkZOSWtmSkhSMGtnOUlSK3Z2dDI3TkQ1c00yRE1l?=
 =?utf-8?B?S0pxRzhSWkZCd0lPcmVwZitINC9TbldtNjN2MzhFT2dFNFdFR0ZsMlRVRk90?=
 =?utf-8?B?T2dDVHhoQTRiYVplS2V0d3ptWm83TFJvenQ4VWdLRE1jNlVzK0NLWFJsRWpB?=
 =?utf-8?B?UnNmdVZXTEdVVjcyZXQxVkVqZlVQWCtkSUlHWVoxZ2I1Z1V4ekJSL2ZHM2Ur?=
 =?utf-8?B?VHpxTU82a2VIcGRxcyswcndYQ2prOHBPOEM5NW9DRUtFQ0xZb05iMVFmb1pk?=
 =?utf-8?B?ZS8xeUg5LzM3ZzRoeUpBN3BmeCtUQTgyZDVLcW5CVGpCSnNqRUx2UWNFUjAw?=
 =?utf-8?B?UFBKZDJhZzdaTVBROXFXS3hQenJkVjFXK0ZadVVFbG5GaDh4UlFScWlEM0ht?=
 =?utf-8?B?RUZXaVBCZXByOEVUbDY3Q0ZPSjlESjVFRHpnc0dUTDI5dHhMeks0aWFaVSsz?=
 =?utf-8?B?cEg3blhTQ0ZwbTQwS3FqMWFJdEJUcFp3VDBUUmRIb0JqSEJHTUpROTFWNW13?=
 =?utf-8?B?QkY2SHg2YzVuWGluanA4aVFmTWh1VXFndUlMSEV0TDRHQjFuMm5ibC8xV09s?=
 =?utf-8?B?S3QvQytNVUhrQzJ3N09hUTFBKys3WXMrRzRmby9DUFZUcGFBVktNVkVjNEZV?=
 =?utf-8?B?Ujl6ZCtteGlYVk5SZlhUT0xzTzlORXdmdnpoVjN3djlsUmZWOWlBWHAwOHV1?=
 =?utf-8?B?RCsyZVhkeEVRTXFYYzlaV05CVkJBR1Z0eGNlVzVXUG9ldzFoRllzNHdIdkk4?=
 =?utf-8?B?UXZlZmF6cktkTDlmelZIYzJNVW02bTYyMWNHZHlrRUh6c204TmpUbFA1Umxo?=
 =?utf-8?B?SGozSGx0SVA4d1J6dWZXdVAvMlVIY1pGOU5xcG1aY3pTdDZ6MHpYd1FLNExo?=
 =?utf-8?B?RmVoWWNObldXdFhBVTllTVVKVFFBV2ZXcDlZNXlZYzdINnR2YjJzdUhMREkx?=
 =?utf-8?B?ZXNaZmQ2bmVWM2QyMEZsWWkxNFE5cjA1aGUweTE1dmZNNCs1V00wNFN0cXBw?=
 =?utf-8?B?am1WNmtVOVU3UURZZDg5M0JNcTJNYzBkQk1ycTFZV3p5UkRwM1VVekxEWUJC?=
 =?utf-8?B?UVBFc252ZDZPc05IUURCYXpjb2I3ejhkcTZmeGM5UEpXb0wvMU9qWVh3ejlJ?=
 =?utf-8?Q?Q7lF3c7devONITGn1kgT7tnpU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348b5920-86be-4bf3-dfe1-08dc0168b0f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3270.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:33:53.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIIakC3IflmIHMfbad+SBsFShtc3a+VEEuEN3iZzc35450VDyVJvO8TjMZcZb0l0jQKIjYEjwwXpkrDx9iIUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015



On 12/19/23 9:39 AM, Jonathan Cameron wrote:
> On Mon, 18 Dec 2023 15:59:12 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> Ben Cheatham wrote:
>>> The CXL core module should be able to load regardless of whether the
>>> EINJ module initializes correctly. Instead of porting the EINJ module to
>>> a library module, add a wrapper __init function around einj_init() to  
>>
>> Small quibble with this wording... the larger EINJ module refactoring
>> would be separating module_init() from EINJ probe(). As is this simple
>> introduction of an einit_init() wrapper *is* refactoring this module to
>> be used as a module dependency.
>>
>>> pin the EINJ module even if it does not initialize correctly. This
>>> should be fine since the EINJ module is only ever unloaded manually.
>>>
>>> One note: since the CXL core will be calling into the EINJ module
>>> directly, even though it may not have initialized, all CXL helper
>>> functions *have* to check if the EINJ module is initialized before
>>> doing any work.  
>>
>> Another small quibble here, perhaps s/may not have initialized/may not
>> have successfully initialized/? Because initialization will have
>> definitely completed one way or the other, but callers need to abort if
>> it completed in error.
>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
>>
>> Did Jonathan really get in and review this new patch in the series
>> before me? If yes, apologies I missed it, if no I think it is best
>> practice to not carry forward series Reviewed-by's if new patches appear
>> in the series between revisions.
> 
> I'm not keen on the solution as it's esoteric and to me seems fragile.
> I've looked at discussion on v7 and can see why you ended up with this
> but I'd have preferred to see the 'violent' approach :)
> 
> I don't mind if there is consensus on this, but not reviewed by from
> me for this one.
> 

Gotcha, I'll go ahead on drop your reviewed-by.
>>
>>
>>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>  
>>
>> With above fixups, feel free to add:
>>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 

