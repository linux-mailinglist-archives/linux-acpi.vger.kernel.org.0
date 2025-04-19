Return-Path: <linux-acpi+bounces-13125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E9A944F2
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Apr 2025 20:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE1189C5F8
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Apr 2025 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6391DE2C2;
	Sat, 19 Apr 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEhlZQC4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2A1553AB;
	Sat, 19 Apr 2025 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745085802; cv=fail; b=BPBr5nywFqACD/KNyIgybe0OaLqj5vIVZrHLiyJxyTIrwNGfqYOLgqRozKIHQFhWlEuAAS32nPL0hWaTilBuj+Tig3xSeBM4QG86lX8kYTr9NSLGyX2hSRnVZ4gv17b886DgHuX8jV9yf1gThnkWOTXP6isEYq7HQNYI/P9SRus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745085802; c=relaxed/simple;
	bh=V0JAit+weMsXAkmrQPGnFLsQf1Kd8FlAXmHk+0zzw64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OrcVG/nSWa0lp+RNpyqPAYavdrZflw216vxMs3wPzfCOTW7mYfCSW64Dg5aF2Ff+m4Na9M6Mphp3iUG1oEtH7dlz5cAugaIW+1WV4tKzSNUBm5i8annAaNrgDSi+psJTq02iVWLRyUWc6PiN55AYhHMonTrkV+Sj7KbyARJsQAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEhlZQC4; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YchBGfGhltWZk2Ov5rGcblIaA0TksraJo5LNJNjPHXld7fgFGm7dN39jGiOyNCR48sWvR+L6Njh2kCRLk/Kpq/vnAifkgiC1GvNRRU6+BzOjwZHaYLmwly8SYEFJ6ANMK7gzyNjUxVdUIqmklSqGUGFfIDg0+4mFnDZIwUAavHI3DfhBKLISQ8Q5xBAMVzrsYiPx/0Qv5/pOBhboUwqjaGsfYcfGidGfSoEfxVkKRhcreAcYowZubMqJZEYkD9MRfToBFHhW1BiwKYp9t0XPPibH6HcrelclBv29uiA+qBW7d3SfNJy3hGPAEhwvfucY4eksYil4JzIGZHERwREwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xaUuP9KjhYD3UhzKc6u0JGTkgjrofsr47jvNxZx8og=;
 b=tdIHTxuIxdv4UM65JAN1ynIo5aTb5+4+9O7yZUyYnY1kCdMyR8EeXHU4TIRVpE7xvlvTNXgbG64U7ASLquY7WWFRVUAWml4+JchQGF+nXg6ObJx7bclyIZKa7gv9u8JaRqOCD4Am5vugVvqyMF0U5XLyI0zyO935dvBSMd9tI8g/Ge0F/Nxr5Ty2BKLgsGGHSy+vg8Ztdl324SLe5LtPnT4ovF7RK45g80kRmX3vTQgM0cwndUOPlIyr4lzRfs40MdPrOEcbyJ0qhIRx0/8WlJXR2eLvM9CdXs6mUU4phO0y4daBOiXEo6VM9geYbKaNsbjI2h+y+TNWv1OkePCaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xaUuP9KjhYD3UhzKc6u0JGTkgjrofsr47jvNxZx8og=;
 b=CEhlZQC4Wfl0Ze+P0rC4IcfAOX9eEIYAn4uImDzR54inTDaO3VtTTQ3z0Lp0J8YGOXND5+EX17aJZjW0qq1Of9HmHRLijjw5HmhK+sWc9BwFUKyfJeve4BcRQjWEIR6Z6LTNiYyGQWrGAgJl2rrkNN/WZoYTZUYCLIS57zyQuXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Sat, 19 Apr
 2025 18:03:16 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%3]) with mapi id 15.20.8655.031; Sat, 19 Apr 2025
 18:03:16 +0000
Message-ID: <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
Date: Sat, 19 Apr 2025 13:03:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: "M. Bergo" <marcusbergo@gmail.com>, mark.pearson@lenovo.com
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0083.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::21) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|IA1PR12MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 977edb86-8469-48e6-71a2-08dd7f6c75b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTk0bmxoc2pHZkhreDlJWVZSZXlTd1RONHB3alNqYXR4Z2ozeHhDTm90U0R3?=
 =?utf-8?B?dDhiSHU5L0M3RDdkWDNFK0Y2OEdzai9KOTlveGRhWjBMVFd3d0h6ak42UGNt?=
 =?utf-8?B?QmNPZXZmTEpzeUNsU0RYRUtmNzRMUzQvWDVUaFZCR05sNHE2RzIwRnpreDll?=
 =?utf-8?B?Yjd6NW9QbU16NDFQbjJiTHNaalpoWnBXZW1wb3RqbVZoNGNWMUZjdjdYMDVM?=
 =?utf-8?B?NDkvb0lnRUw0V1FBaC9haXRrK21pcjdKQytFTkt4SWRSbHhqVU9YdDF0R1hj?=
 =?utf-8?B?eDdONFZTVnZyUmRadWJrd3BWUjJpLzIvTG1FQnQybVFmL0d0SjdRV0tqa0sr?=
 =?utf-8?B?RllVd2F6Z24rOVB3ZU9wMWNpd0dsY2NjOE5mdWRuMkJWaG9pdmVKNnBIMFox?=
 =?utf-8?B?bGpqV0NyS2ZjWW5EbzVEZmdhT0Z2MXdqckkvRTNoS3lWN09Ib29IaS8zUHJV?=
 =?utf-8?B?eUVlcnZma0xmNWliYkJjNk5JMjdONXVLUzA3emtQbXdXMjFFWjVXeTJCb2xn?=
 =?utf-8?B?OTI5VXprcjlOeElNeTJCZXpWVUwwSnVtU0FMTVQ2ZDBrRE5TUmRUckg5dm1a?=
 =?utf-8?B?YUUxNTc5bEVuRHFUUzZOYkZlVjRLVEhhKzdkVG4vN2VFMmlQQ0VKYmwyZEtY?=
 =?utf-8?B?d3NwNEJheHNwYjNrM1NoQ3dpbWpuS2Vyc3R6cmxja1R4Q2lCMUxyVTFid2lT?=
 =?utf-8?B?VGsra09mWE1uUXRKUy9GcFZReG1CdXQwS2lEZzlIaHV6c2Z0YW4yVW1zZXEz?=
 =?utf-8?B?ZmJseEtaa1p0cnlqald2K3NkL3VnR2RhbjJkRHpFTEwxUlh6L0pFQ0tlcGxF?=
 =?utf-8?B?N2Rsam1UcXBQTldlQTgwRnJFSDMyeU1NWW1yTE4yYldkUUQ2NUNUN3BERW5H?=
 =?utf-8?B?QzQwWkhaNW1vbnBNYkpEOXZSUHhQL1RPRk1CQWFmUjU4QmUzWVBWTFFBV3Bw?=
 =?utf-8?B?S245L2lPZmlIaG8yU094VUU3Um9UTWJheHFQWXNrUGU2dHJ1elZJSkZadDdi?=
 =?utf-8?B?Wkt6b0JiRzhyWHBXeVAzS3c5T0JjaWE3NnBWQm1pa0R6QTU1blJ1Q2RaRjl2?=
 =?utf-8?B?Nzc2aWFGVG1xbklSUWlaOGhTYnRrd1U2Wm43UnVCdnZZdmxzT1RRTjVzem5w?=
 =?utf-8?B?ZGE0WHF4aFMyckpUbFB5Y25mcFl4VGpSMnoxaW5ocVhzV2Nub0NUMVZUNDdR?=
 =?utf-8?B?ZXd4clFxVno0UXFmN2tRdDM0MkdIYm1XdmljOEpFL1NGMDYxT01PL0xDeXJh?=
 =?utf-8?B?ZXRGUjgvdis2V3B4eHRSOEpxcWFBL1gzNXpZSFBIZ3ZPb1I5b0xTenUvM1hJ?=
 =?utf-8?B?cDExSzN3M0ZPeDRMY1IxWllRUzNFWTJlSmdJUzFRTys2NFVxNXlUdi9IKzBa?=
 =?utf-8?B?T21xaUhMeUxCc3hTL1ZkUTBDZW1IY1RPNktOdUVvbTdBT3UxTTM1aUNidzh4?=
 =?utf-8?B?QklrYTQyT3RMb2pxUWczZVBybWlHZmNUV3MvU2lBVGx1QVlOWUNjcm5FdVNq?=
 =?utf-8?B?TkVwZ3pHK2NJdEtkb09TRjg2di9lU3FuT2xZUEl1NUVRZUJaS0I2aHBjZWlC?=
 =?utf-8?B?VElwN0tnWVpOeTNsREgwZU92NWUvaTNPQXAxV0JxUHJNT25lbjRwS2RQcDBW?=
 =?utf-8?B?cEdQWGNMQVJoczVoR1c4ZjNzV1ZrQlZKTitrelpqb2ZFUjdoeDlJdTVzZFVB?=
 =?utf-8?B?VUg5OWdBQkk4WWQzRW5XNFVLanZaSWJhRDNWaFdoRTZsZ0xBcmZLbTFGOGRS?=
 =?utf-8?B?NVNIZUxWUCtrcG12THBDK04ybHNSaUNhOVdhSlM0bDQvaTZmRUpIa01FeU5n?=
 =?utf-8?B?Qno1ckh2L1N5clY3QzNDcytqVU1COFRaaDg1MlFTREVDczZOTzNLbmJsczY2?=
 =?utf-8?B?YTZ0Zi9vMkEyRGlScnBMN2VJMjIxSHJEMGhaYjZJd0RNNjVJbUY1ZjN4SzNK?=
 =?utf-8?Q?tBESzHbSVAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGpwc2Q0Uk1IZGt3ZWN2cVlwOU44VWFXSjFSTW5pQlRTSXFzN010ZzNoQUdG?=
 =?utf-8?B?eU9CbC8vYkI4TVExcjdJZ3BuSFdhVGNoTWhERnA1M2N4M29ZL3hoaEI4UkxG?=
 =?utf-8?B?Uk5jb0pIRENRWVAzWU5sZEYwdXpoVEw2VytSTFI3TTZnNXVsemR0UTVCdE15?=
 =?utf-8?B?N2Y1djNhUmNkcURLMzIyWlVvcFlVc0pzY0dNVENwdkFMdDdNeVZxVHNVaHRP?=
 =?utf-8?B?ektwM0Y0SjBheG5ObGJtMWUzTE9LR2ZkUmFSTmtHcjNzMUJ1R0hzb05pWFd6?=
 =?utf-8?B?QWhMTmVuTTdQN2JjZFZZWmZlZUd5YWZydXRuaFBaT1ZTczZYNVFzam1oSHdv?=
 =?utf-8?B?V0FpbFhnUXUvRGNoNjFXbitjZUJISXFEYXdLczJWQzRFK0RtZk1LNlgrUzVW?=
 =?utf-8?B?NnZuZEVnbUdlalR0MkZtUnJBUnVFb1hyUkh0Y1JLeU5NSXF1Wnh3WHVzZ2xs?=
 =?utf-8?B?eGVXbWtHSnlmdEZIdzRiVE1UOENCQld4QlJjaThsYVE5TzNKOWVGUUdEM1Q5?=
 =?utf-8?B?anByekRtd0V0ZlMxdnFKcHUzQjVaY2dHUTRsekJNRHlJS1pwVU5zWVZxc2hN?=
 =?utf-8?B?UjQraFBqL1E0d3dXbzY5VUR6bExBTWlnTlk4V1pBSmdMYXpCV0tYcWprV0E5?=
 =?utf-8?B?ZXJkbkpzL1pzQ0tpYUQzOVlieGw3WWkrRndBQm1tMEdxQTBKU2dVWG5WanhT?=
 =?utf-8?B?VVZPTDhDdEg5bXJaRlYxVXdDYUNtYVRXcDEyWVFaZ2NsZkNEV1pxYlp4d0VN?=
 =?utf-8?B?aVczVUJUKzcveTgvZ3dTT0p6Skwva3JBbDc4OHkvYVVxMkllUjZVVlNYZWNr?=
 =?utf-8?B?cEJZMmVCd1hzaktGMDlIbmVqYVpzbTg0VGJja2NYOEhnU0tWRWdtL2dvU3dM?=
 =?utf-8?B?b1dObE1HRjB4UE1JWGJYWGhmMUI4WjRxY2MybzBMNCtjZXFpcDh5QVFVN1N4?=
 =?utf-8?B?SVZVTzJ4YkNqbTViSXNCSVhPblN0dVo5dFVCb1NKYy9PcmVjVm02Um1hTU4w?=
 =?utf-8?B?K2t6VGR5ZWhkbjBEWFMzenhzbjZqaUZXRHh6TEZTRFlYOFdOQ1dGT0ZjdjNK?=
 =?utf-8?B?Sm1OeGJZTVdSaWNQSHNuM2FIaEZIbVZqekJQUEF3aWdjcm16SVhhMXdYOHV1?=
 =?utf-8?B?eWdHSERuQ3hadUtGOTlZZ1ZPR0RPSG9pZCt6Z0c2L1hVaE93VWdiRDU1SXhj?=
 =?utf-8?B?OUIwNjRpVTNuakYvVjVwSFNOWUlmY3FhMjk4cldnVk4rUVVlNndDN29MdG9B?=
 =?utf-8?B?cVF4T2NEdUhEREVjdUZKNndUNHFhSmIrd2RxcDFkcUhmS20vSE1JZndQa0dr?=
 =?utf-8?B?TVE2LzA4bUJ1Tzg4ZzBjNWVuMG1WUnJxRFo4cU9XS012WkdyVURST3ZaUFg2?=
 =?utf-8?B?QjBQeDZvemxzd2Nla3FWU09iSGlkK0dhWm5wY2xEM0VOSFpqSTN6WG9wTzVz?=
 =?utf-8?B?Y0JrUzgxYUdZVHBBcFMyazNTeWcxM05ZeTBUbTVCWldVd0NFd0tFbkVSd1M4?=
 =?utf-8?B?Y3ZyYTRzKytTaVhRUTI0UGQxZEVsTHgyUEtUNGhlMWUza0FVclpQZE95clVG?=
 =?utf-8?B?L1Q1V3BMZTF6ZEE4ditWeXhSZkZGYTFaSWpXeDRwTmFRYlpaTGVXb0M3ZEgr?=
 =?utf-8?B?cVJucTFrK0FTdWdpdG9BN3p4U2o0V0hpbThzWjd4N2FFQnBNTkZxb1ZOSjBD?=
 =?utf-8?B?TlpldG5IT3BUTW83ZXFrVmdmcGRTR3k4WFlGYVR4YkRkcHZVMVhGLytBd3RH?=
 =?utf-8?B?dGRIZXdrYlJCWDBac1cwSlNrYjR6RU9hVmVhMk9vRStGVUoyeHl3WEtPc3I1?=
 =?utf-8?B?UVFtdW80TFBtMHoxL0ZVaHVSUWtiNjVFdzJWbkZpTUtNNmZaV3hRK0paNE9o?=
 =?utf-8?B?Y3c0SzRuS0NQS0ptVWtwemlQVkR0UlRRaitGa0R5Tm1LZmh4aFFSNzlOWDhj?=
 =?utf-8?B?V3VkcTFLamh0UmE1aVN2Zk9TSnNmUkJiamVudUpQNmVSRkRuK2JkK01FeGNu?=
 =?utf-8?B?MHVBcWZTNFVDenFkSzBTRlptR2lFU2xOL2VBbEJwRlJjOEtTOTg3cmlkUVl6?=
 =?utf-8?B?SjBJbkxGcVk2VWRoOEFsOFdVSHBhYXllU3REd0VSQ1RxM2Q1K1FhS1UvVWFo?=
 =?utf-8?Q?CX/+j8XhvuMZNKdowCSrbg4Lb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977edb86-8469-48e6-71a2-08dd7f6c75b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 18:03:16.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGrNejQTc49+uZN7kxX7tXpJrQUT8J3xteehuIvhF7dl2gNtxxCLgvP3xAj+wQzSUfhIDNvDl+5khoAET1hQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640

On 4/19/2025 4:28 AM, M. Bergo wrote:
>  From 881e57c87b9595c186c2ca7e6d35d0a52c1a10c2 Mon Sep 17 00:00:00 2001
> From: Marcus Bergo <marcusbergo@gmail.com>
> Date: Sat, 19 Apr 2025 05:19:05 -0300
> Subject: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms 
> after
>   suspend/resume
> 
> Several AMD-based laptop models (Lenovo P15v Gen 3, P16v Gen 1, HP 
> EliteBook 845 G10)
> experience a CPU frequency limitation issue where the processor gets 
> stuck at
> approximately 544MHz after resuming from suspend when the power cord is 
> unplugged
> during sleep. This issue makes the systems practically unusable until a 
> full
> power cycle is performed.
> 
> The root cause was traced to commit b5539eb5ee70 ("ACPI: EC: Fix
> acpi_ec_dispatch_gpe()") which restored the behavior of clearing the GPE
> in acpi_ec_dispatch_gpe() function to prevent GPE storms. While this fix is
> necessary for most platforms to prevent excessive power consumption during
> suspend-to-idle, it causes problems on certain AMD platforms by interfering
> with the EC's ability to properly restore power management settings 
> after resume.
> 
> This patch implements a targeted workaround that:
> 1. Adds DMI-based detection for affected AMD platforms
> 2. Adds a function to check if we're in suspend-to-idle mode
> 3. Modifies the acpi_ec_dispatch_gpe() function to handle AMD platforms 
> specially:
>     - For affected AMD platforms during suspend-to-idle, it advances the
>       transaction without clearing the GPE status bit
>     - For all other platforms, it maintains the existing behavior of 
> clearing
>       the GPE status bit
> 
> Testing was performed on a Lenovo P16v Gen 1 with AMD Ryzen 7 PRO 7840HS 
> and
> confirmed that:
> 1. Without the patch, the CPU frequency is limited to 544MHz after the
>   suspend/unplug/resume sequence
> 2. With the patch applied, the CPU properly scales up to its maximum 
> frequency
>     (5.1GHz) after the same sequence
> 3. No regressions were observed in other EC functionality (battery status,
>     keyboard backlight, etc.)
> 4. Multiple suspend/resume cycles with different power states were tested
>     without issues
> 
> The patch was also verified not to affect the behavior on Intel-based 
> systems,
> ensuring that the GPE storm prevention remains effective where needed.
> 
> Fixes: b5539eb5ee70 ("ACPI: EC: Fix acpi_ec_dispatch_gpe()")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218557
> Reported-by: Mark Pearson <mark.pearson@lenovo.com>
> Signed-off-by: Marcus Bergo <marcusbergo@gmail.com>

Great finding with this being a potential root cause of this behavior 
(at least from a Linux perspective).

Although this helps, I'm not really a fan of the tech debt accumulated 
by needing to quirk this on a system by system basis as a bandage.

At least for HP someone said that this commit happens to help them for 
the same issue you're describing:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=9f5595d5f03fd4dc640607a71e89a1daa68fd19d

That was surprising to me, but it must be changing the timing of some of 
the code running in HP's EC.  Since you happen to have a Lenovo system 
does it happen to help the Lenovo EC too?

Mark, comments please?

> ---
>   drivers/acpi/ec.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 3c5f34892734..f3698f3c100f 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -29,6 +29,7 @@
>   #include <linux/acpi.h>
>   #include <linux/dmi.h>
>   #include <asm/io.h>
> +#include <asm/processor.h>
>   #include "internal.h"
> @@ -2139,6 +2140,59 @@ static bool acpi_ec_work_in_progress(struct 
> acpi_ec *ec)
>          return ec->events_in_progress + ec->queries_in_progress > 0;
>   }
> +/* List of AMD platforms with CPU frequency issues after suspend/resume */
> +static const struct dmi_system_id acpi_ec_amd_freq_quirk[] = {
> +       {
> +  .matches = {
> +    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +    DMI_MATCH(DMI_PRODUCT_NAME, "P15v Gen 3"),
> +               },
> +       },
> +       {
> +  .matches = {
> +    DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +    DMI_MATCH(DMI_PRODUCT_NAME, "P16v Gen 1"),
> +               },
> +       },
> +       {
> +  .matches = {
> +    DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +    DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 845 14 inch G10 Notebook 
> PC"),
> +               },
> +       },
> +       { },
> +};
> +
> +/* Check if we're in suspend-to-idle mode */
> +static bool pm_suspend_via_s2idle(void)
> +{
> +#ifdef CONFIG_PM_SLEEP
> +       return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
> +#else
> +       return false;
> +#endif
> +}
> +
> +/* Check if the system is an AMD platform with the frequency quirk */
> +static bool is_amd_freq_quirk_system(void)
> +{
> +       static int is_quirk_system = -1;
> +
> +       if (is_quirk_system == -1) {
> +               /* Check if it's an AMD CPU */
> +               if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
> +    is_quirk_system = 0;
> +               } else {
> +    /* Check if it's in the DMI quirk list */
> +    is_quirk_system = dmi_check_system(acpi_ec_amd_freq_quirk) ? 1 : 0;
> +               }
> +       }
> +
> +       return is_quirk_system == 1;
> +}
> +
> +
> +
>   bool acpi_ec_dispatch_gpe(void)
>   {
>          bool work_in_progress = false;
> @@ -2172,7 +2226,17 @@ bool acpi_ec_dispatch_gpe(void)
>          if (acpi_ec_gpe_status_set(first_ec)) {
> pm_pr_dbg("ACPI EC GPE status set\n");
> -  clear_gpe_and_advance_transaction(first_ec, false);
> +               /*
> +                * Special handling for AMD platforms with CPU frequency 
> issues
> +                * after suspend/resume. On these platforms, we need to 
> advance the
> +                * transaction but NOT clear the GPE status bit when in 
> suspend-to-idle
> +                * state to prevent CPU frequency limitation issues.
> +                */
> +               if (is_amd_freq_quirk_system() && 
> pm_suspend_via_s2idle()) {
> +    advance_transaction(first_ec, false);
> +               } else {
> +    clear_gpe_and_advance_transaction(first_ec, false);
> +               }
> work_in_progress = acpi_ec_work_in_progress(first_ec);
>          }


