Return-Path: <linux-acpi+bounces-20829-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFE5ETrDgWmgJgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20829-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 10:43:22 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B242AD6FE7
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Feb 2026 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E18003071EFB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Feb 2026 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A70399019;
	Tue,  3 Feb 2026 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IwlebDoD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA5396D2E;
	Tue,  3 Feb 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111703; cv=fail; b=npblOd2UcL/tQMUSYS9EwKSvo/YV2L9+Rtx8w/jv/ubboyC+9HHUnWiCRa6OE6WZzk/dc/r9Lt/TDbZTKXoEjqwvVD1z3WmKaRI4DXWcQ31X8F6CfK2b+F9Civecf5AhZCm5OmbAh+4cmfs66GO1vMRdiu08xMRa4V+ePkFGYLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111703; c=relaxed/simple;
	bh=scDZ9fGi1LfVL0ddVv9f0CJufIFOK67AJ6Mg5N/dEyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H1jqjnU4vesVCS9/AihFODWpuIFb7JpJdmlzEYbyY7cJWSdIBv1Kv1grJ/+1xbkpIwOfeoVKxtReJ7j2Klj+qzm3RXYwRh7NxnRLkZU5UeYRQB0QzOqJZWNTO3bdvKCh5GMf3BnWQNc+6h0hGsx+GhUB8SZ5lL+ZjCw6SNxeN9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IwlebDoD; arc=fail smtp.client-ip=40.93.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siDTR3JiHy2qsevSF87p3Ag/c4oTK98O0etcQ1QPdrqCnRxNq+CfsQf9aXN3sqn/ZeLIN5qBIXkv2IslG/3XqwmtebHiHzURnAbFoYZxzt4xVUZldptfKS1BrY8XVlf5hbIX1UbrwmUoMP1Y0BEOykXXOvtTfAkV43VQkFPDyyfgv6td8dwbRhfpF59gAtKSls1EYCckn9cxHfILzBvdHaSiFx+Bm0QXLryhSLaNHtP4IhDZQs4ibdXiRRdzrJx3ELkDMmz1E3+YxUNbjvJZYLprok3pKPtlnGSr6Vw2t/ijOE4fegi7f5KYe25RPVW4A4KD+qsLGI0uM6FT3swWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scDZ9fGi1LfVL0ddVv9f0CJufIFOK67AJ6Mg5N/dEyg=;
 b=q4pMem5hVS0W27YPYpsj9MeZjlnAezsPhQ4+noEsHy3AszI5cC43vEqQTG7n+nWrpRX62hlmumJ/PFfpeIhksa4fl+Wk73zucZ5kA3Ovz8jx48V+vxHeZO24L1jyeqkCxOPK9d3mTMi17uXkbhoCTu8kfuwgeyzGJ2MM4uCJIxlnhDHQNh9yqnK898Bp/eG/uM2oFE4KjwppFZ2fZ2L6Q7qHpXfONsT//MlfGij45yMRfwL/5SLJ8WWFpA338HmBE2XCAxjkhxsh8JlCWvvj4Bx3Ca8O1otiQS783wzSLRx7IOx0KwzBjpO8TwDQnQu6eCZfWvfE1d8O5ZYElSe7Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scDZ9fGi1LfVL0ddVv9f0CJufIFOK67AJ6Mg5N/dEyg=;
 b=IwlebDoDgCeAU4i4vWU3TOC+FIKS85p7yxwl3Yi1Lr6iV6oKNhUi1Qvu9JvzYHH2RtLkrpehoonBbhlKWx5DBMD9PcUuJY6bbMR9WqaaD8PRwc4jFIQtOVgl8EqMwb2z3KalHj3RipIv195vRWnI8dEr/SF7A16q++AJvgzSMzJPxM9xChduR1dsEnAXiE/tEQNdYFgtV+CC9e1RIt2XfVjgQRjp6F8hSHubzVd97fdl+r0XhRv8CpLwocWSElM2xmRMqloBUF3W/mpOFGTu7gd9m8QvPKxT3Tye1UoyRwob+xX53IJNutMj37ntKNXlQAdEEmzvsjzOtYhyNHkk/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:41:35 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 09:41:34 +0000
Message-ID: <944fc140-e5c5-425f-a6ad-883e87eed8a3@nvidia.com>
Date: Tue, 3 Feb 2026 15:11:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Russell Haley <yumpusamongus@gmail.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>, pierre.gondois@arm.com,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
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
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::28) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 611cde3c-4354-4642-4af4-08de63086b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHRSR2ZCeElCbU1BMkg4MEFzSy9XYnRGeHdITW84ZWkzbVB6OFY4OHZnVUxq?=
 =?utf-8?B?aWJYUU1BMjRBaTZ6ZnJRMC9MNjQyUm1rRmkrTG9GQWl0eVZRamZwSm4zblhx?=
 =?utf-8?B?bjM3d3Q3dzNhRWg5NHQ3blM5TmlIUi80UWRWQTRJUlMrd1EwWXFpK1ZSaFg3?=
 =?utf-8?B?am1WSUdaMGx6YmJrYVBBRFBFQjdGVjNuMk5UbFg5NUFtc2x4WFNNaFVUYkE0?=
 =?utf-8?B?bXJrS1ByTXhDU3l1L2ZkTXhmdHZBc2lWRCs3djU4Ynh1cUtMaHh6MGVpSWNk?=
 =?utf-8?B?MHg1eEdHdzBydTFqU052QmFnSXVnR1d3ekF1ZWNRRktta2FjQXZ2Y0hqNzVu?=
 =?utf-8?B?eVFoZDNyaWJkaVhENXB0WlQxNlhOY0F3ek1JQXp2Mzd0eTFDOUZkY0diZjY3?=
 =?utf-8?B?NitCQjF6UjljQ3h2UzhEaDdGWmtYaDlKa1lTb1AyaFNmbUJlSTN2dXNQR2hp?=
 =?utf-8?B?Nkxtc0tpOE84STVSdUtwNHFuV2hOaEw1akRrcWxZSVdrMGxPZU10L1ZwdEJ4?=
 =?utf-8?B?SlVyb0VyTCtHZ1JVNjI0cktxNHRaYkRuSXRCSmlkRTIyTFRvd2Fqd1l0TFBS?=
 =?utf-8?B?RUthdFRLUTEyU25UcW9hR1Y5eHRMc25sRFF0SVRtSUNKRitXaitRems4YUg0?=
 =?utf-8?B?RnNQSU53c0d2ZWxiSEkzK1NOaUoxTHpEYStzT0FESVRzQkJtcmM4UVRsZk5t?=
 =?utf-8?B?ZG04WTA2NHpHZmUrek5taHZVS2lNejllZXZ5VnY5UE12RnpXOEFvZCthMk1D?=
 =?utf-8?B?dVRMbWc3VWRwR1JKd1RuajRCWlAvN2dJU0RaNDA0aVg3ZnJlVWU2Nk56UUt5?=
 =?utf-8?B?QWZ1U1pqWk9oYnpPYURzVEtuTXgyQ2VZbi9pTCtnQVcraXRIbDNrblh4NTB0?=
 =?utf-8?B?NDFiOXBsTkJwUzQwb2pLTE9nem1VTFlJQjI3Sm52UTY0UVRjSm9WWkNFdC9s?=
 =?utf-8?B?eGtpcHFmL2ZlbUZ2NWkyV1U3Mm95WFJzM283cllqSS92L0t0VUU3TlhFcUZn?=
 =?utf-8?B?UGdSYW5NQUxnaHMvU2N3ZDZ4Ykt6a3ZCbUtsNEpydVQ1cDdjQVI0ZDJTcFFr?=
 =?utf-8?B?MzhMajg2djl3TUpjUk84dlJONC9icURZK2RRem1mTm92UzhtZExzL0hHcllK?=
 =?utf-8?B?UmJOMnBBekhQY3RwaFVZUk1SZStoNFU2RGJBU3NsNVZGeE4zdTlaWTBzWTJH?=
 =?utf-8?B?elBCLy9LczNGWkljd2c0Nld0VW9VTUpUd1JaeUFNZnVTdXZObGZJVUdBdjI5?=
 =?utf-8?B?ODFHVGllc3g0eHF2ckhPWnNuL1FmMDY2SUh5eDlLSVlBWVJIZFk2SUMrR3Z1?=
 =?utf-8?B?eDdJSnBEOG1jOW5wN01kZ0M1YjhubGY5REtSbVhnbGpwUUoxbGdKNm1hKzVp?=
 =?utf-8?B?RmtSMWxqYjBEb083eG5Sc3R0aUpkcXVBeVFlQnRQWmFLRVlXTlhqa0RNaytG?=
 =?utf-8?B?elBvZ0dCb0RYYzAxK1A1K0pJQ3JuMFRuVEZ3c1FuZUl4NmNOZEpzckFsVlVJ?=
 =?utf-8?B?QlBqR0J5R3lqSElqRkVCbnFiU2lMQXF0dHZzZkxjUUhqT25rdnNQRjBSVW12?=
 =?utf-8?B?K2xRbS84TmVpQzBGRTlZN3NoTHZFME9wZ05vbkk1aFdXbjlaNVcwcmRhcldV?=
 =?utf-8?B?aHpFVkFITzFWallBTm1kdjhOWndDK0dBQ0ZBU0JtT1FRVy9ac1FVZFJ3UUQy?=
 =?utf-8?B?cjFzWkVlV1JCTVJzZTJFM1o5aVV1N05FRHhxTlprYWZtQjRvUVlBYmpqaDVH?=
 =?utf-8?B?TzJDUmE4TFdTTEZDSzFqbjV1UldrbkpoMUxEdm9WVUpzQkF4eG5QbWZOOGJp?=
 =?utf-8?B?V0pYRnRIVElrRTRrNkJEZWhoRDF6dlZFejVjMjVzVXBVWTBhK1JURXpFTTNT?=
 =?utf-8?B?V0JuSDM2alQ2TXRSRWlnT04xRGg0dStsc2NJd012ci81RHQ1T3ZWcFU4dEdJ?=
 =?utf-8?B?U0R4NEQzbzlXVHFmd0lUQ3JnckI4U2RNZk5aTVFaVUo0cGZDaXRVMjV3M0pk?=
 =?utf-8?B?L2Zib0FHMGtaUW9XNXZaMmozc0pFbHdkZDFoazl2ZFgxUThLODljY25mWEtp?=
 =?utf-8?B?SzJTM3F3VGFkbkJDR2lVSDNFQWVZemdkeS9DWVZxbk0vdnA1aXpOcXpUYzJx?=
 =?utf-8?Q?7B9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clVwcWRpREhFRWN6c09rSjBiNStsdFExbm1jU2NwZnJVdDJFMkcwOG0weGJD?=
 =?utf-8?B?TkRBeDFhZExZdy9WKzJoMysvNWwyWldYdUZDcGVVSlQ5cFgvV1ZOVU41aGJ3?=
 =?utf-8?B?aTRYeExMMWZDR1g2alc0bUgvZGVYeDdUenI5UEJZWW9wdmM1eGV0bzNjSWc4?=
 =?utf-8?B?RjRJV3lvcVRzMkZUMzJZU1VNbjNMZUVVUjNUa0p5ZHdxRVk4ZU9xeE5RQjNL?=
 =?utf-8?B?YVZsSWJiZUZXOTE1U0g4WXZtNzltYUpWamJKQy9oVS9Rc1RtOXlIeDZaU21j?=
 =?utf-8?B?NUY1OUpzMlZRaTRlNmNyM1F3QzArcWpIRm1BdlVkL01qVGV5SnRST2Z1MVM1?=
 =?utf-8?B?UUZmcEplaDMxWTl4OXVUYzNvNk56RjF6NWRtK0daK1A4aTRiaFUvMklyUHJk?=
 =?utf-8?B?bTRxc0ZCYTJkY2FEVnNsRDI1WlVKMW9Fb1VxRzZpYTMvNEVVQ0xDYjFuTlVs?=
 =?utf-8?B?SUF5cXcyZWtjdS84UERWSGxJOGQzd3Bxd2F6L0d0Y2ZVektCTlNZSk9HZ2xz?=
 =?utf-8?B?RWZhQzFrMDVGcVZwQW1obHRSdktleTFrL0VVYUJBZDFuUmVQck9mRWpMYlVq?=
 =?utf-8?B?eGcvN0RFbTJwdUVEVm9abSswbEZuK3ZNSWl1c2cySDcxdmw3MWp4K3RPSjd6?=
 =?utf-8?B?WC8wYU1jQTVza2VTUXRaT3BFWHg2eVRBdGxjTVBIb2kzVjdtM084S25LVEV4?=
 =?utf-8?B?VWtZWXlmVHVRaVdtVUJpUFg4b0E4YkFCR3FqR2hzcGpvUUZjaEt5bVAzeEph?=
 =?utf-8?B?QlJ3R1ZaUk1uVUVuY0FiVUl4dGt0WDQ2OVRyZCt1eksxMHIxV3BYL3huUnQv?=
 =?utf-8?B?L3oycmJNRVJuQnBaRUFHaERQSUQyR01pNWlNTWFqOGY2bUVGUzhMbDUvQTVs?=
 =?utf-8?B?bThZZDNvbHIwWFVBQTJUZlJpVTlOS2Q1Y1IwZktSUFA1dFV6aGJGeENtTGVv?=
 =?utf-8?B?czY3bXdjY1lZQ1oxa29hSzFSV29EbmVDdCtIK0grMTdyUkd5aTZ3c1RxMkcy?=
 =?utf-8?B?MENQd2JQQXJ4bk1hRzc3bjhYdlpaQnk3NFU5VVpmMVFaem11RXRiNzdPZE1j?=
 =?utf-8?B?dURTODZJMkpvM2p0WlI0aEE4cUFxTlFmT0RpZlpISnRIaEtINURIL1JkUUgv?=
 =?utf-8?B?MWM1Mkp4ek5iK2JUNTlYN2FIQVZOdlQwaTNuQ2hQVllGdXlUMTBlUFBRVElP?=
 =?utf-8?B?TlAwSk9kS3hFK1VhNWJXcUpZYjVQWlM0WlV1bXc3MTNvMzh3anZWN25rOEdn?=
 =?utf-8?B?VDREZEZWdXlqSTNLSVE1UFlLVmh5a1g4V3F2TFc5Y1d1RHJLdXo3M0tCaXdO?=
 =?utf-8?B?M0FWQzFjdXlKcDZaSnVodTdvTnNZTjZtVXpub1JWWE53NTd3ZktiRys1WnBN?=
 =?utf-8?B?QU16aitLVGxuT3lQSEcyYXRLYmowak9xRWozNitXMklVeDlESzlCY1FUeVpK?=
 =?utf-8?B?QjFsQk5iRTlGeVprdG5LUmxJUjg5aElBUHhWblpyOUpWMEVZWCszL3E4bkQy?=
 =?utf-8?B?SVV1Qnk1b3dyWFl0SGhxOTY1bnA4L1VGNUZlZ1Q2eFl1d2o3bllPczFwRGZF?=
 =?utf-8?B?Umw5Z1lvVHVVY3l6NG1VcVJUMkVsYWROWmtCY0JvVWtSN3hqSlB5ankyWDVm?=
 =?utf-8?B?MVZXbUx4Z2ExYTA1bEMrR243MGxGMW0zNnllcXpvN0V2SkQxbzBEWk91bGlj?=
 =?utf-8?B?MGJOWHhrL3VKS29rSkFhYzF4ZkZJT29SditnSlpyS244NXlqOVZoWWgzUjZW?=
 =?utf-8?B?MlQzc1V5eGVxUmI5RXlSODhZQ2g1MlRGQy9xRXBwSm83eWE0M3dsSUhzTzhv?=
 =?utf-8?B?WDQ2WG92QkNIOU5BTkEwNUNrYkVQWUJ5Snp2TXZHbkowYmx3K05IL01aNVNJ?=
 =?utf-8?B?ejgwUkJWWnVVZUkrVys5QzE1N1lINkNGSnNXUlNBL3hyODNiNCtabzZ6SXdu?=
 =?utf-8?B?VTE3cXh2TzRxVmVsNHVweDVyRTRPNFNoNE5aL1UxNWNiaU9vWVkybTdpbExk?=
 =?utf-8?B?ZzlNWmh0bU02QmZIeWg0MEdlNXNrWFhyaStnRzI5c1NqRmFvMHZ4S1ZZY3Jo?=
 =?utf-8?B?cEp5Q3RIYmNvVCtKRVZqR0tIejZKR2NLNnNYMlRiOXJwWlNDaVN6dmNySUMr?=
 =?utf-8?B?WHhLOUZvWkk3aUVoc2U0ZkRGVHNtejBTVVgvQk5SekVWUk1OZy9Kcm9oZDNl?=
 =?utf-8?B?ZmJsVjdaRk1nS3dyL3J0cmhKa2E3S2VYVkVSQjhNQjBHWHd2Z2lrZm12QkE3?=
 =?utf-8?B?ZFpFRjJxVlZnZGJFU2QybUZmWGYxNXYyZ0hRc2FxeVBnWGRSRTZEUTlpZm51?=
 =?utf-8?Q?gTNEEyP+rmAG8Lpx7x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611cde3c-4354-4642-4af4-08de63086b17
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 09:41:34.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGH3o3djcjNYottAvwBwV5gNUfbE0pHcHaAF7Dpfbw0sJ/x0dGaatPadhnDTthtJIBsfux4LiDxnJPgxGfOH3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-20829-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,arm.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B242AD6FE7
X-Rspamd-Action: no action

>>> Hi Sumit,
>>>
>>> I am thinking that maybe it is better to call these two sysfs interface
>>> 'min_freq' and 'max_freq' as users read and write khz instead of raw
>>> value.
>> Thanks for the suggestion.
>> Kept min_perf/max_perf to match the CPPC register names
>> (MIN_PERF/MAX_PERF), making it clear to users familiar with
>> CPPC what's being controlled.
>> The kHz unit is documented in the ABI.
>>
>> Thank you,
>> Sumit Gupta
> On my x86 machine with kernel 6.18.5, the kernel is exposing raw values:
>
>> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
> /sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568
> del:437439724183386
> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
> /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
> /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
> /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
> /sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
> /sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615
>
> It would be surprising for a nearby sysfs interface with very similar
> names to use kHz instead.
>
> Thanks,
>
> Russell Haley

I can rename to either of the below:
- min/max_freq: might be confused with scaling_min/max_freq.
- min/max_perf_freq: keeps the CPPC register association clear.

Rafael, Any preferences here?

Thank you,
Sumit Gupta



