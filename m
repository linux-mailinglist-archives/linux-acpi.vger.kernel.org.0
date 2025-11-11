Return-Path: <linux-acpi+bounces-18773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B8C4D634
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 12:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59A974F6BC3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Nov 2025 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9983502A6;
	Tue, 11 Nov 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WtNyA4/d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB9335071;
	Tue, 11 Nov 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860018; cv=fail; b=IPzrER8Qv3Pq5138I0RY1GWSLGZXnYRNeCunWNMheP6tu29QLo1Yg8jqP91wjjlvtbHKA6Zx7KoNZCbRcVRBGcV0uAcK25VaH1v7yunBh+qNF8qL7nUoNsy7jZpxbe192C69h8AJPKb5eYgSjzj4LY2ZS1bn2mu2uNsvK2M1Ld4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860018; c=relaxed/simple;
	bh=7dZhR3ccJ6BW0q3VoQPkWh2cdNrNT0Y75O1j8KPJXXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gkGcYa+niS2OrRufvCAI/rKmimzRkfj3tCOgLjElUoT6f0ktdx4Ye0W3dOp08I4kLU1hKd3d7+FNEBDjtDglw0FS1ysAqnRm6dN69UnOk72XcWDwuCbxPGqyDwFT4Qd8WJygAWAuP3KFGJ/zrkLKeuIyh5+iuTGjY4b6SP8Dx1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WtNyA4/d; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7C3DQ0qvBSLSyG+IMfxNgREA0hMYbM3t5gnboXGeLqWWIwgBvjOJBdWqL6ukll12GqU/mzO3ptgvr64HfEW570Uluru+Td6QqxzjWf2TIA6TT/shony5CQLoyPjwX96KeTfzu6OmbfkmPGurLw2aIHsBwQJAuWRjQyKS8E6KOELGHpiT4s7ftd5Dg+AmwL9NYyIo9qMjnuZ6+fc/D3iAr/jfg4RjcOyOnr1QMy3JpGCtwi22RqyocTgkPN0XKhDZse4QQQYqcGpx8iCOV9GC6TEEpLGTiriwBlURe3A4lXLY4uNIx7dUChD0cfix5kyiaDEEnloEfUOeDXb9b5MKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5xrnzSjvtjycs8BSdoTQsRO5lGbbBaow81YVOkGl+k=;
 b=ulU6OiPFF/7aMmEhzIr5yJTMvhz+bw1lHRvBmclcVAyxiVgrVJdPlHMzl3kBpDgpPXwx06lTW8/ijCNJeonYbvoqArO5U/lWea8LicCWXNvukbiCef85tKC8W8/PAOeXk5twPvgQwQCVL74wKquBGHWnKzAn7Vy9sbOCld6PNrXvlkUWXCxLJ27cj7NaD7rSG/gXAddjwHW58haBjKLf9M3oUYP480fZhEMu3H1MK1p0OCW5M3cQnFhJ580Trfhv9miOVWcmS37/iUS0TMg+7ShGpv5Vbj8ziMeFZPP8rCE1662VKFb0NGvsp338W8baTC/NA819GtVvzEa5HNowbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5xrnzSjvtjycs8BSdoTQsRO5lGbbBaow81YVOkGl+k=;
 b=WtNyA4/dhk9aCjt2KbC/03wZ8km3fv/CeHFJyfwBAPsry+3Kr862AlDdL8la5lvaJCx0fKxSTuG8ns2pwPA27ISEOAjarCop/4dQRiy6kYZC0RhFSq9iM0lLX8oHkZkM1Pc6oOSR9d8eFJr1ROHzMY+lRDEGOlDPH0mpgpO7KYFito6UsGawgD+NM+Lvo6/zv4g2Xc39ly7PDlEKIrzLllHKtw8qD+02E9MwKA3MDGdyeuE0EyCD6UK2C+NEn0X2rWgNe6dRSUmGjgXkCxS7zb9mKTNUrC7w4YdkShQrwKzBlhkJDPykOwFFnqvYy6ifszIIN5eYv9i3WJeU+bFQnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:20:12 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 11:20:12 +0000
Message-ID: <69767b5b-8699-4d45-8ab7-b8965d750bc2@nvidia.com>
Date: Tue, 11 Nov 2025 16:50:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, ionela.voinescu@arm.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-2-sumitg@nvidia.com>
 <s5xt53i6c5wryje5x6zlq75r3lx6nxb7pat6umnghpnldi4p2h@jaeew4iimdd3>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <s5xt53i6c5wryje5x6zlq75r3lx6nxb7pat6umnghpnldi4p2h@jaeew4iimdd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: be94955e-c082-405e-295f-08de2114479c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3IrVlRMUHN2REIxUmRQUjIvYW40bUVWdDNaNjJMUkx6eHhYaGxncVZHREtH?=
 =?utf-8?B?M0tCT2poNnhreWRvekx5MzhOUU9oVVNyeWlHU3VVc0d1K0NRY25XcEoyT1lq?=
 =?utf-8?B?MlhvRjd1VkFrTkNHMDlSa2NIT1RyaEhUYjFRSVBpZjhRZ1huZ2NFb1lXRlJh?=
 =?utf-8?B?c0lwSmZzNlZZdjJGSHBRKzZ6RXo4MTczbDN6UGRFZisrNHZacGxRdVZmaFNa?=
 =?utf-8?B?amt6MHN0WGdLSXBNcFpzVG56TitVSTVrdUcxdi9rSm1UZ01XSFJaU3FsVTlB?=
 =?utf-8?B?YWphVVhRell2bkJwbmdsWVoxYWdlK2lseTFpdUtrUHp3dmhLNWo2WnZ1c2o2?=
 =?utf-8?B?WkdhSkNNUUg3dzcyMjRRWi9BMFVFcUhqOWMzbHhCK1VSUUFuZXhCckdjdE9j?=
 =?utf-8?B?Yitld2doNmo5cHdMd2ZoeGxJNlRuVW02RDNEMUUyNUVGbTZjNFExSDhmUHgv?=
 =?utf-8?B?aGdUUDF6VVFxeTRmNVVGU1BWVm1HNEVmSmdxYjk2Ri84TUY4L29oTUtLS3Jy?=
 =?utf-8?B?RHdrandTOFpuYU0zT1NKTktFQ1NOMVNHV3UwUittMHhOZnQ2R1pQYi9KeFRI?=
 =?utf-8?B?bDF1cFBPRmo5YmZERjVnMkVYSlVhN2g4eDNIKzNNbDBIaEc3Y2NDdmswZjJv?=
 =?utf-8?B?WmVTVUpDOERLTXYwUEIrWkkzSjJiL0JsWmhYOC83Zk12N2lhZVQzejZFRmRa?=
 =?utf-8?B?UzgrSVk4NWF3ZndLd2dsOFdSQUNVMy9kNHcrQkhuS3NsR0ZWa0ZkSkFIQXpa?=
 =?utf-8?B?Y0tHQVhhNTZDSStPMUtUWXFPNVJzSWlzS3N2VEFPcUZiYSthVmZWRmVsd1Iw?=
 =?utf-8?B?eldZWXZ6L0F4T2F4S1NjdW1wNjBCUDkxbHFQZ3lDSk0wZ3ZIT3AzVjhQb1pZ?=
 =?utf-8?B?Q0FqN2wwV045YUJoM1ZLbnU2UDVDZHArYkFHS0xvaGNWQ051eHphNHdjZzVr?=
 =?utf-8?B?V1RKVTBrR21mc1JobXg3Q3hpQjI4WWhGaTV6Yi8vclZpd0ExdUhaT0EvOXJJ?=
 =?utf-8?B?bm1tRFB2TjE1YllzcklKeW05RXhWOURpWjR1elE2b1cwUFpHaTE3RGtRSHNk?=
 =?utf-8?B?VUM2OFJQeEQ0LzhnN3RGU1E0OXNkVk9TbmxVaEhYNjJDWHpGWTJUNm1TYjU0?=
 =?utf-8?B?cUNsTHFnY3ByN0ZKQUlNd2s4RUJQVnpZZWxRTFVEc250cUpwcXc0blFBd2Vq?=
 =?utf-8?B?SkhnRUU1U3dtZ3A4MzlJNmZOUmlMdWVraFV4SmlYOWpjcXZGMmpyK25tOTVQ?=
 =?utf-8?B?Z1YrN3RrWVgyRHhSdzl3Z05YOE5JQ1pTOVI0Mk1jZXVUQ011em03c0JNRjgz?=
 =?utf-8?B?Z0psY01uM2xXTkZUdmFYOFgxVGxBNUt4dC94U2Q1NWxmSkM5Nk0rRkt1T281?=
 =?utf-8?B?bThWTzEzUmI2Z0xUYk9qU0dWVXdLYURBVTlCME12WnprcW05azE2UDViTURH?=
 =?utf-8?B?dkh2ekZlOXcvUWFTS3QyS25pMWdSY1hMR2YrK2NJeTVrcUI3Zmg2SWgvK29i?=
 =?utf-8?B?NHVSZ2tzMnBscURCUW1uZlI2THplemFqenJNZlJiVjYzQTYvemFjb3MyaDdy?=
 =?utf-8?B?alNMU2dRUlFyaTVBQUFHcEp6bE1DTEdDbHFzYTBpVlBNSVFkTnZpWGc2ZURW?=
 =?utf-8?B?MkNSRUl3RHVVSmUyUzJOaGFRNVdlbTdDVDFXYmxCaGI3RVI3cFlNRXhpcmww?=
 =?utf-8?B?OTVBNzZLN2Y3S2pBamcvdk9TUVppbmxpaFVycU9NWVZZN000MGNVQ1Eva2xG?=
 =?utf-8?B?ekZKcEFUZmZHdUJtc1RMMmhPWU1ib3Z5ZE51SEVpaE8wd1U1Y25SZkxmRmlG?=
 =?utf-8?B?bUtUQm9KbXpBNkdKTW4zc1owZXZ0c2RkNGxucHpFYmV4ZllwZnVISjhJMnkr?=
 =?utf-8?B?NjkwaEUwUGdmNjJmOXk0b2oxTko0SlhOV1hIS3ptcFZteXN6ZWZ1a2NUT25N?=
 =?utf-8?Q?y6PFiJTe+V1LER+gLDgDXQhVwevZp+ZN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2FBcDJ3S0hQSlZKTjRCK24vOCt3WEIzMUh4RFhZeDkrWCsxdUFpcFNQRzZK?=
 =?utf-8?B?YUtEUklSSGwxZ0gzSUdCOXZ3cUFqeGNSOG1ZM3JrUisxVTRtck1Hb0VnZk5Z?=
 =?utf-8?B?encyVFhxaWYxNW5EMlF3RldDYlpuV1pTUGVDa05MZGxFNy9Ed05NOHlxZ3Ax?=
 =?utf-8?B?Q0xUZWk3VkVuc2dPNGZzeVd2dXExVzVpSkNnUDE3bXVxRUt6dkM3bDhwNFBF?=
 =?utf-8?B?QlRDVEZOU2FycXRONllsVG5XSFB1VUYrMHRFVzl4NmRyOFFPcXBiTFU1MGph?=
 =?utf-8?B?ZlRWVHpBS3V0YStWc2UvYk0rVXk4U0NockdDaUtBQ3ZPNHUwMmI3OVR4aUdM?=
 =?utf-8?B?VlltaXZ4Wmd6S2hwSzdpUHo2ZENzVDFxRUs5QXRla0NlOVpmeVpZZHJlUEJY?=
 =?utf-8?B?ZkhvVmdUZlY2RnA5SWwrQ2pUWTV5bVFKNVNPWFN3R1dvZGVFY0FMUGkwRE5Z?=
 =?utf-8?B?Q3NpY1QyUUxaWURMOWVOREVjVXNaWWl5Z2IwTGNoMVkvSjEvcGovcWRZY2pi?=
 =?utf-8?B?OVpFM1RyaUt0ZTQ5aDNHSUppUkovdFRaazZxNHhKMWdNKzE2ZnFwb24xYzNo?=
 =?utf-8?B?TjRSWGlXYjU0eU15TVpoTnBvZlJIMG9XcXhIekl6TWtmaDY3YmppdGdHYU8z?=
 =?utf-8?B?TjRpSjFLR1NQVXlhR055TmFrZkRmS3FTSEtwc0U1VUdrdkduVEd6ZndpLzZI?=
 =?utf-8?B?OEsrNlMwc01BS21nTWdzVnl5ZDhSWXI2b0l3a0JGSW5rU2ZEWHJwZjV6Q1RQ?=
 =?utf-8?B?a3k5QlJQYWk2RlI2RHlCNk1KaEQ3UFl0NG9YTkFta1Y4cFJiQlhqNEludUZE?=
 =?utf-8?B?eWtPMSs0a3ViZGk5WU1yNHdMa0tlWGNoZ2tQOE5FYU5JanpILzJ6SDNadFVX?=
 =?utf-8?B?ZGdlODdMYmxVZ05NMitJNUMxSVRldW5pVkVZbC9QRGw0RjNsZ3FNYnNJbFFI?=
 =?utf-8?B?QUx2aDlyNlB2clFWVE9tOE5wL2xxODZPNGY3RlpzS0hPQkZxQ0VXR2NtUWpT?=
 =?utf-8?B?cUFvY096QlowTUh2eUJCQzJ4QnZUSmNUOThzNXJwTWNqYWN6T0ROanBVaEdR?=
 =?utf-8?B?S3p4eVdsNWlVc2hISXJaT1FTaHVpVnA0akRmTFZOaHlPVVFERkxWa0g4VXor?=
 =?utf-8?B?Vko0R245N1BWSnc4Yis4NHp1Nnk5b0VsQkRBbUNteUJhb3M3b0ZTaVV4bHV6?=
 =?utf-8?B?aWRqcXg5R3kxTFJnL0Z6RWFGTGFKc2JEWlR4cjRxOGZiL3hrMS96U0Nla3FP?=
 =?utf-8?B?Znd6TDRtMXNUUlV1VjQrZ3ZiZzgvNkZVNzFueVZqcmNEdVFkRnlacXgvbi9P?=
 =?utf-8?B?Tzdncis5bzN6em05dXZCbDNlWUxYVFk0MGxQZnd0Z09CbE5YMCtPUC9zZE5k?=
 =?utf-8?B?VGdjNGlTaU5mVXNUdkwxdHJuUWJLLzl3VEZaS2JyRm1vNUpjV282ZW54aG9u?=
 =?utf-8?B?S3pyYjJ0WGVqcyt4eCsvMFhqY2FXODV3aW5BY2pEU0Jhd2N5NHoybWN1ci9O?=
 =?utf-8?B?bUcxcHF6L3RqanYyZEVheG10ckJqWFlqZkpwOForbmVleFc0SVl5MDZFbjVG?=
 =?utf-8?B?aGloT2gwaTZJQnlEVGw1d1pvSkpSVDBtZHNteXVyWlladFNzVzJEVzAzaHpJ?=
 =?utf-8?B?Uzk5T3Q5SEZkcURJcVRTai8yS3ROMEpQTitKVmFmS3hscTdwcFBOU1RRSWZi?=
 =?utf-8?B?d0lBUjlqdmcrZEptUkdYWUxqVkV2bFVTOFE1UzRjS0laQ0JObi85Mk9XVlFp?=
 =?utf-8?B?ZDAvZ3Y4ZEw2aUkwWWVQWEowL0swaXhMQUlUMHFzUnhDc29iZklKQnVKYWJU?=
 =?utf-8?B?cHR3cGtkY1hlTC9kTFQ5a1ZXYitqNlNZWFh2TUkwcFJNM3orUmNrNEtmV3hp?=
 =?utf-8?B?UlRsWXQwQTZWVVozMGdTT2tmbXA5dXV0OUpFOGR1Wmt4QTJDc3Y4eVlCYmpB?=
 =?utf-8?B?d21MN3RIOGtIbmZ6YWVGRGlaY3BjM2NKckM1Nys5YzJjdUxFK3FaMGh3ZThz?=
 =?utf-8?B?R2Q1YW9ua3hZMVV0SlFCakNTSDhldE82SGQyeDJ5enlUYytuVDZKK3hCcnEr?=
 =?utf-8?B?ckY1WEJVcXcybHBRZFBWbDBTYWZySHlndk9CblpPV1UyQkJtRndvRGkvSlFH?=
 =?utf-8?Q?etUbYdQQKbaicmly8hukBj/fn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be94955e-c082-405e-295f-08de2114479c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:20:12.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Po7pqdRtPExnQafUhhgkYwW6V9Q0BM8OXLB0c0dH1/fu2NwufAozXDtbHAWuVjv/9wLDsm26MX3q3RV6gFpbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189


On 10/11/25 16:26, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
>
>
> On 05-11-25, 17:08, Sumit Gupta wrote:
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
>>   {
>>        u64 val;
>> -     int ret;
>> -
>> -     ret = cppc_get_auto_act_window(policy->cpu, &val);
>> +     int ret = get_func(cpu, &val);
> Why no casting required here, when you need it ...

Will add casting here.

     int ret = get_func((int)cpu, &val);

>> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
>> -                                  const char *buf, size_t count)
>> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu, int (*set_func)(int, u64),
>> +                                         const char *buf, size_t count)
>>   {
>> -     u64 usec;
>> +     u64 val;
>>        int ret;
>>
>> -     ret = kstrtou64(buf, 0, &usec);
>> +     ret = kstrtou64(buf, 0, &val);
>>        if (ret)
>>                return ret;
>>
>> -     ret = cppc_set_auto_act_window(policy->cpu, usec);
>> -     if (ret)
>> -             return ret;
>> +     ret = set_func((int)cpu, val);
> ... here ?
>
> --
> viresh

Checked this and the current change looks correct.

Thank you.
Sumit Gupta



