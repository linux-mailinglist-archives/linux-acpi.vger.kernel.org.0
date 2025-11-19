Return-Path: <linux-acpi+bounces-19058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BDEC6CC34
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0F3C0241F8
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE2304967;
	Wed, 19 Nov 2025 04:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KOFVuKZJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77441274B40;
	Wed, 19 Nov 2025 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527405; cv=fail; b=HAu5U0co1tKGYWqXcik1ix18h0Z5yf6gko9VFzhEjfSZAKHGXO7nJIt0QgJoSzZmPqTxb8WUCzGvWGqallHJDRJvR8fOzmtHEZyPnk2fXDc6pnjpi3bY3goFw68csl9BoY6sbql8PODepSny2W7EGAMDh80I3Qp0SPYcKtBE5S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527405; c=relaxed/simple;
	bh=meIkpRPSSPxRc/CF7nuSG7nwgdC1HwJ2tcBuaYG7S/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b6L+nkMQihd2y2YGjCHjh2lgMRUbF8oMBNPcrLNeOmf8VWD8hrl+N2xkAR9kRcua2iLzzAJSme/0SYaWhcCiclXTQ/qdQ+jUtb0svwAq4ekwTc6bzze/BER94U+FKsYDMa8cpDCmbpClHK5ntqKucxWU2CJJgCW4aY2Z/bfcU64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KOFVuKZJ; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sU2sYg4ofrO3sHyfNStfyvE/eSSiGFzD7s+SLkKBVw0AKtKECO3SKNt2fFVYhAjzkHyEe+59m4h8YF/kRE8DnGD+naNw5NYbC3QWGQYY/eMz9WZPLK442a0z6zndeYkiyiyWj6VbT9T4MBNbMER8FUAtCImNIhsip73BGeZkjQjWQd2jzIdUgTMqM75axX3xWMADXQTbwa4WDH2Np2F0jWSg3Q6s7pn1TuHoSM1JTMbUD5YTJD/mZB7DlbmRR01LlhyO5gN10RjCK0M93UYFPssWiDafHGslxT08I0nArv3JuEqc69gu2pb+Fn1IKAV2qt84d/Dz9oSLTKE8+Oh9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuloGZAySrQajfJtFknr8OdjmauC9Z6UZLTomQH299M=;
 b=vwssY9SjrdT0M+BeFA2j/vbShZMECkJyftQ/YZr6ybDgOeK+lbEdCHv3Z5YGVood7LbRyrb3wlDYWV9wEDIk+EjglVJTif/68wqeCH9BdYc4Um6r+iSfxuKJG3Ry3oSDfmKBuYPFZF9iTe9cRKBASvb7zoXVN5aVpAwQ8eVmXregE1WiNyJWwI6BgcZ17ZKX0yrd1GA5hy2C6vzVxut/bpk8rgfqNoS0SjjK+a+2gRxgVd9NMotnF+HJuFkDbdmPr29q5XNXbIdDquGUsOazm9aWM76Z3mV4QGp/NEqfOAbg8TRMA8CHswMocvpcTcC6bpEFuKRlQ+5iAG7y7wA0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuloGZAySrQajfJtFknr8OdjmauC9Z6UZLTomQH299M=;
 b=KOFVuKZJLdDBnnlXqEzpPky4xMTtEwl0MqDDAQKvPkW/AmsLpcTFckZ8k9aGrqU/yT1STugmvlNqcDSjkIk+eIYEhuFc/WUYZgLGigoFy5y3CCPKiLIWPy1311ytz2fuTjcgO6wKcGDQ+TZ8VlE07ScFlbiYulb1vVpy8BcgL+XPVM6fF3sQO8LgyDFz0AFx+5MEdr/b6upyCl5RDlixDcmaiPphEHxaYiuOuwTxOJFZeMQpHkMkTKBsekwbJMBMZn0w3cYsdaYjBn4Il2fOhtD8XwZnGEowdd37yrK+ji8FKjsvBMcDCMR/r7No2Var+w2zv01L4iP+ypEM2Whhvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 04:43:21 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 19 Nov 2025
 04:43:21 +0000
Message-ID: <374ff89c-046e-4c23-a087-05b20ff758f5@nvidia.com>
Date: Tue, 18 Nov 2025 20:43:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/34] arm_mpam: Track bandwidth counter state for
 power management
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Zeng Heng <zengheng4@huawei.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-28-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-28-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 487fa6d1-9185-47ab-478b-08de27262ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnBJU0tBVTF1Rm5Ca21XUWVKWVVXT0NUb2lISDREN1VXM0N4WlA0c21zWUF4?=
 =?utf-8?B?UVZBdVZTeUtzZjg3aFNtUjRjSUp3WnZScDgraDdiQVhwRnlFYTA0VFhra1pR?=
 =?utf-8?B?ZGRxUHVFa1EwSW5CblRrbTBGZlZlQUdVVGFFRWlTcVRCWmk1dFJEcko4SjFz?=
 =?utf-8?B?Vk13SnlJVUdxQ2JjcVZodytpWG0zOURGWjlLc3ovWGxnY0lvbnAzeUErMU14?=
 =?utf-8?B?VXk5VDhhTlV2dENOSnFtemZWRkZvTnJqSk8wTis5SG52d0JaY1NUMW1ueUJq?=
 =?utf-8?B?eEpnMkdmd25hTHdHZlc1TWNJc25sUW5KdHQ5Tzl3a0g1a3B5ODUrYUZTTThB?=
 =?utf-8?B?aEEzdnJqdHB2SEsvT2pNMDVIdkwyd2REOWM5empaY1dsalBkTW5CN0FabVhH?=
 =?utf-8?B?YTVZUFBoeUVtUkF2QjJwdm9pTU55QmM4U09KT3RmMUJVODYyb29mT0s4Nm9u?=
 =?utf-8?B?YVlRVVRtaWt0OVpBcnpBSkE5NkwvWm9TOEdFbzgvQWtxRzcwQ3E2bVd3dHVW?=
 =?utf-8?B?dytJRFRrd2pYSk1VTWcxTzE4aU9iOWlRUDBZYStZSkxGTTdvSDRocHpCYnB1?=
 =?utf-8?B?VzltMFRjMXRNOVR1NG1xeEx4QkZ2dFFncUJscTlFT0x5Qi9nUnRqaml0OUJN?=
 =?utf-8?B?eFhkVTZpTUswUmxmcnF5V0lHOW5XZWtFQ09IMWxXY1JUOWQ3Z1ZEam04RFlN?=
 =?utf-8?B?NTQ3ZzhyOHRVaEZoNTFPRkVLMExyV3ZXdlpCd3dFV0ZRM0hDU3RYS1dYQVMr?=
 =?utf-8?B?WWE1OXBnSUlKdk0yaG9DM3lWcWtudTZDeGV4cTlQQ1VTZ1ZOOXQ0VWw3VS9v?=
 =?utf-8?B?ak9SZ1Vld3IvN0N4eUxxcStraURIbHFseUMxWkpmS0RIWk9IYTBydHV3cFJQ?=
 =?utf-8?B?R0NvTkpBRTA3WElMcjQxZE9ld3dibGswT1drd2l6ODZnQVBDR0c0SXFhSDhp?=
 =?utf-8?B?SUR4UGFOQW1neUJFaWRQK0REdytpbi9oQ2NMbkttdzZVYnBDUGx1YlQvd0lr?=
 =?utf-8?B?VDRsRU1iM091S0tPbDlwQW9tYi94S3A4c1pVTEtsTThlQ2ltYzBnY1ZIbDQ5?=
 =?utf-8?B?eTFvWm9GS3FZZWYvV0pTWDd4NlYwVWVJalBYL093c1hKczh2NjlCOW9tK0Fw?=
 =?utf-8?B?VzA2Z1AzekJ4b3R4d0RYRmZjOWozREp3MDM5T1pPS3RMZzE2bzRnRCs1dzNV?=
 =?utf-8?B?UTcwZGRESlhuTDRZT0NLbnltQnJHMHBsQzRkZ3I5VHc1UHBsVXd1VVQ1RUtD?=
 =?utf-8?B?THN6UFdiL0JMSmExRnNFcDljeXZEUURzZGx0L3BjMHlaU09tVHk5bERDYmNj?=
 =?utf-8?B?ZHNjZnREU05pbkVWTlZkUzVkR0N0L1l5RzFMOFozbStBWTltNEYrZFdFRXB1?=
 =?utf-8?B?QmxKY2N2V1o2UkMxa0lLV0dkWkgwUEJhakR6TS9WSVVOektad1B1RitJUHdE?=
 =?utf-8?B?UGxFZWZ0cjhTdXdaSUsvenA0dUMvV3l0dW9yN1FxRzJrTmhMaVQ4RFlmaUg0?=
 =?utf-8?B?ZTR1UHpyaFFmTGtkcmFySFRIc3J5NEg0clRwQ3pWd0hFcUhGeGkvb0VaOG9U?=
 =?utf-8?B?TEtQNW9FN2xhdjlqd2tYamZ3eGFXTlVrangxZ0NveTdGSEhBRXhvY21mdFZu?=
 =?utf-8?B?QitNeWhiYlo4Y250cEwzUHZCL3o1R0ppSk5FS0lFM3JlU3hPcEg4elcrMzZs?=
 =?utf-8?B?RHl1MEV2L1htR3VYa3l3SHFldjd4bzUzOFcva1VBWTdid0RaS25IRGpGcUJG?=
 =?utf-8?B?SkFCSXlod2xuR2MzTjEySUJuVjVpL2RwMzZQS0I4bU40TmN1MTBFSm9UcENn?=
 =?utf-8?B?YWd6Q3lXL0pxZUplanRwVllKclJyWlB3TkxJN1Bjc1NVQTQxcVZOSlpJSmND?=
 =?utf-8?B?TlU2c1dDcHA0bFpSY0NXSWo5L3F4MnN0RFg4ZVJ4U0NxVWdrSXNOK1RaYWlp?=
 =?utf-8?Q?8tHRupm6PCAx8wOJpINxLmLXNaeY/x6E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHk4MEkwNVZEOXlsK0hQaFpPOU1sbWMzdmRTeXBDdVNSSWZSeGpuVDliOHdW?=
 =?utf-8?B?eERrbXJYZWFpNHk2azRFTk8wdG5ZWjRxM0FVMlVCVlFic2xySFRGcUxkeDlt?=
 =?utf-8?B?WkpGaDJ3cGJkekVvSWhZZjllS0J2YW1VV1QrQ3VUeERGQUlicXhjZytQMGlm?=
 =?utf-8?B?QU9hYXdmVjcwRFpyTEhVcGVNMHRqMERkVzdaQVB4OUdOczhXR3BEb1lsaGNh?=
 =?utf-8?B?K0xsWEVvaEJJUVJsbnBvU3NLZ1YzZWRldFJvVG5xaVdtZ1lNbm5zbWVjMmhy?=
 =?utf-8?B?T2h6RTFpZW5EVXlwWTVVSGkyblJWRW1DZ0ZsQXpJVDNySXpzNW0reW1oM0lM?=
 =?utf-8?B?NTh1SE0vRU8zQi9TTnd4Tk5UZW5TbmhWYXdVUDl5TWZYMWJQMDV3ZUh0dlRF?=
 =?utf-8?B?Q1Y0SlV0RTNPRnYxMnNCd25jajhvZVEreEI2TjFoc0JiUXVENTl0M1l5K0dQ?=
 =?utf-8?B?R0NubHA3V20vM2ZXdHN3Y2hhdGVOOXlqekIwTEZGaEZzekV2WmY1VnlyVUdp?=
 =?utf-8?B?L25rekU3dXVOYi9WMHFMN0xrN3haQXdJbE9yWmVSY1B0M05SRWdlSEtlWkpH?=
 =?utf-8?B?UURvbnVhZExkeURhVjR5ODhEVGxEUFY2WHIzR3VwTlFzcTJsYUw2alB1WGJa?=
 =?utf-8?B?REMzTGQ0U0ZQZXhvN096VXdnUkU3VlFMM3VBVVpzeDNTMEJrQWNkS2ltTWRu?=
 =?utf-8?B?NDhNc25COEplT1ZJRG1aRnk1Zko3T1hucmZZK1pzazVVcHVTWmNTaVdIVWxZ?=
 =?utf-8?B?NWlVZ25MZGdxeEpjenBLdFVDRVRNcUdVQy84RnRnc2RTUU5rSFJNamhWVTFu?=
 =?utf-8?B?RmNtWG5SYnRpcUxGR09aOWdxZW1hMWRmMTh6V2s1cFFHNlhSMWpKT1Mwdk00?=
 =?utf-8?B?TWorTkZETXliWm5KYktkSUVqZHh2RW00bmtBaHRUNDFKeUdyNGhLQXBiaXJR?=
 =?utf-8?B?VDRkUFpncVorVjNFWjhnV1NTaGZzQzg1KzBuRXZYV0pmVGE0S1JDL3RDZDl2?=
 =?utf-8?B?VlBtYVJINUZuODJOSWJXa2FDZjE4b2hnWmZEQVBaQVNaenFlZFFHQkFnU2g5?=
 =?utf-8?B?Sko5SktTV0hvWkVMMTNVOUMwOFhBU1FVQWMrdW5adlhYVjRjZWJEdEFUR3d1?=
 =?utf-8?B?cU9ZTTZ5VjhqK2FjdzdiSEh2cHRHTEsvNng3MTkzU1VSNENwNWFRRnUvdDR6?=
 =?utf-8?B?dUVORVh0OXVlTGJHbWZyMk5yRWtXejdOczJZMVdGeVoydWl2UDhsV1VMMnZY?=
 =?utf-8?B?ZDlZTytBSDVtaFBxZlROUDhFZUd0cVVXdnBid0wvM3d5Zis3TUR5VGtpMEJD?=
 =?utf-8?B?QnRPR0ZxSFJuYXdWRktPcVZXM0tsN2Z3bStDa3Y0R0R1N0ZyRkdLdWZQL3kr?=
 =?utf-8?B?K1pxbWpjdURCUGt6c0JMcWlZOGM3aWJRQ3JSZlR5ZkZnbDVzRXlsTXlITGxI?=
 =?utf-8?B?R2I2Wjg1K1B2cXVMK3VETW5ldDdMTkpLbHVjc3EwMEs5eHBQN1p3RmdRZmNz?=
 =?utf-8?B?R2dYN1pDNTBWREVBQWpOT1lkM0t3aHVWVmtKWkZUWWtMcjhEWlFEaHRFWDk4?=
 =?utf-8?B?STRjV3plU2pidXk1d3VDamptcDA0cmVBaTNzbkJtNFBkOWp3eThnMFY2eVBI?=
 =?utf-8?B?Qm9tRHRZU0pXaWpVMFhDSXM2ZHJCYXhTTEEwSEVIaWZlMDVtUzlLTDZqNkJz?=
 =?utf-8?B?RHdUck8rc2RtZGswYXdKYlk1OVdKelFXd0ZCOVlJbG9WTDU3eFoyMkJvaUt3?=
 =?utf-8?B?WnMxaWFuOUl1alE4ekRYTXRwYWNhSThURVpOQ2U0b2NHVXFhNGtWNGk2Si95?=
 =?utf-8?B?bThGdkRzZ1o1OVJNeUZJVm5ZQ1JBMzAvSSt6MEhjVnpmOVF3ZDNZR2lTQXVR?=
 =?utf-8?B?cWh0WEtxUGNOOW9jWDF2NjlVVmdXSGFFR3V3M2VKMGM5NTBMaUIzYlp2OUNu?=
 =?utf-8?B?Y1NXQ2ZlWWVoY0I4dGU5SVZZbmJZb1dEaWJUNWY3TVBGMjBuS01WVUp2cUh6?=
 =?utf-8?B?Nk12a3RwVW5Vdm1LcmhtcTZ5ek5ld0N6MTdvRzVxU2ZSbHhhNC8rcWJaR3Vp?=
 =?utf-8?B?Q1V2eE4vYU1kOWJycmM3ekc1YnFTV0p6ekY2S1ZpRm5yVG9KWElaalhsWFdl?=
 =?utf-8?Q?TH4+BwcyXdHFh1SY+qvy/8gBv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487fa6d1-9185-47ab-478b-08de27262ab8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 04:43:21.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPrT0ZUWLlXQCxQ7LNmHOmULQpeROP9VktUR/jII0GW+D1RTSwDqdPCHwC6khSEzJu7hVVn+ShxfzMBLj8t95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399



On 11/17/25 09:00, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> Save the counter state when the hardware is reset due to CPU hotplug.
> Add struct mbwu_state to track the bandwidth counter. Support for
> tracking overflow with the same structure will be added in a
> subsequent commit.
> 
> Cc: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

