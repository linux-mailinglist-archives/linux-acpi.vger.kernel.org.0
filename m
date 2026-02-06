Return-Path: <linux-acpi+bounces-20880-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNyrM2T7hWmzIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20880-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:32:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44578FEFCD
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E3F1301A3BD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CF3F0760;
	Fri,  6 Feb 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzdrKM5d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72F24BBF0;
	Fri,  6 Feb 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388048; cv=fail; b=qKCZVHHjZTX4szC7kjmiFtLaJOfDXGxOQXsNSP27+MRN0YnFxW3CaSc0ygC+v9BjzKBbYDpNthXa62zl7DtLrm+UkourzlDN5ZtO1wpvcHh5A8qeqJWVoHDud5437N4W7QnXflIF5V4x5h2OekN2TqMBEaHD24H6+GkGQIAB1eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388048; c=relaxed/simple;
	bh=4gqN5Tv8qvRJgQadXdeWj9YyElFbp4AZu42AU1gFtqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7B/6+XIi/zdoqn4fbhgm+O+QIhs/0ssEig7EUZ8B/aprX9YH9NvB/md/ZavPYjkP+0H72Q0pfVQk7QRNXgPFuKR7I7C0gdUoBN5uT4T1xHpph6775KcpmWTvLA4IIgYa5CHUbIxgHXQDEmnwOg92QhrduutZMjbByEm3uJNx2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YzdrKM5d; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgAwvVQOoaX/XeXKOrhmejv9lv0uggUn54BfLSrKAAyOKBrao4VsDMKV1FCNcyeMYdN3XeQ3dnsUGsvARswG72HXX/zxQzasLEVMpd8O0kim00eg4I7liqobRgtz25YoMjLnKz0C49hWj5kkCGdNxBG2B8b9PjpKrUi2sjDBdCdYjg8nFFPgPGdgMzjqg5kHRBYcfMXPzJnfZHIcCP5tN9eV6dWsF/QxxPBqVF7EqRxgcJHrI0TENPNBAS7sWDBmraxCYdArRp8nLcdWG7hkVjio5IgkourtzkePFqZd+rnhHGOZjMT/3NyUqgAZ+tJGSk5OvGfQjYUZNdcBArKyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDgMDfC+NSfOjEdR2ggxm/nQ4zb3fNIvP5K1cXPjOdA=;
 b=IU9C5oBX120mrXzA8pytM8rnl92xWPmwF9S5HtZuUexwUmrq0AJvyFAVb2DheJw/y23v4iv8ziY9oPZnYHptBl8VefRzTRDqyvkv6Bah1+zRkafkY8G+UdBYNbqiRrMGa+8XVQIbkr59Gp36zmcnZkgEfthP/NV552Jk1gcTHMYE1GyGpJfBvpBTA2Y2ZD8L7AC/yEicURsq5mIdjag7MoRY1LYFXpI3SZy8c3CUiisXCM4UBHwgS6UXUpXhv+CDx5EDsA3Qk4bLl0DFAidpynYtSN7Zwe+Aef/Myy6xVSAVPOa4HT1hR17mHrqn0ALuTAL3rVk3t3HqWnhhaCOHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDgMDfC+NSfOjEdR2ggxm/nQ4zb3fNIvP5K1cXPjOdA=;
 b=YzdrKM5d6x+Z7yCzsnuYWQEnv1NDWHZpIZvxPPwrBmdGQAsF3RXl+NMSvISBNepy7ZXbwqEXUmkUSl4lWDWL04z3ckLQJeSWPD2BQ5PDjzfOvoCL25hTuI3jKsXZm++EcyKe+/K3RPz2wb18xMTtmP8vLf12XV2MkvLs6MkaxdQpPIzh7KI4lTQcliTJD/QoDTTT+nu2jaqhyDqdkdm4bIExBI7yVMk4y86wcPWV0vgiv8LOe2Dtq4qKpVDQ1l+ILnPzsj3UuPjLh931jw4h0FOvT5+psjFRSWa8Y6ooJ46w/yqVIuZvVBGChlHjmSeukdNrtVloPmETIxF7jmYarg==
Received: from BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14)
 by CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:27:20 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::35) by BYAPR07CA0037.outlook.office365.com
 (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 14:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:27:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:27:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:27:08 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:27:01 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <yumpusamongus@gmail.com>,
	<dedekind1@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v8 0/7] Enhanced autonomous selection and improvements
Date: Fri, 6 Feb 2026 19:56:51 +0530
Message-ID: <20260206142658.72583-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a1b340-875a-4760-d4f1-08de658bd5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLA4gxEpX47TRWLMwGlHfht3UmtUTFz0wngwQRkBrDo1E1MA/8BL5IqPEQKP?=
 =?us-ascii?Q?CCBQOAE3I0P05DgJWbS9wB0zI4xraGOEfl0oxjVNedORq8ZsgCjeNxHkPg76?=
 =?us-ascii?Q?XtEauC0fdVFWNjR4uCdlpTfCUGT8O4kMX12bt8aHAZaP2aiJs64pcsOJbEsu?=
 =?us-ascii?Q?wyJaGuqTbuGO0F07nkUevrKy1SZT3XeKyAoMdaXoXNfgRLgNP/a2aZy6VbO2?=
 =?us-ascii?Q?iWoCMR10KHro1QqlAtnQ3fKZHuC5TETUuI+h6l4Dzr7X8A9MkWISfYOtAi8P?=
 =?us-ascii?Q?j6GpGHw3oouc+ht79ib4YWz6rhEG0Fn+w0L8zQU5sN0UO0g0untCLxiyLVYk?=
 =?us-ascii?Q?FB2YQyPp0++l9/6ryFw5q8qFcszqpUX2Cax4OzMRDdlKQc61t4ZVQnAWmYJS?=
 =?us-ascii?Q?oryuL951MZVQJFnuTo3Zs+XDQzHUUeJy2txzs0vH0H/1vvuwkOfzBEPEvX5Y?=
 =?us-ascii?Q?nPVnMSFcNi1/spSBHFPpCe78Ng14BFX34m007QNPM+5ynHj/6rkvPI9/sttV?=
 =?us-ascii?Q?NI5szSHe0z9BpRgegFrkmpiMqhGCXd9+Rh9j1ZPF4sguvzthZLWRkYQMuqG2?=
 =?us-ascii?Q?WYJ6UezVJXfdlfcye0SaTfFssGp4oMavd2ox1+qU53eK4GXV/ZR6+ZzMd997?=
 =?us-ascii?Q?FGQNxU8gHcQfWJcHTP1BfJ7oMxzebAqpgjIq0Mfkuts8JI0oMFWy/EpgIMqh?=
 =?us-ascii?Q?0q1YTjAttxF/ac90+ybdt5R5X2zys72D3NwS7P7Ip/faKSIJeOeRZ/9n/CJw?=
 =?us-ascii?Q?JIEr9Cr89P+j2f++QG2ACYU4+17x77zGrpzfvPbm6eWJq4auCnf5Aa7wXx2k?=
 =?us-ascii?Q?+pKnkLXjp1ue5qOzM+qzvQ7BUomijj2kzEJVCn9jKgIc6KsEJs4n5XShJj7e?=
 =?us-ascii?Q?MHiaJJDf71h9yNGXK/lASzkohfoUOopoq9WHE+VBezL7vUkXNrRjTr1FWer9?=
 =?us-ascii?Q?iZzxT1XANdhLrJqgPiaO4GDnnL9yIFQSDakZz4Vf+DhT2Gc5vbgK/yHFz6Qt?=
 =?us-ascii?Q?i61SdldOixAZDYDXyCiFW/0KggcNFyCPftK3AQbfS4SmznrKxKuXWC1Rb5y7?=
 =?us-ascii?Q?qPhbVxjXFfiJI2qnVkGTyKcTUQs9dV8co8QwWdY+dcsnvynuJHMsx/QRifvR?=
 =?us-ascii?Q?AkvTXLLQiVyRL5ogsgTf20sVY4L9x3WNlzAbCPsW1esRB3ib5t5L5xQrMfS9?=
 =?us-ascii?Q?qJSrvV/BGyncFV7ebgUThyy2RA2/0gM55hlYPSAMOHTv+4sVBc9tmvV2Kkmi?=
 =?us-ascii?Q?hRc/+k3P0zx8ngB6Hm7iHLMBPVWrzsr3DZijNf/HDN5Fhbg8rpm+1mGr67bV?=
 =?us-ascii?Q?BHdpkidAfM8vRgCi6rU3c2NS19/ThvhNomfBdb2EFBpl3cIdIX7DCcEajOVO?=
 =?us-ascii?Q?6OFSLC6WFxgUbqtyeEZA9wVPIZp/o/rJ+ngcJzRYKe0+RnjLTxt9lvW4jW1H?=
 =?us-ascii?Q?+xlPSGdmVWbKnCrYsPhnKMLifMaKOZcRiRhiFeVZTVAvVoChGc9PZG8ivJGw?=
 =?us-ascii?Q?oqv8tnTze8/sn0EaU3Q60WECvKFflWFWatmWIqthfuFZ8sSgttdKrBDapGPs?=
 =?us-ascii?Q?FxVbHk0ubFC0GtIxyQWMoYBA9kcdI2UHj/bcG7532GiK5599y9+46kGb+JF9?=
 =?us-ascii?Q?nrPqRTAxhrmY7BraKXymnymU261VUACEK9WwQV3BiJckXyZVbX0n5Hmzv+i+?=
 =?us-ascii?Q?JEhdfti5/QqXEvboJTLnzeCeebw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BdqCfyUzYITJQ+O8Wv1etgHY1GHgVJpsEk/s3zVe9gcbKWga0Yk4IDecbSJtNDmYao2jUV/kJL16sQ85xeP7CJ3Ni2fYsbdxLPqHI52wudbPOP0K7L/dzMMKni58BdYimU2LQyK24/zb0179L+4ok3JkWzQiCyaI73Ccg9LxlnZMM3S/9LGON7/9Cbw51Abcq8e6RmaTZo4u+2ureuKB0NoIEo4id9JxlXUC/PAiPqqq/Q9I+F3Ho6Rvc64ceKTe3zb6XoLhz4nY/n/MH9UAXXjZBwSUfI0dr0HbN/3usxKfQFkWCu6f5f5ZW+NnEU2khkOLMScUcKo0BNxMveAoObgIzVbh5hd67DokbBRhrN6Ri90/qAsYkKVRNrHuiIvxsd3POmAb/MdzrO0p7MwKQRrDmhEm/K3wHYS4+iKvQNLwXPgA3wmXz/Tg/6VnWEuH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:27:19.6091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a1b340-875a-4760-d4f1-08de658bd5ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20880-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 44578FEFCD
X-Rspamd-Action: no action

This patch series improves the CPPC cpufreq driver with new ACPI APIs
and enhancements for Autonomous Selection (auto_select).

CPPC auto_select enables hardware-driven CPU performance scaling using
Energy Performance Preference (EPP) hints. Currently, there's limited
runtime control and visibility into CPPC performance registers.

The series adds cppc_get_perf() API to read performance controls, updates
MIN_PERF/MAX_PERF in target callbacks using existing scaling_min/max_freq
interface similar to intel_cpufreq HWP handling, and exposes perf_limited
register via sysfs to detect throttling events.

The patches are grouped as below:
- Patch 1: Add cppc_get_perf() API (independent).
- Patch 2: Warn on missing mandatory DESIRED_PERF (independent).
- Patch 3: Extend cppc_set_epp_perf for FFH/SystemMemory (independent).
- Patch 4: Update cached perf_ctrls on sysfs write (independent).
- Patch 5: Update MIN_PERF/MAX_PERF in target callbacks (depends on 4).
- Patch 6-7: APIs, sysfs and doc for perf_limited (independent).

---
v7[7] -> v8:
- patch 4 (v7): Dropped min/max_perf sysfs patch.
- patch 5 (v8): New patch to update MIN/MAX_PERF in target callbacks
  using scaling_min/max_freq interface similar to intel_cpufreq.
- patch 1-4, 6-7 (v8): Added Reviewed-by from Pierre and Lifeng on v7.

Sumit Gupta (7):
  ACPI: CPPC: Add cppc_get_perf() API to read performance controls
  ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
  ACPI: CPPC: Extend cppc_set_epp_perf() for FFH/SystemMemory
  cpufreq: CPPC: Update cached perf_ctrls on sysfs write
  cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks
  ACPI: CPPC: add APIs and sysfs interface for perf_limited
  cpufreq: CPPC: Add sysfs documentation for perf_limited

 .../ABI/testing/sysfs-devices-system-cpu      |  18 ++
 drivers/acpi/cppc_acpi.c                      | 170 +++++++++++++++++-
 drivers/cpufreq/cppc_cpufreq.c                |  83 ++++++++-
 include/acpi/cppc_acpi.h                      |  20 +++
 4 files changed, 285 insertions(+), 6 deletions(-)

[1] https://lore.kernel.org/lkml/20250211103737.447704-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20250823200121.1320197-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20251001150104.1275188-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20251105113844.4086250-1-sumitg@nvidia.com/
[5] https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
[6] https://lore.kernel.org/lkml/20260120145623.2959636-1-sumitg@nvidia.com/
[7] https://lore.kernel.org/lkml/20260129104817.3752340-1-sumitg@nvidia.com/

-- 
2.34.1


