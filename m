Return-Path: <linux-acpi+bounces-20837-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM9RI3wIgmmCOQMAu9opvQ
	(envelope-from <linux-acpi+bounces-20837-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 15:38:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE60DDAB17
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 15:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 696E53014553
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA313AA18F;
	Tue,  3 Feb 2026 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZotgNOQG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28473A9DBC;
	Tue,  3 Feb 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129128; cv=fail; b=hckjKPe2tKyQAwKk6TJCSWtwl/6n35OrFhipnjX8qe8iECZIe0ZAYQUo46WcJ9XiEUTPrALNI+/E/pfgywz07v+A7BcBXMYvM5LMLcHWDP6pbH2d4J7HA1VS/f//g52M3WfGCw4YNSP/kYRfx8u7pZYPRwfQkF0oB/kh7UfBmoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129128; c=relaxed/simple;
	bh=ytW5EihnkTKMKjEaz8hpYIr6W1x8ytjc/m4m6OizuQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9e9EoY/+3knuFehmOLVuC/3GWirnR73zfHA0feGfg4QpOmsO/M9UgNUp3xeCjZdqXcQQPr4IOEzIgoAiUwOTbmWL/mvr4KTsWIWHb0OsrlA9VudIC8I45SDR/kUNS2GaoHtwO9Xsr93fVRfRp6Gv5lJ4E+2+IMoXZ5i4+5cfvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZotgNOQG; arc=fail smtp.client-ip=52.101.53.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htnwl6wO1KZj/p/8Qfuzn+avSq/OZgSCTMth/xw7AIFAK6yRoRYmgDYfPXJqQCM1mMIpNv2M3u5i31/R7f61+c3YEhqpodqqjxHWzCRUAryPMKrZLMxS/K657DfWDP2dnlhTxmy+0/nWNSIA3E7ueFkl4z1Qt0zxfn9e+APbGEEYjUnZg5xJqdoeTQr3wG/Denm/I7ZSG2GRHRReuocbj5xJy5+Dn6cxcaQBOC0quY0YBglSCyuhWT+w7b1n9yL2uALuVT4MxTReenFoWQp9PaAW4xh6NfmzNb0qiYEcKttXyz2E4MTu09VHBxSNAsy0+MVBj7SgMVy+Tu1CmyZ5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnDPKFDZiAfekJ/r7/9h4FWkAhHYbSdhbVJdjsLoWkY=;
 b=RISS1dxTvo12xazGbY5iUlav9j4L4zxefo8Dva3VogzopGVj1ExdIRoVb3eQAFkBTL/ffvQiE2Y6GoujWh6rTkbukMtX18AL2UnAvzxNk1+lX+cglZDb+HLvWgbbopIHiOG6a/6kBecnxx+/vxJPMVFPH+f7x7H9FE6C6cAiF7MgYi9gaWbvJn8mGaYsUc0KWM2TGxtx6NEGpZza8HqpVVgV7k9EKpml+73y4vW1YMvXv/344YMCi8uCkKfTEagNl2OGBFn/Yio5m9KmOYEUCgLj1w5RAaHqqOvbJdTZ/cgwXYgZRO0qHayki1ylXLxMi7cShm9KLcGh7Z0vyUZCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnDPKFDZiAfekJ/r7/9h4FWkAhHYbSdhbVJdjsLoWkY=;
 b=ZotgNOQGSUjGDfBgnH0DqzOJ7PQxTrY4LEvApSjIPEm8KpEz/1STzB7Yf5SSxMVgmzIf7mUgpJZYRNZ5gSObD/CPvrGgFN+q3YfNW0yPHlsEYe5ClQV95DQfTieZIy22qE3GybwXb4sqweOQBiKBmP+VYZ5+C4ttL/Y3PqUkvXn5GziaFRE6Hi4wqPF0XKQIJeESvkIlLG3P9/DK3KNJpWTiTCTgPVMNUafPhl/k2CDacPNJ+rYk98ZtAMdyPS3W2X8fINeoIRWTZCkyunjS7I78wE1pop3jaHk0YLuqnwlFqapr7+zFS+YtD6SosaW9vKBdDM4SOgDxew+Ut0sYcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 14:32:02 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:32:02 +0000
Message-ID: <211d9dfa-26e6-4fc3-b70b-f5fbca49e5fd@nvidia.com>
Date: Tue, 3 Feb 2026 20:01:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Russell Haley <yumpusamongus@gmail.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>, pierre.gondois@arm.com,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
 <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
 <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
 <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
 <CAJZ5v0hUdLsh8UK5G6rHHD49RQGYLAiU1J-11DK-fLTKnuqhUQ@mail.gmail.com>
 <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0ggzD0PEti-r20Sm-8n0gPigPh=NgE2Oa=UKzMmwB0jpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::7) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 4889bc4a-61e1-4c88-5202-08de6330fecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVM2d3UyOXJWVytZSW9sN25QUzJ4MzA4QUZrRTZWOEVDeWcvNXErM1hjNnFX?=
 =?utf-8?B?bUlwKzJkSUVGdkNUd0w5dXF6VEZGTmh2bDViQkNFNENkcDZKeExoM3JTaER2?=
 =?utf-8?B?MG1tTStock9sN1RUSUZQK2NRTkY1dmtsOUtscnVTOUl5VVA4dGhMODV6VGR1?=
 =?utf-8?B?L09HRWJ1TkVpZVUwYjJ6bjY3TVR0YzBZT0p1KzZLa0lqR0hKZXNzcVlWVzdR?=
 =?utf-8?B?M3c2aEJTZ2NCU09QcFo1QStHQmVtR2dnUmxLeTZybm5rQTErSy8vMVZsUUlx?=
 =?utf-8?B?VnFvM2x3OGpMMWVrL0NGdlN5M2ROQkhLdnZLN0pISDBucGtTYUtQQ2FzcVIr?=
 =?utf-8?B?dU03VWNJNTdSSEFKRDhhYXNQK1FMZVExMUNDNWdaTDE1ZElTMkpuMWZ6UFow?=
 =?utf-8?B?Vjh2UGIxTWUraXhLWHpWTHhGZ2M2Mm10YWN1OG9sUmVVbWxoOHdTdmQvNWk3?=
 =?utf-8?B?VDVZTHRDKzZFVnMzNmVwbjVnYVdkS1BocTZsVWw5Qmh4bkRySDJxK0xROHNM?=
 =?utf-8?B?VWJDb0NwL1M4N0RWUnFyUHJYUGNDdTBNVkhPOExwZERXS1JZS0dNYnF3dTg2?=
 =?utf-8?B?UW13R2lGdmRwaEhhMEs1amFoRlZCTXZHU29vblgxb2VjL2VHMHZRbTJZY015?=
 =?utf-8?B?VWJyZWpSY2tmRSswR3dxRTh0cG9KZWovRmwzQXVJbkdqQkxpckY0M0JuRHpz?=
 =?utf-8?B?eGRoRmtWRURkdTN4U2JMZVRaUndKdFM1dnVLejJ1K0xTSE1BcFF2dHhreU9w?=
 =?utf-8?B?aVhCc3pLQ1ZSV3pCbHNJVWUvdGFRcHByL1IrcHEzU1RidmFtS3hYWHRhc1VR?=
 =?utf-8?B?MzNWTjhBQy84MjBwUGxVa2J1MUh1eGtwVGNTRTNzQ0kvZm9xRDIyM04rcVZn?=
 =?utf-8?B?UmQ0R0ZPbE80NVo3a25NRE43Z1RsRTF0enpzbkRWZmVzaklNQzhMbEl4bzhI?=
 =?utf-8?B?Tlh0b24vWGY2eVl2R1FRdjdEb2Yzd0lHYzFmVHA4bHV0TG5BSGorcUR6cEhh?=
 =?utf-8?B?NHJXSHdPZkp1Sm5yeUxqV1VFbjRmSmo2T3E0WVJpai9IWktCVFBkcjExZUF0?=
 =?utf-8?B?WXA0YUhUckJEM0x1b1QrakpSRTk0VGNZNm5CY3BDdS9Ed0NMM3JiMlgxckR5?=
 =?utf-8?B?UXc3bTRLOGVPMWpFZlp2N3dIOHZjODd6ME92YWY2YjM0VlhDN1ZRaVVsUThj?=
 =?utf-8?B?VGNTdUZKY1FxaEs4OVlwTlBTUTZZcWV5SmduODRvSEdCWmduTUkrN3hoSFd3?=
 =?utf-8?B?RFV4alBVaGRPMXdZc0V3YmFjNDV6bVNPMHhuenFCeUhLSGdzM3NWZVJlSWM3?=
 =?utf-8?B?dVpsTmdDKzVCRkN0aUJmLzhta0lGN3cxbklMTG0xWW5EVFVxVWk1K2tjdFlV?=
 =?utf-8?B?L1RXNDRjdW9sMHdxc2xQdk5oR3FkckpvSFIweGhnRjFYczRRK3lUL2dQemhv?=
 =?utf-8?B?UElOOXhNWkZsUC9GNTNZQ0hGOTFCNnR0YkMyOVlmVjlUaU5ReFN0RFhqSVpG?=
 =?utf-8?B?c3RXMjd6LzZmRDRDUlhPdi8xQ1d2Q3QrblFFYSsxTVNPbjVIeWdkRVpVOEVs?=
 =?utf-8?B?S3hwcFBRSnBxYjZWZ1BCbUJFekprUTdROER2ZDhHU2dBb3RDYUNQcWRpcHJU?=
 =?utf-8?B?QzJUOU52endkSWxFNlhDdURMUXp4VVFabnkxRndpbndMdjRBdVZVc3NLVGd0?=
 =?utf-8?B?RURMd1NkeUpKYWZJYWt4OUdYSVcySDdDWHFXSVZGQ3o2Nkk3ejhzVDJyV0ov?=
 =?utf-8?B?WDRKRC9Mc2Jkd0o3VjdaL0JVSEU4VDFvWWVQSnlvd0tGWmVJYzVyUmJqM3Z3?=
 =?utf-8?B?bkRuNXVnU3QzbE81UW9IdFRpUjFkaktnUDQ5N3NzQUoyZXlBR3RHdVJBOVhT?=
 =?utf-8?B?WHJ5cVFPdmhqNUVsc0tqOVpSazBYOUx1R2pVN3ppSzg1UjBKZmxYNEVrUy9W?=
 =?utf-8?B?b3BBZXlBOWgyYzl0ckt4RFlWNENUK2QxMTlValpvdkYyYmhpem14bDZJRERK?=
 =?utf-8?B?U2tOTGxLTXFSMHA3QjNJaStFakZSOTZUVjNUN0VjT1o0cTA1bkoydlJHZkJC?=
 =?utf-8?B?S21rR2ltVWllR2FNWi9VdnZBOW5ZY3FFcGxhcGI5ZnBSRFZ4bDRzMm1Hd3c3?=
 =?utf-8?Q?GpLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zk9UVk1KTVNHQzhoVEE3SU96RmJ3TUdRcVNCVGlFOHc2eGdLN2ZkTmdkWmR2?=
 =?utf-8?B?Mll6Tzd3Q1BMZVNFMkhzR013eU0zdll5NmN2dFpna3hMQjBiSjFtdDhtQXNs?=
 =?utf-8?B?Z05KTVU3eFhibDl2TndqTGZJUmc0aUFxdmM1akw4NkZFV3BzSjVEcm9wM1F2?=
 =?utf-8?B?WjlIeWxrZGJwZUNIQXhucGx3U2V4dVUyVkVGWi95TFZNVmtMekZwWHhoWDFz?=
 =?utf-8?B?YnBGOHB5bXJrNXFMNnhYbTMrR2krYzY1YyttKzRoYzhxbUVNbWU1enAxNzhP?=
 =?utf-8?B?YjJmMzgzTnBkZENzTUgyMXByblI0c092QS9pdjhLTlRZNEoydzlERUZFalZz?=
 =?utf-8?B?ME5KZURESkI4alhyby9oUTEwZUU4V0FVdTUvODJoTTEwOEdtb09mNU5YS3VN?=
 =?utf-8?B?a0pvK1BYQVBxdUpRS0dLNmxORFRlL2QrWEZ6dVdoYVd6d1FTWEZsRjRhVmhO?=
 =?utf-8?B?Tm41ZStTSTk4UE1jT0NZd2l6NkZxNkRyeXlCYU1VamNMWVY0aDlrSVhkL3ZH?=
 =?utf-8?B?RmdPZW13bHhWZ3BEM0Y1dVpaOXF1UU83Yi9Dd2c1Sk5mWVlPeGZhV0MwR0pW?=
 =?utf-8?B?c1oyc3FzLzI2Rjd2NjZhT2RJYzlpWFEvc3paaUtTSVNpdDY1U2tOWmxzQUtO?=
 =?utf-8?B?bzEybG1VN0gzL2l5Q0RwRyt4UlRMcEFnL1BQNGRDR1M0S3Z6NFhhUm5tclo1?=
 =?utf-8?B?VnlaN2tkWGhvMEx4TnRmaTVROGdaQjREYklpRzBGRWVnK1hKS1Rmcm96TE9G?=
 =?utf-8?B?QVl0K2xzeDZQNkFMQk9Ta0FMYTZWQ3pGMktlMGJma2ZwSGVWRGZwZGJ0S1lV?=
 =?utf-8?B?THh1MDNKeDFzNnFrQ3ZoSjFkSi9QcTlhNFFmdVZZZm1veFFjVUtMSzZQZHV0?=
 =?utf-8?B?UXBhbWVQaUpZYjMxYmkrbU1CWDVpRnhpNGdlelQ3MzAzekxpdnM0cEd1SnRD?=
 =?utf-8?B?eG1IVU90VHVmS3Z3cS96SUJUNEZWQWRQYmlJMEVaQ2NTa0srd0pxS3VnSmtv?=
 =?utf-8?B?bWwyQU1XYzBjSkx2RGcrakxzd0VKbzhZZ1g0Ni9WaC9QQjFJVTcxcTRjVktT?=
 =?utf-8?B?aG5SYkZUZHNvYXVIYjVKdUY4bG9hOFB1ZzZIOXBYK01SMytva1R5SXYyVTdO?=
 =?utf-8?B?Q0Zmb0l2NGF3cDIxQXJyS1E3SytuS2J1eUNsOU8wQVpERExwNmQ4b2s2Z0tN?=
 =?utf-8?B?R2RDc1RVUDl4OXQvam5aQ0NtV3NhQXBkKzdvN2gwQ240c3lJVm5WcHE3TEdC?=
 =?utf-8?B?UHZvTlAvWmNiWmJwaVVnQWw0aWtWY2FZeEhBTDZIT2ZZa3lDQ29TTDQ3endX?=
 =?utf-8?B?ZzlONGdkNWNVOENER2daaU9qS2ZIU1BnM1ROZ3FZVHppaVVMOGxtc3JNY2h0?=
 =?utf-8?B?U2dkQ0YvTG9LK2hZWjRoRGlWNTdScGljOTdUUmcrbTRZakYzSWpsSWh5NVZl?=
 =?utf-8?B?aTFsWG5mc0VnU3o3bFZuMXdpSXQ0bjZWRlZwUTlrcnVMNnZCS3AyMlhWaHkr?=
 =?utf-8?B?WjZIdG9hNnFJQkxQRm5qMTh4Tjk5M1g0Q0lPUUFrcjBicFlxa09zR3ZxbUsy?=
 =?utf-8?B?OVJWM3crV0dyYXp0dG5adnRJL3ZTeWVzRXc4ME5NYXRTUlQ0Qmh2ZEJtVWZo?=
 =?utf-8?B?Tk1remdDUXo1dG1aWnpHUlQ4ZkVuOTVRU3haQkJhUEk3YzNMMG04VjFyL0c1?=
 =?utf-8?B?SjdBZStVZ3lUUXFsMFNuQXgxcU1XQVQ4Qk9wcDhxZmNxMVNZVXBkMUZ4a0pE?=
 =?utf-8?B?Z1M1U2VCRFRtODRsb0k4eWFaUkEzQzUyNUlLWU5tN3B5RzB2QityTklOV3Iz?=
 =?utf-8?B?aVZoNWJHMmtIZXVPaU9ndmZ4YWpmTGZFelYzMmUvTTR1bmtEM1pHOG5lc0ll?=
 =?utf-8?B?TWc1RmpLK1dMY2hORCtpSHFiSFRNZXZ2UE9tRGZnNG1QVG1KTFlLRk9SWVlE?=
 =?utf-8?B?NVllNHVheldvVGZocEMwU0l5NGdJNDBGZUJqajFPYUdNaDR6M2tUazFXa1Bh?=
 =?utf-8?B?OWc3WDZleFVYemNyTmdXSys3R2lmZEozY2ZUT1ZkSnJyU3JjQmdZK0REQlhC?=
 =?utf-8?B?Rk45NkxvWDNpMkFrMW1mNnRQUUdtejZERjg4REpFR3MzTGZUbzlwc2FhNHBE?=
 =?utf-8?B?OUMxMm1zK0tlR2dJUU96UER5OGJ1NU1rMWY1ZmE5QlVnMjh3S0hkeVBTK2RD?=
 =?utf-8?B?aDd4SzB3ZllPRDY2endZSm9jQVRFZzZ1aVpTeG5vK0FCTHFzM0Y3YXllSzFO?=
 =?utf-8?B?c2tIb2Z3blNaMG9jWU1WbjZETWlrYWM1NlJtYlg3akkxTXplTDh3Y0hQMnUz?=
 =?utf-8?Q?o4qMICTDLXhtj7jdnY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4889bc4a-61e1-4c88-5202-08de6330fecb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:32:02.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ24r6wEIBwd1sr0/6V8JZb4AZn0BHGt69gL4qbhCacRi4GBrljw2AAeImHTAt3OJgIezXr92EOyhyIDzZn1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-20837-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,arm.com,linaro.org,lwn.net,infradead.org,amd.com,hisilicon.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: DE60DDAB17
X-Rspamd-Action: no action


On 03/02/26 18:24, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Feb 3, 2026 at 1:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Tue, Feb 3, 2026 at 10:41 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>>>>>> Hi Sumit,
>>>>>>
>>>>>> I am thinking that maybe it is better to call these two sysfs interface
>>>>>> 'min_freq' and 'max_freq' as users read and write khz instead of raw
>>>>>> value.
>>>>> Thanks for the suggestion.
>>>>> Kept min_perf/max_perf to match the CPPC register names
>>>>> (MIN_PERF/MAX_PERF), making it clear to users familiar with
>>>>> CPPC what's being controlled.
>>>>> The kHz unit is documented in the ABI.
>>>>>
>>>>> Thank you,
>>>>> Sumit Gupta
>>>> On my x86 machine with kernel 6.18.5, the kernel is exposing raw values:
>>>>
>>>>> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568
>>>> del:437439724183386
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
>>>> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
>>>>
>>>> It would be surprising for a nearby sysfs interface with very similar
>>>> names to use kHz instead.
>>>>
>>>> Thanks,
>>>>
>>>> Russell Haley
>>> I can rename to either of the below:
>>> - min/max_freq: might be confused with scaling_min/max_freq.
>>> - min/max_perf_freq: keeps the CPPC register association clear.
>>>
>>> Rafael, Any preferences here?
>> On x86 the units in CPPC are not kHz and there is no easy reliable way
>> to convert them to kHz.
>>
>> Everything under /sys/devices/system/cpu/cpu0/acpi_cppc/ needs to be
>> in CPPC units, not kHz (unless, of course, kHz are CPPC units).


In v1 [1], these controls were added under acpi_cppc sysfs.
After discussion, they were moved under cpufreq, and [2] was merged first.
The decision to use frequency scale instead of raw perf was made
for consistency with other cpufreq interfaces as per (v3 [3]).

CPPC units in our case are also not in kHz. The kHz conversion uses the
existing cppc_perf_to_khz()/cppc_khz_to_perf() helpers which are already
used in cppc_cpufreq attributes. So the conversion behavior is consistent
with existing cpufreq interfaces.

[1] 
https://lore.kernel.org/lkml/076c199c-a081-4a7f-956c-f395f4d5e156@nvidia.com/
[2] 
https://lore.kernel.org/all/20250507031941.2812701-1-zhenglifeng1@huawei.com/
[3] 
https://lore.kernel.org/lkml/80e16de0-63e4-4ead-9577-4ebba9b1a02d@nvidia.com/

> That said, the new attributes will show up elsewhere.
>
> So why do you need to add these things in the first place?

Currently there's no sysfs interface to dynamically control the
MIN_PERF/MAX_PERF bounds when using autonomous mode. This helps
users tune power and performance at runtime.

Thank you,
Sumit Gupta



