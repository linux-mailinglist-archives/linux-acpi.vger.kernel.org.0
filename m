Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25976190C7B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 12:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCXLao (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 07:30:44 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:6104
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbgCXLan (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 07:30:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSYrxq+UcAxQ3EAWRZwsuSSdLF7VjlVtsCttnCE6RyxsvMG2V6U8PjjQAElc6uorVhWcGKv8JvZltgU7LKJz9YDH0ISD798GA0otzXBl7BhLdEKevSMWXuwB6brZEF5vytnHAnk3CVIhWoKOAzrYgrcVuVbZdZJ6rAZ7ftfOsa69lvVpU8usVIGg8QJzOd4sbIthyy085FV2giev2Ixk//XOU89WnI/gp7NW3KTRE//L2HVrjOdLMl3tYqXB+UOmQRBJ2aY8AihPUv7PUgLMYnwb32vlxTWuQGyKisegg1d2nnS6oKqbbLFzOvQM/f0lxJbUggXQTN4tHI2H0oA3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzYnQe6fdBla4ABk2/tHy5gf92LXd+R3+suiLttBwpA=;
 b=h7KNmw8+7yv09FVeWjHXR5pdgr9qDG3LOEafxotDCRZ9z5JCb6U+qZ7L0NtYOqPi04AnfedQ6t2nUuQh4MVq6O6Ceqwq9qawIAwJVkq+los8RFg6wUbkOovYOKRk7mydr/SHdNwSGjo5IyPxH1ZdY1iFq5gyNtehPUVlIxjNMcMnVc4FYUSCXDRdKSPQRG3fDcPED0j4WE1A4OCykozQByJkTS2hk2o+AbSb+vXzedTSbOGEu8ZOkkLyykVGzLWYCd+WLxKIU5wOxbpQe1bbfw4lSscgCkBs2usPA2P6OzK0nze3PRIKSuvk3TZtZSCpJ5/T+WXnBIdrLwcwoCDcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzYnQe6fdBla4ABk2/tHy5gf92LXd+R3+suiLttBwpA=;
 b=FimIDg9zG1F5BCoiS3iQPedb3WEpKd6rgYupj7mDJMx47fI6adNt4RnKl1gsOF8UT9uTjifYL7rRTLVHeUu+Dh/PIZ0bzUxL3ZAJH+B98o8BpGdIeY6EwSbmUBpNVbfw5UmGlaP16Qu3UDBcygL9hOsgStxe4MAsaSty44Eh0u4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB5960.eurprd04.prod.outlook.com (20.178.92.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 11:30:37 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e%5]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 11:30:37 +0000
From:   laurentiu.tudor@nxp.com
To:     robin.murphy@arm.com, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, ioana.ciornei@nxp.com,
        diana.craciun@oss.nxp.com, maz@kernel.org, jon@solid-run.com,
        pankaj.bansal@nxp.com, makarand.pawagi@nxp.com,
        calvin.johnson@nxp.com, V.Sethi@nxp.com, cristian.sovaiala@nxp.com,
        Stuart.Yoder@arm.com, jeremy.linton@arm.com, joro@8bytes.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: [RFC PATCH v2 3/4] bus: fsl-mc: Add ACPI support for fsl-mc
Date:   Tue, 24 Mar 2020 13:30:22 +0200
Message-Id: <20200324113023.322-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324113023.322-1-laurentiu.tudor@nxp.com>
References: <20200324113023.322-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::49) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by AM0PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:208:ab::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 11:30:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a8eb7d5-d41b-4735-544b-08d7cfe6c5f8
X-MS-TrafficTypeDiagnostic: AM6PR04MB5960:|AM6PR04MB5960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB59609E61BECEC00741D8D60BECF10@AM6PR04MB5960.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:152;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(66476007)(6486002)(66556008)(66946007)(6512007)(2906002)(9686003)(478600001)(81166006)(8676002)(186003)(16526019)(81156014)(26005)(52116002)(8936002)(6506007)(1076003)(7416002)(2616005)(5660300002)(956004)(4326008)(6666004)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5960;H:AM6PR04MB5925.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhifNbmejs9D0UejEve1I9zGQPylFT1gHaJ2qUzhHdooF8y1S+Q9QTwl0Z7RHxtSF3JMI+TtT82+FyRyxXAWzEFDjt+BqICrQac3+ByW+/ajgRzsQbcs+DqmI1wstY18ekpsgRusYO5JGua/FKSF0VWzXdQ79MYMtATNggN6CwZuAi9EWyP86kgNE4PhAKT7FQNNQYmfELH4i1LDAo2opwMhwskFMxJKnDTJPwyOaD76Y9t7OFlHDJpcdHOwQ9cjWN3BlqLXjNQwAZTV7ohxusDm6dG+4cTFNCJ3cZiPOwbyjHgeKES6G3OsWov73n+K2bac9oThV6LL9qK9k3izFgGy/nJbBC/NfctmZ75YlqjV49ffbnTvIEU7eR5ma/cCDYDt20GyJ12AIhnIemLMwyIibDfQRoqAS4Zt9RioaIOHC5t8baUIDxvNlCzVXYz8
X-MS-Exchange-AntiSpam-MessageData: k8GZNfj5wuEMhq+1w4V1UN1apkG8sgXQ+qWypwSda0keCyfEnpA7+LcVKACcblvPU1Gly0YtxK7cmYfYL154GPZ2EI3TI92qLSxuB6MN1ECbsFtMHc/rXfbsNeBc7aW40xASUeFM+GnZ2peMj6g4xg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8eb7d5-d41b-4735-544b-08d7cfe6c5f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:30:36.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zyg9A1NrM5tg0Sw1X7T3Uv31YBjRk5Mdw//k8QlZRELfg7f0p0TaQRdTGPC5Sadm3NQiijwxuJR35+G2JIm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5960
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Makarand Pawagi <makarand.pawagi@nxp.com>

ACPI support is added in the fsl-mc driver. Driver will parse
MC DSDT table to extract memory and other resorces.

Interrupt (GIC ITS) information will be extracted from MADT table
by drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.

IORT table will be parsed to configure DMA.

Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c             | 35 ++++++-----
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 69 ++++++++++++++++++++-
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index a3d25c1d4ff8..fbd248597e88 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -952,7 +952,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	phys_addr_t mc_portal_phys_addr;
 	u32 mc_portal_size;
 	struct mc_version mc_version;
-	struct resource res;
+	struct resource *plat_res;
 
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
@@ -963,16 +963,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	/*
 	 * Get physical address of MC portal for the root DPRC:
 	 */
-	error = of_address_to_resource(pdev->dev.of_node, 0, &res);
-	if (error < 0) {
-		dev_err(&pdev->dev,
-			"of_address_to_resource() failed for %pOF\n",
-			pdev->dev.of_node);
-		return error;
-	}
-
-	mc_portal_phys_addr = res.start;
-	mc_portal_size = resource_size(&res);
+	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mc_portal_phys_addr = plat_res->start;
+	mc_portal_size = resource_size(plat_res);
 	error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
 				 mc_portal_size, NULL,
 				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io);
@@ -989,11 +982,13 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
 		 mc_version.major, mc_version.minor, mc_version.revision);
 
-	error = get_mc_addr_translation_ranges(&pdev->dev,
-					       &mc->translation_ranges,
-					       &mc->num_translation_ranges);
-	if (error < 0)
-		goto error_cleanup_mc_io;
+	if (dev_of_node(&pdev->dev)) {
+		error = get_mc_addr_translation_ranges(&pdev->dev,
+						&mc->translation_ranges,
+						&mc->num_translation_ranges);
+		if (error < 0)
+			goto error_cleanup_mc_io;
+	}
 
 	error = dprc_get_container_id(mc_io, 0, &container_id);
 	if (error < 0) {
@@ -1020,6 +1015,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 		goto error_cleanup_mc_io;
 
 	mc->root_mc_bus_dev = mc_bus_dev;
+	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
 	return 0;
 
 error_cleanup_mc_io:
@@ -1053,11 +1049,18 @@ static const struct of_device_id fsl_mc_bus_match_table[] = {
 
 MODULE_DEVICE_TABLE(of, fsl_mc_bus_match_table);
 
+static const struct acpi_device_id fsl_mc_bus_acpi_match_table[] = {
+	{"NXP0008", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, fsl_mc_bus_acpi_match_table);
+
 static struct platform_driver fsl_mc_bus_driver = {
 	.driver = {
 		   .name = "fsl_mc_bus",
 		   .pm = NULL,
 		   .of_match_table = fsl_mc_bus_match_table,
+		   .acpi_match_table = fsl_mc_bus_acpi_match_table,
 		   },
 	.probe = fsl_mc_bus_probe,
 	.remove = fsl_mc_bus_remove,
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 606efa64adff..6d67834722c9 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -4,9 +4,11 @@
  *
  * Copyright (C) 2015-2016 Freescale Semiconductor, Inc.
  * Author: German Rivera <German.Rivera@freescale.com>
+ * Copyright 2020 NXP
  *
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/irq.h>
@@ -66,7 +68,65 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_fsl_mc_msi_init(void)
+static int __init its_fsl_mc_msi_init_one(struct fwnode_handle *handle,
+					  const char *name)
+{
+	struct irq_domain *parent;
+	struct irq_domain *mc_msi_domain;
+
+	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("%s: Unable to locate ITS domain\n", name);
+		return -ENXIO;
+	}
+
+	mc_msi_domain = fsl_mc_msi_create_irq_domain(handle,
+						     &its_fsl_mc_msi_domain_info,
+						     parent);
+	if (!mc_msi_domain)
+		pr_err("ACPIF: unable to create fsl-mc domain\n");
+
+	pr_info("fsl-mc MSI: domain created\n");
+
+	return 0;
+}
+
+static int __init
+its_fsl_mc_msi_parse_madt(union acpi_subtable_headers *header,
+			  const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	const char *node_name;
+	int err = -ENXIO;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
+			      (long)its_entry->base_address);
+
+	dom_handle = iort_find_domain_token(its_entry->translation_id);
+	if (!dom_handle) {
+		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
+		goto out;
+	}
+
+	err = its_fsl_mc_msi_init_one(dom_handle, node_name);
+	if (!err)
+		pr_info("fsl-mc MSI: %s domain created\n", node_name);
+
+out:
+	kfree(node_name);
+	return err;
+}
+
+static int __init its_fsl_mc_acpi_msi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_fsl_mc_msi_parse_madt, 0);
+	return 0;
+}
+
+static int __init its_fsl_mc_of_msi_init(void)
 {
 	struct device_node *np;
 	struct irq_domain *parent;
@@ -100,4 +160,11 @@ static int __init its_fsl_mc_msi_init(void)
 	return 0;
 }
 
+static int __init its_fsl_mc_msi_init(void)
+{
+	its_fsl_mc_of_msi_init();
+	its_fsl_mc_acpi_msi_init();
+
+	return 0;
+}
 early_initcall(its_fsl_mc_msi_init);
-- 
2.17.1

