Return-Path: <linux-acpi+bounces-6706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5391E3E2
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D7A283E9E
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 15:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89416CD2E;
	Mon,  1 Jul 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wLF8b6ju"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B013D16C875;
	Mon,  1 Jul 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847043; cv=fail; b=gvWpgakVwyihWY+ATR7kEb/V7EdGqZuowrN9gWP/iFJfwsWD6MbWrTwWwC2cKMAh19K8J9OJ9eOW81YudndFCktsGxK1T+DgTvCZPPLMEuLl2MR9ZkPqEHxY7izochga518FWRt+4UIfW5F8+2I4XJEYqhNnA9GdQZJ4XbtHFu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847043; c=relaxed/simple;
	bh=zTLUSvpW3EYOwpKPHSVVUmzdBwX81hYoZnBATwlR39E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQ8jNtigRi8UOunIe8iMkn+x9aU/sryQaEaJZQi7CYZJ9t34fyuDfuEJ1HDlmwoT3n6jzGqeAlUWgLez6LYetqJycYSC2UUJXASor6T7bqYpHGzB81ie6Qi6UwBXqEEobGfLoyiprY3OOQHQQ1AkchDQmhWZhEXA+1kkkqKKkew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wLF8b6ju; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF4PBQZOCQx8F5ZiY4/7uxK/xara19lyXHwRBow4utxYb8clvlp/t5ZgfXQvdzMQBKEGs47JzRpJoLGFViYuiXWapmPxdHLQfExQDgSzwKCJN0pl7q3Exb9fuTf2ypQ+CjSN4R8o5SP5A5uHLlriYEejQavK7DXXevWCoC2RCiTdv6B8IlHBprY9bgS/i8sXDO2OiYB+XGfwlNsAPH/6JXWMmu/+pbOo0N5eeXop5we3GCSbpgTq84GNq2PRORiPanM5IH1XAgCvTa8vviEPEgXAHOcbJRAt7yJerDhHvxbzT8AdsK1cR/F3tvtjxQkKcza2KCqWHFnEcZelbx2g8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wkGzkfhCbvL6YvfnBHru/ggVDsvHKpbD7fgnL3jE/A=;
 b=aCiUNees9MmsSNQ+WQqkBi6S6bnCINd8YivGb/bSN1qLQl3hkzL1vkiaUtVgVxcDGvXWlfqb5ecYzaiBY9L023ImpDDiv+dledv5uxhfVDt5S9g5Icm/deEqxRBhBw8NUNVXR/M85CgNkzZkEdDYwuKI6I/QutimnQid01nUL7y5oZArqW8Jyy6S+gQUwk3gtVRnVR62+9nqcDGrZ3Dd/nfa+cv6hrm0dI+vvbb20GnOuAmMWARUJwAEnMagZaRtw6BrS6oxPM51LFljuDuaWTIroX7xbPLP8xFRD1LjQFfEnx3AopTdLlMq34iVcB7wJGeJTO63VfeJlDBWaBYLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wkGzkfhCbvL6YvfnBHru/ggVDsvHKpbD7fgnL3jE/A=;
 b=wLF8b6jujpYuYMu259sxDrrcGTukCYDSiPnWKFO6ibazgDGp8LWkOK+jFKY9w+MP8Tph38daDkRvKllB+xkIRzfRi6DxGGj/rOlt9RdzaiZSZ8y5Wyc8MnjkPORZdN5YC84KD6QIpaZwsz5HoCFgTaikQJZAIwWEOMOrY65ti90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 15:17:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 15:17:15 +0000
Message-ID: <46742c5a-5df4-46d1-bf5f-b74067866fec@amd.com>
Date: Mon, 1 Jul 2024 10:17:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
To: Kuan-Wei Chiu <visitorckw@gmail.com>, rafael@kernel.org
Cc: lenb@kernel.org, akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
 alexdeucher@gmail.com, belegdol@gmail.com, regressions@leemhuis.info,
 linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZoHKhr9896+Kf65F@visitorckw-System-Product-Name>
 <20240701044232.42266-1-visitorckw@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240701044232.42266-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:806:22::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: d5de29c4-eea4-4809-2e1c-08dc99e0e3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWUrZkhST1VEN3VSTnR0MXFhT0xSamhVTlNyeHFEZXluTllib0g0bHgvYjRF?=
 =?utf-8?B?SHd3RWE4NkpkRCt3eGJNSE1XQjdLL2VmdkZGTU5LQ1RUdHErZ0JOejFhTUg5?=
 =?utf-8?B?MVE2T1NnMTV0TGsvK0Q1R3FYRVRQaGlQRE91bG9lVjR2QWVlQXpsMmpMWHBT?=
 =?utf-8?B?eG80YUI3ZFliOXVuWjRDR3JQR0d4NmsxUmkvdDNLM05PK1F1dVcxd3h4VHdm?=
 =?utf-8?B?RUdSZlJLRkxtTzdGVnJ0b1NhcUhBQzQzVzBBL0lGd1RZam9NV1NwcVRub05W?=
 =?utf-8?B?NlBpQkJIejVPbmNXUHhsTmlad3ZrdzB0dmVOSUhYQmJ5ZjNkV3kwTGRVbC9D?=
 =?utf-8?B?dzdhdlJhMk1HM2lwT2IyR2pEbkJ2ejV0SUh3REF0RUttN2NsZkhwZ2RsQ01H?=
 =?utf-8?B?NkpZMnBCTG5vQWY1VHBLaEgxckJhbXBPRXc4QVFpd0tJZE0raGF2eU51YVRS?=
 =?utf-8?B?K1RtYmNlR3lyeUV5UmRhOGNOOVZTM3RTN2NWT1Q3dW15dlVUUFhQcWZ3eTky?=
 =?utf-8?B?dDJsM3J5QUtxOEhwV0ZXK3p3bWZtTWZabEg4MlhmMDZGMmFBVzZnZ05vczlR?=
 =?utf-8?B?QzF4cnRKK2J6eU5seVY0ai9jVGFYSGZuemt5QmNEakRqUCtYaDlVQkVjSGZR?=
 =?utf-8?B?RFBYWlkwUE5OeTV5TmRCbFlvb3NhODlWeUlEZ3lYbUdlU0VyQWlVY1EwTUtK?=
 =?utf-8?B?c1hjVktVeW01c0ZUbjRXMDlyTDdmSEI0SXd4RUJKTzgxK0d1TXJ6UzVtV1pB?=
 =?utf-8?B?RzR6YzFrNDRFVWMvM05WMU5EMytvUUVETlBhWUl4MXdOWXFLT3VWQyttUERX?=
 =?utf-8?B?YnRGSHgxTjkrcjNQeUpPVVVpZzMyM0xpWG9DSG5vdGFyMVpMUDMwSWFGSjFV?=
 =?utf-8?B?cFdTWTI0YkE5a2RFd1pmTnk0NTh3bGc1OE01blMrWlJiNC9zNFlHMEZSVEV1?=
 =?utf-8?B?UnFOOVZnc2VhNEZiU0s4bTFYQlZqanBabStiTDZlZ2VNbnp2NTZCeWNNWEFT?=
 =?utf-8?B?cjljY1Jvc1E5VzgybVRkQzkzZTljWng4L0FmOFJtRTIxbURpTi9Ld29NRXJW?=
 =?utf-8?B?R3F5akdMYkpodHI0ZHpTeDZaVTlFRTRiRFZxdHhySm9KbDlQNlRhdHVNeDFB?=
 =?utf-8?B?Y1IxYnVrSGExdlFpMVlaRlRhWm14TjRsWTRSWUhHRDlBbGc5ZHpKRWQ4c0NZ?=
 =?utf-8?B?OXFRSmtjL0NZQWw3Nm94cmZ0bTdENmt2a1RFQTREYk5SUjQ1L3hzRVErQ1NB?=
 =?utf-8?B?YkthV1VyVHQ4YzBNU2pNSmkyQUdkQWFpa3VvejBMaXhnRllzdG1YWFRDZE5s?=
 =?utf-8?B?MWhCR1BNMW9ZYzc2eWtDV212VmhSd05GYUg2QkJUMTQ3YWgyZGRNOFcrUlc0?=
 =?utf-8?B?aVVmd2k5U0lUNVBmZEZsWXVQeUo1SXhvT0hWRm5yQ1NvNTZpb0hyYk5TRnVC?=
 =?utf-8?B?OElBdE9VMVNSdmtaZEwxWDZIMmdLUkxqSGdvbk5pYkFER0ZDOWtLa2tiY09W?=
 =?utf-8?B?RjVnWFZZZDFPUGhzazlVa21GWEdCUzN3S2w0Uk9Lazh5VHNoeWhlTVNnU3h0?=
 =?utf-8?B?Vlpqd2NLSU1iYzNuYURYWTdqK21nUHlKcUxSRU9DK21sSnFDK3JtNUQ2N1NX?=
 =?utf-8?B?anlCOEdVL0ZXSjA2S2xPV0d0MXFYYkpNZGE2WG0wbEYrNjkwZW5DYTRtSFZR?=
 =?utf-8?B?R3NDNUFwamF3SUxHYjZKZzBXeGRndzMwSTNqVHZETFR3UitSdmYwWkNKUFVG?=
 =?utf-8?Q?LGQ+q78Llwi+4Qh8es=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3l4cXAzZXZhYmlLQUp0anp3Sko1RTdkRmlSWnBPMFB4bTJXeS9neXdoa0Zo?=
 =?utf-8?B?b0Q3ajdVNVRQdVJFazk2VU1qbzBjNWhOZnE5NHRoS0l6T25Ha0xjTmJHaG1v?=
 =?utf-8?B?M0R0YS9oUXkycSttRHVHdUdEcmhwMy9DWG5qTmkwNFAvM0lJNGFYbTFOSXRR?=
 =?utf-8?B?cXRWZVR0ZjVnc3VyaUxudzNDZndpT3N6aTZFQ0FoQzNHbHlMQ1NIK2ZGamZK?=
 =?utf-8?B?WHpZRzRicjFJcWx5UWdyNldGeFM1aTZjNDYranBXdkRpb0g1UGhtQlVMWVY2?=
 =?utf-8?B?LzhmeE5WTk9ERk9tRlR2WitzL0ZNK2UxK1UwMmhCYlRWWTEvcFQ3aUZHS2sx?=
 =?utf-8?B?dEh3b0hZdncwdTllcUp6b1NpMmlBV1Awa2JmOU5KTy9Wblg3UGdBU1VTZlBW?=
 =?utf-8?B?eElnVW5MUkp5L0h6YnV0UGNMWFdvTEpWNXI5TlJ0eWNzT3RqdFBUNVFucEk2?=
 =?utf-8?B?bFJVdnpaWUg2VW0ra3pYaTY4NzhISGpBazhhdFM1cXdoNk55VldPcDVqWUlK?=
 =?utf-8?B?dFYvVHJHWEpqVUtEVTYrTDFORmdHNllMcGZLUDdpL2kxT241U2NlZmJrRFVx?=
 =?utf-8?B?cTEyKzR2ZllKOXVVUG9KaUpFc0pnOFZnWWppRmlPR2NhNEF0cFZONWV1MVVP?=
 =?utf-8?B?dDZpdUhVQ0FuM3hIKzc2WG45R21sTXgvSmR0eEEzT1FkRmJicE9UNU9hM3Ro?=
 =?utf-8?B?aWF3ZGxTOTlabHJCaEZuZnlleWZtRUN5UzVmN3JmUGFjdGIvbUF6YXFuelhk?=
 =?utf-8?B?cVovLzFsUVpCaHFLVU1YcDZJMmxma2xTZmZKa0JnYWVaVkZkeUZPQ2tJTEtN?=
 =?utf-8?B?L2lxY21mMHZGTGZyT090Y2tkQjFUOE42SGpKbjdjWUlTMEh6NFUvSXYxWGQ3?=
 =?utf-8?B?VnluTzNVdHRTd3o1RWlzV2RzY2FMQnpSMDJrdFcxd3VyMWpGQk8zczFvd2RX?=
 =?utf-8?B?bHpzT0o2RFRDcmxWa1FFM0JONWdyd0UxUHNVZmVhbEV6V1ZEWTRzRnlIMnlZ?=
 =?utf-8?B?MGhIb1B1RUkyUkRJSEJrSi9Zd0pBSFFycWkwcWY0SDBDRmk4eFZkbW5QTnJO?=
 =?utf-8?B?Z3dRd1RaeTBucVVXNGRTZVFUSmdQdlBlM29QNXFWbmFjdE54clFDZ0tBdTBy?=
 =?utf-8?B?QjVKT0NrT0c0QlNLcXR6MXFyM0RtVnpGOEtHM2N4a3dmdmN5K1h1S0Yzc1hD?=
 =?utf-8?B?YVRQS0phMTZha29XM1J1emZhMlJWMGRxU0VXUUpvUjI5dHhadjJNYTA2anIx?=
 =?utf-8?B?SWphMEthWVFOcEdQcUNHcVpHUjFYa0w1Vjg4MWRjZ3dZOVBzRnNPZ3ZRbWl2?=
 =?utf-8?B?ZUNUb25YQzNkUzBvSUhKdlVZczRoVEs5MU5OVHgzVGhuODZmRjVlYWtnV0dq?=
 =?utf-8?B?VEtkTXhJNnFnbEhkMWY2TWd3ckk2bG9icmZMTVpZR2lKemUveDQyR2tyaWxK?=
 =?utf-8?B?WjlTVE5XZE1pT0lySFhVQUV5Q2RBOFl5QUVqVmc2VTU4eEkyc3lwVmhKSWVV?=
 =?utf-8?B?WDZYWHQvU2tUcFBoUEpJS2pDODI1Q3F6bU4zWGlYdDRMU3Ivd0tzZHIraHVG?=
 =?utf-8?B?V1JmRk5yT0xJOUtUWFRSZDd6Y2l4Ym0vT2liL1BVaEhmSTcrV1M5cDlXOENq?=
 =?utf-8?B?V25Oa2Y0RU9MKzZzVFZZYXhib3hYcE1MTnFsSkUzaVVHL3VtUlo3cGVhNU4w?=
 =?utf-8?B?MmQxaFRzTnR4dUZaVWZ0UmxPQjMyVlJDNFEzT3J5alhNOWkwN3NJenRGd2FO?=
 =?utf-8?B?NmlFWGhJQXptK0RIR2ZmaGNDcHlscFpwL3Z0RnZIL0JiUk1aZzFPZHo4N1ZR?=
 =?utf-8?B?c2dtbkNkRHAraEF2aGZOc05sNWJSWFl3MlRjTVhocmVwaWhTMWJUeUY5MGJE?=
 =?utf-8?B?ZDNmcElKL2FsTkpqcFgyUjZOTVkwdDF4SjAvaGxjekRMMDNBMThscU50Ulg2?=
 =?utf-8?B?TkJ1amZQbWtGcXlIQ0xqU2RycEhYSmVFeXdoaVNqNVJwSnQwTGVvRmlDMmU2?=
 =?utf-8?B?VlhpR1pXNXVoUEpURGxhYzA1OFhXRlZUZUNwbkIvckxkRXArQVA0cklqQitk?=
 =?utf-8?B?TnFqdjBINkRQVFM0QmYzRVppcndYTkVxOEI2enVNUVdHREczK3Y2R0J5TW9J?=
 =?utf-8?Q?NxWJiwSgrxImpVdG5argKoxJg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5de29c4-eea4-4809-2e1c-08dc99e0e3bf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:17:15.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BP9XzW1eElvmHdoWX1Xbt6Bowqu+PPXF3S+Y9o+kq7QcJ+GuEvzrCnDOKf1hGS05AjrnyNSSoiM1Lv05WpsHeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136

On 6/30/2024 23:42, Kuan-Wei Chiu wrote:
> The acpi_cst_latency_cmp comparison function currently used for sorting
> C-state latencies does not satisfy transitivity, causing incorrect
> sorting results. Specifically, if there are two valid acpi_processor_cx
> elements A and B and one invalid element C, it may occur that A < B,
> A = C, and B = C. Sorting algorithms assume that if A < B and A = C,
> then C < B, leading to incorrect ordering.
> 
> Given the small size of the array (<=8), we replace the library sort
> function with a simple insertion sort that properly ignores invalid
> elements and sorts valid ones based on latency. This change ensures
> correct ordering of the C-state latencies.
> 
> Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> v1 -> v2:
> - Avoid swapping if arr[i] is an invalid element.
> 
> I do not have the appropriate AMD hardware to reproduce this issue and
> test the patch. 

Even if you had hardware, the behavior stems from a BIOS bug with the 
_CST entries.  I know it's been fixed in the BIOS on most platforms in 
that era, but if I recall correctly from a few years back Julian's 
system was EoL already.

> However, if the aforementioned reason is indeed the
> source of the problem, I believe this patch might help.

Thanks!

Assuming this patch works for Julian, I believe you can also drop the
#include <linux/sort.h>

from this file as well.

I do think this should be cc to @stable too in that case.

> 
>   drivers/acpi/processor_idle.c | 35 ++++++++++++++---------------------
>   1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index bd6a7857ce05..813c718b9108 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -386,25 +386,21 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
>   	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
>   }
>   
> -static int acpi_cst_latency_cmp(const void *a, const void *b)
> +static void acpi_cst_latency_sort(struct acpi_processor_cx *arr, size_t length)
>   {
> -	const struct acpi_processor_cx *x = a, *y = b;
> +	int i, j, k;
>   
> -	if (!(x->valid && y->valid))
> -		return 0;
> -	if (x->latency > y->latency)
> -		return 1;
> -	if (x->latency < y->latency)
> -		return -1;
> -	return 0;
> -}
> -static void acpi_cst_latency_swap(void *a, void *b, int n)
> -{
> -	struct acpi_processor_cx *x = a, *y = b;
> -
> -	if (!(x->valid && y->valid))
> -		return;
> -	swap(x->latency, y->latency);
> +	for (i = 1; i < length; i++) {
> +		if (!arr[i].valid)
> +			continue;
> +		for (j = i - 1, k = i; j >= 0; j--) {
> +			if (!arr[j].valid)
> +				continue;
> +			if (arr[j].latency > arr[k].latency)
> +				swap(arr[j].latency, arr[k].latency);
> +			k = j;
> +		}
> +	}
>   }
>   
>   static int acpi_processor_power_verify(struct acpi_processor *pr)
> @@ -449,10 +445,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>   
>   	if (buggy_latency) {
>   		pr_notice("FW issue: working around C-state latencies out of order\n");
> -		sort(&pr->power.states[1], max_cstate,
> -		     sizeof(struct acpi_processor_cx),
> -		     acpi_cst_latency_cmp,
> -		     acpi_cst_latency_swap);
> +		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
>   	}
>   
>   	lapic_timer_propagate_broadcast(pr);


