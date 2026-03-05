Return-Path: <linux-acpi+bounces-21390-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPo3EKYTqWlz1AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21390-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 06:24:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C120AFF4
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 06:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298393006977
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 05:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9FA2566E9;
	Thu,  5 Mar 2026 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEtUogeY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40921274FE3;
	Thu,  5 Mar 2026 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772688136; cv=fail; b=odNrMAaQDXyil8+9C9edhrFsRYXgct96GLyey07melmYcNHti4h7/OE/5HxPCd84IyxagSMGkX7X9n2Gtrl8Qhwn9u0IXflzdBp3wLPUDmfx0SaBVlTk1qX6HXt2P7ZJw0fmOrW3g6sULlAmGV302l1x4PpoBg72o9eKy42H+HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772688136; c=relaxed/simple;
	bh=fNIjFOr8pt9ih87y+a5TLWNaeXGbI5bkasfJnq1GN7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DI8iv/ZFa5sUjeXy+rwtQfP3usgZARngFUp/XeEPcyjZxKscD97cK8WzNCUBPWGDAXcPvgsmaXbjUfgEn3b75sphQqqyAv7hE7WthFv3joDR+Xu1lgvEBDUjZHMZy8LxhQ5MMsbN29jeemK1V+NL45IzmnkqCN2jXPlqnLtsWPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEtUogeY; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wm7iz4MM1BMJ004uo+YbWq+L+tj06X2jGhlvv+gDNTvqfoXuZFnBF4/O8UZVglVH8sRIpwO/S9uPG7pWq+o886qSHpsWg/MRqx5D0rDszGb73hrM/egXCSVO5GDloNyg/CNRZCLXRiVujO42SshrzP8LDYZfwPIm4ezyHQ2NpO0jsf4TO0S/61LX9d3pwwceAYTDnWbMjGyFbU9kck0aC081zU/2LnN4Z3mwfAKesZ0kMeVBzU90d6skULpR0vW/7qaSv9ICUAj6w0ZQKawQKFBYmA4lJkZxHfXnFG2FfRx0yRX95Ozgh1tgpxS40otCKZeKSwNotPyzxNvm25k1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlaaQZpHLAODjG2gD8zOI9Jd1MHMCbTvn7hp8seQZ8A=;
 b=Vo0ti9bqrIsSVBEwwxGbbxDqaQfRxs3WkESNYtcXeIt+Qq0OR7P0LnLENxTXhcceKmUOXikTLNdG25mGqIEnVOIGm3orVzNxpb+HQhINSTtBXXOYyiulwPtW5ttoucsDJd/RjXdXwhGWnZLFJxHaAsi3cy85ggHlBIElXKcS4qd0e21PwtzkytLQj55pZOf2B0utcR8/cSj/0roM8MCdtmH23LAdFRGfIDYgDPz8AuKyx+suTTyffgNcmlR2J7hKPr3IXWZV4YPGjF1w1zhoxUXI4NYxnmH9ghnOOvvmibqI7YU7tRHow05/VzI/yQ1EXNfQez9YFc8E1EUryeU2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlaaQZpHLAODjG2gD8zOI9Jd1MHMCbTvn7hp8seQZ8A=;
 b=OEtUogeYN7gXhuDYsClTYIJJl3Y8NGS6GSaJUPokcjY6MlY17AKc7bf3uqWzPlfBEfKqVQCvrnsOkZzOMW4zy8zyYLBKv8DbDrKZEz97RcAlAy9/A/I5FmgvZbhhS/pSYgL+1PIH6GG57iCju3hsRX+zxxMOI6BsW8lRmCsMTstuetSs22g1U6KZbcM8K+8jlIWQrL0mxikDMDLdQ1Xxs7Oy0lmw12quamX9I+FB+90tnEp2/Sx9cfdEs2ywJBBtiv6lt92lgz/1XVL+makoyJ0b97NhoOoe1GfP8jVwQi1Dcfb3x7D2MT6kDbmcvLAJjSe73NUe0C0DRTTtKT6ogA==
Received: from BY3PR10CA0018.namprd10.prod.outlook.com (2603:10b6:a03:255::23)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 05:22:07 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::48) by BY3PR10CA0018.outlook.office365.com
 (2603:10b6:a03:255::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 05:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 05:22:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 21:21:55 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Mar 2026 21:21:55 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 21:21:54 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<kees@kernel.org>, <baolu.lu@linux.intel.com>, <smostafa@google.com>,
	<Alexander.Grest@microsoft.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Date: Wed, 4 Mar 2026 21:21:42 -0800
Message-ID: <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772686998.git.nicolinc@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: a4693288-f725-41ba-4d87-08de7a772502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info:
	0K4lmuGVAKugsPo7cQ20tITaYdoLmlFdfLe68h3swP2ci5XybWv4N3zelycboea6LWX40vkIge5ZViKKg8RDLO/6oFJzcLXo6C6KRyisfLw6d2FsADaLarABj9AOPGsKzVEIY4V7AY0ZZ952gABiVEqkyE7oIa8Ocr5NJgvzZdY38iGdsWDeqixwEmzE2A21M9l7a/zdhvB0frc9Qjf8uZZ9cSDPsLMx023/JQaX2GfDvnjIF7pbRSwQQzQOSaXpPPgYfmBvRH4hpUCkKuv9dVsfDNVRp5KVzWEOrzwkyBVC8V6SS8kYDc+wG1I5O15bAgS2RhvOvBZcdVoFW8HvvDlaODhwQFbDwpvkhVEdy/uKyyC7Une/g8Ar0Fq4aUC2T2zOQRYH86VYE39EMoOaVPAgpyJRMJhtrRN3ttHeiuGVKST0oJyVWGgV9A09NY0UZTQdWL0/cvdORVRmFb5rovIMetydr/67A/NzlOBxJoiNPIBYwe/+KXUDTY3kC3sqTQhKW7cKqMvxDBmF2Y3SKhvHvTGg9XglIBh7vFhaH3i1UcZ7ZuL+XajIx5SGb+lqKHJAES5Ws2opqK97U9tugvXzbsz5Jkri8xkjUgzje4CnWZXd+t/h1f/3VIRai/8XDgRmx+VClhYK4VeJH/O6jE6VFo39SR8cJOA4Gv0kCYEt3hz0lHZDh3rNi0vy7fVpRyuii7tM/ZZOchre3OY0UK/hGXUh1HFn2WNhhotrm8d7hMglPcEihCPFF8IlqFDSzXYrQjnXo7oDroBzBx5JYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jY9Zn4UEISErbFAkUAEw9ZKyzFR3NdyJZAU/xM2fv0c0T0EYlWtNDIar2Ja6GuX4o+piqcA4TBkHVpUUy2uTTVTUgkPFj7/quxpjEqD01tRyMP6VfynDslv750MNxGjVpCzW2uqzwywG8lgWMUBS/apO+22W1VWfcUbI6J52iD97iKJySe/r1PI/UB0P0zHBh8jYl449aBU7U6hOMg8S8wjsJs6FGQinKRN7Seh5H7To19gzrFs1tBDZ+85vLb6VyKLE/5sVo3s3GI4GVCIMMHuIob57yKRI2Avi0S+FfloJXIGtuMgHDOW+YdSkwCC1VIU7gKYqM6Bxp2LF67evHyJj+8+hzsNAmuJf79aKV6YcDB9gfMjr5RnF+IQ/smON1TT85amfcW7yxxrj/DAjQ5SIILfacQ7dklbQ7VjPkcyxELbaDLFkfOP8EUtytOKi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 05:22:07.3580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4693288-f725-41ba-4d87-08de7a772502
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827
X-Rspamd-Queue-Id: D49C120AFF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21390-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Currently, when GERROR_CMDQ_ERR occurs, the arm_smmu_cmdq_skip_err() won't
do anything for the CMDQ_ERR_CERROR_ATC_INV_IDX.

When a device wasn't responsive to an ATC invalidation request, this often
results in constant CMDQ errors:
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb84): ATC invalidate timeout
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb88): ATC invalidate timeout
  unexpected global error reported (0x00000001), this could be serious
  CMDQ error (cons 0x0302bb8c): ATC invalidate timeout
  ...

An ATC invalidation timeout indicates that the device failed to respond to
a protocol-critical coherency request, which means that device's internal
ATS state is desynchronized from the SMMU.

Furthermore, ignoring the timeout leaves the system in an unsafe state, as
the device cache may retain stale ATC entries for memory pages that the OS
has already reclaimed and reassigned. This might lead to data corruption.

The only safe recovery action is to issue a PCI reset, which guarantees to
flush all internal device caches and recover the device.

Read the ATC_INV command that led to the timeouts, and schedule a recovery
worker to reset the device corresponding to the Stream ID. If reset fails,
keep the device in the resetting/blocking domain to avoid data corruption.

Though it'd be ideal to block it immediately in the ISR, it cannot be done
because an STE update would require another CFIG_STE command that couldn't
finish in the context of an ISR handling a CMDQ error.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   5 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 131 +++++++++++++++++++-
 2 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c6d65d36164f..8789cf8294504 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -803,6 +803,11 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+	struct {
+		struct list_head	list;
+		spinlock_t		lock; /* Lock the list */
+	} atc_recovery;
 };
 
 struct arm_smmu_stream {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f0783..de182c27c77c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -106,6 +106,8 @@ static const char * const event_class_str[] = {
 	[3] = "Reserved",
 };
 
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -174,6 +176,13 @@ static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
+static u32 queue_prev_cons(struct arm_smmu_ll_queue *q, u32 cons)
+{
+	u32 idx_wrp = (Q_WRP(q, cons) | Q_IDX(q, cons)) - 1;
+
+	return Q_OVF(cons) | Q_WRP(q, idx_wrp) | Q_IDX(q, idx_wrp);
+}
+
 static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
 {
 	struct arm_smmu_ll_queue *llq = &q->llq;
@@ -410,6 +419,97 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		u64p_replace_bits(cmd, CMDQ_SYNC_0_CS_NONE, CMDQ_SYNC_0_CS);
 }
 
+/* ATC recovery upon ATC invalidation timeout */
+struct arm_smmu_atc_recovery_param {
+	struct arm_smmu_device *smmu;
+	struct pci_dev *pdev;
+	u32 sid;
+
+	struct work_struct work;
+	struct list_head node;
+};
+
+static void arm_smmu_atc_recovery_worker(struct work_struct *work)
+{
+	struct arm_smmu_atc_recovery_param *param =
+		container_of(work, struct arm_smmu_atc_recovery_param, work);
+	struct pci_dev *pdev;
+
+	scoped_guard(mutex, &param->smmu->streams_mutex) {
+		struct arm_smmu_master *master;
+
+		master = arm_smmu_find_master(param->smmu, param->sid);
+		if (!master || WARN_ON(!dev_is_pci(master->dev)))
+			goto free_param;
+		pdev = to_pci_dev(master->dev);
+		pci_dev_get(pdev);
+	}
+
+	scoped_guard(spinlock_irqsave, &param->smmu->atc_recovery.lock) {
+		struct arm_smmu_atc_recovery_param *e;
+
+		list_for_each_entry(e, &param->smmu->atc_recovery.list, node) {
+			/* Device is already being recovered */
+			if (e->pdev == pdev)
+				goto put_pdev;
+		}
+		param->pdev = pdev;
+		list_add(&param->node, &param->smmu->atc_recovery.list);
+	}
+
+	/*
+	 * Stop DMA (PCI) and block ATS (IOMMU) immediately, to prevent memory
+	 * corruption. This must take pci_dev_lock to prevent any racy unplug.
+	 *
+	 * If pci_dev_reset_iommu_prepare() fails, pci_reset_function will call
+	 * it again internally.
+	 */
+	pci_dev_lock(pdev);
+	pci_clear_master(pdev);
+	if (pci_dev_reset_iommu_prepare(pdev))
+		pci_err(pdev, "failed to block ATS!\n");
+	pci_dev_unlock(pdev);
+
+	/*
+	 * ATC timeout indicates the device has stopped responding to coherence
+	 * protocol requests. The only safe recovery is a reset to flush stale
+	 * cached translations. Note that pci_reset_function() internally calls
+	 * pci_dev_reset_iommu_prepare/done() as well and ensures to block ATS
+	 * if PCI-level reset fails.
+	 */
+	if (!pci_reset_function(pdev)) {
+		/*
+		 * If reset succeeds, set BME back. Otherwise, fence the system
+		 * from a faulty device, in which case user will have to replug
+		 * the device to invoke pci_set_master().
+		 */
+		pci_dev_lock(pdev);
+		pci_set_master(pdev);
+		pci_dev_unlock(pdev);
+	}
+	scoped_guard(spinlock_irqsave, &param->smmu->atc_recovery.lock)
+		list_del(&param->node);
+put_pdev:
+	pci_dev_put(pdev);
+free_param:
+	kfree(param);
+}
+
+static int arm_smmu_sched_atc_recovery(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_atc_recovery_param *param;
+
+	param = kzalloc_obj(*param, GFP_ATOMIC);
+	if (!param)
+		return -ENOMEM;
+	param->smmu = smmu;
+	param->sid = sid;
+
+	INIT_WORK(&param->work, arm_smmu_atc_recovery_worker);
+	queue_work(system_unbound_wq, &param->work);
+	return 0;
+}
+
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 			      struct arm_smmu_cmdq *cmdq)
 {
@@ -441,11 +541,10 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	case CMDQ_ERR_CERROR_ATC_INV_IDX:
 		/*
 		 * ATC Invalidation Completion timeout. CONS is still pointing
-		 * at the CMD_SYNC. Attempt to complete other pending commands
-		 * by repeating the CMD_SYNC, though we might well end up back
-		 * here since the ATC invalidation may still be pending.
+		 * at the CMD_SYNC. Rewind it to read the ATC_INV command.
 		 */
-		return;
+		cons = queue_prev_cons(&q->llq, cons);
+		fallthrough;
 	case CMDQ_ERR_CERROR_ILL_IDX:
 	default:
 		break;
@@ -456,6 +555,27 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 	 * not to touch any of the shadow cmdq state.
 	 */
 	queue_read(cmd, Q_ENT(q, cons), q->ent_dwords);
+
+	if (idx == CMDQ_ERR_CERROR_ATC_INV_IDX) {
+		/*
+		 * Since commands can be issued in batch making it difficult to
+		 * identify which CMDQ_OP_ATC_INV actually timed out, the driver
+		 * must ensure only CMDQ_OP_ATC_INV commands for the same device
+		 * can be batched.
+		 */
+		WARN_ON(FIELD_GET(CMDQ_0_OP, cmd[0]) != CMDQ_OP_ATC_INV);
+
+		/*
+		 * If we failed to schedule a recovery worker, we would well end
+		 * up back here since the ATC invalidation may still be pending.
+		 * This gives us another chance to reschedule a recovery worker.
+		 */
+		arm_smmu_sched_atc_recovery(smmu,
+					    FIELD_GET(CMDQ_ATC_0_SID, cmd[0]));
+		return;
+	}
+
+	/* idx == CMDQ_ERR_CERROR_ILL_IDX */
 	dev_err(smmu->dev, "skipping command in error state:\n");
 	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
@@ -3942,6 +4062,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	INIT_LIST_HEAD(&smmu->atc_recovery.list);
+	spin_lock_init(&smmu->atc_recovery.lock);
+
 	mutex_init(&smmu->streams_mutex);
 	smmu->streams = RB_ROOT;
 
-- 
2.43.0


