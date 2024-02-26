Return-Path: <linux-acpi+bounces-3963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75E8683BB
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 23:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082B51F2414F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896F7132C18;
	Mon, 26 Feb 2024 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cu3lNsiI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D267D131E23;
	Mon, 26 Feb 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986506; cv=fail; b=QaA88hqa03jiDsb4eVbQ2ipmwjcIug174RNRMKPafueDyMlnIs8V6BA4JiUl8h9Br1v5XVpVcdbjgW4kDy6mBxMfWR/S3CJoGjV755DotCgmp65Fsl3vQx+hhtWr49e8sB7nnO/FAiTFJDKvsLVIBbZgsXfnw4b6Un5dTIldK7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986506; c=relaxed/simple;
	bh=s3xALJvAIsNNWPniotW4fplEx5TTsSSVSTXwvrr/e7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fG4SVX07SVe5etJfyV5GgT0ZoG68qgQtXWXiShrEFnEif3/7S/xRKNbiFHBe2B86T80yBQuxTZfuxj/cjXWRflCiES+MSfU49DgekI/W/w4net3fV3baOieOeC7RQA+KjEDH9LKTTg2YVMppzqqQ1Bd5DM+gKBPUL+Ct0ybOe2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cu3lNsiI; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITEmBMBMaIYW59hp5itZc2Q1tRkCRHZFxv7TjYQXL8DmKyI7aIZGjFaWpnqG4nEj6QinAZ0I3s/PuwkL50Kl+1OasBjljseVLcLZF0QSYtmEGcJRZzhLMkKdnqhuw58FPl4m90+FaLluqPml0epb9OxT6VPJ8wvQ74aAuoxatFWbCxGZTsysrcMTPrUGgzjRexR0jzmdLM+6y4Ye8Wx0+wzg7N4C4MZFKjX5Gv/GBBee5vjs01lnf7q9HFJRw5WW5b/iS+J3HWQYiolwOjpLd3+eChv6Li9LwWRuIn5JdkR8s4Zoq0pislDl8W2FjzY4Eb3W/+y9gPfYRtG00DRR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9gip4Z8xkai3SeEkYmh5ADlDrXv0++QsVpTTfmRjmI=;
 b=A27CC9mZBQ1Tewu6jzelvk7Rt+ayVhC9SkspRnzOztC7xA1J9LZqcolcN5gfWDoyTgOw8Z8aAXhMynMvDSWKguLNrW4rzsJv0ORBcxPQXWUc++s+8yNY2xEVvrxMwstwJyC4G608uuBa7xi0EKhgoxSS0dIpa32O8udlFAEcYnhiIi4xIzPfVozR03eZJw/pnySsmxGYMm3EWY+Hd3wSXgXPSNHLAhWyDksrmX5sEh7SmyZD+McBL2YoqbMeTlO6S4q8Ic0c6LSpvsYQyKbKhV9NGTrFmXK6Z9vHk/QjhVFYhIK7FcaeUzfTV7s/riMQzp68pYMjcSueMNVD70Ojqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9gip4Z8xkai3SeEkYmh5ADlDrXv0++QsVpTTfmRjmI=;
 b=cu3lNsiIraDilt4o8LtqT/rSDb4nih5TV2fLLCIxOsC6H/8bR6x6GUv7vgVAVMGB492BJpjZuo4Rjp4aMukKbBoDVhoWWmI1/xi8+bAS2wwlx9yIoE9Mv9tWxwEW76f5Qxs7fHq1krGWxgULa59+c+/S4dnx2+dhhisOjXq4864=
Received: from CH2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:610:54::21)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Mon, 26 Feb
 2024 22:28:21 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::2a) by CH2PR11CA0011.outlook.office365.com
 (2603:10b6:610:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 22:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 22:28:21 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:28:17 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v14 4/4] EINJ, Documentation: Update EINJ kernel doc
Date: Mon, 26 Feb 2024 16:27:04 -0600
Message-ID: <20240226222704.1079449-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: dedd1391-6ad3-49aa-224d-08dc371a3d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6MguVPeWAe2ws/23M7hRmcLgAeimTjcQm9cax94lFWC1Wn4dEF2F23Gad/mClP/DE52NpRigahVHpwbTln148E9YZypN52/pJKY6X6UK196m+srSCbWlJS4YT1xyTjxrnoKvgkGAFS25PShTj4C24KNo7kIPuGD180igIlbQilXtYxFAis7HEyLOD87up2jmEO1+rdttk3QjnTVTWtZatnX8vaOpiKzzUsEDqV1ux5kIFatu5/41gsUOqOX0s6AGKZ7tsWeYRbfBf1iEGxsqIa+ZO+9KZdpo95eS9o6SdxvIxdFFF+bRy635YcmrVvKT5TwdQ74FDFMZDMdCMLtMapGK7nAdMOaPcM2s2OXNuW9ceDDsUKTrLGOrU9LdZD+rknA/k+QpSJecswTHaSHqD6kG6U3vyyNpQ+JnKN+LBcHdYxoVbmFhqz6XlGxNa6r3RL43ZyZy9zyDTanl+aj1ozB/5S9RS3/99EmNUzc0L7j2+IfiO9lwltu5U4F3WsWrsYtFSgGX7qkMWnslfMaBaM9c4QNuUprkakJakzJw7uaPP89e0+KkmsxsyVtyccIMUQs/OPL0Ex7wl/pmHNcd5XQ1XzIn6XlbLrdZMBk68qkTGFQ0zqYTcfYIx+PB1yppmG+ZWESy/UIb2xfmaQCMTY3j5j6fcKvsS1H5HKytL0Fz0qV9wVx6YSvLkeqYqzi3HESL20ZqtZ9SG6oUaFDEX1+eShpkuv9/ycpoFq6ZXPmNL9MdRCrkvPchyVWhyW3R
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:28:21.3180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dedd1391-6ad3-49aa-224d-08dc371a3d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

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


