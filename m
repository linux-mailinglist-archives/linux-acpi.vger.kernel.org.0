Return-Path: <linux-acpi+bounces-1873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6A7FBF74
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 17:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95E51C20A2F
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC25CD2C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BuqxhUa9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78379127;
	Tue, 28 Nov 2023 08:08:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFfo5kayrpfCojc43daM5m4/sqHCWyiWIbZQDFHEHEy4J3iAaVO8Mtz5X1BeMKVskt6I34IXVlK0W5RxFsXNx94/qusf27dz8Ex5AewzimUWItFqt/KZ7eOrW/iJ0JYcoSIKekC3VyC/Msv+eUVYE9tMHR3HrwFu1qyIRnQNvCuCoV2HEaag9qQ6scPJZXoSjjd+vT7AoR806LI84ZYiJJtUO7WC+RhxjMkrsqjYFWTH5FD4+XfdoJw9yP/M7ttQUXGbCHexaf+xmpehuRQEAjZnhcORoWT2J3U2J/Tb8j+Oqw7wLG1e+sr3EASh6EzRQyfM04zqq1MmZtZXUXIbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6I5Xyc73JTe3RYrhuUWYwpjFhVb/m/BBl1g1rIArk0=;
 b=SVjmPJIXE/Xi9JSJ8uLNQuj/pZWJlEcoi+PSqxPGYTEfUXx0SsrHrT3LPhfqK/q0Ua9aDESCaT7xcwcp3vztkdLe0cKdCJnvJSLJJQ2Gkht3RuB9fqTFtf6bOF5RLYj/pK9APXjReTtFlS4D+hv2MwPJqQ1aZHP5iWZwPImGSEmY9lMBiAW2kxMRZPWTUMIzINIv6UR9Ki0NwW+cY1MzFkZQldIq2FN3FLLt5lk6+jLl49E+Uoz2SVtr9+Y40F7NX0uVcYelNirZZTEr6xeurm1wLf5urpGLZyIOzmrpLmRbHzh4741UCrx/u0hiTEqZIPuoLW6Mtdo6kyA7Ye4jXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6I5Xyc73JTe3RYrhuUWYwpjFhVb/m/BBl1g1rIArk0=;
 b=BuqxhUa9jhMNuqFVCvAznF6/8wTNgbp3Qin2fqiHbenvfNcFba/TeY9Pk9AbaOPvsTc2pm3l96FggHDfa0lMEavMEP8arZnUHKH3DrI7ccYU67hbOkC3k93Y0cqgq1Q7YyWt55MwiO62O1FaDDdwf/ihnEhjTFihCN1aHF+bDKc=
Received: from DS7PR07CA0008.namprd07.prod.outlook.com (2603:10b6:5:3af::21)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 16:08:25 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::7a) by DS7PR07CA0008.outlook.office365.com
 (2603:10b6:5:3af::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 16:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 16:08:25 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 10:08:22 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 4/5] cxl/port, EINJ: Add CXL EINJ callback functions
Date: Tue, 28 Nov 2023 10:06:55 -0600
Message-ID: <20231128160656.166609-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: db7a791d-87ce-4709-d996-08dbf02c4066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sASv7unwP/ei4hN8ZpkXQD9JKS37c9HraeSfb0O5LhxGrjRnxfLiFh3Cqg3lwD1cP0pfvRy0k2tpSKZrFhJ6i62/npfU13c4tDwsKupcjg369bb+1X1UTp2H79y7UZZ/jKVfVEEpEvr4zGYSrbZ23DOEK3MGkgKkEmtPUWxa5pE2lW2GYSFUertltlyz4064akpc/wZ/OD1FNTKdkeGpvB7OQO1j9DkRAzFJ9rgmMXjyRCLvNB+nPRA1ep6XvO0P+y1INNRymUnIizGbIUmvpqnPdsyO41Ez8WLJhkOlOFiZrBAHiihq2kaEXbQv+uEjma3b1un2ExMLis6xeeKH0gWQ2+Lwyq4QGcmps1PuvD7apaepehO/oZp9/lPGKZ3YwK/TtqrMh4kG5/+KdLNgEBwxQPt524IQ8oq3M97/iu7ZgjDTmgyzKnoo7jbJvcFe4Kod5zXzV4iqDjfl1NC9ARFRsuyLj8T6m7o+p0GSGMR7JZZ6ibCh1s/efumRlYY3gxpfaUsN4rH8Tu3sbv4kdPHjt9OcDr07VIZ8tgRnIVp3KDrqvpNS7M5Z3PefdO9gftl7RYY4K1VAioeAaPBN4vCbqsad5COl5TFY0YPBU+KxviEJWjkkBY3fxXCnyKV+s0a+q8o4yMWXIIo9DEGBVcTLearcNdfKzQbiuPFyDuADGSwYrlZMgmydfiyWSTD8IXl06hpcYyHRPP8isl0iIk4bTOHceX+kNUfbfl1uA9s3+pYiBwTd9Heo99xerV7CZx82+TQ4PQ4Wl7ejLnDMQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(36840700001)(46966006)(40470700004)(70586007)(110136005)(70206006)(36860700001)(336012)(426003)(54906003)(316002)(8936002)(4326008)(47076005)(8676002)(40460700003)(83380400001)(2906002)(36756003)(478600001)(6666004)(86362001)(7696005)(356005)(81166007)(82740400003)(41300700001)(16526019)(5660300002)(26005)(2616005)(40480700001)(1076003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:08:25.1985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7a791d-87ce-4709-d996-08dbf02c4066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244

Add functions to the EINJ module to be used in the CXL module for CXL
protocol error injection. The callbacks implement the einj_types and
einj_inject files under /sys/kernel/debug/cxl/portX/dportY. These two
files work in the same way as the available_error_types and error_inject
files under /sys/kernel/debug/apei/einj, but only for CXL error types.
If the dport is enumerated in RCH (CXL 1.1) mode, a CXL 1.1 error is
injected into the dport; a CXL 2.0 error is injected otherwise.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/Kconfig |   3 ++
 drivers/acpi/apei/einj.c  | 105 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..100c27beb581 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -11,6 +11,9 @@ config ACPI_APEI
 	select PSTORE
 	select UEFI_CPER
 	depends on HAVE_ACPI_APEI
+	imply CXL_BUS
+	imply CXL_ACPI
+	imply CXL_PORT
 	help
 	  APEI allows to report errors (for example from the chipset)
 	  to the operating system. This improves NMI handling
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 330329ac2f1f..98d5e6d60a02 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -21,9 +21,11 @@
 #include <linux/nmi.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 #include <asm/unaligned.h>
 
 #include "apei-internal.h"
+#include "../../cxl/cxl.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "EINJ: " fmt
@@ -627,6 +629,25 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
+static int cxl_einj_available_error_type(struct seq_file *m, void *v)
+{
+	int cxl_err, rc;
+	u32 available_error_type = 0;
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
+
+	return 0;
+}
+
 static int validate_error_type(u64 type)
 {
 	u32 tval, vendor, available_error_type = 0;
@@ -657,6 +678,68 @@ static int validate_error_type(u64 type)
 	return 0;
 }
 
+static int cxl_dport_get_sbdf(struct cxl_dport *dport, u64 *sbdf)
+{
+	struct pci_dev *pdev;
+	struct pci_bus *pbus;
+	struct pci_host_bridge *bridge;
+	u64 seg = 0, bus;
+
+	if (!dev_is_pci(dport->dport_dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dport->dport_dev);
+	pbus = pdev->bus;
+	bridge = pci_find_host_bridge(pbus);
+
+	if (!bridge)
+		return -ENODEV;
+
+	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
+		seg = bridge->domain_nr << 24;
+
+	bus = pbus->number << 16;
+	*sbdf = seg | bus | pdev->devfn;
+
+	return 0;
+}
+
+static int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
+{
+	u64 param1 = 0, param2 = 0, param4 = 0;
+	u32 flags;
+	int rc;
+
+	/* Only CXL error types can be specified */
+	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(type);
+	if (rc)
+		return rc;
+
+	/*
+	 * If dport is in restricted mode, inject a CXL 1.1 error,
+	 * otherwise inject a CXL 2.0 error
+	 */
+	if (dport->rch) {
+		if (dport->rcrb.base == CXL_RESOURCE_NONE)
+			return -EINVAL;
+
+		param1 = (u64) dport->rcrb.base;
+		param2 = 0xfffffffffffff000;
+		flags = 0x2;
+	} else {
+		rc = cxl_dport_get_sbdf(dport, &param4);
+		if (rc)
+			return rc;
+
+		flags = 0x4;
+	}
+
+	return einj_error_inject(type, flags, param1, param2, 0, param4);
+}
+
 static int error_type_get(void *data, u64 *val)
 {
 	*val = error_type;
@@ -668,6 +751,7 @@ static int error_type_set(void *data, u64 val)
 {
 	int rc;
 
+	/* CXL error types have to be injected from cxl debugfs */
 	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
 		return -EINVAL;
 
@@ -714,6 +798,7 @@ static int __init einj_init(void)
 {
 	int rc;
 	acpi_status status;
+	struct cxl_einj_ops cxl_ops;
 	struct apei_exec_context ctx;
 
 	if (acpi_disabled) {
@@ -793,6 +878,15 @@ static int __init einj_init(void)
 				   einj_debug_dir, &vendor_flags);
 	}
 
+	if (IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)) {
+		cxl_ops = (struct cxl_einj_ops) {
+			.einj_type = cxl_einj_available_error_type,
+			.einj_inject = cxl_einj_inject_error,
+		};
+
+		cxl_einj_set_ops_cbs(&cxl_ops);
+	}
+
 	pr_info("Error INJection is initialized.\n");
 
 	return 0;
@@ -810,8 +904,18 @@ static int __init einj_init(void)
 
 static void __exit einj_exit(void)
 {
+	struct cxl_einj_ops cxl_ops;
 	struct apei_exec_context ctx;
 
+	if (IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)) {
+		cxl_ops = (struct cxl_einj_ops) {
+			.einj_type = NULL,
+			.einj_inject = NULL,
+		};
+
+		cxl_einj_set_ops_cbs(&cxl_ops);
+	}
+
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
 			sizeof(struct set_error_type_with_address) :
@@ -832,4 +936,5 @@ module_exit(einj_exit);
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("APEI Error INJection support");
+MODULE_IMPORT_NS(CXL);
 MODULE_LICENSE("GPL");
-- 
2.34.1


