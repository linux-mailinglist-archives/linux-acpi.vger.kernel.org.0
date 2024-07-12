Return-Path: <linux-acpi+bounces-6872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C18A92FD75
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1B1F230C0
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0B17332B;
	Fri, 12 Jul 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gROLU/xD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2D17107F;
	Fri, 12 Jul 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797905; cv=fail; b=ixSjKDgo+8TPFD2poIhC+vjnTKqzRvmau0aGgEJ//s6giGYvXQSKoIFsN2WhwUEuxfswPwGO35Jr2udTdZBhpgf30ATj3ME+IoWEX3l+4/cyxkpylXrjjjgKZ15hOgNdgHxqmdSkIqwciRCkDRTP7x715dBaI0jBToB1JswtHf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797905; c=relaxed/simple;
	bh=s6F9pXgxhnoyATbr4f8Md9pCbHxhKV6732uU4MnBUKc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NgzsieEl4h0wL6IxQaPoXKQgr7jtHdLVOIO/K/bD7QeI0S1vCUjoMKjpmHTKArjvojQKkM4fO/d8pZiWINxmnfQkugGRYho62H0RbMKOF7+8L7aPfwJLqf57AnHO+QJUiWcibeir78AQpd0AP0XKhwNBBVybE8DCWV6hm8XysS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gROLU/xD; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSXc3TtlscOlzVOiwzLSWQJj5Vu1x+zh/nk5WngsdwpoJFyBk0NhconGUqurO8rRv5ZAygS5pLuLxPnIMjxxnxssAtuAV5P0rabHQrUUCg6CmwUytm1R5Bf5VpfwKiv/KDTs4bs+JUo3kkAw3MRZ10vLmPaYiVcRmdHz3KbdVUoKjLSzQgz3ylglL1OFtUkynqfEonJR8vQr8Y2LqNfjgaXQ89Pin/2HHzlBJiVN+4Od4+lYfzQC/8sl8lP62jCikLVuTNu7ruynT9cCiuMl98nRtLDjSLC7t0YDxHKLFNKYQQECb+mLQZCFeuZPRBDLS1GEWjB8iCZ7DENLBWXzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi0hUuH7ynz54Rmv2C3XVf0m+pkNuODp3QP/Zv+iSYo=;
 b=DpyZx7lsWcX7cvwBSJSn6hwt9rBapCiu7WotgjJpPKiIzSbR4/L0MwxWqJOrDMhfCtIA9uTyoSkgF++x2rJwe6ZHTzJYO8ZbVffsD7LKAJ7WRIHaRf8TZhG2kIEggtn5Id5FVJi+9f4yEHVGrVbkJ/BXc0J0psU5/huxcIc+eNNE3gzHOMj+jGRZnUXKxSW9FqM4Nm68tTyuUge600iiIK403Tp1lBHyysNGJjJDqoLncUOvE0Og4dNRacPVHiCCVZeUxBEKhEz0H5gRMEpVzhE9eXQaXmthN8ReftDM3Ob5aHCnmQq9dJwwS9BI0qDX7JqiXUDU8Fid/RrvhG7kdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi0hUuH7ynz54Rmv2C3XVf0m+pkNuODp3QP/Zv+iSYo=;
 b=gROLU/xDM/m9hLplwN88UeEz/bSmG2Dz0XbjZU6KsDhl23wbBzix38L747Zp0zRwg/SeN5acGfHC0PUbu79uUZ/ufzl4DHNnT75QkvFX0d6lXlPpU/gy9OovBKApK3y81ezVqs5nVSyaZVJ8sP03qfMaGJBzc6SnFAq6mXs7BE37g2Jhl0oM+64QQucL/aIzDIGoOmtqAxiSgtyD8em1wv8H6T4bO9QZInm4BgmiOB2o6YfYkjM6vxtPoGfG9dcIk+Yqejk+6Ro9VeHRmKWASJVygepHTz6PTqCYwaRWCyfqePJ4BDkAHRzmK8I7UzBAWHS+J75209OpMFXhb3K7wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.23; Fri, 12 Jul 2024 15:24:56 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7762.016; Fri, 12 Jul 2024
 15:24:56 +0000
Message-ID: <ee24cb5f-d170-41d3-9928-5507b8ab22a7@nvidia.com>
Date: Fri, 12 Jul 2024 16:24:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu: Resolve fwspec ops automatically
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1719919669.git.robin.murphy@arm.com>
 <0e2727adeb8cd73274425322f2f793561bdc927e.1719919669.git.robin.murphy@arm.com>
 <0eec5f84-6b39-43ba-ab2f-914688a5cf45@nvidia.com>
 <01c05fb2-16ce-450c-befb-8a92ac2a8af9@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <01c05fb2-16ce-450c-befb-8a92ac2a8af9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0336.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c5cb6cb-0323-49b4-c865-08dca286c900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zjc1U0VQZU9JTTRROGFLQlNjWWE1VDdLanc1RVZhZW1vUG03MmY0WUNXdEsw?=
 =?utf-8?B?QWdLcnI0NkFQMXhCMk12OFlGenNnTE4ySTAwNFVDYlVEZExUSWd2M0ZZY1dn?=
 =?utf-8?B?RGpBVXVkWjNudlFXM09jbGdSUCszUlpmS0xjVk1XWnYzcnpacGxQSjJMWGdT?=
 =?utf-8?B?UFVOTmE3UmFPbTBPMjFvVTFnZ2c4KzhiekVEMThkNmNLS3RLdDJOcmhkeVFB?=
 =?utf-8?B?QUd6ZFcrYXJ5YmsxLzlyazhEVmoxdER3djJsaTJhOTU0LzFXQW1KSU1CN2JU?=
 =?utf-8?B?T0FjTWVnNFpBUHZxeEdsUlJSMEZkN0VXdWRLNVhJYmlTbmlQNit5NVN6VXY5?=
 =?utf-8?B?YytHa042a25aQTk1RDFFN0JhdVIwOEUxQURFSjhJUEU4YVpjM1BNNFhNUTVr?=
 =?utf-8?B?alBaWTFYZ2l4aHFnbVRIOWg1SVowTmxRWi9lZ0ZldmM5UEZobWg2b3l4cEVa?=
 =?utf-8?B?RUs4UFlhcTRIOXhuY1VwR0VMVEpSbkZ6eTlkTk9CT1ZmeC9aWVRzNytXZ2lv?=
 =?utf-8?B?a0NCUWtzdzRTMGY3VGtPcXpYZ1Z1eU5ESE5NdmdYbjNZWVVSc3EweTJXV2o3?=
 =?utf-8?B?c2ZEV0htS3lHbGhVQWY3U3FIUS84R2I3RVlDMTU3cFhNdlBtek05a1dtVlB3?=
 =?utf-8?B?bFB5dUJpYm1Dd0tKeGNaZkpmcERyNWFEZHZEdktSYWpNYTZTQ0ZLY0hFYnZC?=
 =?utf-8?B?dWpKcERTbml3NFl0ZE4wazYyQmhCelpxYmtBMzN1NjhiZ01XVTRRK1RkUnFl?=
 =?utf-8?B?VDdSUWFHWWh1VWxuKytxNUVOWWhGNnZHMTdVY3B4eldNdkNZUnZ4eXlENlBa?=
 =?utf-8?B?Wi9wQ3YzTnFOMHJhZTR1TmxPR3pCRkF3b2hHemtIdVhYR3QyMGdvSng2dVBK?=
 =?utf-8?B?YU1Rb3dDR2NXTndqbFZ0L0pFR3pKOStFMFRFZE1vTG5jRkdrU0VpSHBxWXMz?=
 =?utf-8?B?dEJxa0pwMVJKSkdibGZYRzhIQ1loWk01cUxxenNKTEJacVV3Q3RVZmsxNzZX?=
 =?utf-8?B?dzhSeHhVMjNtbmovTVNvdEFYVVdrOE53dkZ2OTBOWkwxR2RnbXZFeHFGRlVK?=
 =?utf-8?B?QjhSTi81aURqMlNHd2htQVoxYU5KMW13QXNKa3Z3Q1lEQUdvcWNCTWFZbkh2?=
 =?utf-8?B?VEJGRlhESXovdWMxYTlRV2krMTFxV3d1azZ1aTk3YmhsRVdOS1RaYzVsNW5m?=
 =?utf-8?B?VC8xYlZ3aEwyK28yNkJHUjZTSDhqbWxKcmtzVlZkN1Rtbm5lNnppcWlIUmdh?=
 =?utf-8?B?YVNGOTFxWUlqYmVHS3NUVVBEVmZLZ1RRT1JUejlQakMzS3IwMngzZ3VXdVZr?=
 =?utf-8?B?TnBZUmd2UXNQdGtxWk4wRU54cldIZWp3VGphNUtaVlJGYlFiVEtrRXRIMnZ4?=
 =?utf-8?B?ZWxxUFZ4Z2xZOFU5clpZamt3alRzMVYrdTdROHUvSEwxQXFjdHNsWWRJb2dt?=
 =?utf-8?B?aUhlaitFYU50dVk4NGRTeXgrNnJNa3RnRzFsZWlhNDlKelRCZWtUQmpETWVt?=
 =?utf-8?B?VHlaN253Y3R0OVM0NWdjVnNGZnozUkQxZ2ZJQ1o2c3Y3MlczZ0ZNMVpOS0px?=
 =?utf-8?B?a0x0MUNUZ1M3UWdvbldTSjVveW5Kbm0yWTV0Qk1aWWZaOTlpR01ISXNjRldh?=
 =?utf-8?B?Q211dWRUUDk4MjFNcXN3ZURqNlRYVVFYVUFRaWZUazBEd2puUStOa1NhM2Nn?=
 =?utf-8?B?bHlMQmh3bGdvTkgyYS9yOXVJY0pTaWpWbGZDb21rdXJUT1d0U3NObjRZZGxN?=
 =?utf-8?B?a09rTzI5MHJhdjRiczAyTFQ0b1VTRnNnVldNKzE1cVNxc1lOd05jL1ErbWhC?=
 =?utf-8?B?YVg0S3B2aUcwcVRiVlVKQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStXUVZrUXI0U0JxMDdxSHFzc2J1SGFHM0ZCR1R4Nmc5c1VqSG1QRnBDMFRh?=
 =?utf-8?B?UGVwWHZQU1BsYVRScng4L3lkcmR1ekV3cmVJdlBpTWloeGZodkY1UnJOWVM4?=
 =?utf-8?B?alJ2T1dIbks4L0ZoTFdYMVJTTUdWck5Mb2d2M2JueEhQZVFFZm9tTHA2SFd3?=
 =?utf-8?B?NHFxdlRrR1pZaTliOFB2R2VOdGtGZmVmM0NOVnp1alY5T2pPTktKTkRmYXY1?=
 =?utf-8?B?b3NLSVdOcG9DT2FnU3FzT29HenlheVVKUTZBb3dkNWcxb3g4ZEs1a3JTbTFN?=
 =?utf-8?B?OTk2NFZKT0cwbEY3TFJ3SkRsTXY4Qk1FYVovaGVrQU53bmkrZnF3endLOWpE?=
 =?utf-8?B?dWdFOGhYZGVKQ0NxQnB5MWtVK2FOZndZNnkwMGN5RzZIK00wR0J5dWpid05Q?=
 =?utf-8?B?eEVOYm16MzJ1N25aSmRSQjVzeFNQd2VucENIOXZ4VWROM2JONXVqVGJWVE50?=
 =?utf-8?B?RllnMkZ1RWZsYW5rMVFZNWVRTG4vMktlcTBEUngvaXVXKy80ckhYd2FLalEw?=
 =?utf-8?B?cDh0aXZDQkh4dlZpLzFNQWRRWmhIa0VJUnRLTDVIeEdXZDBYSTJmazJiOWU0?=
 =?utf-8?B?Z1R1dzlCelJlaGxjVmNpRHh0YzArT3J6SXgzQm9tT3RJeS9EVkNxRis3ZWVD?=
 =?utf-8?B?V0Z0enlaeUxFS1oxc0xjbUdWd1diUE9TSHZkNEFuRzBsQVNoTVBTN1ZidGZ0?=
 =?utf-8?B?TlhlTlJQNnhqbitLSDM1eUt1dTI2RTdJdGRvUlRod2ZyeTZEK0Q5SG85bmhM?=
 =?utf-8?B?UjVNU3p0d3FZa0k2NVBESmh0UzJJbC85MVBFZm5uTWN1dGVrY1BVSmlmZmpN?=
 =?utf-8?B?RlN4VXR4OGNkU3QxVXZrUWdVR2NYbnZzYk9ZM0pJUTJSa3hPQXRkNzhQZHcx?=
 =?utf-8?B?b1lTZk5lUmtRSit4c1o5dnFjSThjZUVlRnQ4WCtxemNJTmR2Z2J0R0tBUkJP?=
 =?utf-8?B?aFVFUVZrZHpOL2dpT3NPb3JIUkNFQURDSW8vMGdJa1VMQlNlZkpSaGZBbVM4?=
 =?utf-8?B?YmxmMUVBZUJiUU5TaDY1cnpBZHNIVFliUDUwN1ZHNDdOeVhhenJkTWVaeFNP?=
 =?utf-8?B?em9KSVo3bHB1eVRYTEszMHZhMFNIZUM2R2NhMFFXa1krTmV2WHJid0NUc0sz?=
 =?utf-8?B?MTl3TUhlZjI2TXRKUEpaOTA1YkZrcTdtWXcydzQ3ZjBzVU14U0tJblgyMEVr?=
 =?utf-8?B?a3R5OXVKN0pBbUhWeVlROVRpT2ZHYngvMm15R3EzaW0rdzNkcFh3V2RXbnhI?=
 =?utf-8?B?RnVPNVhua0pXUCtBZW56dmFxYVl4eVBraExRbithOGNtRU1EdmpSc1ZyWm0x?=
 =?utf-8?B?QkVTMjBoSXduQ1JtUUxvMnh6RmlJMFlvWndCMm1GK0dWVlJXMG1jM0V6NENr?=
 =?utf-8?B?TFNuQXJML0NXSmdQZkh3OFZmT3UyRFY0dno2ZTBCc0NPRnBXMHhtSzAzRVF3?=
 =?utf-8?B?RGdUaWI0VnN1UkppUWlrL1V4RWtrcit2YnJUYkZNWHpTSldDOENPcFpPcVBE?=
 =?utf-8?B?K2xpUWpRdkVjYW9XaVFsN1Y2MzdMQXJrN3U1UGV0UWFRam1SNlFkUzZCMkdO?=
 =?utf-8?B?ZjJRMHBmTk9BUFdxdVdUM3pmajVxeG85bUxlVWhSN1M0Ti9Mckh2c1VqREpF?=
 =?utf-8?B?OEN5N0JzRFhlM3MzZHAzUGFNU1J6cHNVLzV4OEVCNGlaVjZ0aTNubUdHU0ox?=
 =?utf-8?B?RURaWVNMTGJwb21ySFlML2x0aDRKcW44TXdWZDlXZHE4ZmsxQitqZ3J3ekFR?=
 =?utf-8?B?c3VVNGtHMDRBYjZ2THlSUU5lMDdOS21jaVZyL2V4anRqTDhhdjFWczRWWUlM?=
 =?utf-8?B?bTdoZ3N5N3djdzNoUnNPa3pKNEx2bmlzT3JHTnlkZUh1UWFVbjFPdURnZ0Ur?=
 =?utf-8?B?VExWQ1dCUzlNVXFucVZxa3JCNldRazVWMHpwTG5QbUF0cHBTc0RjRmdJelJq?=
 =?utf-8?B?R2hOT0FhMjJhOUdINFJqVlJBVzVURUl6aDZrSlBQUnFTem10SVRhMldRbmFG?=
 =?utf-8?B?TnF2QmN0SlRQazZWZFdSTlowRVNLcjVXa0dzbC9zM0NlNWN6LzFtV1FCMUhK?=
 =?utf-8?B?RTVrL1graFRKL09XWGNZU3U2UnUxSnBvOEJFVHFFMy91UFlMamxXbXB1RDhy?=
 =?utf-8?B?NzlWZ3VMQmtocWpRcUtUUU8rQmpPNlRSVnYxbVdWa0k1eXdlUC9aOTRXV1BR?=
 =?utf-8?B?WXNmV1Q5NzNnK3RrVlkvbnBNM0ZpZXJOWTN0aVNaS0dlMktJdE5jMVZLVDVp?=
 =?utf-8?B?aE4rdlRQRndSOUFBNko1eHZhTTJRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5cb6cb-0323-49b4-c865-08dca286c900
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:24:56.5209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fy56+NfKLx2GNZ4OKxMpD6Q7i24DtURF6RvzBAqZaChefmI62rakPtSFcWevgT+6jSa0kiwEQwSGQsFtIC/8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212


On 12/07/2024 12:48, Robin Murphy wrote:

...

>> I am seeing some failures on -next with some of our devices. Bisect is 
>> pointing to this commit. Looks like the host1x device is no longer 
>> probing successfully. I see the following ...
>>
>>   tegra-host1x 50000000.host1x: failed to initialize fwspec: -517
>>   nouveau 57000000.gpu: failed to initialize fwspec: -517
>>
>> The probe seems to be deferred forever. The above is seen on Tegra210 
>> but Tegra30 and Tegra194 are also having the same problem. 
>> Interestingly it is not all devices and so make me wonder if we are 
>> missing something on these devices? Let me know if you have any thoughts.
> 
> Ugh, tegra-smmu has been doing a complete nonsense this whole time - on 
> closer inspection, it's passing the fwnode of the *client device* where 
> it should be that of the IOMMU device :(
> 
> I *think* it should probably just be a case of:
> 
> -    err = iommu_fwspec_init(dev, of_fwnode_handle(dev->of_node));
> +    err = iommu_fwspec_init(dev, of_fwnode_handle(smmu->dev->of_node));
> 
> since smmu->dev appears to be the same one initially passed to 
> iommu_device_register(), so it at least ought to match and work, but the 
> SMMU device vs. MC device thing leaves me mildly wary of how correct it 
> might be overall.
> 
> (Also now I'm wondering why I didn't just use dev_fwnode() there...)


Yes making that change in the tegra-smmu driver does fix it.

Thanks!
Jon

-- 
nvpublic

