Return-Path: <linux-acpi+bounces-20467-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJaNBAeyb2nMKgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20467-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:49:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3647EEC
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D79AA647
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4F4779A8;
	Tue, 20 Jan 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KZX5M2or"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F64611FB;
	Tue, 20 Jan 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921135; cv=fail; b=rXA6c66W3AlOCqft2nKZ0AAsrZQNVSZLhpLR6CdTOLv+XWIg1ZRtGA3Zi1C2TGXsH38cAAu1w11pBAGqRhDA2aJifLlq3waqtNXjUKfLPsPHWI8DI/mxqVJhNCEebwBAtzRN8t4hy0Jf3BB2ZCm4t3Uqlha+abv/4FhdUSvsG8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921135; c=relaxed/simple;
	bh=L3qNnAx0khWE0Luo1h1QezbkUCfzTsHk5iYSJTIEeFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtyoGo+CadviFVZM2RaDg/C0BPL9i0Zz4+pPgu0vBlQrU9j5wzVgnQNEHee/+YYmYpemMZvjYhU2LEhW7adbfegSshih8oA4eTPrU4XgiLTUY5N1pO7+vpq15+0vZvWeb15lZOo2Srgm9Yb7sdIiQqLperev2KqJbSmrIW1ldfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KZX5M2or; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmuFP2608omtBYW2q14AvVrLSt4GFctLQrcqiEYDZ1paGaTZHeCho2YNEnYtsnzXLa/DhIymeo74LE5W45HtqSbvYTVh+HRcmSicnqCSkoMVj7rhab+SC20pH5Zn1je65XSVIMr8AddUcH015pnAp7N615xOy+oAyt8oBYBAR9ytEdEW9uFh8V3cCX5KoULNlVuT1tjRgKLTPs+hb7lYvb0L/pO8QTB2z8D+vtHb8VCxyM8dEe1EngK8fqbiXcUN91FdjldfgdGMKmZ11kt2XYcN8y4QxmYisX0tr4RSX9dMtV4pVkgOOhDvRzsW6/+D7bGb4/hhP1MJ/Hw9IHuQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxrUtn2EnaNj7axE4JGgKF1vyBqfKeDIrgnErzXOufQ=;
 b=ME+3dr9NlcPZ3pc03wFy7VPhx47Y5C4mCRkYgjfGl+RQ0HRImfE7kyu1+Q+q7kQ7e0N3d4Z3ReCr3QtTXMLk/103oy0Ut/sXMtbi1xCG5xW8MNB/eCSMq7Ws4z/d9ssrXFTZTvl6JR8tmkf03IIGpeYRUToE20wf62N5QVNlhK5AfK0OwI3QeMOmhJKOw4SQvUSAbDWWD0RFhfq+QGxeOUarXZRVCbp9K0YsJ+vpnxmiAx6lcMgXqN9Lxpi6RNRsC7Cbn9+OUXLWrvortQuY3nJO90CBMVWePXsIEGIKSsKmKW7T7t+lHqA0hC5OTpmQAkob54o0+Gt7y3mNLnaNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxrUtn2EnaNj7axE4JGgKF1vyBqfKeDIrgnErzXOufQ=;
 b=KZX5M2orD/R/giPaNIHTRBZJPQhJQUHQfHqlAjPw2Sec1sFkZ/h7BvoqFIuZAWDkCT/rU4EyyRQHEY9wMp99FLvBD2+PJuL5WK4EC0Cu2unxtzlsQNydUu1qMCskK/vqmaoV3OyjISoEiyMxxUBh7KvxhpaNhtA1iJchV4u/DDcH4d6ZqfCFQIug5H1NQV6PljQGxq6xMRou3ELedib9fsA0yDiUfv8aV814GuKjCwX0fOF+Wm1EZkn6ViSY5now1WZ4HAlPMjpAae7p7fKCsOFZxWifxstUDjyg6SXY1XOEHlvM0R0bYSb7kvIFbzMzRrd5O+7StzpK7f9XcZzQYQ==
Received: from DM6PR01CA0001.prod.exchangelabs.com (2603:10b6:5:296::6) by
 IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 14:58:44 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::51) by DM6PR01CA0001.outlook.office365.com
 (2603:10b6:5:296::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:58:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:58:15 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:58:14 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:58:07 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v6 8/9] cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
Date: Tue, 20 Jan 2026 20:26:22 +0530
Message-ID: <20260120145623.2959636-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120145623.2959636-1-sumitg@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc32a74-ae09-4741-4d20-08de58346647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pe02abpUSOj++kgFGmTKnaSWRMp0cTDECJq7jSmxppMa4lZNA64HLbnA6ESG?=
 =?us-ascii?Q?ak+NmMJplJY5N9NR0juVeDqsXQNIkqF5nhUT7HSVr1PhmTsWUIuZXxTahpZa?=
 =?us-ascii?Q?FCYhJJ92CzUXjBOOcWGaJYAK/JgRIw0aC9DEag9lJaBz9DTB2cFj/URvsDol?=
 =?us-ascii?Q?H0v+xUsZAwyPub6dnTPHxuJthoc0oeIvra7oA88df2ry1dGxXRke0sUZj1Cz?=
 =?us-ascii?Q?+NafhdqubyTyYEaltYYI0rtIfr35YShd1SN/0rx/CCnfx5XpPSEEO73wrrCY?=
 =?us-ascii?Q?sUzvrVePuEEB/lwq9vm6g5oZsGjl2TBSSOfO8Gj4AFXCcoNVKbYhNPXAodLh?=
 =?us-ascii?Q?rLXPiDWBOVvu/ErpU4WXQuumiyFJqaAQapRfll4UHvfgUUq0HL//OIHnrP4y?=
 =?us-ascii?Q?Bk0JAyKXRZtbANCreWKSZCBG9xwd7/X0C0E1wmYnvmyb491ZzPipyRko2rr0?=
 =?us-ascii?Q?PxioPdIK804kinGOlNfllzPnrfQS6u2iL/tJxIsjFtOAs98i9gsmbVIGpvDD?=
 =?us-ascii?Q?ROUvR+AlRtsLUU5kyLlDLCWQI0SEiu63NSA+DwJDDY8leTBEouDKGexZLu2K?=
 =?us-ascii?Q?GpW3naAZ98iyxsY3wmfANCl5NR6+1+lrAyvtW89rXo7criNBmSirDwws0PBC?=
 =?us-ascii?Q?h9CVrJmRPHUhQgU5Si0vUe4vZ2rgktiM/Rwbfa8RX2iyBuR2lq/swXWIxZlf?=
 =?us-ascii?Q?3l1aHNxNbqswJqsH01jeBEgqsVlf9xNP/JReMLdeGFcsEqEun03UqftzfG27?=
 =?us-ascii?Q?ZT9ke5pEVpZ4+Lto/aIn04gWJoJqCDghCWO7cTiqucFbQBHtd4eHjVzyTAr/?=
 =?us-ascii?Q?hXT9xL9mfIOq2UfVe1zmuMJ1Npf5SarWKEg+kX0wRUhczGhb6ayMn5dGh9VI?=
 =?us-ascii?Q?RPfXGhjyG3dXshjdCacGTN5zMNquHzdIJNtXenktgu/2xTb6FtFtghOCogpK?=
 =?us-ascii?Q?FNJkpV+j/O+UKjdpXEzAfBSBjvDf6tCYim0NnBzYuo2569EdcvV8zuCPORun?=
 =?us-ascii?Q?F5QtrLhJrzhtpzN30HsJyw26FHm2aWiZFJ15l6hQQ+3hDqnSmVb9g4Z2MWnX?=
 =?us-ascii?Q?/MfuDIvyVdqSKhsEHXfzClbZCM5pAgfi8Gnabc3JLyrRHddzJJbkOVAB5/0O?=
 =?us-ascii?Q?w+J5ckect5wY7nNfx/FzVYuUxoDE8u47xY14lSj/mo+94nQpzWqXDXnPoyce?=
 =?us-ascii?Q?b6qWohV2C7Oew0Iqo1wR5X0PH5xHvRMIg+RcivY/InL53DDO5VrntWmS+N+W?=
 =?us-ascii?Q?jetlN4gFlK0WzHQkc9ftPVTNXrjzGs+pSL/wBpMGjWSn5TWC2C8gT5kD7VwI?=
 =?us-ascii?Q?TzwbYY3S88Ytzo8oqgAYMZcQg19YSOTl1nkX0jtmGCrMU2Ode4Q5md1xqfeM?=
 =?us-ascii?Q?yySGALhZ/W+HEeJnVb7kBuglWOloquapFjzuhldGeT52Ps4POYSU3bsewDAZ?=
 =?us-ascii?Q?/9ZHJfHJDfnKJBqiErqwSzqSWZF3iV7MgiEHjbdhRXUrlmEbJKh9RZCEn50U?=
 =?us-ascii?Q?rhpyrtQwyr1HKaOdUvfhiWfgzQok/x66AgMHrYjGfv6xXRxwxRn+olAqLJ1P?=
 =?us-ascii?Q?VouYdliW9zi7jl56EZ2yVQjK4v9/jDJbSFresx+e5QpQFMIS2jhQgyFwLStx?=
 =?us-ascii?Q?Nq+xzbWUBLlEzZTRhK4V0gIwXCsksFGq1BvAj6z+1SQcezobqKSF6MmeETVv?=
 =?us-ascii?Q?551d2fJIcl2p+3oOgTJIDdxcPSo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:58:40.9369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc32a74-ae09-4741-4d20-08de58346647
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20467-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,infradead.org:email];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6FE3647EEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add sysfs interfaces for Minimum Performance, Maximum Performance
and Performance Limited Register in the cppc_cpufreq driver.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 3a05604c21bf..0b0c07c074bf 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -327,6 +327,50 @@ Description:	Energy performance preference
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Minimum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file sets the minimum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must be in the range
+		[cpuinfo_min_freq, cpuinfo_max_freq], inclusive.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Maximum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file sets the maximum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must be in the range
+		[cpuinfo_min_freq, cpuinfo_max_freq], inclusive.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Performance Limited
+
+		Read to check if platform throttling (thermal/power/current
+		limits) caused delivered performance to fall below the
+		requested level. A non-zero value indicates throttling occurred.
+
+		Write the bitmask of bits to clear:
+
+		  - 0x1 = clear bit 0 (desired performance excursion)
+		  - 0x2 = clear bit 1 (minimum performance excursion)
+		  - 0x3 = clear both bits
+
+		The platform sets these bits; OSPM can only clear them.
+
+		This file is only present if the cppc-cpufreq driver is in use.
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
-- 
2.34.1


