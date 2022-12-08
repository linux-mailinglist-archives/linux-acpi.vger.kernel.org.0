Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C382647482
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLHQmc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 11:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLHQma (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 11:42:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545859875
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 08:42:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJES4TxLSmZzCG73G8Ktl5JIlcxTc/Xmp3pvQIdA9Azqlnxa/A8CrX1bKnQL+1ZoVnY1mjXoLTVSmBZ51kztISOZh7taj2XoLYpo0o3jHoN7oa/aqFQ7QyKtU6pPblYxdBsULjbCjfsbcyF0Vrqh31ELPDoavYp043ZF0bfPoPe5DaKIYyIw1eGyDebIhmmCSx5wyaMPO9ZZ9bONOb6v7dfqLsl0rGjntIMdqPdeIm+n6W3nfzvJqZKLTN8R9mcoaQwRM/FKbBCHqkXyp4omt+rWw3mOue+Kq4rLWPE2Efccbnt0TzaxNFxYt62XQE7Enu9h/N+61tC0CB3EmmFfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSPTzDtJjJaiib+dRhTY3bPyGovgFYnN4BOLuCl0Cms=;
 b=HJfvfaVKVtDFVhn0cYjpBnVzj2UorlNx1VQrmqJfdfd3ToOVg1c3CiVIhAl1qAEJEaG4ywXMQkfZ6vmExPHQAfIzWqbeyFSyyAk9bkRV6xTBl+VeErNkOxXrXSo7mx5a6ywZZH23rhELJUsx1Z87F4sQWClX/P7suo9jI2rJwNjJwRDwnMgJZm1dZgKFBLSFfTcqUsEk7eO9ODvn9jDvWAYBMhgVGGpnlOr4/SK4WZ3A/yCKdfm4EpfFBYT238ki18CcXwXrzMa5CDzQA6vuMtqWqSgIYi+VpJIYhLNnLorH5FWGHfzUDGEfcYXwX7uyRgwNmbdDtq+tJV6b/Exp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSPTzDtJjJaiib+dRhTY3bPyGovgFYnN4BOLuCl0Cms=;
 b=ER9KyvNFiEM/IZqpngMSaZutHlz4PBpd9OSpF5U6w6AfQhLrHGBEp6UBDj7VFHBXOrx942fyFq7ROHfLUD/WquYe197D8kMT5mTxFWbFS1kw4jpsN2Lpx82gVoYxyDKMvqSPJnT+7vRgVf3xVW7HTotx2SQOm8CCZGMEln/ceZM=
Received: from MW4PR04CA0373.namprd04.prod.outlook.com (2603:10b6:303:81::18)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 16:42:26 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::e9) by MW4PR04CA0373.outlook.office365.com
 (2603:10b6:303:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 16:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 16:42:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 10:42:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Daniel Dadap" <ddadap@nvidia.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/3] ACPI: video: Allow GPU drivers to report no panels
Date:   Thu, 8 Dec 2022 10:42:05 -0600
Message-ID: <20221208164207.13518-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208164207.13518-1-mario.limonciello@amd.com>
References: <20221208164207.13518-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|CH0PR12MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5969f3-af76-4c56-03e9-08dad93b303d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRoppHF4dun41ekRnk5w5YFDj0hu+0w369jJrVKjPCBx25sr8Az5w9XAcaFflQ/tL7mNL5l6CIc/fcAucUkSMh+0yupB6WC4Pa/aZdvByHT1ouzl6z4DWmFy6tmKf1Z15VCn0oY+YkRpcQgox+5plTE5VtSSSasHU8hM5Z33YWUlUoUz12LzcmH63vC5vu0ssiH2/Gkbf8UGHmDPcQs2S9n6/sB9iHycsdVy6KbAX+I/Z+r6Q0PKvGOnk8JYQpqN4cUWv//lfqcNC6KHCrgZdYKkeqz+4tSPn/NZTURJWhyN3qG9pfpGJRTV+EYBKvV4NXQUZyNJS3SW8cA1RpuZvsEEu0zBlRfwZG23+s5C23nBcwSr9SWdVA/odMiET9IOJlnCFQt8jMyJmFx1yOR8ZttwXeM+lB7t/Wx2do/P0qmezSKRfiBlYH2ypR1+xcJD66R5wfuOxpowB91DrxadJFa6CTdxP+cLBCB0GChMfMokJgHXO8EazjnpvvUWgZQPI/3JkR77kFf1CeZGvjuwh9tjV3JyUHXT6Rvw0vfewIT6hjwBtYkfbTztmh/qW2NYW15qT3K3OkP9R1+/ZnbhUofYwdA/CdOfR2KZ7mbmXYxiTTDUHKG7TfL3hV+gbCZBO16lFRw0Yag4mk3w9VjrPQ/UPVW9++altrqmnYIL6fXwcsjUH9QwJ4sFHkyK3t2hLtmNAAS14AmQNH9DO5bHUZLD+8mJljNOFaIKXmaSGsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(54906003)(110136005)(8936002)(5660300002)(36756003)(86362001)(44832011)(70206006)(70586007)(8676002)(4326008)(316002)(7696005)(6666004)(41300700001)(478600001)(82310400005)(83380400001)(426003)(47076005)(40460700003)(36860700001)(356005)(81166007)(40480700001)(1076003)(2616005)(186003)(336012)(26005)(16526019)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 16:42:26.0230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5969f3-af76-4c56-03e9-08dad93b303d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2->v3:
 * Add Hans' R-b
 * Add missing declaration for non CONFIG_ACPI_VIDEO case
v1->v2:
 * Cancel registration for backlight device instead (Hans)
 * drop desktop check (Dan)
---
 drivers/acpi/acpi_video.c | 11 +++++++++++
 include/acpi/video.h      |  2 ++
 2 files changed, 13 insertions(+)

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
index a275c35e5249..a56c8d45e9f8 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -53,6 +53,7 @@ enum acpi_backlight_type {
 };
 
 #if IS_ENABLED(CONFIG_ACPI_VIDEO)
+extern void acpi_video_report_nolcd(void);
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
 extern void acpi_video_register_backlight(void);
@@ -69,6 +70,7 @@ extern int acpi_video_get_levels(struct acpi_device *device,
 				 struct acpi_video_device_brightness **dev_br,
 				 int *pmax_level);
 #else
+static inline void acpi_video_report_nolcd(void) { return; };
 static inline int acpi_video_register(void) { return -ENODEV; }
 static inline void acpi_video_unregister(void) { return; }
 static inline void acpi_video_register_backlight(void) { return; }
-- 
2.34.1

