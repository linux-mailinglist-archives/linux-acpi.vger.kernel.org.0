Return-Path: <linux-acpi+bounces-19522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F45ACB0BC3
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 18:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ABF630DD3A4
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EAB32E6AC;
	Tue,  9 Dec 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wlo1U2P2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC632E68D;
	Tue,  9 Dec 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300972; cv=fail; b=LK4CHEAm5/mAg4l1ftlWHJSc1gT/H3Pef/+FFdIzBiDFfvqjpK1CmndsHGkpzU0AcsqPYfaCZd5b65ZrVjT2ceZnW+vAbUiUctxvQrccYPPOlLl4AXPs/JYerNESdXtVSCTtbhblFA4E3280MWHFYXwwthurbPamx00eb2+sRcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300972; c=relaxed/simple;
	bh=aMxHv0GdmyMw0i1a91wr1oJIpjZBB9Mjq74L1HmLASg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ad4PidzMr/prhtUmqTSR9sQM95iY59DZbnuqj7AcEgzmgiGcg5aMapnb+tlCeSKbnv7/ZSLe9Owu1ugXTErjaqC4/WAhxk2FA1YxOcNaQIup/y4Gr7a+O2w0GpTuLih8Xm2RG93I+gOSVIY4ef2Pd9bTvnoIHfHbMFEqW2LSayQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wlo1U2P2; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7Gsu6VqMk4P2NSSK3k2eye9gGI+FtMzjt9402/uUTuPS1RFCOFjc+U4ZEXgQFuXL/TeteJu7TL9ICpvhJYTwbrenGEn0BSHOkSVQOe1R1USbfpeuIYN3aVMsTmLV1wtQBwAV6gbXGcIQojYsqtuny0qukBC9WXCzRBRHcV48riN9gi/eNMh1Wi93dQTt/M0TgRNHoFOev8etmjnmcawkFYrg/A8HmiQfS+L8WJoSFI2mQXfm3JwA9tGlTLiW9lahw8Vd+C+ISPf/6LsO28c3KHnsqbeel/eyVbSu2D481TojIGr5KDmnvxJAEsl1+9kwv3h2TGym7aohizUQSHKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng2EZFqikJU7zxYblUm/7yc3hfE52p0cgaFUkCD7I5U=;
 b=Bvk0tQie1l0XHkg0GsoCPZj82fV7ozmbbBp1+aWAkadGc3QWpP09gBB0hpHNqt7Zn0Iu1YBObF5hTXC5B1nZicCHoTvnFoLDInxKG6ujs45hI5eVSxejpFdnR8yWi1EYd14uqPE2Vy46RhK7YtCb/Jvm634XKcAIjmHXR2Whn5Gs0si6It832tshS1L9zn2f/Q1koTCLE9BS3hwpP8Ur5nzHhLqHt9A4z2zif2BbJO8YOjV40B+zuQgYqN5h/mS2zhIElLimjGLi6rhnzzi4Iwy2H/REd6rqM8C/RXSRoHI6qjv/EnuVWdtNcINPCXYRH4itOl+Kf/jdlxr/hdqxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng2EZFqikJU7zxYblUm/7yc3hfE52p0cgaFUkCD7I5U=;
 b=Wlo1U2P2/kr2MKGCIipMqfQwV8KigYtNzDsx35M96d/3tqUmejyPeotVJabPE80W52uF0O0AhjHPmq13N7/LYMj8Kh0RqHF/4NhDLqCNBkXhCV8P1SZMvPOKGKLE6WjhBMVuNghd1GE6qw8gNsIfJhJ18/uh8DAayLUBN0WI0zwTGFk+FQsgNBaj2RGJaKjgtxWQUIuIwS7DkorgOU3Y0+i4drj1BlyO1ODFMwxdTssKXsDaTfERcWOuvy0l+9d6fFjJla9nsL6rMp37iFUf+1TUjMCLAzm/terxd/3Ock3Gq0aMxW01GPFQEAd2SJLg5htP0TknKAX0VRAr3A2q9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 17:22:40 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 17:22:39 +0000
Message-ID: <d591b343-cbb0-4c33-b9de-39fca4df1089@nvidia.com>
Date: Tue, 9 Dec 2025 22:52:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited register
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 rdunlap@infradead.org, zhenglifeng1@huawei.com, corbet@lwn.net,
 robert.moore@intel.com, lenb@kernel.org, viresh.kumar@linaro.org,
 rafael@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-6-sumitg@nvidia.com>
 <1decddd7-54d7-4e7e-922d-b68b901bf9aa@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <1decddd7-54d7-4e7e-922d-b68b901bf9aa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0195.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 4947b7cd-9559-43df-c43d-08de37478d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGVWNWY2aWp5SitvcEV0TXlIbDI1MS9DSzVMOHFtR0wrU3VuRGJpRE9hUW5S?=
 =?utf-8?B?ZFVjblVHNkd3L0VhNTFvaXVmUXIvWTg0bE9tamtIUDBvRXZOdEVET2F5UmF2?=
 =?utf-8?B?eEdIQ2RqRkhzTlJXVVVsSDVGUnYzdFhrd3JVb1Fic1ZWcDRHOTF1VTlwVFlI?=
 =?utf-8?B?TU1HdFNIT2libm5QNW9vQ0dWb2pCRlBTY01BaEF1ZmRUdE9NL09ybW91ZHFh?=
 =?utf-8?B?Q3FjVUFkRHF5d0orVjRlelpwNzIvRzJtWmowNGIwaFE5U0xjZy82anNNQTRo?=
 =?utf-8?B?QmhkeVV1R0RpN1R1QWwvdWJUeUNDME5mdE1ZdHVFd3djeWVUTk5HSjZjMjZ6?=
 =?utf-8?B?U2FPeWJOd2tSQUxodFN1a20reVpkZTFJY1lrREpzL21XTmZkbVVScEtNZkRM?=
 =?utf-8?B?Vi82czA4NnoxSjZkemlEYksyMzN4SGxZT0hNRDJ2bWVGcm9uTFQyQzBDY3VS?=
 =?utf-8?B?Q052UmVPbkdTZjN6VHVBNXBIeEI3NnpNVnk3V000aDQ0ejFWVWUvLy9VeU14?=
 =?utf-8?B?TldRcnRKa2drN01PcHlybk5SelhBYWJML2JEYndCUmVQQWhZcG5nUThLaERX?=
 =?utf-8?B?MFRMeFpWdDM4SThCR1VkMmlQNFNCUHNheDdxZmhjZEJkSGJBL3pwaU9reVRR?=
 =?utf-8?B?Wi9Mci93MnlMbDZQdkRQbGQ5K211bWtVd2xjdXVPaW1MVDZwd0RCaWNmQVlW?=
 =?utf-8?B?Y3ZRUFRodkxlNzN2Ti83V3hDU0pOMG9EanZlMXNWcEE2REU0UVhOMzhYWXNn?=
 =?utf-8?B?N24zR0VwLzN0Vjhvck8rajMvVGNaWGdzTUNNelJNSmtQckZhZkVWdzh0RVE0?=
 =?utf-8?B?OEtQbmFLSXN3UnNGTGpCdHFiUEdZcnBwUVhsa2RDOVE3RzlEejBpaEFDVGVG?=
 =?utf-8?B?TWZMRXhTdjJzdmVVYUJzaUNwNTFQbkd4NUJBTTNYTjViK0FRMlJMTzJ3bE4x?=
 =?utf-8?B?QTQ5bVBxajVVR253bUNpVjhObSszSEZIL0tiMWRVNnpuaTFQNTJuZG0zMnQw?=
 =?utf-8?B?TzZQakVIT1huQTRYcFk3dUNYK2FGUEZYaS9mNnNpYjdtWURud01YNUFmWjNP?=
 =?utf-8?B?YlFxUGtOKzlhYk1wNlJISTU5emZPbWp6VnJ0QUJ5bUNEbzFqYi9Da1hqMUdy?=
 =?utf-8?B?MG1JZXR6OGdMWFE4R1RacWNrVFJ1ZGZyUEdBYktidXRvZUFxaXo2dlBQMy9P?=
 =?utf-8?B?V3Roc3lFUDROeVBicVJhNlJIVGpCRWl1V2lIdG1rajVPSmtIT2oyM0duaXpa?=
 =?utf-8?B?eUlWYXJHdGU5SEcrSE9JNmNFaldScnBmVmVjVFB0MXZqY0wzNWNEeFQvNC8z?=
 =?utf-8?B?ZUVOeE1YSGtQN0pyUHNKYkhvbUo2bzl1dzRGUUlrWldPSGNDMTNrQVNkOWY3?=
 =?utf-8?B?c3JRRXBDNCtWaW5MUFpiZDVxcWVUUzdSNE9aRStINE9kWDEyeFdUdzZ3OVRQ?=
 =?utf-8?B?RkpGVG1kV3N5VkxMQTVJNmpOV2JSRzV3TE9RZ1YzcjdkcWdXNlRRQkdDcXZt?=
 =?utf-8?B?aEhNbHkwVnhFNyt5VktzWmZMR2tsUXVxL0dyWDJTY3EvWkRVdm5xdWJ6bG9p?=
 =?utf-8?B?UitBbU5TRVNrTFRZSDJkTEdCNnFEMStlZGR0OWs1a1U2YWU0Z3lBK3JzTDEy?=
 =?utf-8?B?dFBtUldTSW1vVXNPQk14RlVNVlozRFRxa1krc28yTkE2ZG14dnRaa0xSTW5S?=
 =?utf-8?B?T3dGQUZjeUozc1NDRDZxL25LOFh5Z0hEZW5Rakloa0ZOekkwRFhBa2lmQ1c5?=
 =?utf-8?B?VXYxS2JSbnFOcHlDT2hpRUZneFo5Vy9xc2o2azhpVUwyQk15eUliL2pHeG5s?=
 =?utf-8?B?bFBhbmJUay9IeG5vcENscnB5bFhsaWJndjJtYXZCOXROS3ZHUmZiUlhvekJv?=
 =?utf-8?B?SnJsWkNBY0ZaV0MxTHY3bWFsd01UVGNPYU5mUGVEWEsvNXF5OE5FbFFOSXlG?=
 =?utf-8?Q?hUqxmYCTdR0As6T3GKF6pJHcIwJbrF1m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXh5bktjdkptdjhWMDcrK21wRlIzMlF1M1dUVGdsVWpTcS9PMy8vR25EYzdH?=
 =?utf-8?B?NFpUVTJXTFM0TkthaURIWVcwUzZsOW91VVhaUnEwS3hKVmJ3WTc3ZUJQa3dL?=
 =?utf-8?B?ZEdiakxja3hZeklWc2JNQUwvVHQ4eWV6WjZyVTJmRUY4UnpyZktYaWNSQ3RO?=
 =?utf-8?B?SmYyaGNpbnZpeWpFNUYzd3RQaUUvYWc3NklIQVR4NHh4S0UyTVdVeElrKzFn?=
 =?utf-8?B?WHdjQndUZTVLZGhtdVV0cFY3NGwvVDNaRjNmOFl4aWJNeFZOc2RvQjAyS1Yz?=
 =?utf-8?B?dG8vRmdZeFJ1MHJVU0Z1d2YxYmVNYkV6bUdoMnd3MnJ3Uko3aksyTk5hMy9W?=
 =?utf-8?B?S01ycEYrN2YvSGgvWUgveFZnSmRiV2RxQnZSUC93UmtDNzBXSC9GWGxyUlV1?=
 =?utf-8?B?YlBiNXhoRGhLelNwMk5rbUZMeEszak1LSHViQ25wSFY4d053MW9Fd3cySVMy?=
 =?utf-8?B?cmdkWWtZekI2aXY3WWwrVjB6M1RHYmpzMTFxUkl2bDNHSWJwUi9rcE5mNEFB?=
 =?utf-8?B?Vk9ndTE2eGQ1dGh0ZHhvZm1qK2JBeWtFU1ZBTEt3YVdFcjVVNEMvYlUzSm1K?=
 =?utf-8?B?QmVjUEJKbTJSSS9QOWhpSmFidFVRdm9VLzZPblpNRGJyTFZVVWdvUjJ5U09L?=
 =?utf-8?B?ZDE3VDF6TFpCQVpJaWd3aGRtajVKZWVQUFhabWl6OC9NVUJpaS9qV2s5N2dW?=
 =?utf-8?B?b1U1VXI4STFTSkdwZFhmRHg0d2JuMGh4VTVha2dMRnoxMWZWYmhPNnhsWDVk?=
 =?utf-8?B?cW9RdmxIbCtZZlluODdzbk00K0lDa3ZmZkVaWEVaWU1xQ0E4WVFrb3VHZGha?=
 =?utf-8?B?QWZ2Wk9MM1EwWmNkeDdwMVdWRG42aWl1MXFOck5taU9CanBFaUo0WXFuZkla?=
 =?utf-8?B?SFNaT2d2R2g1aFROeUxIQzZodzFrUkwzTSt4ZkRLZ1NDdkM3Rzl1bFowdXJj?=
 =?utf-8?B?VDE1MVJjSnZ3OHlJb2ZsOXpHUURsNTVQeGFNWURpdE9QbXRnVVllalNlQVFD?=
 =?utf-8?B?TXhOSGtQUDVMZXpDMTQ1S0FTVjNWMG8vckIrOWNwaEhWZWRNMlNrTHk0Mk0r?=
 =?utf-8?B?Q1RiNENNVG9tUWhOeHVrMnlsbDJsbUNLdllQcmw0Mm9SRDRwWGpRS3VtTjA5?=
 =?utf-8?B?MGo0WXZRaTRGUkF0Q2pxK29Ud2tWVlREczAvNDc2TG1oZWJRTG1ZM2ZjSkpL?=
 =?utf-8?B?NEFTTXlyRmlkRFZWN0l3WUZNRGNEaWQycVBsNGRrb1o5SEJIQzZabHhvNGQ2?=
 =?utf-8?B?QmU5S0NZUFhDVEFSWWZNeDlESUt3bGpvRjlPTTB6ZVFBVlBJWXFMWGtPbWEz?=
 =?utf-8?B?YUdKcHdKWjl3bTlwSzVPNktSUTJrTW9jNERQd0JjNEFyTjhKZVowbzh2MDRQ?=
 =?utf-8?B?dDVKNXJFRlF0b0pUVE5tMnRZa1pRQXY1OUJtem9TVVlpaTArT2xvMG9LU09I?=
 =?utf-8?B?R29hTDIzeXVsVmd0dFB4S0ZSMEdVemtTblpHNmR5NXI3UFNNYUpKRE9ORW1G?=
 =?utf-8?B?Y2drcGdpOTdhZTdDdzJkY2V1SXlZclo4RUdUb1ErSmtJNnNqNmVPZEMySkpP?=
 =?utf-8?B?SEY2dmluK2prakZoSm5aS3kvK0xiQm41dWRhQi9ocjNGNjUzRVI1LytTZGJL?=
 =?utf-8?B?ZFpYcUp4Y2phMTNZRnRxYmlUdzNOS3plbFkrSm4wWWE3NzQ3ZU5aaWUzbGFp?=
 =?utf-8?B?NStab0RpSXI5a2JSMzc5c2RoazUxeEJGM1hDd1VsVVBsL0NYall2bjlvOEtH?=
 =?utf-8?B?Rm9tWUc3ZnhLNjZEcVRTZ09DM2FXK3ByWExGQ283UkhIMDFmbUU4NFlZVGky?=
 =?utf-8?B?YUFjdUw3N1dHakE4ZWpMaGlibkgyYUd2QTNCazdjcHpvRVpXNzdsZGxtRlNn?=
 =?utf-8?B?K0tDZWg1YW4vak5nV01vZFMyTjNMRGZjMDh1M3B1K3JGNkVibTB0RXpZQkRi?=
 =?utf-8?B?ZnNtS1k2UFpjTTgwSG5XQ1FMVXF6Zit3aWdKQTRqT0Z6Vmtkdm9sdUdXNWhT?=
 =?utf-8?B?aExBYkU0dXhHNCtTeXFMMnhJeFk5d0QxbnBmdzVUSktpVGlXcTdxaCtEbTRp?=
 =?utf-8?B?OVRCMlRTRzBLQjc2ZEp4YUpSNERyTHkyV2pVNnRNaWtxUnF6c2Z1QkJCdGgv?=
 =?utf-8?Q?3KARUJFw/sgG7eHQo3XPXGyEl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4947b7cd-9559-43df-c43d-08de37478d69
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 17:22:39.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF4X4evrtzV6QaR+KH18j053KdqS3EsR7G07+x/FWG2Detc9tO8E+3g70dBzKPwdo00TDNLtuF+Yk00Ro/uU9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986


On 27/11/25 20:24, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 11/5/25 12:38, Sumit Gupta wrote:
>> Add sysfs interface to read/write the Performance Limited register.
>>
>> The Performance Limited register indicates to the OS that an
>> unpredictable event (like thermal throttling) has limited processor
>> performance. This register is sticky and remains set until reset or
>> OS clears it by writing 0.
>>
>> The interface is exposed as:
>>   /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 12 ++++++++++++
>>   include/acpi/cppc_acpi.h       | 10 ++++++++++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index ef53eb8a1feb..9b8da3ef06db 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1810,6 +1810,32 @@ int cppc_set_max_perf(int cpu, u64 max_perf)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>>
>> +/**
>> + * cppc_get_perf_limited - Get the Performance Limited register value.
>> + * @cpu: CPU from which to get Performance Limited register.
>> + * @perf_limited: Pointer to store the Performance Limited value.
>> + *
>> + * Return: 0 for success, -EIO on register access failure, 
>> -EOPNOTSUPP if not supported.
>> + */
>> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
>> +{
>> +     return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
>> +
>> +/**
>> + * cppc_set_perf_limited() - Write the Performance Limited register.
>> + * @cpu: CPU on which to write register.
>> + * @perf_limited: Value to write to the perf_limited register.
>> + *
>> + * Return: 0 for success, -EIO on register access failure, 
>> -EOPNOTSUPP if not supported.
>> + */
>> +int cppc_set_perf_limited(int cpu, u64 perf_limited)
>> +{
>> +     return cppc_set_reg_val(cpu, PERF_LIMITED, perf_limited);
>> +}
>
> There are currently only 2 bits used:
> - 0 Desired_Excursion
> - 1 Minimum_Excursion
> It might be worth defining these bits and mask the values when trying to
> set the register.
>

Will do the change to allow only the clearing of these two bits and not 
setting.


> ------
>
> Also NIT:
>
> The spec. says:
> " All accesses to the Performance Limited Register must be made using
> interlocked operations, by both accessing entities."
>
> I am not sure I understand which synchronization issues are faced.
> It's just to report the comment from the spec.
>

cpc_write() already has locking. So, two writes will complete without 
interference.
As you suggested above, only the required register bit will be cleared 
by an operation.

Thank you,
Sumit Gupta


....



