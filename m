Return-Path: <linux-acpi+bounces-9303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 242B69BD07E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85AC1B2303A
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF6165F1E;
	Tue,  5 Nov 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I3BSPjCc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DA7346D;
	Tue,  5 Nov 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820824; cv=fail; b=udpt4MiDg50q9RylHAYyufo6jfW1sbNK8NSjGs8NbTs348ejwn6M22I1ZMNZdYAlJuk2JL1KtMI4vtaXaq5iQyAX2JFeyBy4YKafGzZJky0LbX0AdXyOi+jUyopUnjkGGCWfHIKSpiozBhlLaub7gBcjXWM5IfLnKo4stJFQpKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820824; c=relaxed/simple;
	bh=xE8tgTFhgfeuOgCsUZhC1WiaGITJjtf48n9pdqNlCns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qb3iL9FaPXPfQ4jC8eg7XwhlVFrloXq8XXLeicc05kB/8MR36nicKflcXoT7HN97oCmR039rgDkIZbinBznHViYxyHxsjUCP/c4Iod11JRWXqrJ//S/Ave8obAOt5hElyJZpvRXPp+DaBewVJPo5cM2TqlN87ARrCC/KmZvaJS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I3BSPjCc; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbJ/Oj84acB7SjgYeFKlO8rWu/DAGuxvfJ1GUdBf9A1G+xpbyWFhiFAvCrIGA3DYWglb8O3v14zLTo0jRrQEXcO4/y+CHW72I3sKCfLk0aOxtltZT93r+tsx5UXQNL2Px04R/0qkdwkDG8nbXDWqo8tA4m3wy+Eeo+TCW8ApzeSe4Unu3NiRQfDXmsVm+kjDRPsi649sGTbOnWANgbKw16sEJ8vIPUv835S20+Uz7QRA8vADhBKz8yzwVKx+M5ITW1jeiCQX6K/afk6Y2QJr9ZkRn7Bo/6Y/nQ3x1VpTafBSL4nwG5KESvVqxL1fqXmV45VJnqmcW9sUtArgOC/BSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpP+8+J+86qUK9POCB3KSfm3Zjzt6p92edc6CL2tMVE=;
 b=N4c7Gu4Nfu2ReE1kIpJehcy3HMgIMRwb6ThlgLsy3YRhhUVdOqTR1Rw5eJMTlY5szf162KXq/CGC23zq3/+xDjgeQa5y1/nUhYksJ9jyZrmfXUEzZwerouhLAb2TVPtgbyMB+jie1M+nrXJysUEbs6qPdLOZA3TYWMIF6++dCQNYu3+R5cF6KhHQqKlAtkBfuzBC+scYxU9QiAHuj+bWDM2NYfRxb8mKUJ22h3bngM2Sma6OImZ1gx2XOusjaidUi0HrVySCv5VNZWEF8lU0BVOl3jkRWM8h8bxjmvUW498DlygGIiiU5N+ybJ92E5FuZJkFktVikYh8gS5Bt8zYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpP+8+J+86qUK9POCB3KSfm3Zjzt6p92edc6CL2tMVE=;
 b=I3BSPjCcjAcZc+eSXYPJkARwTfGuFLEtIBx6QdbzzWdTc4jjZWgqfQEPrS5zyJStcPcEU2x4Ex1PMSxkNZjs6IjvDwev/dAIk/EqZjlVQrKawi3e7PkOrR4YsxQs1HJFmDO0mR8LNItiztdmq2lWMkg233akDb3TLR61393GOo0=
Received: from MN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:52d::22)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.29; Tue, 5 Nov 2024 15:33:36 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::40) by MN0PR04CA0008.outlook.office365.com
 (2603:10b6:208:52d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:32 -0600
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
Subject: [PATCH v4 04/20] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Tue, 5 Nov 2024 09:33:00 -0600
Message-ID: <20241105153316.378-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: cce979da-cd70-45f5-c49c-08dcfdaf3720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnhtY3R6RTF0ODhZNEdkcEdaZzNpNmlZUXAwT2FaNWZ1czMrWU1pY0FZMmpo?=
 =?utf-8?B?bmVoeUN6dW5HMHFoYWs5bDV5NFhvOFVNYzFzSEtYZUJ1R1NRaEQvWEFBMUxh?=
 =?utf-8?B?cjFMY09TU1FkZW4yYS9OUmhXS3AxOGhjbmxYdXl6WjZLVnhqZndWT2tXNGtm?=
 =?utf-8?B?ZCtCeEVpWGhGWTFmVktXSytCYm5Td21PWndaMXlJSW5EMncwN1RGb1VVKzhj?=
 =?utf-8?B?Vi92ZlRHTW4zQjRPWkJMYVFLZWs4ZTFxTzR5cCtwZm9CM2RMR0dWOXJQQkdm?=
 =?utf-8?B?NG53bnNMa1h1WUZMUE9DRDB1MkVjRjRiRG1lclBmWmVzZE56NTBYMlhSd2xS?=
 =?utf-8?B?VmtUc1JYcGp5ZTJMUmdQQ1F3NDRUU3ZSOW43b2RwSlV5em02a1dEdnBvSFJZ?=
 =?utf-8?B?bW83S0VudjJDN29KZ3kvVGdkVkUzeWdEYjU0UWJuSnh2SXkyc0ZRYnFybWVY?=
 =?utf-8?B?dWNEeWVFcjAvK09RbXlQQkU1V0hndTM5VWxBci9TWE1HTUlvZ29Tb2lieElS?=
 =?utf-8?B?d0Irc202UlJsUGtjNFBwU21IYnFIWUIyUzJPYXJ0dno4R1lUUVZ0aXRwQVJn?=
 =?utf-8?B?QmFVR3h6WkRhUjQxOURqam5KeGQ2YWJkdWhOZXA2eFBHUVlaNzA5cjJ3WUZT?=
 =?utf-8?B?UmJoby96VkZxa3p3bGtWbnBKQVd6ZWdsWktuZ2c5UkJNM1k2RFVoNG5pSnQz?=
 =?utf-8?B?Q3NnMWtNWWpJUDluSkNZY002NHJBZ1QzSmVXeS9vN1YxWXdVMHRSdk9XN1VP?=
 =?utf-8?B?VXF6T3pMZ0piK3dXSlJoYmhzTCtaMkdjaHhEays3S0VUeGt2UnZGTmt6SW9Y?=
 =?utf-8?B?S0J0Ui8vc1E0eWc0eTNZUllMMlJkVHdLd2V3ZkxyVnhlV1RkQnNzL0cvZGxY?=
 =?utf-8?B?NW9FSjNnejB3cDBWSnY0cS9PZmZBU0hjUysvYWo3VEJBUWlDNEdaR1dnZENw?=
 =?utf-8?B?djdDMDFKNVhTeXhUVHFld2lVSlVOZW50eHBHY0g1YlFxRUlJWUlhZ0YyOEQ0?=
 =?utf-8?B?bXUxQmZ3NTdNN0kzakpGakVXUjJJUHVvVlRKNjRobWphRkQvd3RocUJIQW40?=
 =?utf-8?B?THlKN2pkWm53S0p6NlR1MFAxN1ZTZGo2bDhLYWRveENkWnFWL0JpMzVoQXJu?=
 =?utf-8?B?WWVXVFoyektJRHhzYnJNOW5ucEhYbVZ4TWpHRytZeE02bHl5Ly8vaGlqVHB4?=
 =?utf-8?B?d2ZzUzJWeEsrdzkzeWo3c2FTeG02QXdwUEZTU20zRmhZK0g4d3orMXpMV3ZJ?=
 =?utf-8?B?QnVlclpXTElpNVFvWnFRVmZTbTRSYkNDaFM1YlQveCsrejMxQWNBMWFabzBl?=
 =?utf-8?B?ZTkycjV1R0hiYmtXQVNKSHRPK3BqRlBHT21vR0ZTZGFLMi9nN1NMYTU4ZExG?=
 =?utf-8?B?RjRBN3BSVHhTOE1uZGxWWVNLVlN4R1NKcCtiOE94UWcwNUtOVmFOc1B6OFpt?=
 =?utf-8?B?c3J6bklMa01oV1VLQ0hJWGVKRTNrMGxNQUFrbzNIcWdraStWZDZhUThyUkhV?=
 =?utf-8?B?YnEyeHRmaG1aYUFFMjVDcnNLOStkRDc4eWQxU1VrZzdLRkdxdkk5TUlKUUpJ?=
 =?utf-8?B?QUJSYXB6Rmp6VCtFbGoyczZZRXhTZklsb3RiVXpuc1kycDhiMFdqSnFaTHMx?=
 =?utf-8?B?OEYrWDdnUlRzeFgwOTdGOXlaSUlXeUVOcnZGU2xjQXhPaS96bFQzbmxlVDhO?=
 =?utf-8?B?c2hjeDdJTkp6c0xlSk9DQzVXTE9BZ0pIejF0dkFWSWFta1JzYnBlMVpRcWUy?=
 =?utf-8?B?NEJEall1VDYzV3NkMDVVWUZwQ0g5MThReFEvYmlFNEZhSHJ4M083ejh0VmJM?=
 =?utf-8?B?MWtiMzBDZFJhOXIwRTAwbmY2ZDJMRjB2aDRCUTNJQ0VXRSt0MFpKKzBiUUp6?=
 =?utf-8?B?dXc0OFI5MjE2bFJZUWw2dHNZaGNMZDlHLytBaFByRmJDbWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:36.5141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce979da-cd70-45f5-c49c-08dcfdaf3720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

To allow registering and unregistering multiple platform handlers calls
to platform_profile_remove() will need to know which handler is to be
removed.  Add an argument for this.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * Add alienware-wmi too
---
 drivers/acpi/platform_profile.c                     | 2 +-
 drivers/platform/surface/surface_platform_profile.c | 6 +++++-
 drivers/platform/x86/acer-wmi.c                     | 4 ++--
 drivers/platform/x86/amd/pmf/sps.c                  | 2 +-
 drivers/platform/x86/asus-wmi.c                     | 4 ++--
 drivers/platform/x86/dell/alienware-wmi.c           | 2 +-
 drivers/platform/x86/dell/dell-pc.c                 | 2 +-
 drivers/platform/x86/hp/hp-wmi.c                    | 2 +-
 drivers/platform/x86/ideapad-laptop.c               | 2 +-
 drivers/platform/x86/inspur_platform_profile.c      | 5 ++++-
 drivers/platform/x86/thinkpad_acpi.c                | 2 +-
 include/linux/platform_profile.h                    | 2 +-
 12 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 5d9f3f7ba71c5..c76b8e3fdcde6 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -210,7 +210,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
-int platform_profile_remove(void)
+int platform_profile_remove(struct platform_profile_handler *pprof)
 {
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 5f45f8e8cd69b..b449c4c8b883c 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 		return -ENOMEM;
 
 	tpd->sdev = sdev;
+	ssam_device_set_drvdata(sdev, tpd);
 
 	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.dev = &sdev->dev;
@@ -228,7 +229,10 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
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
index aca4a5746bee1..b12965d9fcdb7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2547,7 +2547,7 @@ static int acer_platform_probe(struct platform_device *device)
 
 error_hwmon:
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2570,7 +2570,7 @@ static void acer_platform_remove(struct platform_device *device)
 	acer_rfkill_exit();
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 1b94af7c0e0c4..bd2bd6cfc39a0 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -426,5 +426,5 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 
 void amd_pmf_deinit_sps(struct amd_pmf_dev *dev)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dev->pprof);
 }
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 78621b2af0ddb..0750e2fe65325 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4886,7 +4886,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4913,7 +4913,7 @@ static void asus_wmi_remove(struct platform_device *device)
 	asus_wmi_battery_exit(asus);
 
 	if (asus->platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&asus->platform_profile_handler);
 
 	kfree(asus);
 }
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index c03b1aa7dfb5f..3cf6c371d4220 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1065,7 +1065,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
 static void remove_thermal_profile(void)
 {
 	if (quirks->thermal)
-		platform_profile_remove();
+		platform_profile_remove(&pp_handler);
 }
 
 static int __init alienware_wmi_init(void)
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 730f97aab70cd..65989af2e4196 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -292,7 +292,7 @@ static int thermal_init(void)
 static void thermal_cleanup(void)
 {
 	if (thermal_handler)
-		platform_profile_remove();
+		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index ffb09799142bc..6d6e13a0c6e2d 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1693,7 +1693,7 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 	}
 
 	if (platform_profile_support)
-		platform_profile_remove();
+		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 24367c3590c99..80797c6ae8b0b 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1136,7 +1136,7 @@ static void ideapad_dytc_profile_exit(struct ideapad_private *priv)
 	if (!priv->dytc)
 		return;
 
-	platform_profile_remove();
+	platform_profile_remove(&priv->dytc->pprof);
 	mutex_destroy(&priv->dytc->mutex);
 	kfree(priv->dytc);
 
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 5a53949bbbf5f..53af73a7fbf7b 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -191,7 +191,10 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 
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
index 222fba97d79a7..13798c6d5fcf3 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10638,7 +10638,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 
 static void dytc_profile_exit(void)
 {
-	platform_profile_remove();
+	platform_profile_remove(&dytc_profile);
 }
 
 static struct ibm_struct  dytc_profile_driver_data = {
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index daec6b9bad81f..bcaf3aa39160f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -37,7 +37,7 @@ struct platform_profile_handler {
 };
 
 int platform_profile_register(struct platform_profile_handler *pprof);
-int platform_profile_remove(void);
+int platform_profile_remove(struct platform_profile_handler *pprof);
 int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
-- 
2.43.0


