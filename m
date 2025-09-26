Return-Path: <linux-acpi+bounces-17328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710BBA2683
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 06:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708C01C00ACA
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 04:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3053264634;
	Fri, 26 Sep 2025 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMdoBMPe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BA417597;
	Fri, 26 Sep 2025 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862290; cv=fail; b=bl7nZ0OCw6y7S9ZHKoulko7yPf/U7WcfRTRDMaBkVpMNELB3HsjnbMzFEB2GWv8TMD5xyLUJ9ntDqZHBsX80GhJU/fkG/KE18HhtQ6CfjYf7ZDw4cKXKatoHiB0Qau6aYAF2zDnlQ43dnPFoUo4MELrZMLnQLr9xJH+e3+HMc+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862290; c=relaxed/simple;
	bh=pOtU3L3bGfKBrqzN3y8rjpi4Wp+wh5cm89Iwmkst/pU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LZRmrAqVj2Ctz9PROwi2sLJXN4PLPCa4aOUmSge2zkSkTqI/2ICRWA3yLOUuSqyYERrZnOK/Vqum1F75qHY/8gnWoSXkjVtmmzR5lFOoSpZ7F9kesPwuVlMilhrD6DgEgw/pycuV7WRq0fbfdCqHWD0WFhgsY9IC3cdh7TDf9vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMdoBMPe; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIUzDb8zgOC1XNl37YnOQfB7UDJ3kcBIjMp54DxrdaDRRo65l0hd6bjVU9ZrlqZSbgfCvzv5UumItliiu+lDBFOTX/Uao7Pie/Fe2otPC/g/oqHtDLus6kR/OJjAPYcpQEtyN+8/zkv0/SAtRH3cPz8QY4jU7MMoilYYUOOboAyjArtO+IdoIL0O+aDk7AtIGVAqMwz6CDcErAFPLXq6IZU5T4N1KWHiHOKtSGNCxeFG0t73fVcb5s6gEDTmN+kQcCl6BhB8jVr8osa4iCpYH9s9iM7lBzwtHDBPLJn1cnjGNgC9S14/vm3J8xP+cbdimmkkzF2kkIXqbkH3yBhy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0OsopB8qtGjKmiOr36rZ3uPPsvTqF/ZTbGf9DCmbN8=;
 b=kt8gomJV7deK9KWZwwNQ5AWFD+n08rfxrxMq5BmPWnQVi9Dlzrvy4UhZz+z0xqkUejLSyPJKO0XurX0DFkyx8hg0FHygwyLd4zPkLW5O5/YIefG0WzbiBle8WjdN8HLoBUNY6+4LNBwB7LU0oydIYmEliDh80UgV89SI7/3txqjA03f8U8lZQgFjvT1HxZaEYTbPAC/kdLusH4+C+ZBxoc9KXcWdJDy9jJF9XcBwpjBWhvHBvVE9S3fzhKammIpykUmTbaPB/B/HgPtuXAS6kcbUvjfhMQMjVnp3FwwKrGgBvgENdTAGHTCbgRfAt91thj4HCKOoGW18eMFDmX2TFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0OsopB8qtGjKmiOr36rZ3uPPsvTqF/ZTbGf9DCmbN8=;
 b=DMdoBMPebtIq2HeQbQU9sIt4wuTueiBJTA+43nLO+E1xrHKYkmwT2wKwIqFglqjKy5p4OibO/vo0gjoVxi3DPBKkG9BKh8FFv0kw6M3IiBluZ3Wh56JrXnOFqVonToU2eIUyhH46usWoqNyHkJiW6/K6Q+vIfPZ0YbPangy7rQ5880uGI6QJGn6/J4qw4GmOYILBOwYdPkAqXQNyG+4O8ZplHXTILzKL6lN9J6LbHzGk8lnfSL0ddVtBj2aGJ5v7N8Ha5MVOuryWVu6ta7u3N9qNRX70ovye9C2LZmj1FmaBiT8VxqXbW/Npss6TzPjXI27gV1pZOqHL05x9aMI7zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Fri, 26 Sep 2025 04:51:23 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Fri, 26 Sep 2025
 04:51:23 +0000
Message-ID: <bb15bd5d-3dfd-4ba4-8261-46ed7412960e@nvidia.com>
Date: Thu, 25 Sep 2025 21:51:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/29] arm_mpam: Use long MBWU counters if supported
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
 <20250910204309.20751-27-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-27-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::48) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 952684d1-6d77-43e4-e484-08ddfcb857b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkxlWHlHczhyazZrQWs3TEU3WkVydExMZmJKY2F4UlBYajdkd2lkY2ZBOGZK?=
 =?utf-8?B?d0dJSDlmd2N4a2V5T2hEUmZhQ2tQVklubmZvczgzaVFhODJ4cmVmalpOS0tq?=
 =?utf-8?B?dzdPMmRONjhIRjFxWXZUVnh4NzVRTndMTEc4aTJkNmc1NGdqTGsxVzZTazc2?=
 =?utf-8?B?KytMTERWM1laUWYxWitERUk0Y21aMUYrV0FBVXlKRkhQaTRBY2x5QzAxK2Ry?=
 =?utf-8?B?UHgrUEQ4UEJTalU1VXJjeWx0aXlKTTBxWUxaZUlaMk5tWG9DbHFFZjE0S2hR?=
 =?utf-8?B?SVZyRzZ5ZVZPdWQ3UlorV1RnQ0VMMFpPekEyMEpKbjU3bCtDdElpdWdnRGdi?=
 =?utf-8?B?NEJlMXppNlFhY2s5NDJsR3kwdWdUUlRGL0tnTktPaFdvd3dNUkRVeVAzRzZF?=
 =?utf-8?B?MEJrYjd4T3Bia3BvcDBEMXUwQ01rUFJteWdyVHlQYlI3NFdyOEkvdXY5NDg2?=
 =?utf-8?B?VjMwMlR4QWRmejRqUDNCZjVkMks1dHhya25QT1ZXY1NsaUxxa1Fmcmc0M2NK?=
 =?utf-8?B?dTZWUmgwaXAvWEdPaklEdnAzWVIwQloraFZQWi8rdkN4dlA4STEyenZhN1J1?=
 =?utf-8?B?cXpYaXhCZUFFQzAxdzNrclJYckFrY3RYREtUQXhhRkwwTGFtNXlKNS9LNC9a?=
 =?utf-8?B?WUtsLyt3cStPZ1gwWmg0MXo5Y1BVb0NCN3BaWFJ5d1QxRTBjbDhRTUdkbm1n?=
 =?utf-8?B?RWtLaHhjRGtJSDNIOWYrdVN3d1dNa3hwRGNMUE9TK080dEFBaldNNGxnV2NR?=
 =?utf-8?B?NU5nYzkyOXBjckRnVVBKVHB3Z3V4Yzhib2dKSmI3WHIveU5SN0VTUEtRajA2?=
 =?utf-8?B?UmxEY0pxc1NTVERYanI3S3AvbElXMU1IZ1RGRy95S3lhYVFtaW5UWW5OSy9h?=
 =?utf-8?B?RVNmeitkazEvRy9DOGV0Tlo5emEzazE0am9KR3AweE8rc2tEWlhONy9Tbkwz?=
 =?utf-8?B?b0IzTUNkWEhWbjNXRkdMN2dsY1NOVGFWMmlBaTcxdzAxSTc5Y2szWFhtTzFy?=
 =?utf-8?B?bEgyaTJzUkU5bnVPYU5vQU10OWVJNlNHLy9icWRDVUEvSmhXMHJqeVpvRTM0?=
 =?utf-8?B?SzMyMTFJSHh2Rk1yU3JFdmlBTDNEVzFPRzhndlhPWkhDYVZKOUJPbVJtemNW?=
 =?utf-8?B?VXBPNjJIMEcxbTViVXN6MWhJU1A3N3VwOE9RK1JZQWh6L2NuVUpMTXFJejNz?=
 =?utf-8?B?RStySTAzK1MwbXcxMno5UnY0L2xkU2F5TlZENHQrMmcvN2prQlNRMGRzSFZO?=
 =?utf-8?B?eGh0bWlMVEFoUndSSnFjKzRMS3o0WmNwcDhEMFRWUkFHbXFqN1NxaFdJSU5q?=
 =?utf-8?B?b1BBTWxQcUpJLzV5SUJITjVlR21YTHVZTjVrSTh1M08yN1hPOHh1S2xKQW1m?=
 =?utf-8?B?YXo2VXZoTVBlYVVMcFhGL1pINVVtQW9vbkJnS0NpaFVWZERvNmphaGFEMnlS?=
 =?utf-8?B?WHBNK2JqSytzRVc1WWRPdk4vcGFRRVhVbGN5cjlxZ01oMTExN2J4YlVnTm51?=
 =?utf-8?B?eExRTjNsSlc0UzhKbEpCa2tqbDc4SDFPdU1IOXpLdGRmbGhzbXhNeG95bnU4?=
 =?utf-8?B?NEt0M2pNbUxqNlo5ZWFZLzd2bmEyaFVqOTh5K0lwWkI5aG54RzYrRWVGN1pO?=
 =?utf-8?B?OTNXMHVWL3hOUUVmcThPb1R6TXJVQThxTUZ0KzV4eE85cGVmS2NYdk1yditU?=
 =?utf-8?B?R1Q4VjVlRUVNc0dWczhLUXdxNXpHNUNoMm15VnZycVNsSjh5SFVEcFVSVWdX?=
 =?utf-8?B?YkhuRUcyRU1tcWVsSlBFdUU3VmdvZW5lUFJqc1dPOS80M2MrZFRJRzNpRGdL?=
 =?utf-8?B?cGhYWXZld2dNUVVxSTQxVk9YNFRwb21lSTdWdFo3TGtEUXl2NWZIYUYwQzhO?=
 =?utf-8?B?cWJ2cEY1czd4TzE3bk9ZS0pLSmM4cTNrN05WYTdMQ0NJM21icVg3QkZ2eTlS?=
 =?utf-8?Q?khQlKvVfefuxI9RHHP0NoCOAJnjAl51X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG1uOGw1ekQzVnNveTNTaFJ2TDVCbmtxdW50Z1g1UzZVOTdhMEhGK2JtMWsw?=
 =?utf-8?B?SlZKTGx2YlV0S2lrdlU0aGhRZEtZbUxjYUVaUmZobTVLbFptYkFObzVtSGM4?=
 =?utf-8?B?eVc0RlFuM3I2aVhTUWFjcmlVVVFkVzhLQW9IMVI5Q3NmNDZwRE1ZRjhZK0la?=
 =?utf-8?B?U2ZNVjljV3FnbHFiK2JvOHErdnVoeE02OUdJV2JYSVlydzI5NUZBWTV6SVNV?=
 =?utf-8?B?WnBKUGcwU1NkS3Jvdm5SZFphSlZwaFJpbnd5aXlrVDZMMnJtckpWbkNxazB5?=
 =?utf-8?B?VkduY0VrSjZxcWk3N0tyRlV1QzlINUpMRUxWNktzQXVWSjBIM0RyRXpkWkpU?=
 =?utf-8?B?WU0xRmRvMmlUUndVRjE0T3dJNDNLeGc0YXNyMjY5dmxWRktKMmJ0YWpuR3NP?=
 =?utf-8?B?R3ZBdkpEaGt2Q0VCNmpBUWZ3eVNBOFFGRzhQcGJHSUM5dTczbGZWYzYyNUN2?=
 =?utf-8?B?aWROaU9QMW9UUE5remNiaFZ4Z0JxSnZydUZsY3ZIcTJTLzB0clpkbmY0WVgw?=
 =?utf-8?B?OUlpNFVaanZzejdMK3dLNFYvNjRSaHd3SEp2cUloVVZ4SkhITzhuRUpRTEFX?=
 =?utf-8?B?K2hjVWg1bjZuVnNldXZZWG5TMG1HOVZmNzAwMnRpTzRxQ2FRM1BTV2lRTWRE?=
 =?utf-8?B?anVOcERseGpNWTc3bUNRNXV1SXZrY1B4anhHbUVzUmRkWEYrNmNDY1U1ak1C?=
 =?utf-8?B?b3FyRGxyQ09jWERzUXViUHZGQ1BsRlcvQnIzakNsTVNYVFpuQ2Mzd3pnNDky?=
 =?utf-8?B?cjZJUHNoMGlJY2pJM1RRVEcxZ0lhNThkWEpLcXNKakdZUFlKNXY3MFFkQ0VQ?=
 =?utf-8?B?TDVLejFtaFNSd25nMkpwSnJZRk5LK0dZZXAwd1grSmRBS2l4Z3A1c2Z2cGxa?=
 =?utf-8?B?T0tRd21YWUtnL2V1cnBjQjZoM1BvMVNrZ09IVjBVSkk0Q3A0VzIwK09QOGRu?=
 =?utf-8?B?ME8vbWZiTTEwb3R4VmMxNVJmZno4UkdsMUYxb294M0w5ZjZDaXBDQ1YzdXRq?=
 =?utf-8?B?a2xoemZVa3lSTkdRajVkSVdBVy81WHdrdzJFd0h1dHVlWFFZNWJrc2wvWXN3?=
 =?utf-8?B?WHQ3TzM1N24xOG5yYUFIeXltMmtQUHgreTdoazJrSXVjQXVIQk11SVRST1l0?=
 =?utf-8?B?ays3dUdET081M215bjNMc1RUYStDV0ZFdmd2bFdYVmIveEpyTmVGT0NvQk5a?=
 =?utf-8?B?NlA2MVBtQzdReFovTStKTTNZM2dDOVJlNHhTcVFqVVhuUHRNS3daVkUwWkpF?=
 =?utf-8?B?clhqODVTOGM5S3kraUU3bXBycVFjaEtUcTJEVThnZlIxTHJKREd5RnVtNE9L?=
 =?utf-8?B?b2FZTWhySzdRaWxHRXU4UmEwR1dZY0JOK3dHR1JDV3YrWUVQS0dOWTdleDN2?=
 =?utf-8?B?OVloTDlIZytaVGtDWGRjK2JYbzlER2dXK0V1RzdKK2dDUGxLTWluUFdoa1pV?=
 =?utf-8?B?eXh4VHNQNU9Pd3BtVE5PTWFGK0JnMHNVVi8rblV4bkVpS28xK3gvOGgrWHR5?=
 =?utf-8?B?dmI4T1BhMVo4R1RUamJNZFhQUDhsUHgyeTcwbUZIbjF4K1lSeU50VVJaM1R3?=
 =?utf-8?B?TGNrMmlLb0VneWt1NVdraURDODZpT253Y1BjK3c1Sk1YeFlQNS9GTDcxR3Fk?=
 =?utf-8?B?L3JvS0EwR0ZiWHp1TDlJaUpZMzRMc3FqNnJGRWVtVXFnRjhaYUJvV084RE9G?=
 =?utf-8?B?Ly9nZUV2ZjVRcG94NDhOWVdHODVucFpTL3JSc0V2cGluaUtwK0Z1bUJkNzBh?=
 =?utf-8?B?aVJveUN4UjVtL0VYckdpNGV1M1pVOEgyL0s0ZTUyMGFhK0VPSTRhbXdBVGhz?=
 =?utf-8?B?bnhHdzdZUjNmSThzMnN4Z3pWQzRnNW1ZU3FlYU05QUlQRHAvblZGaWtNSjNh?=
 =?utf-8?B?ODQ4VFhOdmhBUU5nS0hzYzk4K1R1a3VqY0NiQk1peVYxaFhQRzYzWTlZc2k2?=
 =?utf-8?B?TnAyMHAyUWMyT0hkOCtESEJ4cTJONXM5RHNUN0p5OTd2TExzRTBZTGFja0lh?=
 =?utf-8?B?UkdhVnQvNlpjUW5IYTViY0tPNXFsOEgxSm1ObjlnM09BdWVuekRLbGw1YmxZ?=
 =?utf-8?B?cWRxWWhzREJmNUlDSHdaTUlKMjZrVHlmcWNrOFkzQzVjb1dXRldaU3c1NDJu?=
 =?utf-8?Q?EUqfNPTu2JCw+ZWQo3QoK5EZX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952684d1-6d77-43e4-e484-08ddfcb857b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 04:51:23.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOrrhoJYxQvp5HHRjTx70q55dw5/93z/Sjy+0dAQ7NK/xw+iScki+KeyUwAqr/khCEwDFJvMYUbjhlBsnyDK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635


On 9/10/25 13:43, James Morse wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
>
> If the 44 bit (long) or 63 bit (LWD) counters are detected on probing
> the RIS, use long/LWD counter instead of the regular 31 bit mbwu
> counter.
>
> Only 32bit accesses to the MSC are required to be supported by the
> spec, but these registers are 64bits. The lower half may overflow
> into the higher half between two 32bit reads. To avoid this, use
> a helper that reads the top half multiple times to check for overflow.
>
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [morse: merged multiple patches from Rohit]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
> Changes since v1:
>   * Only clear OFLOW_STATUS_L on MBWU counters.
>
> Changes since RFC:
>   * Commit message wrangling.
>   * Refer to 31 bit counters as opposed to 32 bit (registers).
> ---
>   drivers/resctrl/mpam_devices.c | 91 ++++++++++++++++++++++++++++++----
>   1 file changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index bae9fa9441dc..3080a81f0845 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -927,6 +927,48 @@ struct mon_read {
>   	int				err;
>   };
>   
> +static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
> +{
> +	return (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props) ||
> +		mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
> +}
> +
> +static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
> +{
> +	int retry = 3;
> +	u32 mbwu_l_low;
> +	u64 mbwu_l_high1, mbwu_l_high2;
> +
> +	mpam_mon_sel_lock_held(msc);
> +
> +	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +	do {
> +		mbwu_l_high1 = mbwu_l_high2;
> +		mbwu_l_low = __mpam_read_reg(msc, MSMON_MBWU_L);
> +		mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +
> +		retry--;
> +	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
> +
> +	if (mbwu_l_high1 == mbwu_l_high2)
> +		return (mbwu_l_high1 << 32) | mbwu_l_low;
> +	return MSMON___NRDY_L;
> +}
> +
> +static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
> +{
> +	mpam_mon_sel_lock_held(msc);
> +
> +	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	__mpam_write_reg(msc, MSMON_MBWU_L, 0);
> +	__mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
> +}
> +
>   static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>   				   u32 *flt_val)
>   {
> @@ -989,6 +1031,9 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>   static void clean_msmon_ctl_val(u32 *cur_ctl)
>   {
>   	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
> +
> +	if (FIELD_GET(MSMON_CFG_x_CTL_TYPE, *cur_ctl) == MSMON_CFG_MBWU_CTL_TYPE_MBWU)
> +		*cur_ctl &= ~MSMON_CFG_MBWU_CTL_OFLOW_STATUS_L;
>   }
>   
>   static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> @@ -1011,7 +1056,11 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>   	case mpam_feat_msmon_mbwu:
>   		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> -		mpam_write_monsel_reg(msc, MBWU, 0);
> +		if (mpam_ris_has_mbwu_long_counter(m->ris))
> +			mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
> +		else
> +			mpam_write_monsel_reg(msc, MBWU, 0);
> +
>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>   
>   		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
> @@ -1026,8 +1075,13 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>   
>   static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
>   {
> -	/* TODO: scaling, and long counters */
> -	return GENMASK_ULL(30, 0);
> +	/* TODO: implement scaling counters */
> +	if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props))
> +		return GENMASK_ULL(62, 0);
> +	else if (mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props))
> +		return GENMASK_ULL(43, 0);
> +	else
> +		return GENMASK_ULL(30, 0);
>   }
>   
>   /* Call with MSC lock held */
> @@ -1069,10 +1123,24 @@ static void __ris_msmon_read(void *arg)
>   		now = FIELD_GET(MSMON___VALUE, now);
>   		break;
>   	case mpam_feat_msmon_mbwu:
> -		now = mpam_read_monsel_reg(msc, MBWU);
> -		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> -			nrdy = now & MSMON___NRDY;
> -		now = FIELD_GET(MSMON___VALUE, now);
> +		/*
> +		 * If long or lwd counters are supported, use them, else revert
> +		 * to the 31 bit counter.
> +		 */
> +		if (mpam_ris_has_mbwu_long_counter(ris)) {
> +			now = mpam_msc_read_mbwu_l(msc);
> +			if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> +				nrdy = now & MSMON___NRDY_L;
> +			if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, rprops))
> +				now = FIELD_GET(MSMON___LWD_VALUE, now);
> +			else
> +				now = FIELD_GET(MSMON___L_VALUE, now);
> +		} else {
> +			now = mpam_read_monsel_reg(msc, MBWU);
> +			if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> +				nrdy = now & MSMON___NRDY;
> +			now = FIELD_GET(MSMON___VALUE, now);
> +		}
>   
>   		if (nrdy)
>   			break;
> @@ -1360,8 +1428,13 @@ static int mpam_save_mbwu_state(void *arg)
>   		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>   
> -		val = mpam_read_monsel_reg(msc, MBWU);
> -		mpam_write_monsel_reg(msc, MBWU, 0);
> +		if (mpam_ris_has_mbwu_long_counter(ris)) {
> +			val = mpam_msc_read_mbwu_l(msc);
> +			mpam_msc_zero_mbwu_l(msc);
> +		} else {
> +			val = mpam_read_monsel_reg(msc, MBWU);
> +			mpam_write_monsel_reg(msc, MBWU, 0);
> +		}
>   
>   		cfg->mon = i;
>   		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);

