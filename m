Return-Path: <linux-acpi+bounces-571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DB7C415C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736C9281375
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9F225B1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hnVD+XhL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484E2745F;
	Tue, 10 Oct 2023 20:03:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF23F4;
	Tue, 10 Oct 2023 13:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfnOb3q7YtVVwqNWMTY6fCH22laewg33n3mhNC/ZsaAyPodRPU09LHcAu8QGM36/kZFG7RYLYYU84cQNTXa5PG/1AOM/4Fld8h9t48zvsV1gvBCLI0FG6HJQ9In78IaUYt5FcOJ/zXFJIso6SXqcKC3M03S88ywy9ohAiDVZSawAdxbAxtI8phRMh+np83aUgEZdnxCMXnY/zKW9H8mMLTtl8sYpTLAAA+YaewItp4Pvaeg89ev+igVgZTkNK6eVN02RqD7iRCsJ4D2WHy3/P5AugdMY4EfmWkbR9FdI/3QUG+1zloB7X8YIjKWYKUSxCv7kcMFKiZnZh5rwOPj4TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWfIdvwc4u5ipDPQOfTOGfzt/HvN57Bb9SQTE92Prdk=;
 b=Hxi4kAzNAoewLREydOLAhMFknyyw4w46RzlGxHSSloCpU9ndJ7x8v7UhRkn40SItDDTQQcNSLPaOhA/AwvIUA0u3E6eTrujf5hSsfTPb+2gRz1xzDB7FX2tFD4cxV65yXZCm9p4PRO79hnYy9RhCb31myhLusLnz4+UhZuGXKOfshJE0la0aLFG1IrSwXYXawW2TM+gvRhAZxM8VGJCECqlTMyCg+QUhngnLn49g8sTaHeh983ovV0xyhlxW2FcsO8A6wVNF/xkozNt8OWSH+KGy8woriURrNgRh/YEysqJULMhZinqyfuQopHLLD9V9A5YhO7PgooAMynFw7qALWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWfIdvwc4u5ipDPQOfTOGfzt/HvN57Bb9SQTE92Prdk=;
 b=hnVD+XhLbxlTEUYJCWPk3aV/li2TQR2OuVSNwgVoS7JUrVA0eB8SW8tYKzL+kPdgN2WOqPhmIRhn3LoZgOPeuQeXm0xfKDLaB6hJcAe51ER6gWD2jpKGcn34jAv/9bt7prVZfJVQI9pWc3NcHnZ86IkuLPk2BTj0jVdoaprgcdA=
Received: from DM6PR05CA0046.namprd05.prod.outlook.com (2603:10b6:5:335::15)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 20:03:15 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::1d) by DM6PR05CA0046.outlook.office365.com
 (2603:10b6:5:335::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Tue, 10 Oct 2023 20:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 20:03:15 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 10 Oct 2023 15:03:14 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>
Subject: [PATCH v6 1/5] cxl/port: Add EINJ debugfs files and callback support
Date: Tue, 10 Oct 2023 15:02:50 -0500
Message-ID: <20231010200254.764273-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d6e208-0629-4782-750a-08dbc9cbf0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ajxQ5xaXom1/qZe3MTzFT+7CAStt9v11sfKtYEWLtEgj9EPhOQicpgt81rMvAulZDeO9ia+DgVjv5vMxhF1Mkcnw9LBQBOEeV5gSXEUIq/s7qyZTm56C3sdUqQfT3Exz7Ac0NkIR/VL/ISp+f9ylX25C67PX+f04UDQp172RGepiOzyNBGQ22BFLTA6YxKGWbal038lcC9XXxJZZkzF75A+9ItXjUZI4maWaMoiYfD9mWd5edOOP4SB1LeR9DOTfxYqXaTokIaFRAICMSrP0tsRhX/+ktn8199uusn5kSq0OMJRqqY3daSwULjIQ6UkW/+UsbyBk2picqVn/vpQeSUrc1m4ciFlFzS8BDSCW58mEWTBcSXtA8u18ObaJxcjuQCOshFcIUmm1iwonJtb9QWRkyfSQx7535Jt64iomsB1L1o2yOOuCsuERWa1WissCqYgcDfQTBsvo5XSxvpgUHFaBW5MtSkisdxE6oE9wJOwZ1KgXyX4yXfOuQu86eg3G20rIh8G1+YU4egLwpugjQkScyGsxYIzLuJgRu8JdqwmgxF9jqZNjooqHGSKF2fFvbHN2S8H3dxqoIp/gQwwHuV46dKGuBxELR4maZxTsyd3eDq92BytdZNSYHxhZt4BL7r65qst2RSzHkzq0cQwsXozim5twCYH0dRQPv4/5ahpNKK3qUZpkJV+qFOyBZg3UfJY/o4Ebe+x54/wN7pIv6Js+heX8MmziyprMAZSjHUu7moJIk7vasS5TZLoCwP+nCqMC8NOzD3Ore3etzGOkag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(46966006)(36840700001)(40470700004)(110136005)(316002)(70206006)(54906003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(70586007)(40460700003)(36860700001)(86362001)(1076003)(81166007)(7696005)(40480700001)(2906002)(2616005)(82740400003)(356005)(6666004)(36756003)(336012)(26005)(16526019)(426003)(478600001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:03:15.6415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d6e208-0629-4782-750a-08dbc9cbf0ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add creation of debugfs directories for ports and dports under
/sys/kernel/debug/cxl when EINJ support is enabled. The dport
directories will contain files for injecting CXL protocol errors.
These files are only usable once the EINJ module has loaded and
registered callback functions with the CXL core module, before that
occurs (or if the EINJ module isn't loaded) the files will do nothing
and return an ENODEV error.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/debugfs-cxl | 27 +++++++++
 drivers/cxl/core/port.c               | 84 +++++++++++++++++++++++++++
 drivers/cxl/cxl.h                     | 10 ++++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
index fe61d372e3fa..e87cb687cb1c 100644
--- a/Documentation/ABI/testing/debugfs-cxl
+++ b/Documentation/ABI/testing/debugfs-cxl
@@ -33,3 +33,30 @@ Description:
 		device cannot clear poison from the address, -ENXIO is returned.
 		The clear_poison attribute is only visible for devices
 		supporting the capability.
+
+What:		/sys/kernel/debug/cxl/portX/dportY/einj_types
+Date:		October, 2023
+KernelVersion:	v6.7
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
+Date:		October, 2023
+KernelVersion:	v6.7
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
index 7ca01a834e18..005c5cf4618e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -725,6 +725,72 @@ static int cxl_dport_setup_regs(struct cxl_dport *dport,
 				   component_reg_phys);
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
+	debugfs_create_file("einj_inject", 0x200, dir, dport,
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
@@ -788,6 +854,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct cxl_dport *parent_dport)
 {
 	struct cxl_port *port, *parent_port;
+	struct dentry *dir;
 
 	port = __devm_cxl_add_port(host, uport_dev, component_reg_phys,
 				   parent_dport);
@@ -805,6 +872,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 			parent_port ? " to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
 			parent_port ? "" : " (root port)");
+
+		dir = cxl_debugfs_create_port_dir(port);
+		if (!IS_ERR(dir))
+			port->debug_dir = dir;
 	}
 
 	return port;
@@ -1045,6 +1116,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     resource_size_t component_reg_phys)
 {
 	struct cxl_dport *dport;
+	int rc;
 
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
 				     component_reg_phys, CXL_RESOURCE_NONE);
@@ -1054,6 +1126,11 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
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
@@ -1074,6 +1151,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 resource_size_t rcrb)
 {
 	struct cxl_dport *dport;
+	int rc;
 
 	if (rcrb == CXL_RESOURCE_NONE) {
 		dev_dbg(&port->dev, "failed to add RCH dport, missing RCRB\n");
@@ -1088,6 +1166,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
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
index 76d92561af29..12025ed6b64e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -581,6 +581,7 @@ struct cxl_dax_region {
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
+ * @debug_dir: dentry for port in cxl debugfs (optional)
  */
 struct cxl_port {
 	struct device dev;
@@ -604,6 +605,7 @@ struct cxl_port {
 		size_t length;
 	} cdat;
 	bool cdat_available;
+	struct dentry *debug_dir;
 };
 
 static inline struct cxl_dport *
@@ -795,6 +797,14 @@ bool is_cxl_nvdimm_bridge(struct device *dev);
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


