Return-Path: <linux-acpi+bounces-20069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A65D03430
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 15:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAC45303BC07
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75B4F1060;
	Thu,  8 Jan 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sUyTwtq8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534AD4EEF5E;
	Thu,  8 Jan 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881108; cv=fail; b=MufPydzmUCzHsNL/jpaSbYt85bBubHiO/iAe88rw+MHLk4m7hLcB2FxxZ16zw5DqBi0Hii/jvt1aG0RPtbCA5jG33e/N+ztK1aWg2ixZ4MEVSKB9LIt8ZE02Fai/AaepBHvb5xl43ls1jNAgeY5+yOwVez283z9VEdFACG0w8Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881108; c=relaxed/simple;
	bh=yjFosxzaEv3DxFsNBBiVZ4SQrN/QJyPmvPrfdLhLLBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jHlimTtKM4FqoTM27XVsDYlJHUFQ0nyX8VWvB1YEjOg/2d+UpiCrjnddJDlTI+ulErNJH8IRJWTo1AwHZt9qcNI6fNfqlZPqBx4f3Xi2+TEBEAnrRxmDCcx8IiDWf9JUtdwbiGisXZVXbXUF/4xcGXI5a5SFT8uHhLTJ0u+o2oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sUyTwtq8; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFMoyjYLrHQLvlk1zUCWhMa9jPZlhyGn4OksfAMiESE32kR2SRf6xrfBCCEnSlZuvZ7QnYZdoWWaqUHzmBF1aGfEbIX5yNvGemib2ZBymI4Nn03Ed9v9jEjIB5TkhCSHk9I+r2vYFVDx0x6WcBvC1PMSh+wZGcDLnRYgAAMguFulWTErs7/P9J8Nv9wf0DC/5jbuu31EBd+Q8wyG9088aC1wliOOV83FAeZj9USPrp8ywGPERqcv+9gIHxhG39OhK/GQ5rXrgFk5cKDSCOq6lgAW5Zqn0qyshqzaN8urIgO4C18wAxSmgKvYkqX3K5hEgCM9VW/+gccYcxvVNxYvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX5bZbjLcxyJgbN4YhDYL5RyiputAbCR7L0HFeOhw0M=;
 b=CPAOJTZZeyQENKcWt5ynNs0+oMTf8brfUs9+cj0jRtCw1eviFhDBgpbUbAk386WAzAAlsLI0mQm+pqNxihHkle1mrXnyG+InRpm+VBhDVhLpFwLWD2sbmJFIEHiAwzJmzKWAjY9KLGW2oPCPL1AvQ4ZVSYL5k77I57RrN/1vEvo0dSkGPc3hWIDC/5fTTiIS1WsyrsPz87j+c4nctbA06rjcyJwkdKpH8uObneE6cTFpXjUU3jZScXaAEPPspynA51xdf8pxoSuwdRuid52NepeKsmsXvJqEXbeoBw/KRiavZ9pUlnuluX29m3PwzAf5sYlUelK4jikSTEtKDj/PBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX5bZbjLcxyJgbN4YhDYL5RyiputAbCR7L0HFeOhw0M=;
 b=sUyTwtq8C7LIF+tqJZHSBk3I03cET1Uhd+9G0g8BMEt0mBeYXba46bvalI2B2IlH4fH0WCnCxpUrqG7mUZwlES7j3AaeXfpfacK9kkT/JNA9XIK3wTJE8YGgsivMQOBdypOkz4k+9UWiBNFiTR1MLhMdf99h4O2cfqElGx42xE2NGpc/cnzxC7HYMT2UGxrzuETyVHbf08aomMNQnjh6kaNSeK9cahsONco6SFIbNWU1skq4csmRd3OQJhcjTe+R2samQUrmlCJaQcSB+0LUwWFpuLxXDCTBcyygE87Ed/lbXgxcu+u5VwYAOGhMpeYtrugSNPnY6OEB6B4KXqvv2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:05:03 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 14:05:03 +0000
Message-ID: <2b059212-0fc7-4bb1-a759-11ea24b58906@nvidia.com>
Date: Thu, 8 Jan 2026 19:34:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] cpufreq: CPPC: add autonomous mode boot
 parameter support
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-12-sumitg@nvidia.com>
 <3887747b-214e-45e5-9f85-d4e20a5e2e68@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <3887747b-214e-45e5-9f85-d4e20a5e2e68@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcf4891-fd7c-4fea-67da-08de4ebeeaeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2lQRmFFVUQ2NnByMmJmeFBWaTFkMkVhZWdOV3JkdWJNMUMxRnBSaWd5b1h1?=
 =?utf-8?B?WVNhMkRXeklxM0tYQmUvMk1YZlVhVGVqd1k3ZTlRaFdKRkpUVXplOXBWSDJ4?=
 =?utf-8?B?Z0NUV2tvQ0t3aFo3UUlBa1A2bUpxUDdmSXdidzBiZGREaTB4SmZPY2FMWEZE?=
 =?utf-8?B?VlMvOHpEY1Iwa3BNazlURmVDOTg5RUVkc3QycStsNzZMUC8ycm8xaFhmMDBS?=
 =?utf-8?B?SSs2UGRjSnd6SGwzSEZVUGlqbENVUzZDTitXZy9McDV0Y25JRHd6OTNudWNy?=
 =?utf-8?B?OXhTK042Rlp4dDRIR0huZzJnbGc4THpaVTNlWlAvR3QvVUp3V0JVK2FjQ1p5?=
 =?utf-8?B?L0dxODNMcURoVVMzalFGbzVxVGUxZ2RmRDh0NS9pb3FnVncrdnR6cXVZRnFo?=
 =?utf-8?B?MUluTGc1MDY2UUJ1d3cxeUN2N3JkVzRIUnA0UFNOb0RvSzBMK0RuRlRLSHp6?=
 =?utf-8?B?WXh5UlRiajg1VHBBV1Z4RkNUQ1hFUDZzMnFGMHBFWDRjZ0FwL1FLVW1mSnZ1?=
 =?utf-8?B?V2d4cmtPa1BvaXZCNS9rVmJpTGJCdWZDa1cyMzZ0NDlPTnVPZHVjSW8zRCs4?=
 =?utf-8?B?ZlNKTjZSRGZDTUgvbE1nNThWMVVEK2R4UnBFZ2R2cVJ1UVBUQnpxQ0hTdWJj?=
 =?utf-8?B?V0JObjQ4K2Z4VmMxZHRZd3FTZTBPRUV1eHUzaUFGTUVqZXllT2xrcjUxbCta?=
 =?utf-8?B?eUlZVG1UZDM4dVM5TWozZG5qWHByQU1wUCtJNVNRVXp6MlNucldIWlF3M1Nj?=
 =?utf-8?B?UnR1M2xFZnZSQzNQaWFRcnBoTjNQMzRPdDFSSzlnd3lTUjgrWlM2c1ZGOWc5?=
 =?utf-8?B?Zk5POFczUjNnSHVoQTdLQTQxL2NYc3lqVWIxOWlDQjVzTXNUbnJUdk5JNDNz?=
 =?utf-8?B?UGlzMHVGM3JEVGlzaGRMdHJMN3FpYkkyNzNDbzRUSGFMRjFTL0lZbTJ2S2dE?=
 =?utf-8?B?b05zbEsreml4VXlVMzU0NUpGOEZFRktNMlUyVVVkam5vUFBKemE5VU9XRUZh?=
 =?utf-8?B?MC9wQ0xNZzMzanNGSDFzR1lTS29QeFZvRElBdTY2R0ViZDFjcEdUd2w1WS83?=
 =?utf-8?B?YjFKb1Q2TU9ZbHNWMXlpenBRb1p0cXM1NU5nb1JQK0x4TjI2cHY0OHlKZ09s?=
 =?utf-8?B?Wk5TQmhTbFJxRGdGd3BHVmgvdGo1SElXZHBjRUpzaXZtQXJVWXlBMmQ5MlIx?=
 =?utf-8?B?bmZjWnlSNy9IZ2dNbzEwU05mVWVKWWx4UWNrbk9oM2J4Y1NxeXVVbEl6eWsw?=
 =?utf-8?B?UlZQdFpPNk4yWFhtcDUycGszd1MwUlo2NXJPUUd5QnJXSEFuTDRwSzZLMm50?=
 =?utf-8?B?djNjRUJCZXFQZURkczJYUkp1ek51NDJPSk5FRmtnM0w1MnpzZkRnclpoWmxI?=
 =?utf-8?B?aUZRNlJETGhqUEhCeWNwaTRBLy85Q2x4d0JpNVBBS2ZjZHhZR1QvUTVXeHhK?=
 =?utf-8?B?NndqNG93a3JvalpvdEE5TXJHYTBCUnNqNzRNUDhCOFBmZGtTaUI4bHRjRXFt?=
 =?utf-8?B?SEJyRmtOMkl0SDlKaCtIaXdFcXA4NWZSNHJhd1Rrb3pWSGlxTW50Q2x2N0VV?=
 =?utf-8?B?ZTVTS3hJZW5OTkVwRHZwd2ZDNTBENFU5VklhNEp6aDFVcjNYTFpSZWg1VERP?=
 =?utf-8?B?ZU1nb3NENWljZ3ZEY29oUWdTSkJDdTBLYlRIeCtGQ0R4TmZjc0JudWRpTjc1?=
 =?utf-8?B?dnRrTmhCZS82NVBSL0dLVWJTNEE0VHlyMThQckZ2aVhtSm51UEEyZnMwemRq?=
 =?utf-8?B?TFlTRHh3RVE2dERZaldrYnJTQzV6STdlYnF4REVCU1ZCTUxxOHh5cEZSNjVw?=
 =?utf-8?B?YUVCUW9jTVJvYW9veCtQMjIwaXEzT1NDbkJJWTc5OHBzbFp1Rk1za3NjdUsr?=
 =?utf-8?B?R0VWMC9LcmpTM0J0UE91WDNoMkpCYUxIUTZBaHJVYUNaTC9McHUrSkhpTUZv?=
 =?utf-8?B?VjBuY0pPYkR0dmhkUzZiRk12SkRCQW1HMG1SY2p3bVlQZ1V0ZGNkNVhsdEhD?=
 =?utf-8?Q?V+8UfT5BmkMAYrzdBeshaPbTw1rfx0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTFxcm9wL1dIT0gxdnR5TTBXRGlZemhweHVVc0V3cTFpYjZOM2dJYWt6Z3NH?=
 =?utf-8?B?eVAydXdQaWRKeXdhMG9heUZQRGUyU0kxODZFNzROMnpqQzNMbW5nS1hyZFhX?=
 =?utf-8?B?Z3ZJUnJjS3JFM0VDdEs2dEdCWEt0dVVRejRqMzJIUHBmTHJudExYc1dwWmZa?=
 =?utf-8?B?ZFc5enB0R2ZRR3RtYWlQeDZ4Qnp4RnBnbGRwR1RXeGFBZm9oMmp2b1drbnd3?=
 =?utf-8?B?bVhBVEI5SlhCSTIrYnlGWkttcVpHNzFtVEVleGoxcDJzQzRHWTZic1JxbDNr?=
 =?utf-8?B?V1ljWFBkeWFxcWliOExlWkxoUmxwRUVYaCt2cXY2aXlIR1N5VVpRSUx1czQy?=
 =?utf-8?B?TzQrZkltbmp0QXhtSkJSSXRJVHc0SGRXOGpzU1ZlTUc2MFM2dERTYmFMQmth?=
 =?utf-8?B?RnJZMGZpVnlyMUMzTlpCa1FSMnRXbmRzZW05YkRJM1gzMjk1RjVWSVF5YVNT?=
 =?utf-8?B?UGNER2JKWGNBTk5LK25zZStFdGhac0lRelI1YTlTaDA1UlVDS3dGL20yWFV1?=
 =?utf-8?B?d09pZWVNb3pFQWtJV09rRmFzRlZVMU1Bc3hHZDdpWS9COE9TdDZHRW9GQ3Bj?=
 =?utf-8?B?Rm5Fd2VaNC9NbDZhTWEySG5YRGt2V1dUNE82dElESU5WV0huRFFHeTdncWVa?=
 =?utf-8?B?eHJ0Q1dsMEswMFp6VTBWQnluelVzR2hlS3FSTStjVkhjODBNeTQzdmFubDNr?=
 =?utf-8?B?QzB2MnZoeWI4UDd2TVdhNjNxV3pGcndBZW1GRTY1cEMrQ0hEQkRENGo0czBv?=
 =?utf-8?B?TVpFK3M5bldtRHU0SHBFZlgzTVNzZ1N2Rm5XeElBTkM4MXNWZy9UV1VRYXZD?=
 =?utf-8?B?WVV5ZTIrR1c3QWtNQkZnRzdPZFVMQmJOWkxIem5WOTFDZVFEdlNvQXl1NFlQ?=
 =?utf-8?B?ZVIzL3RJeE9BYzloYXFNMGQzSG1lSGZtTnpmZElETXZTWHF5ZnJyTW4rRWRh?=
 =?utf-8?B?UUlrMmhXdjBaMDVuZUtaczVTcjN3Kzc5TFAyVlkxMHlkcVBESVI2UlJMYkYx?=
 =?utf-8?B?TmJOVnQzSGFRWEVOK2JQczh4TzFJOVJGSU5mRmxCQUd0T1NGeWIwdjNSNk0x?=
 =?utf-8?B?NTI4cENzMEZBVklUSWh1RVpwWjdlUVhZc2Nrb2pnQ1VlVCtMVDN5T25JeE13?=
 =?utf-8?B?MVlWczhnSUI4cGJLcVFBYjJrYTFmbndMWkpmcHhIUzlPWFpvbTAzWHM1UjFJ?=
 =?utf-8?B?U3ZzdmhvWjBRSkVyY2xZcGFIalRlWUVSbkV3TnZZMTVlQ1lRaUdDYXV5dENM?=
 =?utf-8?B?TWwzVlhYQlFESUYwbmxZZGQrVEhTZ0NZZVMrT3lod0hiV1VzeXJ0djdEWnF0?=
 =?utf-8?B?RnV4SFROZjNpTFowcm1vNlRQTXdjVVJ1Z0pBZjBDRGZCQlNZRmYveUJ2TWJT?=
 =?utf-8?B?K1kyelZUY0hocXIveHBxOGhtanlCY1E1S0hudWw4OFUwZHdLUTUrMFA1ZmFa?=
 =?utf-8?B?QmNMdVkwY0tWdnlES0FYckx6MUtxeHBId3FxQW9ObGsvT0hxRi9qQVFTWjZY?=
 =?utf-8?B?ZWZiRFBVK1hlQUFrbEZrYkQrNGhkVWIzTDYzVFcyS3VTaXlyeFJiUFZ0ZGdL?=
 =?utf-8?B?dU9qbGtCVkRpZWhmRndsWG55aXp4Y3FFd1lxWG5LbFNabmk4NjNnek1PMDl0?=
 =?utf-8?B?UlBTTTlaOXdxM2RPd1BVTlNpOEg0ejR0ZExGSVZkaXBNWEo0RE5uQ0IyV2N5?=
 =?utf-8?B?NVd5b01KYjFwUlhZS1VheGtOMHNTcEVjSDhvY0NxUU11ck12Z3BJSTllL2t0?=
 =?utf-8?B?WllMTTltelJsa2ZGNXBGK1habm1yTDhkbEJVaTRGb21VWFhDbGdFdldTR3Zz?=
 =?utf-8?B?VWt3dEVhN2NmQ1E0ZE9uVGw5d1NzQ3R4eXEycFZZVHFtSXhqRFdXN3U4dWtP?=
 =?utf-8?B?Vk5iUWw5QkV4NEszL09DSVVXai9JMVhWVnNDeGFiWDJONjA3Z20yai9BbW1Y?=
 =?utf-8?B?ZEpLUTJ1eCtNb1BiWER2WUtHaGFEcjFqLzdoRnl6TVBtQzRrVC9rZ2RFQUVB?=
 =?utf-8?B?R1pVMXJiOE1sYWdkQnhRYWlibml2VnBTSzQzbExCbWtsVWl5MjdQYjdVSm9i?=
 =?utf-8?B?b0JFcVF6cDZVZ3gzK3VKSHhJSXpmT1dYTHpoUHNnN1VoSnRsWkVzNkZHQ2NS?=
 =?utf-8?B?dDgrckZ6SXRqcHVVeTB0RnhDRzhOS3RRV1lJbXBPNUZwM0ZseXlLdDJ4allI?=
 =?utf-8?B?T1RnZHhjcXNGa1YxNnRTN2M0KzlRWllOVmxBSElnSDQ0blpkZE9xdWxBY25B?=
 =?utf-8?B?TEw5VGluNlVtcnJ3ZFBUYzVtdG9NREllWmJZbnJoTkpnYmt2YnFhWXI0VHo5?=
 =?utf-8?B?WkNPUGs4c3l2M1VmNTBKeDlURldmVFMxZWNVVlJZNzZyT2RFekQ1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcf4891-fd7c-4fea-67da-08de4ebeeaeb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:05:02.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiinAWfj0eDJqUhjB+dWIKYFFbP91IXkLO+0TTONG3r6xuAdsxzqNkhIIu1cmmjZ2hZrhrsNQzoKW0lUOijyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172


On 26/12/25 13:33, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:13, Sumit Gupta wrote:
>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>> autonomous performance selection on all CPUs at system startup without
>> requiring runtime sysfs manipulation. When autonomous mode is enabled,
>> the hardware automatically adjusts CPU performance based on workload
>> demands using Energy Performance Preference (EPP) hints.
>>
>> When auto_sel_mode=1:
>> - All CPUs are configured for autonomous operation during init
>> - EPP is set to performance preference (0x0) by default
>> - Min/max performance bounds use defaults or already set values
>> - CPU frequency scaling is handled by hardware instead of OS governor
>>
>> The boot parameter is applied only during first policy initialization.
>> User's runtime sysfs configuration is preserved across hotplug.
>>
>> For Documentation/:
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 13 +++
>>   drivers/cpufreq/cppc_cpufreq.c                | 85 +++++++++++++++++--
>>   2 files changed, 90 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index aab72efa1acd..450f0b0225dc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1035,6 +1035,19 @@ Kernel parameters
>>                        Format:
>>                        <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>
>> +     cppc_cpufreq.auto_sel_mode=
>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous performance
>> +                     selection. When enabled, hardware automatically adjusts
>> +                     CPU frequency on all CPUs based on workload demands.
>> +                     In Autonomous mode, Energy Performance Preference (EPP)
>> +                     hints guide hardware toward performance (0x0) or energy
>> +                     efficiency (0xff).
>> +                     Requires ACPI CPPC autonomous selection register support.
>> +                     Format: <bool>
>> +                     Default: 0 (disabled)
>> +                     0: use cpufreq governors
>> +                     1: enable if supported by hardware
>> +
>>        cpuidle.off=1   [CPU_IDLE]
>>                        disable the cpuidle sub-system
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index b3da263c18b0..8c6869e68504 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -30,6 +30,9 @@ static struct cpufreq_driver cppc_cpufreq_driver;
>>
>>   static DEFINE_MUTEX(cppc_cpufreq_update_autosel_config_lock);
>>
>> +/* Autonomous Selection boot parameter */
>> +static bool auto_sel_mode;
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>        FIE_UNSET = -1,
>> @@ -643,11 +646,16 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
>>    * cppc_cpufreq_update_autosel_config - Update autonomous selection config
>>    * @policy: cpufreq policy
>>    * @is_auto_sel: enable/disable autonomous selection
>> + * @epp_val: EPP value (used only if update_epp true)
>> + * @update_epp: whether to update EPP register
>> + * @update_policy: whether to update policy constraints
>>    *
>>    * Return: 0 on success, negative error code on failure
>>    */
>>   static int cppc_cpufreq_update_autosel_config(struct cpufreq_policy *policy,
>> -                                           bool is_auto_sel)
>> +                                           bool is_auto_sel, u32 epp_val,
>> +                                           bool update_epp,
>> +                                           bool update_policy)
> cppc_cpufreq_set_mperf_limit() and cppc_cpufreq_update_autosel_config()
> have too much bool input param. Just break them down into several separate
> functions and call them only when needed. These two functions are now too
> hard to read.

Sure, will break them and open code in v6.

Thank you,
Sumit Gupta

....



