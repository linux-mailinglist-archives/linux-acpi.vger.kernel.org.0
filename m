Return-Path: <linux-acpi+bounces-20759-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLoGM4U7e2mNCgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20759-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:50:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A824AF234
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28B74301DB88
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ADA3859E5;
	Thu, 29 Jan 2026 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cS0B/J0+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFB385500;
	Thu, 29 Jan 2026 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683773; cv=fail; b=Z3MGJXV49/iRXuW/hVfsr0A1HUNZYWKYGE84mjEJ9V1DOGjgVlB7i05zvBccCduIxPhFem4+CF+cQh9j7DHmZd+rWxwtl32Jk0khu1XZjYM5HrHhk+Zt/SdF7cstWer7VzZyoZTIpUuePCFTgM0VOrg75OlK2Yyf3RSfRkLwR1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683773; c=relaxed/simple;
	bh=K7awrlmxuGQ8GDMedZVSfk5PqfwrBf2PrF8zmpFVtaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssyn3Hy7okorHaQqZTxwovxTd4qE3/GnCAEpaTwVb3twLYeBqJacCk1RKTPEEqeDgwp8pX/hmNnaiqZaCh3PkrwFUSVC72LEPGo4IaGyocflA3yUFH8ABld35QltEoD0WZ48j2AoBStqbpUUNj8Erx89zbvlZQeYMKz++feU+cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cS0B/J0+; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlJa6fOidoOvVYJB0jeI2guethKld9kxHJJEkJYe3yulDF0Hc2QbEyt3vqrtIIhN2L7ePIV6T/MOUR/lZHjfOHSwKYjRdxUaBZe/ODLNC1iIDS1W9CqC4u0ZRbM5xUBL4H4snmry6FAguD1x0h5wglYkH4Moy4KJrJCsC6CRcO1e0ZhHyjZQt7n9u2V4I7nSr0BIofsBofXASc0uhkfZUXljLODuj/1rWNCJFVnsNarloHItPETMZN8d5gxaSaa2nkadLzE5166pYbCJsvQ/iIdLqp9io8TOF2gux30qJA1MeCediD7oLpDNkXFcEfgJa+nEZsQ/wdG8CUUq0SIgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBVB+7s53c/nQZY8VcGbUWHDFf9P/kxM2Mt9ZNrB6yk=;
 b=AOZFzehCGPq8IP6rRDeED0CFB0UYaK1CrDMFy8Y/r8Z3agIjMyk5kDIWlDKoL4QXeuxAL/5R4iqiO9/RAt4S1Sz6pXAXqEl195QIa9pJgV5caQf2aDhTQ41bsoi/yquudvCjcaT7OpdRNs6jaaq/M7Nsu7hufGvjXu1tyhN8WnAllTBZ1Bui5EklpcwVMNjTrUFKsTCXpA7jZUYD4H83NVRBQwuDviK1JlQPZTHoGZlAUm6Z9YQCLvEyGlQzR1PCcBh15WMnN03FG7GBHArnbOq3ZniXJJJi6MDpdoaYFkxp4FNe3sRkNQG5BlRuIdotrfOzC2DSvL4cgIfy5vZTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBVB+7s53c/nQZY8VcGbUWHDFf9P/kxM2Mt9ZNrB6yk=;
 b=cS0B/J0+MWbiDBwAYJ+Zrydg+A3sS8auGrCLTx8ekhmARxD7eaf5PwFjDG7rKyKdFIcj1AViS24XrhmYjdmaViwVcKk+eH5pkG7dw0D44cdRdNclWACnJC9+akB2/GLxOCazQg0ZdlFZ+S154wbC5vNoMADOF6apI7klx19/wJCWcTiwvcIFOVRPHr4k1UwtozHOzPzmgfsjkF5catqHQCgVht6j9DBBa7IUgdWr7PX0pzHFBY7YcCvaoOshOVGXn2MrlSB2NldfP96USQp0hz1HQrHJqHUrYJMvzLssToKmiGvY1wnVWbv5zAASLfCW+ITNYaGum1L6SYg4qndeAw==
Received: from MN2PR05CA0050.namprd05.prod.outlook.com (2603:10b6:208:236::19)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:49:27 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::9d) by MN2PR05CA0050.outlook.office365.com
 (2603:10b6:208:236::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Thu,
 29 Jan 2026 10:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:49:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:49:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:49:10 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:49:04 -0800
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
Subject: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
Date: Thu, 29 Jan 2026 16:18:14 +0530
Message-ID: <20260129104817.3752340-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129104817.3752340-1-sumitg@nvidia.com>
References: <20260129104817.3752340-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c5f2b4-b678-4271-03bb-08de5f241243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWb0NNmzHNaWzJDwWkLs46NNiQtgR1iOp/Rlo62dkpmy0CYVnzNzGQHHPmL4?=
 =?us-ascii?Q?t737n83DtQpzq+ea8fNqk7aVnGW6YRwrMxiXdyMSDuhR28bHjAOvv2uETJLB?=
 =?us-ascii?Q?OGg57c/+4aPwAemJvLEW18U+stWLBKThdZl/JWTGLckPU48GGH8apponT2jL?=
 =?us-ascii?Q?fTPa5jeOReeOnJpeG1m/O1uBO+cDcDp/4M05VMdjZNhEKlSjy1Rtc2E9cdsH?=
 =?us-ascii?Q?UPimgv+/+Y9j94I+t0a+dJZT/9f34SH5RhMK3146k4Zb+1/Re/Z+Kob2gRq3?=
 =?us-ascii?Q?N9zXX72W/89F9W4ZBdjoURIRXkrnD/6N0pjEAYGpvN5gOOfDmCgMbtL6zmay?=
 =?us-ascii?Q?vYOOntTOmZPYRavs3i5kpA3c2N2bWyCCgU6OG7GCb9ThGtiXPTckA0Iw3rCA?=
 =?us-ascii?Q?SQIDdOuUYUj7ifsQzbM505et3TCl05yexL7NwgmLkbjkp1LGTZVBTxeYgAgY?=
 =?us-ascii?Q?TotWDwXapR9qisPHIEK9pS2X+ctbmmvEydFuzqn+hfXMCLtARoNwz2a2ClAO?=
 =?us-ascii?Q?6UPijr/rPwQdVY/Hye2aSdrvhgHwenFYz/QRbvQKYiZWwUfhisjioxREdkvl?=
 =?us-ascii?Q?rvPrOkNMDYnPFzFvDQoSUxcYuXpy13e1MoGBc2eDuvTwyXo+drwj8avSibOW?=
 =?us-ascii?Q?18yjRTO75JMi4TGCw/crVgdKUj82D7iDH+BsQRxno6jbSHBAffW2i0PNhHm8?=
 =?us-ascii?Q?dl8GX1SeYIV1qZM2rUwRYa+riKoasq00GJM8VwJjAjPRjz8FIua7IEE+UhKx?=
 =?us-ascii?Q?SNhylEd8OQc4aUo6dHu4b0KbLOB3BvaPqrvbUcicGHAi7a2i7532T96aUfAE?=
 =?us-ascii?Q?mUEng6AsYHf6kiAgHPqAxbF7JDQAU9+NUWrVncbcE9t8mHA2wB3DS32+5Rea?=
 =?us-ascii?Q?JQxx5D4GrcO4EVMmGnVt617DiT20OviAKDNOAXEQ2BEPuuSQKsaFkneQsXHd?=
 =?us-ascii?Q?aY4paNzCul76f+srVQy4z511htYOreFTPE4oTfFItjC41UL+EBvuiQGletK3?=
 =?us-ascii?Q?1zqd2cLT1LgicVJf1gED8V+GPs6/RdyQhZ2wR6sYy7AzTAWF204urCXvsx6u?=
 =?us-ascii?Q?GmcxxN8AGulO3X8Cg+NCQkNSCx/OrS8rs6MCJ03J+xGdsEE3d88kHhBg8hIo?=
 =?us-ascii?Q?+RcT0KyS4gUtuxkBppCE2LmDSNj6p6oKnIkLSl6Fm+YNLVWm8UVXsw+RL2KB?=
 =?us-ascii?Q?6YcxJjRUVic5S+IKEf4YgMBiep0fCuRRCHiCg/rIjcWPAyn37P4t+vNzSGBd?=
 =?us-ascii?Q?d1Kn6re0rU4wOATCp7v50P0Cutxv8XlFF7jDV+0rmcFYfTbZ1LkCw3zZlcME?=
 =?us-ascii?Q?TCwLD/0kyro0rL04c5S4KUcbpyzrK/aTGAQKtWtsUGHmC0LgFCs8bbV+dFxJ?=
 =?us-ascii?Q?W5SlpvH2dmHjJzgMvLXcMCikyK292udQAb9jHlWC2R5ZmqdWOUDLodBr0+wi?=
 =?us-ascii?Q?UcGa6ZIZBdJx/qinmLAZ/aM8BqmCoA5QngcpM3L/Sen/AAgVijBtaLlQ55In?=
 =?us-ascii?Q?SUS8FbMY2clTiwwwtyQWd3uLcXXco8Q/6ekrTtbAdcIYzpMxMfNPhks3DdyJ?=
 =?us-ascii?Q?25Eselww5+vVc79iZcZLrlA/a+BaCAe96Nr/UKBYOfmdu64BaaV43OAyJfWH?=
 =?us-ascii?Q?uKzZ0z9B+L5I+u0Feyh86SSE1KZnGAPaV7de0uZUjZBJNZdsqWJCF4BxLVMM?=
 =?us-ascii?Q?uMjksqYchqBnSLGl+SIm/Lxujj8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:49:26.1219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c5f2b4-b678-4271-03bb-08de5f241243
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20759-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7A824AF234
X-Rspamd-Action: no action

Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read and
write the MIN_PERF and MAX_PERF registers.

Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
to expose these controls to userspace. The sysfs values are in frequency
(kHz) for consistency with other cpufreq sysfs files.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       |  44 +++++++++
 drivers/cpufreq/cppc_cpufreq.c | 165 +++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  20 ++++
 3 files changed, 229 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 08e62b58eb83..b2b8daab69ed 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1753,6 +1753,50 @@ int cppc_set_auto_sel(int cpu, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
 
+/**
+ * cppc_get_min_perf - Read minimum performance register.
+ * @cpu: CPU from which to read register.
+ * @min_perf: Return address.
+ */
+int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return cppc_get_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_min_perf);
+
+/**
+ * cppc_set_min_perf - Write minimum performance register.
+ * @cpu: CPU to which to write register.
+ * @min_perf: the desired minimum performance value to be updated.
+ */
+int cppc_set_min_perf(int cpu, u32 min_perf)
+{
+	return cppc_set_reg_val(cpu, MIN_PERF, min_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_min_perf);
+
+/**
+ * cppc_get_max_perf - Read maximum performance register.
+ * @cpu: CPU from which to read register.
+ * @max_perf: Return address.
+ */
+int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return cppc_get_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_get_max_perf);
+
+/**
+ * cppc_set_max_perf - Write maximum performance register.
+ * @cpu: CPU to which to write register.
+ * @max_perf: the desired maximum performance value to be updated.
+ */
+int cppc_set_max_perf(int cpu, u32 max_perf)
+{
+	return cppc_set_reg_val(cpu, MAX_PERF, max_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_max_perf);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1421f30e87e4..8787185cd8b0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -570,6 +570,35 @@ static void populate_efficiency_class(void)
 }
 #endif
 
+/* Set min/max performance HW register and cache the value */
+static int cppc_cpufreq_set_mperf_reg(struct cpufreq_policy *policy,
+				      u64 val, bool is_min)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	u32 perf;
+	int ret;
+
+	perf = clamp(val, caps->lowest_perf, caps->highest_perf);
+
+	ret = is_min ? cppc_set_min_perf(cpu, perf) :
+		       cppc_set_max_perf(cpu, perf);
+	if (ret) {
+		if (ret != -EOPNOTSUPP)
+			pr_warn("CPU%d: set %s_perf=%u failed (%d)\n",
+				cpu, is_min ? "min" : "max", perf, ret);
+		return ret;
+	}
+
+	if (is_min)
+		cpu_data->perf_ctrls.min_perf = perf;
+	else
+		cpu_data->perf_ctrls.max_perf = perf;
+
+	return 0;
+}
+
 static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
 	struct cppc_cpudata *cpu_data;
@@ -919,16 +948,152 @@ CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
 CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
 			 cppc_get_epp_perf, cppc_set_epp)
 
+/**
+ * show_min_perf - Show minimum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ *
+ * Reads the MIN_PERF register and converts the performance value to
+ * frequency (kHz).
+ */
+static ssize_t show_min_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_min_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Use lowest_perf if register is uninitialized or out of range */
+	if (perf == 0 || perf < caps->lowest_perf)
+		perf = caps->lowest_perf;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
+}
+
+/**
+ * store_min_perf - Set minimum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer containing the frequency value
+ * @count: size of @buf
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MIN_PERF register.
+ */
+static ssize_t store_min_perf(struct cpufreq_policy *policy, const char *buf,
+			      size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+	u64 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	/* Convert frequency (kHz) to performance value */
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	/*
+	 * min_perf must be less than or equal to max_perf.
+	 * Skip check if max_perf is 0 (uninitialized).
+	 */
+	if (cpu_data->perf_ctrls.max_perf &&
+	    perf > cpu_data->perf_ctrls.max_perf)
+		return -EINVAL;
+
+	ret = cppc_cpufreq_set_mperf_reg(policy, perf, true);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * show_max_perf - Show maximum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ *
+ * Reads the MAX_PERF register and converts the performance value to
+ * frequency (kHz).
+ */
+static ssize_t show_max_perf(struct cpufreq_policy *policy, char *buf)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u64 perf;
+	int ret;
+
+	ret = cppc_get_max_perf(policy->cpu, &perf);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	/* Use highest_perf if register is uninitialized or out of range */
+	if (perf == 0 || perf > caps->highest_perf)
+		perf = caps->highest_perf;
+
+	/* Convert performance to frequency (kHz) for user */
+	return sysfs_emit(buf, "%u\n", cppc_perf_to_khz(caps, perf));
+}
+
+/**
+ * store_max_perf - Set maximum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer containing the frequency value
+ * @count: size of @buf
+ *
+ * Converts the user-provided frequency (kHz) to a performance value
+ * and writes it to the MAX_PERF register.
+ */
+static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
+			      size_t count)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int freq_khz;
+	u64 perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq_khz);
+	if (ret)
+		return ret;
+
+	/* Convert frequency (kHz) to performance value */
+	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
+
+	/* max_perf must be greater than or equal to min_perf */
+	if (perf < cpu_data->perf_ctrls.min_perf)
+		return -EINVAL;
+
+	ret = cppc_cpufreq_set_mperf_reg(policy, perf, false);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
+cpufreq_freq_attr_rw(min_perf);
+cpufreq_freq_attr_rw(max_perf);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
 	&auto_select,
 	&auto_act_window,
 	&energy_performance_preference_val,
+	&min_perf,
+	&max_perf,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3fc796c0d902..b358440cd0e2 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -174,6 +174,10 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_get_min_perf(int cpu, u64 *min_perf);
+extern int cppc_set_min_perf(int cpu, u32 min_perf);
+extern int cppc_get_max_perf(int cpu, u64 *max_perf);
+extern int cppc_set_max_perf(int cpu, u32 max_perf);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -270,6 +274,22 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_min_perf(int cpu, u64 *min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_min_perf(int cpu, u32 min_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_max_perf(int cpu, u64 *max_perf)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_max_perf(int cpu, u32 max_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


