Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955A3160DD5
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Feb 2020 09:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgBQIzU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Feb 2020 03:55:20 -0500
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:56614
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728217AbgBQIzU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Feb 2020 03:55:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7nwjWKlegqtO7ecCuTx/gA3bkLH9QK3o8jqJKysBUKVk1+GmOkT3KNeT030KNUGEfdzABjg6ylI/3llAcvhRR097y+uq0Yl59VwackWt/gVqFtsqiJmdfJJi3dcU0SVIJPXMM10lgrBjznvgM+On0GjA5vRRjKSwm9S9f4cx6EXoWzBGWFfgYfWn/9TCSw+o7YgY0bz50hWAoV9Q0qy2eIoIf24MA1do18w54S7x8JZPoGGFJJEm3YhCI3Wz/QEWJPcwwXW+zam4vi5haUTo5bWW9mwwMfmnuxAH00gG90sZnPYNyySyWGc6EpqR1DQQySa+XtF9EYbhcSUYSpOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQ7tGMSPobEIhwh6Usal09Dh2Tq0Ikkh7DfWkoYsfvw=;
 b=X9bhDEBid/tUnVdNNg5RolLrYT05gBdXcNXTxYmPsaBbO/L/ZCAJfDQ2uUFQcxxuS+PvdJEKLUHWneZPXdFcq/4guciSlpBn5ceNDzEBqHgxyCeYoH+CwsWIkZrBrYAAs1Fp0Agh01cv+akJ67rxZNh733sYiJXBC9iZFUMSqwMMCCrXERcfuCX2auUMZItB4zRlsuOr3+83bE1oXASPaVPljABJwvmrh76xRilpFhvt/HOP9iGI4CnuH0ncRwV3SvcUFzcXKyJFq2RreI1dWirWndc/vV6yGtV1zd7QYyZngUjrPhMXchbJUnr/XkCYW/NOBkdli3VOmWhGbNRo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQ7tGMSPobEIhwh6Usal09Dh2Tq0Ikkh7DfWkoYsfvw=;
 b=bn2Ivfz3EsURTSoulMCqp09oQyNf9puLi8gY5FhjjEIhFK+cMKk06YjoAD+usOtnYv+LW+GBLMzFBD6uRQ5dHyql3eQOPakt8Wmrjc18qmOBNdQ9IPfuEUYlkBc/v2XNoI6dmsbD0UEO5z1nmNCIKv0L7/LLqdVTMvoJl4x1zFU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2415.eurprd04.prod.outlook.com (10.169.134.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Mon, 17 Feb 2020 08:55:16 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::196a:28a9:bb9:2fae]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::196a:28a9:bb9:2fae%9]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 08:55:16 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Varun Sethi <V.Sethi@nxp.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/IORT: fix output id retrieval for platform devices
Date:   Mon, 17 Feb 2020 19:45:04 +0530
Message-Id: <20200217141504.4183-1-pankaj.bansal@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To VI1PR0401MB2496.eurprd04.prod.outlook.com (2603:10a6:800:56::10)
MIME-Version: 1.0
Received: from uefi-workstation.ap.freescale.net (92.120.1.69) by BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Mon, 17 Feb 2020 08:55:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [92.120.1.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c2cf02e-7e34-46f6-a15e-08d7b3871bca
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2415:|VI1PR0401MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB24155332E265715CABEA91ADF1160@VI1PR0401MB2415.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(189003)(199004)(36756003)(1076003)(5660300002)(26005)(6666004)(16526019)(2906002)(6486002)(186003)(44832011)(81166006)(110136005)(8936002)(8676002)(956004)(2616005)(66476007)(66556008)(66946007)(86362001)(6506007)(81156014)(6512007)(52116002)(478600001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2415;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKjJaYuLdvavEbbk78aIBQTVxaTQwvY8qTIsR24V2C/fSXMafMyw1mEbUf2SUw9vuJmo4q1e7Ifl8dKvAB3rd1Wynvf/u6kQxWzbMmLvFda1nNTheBvbA2YEg8BO/CvNoDWUHl7ooVs8/AQTx5iRCBV8/p53vYigW99Cl+QDmZJh9zZ97oTwYkp4h3j/bor7IjLzFXUSX4oDxF2tkpR2sEkozEabhn4QO0pyM8DQefCBhG0tidI81ZcKURbg6yDaelyVB8USWusg7YItfSmCj6mFsVFrT8C6WPZe4Ogex7OSuu9MpjRLf9pXNqVUEZO3VTF7XZ45HQWO7Qh1kzIarpPPtG1WibowxwEtQn+wAFomcirv4ATT6lKQFj/DqYibPEbdmQojGp/Jny+DMsgoF4P1VQMHDgm7kyvdd1eVQFda1ZAwtMbFEeQHSta9shEp
X-MS-Exchange-AntiSpam-MessageData: U+h/5Zq/9l9qaZLPw3KeXzRdXxQZItMcpFqAbnJohK/oO4FNwe6moPQ+5x9W4Hgutqa7uRiapz1R0jzooKZXH+XcJiBVANkChQ3ldBX53BtbRrGxu33DwEJP+xDL9/IfdBI45t/usaMdi4fdQ4k+1w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2cf02e-7e34-46f6-a15e-08d7b3871bca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 08:55:16.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QhP/dF7CTiF6hObrjebCzo8m75rS8FW+x6kPaXSXWM8JE+XIlTH9SYULayCKWqo/+SaawIvErdChuZdM0vHag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2415
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As per IORT spec if Single mapping flag is not defined for
a node, the output id ought to to be retrieved using input
id from an ID mapping.

Current code of output id retrieval for platform devices
ignored this case. fixed the same.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 drivers/acpi/arm64/iort.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1a7ae9..00e562dadd2a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -358,7 +358,9 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 	/* Single mapping does not care for input id */
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
-		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
+		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
+		    type == ACPI_IORT_NODE_SMMU_V3 ||
+		    type == ACPI_IORT_NODE_PMCG) {
 			*rid_out = map->output_base;
 			return 0;
 		}
@@ -376,7 +378,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 }
 
 static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
-					       u32 *id_out, int index)
+					       u32 id_in, u32 *id_out,
+					       int index)
 {
 	struct acpi_iort_node *parent;
 	struct acpi_iort_id_mapping *map;
@@ -398,15 +401,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
 			       map->output_reference);
 
-	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
-		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
-		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
-		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
-		    node->type == ACPI_IORT_NODE_PMCG) {
-			*id_out = map->output_base;
-			return parent;
-		}
-	}
+	if (!iort_id_map(map, node->type, id_in, id_out))
+		return parent;
 
 	return NULL;
 }
@@ -510,14 +506,14 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 }
 
 static struct acpi_iort_node *iort_node_map_platform_id(
-		struct acpi_iort_node *node, u32 *id_out, u8 type_mask,
-		int index)
+		struct acpi_iort_node *node, u32 id_in, u32 *id_out,
+		u8 type_mask, int index)
 {
 	struct acpi_iort_node *parent;
 	u32 id;
 
 	/* step 1: retrieve the initial dev id */
-	parent = iort_node_get_id(node, &id, index);
+	parent = iort_node_get_id(node, id_in, &id, index);
 	if (!parent)
 		return NULL;
 
@@ -592,7 +588,8 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 /**
  * iort_pmsi_get_dev_id() - Get the device id for a device
  * @dev: The device for which the mapping is to be done.
- * @dev_id: The device ID found.
+ * @dev_id: On function entry the input id for device.
+ *          On successful function exit, the output device ID found.
  *
  * Returns: 0 for successful find a dev id, -ENODEV on error
  */
@@ -608,11 +605,11 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 	index = iort_get_id_mapping_index(node);
 	/* if there is a valid index, go get the dev_id directly */
 	if (index >= 0) {
-		if (iort_node_get_id(node, dev_id, index))
+		if (iort_node_get_id(node, *dev_id, dev_id, index))
 			return 0;
 	} else {
 		for (i = 0; i < node->mapping_count; i++) {
-			if (iort_node_map_platform_id(node, dev_id,
+			if (iort_node_map_platform_id(node, *dev_id, dev_id,
 						      IORT_MSI_TYPE, i))
 				return 0;
 		}
@@ -761,7 +758,7 @@ static struct irq_domain *iort_get_platform_device_domain(struct device *dev)
 
 	/* then find its msi parent node */
 	for (i = 0; i < node->mapping_count; i++) {
-		msi_parent = iort_node_map_platform_id(node, NULL,
+		msi_parent = iort_node_map_platform_id(node, 0, NULL,
 						       IORT_MSI_TYPE, i);
 		if (msi_parent)
 			break;
@@ -1038,7 +1035,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 			return NULL;
 
 		do {
-			parent = iort_node_map_platform_id(node, &streamid,
+			parent = iort_node_map_platform_id(node, streamid,
+							   &streamid,
 							   IORT_IOMMU_TYPE,
 							   i++);
 
-- 
2.17.1

