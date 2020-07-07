Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43702169AC
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 12:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGGKEK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 06:04:10 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:6245
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbgGGKEJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Jul 2020 06:04:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcVTsJ+D0TzGUdWJePN2xnivDUBMaEq8w9Gr/M01YcUd3jZT0mJkEgmEK6eKXXtWSYf1XEeNqJ8gG2Ea2IrI6oUM/R9jLr5R+4F7GJxFVRyeK8OLJV1jerFJKq2BQN+z3m2fk78KS43yvZcxnjUxp1qEgXHMZhCKw95itAPsjv4NIF0HsHz0lip1Xk0Q0aScLupjG6CQhrf3iAmbBACASmgDiuDqhKUtTCv77rygvgyZag06U4oIvIZU+hjOIpTtPrzcBHZ8/a2PsXlsRevPvQHlHxzYa0zFMPjsu9+zqwmzfJxDJgvTLwvNKiHNHbujs5Biz4LBMPKoQPG40ehIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=Plo32HV1lsBhLJonhLqiYUI6UEes1cqIC9XlwSlKY+4zSEsJ1IJK3evnUmtoN+aI2cLIpHe8Q9EK6Uah9hErFv4AxGRrswI7yFXqMbAoUqagfIZ3HZr4myayOABDNQ7czAg7N1rmsmCMJ2FirtAkN9BhqJxyzcmoXybTPNFPMX8IcSPQYj3xno6PpsaFXie86djUGhm3mGL+3zd8R7/kLPniUiiZ9vcPnCA716fQHQhQL1VqsRlTBSX8GQ+x7FjzCbety+BGkFDImqdkWXDldnVjJGDmlUkar/jOoJcUxcVywhnYNoWO3kjLqF5zVVFvGDRLPlwdc2s2FsLidntSKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=PcHiiOi7f9nuE8n4u3i9A/MVj1pfk6S8M4vK30n5kCaI4hx1jIBcqWwsBxGbXsrYD1tkqfIEOASHy1mjCfjXD3II39Mnxd6MtK9IXtvmHkYkF55BqZaxlvX96YGT405Phu4Yf3ptQO7IiV/qxI3yXEBWMvGBok10DWa6QfZ286c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 10:04:06 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 10:04:06 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ACPI: APD: Add a fmw property is_raven
Date:   Tue,  7 Jul 2020 15:33:00 +0530
Message-Id: <20200707100320.24625-2-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707100320.24625-1-akshu.agrawal@amd.com>
References: <20200707100320.24625-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from akshu-HP-EliteBook-745-G2.mshome.net (122.167.38.75) by MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Tue, 7 Jul 2020 10:04:04 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c9d4b7c-571f-48af-1e60-08d8225d159f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB144015045CC0713A4FA8B878F8660@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eeDS/JJJiUly6PH0MBN4FpErLX1ZWky9O20jU6NzUvj2vU+1WtUGJNH5OJ8j0UAzVDXXWNdxI1s/jrsR5gL05bECgDF6A7pbBTxNhvszM0rWEH6QhapKjB9teCjMlpOovbfgqu/d0JmoY7A/O30TD1RzSF0dbnuOMTu9/Zp2kTVOJAxbWDIQMDqWW3K/pGfpoMG9aNDkYlleIl95js0stBJh43y6igk1rMYYa2cBr5PhQ0I1aUwj6VO054b1xTdad3VogoKfaO4QBc6wy6W02F8UQv8M0pSXC9SB+TyAEzH5qOs0mrAXjkX21+t0qnS0uFFIwkeP4cwHJQW3RJZ66GjESRCWLXZhVTFHMbeZkljotjWdjLHx+aMT5LTddvN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(6666004)(5660300002)(8676002)(186003)(16526019)(44832011)(52116002)(36756003)(4326008)(316002)(66476007)(66556008)(6486002)(86362001)(26005)(54906003)(6506007)(956004)(2616005)(8936002)(66946007)(2906002)(6512007)(1076003)(478600001)(109986005)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kZWq6gcVdZulKxDiT/37H6gL0L9nj4sad/WdPOgREOB3BY7EsFx8YTkpGoGJjHS98hz95s7neulsyeg0vPifz3N+icG1p1nMtH7PlTXGUQ8udafn21aX+UtAHaQYkX032+/5pngYQF5C1zb5/Zc1WcDtFkZb3re76fCRSt3mD7yRlD2UY+YV4P4qOXMVNIw9HK4GO8VY06QoeTL/0zyd+ye5E3qoz7wrmlcDL1QD92UD/oXex9ioaUObM9hA8OLdV7CMpEkNX49ZZI44C0xH2vwaYGVbIqLq/2MEdfbTKWJANIkcBpQ9h95Q60rSEpZle3h592PlneUYzh9GMUJ1U3wYIAbx8RWvREEKDckEkY1PH1wicmKA+xUgBuoBWgC9OGYorK9BLY6nCrV0c8eijjgSyT2M1weyyzjYTXS7IlOYOcZ3SYwuJgZW9iLvYsdvYulpEYIyBh45Zjdqe6XLi/Lk6eb5XVo6pjSff8/AVHs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9d4b7c-571f-48af-1e60-08d8225d159f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 10:04:06.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSAo16uoJ8z0N38lbjN8ArGBAk6uVbsz4JqHCh91mQP5bN8f1TpMo9eGbhaZwu1TKnq7mfLV0tYHD0E06yanjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since there is slight difference in AMD RV based soc in misc
clk architecture. The fmw property will help in differentiating
the SoCs.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/acpi/acpi_apd.c               | 4 ++++
 include/linux/platform_data/clk-fch.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 2d99e46add1a..d879ba28826c 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -82,6 +82,7 @@ static int misc_check_res(struct acpi_resource *ares, void *data)
 static int fch_misc_setup(struct apd_private_data *pdata)
 {
 	struct acpi_device *adev = pdata->adev;
+	const union acpi_object *obj;
 	struct platform_device *clkdev;
 	struct fch_clk_data *clk_data;
 	struct resource_entry *rentry;
@@ -98,6 +99,9 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
+	acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj);
+	clk_data->is_rv = obj->integer.value;
+
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
 					      resource_size(rentry->res));
diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
index 850ca776156d..b9f682459f08 100644
--- a/include/linux/platform_data/clk-fch.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -12,6 +12,7 @@
 
 struct fch_clk_data {
 	void __iomem *base;
+	u32 is_rv;
 };
 
 #endif /* __CLK_FCH_H */
-- 
2.20.1

