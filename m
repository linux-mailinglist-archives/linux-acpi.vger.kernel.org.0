Return-Path: <linux-acpi+bounces-20267-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F5D1B827
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 23:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AC2303C221
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 22:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143983033C1;
	Tue, 13 Jan 2026 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EOF7rI26"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A502D77FE;
	Tue, 13 Jan 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341643; cv=fail; b=SOlLEkaxJVGpCY4StgWB8s5a9sQZQX3xXvrDZwiwkFd1y5KA1QjuxKOvphLectfMJxEXbtkBNwwXC7BmkYG26c70kcWEVCT4RWh6XKjlxGbqfKAshoWzlwQdDC/q8uK6tivZTkBbS1D/JLJioF1c07iFtRbRuiOQHyD+yfk7mWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341643; c=relaxed/simple;
	bh=1d5kb+bbeQY+9u+5fdLsjk/8tq5MMARJlMTUnGcCUoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TpDgV0E2b7QHYdudS3m0OI0euJ1rBf1TMmDQ3/anyh3VDf+vuepPgekj1zraC4KkMne5tyviOaI1RPpOyi1oqtWIigFHfkmEnOoXSLwzemiPpFLQ9mYvA3xpALap4a26bbeOtHgF6MGI2Y0i8Nw4tego+BS3J45rkDFkL5aGhkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EOF7rI26; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Chx83cHCkcUU0jzzijYpABrKyH//02DvGO1pv6O2psgZQF0P915uyY2MZqgmjWMPLg3F90LTE/fUOKD6D7i7yW+NARgtQFHxMafQKLMpFHGMwN1ln3PS7q2AH7UDML8rgG8UBVAeRcKyqanq6e/9gEAQRbJIaZPLe3I85lBcUeGf041HkE4xoTjj7UaNHrnpbUoGo+dCirzkgc/+dYdHR8k6v0dauGWdnF75PmzFzn/RLEvLc6E1wU42NaB+BM+N7Fwbz8GMiYemROMSc5dp+TOSMqJQfeB6rGHmHGvVO9Uloif8/ZNFBQGwQZUcIGLuN9rqVyzjQbRapH2T/SP99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY83cLsFO+cfVE1paseU4IoGBTBJwn+GWAqc3IlRTYw=;
 b=nk97oH27cWmFG9YyWUHlBAhFRRX4GaFCh8GtAtnmzFcBU5+CE6qNp+hNfiUfAA6cI7bSsoFGuSRKe4K5Y8OqQX0LiVHZak4IBD+glJcjrvhOcOGz0mBlAmBflYI1thxxJ3sNaJ/WXFqCNVFR3zk3LBsyryfKZQ4ebPRHRxTXEtw2zeVT2xFJR/li19d1H8CNZwGKqhZs+3ObyJtGlHVI65ZL7gc7WolQdZ33H4ij/1rCNld10tRdrc4Hrgerir7taSmexahdgOpQPrNeL73aC988RyXMOGIe5sD1qbVKstBLqUvVA2XGtClIP1H9soXrxTBxpYWCfRcOGUNK1SwHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY83cLsFO+cfVE1paseU4IoGBTBJwn+GWAqc3IlRTYw=;
 b=EOF7rI26RpUOpLuogFn6bdKq4pNOL2uKt5ISODRZdnA6OS9PMyL3cs1f0a1GVAQkJ6oHl+2QHjov97Ae5GaCIxtsP/dgpILeqyd6qDyYW3w9XrErXyb9hG/psSbKIqQvn4J/5fnEBbzBH92NeyvL9EbvKYpGWGeXKIvSST/Obws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 22:00:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 22:00:38 +0000
Message-ID: <bd1c4616-d8ad-4fbc-bd90-2e56996d0f5a@amd.com>
Date: Tue, 13 Jan 2026 16:00:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Add module parameter for LPS0
 constraints checking
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2827214.mvXUDI8C0e@rafael.j.wysocki>
 <757e7800-c45f-4d65-a7f5-9b158660277a@amd.com>
 <CAJZ5v0gwAXU1MdiffgHz8bYJotrJEujwc14D9Dh1rAX0pE9Q_A@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gwAXU1MdiffgHz8bYJotrJEujwc14D9Dh1rAX0pE9Q_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df973d3-12d4-40f2-9e83-08de52ef2fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjh0eG4rRjc2ODUrVHJ6cHJER0FoQUZDSVdBeW1BQktTZjArZ09SM1RSU1dK?=
 =?utf-8?B?a3I2ZmtodmQwckM5U2x6WW4waWZsYXBpY1J2QmM5b25NV2tGRlR1VDRFd3Jz?=
 =?utf-8?B?L0pmWTRYUGU2bXh4N0xZZ3A0M08yT1pMNittN2JoODdqcEhDRjlMWnlDN3Ft?=
 =?utf-8?B?ckNvYnlaRnUrUG1QemlaemVWWlRROXpicFE2RTU3SS8reXFCeUc2WHhEVEkx?=
 =?utf-8?B?ejJseTh5SndsYk1JTGtZUUMwZzQ5cURUMXFvUG4vY0lVd2cvZEVKanRieWRx?=
 =?utf-8?B?STQwMVpqUTFSQVJCMFYwZkxoRUVaQU05MEdvaXFIN2wyUlZWOUEyRm9reW96?=
 =?utf-8?B?aXg5V3hpdUlObjFJb1RYT1YyaUpsdmpackpwSFd1TW5Dd1RTRFZ2R2ZRaUFs?=
 =?utf-8?B?dDV4My8xem83cjVxdXBVSEMzSGhMMEo4RlhXc3JGSC8zdXVCMm1DSXIyVldT?=
 =?utf-8?B?enhBWlUwN05zMm5nNHYzMVpGTG1TQ29mTmIvTjB1UGxaV0IwMEJFNXZWcDRn?=
 =?utf-8?B?eWZjVXlpQXVNWTdyYnlIZkF5WVhKMURGRUNqcTlBaCt2OVFEU0cvUlNZVDd0?=
 =?utf-8?B?NWlDUHhxVXVCVDFETWdZVGdHSE9pRVNkR1JTa1BRR0V6UXZJYUV5NTRGMzhS?=
 =?utf-8?B?SWNCOWg3WXRWU2p0bGt1NExvUEpPaFpGendqRUpRQ2lhL0czU2s1REhJaGs2?=
 =?utf-8?B?YXZaVSs3U0NkSzh0MS9RZU9uRTExKzF4cDJBaVhHVFcrVGt0bG4veFM1clhY?=
 =?utf-8?B?RG1JZUZ2aFgwNXFUZXppclR0QjhzZjl0dFhadVNuZkMzeEowY3ErVVNIaDY4?=
 =?utf-8?B?T1E5bDFuNi9Ic2UwU1htVXNCMDI2Sys0YzBrTmlZOUI5OGY3T1BMS2VsbEMz?=
 =?utf-8?B?Uk54Wm1QengwcFRjVkhpU281NE5wYWlIZzc5alBDMEJzUWJJU2RvWjBJdEZZ?=
 =?utf-8?B?MXBtSDc3Z0FHRnBSNjZkTkw3dmtyK2hLYXpzWTVra09uMDlkTTRIR0Q3ZUxL?=
 =?utf-8?B?cC9hWTZmcHJKM0cyOFNFcmR4bEswekkrRUFMVExQMS96bEQ1OVhYOHY1RDlj?=
 =?utf-8?B?Y0dFVnAzeHF3SlJOOWd5N1B6dkY5elZNd2Nhc2FnNmpHSW5xSnNwZEx1d1A2?=
 =?utf-8?B?eE9ScTlBdFludVlDbmZSUXpKVUl6WGdGUzUyRTE1eGlEV1pnazhjTkNxaGNx?=
 =?utf-8?B?QzRLaTdwcTRmeUp6VERUWFdyT0hjSzQ5a29jbXlxSm9uWlZrZ3gvdVdlSU9B?=
 =?utf-8?B?ZFFtR1NDRk9ZajVZcDJyNGhlS1JGSGZhZWpDK1lXVzl1RHZuOHdSTFRPTWhs?=
 =?utf-8?B?eFhPYU9uam5oR2x6dkRsODREMmIyeW9FSlZoWkJmVHJ0d3l5RGNWWDRrZWRT?=
 =?utf-8?B?ZnJRZE01Y1M1dDZpbDlBT21NaTNBNHQyZFZ0TWVsdXFKd3c3MWpodWIwSDhH?=
 =?utf-8?B?VFNjM01LSU41Rllad05rZVZ3MGg4MVgrNlBpMDAvS1pGNnRCQ09DV2tvb1lz?=
 =?utf-8?B?VlZMSXNFbWVMV0RLcU5Md3BsQUFBay9sWUZUQkVBVkRrbW5MamJIK0V2RmMv?=
 =?utf-8?B?d3B5MEphUEhSdkFISDVxY0ZIVnlkUDVQRkw5SllqVWd5akkzTHBUV3BkNGNB?=
 =?utf-8?B?bEdSOHU4ZkJiZDNyNmdHb1o1elc3MndEbnlrbDhOQVBsY3htS1U0Mm9aYTVX?=
 =?utf-8?B?bXZQcWVYRmVML1A4RWxRRFdEOUxEMUdVVWhXZ2luaC9EQm9JZjBCN1B4QWN0?=
 =?utf-8?B?cjdsdEdMQ3pmaDk5Q3pkVTRSNWZOMHZIYy9ySlFvRXNUc3hyZjBGMEVWSzZO?=
 =?utf-8?B?aERsbkJPcldOb0h1dUI4UUgvcHczUC9MMkFBR3k5b2xTSjVaR0ZWUm1OMjZL?=
 =?utf-8?B?LzIvTnZYLzlaOUgranN6bDluQnNVZmloTVpwbmFUUzRUdFU4bkoxTFYvMmYr?=
 =?utf-8?Q?tx/qSsifXXsf0hHJTVJEVn9KzoQ4e1RJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3pOYjdxZzVuazlpS2RaS1J0bVRoNlpoRVpGaXREenpDYXhTVXlMczdxM1lT?=
 =?utf-8?B?OGZSV1lLbm0xY1pnU1owa1U4d1BpWWF0VkdWU0RKVVN4WjQ1cWVYNkpDU3M3?=
 =?utf-8?B?eVphdm5RNFQ0cVMwYXZEQUYvK0NjMlpSNmt0Vy9KZEtKK2lNN3NyVWRiYyt4?=
 =?utf-8?B?MjZBeWRpSnNZSS9tQ3QxZnBvaVIyaHp5aXkrNGs2Q2ZBdVNoek5QQk5lTHBF?=
 =?utf-8?B?TmJDYktDUVBua2lnMTMrQnVpN01XQ0NLOFd0NVUvcXpocTVpR3Zxa2hkcFB6?=
 =?utf-8?B?QXBPd0x1NkF3cVFSZjZQK3QyZWI3bDZ0UUJUbzdlSGdKYzhBS29UZHJkU0dN?=
 =?utf-8?B?QkJyMU9XTWMvcUFocytrVWJEaEo0Q2RKNDVSU1crbm56K2s1ZFROTnplUnRV?=
 =?utf-8?B?NGsrZkdFZ0VYL0JreXJTZUhoR0Y4YklHZkFVV21sY0xVQlNxeTlUV1VOR2Ja?=
 =?utf-8?B?L3ZMY1pla3ZkZnFNR3NyenQyVkpBQTd1ZHMrakxUbFBLVlo0b2xWRVdWaDRr?=
 =?utf-8?B?YWJrWHNEZFFab1NLdC9yRXVhdGdKckNhMzJrV1dmWHRCRzdyUGFuelIvTEMw?=
 =?utf-8?B?RVZSaGgxV2s5SDZrY3FvaGJyL0o0dWdtU0pEWjhoTzROTUpuME83ZEx3ZEt1?=
 =?utf-8?B?aFR0ZDZVeVBROVkxQWlobXZNckxUSXlDcmpsTFBoSGdMcURrcnl1OU5DQTl6?=
 =?utf-8?B?TjFNcFpWWG9ONjJvYjVReE9WZ2xXZnRBWTB5aExaMGtVVkM5OGRIckkyUmxj?=
 =?utf-8?B?T2JHUGtvNE5lTmEwb21pRCtwQ2dPVTNadVN6Zitnam1mZFNHV2FyWTRRZlgy?=
 =?utf-8?B?eWdSajRIVTFrdTdsM3dzUlFpMWd3enlaOE9EZEFhQUFodWZHUGR4WGE5VmNC?=
 =?utf-8?B?MVVBbGZXWUpXNG5VWlJvdjArc0tvRGVpMzhsQ2JMZTVGRitrSXl6M2xQVmJn?=
 =?utf-8?B?YlJCenRMYTFuT3NCWE1FT1B2ZXBBUmNJQy9sSzRZRXZMWk1ydTM5ZTJTa21q?=
 =?utf-8?B?Uk5laUVmNmtmQ3VXSGZ4bmF1UUsvZWlqRVNxaFVaYS9UMHlyRG9wMiszOWMz?=
 =?utf-8?B?U0tUTW96L2V5R0N1blVXUHIxcGdVaWVBMzljYWYrb3BheUxzSCtka1kvRkRI?=
 =?utf-8?B?TW5BNnlySGhXUFVrY3J3SHFlNEhWV3h5bGM2TGFzSDJBb2llWnZ3VVNRL2ti?=
 =?utf-8?B?UXRTWGNoN2wvREdzMHduMWFibkhrbE5rTnlEckwxUytNRTJUK1c5d3VaaFRG?=
 =?utf-8?B?RUdYZlZlTmhwQzVPckY0aWlxa1JkK3l5S1RlT0FraEpHTk5uRlQwTEZtelFD?=
 =?utf-8?B?RUt6TEFuL3BCVE5keHFjZVk4QVRpSDRTdGthVjZTMkYzZzlVZTJtTCtaN0RX?=
 =?utf-8?B?L2JLSVBibURHeUo3Qzd2VWdiMXhuK0lCbTZBL3ZleWE2OFJuWkk5ZmszY2Z6?=
 =?utf-8?B?MG5aRmgzMFNaanFTK2RNOVJjSmNmRW5TQWhIN1hPNGlJUkRMbHM3dStHYk1z?=
 =?utf-8?B?Y0owY2FzUW96UDJBSEZ3SFBsNm5kcUJTU2pVN0lSK1VibWpiWE5aSXNHNmtN?=
 =?utf-8?B?U1IycGxFZTdiNEZTRTcvaVAzZVpzUjZ1eXpPVjlGWGJqbmJIQW5zdGdIM1Nw?=
 =?utf-8?B?SzV6WllzWGp1Z3FUU1VKVGF3aEc4UENRSjRrMUtyTUlRMjFHMk11Q2hPMG93?=
 =?utf-8?B?WHFSQVFFRXpEbFpTNkt0UGt2Y0xTYnlsYnhVUi9LbnRWYlBsdFQyY0pXNEpw?=
 =?utf-8?B?RkdsZ3ltTktDbVpuYUphWkhhaEcrQUVMdTZTQWc0L3RMVmNObWpNeGlHQ0J1?=
 =?utf-8?B?L3lBQlVPLzRIV0NiVDAwMnZMQmpUSFlFUmkyTGhMbUhTMDQ5Uzl5cG9CRk03?=
 =?utf-8?B?OEtQYVJNTXdpb05XMnJPL1U0eWFTZVNlMlI5SFFIa05xcW91NkhuYXBBSjBr?=
 =?utf-8?B?UHIxdDJ6MnJZU1dObVkvcUtxTWRBZUlJc0psWVczeXg5OFIvQmFFVkVKRThn?=
 =?utf-8?B?elFPTUFGSVRSOXFxcHRnYkVNYlZQUU94aU9ESnJROWxvMG9NVXMzQ1lhRmZR?=
 =?utf-8?B?czFiajk0dlVPbTdqQ0hEZHNqWmVsQmtOMEo2RFpUZW1TeDZOaE92OFJib2o3?=
 =?utf-8?B?TDB6bHU1KzlWUG1pdHk1R0RVRUNzWnRpcHN3QUxMeCtEQW5DTHdwbFdqYTBJ?=
 =?utf-8?B?dXlydS8rYTlMMXY0NW9hOFIyL00wNGRxcFhlcVlXL25QM250Sm5MUktKemxn?=
 =?utf-8?B?Z1Q5M3pxYXgxd1JJUm9nN3N3Zk1ma1RLL2NMVGZJaU5uczdybGZKZW13M1NS?=
 =?utf-8?B?UjhoRnVBd2lZRG1vM3l1dE5XSnJiYW1mVW0vZmpkVEVDcTJGNjdVUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df973d3-12d4-40f2-9e83-08de52ef2fa3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:00:38.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TphGFluXdEnLS1aSALYmnqqmwI7zEvxmoQ2fhvI/rT89ZVNHcS84V5VvNLw3if4AHMv3CfilMSAZ6+61CEZNwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781



On 1/13/2026 3:57 PM, Rafael J. Wysocki wrote:
> On Tue, Jan 13, 2026 at 10:48 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> On 1/13/2026 7:36 AM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Commit 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when
>>> needed") attempted to avoid useless evaluation of LPS0 _DSM Function 1
>>> in lps0_device_attach() because pm_debug_messages_on might never be set
>>> (and that is the case on production systems most of the time), but it
>>> turns out that LPS0 _DSM Function 1 is generally problematic on some
>>> platforms and causes suspend issues to occur when pm_debug_messages_on
>>> is set now.
>>
>> Any ideas why it's causing problems?  AML doing something it shouldn't?
> 
> It's not a clear AML bug AFAICS.  Rather, it seems to have
> dependencies on something that is not ready when it is evaluated, so
> an ordering issue or similar.

Ah I see.

> 
>>>
>>> In Linux, LPS0 _DSM Function 1 is only useful for diagnostics and only
>>> in the cases when the system does not reach the deepest platform idle
>>> state during suspend-to-idle for some reason.  If such diagnostics is
>>> not necessary, evaluating it is a loss of time, so using it along with
>>> the other pm_debug_messages_on diagnostics is questionable because the
>>> latter is expected to be suitable for collecting debug information even
>>> during production use of system suspend.
>>>
>>> For this reason, add a module parameter called check_lps0_constraints
>>> to control whether or not the list of LPS0 constraints will be checked
>>> in acpi_s2idle_prepare_late_lps0() and so whether or not to evaluate
>>> LPS0 _DSM Function 1 (once) in acpi_s2idle_begin_lps0().
>>>
>>> Fixes: 32ece31db4df ("ACPI: PM: s2idle: Only retrieve constraints when needed")
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>    drivers/acpi/x86/s2idle.c |    8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> --- a/drivers/acpi/x86/s2idle.c
>>> +++ b/drivers/acpi/x86/s2idle.c
>>> @@ -28,6 +28,10 @@ static bool sleep_no_lps0 __read_mostly;
>>>    module_param(sleep_no_lps0, bool, 0644);
>>>    MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
>>>
>>> +static bool check_lps0_constraints __read_mostly;
>>> +module_param(check_lps0_constraints, bool, 0644);
>>> +MODULE_PARM_DESC(check_lps0_constraints, "Check LPS0 device constraints");
>>
>> I'm personally not really a fan of another module parameter for
>> debugging.  I know some other subsystem maintainers are very anti-module
>> parameters too.
>>
>> I did like having /sys/power/pm_debug_messages able to be a one stop
>> shop for debugging messages at runtime.
> 
> Well, this is not just debug messages, rather a whole debug facility
> enabled via pm_debug_messages, which is kind of confusing.

Good point.

> 
>> So I had another idea I wanted to throw around.  What if instead we had
>> a file /sys/kernel/debug/x86/lps0_constraints?
> 
> Then you cannot use this without debugfs.

I mean; yeah.  But it really is debugging and most distros have debugfs 
enabled by default these days don't they?

> 
>> If the file is never accessed never evaluate constraints.  If you read
>> it once then you can get a dump of all the current constraints and any
>> future suspends during that boot will also include constraints in the
>> logs (IE call lpi_check_constraints()).
> 
> So if it is not in debugfs, it would need to be in sysfs and then I
> don't see much difference between it and a module param, honestly.
> 
> I actually prefer the latter because it uses an existing infra.

I agree if debugfs is decided to be out sysfs and module parameter are 
equal footing and then this patch makes sense.


