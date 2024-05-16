Return-Path: <linux-acpi+bounces-5857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FB8C733E
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64841283762
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBC7143723;
	Thu, 16 May 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H/GVOTD6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969C142912;
	Thu, 16 May 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849477; cv=fail; b=WRF6zK9dQOU3K/k3bSrpV3lLhjAb2uVHnHqOhRZaNeqYIeB9l63rqwfSrAwJ1EKaeqm02dagHHOobcdbjkvQOargfR9rvEGoxVgFMcq5Xwpj3c6ITlr1eFc+d6xsq9H5v5M9hTy+I3ozGBajDtqCQV2y77NLRRLrPMEu55palR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849477; c=relaxed/simple;
	bh=EmYi72tCnTwnVZwXMDu9b8qJxrd381muDP2wkyU/Q+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzny4ghqqp+mEPaHPV4rutmT5jSNeITlLsvuc/8SkhssLgNlfUN5oTCCpsABARNXIn8PbInO+MgZugKRz8TwnRYV3tptFxNivyYh4MDCWypl5GwcixbWoqSmpo02bH0/Sof1NztgQStimtR7fXC5SW5Rr0XP80EYiz3dO6kK4A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H/GVOTD6; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im5qIVe/llJZsrSUDL8clmBrwm1cz6KsAUIIcUXI53FHCKXXyDR7ZlGwbaI/KKhi6O40hseJgY7EKW+FB/W4oeYD267vMU3GsTgyi4eWWu8u8ccIY/839+N6XFC7EWbfBHVBfciS+Wqjq8HifnVYfgGgGLS7FdKAb/Sjs1cGkGXWIjn5Wn4TdZ478aY91TGs0A+1q6918FjeDHhmq+xju7CNER/Al7xIJ51NbQtlf+jERfq2jEJD9McpJnIRXum1ljwnH8U8bupXCC4vcFKCPixV6TP+5VQaHsJsqynQ7HBIgz66h7cIyCrXJ5ViZxNzQX3E8thvYWMtWSUlGw2Gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqHhSekHrifip5kCnbUXQux3j3Tboo8crZ2wPwP/ua0=;
 b=nr3ykIaWsbIm5ypCKt2SOmX4XY+B8r0cRviLDn3aF+NQfI0s1hdVt9zQtSZjqT5JVKc00K/fhMUNCrB52f09fgSjLWVW/ufeuZ7JTP97jQaIrN5Oth5ULApts+necKAaHIlrBSkl7ZdHQSQoc0ZChikTZxyZtTwUQZV2qS4JWqG5cwLsScsNtFUKBogVBy7+R7S5bQMb932vQEUrXDGwQp8bG6kXHoR1JvLdXCltdsVG8RUHVwfSWcKvBtTZyO23VdiOotK1KEi/89bIEgvO1bFJfePpqxtavty9RLPxQKMAH3CmPgxJR0+RafkGE2F4q7M/FoCpgxGUOP7hvdU4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqHhSekHrifip5kCnbUXQux3j3Tboo8crZ2wPwP/ua0=;
 b=H/GVOTD6KoABoo2XWg1AFyqwsx/66Tw5FFPcbro021krT+/DXYfy8GMPlg3RJCqvIqJ4l7I4j5TPR24Ds6Ba57frxMivXCABYBBF96NEFcor8MftKvIAh4a1tOG5w4EsSDzh0tGjLu7WSznAdYZJMXCzlU/vDHfSlzvSE1zt1MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 08:51:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 08:51:13 +0000
Message-ID: <cb0ff37f-9a73-4e29-930b-bd2ea66e468a@amd.com>
Date: Thu, 16 May 2024 03:51:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <12437901.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:610:77::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: a79014df-b8e9-4f6d-a6df-08dc7585575b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHp1bG5Na1hPblF2YlNKaWZnM21oSDhoMEpsWGtoOUZaeDBEV0ZOY2txNzRF?=
 =?utf-8?B?amNqcGx3Yk9zNjVDd29zVUdPQk5TU2ZjRUxSdFBIVTJCNFgycFZHTmh5VXpk?=
 =?utf-8?B?ckUrWHlDc0Q0OS8zaHNUdk5GM0JWcXIzUzV1YzFWQnpNb09UT3pOeUxDaVRW?=
 =?utf-8?B?c0s0ZHYxRkpXaVRiQ0tBQWE5QWhvOHB2TDhSUVgrblJOOTNpbDQyaUZQOGl2?=
 =?utf-8?B?dkFzSVRpMnViNlkwUWQveUtnVlNhWXFSSWE2TVkwWEQ2NHdjZnhDdVZqMXJj?=
 =?utf-8?B?dDJvbVBnYlYwL2pwMFJxbkVqcVNNVW1FMURvM0htZ3FCM0VLVzk0SmZGY3Bt?=
 =?utf-8?B?cVY2b0l6OUorWUVkdVMrcjg2V2d3aVdVVm16Y3F3Y2F1OVBLUnZwRGpleDBJ?=
 =?utf-8?B?MFArdFJCODFxaGF3dXpLNlliRDJmREhKQ3NhNDd1V0ZZbkpRZzhPZW45bGtX?=
 =?utf-8?B?UFlyczMydTJRVVdka0c4Tjc4UUpaTFlKaGF4aXZvMkZiTjdxbjJkeGN3b0k0?=
 =?utf-8?B?R1JDNVZ6TDdrQitRR1VQNHJHQWFKMFhPaE9OOCsrU2tkQWJveEwvTVg5em50?=
 =?utf-8?B?UncwMGZSVjR1eHhEMVkzYUxreDBIL0dTRk55ZzM0a2VyQjdnbDM3OU5ZWUZs?=
 =?utf-8?B?WGw1YzFEeXdRbmo3ZEV3citjN1F1WU44WkVUaytZeDkrNFBFSjRPUk1UMWVK?=
 =?utf-8?B?algrSDF2T1Q5K0VYeUhIcGNMckJSdHJoelA2b1EzUmxyRmkyZzR0TTVKOVFw?=
 =?utf-8?B?a2NHaS84ZzFxNDR2U0hseEgrMTlRQXlRTVhIYUg3QzcxanFCSXFCVkVnWTdQ?=
 =?utf-8?B?bzYvenE3Q2IvTDJ2SjFqa3lkUSs3cnhweHh0alhNTkdza2pFUkQ0UDRFdlhZ?=
 =?utf-8?B?NTAvTHM3MGpCK054ZTdGMktPY3JqbThnd3hzTWwrQWc5NWhIRXVVSFpFZFNU?=
 =?utf-8?B?MGdleEowTG9BUjQ1Y3htL3VnWFk5QlhiUWJVUFZqdzZrN29LODAxcERTL0h6?=
 =?utf-8?B?RytPTjNzQ2FtVmk0QW82enJqVEFWaWFEbjE3OXNBZnlFTm85YzBsZmFFUVl4?=
 =?utf-8?B?dWxHUUVFcXZ3Wml6cm5vaXl1bThJOGkwVVJHMHJlTUxMQlZCYjNZdGlDbWdz?=
 =?utf-8?B?bGdndmNkMFVPNHhrUDhHUkh0aGFVUm5HZGRsTGJyYk9DTnhESHpVWW5EODVo?=
 =?utf-8?B?ZlFJSVJPMTZBNDgxbVBJZjkrU2FTcHpyRWQ4eTVrcjdYUHVMczZITUJQbmxR?=
 =?utf-8?B?RFkyNmpQTXpTYktQZ2lIaExabG1nbkJjeFFkczdsWTNZUklvZ2JnenhkUHVU?=
 =?utf-8?B?RGVqMk85WkNmYnRSUitWME1uV0p3a1prR20xVzRyQkIxZGlWVXVQd1JnRVBj?=
 =?utf-8?B?Y0toc1JxUEJPWGxObG5mVE90dkM5cVF6QUladWZTR2pob29rbUZJSEJGck5u?=
 =?utf-8?B?czMwUzNHVUZPNGlmaUFsSVlOTUNyRVhUaTZVMlc2bzlGVXVMR0tTN1YvdU9r?=
 =?utf-8?B?WmpMa3ExUEovcVY5ekg5cmo2a0NjYUt5a3hrMDdNMjBlMkNCZk5HRmZZaThZ?=
 =?utf-8?B?ZGt1RWUvM1RJenRjTGRwSmRpbnMzeXlKclNqNm5DV2RQakFkUTFsZWFjdEdN?=
 =?utf-8?Q?vsVMsYmSGxpCBxk7i+MtpWjI50o0C8EhgbSe6s6frigo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZpVmIvdmlLS21uN3BKN0EvQ3Fscm9YOWVkaUxVVHR2OEpSL1RyUWVHczZW?=
 =?utf-8?B?L25PUVg2L25uWVJTNkprdlVKNngrclV6S2RvT2d0NlhPYU1VZmtkQmpJRnpT?=
 =?utf-8?B?ZUQ1a2ovOW9XL3pDUlNDenpPa0lYSmlKanBDY2M0WlpIVVlHK3JYdldiQ0Vj?=
 =?utf-8?B?alF5NDd5TDNEMXZvall5VlltaVNLQko2cW40dDJOemlQTGhSU3g3MEJ1L0lm?=
 =?utf-8?B?RFk2bXF3OUFtZm9mcHlwTy84djg2THV3Q1pHSGpuT3dQN1pheGlKSktBOWhN?=
 =?utf-8?B?bExncEhtOW42cjE3QjlRdVRyTmJRV2s5Q0lnL1EvTHY5bHlUN0ZvR0pNMXRo?=
 =?utf-8?B?REEwcWNhTTBocEpVWlBjUk1aS3VTc3VkY3JERzBVVkoyN0tJdCszelA2bzNN?=
 =?utf-8?B?S2dqYStNZTJKME42YldqamttdUVoZnNtSzNvRUVIRjlJSDNLS2hrektJcUZQ?=
 =?utf-8?B?T3hFRkk1MjFvaitsSGhBSWtnODlMMnFVMEw0ZUNrUGFCWk5kMUNlOGttOExN?=
 =?utf-8?B?QTRtRWlSZ3RDTHFycTQ0RENQc2xuS1VuTUVHbWdrNjIra29YZTJrV3IvRzJx?=
 =?utf-8?B?emhHRVdPVklRWXQ3c04rSjZYMnVkTHNmcW16UTdMVzZDbTB4clV1VFY3WXZZ?=
 =?utf-8?B?L3E1SmhLY2FiMVRNS2xoNXo0Q1ptbDA3cWtnS1JOaGR3amVuYTl1L3VmZ3Fi?=
 =?utf-8?B?NXYzQWlycW9Ob0RGaFUweXRPWks2M1Jtc3ExRitvSkcyWEJqdzA5YmFBMXNY?=
 =?utf-8?B?NmpUd0ZzRDNDWWFIYmlrM1ovKzBjYkZyOW1seWRzMEtPME5UMGNBRUREaG81?=
 =?utf-8?B?VWxRQi9UcHBYSlJJS0srTFN6bXQyKyt3ZWtZeUdqaCtOY1RZNkdCeGY5M3hr?=
 =?utf-8?B?N0VJdXg1NGN0UU5QZ1IxeG5RV0NFdFFKSjhiK3NNK2lTZFZiZXdPMnpkSENh?=
 =?utf-8?B?aUZqWXhLYWNzTmVOMmFhQ2hxRGVNblUxU09CQ2djY1ova3hRbnFnMk5uVkQy?=
 =?utf-8?B?YjlUK1QrZWRId2pXLzgrYWdHTndMdDI1Rm5nQXgrRTNzdS9OZXBreFlRNjNo?=
 =?utf-8?B?a2FNcmVsU0Z6Q3NzQjhtNFIveERUSjlCRUFOOFRQZmxyVXJBWC9jV1J6Tzha?=
 =?utf-8?B?cVVTZE5EcUQxUmNIS3pobXFrbFN6aVZ2dHdVK3lJK1dlOTEwK0UvaFMxd1Ns?=
 =?utf-8?B?SWlVRnNvVlFjTzV2dkIxYmVYVUF6Y2c1M2FCczZtcUViQSt5cUJXOHF5a3lC?=
 =?utf-8?B?UUQ5aXFFYlZ1VmZseExId2loVkNzZEVNdDdRSndyekNrYU1VOFl0NklvUUt2?=
 =?utf-8?B?Wk1LMzlPNmRCdnRobkM1dWVYNWJZK1VhMzF4Mkp3a1pOSUd4bEE4S1ZMWWJJ?=
 =?utf-8?B?VHd3b0wwUncxMjBZYjA5dm5hTFJ0ZnQwVXhyeEQwZHcrVWp4alY3QWp5RG9Q?=
 =?utf-8?B?V3F6WEN1RUxJRXc1RlpYbitIalVQNHRvWnpnUGZpM2dvRFhvdXkvSjVESHd2?=
 =?utf-8?B?bWQzeVlNbHJwSVFpMEpkSUVCempKNEpBeExtU09sTVUzQ2laaHBOMFlsSHZu?=
 =?utf-8?B?aWUwbXdLK1JNc3VFSEFPWjhaOUFGeU9wd1F6dVVHeFdSSExHL2pocWQ1V1RF?=
 =?utf-8?B?WWpnV0VwakRkU1lzRlJHREw1ZkIyL3JGbmJ6QzNoK2RRVXVrOVlnR05abStB?=
 =?utf-8?B?Y00vWnBaNzdwZHRFOTJMQXZ6NW5lZG9yWlVpVElQeXhTU1FGRytHT0oyd0Nu?=
 =?utf-8?B?TzgwNlVPUS9UMVBsckJMYTh1a3FWWGhRaFpDak10NHFQdDNyOEo5cXJUV2w1?=
 =?utf-8?B?c3dPSnJyakVnV3dxYnArVWVUYnpVUy9sNllkdHA1M2ZhZElIWWhMdlVhK01j?=
 =?utf-8?B?b3RJZ0RVTlphZHI3L2JVQjRhNURBelJKNnlSVFVlT3pBR2FDMTF3WmZqZHEw?=
 =?utf-8?B?UWZaZkJIUXJNaU81OWcvei9QemM0NUhLRFp5a0FHdmhCYVJaNFB1UmE2NHdE?=
 =?utf-8?B?MWFKanFNZmZVL3JidEgzV0JtaHVHNnc1NXhBbzBYUUZ0eGhEMXJ5R0E1djJQ?=
 =?utf-8?B?bXNKUStsdDFSWm9KRGVUZWNOTG0zaXo3OG84bVN5a1kyQlJ4QzJ6VFY3L2xH?=
 =?utf-8?Q?K58d/MAi8C5v6yutqbV5gg+tU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79014df-b8e9-4f6d-a6df-08dc7585575b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:51:13.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2PRApMu8ZVbe4fq35e2mwAcLxToxIaHxdbXqs/iuQxBDe00PWOErP1UBG49KJSt4VxuOUJi/LgJN0vYwUBSAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478



On 5/15/2024 2:39 PM, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
> 
> which was a follow up for the discussion in:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> 
> Patch [1/2] has been updated to avoid possible issues related to
> systems with defective platform firmware and patch [2/2] is a resend
> with a couple of tags added.
> 
> Thanks!
> 
> 
> 

Looks great, thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

