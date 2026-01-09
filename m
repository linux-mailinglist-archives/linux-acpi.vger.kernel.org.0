Return-Path: <linux-acpi+bounces-20116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01022D0AAE0
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CBA30D281B
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D343612E4;
	Fri,  9 Jan 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGhGvpsy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7333612E7;
	Fri,  9 Jan 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969468; cv=fail; b=aqw9sDzsaiQjQdfPLdiedQA74L9wTLQRzdTiH4NMTHdfbmW3W5yCWl84SsC75uLZHK/fmZEa7z9ZqmYRCUXK8jy295JQ6+qN9LI3ceBHcskqHQ4dMlnn/kac6NeHO9mZPQLVobnyc1MXE/KnRT71Rt9s9FcS7XuJ/hANzb9UVPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969468; c=relaxed/simple;
	bh=3MrgclKY4qbqO4gbR3DC0f2C89ovyedknSbhAlAysfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSlUGe6lzOuYQQ/o8eZQfeCY2XSpkOEq5uIZ0raBOwjTswJGRH+o3MIkuhBmMdwFAF5K92GIaPJY1BkD6D97+8WXj1DOM2zUQdcgIIDofWHbfkPQF5zJ78Z5Nd7FHYlaJaUrDh0rqrKVDAzYgKX9Y6f4/vRY5LAYwTYwBfBMsWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGhGvpsy; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2Q9ihHas67bJxJOPt3cL6GofBnKWE+AdZoNuWGxQAe1Bw9IqiFB42u6OmXMWfMquCqhFYT+9hqokmZBEE9qaWpDuczEn4AItjm0mMLx4VmIfHEBswM3wIS7wGLxzRPMR9K7YsdnlW2XW22IvWCpWbddXbif62kWOWJuU9d2UimLXjY3wjCEqcmCNjTceyjX68Z9h3tYqbrqvgErXsHZ/NZCIGkA0lk7PFRPxPiRQgCsq4SuZB1bZkX6kipImLmM7nS0LTLN77IbtGmDStjFqvMfKaxp6M40z8kgreY/Ci3WJj3Z55zlXiEpJYLt766192ZRFL5aVFgzTDBJuC00Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ekdtmdfr9PpWUBy9KmerfuspbAKREFJOSmXPMHpc+/s=;
 b=jA45a7sR9dovjtIfGuDjnBFZlu7ztn3H03oxyrBUmdePfY/S0beFaJnk1M5FNMuVWv+pgn0ZKEaLZ05XMq437NaTKEm7yQey46IF583Rnrq2EyC/Ly8ZRHExbHgeiiZPCiv2sBXcSQpxiPDbupLzUyNb25UE0fo/rojjg6i6YtszylW0E0xvNcMk/uQG+oHgQriDCizcYMsHXj7383a7mfILNMpXGsC9gCtuQI26XxX13uLdYaAoBQt7xVwTA1gf/Kxzew3t1sX8MI2GvfA1sDEPL7Pb59mciK2F5emliPaKF+zmCSt7qOJEjqG1hCVvd7EytjS4fVZmHtzcLFCaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ekdtmdfr9PpWUBy9KmerfuspbAKREFJOSmXPMHpc+/s=;
 b=qGhGvpsyyuM7pBQzECz9s0K5kGlx+gQxxufg6euQxYNT822IbFDc8B2VOA5oMHiCjh8bzEdm2nFjJgouy1byIfX5mwBDVMLoo2CzbbgX9oESVrezq6+yxmGez2IeIHqCRsczbhUPGOo3UBdV09lCwn6TKguKr8IGe5l2/0KtmEbkHXZMjx5m7oK9Jr3WZNhbYKc4x/V5Kiq7poXgO2xDjOXVG/PJgdGfUKZ//VtADPdNeAPfcho7bwo01AVZ+PrUp3sU3OLPGJJpWbwY1ku/DMZFn9croSvBEZnNw18rHC1K7MIPMHrpZOjQRVg93iRjULm9K773mRizDCrM16Oagg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.4; Fri, 9 Jan 2026 14:37:38 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:37:37 +0000
Message-ID: <0fe78528-db0c-494d-8d5e-b89abdc993b2@nvidia.com>
Date: Fri, 9 Jan 2026 20:07:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, ray.huang@amd.com,
 corbet@lwn.net, robert.moore@intel.com, lenb@kernel.org,
 acpica-devel@lists.linux.dev, mario.limonciello@amd.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-11-sumitg@nvidia.com>
 <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0039.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::13) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 5673e00b-c3a1-46da-50cb-08de4f8ca208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0lGL3dvb2dBTHE4YTFPT2IwMlRUU3hiR0M3dldGQVZWR3FKQmxzLzJ6OWZr?=
 =?utf-8?B?V0I5N0wydWNaeVcrd1RxUkJ0ZEVwaEFBYi9UbTNpeDYyK284ZWpCaGhGeWk0?=
 =?utf-8?B?S3FKYktqZjJreTNjdzR5QUN0VHBGQXY2dkYrUldKTDFLeXBFRDFPeFFoSVpt?=
 =?utf-8?B?cWxaZWxKZXFISGVFU2hNSzNmZ3RRWExDcXBabk9hQTZlNVIzR2VNYlJvWDBX?=
 =?utf-8?B?OEhVNGc1WjJBT01WdG1tM1E5OVJlYzBhMGN4YlI0ZnRVbVFjRlpvS2d2cXhR?=
 =?utf-8?B?b0J4MjNxM01LNk1tdmx3UTJCWFNKNjFjMUxTRk11VnVqU1o0cnFHSHFadHNy?=
 =?utf-8?B?b3BZeXZ1UDFtY0E4U0hxMno3MXo0SmFXZDVYRUh0ZFdQOW1Xb2xLb1VrUmRo?=
 =?utf-8?B?NE9hSFV0NG1odFgvK29tSk1PSDNhVFBLenJwYldNNDIyRlVVSDh5aHFiUU5r?=
 =?utf-8?B?OWpkdElHZTYveld2aDZJVmFvUnNrcndZeUErNXB5SmRTeHRtTVVDalQvbUc2?=
 =?utf-8?B?N0l1cTkzc0J6SE5TUlErbkVXN2pmTEtkY1FJRWRRQnd6UUJmU2ZqcW5PRzh4?=
 =?utf-8?B?Y3NGVi9ZYnVBL0t6WVErZHlCV0gxZDJ1R25oYVk0UTFYMk42Z2FydWxGZUsr?=
 =?utf-8?B?eGpUbStDMWNiYWIrRDVHZ1F2cElHUm9tTW02UFI3aFJqZDR1cHNHZEhuMFZD?=
 =?utf-8?B?Mm1iUXFTZWZYcDhtT3hYRG1jV3hUaU1QQ0FYdEtGVkFQTnk1MkxwY0x1SzRa?=
 =?utf-8?B?MWN2aWxyb1RtdmZrU2FPZjQ2U1ZTZXhxcTB1ajB5STFmaW1tem9UL0RrZEVR?=
 =?utf-8?B?ZFFnUGNkdTZidlArNG02QWJZTzFtdkM2UlhzcmtWcGx6TWJCYU1vd2VkNUZz?=
 =?utf-8?B?eHVwRzFoamkxUUd0WUc4SzZkR0NIWTl2NmFmbHdLNW9yMWdLc0hIOTNoQzJY?=
 =?utf-8?B?QVExWGxqWUxwMmR0UkxFRHVYYWNxdzltd0hmRWY1eTNHTmx4dEdQb1BXZlVh?=
 =?utf-8?B?bG1FYjBSdkZiTVZqMWNQU0hITzVwSC92dDFEOHhDaWI5d015Ujk1S0ZhYngx?=
 =?utf-8?B?d0JOa016dUd6STFyV2wveXNsdmxpRFJJbERyc0N5Qnc5djV3REdFekJWTGNv?=
 =?utf-8?B?YWJVMFNaY3pkN1dEd2hFRFh6K0VBT0phTGhUL1dnZElLTndNMkV6NDlnOWpj?=
 =?utf-8?B?cTEzQ2RwZi9wRUxuRTZ2MGJ3Q0NFNkN4M0pnTWEyWmtqT3lCdXNUdVh2RmI1?=
 =?utf-8?B?ZEh4eENMZEtKTkluWE5DZjBOTE9aZ1JYd29YQ2tobVlWQUR1UndTYTVTTmVD?=
 =?utf-8?B?OXJGaDNkQjQyQmZJbVNOWENYMXVVa0Q4L1RwUmtMZVhjdFhPOU5ERmhhOVNJ?=
 =?utf-8?B?OW9TNTFDdUY0M3h5aUdlRWtHd1VRbUE4TDEyVWZsSEhtVFk2bzBYcjZjVlRk?=
 =?utf-8?B?WUJVRGgrb1NDSUsrUU5jb1E0WWFud1M2Y0drTVJ2a3NSSllWZUQzTVJtR0I4?=
 =?utf-8?B?bW11TU5VOXhWSjBvOWFabys5Wk56OWE3ZGFESmZVaHJWcjhxUE1KYzM3U2Vn?=
 =?utf-8?B?a0pPdHF5MjlBaERvSWFoSWgwMGRteHpEclhMc3FCS05Bbjk0dWR2TVBTdG9p?=
 =?utf-8?B?Y3V5c2dycXpGVjJLLzlYTCsySTVNT3BzTUprazVsL01XWFdpK0xQOVBUVW1j?=
 =?utf-8?B?Wmpvem8wajhwUVhVc2hhMDIwYXJ0cVNiZkgvSEYyV01oTURFR2F5a1J4WE5D?=
 =?utf-8?B?cVcrd2o0RXR2SmhsemZFZUhzbTZmMEo1Ry8vK1pDVmNtYm9TT3NpbEFvSXla?=
 =?utf-8?B?dHE3RGhBMStGOEJrYXZrYlZCczV6MEdVbUpLK0k5ekg2aG5XSmRKODByM2cx?=
 =?utf-8?B?a1JVL3A3NDJhcmRmVERubUpvZ2htNnJLVU13MmxOaDZNK3I1eGFGTzJPLzRq?=
 =?utf-8?B?Sk9mWmhzTFpxakJDYktJU20raHVxV0pZUGlGWUxHZnJmZ0xnV2tkNThuQzYw?=
 =?utf-8?B?RzR2SVRaUmFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlpFUjU3dTFqaTZGdW45NDIva1MrS1g3c0ROMldxTHlqVGM2SFNvbTMwU1FC?=
 =?utf-8?B?QUlXcldpb0ZoTU5pZVBWRG0rTmR1NjV0cktiVG90Rm9jMHU0ZEF3cGZBOFgy?=
 =?utf-8?B?YkpLaU9vdWNJcFpHeWNhNUJvTHA4YUExNzlZTUNab2o5S05rL3o3RDAzQThM?=
 =?utf-8?B?WkFBcGFSSmdQcjdQL3RkL0VUeTY1MEhPSXJhbVFUUy9MUXBLZjlrWWRsbFVN?=
 =?utf-8?B?MnZHSHNQN2tFSHdwNXFiMkhvazVJUkZhZ2ZKTU5UT1pkb0M0L2x4ZDlGV0NY?=
 =?utf-8?B?K011SUZ3ai96c2VWQXBweitSQk14Zk9DanFGY2l6TS9RTGZLVVd4TjNiUEwv?=
 =?utf-8?B?ampYVUtMeFpJMEhyZGU1MXAwMTB3YWQwRVQxd25idWx1aXR6UFpVemFLNkJw?=
 =?utf-8?B?QW4rc01ZSE5QWWw3OFZObXdhSFJRcm1COUZzMWl4NUE0L0RhMTZIWnlDTUNG?=
 =?utf-8?B?cFQ1WE9xMmJVOEtpK0dKaVFMcjc0aGtMQXdlTGRieUNqSnBUQWxqV0xIWG5Y?=
 =?utf-8?B?aTU3L09GNloyd0lpOUlnalQwZzhQVGNVN3dpNm9maEI4OUFRVys2SDk2V2wr?=
 =?utf-8?B?T25wMzNiaEgwQmNCUmVyRVdaWEVNSzdoMjZJbGN2SFB0eDc5NDNQTUQ5RVZq?=
 =?utf-8?B?d0JwZTNaejlFZVRmZWxmcFh2MGE2ZXlaNUxhU21JZFFsMWMyMWFZZDBHdmZv?=
 =?utf-8?B?UmltRXVCdzlRTWQySC9EU1IvMFdGMU5NUEpFOHBxWXNzUUgxaWZBRk5ScjJh?=
 =?utf-8?B?UEtWUzVONng2Q1dMWGo0M043anJZNk4wQXl2U3dnaVZmMVR0ejEvZ2ZWdnly?=
 =?utf-8?B?R3NsN3B6VWt1cm1pckRIVEZCbkJnQ1ZyZ05Rb25uMnVCdkFCRGNncW1XWHJo?=
 =?utf-8?B?NmRmTWVOUE0zNWtNaDdNOEErTDlDLzl6czEvWGVHVU1yalh5QnF6aWN4dWp6?=
 =?utf-8?B?YU5KVkVqNWN6UHBhV0djaXFxc0tFL0ZvV1ZHZGpwWFdlOWFldzdQbnM1ckk4?=
 =?utf-8?B?KzM2cEpkbDltM1FGNXRYR0Y2VXRQeWs4akxwQVgxSERteW4wSVVjVzh4TW9o?=
 =?utf-8?B?SzhmRWRPVWRpU3hHdFB6V0lHbkZQVzFJbjBzVmxKZ1ZQOFhJWnFQSGNjSElK?=
 =?utf-8?B?VUw5OVk0OG1LM2xsbWlwMHlEYWowMzlzMGloaU5HbGhpZjgxRHNaUWhXSTFk?=
 =?utf-8?B?a1JoeituajV0clMxZzRyZi9YMVlzZ25yenpndmx3d0UwWHZyQkdERGEyL2VJ?=
 =?utf-8?B?TnNHdlZGK0xSVjlNNnlhZEh4ZkIxZU1tWlMyalBMNE5HdWRHUmlZSmhZTytO?=
 =?utf-8?B?eng1WURiYysyS1A0M2JmLzlYbXRSUFgwVkRXZGVWVE5GMUxkR1p3QlhKeWtt?=
 =?utf-8?B?OGhoclhrREtsVFNhLzVwSEcrbTFFNThEZG1EU0ZMVnluL2hKZWtycFRLUWNi?=
 =?utf-8?B?S1QxLzJEMTVvdFhZL3dnREdQN2dTenU4cnVzMTdTOUNiM3VWWXFOMElUdk5y?=
 =?utf-8?B?bVVkaXcwZmJCQUd2bzBHTE1LWEdIclNFaVJWWE9XMUtYR1h1dEVGZXA1YmpQ?=
 =?utf-8?B?SU1ZVmJMSUtvWVlDODZYTzdEdytuRGFGL3A3dkIvSE9JbkRCbzZqemI4d1VQ?=
 =?utf-8?B?Z0NGMzRZL0EzNWZIVWNzWDhKQllMZ0JWVE9rTjRlTWhhbVQyTnl3RXNVZXUv?=
 =?utf-8?B?MjljWXJvODVsZzk2amhyMldOSjEya013ejNNd2dMQVJqdUc5SzBEOUwzV24z?=
 =?utf-8?B?R0k5a2t1L2JrZUlUMHhCQ2dzcE9xejYwZEVFN2hiZHAwQU1zS1Y1c05kcE5a?=
 =?utf-8?B?bWZoY0tZVDZtRDNHcFBZTm9zaUpYUWhBcnQzNXp0M0lzYXRTZGRPbHUwMmor?=
 =?utf-8?B?SHVqUklMdGw0ZEJxS3NnK29iQ0x3RjRRODlaaUtFOUdtTlFYWGVTek5VUkVu?=
 =?utf-8?B?YkJqa1RMNnpoZUhEd3FCc3JPL1hYM1ZnajkycWpBeGxpOVdReXc3MFdTbEpp?=
 =?utf-8?B?ZnVESTNWWExGRksxSGI0NXJ3dmFOd1NSeERSZ2d2NVNtZUhuVXRxbCtUMkRV?=
 =?utf-8?B?akt1SWYyNllNR253TVNRL3UzM0hHanNocHZEYnFJc0JCYnBCWDJVOWRnZUtF?=
 =?utf-8?B?RnNPd0dMZ2xNc3g3b0hnMkRtMDVUODV5bWp4eGN6OUFZaVBMOGhyanp4c2pj?=
 =?utf-8?B?VHp0L1Ruc2gvY0o4dEF6SzRVRHNtMzh1YmwrZ21Nb3Rpb2crRlI2eGNkcS8r?=
 =?utf-8?B?OE8xL05zcUFoQXVTc2FVYm5zUGtjZFNxblFoYkR0QTZ0VVBkRTZHT0kyY2RF?=
 =?utf-8?B?dk53WVlmVmJOQWpiRkFMRFFJVmdQd24xK3N3WmdmcjdMU0EvWjBJQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5673e00b-c3a1-46da-50cb-08de4f8ca208
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:37:37.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYXqqrnZo/RrS8vIZ0cGjWJSp8Oj0S5zoYh20szPYI0ALV7TpoA2s5P5J2j7L4MAjo0hbwRtRx6xtErQ+UTgTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866


On 08/01/26 22:16, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit, Lifeng,
>
> On 12/23/25 13:13, Sumit Gupta wrote:
>> When autonomous selection (auto_sel) is enabled, the hardware controls
>> performance within min_perf/max_perf register bounds making the
>> scaling_min/max_freq effectively read-only.
>
> If auto_sel is set, the governor associated to the policy will have no
> actual control.
>
> E.g.:
> If the schedutil governor is used, attempts to set the
> frequency based on CPU utilization will be periodically
> sent, but they will have no effect.
>
> The same thing will happen for the ondemand, performance,
> powersave, userspace, etc. governors. They can only work if
> frequency requests are taken into account.
>
> ------------
>
> This looks like the intel_pstate governor handling where it is possible
> not to have .target() or .target_index() callback and the hardware is in
> charge (IIUC).
> For this case, only 2 governor seem available: performance and powersave.
>

In v1 [1], I added a separate cppc_cpufreq_epp_driver instance without
target*() hooks, using setpolicy() instead (similar to AMD pstate).
However, this approach doesn't allow per-CPU control: if we boot with the
EPP driver, we can't dynamically disable auto_sel for individual CPUs and
return to OS governor control (no target hook available). AMD and Intel
pstate drivers seem to set HW autonomous mode for all CPUs globally,
not per-CPU. So, changed it in v2.
[1] https://lore.kernel.org/lkml/20250211103737.447704-6-sumitg@nvidia.com/


> ------------
>
> In our case, I think it is desired to unload the scaling governor
> currently in
> use if auto_sel is selected. Letting the rest of the system think it has
> control
> over the freq. selection seems incorrect.
> I am not sure what to replace it with:
> -
> There are no specific performance/powersave modes for CPPC.
> There is a range of values between 0-255
> -
> A firmware auto-selection governor could be created just for this case.
> Being able to switch between OS-driven and firmware driven freq. 
> selection
> is not specific to CPPC (for the future).
> However I am not really able to say the implications of doing that.
>
> ------------
>
> I think it would be better to split your patchset in 2:
> 1. adding APIs for the CPPC spec.
> 2. using the APIs, especially for auto_sel
>
> 1. is likely to be straightforward as the APIs will still be used
> by the driver at some point.
> 2. is likely to bring more discussion.
>

We discussed adding a hw_auto_sel governor as a second step, though the
approach may need refinement during implementation.

Deferred it (to second step) because adding a new governor requires
broader discussion.

This issue already exists in current code - store_auto_select() enables
auto_sel without any governor awareness. These patches improve the
situation by:
- Updating scaling_min/max_freq when toggling auto_sel mode
- Syncing policy limits with actual HW min/max_perf bounds
- Making scaling_min/max_freq read-only in auto_sel mode

Would it be acceptable to merge this as a first step, with the governor
handling as a follow-up?
If not and you prefer splitting, which grouping works better:
   A) Patches 1-8 then 9-11.
   B) "ACPI: CPPC *" patches then "cpufreq: CPPC *" patches.


>
>> Enforce this by setting policy limits to min/max_perf bounds in
>> cppc_verify_policy(). Users must use min_perf/max_perf sysfs interfaces
>> to change performance limits in autonomous mode.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 32 +++++++++++++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index b1f570d6de34..b3da263c18b0 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -305,7 +305,37 @@ static unsigned int 
>> cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
>>
>>   static int cppc_verify_policy(struct cpufreq_policy_data *policy)
>>   {
>> -     cpufreq_verify_within_cpu_limits(policy);
>> +     unsigned int min_freq = policy->cpuinfo.min_freq;
>> +     unsigned int max_freq = policy->cpuinfo.max_freq;
>> +     struct cpufreq_policy *cpu_policy;
>> +     struct cppc_cpudata *cpu_data;
>> +     struct cppc_perf_caps *caps;
>> +
>> +     cpu_policy = cpufreq_cpu_get(policy->cpu);
>> +     if (!cpu_policy)
>> +             return -ENODEV;
>> +
>> +     cpu_data = cpu_policy->driver_data;
>> +     caps = &cpu_data->perf_caps;
>> +
>> +     if (cpu_data->perf_ctrls.auto_sel) {
>> +             u32 min_perf, max_perf;
>> +
>> +             /*
>> +              * Set policy limits to HW min/max_perf bounds. In 
>> autonomous
>> +              * mode, scaling_min/max_freq is effectively read-only.
>> +              */
>> +             min_perf = cpu_data->perf_ctrls.min_perf ?:
>> +                        caps->lowest_nonlinear_perf;
>> +             max_perf = cpu_data->perf_ctrls.max_perf ?: 
>> caps->nominal_perf;
>> +
>> +             policy->min = cppc_perf_to_khz(caps, min_perf);
>> +             policy->max = cppc_perf_to_khz(caps, max_perf);
>
> policy->min/max values are overwritten, but the governor which is
> supposed to use them to select the most fitting frequency will be
> ignored by the firmware I think.
>

Yes.

>> +     } else {
>> +             cpufreq_verify_within_limits(policy, min_freq, max_freq);
>> +     }
>> +
>> +     cpufreq_cpu_put(cpu_policy);
>>       return 0;
>>   }
>>

