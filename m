Return-Path: <linux-acpi+bounces-2912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A05830ABD
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214B91F29D27
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA22230D;
	Wed, 17 Jan 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="haJ+EOCu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6822301;
	Wed, 17 Jan 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508101; cv=fail; b=PtAAGIPf2VwHkWEW/Ca6kWv6z9PZsIWJbu78RLWeMLYPAv7w0xXTM1qD6kPCg8ddi3J+mtAZJGmzCaSiqVGhQIjGo8irHxjkamzbynCyP2PhSM3D1/5jG92io1zjE1VR9EmYJHfz9mmIju19UXk5R1zu+WcYi5wBX29Q7VAxCB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508101; c=relaxed/simple;
	bh=H05ExKCJJnIvj/g1Pf6ygestVAIxyGj4a6cWdoYDi04=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=FUSx3Q1JCwopcr9W87DgXMnj7ImhWyntSYCILx7/uNS+bgruzQnbCWCBgrsJ8vtRr/SdsdQcTF46Bi1Q+vZm1SlaPTkaYmLZhjRgmtJGPJ+Z8fZpyJAgXJ8TYURupIupKF5Ymbv4JopH3gAj99RWljEwRwzAjgl9DuQEe/oamIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=haJ+EOCu; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG+jxAVPiG9cbhz/09JZ71kKDmTzXroKYUYybQunPOH3ud97t6EWaV5K4e1gId9dTudHhFGqLMiziClH/t3mMtS+RCsAeVkvUGJZYkd7mqA/sqfuu6ixl9ihvbJy1iighQadJgQ6iIIC8QJMdzH2BX5ODby0iFvQsit6bkiOG7vajkgsPFNY5wyrQ9oTftbVHTWLv7dFhkvueqhs9KZC8NwRwKA5TpEMsOb6XfWqIjouHsp2h5pWUtyEMLBrEZv613QvNzIvIwhUFPqZbQ2bojDGibauZgQZiTMwlvV0lzKXM/1A+dxzE9/HmlbW/o6Hwqn341CwB6ckaAb3T0dg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieDrAjMPWaSNYXYDLGga7IR/8H1GvbdMPnZGOP6eRes=;
 b=gOmJw1TxQpxWDPolA69EBg131sN0hG6dx0SeQ1+sreEm8ELYLu+LBbu9f9MqznyeGsbbt8q5TSWoZU+TedyCzXhkZOZsQ48F4GkQddcZur1flt4AqTvlqtwcpTw9nBJYlztp4r5ATjfxvkoZW6hVEBMT487YViPspCzDZDhLL9VbfSBOb+V9cThOdiuGvMXh70cgPhfQarSiMIvVoyITSIwK9fJTvls4N5fORe+uHq/GPEWElGsouX1IjjFg2ZyTm1lCF1hPF/0BDNgzLKOynqUITZYRbY6YX53ZcY+mBU0LQLrIAKqsuOz/H102x3rBlVBDv99E644t5HJjBt6cNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieDrAjMPWaSNYXYDLGga7IR/8H1GvbdMPnZGOP6eRes=;
 b=haJ+EOCuWpwMu5n5LfpCH+DlV6yXIZbNG8sGIU//8eA1jCSgJv6JKvq/Alxy3kzONFsHSZSLGpqu8xKhwRjfqYQwIc2CMGIKuvKgeawlmvBzuTjhzyzjzB/4QJQCCwMqfqx2c5VT+HgKSyfv9a4Nv7/YTAHUjqw05Jzxrxw9p/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 17 Jan
 2024 16:14:57 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 16:14:57 +0000
Message-ID: <4eea7fe5-9be7-4853-9c3a-bbe835f7397b@amd.com>
Date: Wed, 17 Jan 2024 10:14:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/5] EINJ: Migrate to a platform driver
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
 <20240115172007.309547-4-Benjamin.Cheatham@amd.com>
 <65a7159bbad4d_3b8e294f5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65a7159bbad4d_3b8e294f5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::35) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dadf85-3fc5-4811-b2d1-08dc177772a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7u5Dd8WUV2JpsVH/3j3pO30YCrsXmfX3Uw8onqW3LnavNTYw0GpcVJ7ITsWYK2yMLdI4c+RPhg7gqWfMylshaDJFOJM7/EW4+LnEQ4sFZSyJu7odDJQXTHKXc3sFKfp1eyK27DX4ydkURITAd2DxB+p6W4g0Kw2IXs16ERrwvXBbffK1d+HYi8gTAevNdPSlQwzM3ySUdmfVbOA24zDvDsm1NJfqLnW3q0wnxsfOUN+2aMw/noJ6vY5X5eFlCU0GcQBg0sI0z/h8Iu68UVZAEFs0H8BrU9ZM6rwDM9anI/yH0xMzb9mUix2O4a9akKwQ3lTOKDc9+jt7HN8/B8EhYjYC7VDkzGnhpTTj7gLysOF+Eh6LHIb/UJAfjXBA56v2ep0O67HcTwTDqrTaFLljMwRQKnrGgPNO7sloLZfIu3HE/xt22Kl0ZPYFcaM59vVH3F0hjR5uOE5jgD2d+serxV4vyHSZhsv5djWG2eOOiB/PgWN2zm11pJe9gvDwDykTFi8yoeYwnh6RWIASvncmH4fSbvbhUe1VRo4C+ElZi/MzHJDGP2jVJ2mS40B73NHH3u5r3N8e2edl0VHLoqQn0rSdUlDCENG6kp1by6YUc9H+deGAt5h6C+Va4e5RtmG0DRtLA/naY0Q79fpz9iMMCs9DqdofwHFcp1P4KxMjCXYpxWX13+6uxeXtI2zErzha
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(31686004)(83380400001)(478600001)(5660300002)(7416002)(4326008)(8936002)(66946007)(316002)(6506007)(6666004)(6486002)(66556008)(66476007)(8676002)(6512007)(26005)(2616005)(38100700002)(2906002)(53546011)(41300700001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnhVWkVXdkFpaWR2N1VBNSswNGg5UUlGMlNocUNqbTU0NnFpbDNOY2JTUXgw?=
 =?utf-8?B?ZjQ4UDZXejcrb2JLNi9YU1JaTlFDRlRwaGpFY0hhOEFwRGpQNHV6bG9qTVJl?=
 =?utf-8?B?eExxRGFJeDhUZ1hOMnRBQ2JrZUZCUSt5amx0RjNVdHlLdDVFMVgva3NNc1lr?=
 =?utf-8?B?VjcvTXIvb21PZDBQRERGY1NpRVd3MkxFZW1CRVhzVHFUTlp0Q3dlM0xJRkI3?=
 =?utf-8?B?UzAvb1JNWm1nL3pvd25uTjBWeDgxc054R2xIZ3RrRzg2bU5OSFU2TXNRSnVy?=
 =?utf-8?B?Qy96b2piVG9KNHJrLzRtVFdvUG5Ebk9qK0FkQk15dURRSGM1ekF0QU1sM1pC?=
 =?utf-8?B?R0dncFl2clpRZUZyMjZ6cHlqVUhsVXVZYUdiMHNHMDVNL3RTZENWVkc1eTBs?=
 =?utf-8?B?Y09IMGl3cVZEeXl3U1NmV1Y1bWNXWW5HajZUb3RMejJGcWtHS3pLdjhoTnhn?=
 =?utf-8?B?a2xGcTBEU0tTM1RGZTFKRkgxTW5kS1RiRlBnMEpmMGFKejlLTklCczVMdTRL?=
 =?utf-8?B?QTlDeTlPVmN3V24zd2dJVmZXVmdwUXdFR2tCTlNaRGE1T084eTF4U214enRQ?=
 =?utf-8?B?ZU43SlBibitsdkM5WTJ4UHdHTSsvZ1lxcFg3VkFlRDU1YTlIQmpRczZ1ODBC?=
 =?utf-8?B?ck40OWZyS2JYaFFVWmQvVDZNRDRIVDFiekJuT3Z1bERCS0VUNVlXQ3pVMGlJ?=
 =?utf-8?B?UWttUjR2dXlTTERYR3I4UDZYRmdDdzJNM0pPUWFkRGVpUGV1WHJQdEEyVVFi?=
 =?utf-8?B?MnNZWFZlbnk5ZEdUQVFLOUNiVmtUMFp3enhvVzdIWEl5RkZjSWFFNkxtZzJh?=
 =?utf-8?B?dTV4dVJXUzBXOVRXdkx5cUJMR1Z6SkxqTEtIcmozKzlPS0JsanE4c2Y5T01T?=
 =?utf-8?B?WkFETjhWTW50dDBkSnJ3WVhxNmdaSC9EZzhGd3V4L2xWVkx6RHUxb0hXRTll?=
 =?utf-8?B?QlZzcmI0UUZ4aWRvTGluNDRwWi9rb2pyeGRvZ0FuNkFDK3poa1RndkxJOWhK?=
 =?utf-8?B?RjlYRjhCWEpUUXVPU0JPZFdxOVdGWHhzRzNKcmlsMHFzYU41YTlzVjRnUXpG?=
 =?utf-8?B?WkZCODEyZCtoZGdkR3dhRTFvOVBtdUZtZ1JuQTJhcXBtVjFHWEs3YjdSaENt?=
 =?utf-8?B?b0VicUgzVTRZQmM2WVZrd0thSWlqQ3h3a1hId0tpNjdvVGk3eDk2bFg3VndO?=
 =?utf-8?B?M05WemhmK01rOG1VMHVreUhxSTVzZEV1Sy9PbWo5RXpscEs4OGZ1UHJ3NDVN?=
 =?utf-8?B?YjVsUGh2MXZXRndna09VWW0rZ0lMR2c4b0FxeXhERFczTjFzcW05dzZlSzds?=
 =?utf-8?B?YzhIWUhnTkZPaU85dllvaFFNMElMQ1puQmxMN3U5dnU1R0p6U1h5VnFrVWJ4?=
 =?utf-8?B?RjRKcUNjY3V5aC9pTEtLZm1Nd29vVmg4RVpDc3JIcDdGbW1ndklkYjBmcFFI?=
 =?utf-8?B?clpNeml0YlFDZWFxdlVtQVVhbnRYMExrMjVwZ09kdVdEWkJhQXlSWjNEaktE?=
 =?utf-8?B?OHJBMFFjQUp5Y3pFM1hvZ28wRnI0YmtBRzl2ZUNsMTlCaGhIWll3UWFxb3Np?=
 =?utf-8?B?cWQvSG1pZlhKQ1o1REpES2Q3TUlYbUxjeUJSTkV6TjE3SjczY0IzZUU2Sk9R?=
 =?utf-8?B?YnFTU2NnVVJPSjlDV3FDVFVURm9HbmIzeVdkWE1WWlZMQmVMNXF0VTZQOHpY?=
 =?utf-8?B?QUR3b3ZabEtFUHgyZVQ2YVpOUlJkNmEwODhQR0YzU290QkFOZ1U3M3F6RWxp?=
 =?utf-8?B?TlNWb0owRUpjTWo2K2NST1liVDJEUkIvMHhBeGRrVVhzTDhmNXRCbXR0SWpG?=
 =?utf-8?B?dlpndlJjR1hDSUtWV25zVnBJYW9YVUlYNkdZcVZHY3JOS0hZSEh2OWlUSmp5?=
 =?utf-8?B?NHdwdFN4WEhQOEtQYVBJaFhIbGxJcUN3T3c4d01PdlJHRG5oNzFUbzQ5NlJR?=
 =?utf-8?B?STdjR3NKVWtkejd1LzlNMzBNa3V2YTlHZ1lEVHBRckpIV1c1QXllL0p6WDJK?=
 =?utf-8?B?dmsycUZSZmdyNzNyWnZsL1l3dFU1NGpRdUJNV1hSQzdEYm93VGM4blZDeHlZ?=
 =?utf-8?B?dENVYmIxcnZSWWJ4cHI2OUZtUE14WmQwK3lOS09CTE8zTGVTckdvRjdobXJp?=
 =?utf-8?Q?kSR16SGKPqDms+EQNXdfkV9dO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dadf85-3fc5-4811-b2d1-08dc177772a7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:14:57.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2U1K5P21S4pybTfW0qflVL4JMhBzQ5V5rgARaQpvabj8QoDZQMrsnSYlU3AA/wGOG210dROlUmGcDYsc3bXxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512

Hi Dan, thanks for the quick response! Comments inline.

On 1/16/24 5:47 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Change the EINJ module to install a platform device/driver on module
>> init and move the module init() and exit() functions to driver probe and
>> remove. This change allows the EINJ module to load regardless of whether
>> setting up EINJ succeeds, which allows dependent modules to still load
>> (i.e. the CXL core).
>>
>> Since EINJ may no longer be initialized when the module loads, any
>> functions that are called from dependent/external modules should check
>> the einj_initialized variable before calling any EINJ functions.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/acpi/apei/einj.c | 43 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 41 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 013eb621dc92..10d51cd73fa4 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/nmi.h>
>>  #include <linux/delay.h>
>>  #include <linux/mm.h>
>> +#include <linux/platform_device.h>
>>  #include <asm/unaligned.h>
>>  
>>  #include "apei-internal.h"
>> @@ -136,6 +137,12 @@ static struct apei_exec_ins_type einj_ins_type[] = {
>>   */
>>  static DEFINE_MUTEX(einj_mutex);
>>  
>> +/*
>> + * Functions called from dependent modules should check this variable
>> + * before using any EINJ functionality.
>> + */
> 
> This reads slightly odd to me, is this clearer?
> 
> "Exported APIs use this flag to exit early if einj_probe() failed."
> 

That is clearer, I'll change it.

>> +static bool einj_initialized;
> 
> This can be marked __ro_after_init to make it clear that it is static
> for the lifetime of the module.
> 

Will do.

>> +
>>  static void *einj_param;
>>  
>>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>> @@ -684,7 +691,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>>  	return 0;
>>  }
>>  
>> -static int __init einj_init(void)
>> +static int einj_probe(struct platform_device *pdev)
> 
> This can remain __init since nothing will call this function port
> init().
> 
>>  {
>>  	int rc;
>>  	acpi_status status;
>> @@ -782,7 +789,7 @@ static int __init einj_init(void)
>>  	return rc;
>>  }
>>  
>> -static void __exit einj_exit(void)
>> +static void einj_remove(struct platform_device *pdev)
> 
> Similarly this can remain __exit.
>  
>>  {
>>  	struct apei_exec_context ctx;
>>  
>> @@ -801,6 +808,38 @@ static void __exit einj_exit(void)
>>  	acpi_put_table((struct acpi_table_header *)einj_tab);
>>  }
>>  
>> +static struct platform_device *einj_dev;
>> +struct platform_driver einj_driver = {
>> +	.remove_new = einj_remove,
>> +	.driver = {
>> +		.name = "einj",
> 
> Perhaps call this acpi-einj just to preserve the namespace in case a
> cross-platform generic "einj" comes along.
> 

Gotcha, I'll make that change.

>> +	},
>> +};
>> +
>> +static int __init einj_init(void)
>> +{
>> +	struct platform_device_info einj_dev_info = {
>> +		.name = "einj",
> 
> Ditt "acpi-einj"
> 
>> +		.id = -1,
>> +	};
>> +
>> +	einj_dev = platform_device_register_full(&einj_dev_info);
> 
> Just return early here if this failed.
> 

Will do.

>> +	einj_initialized = !platform_driver_probe(&einj_driver, einj_probe);
> 
> Nit, but since platform_driver_probe() does not return bool, I would
> prefer this to be more explicit:
> 
> 	err = platform_driver_probe();
> 	einj_initialized = err == 0;
> 

I agree. I was trying to not have to use an extra variable for only one line
but
	einj_initialized = platform_driver_probe() == 0;

went over the column limit :/.

> I think it is ok for the platform-device to stick around if einj_probe()
> failures as userspace can see that the module is loaded but driver-init
> failed.
> 

My reasoning for this was since this is really a dummy device I
didn't want to pollute the platform device in the case the driver failed, but I
see the reasoning here and agree with you.

> Similarly it's probably also ok to fail the module load if
> platform_device_register_full() fails since something deeper is wrong
> with the system if it is starting to fail something so basic.
> 

Alright, will do.

>> +	if (!(einj_initialized || IS_ERR_OR_NULL(einj_dev)))
>> +		platform_device_del(einj_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit einj_exit(void)
>> +{
>> +	if (einj_initialized) {
>> +		platform_driver_unregister(&einj_driver);
>> +		platform_device_del(einj_dev);
> 
> Per above, this device_del can move outside the conditional.

