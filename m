Return-Path: <linux-acpi+bounces-3307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1530184E942
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 21:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7F1B28789
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 20:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E59383AF;
	Thu,  8 Feb 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zaSWdobP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE7381DE;
	Thu,  8 Feb 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422495; cv=fail; b=ceOJ/nKyqwBCy2uyPYfEMUImmcPAi1Ld2pnaeNCtB1suc2DQ2FkWWdulIc/Zf+OPWcWOOS2m1PKsx8eRFbeFRovh7S58R63qtSdl2SRsegNXEUxaC8634UFcdNWhR+zMoNbpQmhmSkky37s/BzPy6sYgpl/B+ni4UlOs3f0rjpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422495; c=relaxed/simple;
	bh=mnCEzdVnRJnulunV6FGnlo0bv81ROT4sKZZkXJVJOws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeLX/6YWbg3L4HCD76fzbeR6rV3caozXbl7CN0/94O/BhFE/0ZY0KlTIgc8KonGZm0fp87ai4BtMmB6pOlSi0jg0/70ohAol5w0l/4iGaVXN3vI/WGXB7ufRO2VtfLEfPlwx4AJKG2e8jDS9f9rPZod+Y6wfMlTwaCqlergLFOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zaSWdobP; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7ew/9euSgq0sJ8Q53u1XIcszNZ+ZN5f8S3/YTjnusEwdwIewENUTSA4RDw2wj7a2BsUt9yXLzlZAMn+VB9Jcyl6Gh1x18Lx0rkrU9jNV7KostcskFhYvq18C+EYEM0o0DFy0YyrMHBsvhVPZ/vzDpxqf9xZwPNt/zCT1BkOPg7dMn3/MstkdNnsKDA0hqit6KffbY7wLKdBg/yK8M4kcpYm8Rj0WpUcGyBo1w8eYAqGS5RzO3j+jrD9Dl+awGSLBBRfdOGU/kwKEVzzfHX7GCDbubd6oBMB/J3vWQBxwkkSpvc16MGHmpDccnuMnUT6jfZeKqNPC09L4KkAXQY0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm9HaP4CVNDZ7pvOvfpT8CXxmH+u9YjtNAdq67pdCyw=;
 b=WkCrQSWy4QsccNqZE66j2mZ5qoNU7ABdQ/F8k8Q+c4EqSRfO9+TF0rZCVQ19uf2AEaYYQuedE7sFn2M2BOHGxqyYZhGd2N6ZBGwnmbnud08rJ5qBMbDGeEekpAnX9sPkae992BZgbsRIqp4Ouy9mVgd1ueNjTYY2S9QQrw0c0CmqqkZk1fHDWJ3eolJKfaw8W50OE04zfQcKqtlwFjK/LhXLIq9udFcT6ktVkcGMP2+09bd3chhcxf4hnHHSCthuv4lAgz8yNJR/mVwIXVTyUnnSnKcHraK9eJTvTEentyeFjDl4TJ8HGERSYuassvAz+ChcoW9dQ+LG7jc7rZdlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm9HaP4CVNDZ7pvOvfpT8CXxmH+u9YjtNAdq67pdCyw=;
 b=zaSWdobPDA38rJRxD97aQkfCHV1lXUPFY4LfCn7JdHUJ1gT7t4kfm1bW71KO3nPF8R2I8j4ICrmY8uJdeIRkp4hVBYDuL7vOwZL8a1qvogJ38phfXlpq5/3Re9/yWY5qaLUmpAEq3US/+FzEm4jyUyQi4b9GbH0vHb8gmvnSl4c=
Received: from DS7PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:3b8::25)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Thu, 8 Feb
 2024 20:01:30 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::8a) by DS7PR03CA0020.outlook.office365.com
 (2603:10b6:5:3b8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 20:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:01:29 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 8 Feb 2024 14:01:26 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
Date: Thu, 8 Feb 2024 14:00:41 -0600
Message-ID: <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MN0PR12MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 813b8080-067f-4eb3-d46a-08dc28e0bd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4zgv5C1xpjRNhox6EZw4UPnPMOh3xTaC4rT+mS64NN1KpjWSrDDpB4T5i/YgbArH/ALs2thsuLVK7XnmyPsmlTWN/XTjQmmJY+r+tUdgezUg8gyoa7E0CVN8ks0b7UOwyWRRniKMUBO9zxoJnRTiyWdE7atL9KAZtydDN5Qauqm0Q/3pxTmAH2vCNe61Jfg/lvX5DoAljNfWeQusQipHtPE7XeU8XyvB7ZnIaxPQWV9uvCwvRnxmEAUnR8TBvtjXVjCXA8RsfsLieJVKT6Rxk/M26fjmvrxLj6g4rReJRFA1Hs8g1v8/sCobaGRLnC7V7nkHHo34ZbZPdqNxF2FRCdhg6jo+ZiQ2ZddphqjSYCDFzidgrj9E0SCsIP0B1c8Tk8Uz8Yqwi+/C3iQHlyxKpFuETe3up3whgbrbQczeJPjP7pJVwRX+6knB+zqthMLBDrfGJDIqWePLWCPILwKt0ClQZgXUN0uICU2mLOyEmRv/Ra0B1MwVkUfjFNIn/NCErvIzfGFIxXuu76zo1MQRX9P142yqsiN8XAwTuroL4lOT2CQ85k3po/PkuFv+pijSCajVnNo69Nc4ZBq0cYgsLTtVULqUjqg1E+oFFZRWx1k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(30864003)(81166007)(2906002)(356005)(82740400003)(86362001)(83380400001)(110136005)(6666004)(26005)(36756003)(1076003)(16526019)(7696005)(2616005)(336012)(478600001)(7416002)(426003)(5660300002)(316002)(70586007)(54906003)(70206006)(4326008)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:01:29.5624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 813b8080-067f-4eb3-d46a-08dc28e0bd7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716

Implement CXL helper functions in the EINJ module for getting/injecting
available CXL protocol error types and export them to sysfs under
kernel/debug/cxl.

The kernel/debug/cxl/einj_types file will print the available CXL
protocol errors in the same format as the available_error_types
file provided by the EINJ module. The
kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
error_type and error_inject files provided by the EINJ module, i.e.:
writing an error type into $dport_dev/einj_inject will inject said error
type into the CXL dport represented by $dport_dev.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl |  22 ++++
 MAINTAINERS                           |   1 +
 drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
 drivers/cxl/core/port.c               |  39 +++++++
 include/linux/einj-cxl.h              |  45 ++++++++
 5 files changed, 255 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/einj-cxl.h

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..bcd985cca66a 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,25 @@ Description:
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 9104430e148e..02d7feb2ed1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/
 F:	include/uapi/linux/cxl_mem.h
+F:  include/linux/einj-cxl.h
 F:	tools/testing/cxl/
 
 COMPUTE EXPRESS LINK PMU (CPMU)
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 73dde21d3e89..9137cc01f791 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,6 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/einj-cxl.h>
 #include <linux/platform_device.h>
 #include <asm/unaligned.h>
 
@@ -37,6 +38,20 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
+#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
+#endif
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_FATAL | \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
+		goto inject;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
 	"0x00000200\tPlatform Correctable\n",
 	"0x00000400\tPlatform Uncorrectable non-fatal\n",
 	"0x00000800\tPlatform Uncorrectable fatal\n",
+};
+
+static const char * const einj_cxl_error_type_string[] = {
 	"0x00001000\tCXL.cache Protocol Correctable\n",
 	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
 	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
@@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 {
-	*val = error_type;
+	int cxl_err, rc;
+	u32 available_error_type = 0;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
+	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
+		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
+
+		if (available_error_type & cxl_err)
+			seq_puts(m, einj_cxl_error_type_string[pos]);
+	}
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
 
-static int error_type_set(void *data, u64 val)
+static int validate_error_type(u64 type)
 {
+	u32 tval, vendor, available_error_type = 0;
 	int rc;
-	u32 available_error_type = 0;
-	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
-	if (val & GENMASK_ULL(63, 32))
+	if (type & GENMASK_ULL(63, 32))
 		return -EINVAL;
 
 	/*
 	 * Vendor defined types have 0x80000000 bit set, and
 	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
 	 */
-	vendor = val & ACPI5_VENDOR_BIT;
-	tval = val & 0x7fffffff;
+	vendor = type & ACPI5_VENDOR_BIT;
+	tval = type & 0x7fffffff;
 
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
@@ -652,9 +688,105 @@ static int error_type_set(void *data, u64 val)
 		rc = einj_get_available_error_type(&available_error_type);
 		if (rc)
 			return rc;
-		if (!(val & available_error_type))
+		if (!(type & available_error_type))
 			return -EINVAL;
 	}
+
+	return 0;
+}
+
+static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
+{
+	struct pci_bus *pbus;
+	struct pci_host_bridge *bridge;
+	u64 seg = 0, bus;
+
+	pbus = dport_dev->bus;
+	bridge = pci_find_host_bridge(pbus);
+
+	if (!bridge)
+		return -ENODEV;
+
+	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
+		seg = bridge->domain_nr << 24;
+
+	bus = pbus->number << 16;
+	*sbdf = seg | bus | dport_dev->devfn;
+
+	return 0;
+}
+
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	u64 param1 = 0, param2 = 0, param4 = 0;
+	u32 flags;
+	int rc;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(type);
+	if (rc)
+		return rc;
+
+	param1 = (u64) rcrb;
+	param2 = 0xfffffffffffff000;
+	flags = 0x2;
+
+	return einj_error_inject(type, flags, param1, param2, 0, param4);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
+
+int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
+{
+	u64 param1 = 0, param2 = 0, param4 = 0;
+	u32 flags;
+	int rc;
+
+	if (!einj_initialized)
+		return -ENXIO;
+
+	/* Only CXL error types can be specified */
+	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(type);
+	if (rc)
+		return rc;
+
+	rc = cxl_dport_get_sbdf(dport, &param4);
+	if (rc)
+		return rc;
+
+	flags = 0x4;
+
+	return einj_error_inject(type, flags, param1, param2, 0, param4);
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
+
+static int error_type_get(void *data, u64 *val)
+{
+	*val = error_type;
+
+	return 0;
+}
+
+static int error_type_set(void *data, u64 val)
+{
+	int rc;
+
+	/* CXL error types have to be injected from cxl debugfs */
+	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(val);
+	if (rc)
+		return rc;
+
 	error_type = val;
 
 	return 0;
@@ -690,6 +822,12 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
+bool einj_is_initialized(void)
+{
+	return einj_initialized;
+}
+EXPORT_SYMBOL_GPL(einj_is_initialized);
+
 static int __init einj_probe(struct platform_device *pdev)
 {
 	int rc;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8c00fd6be730..c52c92222be5 100644
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
@@ -797,6 +798,37 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
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
+	/*
+	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
+	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
+	 */
+	if (!einj_is_initialized() ||
+	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
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
@@ -1144,6 +1176,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (dev_is_pci(dport_dev))
 		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
 
+	cxl_debugfs_create_dport_dir(dport);
+
 	return dport;
 }
 
@@ -2220,6 +2254,11 @@ static __init int cxl_core_init(void)
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 
+	if (einj_is_initialized()) {
+		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
+				    &einj_cxl_available_error_type_fops);
+	}
+
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
new file mode 100644
index 000000000000..af57cc8580a6
--- /dev/null
+++ b/include/linux/einj-cxl.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CXL protocol Error INJection support.
+ *
+ * Copyright (c) 2023 Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Ben Cheatham <benjamin.cheatham@amd.com>
+ */
+#ifndef CXL_EINJ_H
+#define CXL_EINJ_H
+
+#include <linux/pci.h>
+
+#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
+int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
+int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
+int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
+bool einj_is_initialized(void);
+#else
+static inline int einj_cxl_available_error_type_show(struct seq_file *m,
+						     void *v)
+{
+	return -ENXIO;
+}
+
+static inline int einj_cxl_type_show(struct seq_file *m, void *data)
+{
+	return -ENXIO;
+}
+
+static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
+{
+	return -ENXIO;
+}
+
+static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
+{
+	return -ENXIO;
+}
+
+static inline bool einj_is_initialized(void) { return false; }
+#endif
+
+#endif
-- 
2.34.1


