Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9897B6461BA
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 20:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiLGTcJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 14:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiLGTcI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 14:32:08 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D610FD5
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 11:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGfHdfbIQ7tt2uRFtku0cvGVA0TS4uccRNrbFbhCpiqP5VXV6raxy56TpSF1flF+hEHkp/h24TgEK4kguOJ2Nii7bO/EU3Z4Hghdpjo3VfTsF1uCzxfYCWGNyo5xYD0d8skc8Hi1md2KoRutXpyFDZGKzDNKZ9fYKfJoD0e20P38CkR9gekef1vUCDa1l4fwLi70dmUn2WuXL3nC7nKyEeYKqqY6SvMadzLYDC3GAqWLVHcFCdYtPKSXUIUXoz/aXXEzSxiq6mrnFZjF72GRbfhAPPgbgTboxxCqgeORGIRG4IrLxFdGM4X12WmoEhJlaxCDDImjAmugv9cmcFKUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U7B1sTeNAO1ceit7Mh6sWSm/nToweh5svnq1Id1pfc=;
 b=oS+FnNcWXwE4Va+w/ezpPasq90YdIhX59s+Hlwlbn1S1cS+SbhsGUZAzLi3x9RY/ETXwxq+SYtekp31tiI5qCDBcfRWeUYF5GIY/Un3rLjZ6nvM+5LUhNCMvd93bxub4lG8ZIwJLPlCi3pbXEKV6A3XLd35b42QxqyTuJZHEA0xoQTNs+/CpCNxJJrJYrAB0yQB257t8poYFqYSONadbPS55pm8fWLRt/uXn06MuzUZ1jf+dd7Nt37BNWzpGEALoiVjB9kk5gZ8jckGLm6SIYo1qKB++86Kgv6mXbm1aWEhxx+gFkxutKvd2tXdhqtOtEZ5N/IAlq5v1NwTvHmdeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U7B1sTeNAO1ceit7Mh6sWSm/nToweh5svnq1Id1pfc=;
 b=s45+LT6Sch3So8EXdZBmJF+E/ySZtC/5OZhYtZyE+2agaI2AK4+Liojy2ZfJYqIXdP3KcGvwWrRi9hwVxSOOdn+6mFOQbXJ0AyYxMAL/CLXyWjxO/wT+Ejr0P6POyxERGIJ17sAWgu6n1GX6kGBxXDX1rhFkqTMs1xnFDTzIxBY=
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:32:05 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::7d) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 19:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Wed, 7 Dec 2022 19:32:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 13:32:03 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/2] ACPI: video: Allow GPU drivers to report no panels
Date:   Wed, 7 Dec 2022 13:31:33 -0600
Message-ID: <20221207193134.763-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207193134.763-1-mario.limonciello@amd.com>
References: <20221207193134.763-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfd2028-7bec-4062-6361-08dad889b8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUfEh/ntKqsf+zma2DpfFNhjolHqEYgVp8UPXxB8jWi3fOQnNhnK/CYdx4A8nbgS3aKXn6Cpyk1U66AyKxkakBXoDnSHEMfgTPjKeW4Qwo66e5jh12N1BI0AnV6bpQ+exQOS8Fu5SBrUA3vjSB8QC5MEsWOAseJtDjXqKZa+1c66bpBmpDfd9vopn8oKq/KkS2RucVG4wYCkSgDP5bXbV48Umbf6ZIeJC/Dq8kapL/RXJYqRnwwEJfDf5kGLoh/l99r2ugF47xSN59V0h4d4tc2QLQNLdi3efOtibJOjHbQtql5VxXbyfJFk5+bHVwRrCnOkRppWHHcbEF1HhtUl+76Kw7KsG/51JibG4J4MLeZvkVwWTEWa1HAR4POduHZ1/7QHMCgGANScupFobJiVarXSWAE2fBE4iAgG9eLLqMVsOSPISptNO+mTKYMClNZ1BfjdtKi2nxwQiTlJ43LVQZlhvtUkuN+W776iLMToIC6xTdCtGed1m9E9U/UOKa2YArrDur5af0En05B+AGQLRKne27Mw46M5tlooqk8vJifdAdjevrfFZ/0sBOvmsOcj2Ze+qCeXLlfiV1u2IMNu+aPIVu9Ks085Gh8DTdiHNlqlf4yo94vB8bvIQ9mrUAGu5X6c86+d7UgxI9aR5uJnnI3Adx8NTVUKVnZj468oYU86fCbCl8IvT/CwODtIgCyhPhchA3ZOYyZZafb2j/zxQi91r0huxa21PMrVZM+DbAg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(86362001)(36756003)(40460700003)(81166007)(356005)(44832011)(4326008)(8936002)(36860700001)(2906002)(110136005)(83380400001)(82740400003)(2616005)(316002)(16526019)(70206006)(40480700001)(186003)(336012)(54906003)(426003)(6636002)(1076003)(70586007)(5660300002)(478600001)(82310400005)(7696005)(41300700001)(6666004)(8676002)(26005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 19:32:04.5864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfd2028-7bec-4062-6361-08dad889b8b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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
in whether to make an acpi_video0 backlight device.

To avoid risks for regressions on complicated configurations with
muxes and multiple native drivers, only take into account drivers
that have reported this when the system is a desktop.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/acpi_video.c | 12 ++++++++++++
 include/acpi/video.h      |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 32953646caeb..e297f8877797 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -82,6 +82,7 @@ MODULE_PARM_DESC(register_backlight_delay,
 
 static bool may_report_brightness_keys;
 static int register_count;
+static bool native_reported_nolcd;
 static DEFINE_MUTEX(register_count_mutex);
 static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
@@ -1811,6 +1812,9 @@ static bool acpi_video_should_register_backlight(struct acpi_video_device *dev)
 		return false;
 	}
 
+	if (native_reported_nolcd)
+		return false;
+
 	if (only_lcd)
 		return dev->flags.lcd;
 	return true;
@@ -2178,6 +2182,14 @@ static bool should_check_lcd_flag(void)
 	return false;
 }
 
+void acpi_video_report_nolcd(void)
+{
+	/* Only take into account native driver reporting on desktops */
+	if (dmi_is_desktop())
+		native_reported_nolcd = true;
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

