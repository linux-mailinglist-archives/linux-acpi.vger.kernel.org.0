Return-Path: <linux-acpi+bounces-5698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F68C14FB
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760DD281532
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431917BAE4;
	Thu,  9 May 2024 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qei5f/NB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806821A2C35;
	Thu,  9 May 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280326; cv=fail; b=cHyrNXCMhu2lBAUIwTmWBd0TxwEQtDiE+df+LaGVJwiNDR2EWNSWZ7Wtu0uKd02AYJ8pf1yBPaRC+td5nNlk3iJYFrtEcMYFIP3VO2Dk5LSbEjmioBMyPFNmeXIHn7q2M7a2SbOptm016nQzmbz6fikcR4cmsOZJyHmbywTMYPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280326; c=relaxed/simple;
	bh=+Hr1EpkuY/e95c1dA0gPWgh0GStUk7+S3RodskdbKQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTBvyGkuW8iymDg0spHfJISA8SlugH4T+6VLliN7ool721i67H00aNcP5x+vvVA39f9iyHKy8Af7zAEZ9opIgTvr0OhP6dkegznUmKujkqgVzLb9gebV6jQXfT6Jjl0UE0D8BKdXSUaW0SvUKSLQfS4G3GqTgflnWtmoJ7j4cXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qei5f/NB; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1An+D1fCE89q4d0Qbi0PsRMgA7J51H5b/E6J3f2WbBLhEZr23MQTt/GzsrgIKKJQtaAzn97HOxX03ujtUoHxu8zjGFPNRlFvQPvKQ8eoqCrVAYXA4A6bk2hJ3dHgWVc66FzzgJkxwad1v9MhNC2b9A6psL64xrbDF/NhPDMNX67dFpqIhacaSv4pTXF/HI+sWGwfdNnSMSMDd80/uVKl54qXJFu3JZWv2mo1Bdq+xWHhQ+Fw412brpDSohp4fiQ0zJ0SrOPGtprDzXkxfBSW9Ry/Kvyg0Q9xD8ep35XaNCL35ctCRybruOB19NdRGMe+mkD53wjubdhE94/q6ZzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS9c61cD+iqzMewqa2kBZ7Ae824L/NlWEGGttar6pTE=;
 b=X/sU6/nx5+VE1cFkdyFNZPn5fSQH8WbZrV5gwh+u5XvJMbuIiLxUEdQpCKyhCifW2ssFG/XPNnSQFY0ycVS+HUvaMxVfp5u0HwOLjvFafEuikEHgO5DzU/gOvnNSWR4ZxPtvzATljug4BJRkIPhzQUrVGDKZz+KNpkIXdTW2HtpAHOhlk3qfUnyg/kdXNFc7Jp4+0+uqEcnDu6MpfpVLh8WOYqP9V4bW0MhWZ9aL3DV/yiDPbM+poYjgx95hKLRBmsTSa/6BDJruRjdp2bVBzL2UByDXJB3IuSpIxeeohRhwRDo+Pk3M342vBsTyBTNjYkA3wrawF7S+MyuNm0oo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS9c61cD+iqzMewqa2kBZ7Ae824L/NlWEGGttar6pTE=;
 b=Qei5f/NBHWj5RL7cMBxRGAY1RWjsebvK0chHh7+0zNJvYHUwGfsvakwrbJVNbSuTWkTic8j+XAqFNzzB5EGrOt/EYqde/3XiJ2qdfMOlX8rsahN++C9N0mq7o0v5lt4z1CLl+SEoi0Dt6cyo8tCJfaFYkI1tqTZ1Dgye2500aI4=
Received: from BY3PR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:39b::26)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 18:45:22 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::b4) by BY3PR05CA0051.outlook.office365.com
 (2603:10b6:a03:39b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 18:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 18:45:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 13:45:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hdegoede@redhat.com>, <Yilin.Chen@amd.com>, <Randy.Perez@amd.com>,
	<Michael.Chiu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] ACPI: x86: Force StorageD3Enable on more products
Date: Thu, 9 May 2024 13:45:02 -0500
Message-ID: <20240509184502.52480-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1436e4-6248-4942-b267-08dc70582e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fbVO20rG4JDhKEWCGmaFbRM3CKCXGk1JxIK5lRtpNwHYdlwFpYen16esTA1T?=
 =?us-ascii?Q?1yy2EkWNYZ8ddmkEIjsZz7lXJDq8TmX+I/26zk35fOvFBNBm+XrRhLovoI9q?=
 =?us-ascii?Q?1EcizxmKcUdnI44GRL3DXvcyZrC/YYCsOy1yYp7bCTGYRfFZE6jAR60ibCtQ?=
 =?us-ascii?Q?6wDv+Kt/vbdyGgy+40JkWb7bKx9+i9uPb/cvUPtQRSPi8zQ4FEsAoEQGELUp?=
 =?us-ascii?Q?lD86Ow48tr1svIuubbDoQ0fVMEce46Y5vDG7oVqtltul2lYBvnjIsrCQpls1?=
 =?us-ascii?Q?ZIuqs3lYBhYIuo2G6nGPuSuljSpzVmfM4oGhuZwkt9TSPkm8vqfmzrOpZohM?=
 =?us-ascii?Q?nKFz8hjROqNeDE//L6dRR3qKf9uHkFRuz4SEITvMMvbSH9bGdFKIA7lRRQ2G?=
 =?us-ascii?Q?BhzgyO9V4Llv3Cd1lAJ9KBTcH72oIObzYxiUQCjqxFOQF4tCGUEmxK0pQm1o?=
 =?us-ascii?Q?6FiPQjzjUnQnx2EbjrTCbDZc9g5YTreQCn2Xsbi93CChvtdNQADEGk1R/sya?=
 =?us-ascii?Q?3DNyGvQwJ9uQtcF6r8JURpEhPXTQJdslw97yHZ0zXJttKeaCfIIVDPc7rKgd?=
 =?us-ascii?Q?HsqFZBtX64B6jsvwGqkB2iNeH464AYvFr+xIaz8Wt5twtUwSsnG3/d25nmTH?=
 =?us-ascii?Q?ozk+ruoO0cmj7RQRsAqjwwH2W183/6JFZJcDXSrOw0LitK9R68KtGYJkD1Ot?=
 =?us-ascii?Q?MRi6sYhcJsVY7hxuYWwMg6xmLd028fGzBPipN3kInjQq+kKYA2Dz++5snPkH?=
 =?us-ascii?Q?fPoeMMmyY0oSdaMQl91c+QKvpfpSWYuEVIgj7SkHegIFnXAeAdSbiqDvj3ZS?=
 =?us-ascii?Q?gvYTkNZvYgrdUQVe9Ct6B86oidXfB35P58nyfPue0uZIZIxmjOMTdm9KajkO?=
 =?us-ascii?Q?3TIHxb3228n6F+yKdLyYoiZFE9Z1Ev7OOrtabx3PfKMzZnustDgUp4Wc6MZx?=
 =?us-ascii?Q?J0+kx8VfViKlAOMcfMZsA6/aOS16u3t6C5MZ9d4t2D/bIhTWNG8qpYKPKFet?=
 =?us-ascii?Q?dRvoKsJAnuKpdsnjRc4iWgr7UYVAbDShrqpKDoff7+UgWnTirXzOldfEt7MK?=
 =?us-ascii?Q?rqxkUIIB9ZTOGfyoAXNyoV6cFuqgkTpw/JifF1rgT3jY/SJCbzGqu2p329kE?=
 =?us-ascii?Q?ZFktx2LkmYlQ5KKqqF8mf8fZ9UIS0LTN5wqlsW8TxayuZCsG9+389vjIMR3r?=
 =?us-ascii?Q?TN58CMQ/Fv+YWxo9Mm5JNUlT8vHu4Gu2fLzMCfaNUUHmU1FDQ/9kYZYyHCeU?=
 =?us-ascii?Q?rMrDCknVDSmxB3UwMuINFaru0r6c6kg4dIgoMC+FaS52NATCeFVp2GLfyKsJ?=
 =?us-ascii?Q?3HZXsezeiMx4Loz3XrkXOLxvZFuEy715RiqEHyQMkdghHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 18:45:21.4285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1436e4-6248-4942-b267-08dc70582e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100

A Rembrandt-based HP thin client is reported to have problems where
the NVME disk isn't present after resume from s2idle.

This is because the NVME disk wasn't put into D3 at suspend, and
that happened because the StorageD3Enable _DSD was missing in the BIOS.

As AMD's architecture requires that the NVME is in D3 for s2idle, adjust
the criteria for force_storage_d3 to match *all* Zen SoCs when the FADT
advertises low power idle support.

This will ensure that any future products with this BIOS deficiency don't
need to be added to the allow list of overrides.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/utils.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 90c3d2eab9e9..7507a7706898 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -197,16 +197,16 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 }
 
 /*
- * AMD systems from Renoir and Lucienne *require* that the NVME controller
+ * AMD systems from Renoir onwards *require* that the NVME controller
  * is put into D3 over a Modern Standby / suspend-to-idle cycle.
  *
  * This is "typically" accomplished using the `StorageD3Enable`
  * property in the _DSD that is checked via the `acpi_storage_d3` function
- * but this property was introduced after many of these systems launched
- * and most OEM systems don't have it in their BIOS.
+ * but some OEM systems still don't have it in their BIOS.
  *
  * The Microsoft documentation for StorageD3Enable mentioned that Windows has
- * a hardcoded allowlist for D3 support, which was used for these platforms.
+ * a hardcoded allowlist for D3 support as well as a registry key to override
+ * the BIOS, which has been used for these cases.
  *
  * This allows quirking on Linux in a similar fashion.
  *
@@ -219,19 +219,15 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
  *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
  *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
  * 2) On at least one HP system StorageD3Enable is missing on the second NVME
-      disk in the system.
+ *    disk in the system.
+ * 3) On at least one HP Rembrandt system StorageD3Enable is missing on the only
+ *    NVME device.
  */
-static const struct x86_cpu_id storage_d3_cpu_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 24, NULL),  /* Picasso */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
-	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne */
-	{}
-};
-
 bool force_storage_d3(void)
 {
-	return x86_match_cpu(storage_d3_cpu_ids);
+	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
+		return false;
+	return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
 }
 
 /*
-- 
2.43.0


