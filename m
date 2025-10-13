Return-Path: <linux-acpi+bounces-17736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D2BD2E0D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 14:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2073C4597
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Oct 2025 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61642698A2;
	Mon, 13 Oct 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZADweHue"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360621A9B46;
	Mon, 13 Oct 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356791; cv=fail; b=YyEGvDv7SRJV3RU895LZyVc1K9k+bzlya+BJk48p20MZEGqPEpk9qsgFDi8oWM9GO5buenvpLKEXMEJr+Gg1hxEsn/vvVvSTFTtVsMS7fYZGoz05mfi4AA8kX5Kl4UhmGOp1p+twNwnRrXBLZDw6fHIAQlLhTlr2c5ZJnc5b4XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356791; c=relaxed/simple;
	bh=WFNz4j3XnSnLf5oKFzO9fEMtvoNJu42Y+Hz2vvX4LNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IsfFHDlxFlo74SbqLLOUU2Gzzj7Jx+mKgLtEpH9L8tu6/reiAsskRCK2EU2Rpv4sdKmoCJvjzTY0YIkTaYjf1WaqO2QA0WfhmvLP68ziN4XIWjxBE/wYquZLbAQMZgzGjEq5iVPwkGTrxcCjwrN1pB/0/WFB01j/Pokce2+pLhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZADweHue; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adXzmgyr2cAR5JZWUseQ7nMigiOiOfUmlAL++V4t+IEuTqVyQPBfm6Fv9jr20txe6pWBT2cWB8Nq4xp9YD4i7tjeRJzqzBrEbwxtZ1tBnq80iX6Q8rNXiCA7PhV32+fILenD4ALV9d/84KZIsEalZGN9IKnI5C4XSnx/lZ/FrM6rhfkEd2OKsn4mIq7cbHuy7FTkpkxSMSgKQAnhzM5FtWcefkpmFWhzz0y/fqoi2ML33L7yQ86E0wULoyLNhTAinC4nS42tzizOUdsfgPxcsS32HzWzmwcTbxhTdOvmcXLX3SEwi1pjeJ8qXmL5rJl8uqrmIlg9YorEpZFFlSo/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qmhzFHTA14b9FMBJ5uYsBJoIWvYAeFWAJ8vk2Wt7OI=;
 b=zIeXsX2qO2sDEYhePGsbPh0FAzGHzvjbQQEXTMqHTHGEJNvKwxaclvNoS5cN+5v5MbuJpLCGiSFSNMPPCrOHa+/+rQFtAcfdajp2hHKz09x0KJ5MXIN0D3qiAGySDsZRbkbFaFXoRwgWF199wXlcgBP/ax6fa3BId0a+fKZBUCsWCnramHcLcGNRZghBMhrwM+td7rP4pPzRiGz0ikiP4zA+u49uwPsRi95kRLoMeCIiCGJki7poUM64elImQBURTySR8pjeWcYv8z6DUGeGyZXZvthIXDh+O2hc5OepKCzyGA6c4AR/5d2DELk8H2ceXOhHZLOIQ9FNrvYpnB/VaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qmhzFHTA14b9FMBJ5uYsBJoIWvYAeFWAJ8vk2Wt7OI=;
 b=ZADweHueF+UzVLUOuPGpC64fPzDbCdUzhBY6pATytXm2BXEgUckGiCrv2FiOwzHFFTc9GUYcuS0fitPxpv+gX4G2T1Fc9w5SAybsCtzlRQr4U6utXZLD5/KsEgEi9nM1ieWn+YX9TkIYMNXdXoVN+LWE493p2uuW0MOGOKWKJ3lPZRhhbWNq5gMYJxIWgncX6gK+Mq2Iz1mDy+xtiv+u8+Tc5ZyWWbfYijbOJZWGR6kEPboQiNIetOrSZ3umoatrfnrNmeWQP/Rk7ZiUOZZXnxtVNv5XBVQFTaHNUVV3EBWL0Scb09jvxmweeg/G3IWSq2Jwjd6mVwqSXDLiQyFuLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 11:59:47 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 11:59:46 +0000
Message-ID: <43243a37-db14-49aa-8338-dc7ca446b94e@nvidia.com>
Date: Mon, 13 Oct 2025 17:29:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
To: Jie Zhan <zhanjie9@hisilicon.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-7-sumitg@nvidia.com>
 <0dca2bf6-0f87-422d-a348-5ab33a9683d2@hisilicon.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <0dca2bf6-0f87-422d-a348-5ab33a9683d2@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::19) To DM4PR12MB5184.namprd12.prod.outlook.com
 (2603:10b6:5:397::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b37f94a-978b-419a-e66e-08de0a500073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzZPdTJkYTF3Z1dvOGo1M0xPeHhnMllnT0gvMkFJWi9HaE5MaG8wNU5acEdy?=
 =?utf-8?B?SFFtVlJ0VTBsOCtTZkJpeUd1OXhYcXBBeFVhQThLL2V4YnBDY3RBRWNxeitw?=
 =?utf-8?B?bjFGSE1DaktFVW1WdjBkWDBKN292YVM1RWZJY3hqT2ZrV3d3cnU5b2pqLzg1?=
 =?utf-8?B?c21XYmFzakZoMFNoaE5yYnBHcVFCVmkxOTFrTEtUWU9teFZVS3I2QUw5WlVI?=
 =?utf-8?B?RzlMeklwVGREZTZ6TGdmNXhPa0pSeFdYSjBGVFVsNENXV0xCdHA5TXorSE1H?=
 =?utf-8?B?bkFKOW01YWwxN0FiOE15VXcrWkJpcy9YckFHd1FubmtZenA2N3R3Y3RIYTlI?=
 =?utf-8?B?TjF3ZThpL3dTYzJ2UjY2ODByWUhtTUlIaDY3Q3lMZXEyRnRSNG8xdzNUTEp0?=
 =?utf-8?B?bkpFZmxrOUd0NUdteXNDdFRGZWh2d25vNklHMVlMSVVxT0dFSHh1RCtyWXpF?=
 =?utf-8?B?MVdOVEtBUWhoSU85VUxoRHZpM00wNnludHNTWTNQS2I0NEN2L3BZM0pOaTE1?=
 =?utf-8?B?SWZtMXpRVXFHeWtic1c4S2NZeUx4UGU2UXYwdTZzcWxJZTZPbEVaNWdoeDdy?=
 =?utf-8?B?KzZQMytLUnRzM0JsVEJqekNyRGZyRWt2SHRzdVcxb0J3OU1CV0hZZmxXOVZt?=
 =?utf-8?B?a0JpSnZFKzE1TE8vSU1kaEF1VDRhSVNjcjhpNEpMNnVCZXNJREVmcWdwSlZ0?=
 =?utf-8?B?VFVIQ2lQTkVmK2FvTis5eXNaVmNQRXVKZEdMQkNVNjJGWEkzbVFXenZPUTZT?=
 =?utf-8?B?RHN1Z0lXTGRoSUttVHdQNjI4NXJXdHBlS0lMOFJUS2VoNkxRenNUWHBhOGwr?=
 =?utf-8?B?bnN5OGZEcTRGbjJ5Ykp5elh2M2lLYWxqejBpUlVjYkZ1bm5BdTUrM3hjK0F4?=
 =?utf-8?B?dXdZRjkzQ3FKQTdKZUZ5NEFYMC8xbWFYUXRXU0cxalNXOFhULysyUEltSnpn?=
 =?utf-8?B?T3FlZDBYTDV3QXc5b3lVNkttNWZ3ckdmMnF3bStlRzNVMmZZWkRwRnRvdkxy?=
 =?utf-8?B?a2hJQTJnUDlSRTRKbjE1SFFlOU1yZmZSVGl0STEwaE03YTB6V2c3bVRpdEMr?=
 =?utf-8?B?STFUdTFXK3ZTRTBJazQ5aDgwLzd0VENRY1JNandyNDBHSExrTExlNmxZRlYx?=
 =?utf-8?B?OE1FaTJ2U0U3QnA5WDNydFcrYndnS1Z1RGhRU3NRVmN6dWdWcUhNZmVHS3Rv?=
 =?utf-8?B?TU5UZ0VSS25rWG93eGc5ZG9oaU4zMWpENzFvOFp6UTIyWWgramJ3MU9Vdm9F?=
 =?utf-8?B?a2tMUk12Nmljd3RpWjlDYk9hZFJ1MkR6cktwL20xNFlHdXp1ekMvQkJwVlBy?=
 =?utf-8?B?Y3lrcllmaGNNZ0hGNFlXdWNZajQybWtUOHhKZnJLWUdzTUtHUTdBemRGbS9l?=
 =?utf-8?B?b3FKWmZuVE5SU0drcm1ieGJIcHNkQjBaMmgrcVVnL0Vpdy94N1dIY3l2UnB1?=
 =?utf-8?B?a3NRZ2dYNnBHZlFtQnp3OVppVG5CQUtRL05CTENOUmtVNTNRY2pQZUt2eGRj?=
 =?utf-8?B?NTI3TTVPSmNxS3JrUnNSNHlMMHpYSHNBRmErdmVXbFQ2VittOFA0SHczZDhG?=
 =?utf-8?B?MDd4QVNnM3cyVEJ0enpYWTlhbjVVQmdxMk8zUlEvcHBIYlNESmNSMzU0RW1o?=
 =?utf-8?B?SnNOU29nekw5aFNwTTRBOWI2ZERUMWRMTkNBNHJOcjd6MVZQRk94QkEzM3Y1?=
 =?utf-8?B?THpoWkFlZnU5S2dMYzF2Z0s2eE5NSVE5TXNvcXB5c0xxQVhKTG9nRjd4Uk1C?=
 =?utf-8?B?SmxHSmVOSys3L2VOUko0L0VLNlA5RWtBdjRhSW5NS2ZLN0txUUVWdklQbWlk?=
 =?utf-8?B?OGMvcGRkMktmaFcrNDM3d25MbmQvQlJmWXlybTYyRExGWmFrQ2diVm1sWVM5?=
 =?utf-8?B?M1AyVEZDSnRlcDhhYW4wbjNmbEtIdTVnaTRHcUcyY3NNVmxPVXJ1eXR5MjNy?=
 =?utf-8?B?aGxrMU5ySTVIR1BCUGVCNGk3cm9BRWtUVnZsQlFNT2k3Nk9JN25rNnNLTkht?=
 =?utf-8?Q?3pN5oJ+iSFZhgNHMvQPRG2qqis12H8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG9aaHpwSlh4RmxtanZLQVZ4eU9zNVpaRzMyWjNsZHptM3VNZ3lPSjhoT0tJ?=
 =?utf-8?B?dGxGVE1lRUJzYVlHM2hibm9NMDN1K2ZLbU5OTlZLUk9TN3RQKzRXZmo0akR3?=
 =?utf-8?B?ZWUvTkgwaVF4TGNiWmRFR1QvZG9rWkVIZnJyM043MGdSb2RPZG1rMlQ5RkhP?=
 =?utf-8?B?VnBBNUlxaVBaK0JxVnFMelpXdDhRVk9xN2ZYR0RBcTRKVVhQek9FUHNScFdO?=
 =?utf-8?B?clFrSElGQmVYOHZKY29vZWdNcWdyRzlIL3Fsa0NvcjdwOGF3NG9PcE4vSkM3?=
 =?utf-8?B?c2s0a3hEaE1IUUEwbkVOMlAxREhSM3plWUJ1U2NKeDM2MURISXFHeVBuWkJD?=
 =?utf-8?B?Tk9jeXZpb0d5clJPa2NEWUxkemFCUC83N3c1dktpVVhZKzJnSUU2QXlCOFRT?=
 =?utf-8?B?UlphdnNtaXFKL05NWCtRY05SUklCMHFYNWpwd3lIZVdHZEVlV0p4WU1WZGRW?=
 =?utf-8?B?RWNqSUdNWTd2Qk5iRmlPWDEzcVloQ2U4NHEyeHJ5U2xJKzQ0ZFZYSWVqVmRu?=
 =?utf-8?B?dndWWTU5YzMxTy9GREFqQWlwWUQ5WHkxRmQrOFJEcTFiRnBOVjNiSlZiYW5J?=
 =?utf-8?B?SnZsMEloT1RtSmdUdHhtYm1QREZCU2hYUnIvRXl0NFdHc2hkTThUS0wvN0li?=
 =?utf-8?B?MytuS2dVdDB2eVl0MiszSUp1MDRObWs3UDdPZWVQTk5SVDkyLzBGcUhVamZL?=
 =?utf-8?B?VVlhVllQTDVUUXRNUE9sWURDSEh6K3U4RDlrVU1FdGtLSTBJbThpUW1RWlRo?=
 =?utf-8?B?WkZqd0IyMTFtMzJ6QXhyMjdKL01DRkltV05iQ0xzdnF6eE9DRVFOajlxY29k?=
 =?utf-8?B?U2MyUk14b3FxMG1TbG1yR0hUZnlraHJWUWpuSk5ZQ1luV0N1c0trY1BHSkZB?=
 =?utf-8?B?Mm1QMHpUTUpmbWNuV2lpM1NRMU1ZMEhFc1Z3QjVabWI1bkhBZUk5VXg2dnpU?=
 =?utf-8?B?c2pjVHJhQzRhNmpXN05VeS9qOWxIcmVZNGd4bytwRDNyVE5CeG1XY3BXNjBo?=
 =?utf-8?B?dmhZcnl6bzFZTFNTU29jRW9mQ1FuZlJwZWF5UTlNK3ZQajVwMnV2dkx4d2FO?=
 =?utf-8?B?THBXYzhEQ2NNL0wzTDUvUXhzcFo5UXlzWWNsZmhzZ3F2cFRrdmhHN3FtdFdV?=
 =?utf-8?B?UDFQbFlRNW5KdnF3anJ2ZDZOMjQrZmtQOFRYRGZRczU2NWo3VlhFYkhoWjI0?=
 =?utf-8?B?S0w2eHZCdHhXSFRZaWNKNnM3OXBRTjlYVFk5cXNBVHpvTUQwdklwRjRKMlc3?=
 =?utf-8?B?TmNjd3p3dVF2TXpBU1ExR01qbU9CaWM5Z2ttbjBZWjE4OGZIUWNCbXpMSk1J?=
 =?utf-8?B?d1BUSjhmSUViTE5QQUNBeW56MmF6RXYweUdEZWhocHRPS0ZKU1ljOTJEcUh1?=
 =?utf-8?B?eGJ0WmtKMUhHeGN1VVh5ZGJ0Q3pxMUNBbEozcW04bENzdUNDWHl4cFl1Zzhv?=
 =?utf-8?B?U0o0S1Qxb3JreWJEZUFTTWV1QmZsblVkRmRIV2tlSnBacUlyL2RLbnZIaUo3?=
 =?utf-8?B?VU9PbldWYnowVmt6M3JwMDZhR2s2MnNRVkU3M1hlNlIwYjZGdVRpTFdrenAr?=
 =?utf-8?B?UStOT1MzejBENHY4TXFrYm9HUHVqV3dlWFQwbDQ4S2xJYzMwdjlzRyt2elVp?=
 =?utf-8?B?Y0w4bFNoR2pPVTlrUGdrYWhGV3BVMXNwclpmYW1NdVE1TktLbFVMLzZhZmtK?=
 =?utf-8?B?RlU5VHI4ZlJyd2lhTkRpbEtTdml1Zlc1OHlzRklJYkdTNWVMU3M2c3laNFEz?=
 =?utf-8?B?YnJwUDVMSGhNUHEwZUdHUmx1QnFJbDVoQS9nSWFrZEo2RjFzaEc3TmU3b005?=
 =?utf-8?B?dWltdVdqY1Y5RGtzRlFOM0JlZG90dG1ac3EvZG00d1hoQlZYYk5BVFBRWkxs?=
 =?utf-8?B?WEVpYldvdTkraEFMMHR5MS9NUFUrb0V1a1c0Zk9heTUyNEg1dkV5NmtSQjhq?=
 =?utf-8?B?YVFqRzBxRGVNdWRlMmo2ZlR0RlE0NTFTMHhCVHQxTVMzMmpGS2ErMmhxdW1n?=
 =?utf-8?B?OWZPSDJwdXVJRzNwNlNwbmdKV2hZa01WbG1CSS9Cc0FpZTdyTEpaVUxVWDF0?=
 =?utf-8?B?eWFKMFdVMXdHazNwQ1BIQ2ZVQk5BOE1TRzVYRGdjcGNTdDM5RnNjT09GSzZL?=
 =?utf-8?Q?qn+uKkBcU0ViUWQxgGylbiX6v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b37f94a-978b-419a-e66e-08de0a500073
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5184.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 11:59:46.6778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed5S7D9segvv3ojHPQTK1ZyKiXcNVEkKk2RtQFOSAiLVEcVjqGEM/rtXGUY4fX6raBHIcZz0RfB1qVatk7wKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725


On 10/10/25 08:59, Jie Zhan wrote:
> External email: Use caution opening links or attachments
>
>
> On 10/1/2025 11:01 PM, Sumit Gupta wrote:
>> Add sysfs interfaces for Minimum Performance, Maximum Performance
>> and Performance Limited Register in the cppc_cpufreq driver.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index ab8cd337f43a..82141b45d58c 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -327,6 +327,49 @@ Description:     Energy performance preference
>>
>>                This file is only present if the cppc-cpufreq driver is in use.
>>
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/min_perf
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
>> +
>> +             Read/write a 32 bits value from/to this file. This file
>> +             conveys the minimum performance level at which the platform
>> +             may run. Minimum performance may be set to any performance
>> +             value in the range [Lowest Performance, Highest Performance],
>> +             inclusive but must be set to a value that is less than or
>> +             equal to that specified by the Maximum Performance Register.
>> +
>> +             Writing to this file only has meaning when Autonomous Selection
>> +             is enabled.
>> +
>> +             This file is only present if the cppc-cpufreq driver is in use.
>> +
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/max_perf
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
> Not adapted
Sorry, i missed this. Will update here and below.

Thank you,
Sumit

>> +
>> +             Read/write a 32 bits value from/to this file. This file conveys
>> +             the maximum performance level at which the platform may run.
>> +             Maximum performance may be set to any performance value in the
>> +             range [Lowest Performance, Highest Performance], inclusive.
>> +
>> +             Writing to this file only has meaning when Autonomous Selection is
>> +             enabled.
>> +
>> +             This file is only present if the cppc-cpufreq driver is in use.
>> +
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>> +Date:                September 2025
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: Minimum Performance
> Not adapted

Ack.


>> +
>> +             Read/write a 32 bits value from/to this file. This file indicates
>> +             to OSPM that an unpredictable event has limited processor
>> +             performance, and the delivered performance may be less than
>> +             desired/minimum performance.
>> +
>> +             This file is only present if the cppc-cpufreq driver is in use.
>>
>>   What:                /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:                August 2008

