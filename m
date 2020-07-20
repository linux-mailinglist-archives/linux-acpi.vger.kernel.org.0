Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571FE2256F1
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jul 2020 07:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGTFGr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 01:06:47 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:57509
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgGTFGr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 01:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2FpbzMEBXvCTjdoTnaGyq57hWccr7+LfVCiKsJnB/5HDPJZD6BpUjHd+K9VH5gESG8eA/6mXexM/YZPgk2S+FpR7RIN97tcNIkEBJwbv/IMzS8g3yqb8odhOgaTfywEpqlG+xD6yhLGRKmq5OUxjX4SULb7vb7qB5TyWKyEXgrb48g5TffTKv9hdpUo9nlYrfL5vc+2Qpy9Dic35goxW/+RQucjt/DwgpJHsMh87DQje35OzIsYG1HL45q0deM7lf27yTNclINLW2E6UVIMV7IwgP3I5ydf84sA7mF8CtrPW/7O2JEmxNbeMmL7cdyxWSAWEMogWlVsScOmRV/v+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=OByj50mcM/BrQMcib2oFVE0H7N41gBMMbm/ZAUZbzzS5nnFuwKT9HtkFEBspJyFJVrypC/BABSe/TQO30fz8vHXfzV6ghOpu7BXC1jnJ27AdUQYYZUhyvoqeRlwGE+bmRYgD+ZWnkq75vuHKHovqIUwwROuE/RiqJ6U9LHC1eRUhnHTBjQXpMskmN/fzLhS01z0tsNVE24bQayI8pIVQQR/wDh0w6biQ+aP2LahPby5KnuMg4MIloQ0ucRTomzfg4Yy8XJt8AlfRMj4wX5siOA6L0Lk9DYdgA0or2+YglrsRuNSQcHp0eEMeoa6kdkkLbJi16Tkgoerz2nLYBGB2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=Pi2p3IuTAtg5SXyAwW07NLsa9hDsx6ZO7S6NBDA2ubkQeXvJG6Pc9QyJg+PkCjtrH2+VX8WwIW9iLB52erMGQc88B96aQmQ+ZigJIs5BjiSmBG+SkLSkJv48OIoHlEuQIthL37irewwAQGygfJUaxlUTUNOTF1lmAZDBs06UHh0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 05:06:44 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 05:06:44 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] ACPI: APD: Add a fmw property is_raven
Date:   Mon, 20 Jul 2020 10:34:58 +0530
Message-Id: <20200720050500.23357-4-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720050500.23357-1-akshu.agrawal@amd.com>
References: <20200720050500.23357-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::16) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MAXPR0101CA0054.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 05:06:42 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c40a289-6ade-4d64-9b0d-08d82c6ab23b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB18537AF7CAD8ECAD9000E942F87B0@MWHPR12MB1853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmzuXdqr8b9umwm0+KoC4PTS3CWXFct8tv1BUpUkVBAdEho9g0b17GiIrP/HPLyaZAauVXKU0N+TAf0bDdEYaEacLq7a1c5r0AmnSzeF0HyuJwx3WGt+q4VyUp44rmlNsvnQBmnwnbfpnhjvsecAy8o9SFaDFh3ff2deL+wJFhBMmWLYnGtefQ6Cfy5BRAlmZrDvd5b9caoPrCQjd1acMANejtbgMi9JioeQ5Xt8Ht0g7n01i7VAQl7LlZkQiw8/hOBspdDbkq1IIUJZMDrNc7+bGIh63SQIXOi2/PaJ1lenZYApazpZPNF796bxf7q8E8RoYa07lzVyM9bsAPirgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(6486002)(26005)(36756003)(478600001)(2906002)(8936002)(5660300002)(66946007)(66556008)(66476007)(6512007)(6506007)(86362001)(6666004)(37006003)(186003)(52116002)(316002)(1076003)(956004)(2616005)(8676002)(34206002)(4326008)(16526019)(44832011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 06muF35z3zoMGweEbr4tI26PtHRIKwOuV+b+WmaHSGaNPDg72a2CeY71cC8kEg8rlWqBRHeYuhBB16+T8qRZSzLcb555NknXAaM7a0DaX9opeZxFVc4Kb7orQajnaFsP3QCJ93vln3ZPVSu5lOF+HTUZVG/fl9XAUzfsY6U6v51tBWSt3awwLp9FIaxCxMsb6j/xX/+FCRaly00mAXcJV1T9UnXT93t4bQhumn1f385JikYqb8i++u13RVLo+jbxf2bP0UGqYy/qMu5h8mjAN3vz1bUFvuKhhnd58+eFwVuPYFwE7H8Fbcd0Hi3hSoqoZaJP71SEh37OKfbFNr4udVvsNJfNa9Y4MqWuog5ncP3Oym430mllK1c/qECyK/6h1aItUhc9zhX3U9415ZTXt8EeO+HmPIaVJZm+UCGOrmzIeqjsWI14X2ekN8aaeg2SfcgSfy4qwhrGvyVWXP12aiYuXzCWt9lE8U8Kc1rd9O4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c40a289-6ade-4d64-9b0d-08d82c6ab23b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 05:06:44.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1/bbYfB7xSN90jb1VZPNJWdd2cretchN1Y3nzW8ASgAY1R/MttIlpFMJzXbIg8I0pfiLIF33MklX7NSkYXUoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1853
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

