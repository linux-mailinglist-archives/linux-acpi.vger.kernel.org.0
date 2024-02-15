Return-Path: <linux-acpi+bounces-3543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A58566CB
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195291F22242
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24303132C0C;
	Thu, 15 Feb 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fte5rN6t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045E132C0F;
	Thu, 15 Feb 2024 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009319; cv=fail; b=V6VE97ZIZDgOAdvlgTZvUHCsG2F3sa41qI4sNsIVQt0pEVaGjMQCH+m3EQk6RQxqWaikLOvIxTJ1Ebx60XLUAExn2Bxk0Hi9rNMAiFeoMUR4NhCFP3xb2UQBJxGZQnRpjjQfeoJg9xxKXkN3Z+jesmNYL7CrN+IWlvx8ObAA7d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009319; c=relaxed/simple;
	bh=z671sL9kUpmQDU3hOqDij79v+WjAETDv6YZ38jJlpAE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kfoXZVkpsXphAI5kSjt6NbDO55ZRhif4AW/qorxHCyCqFeCVJ72J0GiMKAZfHq4XXwof3Efi1ClTPlA8fEUn/bsUPV129SJvJCIc97w38uZWkbfEkXpwzro4uATCoiWDXkEKwXP1xYJyg+C/LjKC54H8tBJBuqS/NmHaJHSEzdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fte5rN6t; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apoGvhU9qsaf2NAryg+8ZRlLVujBtmQOkDTmTYDrSyhrmCDDpA/e7mZeKsKcuQxmWqBhryZsfUCjlHrltDD6xHfD8Mel8nxtVaXbcdRWBXDRHBsgDt63I1+02AlIgqG7PegqaBhQNiC5+R8m3B/+u/IDebEh3/m8C/rG/0mD75DLgDc3airelknS8nQCXVzq7Tc97TSe6jBmDo5NdwxmdJVNg7vKfocIzIFfMDGgVzBT5zI/uVeKkWzhAHOXb0kLMNetGE+KrhmSBo1UZ/i6i5UhqWX9htgPaexY6uPng/0KG4IrN0k37WT/Js3w+0hCdZnopisAu8fSD7yWwM5OCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgRsyEWpJgnTaUi9dG2d9JQLUcYo5p5o0+ZfUiUK58A=;
 b=gYH0s+UIydCWrRm/5IZCHUePiABARR+AA9akjQwEmnMdE6dduLwTDLMEtgrkX2cylMzl8h70SLdMUAzdTP7d27YXyTA4ad5Sdzqp/YxaNmlGOa0MgWhqOAiVUp2ihEViMk+zb3Ijsg6U9axMQAQB8KlhTYgOsep+tSBJvdRBOpLpidESoYZ333WJx00J3VxhD7vVWuscChp8Manx3GEdM20ybArJmdU1a9Oo0pftDnDLUgQfIsztYX0QtWWs5bSW4xAKCzsMSKliIMnPW37evyRDiP4FYgyewdu/6uh2gMA/s2lx0uo0s9GEOn2sFtsfXZpmuIjf/XQdq3zeskuPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgRsyEWpJgnTaUi9dG2d9JQLUcYo5p5o0+ZfUiUK58A=;
 b=fte5rN6tDFv5pbBJYSahzdO3Gll1mUpMnvRprLvNjkZzX+U1aYcA+1caKsESkFvZMMc7iPiLeBxJxMGMl0ubQ7syHE1oVHpnIxbLJzi5KjIadGM4VMFiaOnlVXlONgLdO+8riA8CbQK4AEy80aHyojUsrE1LVOEokzOLBrOMSgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 15:01:55 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 15:01:55 +0000
Message-ID: <7b00a4ec-7fdd-46cb-b5a1-c06780fa8bdb@amd.com>
Date: Thu, 15 Feb 2024 09:01:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Tony Luck <tony.luck@intel.com>
Cc: jonathan.cameron@huawei.com, rafael@kernel.org, james.morse@arm.com,
 bp@alien8.de, dave@stogolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <Zc1kwWupeN9WagFj@agluck-desk3>
 <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65cd7cac71377_5c76294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0055.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::12) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 333e7eeb-ddbf-464b-cedd-08dc2e370cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VI5ftIaJc/Zb5IGQqrP0BV1Ubd0FTVyzUaYO4EWycsO7jr13WuA2uEBJydEJ1sf34TASjTXJ3wC0D8o3Ru/ksenyV3rOk9DfBLZygwVYkLLX6mpQgApJM1PqXExrBq3ftNsBWyXUkKDNtb2f0u7Eqv4Iy49z1BlZkTI8/ApZxi5tlAGZwCO1XasBd9iFCBFNosEkLwS7Cvu+yKleltye7Z2f59oxJJjDW+eTWlfYZJhUHbb00m7NGaI22kiapb5j7CLMXBn9MJglJR8IBI/B1FK2epHnA1X7XzwSgoICxFz3cafIwGCPyZtsNBwjYRtNxC72AmKjQDyHMljaK5kwY02NYksV9GCf8KUJUIiVR0JQKYU02LCXAPtjN0g+6t32wGLWDocvpr2ldoQtV2+CUYbdCoz+CoZ9VYwtF5rFpGOhEeW1PvNZLJJBg5w2PcgoOO6IDqEa0gJwgiubS16v0+GoUleiq6SAwi0pZ3mZUGC0BT5dica5mI1bNz2LDIAhpESFe+oe413yrcu7obNab8mDgM7W2nLhhHTXuFLmO2YMq4/tknwMGjNL9pjPp0LK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8676002)(8936002)(4326008)(15650500001)(5660300002)(7416002)(2906002)(83380400001)(26005)(31696002)(36756003)(38100700002)(86362001)(53546011)(110136005)(66556008)(66476007)(316002)(2616005)(66946007)(6506007)(6666004)(6486002)(478600001)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWlja3RzRmFrRExOZXhZMFF3R1FRRmlNaVlQb3lVdjcwcDFWS1czSzRiZGpz?=
 =?utf-8?B?b0haWXVWbWpYdHBsdXpzSDg1cVpjeHhiMnp6bm1aTnN3YjA4UGI5M2JSRENX?=
 =?utf-8?B?Y1JlU3hSU1A3K2c4QXRHUFMrdVd4VjJCQnVxTVdHdDFwN0VVTEswbmpQR2VE?=
 =?utf-8?B?OHVqMTgxMVl5Rm5yM0YxWlNxa1dzaGl4RktVSjUxNmNad1FZSFQyN3FuUWFo?=
 =?utf-8?B?bUMzVTNuZzNiQXBsRGx4cFVnNG0xMUNSNWViNUxzM3RyajVNM3M4YlY3Z00r?=
 =?utf-8?B?UmNrVkdqamQ5UDJ1TFBvem5WaUxnYU9mRDM2ZXFiSVpmdys5b25tTlh1bGp0?=
 =?utf-8?B?TUswVndjSDU2T20rTjRtMWpoN29UWU9jTWpoeVF0SXdjYTBGTjlRdUtGL0lt?=
 =?utf-8?B?VHJIanNFcEpXOVlNTmppdnIxWHZSQWhQTHdGRmErZkxtYzhBOHVKNS9JQkZt?=
 =?utf-8?B?azZpQWhvLytZbmltUXNua3ZXODhzaWNmNVNxczB4WXVLeGlBMGRLN1Bmem85?=
 =?utf-8?B?SVNORGJRME9vZjJSNTlkUzcrMzBkekE5UlJwL2gvNWlsU2JyQWlJR0tTUnBT?=
 =?utf-8?B?UmZhNGRnWUhLWGt1OCsvMDZLZjVNZkhCa0oxN2REMmZqSmJ6dlFjVWpoZHFY?=
 =?utf-8?B?YVRFZnA3enpXdllIMTRtOXNZMk9hVHMwVUk2a3NJODRsQmI1M2ZPd2RUcUIy?=
 =?utf-8?B?dlg2RmFkT0ZXaVNnaWU0OEs3M2pWR3krY1lla0dOVWNYeHlHa0xGeU9XVVJ6?=
 =?utf-8?B?TEpsL0lDL1JwVTR4UjNpK1cwYkFLQ1VxOEhvMEhKVmtlcW1ObE9GcHIrQ1Fw?=
 =?utf-8?B?WnFDZUtZR3NwZDc3ZEJPZDNBU00zSS9iVjV4OU5EdXh2b3pmL2FHS1JNakhZ?=
 =?utf-8?B?Q2oxYmNtK2l2QWp3bjM5QmlPcnUyTmZUUDJxNzZ4SDFSL2pZUkxBQXJDY3F1?=
 =?utf-8?B?UWJpWXlWbEZaVlVJUjh1K04wM2xWeXQxSEVINlRyNVFnMHRpcUt3YkE0Z1dS?=
 =?utf-8?B?RkVXTkR2bzRiaG5CZ2Jaa1gwcWo2OXhKRjAyWXdKVmsyRkJLRjJMb3N3RGVx?=
 =?utf-8?B?Z2pBWTQ0UWtZWGxYd0ZXcW1Rc3BVQzg4U1RUTHBPQzJIZGRBeVFBNUZJRnBj?=
 =?utf-8?B?VElaVUQvZGFhV2VyYUo5OUxWMzJuVkk5eUdlVldnbG11OUhHaWZ1bnVOVUFO?=
 =?utf-8?B?NFc4a0VWRHpHb3o3UjE4elJxbS9XR2lrSU4yT044cXlPcWtqWTJxWEI5Qzgw?=
 =?utf-8?B?VWZrNytrWStGNlNYb0xvVUNPNzUxcFRrK2VGcHM2TWpOUkhCMGJvdEhhRUxS?=
 =?utf-8?B?d1lMY1NKU2xEdy82OStPMzVaY2R6cC9XUHMycGhWVjZObWllbGR6ZnJYZ3Bh?=
 =?utf-8?B?cVJteHd1c3ZqaXBCUGF0MnpGMVE3eTBtcmJPY29NaFB1NVJHQVh5V3JjVUNp?=
 =?utf-8?B?bkZhNWRvcGljZ1RpREM0N1JNaWlhazJCejMzdjQvNkY2SWhGYkxmdE9OZnhs?=
 =?utf-8?B?R1R2cksvUWdXWjFKZzNuOFRkbkw4cktjb3VmQm9rN0o2MXMvU2FUcnI5SXEv?=
 =?utf-8?B?Z0hEQnBmN25jNXFWUU01Yk9hR25WRWdjSWR5UjRwcVVTcTNrRWFuY0pDUW1S?=
 =?utf-8?B?RkRaVU1MTGxsY2NyNEpYS3BhMXF6RnZjbUZwYWgyTFZNaHZ3ZFBoSVU5ODlR?=
 =?utf-8?B?ZkpmYW1DWkZKK0xnRkFiRnJ0OUJVU2o5Wk5ySXdZMlVoT214UjFJZHJyQzVa?=
 =?utf-8?B?dG42d2x2STZkaXZuMVFWeU1XQUZtejNYRGpwYmV3aDZNM0RtSU5KcHBnT0V5?=
 =?utf-8?B?Mmx0dGp2VFhNelo2cjhvSGhyckFua0hzMWh4bERBRUVxeXowNEhyZWFKZVpD?=
 =?utf-8?B?elpaMW9JQlFKY203VnZqdnFNRTJ5elhib3E5Mm5YOGFBODdaN2NOZHNPV05C?=
 =?utf-8?B?M09XME1TUUxiN0Fza3JXeXdMVnZvdTlCQVRJdDlwRk92Mk9EcEd2N21VTk1U?=
 =?utf-8?B?WXVVZVhJeG5BTWNkS20wR29YQUFsb1poWnhxS1U0MEdhaEJLc0ZDZUUvZVVy?=
 =?utf-8?B?aFRFd2tUK0hMbCt1YVM5Q2dhWCtSK1IyZ1J6NnpZYmJGMFhydjllRVpGSm9z?=
 =?utf-8?Q?F93ibbDglEuYNrh+Ql2+BhevX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333e7eeb-ddbf-464b-cedd-08dc2e370cbd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 15:01:55.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbdQqOcvyJztIbhWTypoV3ztfAoG6FRhccsf2sQTQj9t/qmBFvsB/uEEaV74+j6m+ThJ2P0l1exsKU/Aorze6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414



On 2/14/24 8:53 PM, Dan Williams wrote:
> Tony Luck wrote:
>> On Wed, Feb 14, 2024 at 02:07:06PM -0600, Ben Cheatham wrote:
>>> v12 Changes:
>>> 	- Rebase onto v6.8-rc4
>>> 	- Squash Kconfig patch into patch 2/3 (Jonathan)
>>> 	- Change CONFIG_CXL_EINJ from "depends on ACPI_APEI_EINJ >= CXL_BUS"
>>> 	  to "depends on ACPI_APEI_EINJ = CXL_BUS"
>>> 	- Drop "ACPI, APEI" part of commit message title and use just EINJ
>>> 	instead (Dan)
>>> 	- Add protocol error types to "einj_types" documentation (Jonathan)
>>> 	- Change 0xffff... constants to use GENMASK()
>>> 	- Drop param* variables and use constants instead in cxl error
>>> 	  inject functions (Jonathan)
>>> 	- Add is_cxl_error_type() helper function in einj.c (Jonathan)
>>> 	- Remove a stray function declaration in einj-cxl.h (Jonathan)
>>> 	- Comment #else/#endifs with corresponding #if/#ifdef in
>>> 	einj-cxl.h (Jonathan)
>>>
>>> v11 Changes:
>>> 	- Drop patch 2/6 (Add CXL protocol error defines) and put the
>>> 	  defines in patch 4/6 instead (Dan)
>>> 	- Add Dan's reviewed-by
>>>
>>> The new CXL error types will use the Memory Address field in the
>>> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
>>> compliant memory-mapped downstream port. The value of the memory address
>>> will be in the port's MMIO range, and it will not represent physical
>>> (normal or persistent) memory.
>>>
>>> Add the functionality for injecting CXL 1.1 errors to the EINJ module,
>>> but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
>>> Instead, make the error types available under /sys/kernel/debug/cxl.
>>> This allows for validating the MMIO address for a CXL 1.1 error type
>>> while also not making the user responsible for finding it.
>>
>> I tried this series on an Intel Icelake (which as far as I know
>> doesn't support CXL).
> 
> Thanks Tony!
> 
>> Couple of oddities:
>>
>> 1) I built as a module (CONFIG_ACPI_APEI_EINJ=m) like I normally do.
>>    But this was autoloaded and EINJ initialized during boot:
>>
>> [   33.909111] EINJ: Error INJection is initialized.
> 
> In the current code it should only load if cxl_core.ko is also loaded.
> 
> Can you share the output of lsmod to maybe see which module loaded that
> dependency?
> 
>> I'm wondering if that might be a problem for anyone that likes to
>> leave the einj module not loaded until they have some need to
>> inject errors.
> 
> That is a behavior change of this approach. Is it a problem?
> 
> If it is I would say that we need to break out a new cxl_einj.ko module
> that when it loads walks the CXL topology and creates the debugfs files.
> Otherwise my assumption is that CONFIG_CXL_EINJ=y means that cxl_core.ko
> loads einj.ko unconditionally.
> 
> I would save that work for a clear description of why einj.ko should not
> be resident.
> 
>> 2) Even though my system doesn't have any CXL support, I found this:
>>
>> # cat /sys/kernel/debug/cxl/einj_types
>> 0x00001000      CXL.cache Protocol Correctable
>>
>> What does this mean?
> 
> Strange, does:
> 
> /sys/kernel/debug/einj/available_error_type
> 
> ...show the same even before these patches? I.e. maybe this pre-CXL BIOS was
> using the 0x1000 encoding when it should not?
> 

Dan's already alluded to this, but to elaborate: This series doesn't do anything
different than before when getting available error types, it just puts the CXL types
into the "einj_types" file instead. So it's possible that your platform doesn't
have CXL support, but it is reporting a CXL error type for EINJ. This could be
a BIOS error, or it could be that the BIOS is pre ACPIv6.5 and was using 0x1000
for a different error type and the kernel is interpreting it as a CXL error type.
If you think something else is happening, I'd love to hear about it!

Thanks,
Ben

>> Using ras-tools I injected some DDR memory errors. So legacy
>> functionality still works OK.
>>
>> -Tony
> 
> 
> 

