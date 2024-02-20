Return-Path: <linux-acpi+bounces-3739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D614885CA82
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E652B22F8C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03194151CCC;
	Tue, 20 Feb 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IFBVtdQs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D0152DF8;
	Tue, 20 Feb 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467179; cv=fail; b=h56d95ynfI8VljlSCyUM+AhYr00YRmsgDlbzqY+nACILuZvpJWZKTtVFppbO7afyY/kPZ6SxMF5NbCkcolIWNMsDkLIJBB31/7HlriSux74JYema2s8uxdn4NcmdmaYfxvIQf0Xy/CxMqlPzkVcTZoTWqztml9VwJSYcgG5hR0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467179; c=relaxed/simple;
	bh=9HwD9KGWbTptEy7UVMaE5FLEGPhRUK/0tz49eWwxe9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXh9zfgGefW1h1CuQ17jobpSFfacPwEZkt9dtM0MMjXC30/53S/TlEVBTNeoBlbq/LJhwURc/2/SgFYjwEBT5Dn0S0Z34qeMwPOgDOUJwcye9y4Jk65tZEvaBROFevB9pFe8/rIKSx7ufcixQiSJ1I0IHPHMP0aPN9fvt5rmhSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IFBVtdQs; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ6nSltXdeyvxHoyxTmbx/A0JSyDLyO8ZrERvzLqFrG6rHporDFEADN3YeN+7MEshZF5g5Tc9JOG/G+dW5em9yrkfFyhVjbvdAP6MDW6xR6F6MUXdlHKoqa6Yw9hKuNWEwi+KgVkr4hsetkXn5588MDWYVD/LwFh+Hry82XxMXRFJgX4OhTwKHClgdFUnKIVdyWrk+GEyxA7nNaI3HPOnzwsGr87JRCC1gBpU2cTD/RgrXoXvKacOEeTUygFF41FbmVjPGLLbh0SFWsPj54TaDnIwJ4K8P10gDf9ClHlx2SYaRQw+mrHFETIy9L/m73MbnYldX3Aj97O5YI2rg5t4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg0m92sRNdacpUC+fqCBZoYELdWS4tw+CqSlSR1Yn9g=;
 b=Mlvx2Bs+ZWoeK9IlVHU/qPm8bDOI/Syk8auEKpl5JTHG9oUNDvM8TtmesRlHHRJ8ck+OAHeVLTRu3uwMmK7xGiC3Y5sFI86xhFbd0uwFS7soo/6hgsQ4rcUo6r9NHDHQc85Lab4tUJEw6cqrES/bxvrJ2IgJvxmChHmR2FLAmjb9uGsV2DdGUQ9QhdHXEkSoKVh0lSm92XhwcHwrGqY2Jp+gasid8kxCeBGC5q/cbcNGjIY2m3Zqc/khPoODqU4P+YB3QMvirvvK/Ue63AdIaOOlUnbT2HEjAZOULFAg9ne8JZ3sUkaHmaiQvFaJhndz1gGe5/w3748yqvZjfZJHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg0m92sRNdacpUC+fqCBZoYELdWS4tw+CqSlSR1Yn9g=;
 b=IFBVtdQsCpcTTbKRkKRWjXoMOhiN5cs1Zrhf642v6gj1SghR1eKr+14L3G6ksyiyAbmkEi9E4fqGAmYBE2L29cpb3CzBWKwIL/7El7gw4RsvJUSeky+DxyqZSjs3aEtmBWT421CqR9TVYTQGwR7QwOzrQFcPWa2y+SEOyhAeOEQ=
Received: from PH0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:5::19)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 22:12:55 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::5f) by PH0PR07CA0014.outlook.office365.com
 (2603:10b6:510:5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 22:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 22:12:55 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 16:12:50 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v13 3/4] cxl/core: Add CXL EINJ debugfs files
Date: Tue, 20 Feb 2024 16:11:45 -0600
Message-ID: <20240220221146.399209-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0f67cb-0252-48c7-53a3-08dc326116a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1xYq5vlV9b/iMmMMg1aLXwlC02OL4cX9YebWhsKJgANDsAW3OP+Wo90UroxV3hpzsdlhBElV6kxcPYlZpwTCa+C6QDumMrYB3ttYg4GV0zofG8E0VfFhvHQHRV8aXJ9JYmb1NMyU7mbaLCIMn9ALdSU6irVuQF1SbERq3/tN4QiDNyhUhfx9i0bIXnr6Y8Y74CTnnZ0mD/ljt102DivQ8V+U4MVcAXTZ7EVEBPJ720NymCYP+j0TgqVVQqIFwWbutTo/mysvDEovCIpbkcjFjn1oIYmGZMkxYZ2ZSHI7P/DHX6ZuRlFAEQAVzmJ9OQLCO2/Yv80i+JtIdjjLBTNrE/DJWyC2JowBl/IlKB3kVrOKparNTeLRc9/3Fpj4byM481559Q0srSC2ZhBUiOtwQmK49zAatLP4c3hyfYgcpk9mw5strAm1OesMXscA0xFOznn3cS7CEO7BVBXuudkxtTRDT0mvm9HYXcxX07kjyV3IIdX72BvR9OmT2U0lEzLdaVD0BdoEm0hhSow8RTu4y1utWeSAKZ4ff+BK3kG6E+CpKhiwWx1D/vVsW5cFrJeiv7amm3MZ4+eey503RY5VmA9HwKk5HnW4NrLMj51kyTVmlvFnyHrljZJU7Hrw2iW5YantC/Zvx3efmOE3KfkrXCYHO1NrAi2r0dAVn9vYHS8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:12:55.2030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0f67cb-0252-48c7-53a3-08dc326116a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

Export CXL helper functions in the einj_cxl module for getting/injecting
available CXL protocol error types to sysfs under kernel/debug/cxl.

The kernel/debug/cxl/einj_types file will print the available CXL
protocol errors in the same format as the available_error_types
file provided by the einj_cxl module. The
kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
error_type and error_inject files provided by the EINJ module, i.e.:
writing an error type into $dport_dev/einj_inject will inject said error
type into the CXL dport represented by $dport_dev.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl | 30 ++++++++++++++++++++
 drivers/cxl/Kconfig                   |  1 +
 drivers/cxl/core/port.c               | 41 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

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
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67998dbd1d46..c86ae4c65c03 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -2,6 +2,7 @@
 menuconfig CXL_BUS
 	tristate "CXL (Compute Express Link) Devices Support"
 	depends on PCI
+	depends on ACPI_APEI_EINJ_CXL || !ACPI_APEI_EINJ_CXL
 	select FW_LOADER
 	select FW_UPLOAD
 	select PCI_DOE
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..3b579eef4d23 100644
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
@@ -793,6 +794,39 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
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
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
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
@@ -1149,6 +1183,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (dev_is_pci(dport_dev))
 		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
+	cxl_debugfs_create_dport_dir(dport);
+
 	return dport;
 }
 
@@ -2221,6 +2257,11 @@ static __init int cxl_core_init(void)
 
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


