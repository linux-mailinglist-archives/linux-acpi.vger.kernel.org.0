Return-Path: <linux-acpi+bounces-4166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEEC875240
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 15:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035E9B2A8AB
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447C12EBCC;
	Thu,  7 Mar 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xasPre0V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1A12EBCF;
	Thu,  7 Mar 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822824; cv=fail; b=bGNT4uqfmaHVyfknTq0X7NXxCWbprEfF3iVf1cZjTfl7deBk5Of1GOm/P3iu1L7a9EG0hEURCFIJpcty+wMEiIj3K1Lqv724MFA/ew4xsRD7GE4pxPmIZl5oeZ8GgRYGnuc+I1zgzE6TLVAvlLXTWAl00uohjs+gIA8lbOQ072g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822824; c=relaxed/simple;
	bh=Fwv4+mptKbs2MOj63ZL4F7XgxAUzwHXu8r+vw2tv0mQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CU11aS/SxLJwuOOV6x48mpWa8+ZRVQ6uvQ+3jl8/xsngiB7t6cq5YvJmvtbXFcqsyQBR81YMqNVDrbqHpIhW/0q1Oktcf5F935x9Zpml0bu8fi/kRkwXkQbAWO1zXoZgg65WavYJFhXwhvLPC8xMb34KN0mHFUDIiHDxRzDT2tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xasPre0V; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLr51+/c2Id6jtiRoZ+TLeymJ3ZFPaMPnJo4PQwSMagJAoEaFPr5eATkQE9JCrXWpjCW9RT3U/1tqalUZT0Y+wet1/u7MmDIGehf31ugz3El+4ArNC8oYqU3A1lpZGSUum66bk3Aq9Md/gLsZO5MO9us8nbXN0rH8t6DbTL2DqoJ5um1vOaZfxRavQevgtnM6SmdgMhlBUyzT6Fqtu8oiVchfNiiCtpfPSGV0pa5eTY0eyBkeTvRy00waRSKx09OQLVDHt8v1ScPfzjbMEfy/+0BQ1yregqJG03o6adZ2Zl0wWO+sAW3iQT7LyiELmH8trnLHnx5oEeJro6Fr+KYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j39SSwQgVs5XwlM7lxjDkLvP7Y6eGT06ntELSAt2W8U=;
 b=YopiYod/AgYsgPZxC3bxGndBLcWBFGUcU2LSTD7dPqGyZramnGyU+fTWYUPRlYZvFtKlyEGlxJsjl2/w6DCbwkFzFa0UvM7c/heMypI8Z9ItcgPXeITQzx85WuOA8Q9VYFSKCioylvQ/tql8kvgGWJN5pGc6Pp2QaT1DNCA0eWPjrkvmZVVlNmrgj2WPG+HSq4fb+BjMbwEXcrynCvcBziwK2R/airVCKSqF4ScawPyTH+5Cs46KKZsJHBoRuNKo/+I0ZCm8rI6rn/xl+DcewibB0f/5tyWvTy3Sa2JZE7yDHA7Wq7pLj24tjf0F0S97Sn4iNlOJtWECUVPS6HSiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j39SSwQgVs5XwlM7lxjDkLvP7Y6eGT06ntELSAt2W8U=;
 b=xasPre0VPd3bE1vbgk0yA5PafQ+k++L/Pz4gYW+1Do5blSop/npcLA8v8/Jx7wmDRj3E2utdS2k+IZckC6L1oeeCbinunv7fZssxzT7oQefhH51drgeAl9/Bi3nfCAbCMjvNqKdc+1DNZqyCP4DMc9iUWQcpj85v28+h8zdyZs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Thu, 7 Mar
 2024 14:46:59 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 14:46:59 +0000
Message-ID: <942e68e1-a4c2-4d8e-bade-1aa14e0ab614@amd.com>
Date: Thu, 7 Mar 2024 08:46:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/4] cxl/core: Add CXL EINJ debugfs files
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, rafael@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de, dave@stogolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-4-Benjamin.Cheatham@amd.com>
 <fcc39ab2-d616-4be2-a816-b0037a9653a2@amd.com>
 <20240307121047.00004b28@Huawei.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240307121047.00004b28@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0093.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::17) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: ab275c90-725a-4b13-4a4a-08dc3eb57161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e3jeFN0Y5cZYo8yoxHsdUc3JIQcccITmcYt904sV2kHG7TVn4MsaTTGT7d3KZO/y63ByDe1zKgM7HmxYPQu6Ju20zSmsmPlp5Emn3NZYN5yV4DOv027KbIij09iMrY8NS4Nxx/7cQwnckGF41uaZ0DlbPw0WMlgk8ACaPY46hB+E1MPHsN0L8dByPHueIIgTtXRqe+yeV4qIW0j9aFf2/Sdl2uQwDn6ALNZt7CbIVsPvFp4zMuQc4n9wPnQVmjR0DCi265WUbr8AzuBxS14layIE9qjzj98rleuHPTOM9xREgkW06jYqMe3kCCahK2X9DSEHbpjM0Ex27ZyfbIlzWUGOxCILE6B4WSLaWj4/z5rw8/fUqR0ha79kghQU/K+xH3twl85jRBqaQCORLuWYf9qO72W6753sOlIwqwwXgf9tlcL9FSxKlwu1Szwt5B51fdgIq43SViF5iUyVNKzEWrOLaXCuNra7r8TRM8t6QRo/nhreAm5usFQ2x6DUhmblOXIQPd6t0fQW1cpndOuOMDJZwy2XgwtqcGbYR4owFMAo3s6m3OEtzxwfRA1ZH6CuIW1QKvp/fpAWi5ZZXWkfoAQnrRpKUqZSNcGSQZSjiR64hG5cC14qPZUexvmfPdGikc2Kc2bsP9bX9DUS7FB4OPWDPNMhvCBhi49JycMcfd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzEraGpkL2FmbVc4dWYzRnJ6YlpDTkNSbnV6MU5CU1prQUg0U2ZxVUZRZE0z?=
 =?utf-8?B?dU9KUTBmZ1hkNExBcEQrZk5PNjdraFZQQUpYM2hxR0p5NzNsZHVVbVgza0xp?=
 =?utf-8?B?eE9pai95SUJ6WVBHTkMxeVBTbE1aWDBIdzJ3WllwTmdLTThJbzNiWmphdGJT?=
 =?utf-8?B?N2o2UVVkbFh4Q01XZGNUakx0UnpMNHF1Mi9zTTlaeE1pc0VDbStxc3IvWlBG?=
 =?utf-8?B?OUpaZ1ZsZmViYkplek5rWnpoSmtFYWF1UWJQTWxZVFNsWVorSFRBdnhEOGR6?=
 =?utf-8?B?Mk95NHpDajdaeWdudmdlbFNYQTBQbzVqK211NzJaYkVITXp5U1l6eU9mMjVz?=
 =?utf-8?B?MGM4V0hIN3JaT0tWYmhVNVJDVVRpWEI4a1B3NlRKYTI0aHJ4ZmtYaG16VnNx?=
 =?utf-8?B?V29nWFhRYkdnTGhKQnN4dlRvU0h3VVY2bTJDeDdMc2cxNFBhUGlYcEgxTkMy?=
 =?utf-8?B?RCsxSno4V2Rxb1NLcUpodmlEMkhvaDNocitXRndVTk4rZ0J5Nkw0K09zTU1x?=
 =?utf-8?B?Z3QxZ3JxMFBTeXZ1R0RXaTM5aU1TcG5tbWZ4WUR6L00wWjVwblo5M0ZLRlU2?=
 =?utf-8?B?RU5xOGVvUDJiUFRtZHVjMWMwNkRraWdrU0tyTWVybUdUMDZNbDNhVDdSMHlZ?=
 =?utf-8?B?Yi9GTzR6cmF0QkdZQW1hbzZBQ3JBYlRhRnZXQUoxU0l6L1grME51Q3hSQ2Nu?=
 =?utf-8?B?Mm55cHczc3Z2aFBlN3A0ODc5c2xWSU8xYStuNDZONjlkSkMxYVJ0Wm9PenR1?=
 =?utf-8?B?MXpVKzUrTlJBbC8zb2Z5dElWQnpsSjFIVmdLQ00wZFFvSEVoTGcya1Y4aUUx?=
 =?utf-8?B?WUd6Rlp5eno3SmxhM1RCL0oxNGpoeUEwSE5sc2FDTjB4c0hmdnNaQmNzSFRN?=
 =?utf-8?B?MXNDR0NRcVIyOUd4V3RpZ2JSdUZjSWJoNEh6aFBCVUMzUUhXM0pIQW5ESyts?=
 =?utf-8?B?Rm5DN25YRjZ5SjJPKzM5RFpNSjJ4Qytkejgrc0xNRWFvZy9kNDBZbHBKd25i?=
 =?utf-8?B?Q1FicUQ0VDhoenhkdEkreWluTXBwSzhCcTcrdU9HYkY4Ymp1cW1UZHowMzNx?=
 =?utf-8?B?V3JzOHk2ZGpxVGlOQm4yK2NLTW1zZ215NCtWWk9McG1lN3grclhRWllpcmo1?=
 =?utf-8?B?eXNTU3BPTXpuSEo4T2JmVGtUZEdVMU0wVHluV2p0OW16b21yVVQycjY4Nm16?=
 =?utf-8?B?QWlPdlkva1JLdm40V1c1eG1ISVY1d1A2OTI4dXZockpFd0E4MGZreWIzeWRJ?=
 =?utf-8?B?V1FjNXVIVGt5K1h5elNTTnRUZGw5NXlkSTBvVWRyK2lJS2lJbWdCNTk0Qzdj?=
 =?utf-8?B?Z3VQUTdJVFk3L2tuc2s3Sm5sRGFiTFVZV1B2UzgxVlZxempyaFJCSlVpb2dk?=
 =?utf-8?B?a1h5UnFGa3pkTWZGdFo3b3pCajFpTGtqeFJSdFFETzNIandvQ0oyaUJoWXhq?=
 =?utf-8?B?V1ZXSTBmYmRCbjFXZnNjbnNPOE85c25wdTh1bjg2Vlg2SlRyb2tDQzJlcDhU?=
 =?utf-8?B?MGQwZDE2dWQ0Q2ZjRlB5eE45Ykp1SFJCL1k5eVRBSFRaeVlGZVdiTWVxeVlY?=
 =?utf-8?B?NWo2WFhIaGhONGJOdEJYMWJ5VUdLUlZMcHJsL3N5TVd6SythRkFaTVN2TFJj?=
 =?utf-8?B?eTF0QVBOVEZpZzVzSnJoVXVwSFVCTjRSN2I5VW1IbUQvSkJGMU16bmZCMEt3?=
 =?utf-8?B?R3ZRQ05NZERnT29PQnhRYm1XTzNJZGQvWGw1UGVGNVRycE1hYVk4SnVZUkVW?=
 =?utf-8?B?MWpRajllVXpGYlJjellSZDRyTXRORzFON015UVFja0VwVXJrUU5DUzlTSVdS?=
 =?utf-8?B?Vk1yUDlQMUU2UnhSUExGR2p5cmtjOE1RRGZMSDhHRWd4aS9MMEpiUFlVWnZC?=
 =?utf-8?B?TW9KdU1JTXphQUlDV2pwVTBIRkEyajFvVnJEZGRsamtIa3dxOWZDK2dXSEo1?=
 =?utf-8?B?WDdPMGR4Nm1yWnlpQlNxZXV3THFsOGpuQ3Jwdk1VN1pVTzltOS9vcWsrYzhu?=
 =?utf-8?B?a0MyMVdWY2FkTTd4Z0NKdmhSc1ZCbVlHdmI1U1g4eUVWK21nMWVCdEhCN0Zl?=
 =?utf-8?B?NkgwK05TQVBMQU8xcFQ5eWxDSDhDRzNsN3ozcjYybkY5NVppYzVxZk1IQkJQ?=
 =?utf-8?Q?YEMBA67ey6oPdVl8omOHKbvpO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab275c90-725a-4b13-4a4a-08dc3eb57161
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 14:46:59.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eq4H2GbqIpH95k1/RDEGlBnTYt3K4xn3oKy3rASXIj4OiC65QvBg8F9pMwUuxAFoxyREenAa5veHw7wphwhf+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018



On 3/7/24 6:10 AM, Jonathan Cameron wrote:
> On Tue, 27 Feb 2024 14:14:35 -0600
> Ben Cheatham <benjamin.cheatham@amd.com> wrote:
> 
>> This patch also had an outdated commit message (still referenced the einj-cxl module).
>> The patch with the updated commit message is below. I also made a tiny change to
>> the format specifier of the einj_inject file to "0x%llx\n" from "%llx\n".
>>
>> Thanks,
>> Ben
>>
>> From 321129893da9129473c447772a461c1a4e9e0e9d Mon Sep 17 00:00:00 2001
>> From: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> Date: Fri, 16 Feb 2024 11:17:01 -0600
>> Subject: [PATCH v14 3/4] cxl/core: Add CXL EINJ debugfs files
>>
>> Export CXL helper functions in einj-cxl.c for getting/injecting
>> available CXL protocol error types to sysfs under kernel/debug/cxl.
>>
>> The kernel/debug/cxl/einj_types file will print the available CXL
>> protocol errors in the same format as the available_error_types
>> file provided by the einj module. The
>> kernel/debug/cxl/$dport_dev/einj_inject file is functionally the same
>> as the error_type and error_inject files provided by the EINJ module,
>> i.e.: writing an error type into $dport_dev/einj_inject will inject
>> said error type into the CXL dport represented by $dport_dev.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> LGTM other than not sending patches like this as tooling won't pick them up!
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Yeah I normally wouldn't send it in this way, but I caught what needed changes
before most people started to review and didn't want to make a whole new version
for them (especially since the version number is quite high already). I probably
should've just waited a day or two and double checked before sending it out in
hindsight.

Thanks,
Ben

