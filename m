Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3E23470C
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbgGaNhH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:37:07 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:19681
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730367AbgGaNhH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:37:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvYR4S6Y4nw4qoisKQ3bjepEa6w+4n8HESywBq9qYlyByZahcDGVT4tIyAS0Ph7ae9ZG2SbyH90kElb2qUCooxM1NoKtUD1YRR6AmXZjvT4S+ygiNniU/ZXNFglsdIv39jp0wJTtsILEmQ+VQ9UTX9LCYAeJvLDDjkh13W0vlftPlmAGoXfWgZtbCbDYosgX+4aSR0YSBIpZA2j81vSjqdalDw3MXHEqEsz1XhSAo7iUm5aX8t2fu3Q/Y0NpPEk6I8pE6ATbphMjsrQi3tEy3tVnBBZ/FB0eM6400TZu9ROBZmC2R+D+/TB49a3iL1y/EnFmgpD0QTmG3s3x41RDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=irR++mohqsKyrl7yNFfCmNm2dbHQqdqk2kAPSF7ZIfdGpeidDje6QpJMiN4yM7VbxQn5y2ZZcxilbXycioREn+7oNxgRPnOt+hbVNXyO3KQx+LbN+sgO1GKMqL0VXESYJp9cdLHes65EywnTMPSSKQYtP+YsOva1rBuDGiY2I37TrfmAPp/iB/gpg/P6rSAsYhKsyHJNWpVZYjF2koEONo70HwOhV+ZfT2vIOiJ/98F4g1FHiQTma0AjxbB63GNdyvrsSd1Ahv+OSWB5JcJ2vsnzcwlLmCJ5Pwc4W8FQjuTXpjJB8M+ljVclv7/OYMb/MEUzs7UldvnMWHHw+tGBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfCk201FvWlIusiJ20M931+ZD+2bvTDB4nRyCEUoB8M=;
 b=q4mqn9YmPTZKS9qzdpoDV2l97m8EF80lIxuDeYxZ6sXIdKc7j/q2GxlLnKOMfus90exv7WQiz/BULP+SCP/N58Lyw2z3GwqyzOSKBEmQrSRf4jZtftTPet3UW/CrNwPjv4z91dZ8ucxjXec3ZcYU9JkXlUYDus6BRflEv2ubRwk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
 by DM6PR12MB3257.namprd12.prod.outlook.com (2603:10b6:5:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:37:05 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::4df1:4ad8:38cd:128c%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 13:37:05 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
To:     akshu.agrawal@amd.com
Cc:     sboyd@kernel.org, rafael@kernel.org, rjw@rjwysocki.net,
        lenb@kernel.org, mturquette@baylibre.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rahul.tanwar@linux.intel.com
Subject: [3/4] ACPI: APD: Add a fmw property is_raven
Date:   Fri, 31 Jul 2020 19:06:03 +0530
Message-Id: <20200731133604.12512-4-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200731133604.12512-1-akshu.agrawal@amd.com>
References: <20200731133604.12512-1-akshu.agrawal@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To DM5PR1201MB0188.namprd12.prod.outlook.com
 (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from local.mshome.net (122.179.42.211) by MAXPR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 13:37:01 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.179.42.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94870b12-acf2-47fa-c3ef-08d83556d01d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325717A49CD3C42721F30FE8F84E0@DM6PR12MB3257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPuVVRe9X91B81fzbeF6zZ3VqILv9yHGVGCnVRFpOfDtu+wIRRmc79iWMPEw0B9fcNEMQrO1wsWOjNTExNICRfGT2EfAdsEFkOEodwm94Jtv4+Abv3vhTJxS71bRE2GqtCWF0J8Ud2kjwRpliZUS4OD8meBOWCXYZfy7Rm7HHawHS50ZoEypq21bttCqSo3K3dLO7ahUQfy2XwXwRXvSj3Q8rg3fk84zqhiim478n8+R/OcU+uj8zawu9aTjHJ13b0mMQ0/Ifkdr3FpQ20mwC+7F7EZEJMARf4pI7/yirg9wjuuXb3ok1dkvEXb+Fum+PLuRntv9iYoL9OtCwy5Rfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(66476007)(66556008)(66946007)(4326008)(44832011)(52116002)(36756003)(6506007)(34206002)(2616005)(316002)(956004)(186003)(26005)(16526019)(37006003)(1076003)(6486002)(478600001)(2906002)(8676002)(5660300002)(8936002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tpnddP4hLQI66P0JKxSLR104FT8Pv11o0U19MOgM8Wu45F2Agqrp04CE/MupRJVI/GOgsla542szIw3B8zSJjgJe7bJMif46QcBH5t1jtlc88SEjVv+ebhX/cLXaeEa9Q8scM44XO9jVS4fEpMJAkIK3f4b4EiSaCGjBL/M0tcAkaVJbu0jVZMjr97CTSvTAhB4Z57sWoKO4JPX9qK2QL8Sv+sVxjRBYZcL4aGRd9dQh8Esn2NHMvrrW55y0LguAdaCpOYYD4P8jJCqvLI+fW5P2PfVob40VCPJY9Yko8rfWGBDtF86YzX/NRM4manE/hd9R31HM3q+YKm617WJYclqlkVX8DL2gTrMIkl6VIlOw09Mt5U1EM59n4Hp9sRlj1R2VNVmeICZGb5rTVqNDpeYjKjhpfW0xfDk98vPxlyyOczL6Se6NH4O6/bsJ6n5RxThuQZTZmEaUgoX+GfUFbnBxU1gTk5T4bK9UAeL0BEYmCaJjUkh+C5brFwwlwrOZ7YaU7+CUnPsBumP/IzRLEQnFGG+4lhqa4Ie8GnumBF5BAT+4a/WMTJpzRKx3ldj2qt/sGrM86OGVshrs+9F5FGrVEmLqrDVWjK3jIRx2a7e29LORW3TjyPfjmZTej9mrj5dWr0USYoECVPyp67dnYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94870b12-acf2-47fa-c3ef-08d83556d01d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 13:37:05.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBxBAWK8JIoghB0dwkxbExz9k0izMV+eXp0u8Ihn1cBCazbJygAFO5/y/5sptdpap6ZT4mUMRla5Nq0bsbloIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
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

