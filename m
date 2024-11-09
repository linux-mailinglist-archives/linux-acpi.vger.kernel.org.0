Return-Path: <linux-acpi+bounces-9462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D89C29E4
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FC91F22B05
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5AA145335;
	Sat,  9 Nov 2024 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NcT7ZEI1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1313FD86;
	Sat,  9 Nov 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127350; cv=fail; b=FJDmzMCAWj9RGQIR8mrzWvdQ43HXH+gZN2Hq6Iq/zD7dZgox+kCbS+QPkUyi7alUcwI76zAjLaim46h+w4Tw8I6J8Sz/MsWGX/hXX6b+GwzN3vOL0ov4bpkJJ+hLbkHLD/Db1uhDdtsWH6F/9V/yPBBRfuZw5VQhBxKTKiqngtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127350; c=relaxed/simple;
	bh=F1Pxy1S1dRqyvuiXU8C/QmcFr5MXUQihSapuszxXgEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pddilueesMTUlEF98o4DioQjjQ2pBDWOZQ4noWsr+0umejyLxc2F4IGNXFSWUjpUreyc3eHtgKk1hAOLiK4BdeAKOwMgsle8MTId1IxY3nyHI7IZCvw0gVtTu1YQHpKT//i+NuF1ciEJtJrY4XclhEfpPNmoxeQ4CCNXI4/8r44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NcT7ZEI1; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AihIoIMlfdXbI97X8heVW9MtHtWRG7cAMybuU3mAOG/NCH9dLKZWGqf3Jn49KX6AAioyOy4nbw2QuOgRN8myyd7XEa2HKWTb+8YFG6D92Neoz7BxLdoCVZV85UnsbFLObHs+SxxofFbIFj0aUnsyU1OP3On5fDRGNmEjiRoblKAIXux8823xQQ+TFHibiW/Ad7/UKhFBfh+vmtosTmlr+T6MFccZI6oHHKp1KQ7ARsJzN34doQSXQclioSFYuRZmmhUltpcxIehtlTVk7/HWr6O8fLU63YsZPZti9jiNrc6feSQpm+c02bk9bwTWSp3fypXFREkKSV0dnO+0fnqkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2hDAjXmMDYtqw1TqBySTR0sDGwr71iZc6aE/2BH68o=;
 b=ebIGnTjRzW9QOPckY0UbqMEvTbf7ZcLdCMWiNhBC5DSVWjnXeHyieGSHsP0qguZjanaOHAz6ojThOyjKvcmB6UZhlqyNgxA9lE9n1ENUwFNNcqeKWrPIZf6qrD70tRtOH/q5LVA+1mEg8nwPCqbx0wgLiwrpgJ0dFKN9Hww6+Aoxj3kpW93bvRGEh359esTIfZmcTJVdHVvLbp5lHVB/1DVhJL303Tj73oXxD2s5BuhfHPYSrYDxdtDNuvcwx4U9X3g3IZ5Cicjkutu/XhJ6qstKl4gZce7m5Q+O1EyuJcFVihPztDa4B5VG3/12ZuKDV0mgb3w3P7faQK/QMDC0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2hDAjXmMDYtqw1TqBySTR0sDGwr71iZc6aE/2BH68o=;
 b=NcT7ZEI14YIlkS54xdPObOOXhuUP1ZlOX7FpCs/nOjOxcY7Nsi+/a6iVjcQ1iEsCFpIUJqnTMJtY8ha6v7y54ddGt5gcZflnaHPJNgp9KyIVcwpsB/cYIu13fVcaukuShlEs7PDiuBec8w9bqmZBBUv7H4cquZeFH3C9JHGMaOU=
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by IA1PR12MB6259.namprd12.prod.outlook.com (2603:10b6:208:3e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:26 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::44) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.12 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Sat, 9 Nov 2024 04:42:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:23 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Corentin Chary
	<corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, Ike Panhc
	<ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	"Alexis Belmonte" <alexbelm48@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles
	<soyer@irl.hu>, open list <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:MICROSOFT SURFACE PLATFORM PROFILE
 DRIVER" <platform-driver-x86@vger.kernel.org>, "open list:THINKPAD ACPI
 EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 05/22] ACPI: platform_profile: Pass the profile handler into platform_profile_notify()
Date: Fri, 8 Nov 2024 22:41:34 -0600
Message-ID: <20241109044151.29804-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 39018bed-ca04-4303-3915-08dd0078e8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oCYzn8KIWahO+/ObCKLKeRjSdT82t10xTEK48x+j0f7ZKwSk6uZZ6u5iBpPN?=
 =?us-ascii?Q?bBbnRVjOihNtPTEBs6oB7INUK1SfF6eZ7bcWxHykEIDlKLCWjmeJMNNo8+r2?=
 =?us-ascii?Q?b6Y408sNWyCQK97aFk/iBHfRtFu7dlsKxrzkyryAeSDD+QWmHtyjLpBCUSUx?=
 =?us-ascii?Q?aaRkUGWgqh7dsOP8pXcm1j4mEcJsdiKwA/Fww+scOH/dHNUAr1v5NHNCohJ7?=
 =?us-ascii?Q?sgMNDoD+3weBlF7zXW0Xjrfk/HUjTGQIYaayPmyJdEpWYM/rAMmrFn8hDd/a?=
 =?us-ascii?Q?7wNz66a6HTu+Qe+PvlQNmG7anVc5qdzUBcn1SYPEXFyfkXzmvN46419PP/bK?=
 =?us-ascii?Q?CHPzJ3X3eMBPoa9sz06hqcRr5a1K8XUSyNHC3aasJ1wVScMLrhKD/v348pT1?=
 =?us-ascii?Q?o4/sqNQsUdcWbARTz2F8i9OO66QbXZ8ilZsZXRKbkDRdDK3+cSDyQcWfPXDl?=
 =?us-ascii?Q?H74e0qm2V0p+iIwvlqTYprCyXZ1IYftfLfMASt45lbkK3ASzxhLlMi+P5F8m?=
 =?us-ascii?Q?Dh7wQrLQHAzrLSXy1FXlB1jeLllexG267Tp08kobydlYMbdPUgeIJTrwrobM?=
 =?us-ascii?Q?OQi1y1riL0DZsMXjpOptLklsebj2pAmrScwU9k2LsZwi0tC7efYl9NEKHWHg?=
 =?us-ascii?Q?5ocOmKgf5FWbuLIgNoHIGLOr/Pkc/lwg+vdm4f3SFioMYWgn0Pp3CKKMHSrx?=
 =?us-ascii?Q?/IA0vBocAogK88ozqzkfLLzaytiOB5AIxwS/OdcFr9nYTlxUe3TWqJ/RHfnP?=
 =?us-ascii?Q?+NL/HkHLOIQpZMf17SCHWrA6PcCDkRBOZzh/b2Tf4VKc/ZrdfwDwEA1Hgw6V?=
 =?us-ascii?Q?K5OB2coHasjPqsPOwPXrpFvUw92S2UocMKCZ4cQL15hsKS6NzTHpJ2dX0ZUg?=
 =?us-ascii?Q?h0YwDdqlzVCO6tHde77r+k2IuZJ7zX1NBV5u3L/A6q2j8qzpvmFRPD/hMoUt?=
 =?us-ascii?Q?S0VPm9a25O8XYbUXm4qMGu0uNRI6qJXcTTOZTEZcIysTKqKiwf41U58rSqxl?=
 =?us-ascii?Q?snQuLl23RXhW5iS/53pUVx+xOs5eYr/txHmO8VkITAdWrkCKHq12GQ/vk8U+?=
 =?us-ascii?Q?uX/Gl72x+XUPYc1ZVENWA7azd8Gv1b2Szu45ftKpvCUw2R5DFuH8Txflq3pu?=
 =?us-ascii?Q?ZpAVjLupl9RS6ebdL6ApdQE4CqbNihu9yXwxXhACu6uxXy1gzz/2qnERVqpF?=
 =?us-ascii?Q?Ux6qhXFZPoVh+ntSg+K57q8PYAYiY5GkO3xqnvnCQVKlXe1P7F2+1lpe+b6Z?=
 =?us-ascii?Q?HM6VlxpMmIGdZIH1niOwK8X4b8GNDuu2QFX99WY5Czp8JlRoAvfEo2aDsS+g?=
 =?us-ascii?Q?/yXYTUcQaiwgyaH5HULjp9SAbmPMPz3hqO8X5JOiViW0KiIrSCBrQEms3JUM?=
 =?us-ascii?Q?pCeyHRlv5TgqZowRRduJPZMy21XQ5b4G1Fdzrv2H2YoGWr5ghg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:26.0026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39018bed-ca04-4303-3915-08dd0078e8f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259

The profile handler will be used to notify the appropriate class
devices.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c       |  2 +-
 drivers/platform/x86/acer-wmi.c       |  2 +-
 drivers/platform/x86/asus-wmi.c       |  4 ++--
 drivers/platform/x86/ideapad-laptop.c |  2 +-
 drivers/platform/x86/thinkpad_acpi.c  | 14 +++++++-------
 include/linux/platform_profile.h      |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c24744da20916..927a2f7456c9a 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -128,7 +128,7 @@ static const struct attribute_group platform_profile_group = {
 	.attrs = platform_profile_attrs
 };
 
-void platform_profile_notify(void)
+void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	if (!cur_profile)
 		return;
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index b12965d9fcdb7..0018818258070 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1988,7 +1988,7 @@ static int acer_thermal_profile_change(void)
 		if (tp != ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO_WMI)
 			last_non_turbo_profile = tp;
 
-		platform_profile_notify();
+		platform_profile_notify(&platform_profile_handler);
 	}
 
 	return 0;
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0750e2fe65325..2a8d789ee05cf 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3754,7 +3754,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 	 * Ensure that platform_profile updates userspace with the change to ensure
 	 * that platform_profile and throttle_thermal_policy_mode are in sync.
 	 */
-	platform_profile_notify();
+	platform_profile_notify(&asus->platform_profile_handler);
 
 	return 0;
 }
@@ -3793,7 +3793,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	 * Ensure that platform_profile updates userspace with the change to ensure
 	 * that platform_profile and throttle_thermal_policy_mode are in sync.
 	 */
-	platform_profile_notify();
+	platform_profile_notify(&asus->platform_profile_handler);
 
 	return count;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 80797c6ae8b0b..79c65c24b433a 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1041,7 +1041,7 @@ static void dytc_profile_refresh(struct ideapad_private *priv)
 
 	if (profile != priv->dytc->current_profile) {
 		priv->dytc->current_profile = profile;
-		platform_profile_notify();
+		platform_profile_notify(&priv->dytc->pprof);
 	}
 }
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 13798c6d5fcf3..8539cac042be8 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10516,6 +10516,12 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 	return err;
 }
 
+static struct platform_profile_handler dytc_profile = {
+	.name = "thinkpad-acpi",
+	.profile_get = dytc_profile_get,
+	.profile_set = dytc_profile_set,
+};
+
 static void dytc_profile_refresh(void)
 {
 	enum platform_profile_option profile;
@@ -10544,16 +10550,10 @@ static void dytc_profile_refresh(void)
 	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
 	if (!err && profile != dytc_current_profile) {
 		dytc_current_profile = profile;
-		platform_profile_notify();
+		platform_profile_notify(&dytc_profile);
 	}
 }
 
-static struct platform_profile_handler dytc_profile = {
-	.name = "thinkpad-acpi",
-	.profile_get = dytc_profile_get,
-	.profile_set = dytc_profile_set,
-};
-
 static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 {
 	int err, output;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index bcaf3aa39160f..8ec0b8da56db5 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -39,6 +39,6 @@ struct platform_profile_handler {
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
-void platform_profile_notify(void);
+void platform_profile_notify(struct platform_profile_handler *pprof);
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.43.0


