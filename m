Return-Path: <linux-acpi+bounces-2868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC082DE64
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 18:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96732812DC
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E1D17C91;
	Mon, 15 Jan 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VQf3Ghzq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE41182A0;
	Mon, 15 Jan 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKuX8zVeafZIvzkxj2hHHjLRBxStGKmxzOSCQLhUWSKnHBX5qa9JzoOlyKld5U0i06m8V2rdxH4HTXmVEa19A8KgOWgvNbKcPCl59mHY/M4SeCbUQM3phO+kaFC7mByYtwasXBTrpZ78+anKpqmV+ASV9Gie+ueTj6/LJv6JcuT5FU/Dgs+RpORD5C6GZdtHuVFNabuy5mrIA89y+BJpEisEzjKul72LNXrhfGFlQ7w567B48nlo0zmk9B1Ry59BOX0DcqVTfoPMdPDe9JCsEMR0+8+aQv/MEX6UCWeHmWsourNDvo0PN0LhzVTVNP79BGIqDkoe+L5qSTbCXet6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNDp+8WI+o8Kmu19OIG8jnRx0yj/PKI4GXtYD9cu3RY=;
 b=VIpYz68jnQPTwk7trjxIogb3+gzMmQYDSpvvpxkXdqRKxbysu6mrblA7R6Bqj34ln3kp7Ubmz9dk3z8Hsgey8a63xMmTrCsw4/PJES8LU9lnzFw4zTxdJWFD63pqZwchZwe5Z64OEtE+y8jmeAnDjGRaNt6Obaij02BL7HexSgjha1AYdK2yIynH2UTT+mp1CTTe/y+N9wd4xiLLZgUxb8AVQSDrm+3K1eFShfV9tUy5dOMfzy5IrDjUwWb130bW7vRIpdYCakqpqro9O60O0TUHneD7w246SDJHXK9XfXQznnTNFfOJ8TR/gvfbilhDwsmZuXB4W7BhXN50W/7aOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNDp+8WI+o8Kmu19OIG8jnRx0yj/PKI4GXtYD9cu3RY=;
 b=VQf3GhzqoAW8WGDcuH0HjgGxRIf67s25Yfm+UfNTkUv+n2e+N2Mmw0PYeSAtD9ptSPGZ8rALKjHa7i01Ej4XKHwhXi4ArSPifIbpB4KYqzmD1J3RZLOIkE/AjYPoqMfe/Msbwjm4v20W7Gx97GBnUdETEMT4pusoEeUsT0Ou0zw=
Received: from MN2PR19CA0038.namprd19.prod.outlook.com (2603:10b6:208:19b::15)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Mon, 15 Jan
 2024 17:22:05 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::e8) by MN2PR19CA0038.outlook.office365.com
 (2603:10b6:208:19b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 17:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 17:22:04 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 15 Jan 2024 11:21:35 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v9 4/5] cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
Date: Mon, 15 Jan 2024 11:20:06 -0600
Message-ID: <20240115172007.309547-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: f561c14c-704c-4e77-b226-08dc15ee7e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZbdstihQ+9C8laGsG+r44sslWziwrLAMsoLzCpbOquRto4WQYyCwQ+dEKmGGtalud9rpQ+kXnhwK1BJ8sCUCGhzvcWvnsVHajLQlidu99tsqitOb1pB5NcDugHbvJ0NgiS1DXSDKfIKVE2OTQsNH8yFfNz3+zuVRM3Qhreol1P0PpZohAxnUHhbAbCOZYP873OdZwwXl/qpecjYS98zLx6K1XPThcsHaFhnWf1LIrQT48TX6Ak9aJK0VFoYjWIwcrrZOTM9rKZsYk5UimweFDV1yjIERwo1GQ3dtkhn1hQFrGPzsyFJDn5hVy/Qsl6r3+TaUPZ4FC1CnpKd4sffMwNIqe92UjLmOkRe7Dqed9RX9p+AjJGq7/58+ucvHdVKloU9GqHWxExi0CQ4DgEDVuP490ZM6HrukH6CVM+63Rnj0PRn+eg869ymwMN1dIg8UOY9bwx4fMc+4YBeKE6rpTbRqnCRLYFgPMK9OKFVtwxWMgPjso31o/EA/4C7T+CqeOsWoqfEeMXhQzx4m+IQ+r/HsKTrF52xNKzOUP/R5EOIR27HSp+0I5WabX4QRX7HPz0TJpTgi9W9wNpdCVPRVyY9fwBAoT9VBtMaaLWpaIyij41gJ5Qb3olAGhDjbfKKm2y63DUclDXfGE999WnuOEYS9tzO21nY5DAC/06qZzEMJSTmgiIwudEaWjFsXzoswhvqkUzbxOJU0ZWgGNkszw/LmCB+XqV7HBPH2bN31aeOkZvluz6ZxXDW0u8LTBJ/MnhNAc7O8uQ8aB+fsF3hOumWURpuVqQGffUUAt7dbXi4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(81166007)(36756003)(110136005)(86362001)(41300700001)(82740400003)(26005)(36860700001)(336012)(1076003)(2906002)(2616005)(47076005)(16526019)(426003)(478600001)(8936002)(70586007)(356005)(316002)(6666004)(4326008)(8676002)(54906003)(70206006)(7416002)(5660300002)(30864003)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:22:04.6948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f561c14c-704c-4e77-b226-08dc15ee7e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865

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

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl |  22 ++++
 drivers/acpi/apei/einj.c              | 144 ++++++++++++++++++++++++--
 drivers/cxl/core/port.c               |  39 +++++++
 include/linux/einj-cxl.h              |  42 ++++++++
 4 files changed, 237 insertions(+), 10 deletions(-)
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
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 10d51cd73fa4..c3ec03583946 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,6 +21,7 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/einj-cxl.h>
 #include <linux/platform_device.h>
 #include <asm/unaligned.h>
 
@@ -37,6 +38,12 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_FATAL | \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -544,8 +551,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -597,6 +607,9 @@ static const char * const einj_error_type_string[] = {
 	"0x00000200\tPlatform Correctable\n",
 	"0x00000400\tPlatform Uncorrectable non-fatal\n",
 	"0x00000800\tPlatform Uncorrectable fatal\n",
+};
+
+static const char * const einj_cxl_error_type_string[] = {
 	"0x00001000\tCXL.cache Protocol Correctable\n",
 	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
 	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
@@ -622,29 +635,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
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
@@ -653,9 +681,105 @@ static int error_type_set(void *data, u64 val)
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
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8c00fd6be730..a41618ce380b 100644
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
+	if (!IS_ENABLED(CONFIG_CXL_EINJ) ||
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
 
+	if (IS_ENABLED(CONFIG_CXL_EINJ)) {
+		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
+				    &einj_cxl_available_error_type_fops);
+	}
+
 	cxl_mbox_init();
 
 	rc = cxl_memdev_init();
diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
new file mode 100644
index 000000000000..fcc0541ff0f3
--- /dev/null
+++ b/include/linux/einj-cxl.h
@@ -0,0 +1,42 @@
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
+#endif
+
+#endif
-- 
2.34.1


