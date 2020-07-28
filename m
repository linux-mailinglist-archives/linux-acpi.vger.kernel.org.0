Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55923059F
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgG1Iki (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 04:40:38 -0400
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:24417
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728016AbgG1Iki (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jul 2020 04:40:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM5w21v2xul73whf/j3FMEN0bd3AYISelGVMDrYs1I1k+ZOLFo+ILzLf2P/4kf0wkz0AHx/6dDi4NMXz0M43XYL3tAPVNXUed2NOmGsf/v7e0E6uuiA2P0a6iWky1k8sdA2jffbSIUKNb4XkHkqZ0HKVFhvELYtUuVPZHZRQdxykSPC+f6udRqgNOB5wgKucSZpvuwD8VmfxtWKV3p9/hKE7DFoBcoaWjD1lYRdOIsx4oktJVUFTzmmOazeNkBRmAJKFnbDsp0VZdnk79Nq9/OfgnEap6juhNRdi+LgKetT29C72lPrC+McfyZQiXWQvS1u+6UP6iSlNTv9eNnbgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=gvqcjr5NS9Ut451jDu9noUnyP+ZQPestnEyyhqcTmSp6oiDtf9thotOJ4IVGRsJlx5EelAYJoGA7SPrLNjGxBy8f/xJWM9ijYX7yjeMhOZla0FEb5jvFQf6d9zbI/124uGdm+WP0zItnkM6lh4omfgQQcS8N3DJBV/NwLotnuGIJ9nREdAipK7Ktga+KGQ723GZJ7CQ3/JSepz3x2adPNQ24mLdiVbuvkT6UOtmEVw66bjb5tluGNy3DgRUjllVXqneNvYeWyt8k41vdRwz+8HKw7g+Pmu+LdKyV4fV1n2W4cFA4PJ4IrQpOtBAWOg+DH47o69TBC7NZSgYJp7P3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=DW4cQ9aktgKqJwZVsECL8UVq7XTxYSheYiXuzMYoAriSYo4Zppo/CQF4UiN8hWxD8/lb+3LP3pAaJsSEvXg1wiBJhkZe0f0AxwS3NzACBAudOBziSwc/k4cZkh8mC4d9K6deEB7gNzUK6RBw7t7lb01JW/KR3ar/2dEvPUU4XWY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM5PR12MB1468.namprd12.prod.outlook.com (2603:10b6:4:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 08:40:35 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 08:40:35 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [3/4] ACPI: APD: Add a fmw property is_raven
Date:   Tue, 28 Jul 2020 14:10:06 +0530
Message-Id: <20200728084011.11002-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::31) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MA1PR01CA0115.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 08:40:32 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ee8d40c-0483-45ac-99e5-08d832d1e538
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14683227412EE7E5456F2404F8730@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0derhuzWPAGtrSKAkuxHU/ytnIcv5ffsZdh3088cE9VrkhaY5tnpxE6QzPYe15JuMzgZEeXe/UtRC6cALHkyokvpoTlbh5uF26kAc1yBhvoYgp2J5o8j07+XlVrNM/tZOWfT36IKASomkerJc0wWFNDLj/HM6w5FYwyrXNwtyxe666QhvAkAg1unpun8p4EfY+A7Th3BayuoXFLGuR05BCQaxWvFvQ+vR/rwelXVlx9ZFfgsADEq4pPsjfcbtKauQOpM07Ff1SQb2mkxdqOAM1hFFqGVqMFkwABUsAMud7frICEoPt8r8gHn+Ob47U/RMSfnzp9z5E5BcM+agxNCDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(956004)(2616005)(8936002)(44832011)(5660300002)(36756003)(316002)(6512007)(54906003)(66476007)(6666004)(478600001)(34206002)(37006003)(6486002)(66946007)(86362001)(66556008)(26005)(186003)(2906002)(8676002)(16526019)(52116002)(4326008)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0yfjVKol763U7b9sJkosCmeaV09H0f0677aImHbxXk+GeW4TV2lOnCyMH11JAo4W/4hCuGybs2vhk1HGd8ttsYjVA7oNPwz5H9didRk7D/dlDEmrOqjJeSG6e+rm4djCPBQoqEoHtumWbpjwGNLxOBwfczBgG7RDeYS97LFJ7knSuczg+r3pzTOzSPLVM9pAVndMTONIgeqIVVtU65h8uwwNn+gvTX+pe/WH8lIKJq3OKMq1jxVuRd81UYlrQSgM8N5M3KnfQx71y8wUEamgzOTGRuFz7I3GS+KRmDB7PrUYgfORCBcgUvvbGHHrmz/LP5NRHWqV8CXyoBJEfX67k2iQ9Zm+3zKUMhRyjqqgf0bFuYS9+9oROzq07RXVQUgSkmut6BhLJcGbpmx+i63YTMr+jWSsDqD72heI51cNfKvSkHX4a9WANox2yknYG5xWe1VknfOFkMS3/2BH6oWS/9g4L3uVS8gb6vF2M2Tzy5oaLVABiGLViDmQ4ZGKR5Sl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee8d40c-0483-45ac-99e5-08d832d1e538
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:40:35.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bndJV7qF1VGkd8+PSeA70RGh8o3DofXMEg5Ii+LkDkiRxF9DV6yqJGntHgF37eSaM6vxE7x1JAuXRiZ0dOUZug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1468
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

