Return-Path: <linux-acpi+bounces-20063-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA5DD03599
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 174B43146401
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DD24C5F20;
	Thu,  8 Jan 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HfdycJ+y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HfdycJ+y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B04A8F6D;
	Thu,  8 Jan 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879884; cv=fail; b=Af2Ut0/Nb1iSae3LYKQq2KnqSjFDXPHVFskrf4aWBMYMc4cSgRJLAozyn4VDNgYj0gLNxDxZ4uJpU+1VWYpkQsdiI6HkTPJkPPVNTbx8KdFojyCVGf3oaE0PQAR19bRSzipyrVEPkzXPDrO6tPPu1aKgbHjrPixnd1KciT7jxO4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879884; c=relaxed/simple;
	bh=VXAZSRhAnvT7XuTkfad6EP0g0xVNQbqWNHLz4EJDx1Y=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HU6e+mAkFV1HH0KjEE2uoRKfYICGWFfcY0innXiwoOxnyBHKxKJcwy53KH6M55XIbKkKlgzo2Hsjl6UQHNnZNhc5RU5u0I9L4bpkJ08rx5nfASmd7kvHe7MRIEkFgrzOIWmN83Kj7TE9Nbz94S0NZaEKYTzgKIOBFuZ0Jc3Un8c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HfdycJ+y; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HfdycJ+y; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ubVvuIXDNhn/bREMGIazXwAELUZzcFkkDW4KonpI4Nz5PVvfvA5aIVCwfJA/gHe8jo6gdDYCFX/0AeUDYhBTNqVPFyTWU/fIUkBgjAYLbz5lw7TFhGvWaUUeG4j/je7jnDzKk+FWfjF+3ayFrDvf2QufORoH4CfrI6X5ZzyaUZtxLHbk/qW7BjcK07gcM4MMh5IshZembx7d5QMbMLXI9l5idZGSLdLUM6i16dX1invTHCpV8lfegA6HFOo9DKpZnlkEncanGlLvfr+ZIZt0hs0PiLZ2UWAkgyB0Fy2wQm/qFsf/y002xIY2/ODaJyZQ1a361+6ogc6TOS8gKxAWbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3xUtODcasnsutJo5ivzlCgSkM/kICcLvANEU52uCN4=;
 b=brDcWHX83YR/TMhNaXklWxDuN0hUwJ+sDosWRiMrHLosvOS1++QMQE+K2mS7XKgccsf79EhaErzwsczVbG1u0isTpxJwfkY9ETxO7TAPmKN0hFhn2NEuGK5/vqVuCcn+jDz529M2s9jYbumzL4p1/xr5D/IVvLAInb65OPIIXWTq5Yiq9PwDSLbC+8kjalsqOu4v04DCgsuDYXA920BkSCISBuAcv3aWXnVGZsSaA08jNkuwyENZs4GEHEdGXIpWL6pqu1/zGkP1j7QiQC30dAYLJZuOyZNAm3iJSsOFoAsF2nfE8idZsryz1367BLzi4k13KRYYjl9AQR/jGbH+cQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3xUtODcasnsutJo5ivzlCgSkM/kICcLvANEU52uCN4=;
 b=HfdycJ+yOYOebs3xX7LVPTU0MTz+qPlSHcf6O4VvWmqQiDP/wMQBXpMm4Cus+3jW5HT2dy1NRlHA6talobxyTMUtjLntduaPmSvEWuNkBFbHa067nVIuFdk74dJyv0p9cwt5gV7oicGdSqp6xIQaeaSxnt+H8WUGSEvIEWKOlbs=
Received: from DUZPR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::15) by PAXPR08MB7417.eurprd08.prod.outlook.com
 (2603:10a6:102:2bc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 13:44:21 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::c8) by DUZPR01CA0003.outlook.office365.com
 (2603:10a6:10:3c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 13:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 8 Jan 2026 13:44:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd+MyU/IlqZUJ9evg9HyBrbd2dNjJm6rUeN57cHVuebmIRxJb8SOjfvbx1IBfgqnO3dFys+a3dxCXXRKhNW2p/GVYy5nM+xDNiHT2qR3Kp19yVXvGc/EWFbjTD2hJ4Gxsb1NQVSlKGZm/wFSft40cNb+5BkYBRwsPQE0drf3SY8q7U4BCNLL74Ce0h8RIAasyaNEi4NNX4hi7hT+dNa0VuL3HFptx9Nf7h/KN8OczHW5cSpr1vSX8RZnFNLrNp5mfmYNJhD3b3UJASQBeVeB3QQR8awG7UODhurUhkoEmvQsb3MGdyHuofsnpbdGHoVJTHoc6oA8PIiQxxfU7S3CUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3xUtODcasnsutJo5ivzlCgSkM/kICcLvANEU52uCN4=;
 b=hQRiNX8QSM+NPwclWa9cWDyxfahFgdeDfwP/NsHAp7Pszzl3oGRQfpMm0Qm+IOEpO68My7lyTYq7UjMwqWj4D4aPCxT5kmsbbEHil6EbQpHMHqltkKfz/b6XAI4bjr9DlwCnYbCWNwv3XTezFdnlfxZeh/sjv1wPmbk2sm/YT7b7nJIaU2t53ffGPzgskBByVE6D+9MVHad/lyuOhlaTItX2PJVORtxyiieT+iQElypX9zkaHZcNkfJ0hlZ5iCQf95LsGXdAcyQtVGgRn6Zmr3Ke+OlCX8ovk9UoU390JI+5pkbmhfmqhyyscT/PFD3dq1EvZTxg4cKSannIQ9aaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3xUtODcasnsutJo5ivzlCgSkM/kICcLvANEU52uCN4=;
 b=HfdycJ+yOYOebs3xX7LVPTU0MTz+qPlSHcf6O4VvWmqQiDP/wMQBXpMm4Cus+3jW5HT2dy1NRlHA6talobxyTMUtjLntduaPmSvEWuNkBFbHa067nVIuFdk74dJyv0p9cwt5gV7oicGdSqp6xIQaeaSxnt+H8WUGSEvIEWKOlbs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by VI0PR08MB10711.eurprd08.prod.outlook.com (2603:10a6:800:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:43:19 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:43:18 +0000
Message-ID: <38b4cd89-dcd8-4384-991c-8c364a13e87d@arm.com>
Date: Thu, 8 Jan 2026 14:43:16 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v5 02/11] ACPI: CPPC: Clean up cppc_perf_caps and
 cppc_perf_ctrls structs
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, zhenglifeng1@huawei.com, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-3-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251223121307.711773-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0473.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::6) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|VI0PR08MB10711:EE_|DB1PEPF000509FC:EE_|PAXPR08MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e66940a-dce7-4ddb-c1e0-08de4ebc0745
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UnNwa0ZDWFBQSy9LeGFVNVZCck1STytsWENZTElnRXdoVGhxOU4zaG1hMTg5?=
 =?utf-8?B?aHI4WThQVzAyeWRKN2V6MkgwZ1RHT1h0S0llZkUwa1ZReFptN0VnNlBWSE92?=
 =?utf-8?B?clliU0czcThBM0d0dGdIYjZhSTV5WmZHVmdGQUpaaERsU0hFQ0pmUnhNMUd6?=
 =?utf-8?B?MEFkTnBpZzJvVVAxOFZsUi9zcUc0cmE4RUFZSldMRExISHYwM1NmdXROUXhl?=
 =?utf-8?B?MGE5V3ZVc1V1K1F5eWVxK0tLc0s5WFZyWEhTNVo5R3dUbFpweEZWYVdoVHZR?=
 =?utf-8?B?a1ZaUWpNZEZLMU85c29DVW92WFhGTkNJMHY3YnJaYWlmNjJRUEI4bFZqRndo?=
 =?utf-8?B?ZTVncktLZmhNU0c1eEtXTlo2elpEa3JrS0NjMDVxUy9Wcm4wR0ducGZrMnBW?=
 =?utf-8?B?SFJEcjF3SWFMa294dU5MWG1GcHI1VUo5VlZaclYzS1phT0M5MWNOQnNIRkJY?=
 =?utf-8?B?ZXQ3WXY2OHJ5NFBwRGZvYUdIalU4YTRJUHg3OWlNUm4rRExYeTBhTUxGVlpD?=
 =?utf-8?B?RE1raFJRUkJrbCtSeHdDbkVFeDhEQ0xIMU8rby9wU0p5eG5UUzBkVTZQOTlu?=
 =?utf-8?B?dEFDREQ5SFFsazNMR3pleWRZekxxclo3QTdIcHYzMUZubFBzUG1tWUhRWkU1?=
 =?utf-8?B?ZitEekJ1cXRJVEQ5SEdNODJQelFlNjY5a2w3dGJWQzZ4bjZpSGZTd3MyU2lS?=
 =?utf-8?B?eTlMSjVlbXliZW9UazdXV1NudG9DTm02Y29ycEd2TVFQaXVkMitZYlAwVjI5?=
 =?utf-8?B?NXNFbFp2RUl3UVZFWjZlU2ZxN2FheWEwNWxYTU5iM0t5UzlSZ2hFZ3BzUmRI?=
 =?utf-8?B?OWRSbFhVTG9IU2hBOUJWNloyWWUxMFlyVnpQSnhQS0dUWHR6RlNDbHZwT05a?=
 =?utf-8?B?a1pySlhnb040cnlGWGQ1TzFBR3VIUU1qWEZQenQwQ0txNWJKN0pER3NsMGly?=
 =?utf-8?B?Slh3ZVNQa2hGSW5WYUsxcUdTVDQrS0k4K2NQbHZzcjVMNzF2Kzg3aVJTY3hH?=
 =?utf-8?B?OExKWlg4UFZQaU5tbTl6c2tSbHl4SGJZbW1WblM4a2FFOEk2SEw0SGhaS2Nt?=
 =?utf-8?B?QkpOSGF2K1VvSEpiL2Zyc0JuWEpRUmovbVkyVUthbS90Sjl2KzFIMzFYdG51?=
 =?utf-8?B?c0p4SnJzdDU0Qnc2d0NZV1RmL0lrMFVGWHp1S0ZSVDlmcytNTW94T2pmeisy?=
 =?utf-8?B?UlUvTm4wUkV1Y1RhTmJzN3o5Z1FmRlRIT0tZTDBMWHFYSCtxWGJoRVpOWnhQ?=
 =?utf-8?B?YldacEI2Vjg3WUhRbW9KZFl0bkNIVWVaTVpuYXNhcWVnc1p5R1JNb05LWWhX?=
 =?utf-8?B?U1dCQ2kxd1NOT1I5UDF4L2VIWGUzYXh3K0dTQXdwZ0RKME9oZENNWm0rSlV1?=
 =?utf-8?B?R0s4S1Z3c0p3Vy8rMTQ3Z1N5YTlOV0ExOFNIbmhBN0lrb2lCOEk0NU9UNVBi?=
 =?utf-8?B?QUJDTHNtVVBxQTU0M0JxZ0VxM2hVSTdCL21NelFqNlVpajlWZGtkcFZxUlR4?=
 =?utf-8?B?Uk55MENrblVNMlBOWGNRcGEzYXRQNmgza2w5dDhwc3ZiVTUrci9DS0pWWVR3?=
 =?utf-8?B?Zm1vbU80eHdFeEYrMVhtZVI0aFg0NHBxbUJzSWJ3ZnFOdjAzdGs5eERJbm9s?=
 =?utf-8?B?V3lYWm1VRW5tb0dhUUIyVllYVVF5VEFiSUtJUEpzdjdEQkRkREFrMlpIbSsr?=
 =?utf-8?B?MlZpd2V5ejRDR0srdHpKR3RhRis0KzBSTWI0MU1MVjNncHd5RzdBbkhZU045?=
 =?utf-8?B?UUtjYW8yakZkV3V1RlhkVmR6RHkwTXRoZ2k4Q0RFdDVKTU9Gc2JMbU1CNW1E?=
 =?utf-8?B?NU5Hc3lZTnhXdkdkeDA0MHJMR1F2ZkJVYVRVd25adXBUL1hoRUU0Z3NBUEFi?=
 =?utf-8?B?WHJTKzlKKy84d3J3UjNjNXRvYTVwTGhVbm5KRWNOZVZ0WHZvY1FrZyt3emw2?=
 =?utf-8?B?amdqRnZwU2N3SkJlZm51bWFaWW42RUJjRlpaNDMrWmtMcVdSMkNrWFo5cmZZ?=
 =?utf-8?B?MkRPWFd2dnA0cmpWajRteG5Pb0RzS2RSaTU5ZFNKdC9UWDRKYnFDekZPUEha?=
 =?utf-8?Q?6vfpiJ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10711
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7691dfcb-ff3e-45d7-a732-08de4ebbe174
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|7416014|35042699022|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXZsb00zUW85alJ1UmJlQlU5aVJqdXFuampVZkVvQVJZTzhTUzNnSjV6RnNv?=
 =?utf-8?B?eXBIbXVzc1JJS1E0SG1ROU14Tm1LRHFqUGp3Q2M1cVJOM3dXTUV5ZlZVcmZy?=
 =?utf-8?B?T0RIV2hzNlBTcDBRVWJFZ1BGcjlUVkp2T3MyR2R1M1ZoZlV2R3lNTUJydGRZ?=
 =?utf-8?B?N2lyelpuaDBWZ0JxcExIWXA0dnpjai93K1IyWVV0ZGkxNWMxZEZyYTdUQmRO?=
 =?utf-8?B?WG5TQ3JrYTVlMFJYNksyZzZuUWNCNUdxdGh3WFJsdjdRNjdJa2hONVNKVkxx?=
 =?utf-8?B?NGVIL0t5UzJoemZSTG1CWFZKWnZ2S0U5eXhsQzAvanRoWVpsb0hwVjI1eWRZ?=
 =?utf-8?B?ZHU4ZFo4MEdldWNTQkRNbEYxWHVkY1VUMTNDWmViWXozRStkTE9Bc0xuYmZj?=
 =?utf-8?B?UFRJMkVJVHNnUVpUL1lNdmx2YlpoS01ZL05FZHZBZVo4cTNqTURrdnAxbkxr?=
 =?utf-8?B?QTUvYUsyTmQwYU9QYU1BRDg5UThMcGRPR1pIb1pEeUdUZVpVcFQ4MVdzQWR1?=
 =?utf-8?B?VExzd1RKbnNLa0Z0U1JvVG9KTUNtc0RLQm9Va2cwUUdpa2J6c3ppOHFPUWJT?=
 =?utf-8?B?d1VkRld6ZlZqbmZxcWFvK0Vad1RYdXo4aEUwb2tiYnBQMzRTS09CYzgzUE9t?=
 =?utf-8?B?RzFQcGMwZ003ZSt4eUFvd3hZUEliVjJyL0x3TnJLZjNodHdQNXhLQmJtVmhW?=
 =?utf-8?B?a2xTelVIOGE5elpnNDVjNXFwbUN0Z1Y4dmpxZ3RZejdOaVVEbDJ4VUtDazJP?=
 =?utf-8?B?UnByVVJwQmZsNm9vYksxUmdLdVBIV0FjdFA3L254RWt3b2tXWnJsMzFFSE4x?=
 =?utf-8?B?VGdsTUpJU24xVjA4S0lPWDBUY3ArRW5ZdllEVXUxOThyNVQvUXZLWnZ4QitV?=
 =?utf-8?B?bjNmMVl6OHVWTFhrSU1leVJwbzhXOW5KVEg5OEhDSXlVdHNFMkNTcHFwY1g1?=
 =?utf-8?B?bVZyRmRMblJsaVpjNW1MUXM1ZDF6aTIzQjUxL3pIOE9UQkdSWG9ZeElDTW5X?=
 =?utf-8?B?bHpUbStxMzYwSmRIY0JQMXNjcm80S1dzZmxWTGhxMXNiem1jdzNndlpzZmkv?=
 =?utf-8?B?MFRnZHRnelZLMzJhVjU1a1NiMGlTb25uT3JZWEJpSEFIeGZpQ054WHRtMGlk?=
 =?utf-8?B?bEFWNXdzMjNyQ0I5Y2NvcU9kTzFzNmFNNjN0SGpoL2d2aXhxNTNoNEYxeUpR?=
 =?utf-8?B?VXBkVCtmb2RTazNYOWh6cEF3N0l2UkE5MkE3YzFqTXBDYlZJREs1RFM1ZUdF?=
 =?utf-8?B?WEtwdS9tY29OU25MQzBhYWQ3RW5MWGQwQkNlTXhJN2lJYWtaSHhhR0F0a1I4?=
 =?utf-8?B?RW1iU0NNSUFtbjlDZ1lIRFZzSGkxem9kWDd5a2dyMWlHUStmR0Z1VTVBaTRz?=
 =?utf-8?B?cnBhRGdONDAwQS9VU09Ra3JDYUhtT0hWaERJMGFxNzRRY1pMUXBmbk9PdGpF?=
 =?utf-8?B?QkoveGo3RGxJV21DUWJUMk9oTWRvTmZNakowdlFCS1FpS0kxeHkxcE1HVjYy?=
 =?utf-8?B?eVI3NHo2TG1rUFIwMjJudXhZdDNjNEdZNEZPaVU0b1cxUkJ2OU9STDBQTyt6?=
 =?utf-8?B?Z0dmR1hVQzYzNEp5OXVtMkMxYmhzc2ZJc0VIUDlUNXJpL2lZVEhmdW9MQWlV?=
 =?utf-8?B?SXJyMkg4cCtGMkVGNEQ1Z3VZSDl5dkxGd3ZTVTUxRytLaDI2QW1YSVRtSmpo?=
 =?utf-8?B?dStFYUZHVXQ4b215QlUxRTdTSFYyaUtuRWdoV3JjUEZkSzVjUU8xZmZQcmQz?=
 =?utf-8?B?OERKMDc3UnRmdFgxSm91U1RXallKa2pFS1FVTHBleUdqTjNtSjhPcnJoTGFS?=
 =?utf-8?B?bDZBN1FpMXZIVU5CTXBwalUvRXo0anpTamg5eUxaQnd6Q1JrYTlwWllUYXpk?=
 =?utf-8?B?MXZneGhaZUZvTTZFQmxGVXZMRmI4VVh2NTFFd1ZQT2JJS3RwZmVnNEhDWHlW?=
 =?utf-8?B?Q2tLbjltYlFKN2V5Tk5NQlhHZFRGOFlnM2lLVTJ3aHVwTTViYXZzcnpQMVdN?=
 =?utf-8?B?RlZJNnVKY25TVnhlN3RKdVl4VlJlWEhxUWVhb05PaVBJam84Z2htOGwvdVZ5?=
 =?utf-8?B?bmVYMFVjR1JRenkxaURRNEE5clg4enBoYllaMHo5bk12VG8xOXBYU3RCS1pO?=
 =?utf-8?Q?XUHbNfkv8GxHPxrBh2ZATVJGz?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(7416014)(35042699022)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:44:21.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e66940a-dce7-4ddb-c1e0-08de4ebc0745
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7417


On 12/23/25 13:12, Sumit Gupta wrote:
> - Remove redundant energy_perf field from 'struct cppc_perf_caps' as
>    the same is available in 'struct cppc_perf_ctrls' which is used.
> - Move the 'auto_sel' field from 'struct cppc_perf_caps' to
>    'struct cppc_perf_ctrls' as it represents a control register.

I think your SoB is missing, otherwise:

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

> ---
>   include/acpi/cppc_acpi.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 13fa81504844..a090b010f5f1 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -119,8 +119,6 @@ struct cppc_perf_caps {
>   	u32 lowest_nonlinear_perf;
>   	u32 lowest_freq;
>   	u32 nominal_freq;
> -	u32 energy_perf;
> -	bool auto_sel;
>   };
>   
>   struct cppc_perf_ctrls {
> @@ -128,6 +126,7 @@ struct cppc_perf_ctrls {
>   	u32 min_perf;
>   	u32 desired_perf;
>   	u32 energy_perf;
> +	bool auto_sel;
>   };
>   
>   struct cppc_perf_fb_ctrs {

