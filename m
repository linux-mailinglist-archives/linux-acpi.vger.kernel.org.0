Return-Path: <linux-acpi+bounces-4251-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F3878198
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 15:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD361F20F6E
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC583FE27;
	Mon, 11 Mar 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rPHemmIH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690463FE20;
	Mon, 11 Mar 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167201; cv=fail; b=qvO7SEkM1qrx3vUjuXW9EZj9rXGP1X3XTNrWFk/nq+KuDX5aqJLrkW8MNoq1y8Cia3U1tGIC5dd1WU0fxbWhDzuqm5XzcZ8lujcfA/ccIqFD9mhP5jXadOyt8pHVeIwAz3Mjte29dZr9luv8VWOwNS8vaPSpK9nYzs5nYpz9AYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167201; c=relaxed/simple;
	bh=WZ5YbEnhqKXopFQNcqS3vyv+MaIIL0oXRn3J90vnm8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRwI5y2zjhAuvYacRxhSUNQMG2Vv1s95bVMF0okzSaDKYkSj64ZoQc5T/Ek9Uu+SvXyLH1J9USbA5TePCuRxrpqB/F8zZ3XC0T13En//YL8IBrCR14JfIoQU6cxTCOMNXbu9TXdtIgBivJlRN+R3jXej9exwLcqySRpVJ9A8A2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rPHemmIH; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1qd+V/8VJiBRWVEZKkTkhl4zLayNd/pEBlgjkN7+2BjthmfqAWHpIhsCTOvhiffpu66KLeq3wgD7dWVrGodydReLei1Nxuub11X1fBg5asr9UCZJjbuujiGol4us0wNYjab04wUiKHcSqWunhAJBjLtV/0GxBIwkW9E4UpemcXpXwo3Pg5A2+3grEBenQQl0pKax3eJua9NTQva7zdtqkKYNL0sZqUdm6FeaZSmQEeMsXI/vKy5rlFi8Tt0Omro7Yc4lAcGqPDIYTxBc4kuWecXEdAhRT6Q1DAh2X2c23X8ey+Z9+4Ao96MBkj3I9tjRFKMHXsYcZSVlbmkKp4tQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFBN5h+d7exIkliBEw4l96DipCKejqb1+Lo70+MyXu0=;
 b=eftd/K0E2P0xnav49Vy3BXt8sv1QYQ8SmWApPc0Ra7RCIdOy5PlctiwoThSiPY98NdXInt9fIl6OXpRviDBw6SUp6c2Qa6vlibU4plMuv2So1JZdeSfsCZSEt/ThOr3PPndDXyWVjZmD15wkO6XXKrxP1hVklrDxJ5uo7ALDWaFPXOS7GwDgUmwIqeRqiOfqwgEqqa9kvaCe6hgvkmx6nXoKu3YRnHvvKFaRlt39AfftbvjxM4ztEqRREhgsr8GM8ZiGbALP/mqoGU6cfeN+I4CqeqxCNo2bP4EYnOLwo4PD77GcC/+LPkZMkZc6kOJhhvDA0dJD6DM3ILTHomALeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFBN5h+d7exIkliBEw4l96DipCKejqb1+Lo70+MyXu0=;
 b=rPHemmIH+Qa8HzjuKqtTIRjmC3mGKC3bLS6etVXlpwxOmEVtgn3g8///SW73yiAvZOCNFtrx8ucWHwt0ygc+XPl0ceTGcKeFOMReUPLLKGEMQIbrTISCyUv0Mml5Wh85YJBEZhtSUZ/kIRdPlsDOdq1Chb0ezcQEuLBn/BLyJJs=
Received: from BN0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:e6::20)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 14:26:35 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::89) by BN0PR03CA0015.outlook.office365.com
 (2603:10b6:408:e6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 14:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 14:26:34 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 09:26:32 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v15 4/4] EINJ, Documentation: Update EINJ kernel doc
Date: Mon, 11 Mar 2024 09:25:08 -0500
Message-ID: <20240311142508.31717-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 094b779a-c85b-4367-a425-08dc41d74158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tKpeVUYVo20ZZgFZELfvoY2v30c7tK5byUt/ytpFtEAfMhVipL9Ytvovx1XFMUg96youax1L+ro6Mo2nj2lgd7CG8R5B/qdOuDUqo38nWX+AdJq6n18CZBuIOOo2bbZ+CcpeFzxb2+9gGj/m/W/D479rm3pRKgsMgeF+0ANJGeP6Xk71Tb2eTYrsdm9p3UyRkzToUSciNxHqVY7qCJDHxEIINv5JI+2VFlTAPn3W1vPnobM3Th3sGtXTqC+3t1Kad15+U/KK6kbzOIvPV7QrQ8YBpMy1cW408eeEkcoOIl/fvHlrnC9fNXiLZJjaVEtZg9ugZOQE7Snfxf88Be3XgD17Ntm3d+KjmW43as07BcduRTy92y0L4paJzoiBps7tukrjCOUDtc1QMAwIunA7MPWR+CvIcEewt4gzhi9VagXucnN2t1jSs+5g5qCSi8HqIjOo7V2vts4jGW2S9GaFjfc54Tp/sPiq3AP7C63jLfxAS9DYZhYLnECOI9WwwRrqlItZNnTA1UW/rMTvMQqA/I8ZRb/aVksqc7MWSZe46xUwZpJHlihzeFdLuVlOO0Cz1tMQ6xEZprAXDkc4ruRbADzdFeYSoYK2s2oIjXz3RPzdTGJ6oXpfvX2Nb5b2wOzY7knkdrm6e8hArV3Iy/hWqRrhhNqK/J3K4OfWPZWDymDpcUsiyTHEckaif5W2lqiBQKon8muUe4hC22ler9QKlTBTMrwHN8v2TuFvrbHGi3hbze3l53le4YFikJvaRs+7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:26:34.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094b779a-c85b-4367-a425-08dc41d74158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..c52b9da08fa9 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -32,6 +32,10 @@ configuration::
   CONFIG_ACPI_APEI
   CONFIG_ACPI_APEI_EINJ
 
+...and to (optionally) enable CXL protocol error injection set::
+
+  CONFIG_ACPI_APEI_EINJ_CXL
+
 The EINJ user interface is in <debugfs mount point>/apei/einj.
 
 The following files belong to it:
@@ -118,6 +122,24 @@ The following files belong to it:
   this actually works depends on what operations the BIOS actually
   includes in the trigger phase.
 
+CXL error types are supported from ACPI 6.5 onwards (given a CXL port
+is present). The EINJ user interface for CXL error types is at
+<debugfs mount point>/cxl. The following files belong to it:
+
+- einj_types:
+
+  Provides the same functionality as available_error_types above, but
+  for CXL error types
+
+- $dport_dev/einj_inject:
+
+  Injects a CXL error type into the CXL port represented by $dport_dev,
+  where $dport_dev is the name of the CXL port (usually a PCIe device name).
+  Error injections targeting a CXL 2.0+ port can use the legacy interface
+  under <debugfs mount point>/apei/einj, while CXL 1.1/1.0 port injections
+  must use this file.
+
+
 BIOS versions based on the ACPI 4.0 specification have limited options
 in controlling where the errors are injected. Your BIOS may support an
 extension (enabled with the param_extension=1 module parameter, or boot
@@ -181,6 +203,18 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+A CXL error injection example with $dport_dev=0000:e0:01.1::
+
+    # cd /sys/kernel/debug/cxl/
+    # ls
+    0000:e0:01.1 0000:0c:00.0
+    # cat einj_types                # See which errors can be injected
+	0x00008000  CXL.mem Protocol Correctable
+	0x00010000  CXL.mem Protocol Uncorrectable non-fatal
+	0x00020000  CXL.mem Protocol Uncorrectable fatal
+    # cd 0000:e0:01.1               # Navigate to dport to inject into
+    # echo 0x8000 > einj_inject     # Inject error
+
 Special notes for injection into SGX enclaves:
 
 There may be a separate BIOS setup option to enable SGX injection.
-- 
2.34.1


