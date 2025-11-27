Return-Path: <linux-acpi+bounces-19318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69514C8EF5B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BB004ED8F4
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A432C301;
	Thu, 27 Nov 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WoE+6nFn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WoE+6nFn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8F299943;
	Thu, 27 Nov 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255275; cv=fail; b=JT4Pb2BlShFDV3ypUHkn2ZAtxzPBars7H+2N1i5QVMxrI2f8Ymj8Zl1xntOwt+jrc2W+lCsnvr3qbrXjqf4mz35Xnn4roWC1JnUyJ8KWqoGG89t4ghxQtFmow1nBnzlEQxJLLg8Dow16u1AuBar26z4dIsdJ70cG/+Wz3Dxpo7g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255275; c=relaxed/simple;
	bh=zCNQ1F+oYT2UM33pqbsOoZkSL91D+rCWLH4BvfLD6CE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B6368h7C2JTqL6Q6pJV7oRTU6HPPcQkjvx6wNPbBT0x74X3le2aVAJMj+acN6Cf1HaH4tXtEwuyzDJCcYrPsyu3H6liMmFNamueFZC89QgvzJsdx50CZTQOGrR7zgdw8edUNzdjtMCTvKniXzKzc8rFst5pWGZslZx9gYb8slmw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WoE+6nFn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WoE+6nFn; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=i6uSa7SzN/xg/GOGgkhl9tHewL/5YTjqmKYlsT5jEApVQ1zxaX8RMFYni7skqPVktwWPuhJyFlGRcMR73HCC4X1bC9RHqNftdd211lbbYU7MxqUPJWKpgu3PyyQo8FfF5ysltdkBm/616qySFvaz8raQGTt+Sf5m/QYMxv1tr469p78nJk9BcWS4gO7Y29SlHa/cb+Ppo8jmd+9FFNJxD4v6MMDbIZvFy1HJFEipjCVImymQA47Gg1UkSlBxumU+wvU29m8vANxU9Tmer4tp9Lo07o0KBrV3UwzI7MY7WtVZIXIl3bp9MaSMNCpe3zMQXDxIZRwhDC7MqwbYbD+WLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IlLZgoKV84k/DkdN8RV7fRq6kw14mIY9wAMlDG8Mfg=;
 b=pealFDiLBDkfsq6h9ugNoshpCd/a84wEK0jXdQZXYhtHm3xT+n6m4qoXrVfjHN0+Cxg3nBbywSviG+sbr4uAPERYAKB3mnRTpizvm4zEjKnVP0/MAEKM1ZkRX0CvA/ith/Owt6lsCv7Jg8aYQGg17+j/RMikOaMLclTQEhgiwI70Az/DrxKV5iB8nnIjD6J89KXvOIos/9O4JKsRUsR5ubiEkPXVu+dxz2SCsIimf7VzoTRV9evsa+wGBc12GeviyiXYsRigxvv5TDp6Pej/JOFEDfAgWOaD1hC+4N9AXEYM/LcgyM4Pq3zZ2kIvkPFwUVHgrmPYdYZyM1II/K5dPA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IlLZgoKV84k/DkdN8RV7fRq6kw14mIY9wAMlDG8Mfg=;
 b=WoE+6nFn4AzvFZoHLpwjK/ltMJ11P0yvzmX2Noh7RKtQuLj8cTN4isqkFopcb7v3US/wTnSCa3m84W/NvVHnE5z31segiQJeoGbUeBjeelXErehGVR6sEU1Kojagy2YsiPAlgHZPoyx/1iuiV1Se4zm/GOpzzhVwBIfSqpnSrdg=
Received: from AS4P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::14)
 by DB8PR08MB5323.eurprd08.prod.outlook.com (2603:10a6:10:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:54:27 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::f2) by AS4P191CA0018.outlook.office365.com
 (2603:10a6:20b:5d9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 14:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymqGPEs9BubGkGmGRFfeyho5x0d5gFUecA6cqqiYSraNF6EOrr2Zg4j4Jcodk17Kp/SyqMf7W8lDeadgN5atEYYLSOj2gkQyPE3q7EeVerjKyTbhFD5TcPADL/eaGjTFdfAmxOpJhHpzg3+j5uqIEe67Xjr6nHzFz3KDCIdnfxJgI8qmQHSKAmmYjtr8LZLLHXlIsIuIYGBaF/0MMAoMx/xQrJfCfX8IHTVmlHqd8yTDCu+ZYOrrI8sSMH3sd+A+lbwSpD+97FpcsldZvJ7Dd+x9UtvoveoZczilP2GnKTiSVq6h1td/XJTVMScg1ALaTsHypjxLZ13Q32z94oVRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IlLZgoKV84k/DkdN8RV7fRq6kw14mIY9wAMlDG8Mfg=;
 b=bg1vg9OsuDSUw6/bIB+B9Ha1zYoEEQKA7Ci3C8PUdE/+pE+JP3ZLRygtFdV9wPv5R9OeR7+OfMv7LQ0IHxieqXra5LsGf3i6YKVZlfFhWQEtLiWKpsh0OUJOtrjHpcDeq5qnkbmantegxTVUFwwi7dHyAxGkdwdTldRPcRfXWIt9Vnx3ajSImdvytvXIQFvJuToEXGWUi/YilqS9lEnJKKPLmqAiW4DU6+ZXC90i4TALSm5H8fsXl97+hc1S0iPywHB2iS6+0386nRFzXqijYu6nYq7JTOKGxHVepdEw3qpAwltIiAmr8tNzi7TzN2PQOBFUR7nN90Dpt3QDmTeLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IlLZgoKV84k/DkdN8RV7fRq6kw14mIY9wAMlDG8Mfg=;
 b=WoE+6nFn4AzvFZoHLpwjK/ltMJ11P0yvzmX2Noh7RKtQuLj8cTN4isqkFopcb7v3US/wTnSCa3m84W/NvVHnE5z31segiQJeoGbUeBjeelXErehGVR6sEU1Kojagy2YsiPAlgHZPoyx/1iuiV1Se4zm/GOpzzhVwBIfSqpnSrdg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17) by DB9PR08MB7891.eurprd08.prod.outlook.com
 (2603:10a6:10:39e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 14:53:50 +0000
Received: from GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8]) by GVXPR08MB10408.eurprd08.prod.outlook.com
 ([fe80::7727:253f:2e85:efb8%5]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 14:53:49 +0000
Message-ID: <011bebf3-ebd4-4245-88ce-5e826faae66f@arm.com>
Date: Thu, 27 Nov 2025 15:53:43 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 2/8] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: Sumit Gupta <sumitg@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 rdunlap@infradead.org, zhenglifeng1@huawei.com, lenb@kernel.org,
 robert.moore@intel.com, rafael@kernel.org, viresh.kumar@linaro.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com, corbet@lwn.net
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-3-sumitg@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251105113844.4086250-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::6) To GVXPR08MB10408.eurprd08.prod.outlook.com
 (2603:10a6:150:149::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR08MB10408:EE_|DB9PR08MB7891:EE_|AM3PEPF0000A798:EE_|DB8PR08MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: b92448d5-c393-4dca-e9a9-08de2dc4dc4f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Tk1oMDBUOU9RK1hXZDVFNnRuWHlMd215ekhabzR5RjROalByYS93bzJmaWFk?=
 =?utf-8?B?blR6dzNrbmViMlFKODk5OXBGeVF3NU05SC9Pc1JLaFF3enBpOGJXYUIrQUpJ?=
 =?utf-8?B?WXlNTXFOeXNRNHVFUGNYam0vK2Rvd1hzbllIZDNRRjhOM3NMckFENXE0ajVV?=
 =?utf-8?B?dGZCd0V1TDVRMTlEaWRrdFNhVFZacHVCKzQycGFTS2FMcklCenlyVXg5bzhz?=
 =?utf-8?B?QmhlN25DT1d0ZE96T3JCUFFwZHBjaXlHeGhKVDVkT1V0UmJ3Um0yUkRuNEtj?=
 =?utf-8?B?elhSTlZEUk9NTGJTOWtXQU53NGpsSHVhUjVFQlhVYmNUVE9aSnFtSE1pdGNL?=
 =?utf-8?B?a1B5cU5JemU1cTJwQlhoaHFPZi9pS3NUWnB1T1Q0cHdMSWpWKzlieXoyemdw?=
 =?utf-8?B?UmR1WitiQjNOTXdmekNNNzNpOTFPdk8yTkRmRFVkZ09sQTF6REMvd0hSbE02?=
 =?utf-8?B?ZEhDUjhkYUMyYWhNMlRUK2paZExENTVxcmtLM01vTHdCNk50ZlRwYVBFako4?=
 =?utf-8?B?a1ZndHA5Y3FlK2NmVkdxRFpRcXhMTHkxajlGMHV6VzdMS3RWdCtnOHMra0NZ?=
 =?utf-8?B?VndPZ0xWZ0xZdHcrMHNqM1MzQjJkUzkzQmkvanhzN1hmTXJBVmZWUStrV2ta?=
 =?utf-8?B?QXg2ZG1RSGxPYlNQR2xUaWlvR0l2MW9ORklwM3d5aGRZQ0RrNDNLT3dCOHpC?=
 =?utf-8?B?UVhpYTdQUkpGV2NoN1ZSUnpxUUUzZWk4ZmVrelBnZE9ONnZ6clJDcURnM1hr?=
 =?utf-8?B?UXJ2OHMxRytMMW81b1FxZHpkWERDMks0cWdodFQ4d1RtTGl1WWN2ZTAzaEN4?=
 =?utf-8?B?eEt3MFp1VHBXYTF0WDJwN1BLMmdKR1o1QzNBQXViK3gvNTBta1RRY01sUXU1?=
 =?utf-8?B?dnp0SVpmSXg4aUxLRHdEbjdCWU5iQWZia0s1Tmhxdy9NUjRZcU9kUmJMdzhE?=
 =?utf-8?B?MVk0aUJ4ODU2NlF3Tk5TekVWNlhwcGdsS25OQUpkaHlTTldjbXdMa1lzbXJ1?=
 =?utf-8?B?UkNPZ3VDdWlDSFFQY3N3cEdlbkM5QUU2R3ZNbWdyQzlyblBaVnhSUTQwMERR?=
 =?utf-8?B?eTRQaExWUFhnMXFKQzd2NUFVZ1lZaEJLRDJhQk9xcVltemg5TXNUWHIxMElR?=
 =?utf-8?B?RmRNbVM5QVlGUzMyaWpucWFiUmwrdXRnSDlyT1cvYlVCOElsdDZSU0I1MkJz?=
 =?utf-8?B?QUJ5UmE2bXoraUNLSzVPQytUZEorbXlDUTJsUmJHcmNMS29VU0Zjc2hZZnFQ?=
 =?utf-8?B?REs1TVdQQ21vL0QraTFpNW9XNzRydVk5R2tpbDd5NVR3bDk4bGxSOVRWeGQr?=
 =?utf-8?B?UU9LdkJxMUVJS29IakJCU2hlaWZYVVFxM0FLNTdaMEZaVkg3SmFUY0VUc3d3?=
 =?utf-8?B?RjI4QzA0WVc4d3BaNUlaTHl0aXMvL2FRYjIxSEJYOStObmRBUTZ5MytvTGtB?=
 =?utf-8?B?WHFrSWZGQmJqelQ2a3ZtSmZsbVptZ0pyQ3ZUcFVpa1dwTVB0d1ViNzY5K0c4?=
 =?utf-8?B?Y2pXcUlsQWhOaS9wRDk1eVZoMlpzY0k2YnF5WDNJT05DLzk3RHNNY3NCdFJl?=
 =?utf-8?B?aDhNbFM5OGJoNkJEVVVUQWl3VHRUcmkwVmpZdkxVQTdCaWxDM3hrMWJudGRo?=
 =?utf-8?B?djZqYUVPWXdJczNkTnRRbllNRklsaVhxLzlLY0dsYjlHb3R5VnJ2S0VUb24y?=
 =?utf-8?B?R3Z5NWJHMDhXNmZGVGM0UzhTeW1yYUNKSkk3U0FyQlBPaXdQMTZYQkJHYTF5?=
 =?utf-8?B?T2FPKzY5NXFqcXFYTTlDaDlaK1ZhamxkdlJmSVFiVXZYWmFYUTF2NE40YXU1?=
 =?utf-8?B?eVpINkE2cmQ5Z0kxbFg2WFh1VEVjS2RBeU8zamRHajdxTzJGcWo2M01aMTZQ?=
 =?utf-8?B?Q2xlMDdzQTQyNXBkL0Y4V2dSUFV0SDBZaEZQOXIwMzlhdWJaYS95MnpFUEF1?=
 =?utf-8?Q?xh1XXG+/vAy6OZiDhQN9DcjU86g76Dmr?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB10408.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7891
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	25c222f2-3c73-484a-eced-08de2dc4c5f3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|1800799024|7416014|376014|14060799003|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXhCYTlxS3NWYzQxNFFoNlJtaEJWZW1NVjlnd2NXaE1aS3EzS2VuaWhKTGtL?=
 =?utf-8?B?S3V3a0RFVDRRYitNc2x5YnJZZEpuZDB0L0V5b1NwTTkwWlpZQTBGM1ZTWGlX?=
 =?utf-8?B?Z1Z1VkwrZEd0TXhxS01Ya0t6aS92NDlGeW51dE9ueHlDQ0ljbEJFbk9GaDc5?=
 =?utf-8?B?M2s5MUtUdkRUWVVxblk3NVc0MWx5OHgrMytjM2c0Q2ZIdnZBQ3lGWGFuV1Vt?=
 =?utf-8?B?NnVxMkRiWTBIckxxb3pHcEdCL1lJSmRwTk9JYlI5REJkRXRYR2dsL0w4THpF?=
 =?utf-8?B?OFhFMEhGWURyMjZ5aVhWbEpjOFpBMGRWUEp0cVpOVUZJeC9BZTNYZVhJU1Zv?=
 =?utf-8?B?bExTcGVmT0tWalJzaWlpaytXSmpRZTRud2hmeFdvMllneWRjQlI4RmtCclp6?=
 =?utf-8?B?dzZ5SjlyS2ZFTm01WjczNVA5aGxnZGs1ODZ0RkF4TGxuMFpRSnRCd0FrWDZR?=
 =?utf-8?B?SE1pNjd5NlNzVlhMYzdhWXdvSXZVREc4ckhlSlU5NGlML25HZ3ZrZ0w2WStz?=
 =?utf-8?B?SFBkN1gvcW9xeWR3bTZzRHhXNUhFL2d1YzlnSlJqS0V2bWFaL3owQWZqWWpV?=
 =?utf-8?B?cGI1cDZuaEZpTkM0NTZaVmlQT1NqZlFyajlvRDhha2lVZzhtcUI4eHUrQWJP?=
 =?utf-8?B?RzBzVEY2cWtPOWpRRThHMkpORk9EVC9XK1Arb2xhRnNXaHhxZ3VUZDgxL0RY?=
 =?utf-8?B?cEhnWjlzYjk4cUkwR2JGM0s5NFlVYmNwODEyMVNZR0s0SjgvZWV5K1NKeHkx?=
 =?utf-8?B?REVCQzNDN0lncDVEOXhJN2h1YWNHUTF2YXhVYWlwTmpEYVZ2K3NWUzJmZjg5?=
 =?utf-8?B?TElNWTdJQlA1eEUzRWdObEI5MnRSb2dlK3lJN2JXSHZickVKaHFZWlcxY1ln?=
 =?utf-8?B?bCtPTGQ2MkF6RElnWUp0RTd3ZzJpZk93VTNBWFFsZTR3Rmowd1VFb2JQNVQy?=
 =?utf-8?B?UEZzTDFXcTJJTXA1SVg4c3Z6cjE3MkdtZUI4NFBPamhhaE8vaXRnZGFWcUpy?=
 =?utf-8?B?cFA3TTBncnJPUFFlWXlxWUJQelR3b0hjL2hzVkFsL1lPcFBzZmdHL21QT3dC?=
 =?utf-8?B?V2xsZWlZYlU5Y0Ywc3VjSlh3YldXcUZzdEtSWll6RGRzWkxQdDFtYmpNTUhM?=
 =?utf-8?B?cUw2eC9yWUl0S3ZlTDVTbjlwR2VTWitqTjAxQUJpWmErV3A4WW11R1drc3dm?=
 =?utf-8?B?b1g3THFZanQ3S2ZmemtLdnJVTzNMWTd5SXozamxJM0x6bytVeFQvOHAydVlV?=
 =?utf-8?B?eStsbmp4VWJMcEc5cDhNSEdBSmhwMmFpK2VpSFowMk13aXlTUU1VL2NldlZ0?=
 =?utf-8?B?K0hnZDZXaXNZeWJ4dFVXMVQzaUJIL3BhZHIyU0I5dlhkS0ZHWWZhVCtoa1hn?=
 =?utf-8?B?VlpoWVNDN0F3M2wvN1gvNitOQ0JZUXFsbmRKZ1ZySWpvUFVIRkRkc29ZWjJn?=
 =?utf-8?B?dzZpUDg0SUpOdCtCMlk0bVJ6dG1zWU9LY1M2TnFiMU9RK2JpTHlWaTlwSTBD?=
 =?utf-8?B?c3hhVGRrbWgycG5mSlMrbDQ1UnMvMWxQVyt5aDZWTlpDNTdHY3BvY3JCY1ht?=
 =?utf-8?B?R0c3bWlBV1k4MDdoSjVqWDBLanQ0MXV0ZmUwdlN4ZnI2M2FFaGtTMnlNNUdZ?=
 =?utf-8?B?bXpaY2NDT1NiQkNVaEJqelV4SUdJb2hoeE9GL3kwd005RWIybXBCd0RjNHFu?=
 =?utf-8?B?SkliZVhTbzQvVHdjSkVBank4LzJCaVVCMlA1MjIwaHR2TzVJVUxieEVRZE11?=
 =?utf-8?B?SjlVZEdkQ1J5d0UrTDd1RHoydE9Ockk3VUdXTTVxSjNYcFRPTS9HMG0zUEJC?=
 =?utf-8?B?S1o5UG5wSVc0NURoSXVHYzVNcittTzVxMWVkbTlsZWwxZFhCQ3VVS3pRNUJa?=
 =?utf-8?B?MFlWSkk5WW4xOHVmZ1orYkh5M2Fwangrc1BFWDBLRUpJbjEyUEZXdHNaM2Ns?=
 =?utf-8?B?L3cwaW9CNTlTTGRCTW5wNWlTMjRjc016ODNZVlhPZVNsanFTV1hpcnQxRit4?=
 =?utf-8?B?Mm5SaGRxRE9FUHJ1cHdEMXE4ditlZ1ErS1JWdHBaQ1UrMXJncDZ5M2d5OCt6?=
 =?utf-8?B?ZXRBS3N2Q3NvaXBNQWZZelBibTV0V0pKc0wxNXhsdENtMk5rK1JLZmlLS3dw?=
 =?utf-8?Q?ggpk=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(1800799024)(7416014)(376014)(14060799003)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:54:26.5331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92448d5-c393-4dca-e9a9-08de2dc4dc4f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5323

Hello Sumit,

Sorry for the late review.
I think it would be nice to split the patchset in 2 as handling the 
auto_sel and
min/max_perf values in the cppc_cpufreq driver might lead to more 
discussion.
I.e. the ACPI: CPPC: XXX patches should be straightforward to upstream.
This is just a personal opinion, feel free to ignore it.


On 11/5/25 12:38, Sumit Gupta wrote:
> Add cppc_get_perf() function to read values of performance control
> registers including desired_perf, min_perf, max_perf, and energy_perf.
>
> This provides a read interface to complement the existing cppc_set_perf()
> write interface for performance control registers.
>
> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c | 73 ++++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h |  5 +++
>   2 files changed, 78 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index ab4651205e8a..05672c30187c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1731,6 +1731,79 @@ int cppc_set_enable(int cpu, bool enable)
>   	return cppc_set_reg_val(cpu, ENABLE, enable);
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_enable);
> +/**
> + * cppc_get_perf - Get a CPU's performance controls.
> + * @cpu: CPU for which to get performance controls.
> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
> + *
> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
> + */
> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *desired_perf_reg, *min_perf_reg, *max_perf_reg,
> +				     *energy_perf_reg;
> +	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = 0, regs_in_pcc = 0;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	if (!perf_ctrls) {
> +		pr_debug("Invalid perf_ctrls pointer\n");
> +		return -EINVAL;
> +	}
> +
> +	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
> +	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	/* Are any of the regs PCC ?*/
> +	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
> +	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg)) {
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id forCPU:%d\n", cpu);
> +			return -ENODEV;
> +		}
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +		regs_in_pcc = 1;
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* Ring doorbell once to update PCC subspace */
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
> +			pr_debug("Failed to send PCC command for CPU:%d, ret:%d\n", cpu, ret);
> +			ret = -EIO;
> +			goto out_err;
> +		}
> +	}
> +
> +	/* Read optional elements if present */
> +	if (CPC_SUPPORTED(max_perf_reg))
> +		cpc_read(cpu, max_perf_reg, &max);
> +	perf_ctrls->max_perf = max;
> +
> +	if (CPC_SUPPORTED(min_perf_reg))
> +		cpc_read(cpu, min_perf_reg, &min);
> +	perf_ctrls->min_perf = min;
> +

NIT: I think the 'desired_perf_reg' register is mandatory, so the check 
could be removed.


> +	if (CPC_SUPPORTED(desired_perf_reg))
> +		cpc_read(cpu, desired_perf_reg, &desired_perf);
> +	perf_ctrls->desired_perf = desired_perf;
> +
> +	if (CPC_SUPPORTED(energy_perf_reg))
> +		cpc_read(cpu, energy_perf_reg, &energy_perf);
> +	perf_ctrls->energy_perf = energy_perf;
> +
> +out_err:
> +	if (regs_in_pcc)
> +		up_write(&pcc_ss_data->pcc_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf);
>   
>   /**
>    * cppc_set_perf - Set a CPU's performance controls.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 13fa81504844..7190afeead8b 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -151,6 +151,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>   extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>   extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
> +extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>   extern int cppc_set_enable(int cpu, bool enable);
>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> @@ -192,6 +193,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>   {
>   	return -EOPNOTSUPP;

