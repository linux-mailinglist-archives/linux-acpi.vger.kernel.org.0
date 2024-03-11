Return-Path: <linux-acpi+bounces-4250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6E878197
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0625CB23C01
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161F3FE35;
	Mon, 11 Mar 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5NzGWvWs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74443FE23;
	Mon, 11 Mar 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167184; cv=fail; b=mXCfGSEXxXD3UasnyWHLpR0AhX9jRtB34BQqSep2jgZY02PLMrEohSV33lbmvHTVc6OPSHc9KNnP7RGorz56Qpy5IhVYzP+XazPjGinHd8qvcLa10PT8e8nSk3ehpCkK7X79yHd1GAd4Y3vrjAwWR7nJHQUylfhITC8UTjkYNpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167184; c=relaxed/simple;
	bh=TNBEdbZMwaRQnhUEUf7SXKYiiDlKqa7VhYp9Dl3jdFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnY886Aau1e52KHAuPIgdG7QndhSQa4J0fCDmRYx/ZE444sTz0cswI8u4oqGkGPZTEhCMxa2rtYZnaaKA+O2ITWs0h+qbgWhH7mRPu78V3NqHc4Y5PceKUWKMcxnvOn4ZERro8sJ9lJrS2Op+v64DPVFhxiSWGiivvzIlP4JuNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5NzGWvWs; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUzhtoBUlzGdKaBx0jiMyeAACoYUEKG0pxff8h0gig3vF0oIShFnOR4I4wmuvkSXDn2qno0RfghoNjxI+suNOFYgi0Rox6xL1XyELxysP6M/Na/zBocR5OIJwOc7NRe41Q6Cdls151GVGOLpOKgtvQnk31qwvojWiiRWuYyeH9MwHTmX88JivD156ZiUjt3o7HZ6IXUlOnudjU7Z8e9Ddd53tqWh6pOOc36NvgPLx8Df9WGdnAxn6+FTNhoZSmvbcCqhTtjYVMxL2adfOOOMqUShDCWH4IQY7HOOYTVmBXCdmIryk+Imaiupw80T7ECp+9bcBSdfULTERFxHiz4xxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeCt7FNiNNomYvV8RLm9drmt8/6Gad1m9M+AQr/w3dY=;
 b=PghywatPq3ZEZuaTWDrgr44OqltRlRxiFvrLjvIXU99EOyFOO+Yf6XgnMFRnfdIBiJfd+SDIHfVdsaFaYrY9BmTlYz8XkoCsgiKYYbwLsdMEwlyeEUEsLTQYWyfxHYgbQFWhR2dVgh0NmhDpORBtGAqRkHe7mS8E3OAxMIlx8lazx8dgC6CPUWQVxlslicDiNV5tVsrfTTL/SM29nugV+32/RhW0eEwSLjS2YKgmQWRvEFJCnOKgmTsfefe205QXZVUQ4/YGCqLEHcCaujxgk7sl08QW7PZG1+v47s3rxc0kDWrOeldYzMSPgB/bQM8r4cUTs7CzOs7PPEp3zwm6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeCt7FNiNNomYvV8RLm9drmt8/6Gad1m9M+AQr/w3dY=;
 b=5NzGWvWsqh0rVi4ITcDYICz4C0YCzCJz1Q+r0vLeKHbCzOCd8i0KwAftzpqVGRZ9+Ew4JbknDrg1HwdCYXKsPDo8L9YwG6VYQGf7j5uPar+iepIrDejxn5H54Ddru//HSJLUV4LwVyf0jgVIcmuh9oX0tgQQmhfyq1EIouTLMGk=
Received: from BN0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:408:142::11)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 14:26:20 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::52) by BN0PR08CA0010.outlook.office365.com
 (2603:10b6:408:142::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 14:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 14:26:20 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 09:26:15 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v15 3/4] cxl/core: Add CXL EINJ debugfs files
Date: Mon, 11 Mar 2024 09:25:07 -0500
Message-ID: <20240311142508.31717-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 1176bbca-e46c-4c1c-8397-08dc41d738cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	III8IN/Tl9Af3/3QbkcYFznl5x4DMBI1+14g/TjFU2Veu9ODTezaDHOqCViGohcyHSJpKTbVfg70KtRpMnmyHdgb2GHzmaSe8sv3+wr3eviWICAVCPXy7g4JHnLjAi3SZw821UM+CvLHxVpIQpb834crkVAtyBG8mIppKS6z5S0CWR6Cm5lEtTjYfcg6AZyXg9SzneeN5QqrFI9ofGbRj0zPg6IEYyBqML5pk45RUjZTS5VqG4GRA6sbzDswuy8dwe3ch2xEcufbLq6w5FeMdeU7QdYV0oBPujsjpk5mQ7f4dFwz8sC02OABOCXzZFmmzBdgHDxwBqJBz3UFx355PCGYKI0QaJa0sR7ty8/b/WqcGmYdMtuubSZeg3ObKdEEGlctmC8zCCNLpzCcL6vHiF50CSBs6ctzpzuTSUzcb3iDtqO0rdH1b0FpfHzVqRFCPz8eBTVC510gmJmiWPXoMI+Km0tys9G1HOyeTSlHIF9V6iT3TMuet8Ch7oXK4XGjUtGkh967kktaIup3qvPOqPf5J5iLPHzS7OCoDL8SJ1fdD2QpsYVDAHjrdNFjI9yMaiiOUskhjAnsOonEWscjIPPDSCGc9ErTcT7BDwasO06e16zB4bABHAEmjZgmDy6D5J17yLlXyvXOvkD2xASHCAWElPs6CqbtOppxY+q1cBzDn+TqvEPLb44p1abH7bM9xJWX9vlNfOBskXl5kEwi05B73PGQnB6lV64Ogg/Pzzas2KL3jevxpxnFa7RdpWgP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:26:20.6000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1176bbca-e46c-4c1c-8397-08dc41d738cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481

Export CXL helper functions in einj-cxl.c for getting/injecting
available CXL protocol error types to sysfs under kernel/debug/cxl.

The kernel/debug/cxl/einj_types file will print the available CXL
protocol errors in the same format as the available_error_types
file provided by the einj module. The
kernel/debug/cxl/$dport_dev/einj_inject file is functionally the same
as the error_type and error_inject files provided by the EINJ module,
i.e.: writing an error type into $dport_dev/einj_inject will inject
said error type into the CXL dport represented by $dport_dev.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl | 30 +++++++++++++++++++
 drivers/cxl/core/port.c               | 42 +++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..4c0f62f881ca 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,33 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+What:		/sys/kernel/debug/cxl/einj_types
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Prints the CXL protocol error types made available by
+		the platform in the format "0x<error number>	<error type>".
+		The possible error types are (as of ACPI v6.5):
+			0x1000	CXL.cache Protocol Correctable
+			0x2000	CXL.cache Protocol Uncorrectable non-fatal
+			0x4000	CXL.cache Protocol Uncorrectable fatal
+			0x8000	CXL.mem Protocol Correctable
+			0x10000	CXL.mem Protocol Uncorrectable non-fatal
+			0x20000	CXL.mem Protocol Uncorrectable fatal
+
+		The <error number> can be written to einj_inject to inject
+		<error type> into a chosen dport.
+
+What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Writing an integer to this file injects the corresponding
+		CXL protocol error into $dport_dev ($dport_dev will be a device
+		name from /sys/bus/pci/devices). The integer to type mapping for
+		injection can be found by reading from einj_types. If the dport
+		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
+		a CXL 2.0 error is injected.
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..eeeb6e53fdc4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -3,6 +3,7 @@
 #include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
+#include <linux/einj-cxl.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -793,6 +794,40 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
+
+static int cxl_einj_inject(void *data, u64 type)
+{
+	struct cxl_dport *dport = data;
+
+	if (dport->rch)
+		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
+
+	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
+			 "0x%llx\n");
+
+static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
+{
+	struct dentry *dir;
+
+	if (!einj_cxl_is_initialized())
+		return;
+
+	/*
+	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
+	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
+	 */
+	if (!dport->rch && !dev_is_pci(dport->dport_dev))
+		return;
+
+	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
+
+	debugfs_create_file("einj_inject", 0200, dir, dport,
+			    &cxl_einj_inject_fops);
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -1149,6 +1184,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (dev_is_pci(dport_dev))
 		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
+	cxl_debugfs_create_dport_dir(dport);
+
 	return dport;
 }
 
@@ -2221,6 +2258,11 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
+	if (einj_cxl_is_initialized()) {
+		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
+				    &einj_cxl_available_error_type_fops);
+	}
+
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
-- 
2.34.1


