Return-Path: <linux-acpi+bounces-17589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC4BB9369
	for <lists+linux-acpi@lfdr.de>; Sun, 05 Oct 2025 03:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA0F189B691
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBE17DFE7;
	Sun,  5 Oct 2025 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gVIOo9dI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919D34BA34;
	Sun,  5 Oct 2025 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759627729; cv=fail; b=qH7ByajZi6650BoWK8Zmj9pwD3Lk7hPDKG8enHy2L8ZGJyo4xYWMW5+Fyg6hgbwsoFGHs74/FKT9C4UGv2QrXgC4Ofgw7EwekB7tsx+UKcT+OX6/40n8tFwXsxvapZEgD3FKd9KK5MgsxD924ZqOT/FmEtR7mrPFnK0WiS5eozY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759627729; c=relaxed/simple;
	bh=Sh06bvWeSkZHaw4kQXPVzrMB/b7FuuS+vG1kgPkvjN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EUasJHGz9vbkRDIUCNUOTfFJloJC6tKJQAwzqMerIPgfVcfHvZEqf1sGh5en6yHlohEqtQZFXPrq1JVOSeQGPST+VqFSzFJjGEcgHTZW6IP28dlPmZNq7uZ436eK8agFDIQiVc36iowdVvxv7sKYkWnj8G9pSgYBlnQeD/1nua0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gVIOo9dI; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g86YIeS0Y8Ebw51pAG+GDgruD8/CaFH9YaL3wulLLmcqYs1N1+VtvW89Qd8SdK3IY9OwA/Pfi9/QjN5Dm+ozeGJkj3h9AX97jRZ2/vnB1q2/4Brw6XgXo+LZa+VMI1x9VeC6XV9ZKa/Ur6AvcsOVrF0Qpi1agyOv+OlL/M7Pga1O5IMW3ukeuThAXzU2fQZMVibVpd9CP8sO1j4PcLnQXL8p9v4Kwkq60aCrmTgDyBNWwq7Zd+khtcTI4Oc/nzCAGczB4LzC9asknEJMrgN+6NLucOEelvf+sHE6lz4e4mhs141eadV8JFa9Rhc0LVqI2MHiFv0Zs8RRoaArbDko+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh06bvWeSkZHaw4kQXPVzrMB/b7FuuS+vG1kgPkvjN8=;
 b=jCs1dF3zevNo/qS4CsD6lR0UIUdNBrzd0gx3z5x9Re6F7JGwqvR930C8qSJYFlKhs7F6y95B1LlTctJO44w298AKkGAguqHk1Q/gdG6lLf5XZL1g4bAPA/dhyo4sS2xw/aUl9N+NPORPU8AsWqlUcW4dp4N2CpTDsZU/nk9NsMAT7DHLa4Xu7yZIWGoNta5q3Ey2TFyrLDZjSidewhrdv/QDuNaOrxHz3y9TKLXwnZ8aTzK6vbo1LRh0ndtZ4hiLKleVfxTyB1uJOWZJ5tdnHTdJ9/bht0i3Hcq4TNeZwceR43EIeE1sFANbf7679UA/qFPJXWcr8vhfTTwPFT5gHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh06bvWeSkZHaw4kQXPVzrMB/b7FuuS+vG1kgPkvjN8=;
 b=gVIOo9dItenTGU2zOR2z9MiKyTjelE+w9HFyvAWkLEDNNgTvBApdXHkImiZgdpCPf8pjq3fO3YLgVZnjweo8C/R3LyDeL3jqXhzyKYJ+DS6C6CayjBjtUI9CLssDu0ruyuHqCyk05jEqtriowHVuf+xuU9O8ovUretUdm3KtjPkaZgDXBh51ixsUIiae3eFSxZEY25oCJwnxADJYZfr9fEwXTaoJ/xEfH7BDC26JvohDYs+Ff17ugwSI8AImoEscnzjmHeiekMHKo94OEfUZx/S7XU0qT9R4mmG4LIR6KtS1pY2XhpR0RCTdW8ObYUpZhKegr77OFuQYv/f7Bj87sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Sun, 5 Oct
 2025 01:28:39 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9182.015; Sun, 5 Oct 2025
 01:28:38 +0000
Message-ID: <b823d313-2df2-4d10-90b3-cca026b12d80@nvidia.com>
Date: Sat, 4 Oct 2025 18:28:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/29] arm_mpam: Merge supported features during
 mpam_enable() into mpam_class
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-15-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-15-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: a840d8cf-ab89-4c9e-1d7d-08de03ae82af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VytnZ0dBZkZiYUYxazlKT3YxTnNNSzFsUzhNWU0vcDE2TERtb09nK1N4TENN?=
 =?utf-8?B?Q1NOaHoySDduZml3Q0xGVjdaN3pneWVlaXI0a2VSUTRFRzhQQnJFVk96S1Ey?=
 =?utf-8?B?T1dXemlmZVhXREJVVFZPdTJqMG96eVQ4L0REQldIYWg3cTFKZGREbTU2Rml6?=
 =?utf-8?B?eEZNMkF3S01QdUttdnF3YmUzek5aSEJHZSsxdVlmc0VXOXBUbW5XQU9DTW1L?=
 =?utf-8?B?T2tDTEo3SndFc2VRMkFVbXg3N05IZGZDdDhGdHlnK2ROaVVHQUlxTWxRR3c1?=
 =?utf-8?B?S1k5TGtkY291NDl4TW1rY0EvaHlRL013QWExKzQ1aWVnWUlPQmRSc0t4SWla?=
 =?utf-8?B?T0p4UHNkUm1UZWdFWHNnTjhlZVlGU05ZVGk1NFZOV1ZWODRFL2grNElnRFFu?=
 =?utf-8?B?TC9wbER2UkwzcEZPWXJKczZGS09SQm1QTjE5Q245N3MvKzE0aDVFSDlCMkRr?=
 =?utf-8?B?RWExS2o5K1VzTDhHUXNSSFpOS2tqWWs2WTdpTUZDVThSS1EvSFZqM3ZzME5S?=
 =?utf-8?B?YUMySlZPNCt5ZFdRT0o5YUMrUGFReHVPYTRMUEovSFNtczRIamQ0bGNKWlht?=
 =?utf-8?B?amZnOTdjZ1pHWG8zWXFDY2xtVlMrd3VSNDNvWnVjQlk0WWxpQ3dPY3NwNHh5?=
 =?utf-8?B?cGVtK3gwSkRnK081QlRRZ2p1MjF6T3NiazNkK2dTWEF0VnQ2TGRENFk3ZjJy?=
 =?utf-8?B?VnJJUGZCcnQrY0tuenNUOEpON1BmcFlTR2hqN3ZmYzZaZ0FxWmZUa200UWNR?=
 =?utf-8?B?Y2JYLzZKR2lWWDUrcGlTdzhYTmNraG9KM2ovTmxsM0owM0h5ZWJhWTIyRGd3?=
 =?utf-8?B?bkRrTEZlb1NxWXR5UmZScGdQQU1kczJuVnNOYUFCTzd1YUw4UGZ0aHVNNW1D?=
 =?utf-8?B?SjJuSEVlVC9INmxJZ21ITUZWLzFLMnVISzl1UER0UlJtRVRoNUlERG1RY1hO?=
 =?utf-8?B?T2Q2SWt0Yk40TStrNC9Uc2pOcThtbVRyVE1Tc1NGSmpRUnBjTDdGeTAxRDBE?=
 =?utf-8?B?c2JDdkpUR3pHU21uV2Y5aUE3MDRTdHlhZ2NpaStjWHR2QVYzTm5MVFdMRWtq?=
 =?utf-8?B?R1ZSdXpNTWFRMmlsNkZkRFlJQlZJQXJkZG9rSFA2UjEzZGR6d2FQaXo2TUxN?=
 =?utf-8?B?Y0Jqc2NIWG9FdlhhaVdBa1I5YnRXMjN0RXBOWTVFT2JYNmFTMWZWaUI0cTJz?=
 =?utf-8?B?WEhDVm5xSGhCcHNYYWRYMGNMK1JKR3lCTXZnRDlJMHVtS1pMTXc4ekp5RUdB?=
 =?utf-8?B?YVZtTXdoNlh4dDVsaHQrdm4yQzlJUGdQMmI3TmRoWXBFUEN0Z091T2IzWVJY?=
 =?utf-8?B?QlV3QW1CblZzbXJROGpram93N2tSRXRFcmgwY1ozbFNHYXp6WENrSjN5amt0?=
 =?utf-8?B?WHI0YTBWU2xWMitYcXhvekNIdVNkVThiVFNmcUViS3pzaTcvRXJYeUpmR0Q0?=
 =?utf-8?B?SzdFSXp3M01yQ3ozd2s4L1U3NHI5ZnZ5aWlJYWQyZWRTSUhzVmRza1paTVZV?=
 =?utf-8?B?bXhsVjdiVUljZmJSeThjc2pWOTY2RFZQTkIzVXZ0WmwxVEdxSmx6UTlvYkVV?=
 =?utf-8?B?aHZlRnhwSWhmY0NEVUxQTzlxOWVBcjY1S1BNc1U3Rm1MUGhtSWREU2tiU0NG?=
 =?utf-8?B?S09OWXdQZzZrLzZQdXU5amk2WWg3b1JxeFdqVnpDdEVqb1VhM29GNEdISkQ5?=
 =?utf-8?B?QTI2NnhXQzZVaTBiRlRLZlFiS2h1UmkxUTY5NG1odDBheDM1OUxPRHIzOUdX?=
 =?utf-8?B?ZXAzdDNtdFRYc2FLSTVVc3hkdis1R3dnZjQwSmJmbEtOQXp6b2Y0cWtQM0ow?=
 =?utf-8?B?Ukl4aDQrY1BVTVhLcmJJWnJNN2YraVRpUjFYZjlnaWhuaDN4Q01MUnlBTUFI?=
 =?utf-8?B?QzVRVElHai9QMW9kZHpTYlpuQ2VNWWRwOXJ6anFaMU9adWhSVmwvOTdKc05T?=
 =?utf-8?Q?Ag5s7I0/o17RB+Ew9kL05shxCdhiogwE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3VsK1BicHUxa1FxTWdlWXlXb214em05dVpWSmNNMElRSzkzOVdzZGNSSDJt?=
 =?utf-8?B?UnZCZ0h4UWIycWphdjJwRlpBQm41M0FhM3hFWldMRHp0Yzg1U1dQZHFFZVlI?=
 =?utf-8?B?T3VId1RCQ0dYOEU5K0VTa0xZWnBOWjBzbFFQRnBTREQ4SHBzMitZc3NCTGJT?=
 =?utf-8?B?UXRjOSszNlZYcHVvQ3cxNEpXUUNZQ3g0cU96WEJUYnE3cjZXZXhDSHgwMGI1?=
 =?utf-8?B?WXFKaDlGdm0zWFV2Qkw2cGhSVm1mOU8xNERRNitic0xBNVVBNUxMSTU4Tzdp?=
 =?utf-8?B?dmkvb0o3WnI4a0VYdCtycWpQY2dVQUdYN2Ixbzk5emx0cFErdzNCWHFicWY1?=
 =?utf-8?B?V3lqUGs3Rll1d2ZDTmFnZHk2bHhYSld5MDMxQUN1MVgrLzRsM3JzL0MyMmZp?=
 =?utf-8?B?aDZXT1B2UWVNT2lucE1JR01pNDlzSWQvcVZiNjNKSS92dUJwUGQ2UjVEalF0?=
 =?utf-8?B?ZHQzRVZoM2FtTGtpUmFGSEhCZEx2Nm15dHlhRk5HRDBuZFo5azFueTAzbmxN?=
 =?utf-8?B?WEx3OU1QWmpPVW5Wa1kvQVN5T1lVU25jZTZlQUU2aGtDdnZIU1lyRjYvL1dU?=
 =?utf-8?B?MXlyWmtiWHJoUmptMHltNGVNV282TkJMNE0xL25xek1kaDkza0tQL2NlbEJX?=
 =?utf-8?B?ZTl0Q1EyVk1DeFlWeUhrNXNKU283Wmdjb0dnTWVSM04yOEUxU2k5N2JOMTNK?=
 =?utf-8?B?dkpPSzdkNXFWazYvRkJtS1MxaWZnR3dzSDYrMlVBU3JXMk5pTFJRMTYxVHNi?=
 =?utf-8?B?MURBYkxqYUpvL2JzRXlsbkx1eFpFTG5rMzdCSFMybWhKTW5GYjZtQURBako0?=
 =?utf-8?B?VnZ6eE1yMHNuNEl3ZXYwdkUzQTNWeGM1dzY0Y0NvckhhU0I5NmtQMWZPNUNo?=
 =?utf-8?B?by9DclozSmZyWUk3djNscCsxUWx1L29lNnFnNjhITFJObm9WcGxJV2xEYm56?=
 =?utf-8?B?d21EMDQzeVovRjBGMkJ4S2dWY2N2WS9JZis1eC9Ca3c0cWNZREIyZGlRWTNV?=
 =?utf-8?B?T0k2WlJBTC9XcHIvQVRFaHJUMzV4dFRPbkpjdEIyUVk5bkIrYnphOTkvMUJn?=
 =?utf-8?B?UEdEZEN1NmU3TVFHYkExQ2VUMUxkMmVTWmRiU2ZZRVRDRWh5K2lLeGEvQ3FW?=
 =?utf-8?B?ZkVGaC9QNG9tSU5rUnQ4bXRMZ0ZSYlBWVWkzZlZBdThBc1VFRlpXcU45Yldl?=
 =?utf-8?B?UzhiQWVTNHozbXEzTkNWdDIyZTdyWmxpejZGTnJNK0h2dXVXQTN6U1RVSG5j?=
 =?utf-8?B?czhweHVKUzBXR2w1cEJvdU1jM1N1bllqUnV3eG4vU1lIT3ZaamErVmY3UXNW?=
 =?utf-8?B?TXZRNUFaTU00VUdvQkxaaDZxUStHVEtFYXJpbW1QOGtMY09OYy9RUHo5ejJC?=
 =?utf-8?B?SjBzWUMvYm5PTitNaWpYRkFDaWE5dTRjVHN0RXZ6MFZXRm5jL2RUSllTTUVR?=
 =?utf-8?B?MVN4S1k2NjVrQk85NmxhbExpNURGdHVlUnlJWjVNWnRMSnpRdExDY0pCRWZv?=
 =?utf-8?B?b1lNQkZUVzMzakhOZmp6QXZPRVdQbXhBZFpVY0hCd3RGMHFyK1dEOEVBNHh4?=
 =?utf-8?B?RGhhMzQ2K0NMd01pSkVZWTlkdlY0YXh0T3IvZ01FNkJXV3I5dmVhMTRNT0Fn?=
 =?utf-8?B?M0JyTEFUQ2JMZmR5ak8vUXgxRzJzQWlsUWJ2NFc4SkY3cDlEdlhlVEdVYVdq?=
 =?utf-8?B?RlAveXhIUCtpaitzZXA5STZzTzZmUFNSV2JERlpEMlBDeXZDMEoyN1h2YnVs?=
 =?utf-8?B?eTRhWjJueFBMTmI5QTJoaDJBZHMzelk1STRPMGEveWNBTGxqbVByckZxR055?=
 =?utf-8?B?RGZiNXU3OHFYWGJ5N25NODl1YXZ4Z3VYdkJQVTd0M1FiRzViSmxXNzJabW5R?=
 =?utf-8?B?Y0hRY214RW1iSEhTNmJsVXVhT2p1MG9kcFAzNGw5ajBxNlk2T3pnL0pCYThY?=
 =?utf-8?B?TzhnY3lOSldiTTlMdS9FYnNmVHhocGZkZ1NXOG1Odks5QnkrSFpZZnQvV1VG?=
 =?utf-8?B?cEpHSGNjN3NtTURBb0NTUzRPL2xIdnV5czdkR3lvTVdvMkxyR0h4UWNlczBQ?=
 =?utf-8?B?M3Q0UU5jejR3SytHbVg3TjhWaG5DcnlTMStFNTB4V1U2RWc3OXNLSXhoYTJN?=
 =?utf-8?Q?f6zMt4i1fsd5DPzLi0hfQtnzn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a840d8cf-ab89-4c9e-1d7d-08de03ae82af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 01:28:38.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hKTL6mEjA6+19ufLX3FY1yzv5dRf/gktWgwedXwUdcaLZ44rnPp0+B66PUFNgoNg0duHdlSr6RAWBjqvjDRQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160


On 9/10/25 13:42, James Morse wrote:
> To make a decision about whether to expose an mpam class as
> a resctrl resource we need to know its overall supported
> features and properties.
>
> Once we've probed all the resources, we can walk the tree
> and produce overall values by merging the bitmaps. This
> eliminates features that are only supported by some MSC
> that make up a component or class.
>
> If bitmap properties are mismatched within a component we
> cannot support the mismatched feature.
>
> Care has to be taken as vMSC may hold mismatched RIS.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


