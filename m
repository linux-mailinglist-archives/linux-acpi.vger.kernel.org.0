Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46D45D4B3
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Nov 2021 07:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347818AbhKYG1C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Nov 2021 01:27:02 -0500
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:16001
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346898AbhKYGZB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Nov 2021 01:25:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juNZ3h6IGsq0PylgzbOYY8dn4/ulfHSnWDMRrFZyTpFllUWTDGVa+FiD9Wv2ovhFJnncPupAsv3b77U3DjNMiUkDAz8UAcdiih5SPi4qKDeSUucQ7miM5x/fP/gLKS4puvBwN5v5AulftVbU5aXnM9cuvixMbH7SzoZ0jvSC+YUCekcaFte/9RpnQ4YwC7/lfWXpbtLKb2am0r97648ePNInja8u+z+VPJvgRN1IuuqVLN19Ot+nXfKccJgqdWkkRypPBICN8Lk/Nl8ELUdTjVAI0i4YNbGyJ3bh4PWJ/rOW4QT7QWM5HdKK5RCaH0uQVv+r7OS45W/6k70vt2VTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOU8C6Y7znkiFBHiwjZb0jtsjd1uW6pExmiRuMBLTIE=;
 b=M+YAEpqvkr1dkWsAMaAuh5FbXWJb6svXNcNIwYd5gR5Hhxr/efCnthn52q1Om8lgGsQR78BFswG9hKU9kXGl1WE0VbUXl2dGNu9nsqTtsuT+POFlQPxPwfyc4Q2jpn+J6xnHzN1izUWuYu70ZmJJ9exJCEWXEo70hpc5xj8lSW/lhmc2naj4G0ok3+o6ewc5jfeKm6slYklF6DMOBosnOB1LUa1j9Kt2jv+nwYHvWhADUnKyuXtU8WGQS8Ybl/J0+P/fspXcpXYI1LBir+3u9kw9H9XuuFGuVxh+jOZdOLjnRZG6DlynFYhJuHqKNwNtrxsNz4aQc0WA4Oo+Y8YFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOU8C6Y7znkiFBHiwjZb0jtsjd1uW6pExmiRuMBLTIE=;
 b=uavTRIB5BHIA0HekvcrxLzKywf7hnA1FyZ2z/5BcZE0VLe5y4WmyEkWhTjfuFbum5agpW2OgGPLJoZKDUUWXv1OeUX6otqpTE29c/+q+8ZSvsC8Ezhqryh3hodY4mC8cVJGQ90NKBSXfQ777R2+6K8KokiqFdmCuPasIuBDdj+U=
Received: from CO2PR18CA0063.namprd18.prod.outlook.com (2603:10b6:104:2::31)
 by DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 06:21:49 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::38) by CO2PR18CA0063.outlook.office365.com
 (2603:10b6:104:2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 25 Nov 2021 06:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 06:21:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:21:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 25 Nov
 2021 00:21:44 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 25 Nov 2021 00:21:41 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <rafael@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/7] drivers: acpi: acpi_apd: Remove unused device property "is-rv"
Date:   Thu, 25 Nov 2021 11:50:31 +0530
Message-ID: <20211125062036.1185994-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
References: <20211125062036.1185994-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1a0c10-f325-484d-1dba-08d9afdbdd29
X-MS-TrafficTypeDiagnostic: DM6PR12MB2988:
X-Microsoft-Antispam-PRVS: <DM6PR12MB298865884AC25EFBB40B837C82629@DM6PR12MB2988.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 114HYxSeYaZ69wHhIRkWpk8xMtbcXZwaS4fXEql6tsoayRYy4xWHrT7RZxfB+8ebyLSlfFFp4DQ1yOzUgTerej94XLB5QMc4bFMQ+jtOMzwtNf2+vDQ3g4WMgpUyP13i9XJRI8G9ODisjqQyeKTV0E2YCBXQOyFDPkFzWzfY4eixr8a2TaE12vJqJxYqJnayFdutwvHT6shqbysqdNomKunfR9iUKRkpkbeiEg+hEO07cWSqKVL2MnlznIMlieeUT/ijGLukNiUn6JPOix9eD5fLqhDuAkky30auJLc8+7rNIq5Wt3kObuneSmpejYpB8+diGdNxx469zYbzrNL9bG5plKypGp+RV7lVYt4VrH/T0puxYplEAO2XpYUoHWOUzUlfZ8JffnYll/thuGG9ELOL6sAnhdejkHQRYDeODZ4JN6W+KcxvbhrooZ7EcVPY6A3Gg7pObofe1oJtpt/t6GbYOfs7Sv+jQrGkNrtvutbutvpjjH0Lrum3l04QZept6sdV4fIjme2B59LehjELihgAmb6mI99IcJxU3v5sZKfcMJY8xzPwHew1sEIEdcytJS1u0Utik9Dhy/92cth96gyq+dSC45e8ig3+P1QxG3k12Uf9giGzTSaKH8YiC2/HTXHuQMbYAw7DTVwSwq6cvq938Hg+Br1yR8FS5c7tzOEZmuDWyWjlgWG7Sbhfbp9znGrGT09AUK9M4HNuIw+bsTR452iJIVZRBGNt4FeiG5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(2906002)(5660300002)(26005)(70586007)(316002)(7696005)(36756003)(82310400004)(70206006)(83380400001)(4326008)(1076003)(47076005)(36860700001)(426003)(81166007)(110136005)(54906003)(336012)(86362001)(6666004)(2616005)(8936002)(508600001)(356005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 06:21:49.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1a0c10-f325-484d-1dba-08d9afdbdd29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Initially "is-rv" device property is added for 48MHz fixed clock
support on Raven or RV architecture. It's unused now as we moved
to pci device_id based selection to extend such support on other
architectures. This change removed unused code from acpi driver.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 drivers/acpi/acpi_apd.c               | 3 ---
 include/linux/platform_data/clk-fch.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 6e02448d15d9..6913e9712852 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,9 +87,6 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
-	if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
-		clk_data->is_rv = obj->integer.value;
-
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
 					      resource_size(rentry->res));
diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
index b9f682459f08..850ca776156d 100644
--- a/include/linux/platform_data/clk-fch.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -12,7 +12,6 @@
 
 struct fch_clk_data {
 	void __iomem *base;
-	u32 is_rv;
 };
 
 #endif /* __CLK_FCH_H */
-- 
2.25.1

