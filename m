Return-Path: <linux-acpi+bounces-18618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AD0C3ECA1
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 08:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0BC188D298
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 07:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4C230DEAC;
	Fri,  7 Nov 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P5tA/RM2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711C30C61E;
	Fri,  7 Nov 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501406; cv=fail; b=DS/snnRCeGrprrGZ36jjEcJcK5fsVJbHvNheUbTZ/vC9H0kiAfgOp5sLG7Bd1PxGOy+ytEeYsRy6Y+T1NU2dwsiYyod/AeH1af5OakKs5wD+KwKQMga0YpeOk5bUCsbNVot0lm7YrsLTqvA2a8ZRgiT5cop1/ttmLvcUVDx48wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501406; c=relaxed/simple;
	bh=tfJOe93wpWp4aQ5VJj57yIzefkQrNWOBTL8Cp3qe7dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHp1g6Rq/gI+gZfE6KeB0gEzu91DLiidsHcL+DK4gv0U/gxqTs52NivFm3L8WKZUKO+mH6jtHQHOkVxJuGMrQ8J0SxPgzPzErfqpHGGfuJkxahmRTXR/dxCiRSs5mnsbp9dgkfAgLIFOLVC/Gzl/s1piNYVMY9aE68lVzn0r5oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P5tA/RM2; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXTOBkL6Y2mVFJyVPjgTijIyMckBjdxa+ZaBo23DyvGm/RfqRhZ8TvHmUc0dlU0n2+oNggxRUXB7HHSSUnBGbzjNV2zTQ5IfijwGESC6fsKWuoKMoZjsL3q220O5uiOqZNx0Dl9uWOO7Cdua7gjHBxqKaTRygxMohms/ZtTxor5U5sB8AenDeMipKbD5nq6fZxJ9d9p043dLUpP5T1MPDY4wRTlyvcz+98Lj+kpIhbcbUpbBOhbbhzTVsdJpNGClTcnGCQEaetKdS6M1slhtounVPuCJCGAUNXglztJVaykSgwKw102PqvBtQs9E7YiGiKQtzAvUZpp6lgZ3GwDrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdBM184OlOeHEEgkDtBDauPZfI2aDO0KT6fC8cy3NRI=;
 b=R2H/pCqGSi3PpmeHloSON0REeqG7xB0CvDpOr37HiQ7uAd6+jXYqNKSKUqFsiiDq0avXEh4jdua6jr2uX6EdnNof7p7043EJYb42bnrlrxS/gFxfhC1NsSWRG6y9jH+dRvFjS+FbAQhBvQpu5E4AsEGhkRpKU14WVaGScHHmbn3ZUQRVYlgm8XZjYUj2z7zKNIGcl6eV1MWLSMvgtXCPKC9lgD7TU2q2o4sArhs8bncLssgkadoDSKyrBW1i2wxJB/RZCLb8L72expO/O7AIa7rRXOo5fJvdJLyIiyByTDLunPKJCrLyJ9x3zenzyrlN9HQrHGFxml4yWYhAIL/g3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdBM184OlOeHEEgkDtBDauPZfI2aDO0KT6fC8cy3NRI=;
 b=P5tA/RM2xKftlyAxGKrcuu5jmxiCOatoj7tpwQ1/k9oOuXZ2C3vCp50Gib23fD71SS9rijSXB68HUsFKjIt2tj8j3pDfofaZNRT1hT8pMFfymxWJsDNX7daXp+0lN1R54/FT4mNjCgBhX/Mma7VOJk8LmOL8wIWFzZuJg4CCGD4=
Received: from SA0PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:d3::16)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 7 Nov
 2025 07:43:20 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::58) by SA0PR11CA0011.outlook.office365.com
 (2603:10b6:806:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 07:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 07:43:20 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 23:43:16 -0800
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, Jeremy Linton <jeremy.linton@arm.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christopher
 Harris" <chris.harris79@gmail.com>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, "Mario Limonciello (AMD) (kernel.org)"
	<superm1@kernel.org>
Subject: [PATCH v2 3/5] ACPI: CPPC: Perform fast check switch only for online CPUs
Date: Fri, 7 Nov 2025 13:11:43 +0530
Message-ID: <20251107074145.2340-4-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 63196d4d-3cd4-4ae8-e773-08de1dd152cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3zvLFCmo1njtPffEMJnRse38wNVdC0x9BlsOATA9rnBgtgjWxlaH/5dPdspF?=
 =?us-ascii?Q?JM7Vm0SmT4SzPp8BnxennX3rC2CE0zGhcZOLx+nuRtYQyZ8gvMMwr+vFvUxA?=
 =?us-ascii?Q?GNlyFMha31W5pAPswrr91vb7NLRbUf1dPqMSr0HC0L/kjT9EC6+9m4Pj1ghq?=
 =?us-ascii?Q?31W98xL6cnR6G9CUFGvjpuq+7TxzbVmHogLTON9sV+ZQa68HuodOPFKUZS/d?=
 =?us-ascii?Q?LUd0mBftid+ZW2SX0dPYGtLprotqGdaz4LZ1gAT7lqtBRo+/t6uR22jNzhtY?=
 =?us-ascii?Q?s8ttyZxRRSsbuHJWZsjilRqFvV1f9/TN3M+trnertyp5N+6GCUts5/BO+oFV?=
 =?us-ascii?Q?0YBHprZiibD9CUPxTOioWuGGTqw9ljSuV+DGEV+K7zYTqSUF1/93h0ZamU3p?=
 =?us-ascii?Q?J2zS+GdswllFo/FuaBc/3A/CKfP7VBcWU+yidq/1fIq/ct/AAOP3tvteMqTO?=
 =?us-ascii?Q?GfWiZ1VtHeF+eh+/3z4a2aBeIVvnTLg2QCC8cGhCdLzdvQk5z8UWeVMjcy40?=
 =?us-ascii?Q?OL5m9pFs2CyEWcB7nlwD3MdwDbc8Jq7ENWdq4Qrv06aDHz+mfPPkzJ1Zvu+0?=
 =?us-ascii?Q?VkD9uIfHcrfPXs5QjXiTX2JpwMmIw7Db6F2V+ggY7n52JJsbUtMmOywpJ7aX?=
 =?us-ascii?Q?xELmMjN89M0HyHyKiqcN9MqwZyqHicFS9VRRDo0GEnXg6LSqzHLphQNjP+9a?=
 =?us-ascii?Q?T6tk3NlSvATm2LjDyeV8nV2f36lEptlxXdc3MVEhoZzYZrDkE/GerFUAlx6T?=
 =?us-ascii?Q?zsFhMpKRaMo/HKIoVSNbgTNXt7l6K5+Vb0k28HG3ZaVuL78yE6BBHt8Cnk4a?=
 =?us-ascii?Q?ze61IcMdM8oYDoJkkCPovmP6SPrC2eP1N7bdPhJBAxm3nXSf/EbPhx4mvGle?=
 =?us-ascii?Q?ej/Xb2XOrdD6ABflqGsqCAywxOWGFh+UQ/wd81HPii2PtuEB8R07DLureXUo?=
 =?us-ascii?Q?wxGBHlFn/g/AFVrlWzzkSPeubZS/Nk51E/FTGvsLeCaiZy/PdU46eTdzUPtW?=
 =?us-ascii?Q?6BFxupOwVPb9wsITrByEEyZnC35cxl/iSJ6Ncd1jdMv1qX5Ow3EKwiEkSI7F?=
 =?us-ascii?Q?zpQt07S9vASTW/2O53ZLhcB7KBCdGEg9CeKNLbLv+TwU+NRZtBzdtnTefwAy?=
 =?us-ascii?Q?GNXP6rO1m9hcz4GHSzq+ts2u607NPa/JiaNyZUYnc48vfGhdxZqHU/e/WBZR?=
 =?us-ascii?Q?GYoST3C9WhHR3pRJOCbEXcFaTg/3wCUixGB9ngvUmHDvpbeytx28t05FNXMs?=
 =?us-ascii?Q?+PRuNN6eVOz8ME0xZiNDUCigrYoEtJ8q8Ye8h2aE1H04yR7HyyXzZpmP2GZ6?=
 =?us-ascii?Q?Ucv2NuC2TtpAmbZu/4H3nVaYXew857yte6JNl+SqxeluvB1gaaqKW/8A5yn1?=
 =?us-ascii?Q?hXAh/Qa/6ji81iYmmH2fHxj5HqAFEftieuOscSwg4C+IiH9ERdcAu58tESyP?=
 =?us-ascii?Q?gKcskdTS+KoQ7Wd+IPAVNOx7Bv5TYOXZt4gKkrSKiFLs1/8S12/a8wDFJteW?=
 =?us-ascii?Q?1ONCRlQ3r4pkvfVP1+oJLQgaTIAtRW6fwCivuNVn4cAzflRxjpc3tyygBbz4?=
 =?us-ascii?Q?fZ8WCJ6HFWjHE1bkRQ8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:43:20.7169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63196d4d-3cd4-4ae8-e773-08de1dd152cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

per_cpu(cpc_desc_ptr, cpu) object is initialized for only the online
CPUs via acpi_soft_cpu_online() --> __acpi_processor_start() -->
acpi_cppc_processor_probe().

However the function cppc_allow_fast_switch() checks for the validity
of the _CPC object for all the present CPUs. This breaks when the
kernel is booted with "nosmt=force".

Check fast_switch capability only on online CPUs

Fixes: 15eece6c5b05 ("ACPI: CPPC: Fix NULL pointer dereference when nosmp is used")
Reviewed-by: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 50e6348b511f..fb7696b27d82 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -476,7 +476,7 @@ bool cppc_allow_fast_switch(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		desired_reg = &cpc_ptr->cpc_regs[DESIRED_PERF];
 		if (!CPC_IN_SYSTEM_MEMORY(desired_reg) &&
-- 
2.34.1


