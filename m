Return-Path: <linux-acpi+bounces-18550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE177C361F0
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 15:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C7F334421D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6B330B2E;
	Wed,  5 Nov 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PeMjFFwR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5F32E68F;
	Wed,  5 Nov 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353696; cv=fail; b=FwuEoLBq7WlK/reTHLBP6aWklsOIP8yCFPwrV2S2wPv2gjNziX4lb9UvcJjtqfoETFxrffBwFgqVf5j38b1pifD/QUaxs93VTiySYo1Inz9KglYCfrYcxyaUfsLU6ptJdOyzhzL7+8bXWaQaNxp8esZDzpBT6IhixmDlOrAqVzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353696; c=relaxed/simple;
	bh=YNJshCYQUwrPA63hHVbFZwEWyn15/ueOZ1MbDDl98vc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rm1pMKNXDga4i8Alk6mD2XDy8hHepJlPJ4YgsWzY7CVNtFm2wOR09J9XOEmp5omSE5aET2Z7vdydqexuZ9U+eGvPmPfqoPcH9vF/j0zmQ/91mABd0i1QlBY2XS5GTC7OQSUoMb7/odyzlleWDGCjAvLCnV7/5+RLAcnqvpLn344=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PeMjFFwR; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqqccDG0IuV6vKTfrdErO9pMeR1mVhdRscP+PeJct9ojA3Tl3oAvfAFmhT5S5Uh4SgtrCkQ79WwlhLwhLiIay6KcycpW5UyoRo9FdgMhIT2VQNR4D7j+hRphqP8NUGCI98y7r3VLBbCXtLJnX4RIfUk0sVeoIC+ra+cv2umXxxV5Dij0u7EtG2h8DOYXbA+GB1nKh8KRb7o07T0yyI7ou5OYqxpFhZePxaUL37avkcpMT0I6MYEBfzskqIt1oBnmqmyqHWp2Etwb/EjNePbgl3VLsd1mlwoHIJEp/lOY9Rquy5wVud2y26NP/dCSMLnLXrWuHp1/Uq3dyC1FRTe/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqQaR26R/Cu7w+D/eMKDKKtRja+2Zg2FEKl838Exoss=;
 b=CuLKmEPjcc8vfLF96DNptySGyqvaFeEbWxnhqZoWHp6YUGKuKqzz0V6tzwETLvXqPu3y1niQABSnTe/bFG3EQGIAq4RObUsz8bw1OvP+j+fkv5/Kdk2VWvSAh4o2X8uNVQ59z0yqIcwRiWHacD3C8cm6ZKyveHrprJ0Iwyv+iC67nFvQDlCBAV4BFwmsDB25FHaN7Nc/ZhVDlxzhw1pgQTm/q6FzGEDt6Agly+c53EaB0nFUq979kKtAOwPIFXJ74+HiLtog6XACiCAMsdEwdr7/uMmmgJOvUNPqBb0XDPz3VlShk+pkt6W9D5WhP8Fk3yvVWPLZl4eYRp1KtNuUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqQaR26R/Cu7w+D/eMKDKKtRja+2Zg2FEKl838Exoss=;
 b=PeMjFFwRO5CCj5q3oAfSPnxOtxYWaAuX0/nOjXVdNSCYGChaVCM8+laqRGSsmrOuIgRVA5YG5TuIWqWIQRMpAGAvkFvHfGQnbBv5akR8JtZcK/+xSOW0FuyRDxME57KevjObwqehU6MofhQkNASTbpQox1X4Q+DvkzjIy82YHMI=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:41:31 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::ca) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 14:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 14:41:30 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 06:41:26 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 4/4] ACPI: CPPC: Limit perf ctrs in PCC check only to online CPUs
Date: Wed, 5 Nov 2025 20:08:51 +0530
Message-ID: <20251105143851.4251-5-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105143851.4251-1-gautham.shenoy@amd.com>
References: <20251105143851.4251-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe38b13-253f-405a-20ec-08de1c7968d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?me3jDVoWu/HlV5JRgb0jglcdxd4xjG3ZpIOtVmhwsB8fxq5FJELOvVAbrIG6?=
 =?us-ascii?Q?RKyXh/yuoZ4cXVtaZ5CXR1PihgwJqYp/Dk+JN70FdXQOABULB/BLaWuwI/54?=
 =?us-ascii?Q?7N2ifiLHli4aLGs5paksVQgb4xvtxR2TBdcUQVcFbO7FgXE5KE4DecpqUsVw?=
 =?us-ascii?Q?GP60fqvaWAuIKXEaeCb20tvy9rdzVguGMLWIE4RI1X7Dwnx+LXoqbkrixl4G?=
 =?us-ascii?Q?8L3+hRwZHYfqnmZ6jhrxMhfb/H4LurOzoSyph/ch+OlhFSlpXg7tmcOorBls?=
 =?us-ascii?Q?LkMdik+pXu8WawX2xIqXevykrWJZzsq4oToQ+lxMWSpllqiHmyp/VpKh+DL5?=
 =?us-ascii?Q?RDAqy2Ip/QocMJ0hUzQ+0t466HsmsG1E1yd+wxL2Ql2DRlAjUjXAzjYCr7Sb?=
 =?us-ascii?Q?iQOkocaUF0sgl7RwqlYwR04Z9l2enNw/JtRGRtlPpP7Gq4uEe+H7wztmWMiR?=
 =?us-ascii?Q?3p4+8Qkp0n/le4i2SOOk5UEq+TqexuY8+qt17TGKiez6y/ot/Xa6gDIfLy2X?=
 =?us-ascii?Q?prF6TdJg+7YYqQEbbYubMtlyp/38bzCj6+9liNGJ5UommVN1AaW+yBQhBT21?=
 =?us-ascii?Q?H7eNtc89utD08bfhXLLCC3khs98YeTnoYa+RN5L7TJmdjW4996FZYjWUgG3P?=
 =?us-ascii?Q?o8B7Ijqjv4H64ZqsJgCHpb197MSmr0392jsW/Gzhm7l9ZnwbCudVrJegrgO2?=
 =?us-ascii?Q?WeiE8B9mW3n7L86lDjhubCkFuh92ARUtsBvvxCBSDoZsUgzeKhjesGS/6pGB?=
 =?us-ascii?Q?30X10iEX98IQAb7+/J2/mtI3UGB2iN8c9z8GV5NNr4Qoty0oiuQu7kAEpzUl?=
 =?us-ascii?Q?STodvU94bUUVgqyS82ctcsm7oB2KEGmxFpUbf4Wb0ZDMA7qwN+ub502j7sqc?=
 =?us-ascii?Q?iHbJpaK1elxCrgByreFIZoDF10s9VLepc3MW2JLoovMjZPJwI/Ya1kX/NCdw?=
 =?us-ascii?Q?tC5buyOQqvyCJAybjZzvlX/0q89GvWg0CRkBofgngMdcciHnk2RP7hh4NkxG?=
 =?us-ascii?Q?Irw4BmxXyXoKzUEbdbK3+y2vUIC33HiAI35SbNvKcIuQZgW7oC3SPVb4LHxY?=
 =?us-ascii?Q?lSE37X0GoIV4swww97JAWvTdiqanlr9uuzpFn5KIyvjp5zhVM8tMzBFNDy5m?=
 =?us-ascii?Q?2BMvB27QCcVCgpDyWFYIg8c961UEKdA+qnZ3P5+3wAkzN9EVvih2XfpsYhsF?=
 =?us-ascii?Q?qTrQ3XIs3GYXH3cf5v6fqDYAkkdflX4RGmp7qmR4F66SLd0cleBXu7TU00dW?=
 =?us-ascii?Q?b7SOD83R0EUju0lwQFC8OzZJrfx8pCL9DHZZ6PnNoHLstCPd+mFYzNavcEGb?=
 =?us-ascii?Q?3kxPBK7NCLFpwK2PHXJUbf6YW4wWVnetqwPdhjCw6AIl/FzE/2fwMnGSqVZ1?=
 =?us-ascii?Q?ZcEbGVPqgAbAxQOILCRqGF06cqPMfvPiLBr+Fu/j4BMX2kCcc2bis116a42N?=
 =?us-ascii?Q?JikxhCTOsR3OgoknWfjoWstxLDVOg2LRnfcCAtzW9ILDcOsynOX30SIXdGF3?=
 =?us-ascii?Q?r4cQfw63rWLxTT+RfvSb4G38sV1y/YMg5cMJAsUFfb3VrNRG3YDOb/PlkJ09?=
 =?us-ascii?Q?l7XPCoq7XCc/E4w+/rM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:41:30.7255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe38b13-253f-405a-20ec-08de1c7968d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPU via acpi_soft_cpu_online() --> __acpi_processor_start() -->
acpi_cppc_processor_probe().

However the function cppc_perf_ctrs_in_pcc() checks if the CPPC
perf-ctrs are in a PCC region for all the present CPUs, which breaks
when the kernel is booted with "nosmt=force".

Hence, limit the check only to the online CPUs.

Fixes: ae2df912d1a5 ("ACPI: CPPC: Disable FIE if registers in PCC regions")
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


