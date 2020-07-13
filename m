Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27D21CCB0
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 03:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgGMBCC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 21:02:02 -0400
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:48481
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728010AbgGMBCC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 21:02:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ej1zyNdT7lCaj3tsgWrKGTN7gtNpT5xlUuteExj/aqf0ui7zwrrsDGm94dG7fCFo4Kouylia/piS53npxTRyvxO3NkyU59SJSGj2acbGRSleKAwqRJBNBlpS2ufKruubB6FURr7JDvjnqy8R/fuiyuX5cQbna8O5lXT1t1QFvItBgiwYRlM9RzKou1uGZF4q9WzfOP1g58u6FXqKIpTqAvIu06XhO8hhJKhYQrgg6TaUOcqZT97hwPyUgNh5nejEvrFVgnRtH5zHKZx3DiH0hgMmPIychAkiBqKuKgQgEQmUB52aqncnedhz2qUrOAu2iZ290MkikaweZ1pm69t09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=Q+r7/MRBXGBLXJVy+X81hbYQAw/mkv9WgCVy96o7+nuETpB9H4BR6GT7EN4TVdsdtI/UDh5D0lRDa/cH5FitCxC7pgVC54uHO8Fl0ag0r62jU3kSqe9Wwu8Hq2oht8v5hqyd0W8KUQVIojBrUFDcX2KfKxfWbRb5UfSMEE33efEvk0ryNrzOI8bfN36i0QgsjEA9finloPKeLn8XUDGYT19UMrRSEwpR6vIDrDSpH39gbF1pEZ+dvzXeFqM/wL2dSBH+hQLLvcptbEFTBB6+ZX6GVukSzJ8y9/hi2ZJgC2Smo44KH23AtJbWRrXgZeMP9s0Na9v4/lfWCaIeAIZLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=2tGQKnm8tRvtXPF3fKDZiGdXuHJvKiXVCPog3KZYoJthT+CvtNpGPGGcuE32SWML8GBqg+HTErnK5JXw0N8R8QWhGBYFpAtVFVe9RXFUOaQ7D8TgLzDf8VyciNVtpZhnJM+Z+IzjWrjlGp/+HMQ3SRydI67p+l3/O6hWgN6m1XE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1600.namprd12.prod.outlook.com (2603:10b6:301:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 01:01:59 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3174.025; Mon, 13 Jul
 2020 01:01:59 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] ACPI: APD: Add a fmw property is_raven
Date:   Mon, 13 Jul 2020 06:29:51 +0530
Message-Id: <20200713010001.18976-3-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713010001.18976-1-akshu.agrawal@amd.com>
References: <20200713010001.18976-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::18) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.167.38.75) by MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 01:01:57 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.167.38.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4e809c8-8fab-45c5-1c0a-08d826c85840
X-MS-TrafficTypeDiagnostic: MWHPR12MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1600540D866D93C07A3F79DFF8600@MWHPR12MB1600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Okn5yMXAF0Ay7momAzQLdPGTYgXYHxq46D93IG+rx2CF1r7IlLLZ1wD8DqOIdc03gaeDV4id7Mp9bXTvs8MScVCZmndiheCbmMiSrd9Y3+/SK0Tt8KE6qptFvn1MvbULDM5dIysqOwXnWhahcGjf0w8Bah10UhfclG8V3G3dLkv6u3DkOlrZGFhzlDgR1lrdihDP4UHP9yJLay5rMbbZR87p9DpfA+RXzLy8Ae9tvq8K9dsoNHMGMKM6cu9+ZT28I6MdWKzFqsP3/lUxXs6NBm6JhlRpipgtSIavzJXrKmXZLTSKK5hbY0wH03Q4fmaVrWq+ZiptjlmScfZ7MDxCXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(52116002)(478600001)(2906002)(1076003)(54906003)(316002)(6666004)(34206002)(4326008)(8936002)(6506007)(37006003)(5660300002)(186003)(956004)(2616005)(16526019)(44832011)(6512007)(36756003)(26005)(66556008)(66476007)(86362001)(66946007)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Cy4Z61W5dz2Irs6uIu8kqAb5h4Wc7Jp/lUv8lix85NEfteIqh0yUBsF89+XpNKsHsQ9FdUpqw2cwLnpRu2rv+xoJobfmTUW8DtXiBaCRFtU6dearwlBbkz6MZmT2RM9sjVS8rg4lG55LWxY9H3j7zx1cmbaBQM26aXSaU6CBCyVaJ2r8YBJl5Q9/zhTSvA7wD6GWXBiUWfmMPt5sEk7VT0NHht5gmoAuKrHuFGdJSCA8h35kiYACh3DQQW4SLMyptOBXCkO7pDAfBL9YBXuxqxeh/lDnPY8C+NRHCWWlympt9niHOfAwSTVJL5WTzHroF1L7mnNS5ZeI+eomS40EhaFL66t8ESh8hSuKk1QoCkFxyb/2SIKW77FroYOrnt9iQe8Hme4p5cQ2uyPfKzjEL2dSFj3OOePbr2KIxrBoP0MKoOiZjDpYkX4yo24e39qtbbVazO16Kypo4LP4d+H64eb2cgEJGtNNmJLic17LQTg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e809c8-8fab-45c5-1c0a-08d826c85840
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 01:01:59.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIf7Qyeqrv9MF184BWiGHVPIGoOF5OtthkmRfoSexYoi6EkZHkFkeDj3nEJFKHUAtnPZ10M5df8d3nJX1cIcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
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

