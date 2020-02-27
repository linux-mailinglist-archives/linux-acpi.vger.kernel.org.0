Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687241714B2
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2020 11:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgB0KF7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Feb 2020 05:05:59 -0500
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:48552
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728659AbgB0KF7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Feb 2020 05:05:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3gYgNwElYwAOAm2MNvO0LDwbWFyDDZYw53nzgEmEo2PLTIRyRffmuWr6ISU2tGW8WAkCTOYZ8VOcCUHpbyltM3Z5ZWXDw+K4upL0T8kuj091iTOU+2f7O7fzn0IwXLwXBHLf8fi6DHpyAH7BzjpClbR+3V1JeuHlwjdBkffJhc7tWksQbqqpGNAu2a6XqBVcFFWNbxRwuycnKuIUYRcGfcwaUmLu+RCll6UTWOC6NOZADhp/sDb1CNBJdc+x9o1hyv6zxdrJ5w9XHKeHv1+g4v0GJ/NhkkDXBiirKrDRDC3l1Svpd5ZoeyKKytlqDklzSvusiqUOAJdy7F2jGfKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrAsPuYmzomTw/I6ERXcbfE6GbcnkxdExla3dKaOzEA=;
 b=FlWVvzRfZaMIE0msNw+kZmPGf0j/UXZ3bK8DBj5djuUf8Yh6xOhANd1mwFxc884gZvmNqrk2nIQ7ZqGAkJmuwF7LQpFnVkv9UJbl0xkbAECfb7xGXUFT+lUl9jH6VJTesi0fSxLAm+JveLAWx0LtiMlV3VdkniTie9jKI7C4Xux8N6ZspvkfDIef6mVO9vKY+fGLM5LIky5ValkDvI9c6AvxuAOLFY8bBdXaUcCbeYee8qSJAW7eHPdYV0OxEEkh7zvSDD29ZFyfCkvaORkiHYm1hbcQkr2XrpScgi2u7e8RRSZUFAuQBHWIwOQqslwGbgL6YYbCaHjhV+pjJgzA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrAsPuYmzomTw/I6ERXcbfE6GbcnkxdExla3dKaOzEA=;
 b=XS/nQy7jGw4NKM9GWgcxBNlw3RoMQfT6DPFNIgTZpFiqLsyPqKy0fsFjPLjywXtdV4qalHl/LTpfDS9UsOFJFva3SOO1mEL+BA6R2roqhq3qFuxGA5qBKePi7kzx1V1rR7qfAxDuQ7tjLgGEjMT4S9GM3JeVhpyGq+6mTrY0C5c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB4312.eurprd04.prod.outlook.com (52.135.165.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:05:54 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:05:54 +0000
From:   laurentiu.tudor@nxp.com
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     robin.murphy@arm.com, lorenzo.pieralisi@arm.com,
        ard.biesheuvel@linaro.org, ioana.ciornei@nxp.com,
        diana.craciun@oss.nxp.com, maz@kernel.org, jon@solid-run.com,
        pankaj.bansal@nxp.com, makarand.pawagi@nxp.com,
        calvin.johnson@nxp.com, V.Sethi@nxp.com, cristian.sovaiala@nxp.com,
        Stuart.Yoder@arm.com, jeremy.linton@arm.com, joro@8bytes.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: [RFC PATCH 2/4] irqchip/fsl-mc: Change the way the IRQ domain is set for MC devices
Date:   Thu, 27 Feb 2020 12:05:40 +0200
Message-Id: <20200227100542.13819-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM6P192CA0056.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::33) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by AM6P192CA0056.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 10:05:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d1a28c7-35ae-4b82-fe70-08d7bb6ca1b7
X-MS-TrafficTypeDiagnostic: AM6PR04MB4312:|AM6PR04MB4312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4312027521DBF6F444394A8EECEB0@AM6PR04MB4312.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(66476007)(1076003)(66946007)(478600001)(52116002)(6486002)(5660300002)(66556008)(4326008)(7416002)(6666004)(2906002)(8936002)(6506007)(16526019)(86362001)(26005)(9686003)(36756003)(8676002)(186003)(6512007)(316002)(2616005)(81156014)(81166006)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4312;H:AM6PR04MB5878.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94tD5Tz2mP1GwIWNFOYGmveoIeY1tDG0PjGE9L5Q4j/LFZSqLSzVI9yPdu8uwp2Iywo/zpwQpNeC2b8rfG+ZQ0XN5uo8NfOL317FuoWtLbIWugYEAxbz9FHNSX+LpOqovx61Yrls2kKPCiXjtTTSU7higU+QCXwJbQ6yELK6b6suQ8Fj4cFXDqhixSuJ7RV+UQsrHatpJo1BrItudElvWxmb9Jh1gepb4AVPfHKz3O1Boo/bNqY3YZBxVdPw/qj9bsVAkZ3qLLA/Yi2Ubld6J0Z4SQKmkevFlAOdgFx+gl7QKIjRksu5laka5i/5Qiqfw3Ze7wNBGY5Pq7EBbTtxeX+MuvXilSbtMqff/SDJ2gy1HSiAr/cj54x42Vp7S6u0+j41nOVmI0Gwc9aJHezGIU53cD5XULljYFB0aUtwo5hGqPAftbYJosDy3vqbkfd6
X-MS-Exchange-AntiSpam-MessageData: YjOY6gmyIVrVtBwgHx7w5IEEAAQP5ep2vKoBWPc3yrAodetfvEycA4JuMJn7d9S+GCOnFr/LhaoSTR1MRLF58y/ofQq0nYO27oaM+1tdpX1WuQrk4jlMGtGn+weK5fMHFl7XgoJVpBPXEOvmakIJCg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1a28c7-35ae-4b82-fe70-08d7bb6ca1b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:05:54.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLV64tTm6HjpFoXlXhtFVDwlVsu2b8TZ34TkpidSEKfjVKkeWwYosMMpGNFmrw/OcgfAEW3GMwDb1307UZQM5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4312
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

In ACPI the MC bus is represented as a platform device and a named
component in the IORT table. The mc-bus devices are discovered
dynamically at runtime but they share the same fwnode with the parent
platfom device. This patch changes the way the IRQ domain is searched
for the MC devices: it takes the fwnode reference from the parent and
uses the fwnode reference to find the MC IRQ domain.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-msi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8b9c66d7c4ff..1e2e97329781 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -182,16 +182,23 @@ int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 {
 	struct irq_domain *msi_domain;
 	struct device_node *mc_of_node = mc_platform_dev->of_node;
+	struct fwnode_handle *fwnode;
 
-	msi_domain = of_msi_get_domain(mc_platform_dev, mc_of_node,
-				       DOMAIN_BUS_FSL_MC_MSI);
+	msi_domain = dev_get_msi_domain(mc_platform_dev);
 	if (!msi_domain) {
 		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
 		       mc_of_node);
 
 		return -ENOENT;
 	}
+	fwnode = msi_domain->fwnode;
+	msi_domain = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_FSL_MC_MSI);
+	if (!msi_domain) {
+		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
+		       mc_of_node);
 
+		return -ENOENT;
+	}
 	*mc_msi_domain = msi_domain;
 	return 0;
 }
-- 
2.17.1

