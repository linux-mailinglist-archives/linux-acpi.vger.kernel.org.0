Return-Path: <linux-acpi+bounces-20881-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLmwJpX7hWmzIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20881-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:32:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA14FEFDD
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E2F83037D7B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917C3F23CE;
	Fri,  6 Feb 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E+9xv8xq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738773F0757;
	Fri,  6 Feb 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388068; cv=fail; b=Bin8J/HCD7P+fmTydtVs3LAFMrBFnZUAgntJqFXSvMARFh8bdwzRiDKfcgxhdajX5uTxjue8WcAvx9PX1vAKMR6PwDy6jQq5qKSpr2lH5dhvvyOy1bFFZQOisAVTUZdGrL2F1QrhAcv8IgpDPbK8SNOgA2MCA1L3yZ0NZVSOzkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388068; c=relaxed/simple;
	bh=+HbxtJ8FJF93nrXG5gd8seN0weghGpI0E3r17hD/PCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmyz315DtuHAp2kwEGZ34cFENcdU4ND3w6QE1xx71EnQBFsM8J3/g0sJErM9MR1pR/JIePSVRjFMXWhckBmogC63SUWSmSnrrsjw5BrpMQlouvbxAA7VrWgrS/KvORyM4KJM0tObuyv9E/hMHCNBL+xCFbzAd2jiQUHq5cm+mX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E+9xv8xq; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj0FqQRoEjWJWK4U/2x32i2hTRtnb9uxO11HEPkTLU4uL+ai5KevoBPYtpiMvFVwpsQ95ukjX/UUXRVz//XOche/AZK94nhi5bNQDR9e8GWdmZgZqyHyDEy+9MiGcmRLSaJZ3otrfoygITzTOozVnuRLIhmMbRgnW8mUUj9jCjMw/GIuInnfZyE8CTNA8+4z9dwxjF83WwD5zMFWFNbcM+1ocMofGrvXHlAc8v0w9PGbglxAJAl9rybXkCiOSuRRepWnRoG4A+XopxdDVK9S95sPCHq7zgpfozS0W6qX40UmAF0EwC3rM+UZUT6g9CYIL754RN1SOmYaDlfUyS6Zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOefzsU/Xy+mNObGW6ynsEX0NU8wbv5wziO3qSG0ABw=;
 b=T4g/aa0Vv9XGsscTFxs7Zw1tSiicG7t7UKl3Q8AWXGWeDOkH/xple+8j0/5J9JWjg1b/whxWhoqAP2UZR9SIUpEJx5YqkOCH9RADOlHuoKFom+pX7JfWNlxTeneYj5rINP3XoHBNq05+SYoMmxGjPA8E0Ba+/wKxG1GVoiZH7juZd3jKgtZBWqe4PNS8o8+6phutSkC3xhoyhsj4TQFx5qfKeY127LZEFfG4ci2l8+/usaIuij3x9g3sNwF0NeLzi3wV7bzczNp/WrwO/2/QNoq6kOs7OJmtc3b/oZrt0ix3zHpn/0k+4TqPGEePgRcdVHI53oDYqkUqkln0A0+OZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOefzsU/Xy+mNObGW6ynsEX0NU8wbv5wziO3qSG0ABw=;
 b=E+9xv8xqBF3LKl5rP3/IgSZTMzn7aypRaKrOPUwLJtF5YUB5NnMcd9Bvk5D6Dm90/8EgwtpQRE1TjBst3ibLpkdRLSeNRvBIwMKqqF5xr4ZJFFvUQJtE42Qwo+N7tNVVDjCCoQd49VMFWTC930kPDy2H98873tdQpIdQeXOK1pNVOvrwoXNOWaIyKTqxtugU/CRBamg0QsMSiRCfUwoM60DTCP7x88ouh100r2hbiqjqzMJ8fN+uM7WOevqD828sQP5l2NTVKEkvVXLQcG8TKBg15oONYVug7FkjZyceHoOweM46xRW5+jq+ZaT6pgnf+2S4MjljmD31fr2NYPV6kQ==
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:27:39 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d8) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:27:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:27:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:27:25 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:27:18 -0800
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
Subject: [PATCH v8 1/7] ACPI: CPPC: Add cppc_get_perf() API to read performance controls
Date: Fri, 6 Feb 2026 19:56:52 +0530
Message-ID: <20260206142658.72583-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206142658.72583-1-sumitg@nvidia.com>
References: <20260206142658.72583-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 21733dae-c3fc-4352-8752-08de658be14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4o9rtQzT7WJJpA9fqPOvPlwW/5qVjX7AFytsiJt9J5pAFh8xVJ14TZRCHn7+?=
 =?us-ascii?Q?C1ZhLw4BRlztZpGw3sCN9MWWqgfzBQOQpfpokKotQ8A3KDgCxmHIeZZnBc6Y?=
 =?us-ascii?Q?Ups+ypN0SFM/4HBD2evUHJDJXLK3RtcnWmS3gM/D+uiIMC1Wi+ARAtIwKXHv?=
 =?us-ascii?Q?lmO8R7Uciye5YSvQb32TFT1G8HQWhTb6bXHF8ApKzTBNCSpKqACQvanjOajy?=
 =?us-ascii?Q?WE4pE7p7pS0kuo2IWiJvan86DWwmJWRozuQSCENa3h7hPeajzxcze8CfxzAQ?=
 =?us-ascii?Q?1U7+e68aDj3r9sMuVg47UEH4Gug86Pq1Eun1KlIVB6OCe4kmRNIX8ZPZcWKE?=
 =?us-ascii?Q?tbJwgST/eKTR0ZjZrnPfr29UWSMqkydxf8fJxEaXfppv42JyWO8KEovuOKXn?=
 =?us-ascii?Q?bReVs320DAcmveFHY82wm/7HvJd+YdrNOEfuqW3Vf1pkjQ7IJD+GEz+YsJ6N?=
 =?us-ascii?Q?IaEJz5A0ytK2Hh9hxwgzTOQhz6nOGyuh2EbpFBwy+zgW5Km0TTgtUa6zC9zB?=
 =?us-ascii?Q?CAD8VDROpKwNKCaCFN6XvvL+G2VBFY+yaQDgrk0EGWNSXfa46VO7Ywq7LrWB?=
 =?us-ascii?Q?ohK1kpS1jb6dHa8ZwKtKF1ED9fajIYmFCSwdfSfwVWNMoqigouWk/e/icD51?=
 =?us-ascii?Q?pJeRIL4JtUcIPRhJ1vKklsyJBVdxOehjFACYI3bbGk/iKzi/lwWTnnNrGTPB?=
 =?us-ascii?Q?1p5F8GyPmEYG047Wt+jXPdVZ05TweUYpr1I/nO1j2AXNIWpTMZpVsV1h5hju?=
 =?us-ascii?Q?k6E00uQ6lx/mHbv6ilV9mDOLImrWns0WEvT7cD6ULx6wi4WABumprlhNlprw?=
 =?us-ascii?Q?1vBh+ISgL/CXxq3BhUOVthsC3IcEjWPg+nkudu3sPKmW/gnIqZXa5HUc3vvC?=
 =?us-ascii?Q?TSeQyUJauQ88VJlSqP6EWB7A83i5q63NAHdBciuF4xrqvFx1QxdUP6s4GGcz?=
 =?us-ascii?Q?dB9Y3hrYRjReKp0VOvNeHnMQQjN9hKDfDvHFlXz+CsyKm+jEsLrje1gDJXRL?=
 =?us-ascii?Q?ejGsPA+1bgYFixjR0pmudpY7ZzlWq7VeCZwzL88ZHrIUCNZ05feuIB3IJbAH?=
 =?us-ascii?Q?g+K78eQFg+kbgST4Z11gXfMYOGCWQ32iY393+1ql+toZaQ16cRMG+e9ouLlE?=
 =?us-ascii?Q?aqGVFfxqzS6xhPSC6xxHyhoOWLkNuxp/9xQy+L6IP0bgKcED8JkrhlUP7if9?=
 =?us-ascii?Q?ntCuV/oC3lovUPdkLR7MOnuZTRLE2FROKHpLPBi2X+vnL09QYEIfsSg3knBV?=
 =?us-ascii?Q?d1NouwvFaZzwiAQsVGj8wFjpUCE0qodSfq/RpH5R9IUWxksJA41KoLwIUfz3?=
 =?us-ascii?Q?s+3KTKVRHmbcPhN7NNRIL3w8DsNVvudlBP0oppsbeYZ3JOAc9OQLIrvT3Ykt?=
 =?us-ascii?Q?Q96MgnFVh+cuCp8yazf9T0Wxv7+V78b2hqzTqyxDaCcFuJeneb9ERC7AMBOq?=
 =?us-ascii?Q?ZD16H14jzDh0E8ojjlaqqAJAtiMPr6wjD0hG1LZv9+mqK5bI/JiD2FQ+2H7/?=
 =?us-ascii?Q?nTrN/+J7UShFIZkqFSJKJ15ZAcI2HHnEunHrPt+AU3rHjp+XdQ49KuXQ5IX5?=
 =?us-ascii?Q?b7ddwSPVOYb4nucUnbQcOiPkGb5j6osEoKr3XqOww3KW5LRl3BBKtgsDyXN3?=
 =?us-ascii?Q?CAmy88I/E/ZalA18INYhcq/26e5VXVBcLZS6+Rvh6aCtXJzSu3457nuzgMGS?=
 =?us-ascii?Q?TajAuRAVIRHctxKNC6NQEM9yvVY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g5O+gBqZdMWs5Ui5ONclhwYOxmUepwj06Xs5fNdoVTGzHwOxS2BTxe3jV/cBdnWkIHEEFXTN23uJSiM7yW2RXxBu4wtIi8PtTI1F9DNkNhYAFwKrM8uKDQzcwtr1GZtgGasmjDgeSGr2StLGeHFuERIA8qms6ACa2ipjyIKdg+uIT114c54/G9mrNqOxlvmDpZO+cWVdqG5d1/Y2LpPGtX12CtpydP/9efF3bzUXv9x+1ofuouO5AB6nNR5e5LNDFcY8Xr0lF1uwsFUiwVtfWSpaSQuDSWAUd8urfrbX4zJzepomuKobIAky81LzbkI0eCOW1Mt1jVVGIi5U2AZg518N3d8nhNbB20N53r0FPoaoattC1OlE/XOPJ8d+oIRE469aNlVBVg+aBUGhCmE9HgshaJMBRN2Sfr1bj6zE72XkNwaRHPQF7WtSRywqVSYi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:27:38.7106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21733dae-c3fc-4352-8752-08de658be14d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20881-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EDA14FEFDD
X-Rspamd-Action: no action

Add cppc_get_perf() function to read values of performance control
registers including desired_perf, min_perf, max_perf, energy_perf,
and auto_sel.

This provides a read interface to complement the existing
cppc_set_perf() write interface for performance control registers.

Note that auto_sel is read by cppc_get_perf() but not written by
cppc_set_perf() to avoid unintended mode changes during performance
updates. It can be updated with existing dedicated cppc_set_auto_sel()
API.

Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
perf_ctrls with current hardware register values during cpufreq
policy initialization.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c       | 80 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  6 +++
 include/acpi/cppc_acpi.h       |  5 +++
 3 files changed, 91 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a09bdabaa804..de35aeb07833 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
 
+/**
+ * cppc_get_perf - Get a CPU's performance controls.
+ * @cpu: CPU for which to get performance controls.
+ * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ *
+ * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
+ */
+int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_perf_reg,
+				     *min_perf_reg, *max_perf_reg,
+				     *energy_perf_reg, *auto_sel_reg;
+	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret = 0, regs_in_pcc = 0;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	if (!perf_ctrls) {
+		pr_debug("Invalid perf_ctrls pointer\n");
+		return -EINVAL;
+	}
+
+	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
+	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
+	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
+	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+
+	/* Are any of the regs PCC ?*/
+	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
+	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
+	    CPC_IN_PCC(auto_sel_reg)) {
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
+			return -ENODEV;
+		}
+		pcc_ss_data = pcc_data[pcc_ss_id];
+		regs_in_pcc = 1;
+		down_write(&pcc_ss_data->pcc_lock);
+		/* Ring doorbell once to update PCC subspace */
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
+			ret = -EIO;
+			goto out_err;
+		}
+	}
+
+	/* Read optional elements if present */
+	if (CPC_SUPPORTED(max_perf_reg))
+		cpc_read(cpu, max_perf_reg, &max);
+	perf_ctrls->max_perf = max;
+
+	if (CPC_SUPPORTED(min_perf_reg))
+		cpc_read(cpu, min_perf_reg, &min);
+	perf_ctrls->min_perf = min;
+
+	if (CPC_SUPPORTED(desired_perf_reg))
+		cpc_read(cpu, desired_perf_reg, &desired_perf);
+	perf_ctrls->desired_perf = desired_perf;
+
+	if (CPC_SUPPORTED(energy_perf_reg))
+		cpc_read(cpu, energy_perf_reg, &energy_perf);
+	perf_ctrls->energy_perf = energy_perf;
+
+	if (CPC_SUPPORTED(auto_sel_reg))
+		cpc_read(cpu, auto_sel_reg, &auto_sel);
+	perf_ctrls->auto_sel = (bool)auto_sel;
+
+out_err:
+	if (regs_in_pcc)
+		up_write(&pcc_ss_data->pcc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf);
+
 /**
  * cppc_set_perf - Set a CPU's performance controls.
  * @cpu: CPU for which to set performance controls.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e8042efedd1..1421f30e87e4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -594,6 +594,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
+	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret) {
+		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
+
 	return cpu_data;
 
 free_mask:
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4d644f03098e..3fc796c0d902 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -151,6 +151,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
 extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
+extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
@@ -193,6 +194,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1


