Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DD190C74
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 12:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCXLah (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 07:30:37 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:6104
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbgCXLah (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 07:30:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtLC+krVy2YatXxLAJqi72IQYrEQck0S03MHKTlcdh4njBORzhbOi4q4sz/nfgLpoxSR90uzRq7K9IB8d7HjOjtOetM9HDVP6KocnrINs6M3JoL3xh4tooQsBrRbJTWmPK0wEVs171LvHuHCk6ZCWNn+O8jKHOamihNK+FmpGFxSQe7QcmCeFgFlJSbNHQCxYoUw/vXd19JXY44uZ3CdURTxE0k6sYikheZPANS8YyY0+xLPO3LzBnQ9Pk8jyfQQF56OxLMN697q/yuGlEJ6sTWSRbHjnhz1VLRR7XC9iRbHrvRU57mXGDRxgYjV1bAURLkvdNw+VIuL9Uq4bENFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg+8IM8Rq0BMgwys+NY7eYgPbomblGiHhi2paGqATyE=;
 b=kAZpLZ8jlVMnnpAZINILZbsjLcRmsZ5hyZYmzUpAtQBLYFi3sA6LBrIsxV+He1SS5bTwdM7OBQtblZo8qRBap0ejI5LzY28oK4bCHaKFtqGizzmIhliN8NHzGnvPHAbNpbgeHAu53CLTqT8YJ8QjivhNdnTUgVMfyNJCjImoNXytZvLPtdfUmu/hq18rbxwPVFUk4cBSKLMrKsCIgUuys/n/SwsHAKaCq/jtZLQs1ITwofM0lPBQ5A6RrlqBDjVh9Xj4kAJUDdKsU/KUkaKn5QipMcXpJKXI6XxhdtKgIxOGar40XcDI7KPH8nZ8wO3jFQEdfVPVgXHb7T1wFLGqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg+8IM8Rq0BMgwys+NY7eYgPbomblGiHhi2paGqATyE=;
 b=CAYlGPefVtskV/QBSfluZCwjWpJzUnMK9JIEc2wQWSPLDsGa9qb5nzKWgSoW3XLzYibCUWmR5oa2x5txV1msNXmwgPpjwLb/yPdj4/48ZNTVm5JVwZtLX2DsrWf2fnoUqi40erdMhxT65MRHjkYv5mbcU3uuae6cPtkwb47xXpc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB5960.eurprd04.prod.outlook.com (20.178.92.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 11:30:33 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e%5]) with mapi id 15.20.2835.023; Tue, 24 Mar 2020
 11:30:33 +0000
From:   laurentiu.tudor@nxp.com
To:     robin.murphy@arm.com, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, ioana.ciornei@nxp.com,
        diana.craciun@oss.nxp.com, maz@kernel.org, jon@solid-run.com,
        pankaj.bansal@nxp.com, makarand.pawagi@nxp.com,
        calvin.johnson@nxp.com, V.Sethi@nxp.com, cristian.sovaiala@nxp.com,
        Stuart.Yoder@arm.com, jeremy.linton@arm.com, joro@8bytes.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH v2 0/4]  bus: fsl-mc: Add ACPI support for fsl-mc
Date:   Tue, 24 Mar 2020 13:30:19 +0200
Message-Id: <20200324113023.322-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::49) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by AM0PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:208:ab::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 11:30:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28b32295-fb09-4428-f5d8-08d7cfe6c3bf
X-MS-TrafficTypeDiagnostic: AM6PR04MB5960:|AM6PR04MB5960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB59607971FE7BA0001F8AE2D6ECF10@AM6PR04MB5960.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(66476007)(6486002)(66556008)(66946007)(4744005)(6512007)(2906002)(9686003)(478600001)(81166006)(8676002)(186003)(16526019)(81156014)(26005)(52116002)(8936002)(6506007)(1076003)(7416002)(2616005)(5660300002)(956004)(4326008)(6666004)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5960;H:AM6PR04MB5925.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynWu7pCsEJey1HU4WGwPJ5dUFiPt3KAyhqafdbU9WjH7zEfOTLD5gmYdjJk/E4DGv8EyGcc4QMCeR5iAdx1lU3xEL+vKnxE0zMpPVzQMKsb8CqU+BPDG9O7MPEPu8jK2wgHziwlfQdq6e6w9wyHnc2zx4bgOvEHT0H48C9l9P9+xQz1oj8WwktwUoY3Q2u6KfEtCm1RYXd6SVvE+JMx7nP1Fpwkm3WxrawAoKeDgzOlcIe9xm86bXc73L1g4MwW18UIksJ/s04n4GbiaUeiRse06F5olFIzKE5vxySS3ih9Y/92y66karBz9nXxBShloxieBmUGBl8soJXcU+7+xW+NWKQuHyb2i3V0sk+xb/OWZ5cPOcwbspq2tmLeSmRkhashOmeUP3U7uhyNWrwF5mV5ivpA/0J88OlyMqjC/pqKWjjYdLQphlG5vypwdBUXS
X-MS-Exchange-AntiSpam-MessageData: aVMGSiBUXOvriiq4pyg11djuzvEY54WIiqHjUdNfqWTH2otwT0pfpFdeJDMbMJrKn45+vFoZ/xtbnRGpOzf1goWuHmgTHaIlzAokziMD6pjcqBOfo2QJPQKM390LvsvLdtnm2DAH0EDcvpcXVHYo5Q==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b32295-fb09-4428-f5d8-08d7cfe6c3bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:30:33.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnjXs3yIVCmR8QplT/ye/7nf7mwJSRSqHnyphhvZw1D/FlJpCanDkLX3O/skWP18nl4f/e1tboKC1QgNqz8U9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5960
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch adds ACPI support for the fsl-mc bus driver. First 2 patches
are prerequsite that remove dependencies on device tree. Third patch
adds the actual ACPI support and the final one drops some fsl-mc
specific code in the generic device tree handling code.

Changes in v2:
 - add missing of_xlate call in custom .dma_configure (patch 1)
 - added a cover letter

Diana Craciun (1):
  irqchip/fsl-mc: Change the way the IRQ domain is set for MC devices

Laurentiu Tudor (2):
  bus: fsl-mc: add custom .dma_configure implementation
  iommu/of: get rid of fsl-mc specific code

Makarand Pawagi (1):
  bus: fsl-mc: Add ACPI support for fsl-mc

 drivers/bus/fsl-mc/fsl-mc-bus.c             | 85 ++++++++++++++++-----
 drivers/bus/fsl-mc/fsl-mc-msi.c             | 11 ++-
 drivers/iommu/of_iommu.c                    | 20 -----
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 69 ++++++++++++++++-
 4 files changed, 145 insertions(+), 40 deletions(-)

-- 
2.17.1

