Return-Path: <linux-acpi+bounces-9670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C69D2D80
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 19:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F36B32448
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE71D2B05;
	Tue, 19 Nov 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="khN3K3JO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BC1CF295;
	Tue, 19 Nov 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036875; cv=fail; b=opOtR5tAjI3bL5t88Rg3y47Tq2ivLPNITctEFTIhX49BusppU7E7Atbrd5PmMuJgUvPpYTkur5Nva5+ZTB+XL56kwkLzOPy6MJVDMDGi9nETVgDYOfIph2jLhr8lW52rhLEXD5ko2lR6fvtEXuyHX/CDxVueTGUYg5ixw9MzpT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036875; c=relaxed/simple;
	bh=JPe2DJsTvwK+BxZZsMEmNji+XZXD4uKA1ctPwvtUOf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya/winkQa577nSVTeMhGlLEoy32xi2nrXkLBYZw4o6aEyX5355c6qSd8UviXml88aJPXaLYGFbG4q0JtLnu7spvtI9PbS9nzL/tkdV2scfQTJzduWqt4w2yiFcxrQ0TVF6stKvx2EmRNqR1NE1BCUsxd+1nOyBZF/Ihp5NYx614=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=khN3K3JO; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocUyvG9b/mDzGCwEU1WnX5OnEO0UgknzSXw9QEKpkLV+MpagNytxa6C9QaxYKqm5GQpwCi4v0MEpm2xl5dS1hRkKtJZo6k9qcpq/P7KSlHDoBKGMasuUchxboaD5zNOHIGsHqaIJEMd+R67kA3DRcDzeZYtmCgDJ/0XryP2JcvMyyWVt6TW3WqS63MAWHaiwGsecCKosXS8cOqyYkjcfSyBfQ+xPTren64EyWvSjsVRzHTG74BYPS8IKQrB542aKXo4F9Z+0VxLfK8zYuz2MKR7jHeHIGzgRq4KwFSivfefxrQ5reeB7jV904hMm1lT9sz/VtszVC+9gwVTxlhhhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzCFVbPZgYxPcQ1+GhB7cobM6gVHm22OUaAGLwiiReU=;
 b=BkDAYvRiBY7JyUaIx60tIpmvv73epvM17nESHdmN57kjOqzV8itPO61ssRsCj+8Fiuqa1U6yfPrR64BcoZWpBFSIjL0i1DTdFmJuuHsJPsserp+0iexMIgUMoOzbQjo5k8eROL1QFLs470KX8mPRxPLJ2q4ipI+ima5JqaSFeFuXLQw7b17ZBZjMzju79Ww6HQp3Xap64+T3BEg5EBWVcSDAMXLLr38xkcvDBQ9zBdExxA7dCjAVDgdkcb1ktSLCvj/Jc9yOf8Bwd60OMtmPCR7o4Kshuf/thm+tHhy4T5yIHhrCCurXGveJTAZON1nw+pCScWRy4IoO06VmDer2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzCFVbPZgYxPcQ1+GhB7cobM6gVHm22OUaAGLwiiReU=;
 b=khN3K3JOkcDQMw58erNZm0NgzHVxfbIvtfp/q/3cRnPG4n5umGgUBf1BTMOrxZbmdpqaEBjv0ep8fhF6Ggkdu+oABGU3RzmW5QYwW1Ha0JgdKXUd0Q3OafckV6/Xzevf+PHmNZXCqk4do3qLPD/f/SUxQxYRDXJ1QigpY6UPIjQ=
Received: from PH7PR17CA0047.namprd17.prod.outlook.com (2603:10b6:510:323::29)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 17:21:10 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::27) by PH7PR17CA0047.outlook.office365.com
 (2603:10b6:510:323::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:04 -0600
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
Subject: [PATCH v7 05/22] ACPI: platform_profile: Pass the profile handler into platform_profile_notify()
Date: Tue, 19 Nov 2024 11:17:22 -0600
Message-ID: <20241119171739.77028-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: a5410d8f-e214-4d78-ea3f-08dd08be8f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1psSYPGuzdJ4PrkKJ70Ax5O5+o0HYtVVv7F1kuIsdm6C+vBAY/8FaVV/U0c?=
 =?us-ascii?Q?0wRGeAMNINJvuVSLIhHU/wDmrdktUa1TlN8a7Ij367tl0XIg9R/oBUPbH1HD?=
 =?us-ascii?Q?f9iVp2GOFxH2CqKzo/QvfkwbkyPMBDBPGA/hbvdQWWHamrSwQq1QXzLuX1qB?=
 =?us-ascii?Q?a/WxlZNBEHcsQn7jhiiW6UqJuoGP4LPDXh6dZPgBKKS99WsVXzvVts0m/NFN?=
 =?us-ascii?Q?3WMjFHFVidkpdYtu7qqnwIov//dCpSjHZD27IbjcTwMb59EpKcrWg2QyNf3D?=
 =?us-ascii?Q?NLMwIXDP/9mRLZC/CkgQ+mQ4hPF8gJHHPuPpz8fv2tD65XswujFLyRqOiACj?=
 =?us-ascii?Q?RT7gDR8JllO0nONKJV2mBPmJj4f5VlDHkb1W5R0oGJwXLFlmv5eGMAAC82Iq?=
 =?us-ascii?Q?rkmqbtRUVAxUHalJiX3oi8A4Fq7t/jBGm23uSYTKXOEdOPxaBl1/v2NT4kdr?=
 =?us-ascii?Q?mRPUqpgs3ahbdhL5Vx2LwuPGs+Cg757EYHSNoMtdJGJyhmxTQQ2lFyYoRggd?=
 =?us-ascii?Q?blBipjHly+XqxxpGXnLn0keMrTiWuuvyyAbGjbUwao1/kdqJyp25jucp08GS?=
 =?us-ascii?Q?E0glF5fhiWzZAprlrOyB3LEYHb4ZY7gEf3ItKBJbfEmKPhVVOCaBW4sFWAUh?=
 =?us-ascii?Q?9pZjMiORuLj+r6iuzF0njfW7qrfbw/PzWa8jXBwuHUyN4g2/HlKmgFSO2+PG?=
 =?us-ascii?Q?l5RgQgeFVtbqIJ6yYseSXSH+8jbg6NnYiAr0HOjSXBGhjJBUK/braxZ7IC9j?=
 =?us-ascii?Q?GRha4TYIklAhwLOviCe1+iEkY3dxXSxlyNnvBuW5nWkznRuZWCfmi6/5mfQd?=
 =?us-ascii?Q?XRNPGz2KeLCxQpOO5qshaub8kPdXttTw5WKgBBKcsqoI0n9jLR5VlejZ3L2c?=
 =?us-ascii?Q?mFFHXhFF0d2pYp93tj/LcY9IcOCssrM+fcgkSSRC4+S8tbPe+DnnP+95MNK6?=
 =?us-ascii?Q?gzOqHOs2irtLomvlr+9SMBxNyIBozfwPV1tXoXCnbv7S7K8NilDt1GT/VGUb?=
 =?us-ascii?Q?xW3OuHcm49U/dK9YXjsiATPoBXTLjuBtoJddsBHkOfnQN8a9/aNkFlVyDfJK?=
 =?us-ascii?Q?ppX25Eva8mLxNqvlFFCnUiFk/5KT0JkhLB+OycKjhDO3gaFSXOTHysYX61O8?=
 =?us-ascii?Q?7q9tXSiPc7KHvuJ5u6/p+rgrab6nANhA8muFC5xhAQjuYCZFV43Ea0FklEfV?=
 =?us-ascii?Q?4ZOSIBwZt3nsd5ASZeyIpTjQep0mGQO9UjvGF0fjXOI8dOwCQF1pQDPWCt1Q?=
 =?us-ascii?Q?effkN9faoxwNeSiEJR+JeLguWbXa3BncPC6bEhwo09xrcs1ksvqIxo2Nk+SH?=
 =?us-ascii?Q?sS94SENw+aC763etxnvAxBz2G+p+DNcNKho45DhGyuZ9hf4HVI0J2SU9gnwJ?=
 =?us-ascii?Q?2YKFwT8Q4nWoi23cC/Q3KNWhnvBYUZY+hL0xwYdUyS5kyAn33A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:09.3548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5410d8f-e214-4d78-ea3f-08dd08be8f47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

The profile handler will be used to notify the appropriate class
devices.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Rebase on pdx86/for-next for asus-wmi change
 * Add Armin's tag
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
index 9105b456eab1f..dcda7420ca26c 100644
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


