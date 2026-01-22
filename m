Return-Path: <linux-acpi+bounces-20543-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB1YK5cicmmPdQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20543-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:13:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6D67223
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 153FD745CC0
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724544D002;
	Thu, 22 Jan 2026 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CDOQES9f";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CDOQES9f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA5D44D025;
	Thu, 22 Jan 2026 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082787; cv=fail; b=n1GkUwwHaa7k4/IefF0oaVeNsKPOV8qThc+yddjMEcSWKsGUdcy6uq9AmcH7AUlVMhnbhQbIKLBidL3Stvw81LcHkOVKUVD3pkqFciuNc0GY7czolKfJZoxh1Tg6SIeGq/V0x+0PHIsYZwgwIhWvLJccrq2ILBRrw7oIUQQ0M48=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082787; c=relaxed/simple;
	bh=mIWXH6nWn7AlOTcO9I+fWVZGcH0QYCAEIBl2Hmnq/fY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCsPKg3eJjN0xSJkVra9HO9L68VMf1t3TytMXTdknOPxo3ch9etEmMk3OGDZrFnx9d6bYnLZW72Qex7ZtfAPC5U6Rp4D5TaebMvzgruim/EmpEw0yj2YAmZV1vpSyQXA5bRb47A8LTDhRhjH+IvHZ56OXFrOQ2OuRrFK7G6NysU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CDOQES9f; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CDOQES9f; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=f+6uh1igmQloc/+XBp6WgqD/36Yi7MdF1McXeNWxlCr8OoJH4uv1pZGCAoQWpDNNHZwQ14uoePSskPmGutf+LEy6sPhzC4vMOApqL/2ZSDzvFkX1qAQ4HPaH1X5cCeT5s+G1GXmpw1gQJ+dSSsvNtroym8r54jxjTKAAiz/Xqe1rrE8iOMPl34bKS2DLDc1iIxJoZsdZhIH9ntZHyoMH38d+N3Tr3xmxYE0pqVYwXrpVGfmJYWBo7TyESMvtf3I6079qpI1Z8G6Ur3XxSid29fvC1+Zk/TlNYJg2sBy6mCNFU8za5NMKZaPq4Wpiv2fzxZh75ITuotXXoIcUkBeK3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWMcjtNjUEFd3I4A6wJnqsl7M34VBIk160f5cq//bvg=;
 b=X1oSx9Rm+bhBVNE3pB/dcrbTccp5Yzbmqyq170FIBY38F2Pgjyi6YLByQeu0LlNCWfHKm3nfRP9bGt///+Q5ZqB+5rG47+d3hqekwGURbjRHXLmBJ5e+j38fNc+qM9nPRGKEEGsxUzmakFgojjvbUDRoeNtMTAmJJ9AT3oXX5rzOEPUktftvgtUFbhbfK4gQPuU3kWW7CWR0GUODSXu89NIYvOO9V7MSILGyvffMKcaqNHuaeHeS4AqMy899nkJ2/H5TET7npG4xz9PJsthq2wR+l7DkJjOqwVw4RJqAabP2z6AgFHgzaUiQXd21gu1zeENPkJu/tABRaD3TKdkPgQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWMcjtNjUEFd3I4A6wJnqsl7M34VBIk160f5cq//bvg=;
 b=CDOQES9fNd1bkECazVuISPynQjEPSTExTD1wnRSqDQ7UVG0S5oYenfqGdkkKwj9ZyU10x0fG9PK5E04lB7gMFYPf1Hg+kEAnl15t6GasZb0y3lXR21VFeeMvYuhPrc9PbkBlfsNyPaZU0hoQddR0T3+CKVJB/s5KU0kPGrJxDag=
Received: from DB9PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:10:1d9::31)
 by DBAPR08MB5638.eurprd08.prod.outlook.com (2603:10a6:10:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 11:52:57 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::95) by DB9PR02CA0026.outlook.office365.com
 (2603:10a6:10:1d9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 11:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Thu, 22 Jan 2026 11:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1q1wDRN0jwN0ySDBAzwxfV6ralBkV1WkbXQwE44//FVWtAFMMDKybUqJNc4s6oN4aJ3rP/AxS9VwwXyEIhGiY/CqYK156pUihNUS6rgTuv4AwzEtswlM4gL/ZpaD/fO1ZPVk82YM3z2s3/A8v7lIPLm7C2uYqoYJ14Aw3MWdbyBsCDjBJzbluqFNBP7Fa2XWUovdGSLu0psAmu3IkRSraaegNHkXwiAqFAph4206Bn2ciU+ujrVjdb6ntHy2K1Z4KcwLL4GcJGErfPXYTAO/cBfDuq5Mh7nBgFTjU1YK73W/XFTBW52d1aryjRBUWihPKuwzHqZK2uZjluoEGA/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWMcjtNjUEFd3I4A6wJnqsl7M34VBIk160f5cq//bvg=;
 b=TgZByGLCzCA3lXICtoT2g6/j9TTtrBNBVQc4fvDQmXqlu1i4rmL2k6shLr93g7wN7XnpGKA5u/xQh4q8w/kvJprTGz46Byceqr8OO1bl9Vp7t8bfwvrkFUuBAQiIQE8kQA72yuBkN/izk28Kf2+wA6xxC8omFCFZm6MqhwuO6HLtqfSNUBd6dyDK8j2q3uzH5t74/H9MNCE9ncuwI+kd5/v973nqStfeJNjEt+cBuj0f3CoknTypJ3R/EKRdmjFm8O4MCyYKG9STlfKrJ17da1hsuf3GifcSf24Jgi+14QVEwyVKq0qX9kLjwL0/fi9SBmwrgy0F+wH7Canq1sDWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWMcjtNjUEFd3I4A6wJnqsl7M34VBIk160f5cq//bvg=;
 b=CDOQES9fNd1bkECazVuISPynQjEPSTExTD1wnRSqDQ7UVG0S5oYenfqGdkkKwj9ZyU10x0fG9PK5E04lB7gMFYPf1Hg+kEAnl15t6GasZb0y3lXR21VFeeMvYuhPrc9PbkBlfsNyPaZU0hoQddR0T3+CKVJB/s5KU0kPGrJxDag=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by DB9PR08MB6473.eurprd08.prod.outlook.com (2603:10a6:10:257::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Thu, 22 Jan
 2026 11:51:53 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 11:51:53 +0000
Message-ID: <e47509a2-c1fc-45b7-828b-b957b9f8ce1a@arm.com>
Date: Thu, 22 Jan 2026 12:51:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] ACPI: CPPC: add APIs and sysfs interface for
 perf_limited
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhenglifeng1@huawei.com, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-8-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260120145623.2959636-8-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0198.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::14) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|DB9PR08MB6473:EE_|DU6PEPF0000A7E2:EE_|DBAPR08MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a02d797-10a9-4862-8f96-08de59acc8f7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Mmk2U05UTTJCRUwxVUFNT3grd29jYWlaMTVFV0wxVjArUE11WVNGbjQxUzhr?=
 =?utf-8?B?dDNldHF4cWhxU215VEdBM3pEKzhnQjM2UUlLalZUcmRzOXgxZTdld0Qvdmwz?=
 =?utf-8?B?cGs5UjE0b3VkaWpwSFFQYlY4SDBZeTFRcUtiWHRxRWd3STZ1T0ZPL2RrL0ts?=
 =?utf-8?B?cjhxa0RHbHd3MEdMUnMxc1E4YWF0Y09tUW54VEg4ZmZuditnOVdNUlpZZGNu?=
 =?utf-8?B?ekM2ZmtlQXd0ejU0MEpESlo2bUxHdmNRZmpEZHN3enFSbHFKeDNrcm1ZcXlJ?=
 =?utf-8?B?VCtxSFE2Wm8wTTJVZ2xsL1dad2FiZWpwZVNjQXJvenEzaE1GT1hqMWlsYnRV?=
 =?utf-8?B?T2Z1M09acFAxRjYxbnBlRklEWXNaenQxbjBudDVVdDBTS1REQVVYUlJrM3p4?=
 =?utf-8?B?YnNxWjRsVVVOeWJFaGwzS3hlc0ozVXFrVlJjRlZSZ09IbHpWaXJFblZKMnlH?=
 =?utf-8?B?dmxjYStOOEJ2bDlsQ2hkb1JzUHFUbnYzRllnZHhMVjJXd0ZSaWZFNEU0Mm1T?=
 =?utf-8?B?OENuOW50TG5QeUwzaXZ0UDR3T1RYMDYwb2szQjE0WWs0eHVCU0MxaGFLSHZS?=
 =?utf-8?B?eEJ3YTZvVm9lVGFFTHpxdHFUeUlva3c5dDJpUHNmZzNwSjM5ZmxEUFFhSkNN?=
 =?utf-8?B?TmYwY05CWHVtcElNT1BXVXNKMXdPNzZjUllLdVlJSThic2M4TVFoM2x1OVI0?=
 =?utf-8?B?dWx1YWNkaW1HTXh1NllON3dxVFdyNE0yTG5wVlZXdkxJMlpPaUtMMWJMNFE2?=
 =?utf-8?B?a2VQWnA3cTkvdVlTQ24vMzB4Qk5QN3VwWWk0Kzl6MjFKakN3RXpudEsrVlRy?=
 =?utf-8?B?dk5BV1ZPRUxLSFBJaTJGdzRhRGErb1FWTVdaS1JQS1k0ZThyUTZ1QmN5bHlu?=
 =?utf-8?B?MXA5THZzTFJZNlIzTjloU1JwcGRZK2ZLamdGdHpWRUFRSFQ0QS9udktDV0Zk?=
 =?utf-8?B?ZnZPOHlhaHFQaTBYUEh0Sll0SlBkeWJSbGxwTVFxbVhwSFlNMXhoUHFwV0oz?=
 =?utf-8?B?YWZ6aVRpajkyTlRKOHI2U21teGJ0ZjZSY2lpTEgrRHdaWWE0TXUxWExqKzkw?=
 =?utf-8?B?QjRaelB4cllrTkV0NTU3dkVRUWh5b2lXZ3ArYVYybXlHMHhPdFdUeTduZlFW?=
 =?utf-8?B?ZmJiTFAwNUhxa2ZKdDJIL3hKR1hqeDV1VzRkUGRhK3EzaldDNTBTK1VSb0dv?=
 =?utf-8?B?dG1KakVrV0txSnpqVFE3SzJrQ3VZOGpuZ2NyNGw2QWhWdXl2clVZd0duWGRp?=
 =?utf-8?B?RlpzNmtlQkl0ZzFlWnlCMERvM1hkVlZDNm90T0VNT3VwdVdFRS9xbFcyVE92?=
 =?utf-8?B?cThuQkhxK3I0bktab2xDM1F5V0hZTlozaCtLTVk1ZHJtMG1yUUFaaGxxaWQ0?=
 =?utf-8?B?TXR5YUdQK1Y5aWJFalVTNnN5SkxUS3hadS9XU0Nvd3hRMHZ1c1FoT01oWFQ3?=
 =?utf-8?B?NTJodVcxTTZyUzkyWlhTYnNDTWhlNmYrT2ViNUFFeUM1VWhqRGxmSlFmdkUx?=
 =?utf-8?B?cGpRUG9zbUdMbW01M1pBQldrVUlhM25Ga2xYQ284RTBjNUw4WEk1TWhjTGVN?=
 =?utf-8?B?MXl4V3VrQklDQUpUbnE3SFpPenVDdVpESDJ5bTNObVFrc1YxMTZ0RTJVU0Ju?=
 =?utf-8?B?VGFacUc5TkRrUTZvRElHUkhxcDkrN0ZEVXI3bUlNNU50MzNrZVdsQkEzdU1i?=
 =?utf-8?B?OEI3aHpxK2VObXN4MldyVmxxK29LZEN2R3lHemdUVHI4ZiswUXVXQzI4NGNG?=
 =?utf-8?B?Q0hGdUhFbjNJVzVDbTREZ2c5REsyQVJFOHQyOWxZelVOVlBOcTZCVm8zVE1w?=
 =?utf-8?B?UVZlWVhJM0xqbzg5MmF3M2pFZFdJZU5aOC9Ec1J1dkRTdUZZczVlMFBJaDFq?=
 =?utf-8?B?ejF5V2loN25lMkNmNG5hbTdTNW5ia044UW5YdE10Y2FLQkF2blRSTVhvM1I3?=
 =?utf-8?B?V0pDblJBV1dROExaUkN4VFJyNVpIOHJybEwwNy9rVjBpNmlFUU8vaklTQktW?=
 =?utf-8?B?MnloaGQ3Q2VUVTR2SUhGVWU3LzZZZTJBR0hTamR4dE5NaWhZTGNNNzJNc2R0?=
 =?utf-8?B?Mzk4cWJKYlZLZWtGZjQ0RGtVb3ROV2p1c0s4MTRRc0dQa0pkaG1EeVk0ZDkr?=
 =?utf-8?B?SzY4VFVnd1RlVDlQRHZLNWxBZ3ZPNWUrTlBiZ3hwUU5DYUZwVkwxdyt0NGFM?=
 =?utf-8?B?MFE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6473
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7abe1b96-4437-4e00-f4ee-08de59aca283
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|376014|7416014|82310400026|14060799003|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk1KOU02a0ZsTUdhd1h6YlpJMjM1MjNDSUNIUitSb3R3b29TVXR2WUp3RC9o?=
 =?utf-8?B?cVNCYlhGdnRHdmhlT2R3cTJyTkRLanlnUjNtWU8vWnUraHorNW45blVocDRQ?=
 =?utf-8?B?dnBCSDVBallQMEg2WklOQXZ2Rm9Vb0FuaHM3cTFQdzJDSFRTbWNMWlkvd2xH?=
 =?utf-8?B?WFlXTmVZb1hkdWFyZDduQVdOV08xR0dzTlZHYkdXQ0gzQ2NJeXRWQzhEWld2?=
 =?utf-8?B?RkpnSm1CREVNRDFXZjdTWWJpSjdqd0NCbjEvTFQrNVAyOXNzR1hVUmtzMGdt?=
 =?utf-8?B?S214SFFCTStjazBjYlh2V0N4YVE3UUFiQVczanNvREwxdFhVQTljTnJZWnVw?=
 =?utf-8?B?WlFrSW1HZkVTT2lVTDZWVTlmcDlEQkE1WkoyWDl2MHdlZDN6V2hwazFZNzlG?=
 =?utf-8?B?cnBnTWxzbVBxTDZVVyt1WFJFaExJOGdrOUpnRUlYVStBYkJtWGNxbnJheXVZ?=
 =?utf-8?B?Y1NtQ1Q4bHVCZEpFQVNyN3I3blYrY3pNblJqOTJ6ZXo2QjlOWUIvSmlwYzEw?=
 =?utf-8?B?aVhqN05hbmhUemlnQnRFckZLSVJBRkt3dlRvZGphTXNpNzJrY1NwNDFkcGx0?=
 =?utf-8?B?c3pYektMSndMc1pVL3daU0NoQTk3TURoTGVpejFEZmRmWXo3QktZOGxsSm1S?=
 =?utf-8?B?R0tNOXZLcTBEZXJmK3VDVE9hR2x1SjNDK3h1bXQxKytBam9xRTdOclRCTmE5?=
 =?utf-8?B?RCtadzFGeml0VDhXYTJsRmNvdjBmVXZMOTRDK3YremJ2cnNLZHl2ekFjTmRo?=
 =?utf-8?B?ZmREWjg0eVB5YzN5YjVrTEduYmE5cHdwK1lybVlsNjR3b1ArNWJ3NUx4Q3N3?=
 =?utf-8?B?eTFiNDc0RzBNVFZtTWFrUGVqcTNPaUQ4REJZR2dvOXRKaGhlRUVzZXBpUVI1?=
 =?utf-8?B?WnVIeVdwQk5IYlB4d1Y4RzFtK2E5WnN1MXVRS2VNWUQ2NXFyQjRRQUR0dUp2?=
 =?utf-8?B?YXlQSE8yTUkzV0RVQ0ltYmZRVit2VXppR1U3ejdhOVJPZVo3WVZpZ2VESDJM?=
 =?utf-8?B?YjZtbW52Si9id1M0aUpHWC9RWFVRVlI4M0JNc0V6UnVNUm1rQk9Gb2dYSGNU?=
 =?utf-8?B?TUpGQ1dYSVFsQ2l4c0JwbHYzV0RRNVhsT1hXK0R0UkpINmtQQWxOcWpCQWhI?=
 =?utf-8?B?V1VDV1VHRFo0MWdZTFlxZlFPT0lIMUtLTFJUYy9XOWg2VlVtclBYU1NWMEEr?=
 =?utf-8?B?TzZreXNEdXkxRnB2UnZxVFdBZlpmV3dMNUtJNnQzUFQ1TE9jV2pzc1kyWHNo?=
 =?utf-8?B?N05YNDZpV3AzYTFQcWFkKzhCWFpqRlU1QlFjYzFPUzJ3WEhQNFhiSUtYZVVz?=
 =?utf-8?B?RHRGVktHNXFJbnUvS2MybGFsWXBjVlJuN2xrdDkySmZvYnNsdTUySXZ1OWlU?=
 =?utf-8?B?UFZldGJDU1lrQVI2UDc1OHJWQnRWZ01FTmxVWWNOSURKRC9YUTZlWmNIUThB?=
 =?utf-8?B?eU9QZndSUnlYM0VCMFlZWlZ3bkxobjRHcElzZ0NtTkgrMVQyYnVBdm1TZkR5?=
 =?utf-8?B?eEVlMUJOeFcrVFhmRGdSVkhRUzdFenl0a0hCa3BFWk9nMmI4UEgyVG9LWTU2?=
 =?utf-8?B?V0c0cE05ZzV0ejRDZmtTUmdaSDVUb3NrYVJiamFoVnAzcXBoYmNEcjFFSDNL?=
 =?utf-8?B?ZHI1aExYNURRUmtSVzB5aUtqQ0M4ZFVYTE1NUEF4dlkyS1dha0loRStYMFY3?=
 =?utf-8?B?WWFKSWNWeG81aEQwNUNSeENScHgvejVueUN3UUlscEtyRkRLVkRDcUpTTldT?=
 =?utf-8?B?cEJYVmJxaHNGRkNCK3l2clN6R3Yrc1BTdTFteEdlSkFYT1RWcmVkMldBdm9P?=
 =?utf-8?B?Vzd6Lyt2V1ZDVEZpSVFkS3hmeHFsaDU2c0ViSS8wcVlXbFlMc0s3Tld6S0xz?=
 =?utf-8?B?eEtLMmhWNDJYTjlLcldpNGFCUGlkSGF2UkJpZVJaWGRVSmJ3dWNBVDkxQis0?=
 =?utf-8?B?di9LTFZXRDJneVZFQmNiOFUxTGVTMmtwK2lKcHpCUjBaV2xVN25tcWRzZTM1?=
 =?utf-8?B?Z2t1NUR5TTV0dmVWVEMyMkVVZzJCUmNsbjhZbzVJcmFsTlBwbytNWksyNm5j?=
 =?utf-8?B?ZThxUXhQaE1WaUkrS1pEM1U4R2tNc1lZOXZQaU1lSkVtQzd5ZW11UkhyalBG?=
 =?utf-8?B?blpNSVJiNUQzN2xIWnl0aTFhN1FieW5uczBxWkVlRk84YnlKRnR3cC9GMHMz?=
 =?utf-8?B?eFpaZE1IeXBwTnpuWkZCYks3NXF5WXdsbmhUOEdlMWVoN3RoSTloVVI4ck4w?=
 =?utf-8?Q?nUV0uxFpuedAzOIJnT91+/naWjicBAoED6y9JojCI0=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(376014)(7416014)(82310400026)(14060799003)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 11:52:57.3024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a02d797-10a9-4862-8f96-08de59acc8f7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5638
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20543-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[arm.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,nvidia.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 21B6D67223
X-Rspamd-Action: no action


On 1/20/26 15:56, Sumit Gupta wrote:
> Add sysfs interface to read/write the Performance Limited register.
>
> The Performance Limited register indicates to the OS that an
> unpredictable event (like thermal throttling) has limited processor
> performance. It contains two sticky bits set by the platform:
>    - Bit 0 (Desired_Excursion): Set when delivered performance is
>      constrained below desired performance. Not used when Autonomous
>      Selection is enabled.
>    - Bit 1 (Minimum_Excursion): Set when delivered performance is
>      constrained below minimum performance.
>
> These bits remain set until OSPM explicitly clears them. The write
> operation accepts a bitmask of bits to clear:
>    - Write 0x1 to clear bit 0
>    - Write 0x2 to clear bit 1
>    - Write 0x3 to clear both bits
>
> This enables users to detect if platform throttling impacted a workload.
> Users clear the register before execution, run the workload, then check
> afterward - if set, hardware throttling occurred during that time window.
>
> The interface is exposed as:
>    /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c |  5 +++
>   include/acpi/cppc_acpi.h       | 15 +++++++++
>   3 files changed, 76 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 46bf45f8b0f3..b46f22f58f56 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1787,6 +1787,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_max_perf);
>   
> +/**
> + * cppc_get_perf_limited - Get the Performance Limited register value.
> + * @cpu: CPU from which to get Performance Limited register.
> + * @perf_limited: Pointer to store the Performance Limited value.
> + *
> + * The returned value contains sticky status bits indicating platform-imposed
> + * performance limitations.
> + *
> + * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_get_perf_limited(int cpu, u64 *perf_limited)
> +{
> +	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
> +
> +/**
> + * cppc_set_perf_limited() - Clear bits in the Performance Limited register.
> + * @cpu: CPU on which to write register.
> + * @bits_to_clear: Bitmask of bits to clear in the perf_limited register.
> + *
> + * The Performance Limited register contains two sticky bits set by platform:
> + *   - Bit 0 (Desired_Excursion): Set when delivered performance is constrained
> + *     below desired performance. Not used when Autonomous Selection is enabled.
> + *   - Bit 1 (Minimum_Excursion): Set when delivered performance is constrained
> + *     below minimum performance.
> + *
> + * These bits are sticky and remain set until OSPM explicitly clears them.
> + * This function only allows clearing bits (the platform sets them).
> + *
> + * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
> + *         access failure, -EOPNOTSUPP if not supported.
> + */
> +int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
> +{
> +	u64 current_val, new_val;
> +	int ret;
> +
> +	/* Only bits 0 and 1 are valid */
> +	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
> +		return -EINVAL;
> +
> +	if (!bits_to_clear)
> +		return 0;
> +
> +	ret = cppc_get_perf_limited(cpu, &current_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear the specified bits */
> +	new_val = current_val & ~bits_to_clear;
> +
> +	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
> +
>   /**
>    * cppc_set_enable - Set to enable CPPC on the processor by writing the
>    * Continuous Performance Control package EnableRegister field.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 66e183b45fb0..afb2cdb67a2f 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -1071,12 +1071,16 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
>   	return count;
>   }
>   
> +CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
> +			 cppc_set_perf_limited)
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
>   cpufreq_freq_attr_rw(auto_act_window);
>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>   cpufreq_freq_attr_rw(min_perf);
>   cpufreq_freq_attr_rw(max_perf);
> +cpufreq_freq_attr_rw(perf_limited);

If the OS wants to get regular feedback about whether the platform had 
to limit
the perf. level, it will likely try to frequently probe the register.
In order to see new events, the register must be cleared. So:
- is it a good idea to allow users to write this register ?
- is it useful to expose this register if the OS frequently clears it ?

I think the functions are useful, it might just be questionable to expose
the register in the sysfs.

>   
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&freqdomain_cpus,
> @@ -1085,6 +1089,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&energy_performance_preference_val,
>   	&min_perf,
>   	&max_perf,
> +	&perf_limited,
>   	NULL,
>   };
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index b358440cd0e2..f3a04ccd10b7 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -42,6 +42,11 @@
>   #define CPPC_EPP_PERFORMANCE_PREF		0x00
>   #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>   
> +#define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
> +#define CPPC_PERF_LIMITED_MINIMUM_EXCURSION	BIT(1)
> +#define CPPC_PERF_LIMITED_MASK		(CPPC_PERF_LIMITED_DESIRED_EXCURSION | \
> +					 CPPC_PERF_LIMITED_MINIMUM_EXCURSION)
> +
>   /* Each register has the folowing format. */
>   struct cpc_reg {
>   	u8 descriptor;
> @@ -178,6 +183,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
>   extern int cppc_set_min_perf(int cpu, u32 min_perf);
>   extern int cppc_get_max_perf(int cpu, u64 *max_perf);
>   extern int cppc_set_max_perf(int cpu, u32 max_perf);
> +extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
> +extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>   extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>   extern int amd_detect_prefcore(bool *detected);
> @@ -290,6 +297,14 @@ static inline int cppc_set_max_perf(int cpu, u32 max_perf)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
>   {
>   	return -ENODEV;

