Return-Path: <linux-acpi+bounces-3914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4178615E4
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79C81C2440D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C692823D7;
	Fri, 23 Feb 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cx0bOLLV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0E80615;
	Fri, 23 Feb 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702437; cv=fail; b=m2DadDZJWWmxrWZxLL9laS2Yb7XMx5ECUSNpk7NTJI+/RhiZr61W0z8wE4f72CbqEfcusv6Psl90LsjUPv+PBNVDYJXpQNz9PdQEvrsPO5xhty4APeq6ew0fmvJBedI0WudLqtUQKg+YbcZalFvWzQEhIXB8JsinS1mDInP98wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702437; c=relaxed/simple;
	bh=agueX4yqALFAyyR+Kb/eCSqmjv4ZWamw518KJTrnjew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T9XwmMtLTxDowd5qdcSX8cOvI2pRZSfn572TP8xYNFCp3CwmiY/mzzdgN9YHfVOxY+wDt4hBBcFqjnIFZMYL8zStmzpSKzkMbqPM+tTAxRdyj20l1DqX7brHUIsI+Kmq06prNFQd9OdZ5/89RkuPXA4bf2K+yO4B5Lg2WViok/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cx0bOLLV; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWOSdmu9JiA9fwZA42RBlhHH65IV35SXRkoCaCGC/PPHMLnmRS7wmUUQ/XYFGKi1uS/W+7SJLHkayczXAinprHwEj7tnfuiInMxzsl6uFsFZNlUJ078+FnFgREacF54pfVEu8HlNAM9n70Xi69PidOFWgNWAn6DsLptxX/PI/RzZRHb590M16oKiTWoIvr17pEZOx7K9HAJGzYlFLpj7NDJC4Nay2tiW1/DUVfl1G2U0v9f0m+4BU3K/x2DIGGwmpDFeAd6m/bo4zsNh3LjnNv+TghelXT8CXgGXuFT9seOBIKDNRgA0mMf/cGAenPSdQQcCIXVO8cUWZGOFCAhBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDIFIlhXPfZ2VhC13k/DHH66ZjKcC7aXVCahg0AJqDs=;
 b=dQdMznW1plpQuusDSFuTsnUMelwV7ur12pYoRG/8be03TISTy9gkMO6dU5sjhW+HpeouVmwjkA+mNHVqF/BmtrVM9wnTWaATdXeXRhsm0N7/4HuHiGae6wBTDgFChc7x8tT8xR43dBqaiYK+CHSwzYk9yhXasXls95e2niQ1mk5Dm9Mst/Qf43Vwqm5jiJvRmPN/XqeMqo7ssqFhqK4MGXhOTnXcMTR3O2hvre8LyLBs8jQ1WaB4xTl0iTzWs4vQ0S6G3sEjvd7K8raPrPUiHTRc+7M+bmg3zoIl7/0JVad3754IPWuyCa6NTtFUeOHXv/FiKc4QKrkTJookBLZ+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDIFIlhXPfZ2VhC13k/DHH66ZjKcC7aXVCahg0AJqDs=;
 b=Cx0bOLLVUKVsosURrBh2xUgABcN2D1r5TXaBQk2TzlEWNo+PcE27L0icIdOXTade11fFoNzGWU0PdpqjCJHwswSnqfLEAHjnjOK1IQMH3h660Yof7d+MXi1Zl97zz7xhKTn4QkIWZqBKW4+9xS8exbTE47Xk0+X1EkpaE5D6V8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 15:33:53 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 15:33:53 +0000
Message-ID: <f713ee4a-eaf7-44ed-8b60-bd09a3915b35@amd.com>
Date: Fri, 23 Feb 2024 09:33:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/4] EINJ: Add CXL error type support
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
 dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
 <20240220221146.399209-3-Benjamin.Cheatham@amd.com>
 <65d63647ecdb1_5e9bf294d6@dwillia2-xfh.jf.intel.com.notmuch>
 <5a650a49-8f80-4ade-8844-61f88172cecd@amd.com>
 <65d65ffdd40f_5c76294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f308f836-a41c-4de8-8522-7c086d89f167@amd.com>
 <aitsb65thx4oyojuuf7s4tett5sw7p4qih7hlqqzmahrkdgoqi@akiloc4olwrx>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <aitsb65thx4oyojuuf7s4tett5sw7p4qih7hlqqzmahrkdgoqi@akiloc4olwrx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::22) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: a72cbc11-ce7a-45fb-ff80-08dc3484d6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hX/y6sa1DvLlGtHy7UmaqLxvsB+YBBU5Vlhu06MPe15/Am0j2uAghzSB6B1Cj+Oj4JBuPhWylOhmzc8TEZgPT+3tNignlMC1+SDGTqYsApOR2TbbrU9rBTl4eJWCBkYeNab9bUXilO5R9KkFVThSfWe14LNibFqBa70hU9ej4ZCSaPKIu4t7GqIBoOpWgmpZpFE2qDcWmgX8O2zYl3vtIDSXCEw5G2TznQB8JiM52ij2dzV2f2oHURUIjaNeONTBoKrtJkkphS0FAoJMV7L/LiWaQAdjfG7Q/M+KI27YbtOfhXAMf3rlLtWS4ErDm+i60BH5RiQNc2mSpbhS9g2kJwVHIKMj4IZWPwhpX/VkV1hlraZcv0J9kWl5mh0oL7O7FTfT+N91cuvA4mwJx0khcC4Q/lufI1h/DLljozRmbNYdE//vyZSUvx3CSBs/ieO+jsuTJ5cHiI0f8avf/3p/a00SD35ud9JxAIFcTer07VEGZT1pEdftWD0y68YGw4YIxcYbM1oZenqHBLgptfqVeIlyMJCtlsTaELXJNhiqpTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk5PRXNJWENhSVVSVEdsY0hNZnhFNVhVWXZWcjFmZy9waS9TWmUyNE1JN3h4?=
 =?utf-8?B?ZmFxWUlhTy9hS0hYdHRzMTFlcTAvQlU1RmZHcWRGTlVTbUZkdXJiSTJDZ1gy?=
 =?utf-8?B?ZVMrNm12WnRYbDJEVTY0UjFTTUpJNGdzMWltOVJVM3htRmVDbmpSbTdsRDdx?=
 =?utf-8?B?YnF2cVMyYTA2KzJvVlMwNG1qQ1lhMlNRVHJ6clAvMHVEMFZISEZFZUF0WmtQ?=
 =?utf-8?B?cjY2OWNZOTVRK0dqY3d3d3BIRmhZZG4rdmdiTTBDNkNDYysyWitjemNqSHFa?=
 =?utf-8?B?a0dQZFYzdEdMOTZMbkFYdGJsODFEaTkyZitjd01LWTdkWkJnRUVwbHRscWhI?=
 =?utf-8?B?Qjd2cGlPOE54cWc3Y1JQam4rU2hMUERSS2hjRnhjNzg1N1hnenhzK0NNK2s1?=
 =?utf-8?B?UUp0Tmg1RmEvcExjaGpCcWFLa05HS2JsUG5lQmZGUi8rU2E4WEJjeERvbUx0?=
 =?utf-8?B?eGxqMWJMM3gyVkNsMlJyc3NzdnlyMW1Ca1p5ekUxRWNOZTRsOVVLNTFoc3k2?=
 =?utf-8?B?MndNdFV5Tnd4R0xxTnFpWXRkbFphc3FLdUM2dXZ3TlBsd05TMkJ0c0RGRlN4?=
 =?utf-8?B?UFFFY3pwVzB0dm5PeHMvVGlvQ1MwUzZDRjIzczRYSFM5dHptRGhleWhWMEcx?=
 =?utf-8?B?UU9FTkIyMWE1MjJBd1puc0tmUTQ4dzRIUEJ2VkhpaDJRNlQydm9TbUNsWGpz?=
 =?utf-8?B?QXVDeEE2OWJlMmhKSkpDQWM0MUwxMWdpYVBveW8xN1JYdEU3NDBRdmZvUzky?=
 =?utf-8?B?bzRFQlcxWDNTUmlsQ3V2VnZiUkVnekxvcnF5V2F4R2ZTWXVGSjUvVCsrWmFM?=
 =?utf-8?B?cWwyVHRNSjA2cXh6Z2w0TnFtNXJTL3lOTkFRbDJvc1lVckxEMGpEVlR0dlNU?=
 =?utf-8?B?amZ2M3k2TG1KUDZDUE1tc0pVdS9sSm9oc0pHRW94T215Yk1yL3d6UDB0VTlC?=
 =?utf-8?B?a2VzL1lKSHU0Q0VETVV5QkxGdlVqYm5XWFRJc1l3YkdiZkdZaldiaEhscFpj?=
 =?utf-8?B?eXE4QUFTVmJoc0QxYlZaOHNrRWRKdTQ5djREWXI3QlBqTkJhQVQ2QnBVMEcv?=
 =?utf-8?B?eEJSNXRuQlhTN2tBcm90Y1pDcGFaWVgwenIvZTg2cGdhb0szaFY4UWxieDEz?=
 =?utf-8?B?Q25sYk1wb2ZoMUk3TzdjSStXa0tETHJGZHpPcHkwTkRUTlV1TUJLRUlpdlZr?=
 =?utf-8?B?NGx2QkRMU2RJdGx5N3hYcUVoS01jTzYvUm5uM0srd2xXRHk3NGpZdk9WL25S?=
 =?utf-8?B?bTNVdWNTcjBuOWozZUFEWndBL1lMQzA1bVhUR29uU3JnMEtveDZ6VE9XMnYv?=
 =?utf-8?B?anJUUS9VbUlUTXhielVpUS9DeS9IVDIxVk56MEp6SVNIZUN6NTNYdjJVQnNI?=
 =?utf-8?B?eEF2RlFRZjNQRk9FdzBndCtNSE1EeVRLdU9vZU5Tbzg5SzgvOHZmVEM0ZzVJ?=
 =?utf-8?B?OVp1QVVVL25kTWppUGR0a1JmWmtnenhXMXl3K0Q0WDVGbi83bTMxTXJ5Um13?=
 =?utf-8?B?d1NJUitPaEtIb0VZMW5pTUxzVGJrRVc5YmU0MFNRSlhHY0xZWnZhQ053OFY3?=
 =?utf-8?B?TFNIaTlsSkZoNUNPRDc0Yi9qOHVSNUkyeFJRUSsxRXRYNUR4TU5kRU9yYy9v?=
 =?utf-8?B?SlY4NEJVaUF3V2FScksxRGtEQ2xOOXR2MEI1dno3eW9EWFFIREFRYkxVdjNk?=
 =?utf-8?B?eklrQzhSNldnVlJyVGhpN0hMUmVteFl3SWpSRm9IUklLNXA2MTZDRW9VUi9Z?=
 =?utf-8?B?MXRXTWpFcE90SWxwMVg1WHNLdVFNTzZXZE4xS2gxeVVUOGhDZFNYbjFEWWx4?=
 =?utf-8?B?RXhaaUFyOVI4VldqZEtlbmtlRHEvTllrK25pa0xIWGhVSzlvWlNaQm1NUzdF?=
 =?utf-8?B?QlBWamhKTGlPa2pWNEhpWjZ5VzZvWTM0dGtCVm9nN2ZubGRuL2N4Mm56TSts?=
 =?utf-8?B?OHBUY0VjUmxRQzUwcURQc2hacjZoNk5NTGNKeWNJTUtzSGQzNXF6Yks5dFJR?=
 =?utf-8?B?ZERVWjJES1FhVFpuekFRcXdaREJMU3VCYnpENVY3VWZhTmM4aW50OCtpSnN0?=
 =?utf-8?B?M3YyODVNSmpIK3JWdmFlWDBlODVhaXErYk5wZ1pRZkxXRGk3RVdxNXhocHJJ?=
 =?utf-8?Q?EsghGoeXLzpXc2fMTdzNghSAQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72cbc11-ce7a-45fb-ff80-08dc3484d6cf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:33:52.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzZiYJKYusATXlErBLwzTBoB2da26qv9HRPjtRZVS4PBiq8fz5jKWAE1lD524MzrqutSTsDffdZ94K4MTuTKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122



On 2/22/24 7:13 PM, Davidlohr Bueso wrote:
> On Wed, 21 Feb 2024, Ben Cheatham wrote:
> 
>> So the way the EINJ module currently works (at least as I understand it)
>> is that any address supplied for memory errors is checked to make sure it's
>> a "normal" memory address. Looking at the comment above the memory checks:
>>
>>     /*
>>      * Disallow crazy address masks that give BIOS leeway to pick
>>      * injection address almost anywhere. Insist on page or
>>      * better granularity and that target address is normal RAM or
>>      * NVDIMM.
>>      */
>>
>> it seems that's the case. What this means is that we can't supply the
>> RCRB of a CXL 1.0/1.1 port because it's an MMIO address and we have to disable
>> the checks to inject a CXL 1.0/1.1 error.
> 
> Maybe worth a comment here as to why the error checking is skipped for cxl?
> 
> +    } else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> +        goto inject;
> 

I think that's a good idea, I'll go ahead and add one in.

Thanks,
Ben

> Thanks,
> Davidlohr

