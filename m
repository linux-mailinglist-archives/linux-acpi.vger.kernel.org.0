Return-Path: <linux-acpi+bounces-18620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A16C3ECBF
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 08:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6F984EAD2A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A330DD39;
	Fri,  7 Nov 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="og4NOjUm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD130C60B;
	Fri,  7 Nov 2025 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501459; cv=fail; b=oJEHuiBMCHl6iw38KcevkKr5vC6jZHX0ITLgy7F9lrbvkZu6LlfW0waXL0MWwt9Vi1j9TBruYXCVDbCLsF1Ds3iNNl5pzGMZbouL6WoFINbE3u28Q8x5GBgtWwOrNwa65QTB0os4Q1xXmZPmX3HiFH7Nt7wYhQZnumUF4YRhsis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501459; c=relaxed/simple;
	bh=v5ZbXbpda1x76jVMQVkGFf9nr1Z+yqGWU9LOg6/5svs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+KzQ85SFEkQ1sQXDVH0XGzKlMJLTUNoi8UxDn4Diuj+V8ksje6r8NDtN3n5aTP/GF1ovlLthqB5rvayHtYuoAlRivi1nRQCu5OZUeUmGpTSeRDAxmF5If3AHO/a4EoLa+0Q3YJLMV2SZWSF/Lux7/tnKWwVe82FZeV3Fl0Mg+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=og4NOjUm; arc=fail smtp.client-ip=52.101.52.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcRZYZb9hfFxvrtXQ+7/BRbG/QzgTvEi+Km39iUG5lfCVNXfiCoXiADyl+Ew7KY8GeT74R953iDRovepxs3XF9TqGIPy7c9WkxvcEQE/M3m2kJ6TJdhJlUX1j2ISLmyodrgQm7B/wfDO1/oLiUbjqLrA+fxdbhkWnTiOQcvx+4raH5kt5zA8L3PZrutlJ0xMR0a4PY2K4hwRssrQpeKgy9g7tEDZAh54r5Lp8deeFBOxcEoykdpLk7y2XdaX24heHD84QYKZYhr3tbaNrrheBjx5r1BEWwl1tP+Ht2irG/yi7u99Yg7CKv/tAwZJWqEEMiM9PLh8LYhkspWFpnbD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyWawckfW5TGyu9Olo/n9eWgZhfDXa6b7zOouWfKh2s=;
 b=Cp3uzfLn4zSqmDLB/EzTZmoK1vVQJM/8qjYBkzW+fTh3X4XOpf2t90xOwqybGrxKGQ7nq3dizl38sS1ttS1rKgPuB3qi2Cyfm9rp7sGT2Z6mmFodJyIQl64u/nxf05pOwPyoP2PTv6AxJlaYgalE2y5LNzxUNTM9yjM4v0mvS/NCDQaAWN1Lvn2BaLaKWdgPOMReoo6MUV9sC6Ea5sq6zSZ1vArFpPjZb9qTGTQMaA9w+r44CQa6XWhNwU2PvhIPBl7dgtNjQzi70fV8V2e78ldg0KVGTi9HbMkhe6SzK4bcKsqEwhlMZ6BUC3XdX+84IBw7VqZaReSCAj03u575RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyWawckfW5TGyu9Olo/n9eWgZhfDXa6b7zOouWfKh2s=;
 b=og4NOjUmxyWuySzlK1FDtL6sTt/tCk0kzhZ70gs3V6SfzEimN5yceW5ElPwehKz32g4phQFaOq0eIKv3VhzQVSW8lPzxPUmTny0uYB0tGkTu43j5uPvV/REKf21q70JMzG7QaByez1k6QBubFxm1g7F8HYUqrJZ6k05zrP/Hgf8=
Received: from PH7P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::33)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:44:14 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::cc) by PH7P221CA0046.outlook.office365.com
 (2603:10b6:510:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 07:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 07:44:13 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 23:44:08 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "Mario Limonciello (AMD) (kernel.org)"
	<superm1@kernel.org>
Subject: [PATCH v2 5/5] cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs
Date: Fri, 7 Nov 2025 13:11:45 +0530
Message-ID: <20251107074145.2340-6-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107074145.2340-1-gautham.shenoy@amd.com>
References: <20251107074145.2340-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bdc501-da46-4db8-1d9c-08de1dd17270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?61KKxY6d2yV7uJBmyPc/hPOVH8blMsCphIZZE5prgg7LaZOWvT46jQori/k6?=
 =?us-ascii?Q?g0HznTGr18x9hlsxtQGn+AwbkPiaEuc06Wf4OZDRIfjiO9x7+2fAO2GPJOMY?=
 =?us-ascii?Q?XSgL2Nvl/P2zkT/4mGFLLeYg+VLXMrulAjaPmiixb8CkGfuc228incpwAsFN?=
 =?us-ascii?Q?xIxfHENw4wL8h9vbRi+GUgLsfPej4ja7pSL+8fgySoxhTTuRLSva4EAM1ol9?=
 =?us-ascii?Q?QseyhNU8oJOgTUBi5t8GpJQl0bXUWGzBVi+hz2DU1aWLuvCGvkV6YtTb6Vcv?=
 =?us-ascii?Q?0kyIAzG5jyzeAwO6qf3JfVCkwqxYZofu28dxOMDQDLSCUKwy4LEI37KKvLSX?=
 =?us-ascii?Q?gp/IZmt7XbTmuJwJ4zB51kwYupn32AN86g9BDg3nCxdVEq43bWCL8bl8lt/y?=
 =?us-ascii?Q?Ny3mzke+2dsPoacFLsa+756NSqza2DiBFX2ycpco2eT8EG/fh9AS8bBjUKk3?=
 =?us-ascii?Q?GCFQNO/cf9D/VpEuHoqp4NsLp97mjuNuemhsGtxrH3UIqXGgJYAPdN18HRoU?=
 =?us-ascii?Q?X5dVhAhP3pVK+SRnlR0TpT+JiG/kD+qBO8/es+SMz45YSFR/BCfd2YezzWjv?=
 =?us-ascii?Q?YNDnrfGfDmozsQw99pNPzyXa41XXQVoJVQvhgQi1gvgTONjnhF5pDQ+8VQZZ?=
 =?us-ascii?Q?NdtWBPAWx8WrUXOq43KabT+QXRh+ety/UJHfqYGHzyqkxVXiXkKKdjALq2W0?=
 =?us-ascii?Q?LdpCMVy1PYVu+LA6Nbnf06Hv5bf+BMh8kv3kb+KcZo9+Km/QSM9eBtciyeSV?=
 =?us-ascii?Q?sovTxrFMBEVKik7DtRFJFLZ2v/psY/l+6vMTo7gxtEZTeNQ1+/8tu1labZsV?=
 =?us-ascii?Q?qkE8vA83mNuZ6bkOtyzigjrI5zCKOMf3fKK3/ejDb2NATJ0rgBkiT+nninkI?=
 =?us-ascii?Q?J2IKj0rN6OOYuVbGm9702nxEQjIJF0RoVyPNgCLVtYwzL/zDjk5qXZKXsjTS?=
 =?us-ascii?Q?w+l4ZkjRg9GKqvHEUxiRmEi0tykeqy/midIwdRbxonZXakA2PilOmkPiQzxk?=
 =?us-ascii?Q?NdJhu9wQZ2CillkMuzczsRgTQ081dYDDKGh8h9f8k3peHKRg46vyvTE5vqcS?=
 =?us-ascii?Q?iQcdofZ9/LUN1pL4JvjXefeXeAlXoVurziCfY7JO7E7XF41oRskO1XNnw1q6?=
 =?us-ascii?Q?uTg7Pg30bi76uL8hx7I/O8ilVB3a6BhnVvxERuYa8Yq6rRWHbjzntwWCFm5a?=
 =?us-ascii?Q?nQwymiRZBZrjHm4zEHRnXBJBlQCHmIHLIXrM9BaKD+mDz3oikVP9lajj5S4F?=
 =?us-ascii?Q?lqRRTN59VqxCB7i5Y53buYlXli+2fXWPRfw8CJ1J7wjH1xm8r1zvADxpB+JS?=
 =?us-ascii?Q?vrBrhPPVjyhGgAxfSYK3Kmjh05OUlRUzbz3/oOgn/80Ic8XLB44JYckdayHr?=
 =?us-ascii?Q?q97iU0vBCuAIMpS8iBAJkbGLBXRUUZTC26i7/JdJL0dqtoD7iorf5XOGQrmY?=
 =?us-ascii?Q?7XaYNqKNHfZqeo2K2niwZZaePD+V7zXEjwbFKcE8J6RHM6N75wh5FXLyUVw2?=
 =?us-ascii?Q?dJwnbfYIWjZOf4VZbDyYNxAMcKyiIt7ZWOA79uMgrn2nsyktu/ttu/NCZPDw?=
 =?us-ascii?Q?UsGg0//eV8Lpi5+2fUY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:44:13.7905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bdc501-da46-4db8-1d9c-08de1dd17270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

amd_pstate_change_mode_without_dvr_change() calls cppc_set_auto_sel()
for all the present CPUs.

However, this callpath eventually calls cppc_set_reg_val() which
accesses the per-cpu cpc_desc_ptr object. This object is initialized
only for online CPUs via acpi_soft_cpu_online() -->
__acpi_processor_start() --> acpi_cppc_processor_probe().

Hence, restrict calling cppc_set_auto_sel() to only the online CPUs.

Fixes: 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control support via sysfs")
Suggested-by: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b44f0f7a5ba1..602e4fa81d6c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1282,7 +1282,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 	if (cpu_feature_enabled(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
 	}
 
-- 
2.34.1


