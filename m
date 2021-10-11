Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88260428601
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhJKEsE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 00:48:04 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:30561
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233778AbhJKEsA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 00:48:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEbFrJtL5nj0xPxIw8or4HikvRqZ7dQ3ZP3uctmhIGY3udybPxPMwxuqwxDRz9gvxhBzCggWdrUU9KMcCt9yL4XwI/+sEGkom/bvDuaYLCNUM0hmg9HPZ/eVuxYFR8rsqXI45J9yzQD8CQsknqPBoPzHP0iua5cXOUV+zcS55wbcwRZTB8hk2XLwsn9gb5Eavf0Jh7ATY6mKczJK2084bYUyvM7rp5pD8C5+29RESzfFx2M0wjHQAMAoS4PUNyqJA87HFyNq7Rx395CRSlD7KxgQDMHl/Z4yOF3Tg9957StGjMQGT2wOj7skF1i3BqONl8GIo/rQsKmN+tP2Ffw1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXFa3Z4AxagLKvohaj5pp6xcSeeWL/caaeWK+OGMA6M=;
 b=HUKEnVAcHW4zrKhfy9dX7R7GfoVtMqT0xoypa/AELWqko0ptdKN77SnO1kf5sDrORUIyeX+BRDEdtTySjvOrKAuAmPKTH1fgbctdsugRPWwkKjROPwHns1JBfs0zio7J/oVu89MRH8gsY0daSiPwS+GulyQGvxWjdwcQIcAiMP5ZJNs/v1sSBh+JTwHu5tLG3XSDZmSKiEJ4slfalQMeMt+v+0lSoOmWNLUrzcyQI4N9xgGH+eZge+9ac/DiKsf7e8p1JRoI+ACsR6gniFaZHnBME2PirUoSB+Mwhx8LOyz5x0vXS9p2xMS/ux6NX3SRgq3IV2LUGS249hEwiQRV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codeaurora.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXFa3Z4AxagLKvohaj5pp6xcSeeWL/caaeWK+OGMA6M=;
 b=HO3grOGi1V0xuVrL0OpZcfvKdRX6UVZW5lIbhkVhFmIbS41RwAOaaNTpqiLmrRzTc2jU9XlIil1k7CRotGZ7NKA1IRcMyY9QnvHAO+2jyXghn+lYiYaBU9WEHNiWH12JjL86lsxOfN71K0qLkUrmCmLM83ZPfCE/+IzgwjkTeEs=
Received: from BN6PR19CA0051.namprd19.prod.outlook.com (2603:10b6:404:e3::13)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 04:45:59 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::fd) by BN6PR19CA0051.outlook.office365.com
 (2603:10b6:404:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 04:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 04:45:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 23:45:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 23:45:58 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Sun, 10 Oct 2021 23:45:54 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@codeaurora.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] drivers: acpi: acpi_apd: Remove unused device property "is-rv"
Date:   Mon, 11 Oct 2021 10:15:23 +0530
Message-ID: <20211011044528.66109-2-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
References: <20211011044528.66109-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baa349b0-d50e-4200-50a3-08d98c720545
X-MS-TrafficTypeDiagnostic: BL0PR12MB4914:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4914B204950FF730B438B43182B59@BL0PR12MB4914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lB2E38JrWKhfZXmFHjDy/YBys+yZMW0oaThbtBxeIixupPi4VXKxxlcm45PVWtGhRNM2MeHjlM9E5dP/46vgcNxOQTruy3JHcYQf5t8nn4gQpjHezixPVUB+6xVfxO/bNzYnMzA+6em8/JsvyvETV9MLB2cKadIefyOOCdoAU/Yw7ZBAYulrOQDKvHGQvmEcOqKQ40uvOY0SRq/5jhGDbCiuKPBbAV1dIZ1Pdq5wHIqj2v8S/snoOhU1WyqShkdSgTjF2adWYawGIyQ+i2iNdNwrmtqt063/Ap2FB07E+Hu9/yxa+G1VxknyeNGLc/r+gUEJZ80exMVRIGNGair8+t3mvTCsvsVwBT31MgjGwTcVFoEWj9YKVwPkxMFTsptUUtFUop5uMZTIx6p1WJEyRH2/NweYqLoWd0lNF1kOP4FnKtZhyuFOjfQzOSvh+1eHnbnAmgtithpbHufgVndnESF11u5zfz1SuS7NHps62Pqk4s5yFn3riU272fQi/FKUOF/UOfmAtXvUHPq0SLgfKR8R6CkKFrMb+SX4IOoNpOfM/deoKEcUk6GYT+pjcmkQLuypH1Og2YX+HFRQE6TGMA0Euolr3wfSh0LqkIzRLj+EfLRDkW3yqs84JkueWbxrksHV4GlSsjo7hNSaq6+Kdq7+ASSQmsY0AE9BU9y3oV3pC4LIYNK6x7glTetnDPQA9UH82gRss0jZwNfjE+ADBd1HVN0tyGgwwABrucMxJyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(5660300002)(82310400003)(70586007)(70206006)(2616005)(8936002)(36756003)(6666004)(426003)(356005)(81166007)(110136005)(508600001)(47076005)(26005)(54906003)(1076003)(8676002)(7696005)(336012)(316002)(2906002)(86362001)(36860700001)(4326008)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 04:45:59.1795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa349b0-d50e-4200-50a3-08d98c720545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Initially "is-rv" device property is added for 48MHz fixed clock
support on Raven or RV architecture. It's unused now as we moved
to clock config based selection to extend such support on others
architecture. This change removed unused code from acpi driver.

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

