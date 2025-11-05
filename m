Return-Path: <linux-acpi+bounces-18548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E9C362BC
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 15:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BA7566EB2
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94152332EB2;
	Wed,  5 Nov 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="290pJybM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465432F753;
	Wed,  5 Nov 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353641; cv=fail; b=IGAhldA2d1vJ/gaN20IqrbakleAMqJDZe8uBzvZ4rryrsIQGro2h6dR49Z7RDrZrAfATJOhNfVZl40KWRfnPgezDk/Oal5y9KKDwKTJJ320/1YQ3DFHqmhgWTnRalOQFESql3yfpe77kkl/flhJi9RwrUnG5AXVTnBwQopQeCR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353641; c=relaxed/simple;
	bh=Ske18UpNe+6e/a8Ssht93pa8QczkQG2+33lxsyYqsGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5jHVT6WCxMJKE3LMgXZJsXotQiEToWmny1t/oTnXEW7FiFRBByVzn7h3TfjGfSOdM3WIeGpzMjqRHpeSTpC0yx7K3wmIPTFzgbhEhT0fCyRWI6pcC9IlZywYmSzisGQ9nhNM+q8XDpVdqTCEeo4INDaQDh4n260B3HRXmwPMWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=290pJybM; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgrNGxTSYawYdE8K2l2T1blR3lybR9Q7LkPYFk/TN8L0Z0fza+Vwyw3kICLfNJ2sBz+NvnI1j8YIWHhYZZkxU5hBZIFTL+e1J/jQAozJcr5CYpVEQ4qBiRp6BQB3Nc16Ihfb4bgMOh/6pCADzVyKgllwhOjUsGoJkI0Hdg6LGvdG2vdc/Zz86NzLLJlWehw1seG+W2wSs9PgwY4cc62UKSf2i/9xPMZPL9yjzOZonPgbUtwRejpLJPt10tdFosVwSivqVx5EDFrFg/FmVMYDnYlZKndrxKKAPvSg6k+h3GypHCUpQaLomn8yy8zgPdcEX/qcB7R5ww+oIkP8yI3CZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10JC0U5Ndu7c60f2UN0F3f7RShDyiL2fwnXtlGggVyA=;
 b=A46zHj0PujZp53hSoA/1aoSMT8kkUU4JZ9PqAP/tYAu839JIAr4UHl0apf/ShSh0rkvqcjnLIhDkNWswFAxheBqLogbi8kPZMxnqv+mULx1OxdVBx0ka49ctQBNdvUoEKwAnXlzLWvmrBVZnw1b8eWAzY7MhHDf7GXo654TJyFMwB7HOFtNEEaovYCZlvDeaYAHDPp71by1wuY7+EtQ4GtCiwETYeDr4bqiB6XeHYsW4E5CWM/LsJkkpeouYkLJ36yWXWT8u80ktnuyw+3JuOVVm0599GUO0qeOQK+rRpJWmXCd2Fmqzi6ZxywTjOu1Ufvle1maAWD0xLIxe3iT3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10JC0U5Ndu7c60f2UN0F3f7RShDyiL2fwnXtlGggVyA=;
 b=290pJybMPOVl9QnOL+aJs0F05qAOHMKThH1Ojbssz5wYdZoucddIj8oD2XYzDMDf+1DbUUbtb5YcOpTITWdn5VLEVwGt5ONURwTg12ssuhN3cgDgcXPKRFYvzfEYz7d+aS5Mx1OcJTEip7D54eq2Lc3HMpp3ttsjKdDSaJf9ZSw=
Received: from BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) by
 BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 14:40:36 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::f1) by BYAPR01CA0044.outlook.office365.com
 (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 14:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 14:40:35 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 06:40:32 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH 2/4] ACPI: CPPC: Check _CPC validity for only the online CPUs
Date: Wed, 5 Nov 2025 20:08:49 +0530
Message-ID: <20251105143851.4251-3-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: b31cea09-54e6-4a48-35ac-08de1c794836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25Kk/VGv5zCW1aZMmgQJFrrgoPydPEmuryLU+uCMu4TXFOXBDpPFTQ5/97Vu?=
 =?us-ascii?Q?N7pBEtS8ODTH4d0S0xQgN58/30SrplF1C3vqpG2UVGGMNKxbi6XfWTTcHTwz?=
 =?us-ascii?Q?V9XEvN4UBbvGHmpIItwqru1nBiDN5GKMTuGPwbIgUST1XG4AMjFpTMr1B0fy?=
 =?us-ascii?Q?lvJbasxwYuF3kBExTpOkEb6HhPCoIlbUAbm8wzslGKij2CA2WeqlXXEwc6wv?=
 =?us-ascii?Q?J/ZJL4qIZTpxgzGFZtCJWKnwEdjZsxu+mSROVGGeQc7FwFpS4cEyF0XTf8su?=
 =?us-ascii?Q?rAJaahpfdE4UAfoqCH6n+TzjsUnGwoyePHbmaniv34XaWdoIL18qa+xGvanl?=
 =?us-ascii?Q?2k1yCs2jutc1TsTjuzGURJWl2zjeUwvJiu6+iOZstvNtOyBUeH3Dkc7okmwN?=
 =?us-ascii?Q?t/1XVku4YIIVk5tZJn3P/xBz3gSWUbIgjx4/WW8YYXAd/vVvbHNU84xjqwLU?=
 =?us-ascii?Q?BdUF5wKDQcuYzlkHnQQbQ5AJbpCGwWKizHcII53HvnfPXBh9RdokBPxf6zph?=
 =?us-ascii?Q?HdUWzwn5UDGFV3tGGTYNvR3yZuOPpfd5hSPY5fpZo2+hJ3A5TS+AC1Nbg1Vj?=
 =?us-ascii?Q?6sQ8PdptNUAapimaTzz5vtD3d2ZhNQxyPE9EZnD6aaoB4zs8rmIMS1xgWe7A?=
 =?us-ascii?Q?HjaRXbr7dChlfDkiLZX+vwZ1xdolAkd7RB0W0JP1JbF8bvbSR4IkX4wU4Qel?=
 =?us-ascii?Q?HQwyxMEe9nG5AtQ0mMnzZKjxxPeVyNGE4HBsSqOOkuiPg+mpK0fVMB3+H3zH?=
 =?us-ascii?Q?55UTmE/IvMSffXtEq9onCD0+3QNNwUxO7a4LA9tQCZq5ar3DNCTl6Q3u/A9d?=
 =?us-ascii?Q?XRa9OnRKMYSAjZ39SOnYRYji3MvlUBrGaR7BIA7YKj5vKOdSw0J7IDRjrQqP?=
 =?us-ascii?Q?jjEq6FzkwuMUA7WldkiMox6YXZcFYP+LQdk3E86Ni4gO3fPWGbIGf59ICmjc?=
 =?us-ascii?Q?89Yd3jnSKbnKliK6Kc7eoei+LorWwY6RgwrpQQWImdHGp7h7T2yag+Nb0OEM?=
 =?us-ascii?Q?0bicNJCs3hQtgWbIVwQSxe0+WlN9nliS6niV+GSzjTAPVxzLXXSSA2BOZsWp?=
 =?us-ascii?Q?qJlLlEHc6KMl81ViFGtq6HmU65fisGSfroBH+DlKns7brhEAAW+jibfzCSAf?=
 =?us-ascii?Q?P/Zt1aSx9BYwCrGVPKIjFzaS9jVKiiO/JlP4Yqnz8OELtaKde7qfIxNKFg8z?=
 =?us-ascii?Q?6NxIBZFZkSBh4BhGAUulZvJrn21bV5QWtZjlD68HD53hIQH6CDqv0v7IQ8P8?=
 =?us-ascii?Q?/SHi4QNvErPcM0dC8T7XU5ELJf+Kd4RuIcbtXudwFUj6a2ECPjY3V2eEvKdp?=
 =?us-ascii?Q?TH5MCIpGGnLZ8XVdm9jI/ryJ4mAv0//ikcc9RhNCuYJbOk74iB3N1ESN7flf?=
 =?us-ascii?Q?epIeZhWO8LbGHxyQyhuMIUqrvBEPpmlk22wRqm/QN3nFnFnjADZI8A7JUVuV?=
 =?us-ascii?Q?ML52iUfjfIArVyjy0yb05KMZqVKOZWzetIjT3Xu5nntmqEGAI4bUlEvuOmIn?=
 =?us-ascii?Q?CWwz8IEkSPNnASnYnfescNCaW7JR0PtqvylAFKy4N1tTmeaOrp+s01xOAqPW?=
 =?us-ascii?Q?gadaY/Eb1quz+vpOOfes1bQS5BqEl8QRW3TkkKqw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:40:35.9961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31cea09-54e6-4a48-35ac-08de1c794836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPUs via acpi_soft_cpu_online() --> __acpi_processor_start() -->
acpi_cppc_processor_probe().

However the function acpi_cpc_valid() checks for the validity of the
_CPC object for all the present CPUs. This breaks when the kernel is
booted with "nosmt=force".

Hence check the validity of the _CPC objects of only the online CPUs.

Fixes: 2aeca6bd0277 ("ACPI: CPPC: Check present CPUs for determining _CPC is valid")
Reported-by: Christopher Harris <chris.harris79@gmail.com>
Closes: https://lore.kernel.org/lkml/CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com/
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ab4651205e8a..50e6348b511f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -460,7 +460,7 @@ bool acpi_cpc_valid(void)
 	if (acpi_disabled)
 		return false;
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
 			return false;
-- 
2.34.1


