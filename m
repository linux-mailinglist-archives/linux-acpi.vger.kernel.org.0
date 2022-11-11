Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215DD6265B0
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Nov 2022 00:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiKKXn6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Nov 2022 18:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiKKXn6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2022 18:43:58 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F4DCE17;
        Fri, 11 Nov 2022 15:43:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd/m+rQCVtoCkpjP0n+ddAZuASR3TFPG2Wdg4mYTJhjddQFMRnUSHMW79SCGuFD04pRbHFHBulJ0SNxyZMJe7FlFEoTi6Xtnlu2cyXRzkDHp8z6ohT2nWnogZKDU8JDOMvIW5MkP74R/U5EboiawUBpiyZI166SlXDknnfgHR1DVkiAxAyxJCHo2WWZx2Xtadc2LgDgmyxYkxZXutUtFTPvtAn/GMuBPBV2Rw709L2RgAmw8K5JBvlPgsTPyyrCabq26rGxAAra4cyKYRwYDMz04uORXff+dsCupEj0XaoDKRYBUFhOdCmomau1APQHSbGq3tjQfsAeLSAqW8qNmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0PmLlEWGTZU26znzCiDvS0yf/ED5CgleOVcx6RAnbU=;
 b=m6AxE2zMWHykI/n5JsKcLeE+fDikuEDdBcAm/YOLrnSydnGEQ7zZyXKP8aqqje2f7tiiS33r1SrbGjrUvBHD13qaoOn68KP5sFgNRUeFgcbTyF/6Nyc2GGzOLVodfqhnCc+ZDKRdSfD3q/xIn0uFnhh/0NYdzV9YdSSOyKE8jUnvw7s7AaKm7sqlBvd03pMRjyY/Z52e37D3MFDub+qWBOQRJ82jJjiNXxj7mXY2qXDVErYutmtAtB4ByC1U2z99GRqPNKnERCQpV5ubd5k5Okp6Z5Tn88h2kR5PeGqesIFsPZLgcOuf3QZefPekUL5ibl5wJQ5GXqEHQpp2qRGDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0PmLlEWGTZU26znzCiDvS0yf/ED5CgleOVcx6RAnbU=;
 b=Z+HZKAy/mbSOG6hNGs+Hx10WQTueRFWDJpXZfWkM2QTktBr0FL2DUsxRBSvCQFxy4fRvRyhR4sxgw4xMpHBRCcQafKKMm7nyRr51oi3meXYwKa/ignp7E/vVmwtHZjmSAleU5SWKcLAO9R38B3PdG9qW282kDjYkIgvybTdhUhUuiz37QMxcI3Sn3U8Ip68pO1scV05dhKI30ZwLNWUSgp9IPODDePdsFGVU36MZ7vU+hqAPz04VLPUMsZQorBgMl2jZcTEExvVjryERLFXLpgrg7u9QVlf2Btx0o+GIS+sVg6qWOFgPC0nLzdLp3/DpMqfMglqj8Yqj9HMmWOs/wA==
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 23:43:55 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::9e) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Fri, 11 Nov 2022 23:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Fri, 11 Nov 2022 23:43:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 11 Nov
 2022 15:43:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 11 Nov
 2022 15:43:52 -0800
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 11 Nov 2022 15:43:51 -0800
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>
CC:     <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH] ACPI: APMT: Fix kerneldoc and indentation
Date:   Fri, 11 Nov 2022 17:43:23 -0600
Message-ID: <20221111234323.16182-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 197d33da-fe17-4d0a-65ba-08dac43e9850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzCYyFQSLumYsArLGFEmXmpB8wcaXzRvdtuzbxKOqQgztrJi4axxDCHZlkrggsgUF14Sp7+DJOt2/oSt/Masxwlk/vuRJpgsPx58JQQALO9whYWYOTPuYRhqzwnfavvAKOK4Hgn3V8A40UM7rYL96WnvwFXlDRBf0Knga3U7GsZMaJGMH9Z3C7AWYq/r2BbhNl4J0WsdY3nvCyzNgvubfeQDB9ubuDaIdRjvRpUerQmCHOXsNYRwI6DDQafg9RQ6W5FlSMoYQhrhWoXvVDNNL/MN3oJ8NkKj28pywLn8ina8tVnrbkZElhmgrPAKKmCVwE6y156DSu/N3bg4x+SYq8tCirQDE2hEsdaKG/aKlSVL5zgT17rsxW56PL4XAhSFL+6N0quTMqb2Rob3zrJBDYCQnEd7a7Kzn4yfz9A9uu1WsfAPZRgxM4Zq4mTqSQrSKCy7PXFdgbTBL0nzUDghTqGZ4KkE19hx0qtr7FgMTEPaC6WbovA6agmMx/EJEE889R4YUPBOrZrzBu7y3AWuSZYPznhLIBmJJo16UP5PVy6DRceM1Ua3BkELSF/DdMkYKGWPYNpM+pJFh4ZpgnZ6SoSPhOyLWSy7tINwm7qnJh+6jxahEOUVYSA3P8M9+3JNCeU/tW3rWQag4DhDA2XW9INP3ddZwudUBNpC/VSNTvY0xXyYR3i9fu/KKhI/4aLinxQ2DPXrc1fj2bbYF5HSaymg4h4REAJtPv01pc5mMRuR5NuqXKbjiu1jXJtfo6MQH5gem022XgzcGl7G6I2Bcw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(40460700003)(41300700001)(336012)(4744005)(4326008)(5660300002)(186003)(83380400001)(110136005)(8936002)(7696005)(70586007)(54906003)(26005)(2616005)(1076003)(316002)(36860700001)(7636003)(356005)(36756003)(47076005)(82740400003)(40480700001)(426003)(82310400005)(2906002)(86362001)(8676002)(70206006)(478600001)(107886003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 23:43:54.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197d33da-fe17-4d0a-65ba-08dac43e9850
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add missing kerneldoc and fix alignment on one of the arguments of
apmt_add_platform_device function.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/acpi/arm64/apmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
index f55167ca51e7..5a3f90a34e4b 100644
--- a/drivers/acpi/arm64/apmt.c
+++ b/drivers/acpi/arm64/apmt.c
@@ -66,11 +66,12 @@ static int __init apmt_init_resources(struct resource *res,
 /**
  * apmt_add_platform_device() - Allocate a platform device for APMT node
  * @node: Pointer to device ACPI APMT node
+ * @fwnode: fwnode associated with the APMT node
  *
  * Returns: 0 on success, <0 failure
  */
 static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
-							struct fwnode_handle *fwnode)
+					   struct fwnode_handle *fwnode)
 {
 	struct platform_device *pdev;
 	int ret, count;
-- 
2.17.1

