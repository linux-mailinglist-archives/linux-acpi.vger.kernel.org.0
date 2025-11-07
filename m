Return-Path: <linux-acpi+bounces-18619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF858C3ECAA
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 08:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04FBD4EB798
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 07:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572230CDA8;
	Fri,  7 Nov 2025 07:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yRqA+m7T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37594303C97;
	Fri,  7 Nov 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501434; cv=fail; b=MppnXPK+rtZyWmTwYXDOclne37AmroN9vmNNv1ZIaOmbPtwOSzfYJnHt6mhICEiOiz21OYEBB+a1pIq6O1o8/ynqkVGS9/B7ENYo8m1sBWnAcHgA608neWaETNycDJPMRDbudj6JV0+c7+ZRl8CwUA/NnH91tw9+GvrwBO0LroA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501434; c=relaxed/simple;
	bh=r/lqbeXdn+FiJrdDtXMZ5NxybFnW45SkWCfB9SBaUJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVE6TtTOvrvyUFx39getnYmdEb1CggRKCkhCUrj/RToeDTdHx5x3ZYCBbSWCVCD9iWiRXjMGsZ4XqcVrMs8nTtFa97p2UiCWRNEFTvpKBaLpPVYGmLdE9cBMQvV6HQnaxAs6OM6BJJhfxCnoog8XqZiAWjwf0+jEzHiXkxvQGCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yRqA+m7T; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TASvmDL89Lv0YTcM5e8HUE1S8Ck3fXADyoDHNgcvkGmoly6w6zJwfbVIfbTjhCKiBWZfnGqkvO1tf75WmUOQIA0P24CSAyjqpKyAyTzsEZAa9gkbhf8NnDJUtyVGzjoa+QUR2M0bqcudBFzdBMzyZmc/jjA76AbLuRYj4l35CxKuZZXtWtKgPoU9nPK2Q4jI4dU6WYPnhTwgATDdEzVs7BYcVTTTJAdsr+CJtxUrdZV94fK+8fGSOnUDANmsrDfZQJsXtA37nGUoVBT7RsCdjmGQmP9oqS4RHK6TT1F7giuk6mxoPSG3kjtYPQA0BgePcg7cbq+XgdJPEff6eC4gKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvbagrnBTwXSiYRoU03utR4d8CpMJuEt90S2BF4UZlw=;
 b=NRF+C0FBwO3liARXGDzHuYvzpxoJ3uP3lXdqgHcRjA54rgK2li3qflu4QhuYSwV8xUo2smLsYd3dsoeUVOY62hrRjJbB7vySISOzJ8RqH0ob/tWwokBI3r8obzXH+S8o40PvOAU1jKruocjLxlbLScLlCnaHFnbmcyqecuE+2MqrzBtaGwdQAM9eMN+gN/oFc6MZOimwLT3U9TpiGDWOf0LYdGZF2Y2sLSvhBsMMS5whKLYV0ZtZxj6IUOAmQ0fY2DPp5RpZCyEBUEW7rgVH4+XY4FfbpeL7csMKpTGMs5tWqs+q3o0RmPH/k8TgHmfCFNGAlatkqbzbzXjNUoq7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvbagrnBTwXSiYRoU03utR4d8CpMJuEt90S2BF4UZlw=;
 b=yRqA+m7T8LoYcDmvU9L3EDew5qdbeX3mLnogYoxH+o4hJZwiUmlgBJisLSQOTxx7zDe9R+4dG+uqcXN752Uby0Pn3+d/ZBQHsudtEfrlBFwqYkyncLdd+W+9Byf6DT8SP/HRlzqE48jAEJddSsIaaPlsK+lnFusH1ZXqoXORYj4=
Received: from SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) by SA1PR12MB8117.namprd12.prod.outlook.com
 (2603:10b6:806:334::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:43:48 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::bf) by SN6PR2101CA0013.outlook.office365.com
 (2603:10b6:805:106::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.8 via Frontend Transport; Fri, 7
 Nov 2025 07:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 07:43:48 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 23:43:45 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "Mario Limonciello (AMD) (kernel.org)"
	<superm1@kernel.org>
Subject: [PATCH v2 4/5] ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
Date: Fri, 7 Nov 2025 13:11:44 +0530
Message-ID: <20251107074145.2340-5-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ee6040-c044-4993-9216-08de1dd1638d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qsocN9SY3B1c3yI29yWmnCIpdwn7dessXEW0Vw5GEK//H61TCo+JjUirnVBD?=
 =?us-ascii?Q?2Q4zP4h+DgwXrjZTrEVPRT4aojjfPOwQ4FDDeTTDDJD2b+KiLnk1TxRjq29l?=
 =?us-ascii?Q?mbguCeYjiHqW4TImPjDm5OJB9b6hizECl0ztzzC1c0CRTlDZf1mVFLiLzwDq?=
 =?us-ascii?Q?Got/4TRN11aY7MofxHIKbmsNdxiDY7MvRak9gySEwjjXOarntjJTmwwwGr5/?=
 =?us-ascii?Q?MbhQv5QXgAojouX1eHehaz0utuHg8O1gFFH1yB+ekaeTMDqvHQ5sYbgwvfnd?=
 =?us-ascii?Q?m3TPKzCxjqEPLav4rZohXBg6eyk+wSG+Uq48qdXhL3S+GKYJWbWXruZvd9ez?=
 =?us-ascii?Q?SCNU8PT1wtCdHnCmmChN8JR0wuyEezmuiFu7obrbjunzzHh7tOf01VGznEWA?=
 =?us-ascii?Q?3eQ3WzgwNeo3kxJJ+m+T4clMt0XXCOtAToibIAJ4D7qVj9C2iz1GIFRsojAn?=
 =?us-ascii?Q?Wo4MdbZSTYzRAN7hpU+vIi98Qu1gva4OmCZGuNeUUeHGhbKg7N8aBGz88s1K?=
 =?us-ascii?Q?v+TBFa/hJZlQfpHpvSniSnpTzxFmW7IcLECNFCLmmSLqlE/grcifT4Py1ghf?=
 =?us-ascii?Q?2hOz2k+hEMzGtXb69E4qheLkKIOSkOadnT0CVXcpj+/EMOlOrDdkGh6l2Q7a?=
 =?us-ascii?Q?ci3dg8P/skvYjQzKZv5XBFih0N5JwjqyTL83dElblTx79yJ+rM0P3z9CrDDA?=
 =?us-ascii?Q?V3yj0OBD2nbV4Njb9BqTA1HxQzTdZ/5RAkWJVmEKyy6X+evbgPIYik2MWKnF?=
 =?us-ascii?Q?0iCOaX4p1hEfEN9bfGn0PfvvZPPyXN9t/S1Mt1PAyxPjsTlxf8ktJS9DydO5?=
 =?us-ascii?Q?Q3ORWZCTkdqrnOFbCFQMQ29dm4AnSi7Rm5Ney9+doONW29aD0wuAdnFY8Iz+?=
 =?us-ascii?Q?YV3UUoaDEmGVXAXDHj7SarvmrgSKCUi9tRiFoL5NmIV3ENzjvhF+41eg8jMx?=
 =?us-ascii?Q?pdigH9HqQ4RwreKBuh+1wocNpWI0HafshpiB1T7nN3+ndAahEBu5mnKf9rC2?=
 =?us-ascii?Q?cySBIjsv8SRUf7SJJXCO5akIKgO4FOaEWEBnPn2ifMxT4hP2jwboO8VMpgTt?=
 =?us-ascii?Q?PVFkAR/Tp8zMAvQ/WRQn6BcAVT7vTb6FuNnh+/xTT3YlaWAdtMnkyPPcsj2Q?=
 =?us-ascii?Q?njmbYhpovQFVgOHGTVcipjwOWXOzgxXNhz/+5drUZrJZLlMCtcUlpIA/3q2d?=
 =?us-ascii?Q?tWEbjzVy0iKBNMn7boTFCLai3Li8zoF9pYspk3Cby9AAB4Pnux1WU9tvcs4N?=
 =?us-ascii?Q?XfPrYPPjFQQxmyg0uW4QSbTphBejfqw7076WzXdGqszcSkNee9WGxTx8ieCc?=
 =?us-ascii?Q?Zhooy/p7rnOKlYQgz05sZDPz0kdGW6B4oqVpSM7Gm/QdOdoquNp256+vOnWR?=
 =?us-ascii?Q?oRmA6x0fQRDf+rMiIfdt3G2GYVl5eGFigwOMmJ8U0vps+m8Vt0DjSHLE0PaX?=
 =?us-ascii?Q?btuBvu7S4ZsoSgHMlbsMJxl3WJcu/Jx4LfBQNi3xMI4jw5wncAiZJ5RXgE8m?=
 =?us-ascii?Q?bzj6ozsy2vKT61kKRv0bUx30fp0lE9K4GH+YhXFPxaVOVE1ZEJhJv93CaNp0?=
 =?us-ascii?Q?TxsgPGjytX0BMab7Vrc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:43:48.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ee6040-c044-4993-9216-08de1dd1638d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPU via acpi_soft_cpu_online() --> __acpi_processor_start() -->
acpi_cppc_processor_probe().

However the function cppc_perf_ctrs_in_pcc() checks if the CPPC
perf-ctrs are in a PCC region for all the present CPUs, which breaks
when the kernel is booted with "nosmt=force".

Hence, limit the check only to the online CPUs.

Fixes: ae2df912d1a5 ("ACPI: CPPC: Disable FIE if registers in PCC regions")
Reviewed-by: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fb7696b27d82..f49c72d3a78b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1435,7 +1435,7 @@ bool cppc_perf_ctrs_in_pcc(void)
 {
 	int cpu;
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct cpc_register_resource *ref_perf_reg;
 		struct cpc_desc *cpc_desc;
 
-- 
2.34.1


