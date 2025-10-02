Return-Path: <linux-acpi+bounces-17495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D294BB274C
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 05:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA619C6AA5
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 03:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A9E2DA759;
	Thu,  2 Oct 2025 03:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ViLPRqUm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D411B21BD;
	Thu,  2 Oct 2025 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759377347; cv=fail; b=pCap3XdYSYg8OjtatKw+Kt12smnpEv3ofUXx0iHJtxItP9PzJ8cgSK/OBVgHkRfpEXYEuNJWZY0teL32N8XIFQKIhjPulFj+Gth+J+vYzzC4NI6ZBC8BsLxxDX/5h3mYcYeTsbqD5IthAXspsVgsjpwFq9KXkPGRENwdI+kKIW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759377347; c=relaxed/simple;
	bh=5K7k3cq0aUsgUy3pbRIdndpkWHOcqR+Uo5BfPjCFF6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hhuI8YI9lUMVNc/hKCxTbVk4lX+smP41E6GQM9rov+aeECvixkuoMAzwc+/dWbasn23lOBswByfrGeVS0VH72Tq3GI4n0lUOeUQNY9fTYne6F0WE9G5QU0h6Ig+KOd4oRfZGgisTVK5wQNrQSIAuN0GonVt12Ek1sFgDfoI4tdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ViLPRqUm; arc=fail smtp.client-ip=40.93.195.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gz1gaRq9SlK4R1rhN8kHxuLQuRQYzL1F2MzXYbjHLmmWOvNnZgK9s2VSskqvWKE8Ui764D4+CdS8XqKR/dv4UP2JdJKx31B4k6KHfb9VtY6RfNP3OtVCmaAvTE0hUCiO7idxkTm/jJHVLWCtAnzgRuN2aXoCXIFFcQks6zohm+kMNRnFxLlTf6xI0UTP6YyATzg7/Cxclc6wA3KIG1QeIM5vsBSvw9unlY5ZYfn00hm/2+YAv/zkcUwKDGCM27iCNofJJNFeb2Vxsibm9MnqB2T0Ary0BR964zV6508VkCHT+v9mLLgmBIfu7yGZYaLdDiQin4RVnc8q/67QqWkEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75occNliO452i9JaCTKQp2DR2e3uD+1A2V3SIe+kvro=;
 b=h0LqEPOafT0VvjEVrtipn5NUIX6ynINrCeEMXJavDip5I3ayvNM/cx2v4j1/L7+vJKX4lwpAm0yhQNirdCVzvgLiErtU7sg+ljKouQV/bvSbPfho6aIrG894z9lcanQb+MGkNkZiYMr80wg+KT+6sIuolJhVL1ocGAGxjHic0VrSRyQELAZeRO4hlzQAzKx2hHZL2kgi3Xxl3yN+2RNjCiyI2+DUBOwd3mncGz5bphEC/lbk+P/HqWoDtciwC8HzTjwTUpDSbhpjbsIwjRmDNQYY/1Lu/dx58yrElcWiucoSpV6zY3BjJ81/VBVy6XBBk+TB/8XSl2b9NO7qgAX/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75occNliO452i9JaCTKQp2DR2e3uD+1A2V3SIe+kvro=;
 b=ViLPRqUmowFVdhgSsq4PQk3d+qvFM9FqJNdK4oS8QOPQ6LnAs4zPZiywkEic3Lj+d3tjpGFEACpKvKq5wmKKc+FtltX1NWE/d4MJ0YZB7ZECEcQxd18EYyD05TdFNgygBgqMBNXAUL3fwc2TXK7vQxiK3uMxFNHvEugM+ka+Xbm7noM3geeETSJBxhFqf9BG457YBv/j//pV9JfgffIM/xxqFNPnVxSgFtDSAIcfQ1r+BoJ0vI8G90a3aWMQjq3ldXJzpfa8V+XM8YlSKburlzPKuTOSs1mtne1MtQ83F4AjPjN36i/Ste1qXJW74XYEwnVPJ2biaX7A9QmfOvrRXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 03:55:38 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 03:55:38 +0000
Message-ID: <e05396d8-a3f1-476f-b217-0f0a74e9e08a@nvidia.com>
Date: Wed, 1 Oct 2025 20:55:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/29] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-3-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c577789-b2b9-442a-3a2e-08de01678c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHZPUnh0T2RzblNndUdUSzFiUEJnVDJpVmtaaGdFdC9pdW9FdVRxOEtNaWNX?=
 =?utf-8?B?b1ZDV1FZTElGM1Nna3V3VElLR2dYNFIwZVJYYUhMRFhmTXNvWjdlWHNDcEY3?=
 =?utf-8?B?RE9CckdPbzBXdm5jWlV2MVgxdkVBWEVERGI5M29haU0rbHAyNk5kSlJia0p5?=
 =?utf-8?B?SWJHSjVFVGZFWEw1azVMcDZiVFFGTUUzMlBFMmZlczNZVWIwY2NIZThmbjJj?=
 =?utf-8?B?UTU4Z1pEeDFham8zTFl6MXlodDdOUDdmN3RjZmo2MDFuOE5kRlRDeGhmV0Vx?=
 =?utf-8?B?Q1FGWmliaHNwcUpwN0lDaTNYd1ZOSUdqWk1QT29wMnVUVHdkbisrSnJ2N0x3?=
 =?utf-8?B?Mk9VUGxqZDNSTWttZU13ZW5Sbm5Nenc0d1duZFFoTWw2VXlrSDdsYklwWnBn?=
 =?utf-8?B?elpiV0NwUDN0WEdkemdTNHlGWGNBN0FoSkdiMlVRY0xEOUthM2JEc2JySTFS?=
 =?utf-8?B?M1htekNNWGZPTHZuUjU0MU4waFJEUkhQSitDaXFJVnpWbERReVdJT1g0RDZB?=
 =?utf-8?B?SmR6TGxkc1pkNFE5NnBuQldJZ2wyTGdhd0MxWS96SHdRZkxMMFEzQk1JbE03?=
 =?utf-8?B?TlhRL2pDZnZqcG80cFFYNW80WGNiZFZVV01jSk5STlJheDJ1b2kxYjNOaEIx?=
 =?utf-8?B?VTlsNXVOdGg3YkVNSnFmdkoxMzRCWHVkeUtKQXhaOXBDelZmd3llVE5EQVJK?=
 =?utf-8?B?ZWR2TTdKRUtjSXZBTUdoM09YRVVaWVRUMkluZUhJNENiWFNYb0k1eW5Gb1JK?=
 =?utf-8?B?VkRGd25veW50aUF2eWZBUXdKT3B0VC9ZN25xYWdnYUJOSUtBVzR1RXQyempG?=
 =?utf-8?B?Tm1wV2dQOEdKQVFkNVBvRzRickxqUnNvLzdzSUxITFFhRy8zTHMwRVRiVDdN?=
 =?utf-8?B?eEd1V3JvT3FYSTJlMzdTZHVJYm1iK1hETDhwcDE4OExuTlhXTnAwajdJYTRQ?=
 =?utf-8?B?L2g0U3NWMi95TE11eGltelZ3VngzMUoraGZEQ3BOVzB4cWFmakxEZkI0WjQ2?=
 =?utf-8?B?Wko5bUM3YWIrd0FmRFB2R1llUVRKa1d4WnZqamJBNi9zZWZIOGtEVTg2M1hC?=
 =?utf-8?B?aThMaGlCRDV5WXc4ajZuRVE1SUFHOGc3UEVJTndCVFNYb1ZZa1lyeTRzbGdn?=
 =?utf-8?B?RWFLMkRPekRTQ1NxUFlKaEswUUFTdmk3WkZ3VTRpVEJteHVDZTJFNFFDVDI2?=
 =?utf-8?B?Rng3d0V6QWpaaGhrb2hlREV6WkRhMnc1RWRGS3EvbGJGcDFQelRoSFV0cm4z?=
 =?utf-8?B?TlJUVm9QNnR1WjIxcDNTUjBmU3E4QUJlUWdzVEhGVFR4Q2pJUzdFSTBWaWpS?=
 =?utf-8?B?YUlwT0ZrQk1TUDRuRktFZ2tCbEZiTi9qWWhaT2gvYVpqUUNpUjl5djZ0TzAy?=
 =?utf-8?B?bVR2L0s3RGtEMnQ5UVVkempQbWpobDdjN1ZselNlTzQ0SHlZZmtiZHFGRk0x?=
 =?utf-8?B?NmNETDRyOHdOOTQ2VHUwVmw1UWIwMnpxSy9ZNUZSN0xweGY3MXMvOXRpMFdE?=
 =?utf-8?B?ZWNFa1FYYkFkWGRoR2lyZFgyWXprakZHUjJmRGRoK24wSmJoZVZJZ1V2UXp0?=
 =?utf-8?B?NDhYcTAyZkhsVEpjK1l2OGFnMGcrVGYvbElMMWNadkRhTzhxdmRpR3g4NEts?=
 =?utf-8?B?YnpDSU9JTGpiKytQTFh5VURoRHFHSkkrc2daMDdpcWRNVkYyUzBGMFRnbjdm?=
 =?utf-8?B?ZGdhMXg3enlpZFVWUUJRazFJV0lQR0dpTE42NldNSDBUUnR4Wm85RFJLSkdR?=
 =?utf-8?B?RENmTUd6a0hNS21HZWExbGVxU2JkM2FBc29PbWRFSTBuVzRwOHFlaXhoYmZo?=
 =?utf-8?B?ajRQY0g1NFYwZzZoeXBTWVpJUWphRUVXZGsvMXBDWS85YkNxdFFmME11YkRa?=
 =?utf-8?B?Zy9yNWwvRmlVMFNoWityY2h0cFdFRFRGVWVibS9mTmhrc1VwK0RPQ1RSOXlo?=
 =?utf-8?Q?+AJrSibb9Bm6hj+5eQtRLumbP+JYzb/L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUdIMW8zYllrNFYrU3lleFF0RllwRHRHTjAwQlJKUnR2SHVONTBod1JyRlNm?=
 =?utf-8?B?SnRPUmQ5ek5YeWpFbi8zd0RGNkFRZlFtTnc4TUNJd3AzWUY0R3JrSGUrMFZi?=
 =?utf-8?B?czdqYkhHNDM1QlhoU1M5NWx5Y3F3d0dhU2JrRkdEaTVqU3BLQXdrd29iclVK?=
 =?utf-8?B?dE1XY3luL21HamhuN2xqTVRiOHlRNHBOckxGcW5BWkJPaUd0QmlwRkJKc1Nn?=
 =?utf-8?B?dGF4R3lveFhoM0M3Yk1XQmJTN2J1TXBURWtJSk9SNzV5cXhHbCs0RWhTalpy?=
 =?utf-8?B?K2hQbVlPY3BEb2M0VExWczJOdExGTHUrcnpwRDNVZTUwb3cvSmVUZk1HU1dn?=
 =?utf-8?B?RCtCSUVRYTJMRjBXWnl3WEh2eXp0YW9PcU5kYllxZHVpdjd1WEVSdVVMQW82?=
 =?utf-8?B?TGVLSUNFQUNBNnF1Wi8zaFVPcHc5UFpZTVlGUVVpMDAvR2NEVm9FelpWN25r?=
 =?utf-8?B?MjJuMHc5UUFCeFljaWFoVU15aGFhYzFaZDlSaHZkaysxMDFVbXJVc1gwYUwr?=
 =?utf-8?B?UlB2RmRENjRUSjkwNXVldG10OUZ6WU9yeHdRSG5Ma3F2M0d6amFMaVlPUWVP?=
 =?utf-8?B?OGFvSmxQSWdqbGJDNmZZYVhwMjhYV0ZwbFkwdDEwL0NqQzBXbFR5OU50Ris1?=
 =?utf-8?B?cVF6UlBKWjV6TmxscE4wb1B3MGNzWkhQVzBXYW1URTdlOFRIKzd6RThXVE5R?=
 =?utf-8?B?L21IM2wvaGRnMGVaaDdDOVU2TUthUWtVaWFEOFNKVVB5NlNib2dobTRaY3B4?=
 =?utf-8?B?SzBwS1F1Z0NIY1dNNWRReGFPZWR3QnZkOUUzWEhNZkRoUDhUM1c4cVV2TWpt?=
 =?utf-8?B?R2tmaFk1TVc4bHg3WFJCRWZTR2xnSk1LSlE1ODJXUmdsVHBtTkZ6UmJCb1dF?=
 =?utf-8?B?Nk5XZ3lxV3JnNm9wdy9wV1JiMy9jenhsSnVGdGFoR1ZMeU1mREhyUEx1Vzh1?=
 =?utf-8?B?OHdYUWt3MUVHQm1QcllHcXVnVzBWV09RaVBKREh2cUJnb0VEcEc4ejJ0VUxp?=
 =?utf-8?B?c2tsRVJtTGdiOXFSTXBsaHJJMzVZTUltM3FuN1NGbjRTdmdUaU5oVTYrSzJp?=
 =?utf-8?B?aTNrcnlYUm92WElLMnlLRUVHRlNKblJuekFaYi83elRmcHdDeDJjSGJzYllo?=
 =?utf-8?B?a3lOTGhoc3plOUovT2JIcmZJQUFpVWw2d1NkcWZRWXRBVWhnVTlCQjFkd3Jl?=
 =?utf-8?B?UVRKdUk3Z21idTFCOHpYZnFRRjRQVm9SN2M4bkpCWFN0RVN6bS9SSzNkRTdP?=
 =?utf-8?B?TERnbm43US96UkgyQkwrYmRlNFBTcjRTZytPRGp3dmpxQTNyYlJjQjNnbzRm?=
 =?utf-8?B?M3UwKy9FV0dnZHRLMG9LaXh5ZmtMZnJtdlJZZW13ZktWUXFGbUpKaThvVFpL?=
 =?utf-8?B?RmR5L3FyRkY5Snd3Nk0wME85WnQ5OGYzUTBwNjFXR0t4MGxGTGppbHBDWGNq?=
 =?utf-8?B?VzBiRXppR284S0Npb1B4THBBODhFSEYxeTQxSll1a1JzNFRndXJXWW9IajlP?=
 =?utf-8?B?OWU5NmtnODY0NDRMbUZ6eHFzNTRxRFpPNzk1SnA3Z0FJQ0ViY252YWtkUUtw?=
 =?utf-8?B?Y3pEV3I4bVZna1hOUVI1ekIzNGlaM0UrQmU3TzZvZFJlS1ZJYmZmcVdlNmFq?=
 =?utf-8?B?Z0pJTFdVMkV6bitMQkhrdjg4cDZJTzhtRmhMNWVpdWJ3ZnFhNU9UOHd6TFFR?=
 =?utf-8?B?bXlvRkZrdlYrYmtYSzd0R05jVzViRVF2b3NSdm5Id3FYYXVkd3dNU1NkK01P?=
 =?utf-8?B?c1BwenBHWlBHS0NDTXRHRElJOWpxRUxBZ1VTcXVpdFpacThjbk5tbFpLcVd1?=
 =?utf-8?B?cDh2RStqa3R2TjJLWlpFUHlLUnhaYTFqdTB2bXI5WEphSWtwYU84OWpMbk5l?=
 =?utf-8?B?UnpIRklKc1RNQlFiWkJMT0JQSitRY1J1QlNSd1l1bmw3NThPR2MrV1Z0aEVD?=
 =?utf-8?B?K3NaWTdqWTROYi9BWVVIU2ZrYy8za3VMZ1dhUDQxUytOTGFEaCtKNExUSnE2?=
 =?utf-8?B?SmMyS3dXenlFdWozamlkVFNDVTUrekZkaERjdE0xZDhUOTBEUWt2MEtiR2p2?=
 =?utf-8?B?RHZUT283UkllZmIyREZFMUw1UUlZeVU5V1dXTmR0WGNSUU9PYkcrOTI2b3Y1?=
 =?utf-8?Q?XqPAvQv4nOj3QxEukBJ8PMnAO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c577789-b2b9-442a-3a2e-08de01678c23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 03:55:38.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7szE4APyg3rw0E6ilTNU0DEENB9dhl4T2hP14h4OLCSqzPbwAb02DfWBUtqD8XeLGH8vDRS6mSY5V9seLXgeMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825


On 9/10/25 13:42, James Morse wrote:
> In acpi_count_levels(), the initial value of *levels passed by the
> caller is really an implementation detail of acpi_count_levels(), so it
> is unreasonable to expect the callers of this function to know what to
> pass in for this parameter.  The only sensible initial value is 0,
> which is what the only upstream caller (acpi_get_cache_info()) passes.
>
> Use a local variable for the starting cache level in acpi_count_levels(),
> and pass the result back to the caller via the function return value.
>
> Gid rid of the levels parameter, which has no remaining purpose.
>
> Fix acpi_get_cache_info() to match.
>
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


