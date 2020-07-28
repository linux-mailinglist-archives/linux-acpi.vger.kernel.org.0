Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1868823056C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jul 2020 10:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgG1Ia3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jul 2020 04:30:29 -0400
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:5217
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727808AbgG1Ia3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jul 2020 04:30:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1A3bT0Qxe4SMl7+erRfAhPKJWNRTxgsjOZMZ1g4jHBLPGhxOdsCt716ano8y62olBrtkq5IPExo3x7ypF/78WgSeq2nCm62Bz2vpcSb5Z6jImW68g97i/4cCTn7i0HTrnaYtC0w2lN4DyAyjz9ZUVhxganVZzWEtQcQ6xaMnSX4u0TGRIWyIcoPO8fnaVkvXpQK1F2gVbR18adZouvo+Kktpaq0Iu/knES0/gSCER1Zfyqhum4FVbdi6ytv/f5+7SXIaB1McTYR+g841aabsTGNCKCNPE2409NZpjISkOIrQfXr3PKCSvroVG1QhjnHOvPqd5G7M306++uHmuRsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=c1F0OK9VoFlmyh4DIUPx+/7r9yzd0jLw3WB+rCUfllK++QEwwgowh3LXh8CkL9q9LBJKrarUeUOORBnPMAGi55vo/q2MJBrgUOZ0umELoKYPckFQl4pWfPGjtH78DmxYAAMEpM4yk2Xeg7lLQCbqja+YCr4ZfmQ4MM59Sagzba3NuviI7w7u6jL+iLA3QU1iiFONdyVFptCMKYxxaojyCIEOgIKsY8NMN2ESjcQ9/5hceA7EJsy0yfp+Lfkl1zpXKMnA90CBk+NkOoDYlGKZtueK1EmrQ9FBEYvwD3/miRh/QJRMPkh3C8Bf6Zx+slC+KHx2BDAjpcT0oAXwhn/ghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=E87h/vPS43/U5ExNyob5029cIvwhCk5x8H4G6DrwlhNL+7empSLLx0RVKoAU6r6MGr2LEOy27/XwurjI2cKtpSSZGbIzNjrpKLGSviYsyBr1deWwOOdD5TNdUO5ky9Zi190bAWNEU0MVaSnZnvJV77RMrSP6GZYx8hX0dRLZVeo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM5PR12MB1468.namprd12.prod.outlook.com (2603:10b6:4:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 08:30:26 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 08:30:26 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [3/4] ACPI: APD: Add a fmw property is_raven
Date:   Tue, 28 Jul 2020 13:58:55 +0530
Message-Id: <20200728082857.10829-4-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728082857.10829-1-akshu.agrawal@amd.com>
References: <20200728082857.10829-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.171.179.172) by MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 08:30:24 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de8e3716-347e-4a80-44e0-08d832d07a83
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1468BC785A5998566C4029B7F8730@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpLY7LElQgrriFwY6iC2CzuMrULDTiw1fFanoM7R8PtAosIM8ORV4t9+Ra1TOZXqeoEU1F3zBV7oKJ/CvGNLtWrdDSWXTcP7i2TaYkLA0GM3VBk6e99hanKf/oY9orhLNiICy9eQw9QTVdJnzDlqS0Iq6GoluAj8WdPs+K9g7E8wSqIR6ogXAKvsCuKCN4GS5Q2PIWBpXE/MTK2GEOODo/rMfE97dL6u22o++ChJBZkT/yq7Gjz3Tor30Dr5Wchs52fQumkvUKNj5vLJDYxocH1a3pv9/walJ3EnVC4vBQ69ohdPJ5r6vFPDYNRN+k6PQ2s61YpyWienNWgNuyPWkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(956004)(2616005)(8936002)(44832011)(5660300002)(36756003)(316002)(6512007)(54906003)(66476007)(6666004)(478600001)(34206002)(37006003)(6486002)(66946007)(86362001)(66556008)(26005)(186003)(2906002)(8676002)(16526019)(52116002)(4326008)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: J4OtI7QqcGf53nQKA0pqEXtQyHg2ib6r3RqchA7YvpBHimF6WuTpkhDzJxou8v11tMyopQrxriki31xZSlxki6tEEh35FiO1jNbn5ZbgfcN9qse4qYMSYihjxz5JxruHhAAX5paSScgLSYjWayhJzEXvA9IqpkUGoK7wNKG/VLBByEvbsQKTDDsGrfmCwuTk8FXZE6vef4iiUVliKBM+F3ytwe+fuhevKq0EeT7VOwxxQZB3UDdtPt5kHPbaT3aXAZN2EN1iTrcZxCIcs3I5J4tQ6Uc/cLpQVYnC17Rxi1N/4bzzJZGKBSfOAh5sSLFvorwUB4pynA3lHVSg/Pd4C+CR6g2XldKqpXnXkgzwlOwNuraPNBKdT6ANGEF/Xf6iimDNxkUf2eIpTO72S7a0qwUfYRtSZPZHVXyCS9GejU1ittCt79l00OLBGWOC3RKkaxMgTD0r2QlpP2j10aGSGT/IU9zIwWME+kjEeUELKKI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8e3716-347e-4a80-44e0-08d832d07a83
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 08:30:26.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NzjlOfQUM6Lpw134inkRkTmCp0HXW+j0EWnHDGayC+YHyRUXBKDQbuKyXKc6Kp5LXTOQaN0oklQl/nMAf4Pfw==
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

