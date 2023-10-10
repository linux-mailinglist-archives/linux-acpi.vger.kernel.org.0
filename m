Return-Path: <linux-acpi+bounces-574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA37C4161
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDF6281467
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD9225D9
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ni7LdzSc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2429CEB;
	Tue, 10 Oct 2023 20:04:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE5F94;
	Tue, 10 Oct 2023 13:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjSuw7Esg3VYozmvhbPGHKnWu1CIHP8BFQgJu3CehXNXJr0TZuZlyoyDAouO7CiRHwIsQLqdxOk4w+ZotZYjDiziO2TxfqQWHL0yJl9GBM/5kI8cn2ezT5cuGfpoQCPkr7xGeyNVNFkfc3sJQySyVzH8RlYrmUVIBv2ALMUU8De9c7UseW1McI3P6gBrV0J1XkzgaCT2yaOj192/iZGOSzaObRockDJIrRKDmlEVcT0qHl4scIJQfd6IMwUPteX1QUiDdZgAK6r21XtVLSu5JBNPpLDmUj5baLK6bOlX/9L0PNPFOFPWvQrk9hzx/ElEAQDyQdTECP3U8Ex0pIpcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoKlsIXwSz7IIGh+jUGFjWqKnm0Bdw+GO+aeWW/uVU0=;
 b=gAtxK7nHdqYpDCXdorG3/zd94P/JTuvFWZ7IP3guyJIQsB5NTJ//IumRXT2W0W0frIzEEDE6dZZyLDw3GpwnS60XLF9zgmX1Ph159FtIznRs8GzrhROS2anbykch1ZcSIFgqgn/trIp4YCQ1RHIhPj+Mz31tDkP604QS9Ls3kJVrcO8JTlkkPkpJGmIAYHLHo+dpb+i5Dva5s58edqhosnqZNGcWuOB+pDHljO4W0/BPd5An1g8kpAg4iIN+a+QVOWFgYGiwFtvXyEurVLjEgKuYptQlyfaBQuhr6IuS7MuafYhyQ2PYdh2WWOLbclEgtJOlXGXtwJ+4uUp82Zq0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoKlsIXwSz7IIGh+jUGFjWqKnm0Bdw+GO+aeWW/uVU0=;
 b=Ni7LdzScNRKoZsSaJFWJFPc5tCkhSFu6KWuekR1GQI5uXSv1wynLVAkRw4PxOYccHaMcnG3UTiD8YZFWkXc/uAE5eNfijuShHpcPOVAwcq48zywzWu41Z3CPXjDK+sPrQeDT7QwK+c6Thb67+LPHeF3dacR25iengC08lMCFdoU=
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 20:03:53 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::c) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 20:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 20:03:53 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 10 Oct 2023 15:03:52 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>
Subject: [PATCH v6 4/5] cxl/port, EINJ: Add CXL EINJ callback functions
Date: Tue, 10 Oct 2023 15:02:53 -0500
Message-ID: <20231010200254.764273-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
References: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5b8413-0bf3-45d6-e2bf-08dbc9cc075f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zXvywzX7XLU71LvP1PV435CYEX6kAISPwEt/wCqRuvMYc2Q9lo2mEdBYOWRww2NuDFYzhWZvFVKsbgCHTjAc+0X1JUo0neD/7EmLmA27WIq6gYkscfB2cIU7vhzm/AB/dHBAake/d/toJ1zXs/EOril0vt5Li1Xz5Ymy021F9/wTeGrCAWcu/P1hGOgKhFIT6MixD7gT5j8pquWySXBftdFKKkk3hhQsG8dq2Q/DvA3tFarWaAt5Wcz4C4E08Xj9gtk9xkyZgz12qN0IviITF3WIDU4QEyR/zRUb0UvJY+GesMntomndF93JLIi1d1VJ4yGZaIMcngpZlsn7mjkEvKu+bF0vy/d8YbjScvpnidyfBmimMAtyK2xSAfUXsBbYvPQQSRAh3QtNwvbI0dTAr2ehWBYowwMm0FHI0W+YSvQPoxlMIDDgku3IuecR0dteBZbVirn7zTFdfHgtcxKgN/7rtj6FHTbcEy54GX2vYOJQTRL1L8hF5LptwVbAUZtfDNgs5Skym2HcOfZLT7wYTty14QYHKuYEyrFzCdgMZfrLcFEd15kf8YkH1ULYCZiwb4VuTZpCF/u3Iqxkxpp4yVX9O9f5g030txVG0QAolbti5NhqxUA5NDWaWw885saKJqRWdlnY//IGW4XZrWIOff9tSV9TPD6vjSzn+uMnHly6ZBUC4IYiHvwsjG3lmrvqY6i8uz6YLUWmpJPiHSv9tRFzMEe5mf+ONCEIaKOIlv4WIMb3qtqrfsWMkM1Jc4AZlC0+A6nG+fi1sD6kdkVMZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(47076005)(40480700001)(40460700003)(4326008)(8676002)(70586007)(54906003)(316002)(8936002)(70206006)(41300700001)(478600001)(2906002)(110136005)(86362001)(7696005)(426003)(5660300002)(36756003)(356005)(336012)(2616005)(1076003)(82740400003)(26005)(81166007)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:03:53.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5b8413-0bf3-45d6-e2bf-08dbc9cc075f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add functions to the EINJ module to be used in the CXL module for CXL
protocol error injection. The callbacks implement the einj_types and
einj_inject files under /sys/kernel/debug/cxl/portX/dportY. These two
files work in the same way as the available_error_types and error_inject
files under /sys/kernel/debug/apei/einj, but only for CXL error types.
If the dport is enumerated in RCH (CXL 1.1) mode, a CXL 1.1 error is
injected into the dport; a CXL 2.0 error is injected otherwise.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/Kconfig |   3 ++
 drivers/acpi/apei/einj.c  | 103 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

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
index 330329ac2f1f..801b159b505f 100644
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
@@ -627,6 +629,22 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
+static int cxl_einj_available_error_type(struct seq_file *m, void *v)
+{
+	int rc;
+	u32 available_error_type = 0;
+
+	rc = einj_get_available_error_type(&available_error_type);
+	if (rc)
+		return rc;
+
+	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++)
+		if (available_error_type & BIT(pos + 12))
+			seq_puts(m, einj_cxl_error_type_string[pos]);
+
+	return 0;
+}
+
 static int validate_error_type(u64 type)
 {
 	u32 tval, vendor, available_error_type = 0;
@@ -657,6 +675,69 @@ static int validate_error_type(u64 type)
 	return 0;
 }
 
+static int cxl_dport_get_sbdf(struct cxl_dport *dport, u64 *sbdf)
+{
+	struct pci_dev *pdev;
+	struct pci_bus *pbus;
+	struct pci_host_bridge *bridge;
+	u64 seg = 0, bus, devfn;
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
+	devfn = (PCI_DEVFN(PCI_SLOT(pdev->devfn),PCI_FUNC(pdev->devfn)) << 8);
+	*sbdf = seg | bus | devfn;
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
@@ -668,6 +749,7 @@ static int error_type_set(void *data, u64 val)
 {
 	int rc;
 
+	/* CXL error types have to be injected from cxl debugfs */
 	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
 		return -EINVAL;
 
@@ -714,6 +796,7 @@ static int __init einj_init(void)
 {
 	int rc;
 	acpi_status status;
+	struct cxl_einj_ops cxl_ops;
 	struct apei_exec_context ctx;
 
 	if (acpi_disabled) {
@@ -793,6 +876,15 @@ static int __init einj_init(void)
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
@@ -810,8 +902,18 @@ static int __init einj_init(void)
 
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
@@ -832,4 +934,5 @@ module_exit(einj_exit);
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("APEI Error INJection support");
+MODULE_IMPORT_NS(CXL);
 MODULE_LICENSE("GPL");
-- 
2.34.1


