Return-Path: <linux-acpi+bounces-18852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 826D2C5597A
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 04:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED9DB345DA6
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 03:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A9286410;
	Thu, 13 Nov 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bnOGqb+k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EC7E0E4;
	Thu, 13 Nov 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005961; cv=fail; b=WcsgZsiBWhQq7PuNCsxl52kLQw2p6slK9TVXQTH19SOlGWxysxR6SqWqDo2bsovQE2IPojTfI5ymtZPVMZtAV4/c+vomY5c8QDGr8WC3/dH5f+htKghrrUWeUjmajWTFkri1kgVCUW0lS9LJ4oBLLU/e/tnKHsz9lgDTE9IogLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005961; c=relaxed/simple;
	bh=OZOjH28CCrcFyrI5YEitON93g2pn2OJT3w8spnBo7ok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lsaceLTpiZJBh2K58XBRR/tc11HTUF64+hQeARxHJiSzltfD+XdgSo1oA9/1PYB35zJwmggRvVMCtmMmVG4EfcUevMpEHu62esfdDM/JPWTyD8vgzzE6lsRQFlyrfdlcFlxzoPjN+znsb4fW3agR1wdzWalogZp1lDRvtKSKBuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bnOGqb+k; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkzHDrjVj6s+vM+VhZmBl770XYVagW60DHNDqHfPaiQ4wOHlAcaRy9dFnRSBRyVn6y1qrRS8bp4ZtFhq7aJ5d/J+u8iOvmeYWc3YkN2hUT2IwdA+iO4JSvvzgMOWUHtc9j2PpJaddoAM6S4A6yklFEESZhoohVne/EMaYJsr6zIoi54fBwYBtK++bf2bSjpV+hnQqlq/4wKpv44z5KIykRviLmvSckRgrabnyi7/iODjfq010/6HNKWbP+qnOUb0t+1ruVRpXywZaCdRAdsygPU/3MjBZZOaqLKR2pUSxnrrcIArPphPYu8LK6ScADnaS2JJrnQoyKK7jBboJ04aGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn85VH57zHOLvPlsCpj4bz6pj6waG+k3MfKj9i87P8I=;
 b=PrbOr15Cyp9ginTV4fLSHRLuEzsBXZCv9ipdNOWxcp61Mxh10mLzBzTCeSuQg9bcgpTCTg7/x8Rn9+rrGS+LnwZP/WAxguUGMAkQf+RQk0QlQwJwvezmvBwlIcpvMSnhlOpPHdh2QYDH9Ge/2sXyNBshjwp7kyGMPJQjqjdzB/qRCTC8YKu5zHunMjMAkT+wxoG1N1Y/z7/On6yf4g8WK3qQvWC9ChyO/X1QQIcMliGQ0zxAnDybwUS3GLehXUSGHj2hQTXn6Erd7ewbVWsjLOy+E30tz9GZRw6EPe43AvWIlLyGKYyOk4Bp9rbRFqSf6hOG0a/OLjPfUhFlL6El6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn85VH57zHOLvPlsCpj4bz6pj6waG+k3MfKj9i87P8I=;
 b=bnOGqb+kUN22HfvFTyELuNV/UBE10EOBuMISRtGUGHb/++RaPk4BNmC0gMQeJEQvB9eUq/5DgbBFxH4Ms0XJek8syjfKwUhuYax995v7sHyQ2FkVQTXdl6eIpDn8EI06rYsEk+d+BOxcmwNKuXQcalvslQ5wlqUerkBy80slMCwdOuZVgpPIS+Hg3cnGrAwRCg9LS/mhO7k425BY2LAtK0WgUZcI228T/lfqbahhS+QVw1v6/mwlJgvUKQxx+3Qf4VsLRTXuLsek+anwWvdl3qDs9WaQYj27ic/dhd9Agl7YkVr2GR3YC0iLUEjGtBBVZyz42FHVu6kYyoze0Zigew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Thu, 13 Nov 2025 03:52:36 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 03:52:36 +0000
Message-ID: <5e864c02-381f-4128-b539-2348c149a459@nvidia.com>
Date: Wed, 12 Nov 2025 19:52:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/33] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-16-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-16-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: f260a77e-4222-470c-0404-08de22681542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDBHTit6ckZsdTFYOW9hZUo4N2xWUGlWbGxCdDBOYkFhdk1RTjBld1FkRmQ0?=
 =?utf-8?B?VExjWmptR293T2lzM2pHQW5Kc3VBSVVJVFB1c2U2Y3RvTm53QWJXZUdwTStu?=
 =?utf-8?B?MS9EM3lNRDVoSmtiVEI3ajFXbzRvYTBkNXcyeTRWRE9tSVZnYTNteTFIRTVF?=
 =?utf-8?B?Yk5iVHFCMVhGK0tham5sTERzNUxSWERUdGhkdlJyZUJFeDdGbnZzWjFrWmZt?=
 =?utf-8?B?T0F6U3ZZV3FlRkJHRHQwNXk1d2pFU0lvcysyd0M4TmNnWVNtbG1ERnJkeE1o?=
 =?utf-8?B?WUhYTHpUVXV3L2dtelVZMEtJZ09MSStwMk9wNXpacjRib2plV0x1MGpHNXk5?=
 =?utf-8?B?Z3pPSjNVUnFFSWJGTythYnJXYXp2b1dnNnNEUnhZVlNXbE93ajhJZWFWaVRi?=
 =?utf-8?B?UGRpMDlWN1ExdUduNWxla0p1RXp6N290WVN6R0JsTFhqNlRJOHE1aDQ4R0ND?=
 =?utf-8?B?V0lrTDlsQUx4bzA1RzhsWnVrYjBMUTZVVmRzdEhpUmsvRzVta1prU0ErbThx?=
 =?utf-8?B?bVFneVZUd1ZUSVZYa21LYnIwSEtzUUdzYkQ1b3FzcWF6NjVQcHFTODdKNzhm?=
 =?utf-8?B?clNvOXpzOUNUV2RXazVhOUJkQVRwTC9TYjRZNFRkWGpZaDRTeGtjdy8xMmRr?=
 =?utf-8?B?U2tOSzBCelFzMmJhNzNubHRaUXNyMk9Ca2tUUkdaTS9pZXRkalBSamFlazBQ?=
 =?utf-8?B?QkJTNkV3UUxrb3h4Q3NKSFRWc2RJOU9NVnZ6em54ZWxBaGxtcis5eXJieFJu?=
 =?utf-8?B?N0FyeDdXaE5mc2F6QUVFRGhWRTgycHpIN0pKL25aek9wM3FGa1YrczNid3lE?=
 =?utf-8?B?MFJkUVIxMjlRMXhGZnV6dTd3WHNvcHA4WTZ0MDRFeVErcTlXcHFYS3dnQmE0?=
 =?utf-8?B?SndzeUc0MUx6NzRYeGlaNjZwL2FjRFoyU2VVNE5kUlgwSHBaS2pnRitPdmRH?=
 =?utf-8?B?Kzh5WDNkMGRORWxKRnhzeVk2TWJFT0I1cURXZjlvRGwxUWdoak5iVnZzdEFh?=
 =?utf-8?B?dmt1OTVhR2hHY3NkMWNJT0d5NzJFRGpxRTN1U0c2TnJiVlc3OTZOMmF2dDB4?=
 =?utf-8?B?QW80bmNUMXcxQXB5T0EwOTErazZCdGIxT05nQTNjMVB4QW44Z1N1N2EwREJR?=
 =?utf-8?B?MnQvY1BqdU9oQVJwQ1NnYmFFdVFnMG80YlFmUm1WZFJxL3JCcTE5U1U4TFlY?=
 =?utf-8?B?ZjN6Um1Ia0RUWFdGYkFmbHBiYXgxRS91alZUVzNqRVF0UmVvQ3lQTTF3M2lw?=
 =?utf-8?B?UXRyeW5YbkpQWXJWRnV5cmRTT3hja0VIYlRxMHRyOWd4NXAvYkNnK25XOXdC?=
 =?utf-8?B?cThlbUVqZ3E4c1JvajZmS2pCaFFib1BHRThvbHNYTmZKYlpoUzlVODdZOXJa?=
 =?utf-8?B?MDd1L2pac2t5VEZyYnJiQzlnbklCN1FvOW4weVptby9DbU1tQnZKSTc0SHRn?=
 =?utf-8?B?cnhUL0RkZmFQby9kQXIrUGZ6NS9vNkhRZElNZGQ5RmNiTG5XeUl5Rm8zeVhh?=
 =?utf-8?B?b091ZldMa1VkeENhdG1wK1NKYk1jcC9SVGVBZkFIL3A5Rm5selkraEVRUnFO?=
 =?utf-8?B?b3RDQmtQMFg5YTZiVGlKZGtmV09Md1k5MnMwU2I4WXZWNjJ0cmxJQWZsSCtB?=
 =?utf-8?B?aTZrVEVubE5CUzVjOFJaTjBXUHZrT3p0b3dzVVJYMFVvMmRVRE1oYVI3QXh6?=
 =?utf-8?B?U2pBVHpmbUZVYW9vNjR1TEN5QnRzdytBeXBFcTluYU45cWNMOUF0Q3ByM2Rh?=
 =?utf-8?B?TkpaRWlxY1VHRnlPdzNub2dEenB0SEU2R0Y0UU4ybXgxL2dvYno5SHBUakUw?=
 =?utf-8?B?c2Z1WUN2QTBQbFlGYzl0Y1J2Q2Q0ci95UzFvaWxpcGwwOVpQMDRsSnhRZzJT?=
 =?utf-8?B?V1k5NFBpT3BwcjBiYmo4L0xYZDQrMUVxc2hLQUhEYjJYQkVqSVpTamNSM3F5?=
 =?utf-8?Q?FWvxqA+biNcraYLk4kGr4pj97dK8TBTm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVpJSU9hU3d6YlJpMXVjc3hYQWFUVldTbFNXczBCcldNayttV1VXdVR5QytY?=
 =?utf-8?B?U1prWWppbFl3K0FKcE05WkswT0dpYnI1OU1KSXdPOHBGRi9YVU5sKzVaaGlV?=
 =?utf-8?B?alVLOWZqM2duOFdhdTdsNFNTUU1aZmJRNjFoWXBDMmFLNTc3WUQrV3V3djhR?=
 =?utf-8?B?ZGV6RHREaG44OUdsNStEa2NwVkRkMTByOEFEYkYxVXhYU2VIL0E5UG5oZDNh?=
 =?utf-8?B?ektpMEY2UHliTGE0WXQyVkVITlJiTmh4VXdQQ2h0dktvN0cwalhKb2hLTkps?=
 =?utf-8?B?Z296bzF2citJb1NRVGdaRU43a1NyVlExUG5sUjJ6S0piRjg5REluTGZIcDlN?=
 =?utf-8?B?S3RGZFgrTEpkQ09GY0hEZHpiREdPc2VRcUxJL0VDUmRWSnVEZ1ltMVJoV21p?=
 =?utf-8?B?dGxJeDJGMXhxOVlSTWpRR2piNCs3REdFL0hMcmFIYzlDWGpta3NwcWJ5Z09w?=
 =?utf-8?B?WDRzbHBqWUYvUTltYy9LREM2d0Q0SjJPVnY5VVZjY1Y4cWJ4SEJPSkVDeHo2?=
 =?utf-8?B?NEV3aWlraTV5dlZabnlvdlBYZmo4SDNQenFQdEhlUmJjcTBjTE1HU05Pelpa?=
 =?utf-8?B?ckpmSGt1dHZ3WXpsK21sUVR5V3pQVGoyNmZJMjBpeHVwSkZpYUIrNkIyK01a?=
 =?utf-8?B?amJmb2FmTjF2T1lXQng5YjNVNjFnRkJuaTc4cHR0V0QzNzAraDF6VVFubmI0?=
 =?utf-8?B?WG8wWEx2WVdSUWJQUSt1a0RrMUNoK01UaUlTRW50em1HTWpNeldNRTBlYnNC?=
 =?utf-8?B?MTBOaHErdWw5UHZyZERyNjR5SXgxSmFKVXZYK0o0aGRzK1hxOGlXeGVEYnhN?=
 =?utf-8?B?YUtnNWV3YTZMNDNqeHVPeWU4dnQzV3ErN2JwMldtRFR3NlZadVRsMy94SWdY?=
 =?utf-8?B?cldKWWRlTVRtMmxJMG1SdjVjSFZHL3AwT1YzSGZtdlpjbjVMdGZJTHFPVkw3?=
 =?utf-8?B?dzB1RmxBdEdVWFhDVFRWQzE0RHlYZnhFTDdrMWJMRFYyWmNUUU5OM0o3b1ht?=
 =?utf-8?B?b0NYQzJYVnV5S1plMjdYL2U5N3lxUVJLNjQvQWJqeDllMXllMXcrRmRpVkpi?=
 =?utf-8?B?Y2Vha1plTXBSczRWYWhwVXV1d0p6eS8rNDZXTWxOc2xyTFJNSWdBUGlEMnEx?=
 =?utf-8?B?M2JHZm00OXAybDlqVzF0OW9uYjNObUpVV0FTMXQydW9FYy8zUWI4Nnh6M1My?=
 =?utf-8?B?WUo4RVE4QmVVZ3NWR0JoUXM2UThjZElMSzQ0blU3cTBIN2laU1NQZ0hFR0c4?=
 =?utf-8?B?eXdJb2lJbzcxajZXbUVQUEwxWWJnMjZidkpyYlAvamxNY3ZMZjRZV2RSMlFm?=
 =?utf-8?B?T09scWZvQkJLbGZvLzNOeXgzQjQ0d2ltKzhyY1JWQzdnaUtuUEF5cldrUjVn?=
 =?utf-8?B?ZnE0QXpwNGs0SjNyVkl3bjdxWFFIZm93NHhIMnc2c1NpQTR1Q2NVWnQzUHJt?=
 =?utf-8?B?NkpUL1JKcjBFRUpoVjVkT2ZBQVJjTHdrS1lXcCtWVFk3MUNFVlhrYzdiVmlB?=
 =?utf-8?B?MXV4ZWQyZUVOOXhxb2NsV0xvNnlLckRpZUFCTGg2UTJ3RGFycnhiZ2dTV2k5?=
 =?utf-8?B?djNjcjdvbjJrcGJYMHJlYm94YTNxZWdaNm1wSUdwaitjZkVnTUppbHlOYmdI?=
 =?utf-8?B?c2JOL0VaaDdsd0xOLy9BRUFZRStVU0IzeDkrRDEvZ2dwZk5abTJQZGtmaUxZ?=
 =?utf-8?B?cXBDbWp0RElnZ3drTkV4amRPVEFvYVIvS0ticThhU3BXMUx3dVJBeVE2NzFo?=
 =?utf-8?B?UmZSQmtxWUpXZGN1UHNsWVZEaXFZcEFoam44ZE9nUk0ySVRvelRzc1dpejdL?=
 =?utf-8?B?WSt1QVdDMlNYczZCcWxUMys4NnM5QjVpcExpajBNa01rQzV4MjVuOHNiMkls?=
 =?utf-8?B?Z1dRUlJkcmJnVkhlYkJlM3pndVVHYmRoRFVmcmJNK1BaczlTMmh1SW1EQTgv?=
 =?utf-8?B?cDRaUGJLNkhMTEEyT0hwK2U1aGlxVGV2UXhnRDhOQ3hyTEM3ZytMdk1nUTli?=
 =?utf-8?B?UWd0MWw2QTRlVy9PYnY5S3IrbW8ycUIxOUtRYWljTHVBTEFQR2hSMXV2bEt4?=
 =?utf-8?B?ZHk2ejdtRTdkRDVuUk1SYmVyTzJUQmt5YVRWSmFlQXhIUWtWY2VlQlNwK1Uz?=
 =?utf-8?Q?bXJYaB8FtqUgkDTyySHoAGRR8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f260a77e-4222-470c-0404-08de22681542
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 03:52:36.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYPRszTJzFCdiv8gT1U5JNWdFAQi8EdxhXaUXdnG70MBJI7Jhv2bc20g3EI+jOP+/Z3fnYLQ/J2RQPza4Ik3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048



On 11/7/25 04:34, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSC are not accessible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> or PCC mailboxes it must be able to sleep, meaning a mutex must be used.
> The SCMI or PCC platforms can't support an overflow interrupt, and
> can't access the registers from hardirq context.
> 
> Clearly these two can't exist for one MSC at the same time.
> 
> Add helpers for the MON_SEL locking. For now, use a irqsave spinlock and
> only support 'real' MMIO platforms.
> 
> In the future this lock will be split in two allowing SCMI/PCC platforms
> to take a mutex. Because there are contexts where the SCMI/PCC platforms
> can't make an access, mpam_mon_sel_lock() needs to be able to fail. Do
> this now, so that all the error handling on these paths is present. This
> allows the relevant paths to fail if they are needed on a platform where
> this isn't possible, instead of having to make explicit checks of the
> interface type.
> 
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

