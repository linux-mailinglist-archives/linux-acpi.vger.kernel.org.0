Return-Path: <linux-acpi+bounces-20756-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AeBGyk9e2mNCgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20756-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:57:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F8AF441
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07D913076EC1
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5F381700;
	Thu, 29 Jan 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hoU7PHoP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AD38170E;
	Thu, 29 Jan 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683746; cv=fail; b=Bo/79NmioOQKbuia3HelsQEpr7mVV2UjM/uxPVkrqrow2TqqIjnBCsUTpC2nzxG+0GZddMY6yUr6xH2CQ2br/N4UU7+Du7K5sLOjAx4qC0opqD/mG90r2HOV1VvGar6Wb87iEy3fIzbIdTtWEu18pYDHWbU1+/oQEdjDDjyFMH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683746; c=relaxed/simple;
	bh=ODt+mrWhKfDo4B0pCw4OgUc9DVhiq+i8E7+Qddm4X7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6omAY7RjG1q/HIXNhe52sJSzV8kmMTzNhgJcbjvEn0E+8a0Lr3T98eM+IjahDn46rsLV4pNLTyzuNUf1cKKKnHCbOrZDiodxVHJ0pK3PF2g8Oe70+64LFpyJSxxUQ9nEStTKZAWsFces6V2ZBwyMSY+KZGEg4YHXoyqWHlLNRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hoU7PHoP; arc=fail smtp.client-ip=52.101.61.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8jMa4wVzVz4hEQHIBnxke/VRcOj0omaHxyRRBZG9CeawwT7lQa5QFajX3AaYH0douzgqxLaoOFxN5hhZTeT3ojgGrzlF36f3rX4Eje56gGsse660GTSxQge/Wyd2GHHukBM4Kt9Q6P9dpa363blWoJXr5ExIpHB3+HFSS4hPOfaXw4hMCI9540Fz4Avi5eMxoq5u0PnzfklI3rUWgNUlb2EYAt5Quwe20FyuNgUFOPX2oEbhvHAar1aza5RCU+1luwJNppbE/KY8AXX4xmsS4zVQiIyZyXTaeGB83g9w6h+QEZxTYYBVS8DRIc7Uo97GDx/H4oBQdnzFLHk+43ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ePpdZrd/tvylu1/ICv30Yy1V/c/CnV6TKMi9s+0TeU=;
 b=ZYnfIa9ZqLiOvyylq2QOPz72CHMzGK0glkmU8d4k9JeOuroE8KP+ME5Oxu88GBLjOLH3oduicVIDBzPEf02PIPj81K3jCWZKBk1yXmGSLxe5KGzfMRphDcZRLArM6UuvS+tTFiNtw2/1VyHVEDqDoe7wNbb4UQSMPpw3/JHQfTIEgfMM6ZDGrlHds9faCXEGRXl0dxCQ0qcFAoNzx6fc8PynnuCiEjJ3PMNMiP0YgDGndTwHPEjrMBLSbUgyOxhzUAUrSyxR5SlNeJwHzNMaBmVdJ+9xGFbemj5jJKC8Tn+hyt9wvQ1M4E1zpP1LTDT3qcPnmJc77mzDHJonm1GqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ePpdZrd/tvylu1/ICv30Yy1V/c/CnV6TKMi9s+0TeU=;
 b=hoU7PHoP5IJFSqD/Swocu5BwG2p0307wUy30c4RfbobnMk5hnxAc7kj6DMyv89azwuZ4VcOvsgbYykUescUc7LkJ/uY3WNnoJ/P8dyAwEm9d6Qtc0OnBkmNPmp0FTgI+KmrNOlKegrMP6hW1m/CA6hoaLOXS1bLbfCfidQ6tpmzFjd8eopuv5AAxvT+VMFkaQCmHV/JksPqZBUD3ZUG6wJoKtlhRrg+VslLavkOJBRJUVfsxfBzNYwuk/xRGE7c4Lm1nXPt32L1sv3vNJ8k4x5jgVch/SO/qdZ+gI12YlzyivtclECWEmdzsGmi11YeRhx4NWQgJk2QBrZB3G6uq/A==
Received: from MN2PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:c0::41)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Thu, 29 Jan
 2026 10:48:57 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::6e) by MN2PR05CA0028.outlook.office365.com
 (2603:10b6:208:c0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Thu,
 29 Jan 2026 10:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:48:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:48:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:48:44 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:48:37 -0800
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
Subject: [PATCH v7 1/7] ACPI: CPPC: Add cppc_get_perf() API to read performance controls
Date: Thu, 29 Jan 2026 16:18:11 +0530
Message-ID: <20260129104817.3752340-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 872905c2-a8f6-4de9-02ea-08de5f240117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mBOpgp0DC4BjXr11TzdD0zFpykKLv1g2RqdADOf+artef/W162CGA2MlITuh?=
 =?us-ascii?Q?/fvBCAXcDhw/VIpnlNogBDlpEXqeOKXljZs6ifAyim8FNWYHOweozn70CQEb?=
 =?us-ascii?Q?F+Dm06N0VnbaVk1KRzR7LhE6zj43LU7c1uxoBQX8xLioNRcgSf22vi3Inimd?=
 =?us-ascii?Q?bjOX++XjGcCFPdmMj4MGTtaU6QGAfb6Fe+hx4E8Y7MbBJkcB89Afaf2fDTaZ?=
 =?us-ascii?Q?uaFYPGTskIHWEb7DciNzyslwAgANbJWMo9dJ2Ks5jB0xRBh6mYKcM/P7/Euz?=
 =?us-ascii?Q?DBLsuQ2SYNcGYQqvSyLjuMDdgDDDhIjlFYgcUCvyeNXQV9h2Z3JGC2gkicSa?=
 =?us-ascii?Q?Sxhkd+Xy/7SznYG+r3QGMqeAeTMIOKMVAbZYXZPA5EA+YwvT/7wcrpcLKr3y?=
 =?us-ascii?Q?lNXPjx/D+UTb1pUSUW3SL7htc9kn+XjALJxsy4GEk+uv4SxDSj03t0lhrpUc?=
 =?us-ascii?Q?5meK087Uv2FuWEkKk09eOnJkjNa0/q3BcpydYL2ZdGqAm1b7wn/A7KDo95eR?=
 =?us-ascii?Q?E/ze/WPMZL3lHg3GTbgr8YfwtZNkKLIGbbk7AwO31DMetjvg1jo+DIneM743?=
 =?us-ascii?Q?9CkxkCFj8iXvo0uHLQ0RZVMgx5EizEtAA9mrnv9s5/jsVyA0x10/+Oo30Lj+?=
 =?us-ascii?Q?2ItXqptozKdsnI97+iJn9XMHXL+/ON7mhTgg36Vpts7BSnOh71bAWW5UGMeC?=
 =?us-ascii?Q?o3oDCqFqJtbAkdipQaCe+cbWjhb9UszlGAJg3aWI2RwRPhDNCaw3gO/kQbRM?=
 =?us-ascii?Q?Zj+Ju2DMNisnhWOVISBT+TO8jmS7aBNlmvU/22+JbBq2ij6vIxEO5pqNML3T?=
 =?us-ascii?Q?E9lqnijuWyolT7hCxEDI+dvv+Dhs2H7Ud2eOfrEDO1wDW0XwvpqpzAN6a9xg?=
 =?us-ascii?Q?wgEM1EoKwgautFx9rO1ApBBjOSsn3aI732b1imK2Tq87uLtcej58J1Q08yGE?=
 =?us-ascii?Q?olvds0xuHrNhSm4C6ARQ6yqGxAyQotvSzkv5ZjAXnaJYfqhpNxoXwEbtcmWl?=
 =?us-ascii?Q?i2M6LQZt4bg0HmzQvBcH4kZnZUi39hYolCzdF+wxulASkmr94+2gi3bfCf5f?=
 =?us-ascii?Q?rdmLIydRHcCz24bJogbqoSrGPMHnqphbnvCnB5cR5454RIa4P8H9ZAOmrYI1?=
 =?us-ascii?Q?U6DRWbyXl6cbyDRwSihKPN5baX/Qqgp/KvS0AATvIH/E6SJZA+Kr1RcSDWQ2?=
 =?us-ascii?Q?4X9LWxzyy4pXaLCxtJ/8C/InvCWv2XzWhFfr5jMgxCI/WcqdWVOeta78raom?=
 =?us-ascii?Q?Ut4p/il7MWL2mihnRSATYZhMBpyOkr3bgVpivRGNiZAQIHjQCYDdodwUCy8R?=
 =?us-ascii?Q?1Utq8fdWZJYYhPDl/Nvj/xF+bTKeNy7sREyhzmbmhUXryZdsTXKUQ/FADUdT?=
 =?us-ascii?Q?Ocq6AYYnXkZfg9jy9AjGaOaKYB3mssQ5pqIi978UZ3En4q+/Pb5Baq/+8bFm?=
 =?us-ascii?Q?nTlC+ltX9qypyUMS5SN/Q0nXeO3kaKwjUMg+URcRCxQFbwpkWzlzse6SV29O?=
 =?us-ascii?Q?i3pNK44g24Zq+J0RBzdHKG6fgeVC9wtAMTaDuOcjhrJUolO8hHedBlzyvkVQ?=
 =?us-ascii?Q?1cvZQjPDYtezyraYbuYS8M3Npz/Jjx1axM0J/sVkUIi4qQKIqzEjPH290Gq/?=
 =?us-ascii?Q?wkx6e/vQVZW34dTyLNoIT3oQTRD5RNvZm6ySIvI1N807QJjMwxiONXwiJ4jC?=
 =?us-ascii?Q?B4y+Tp7XJWvzjqDTr8HkioMwce0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:48:57.3154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872905c2-a8f6-4de9-02ea-08de5f240117
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20756-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C60F8AF441
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


