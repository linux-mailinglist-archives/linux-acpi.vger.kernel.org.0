Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465FD1714AF
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2020 11:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgB0KF5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Feb 2020 05:05:57 -0500
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:48552
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728630AbgB0KF5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Feb 2020 05:05:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyMcx0wpMI0LXTSsQHgn1lnQcY3wpH91vvWr9JFLkLfQklc6zLyp6b7ko9wknh7GTPaVbQIILANqVUiAMR+/yU1Ph5jPCT0P1txDoDZR8naw6V2eGtSJpJZxQjSreneA5lCmb1Zy8e+jNw92xFSOiYL9rCynNf/EXNm6yPDRtvyxn7dAFNnDXLB6iehbu5jL3RLkPMbqBKbsy59C2kzxN3+Ip7hmZISnAWtz81z4pOKOEDyeXq50n8iIjqum+Jp26RhmP+F0xkqHadUJp85qqtBDU26xGw9lHgdu9JvxTlxJ+t5FeOLCP1gnWKtkn58218BNawYwgVug3PEH1jPrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp/LTPAvf0JpbewNnY3iEKWLkz04nuBGdl0Sv924GmI=;
 b=jYtVXecQsXzxR5T8WC8NkONalt6AKe4jPfQ7gu/8YAkTLSqNxy3KboaXducA4tlLF2Q4n3ouooklP1+Iot2vn2Cijn3rDvX+4fPqyE0uqRN6fzMoFMOShUbaRMtlzYdiPUz3YBIWeuZSBPRoISiBNOhfhQnlKaIGlSOsyC966ozTUEpnHwaAZXXqmhtuQ8IRdKk9CKnsTxB/Mu7CSfYzAqaRxoEB6/HlAASDgeQov835A8mtukfv3TLQvm9uTrE9EwtHLKKhRt3PD6zo5Nkrd6Fyb1Vwb3PEYoKLnDWwGHcJJ43pisTs2c2ASLcs6InEiSWZNPYNDSfZKqfi3VbiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp/LTPAvf0JpbewNnY3iEKWLkz04nuBGdl0Sv924GmI=;
 b=AiRnlgiyOIRGHjbeR4yLnOUIoZZuK5L3RFuWOh6xlrCkEhsUcYdNfz424Rvgby9xlSpTSUDlai2DHXg3k5OVIIPXHkElT13LpB+EMxtGMxpJZM+VJMpGCFFkD3/OPjWCmD8LzjwrqISAczpp8fTjZLspuCYoynYLiyOEuERm5rY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com (20.179.0.89) by
 AM6PR04MB4312.eurprd04.prod.outlook.com (52.135.165.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:05:53 +0000
Received: from AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e]) by AM6PR04MB5878.eurprd04.prod.outlook.com
 ([fe80::bcef:1c59:7d27:d0e%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:05:53 +0000
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
Subject: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure implementation
Date:   Thu, 27 Feb 2020 12:05:39 +0200
Message-Id: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM6P192CA0056.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::33) To AM6PR04MB5878.eurprd04.prod.outlook.com
 (2603:10a6:20b:a2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (89.37.124.34) by AM6P192CA0056.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 10:05:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a84ab2c-a46d-4f98-a345-08d7bb6ca0fd
X-MS-TrafficTypeDiagnostic: AM6PR04MB4312:|AM6PR04MB4312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB43129C1D33F2ED76B03C4D35ECEB0@AM6PR04MB4312.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(66476007)(1076003)(66946007)(478600001)(52116002)(6486002)(5660300002)(66556008)(4326008)(7416002)(6666004)(2906002)(8936002)(6506007)(16526019)(86362001)(26005)(9686003)(36756003)(8676002)(186003)(6512007)(316002)(2616005)(81156014)(81166006)(956004)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4312;H:AM6PR04MB5878.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsWi/zKS+FmNEMPuo7Io1USJz0q6K3qP+Y3v8mK3rLnaYzMISrq0dFn1D4svCi3QpDPIKVho8olOMSwQo2KWot8KMmx8IMTz4kAIDzitgyvR1mEj8a0lKYCK4Wt4nAFVbHx8J3ddEKkoG+QNbl18d4fJe/vh63ygiJUMZDNh82sqnFqZBKgWs9xUvFhicq0Z2Q4mypv0CoNThaqf2eHMg+i30DZDR/R6huMYRJZ+D+FV2FyEKTfNdGNJIcP2RRqSJd1gbw72GIPQ+bGn3PWW9UmEsDnyU4FDA154a/xpxbr3jNvqP6wJXJwYFm6sSJtjC3XL8yaYrqh1IMyKBnHkSjdlfQW7/Bpci66A52Tk72scT+tHwQ3N1BGHAhyeNVRPjeBJt0wI9o+cajXO4fzckqWDMVVZPIL0Q963ziMAJvAGuzvPdNLuTD6SgVuIIlbK/Y8qgDE400KUMidW6am3q6EZ4AtGUyl0RbhUbKUkQ+WjRl0b1IWl/du4xCoVhpjo
X-MS-Exchange-AntiSpam-MessageData: PuJHmMkcQMRYDsFrr2TEsmbhMVieRqg4tbJwAogPxTIz6XX/TfRY3xK/AQtaA2FxmxOrnTkkBtbDn+Oy3LxT1Qki0GhUfsx33W4qTCX6wWNlTqYn6WKMzmG9KIlIyIFLrXz0VbP4Bwdt3jWrgbmJVg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a84ab2c-a46d-4f98-a345-08d7bb6ca0fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:05:53.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWpb5+TxiL+gjXLio7s/z96Pk59A9p7TCGNoeFsQ6V/oXOKl/LI9fTDGJaRdzfZeWRjgHTeD5HMyDwILvA4tQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4312
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The devices on this bus are not discovered by way of device tree
but by queries to the firmware. It makes little sense to trick the
generic of layer into thinking that these devices are of related so
that we can get our dma configuration. Instead of doing that, add
our custom dma configuration implementation.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 36eb25f82c8e..eafaa0e0b906 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 static int fsl_mc_dma_configure(struct device *dev)
 {
 	struct device *dma_dev = dev;
+	struct iommu_fwspec *fwspec;
+	const struct iommu_ops *iommu_ops;
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	int ret;
+	u32 icid;
 
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
-	return of_dma_configure(dev, dma_dev->of_node, 0);
+	fwspec = dev_iommu_fwspec_get(dma_dev);
+	if (!fwspec)
+		return -ENODEV;
+	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
+	if (!iommu_ops)
+		return -ENODEV;
+
+	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
+	if (ret)
+		return ret;
+
+	icid = mc_dev->icid;
+	ret = iommu_fwspec_add_ids(dev, &icid, 1);
+	if (ret)
+		return ret;
+
+	if (!device_iommu_mapped(dev)) {
+		ret = iommu_probe_device(dev);
+		if (ret)
+			return ret;
+	}
+
+	arch_setup_dma_ops(dev, 0, *dma_dev->dma_mask + 1, iommu_ops, true);
+
+	return 0;
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
-- 
2.17.1

