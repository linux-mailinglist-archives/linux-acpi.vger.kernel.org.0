Return-Path: <linux-acpi+bounces-20057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B685D02B6F
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B5503016658
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CF4A7E70;
	Thu,  8 Jan 2026 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLCS8Wbd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CA4A15BF;
	Thu,  8 Jan 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875306; cv=fail; b=Jqsu/JB37bpnzFteynqJbSOcFfIvQ+MmUM+KtUhNPICquyKCBqN5pkBnb1bQ7ILpnz/ApaX2kh/r6qYVPE0J97jbduAo0RSUzgZ4Zau5G3e23IIebKo+Do9u+JwreZXDSbcZ4TNpp4KJTMh7Q+kQv/rQ/d2OF4KssOsSe4EILG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875306; c=relaxed/simple;
	bh=MSJ4edVYrDpWaARGsjXIcnkJmEbhcQbvFX0BFHB2H1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bc77ltXus/6XS/btyXBgJ/U5bUzlHjI7tuustP4ygrfnbADZ0pAcMiH9SOf8Xsfjyb7stOCbtmB2gy7E1v6uXLNwb03zk9XBEVxspyYAu0Q8gkSCQKyCnrQ1FiK1FhxVdgJqBZltRA53D68KNRWSJYRq3Gc51jMJu65HwFrHkUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLCS8Wbd; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFCPXAf1I6YiahXu7UnBd0Wg8Gl+HX5z4u+GxxMbttnzw3IMGFEGztaTjyaeIdbBdTze2DGDW/s5WaiaHhJDkqdNgY8X7xdTvOAc62UL8hHhD1dL3K2qgzXDwVOoVZLYGeV5o52hG3FkbXvxDiR+A7n9DggmmlSixkptil5bxHZYrQSbfzSaHK+QMdofcVWyk7nV7/UzjCCuJZnXMdrakzI+KvGQ2J2cSU++4zaVXwq91w7yP01DBpW1/Xga7jSDobCVsXD82jHdcLU74lOHOtrEzWMZpTyRB8MaQPVVGA171+Z9lnhm1fmmOv0z7fA/kJhrGpBEBVuXXKT/32ls8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpMrbUjGDm/S9kIU85VX4xHpp+dv79h0yQ0hDw99zUs=;
 b=lQj13j64O2HjWgStkVCCnpjOgdynYezCUh3v2Q42bz6gOUBqAMJkHro4iWuE8I9Fr1shOAuTS9Xk+OXPgGFgAPrInphMMQjHbZEhs4eoAKTC+K832P+IdETYQpbeJd7LTA87ss5iRJR4e0zAYhBLJlHtkFvjz3DEcPZV7YIwLi4OKnsLHWUMFP6A8eas4GW82+ClYoY4oR4N85FTjuqUYwsfpCcy7ft1QiWY2w04NRmUXgy+nOQo0VELNwDqv0/0Zxc0mOMcAEGfyj4+S9Sm+Gau94dwETuq9T63yqjH8TA88I1PHG0bS2nMkuQ5CDXmlY2oS0CLTLuwugtILLhk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpMrbUjGDm/S9kIU85VX4xHpp+dv79h0yQ0hDw99zUs=;
 b=iLCS8WbdRi5Wvx9D9NJ0X/ugYVaN6a6vYpHVXUv54q4OLm5o14NXQuWqIhsj1Pny85wNHX9gDe7sBIMCj/VNB5aagwBKimqmlXSjkYtn7eKsADMVUTGA6nV5fynCUBXIHT8zSxIoAMJOYwIHnLG7kLtvadVVjh4IZGWT/XnznEAqIciMgLMAlbIj9fnFgMS9QpmWHvg4zVFcj7LC8/HK+N4U21wIsrYfi5QG6p4LwnCKICVIGwiFWwpgaOM7MTY08l0rWOg0fKznmhk+gTVUEYSNuXIyNaLYimEii50DqL52YzoWnbapkQXMqlscieAmKzefbEpXxN4ETdEoLco9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by SA5PPFEC2853BA9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 12:28:20 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 12:28:20 +0000
Message-ID: <abfdb44d-108a-49d5-98ad-949d184f4f98@nvidia.com>
Date: Thu, 8 Jan 2026 17:57:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched
 devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lenb@kernel.org, sakari.ailus@linux.intel.com,
 mika.westerberg@linux.intel.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260107120318.13130-1-kkartik@nvidia.com>
 <aV6ALdPCjaAYHM7-@smile.fi.intel.com>
Content-Language: en-US
From: Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <aV6ALdPCjaAYHM7-@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::12) To MN0PR12MB5716.namprd12.prod.outlook.com
 (2603:10b6:208:373::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dee716-23e3-435f-8ce6-08de4eb1685c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTYrWjFBcmMyanVOYkhmZDUzbmpIS3dmU0UrY0JKUEh0MWtEZEN5VDBkd05r?=
 =?utf-8?B?U0duanNrcUM1UGRPRkF6VXJyd0N5R0VrUzl3Mk9wWXJVSkJmRzltUVYxRVdM?=
 =?utf-8?B?RktQWFFkTEV3RlRHMkduVGgrZHVPdmRGNitEcTZrZzk1V2V6ZlM4czZ3czAy?=
 =?utf-8?B?OVZDYzFaQXZsRDd5eDRWaThDc1kyY0RsdkZldWNXMTRMbmtHQ2hBWnNiR0Ro?=
 =?utf-8?B?VmRXZzFuNTM1T2hkSnZpUi9IRDE0YSthL2J3NVQ3ZHhVOXE3RUNUdncvZE5w?=
 =?utf-8?B?VTdXaE1Eb0R5ZlJ1SWpoeWJoeCtadDB1c1psKzJ0SE5OVDJuVUJIdXROeElU?=
 =?utf-8?B?Q2M2WFlTSmVKRXVnN0d2Z2Urd3Exb2s1NXk2UkRlSGdicnpkYTFVd210NGtI?=
 =?utf-8?B?VUZFWm96TGFHcDFLT29HTEcxeW1Yc2NMQWU2cHhTWGttdHFBb0hnMFFJcDk1?=
 =?utf-8?B?SHJhelp5V1M3K1FDeEE2V1p3NEFEWUpQTllPUjJRNVBWdmlkSjBXelpLbzRB?=
 =?utf-8?B?VDNiZURKRFVDTHdHYkh0NEErZEhIWFd3M1dxbk1odC9IVEVROFFrWnFiVkdI?=
 =?utf-8?B?WEJHNmNqQ01wZnFQK1JRaDFDbnFMZWVTSElsL0RtczdFOE9UUEJ5Z3FoN0p3?=
 =?utf-8?B?amEremNvQjRxbUpVTTh1b0VKQWlrUFhlSXB1MUNwU0dkMVlRblBGNW1CUnk5?=
 =?utf-8?B?Mk4xcnZoaWQ1aG5lb3FpWFRCcUFxcnFmeDFEVVIyS1hpSnpaUEpja1JqaEVw?=
 =?utf-8?B?bGd2T20xbmd1Unh2dlBWbzMveXE3YU9EVWszN2lNVmtEQjBTcGp1WlFYdHdi?=
 =?utf-8?B?YzByYjdhRy91V3M2OWtwNllnTHE3c1FLVFN1eWU3ZTJMNXhrVGhkZmU2QTdW?=
 =?utf-8?B?STFHbFR3TG1LV21EUkhDQmxYb242RUowenRTaXJmZ0ExcFo0aXo4SWNWR1Fv?=
 =?utf-8?B?Wk5jMzBlTS96MVM0bGNSQ3VTOFQ1THBGWHp3bWcxWm1mNUxpS0hVa1lSdmlI?=
 =?utf-8?B?MVUwcytadHJiMmlQQlFpcFZ3MURlWTQ1K3VDZlBsS3JLdjVEMzRzZDhtUzAy?=
 =?utf-8?B?NHoza0JHd2FTK3g3QVhOcWd4MXdiaE1ZZjJVU2l5aHV5ejRXaklPSUxVV2Nj?=
 =?utf-8?B?TUFrV1VPb2tVanBySHlJYVk0MkJVZGNxc3BOVE5VMURJYTVNYjdkLzBTcVNx?=
 =?utf-8?B?YTJRNlR5SnZMU2JpZGllWnJ0cnpEQ2tsKzFCTXQ1ZTRyRkR5L2RlblA1Y3g2?=
 =?utf-8?B?Ky9UMmpkS2lzY2luVmx5TndxUkprSnowc1F1d3J5YVNObWMxbnloUytGZHB0?=
 =?utf-8?B?Z2pNcE9WbHhuTHZNcXRGdFllcGUzRlNwVktiYWZZbDlQVDZ3OENuVTczSEFs?=
 =?utf-8?B?MzRUNmFkYm1wYmU0VGdENWFINWJ1RSszVVA2WHBRRUEyNDdmR2RlSVdBbHdN?=
 =?utf-8?B?aEtReGxVbEpVa04xWmFtTkxMYjlERytrU1hHWUVZdEJCRXNOdmF4U0lNWE9Z?=
 =?utf-8?B?ZHowamw4YlVFRVJZN05JbjRYZG16N29yWmRuWXpLSnF2dmVPc09YSnNwS01m?=
 =?utf-8?B?UzFMeHlWNnJmZEk1clNDM2NDTDNBWGZHMjQ2SXRzZnlHaXplV0FCckhuQUo4?=
 =?utf-8?B?ajU5NGNHTFU0U3l3MkdLelczbUplNkprSE5icUVsYUhwWlZDYkVSak82amsr?=
 =?utf-8?B?RW5TV3doUklvUnE4aU84SmpxQ2hlVXVWNEFDaEpBMnNCS0t4WGMyRzhNd2ZM?=
 =?utf-8?B?MCsyMmNwOHdOS2JRMitLaWdBWUtWWnE0a1l1czFRZ1U0dzZKUnJ2aG9NUUJF?=
 =?utf-8?B?TWJTdk9tcGY3UWpVOHBIbWdwQjRYS2VxYXk1V3lwcXVmcE04QitnSmdobGVu?=
 =?utf-8?B?YTBHQ2Nva1ZPRDc2UWNGR2xyOWlWN2FGeTdSQk9iaDJKVjBzM2JoRDA3a3FB?=
 =?utf-8?Q?jfOgamD9DwKusjw/j9USPzRM6klcDxo5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGRXaVh3T0kzZVA1anNyQ1pIOTYrTWlLNnB3R3NCN1BIdkRpa0YrNmR5OTlq?=
 =?utf-8?B?bFB4ZTQ0QXdUR3NicHJZMkJHUlFxY3A0Z3JRNGQzbnJXcVZGeDcxYnd6ZFlK?=
 =?utf-8?B?WHUrNEpFUFMrRzhub1kxSndsa3JadFlsNCs1VUpqVnJDaDlOTjc5VzZtcC9H?=
 =?utf-8?B?QjN5MG1CYjNYOGhid0hoUlRiQkZ6NHJid3IrSW1FOVJ6RXlrZkFTS3hJdmV4?=
 =?utf-8?B?MlpmMFdGSGhMYmpUd2dwSEY1b2VYNkRQWE8vSkFpMFA1U0lHOUUyVjRIaTdD?=
 =?utf-8?B?bkptbFVmT1BsV3phWFMvd3lBQUlvWFZjSklINzVyMVVKR3h3RE9IMDV5TnVS?=
 =?utf-8?B?RkQrQk1HUmhwQjF5R2R3RXJLMlE4QzFNYy9adVZZdE1DcXdPdHIyUnMrUlps?=
 =?utf-8?B?Nll3T3hlK1hyeGR4U2RiaDBKa0ZCUlBRWndtZ0p6UjAyOUxuY0hiNGZHdHNM?=
 =?utf-8?B?N3dJNnY3M0RhaDUzTFlhbm91V0Vxd01FYUFPWFJiNmNuWko2eUZ5dHROSU5B?=
 =?utf-8?B?UTBNUEtXSjRqa1BDZnhZdzVSRWJ2NHlMaGtxaE5VUGFwMFBWMjV3eS9HYi9n?=
 =?utf-8?B?T25oNEQ3UmVpdFZ4Z1F3YmRtWDJzbm5qQTVkRkM1K2pMcVJDUzVGMzdXQnl6?=
 =?utf-8?B?bkUzY0o4SzJpUm9OeW1KSG91NWIyK3FYaVNNQUl4eEQvRkphTDhwbjFzWEUv?=
 =?utf-8?B?UDRVY0hMN2lENFJZNytJYXZ4OHBaY2ZteEtURzRvbkNTMWNDbGR1eXF1aUZ5?=
 =?utf-8?B?Z0FXQVpxMHVvQW1Wc2NxUEpNcXl6bVFEWkdJOXR0eml6OVRPb1ViWDVRN0pD?=
 =?utf-8?B?bWE0L3N6V0Z5K2U1WTlGeHNyQWUwaUtKN3dNdzNKYmwwWUNGREo3UWRvMWxa?=
 =?utf-8?B?K29NQkdQbXdkV1JJbXJjTVp2YVNxelZPSkRFSUs3dFN1VnpuUTBpOXA3R24y?=
 =?utf-8?B?YUxpSEs0RWNXTTVwQ2tKMlRnbkxNNTcwdWpLeUR3S1d3T0RJUlJBSW1XcnJp?=
 =?utf-8?B?YVVuN291SndJTkRaTnZTSGhaL2VoMEdIQU5IVXRac0JqeXByZiszdzJBTTlB?=
 =?utf-8?B?eU9GTTZvWnFLcS9zZFk5VlhBeXRkd2RPMEJNVHdkUEZ4RVJSWEdJZEx4SnZU?=
 =?utf-8?B?UHJHMU9xOG1vRC9UUUVtQktsV0dzemxwK2g3KzlpWDNYR1BsRnlWYmFtckFq?=
 =?utf-8?B?UFVCY0t2V0k0QW9DMUtvTG9JMTRYZndyeHlIbXpzRXNkRGV5ZjlNUXN3WlVv?=
 =?utf-8?B?RDlIQ1I4U2dzczJyNHZCNDllclM1ZzJaVEtYU0o1RStIRFlHRWJ2N3l3SmZo?=
 =?utf-8?B?UUhzUGVmK216eVFaeE9rM081ZVBtN0ptZUlPQ2dMN1VVSWhsK1BiRnI0T0pU?=
 =?utf-8?B?cU14Z2RFNzRNcWhkRGFUYU9WMnFpeEZIOHU5cXR3N29mc0JkZnVYT1lSMGRV?=
 =?utf-8?B?WVEzOXhTYjhFOStkam9POXpKVWgwTFpNUloyTnRCbU1zQ1RQUWN1eC84YVJj?=
 =?utf-8?B?elVuSEJLb3kzcXpUcDhMcG1FRFVvM3BRVXlYQVc2ZUxCNjIzMVFuanJERGVt?=
 =?utf-8?B?L0hwU01BcndUNnNRYTlkSUVpelZqTXgxNy8zSERvWVdUMkg0ZDZLUFJ0UW55?=
 =?utf-8?B?OUhMcUt3clJVaU85VURHMWN0TkVrbW9YN3hLckdvZTdGRDZKbm1pYlhGa2NW?=
 =?utf-8?B?R3F6U1hPRFk3c1NsdXpPUlJaaWNncENuL2lBMjU5a25zT0xRVXBQMU5rU3V0?=
 =?utf-8?B?bzhrS2tvRExjRmlJNTVsVkdXdmhGd3JweFBDc0Z4eXRNS0U5RXRGckpBaXVy?=
 =?utf-8?B?RDVJUjZEZU1YYTRMeFc1WjROY1k2Mit0TUFtRGZ3a1FGSzNBb0ZWZEQvbnlF?=
 =?utf-8?B?cWxBeUovUnROWXo1VEdjWE94UWxLU1UxTDBGK3Z6disxZHhOV00rRzRmV0lZ?=
 =?utf-8?B?ZUx1UnNQYURnaGVKT2hZQnFoMXhrN0RqdURTd3ljazdsVm9QVkEyQUtqZTV4?=
 =?utf-8?B?MlZLbVJNYThDT1BGc1phSjRqdmdPVUtoNWdISHV4WmFnUGc4VGFUaXpDSm1L?=
 =?utf-8?B?MVJGdG4zOHcvL1RTVnZpNDRhU0pCYk85Y1VTMFlkN29oVzRJSXlIdnlaQlBW?=
 =?utf-8?B?d2Y3RHIyem96cHBRRXR0and1K3JNODZNckxya1VkZjkybUdLVlVQRUlIcXMy?=
 =?utf-8?B?Wnl4WmhzNkZ2bGxLVlhZbUpWRys0QTdZNWhxUUc3ZmtnRmRsbTBGTGN0NmZK?=
 =?utf-8?B?Zm91RXVRRGZWdjQ3anZkNFA1NlJPNXpNV0o3MnF3ZFlWcTVZOHEyQy9SODls?=
 =?utf-8?B?dTJtV0dMajIxOW0rTFhVK2Q3T25YSGFQS1M3QTAydGtwbTJSUzNGdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dee716-23e3-435f-8ce6-08de4eb1685c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 12:28:20.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1Xv4041rinQVj4PGqLzVW+2FxTb51uIbh+Ldb6vPnjXfGF1/BRslDi8/JEGVT9b3nZTJRQnivPgyqMyGyvLjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9

Hi Andy,

Thanks for reviewing the patch!

On 07/01/26 21:17, Andy Shevchenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jan 07, 2026 at 05:33:18PM +0530, Kartik Rajput wrote:
>> When a device is matched via PRP0001, the driver's OF (DT) match table
>> must be used to obtain the device match data. If a driver provides both
>> an acpi_match_table and an of_match_table, the current
>> acpi_device_get_match_data() path consults the driver's acpi_match_table
>> and returns NULL (no ACPI ID matches).
> 
> Since we have both tables, why the actual ACPI HID of the device in question
> (actually which one?) can't be used?
> 
>> Explicitly detect PRP0001 and fetch match data from the driver's
>> of_match_table via acpi_of_device_get_match_data().
> 
> In principle we can go this way, but can you tell a bit more of a story?
> Why the device in question can't use existed or a newly allocated ACPI HID for
> that?
> 

While testing PRP0001-based matching with the Tegra fuse driver on an SoC that does
not yet have an allocated ACPI HID, device_get_match_data() returned NULL because
the driver also provides an acpi_match_table.

Commit 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device match data")
was intended to address this by honoring PRP0001 when retrieving match data. However,
when a driver provides an ACPI match table, acpi_device_get_match_data() currently
consults only that table, resulting in NULL match data despite a successful
PRP0001 match.

> ...
> 
>> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
>>   {
>>        const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>>        const struct acpi_device_id *match;
>> +     struct acpi_device *adev = ACPI_COMPANION(dev);
> 
> Please, keep it in reversed xmas tree order.
> 

Ack. I will update this in the next revision.

Thanks,
Kartik


