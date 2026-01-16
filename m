Return-Path: <linux-acpi+bounces-20407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F19D335DF
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 17:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3C05300870D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23B341073;
	Fri, 16 Jan 2026 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W+NN99lI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W+NN99lI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD61E1E12;
	Fri, 16 Jan 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768579252; cv=fail; b=IPI5OL/NEuQ2/aQgEv8SYO0n6a2UJY6zBgHgRmD5rQ6uBxrQvBKO21oCSZhsD9TBrZSKZl42ubbH05we7qt+EtF/yOGbAgv3Y63lBQjIArF/f8/sLzebUg4J1pHpTgAhz4LPmo5bEtnejJl699fPZAmmmDELmRuaDeyehqn2agg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768579252; c=relaxed/simple;
	bh=87UwhWe3kXxqk3R040l/Ri3M4uBo54i6i8qX8tFD7WY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V4V7TZPKltPlq7UAVfwEWwQ3Lamw5Un1rMlwyxMJAb3RZC/OpZOfxTMqtuQJ834iiGKi09REJsn3jL0JWEMh2VAGEX9Tsrk4UYzuLnVk7sU2VYAEntoPgfjaGKC/EJYvXM2gjED8bjq16txzPSk81cZK6hqEf1wFFLTHhP4Uy4U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W+NN99lI; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W+NN99lI; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yD5fIO9fHKuKjz6MduxyUYBB4eAT6EvQjtKylFBagfOVkMy+gfnbw9pPz39Ens5TQ26S6mNGfJU0m9Gv4f5cEzP6grgYmGIjmc9yFXlLN7EvsstiMb/UwgYbyIiBvUf3R5Hn7DVQWwWyttNbDcxqRsR4GPpSNEqrMs3k8/T5e+8bzVWtfYAh1egOBGc5d2TjG1GRYPhaVGQAR0PGYAk2JuShR/T6sN2s61tpfgWS9lKJN+AToa7rmMU6UyZfcGelvTudQrigh3VyoAS9vXNO1kgb+DDcPl31OcNLaQ5CxUW2iIbC0aeHiiAhj5CXr9QFjA/MQKPbvXeT+aZJPAbiGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cuqWinzn03yGcrxwSikHAli8Dtwlk+PftHFuEBfmow=;
 b=bbCg55bCaR75RH4dnMxvYmhzAFSzocNH2nFN6NJchSDqfxocGO9rE8nHA0X0daqTFBVH+hm7GMuDMqXEn+xiXOUZ1L5+ZvEKi5zkayJNGdFRl11+qGuYOJBgBen+b92NW00bwo8kkNKMpD+W13eM7Bdd6q+abLOlcNfrRmqePFR9CxJgWnf9PxYIo0cNAKap2I+YUM9bYRCRlbX8IcWuZouYjDkF+ptkJe8/FrIXE2rwxo2AelUA7qm93K/RtJ5rT3GuiedKl3U7MEgVf0rKQgCCxyKp7WxeLQyx9wxfJmYzqVGBLikDTLsEhbrZ9kv7Ai3fPgqTTxSh6oUTr/zXuQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cuqWinzn03yGcrxwSikHAli8Dtwlk+PftHFuEBfmow=;
 b=W+NN99lIE7zZer7FGrHRuTXd/RcJEpJAHk05el7qje58Kg3+k9bH+NeKtSATn7hsMlz3rVzqOizT3i+ghd8IozsxrB4DCkbn/utJ9ULCQIjFnFbCvqESC37BhOiP2QalIZCXhbEqsnk/evsi9Iicqo3g3dvdAZlVNlKuSgsTS7A=
Received: from DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) by PAVPR08MB9016.eurprd08.prod.outlook.com
 (2603:10a6:102:325::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 16:00:40 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::d) by DUZPR01CA0158.outlook.office365.com
 (2603:10a6:10:4bd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 16:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Fri, 16 Jan 2026 16:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQHrZr9e9f5kO3zTf/LbHrJseYmdPreCrIc36CgL0gP5HCH80LDLoHOmZ4jRa1ffbgJT/6szoIZL85uIhacNyQFlYGGwL8YFavvQYFYm9U71gnUEWZN/tu29K5G6p5s7Beip7iMFOjHFbT+G2OpRPAnbbh9JAW2b9bIaKrbU4LmVLYMttRA4fOxN2pYGXVKkbjSzrVMMK2mLzc+7HUJtU1m2h8PR2QehxUAQZsnkC1YXqfoROG05xfaHTmVxR4z33NHL+w+ThA+4+9exHlXh6WlF5yl6J9XEvgocD/UlErVreUxA0M9j1tGXeSvlGgIdzviJK6ucP/9vWzCaYnra7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cuqWinzn03yGcrxwSikHAli8Dtwlk+PftHFuEBfmow=;
 b=Jk//d/B4chAZSMsHL72FNts/sFcwHze7hTTOZVW5+WWXkTV6qhx77LxNxW+7VYOu15SxM81oQPD3mFrGjStTdjbv2xyn1sZ+UmX5pIrIZCHIX23frgNX+2Nmup7VesalG2h3Kon4xagJWAbSM1XXc4fssygon1QSoqBDn8RaPxVbG8Lits/EFD+HSjIE7Ma70h6q4pNiXFBnPf2zJtRNdbXB/mwPWwYP4xvrzOtPZnqKh4HDLGZ0O+PgWKl0kc5PTg93VjTigPIA0QJ6vzYI9DEPsfhS0F9HHLGzx5WGbL+AIKwcHcs/aY4dWtxi2CRVkbq1+XjpqSe27TBtdW3GNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cuqWinzn03yGcrxwSikHAli8Dtwlk+PftHFuEBfmow=;
 b=W+NN99lIE7zZer7FGrHRuTXd/RcJEpJAHk05el7qje58Kg3+k9bH+NeKtSATn7hsMlz3rVzqOizT3i+ghd8IozsxrB4DCkbn/utJ9ULCQIjFnFbCvqESC37BhOiP2QalIZCXhbEqsnk/evsi9Iicqo3g3dvdAZlVNlKuSgsTS7A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by AS2PR08MB8720.eurprd08.prod.outlook.com (2603:10a6:20b:544::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 15:59:35 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 15:59:31 +0000
Message-ID: <d5471fcc-ac74-495f-ab65-18aa870bd5ba@arm.com>
Date: Fri, 16 Jan 2026 16:59:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] ACPI: CPPC: Extend cppc_set_epp_perf() to
 support auto_sel and epp
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
 <20251223121307.711773-5-sumitg@nvidia.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20251223121307.711773-5-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0293.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::19) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|AS2PR08MB8720:EE_|DU6PEPF00009528:EE_|PAVPR08MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: b679e7df-7400-4429-ef23-08de55186521
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VGE0SkRDZXI4akNndzdqazJ5cHB1eHhqVkp6RGZ5UUgvcEVSUkJhMmVkWTdY?=
 =?utf-8?B?dGpwUG4xU28wSXpsYTZiM2V1ZWJwc1lsRXlJUWFvNHk0NkdhMlRQSVREOHc2?=
 =?utf-8?B?MUZiM3hyOUdrcWFHNmMzMHpnQnpNUkI2dnRSNkV3Rm0zRkUwZ3I0QlJFYjc2?=
 =?utf-8?B?MG5kQm5DVCtab1Uxb3ZSc2xBeXVKZHpOSm5Yd2pCenRnTzZDSUgwSlNXL1ZB?=
 =?utf-8?B?dFM0Yzd6Tk9SM0hIRnE0aE1lZk95bkRxeDcrRVlLL3NxSzJuRmU5K1U4L0tW?=
 =?utf-8?B?Y3k2dXh0eHM4NUFqckk4NDN0VWlVSnFzOFd6Z0p3Nm8wUXlmN3NOMFhoa2xT?=
 =?utf-8?B?czl1ZVY1V3hXNkhaWWF5MldXbU1xRkZoRHJaNnVxdFNCcDJpV0FSdTljN0xY?=
 =?utf-8?B?WUZ1ZjFxMWlKWlVyRUZkNHh2RmtONklQN2xwd01LS2hkQmRjNEloOElHYzlV?=
 =?utf-8?B?ektTUGNMRUJ0TFZPbW1tNkEwWE5LUDMvY2t0cm1mbE04NTVkSk1YNTFiWTRL?=
 =?utf-8?B?dFZrM05WM3hPWEs1ZVAvdkxMa1N5bXpZYWJBcmVJbGpRcG8ycERaTXB5Ulc4?=
 =?utf-8?B?c3haSmEyVm9XZktaelNZcklta0gxU2t1YWtpKzFvRWNXak9RVlhXRk9rWHV4?=
 =?utf-8?B?eWxsbGdEYi9id0dOcFcrSytmdzU3NTg2UW1kUkN1U0pqUmJObkl2MWNMNnF2?=
 =?utf-8?B?a3Vvd3dYN3c2NEhyd3NDMFIzTmdOSEhTZC9CMHVvQktPNnNCQkl4RkY4dFh0?=
 =?utf-8?B?UnJHUzFLR29TcFE1VUVVVGNBNzdkS1dObHA3ZkRrdlN0dXhGdzF4NmFGa01s?=
 =?utf-8?B?Q2wzTTF1MFdNNmJGaDVJbU1OaTFYZFUwWlF3SStkZGFaS0xXRGwyV0R5VnEx?=
 =?utf-8?B?MXN6TXRnNE5lbjlCdGk1ZlBxMEtLYnViSzRkSENJaGlzU2VaVGpQVWI1VThK?=
 =?utf-8?B?ejVlREloZzNPQUFoWSt5QUJkcDkwL0xaelovU3A1Wi9OS0VaWjV4c0NyT0RO?=
 =?utf-8?B?eUdnTUJZaE9tVGUrN2Q0NitsYTdncVVxOXBLcm1tai9SZmN1RG15LzNqNFMz?=
 =?utf-8?B?QlhoV3FkSHRDMGtHa0JzYmJBRFlpR3dub3k0cWwyTWdXeFhwbDVCNlZ5d1J6?=
 =?utf-8?B?U29aZVBkUEdDNUVyY1d4RHBGc3ZMVERIZ2tsZHg2MlZ4S3Bwc24yekQ2TXZ2?=
 =?utf-8?B?NStzMzMxeXhwOFhRQWpGeFErUjJKWUVCK3kxNTk5ZzEvQk5GY1VNWHN0dUh5?=
 =?utf-8?B?d0xzOUx5V1ZOVFY3T2tteDFSTDRybG54U21zTW1sYUk3dXFZZkNwT1J3cjll?=
 =?utf-8?B?YmpRei9NWEY3ckhxaTRKVUdTQmdlNnZJMTREcklFY3Y5czRRK2kxZDI5OENv?=
 =?utf-8?B?dTdoTktSbjhmMDRZUWtGZlVsMWNGakVITERwdTM4b0daYStHajBXRTY1UHNL?=
 =?utf-8?B?TWdYZWxvNG13YURQL3liNndvSkU0ZW96TVQyL0o1bXcxUWRSSytQbXFXRFIv?=
 =?utf-8?B?cHZxeFY5Tys4dU1BL2llWG5UQnFrRks3UVVEUXh1TWxnUi8xMUhOTStVWmtH?=
 =?utf-8?B?VGtzbU1vL0lmeGRVdUZjY3dHcUpmVEhrandGM0VIckNjc2xqOVczZmh1YnMv?=
 =?utf-8?B?dGdHaUZ1SitvZVQva3RDMUozQmNLeHJxQlZFVHlaeU00SDd5MlAzVmNsbnlw?=
 =?utf-8?B?ZVFjNkxDY0hvTFNSdElwL0dxdUpIVUVvWC9MQlYvamI1M0d4OER6M0FsU3ZF?=
 =?utf-8?B?QVVzTlNOOFpLRmhBTDYvUXVWYzFKanBTcm1rV3dXcW0yU04vcHJEeCtHc216?=
 =?utf-8?B?NzBTQUdXNkp5dVdMcHR1WjB5cjBicVBlUGtyVGx1L215WmtTZjZ2dytrSFMv?=
 =?utf-8?B?ZTM1M244ZDZDSU9uSDViRXV6aXpFK04xTEJ0UFVGUC9nTHlneVVrZnE0UG40?=
 =?utf-8?B?RXo5blJSM3lHV1R6azZJOUhFaFZkOTJldDB2VGNTc0h3VWVDWDJ5d1VISzU2?=
 =?utf-8?B?MExjVDcxdmdvTGFyWldVOEhPczFIUEZ4a0hzaEVrT1o5Y3BsSVdyV3pLM0JX?=
 =?utf-8?B?MyttTGNkbmtod3dJSDlDckVxd2xIREQ1YWxoQ0FYZzNndFVsMElmaGFoM0RK?=
 =?utf-8?B?c1pZVy9FY2lGbDdoWGZ1YkVnK0tvMDcxdTNBblh2WmQrdzlvdTljK1RyL0Zp?=
 =?utf-8?Q?KAvRgRqRhcLMAbguZ+WRVzk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8720
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1275ae6f-72f4-4ff8-bfc4-08de55183c63
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|14060799003|7416014|36860700013|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk5QWFVncHZpUXhnRng0M0g4ZDh3b1d6ejg3TnlaLzhyYjY3OWpnbkFIT051?=
 =?utf-8?B?RkM2TW9RYXNIbHdhL2Y1L3gyNW1BbCttd0Nza091dEdibmhrYWRXTnZQbTZr?=
 =?utf-8?B?eXpRdTJ0SngySXlNYW1SN21QSGlnTVRrcXJFNWY5emxncUdxQzQzQjdHY3da?=
 =?utf-8?B?TkhPcmtNcGdzYVBrUFlYTElTQU12UGs4QzdCL1dtV0JnOFRJWkZUNysycWdp?=
 =?utf-8?B?NGhCTlU5cHkvdG9sNGpCcTh5TDZ2NGhaaklsNndQZzUxaUgrd0RpMU1VOU1Z?=
 =?utf-8?B?N0hjdHRjdWtrNFNGNzNSS3FnWmFRY1hUZ1Y5bkZkLzM2NWZsZmp6WEVWWStk?=
 =?utf-8?B?NEdVdlZtVms1eUo4OVRJenpoQW4rSWluc0F4bzJObDZiNDRSU01VekpiejI3?=
 =?utf-8?B?MkdLTUdYWjdqVkFpYWFzMXNVbXdSWG55WXZza0NHMTMxdXg3NW5FTjQrVWQ5?=
 =?utf-8?B?aHl3TWNmNGZSdGozdEp3WnJtSFhKbCtoS0hJTWNzU3I0SXhTYU9qWU96RWRP?=
 =?utf-8?B?ZUZMY0I0VE82cmtxRlpQRE5DNXViZWZpZWlKSUoveEJ5ZjlmSnNJMjFidzNN?=
 =?utf-8?B?bENISkExbnRZSjdiNHJLamkyR0VpYWtNYm1jUGpNZzg3T2pvQ2Vqc21jU2xz?=
 =?utf-8?B?M1RNN0YrbnloNlB1TWFOTDVTZExSb3cwY2xSNXdhUzhrQXd4Q2k2VzE5MGpo?=
 =?utf-8?B?bktPMWZoLzdHa2MwMkltQWdnNE9vZmZMTWkwalcrQi9pY1N6UmJBU2dWQkpz?=
 =?utf-8?B?UkwyNHZhRExwUWl3UXF1MFF6OWFvdHhIbm0xczV6Vm44KzQybXl3SUM5YTBq?=
 =?utf-8?B?MDJJRTBQczhjRlhGbmw5UzlSLzFJQjJEc3RsTW80TFRSdnVzS0JFL3BWV1Nl?=
 =?utf-8?B?N2hCSDFIa0ZFWGJBZFR6QTFqT2gwdFc1R2pBYWl3NFkyU0ZKMDB6aWhrN3M4?=
 =?utf-8?B?ODZXQWhGZDB4SW5QcTIzNXBNaHprcWFyeVFEZnNkK3YrbTd2SkR3djhtTVV3?=
 =?utf-8?B?T09BNTN5d0l1Z2lSMkFLNXZoUHVHREFGc2VkQ210eVA4UURYVzVmVlRrS1Bs?=
 =?utf-8?B?VDNkekJLbVRTQUR4WlI2TUlLK1IxUmlKa1ZxWWlMeWRycWlEYjVjZko4U0NG?=
 =?utf-8?B?cnRRUHphU0M2YTB1NHNRTzRzWU5rakNnZlNDWld4Mm44Sjk3WE1UK3o5U1Q1?=
 =?utf-8?B?bVhWNUdVbXhldmI0MHpOcG52TzBOdldyVEVQNDJaTTQzY2gyUEJiUE9sZENn?=
 =?utf-8?B?OXpQQk43QUFkUnh6cVdUeUdLbHhlaUlTNWdKMDJXNTB4blllRENuTGQ3WDlo?=
 =?utf-8?B?WG1pT0VjejJ1ZHlvTDlKTlhScExjWGtPUlpPUnJ2UldEM0hZRllhaHFxazlp?=
 =?utf-8?B?RkF6akJBNExPMEh2USs3QnBGdFEvUGw2eXhvd1d4bHBYeFNUZEtIWmVmK2Nx?=
 =?utf-8?B?NGhIVDdOZWYxL1lPSTJpQnpGbW9SamZJaG1GMFFmSHRnQlRLTFdPa1dQT2do?=
 =?utf-8?B?azYwRmI2a0tEL2hHYVVjVFNEd2Z1cHdGM053dFdKMTBnczlhMEVwUTZHbDVH?=
 =?utf-8?B?STFLVlRyVENsMld2RWF1b1FsOHVOZitIS1cwTnRFSEwycHBNTXpTYW9JQUgv?=
 =?utf-8?B?VUN5Q2tPNFUyUUVpVmxCUFhXdm1aeWNFeWtFc3hrSFkzN1F1Y3lzMndwQ0Zi?=
 =?utf-8?B?OCtKVlRHVTBWYllZUFQ4YjhlMVFEZUpDQ2RiTFM4UkxmZmg1bEo1WDFKYTZ0?=
 =?utf-8?B?NElBTXRNaUFYM253bmhONWpmQ1B5VkRRenk2WlZKeXhTdDNNMVAxdWp4UjUw?=
 =?utf-8?B?ZWdHUnlWMlhXdVJqR1AyQ1gyU1ZnUmdURTBCUVVIVWVQT3hDc2lyNXNCQm9k?=
 =?utf-8?B?VmRTNmxZMHdtV3Vwd1QvR1RzYUt4VkNiRDFwRElPMUtlOUQvamM5VlJPVWJh?=
 =?utf-8?B?T05BWGcwVlRCenYxWGd6dU9XVWtCdHhnc21oSDNhWFpRajR3dHJjdSt1MEoy?=
 =?utf-8?B?NTMyYUxvbGwwWjgwY1V4dmpZSlZ6SVRMTEJZc2ZsV05Yb3FsRnJPSlBRcWFW?=
 =?utf-8?B?MDBLTHJVMzl0UGRNL3J1TUpDdkllckhwbnB2WE9tV1pDTVNjMlgxOWYwRjlo?=
 =?utf-8?B?aDcxTUxSS3lXZGlFYVRRRG55aHI2RHhLS3htbU14RDQ5NDhvN1c0Q0VFREF5?=
 =?utf-8?B?dmE3YzRSOTJiRHMrMDlyL080RE1ZYW41UnF5YjBNSUdWdWFweE8reC9Jb3Iz?=
 =?utf-8?B?V0dpekY4ZnVGMTZya1RhY1RGQkJncHJYTDl3WGJXVUxKVFZjS1lucHNSMUZT?=
 =?utf-8?Q?0hdgeYly/tgbKJCnT/?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(14060799003)(7416014)(36860700013)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 16:00:39.6359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b679e7df-7400-4429-ef23-08de55186521
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9016


On 12/23/25 13:13, Sumit Gupta wrote:
> Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
> registers when they are in FFH or SystemMemory address space.
>
> This keeps the behavior consistent with PCC case where both registers
> are already updated together, but was missing for FFH/SystemMemory.
>
> Also update EPP constants for better clarity:
> - Add CPPC_EPP_PERFORMANCE_PREF (0x00) for performance preference
> - Add CPPC_EPP_ENERGY_EFFICIENCY_PREF (0xFF) for energy efficiency
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   drivers/acpi/cppc_acpi.c | 35 +++++++++++++++++++++++++++++------
>   include/acpi/cppc_acpi.h |  3 ++-
>   2 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4e89fe6aab5..403ee988a8c6 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1556,6 +1556,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   	struct cpc_register_resource *auto_sel_reg;
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>   	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	bool autosel_ffh_sysmem;
> +	bool epp_ffh_sysmem;
>   	int ret;
>   
>   	if (!cpc_desc) {
> @@ -1566,6 +1568,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>   	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>   
> +	epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
> +		(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
> +	autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
> +		(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
> +
>   	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>   		if (pcc_ss_id < 0) {
>   			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
> @@ -1590,14 +1597,30 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   		/* after writing CPC, transfer the ownership of PCC to platform */
>   		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>   		up_write(&pcc_ss_data->pcc_lock);
> -	} else if (osc_cpc_flexible_adr_space_confirmed &&
> -		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
> -		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +	} else if (osc_cpc_flexible_adr_space_confirmed) {

I had a comment in last version about the 
osc_cpc_flexible_adr_space_confirmed
handling. I don't know if it's still relevant:

https://lore.kernel.org/all/8fb77549-ce33-4c89-959b-57113eb716b6@arm.com/

> +		if (!epp_ffh_sysmem && !autosel_ffh_sysmem) {
> +			ret = -EOPNOTSUPP;
> +		} else {
> +			if (autosel_ffh_sysmem) {
> +				ret = cpc_write(cpu, auto_sel_reg, enable);
> +				if (ret)
> +					return ret;
> +			}
> +
> +			if (epp_ffh_sysmem) {
> +				ret = cpc_write(cpu, epp_set_reg,
> +						perf_ctrls->energy_perf);
> +				if (ret)
> +					return ret;
> +			}
> +		}
>   	} else {
> -		ret = -ENOTSUPP;
> -		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> +		ret = -EOPNOTSUPP;
>   	}
>   
> +	if (ret == -EOPNOTSUPP)
> +		pr_debug("CPU%d: _CPC not in PCC/FFH/SystemMemory\n", cpu);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> @@ -1609,7 +1632,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>    */
>   int cppc_set_epp(int cpu, u64 epp_val)
>   {
> -	if (epp_val > CPPC_ENERGY_PERF_MAX)
> +	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>   		return -EINVAL;
>   
>   	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 12a1dc31bf2a..2860a0252313 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -39,7 +39,8 @@
>   /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>   #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>   
> -#define CPPC_ENERGY_PERF_MAX	(0xFF)
> +#define CPPC_EPP_PERFORMANCE_PREF		0x00
> +#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>   
>   /* Each register has the folowing format. */
>   struct cpc_reg {

