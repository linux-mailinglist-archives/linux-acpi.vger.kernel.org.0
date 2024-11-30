Return-Path: <linux-acpi+bounces-9805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7749DF0B9
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4754816363A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731271A0AE9;
	Sat, 30 Nov 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lbsb78tD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2BE19F485;
	Sat, 30 Nov 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975537; cv=fail; b=NG9oabXopOrTltJLVjZ2zm8Z9PzivKaEtEOw5LxfleUwcAtPGLuZY8YIg6X8Q6xB9zGWaMuLWJEAJemY9KGaD7DDpU6JTsGJa9VuZaX2jeWjjoF5vq1vDws7qOuzBM2Qdstiyk6dTzy+YO7feGhOlFH7B8O792IxGrrJloo23jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975537; c=relaxed/simple;
	bh=2sGp8nsceMSqqbGFXAGu40PROo274ncRCGZ1RbgNNlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQt+hK8KpFFcbapDiR0NKVjfZ6lMEndorT5PrumQbjJ3ugGMpsuxfnxNmNXhGLGrvZxOFggCSPlZ4iSi0Ml53lLQC5DUKzYa18F7AYmW5wES2KbxSIJe8lFcySxu8JoIy4s6ymCOiSQoH102qZKsHnpLqwLgTunqrilsyCCPrA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lbsb78tD; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BH90ucLw02Oe+2A5031CbqXpFMixSTaHfdBDmqt4cEhIi6OcDEDgtYAPIcTYeL5He570PlLTFWykzOKRm2kGz7F06ljPPNh12Xeobbx7VvBIXMyhoToz2GUxIshPOkCS3zp/rqjhlM/I1QOdicsotMHcnn58bfQIwX6Z9ZHE3+KvOSgyJ3uqAjYAdwyrtSKNeySHZv5FJO8zADn5FnZtmLsXA4inT2x7OuJaN2B0+aYES/CpLR/asEhL5obM7v74zCJU88U5v277uR6yOlGQpBqQWiHhh2eFb6clpnmMm1Q+bDP0VijtB8QdRndOHOFkCK3gt9OhZWTbDNcNLp3oXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtJpblUh8MBOEucV5B3TNCycXxWvmJz0+rzIT5JUVPU=;
 b=L69tq9mHLT0lMQk6UrUfxjMKZlBFcls99rQZug8nBdIKldvOLBBbRx/sHGBQpxWCtkMicvH/UK+yMHvlJium2anOb9aMffy7IeKDNXfR8dDUq82Q8F39TBXj80Duy7Eo9XO8Wf4A/h0eGDOS18xSAVuL64h3kS6MiQGBx+4tIaPHiZ3rd46tY0HbyhmoDaTJlB8dXzNG+LKO9U0dwzxjIjsyG45O/hgsklDnAHYwIhznQ+EWOwyxlSXZpYq0Go8hIQneuQcUAvgCH20eNMU2cBt/rO99a5JcyF6sZ0EqdHLTj43a6V9D2dSLWxsQkiaSZ2+t8DJSHhSZrnFX+wr9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtJpblUh8MBOEucV5B3TNCycXxWvmJz0+rzIT5JUVPU=;
 b=Lbsb78tDIhFYQK5l9RYqSVHIiSC3Bp1N8uIFvm0dMyPAo7pfJBekyhqaUkUsCuRIbOoMb9k49m4wCN8WjACZIGhxwKHMQm3dcyjlJFGBRYfo1BOBeSZfKzNNVfwYomi1YkmDnEbvDDeYsIIECGhOVHv01uOFq6CPIFS/dgQ5WAA=
Received: from PH8PR05CA0004.namprd05.prod.outlook.com (2603:10b6:510:2cc::23)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Sat, 30 Nov
 2024 14:05:31 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::cf) by PH8PR05CA0004.outlook.office365.com
 (2603:10b6:510:2cc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.6 via Frontend Transport; Sat,
 30 Nov 2024 14:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:26 -0600
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
Subject: [PATCH v8 05/22] ACPI: platform_profile: Pass the profile handler into platform_profile_notify()
Date: Sat, 30 Nov 2024 08:04:37 -0600
Message-ID: <20241130140454.455-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 660205db-bc76-450c-1edf-08dd11480d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h0oKNY1hbV3amxPzNPW9nuxWpUglr3/qeY6nPsZEEa7UDR7cR36vz98O21i7?=
 =?us-ascii?Q?HNJQy4PTPw7vuRsGp/9u/pglG6qQTRD5vJkzr9hwBHuO19Gt0d+sjxBZYKWk?=
 =?us-ascii?Q?dt53DEoa0MsHaMsoNrj76Gg2O5UGr67tql0eAA9czIDNWn5+yOhtZh3CHVOh?=
 =?us-ascii?Q?A9O9XCzJ6s/R8SrjAv8yAnXT2WvNg38tkx4Bafd0wgb3qUH72R//aO4TUGft?=
 =?us-ascii?Q?vyJ28JVZ6/ZsdmFvg6kEm47BToI+7nFINdkS4/s8B9l0oaGnf7mVrDm1n+NV?=
 =?us-ascii?Q?tifN3mSvmu5D3dtDjTkM6+nYarLL2InPvbvdHjmnc2KvE1CKm1zH2iRrGMxl?=
 =?us-ascii?Q?1/vL8ef521eYPO+jE87FMEKY9KMDUdNwyw6b2szk9EcQlzeef87l64xpcZz0?=
 =?us-ascii?Q?wcX4h+XVVYAG4ir73cjW23DTGedAXxdWnp70LupHHDcdtW+INk3ewD/Po3tG?=
 =?us-ascii?Q?kJDPkJWwXEKUCvlGfnZk2vNLCtOJeR295UPy201jKgfJYLtu1PRG2B8Tpj5r?=
 =?us-ascii?Q?qFQ0WetlLQOE157ynOw2jDvK0Wc3IxtrUFYtQaIEIeU9MWu3gr2Zx/tdqkm1?=
 =?us-ascii?Q?IhcvSLTyquPQco3INy6aJFLKQxYMbMgLS8RPiDRD/p2aMfNRbHp1kr8NQoRm?=
 =?us-ascii?Q?qAU5ggUTGfDUm/fhJEkrPFSWfBhSgwbPtM0jPTpwHYHyyS2iEdVyKcOQ9t/1?=
 =?us-ascii?Q?Zdv2IPFxy5U9itIQWUq10rlXqiAyRIuQjKPxDkN429n/0E3L+D2O2og5w5cj?=
 =?us-ascii?Q?EWQGM+T9nRW9Ah5cDq6aeyTDRe+UfAK4MRZLLuWIuyzFN9g/vdBU+RmXSC5j?=
 =?us-ascii?Q?BNJkGV+AeCMqE/X0g8vSJGVyHBOsFg5u3nQ3yQS/xtFE8mpdqYHzYLrR9xoS?=
 =?us-ascii?Q?R1IvNDi90DzVJxBXBelYFgyZtm9aTlsntQ5TXNP8VEAX4rGC4sxb7WVwh39n?=
 =?us-ascii?Q?xqigq7ugJO7nqylx9URDxLenPlcG6Ep8z8Yvv4Y2HXYlkDBDAmt1bIpVCf6A?=
 =?us-ascii?Q?ksX9su9DuvgRdgz1oNKnHb7DUW9mq5MgWqL7FkSwPz0z+y+RJOUL/PfNlbwm?=
 =?us-ascii?Q?NYtwYXQFkstbdJ9fJcffY8gGNSGHTHDmC+HvC0fQ4wcaQgJLfmxnx73FsgA+?=
 =?us-ascii?Q?ANT7K0tOUedB6ClO0WL715/TIT7OnweswdIb8P47d2Q0flMW/YrxSzJjmf8l?=
 =?us-ascii?Q?9sEPerAHfBxm5EaaKIHsj/Sd4x0/5OVOIFaK2nkJPZl6YtdgzWXfh0sXAgn9?=
 =?us-ascii?Q?mp5perfyXJWfXgvQYuZWUthOx8KtOfnE9FBD0Tr8240/fvuO4EqBZhCelTiF?=
 =?us-ascii?Q?nusQkj3PV+QxY5sZZ/wjIfceCB8YOpYuo6YooUmvPh8SA1F02pgmDIsm/vwT?=
 =?us-ascii?Q?58HYQ/9IEdShSdCJZhxLtMxzajTHggtLyvMzFpfE/RTCBkQTlH0loWWIKra5?=
 =?us-ascii?Q?5m58582M+ZqxK3rqS81KrJ94/csDSPvt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:31.0351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660205db-bc76-450c-1edf-08dd11480d21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

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


