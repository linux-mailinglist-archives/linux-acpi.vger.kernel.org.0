Return-Path: <linux-acpi+bounces-16359-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E2B43AEC
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B4017C68D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2432D21FF5F;
	Thu,  4 Sep 2025 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DD6sKvX9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A82CCC0;
	Thu,  4 Sep 2025 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987336; cv=fail; b=uiBB3dFp714iA8eXb+XlHqRCJkPrr1QIv1fRpPeNi66XDAJME5yscZuGTh4uoH/PwcH5qw28UZXvNwAburZfhHfT3tsA6iVzaw5Z5ey9UZG0seY0MeQeklanAm+jUdSMPjfJarHfP8idARNWAO1TEYtokT6zV8fvun7+EPWRN+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987336; c=relaxed/simple;
	bh=NmzmMUMOM70t7fyETo/YuByEyYDztmz3sKE8G/4vW70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N+nq55MGPdl39N24keVzXggck07mF7OeZbIlyVsFvBbrhDjgAdBSs5vT64YgcSjdLBqZzArmPc/M+xrbHEOuUCc45Elay/+1K6ruzjDxy8F3jKCiMMZjkzdJ25GcShBveYw0ZxDNCQTjX+HhRDPR3w4D5GqvlPxD0OKZSuyI2n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DD6sKvX9; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FX87FJ8K+d2cVi2fBnfzvrwPb14i54w3Bns4Sj/KCPyPHVukv9ZVnZ4D4Xu1rBu5huYf94Q1GRcNx/ulqc15lE9JIPv1nJGJiaofOTxDtNxM50UX6PwtB7pErZlPdHyeD4ajfY9KVjCLOPS5p/zfScck/nezVFUwiPUOXn7+1LQ6BHhbJUgo8GNVQXGc7PpfjBb4jNyrbeECSMhE2dvJpt1d3wADq9G/qe1GhzvXHw+oMXVERfn8JNg+bZQ2i/LBn1DvzDfmTwVG+joSWJsLYPrtusW2kCbNWwSSmk6AZ3Wqps5M750BEjcLJR4W3QRHqxMc38nr7Kbq3lVWymjzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKg+zkGU6ly4A/S/ELUq+yA/SI1CoQTeFTN72i6/d9I=;
 b=c75gBR7MgKw93yL9Ln354RYA3H1N8eQuChZn5GDaHd2Su7uypTyTwZJUXUc0G59cfTuHPEdwBfj17f//kgxMU0snY6aVtiNyxVquTUlcRS/i+Rt60PBiHR+/E5c+37WQQYOErwzYvuuH04Kls1yfDj0iqqXVI0PDaSFYoyQpQITZle4ob9oa5yNqrX/NN8ui9ONpo6SHev1FG6VjTKh9UNCn9StAvex146rx8XLdr9dZA/Thei8DM1olNZAmroGyqhOkDjkKw8MvgMYUfgRDxRLK3xbuVsF1tU+oDlYv9ZeI32jPYCL7qj5MPrfSs9SFV3+FyrVNGApRbc/Ypx27Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKg+zkGU6ly4A/S/ELUq+yA/SI1CoQTeFTN72i6/d9I=;
 b=DD6sKvX9htlsYaF4uql4ssfbbptA82hFTbVumJp+Wv1xrYlNVKmIOg17PEj36P4HWePhGpKavg3s3Qg+Bhu38mKbCqYltwznQLlMlFDgekLqfQyoeWW6Lzfm1pTBP++rqEGWlh/mUSuoAF8KkeyxTKTWpiTj0VhdfyirMtqM3SSuVl5BwTXrHI1amFNoMFDQOjArihoNA6n/p2Bw4mzWLoQpVxXppQIl+oeU1f8MsWMAtKxe5tjrN8UNFimvOQjnq/SDkbKC/opN/cstMu8a8mu/usMuBNWFpUGX1QV6hON1xKk25zLZuOrZQCaXC1f8NUudzKDwXT8u0B9wTsPT6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 12:02:10 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 12:02:08 +0000
Message-ID: <7641627f-ab0d-478c-9d52-6ed4745bd61b@nvidia.com>
Date: Thu, 4 Sep 2025 17:31:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Mario Limonciello <superm1@kernel.org>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, perry.yuan@amd.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-8-sumitg@nvidia.com>
 <507095d6-512a-4561-bc90-12a34a43302a@amd.com>
 <30b46202-d377-4455-9551-5874e1e9f104@nvidia.com>
 <64a744bd-0f62-498b-8886-a5338fd8410c@kernel.org>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <64a744bd-0f62-498b-8886-a5338fd8410c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::12) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d7d370-b457-44d5-a833-08ddebaadf78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2lvaGdIb0FjdVVKd29yV0h3M2xraEwveDFQMHN2OCtjWHNxYVJFTFhYL0Nn?=
 =?utf-8?B?MDhFVTJvamFHdXdxNDBwU2V4eHpGR0thSE5sa1h6SnZzemlaM1Q2aHZIeVBr?=
 =?utf-8?B?QjIzbkYvUXlsbmgxandtSk1ycGVVZHNRVmExUThTRmJUR2V1SUE3c0dCMnEr?=
 =?utf-8?B?aUNCa0hVRU85UjBRL3Y1Nzh6dHJ3WHVmOUx5UHlrblJqWG0vTmRHVHRRRUFv?=
 =?utf-8?B?ZWpoSVYyRDAzb2wycVZSTmJMd05FcGNwZEhrcTBmOTNmYjk0U1FoMmw2dzFS?=
 =?utf-8?B?VVlJUkVNMmRZOURPM1lCbEhaZEJLL1JlN1YrTDBmSEkyWENmTWhGQlhJSHVt?=
 =?utf-8?B?VG1qeVZRTXJtblNTaFpkbngxU25FWmhDa3RwUmNvd2ZwbGVTVlJnN2dudkZT?=
 =?utf-8?B?U2dMYXZ5bGlzUWxxMmQwcFVtVTUyVFZpZU8vK1FyVzZLRkN3eGZVaDhDME9V?=
 =?utf-8?B?dVlybDlxK29ETVpPdnU5ZWI0M1Q0SHhsTDBvUS9MbFk3eERHQUhUeDlSRW9X?=
 =?utf-8?B?NFRpMEF1YjliM3VyR2dyckFuK3YyYlk5YVhydTZZaE03aHRhYWczWFB5QW1J?=
 =?utf-8?B?WDQ5elUxTHluOVFxN3JOVDJCOGNUenNNcU9ZRzNmYkxXOWVtY2JkOGsyOVVq?=
 =?utf-8?B?c2F0N05FV01yazFWR244M0ZvZjFhbWNnZGl3bWN0QysrT0JVekQycXV0N1M1?=
 =?utf-8?B?eWFSRnlpMHkyd3YzWUV5MEVDMnhadThyUVp0alo5cDQ5NTNDcE1hREdveDdk?=
 =?utf-8?B?cGJ4WDc2ZnViUVd0OEkyTHV0L3FtZ1NPcFhkUWlES0RNTE4zTEpiQ3FyR1No?=
 =?utf-8?B?WUVsLzYxVU01MzNvVllWN2xkdUNrdWZaRXhpcGJMRDg5QjFhMFhWak5pOER5?=
 =?utf-8?B?UGV0NVd3c3BSWGJpNUNqMnJPWXg4RXhtVnlvOTZpSTZqcFFvNTY0REJjbHhF?=
 =?utf-8?B?dFc4K1h0Y0ZCWURFUE9qUDYwYWlEWmVaTyt2OU5PNE1pRjF5UTFUTkxPb3J3?=
 =?utf-8?B?NVNTbXdFWFY3U1NuOUlWSEpEVnVHTVliYURPdWZ0UXI4SzMrT0RzN1BVNGd5?=
 =?utf-8?B?dHFjUE9STXZvdjdzVSt6cnp6NitHN1dtRzZQeHU4RVYweUpvRVNFUkllcWNl?=
 =?utf-8?B?M3dER0lkc2wvSGZGMVJ1cFhZSDFoTjYraEo4dVA0Y2pCWE9YaE43eFdNTTdF?=
 =?utf-8?B?TmdTMjhTWkd3OVNRckJzbUhTREdsdGlMOTlodm9kUmt2dnVPTS9ScVgrenJF?=
 =?utf-8?B?cHJlZDNxWGM4N2Jqd09UNTNmVHR6MndvMXZjNXRjTGtCSXZLNzdzUkhzTmli?=
 =?utf-8?B?Njg3ZWpxUEFsYVNZaGtjeVQxckUvSzJML1JyME54OXIwQkhMM2hmUmpKQ1lH?=
 =?utf-8?B?SHdEZHVnWk8vVnZrREx4c3ppRnlSVFFSYXErREVpbkJqR1JnaDc1QWx6bW9I?=
 =?utf-8?B?SFA2d216TUM3eGw3YkMvR3NGN0NVMGVzWW9CTDZ1RlRWSVl0NFNXSzVUV05W?=
 =?utf-8?B?aXZYZmY5V0RYajBCT1JGSDNNZ0d6VGtsYVdkSmtlRXBHMW5DS25DVDBtQ2tw?=
 =?utf-8?B?N25HZVlLSEFSTjNEaXNYd3JPVm0wN2pGTWUyYVdrSUhXUFluSXQrd1daeWhZ?=
 =?utf-8?B?MHdKN1Z2Q3NpYmREZ3NrU0FUcXlxWXBPOGNzYm1RVHp4blFvZmhuQ2ZxSzB0?=
 =?utf-8?B?RkF0empHRFVjMk85amYxdnpMR1RQWUVKaDZIV2dkTXV6ajhFQ2hyVTJ2WHZi?=
 =?utf-8?B?TTFFY1IvY05FUk82ekJtdUxCZ3MxK2tCOFNyRmhBczVEdDVoZWlhalkwbUxZ?=
 =?utf-8?B?dnFucUtwWFh4UU5zeEhKaDljOUpBR2ZySWtnNlFRTkM0YkYxSnM2c2l3RWZy?=
 =?utf-8?B?U1p5c1ZnaW9FczhGVjMvd2RXZmo3emZzdmpIZ0V0b0lWYU9nOUdMaWtHTjQw?=
 =?utf-8?B?c3A4UFZnME5MdXR4OXh5emIxWVJSb1g2R0ExN2loR3M5WnRCUEdCL1hwZ0Jk?=
 =?utf-8?B?Z3hENGFzNWV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmxuZmZYWUUwUXlzYmVYcno2VkM1T0NTcGs3YndQQ05yRzBNKzZoWlRWbnJ2?=
 =?utf-8?B?MFZzYVExS3dvaTFzbXVZYnM0dFJCd0krVjRXVTlaVUp1bFBaRDRzc09UL1ln?=
 =?utf-8?B?RnVINUNJTzNFTjZRKzlQaHpkU3I4OTBtNGlnVnRoWXl0YWM2VGlNbkxzU3h3?=
 =?utf-8?B?ZVh5MnZZTmxBaDE4eTZQR0NmSDBSWWY5WkYwZTlLOGQ4TytFc0VjSjRBRFZE?=
 =?utf-8?B?andBSEpFeFc4WFcxS2t4R1dSWnQ5RUlDbnd5QzVzVnhDdUpCSDBRbHBRVzhP?=
 =?utf-8?B?Vm9aa0phT293SjlFMmx1S0Mra1d4OTJlYzcwalpxL2svd1R0MVpjVVpuSnVR?=
 =?utf-8?B?RGplUmdJOHhjd2hWeS9TVVZCWUk1WHJ1cS9iVTFZbUZ3aGduVWxnWFhQUzNU?=
 =?utf-8?B?c1VPNmpaKzZaZUJrU0pzQmJEL2hWUWJ6L1F1ZEh4RDlsdldhQ2F3OHF4MnRJ?=
 =?utf-8?B?MXR2bU9hNnVOZEpZa01scnR1L0JFNWo4SFFVSFdScWRsUWxBWFgxZnp2MWho?=
 =?utf-8?B?N3lYUFhkYlY1Ujc1bkdNS2tlRElURjBWZ0tIT29IaW54Qk9temZTd045OFZy?=
 =?utf-8?B?RkNrZ0RGY0s3RzBTUU1pZjAxeGFsL1V4UUg5NC9CMXJ0bnUwRlEwNlFhdmRR?=
 =?utf-8?B?dGIybkFxdVJaSk5xbzUrVWNjT21GTWJHRVVqWG5VQnBYNlp0UVJZMXI5ZHpq?=
 =?utf-8?B?Vnlic1JPV0srSnN4U0xIS2lsdENRc29jUFpHek5FeFNqNDBCdHJSdlYvdmxx?=
 =?utf-8?B?NGNNTExCYkFXZkN5cHVJRmlJKzljcDl1ZDNESVprMVNxZW01UjFYZ0JKa0Vk?=
 =?utf-8?B?amM4YVBhWWw3WnRDWHhoNjVNeDFXL3BzdTBnRXZVYkdkMDUrUEl4SG9aeGVR?=
 =?utf-8?B?R2hUTEhoUU1jejVlVlhKNzdxS2tTcStHL3d6VDlxZlV4dlNkNmJJNEd3VjJs?=
 =?utf-8?B?aWtTZTFRY2dxRURiYjVhYU5DdXF1Ti80RUNnT3Q4amI4MXoralFPMFNITDZX?=
 =?utf-8?B?UFg4SHIxU0taL3lNWTFLcmdiTno5RTZRK3B0TndMc1puMWpYYWowZFl6VjJX?=
 =?utf-8?B?ZzNnN3ZQNEZsUUVYdVpyamlzWnhQa1dDb0NTUFJjV1BmYW5ySVQ1aUkyWGhx?=
 =?utf-8?B?SzVnViswWHE5Z3RqZVZZRmtKaEdvK3ltV3lZeVpyTm5RQXRKZEVCbTZXcE1H?=
 =?utf-8?B?OWdVUjRibHFtZVlERVBpd0JZQlVwVzRJcDBlK280UEpDdFhleUZzSGNjTFRV?=
 =?utf-8?B?RFVLSE5iWlhHN25lWGxDeWZSNU1wbFdXTTVQdXRXb3JPeWZIc3FWTWVhUVBR?=
 =?utf-8?B?NTM2azVYSnRzQlU4dkI0TlNDMlk4UWc5TmZXR2p3SjVOUHJvcmZJSmlua1B6?=
 =?utf-8?B?OG5HakNjWHRhYzRwS2lLczZsSjFhd3V1dkd3NXdKanE0US9xOWR4cTNJVEMw?=
 =?utf-8?B?ZCsxZmxEZFdPc1h0NTBqZmhVcUVhWFNLNDVPVGlkL2tDVkNJa1FqcVl2L0hi?=
 =?utf-8?B?MWdNNWQyWnVrNXlmRXZtSDgzZ0xuNkE5d0ZYUU9FS2ZicVQ5M0lZZHVwY2pL?=
 =?utf-8?B?b2ZEVm5CR0ZNZkpldnZhMWcwQ0U1ZzFPajh2TGFvU0lHRDR1YUFsY29wUlYv?=
 =?utf-8?B?Z2p3VUowUDlNK1BUbnZUekxId0VWZm81eFIrZ0d6YzVVdUVmTXZXZTBnTlJp?=
 =?utf-8?B?VHNlaisxMnFpemFUb0t0R01aUkc3Z2dFdGU0SlJtdGVIb01WQjY5b1ZaOTR4?=
 =?utf-8?B?c25PWWRXRGJmc3hPNENPdVRmS1ZRZHBDUmt6UEEzV1hCY3JldGMxSlZrR3FO?=
 =?utf-8?B?bC9QYWluZFIvRGo4eU5yUFNHRUdacW1sc0Yza2lPQllWd2JWa0VRNUVSOXA5?=
 =?utf-8?B?ZmVlNUZzN292dTgrTHkvMlJSbkVNTEE2SG0xamJKQ01zZnBlN0ljMUc2Mk5L?=
 =?utf-8?B?T3FpaHZTci94WWpyb3ZnTDBYWUVpWTY0OGFUMVVQNjE3ZXcwYWxkT3paang5?=
 =?utf-8?B?Q3gzMkgzT3pKNG8wdkVyVldCTkVYTWZUMlFjdDFxTEExWDFPNzJWWmpOMW84?=
 =?utf-8?B?WDRjQmdRWEZFYkNvUStSOEhhUnRLVEZpb1EzVVQwQWFVNUJ5L1I2UnNDSE9T?=
 =?utf-8?Q?YLMpdAMaV2VXgNEkR8wo3lfnA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d7d370-b457-44d5-a833-08ddebaadf78
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:02:08.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmZ/7Jdz6+hovmRs7H98a9yoBe5wwF40hbUxY0V0In1ZGeXHbaiOpQWPVhb7JC3d3VF3tsnNTmYiHHibhT+Qeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307


On 03/09/25 01:18, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 9/1/2025 8:37 AM, Sumit Gupta wrote:
>>
>> On 26/08/25 00:10, Mario Limonciello wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 8/23/2025 3:01 PM, Sumit Gupta wrote:
>>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>>>> autonomous performance selection at system startup. When autonomous 
>>>> mode
>>>> is enabled, the hardware automatically adjusts CPU performance 
>>>> based on
>>>> workload demands using Energy Performance Preference (EPP) hints from
>>>> the OS.
>>>>
>>>> This parameter allows to configure the autonomous mode on all CPUs
>>>> without requiring runtime sysfs manipulation if the 'auto_sel' 
>>>> register
>>>> is present.
>>>>
>>>> When auto_sel_mode=1:
>>>> - All CPUs are configured for autonomous operation during driver init
>>>> - EPP is set to performance preference (0x0) by default
>>>> - Min/max performance bounds use defaults
>>>> - CPU frequency scaling is handled by hardware rather than OS
>>>>
>>>> Also ensure that when autonomous mode is active, the set_target 
>>>> callback
>>>> returns early since hardware controls frequency scaling directly.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>   .../admin-guide/kernel-parameters.txt         |  12 ++
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 171 
>>>> ++++++++++++++++--
>>>>   2 files changed, 168 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/
>>>> Documentation/admin-guide/kernel-parameters.txt
>>>> index 86f395f2933b..ea58deb88c36 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -911,6 +911,18 @@
>>>>                       Format:
>>>> <first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>>>>
>>>> +     cppc_cpufreq.auto_sel_mode=
>>>> +                     [CPU_FREQ] Autonomous Performance Level 
>>>> Selection.
>>>> +                     When Autonomous selection is enabled, then the
>>>> hardware is
>>>> +                     allowed to autonomously select the CPU 
>>>> frequency.
>>>> +                     In Autonomous mode, Energy Performance
>>>> Preference(EPP)
>>>> +                     provides input to the hardware to favour
>>>> performance (0x0)
>>>> +                     or energy efficiency (0xff).
>>>> +                     Format: <bool>
>>>> +                     Default: disabled.
>>>> +                     0: force disabled
>>>> +                     1: force enabled
>>>
>>> I don't think you can actually force enable.  If the hardware doesn't
>>> support it, setting 1 won't do anything.
>>>
>>> IoW really setting 1 is "enable if supported".
>>>
>>
>> Yes, will change in v3.
>>
>>
>>>> +
>>>>       cpuidle.off=1   [CPU_IDLE]
>>>>                       disable the cpuidle sub-system
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/
>>>> cppc_cpufreq.c
>>>> index 5e1bbb5f67b8..bbf654c56ff9 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -27,6 +27,8 @@
>>>>   #include <acpi/cppc_acpi.h>
>>>>
>>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>> +/* Autonomous Selection */
>>>> +static bool auto_sel_mode;
>>>>
>>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>   static enum {
>>>> @@ -272,6 +274,14 @@ static int cppc_cpufreq_set_target(struct
>>>> cpufreq_policy *policy,
>>>>       freqs.old = policy->cur;
>>>>       freqs.new = target_freq;
>>>>
>>>> +     /*
>>>> +      * In autonomous mode, hardware handles frequency scaling 
>>>> directly
>>>> +      * based on workload demands and EPP hints, so OS frequency
>>>> requests
>>>> +      * are not needed.
>>>> +      */
>>>> +     if (cpu_data->perf_caps.auto_sel)
>>>> +             return ret;
>>>> +
>>>>       cpufreq_freq_transition_begin(policy, &freqs);
>>>>       ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>>>       cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>>>> @@ -555,6 +565,12 @@ static struct cppc_cpudata
>>>> *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>>>               goto free_mask;
>>>>       }
>>>>
>>>> +     ret = cppc_get_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>>> +     if (ret) {
>>>> +             pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu,
>>>> ret);
>>>> +             goto free_mask;
>>>> +     }
>>>> +
>>>>       return cpu_data;
>>>>
>>>>   free_mask:
>>>> @@ -642,6 +658,79 @@ static int cppc_cpufreq_set_max_perf(struct
>>>> cpufreq_policy *policy, u64 val,
>>>>       return (ret == -EOPNOTSUPP) ? 0 : ret;
>>>>   }
>>>>
>>>> +static int cppc_cpufreq_update_autosel_epp(struct cpufreq_policy
>>>> *policy, int auto_sel, u32 epp)
>>>> +{
>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>> +     unsigned int cpu = policy->cpu;
>>>> +     int ret;
>>>> +
>>>> +     pr_debug("cpu%d: curr epp:%u, curr mode:%u, new epp:%u, new
>>>> mode:%d\n", cpu,
>>>> +              cpu_data->perf_ctrls.energy_perf, cpu_data-
>>>> >perf_caps.auto_sel, epp, auto_sel);
>>>> +
>>>> + mutex_lock(&cppc_cpufreq_update_autosel_config_lock);
>>>
>>> As I noticed below a case you missed the mutex unlock, this feels 
>>> like a
>>> good candidate for
>>>
>>> guard(mutex)();
>>>
>>
>> I will check about 'guard(mutex)()' and change accordingly in v3.
>>
>>>> +
>>>> +     ret = cppc_set_epp(cpu, epp);
>>>> +     if (ret) {
>>>> +             pr_warn("failed to set energy_perf for cpu:%d (%d)\n",
>>>> cpu, ret);
>>>> +             goto out;
>>>> +     }
>>>> +     cpu_data->perf_ctrls.energy_perf = epp;
>>>> +
>>>> +     ret = cppc_set_auto_sel(cpu, auto_sel);
>>>> +     if (ret) {
>>>> +             pr_warn("failed to set auto_sel for cpu:%d (%d)\n",
>>>> cpu, ret);
>>>> +             return ret;
>>>
>>> Looks like a case that you didn't unlock the mutex.
>>
>> ACK.
>>
>>>
>>>> +     }
>>>> +     cpu_data->perf_caps.auto_sel = auto_sel;
>>>> +
>>>> +out:
>>>> + mutex_unlock(&cppc_cpufreq_update_autosel_config_lock);
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int cppc_cpufreq_update_autosel_mperf_ctrls(struct
>>>> cpufreq_policy *policy, u32 min_p,
>>>> +                                                u32 max_p, bool
>>>> update_reg, bool update_policy)
>>>> +{
>>>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>>>> +     unsigned int cpu = policy->cpu;
>>>> +     int ret;
>>>> +
>>>> +     pr_debug("cpu%d: curr max_perf:%u, curr min_perf:%u, new
>>>> max_perf:%u, new min_perf:%u\n",
>>>> +              cpu, cpu_data->perf_ctrls.max_perf, cpu_data-
>>>> >perf_ctrls.min_perf, max_p, min_p);
>>>> +
>>>> +     ret = cppc_cpufreq_set_min_perf(policy, min_p, update_reg,
>>>> update_policy);
>>>> +     if (ret) {
>>>> +             pr_debug("failed to set min_perf for cpu:%d (%d)\n",
>>>> cpu, ret);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     ret = cppc_cpufreq_set_max_perf(policy, max_p, update_reg,
>>>> update_policy);
>>>> +     if (ret) {
>>>> +             pr_debug("failed to set max_perf for cpu:%d (%d)\n",
>>>> cpu, ret);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static int cppc_cpufreq_update_autosel_configs(struct cpufreq_policy
>>>> *policy, int auto_sel,
>>>> +                                            u32 epp, u32 min_perf,
>>>> u32 max_perf,
>>>> +                                            bool update_reg, bool
>>>> update_policy)
>>>> +{
>>>> +     int ret;
>>>> +
>>>> +     ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf,
>>>> max_perf,
>>>> + update_reg,
>>>> update_policy);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     ret = cppc_cpufreq_update_autosel_epp(policy, auto_sel, epp);
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>>   static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>>   {
>>>>       unsigned int cpu = policy->cpu;
>>>> @@ -710,11 +799,28 @@ static int cppc_cpufreq_cpu_init(struct
>>>> cpufreq_policy *policy)
>>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>
>>>> -     ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>>> -     if (ret) {
>>>> -             pr_debug("Err setting perf value:%d on CPU:%d. 
>>>> ret:%d\n",
>>>> -                      caps->highest_perf, cpu, ret);
>>>> -             goto out;
>>>> +     if (cpu_data->perf_caps.auto_sel) {
>>>> +             ret = cppc_set_enable(cpu, true);
>>>> +             if (ret) {
>>>> +                     pr_err("Failed to enable CPPC on cpu%d (%d)\n",
>>>> cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>> +
>>>> +             ret = cppc_cpufreq_update_autosel_configs(policy, true,
>>>> + CPPC_EPP_PERFORMANCE_PREF,
>>>> + caps->lowest_nonlinear_perf,
>>>> + caps->nominal_perf, true, false);
>>>> +             if (ret) {
>>>> +                     pr_debug("Failed to update autosel configs on
>>>> CPU%d(%d)\n", cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>> +     } else {
>>>> +             ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>>> +             if (ret) {
>>>> +                     pr_debug("Err setting perf value:%d on CPU:%d.
>>>> ret:%d\n",
>>>> +                              caps->highest_perf, cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>>       }
>>>>
>>>>       cppc_cpufreq_cpu_fie_init(policy);
>>>> @@ -736,6 +842,13 @@ static void cppc_cpufreq_cpu_exit(struct
>>>> cpufreq_policy *policy)
>>>>
>>>>       cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
>>>>
>>>> +     if (cpu_data->perf_caps.auto_sel) {
>>>> +             ret = cppc_cpufreq_update_autosel_epp(policy, false,
>>>> + CPPC_EPP_ENERGY_EFFICIENCY_PREF);
>>>> +             if (ret)
>>>> +                     return;
>>>> +     }
>>>> +
>>>>       ret = cppc_set_perf_ctrls(cpu, &cpu_data->perf_ctrls);
>>>>       if (ret)
>>>>               pr_debug("Err setting perf value:%d on CPU:%d. 
>>>> ret:%d\n",
>>>> @@ -920,17 +1033,10 @@ static ssize_t store_auto_select(struct
>>>> cpufreq_policy *policy,
>>>>        * On enabling auto_select: set min/max_perf register and
>>>> update policy.
>>>>        * On disabling auto_select: update only policy.
>>>>        */
>>>> -     ret = cppc_cpufreq_set_min_perf(policy, min_perf, update_reg,
>>>> true);
>>>> -     if (ret) {
>>>> -             pr_warn("failed to %s update min policy for cpu:%d
>>>> (%d)\n",
>>>> -                     val > 0 ? "set min_perf and" : "", cpu, ret);
>>>> -             return ret;
>>>> -     }
>>>> -
>>>> -     ret = cppc_cpufreq_set_max_perf(policy, max_perf, update_reg,
>>>> true);
>>>> +     ret = cppc_cpufreq_update_autosel_mperf_ctrls(policy, min_perf,
>>>> max_perf, update_reg, true);
>>>>       if (ret) {
>>>> -             pr_warn("failed to %s update max policy for cpu:%d
>>>> (%d)\n",
>>>> -                     val > 0 ? "set max_perf and" : "", cpu, ret);
>>>> +             pr_warn("failed to %s update policy for cpu:%d (%d)\n",
>>>> +                     val > 0 ? "set min/max_perf and" : "", cpu, 
>>>> ret);
>>>>               return ret;
>>>>       }
>>>>
>>>> @@ -1139,13 +1245,44 @@ static struct cpufreq_driver
>>>> cppc_cpufreq_driver = {
>>>>       .name = "cppc_cpufreq",
>>>>   };
>>>>
>>>> +static void cppc_cpufreq_set_epp_autosel_allcpus(bool auto_sel, u64
>>>> epp)
>>>> +{
>>>> +     int cpu, ret;
>>>> +
>>>> +     for_each_present_cpu(cpu) {
>>>> +             ret = cppc_set_epp(cpu, epp);
>>>> +             if (ret)
>>>> +                     pr_debug("failed to set energy_perf for cpu:%d
>>>> (%d)\n", cpu, ret);
>>>> +
>>>> +             ret = cppc_set_auto_sel(cpu, auto_sel);
>>>> +             if (ret)
>>>> +                     pr_debug("failed to set auto_sel for cpu:%d
>>>> (%d)\n", cpu, ret);
>>>> +     }
>>>> +}
>>>> +
>>>>   static int __init cppc_cpufreq_init(void)
>>>>   {
>>>> +     bool auto_sel;
>>>>       int ret;
>>>>
>>>>       if (!acpi_cpc_valid())
>>>>               return -ENODEV;
>>>>
>>>> +     if (auto_sel_mode) {
>>>> +             /*
>>>> +              * Check if autonomous selection is supported by
>>>> testing CPU 0.
>>>> +              * If supported, enable autonomous mode on all CPUs.
>>>> +              */
>>>> +             ret = cppc_get_auto_sel(0, &auto_sel);
>>>> +             if (!ret) {
>>>> +                     pr_info("Enabling autonomous mode on all 
>>>> CPUs\n");
>>>> + cppc_cpufreq_set_epp_autosel_allcpus(true,
>>>> CPPC_EPP_PERFORMANCE_PREF);
>>>> +             } else {
>>>> +                     pr_warn("Autonomous selection not supported,
>>>> disabling auto_sel_mode\n");
>>>> +                     auto_sel_mode = false;
>>>> +             }
>>>> +     }
>>>> +
>>>>       cppc_freq_invariance_init();
>>>>       populate_efficiency_class();
>>>>
>>>> @@ -1160,8 +1297,12 @@ static void __exit cppc_cpufreq_exit(void)
>>>>   {
>>>>       cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>>>       cppc_freq_invariance_exit();
>>>> +     auto_sel_mode = 0;
>>>>   }
>>>>
>>>> +module_param(auto_sel_mode, bool, 0000);
>>>> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level
>>>> Selection");
>>>
>>> Why default to disabled?  As a precaution?  We enable EPP by default in
>>> the *-pstate drivers if the hardware supports it, I would think it 
>>> makes
>>> sense here too.
>>>
>>
>> Kept disabled by default both as precaution and to enable it based on
>> preference.
>> Someone may want to try different config values during bringup,
>> verification etc.
>
> I personally don't think that bringup software should dictate the steady
> state decision.  Bringup can trivially have a custom kernel command line
> that disables it.
>
> Otherwise this means that the "worries of stability" translate into a
> custom kernel command line option on all production hardware.
>
> So I feel once you're happy with it on a variety of hardware you should
> consider a patch for enabling it by default at some point.
>
>
Sure.

Thank you,
Sumit Gupta



