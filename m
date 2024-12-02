Return-Path: <linux-acpi+bounces-9850-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0519DFA54
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F271B22183
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5361F943D;
	Mon,  2 Dec 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r9tq7M6E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BE1F941C;
	Mon,  2 Dec 2024 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118702; cv=fail; b=mf2nLxy5SXbakmZimNiQUWK+3QgN50kVlHWPjLqeF/aXmFrid4f/QEZjqO4HPeZTQjEeoYOTtZIfhk0s+2W77OR0w45F9ZwkMcwuuoC384tiTCmzur35NzdKgIVddRAeY83nMHm4t2Uw4OXzIxENj8WyOdEJJVTo74OF5mH8ohI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118702; c=relaxed/simple;
	bh=2sGp8nsceMSqqbGFXAGu40PROo274ncRCGZ1RbgNNlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4sWLmcvk3EXuor0ZEw2y7b5GnLsUAlu+DRlZjeCdZywYP4VBl8dvlGWFfYY2T1SUOFaWwKbI1V/etf3eyjqM2sZ2hf1ryE97CbEEtwnagxEsuViK2JrFqkpQJCeBM8+i9ISlm/aIplzcaZqi2Kdo3u2oXjbREOjQqQsX/Foj0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r9tq7M6E; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1cOKteqJnGzTkvgiw75orWMkDcmZRZJbxI4E0jxxVXnNELIbLt7O5I08KM/dr4xfu0U8NbkADfAnJ1d/vDOiqyaAUbS7WWH80RBnkkkq0vpGoa68r2binkzvze/IagbCXPfBDOlWYV3RSYcM32Ej27eGP0Wh/UXcMza8abTc1HYOyYJhXizkZ5Vc2BBlbAHp6mJJf9l359Qbmtl0v5zfKV94IQhqHNiG5XFO8x4EeDf8srIs6xn/DEGb0zdMiZO8OFyNYwsGFQ1AjisLf4HeiseArymVv+UCMubA9okktSI1tQP3DO9AATFPU0TQ0GmBXZExeNU4o8FQPyuEll7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtJpblUh8MBOEucV5B3TNCycXxWvmJz0+rzIT5JUVPU=;
 b=C9gHq9hTouKJXXBfHlk0trxQRfQEhc1uOXC4fnZFEh2Y7xKFz2lc9Y8X3wsWFYujO6HIbpBjeEnr0pccvxk9F6azYSXBNdtfTcxkDjHnVhEFSwgGMGnpCA/Fj+pDiL17nY5Qji+lVcW3CDMaWnAnypFG9jz4VppcF+UslpA1c16BaAB20yRd6deKG8NkMlqzUUGfuAOyUDFQMBf1rpHdmgtHP9W9RISfffmFjJ49gZ/h2oIzEcKE2gCUvMjED2VSkj6RXDh+roMkNn+x0a6XR5DsVXvOB+IVVJeJgOXyByXsrlKMO2EPiucNX+zp+IzDmCwi3eJnPrDv1NoR9dtiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtJpblUh8MBOEucV5B3TNCycXxWvmJz0+rzIT5JUVPU=;
 b=r9tq7M6Exfz4KRUxDsZyw8Y4P3eolhrWcusd0tsuGM8XIIwQRp5b7uZHrpl4r4pPsicHkuCT95fKFzHi+OydIG+hz+4Yi8ZSJYmRVPBktlclF8W5y1J2sdssyI+8+1Hb6wy8scFUfKhi1EbcBPdQX6Y15zA7HU317o3LU8JwSZk=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:51:36 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::27) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 05:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:33 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v9 05/22] ACPI: platform_profile: Pass the profile handler into platform_profile_notify()
Date: Sun, 1 Dec 2024 23:50:14 -0600
Message-ID: <20241202055031.8038-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 1745921c-4dc3-423a-0cbc-08dd129561ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GsAQucWpkXDk52kISSgOLFeTyYZ6PZDojdMgmRG72XHsz+CeaGbCn3GRjwUm?=
 =?us-ascii?Q?XeNqsXbBUKz7nmh3dUWpR/fEzvaAmJ4UGfI5niXwSrEutxe3tfxubj4W+vby?=
 =?us-ascii?Q?qdpvcxBPdkyXlxpMjZ9eLuka6Scuaa/oNXRo3u6L4vMWnspVZYR70yJ1v329?=
 =?us-ascii?Q?GUrmeFAPR+GznRFJ7xz81qXhXUyIk4aWpZBhrgesV/Gao/r37/ijUNDAQ7vG?=
 =?us-ascii?Q?YlsPR4LLj7ynG45iSxM2wHYAGsT88ssFR5XxdpKIM48DO3d/bmbypUNxmtz9?=
 =?us-ascii?Q?WzE5TIfKa5ArYZ3vZkkA/KMorS+2sGy3IG0QUMyEFHcXVCot9eyXiEGxBJ7u?=
 =?us-ascii?Q?zOY/M8na48X3vTy4qv9rK4MPZ7VNsYIfHjVKbfdOgeqHPHY0bYtDBlbVz84X?=
 =?us-ascii?Q?Zmw2aPcStcDRmeFZz3YzkF+d7DZF92k0KBcGjF4Ih4sIvlk7Z+ejg3FFBaAD?=
 =?us-ascii?Q?NRM9yGOlzeyreWuph9sPl3S6LOwf2oYf9tpXFXVfub7NRTillLGHdW1uSW39?=
 =?us-ascii?Q?LD+EAqfxD5Ozc1V9xAB2owvfGHay0vUTmiAgfNJPNEVEFWU8lCfAx16IG1ZD?=
 =?us-ascii?Q?n4nA3/flxxjPtj6su/c4KC1f5t4IvYoEfO8ewJg6IW9xphNOOwL6VzBxe/Os?=
 =?us-ascii?Q?MVmMenYgQA/lFb5F8NpiNgmZjHe0Mp6oyKS4d2MR9ANJR7TYn0trC/NWJkYS?=
 =?us-ascii?Q?9sAStzKkZlPjL6i1HeZvJGCDibrNIHxmo1TGz/udlJhEpu2uJc7+jjiJCSAp?=
 =?us-ascii?Q?GD86yoJw8TRpwTTrsUy56K/h9LyUk+YyRFxt0UE9Mc1o5bYrrJ3HEUEuAycu?=
 =?us-ascii?Q?4UKzydPcEbTS2Fcq58bC17+RPXh8JQPHyRZjxhUip7j6ydeV+C+eCkzVYNc8?=
 =?us-ascii?Q?dZMXDhnSaS94dp+hSpYvnm0yQVF/kpq5thTP3GVA+P9IhT6V0OFwYUQkR56I?=
 =?us-ascii?Q?bFLxu+zmv4p4NKjP2N6O2x3XkmEMj9eJd4iSh0xrADOkBcaOzQzrtKXdP0Dw?=
 =?us-ascii?Q?DOCp7PzqiipACeef+vCCLAkvp7pMGpp9EoYp1LriIrAl9qeKenPscN8NgrAk?=
 =?us-ascii?Q?PofIMgBJTEC+wKsjc/jsl2DaXUoQx6f5IYIhLHGb6f4vOKuBJ1XDi2D63Ms7?=
 =?us-ascii?Q?kqYyJku+VC9/TVabMNMon+Fw90VrKgc326e68rWqeS++SBEjSCOHDaysrwm9?=
 =?us-ascii?Q?S2fWAppU2JzhaiVWjM1+hM2dAiGZk8Vc5UZrZ4OGL02PEcbMSs8oO9As8KBJ?=
 =?us-ascii?Q?FPvEWJ8LKozcKqjf/Bpd6JyUx70VT1BsHzAdf8qGOuNLYbqiEiyR+wQ1d3dh?=
 =?us-ascii?Q?sWVTRbN9ddFPo6qow+huUlEyPkrgRserMsV7g6axzfB2WRx/kAPytA+7Rkzd?=
 =?us-ascii?Q?MwAFKj0fKakcjTQjqZus9vwrsbuHz+N38+S1sUGL8vCnIX/ISCexcLxJXB12?=
 =?us-ascii?Q?Kms1I3ho7/BvliS66bFTUv5DHDdVo96n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:35.4550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1745921c-4dc3-423a-0cbc-08dd129561ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830

The profile handler will be used to notify the appropriate class
devices.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c       |  2 +-
 drivers/platform/x86/acer-wmi.c       |  2 +-
 drivers/platform/x86/asus-wmi.c       |  2 +-
 drivers/platform/x86/ideapad-laptop.c |  2 +-
 drivers/platform/x86/thinkpad_acpi.c  | 14 +++++++-------
 include/linux/platform_profile.h      |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

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
index 805bce80beef2..fdeebab96fc00 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3789,7 +3789,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	 * Ensure that platform_profile updates userspace with the change to ensure
 	 * that platform_profile and throttle_thermal_policy_mode are in sync.
 	 */
-	platform_profile_notify();
+	platform_profile_notify(&asus->platform_profile_handler);
 
 	return count;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 95b66ac3ea1d6..00b9c0c32239c 100644
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
index 298100d5c535c..f516628617384 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10538,6 +10538,12 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
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
@@ -10566,16 +10572,10 @@ static void dytc_profile_refresh(void)
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


