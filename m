Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF311714B3
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2020 11:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgB0KGA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Feb 2020 05:06:00 -0500
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:32321
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728630AbgB0KGA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Feb 2020 05:06:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciJRW8Us6sUYaAeVtx1zg7ohx6rUnu10YWU2KFxG+y9IhJdLkRgDf+Rjfj25Qs83B0UUXBOg9/Y/MicOqCuE/6vF8KE4b2jjKf2IKJ4Daa95ln0r/z1iO0iQUEEWMLgEgoOA8CopBXgwZEDaYk1QK45kSiCqvcMVQr3ZWoDvJn8XbPpx4IPufvTm3Eq3CBe3uGZyBUCa3KLVPjOU7ykitw6mCOTnonSrVKicnIPY87XS9GsYTdip4uhAbM47XI0hORxkk15sx+uRwwC62YVFrSPe3I/Jjxq77dAKo56QHU3fkS0S5dvNHGrK7BPdvJckg66raQrcVrKzndN1HvMoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLlmxo3F4Gx/ZLPQd1vZdy7uzn9E1hqWbQUmSJHTuto=;
 b=je0AUJt9LqV/e2JL6lrZxf10H3VWonA46Mmbi3Ph4Ek1CWUD68sUWlmisfJj4+gjs8CrGRBoEkbmeVcksWifddrQ4sV9YJyfb91O0a6hPSOJmdTRQ3x09+j/YzuRlAm4Qzzrj+U6fgKZiBltj/979zhI4zkGhlljqbgN7v9I7TUCAonwzY1JBy7EuTVifPLVDb8oYymJc0CHdZTP/8rwVCCykHYAbXjQLfvGwdQdu+s3qaartmy0PDSaAc2Y+D96xMX2nxDX8RGd1x0ooGendCxKq7axFM/KC9FNIAUlasTOZYcZfZO4GRnd1APh5xDD05I5S4kdIl0GuFCHz4TcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLlmxo3F4Gx/ZLPQd1vZdy7uzn9E1hqWbQUmSJHTuto=;
 b=QQv44OYZWOSr3ebdR5+PzTJDK5pLjbLpMmPgyCZbKeiIRO0MgKSfB64WofDzK0qtFVS6RxSj2ryFDbL95qWVrwRKHx+aRZ+OwlWAzv+8z1uOIBp+GK9GbrF1rk/XeALk6Jf8tuzAOyOQs7D4kMS3KO96a1bTdrocNESBnMksetk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB4069.eurprd04.prod.outlook.com (52.135.165.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 27 Feb 2020 10:05:57 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:05:57 +0000
From:   laurentiu.tudor@nxp.com
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     robin.murphy@arm.com, lorenzo.pieralisi@arm.com,
        ard.biesheuvel@linaro.org, ioana.ciornei@nxp.com,
        diana.craciun@oss.nxp.com, maz@kernel.org, jon@solid-run.com,
        pankaj.bansal@nxp.com, makarand.pawagi@nxp.com,
        calvin.johnson@nxp.com, V.Sethi@nxp.com, cristian.sovaiala@nxp.com,
        Stuart.Yoder@arm.com, jeremy.linton@arm.com, joro@8bytes.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH 4/4] iommu/of: get rid of fsl-mc specific code
Date:   Thu, 27 Feb 2020 12:05:42 +0200
Message-Id: <20200227100542.13819-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM6P192CA0056.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::33) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by AM6P192CA0056.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 10:05:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52036203-d487-44d7-39f1-08d7bb6ca340
X-MS-TrafficTypeDiagnostic: AM6PR04MB4069:|AM6PR04MB4069:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4069D4ACEF8C0AD0C8206CC6ECEB0@AM6PR04MB4069.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(478600001)(26005)(16526019)(186003)(4326008)(2616005)(956004)(6666004)(1076003)(6486002)(52116002)(2906002)(86362001)(6506007)(81166006)(5660300002)(8676002)(66946007)(66556008)(66476007)(81156014)(8936002)(9686003)(6512007)(36756003)(316002)(7416002)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4069;H:AM6PR04MB5878.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1mBzZx05xD5eiHnLiCkSACV+x45nCV1dT2ITTNJnH5dkoOYef3iAQ34+QaG0Pi2EBazmQGhmtrHjP8J/G1EG8XMbbAl0KSMc/JuuklZV5BgJV1jpz0IgdHFBnwN5HtTFVea58Ocjaf/r/PdSeuMnqK2XV8MXscc+Zb6CHWxRAzMlc7o4T2KbbnHWwNzlUtkW/81ZnzHEKjAaTzvU3nUODt+XoiOJPJY2plGI8FkskZD0X23aZEodVpmbavN1S4gvtySjLGD59FmzuCWsZCmkTBvXYdFSLXLwrO6IIipPEi6KyuJebbGQ6Ian0cXWMK8bFwKDQy2lmXTblQAh987o5pNlX4h2D2rOqF88at9zsRqMjMDhFDK458FX3rprIBkgIL8gSfx6QN70NmhfFkPzQ3hDaIUcm8y/YDjAXF80bfN+Ya9O5t34GRNi+a/MAp13sZqpWVIwczn6mKaYzvSluJq1R0Za/vbcRaWUYgYDZfzUf3DAjUp0e6X0CBu51Aq
X-MS-Exchange-AntiSpam-MessageData: +quKIS40JU+BkebzJKKIRLC8irz5mKI78HQEN0aUWWIgCb0c/2bHr1QDdRv/2OdTd1l4OeMeY7/fI9wV/NbAQM1WpMhc/wArYhqmWafBVLh1j43523hhiyIJbfO0jz5MPaaWDw4ESu2+dbyJdlRZjw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52036203-d487-44d7-39f1-08d7bb6ca340
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:05:56.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9S2emav2JOVvH+ZrtxIDk0aA50T5BxZu+ITgTzYF/c4DwAO1TDHHsS66yVSV1h5E/59ubzzHWcbxfazr28fGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4069
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Changing the way we configure dma for fsl-mc devices allows
us to get rid of our fsl-mc specific code in the generic
of iommu code.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/iommu/of_iommu.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20738aacac89..332072ada474 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -15,7 +15,6 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/fsl/mc.h>
 
 #define NO_IOMMU	1
 
@@ -139,23 +138,6 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return err;
 }
 
-static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
-				struct device_node *master_np)
-{
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
-	int err;
-
-	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
-			 "iommu-map-mask", &iommu_spec.np,
-			 iommu_spec.args);
-	if (err)
-		return err == -ENODEV ? NO_IOMMU : err;
-
-	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
-	of_node_put(iommu_spec.np);
-	return err;
-}
-
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -188,8 +170,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
-	} else if (dev_is_fsl_mc(dev)) {
-		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
 		struct of_phandle_args iommu_spec;
 		int idx = 0;
-- 
2.17.1

