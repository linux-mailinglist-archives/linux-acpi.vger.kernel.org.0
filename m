Return-Path: <linux-acpi+bounces-20784-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFTlFgtrfGn+MQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20784-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 09:25:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF27AB854A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 09:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72C3230293ED
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46A352946;
	Fri, 30 Jan 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lLu/gWtu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lLu/gWtu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AE2FD7B1;
	Fri, 30 Jan 2026 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761508; cv=fail; b=siPGM1LgY9r4N76jRdcu2Vf15f1HhTYgakER24YC56TNwpQpcLpkbHOwsIE1vJWASfuEmWXkwcJG4SXyWoUiCinisXPkVzJEAFE2FJ0tGLzFD2+/Iikzzkr/qIBt74vsaxgicvCTpT6Y9s0BLPaPqNZJ3xVmNNYc3ncfgvKpQcc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761508; c=relaxed/simple;
	bh=uL68O9Mk+AYMyqaOXe9BHjoHhJOiaI9qS75EOcj1K9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MUd0VuQM+QXYJ5xR2PqWay2KO/eo+J2iijV41IlOetDW0vA6HlsSUxrR7ITMIGrZehdBzGNMk21+9lLppPyOYAjRbrU1nkCIeqw2rJYQofab7jwCSuwz1LLwf9Vtp6qxn2PsBzKR7Y2+jrRlW2N0da21iRn41k7RxSgCiIXMlc8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lLu/gWtu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lLu/gWtu; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xQPSu89Vzz/rgu/CyF2svF7UCi/6/SiUNJ6x4rmrmG6cGdgJGeX3//B8J1eftDfc5fCyqIbnxjCylueuyki50vMByC/tXMtCRjT8PqW/zs4SuWJ7WPeto+LmzGrVl0FiHemA3x3lDGkxf9z05j9W+CYbRzPbyluNqCd7x5vPk41DDspNJS24j+CXOo47JJikvfqlE/EwEF86gXta7A7jav5YERxbTTQ8FiY5S/Qgut49XiMLiYIbC6gmYbKL4JNmkcJ9qVZ1jDMrH7mdP/sxEI4r2fvw4k0rWGcZ/9aX6TGVWhTxXR2qCQjxZgKAWxVkmRKzqO2pMg+gY4Ysh8QUyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXVBz0DGpyhavVFC9bBHLvU2XJa7apBKt8QUeEcVP78=;
 b=UW/Jgki7nqGgd9sZcPiKMYGVLHpRmBv7H7oGn1xcWRmpd+sEp4plCsMP/PG7fg7VflM9Z268l/WGq5C45Ncmc60xkHr1t6pB8Dmgyr2vnT470xbylYU/mvR4dUWxnhyV4Gc7x3kDR0bA74tu5KAWpJ3Iw4iJVT9AsH6TC/dYEmPzmjl1YPF3ZmptiO/AQi6F4+Q6/4Ay6Z5ILXIOYK0iF+oIxwmc/eic1iJwxXigo9LHYX+hjnGWjqAiC/dET9ayyKXPefFh03m/28hDdLKmidhdlxlveGaUWWlpU0ZJz2btrQzvDOaPPJydb5ayhcsPq9Qd5GCvbAGHjbG46AX5Ew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXVBz0DGpyhavVFC9bBHLvU2XJa7apBKt8QUeEcVP78=;
 b=lLu/gWtugE1Sr54SJaZjBoUBTZ9dfmOwo84+VZ3W/ZZU8KcBXOFufkcaBsljffe/cSKNm9t5bxkOLp4QqDxR3tQKatDTYDqzKLvKXQF0u/CumVCOO8YFkxm1qcQ7EGM/rKeW8bigCpFcGciDhSpJZXzZBs4K1QjSsrwuwP6RZWI=
Received: from DU7PR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::20) by AS8PR08MB8635.eurprd08.prod.outlook.com
 (2603:10a6:20b:563::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:24:55 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::6c) by DU7PR01CA0038.outlook.office365.com
 (2603:10a6:10:50e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 08:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 30 Jan 2026 08:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HucStdDuBe9o0YOj1jHYkexS8fYAv4y6AB5ODC8pNx7LyUcamLMBcnoUeoSs0RL3V+YSObCzWuGqUg338H0C8AXeNlLk/7y7GJMeF4qF7rOZEIJlu5A+coSvcBm7lC7VjJFBuTL4Tfv+n2iHdShoz8e7c0n80oQC7k24b05xurZPHRXir5nyRrTMbhR3H4ga9tTSe+vgcmzA2bMFjwrtOBomzqCfk/+mBZ5R8ZmirY8kCKualI4QZRaitmqyF22I5FKWjrXCASKoPj67W42Nem1x+vaUWFGNF11Z4m1LXWwgcWdCQa1WCTmJYbkJ+OKMhizMFbObKgcHcYqntB+V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXVBz0DGpyhavVFC9bBHLvU2XJa7apBKt8QUeEcVP78=;
 b=y8KW1BV6pbusDqMwk/BWFfnjDW+NSwOGaAvNEYVQtvYdPZoXzDg0eG8xVL8VzI6F8HeGjgBcdGjnk+ahkMR3OglulE267gC8CPxNvEgLHBNyyFN4HBu0EltJ+Qpip1csbpMB3OgPor/0Cw4zSmEl5TeYan63aRDHe0D5lqg5jEdSES9qBKGcONzxorWEqlyCgzgcXScsOIzJePkiB8ECA+8O7hJj37CshtXs5TtPva2dGUeoz99Rj7eXmR6sFvswQMjtfFsZ5kaRtR4u913sXqSlxq4atyAl50jRMi3gcAkVgK/zeiWc7iNeCiBMl7MI8fBRjZxt7+5xLw4XL50pvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXVBz0DGpyhavVFC9bBHLvU2XJa7apBKt8QUeEcVP78=;
 b=lLu/gWtugE1Sr54SJaZjBoUBTZ9dfmOwo84+VZ3W/ZZU8KcBXOFufkcaBsljffe/cSKNm9t5bxkOLp4QqDxR3tQKatDTYDqzKLvKXQF0u/CumVCOO8YFkxm1qcQ7EGM/rKeW8bigCpFcGciDhSpJZXzZBs4K1QjSsrwuwP6RZWI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAXPR08MB7333.eurprd08.prod.outlook.com (2603:10a6:102:230::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 08:23:51 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 08:23:50 +0000
Message-ID: <6652394f-7a44-44e9-8220-4dd45624729c@arm.com>
Date: Fri, 30 Jan 2026 09:23:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Enhanced autonomous selection and improvements
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
References: <20260129104817.3752340-1-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20260129104817.3752340-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0055.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::30) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAXPR08MB7333:EE_|DU6PEPF0000B61D:EE_|AS8PR08MB8635:EE_
X-MS-Office365-Filtering-Correlation-Id: c8079bfb-6ec3-40ad-2561-08de5fd90c76
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SEdTbk1tVUgzVXZFakc4Y1drZVZtT3VnMGo1R3R4S0NuWFdKRmd6aGNRNTM5?=
 =?utf-8?B?SWowL3JHZVFoMUhVQW5qT1VGMEpVUGM2NE1pbGZGN01kOHh3TWlPSGs4R2pL?=
 =?utf-8?B?WXRySzNRVTByQ0dWclgzT250WGY0cXZ3SVJuSHU1SFhleC9xZjlJaUdNTkdH?=
 =?utf-8?B?ZTVzV1pOVzQyNUlJL05RQVBjSVMraE9UR1FsRXlSUHBrbDIxYmxab3NoK3hx?=
 =?utf-8?B?NWYwci83cU4yTlZuVk0xRTVrdzdRQmE2K2w4U01aL01mcUkxVFZwaTJPZGw4?=
 =?utf-8?B?UTBZQ0U1RjVOb0FPQmE0ZXR1TU9tQXF6cHUrdzluVTdIKytsRjI5cVJvTjZV?=
 =?utf-8?B?OHlzTUZiMXFLRlRZeWNjZ0pMRGEzM3E4YWl1bDFWT2tBL2xHWXNOc2NXbGE3?=
 =?utf-8?B?eEdqb0x0NDd2U29YdjdmMDI4aWdZRzZKcml0QTVITmdaeDJjVjljR2ZqNUxj?=
 =?utf-8?B?bmtiZkp4TmlsWDhYaWVtN1A2aEY0UVQvMEJkcE9WaCtGVHNxd0FZcmFFdUhW?=
 =?utf-8?B?eHk3c3ZmY3FjeUpHODlHb2NCdDF0ZzZQUExnMFdmQjVPejFXTEgvc1pxU0NO?=
 =?utf-8?B?dk13VkNoa0RnUzVzbXRLK1JWOUFLUWtzN2xMeityUGROcHRLSFhZcVY3eVN5?=
 =?utf-8?B?KzlZb1NQR1RUZlg2RTRGUSsra0VEZ3RIYWFXRmxSbnQxaWdYMHdlbXl3UUc5?=
 =?utf-8?B?T3RCRDhuc0Y3ZEJja3d0UXBua0ZhZnRIdmlaVFllbzd2Mk03ekRhd2xpeVRS?=
 =?utf-8?B?dGtvd0J0R3p5dktpZG1MRDh5NFY2VU5IQVVVYUVaUS9lU2VpOVR0TlQ2em1M?=
 =?utf-8?B?V3NKaHNyb2hWN2JmYnhpTXBsQmRLNFZaSUhpajZyWU5ENCtTTVp5OEN0MnZR?=
 =?utf-8?B?UW5hd09JSC9PLzBKQnpsNUJ5WlJyeXRvUlpld3pSbkJyMmRsZUg2L2hiZ3hE?=
 =?utf-8?B?TFpIS1poYUJEN2ZaY1hWbXZPb2kyK2NNODM5UjJHUkw0dE56U2pGZFZWVkJJ?=
 =?utf-8?B?UWF1bVF3UnlHOThFbFgxbWtTa2VpZUZxRk1PK25tNW5YcnhURlRwVk16OUU3?=
 =?utf-8?B?YmhObUduSHU0UUp2RWdhWFdjMXBFMy9zZVlzWk9qRCtaS0YyQThSZlErT1FK?=
 =?utf-8?B?LzBwYU55TUQranJHME03NWpqcEswRmM1dUVZdEdJZ0FmNGtBMWVDLzIzam9l?=
 =?utf-8?B?djVrZ2xxVzNaL3M1U2JTeTlPTXAvWGczTWkwc3VFUXlIU055bFJXYjdmamRo?=
 =?utf-8?B?Vkwzd2tIbGNJRHlUd3dPZzZIYmRpM1A4V3l3ZmNvd2prSVQ1czhXVlQydk02?=
 =?utf-8?B?ZGhJYWUrL3JCbWEvV0hzd0ZEcWw4QlptOVVtcklYRGdTb1hWSVErQ0hEYnFa?=
 =?utf-8?B?Q2h3SGVSUG9salorRDVGNFBkeVdxMlplME5zMjVCUWFneHlua01rdzRxZVlV?=
 =?utf-8?B?U0tGRU5GanpGWGsrLzlmWUpGVWY1TnFyQ2RaWWRFcmdZU20rdDl4OHVHSWww?=
 =?utf-8?B?T1NnVVlXbXl6RlRVMmdZaERPK012eEpCTWNjRzcrR1N2bGVGbEIxS3Y0dHI4?=
 =?utf-8?B?VmpXZzhJNUJhY1NhWC9CWUxJaHg2dlJoU2JLaitqWitiMVlUTWJjRmhTTEZO?=
 =?utf-8?B?UGRZdlhPRFRLbUFJbGVrWWFxeDExSk5tbEhDdXcvUEZ4d254RVZYNVNkWWs3?=
 =?utf-8?B?NnFoRkpyT1B6NnpPa1JHT01tNG1VTXZyc05tYnByeFp2Sjk1UWpzenFCQlRI?=
 =?utf-8?B?RU5xMmJSdGkzS0tJeEFuTmVkdm1xSjhseVNrNlN0YUJFa09ZRUZXb3JNWTBu?=
 =?utf-8?B?SjNiN0tmNkM4Q05rT2xrd0ZCdlg3VjBTVjA1UUp0MGpQZDhOZnVNbFZHS2hn?=
 =?utf-8?B?dUlCckNzZE5PVVFVY2tVNm1lOGxLa2pjamNMS3dlVHprcFhpRXR5VTNMNSsr?=
 =?utf-8?B?TkpIZExrTFdmMkM5RldGbzNOWkw0NzFRR3F6RG5hN0JUd3U1ZTh6ZSswOGxL?=
 =?utf-8?B?ZHg1a1dKOHFXRHIycFBnc3FtaDF4ckY2RTRxV1p6bVRvbVRMdGdJdHNjYllP?=
 =?utf-8?B?NFllSjI5K0QvREo3QzdMVVdkM0RjUjlyMTkxekRGT3pGdEJHNXJ5L3BHV1k5?=
 =?utf-8?B?Q2VvMVIwY3lJbnV1YWhBc1NKUnU3Y1NmaFJkV3JWZXN4RnZwV2dRd3diMnhN?=
 =?utf-8?Q?IlAliI1YSmv6inziH0uQBbg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7333
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ce14a773-3491-4480-4928-08de5fd8e546
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|36860700013|14060799003|7416014|376014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXRYaWZCUzFDdWcyaGxpY25UcUZCUE1QOENHODJPOGNjd3ZMYzdjanMwSDJ1?=
 =?utf-8?B?SDFBaFV2MzVuMjV3TzBSTUlpL2ZYK3pXVHRxKzc5dkVuVGtPeGRPOE5tMW9B?=
 =?utf-8?B?Sjc3MEVzYkJHQjNrV0RxZmxTbStDMHJkaTM0ZVdsK1BUWTZ4SzdNM1dLdzkz?=
 =?utf-8?B?bFJtdEQ1dkF1bWZUeEhuNkx3QWhXSTcwRDBZVTVNWGhsaXR1OUFvdTlLaUNR?=
 =?utf-8?B?VnJ1M01wUlh1V2xJd1JDOFF2aktZb01kR0ZaNmZXb2JsbU9CVTdYcUxzSFpi?=
 =?utf-8?B?QkRrb09iWUFPZHZMTnFjVHJvRFFOaU5CTTBaNXNHNklQKzBhRHU5RkJnc3Vy?=
 =?utf-8?B?NExTcnBUTXVjWVJPUSsxZGtmakN3TEVES2x5U0tIeFYxSHBXdENvLy90eHAw?=
 =?utf-8?B?cXN4WmpZa25qVlpiTGpXd09OVnVEcFZWUnZGeFJENFpOOU1heHZUejkvRXUw?=
 =?utf-8?B?U2s0SEx3ZWg0UkhMTUJocHZRU1ZQc05yS0lpc3hYVHlaOHhCTC80bTRSRXc0?=
 =?utf-8?B?ZU5uUXNsczhVekdxOEduQ1F0aC9VSmZvd0hUWHQ3WUxHYUxlWkF4cFRCdjZp?=
 =?utf-8?B?bnBsbGdWOUt1dWZGeDgyOXExak4rSWtFVzl3QkhCZEV5QllqQ2NJTDhwZEYr?=
 =?utf-8?B?d3NDTUp2K2lPRXlLaWJueXphNDdOTlpGUzdKZFN4MjFqUGxlVDBUak5vam5M?=
 =?utf-8?B?YUpGOHVNWDhMNzQ4NGw4bjBhTlJqWFFFMWdXRW9iMGs4d2MxcTB2SHR2VGRl?=
 =?utf-8?B?bkZ4N0FOY0xqdzlpaW5xazFrR294WDVwVjNhVEI1MGlQbGh0TkRRYUNCT0VL?=
 =?utf-8?B?ZlVCNWJaejA0Wm5idll3VzBTcUJaQlA1UXBza3RLTTNSRmh3N2hlbmhlaGtY?=
 =?utf-8?B?bFh6K0Vxa3Q2MHVMQWc2d0s2NUtXUmxOcnZIVkFTZWp4MlpjYWZTKzBLdkVi?=
 =?utf-8?B?cGF4ZVNnWGhvQ3RUTUtxWEtZODlqbTJsaHAyZlBYVFBDRDNDK1VwM1p0c25K?=
 =?utf-8?B?L3dUWGN3d1NRM1d2bWY2TlJ1dGJzcEgrS3dyZ3FCWVZaYUhEY0t3N2s5c2Y1?=
 =?utf-8?B?Q21VY090SHdvYzlCOWc2eXlyZVdkdE9zZEYzdG1HT3JlQlF6V3U4M3ZIbTVN?=
 =?utf-8?B?MjdENEJVSjN0OVdOS3Blb0VUU3pTWFVyVDJjRHJTZDlHS2dCelYvMnlCd2ZH?=
 =?utf-8?B?RlF4eUVqZUxOYkVRZXlEQW51Ujg2L0FFMWRESXVnaG5id0p5aHZ4Y0ZaenhR?=
 =?utf-8?B?U21Ic3VxYmZ2eE4rdndPSmlrcFNIaWpXT0k4WEFMc2EyaXc5SFE4aU9mWTZG?=
 =?utf-8?B?aEVaS21xa1VkN2JaOTNzajRLcmk5VnM1aE9NSk9IalRxRVFCSUsvNmIyQkZM?=
 =?utf-8?B?Q3lQdDgxMnRYM1NYN1FVWStOTGpCcE0rL3JTUEw5ekRTYktmb2loNlFGeEJF?=
 =?utf-8?B?MG1XY2xReGh0UEN6d2x5NWc1VTBBZlRHMWNJNkIrNU03RHg2b0QrRjNSblYx?=
 =?utf-8?B?UEhPNGgwWEgxYXF0dWZqSVdZbWo3ajU1Ymduc2NvOXZYemlmc0NzRmczK3ow?=
 =?utf-8?B?UmNac2I5TnpEYU52VWdKY0ZIK2pRSVBmRGxhbFdoTThGd2FjVExYVUF0U3F5?=
 =?utf-8?B?MGpOZlNzTlE5L09SeUhyYVlVR0FXUzlyUEdHaUltVWhUeFBxQXlSY2JIazBP?=
 =?utf-8?B?OVhMakhqSERlQ25YZ3RjdXdyT1pjK3JwKzlNdkVRZFJnRHBoakgyMXBpbjgv?=
 =?utf-8?B?V3lJQlJQZ0FMR09ZWW9MUVdLM1pWOGRqU09qNE9SUGpMVFNkSytDMXZkY3hq?=
 =?utf-8?B?VWN1UzkralZiUlBZRVZqYWRZRnlTeGhhK2pIaGE3aFNDTjdYVTk3ZFVBaFhs?=
 =?utf-8?B?S1E3VlUrMnlocDhMd3llUjlhV2tCRnJVNXFJdEZ1djZIbStwbU1sWndxS2Ni?=
 =?utf-8?B?dkRBWlFTaU9oVXluTGt3a3YrQkJUa2hVZk1IVFd1YUZPT3Y1L2VUd2tyZjVY?=
 =?utf-8?B?YjJISDJUd3lsemxaZ25EUisvUWIvejUwNHIyUXg1Mk5VYUh5STEzZ0ZlMEVM?=
 =?utf-8?B?dUpBM2JuckJVYVh5Tm1MbEFTcG91OW1DUEdGTVRPYzdSWFhVczFZWEhCdWFU?=
 =?utf-8?B?UHdERFMvSHd4M0sweDc4VmpoTzFOeXZKTXhpN3NTM2FJUEhHVVB3eHdHWHlu?=
 =?utf-8?B?eFVoOW5WS1lCSTNQOUE1em05YkY0UUVUSllMS2VUNDdiMjZZemV2SnBtSHhx?=
 =?utf-8?Q?qZP2t9ARNN2YmoTfRwRsRSrRz3rHxDXirJ4lUVzLuY=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700013)(14060799003)(7416014)(376014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DAmJh0l/dqcLmc/HGj5Auej35kC5JFoGFU+RPun+ZZoEN5zpt/eBecEFhwhCNgFpBaAy6AMVFG/f7c8iwL20ixuJ/thNOePPT7xfOY2ZycwDPq8NuagWwJnHilrpCgvO3pa/ln5HM1+vdUXnhx1Ng9tXDodIzdj4OyXRyKysKE7hpKoAuHi0D8h68c0jNV3hdgWBer02Hv2YLI0xQ3p7TqcVWuz31gkYxkcfg2koeUJkJtUqYTK66RBNsgNLj7Wt/BRo09j00E20/fch9X7Nhd2uqNk14Bm3Uth2zRj9xLHMt584TQ9Qm0K/l943YLrAx/OvnxF+FGrAKwR0xB8uI7TGEH7Z89kW4JKid3L6baCfLH1xbx8eiufvriM8oBN6qzUZ4+RazpNKk0Ks0eRmmhM9F/aAEDD6jyEvVOrwmUh06dFMwhSduHVeH1r9RpOI
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:24:55.3302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8079bfb-6ec3-40ad-2561-08de5fd90c76
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8635
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20784-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[arm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre.gondois@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CF27AB854A
X-Rspamd-Action: no action

Hi Sumit,

For the whole patch-set:

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

Thanks

On 1/29/26 11:48, Sumit Gupta wrote:
> As discussed in [7], v5 was split into two parts. This is part 1.
> - Patch 1-3 from v6: Applied by Rafael for 6.20.
> - Remaining patches: Included in this v7 with review comments addressed.
> Part 2 (v5 patches 8-11) will follow separately.
>
> This patch series adds sysfs interfaces for CPPC min_perf, max_perf,
> and perf_limited registers, along with supporting ACPI APIs and
> improvements for the cppc_cpufreq driver.
>
> CPPC autonomous mode (auto_sel) enables hardware-driven CPU performance
> scaling using Energy Performance Preference (EPP) hints. Currently,
> there's limited runtime control and visibility into CPPC performance
> registers.
>
> This series addresses these gaps by:
> 1. Exposing min_perf/max_perf registers via sysfs (as frequency in kHz)
>     to allow fine-grained performance bounds control in autonomous mode.
> 2. Exposing perf_limited register to detect and clear throttling events.
>
> It also includes code improvements: new APIs for reading performance
> controls, a warning for missing mandatory DESIRED_PERF register, and
> extended epp_perf support.
>
> The patches are grouped as below:
> - Patch 1: Add cppc_get_perf() API (independent).
> - Patch 2: Warn on missing mandatory DESIRED_PERF (independent).
> - Patch 3: Extend cppc_set_epp_perf for FFH/SystemMemory (independent)
> - Patch 4-5: APIs, sysfs for min/max_perf, perf_limited (independent)
> - Patch 6: Doc for min/max_perf and perf_limited (depends on 4-5)
> - Patch 7: Update cached perf_ctrls on sysfs write (independent).
>
> ---
> v6[7] -> v7:
> - patch 1-3 (v6): Dropped as they were applied by Rafael for 6.20.
> - patch 2 (v7): Added new patch to warn on missing DESIRED_PERF as
>    suggested by Pierre.
> - patch 4, 7 (v7): Removed mutex from sysfs store functions as
>    policy->rwsem already provides synchronization.
> - patch 4 (v7): Added validation checks in store_min/max_perf.
>
> Sumit Gupta (7):
>    ACPI: CPPC: Add cppc_get_perf() API to read performance controls
>    ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
>    ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
>    ACPI: CPPC: add APIs and sysfs interface for min/max_perf
>    ACPI: CPPC: add APIs and sysfs interface for perf_limited
>    cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
>    cpufreq: CPPC: Update cached perf_ctrls on sysfs write
>
>   .../ABI/testing/sysfs-devices-system-cpu      |  44 ++++
>   drivers/acpi/cppc_acpi.c                      | 214 +++++++++++++++++-
>   drivers/cpufreq/cppc_cpufreq.c                | 207 ++++++++++++++++-
>   include/acpi/cppc_acpi.h                      |  40 ++++
>   4 files changed, 500 insertions(+), 5 deletions(-)
>
> [1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
> [2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
> [3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/
> [4] https://lore.kernel.org/lkml/20251105113844.4086250-1-sumitg@nvidia.com/
> [5] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
> [6] https://lore.kernel.org/lkml/20260120145623.2959636-1-sumitg@nvidia.com/
> [7] https://lore.kernel.org/lkml/66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com/
>

