Return-Path: <linux-acpi+bounces-9017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DAB9B2230
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BFC281D9D
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380418858E;
	Mon, 28 Oct 2024 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2oHv2Arn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2D155312;
	Mon, 28 Oct 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080932; cv=fail; b=FhTqYql5i7I0Z7mPVYrYIKHF7E/5uMESU8v6tijdIm7BGpSjh/J8wjY8DGWfcU0TYX4KwwpB/4OoFUQEzc/+qFrROhFP4E1NQBlrl5uNxLngO8U6k/igIOxNe6u1jejMNGysOcbSKY1SPUZG3sYDwGRkC2IS9xD41JIAMa8CG/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080932; c=relaxed/simple;
	bh=OoN3eZlkyfm6Mz9FzMTcdXwyJfv+MypM39VX7yFnSao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+LTS1wQlFcvVoxc5feQN5kGq7YWHu0wyUHQWa+5IplzCOdIdQ+GK/4VRfeKGWr0XO69Z2uvPX7ViM6DmnF2wWXlTC650G+uIE1wgUsyEnSiWr8Gv7CGlklz0mYWNYn02flKjbuDHMOSqv8n3kFGVZ9buHnlAGxh+mN9cjFCxFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2oHv2Arn; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg3vjtEGPATcOjtCeFYNpyLSZaBD90TZSOHB8vIUlacX6oPgxk8/boNBnie9188SBlKAdM4UKaB2JyiI1qfuygu1yMGd+beyoQlm56uPlpe9dsw6SngzILAsvfrfnxLmPS5nDt22jJEsS27kazbwUWSlISpxuy5OltqHMDInFRxmPk+SyzNocGX0svcHXNCG8NQPPP2uErDiqD7zW/nIjLMZFKj+VtDY20u1YUn0l2K+rBIyob59mh82CWYmAYIN4E9tOkhgOsD+YLMmyFTytwuZlhNdpuytXRe9SppmZw9OXYXVByLZbPAta/PryarJ2i4LgSMkpv4IyyI25Zi7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYlgHKWAOl+hz7FzS0RcOZOUWbEVRZznOwckRkpt9+k=;
 b=MAIuji8XJPQNHYMAwDCPB3TxyBzOnCh/H+pq1AcaAQkHaYkoOogeM5DRYF3Baiz7AZSxySwc5O6UBZRDCxrhEPqEYWRnscsr3Ns8RUjofKs8tCFaqNtfOWRmAP67KTFMYnp6lNFo6BXn2ax6sS+LWdlN/FdPidWhPVBbrePgItRMQ8NlYU3Wp97NJGX1S56KChwQOTdMqrU0SW9IVD5vy0iEGd3sGof5ai3WRDnw1HXzn3/mnwD5LrLDaDdvsdsrtuhxRMNoFEuOp3fyOiMwGwDj1Ho7seZw+Fi7uQHnYgr5qz072rxL/7ctbSnqFE3H7OEuEUNODEd+RAEtbw2paQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYlgHKWAOl+hz7FzS0RcOZOUWbEVRZznOwckRkpt9+k=;
 b=2oHv2Arnn1DOOBy9db90A2bKYKDeWeoCVrSiMcV5r5S5CyYovc40Rmo0T9yN7UOxzgIJVR96zdOWholdrIatCZzhr0fuKQm86lbAAzD6gWLMVJ5FXAu2w0n+arkAx0zMEEXRypczSpMpnekhJkfTyi0ZOgacbisthd/Tz9y5M6E=
Received: from BN8PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:60::14)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 02:02:02 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::b) by BN8PR12CA0001.outlook.office365.com
 (2603:10b6:408:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:01:59 -0500
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
Subject: [PATCH v2 03/15] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Sun, 27 Oct 2024 21:01:19 -0500
Message-ID: <20241028020131.8031-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020131.8031-1-mario.limonciello@amd.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: e1104ca1-c746-4da8-9374-08dcf6f4840a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TVUDrWURJigaqhCpwizrjpWU4K8r2L/rtlrMOu7QUQ7mgKkMH9D52VrDNvRx?=
 =?us-ascii?Q?c4crGC6m+wYFllVwtsgODFRWIG8u4Jv2qDpqsa85NZ7VvbbetKtQ1gkwmjz1?=
 =?us-ascii?Q?V5wyNn4ArGdRQIGJeIg5gZT85SkEwQtwdO0RD8ue1iD/9mYyDpCAr4ZmxLRQ?=
 =?us-ascii?Q?89nUqT5OlX+Py/ETmiXM+K5QgoKvUFC50j5O1j3Tu3BIb9nc620oWsdfSEqB?=
 =?us-ascii?Q?Nm9cbwtGAGAJ8LCjpBuBxG27mNkKwQef4ty9SwGeIChrqKKWK4zxXlCehSy3?=
 =?us-ascii?Q?wEorHLm0DdYgajd7rJvp+/6jccpImz/h+6aCgdBN/zaoszNz4May9kHGjr52?=
 =?us-ascii?Q?0T11SyjPe/3iwJTp0hjWs69rkAsoqkOQodvlA90g0XiGiwzdZGyYV29Mi7Xe?=
 =?us-ascii?Q?kh8TNNRGbNhQ44gnq5ex8HYHJXmB03Z9za2k3jd//pxvlZYrIbKgaVlT9WJi?=
 =?us-ascii?Q?Ll+8/DzehpWu4yPTQqcgoBzY114UbB1yrzZeDNihqELlnhihWvF08YIQJ76o?=
 =?us-ascii?Q?3upfTSFSm22csk2gLpwxoD4et+7db4gkzq9251DH8zWO7NZMFtQ+0P7G/2/e?=
 =?us-ascii?Q?pWOdZt1TEloZZRJNsTFbvL/WdhoUH13iiUIaMCH0nnBLj1iYolbh2E0/ij6F?=
 =?us-ascii?Q?QZLXO+45WBzgql4wR4ZY1aHAmPQDETDZdfPqUI6szXueRfmMlIj8R3JYVaXi?=
 =?us-ascii?Q?0s+d6PTIdjXSMhD/LzKNNc40eloJ7KIB8XzcpzI0JPty/ZNAX3c8Fynv6AXF?=
 =?us-ascii?Q?GLbSr0ri9P8VIyEL8mp9Yo+jcvZijea7GOGh3xCOh45elGyWMbFRFCIr5lhh?=
 =?us-ascii?Q?UDKES5/SyOOzLr0vuOTPNvdU+H1hnlCVvl0gLFZCFwE0+kBTp8NUAWbL0Re7?=
 =?us-ascii?Q?D5FFoLOcjseS7M7JZGBX1v1XUNO4SwbUJK+TZb6Xi4pLMs8CF6Dg7tfJYqGW?=
 =?us-ascii?Q?8Iq/dW2ehGT6NtCEMNbPorzwbB4lvjBlx0S63BYR79ta+6CvvMffh7JsrOvI?=
 =?us-ascii?Q?AoLDPXZUIt1741hCKElccc5WfIMRGGMDO1PwNKfKUojVfQFksq/0mc/3CLLB?=
 =?us-ascii?Q?HkICBy1eDwI66Sb0L/iB2vVypOI10l9ypUpdClqRe4A1Lx72qD6eumZAg09L?=
 =?us-ascii?Q?d+nXs4ywP9nsD5+7XBCfEcRBjGtkvsYW5CApSTlH3z/TEp9CZv9+gl+bZcPa?=
 =?us-ascii?Q?Rt6BmAvysDoi7NRITBW4iIsg8ndSeiaLfJpFXULDWFeq4jyrwseoBdeqZcJW?=
 =?us-ascii?Q?qgX9bDDP67U9pLIE8WCAFXnAy4hh5nrL/sekKSh5/mtWg26Un94xkMj0qGmV?=
 =?us-ascii?Q?mddO4QCfjKCnyTFhBCvYutXVhGBya0r1dWj4cTb3/+L6W8W/a4AoyUCPhxvc?=
 =?us-ascii?Q?8T9uLd86RfSbRjiKKGx699LZ8XO9IfNOvgoO1VsAur8dS5icRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:02.6881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1104ca1-c746-4da8-9374-08dcf6f4840a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

To allow registering and unregistering multiple platform handlers calls
to platform_profile_remove() will need to know which handler is to be
removed.  Add an argument for this.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use ssam_device_get_drvdata() for surface
---
 drivers/acpi/platform_profile.c                     | 2 +-
 drivers/platform/surface/surface_platform_profile.c | 5 ++++-
 drivers/platform/x86/acer-wmi.c                     | 4 ++--
 drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
 drivers/platform/x86/asus-wmi.c                     | 4 ++--
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 2 +-
 drivers/platform/x86/inspur_platform_profile.c      | 5 ++++-
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 2 +-
 11 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a13..c24744da20916 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -205,7 +205,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
-int platform_profile_remove(void)
+int platform_profile_remove(struct platform_profile_handler *pprof)
 {
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index a18eb93eebb92..1c9e37b1f4761 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -228,7 +228,10 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 static void surface_platform_profile_remove(struct ssam_device *sdev)
 {
-	platform_profile_remove();
+	struct ssam_platform_profile_device *tpd;
+
+	tpd = ssam_device_get_drvdata(sdev);
+	platform_profile_remove(&tpd->handler);
 }
 
 static const struct ssam_device_id ssam_platform_profile_match[] = {
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 53fbc9b4d3df7..71761d4220c26 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2546,7 +2546,7 @@ static int acer_platform_probe(struct platform_device *device)
 
 error_hwmon:
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2569,7 +2569,7 @@ static void acer_platform_remove(struct platform_device *device)
 	acer_rfkill_exit();
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e2d0cc92c4396..cfa88c0c9e594 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -425,5 +425,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 
 void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dev->pprof);
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c7c104c65a85a..f5f8cda7fd19c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4885,7 +4885,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4912,7 +4912,7 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_wmi_battery_exit(asus);
 
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..4196154cc37d9 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -273,7 +273,7 @@ static int thermal_init(void)
 static void thermal_cleanup(void)
 {
 	if (thermal_handler) {
-		platform_profile_remove();
+		platform_profile_remove(thermal_handler);
 		kfree(thermal_handler);
 	}
 }
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 26cac73caf2b9..bb8771d8b5cd8 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1692,7 +1692,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 	}
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1f94c14c3b832..50819ac919e87 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1135,7 +1135,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
 	if (!priv->dytc)
 		return;
 
-	platform_profile_remove();
+	platform_profile_remove(&priv->dytc->pprof);
 	mutex_destroy(&priv->dytc->mutex);
 	kfree(priv->dytc);
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 03da2c8cf6789..d8fd59b826f3a 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -190,7 +190,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
 static void inspur_wmi_remove(struct wmi_device *wdev)
 {
-	platform_profile_remove();
+	struct inspur_wmi_priv *priv;
+
+	priv = dev_get_drvdata(&wdev->dev);
+	platform_profile_remove(&priv->handler);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c8c316b8507a5..619a4db74e5f3 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10637,7 +10637,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 static void dytc_profile_exit(void)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dytc_profile);
 }
 
 static struct ibm_struct  dytc_profile_driver_data = {
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6fa988e417428..58279b76d740e 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -36,7 +36,7 @@ struct platform_profile_handler {
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-int platform_profile_remove(void);
+int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
-- 
2.43.0


