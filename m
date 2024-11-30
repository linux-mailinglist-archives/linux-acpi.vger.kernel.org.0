Return-Path: <linux-acpi+bounces-9820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942F9DF0E6
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6282819A2
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558031BC068;
	Sat, 30 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ncOK61T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E01B6D15;
	Sat, 30 Nov 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975572; cv=fail; b=m60865CFmSZO8cN2guAVhvj67wyIzI5WemrdWWeySaKHzaRGDJftwEHMD/9T7ar1XumN6GBFtEh61h3CuxnP06apVp0Ogc0KJFJvk0EztKGMXm4sMBIqOHta7IUX1kZEJwvRFeZvx7lMdD5TF8vHluEKAu57oyep3pbiBH55fRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975572; c=relaxed/simple;
	bh=Ic1kSez1p5RhlfYjfiCieTuIGQgUojglIYTT9+//idM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6eCD1+blAWUNPgXJYIr3vpg4fSTpcTOezReFWraRnZxUY9H7W8/IepwxL+6S782oYMwprc9TCCSIarWr3o6c+vKX19VQqO8xtfiCkeedKlpqnWQn4gZh6Zv5lzfSrvV25ywKR9pkGO2Lsn05sDWbAxTgSnTKLEwu3V7ZBVEt+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ncOK61T; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuXH4GQuBkKa3Yb8imCx6gTMChCpWedGENR7zRvYtNFobNaCMv3Kyan/kTdYbS63rlxcmHfA1ym9s1el61vjfsL51NKJjkA1z1rS0ZoVP39NQNy0jdKolD1Hgu5X2jfV9Sb+C++aBqBEaucA3W9JWBALI298pSSWpI3S17vVMwUADzUQ+s/rEQbf1W9OK/eAWLGXXd0/7ZQifhMI7ZJ4EDkh88bQPpXONr9Dr/Klb9zBZ3z3L1pbF6hvXHPKKb2X7pQmUyEurmpCcVGPTpA0QqBbPjhWYZR3QDTlnSc4zh5sUSqt1NI0/ugm4Lgo8zA9qMdx67CR3oDkoQn+uEmOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZygNqvmrqxLlOcz7KlrmxmajDRP0uJQIhejUlstLa6Q=;
 b=SaxaFMRsutsULt8cSrOMNAGYeWOdQwRRx5srwwakwGyb8JdWnhVTO67HtcXdILl4czBmGho4LHYzw9vc813KNIWm+0pPsqo5K02VI9ZAzt5DW1i0ncJj6jl48/dj0tgeWctAMD/uNg0GO5glQf3DZT8A+ymn3O2EbPyN9TqbGrSxtstdK/h/5M4KrCL3R8P7QVitPCjO7DdbJ2/FRMqvSyRrMENPmOHavdt3kI4TOKCUxhF+lm1Ug4JiwExAIDvbm12RDo/linMtbBBBKWJrlXHx8/km7lR0pcGjHGci98VsCendfm/vakN9AGIbsj5ZTsq90H8QgZSHUQ/Mgey2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZygNqvmrqxLlOcz7KlrmxmajDRP0uJQIhejUlstLa6Q=;
 b=5ncOK61T3hkLdtVSip+a98tvF5mYwOV/+LGMQy6e9Y98EJXLvuhEOfA+xOdftJkVdKtskYFrpb9wSjL+QZaj8FnnsPd1T09czitHd8yv8caXvxP5N3tZWbv/rW+P0H9MVyRcOUjwN+A3D0By2JL+Le7TQoLjeiCyV+7G8HvVA1s=
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:06:05 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::8d) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:06:05 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:06:00 -0600
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
Subject: [PATCH v8 20/22] ACPI: platform_profile: Allow multiple handlers
Date: Sat, 30 Nov 2024 08:04:52 -0600
Message-ID: <20241130140454.455-21-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: afc79dcc-a784-45c6-efeb-08dd114821a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wae5UrM21SFa6n2lCVqf4OZ5K0wfO6pnOVyHvjb7ttq35uI9ykTsW9JpAxpx?=
 =?us-ascii?Q?bJL/kOXwTHzz1GCLpDqIfIpHblWNkVC8XbabcyqL0tX0leSad9SOz2lM/ISY?=
 =?us-ascii?Q?EL/efaMRhCB+CYaHCLIAR0VH1We9FjKSx64DLthqb9eMtl/ZqV8fjpBLLX7o?=
 =?us-ascii?Q?DSptX8kNynaG4rCerOfFjdkkb9y14BbTvax11zRI4bedWlQsRd3zfiBweVTZ?=
 =?us-ascii?Q?C/AfdiEb2yQ9AQxZ7dVdgrZnlJJUXy1QBsq6WcX+s0zBKMmhGEmkQCVYozlF?=
 =?us-ascii?Q?QTORbN0rSrAD48LEMSnFSa9PPlYSUU899GXcKWmJFTdEwEb+6sRlM4dEBPUr?=
 =?us-ascii?Q?6FTQ9qLJraPnW0/vV9HpABTsvaWNlMtTkvO9SMQgSTLDu5CuVNS8kr2MKPvj?=
 =?us-ascii?Q?WfRDii1zlZe6n7I/Ub4nlclI5tbZujeBYY+hDHuAIyTnIiBtRPTwWhq6811V?=
 =?us-ascii?Q?qJDalBTQPbqXwIvVzTll9ljvhzWxswFb7RNocIwzhvRHs47W1n/7pvyb7zWL?=
 =?us-ascii?Q?rtGCSRosDB4jslXNm/PNACgYteqVVR7V/1oCgtXi3Hxamevjv8zpCSnVzube?=
 =?us-ascii?Q?hbpUdxR38+VfIepQsFJGxKPP18H7G+10nMZAevFnfRxw/tJb4iLD1lxSLlEY?=
 =?us-ascii?Q?kkDGRcEeAZx4z1M0WSRCqcSv7DryA0TlNTG0qq1V5RxKPBVlIfJqwTeGtZAe?=
 =?us-ascii?Q?LlOpZ1CuUEnZgGfhuBathhIG3TAddruttMetcG9JaR/n+6LfEjnix8JGAaTy?=
 =?us-ascii?Q?dYROG7i2ZnPLqUpAM81oMdUn1Ogo+kvLE4BrgEdbIyuR7YZw9EJWD53x7GDK?=
 =?us-ascii?Q?ImYWyA7gWd5Btdl/Lf5GCh++KfYMifHSn4oQORaCekIpFDy1GufbqBVzrIkr?=
 =?us-ascii?Q?zN+4sAZAXgq1OSpKmlKrFTo23NlUrvpN89zk3XojIJYya6ikNzwU8tERBpE0?=
 =?us-ascii?Q?TyvM7umJUBtmwKowLcwJ46A9y1WIS9aRaLJMJBQgUwFWRGVo97aVocGsrGDE?=
 =?us-ascii?Q?MfjiuF5Tm1naGxi974ikATt19cKdX6tjhCP6agU0piao+qCb2akMoTG2J51H?=
 =?us-ascii?Q?Om14H0AeeyPxIukRWbRzz8mnFbOUn1xTEcG9503YwnUJGoCCsVl+drQh5Pv4?=
 =?us-ascii?Q?6DqV9ctPCLbf+iCDK/Sv67vbNTXDxuSesftE6bHymrNGTo2Sg22NIaQL0iRZ?=
 =?us-ascii?Q?XZLrDnwe1cOgRxamQmDm8xcvGwlw2mS6Q426XYvd/Xw2fWG7O3k3/Xm29Iw7?=
 =?us-ascii?Q?44kMvOvLkyBR0XRZdJ75r3JYMQgnb4fzKaJOkJTnYbS38RqF9+eXPgd0rL3u?=
 =?us-ascii?Q?oXW7As71vtb0bS7fxS4t6bkspoixV2BnRD8BObfhhzcq/f5WK8orp5NHApDS?=
 =?us-ascii?Q?9wetBhKmeesTexvENsgrvMGQVnw8Kr2vAglGa8QLE4L376mJjm5r4FwXcMHD?=
 =?us-ascii?Q?IWmR//uxz7MgCIyDE0CWk3/KGQgM2fzg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:06:05.4534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc79dcc-a784-45c6-efeb-08dd114821a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

Multiple drivers may attempt to register platform profile handlers,
but only one may be registered and the behavior is non-deterministic
for which one wins.  It's mostly controlled by probing order.

This can be problematic if one driver changes CPU settings and another
driver notifies the EC for changing fan curves.

Modify the ACPI platform profile handler to let multiple drivers
register platform profile handlers and abstract this detail from userspace.

To avoid undefined behaviors only offer profiles that are commonly
advertised across multiple handlers.

If any problems occur when changing profiles for any driver, then the
drivers that were already changed remain changed and the legacy sysfs
handler will report 'custom'.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 289b5d43638ae..2e38aa410b3ad 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,7 +10,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -399,8 +398,6 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
 {
-	if (!cur_profile)
-		return;
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
 		_notify_class_profile(pprof->class_dev, NULL);
 	}
@@ -463,9 +460,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	/* create class interface for individual handler */
 	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -481,8 +475,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
-
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
 	if (err)
 		goto cleanup_cur;
@@ -490,7 +482,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	cur_profile = NULL;
 	device_unregister(pprof->class_dev);
 
 cleanup_ida:
@@ -505,8 +496,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	int id;
 	guard(mutex)(&profile_lock);
 
-	cur_profile = NULL;
-
 	id = pprof->minor;
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
-- 
2.43.0


