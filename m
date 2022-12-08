Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB564663C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 02:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLHBJf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 20:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHBJa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 20:09:30 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC38B1AA
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 17:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJWS/LWJGmjo4Xid+fuhVvYCOULNB0jvmNN1CPtvVpHdkgmDYfXWazUn9HZfiwFflXjA10ApOPiS9gf3Ajg/yrvVD/ewyUUxbj6NCpBR0HjDb2JadpLVSsqNOdxDr8YPDHybJYB6BtUxHACtz/xVH4CPNKL+ZwZBGd7VpQcEyIVODRmJvDcCyxf//9R47bO5KhO0JuJUH1hrXIG8J4F7DMGS+NeQnR20BLq8qX1YAxtQrJxJNBJK4L8xDdrYaB51oYnhjgYrBL2ePxp9sjEwsCiHfIeD4bxRCnwfZFgFN6KWj1ScurL+xUF6uBYbgb24C1thkXvePkgTMNa5Sd9S3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDtid1ojx/lvZjBL2U+cgdTDrZrmuycQc30fbkxqeqE=;
 b=n97jhyAujooBvLG0dFGaDB8uy73RMzCzHf0c38ipK77V4I0ciovhXmpDHyizyVRWbyqfXJ0dWEdnGFvhW9RkgN2xZgwVm+ECsVqtWEa11dLfJovMQ6mIQ095m4nNmdyU3HAaoV94kw85YeUILd0yj2YVvP3PoNhoRob9OqwKqaguhGV+J0LLGx6e0JDvpkoV7GFQfiHJJx7mqo/LjJ9P39UXiAA42COUzQNEEiutVEK8+FHwi6P5bnfhJNente+OF/Z69NBklIqjpyY7t8LmSwMHaq77xVwZN9uDTEkVXTRIYjfGe+ld1mDljaiet0z3ytrqc1ELVkKUqbxxTZs1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDtid1ojx/lvZjBL2U+cgdTDrZrmuycQc30fbkxqeqE=;
 b=os8NSjt/mIseWJrdfaM4kJByyxhe3OsmAa/82iRs27KA0TGjOMVtTiwkjJOQufRgisXYgHChwnqsTJus7x/LpCL9RCk9wPsXNlv4rLnslt9ctuICmZrRIOdBhFQraFwf8Poa1Iw4ISskeJ3wM0YL9re2PWvXHXGwKgj74lOofvw=
Received: from MW4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:303:16d::25)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 01:09:25 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::ef) by MW4PR02CA0026.outlook.office365.com
 (2603:10b6:303:16d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 01:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.15 via Frontend Transport; Thu, 8 Dec 2022 01:09:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 19:09:23 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/3] ACPI: video: Allow GPU drivers to report no panels
Date:   Wed, 7 Dec 2022 19:09:08 -0600
Message-ID: <20221208010910.7621-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208010910.7621-1-mario.limonciello@amd.com>
References: <20221208010910.7621-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec2b907-7328-472f-b5e5-08dad8b8d91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcDlowsx/MbR5fIBQ9Mo3CvgMS7CustTKPTaaaoF9B4GADqyouYMcT4ltq5Biku2zHVluc0L0AIvTUem72CLP7Q0gnfJLtg1tKE/hNv13hD9aDKCnVAPHYE2THWkfKgBueVVJNPt5HWiI2eL6kTVQuJXQL+Bqmrh+vK4VeS7PkUqOolfLNiqBRoebG5z6BtNpTJ0H3i0Ln7s1csouZEziY4vitpCkqUsksHn4btEMp3b+AAEhOcX1vAdHFTeLgzTIz/w3yYvqYyJZlCUnNQJgSNOxLW/zh08z711A+fPfY+Mz7qsqAYa7P4lH970aEbg559uLvCOWPP0Ehq497OamzbVroX3LcIP0HB7fLPy78HQshQJ8zu5YhY9/pxm0U3KmxwFVPYD21Bv+flmzPxu4keLZN1OZbHB43NfyroE6pPV0MokElWNl/kpohLrghRMHr0IIagB0fBrEr+LGyTNF0tYy65+4kp9DCPwcg2lGMO9n5Pvelw37UloHw3E/iqVsPa9YsetzYUbUz4YRDqA3ju0C8WE7/pyL/JDaitra4EmRRnuea6Qd5HbPn4xzULitmqFbsb4xQpJBOkQhvwP5x6arPLltlZ50mLam4AzjSGy+LQd5KNrfj53EeoNPKZjwVcecjt/0bEutmfkniMPU7n16lp5D0LotLEFhO4bJmtKzZJyD1E+VM9XQrp7F35q4+S0Esc8SqUIMCh2XR4S0gZCBYKcHp35EjnxLyfET2w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(86362001)(5660300002)(356005)(81166007)(4326008)(44832011)(41300700001)(8936002)(40460700003)(2906002)(82740400003)(70206006)(40480700001)(8676002)(336012)(6666004)(26005)(7696005)(186003)(426003)(1076003)(47076005)(82310400005)(16526019)(2616005)(54906003)(70586007)(478600001)(110136005)(316002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 01:09:24.8372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec2b907-7328-472f-b5e5-08dad8b8d91c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The current logic for the ACPI backlight detection will create
a backlight device if no native or vendor drivers have created
8 seconds after the system has booted if the ACPI tables
included backlight control methods.

If the GPU drivers have loaded, they may be able to report whether
any LCD panels were found.  Allow using this information to factor
in whether to enable the fallback logic for making an acpi_video0
backlight device.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Cancel registration for backlight device instead (Hans)
 * drop desktop check (Dan)

 drivers/acpi/acpi_video.c | 11 +++++++++++
 include/acpi/video.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 32953646caeb..f64fdb029090 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2178,6 +2178,17 @@ static bool should_check_lcd_flag(void)
 	return false;
 }
 
+/*
+ * At least one graphics driver has reported that no LCD is connected
+ * via the native interface. cancel the registration for fallback acpi_video0.
+ * If another driver still deems this necessary, it can explicitly register it.
+ */
+void acpi_video_report_nolcd(void)
+{
+	cancel_delayed_work(&video_bus_register_backlight_work);
+}
+EXPORT_SYMBOL(acpi_video_report_nolcd);
+
 int acpi_video_register(void)
 {
 	int ret = 0;
diff --git a/include/acpi/video.h b/include/acpi/video.h
index a275c35e5249..1fccb111c197 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -53,6 +53,7 @@ enum acpi_backlight_type {
 };
 
 #if IS_ENABLED(CONFIG_ACPI_VIDEO)
+extern void acpi_video_report_nolcd(void);
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
 extern void acpi_video_register_backlight(void);
-- 
2.34.1

