Return-Path: <linux-acpi+bounces-20602-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKWxG8kmdWlXBQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20602-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:08:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE97ED49
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 21:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92096300C00C
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jan 2026 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AEA27B340;
	Sat, 24 Jan 2026 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ee/QVPMw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801326F29B;
	Sat, 24 Jan 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769285301; cv=fail; b=uTV13FV5zhiTlryHslIqpTRxSRCYX1doTFaaN+P9kZKtQ9kQ1K+ZB7ixpYNgiCNAYHBDegY18jNqc939JCVDUcXN1nBlURsjHhRX4o11dz0BH/xi+wrnoYv0yKybzirFg3pY14ihpybvP1gYsNdwR5PKHj/vr1zjoaTk2rql7wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769285301; c=relaxed/simple;
	bh=0hgHcw+9wCiAMaH5kE3GiSQ+xa3gzSYXPF1c7rjMhcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=er/DKK1pMJjRTPuB9SlbCeFOhEBhlsWPDyyjJyD86zIk1T7si9uIz4PjL9dkojeG5mVznTOq14j3qYLpN4KMQuYPc6DYs8UIFL+3SYIHKdu5A5Am/FEQKTKicbwmR9UvqV04ovw30/D53eqHT2DACy9CDkXHSp50TA8pEgjAcTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ee/QVPMw; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ0bzDyglamahbe7B7VFh1qlunoIGth9TNpwP2PMZTK5/tMYyTUEzrKncBvPCjaUsegGf4a0UUL3zCPgCJV5zdrxSpGkJ5DEvSdwsMyFrdKopzfh1QhIogB+dfXrEuzO3vC0t7YToEoMLdRZxCvrmqe/4J69aaSTvPuWl+zkvqEakAI3j4qeB7tYX4nGb0djvydAirsAeZya9ZO6B2cWKnADrG7DEHDDhSiaPnKIJZdzm7KIu88YWJYWGFs2zMGgAeELpBoDtAg09U841YinFcJ7xcVQjsMN9+LbCCOdDzJFiN1Ed7+LwKXp7qqsZdhFvpZ78yU33QEc2/HISzpz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3k+Q18AqDM8dBoq2uuT8U5n8z5h5hQM7a18abEUYpg=;
 b=nayzhqPICjSakc3uL4cbJjPx2jERI/DN8R2xIh2IHgacJY6qnyLEqsBQuok5ND5i2uuRd9DXpTA0S2Km5PxZDyUP5carnkYrmur5zDtdnPmyJb/0EwKWJB3ZrVmSrhHZW4HGQxu0gv+xuyRABsiQCNUPt5xVACvbNpCVeCliUkYLuEZ24chfj9xh5cKkbUZvZ4CrFcxdWK8zqqorh1oDBRBucejy/3bukhgzx1WgcPIc8UjEi4T23g/YyOCkqkL1L6hrT3aj83pqD/yEqypd5IU1JcijD2SMUGHAK4YymnEIA/8BAM6VquazHl+YTuEcQCOjnH9vTQWMiNhgQtmPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3k+Q18AqDM8dBoq2uuT8U5n8z5h5hQM7a18abEUYpg=;
 b=ee/QVPMwwM/07x0qqFXwp9j6WlbA9Y8XhdK0u+emKV0cYz2dw/HCRMFNeyQV56/DcUC4H5kJhJBqg+MnPa672iDKXss9M1tj61LqVAoaFaDtsh4KYGTPFF/18GxBLd1p10HLhrtzLbml0LF5guZe5uNqH6WEEmoH0En/UdoHtw9cTvCGPA9YHsaNfpf18fLkMMcRsE/cuIETY817O1/0gkxstz7vDTVG4GauVM8r02nDi4OvYdurLK1uY+CyuI6MoEZ3uww2/AgHHGTJdGP3RpjYzY1c/had8BcvIIk8oWwz9Pyb8vd/E51zvqYuhMurHRtghm0hfeU8P/tO4oUWqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sat, 24 Jan
 2026 20:08:15 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%5]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 20:08:15 +0000
Message-ID: <86303677-6124-424f-999d-c420eac0cceb@nvidia.com>
Date: Sun, 25 Jan 2026 01:38:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] ACPI: CPPC: Extend cppc_set_epp_perf() for
 FFH/SystemMemory
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com,
 ionela.voinescu@arm.com, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-6-sumitg@nvidia.com>
 <a7a4d351-eed3-4ea6-a84f-e525b7ac13a6@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <a7a4d351-eed3-4ea6-a84f-e525b7ac13a6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: e70332ee-ef8f-4b72-d90a-08de5b844edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WCtZUEhlaFBSWUdNaU55ZUFTbjJhWFd5aXA3dlJldFRPVlBkSkQ4a1hReGg0?=
 =?utf-8?B?Vjc0cGdPbm5UckpNY0dlakNOaUZOeUZiLzJ6WDVhUVA1Y0VNaVVoV1ZlcXlq?=
 =?utf-8?B?Z0YxVURDNCs3ZW9MNWh4SHBOYzNOSHpOR1JFdXhpdUNkd1FFV1hsZk9RTW5E?=
 =?utf-8?B?eCticVdvUVVUYmowdkhTbkpRK0FUTTh3dThialFzNlNrYUExN1M5NlJuOWd5?=
 =?utf-8?B?dE5wRzg2UFRoSlNveHl3Z2c4MHc0UE5TUlRYcENWUnpkbDFxb3FIZmxqSEpu?=
 =?utf-8?B?bkM0c3VvYXVxdC9saFlHdGVnbWNzTVk3VDVjK3RScys1QlpKVyt2dVdBYU9I?=
 =?utf-8?B?UkV2SnpTd3JPMlVIQkdmbjZGUVk0N2VUaURxeFNXZndEVG9YYmVPZUpSQlpm?=
 =?utf-8?B?NjZTeW5hU1M4SEdGU3B6VkVYYnB0M3lKdFFUWkpndGVoUC9Rci9hK1BtbG15?=
 =?utf-8?B?cDl3YWExdkRDQkIxYTQ4cFVUZmtHZi9vUzVHd3ZCVGNzbUF3dHBTMWJzZVha?=
 =?utf-8?B?RnIwNGJMV1k5a0swZmhQWEFWVjg5cFZMWkh2TzBiSWdyQkswb0lRRGI4eDZj?=
 =?utf-8?B?N0NVSVdwcG0xWnRtUTFuSjFYWGVoYm9iazNHelZ6enVaK3VZSkd1VmVYd28w?=
 =?utf-8?B?aDJ6ODN6ZC9KOVZrT2p5Z1JIU2VJUTRPQnd5NW5taGIwaGRzTUljcW1qOVp0?=
 =?utf-8?B?TE1PcnRlQzA1QytlTnc2WFNlZG4xQXN5cHdYSWpEcndzK0NMY3FaVTFoa1RN?=
 =?utf-8?B?U0VCMmNuMDZ6dmwwN0tFNzlSK21DUlo0b0I3VElhZzB3WHl1VktnMnBCamR5?=
 =?utf-8?B?eGhwa2lKTGY2R2t5U09UTzJSVkpXN0U3YTNjazVPZ21vNzhuQldveUdMcEsz?=
 =?utf-8?B?TzIvNDVOT1ZQdEV1S3g5eXVabkRLTVhFZTNPcStpZ01pMWpFa0Y4NHlKOE94?=
 =?utf-8?B?WExnSnR6dW5ZS1VPUm9IQTZkcmRWM1dzTlprUHhJYXNhWFVWaWh2cTc4T3Mv?=
 =?utf-8?B?R1BaWThxaVFQdUl6UTBvd3lqQkFUTWt5TFZHZDhOOWh1anhMcEZ2N2RyN1U4?=
 =?utf-8?B?SDFtdDl5Z0txMkp2WmFNZDNKaGZ2RXJBckhOTTF1TUh0dGlrbkVxSHpkaDZt?=
 =?utf-8?B?WEVlT1p4OTVSb0x0WHdnOFdvZDMwaEFMTjE0WHo4Ni9GK2tWbmFtSlRSR0VF?=
 =?utf-8?B?YmplcFBPcG14ZVFpRnF6ZkVZUHk0SFhiQWNvaGlGN3hMMEx5NlBabURRc2U4?=
 =?utf-8?B?NEtQVzUvbTJPUkZMUlBJTE1vdzJ5L25YOEpFK2x4UzFNSkN1aVp5bW1qWmlP?=
 =?utf-8?B?cGp4TWticUhnTWJLY3lzeGNmL3VxUUNZbnlWSVNmV3AxQTF3VjlTOXVVajNT?=
 =?utf-8?B?MUM5c2k4b2t1T3RaQXJyMXFwUGVDMnFSZndTclRBREx5REwydTRBQWluRTJG?=
 =?utf-8?B?VDF0R1l0RXlzVmpKTmx4SWUzc2UrTytXUENXYXkyU1c4TTd5cDNieU1OWXRY?=
 =?utf-8?B?SFMvOTFpRldYdVNKcUY4SDlGL0x6THlZNFJ5L1czY0FVZlF3OWl1bFRNSHdW?=
 =?utf-8?B?VmwveDhTcmVZUzNaeFQxY0RwSlpJbWRQMHU0bE5jTk10ZmMxd3FVak1KQnA1?=
 =?utf-8?B?TnFmSGsydEdTQWtzczMrMVh4THRFZmdqK01KSzdjbDhWSkduZzdLNUJ6V1ZJ?=
 =?utf-8?B?RzA5Ym5QRERvTkQwM2JpM3J2NDJKdjZBUlNLcjFJcWl4VkttTWUxZmhnQk1G?=
 =?utf-8?B?bVRzby9IN1ZSU0ZCcWFVQVpYTFJ3UmJRWGRUVzh4K1o4a3NqM05oU3hkd0lw?=
 =?utf-8?B?aTFkcFhQZXNKdm9VcTBpMG41VllZUnZZUytZUWEvTk1nSTVHWkJEUmtYWlZH?=
 =?utf-8?B?Y0xXK01yZ3NRVVVsMUlpOGwvdUlxYUEwUktNMy9CeFVLU2xDbUhwSnlHT3pM?=
 =?utf-8?B?U0dTVFJvUmZvS2k4d0s1SUdzZkZLUGNDYk91eUZ3cFVjRHpkKzJsVEM0Y1JC?=
 =?utf-8?B?U0JXOGo1eGVjbjJhaU5wWU5zaFo1M2pBeHBxcUdtK3pzWlI5Rm9CUjU1MGNK?=
 =?utf-8?B?WTVOc3BzYUhzWGlJa0c1bi9mWmtxZkk3UUd1ZlhoTVJVMUFsL0FpYTVHaVFL?=
 =?utf-8?Q?BVP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3JKdytWbkt4RWxuOC9uOFpOMHUvVE8zVXorOHhjV2w2b3JkM3BvaGxrZVdj?=
 =?utf-8?B?ZFllb2ZzeEZwT21mZUZXQ1ZwTVc5WkVOd2NCQW0wVHNZU3NzcTRBdHg2ZitL?=
 =?utf-8?B?U2g0N2t6KzZUaEZPa2sycVFXKzFqY3BYaTRmdEtvaWs2ZGF0NS83YWF0VUxR?=
 =?utf-8?B?dEdEWDJSRGpWTHViTi80cEc5a1c5cXE3eWE2b1Bkd2pyMzVOdDVFWDR5Z2VY?=
 =?utf-8?B?b2VxTWlETGxYMVpscS9VU0w2ZUF2RWdTMldyTkx0MTN0MFNLajlzZFVSM1hh?=
 =?utf-8?B?MVJnOWx1NlFQK1BOM3d2RDdzVTNTSEZyazRSbzQ0TC9tNzMyY29kZ1h0QzlU?=
 =?utf-8?B?TlFzajRYbHdWaDlnbE9PbFV4cUxZYk1INnFIeWhBTGFiUW5pdlpRV2xsbERy?=
 =?utf-8?B?QklJMjhkbTVLeVZ2WmFvMlhBbmtoc0liRlhBL1diVm9jcURyNzIzOGhWM3Rm?=
 =?utf-8?B?ZWhCb3lPMXpZK0piOU1sRlhxZFpnNjNYd3pHQThGMTZuaTU0THN0Y3AvUWFr?=
 =?utf-8?B?OUV0aWVZeHIxUmtuZ2V4NmdlTGo0TngyVVExMlJrdzN4OUVCeG8zem9odHBJ?=
 =?utf-8?B?UURPMHlMUWxyd0I2SUlsWHZPOWhCcEdJR0gwMHZCcXlqNHNyM2pRNnRPcmQ1?=
 =?utf-8?B?emxlWm9hQkdaNFdoMmdOeklDK1RsWStyTjhQelo4VzZQL3VMM01TNDY3Rkh3?=
 =?utf-8?B?YzFFVVVEZytMUW1YK1gzVXZBOWhnNE5icmpoUForVHNzaUhBYllLcTNxMHhS?=
 =?utf-8?B?YTNJOWVtcXpTMXRjZUVwZnc1WHpUY25naVQySFpIeUZVU3B4bUxXTms3UnBE?=
 =?utf-8?B?RWNUek9NYjlIbCtlSmIxMjdOYWx6UFVZVUtHbnpmWnhNYzVhVks2dHJaYUhv?=
 =?utf-8?B?Vi9mWWx1eWtNd0xGWDQvMUlSaVlNK3QrNnBGZWJ4cGY1MkRDRWk4NmwrZ3dT?=
 =?utf-8?B?QjNWd0tpdUNPUnlPOVN2MVNJdGhROFF1UU9ZOTcrb0dsaUs5ZTg4ODc2RElz?=
 =?utf-8?B?RDZsaElpazFXdjZGaEk3bWp0eDJ2cTBqV2RGZFloaFl1TmF4aHJCeE1SYTB1?=
 =?utf-8?B?ZTArZ1pCdTNlRGsvdXdpZzE0R202Q05yVUE3a2VKSG5YVWlSd2RHSThhUjk0?=
 =?utf-8?B?NUMxL1lDaTVtU3kySHNsa0hITWJJenY5QUlpOFdaTXNwOVlIT0RUeGkyRVJp?=
 =?utf-8?B?YlRqZGN5UFkxaGtWOGVmd2Vpb200UjVwVXM5NVdQZ0NpblQ2cjJtN20zVktC?=
 =?utf-8?B?LzVVUE02Q3oyNlk4Wk1iMFhSWDhtMGhoVWVNUmQwSXJPOGtPVGtDN1BHZVN6?=
 =?utf-8?B?N09qOTZOT3QvRmp4M0xSV3k1cmZzbW9QekdrYXVkZ0htalJETHlHOUxyYUNm?=
 =?utf-8?B?ZjFTYVNoMVhKWWREdWQwdGFOZk1UTUFmS0RIajlMaEhpQUROb2FsYXdZVnpx?=
 =?utf-8?B?TFlONkplV1AyVkRsaGpKSXRVV0lucVgxcWJyOXpSNE9VVStOT0hMbjh3QWZn?=
 =?utf-8?B?YTliNGovdGNVTjI4bjdXSjU5WUVieDBJMnZqYUF3MUlZeU5qWU5EQXlWeUdh?=
 =?utf-8?B?UzNMdzllUHVNSldpNzFtaXphNE92UVJvVkE3Nng3S09WN2dPcXdjditSMUhY?=
 =?utf-8?B?ZlVuQWtHVlVvV0x3TXJsYTZlRW1qc1BkdkFrd0lMVVhFd0hZbGo1M1p1MHJW?=
 =?utf-8?B?eUMzMkY1bXJnUURMWll2eWpSZk5KQ045T0JNa01GbWhlTk93N0NiRXBlRGdC?=
 =?utf-8?B?MkFrUVlzcVZhRmEvc0ZPU0NTUG01YVVqT25oZVptOGNOb0tZbW81bnRoRE9Y?=
 =?utf-8?B?cjlDekJKUm9DS0VFRU9OSlVHR1VQMzZad1NCcThMNDhRUlozQVlxcVRSWThY?=
 =?utf-8?B?aTArR21FemxOcDZIKzBuNERXOGJJd2xCTW9TR0dUWm1jandjY1M5ZVlxaGJD?=
 =?utf-8?B?Qy9oT0IrVnh5b3N0d08rUENhWlRtVlpod2NkeXUwTzFYcWhlZUs2N2Z1UG1F?=
 =?utf-8?B?ODh4ZjZmL0kwaThlbE84c3VHNEFBZThKVFpjSjA1WTFvT3JPU1RqQnpZM2ZC?=
 =?utf-8?B?SEllYkdMZHhlejlhZkNDTEtmcGFnb09WTlVJRXpmVXV3dmdEL1E1SUpHeHpH?=
 =?utf-8?B?SlZzMEtlZlJDUTdrYTA3aURKeEFNSWFCRmpNQnFmbDcxY21NR3FqVFpxNEN2?=
 =?utf-8?B?YktrMXh0M20vdGN2aThnZnA3R3lmejBVTHlFZ045aFBkbHdnL2MwaGwwZllP?=
 =?utf-8?B?T3JFTnJFS2xPQ1JUcEhRM1h6Yi9JZUJHdE9aak84QjR1aVVyK2dRcTlsV1ln?=
 =?utf-8?B?MmtyUFd3RVY4SlU5TEJLRzF4cVhsY29pakM4V25odXo3azVyc0xyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70332ee-ef8f-4b72-d90a-08de5b844edb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 20:08:15.3594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c12+h/u57jk5Wa3NmWG7gLi59GAL4rKEhNxGhUREv6AMw1oPaS8jVXPV7stJmEuJVtHDlGUfADSMbYLzi0D6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20602-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: CCEE97ED49
X-Rspamd-Action: no action


On 22/01/26 14:48, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2026/1/20 22:56, Sumit Gupta wrote:
>> Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
>> registers when they are in FFH or SystemMemory address space.
>>
>> This keeps the behavior consistent with PCC case where both registers
>> are already updated together, but was missing for FFH/SystemMemory.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index de35aeb07833..45c6bd6ec24b 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1562,6 +1562,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        struct cpc_register_resource *auto_sel_reg;
>>        struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>        struct cppc_pcc_data *pcc_ss_data = NULL;
>> +     bool autosel_ffh_sysmem;
>> +     bool epp_ffh_sysmem;
>>        int ret;
>>
>>        if (!cpc_desc) {
>> @@ -1572,6 +1574,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>        auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>        epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>
>> +     epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
>> +             (CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
>> +     autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
>> +             (CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
>> +
>>        if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>                if (pcc_ss_id < 0) {
>>                        pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>> @@ -1597,11 +1604,22 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>                ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>                up_write(&pcc_ss_data->pcc_lock);
>>        } else if (osc_cpc_flexible_adr_space_confirmed &&
>> -                CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>> +                (epp_ffh_sysmem || autosel_ffh_sysmem)) {
>> +             if (autosel_ffh_sysmem) {
>> +                     ret = cpc_write(cpu, auto_sel_reg, enable);
>> +                     if (ret)
>> +                             return ret;
>> +             }
>> +
>> +             if (epp_ffh_sysmem) {
>> +                     ret = cpc_write(cpu, epp_set_reg,
>> +                                     perf_ctrls->energy_perf);
>> +                     if (ret)
>> +                             return ret;
>> +             }
> Don't know if such a scenario exists, but if one of them is in PCC and the
> other is in FFH or system memory, only the one in PCC will be updated
> based on your modifications.
The current code handles mixed cases correctly.
When either register is in PCC, the first if block executes and calls
cpc_write() for both registers. The cpc_write() internally handles
each register's type (PCC, FFH, or SystemMemory)


Thank you,
Sumit Gupta



>>        } else {
>>                ret = -ENOTSUPP;
>> -             pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
>> +             pr_debug("_CPC in PCC/FFH/SystemMemory are not supported\n");
>>        }
>>
>>        return ret;

