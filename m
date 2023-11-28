Return-Path: <linux-acpi+bounces-1870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831747FBF70
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0310B20CA8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9DD5E0C5
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AJ0PqEUm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72914DA;
	Tue, 28 Nov 2023 08:07:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3c84fCmg56skiujxRbXQf5MIKttj5NJ9PMZW4efZeFCYTDDaKxAhbgvCxTkfiLa2MtcXO2OeIXafG2d/ODz6AIa1DLuzDxE10ltPapanqaKOXJMcLqbUD+4fTnL3zLCVT0e55npbXa+YMJ82pXH6VsI/KdX7VcCu0/xKUsWwZP2i8yvlLOqMjKfrg3LgNKnXvKTfcQmi6oNvK4RDooBspvdmeSxM1EVL0InuvLlyQvtESAYJPIgYTaUqP3XZ9LTreOSjAB/FVuWQNvsfGV/pFmKATKVWjl97nMNaexXho1lrX00kGcG/QxCFivEdU4PQe6zsb2njvl1/c3FFyN9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns6sYwxro6lc7RGkxwPb/0p/KGPAaDwl+r3CHX1WmF4=;
 b=YYc392T2aX2EXGqlTSDRPt0xBWvCURyMgMyay2i4h09FauvbS/8Sy259UW53tNUrUYFXppaDR6Fc+JKc0R+usk8akCZ6XI/YcyMj9qUTfwbX6lAZxHKmsMHyVxcAzcV4+R3drNmpQwbkyXxqOJXIk7/kKQ+THtCiH8RuRK43TWwzL+/he1JTPiWlbslsdtRRGt014vvSvi0laf8O2wlTgJ3Efb1xS1Vs3GcOE76nfiFqTCs4B+4m1FlVsGJdbl1gDkDTz6h1zgcjjQpAFgC58pKhEA/93scMq2qgXUC4tpIJxLrDTRok0XTU86d9VKfCY6Q3AraJDjtKerS81BazHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns6sYwxro6lc7RGkxwPb/0p/KGPAaDwl+r3CHX1WmF4=;
 b=AJ0PqEUmKtOU6qPA6KM2aMOe7WhfIp6OAkOwCLGK/bb3IQgVTo+86UFo9/ZwUPG4kNXIfoPLf9z6fFba7a8jjwnCFqv7YCBhiZ5uAXbw2bULCuX5uh5sxSq9bJotTJM6d1fcc0XkWYXwKqAYYcjVaXk/y6HDK0KYm6ClNANjaJI=
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 16:07:25 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::ce) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 16:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 16:07:25 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 10:07:23 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 1/5] cxl/port: Add EINJ debugfs files and callback support
Date: Tue, 28 Nov 2023 10:06:52 -0600
Message-ID: <20231128160656.166609-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: e9050e4c-e4a8-429d-2426-08dbf02c1cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wGEr0fDFP4Hiot7cJlEfqvPFbvEAkPt6PvslX2dv7163eCPTuZMiWVjWqDGmdcUhXDTvKZyW4nrv/3OrjVTo9CWNoJChIH2FVoDhRSrjlWxQ1GmDdh+bn5xjQaek2oXybo0cQJlcgEryWozPtJcaqTHO4u0MGqmwTxjg94dTwq1g6Gwb9v4su1bsSWZOCLhAvMYzpQhwjaIR2L1fgq2ni5SVUsVl/JfubLchGTUlgABDt+YQxXXk6W+DgfiVdn1IfrdHhOmYHoEIJiCDzwaC9LQPcUNGQmM0fReIA1V6JMvqvSsWwW4pflkdQUv3c/CQFiUPzelGIlyv8V7TtLaxa/p/PFpJ2YiOTnlmTq2+urmVgQlLZiiRLmjsNRMtIGgmRV9nT9vmSvdIHn3TQF0xBiU6btqGToWR+sxmNl2HDlivOsdlhj8hZ4cPiKgpyedla2DhIoR+Z3TZtGbq9ShEh19NLks2CCDgb8zPNFrScHIWV9xAu/ffe6TZmKrzeEcBYlKdu+Gyw9mdrSUDYx1X2H1gy2E76LzzO07FaoIgD9erSvt5s3/G+z7eiRDU8h+58xCT5qaBHtCMVU2wE7z7vF66+8wUWSVTTfoGueN/by51lQKSGzwMOWFVbYeii1v4U04Vo5ksBH14Lf9aDKHvbRSzz8XuQ1kDFsunk/Ah5WUwaLpz5amKLTelhSQt7g4HH+olAqNJFuZYXH+MdpGPY0w99GBNe3QIGhfnTEuBsce+roFtI/Acnrwn1Uun3kBrxzEblpz+7NiY3kV/Dudm4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(82740400003)(356005)(40460700003)(86362001)(81166007)(41300700001)(7696005)(478600001)(6666004)(7416002)(4326008)(5660300002)(8676002)(110136005)(54906003)(70586007)(70206006)(316002)(8936002)(2906002)(47076005)(40480700001)(426003)(336012)(16526019)(26005)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:07:25.3701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9050e4c-e4a8-429d-2426-08dbf02c1cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

Add creation of debugfs directories for ports and dports under
/sys/kernel/debug/cxl when EINJ support is enabled. The dport
directories will contain files for injecting CXL protocol errors.
These files are only usable once the EINJ module has loaded and
registered callback functions with the CXL core module, before that
occurs (or if the EINJ module isn't loaded) the files will do nothing
and return an ENODEV error.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl | 27 +++++++++
 drivers/cxl/core/port.c               | 84 +++++++++++++++++++++++++++
 drivers/cxl/cxl.h                     | 10 ++++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..782a1bb78884 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,30 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+What:		/sys/kernel/debug/cxl/portX/dportY/einj_types
+Date:		November, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Prints the CXL protocol error types made available by
+		the platform in the format "0x<error number>	<error type>".
+		The <error number> can be written to einj_inject to inject
+		<error type> into dportY. This file is only visible if
+		CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
+		be able to reach one (or both) of the CXL_ACPI or CXL_PORT
+		modules to be functional.
+
+What:		/sys/kernel/debug/cxl/portX/dportY/einj_inject
+Date:		November, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Writing an integer to this file injects the corresponding
+		CXL protocol error into dportY (integer to type mapping is
+		available by reading from einj_types). If the dport was
+		enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
+		a CXL 2.0 error is injected. This file is only visible if
+		CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
+		be able to reach one (or both) of the CXL_ACPI or CXL_PORT
+		modules to be functional.
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 38441634e4c6..acf10415a174 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -783,6 +783,72 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+static struct cxl_einj_ops einj_ops;
+void cxl_einj_set_ops_cbs(struct cxl_einj_ops *ops)
+{
+	if (!IS_REACHABLE(CONFIG_ACPI_APEI_EINJ) || !ops)
+		return;
+
+	einj_ops = *ops;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_einj_set_ops_cbs, CXL);
+
+static int cxl_einj_type_show(struct seq_file *f, void *data)
+{
+	if (!einj_ops.einj_type)
+		return -ENODEV;
+
+	return einj_ops.einj_type(f, data);
+}
+
+static int cxl_einj_inject(void *data, u64 type)
+{
+	struct cxl_dport *dport = data;
+
+	if (!einj_ops.einj_inject)
+		return -ENODEV;
+
+	return einj_ops.einj_inject(dport, type);
+}
+DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
+
+static int cxl_debugfs_create_dport_dir(struct dentry *port_dir,
+						   struct cxl_dport *dport)
+{
+	struct dentry *dir;
+	char dir_name[32];
+
+	snprintf(dir_name, 31, "dport%d", dport->port_id);
+	dir = debugfs_create_dir(dir_name, port_dir);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	debugfs_create_devm_seqfile(dport->dport_dev, "einj_types", dir,
+				    cxl_einj_type_show);
+
+	debugfs_create_file("einj_inject", 0200, dir, dport,
+			    &cxl_einj_inject_fops);
+	return 0;
+}
+
+static struct dentry *cxl_debugfs_create_port_dir(struct cxl_port *port)
+{
+	const char *dir_name = dev_name(&port->dev);
+	struct dentry *dir;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ))
+		return ERR_PTR(-ENODEV);
+
+	dir = cxl_debugfs_create_dir(dir_name);
+	if (IS_ERR(dir)) {
+		dev_dbg(&port->dev, "Failed to create port debugfs dir: %ld\n",
+			PTR_ERR(dir));
+		return dir;
+	}
+
+	return dir;
+}
+
 static struct cxl_port *__devm_cxl_add_port(struct device *host,
 					    struct device *uport_dev,
 					    resource_size_t component_reg_phys,
@@ -861,6 +927,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port, *parent_port;
+	struct dentry *dir;
 
 	port = __devm_cxl_add_port(host, uport_dev, component_reg_phys,
 				   parent_dport);
@@ -878,6 +945,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 			parent_port ? " to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
 			parent_port ? "" : " (root port)");
+
+		dir = cxl_debugfs_create_port_dir(port);
+		if (!IS_ERR(dir))
+			port->debug_dir = dir;
 	}
 
 	return port;
@@ -1127,6 +1198,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     resource_size_t component_reg_phys)
 {
 	struct cxl_dport *dport;
+	int rc;
 
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
 				     component_reg_phys, CXL_RESOURCE_NONE);
@@ -1136,6 +1208,11 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 	} else {
 		dev_dbg(dport_dev, "dport added to %s\n",
 			dev_name(&port->dev));
+
+		rc = cxl_debugfs_create_dport_dir(port->debug_dir, dport);
+		if (rc)
+			dev_dbg(dport_dev,
+				"Failed to create dport debugfs dir: %d\n", rc);
 	}
 
 	return dport;
@@ -1156,6 +1233,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb)
 {
 	struct cxl_dport *dport;
+	int rc;
 
 	if (rcrb == CXL_RESOURCE_NONE) {
 		dev_dbg(&port->dev, "failed to add RCH dport, missing RCRB\n");
@@ -1170,6 +1248,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 	} else {
 		dev_dbg(dport_dev, "RCH dport added to %s\n",
 			dev_name(&port->dev));
+
+		rc = cxl_debugfs_create_dport_dir(port->debug_dir, dport);
+		if (rc)
+			dev_dbg(dport_dev,
+				"Failed to create rch dport debugfs dir: %d\n",
+				rc);
 	}
 
 	return dport;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 687043ece101..3c7744fc3106 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -590,6 +590,7 @@ struct cxl_dax_region {
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
+ * @debug_dir: dentry for port in cxl debugfs (optional)
  */
 struct cxl_port {
 	struct device dev;
@@ -612,6 +613,7 @@ struct cxl_port {
 		size_t length;
 	} cdat;
 	bool cdat_available;
+	struct dentry *debug_dir;
 };
 
 static inline struct cxl_dport *
@@ -813,6 +815,14 @@ bool is_cxl_nvdimm_bridge(struct device *dev);
 int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
 struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
 
+struct cxl_einj_ops {
+	int (*einj_type)(struct seq_file *f, void *data);
+	int (*einj_inject)(struct cxl_dport *dport, u64 type);
+};
+
+void cxl_einj_set_ops_cbs(struct cxl_einj_ops *ops);
+
+
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-- 
2.34.1


