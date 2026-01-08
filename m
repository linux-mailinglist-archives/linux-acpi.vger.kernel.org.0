Return-Path: <linux-acpi+bounces-20061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBCD032BE
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 14:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5639D313D685
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE4428FE5;
	Thu,  8 Jan 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DHI5XhBD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0374219F4;
	Thu,  8 Jan 2026 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879409; cv=fail; b=KPBOd5Fhp2teX4AMQ6wgHcfGXj5QnwM0m90D8AEQJPx0WKi+d1R2V2nvc1YKP6pcMKZsHqtzTawUUheNOYBsL+7TuMmBaZ+Rt7suPRB3K9TOkJcqnrNc5KghUOxGe9i3THQpIeY733Fi/DmFprV6Dld7UB/cnIuG/7p/cWmOKOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879409; c=relaxed/simple;
	bh=YEDhQSiamc5w5CViQBZTbzJJVw2OD0rMxSjgoiCvm3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jjONSJH7G6x9DYVm3EibsKYN2nCxYDylQRz3akTl7Z6eu7I0ghWBe+iLlRo3W29dBrfyHtndcVzJZFHCwGdj0IJoGk4VAgRtnvxM9DXIxykP3W9aKzI7oUmirJF0fzw7EL/vW1688pxqdTvqUvqDhrID8fPGYRJxxvUk1NLQDL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DHI5XhBD; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTSrWBf0di08ci/ShQ+YrrgTc/6HFPFYoquAQNdRh+zToY+f2gQxIOQjCOFVo/Vo0uDYw3npxwv0y4CM0WBQ5UDEhGYwx57J9cSHGM5SwTJoWiRPrYzMQmbaoyrp+mdNYrD8TYZ4Bq4RBlOKXA6puFn330ZKHVqHgVwBgoH7fHzi/VHo2R/Fgh8qNXzDY2EezQOmK+6Yy+Oo7owkKddRbgaUBLJwFN1F5+KBsxDl9Hn1NcN3GHxJoOb1xTXEUPJKF1rTrnj36v55mWbEuyISOW5vwTAu3Jw1r3FfRliFxTgcmGsjVdIK2OkMBeWuKE8KYOGUnALMIf/M9PgENDHlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdHzM/gINMmhP2dzFJMLdGJuoshEyA/oTbVJPveQPlU=;
 b=R/W9rrD2XoxHNdy0sEzyDOw4KZmB2YtlPrnd1gfjEuT769iXAGZTrzRCYNicXnQH362EG8CCwpbcpmrR9KUAsCUJzxaMX0jkVEb5+645wTb4HQcIzM7WSwfD4an9+Frh6TAmRWHK2P0BG5XMfHxqxFOr/CXYvp4CQwGGOGyrSAIKCLhUdiIHM8bHGugMsZgilsuouTzeJ3I/5k9kOkjXLNlYg34lEbfJjZf3ZV/yFObyQRD6+8ghbmBHOza7DuQ2tzNqJwmNeTD5E/mMWFEcbRkWn89tlCuUmA5bSWoWSU+h+2XtgywjKMsj6s7MK/PWU700m25zZS3B8wJv0DSSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdHzM/gINMmhP2dzFJMLdGJuoshEyA/oTbVJPveQPlU=;
 b=DHI5XhBDvNVnq3s7uqd5xMW9BZwlj4Ga4M1vV3J3VcLnV3BPU9KCOgHdpqF8TsEcGva1PJ6DgHZv8To7D6ZTKyccGex7SvU29vANxyX0ebFmbgAum/bxaPFU0VqaqwQIyVxMcPCVSs/737mmiO78nLBMC9YSOowfAlRRPssBxwkQnomS0WEtO+hd/VfFmyh81GMRtptkjkXjZu5nN7wvOUOhu5X5t8lV/I5ON2v0CxXDPTiek2C/ujeOgJOsxbzQkBI9kRERm26cVGRfW1uzBL5y2oL+VmuAySqDXYOGtR+/3u4ET03nOr9QaXAgHrbfrDtIk9KBDmWSse5w0A90Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:36:40 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:36:40 +0000
Message-ID: <fe78d07c-f648-4a1b-a3b0-87d388fd2f2c@nvidia.com>
Date: Thu, 8 Jan 2026 19:06:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/11] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
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
 <20251223121307.711773-4-sumitg@nvidia.com>
 <e484ce68-1fb1-4732-8577-19a2b7141c40@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <e484ce68-1fb1-4732-8577-19a2b7141c40@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: b540d6d9-1a92-45c6-372d-08de4ebaf3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blR6elFldmVJOTlZaGNVUnFKVU1TbmtQRElOSUYvNm8vWlQxaW9mME8zWUg0?=
 =?utf-8?B?VEdZMFpvb3B3NFY4dy8rbk8xVllyOTZVcUY4WTRkcFhwUmF4d0Y1dVdSSUNI?=
 =?utf-8?B?SzZ2K3dlUHh1MzdLQm9NNUpDRnZxN0l4OXJCeDFKY1FuS1loUU9jTUt6a0lp?=
 =?utf-8?B?ZHlXUjlWbjhWQXRFb2RvcFc0WUQvbnRlb1lqMVRTK0ZaZFhEZlphSmFFMDFj?=
 =?utf-8?B?cWhjcDFRWWNCcjlOYnNxalhkaTVZQXlNZ3ZNWW1BNUdSbmE1eXdBKzdwVTFY?=
 =?utf-8?B?ZTBTaTdqVVpsU1k4MDdmYVloK0U0Z25kV1FBUTRsL0pmYnpIZ1MzV2VKeUlK?=
 =?utf-8?B?UW8xWkNhcjBzQjdSaUdObmhsUHFJVmpjUitvWGZ4c0UxdlJzRjBXVVJJdHlT?=
 =?utf-8?B?YmRIV2E2ell2Q3hZOUNLZDI5WDh6amliZ2pjV1VjR2RxWnV2Q1ZQNzZVZDY0?=
 =?utf-8?B?UnE5eklYRGhvYkVuM3N3WGsxa2pITjZKZmg1aEtVSTFJY29TYVVydlVjTDE0?=
 =?utf-8?B?UXdFMFlUZ0dtUmR1ZXp1SkJxcjNQZGdQRW03TWxZcCtZbG0rQlFJQ2ZYckhU?=
 =?utf-8?B?d3F3bVZrNEM2bndHdDVpM1NGZkVQQUlwbFVHcFl3Y0tpaWdSU2pXaS82Yk92?=
 =?utf-8?B?VEswbCtZMFhPTHpxMEhUTSt2OGF5eHVqdUxJN2lKNWl5SDlnY0I1NGVnMFox?=
 =?utf-8?B?cGdBQmNxTVVMQUtrZHdEVVhETW4rZDV4VWRPbW9HNitMS3dUNnN0ZE9SMHZB?=
 =?utf-8?B?N1o5UjBuRm5iRi9EWmVkbG1Nd0xid3RLdjhKQXBOSEV1RW9sc2lIUmswdTN0?=
 =?utf-8?B?R2tJS0ZSRU52MjFOMnBhL0djNWJrbXB4enRYbzhjbm15Z0NqdzlVM2NQSHY0?=
 =?utf-8?B?VVJ3cW5BSjFKU3NyL2lhRzRhdGNEb3FEc3RYalpSU2NXY1QrU09nVXJUUUxV?=
 =?utf-8?B?bGxXYjBCRFJmdGFhdzBGbXgrRHVZcmczUHlZMjlIVGJvRjRxL1JVcW9KcEJ5?=
 =?utf-8?B?MHNWNitDS25zZUlhNUI0N2kyY3FEQzZQalorL1lYY0pvS3lrUnovaVRUQTFZ?=
 =?utf-8?B?RTE5cFV2M1lFWm9PWkpQRWF0NTlQRFRBSmdxTmZuV1I2b1JuMVlyeENRb0ow?=
 =?utf-8?B?TXJFQTA3T1haK3hFWkZ0MlZPTzdjMVN2ZUcxQTM0QTN2ZzdSWTFWTmYxTXpo?=
 =?utf-8?B?czlHMDBuQWRKRG1kblBYTlkzU1BvSlBtcDF0dE5EZFZObGpmTVUzN2FqTVRt?=
 =?utf-8?B?RnlaTkdJcWl3UkNhUHEwTFNjd2lUUWJYenE1cXRwbldJclNvbFEvdzNhUVd4?=
 =?utf-8?B?L2wxSmE3TlY0UWVJckdJd3ZiT3RHS2Z1VWRSU3VuWURhQlk2bEk3MDNEeG5P?=
 =?utf-8?B?aTZtVnZCMDdJVFRWZU9HemFYeUF0OUNwRTJaU0FwOHZ3eFBLd2dheHlEeUJr?=
 =?utf-8?B?c0dpZXpRN0NpcFB5em1COSs5ZUtrSWJtaGlqaVF3eXhXVXBIdmxVSUNsVm9Z?=
 =?utf-8?B?N0JIQ2JaZHBLdTdEZ2grRHNxeWcycnhUWkdYSWhXYzZ0NXZGTXhHNDZGSVhW?=
 =?utf-8?B?Q01pME15MWpjcHhXTFc3K0V4Nmx0YkNjWkpldEh6cDBjQzd2MGIvTk5xMXJV?=
 =?utf-8?B?UTB2cGJHeE05NFVEelBJUWUvOUFvdittWGdtUTI5V29KRUk2Z1hzZXAwZ0p3?=
 =?utf-8?B?QUpScDFFV0dkUlQ5WWQ3THhTUUhjdXJtMmdQZHBTRnFoQ01rMTRCNjFqalYw?=
 =?utf-8?B?cFcvQ25HMFRhanRQL1BPVzl1NGJHdzMzWmZTOTJHOG5NVW9LbHliNDVRZ1VE?=
 =?utf-8?B?c09YUkRvd0lqLzZxbG9ZREpKeFlRRFBmc1dnbEY0Zit1b2VPQ3BtSVZmSkls?=
 =?utf-8?B?WmY4ZS9QTk9MWHRtV3ZKSiswNkx1eU1hcWhOK250SlgrUzlPM05LaC90UlMv?=
 =?utf-8?B?SzZPdzE3UUJjQ3N2bUw3OEd6OElGdTlpMjR4c2NSRlRXYWJtOHdEUDIyNHUw?=
 =?utf-8?Q?y6DO3ffYvSytSR5t72+c3btcvxnPRc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW5JYnhtNVJESkJyUkdCTng4cldpUkQ1MTZ0Yk43OVM0SmRaUG5NV1Q1cnVQ?=
 =?utf-8?B?Vm1kWUtDUHplbmRUbVZrSjFVRHQ5cUxXSzlVTHFWWkY0SVhpeGhzR081SUZj?=
 =?utf-8?B?RmRxd1RaZjFBT2RHN2dlY1pGZ1JQWG1nZUNmMjVvMnFkQ1RuUHE0aWxJYkd0?=
 =?utf-8?B?cWNUU2w1ZFJlZEJjRDU3bzgvbVhDQnY4b1ZPNUtZR2g5QTVxdE9WSVVCOGtT?=
 =?utf-8?B?RHBGaVNWeWtDZVNsTlFjVVNHK1BoT2QwbVpKTE1qK2Z2dXVhNTFyMXphUXMv?=
 =?utf-8?B?ZFRhWlZJbHdNVUUwSXN6YS96S29JbFhqUHhxbEEwTGNtRzd2aWRRS1gwZHI2?=
 =?utf-8?B?aWI0K2FrRUhDdWd4N0p4Ukw4L0haRDBkU2pGTzBZVWM0UitHczFDVmtzWGJS?=
 =?utf-8?B?ZXhqZGVxT2YrZXNGSlNVZlUvZXN4SmxKTzE4ZS9ubkphdUZVNWw3bkh0M01k?=
 =?utf-8?B?enJrT01BbEVZTXF6UHNxWm9Ja0JGOERCbTNoNlNyb2pwdEtEOWEvbXllNnpH?=
 =?utf-8?B?cnBneWFyU1RkYnloRFgvRS91aEVldUNkcWJhTjdNYmhCRDRLSlVZL21Id2g3?=
 =?utf-8?B?U3pwL2JhdUJxVXN2UVFFbWRXbzNCRHBRRmlJdEkzaE9CMHRsSVdEb0FOTWNr?=
 =?utf-8?B?aWgxVWF1QmNWMlRyN3BzamdEY3RUT3U4S0FCNWIyUVpjWTRtZ1R3amdxKzJ5?=
 =?utf-8?B?RjBkQk0yc3NIaEp2S1owc05rRzNyQmpVQTNtazRUcUhBU1hRUm9HODRpY3lQ?=
 =?utf-8?B?SWpXenM2Y0R2ek8xcitMdk9XY1Q5YnJNNithZmNOUkZudFUzemtQZTUrcXVN?=
 =?utf-8?B?aFYxaTFnV2dkUjBoN1EraS95b1B6TllkZ2FlN3Vlb0xIb1MyVktOQlBFbURO?=
 =?utf-8?B?dlFaajhGMzJRSm9PUmhBY2hjR0VibzExZlcxaDJzZUZLdjB4L3ZPeiszKzNt?=
 =?utf-8?B?UTI3ZXduK3JJcGFlRlRwN015SEdhUFNDaWN0akV5eWlXSEl6SFQ0Y3EveWVX?=
 =?utf-8?B?akdjUXFBR2hKVVhIMHZvbmlRcEF3Wk8waklyM2FBbUVuekp5a2RjWWwwRjV6?=
 =?utf-8?B?T2pVMytOenNZaTlWdDJxWi8yWTVKZGlrdHBRVURIaVlEQ2o3eVNYbDlrdVJ3?=
 =?utf-8?B?T092bk9sZ051MXZ5dGFNWVZWeGRIUGswS0szZ1VEOG52SnZ4ZndGVy94MVU2?=
 =?utf-8?B?b1Aralc4UFZCVjhrN1hjMnR4alIzSGJqeDZSa3ZPSmltTjZzYk9JTzM3aGIz?=
 =?utf-8?B?Zkg0b1ArV1pPOHdFN1RzYzBOY04rNDlQUUE5T0hPdWdPZGZjdktQWVBQZHlh?=
 =?utf-8?B?dGplL3JyWjNicEU1Rm81bGdHQnpBWTk5dUlEZzhuamxGSVJYMW0yd0hsWUNP?=
 =?utf-8?B?cDZqWmt2MUtnY21jcHZhbGx4cGtmNU5tcThyRGpoNkwrbitlckJVSnQ4OUlN?=
 =?utf-8?B?YmVpYTlpUEhUUksrVzBmU2VMTzJpclltUm5uckFpMFh0cUp6VEVYcnV5Szhv?=
 =?utf-8?B?ZzF3VnhnWjB0bHk4VkwxaFhZWm83ODA3VlJSQ0xDRzZEb0ptcHA3NlFzdTAr?=
 =?utf-8?B?SFMyWE9yYStSYWhSR1k3Z3A0ZGs0WUora2c0SFBEaUhrMjhxUDAzVVdBRE1m?=
 =?utf-8?B?ZDdTOGtUaTZRTk5GY0RGNDNBTTRucXhmZGUveWk5UEZLTkFTRXlZZHhvck51?=
 =?utf-8?B?MXFTRnhYNjRBUnB5VW1tSExhdStPekxwbmFicitKa2FXRXEzT2wzanFFdzU5?=
 =?utf-8?B?SkdmK3pkR0VtYVNjcWtFQXVRUlpLb0dIYlpXT1NtZDhIQUdxc0Y5Yk1ON0N1?=
 =?utf-8?B?TkxtZmZYL0haOFBaNVVrVXJ3RUxWazgzUUZvRkxCK1RsK0RFNHNYYzh5SDl2?=
 =?utf-8?B?UERKS3o4L0VEUFJMa2d6d3pjSkZMcVFpQW9vaWZia1ZPUDQ3ZEFSVGN6ckFH?=
 =?utf-8?B?d1F2QTdka0J6M3dpMW56YTdUUTc0OFgrT081bEFNejJoRFZ2RVlvUTNFZ2ox?=
 =?utf-8?B?QWE2T1NGOGYzMzIxVDhxM0ZqZGQyYnlaenplZURRc0hDOXd5TWt6Z2szTkNU?=
 =?utf-8?B?MmZmWEhVOG5DTUFZQzdXL3NRclFQUXBtRVJGakJ6RUl0amxPSVpRaHBLMlpW?=
 =?utf-8?B?NTBjeUpPUzhCYjFQWTJFR3QzeThXdTNzM3N6N25UNmJyaXBLWDRha1JhRnB0?=
 =?utf-8?B?TE5LaDYwa2ptM2lyR1ZNUnNTeFVtWlVRSFljNE9TUHNRU3djdTVPTnpWbk1D?=
 =?utf-8?B?ZTdqSHYvUnYwZDcvTS9DbUthMS9UcVp4ZXFBUmRxcUlTZnEvUi9TT3lDTnR5?=
 =?utf-8?B?ZHdCZTB2aERQbkRLa2pMODY4LzZXc3JxNGFrZzNDWEp5Rml6V3lhUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b540d6d9-1a92-45c6-372d-08de4ebaf3ee
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:36:40.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gowMerNoSHncogsrBE1Rh09vtpT+Bdw6EmVKAIc1+M/Jb58Pksa/q+heci5JG70U6GNBic/HU99F3SJEq+9LcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526


On 25/12/25 13:51, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:12, Sumit Gupta wrote:
>> Add cppc_get_perf() function to read values of performance control
>> registers including desired_perf, min_perf, max_perf, energy_perf,
>> and auto_sel.
>>
>> This provides a read interface to complement the existing
>> cppc_set_perf() write interface for performance control registers.
>>
>> Note that auto_sel is read by cppc_get_perf() but not written by
>> cppc_set_perf() to avoid unintended mode changes during performance
>> updates. It can be updated with existing dedicated cppc_set_auto_sel()
>> API.
>>
>> Also call cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
>> perf_ctrls with current hardware register values during cpufreq
>> initialization for each CPU policy.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 79 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c |  6 +++
>>   include/acpi/cppc_acpi.h       |  5 +++
>>   3 files changed, 90 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index e66e20d1f31b..a4e89fe6aab5 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1732,6 +1732,85 @@ int cppc_set_enable(int cpu, bool enable)
>>        return cppc_set_reg_val(cpu, ENABLE, enable);
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_enable);
>> +/**
>> + * cppc_get_perf - Get a CPU's performance controls.
>> + * @cpu: CPU for which to get performance controls.
>> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
>> + *
>> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
>> + */
>> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +     struct cpc_register_resource *desired_perf_reg,
>> +                                  *min_perf_reg, *max_perf_reg,
>> +                                  *energy_perf_reg, *auto_sel_reg;
>> +     u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
>> +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>> +     struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     int ret = 0, regs_in_pcc = 0;
>> +
>> +     if (!cpc_desc) {
>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (!perf_ctrls) {
>> +             pr_debug("Invalid perf_ctrls pointer\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>> +     min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
>> +     max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>> +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>> +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>> +
>> +     /* Are any of the regs PCC ?*/
>> +     if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
>> +         CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
>> +         CPC_IN_PCC(auto_sel_reg)) {
>> +             if (pcc_ss_id < 0) {
>> +                     pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>> +                     return -ENODEV;
>> +             }
>> +             pcc_ss_data = pcc_data[pcc_ss_id];
>> +             regs_in_pcc = 1;
>> +             down_write(&pcc_ss_data->pcc_lock);
>> +             /* Ring doorbell once to update PCC subspace */
>> +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
>> +                     ret = -EIO;
>> +                     goto out_err;
>> +             }
>> +     }
>> +
>> +     /* Read optional elements if present */
>> +     if (CPC_SUPPORTED(max_perf_reg))
>> +             cpc_read(cpu, max_perf_reg, &max);
>> +     perf_ctrls->max_perf = max;
>> +
>> +     if (CPC_SUPPORTED(min_perf_reg))
>> +             cpc_read(cpu, min_perf_reg, &min);
>> +     perf_ctrls->min_perf = min;
>> +
>> +     if (CPC_SUPPORTED(desired_perf_reg))
>> +             cpc_read(cpu, desired_perf_reg, &desired_perf);
>> +     perf_ctrls->desired_perf = desired_perf;
>> +
>> +     if (CPC_SUPPORTED(energy_perf_reg))
>> +             cpc_read(cpu, energy_perf_reg, &energy_perf);
>> +     perf_ctrls->energy_perf = energy_perf;
>> +
>> +     if (CPC_SUPPORTED(auto_sel_reg))
>> +             cpc_read(cpu, auto_sel_reg, &auto_sel);
>> +     perf_ctrls->auto_sel = (bool)auto_sel;
>> +
>> +out_err:
>> +     if (regs_in_pcc)
>> +             up_write(&pcc_ss_data->pcc_lock);
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_perf);
>>
>>   /**
>>    * cppc_set_perf - Set a CPU's performance controls.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 7c26ce554e29..a87e7bb2e2f1 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -562,6 +562,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>>                goto free_mask;
>>        }
>>
>> +     ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (ret) {
>> +             pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
>> +             goto free_mask;
>> +     }
>> +
> If you really need energy_perf and auto_sel in cpu_data->perf_ctrls, they
> should be updated whenever they are set, i.e., in store_auto_select() and
> store_energy_performance_preference_val().

store_auto_select() is updating auto_sel in patch 09 of v5.
Didn't update energy_perf as not using the cached value currently.
Will move auto_sel update to this patch for clarity and also update
energy_perf for consistency if value is used in future.

Thank you,
Sumit Gupta

>>        return cpu_data;
>>
>>   free_mask:
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index a090b010f5f1..12a1dc31bf2a 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -150,6 +150,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>>   extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>> +extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>   extern int cppc_set_enable(int cpu, bool enable);
>>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>> @@ -191,6 +192,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
>>   {
>>        return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>   {
>>        return -EOPNOTSUPP;

