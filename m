Return-Path: <linux-acpi+bounces-20408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3375D33BB1
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 18:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBF4D302B72A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BC369207;
	Fri, 16 Jan 2026 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LcQIs0Jf";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LcQIs0Jf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE75346E41;
	Fri, 16 Jan 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583207; cv=fail; b=TBE8AKpeDqTx9Al20dYvReX4pKyT4DXA+BAxeREjAQRaj/eaSIC7bSmh5+DsnPQXHnHZVnUFoorsSEODk6ATafq5jf1Yl5DPDtYkAMctehpMzsUWYARBrqIJf+KKkAsY0geOOOO8nI9AN8BIWFK/qxyD+aQ5u22cFvA7dcNzaMA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583207; c=relaxed/simple;
	bh=Q0+vEc+9pavLX+MZJouGyqvXP1mWqBysfUYGM0fxgTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usok/Psbx+QiUEescb0fb+IFfuuWEgRSpUD4YpS5kfddXIBtIgtWBtpic6CngwSBg8/quawdpRRXp9NHdbmnqdeg2uCB7rK99+e6cqTTTzcyvuiQcNdYxx5M3UO5odlEs9fvLYbZryI9RbgSQ7BUA8Fz2HvKS5YN1YTze1JzZOE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LcQIs0Jf; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LcQIs0Jf; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=psRjoXmIs5c4Km9OCYl8tMcoNT/S+VxIgmEydreXrw4YZeWXwwYtSqr2pwy0t2nWk5o6UdDSvGc3Cmt/QqIDs04P2exwTxAEIuH5R9BfwYNRE7w/FLmASyjqZbvUjkyoNRoRUnmvzNH/vmCEe5UVwXaMMpazIsP0CViS2w0oBlAP2vUySJJbyi4z99wRnqhF0dk0+mjh5d+Wgrs9wlCEwCX1L2cxvPCs2WjfPP4DezLIExQjVg4aU+pzOwp4C1M+teZYga+4th9UPp67BJ6XO785cPsu7n0MTvRE0jtyh3APqqZ/NXcvLhlG/gPSTbWya6ZJJLvsKKKtyeKGtW7t9A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nu0IfWJUh+RqtbEYifvJV6I31u57S21W28SaprUdSs=;
 b=p4ipByyERwnsF/rwCLP04ez/rgo7aSIpHcvBpW95OXpoXs7suiGE5suqxWQOtcRDwsck4yFl7ERRQHZkSdyIZNKCwLz+l4CH4eaFhhwSz6YbXh0XSDN8UMiNyIGQZ0dwFs57s1cWU/gvwjvpNKZThdvJ1kbx10+SeqshywLeXaEZhGLnemygk2qODyudekvHbWCl94wdTY6n2lldGHg1ezTYhUgvvuzv/EkhJb3WPb2k1IkGOBHjMNkMQEeQQEBFC33efqnq7ff1SdOn50ssE7W+cNiqANaQvNBMnoby29tSH6BEkzkl0IKbicgCy1evttk714Ph/W/lnOrh0dak2A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nu0IfWJUh+RqtbEYifvJV6I31u57S21W28SaprUdSs=;
 b=LcQIs0JfwRZ2YcBQ1GtGbilW+yminPzKwjVaekAL5YT2+ljfkQHeAJkCCBv9S4DQTi0Xides24S9XfIy6iUMXpAXeT/I8YAy7GOz3P7kErYY70Ja4vItS27xTVkt7IMlde/KKW1Zg7iAuFfHSUKuDbadVh4solmKtv5sppalo7g=
Received: from DUZPR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::10) by AM7PR08MB5480.eurprd08.prod.outlook.com
 (2603:10a6:20b:de::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 17:06:37 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::7) by DUZPR01CA0034.outlook.office365.com
 (2603:10a6:10:468::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 17:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Fri, 16 Jan 2026 17:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4j4bdnNsvfBrkM14b0Fyhe9K7NZ0T9NCgQng31seWn/J7pZFzrNJb91duM4Ckq2cGwG1W32s8+tqh2f1vm0bxbAyNNCazMW25gJiLxgM9l5NDRn+PZRcDFfkOmjoiWUK82ir1HooBOmRuArAeWGCYkSvQAGHS6JlMLP2rMGmlJpsDBVqFj87hiYiP8CTgVTIV34jhHfohk+eU9aq/7cbPkfBodYw+s5jFwNJilFIqTwbPETONnawzbf9IYmkZcQSkOwO+1xsxyXJWoRRUuCeL1RK5aI79KCd7ao/AA56lCxYq43/Us13xfc876ZdxpxiiScfA/cosok65vySDH7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nu0IfWJUh+RqtbEYifvJV6I31u57S21W28SaprUdSs=;
 b=guVQxSoamPh/fggJolhGiM6KVgpE7xI4AX2xlRdi6+Ldkoes2egvn2R2g+p7pUcts+SSen3Tkg3ThX5Y5opBSS9RjdIzWmAdP8F57DJQ3DcNgwtCEHc3+sS02zaM9BYuCfKKNpyMQzdgT8qzyzdozbvbKWgTfKkORTeFCW7XyhvrRiskFJgRrm5j0OuTvDxhGS9nznaZSyT4hwQKzvdiA85EFO4kW5if2rxtYuITw2YCGKbuK14GHyVGdVKWvarl3DbUbl/EqGkz9KDIL+gQfTgVVry0tYe5S4FaIYR3Pk/J8MNQ4JUCbv8N+HzNc/MYCbrA6tDqMenh4/AmLKle3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nu0IfWJUh+RqtbEYifvJV6I31u57S21W28SaprUdSs=;
 b=LcQIs0JfwRZ2YcBQ1GtGbilW+yminPzKwjVaekAL5YT2+ljfkQHeAJkCCBv9S4DQTi0Xides24S9XfIy6iUMXpAXeT/I8YAy7GOz3P7kErYY70Ja4vItS27xTVkt7IMlde/KKW1Zg7iAuFfHSUKuDbadVh4solmKtv5sppalo7g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PAWPR08MB11485.eurprd08.prod.outlook.com (2603:10a6:102:50f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 17:05:34 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 17:05:34 +0000
Message-ID: <66f58f43-631b-40a0-8d42-4e90cd24b757@arm.com>
Date: Fri, 16 Jan 2026 18:05:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] cpufreq: CPPC: make scaling_min/max_freq
 read-only when auto_sel enabled
To: Sumit Gupta <sumitg@nvidia.com>, "zhenglifeng (A)"
 <zhenglifeng1@huawei.com>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, ray.huang@amd.com,
 corbet@lwn.net, robert.moore@intel.com, lenb@kernel.org,
 acpica-devel@lists.linux.dev, mario.limonciello@amd.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
 zhanjie9@hisilicon.com, ionela.voinescu@arm.com, perry.yuan@amd.com,
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, treding@nvidia.com,
 jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
 sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-11-sumitg@nvidia.com>
 <ed9015a3-42b5-4c0e-af6f-2b4d65c34cd5@arm.com>
 <0fe78528-db0c-494d-8d5e-b89abdc993b2@nvidia.com>
 <f85ce68a-91cb-4b8e-b67e-413e5b62cd03@arm.com>
 <27750fe9-8b0e-4687-bc5f-21e4ec38bf66@huawei.com>
 <0d1a10e8-a8d5-4d27-bd16-0443d5408ca6@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <0d1a10e8-a8d5-4d27-bd16-0443d5408ca6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0247.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::20) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PAWPR08MB11485:EE_|DB3PEPF0000885A:EE_|AM7PR08MB5480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0437e078-988d-4a43-2555-08de55219c0b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024|18082099003;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TlNLRlZZTHJ6Mm9QWHk3c3h4M1BpdEtpVUxUaHJob3pJQTdLcGVXQS9sYkxt?=
 =?utf-8?B?RzhyaU44OG9hSW44V1hwd1daTDNkcUdVOE1iemY3Nit6WU5KTmsxZFpoWVJD?=
 =?utf-8?B?MVlHbHMzTCtYM0pic0N3ckZJTTNST200M055dVlnRU5FZ01jdWV1a3hSSm1L?=
 =?utf-8?B?ZkNhb2pZWUs0VlIwbmtNK1J2cS9kdU1hcGhXbU9KSWNQSjBQZ05ONis5Y2lJ?=
 =?utf-8?B?ckpCZ2RseGNobUx6dEJGL1UvQVFWSU94UmV2UVFlOWhlaGRlTHE4M3YvaVYx?=
 =?utf-8?B?VTRhVGFpNzBXalI2NmZYN1VCYjFLKzNzYWxJdkY2c1IyNkNTbVFIRytJL1ZY?=
 =?utf-8?B?ZFhLeGxRZGxlQ1dNS1RVRm5JaUJ6RldpbVFOK3ZKazVEZ1lsZ1IrNTEzcllQ?=
 =?utf-8?B?dGt0MGUyVWlnV2JmMG5XOHJ0b2xEaW8rbHJxWXJxdzMrdDRBYjBPdlQ3dXpZ?=
 =?utf-8?B?OUxzSmoyUnJVdWhwdE9tNit0M3M1UUNqM0Jzb213YUJYVFVBSGxFa1BlYU5O?=
 =?utf-8?B?QTRSd2FKQ2YwZG4rWFdSYVFqTzBKWmpRZnpvc1ZZZklJa3lHWWZZY015aVhD?=
 =?utf-8?B?OEV2eUVUTHIxNjR2Y1AyS1F6Z1BkZ3MxK1lYeEdTZklPc28yZVVRWWJQMHdU?=
 =?utf-8?B?eUlQTm96SmNYVjBsdGs1ak9MKytWRldvVlJpOXBqbEhUVnNpV2lwdHEzY0py?=
 =?utf-8?B?UnRjbkZzUzV4UjJhMnp4WDZ2Nkh3d3hnSloxNXpIZU52aTk3QTZ6T2lvRmpm?=
 =?utf-8?B?MTBERlU5UkdrZXd0ZHZFc1ptOHJrbTBuOXZabDlZL3VmZWpnL2VLREMwNlo4?=
 =?utf-8?B?T0xrandrZkFwb3VMRlU4T2pnWUxNQjEzMVYveVgwSTJEbDk3QWxYdUZCcG40?=
 =?utf-8?B?Q1gxRzJYS2U0ZlJ0WW9UTDFYSlVVYkdJTDdTQlErancvWHR6NVc0SSszQ0d2?=
 =?utf-8?B?MU5kR2owbHZJVHV2L3hvc0dlK2lxRzhHdHl2U0tFK3kzaU5tRFpBN0p1Vm9x?=
 =?utf-8?B?ZVZxU1d5KytaR0NVOC9raUI0TEtvaThMN3dlK2tYcDdrNFRPcU53MHYvRFZj?=
 =?utf-8?B?Mm1kbkpiWU5DbnFZU2kwak1sOWwrQXhKOHR5ZmFTRVlzSnJLNksyamFpVlpj?=
 =?utf-8?B?bFNUM3ZnY3hUcnUzL0d3d2lCQkNFclJYS2IxbGZFY3RDaWhqZ2hzeFQxb1dw?=
 =?utf-8?B?YWFsRk40RVdTUDNNVEZFZXI5Q293ZWlPNEg2VDl6VTZIay9BakE1bEtLbkRY?=
 =?utf-8?B?V0JoWGxBdTYzc2g3RXUwd1VWaE52NEtqanJUOFhHQ2Y3UzJ2NVgvRVNRaFNV?=
 =?utf-8?B?dFpZODNva1N1YVZObTJvMmxyeXpsYWY5UEVjbmFFcnRhYVJjbmRzL0EzTllh?=
 =?utf-8?B?RU9DamNFMHU2dDhRdWJCMk5tc0xpVkp1N0QwTzhVRWdDaDNuckFVM1Fzak9k?=
 =?utf-8?B?QlROQmJhL095N3drTklRS20vc0ZRdlpBVGJreWFaaHpqaHhiNlV5YkgvWjdv?=
 =?utf-8?B?WHl4cENuQVFrSTRLQTFVSkhiMWU1bnhzcXBYWHNObGwzNUQ1c2lRMGtQL2l0?=
 =?utf-8?B?b1NsaDB0WkFFOEVEUE9POHdWbk9adUJhZDBNNUxHcTNJMlA4aHpHbEZNV0hD?=
 =?utf-8?B?MGVrd05iYTNkOXFiWVR3WjRDL29LcXpCYlNpNXF2V2wrRGx0dkNVV2VuM3ZV?=
 =?utf-8?B?Y21tYnpTZHRqMGVxTnBMTlEzUXNIdVcwVWtJRlVCR0J6QWFtOUVJMlphN21I?=
 =?utf-8?B?YlNrdDFZT0M2UTVLb1VBZFF6OUdIcUR3ZjZDU1BueVVCOHZUY21mdTJIOE11?=
 =?utf-8?B?cmhtUndJRmN1MEJNVGlMRmhzSWRSMHpDbTBuTHpMVXJqTkRqQy9uUEZxdlh3?=
 =?utf-8?B?cGJvelYrRG4yVjZNSjkybXFxTWFVUmpiTVczWHgvV3lBZFRxRjhCd0hUQ2Zz?=
 =?utf-8?B?SmJ2R29ub0NCM1pBc2RxWCtYMU0vSTErTXlqczRwa083MWVmSTVWZ2tqQzRT?=
 =?utf-8?B?RDJzTU96dStKd2d5NGcrNnIzd0l0azEyYVhIS0orRHYwcDA4VVdFaERBNkxn?=
 =?utf-8?B?Y3Y4OTc4WkhaT1h4UFUwcEJDYkhaYk5kWngzR2dwQS9nSzd1cXVyZVlFQlJi?=
 =?utf-8?Q?IIG+nd5NZjY5aiAe+Xfz45tY2?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11485
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4486ab39-f924-49d7-0947-08de55217681
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|35042699022|376014|7416014|36860700013|14060799003|18082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3ZKYWtzRHpOUE5HMSs4Q05VRmR5aEY5ZzRKNHEwK0FXTkpsTDhoMVlId1Nn?=
 =?utf-8?B?bmhGMHNBaGZvOFQxYlZtY094c01udGJQTWQrMjYwaVMxUW4yckJuZTIrbkZF?=
 =?utf-8?B?eCtLSU5MTGQrc3JRVFRoWlJ6bzByQXRiZ3owK3hVS2JSNllUaGt2ZUd5TGUr?=
 =?utf-8?B?SWwzMnlPQkNyMDhKTXN1SkxIajYycFBjV2JCVEpJQ3pSaHpwQXFoa3ZuWEVG?=
 =?utf-8?B?MENCU3Q0TW5QY0xzUFEzMUJjQVV4RnpFRW00RUhGWEdUbXFvZ3FabllSZ3F3?=
 =?utf-8?B?THJ2OFVSNFp4Lyt5VzhHZHBzVXJibDk3cE1EYXF1QkVZZ3kvMUxDYVIxbjE3?=
 =?utf-8?B?bWpUYU5NdW1wQ1JnYmJpSlFPN05Bby9GZ0hJeXZuVnR6NTRndnpDMzFXSUZp?=
 =?utf-8?B?a3EzcWtCWHRpdkVKUUZSQzRTWlVKbFl5SUU5a2VqZThkc253Mk1JbG0wUmxM?=
 =?utf-8?B?NVJ0U0FMUXhiZ2dHMmpVQk5Qd21wdEREbFNoTS9JSjFuNkRDWTBWNlpYeGFM?=
 =?utf-8?B?V01VMHQzVjVMSEhQcFZ5Q21tZWN5dmtnTTIvVy9OZVVPRFFNVldXbkNTRTZS?=
 =?utf-8?B?dGtLOEVhU1F1UzBINUUxaFdhN2MzNDcvLzlOL2xqNVhsbHpQUFVQWkVJcldI?=
 =?utf-8?B?S25XMkV3NEhCeFA2VUhsWHc0T05nUC8vd01qRlJ5SUoyVFR3WEhHYWo0L0JK?=
 =?utf-8?B?Q3pXVk5naGpyUkpFbnUxa2ZSc3BCT0MvNGdzb0xadEFDY3BFTk1iejlOTGll?=
 =?utf-8?B?R0hDSVMxcTY5Z2k2SHdNK0RWSzNpME5mN2Y3UC84SVBsZko4SE4rZ25DN1R4?=
 =?utf-8?B?eEtraUZIbWxFbWZyL0Z5T0RpanRETmpjMGdpUlFiQ0Y5dTRzSlR1VzdTUHIz?=
 =?utf-8?B?a2xLYm9OYXlXY0cwMDZNZTYzNU4wQWZmeC96SjZHYmNPeW1KS3o1bXFSNDRq?=
 =?utf-8?B?ZktQVW5KYUZaYy9nemRiWThZTkVlaEFybjd6MFQzM3gyc0VDWHdSWU5Dc2cx?=
 =?utf-8?B?MUFHd2MzVVdhSlFkdGRqK3FqMGJuTFNmZU5jdHdRWmZUSGxTMEt3QXgvR1Zk?=
 =?utf-8?B?N1licUFrM3hxWEVZZmRUMEJwWEFEVkRtTnJIRVV1YmZvaDBlQ1E2ZGpvbFdz?=
 =?utf-8?B?MFUwZ0MxTmhlYnRMVUVZUW1FUlhBNzByYkY1Q1JhUXFqNWx5a3hGbFFlZWx1?=
 =?utf-8?B?MXNCWGJNeFQrU1FHaEZyc0JRK09sakZ5Zk96aFlNeWU3RlV6LzlQVmtGelJH?=
 =?utf-8?B?S2hocmNSSk5OWC9lZzdycE1Gc3gxRXAyZkkzN0Q4TnFPbWlwQm4yaTgyVDY3?=
 =?utf-8?B?TXdCU2piOGE5QnJrZWlWZ0dNTVROQ0pyemhJQ2FxaVdscVVUSkkrMWVrOURO?=
 =?utf-8?B?elBWbXBDTEN6Y3dRVm15blVHc0dreks4anl3c0ptcDhRdW4rSjNhRi9FMkFk?=
 =?utf-8?B?RlEwVWZUNVRqK1FIOE92WklteVloZXpMOXNSSlVUQjlkd0dYQWNtVThFMEhF?=
 =?utf-8?B?Y3NRN1JhaVB6a2pWWHVKbHlOL2U5S1RnVHlnSTN0a0UvUFhwRDByS1hnNFFW?=
 =?utf-8?B?UTFpVjhaRU5PVXJDWnoranEzL2tFMmFNNVZsRHR5WUtrWGtvc2wwY1JsYWh1?=
 =?utf-8?B?M1hwN1c5amptVkl3b1NFTGdtYzRhWmpkVURSNk9tZGhxUjgzQmd2V2hHenlq?=
 =?utf-8?B?NXMrREkzalRGV1FaMTNSSU9kUThudHF6VnBzL3E1Y0ZLMnBqUVVKRmloek1u?=
 =?utf-8?B?TzF1M3BtOWZScUMxSlU4dmN6cTY0NURDRE9OS2ZxMUxpaThldFdkNDZteWFs?=
 =?utf-8?B?bkdldUkvTDBqU3BvcWZpWUlmQk1PMS93czJ0ZFdLUU9iUVRrbHVrRy9VNTNo?=
 =?utf-8?B?aEZMS2JPL0hOZzM1WXY1RGQwcGpQVDBmOGtwZmpHQWxGaWxJbXVDTmdoSkJ0?=
 =?utf-8?B?K0FCNWNMS0V4enlxWVRUNGVwNXhDOFlOWUNTeHM3TDVqTDVWZ29zMFVXbE9N?=
 =?utf-8?B?anNxQzZvcGNwc1dxZng1bVpvVkp2alo2dDI2QVFmMTl5ZTloZzR0bERRZ002?=
 =?utf-8?B?clA3WjlHY3FyWXU3SVpJSlE0RWF1MDlKaXNqTGg5VnVVaXhzREZmZEt0bUJu?=
 =?utf-8?B?Q1VVTGFwb2xXSC8vTTEzVWtVcUdEbXhpMFpsZVRFQTRXVW5OeDB6RUQyU0lV?=
 =?utf-8?B?WGlQcnRRbXVvMnhqb3dabGw4RUphTC9jSlU3S2hUeUlxdHhyVjRYR2tMTGps?=
 =?utf-8?Q?xIQIPLQ3mNoOL7An46mXybg1T7w8r+QS4XgYSymhfU=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(35042699022)(376014)(7416014)(36860700013)(14060799003)(18082099003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 17:06:37.2332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0437e078-988d-4a43-2555-08de55219c0b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480


On 1/15/26 16:22, Sumit Gupta wrote:
>
>>>> n 08/01/26 22:16, Pierre Gondois wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> Hello Sumit, Lifeng,
>>>>>
>>>>> On 12/23/25 13:13, Sumit Gupta wrote:
>>>>>> When autonomous selection (auto_sel) is enabled, the hardware 
>>>>>> controls
>>>>>> performance within min_perf/max_perf register bounds making the
>>>>>> scaling_min/max_freq effectively read-only.
>>>>> If auto_sel is set, the governor associated to the policy will 
>>>>> have no
>>>>> actual control.
>>>>>
>>>>> E.g.:
>>>>> If the schedutil governor is used, attempts to set the
>>>>> frequency based on CPU utilization will be periodically
>>>>> sent, but they will have no effect.
>>>>>
>>>>> The same thing will happen for the ondemand, performance,
>>>>> powersave, userspace, etc. governors. They can only work if
>>>>> frequency requests are taken into account.
>>>>>
>>>>> ------------
>>>>>
>>>>> This looks like the intel_pstate governor handling where it is 
>>>>> possible
>>>>> not to have .target() or .target_index() callback and the hardware 
>>>>> is in
>>>>> charge (IIUC).
>>>>> For this case, only 2 governor seem available: performance and 
>>>>> powersave.
>>>>>
>> As you mentioned in [2], 'it still makes sense to have cpufreq 
>> requesting a
>> certain performance level even though autonomous selection is 
>> enabled'. So I
>> think it's OK to have a governor when auto_selection is enabled.
>>
Thanks for the pointer, I forgot the spec said said that the 
desired_perf register
could still be used while autonomous selection is activated. This means that
having an autonomous selection governor is not a good idea and that your
implementation is correct.

I'm asking some questions about this to someone who should know more.

Would it still be possible to split you patch in two as you suggested in 
another
message, i.e. PATCH[1-7] and PATCH[8-11] ? I don't have any additional 
comment
for PATCH[1-7], but I might have some questions for PATCH[8-11]. This would
give me a bit more time.

>> [2] 
>> https://lore.kernel.org/all/9f46991d-98c3-41f5-8133-6612b397e33a@arm.com/
>>
>>> Thanks for pointing me to the first version, I forgot how your
>>> first implementation was.
>>>
>>>
>>>> In v1 [1], I added a separate cppc_cpufreq_epp_driver instance without
>>>> target*() hooks, using setpolicy() instead (similar to AMD pstate).
>>>> However, this approach doesn't allow per-CPU control: if we boot 
>>>> with the
>>>> EPP driver, we can't dynamically disable auto_sel for individual 
>>>> CPUs and
>>>> return to OS governor control (no target hook available). AMD and 
>>>> Intel
>>>> pstate drivers seem to set HW autonomous mode for all CPUs globally,
>>>> not per-CPU. So, changed it in v2.
>>>> [1] 
>>>> https://lore.kernel.org/lkml/20250211103737.447704-6-sumitg@nvidia.com/ 
>>>>
>>>>
>>> Ok right.
>>> This is something I don't really understand in the current intel/amd 
>>> cpufreq
>>> drivers. FWIU:
>>> - the cpufreq drivers abstractions allow to access different hardware
>>> - the governor abstraction allows to switch between different 
>>> algorithms
>>> to select the 'correct' frequency.
>>>
>>> So IMO switching to autonomous selection should be done by switching
>>> to another governor and the 'auto_sel' file should not be accessible 
>>> to users.

The cpufreq driver / governor abstraction still seems a bit stretched 
for the CPPC
case. Indeed, cpufreq uses:
- .setpolicy() callback and CPUFREQ_POLICY_XXX policies to allow 
external scaling
   algorithms
- .target() and .target_index() callbacks and scaling governors for 
internal scaling
   algorithms

But if CPPC allows to use both internal/external algorithms at the same 
time,
so for instance it is unknown what the 'performance' governor should be
converted to:
- using the the linux drivers/cpufreq/cpufreq_performance.c governor
- setting the energy performance preference to the maximum perf. value 
with auto_sel=0
- setting the energy performance preference to the maximum perf. value 
with auto_sel=1

------------

Right not selecting the 'performance' or 'powersave' policy gives a 
clear result
for pstate as autonomous selection is alwasy enabled IIUC. It would be nice
if we could switch between an 'autonomous_performance' and
'non_autonomous_performance' without manually toggling the auto_sel file.



