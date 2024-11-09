Return-Path: <linux-acpi+bounces-9465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F187B9C29EE
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21EC284651
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063341487C0;
	Sat,  9 Nov 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AiV7k/0Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAD1465B1;
	Sat,  9 Nov 2024 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127354; cv=fail; b=X4T76IREFbayxlqkTBf8hbt7/ZlVl0B3yIo2Vis0IQuH8F7J1XqQV+XW+94Bhx8J8kZh8AytGPP3lCJgCz85ZgL6676mxePO7rz3ZkFoYLyXGCMiAjUuTygkj/v8l87peYEFUlPQBN/T4P1CFhNBnZ0iBNaOJUYRtTfFasjZe7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127354; c=relaxed/simple;
	bh=AkmQ0mQfkawEwQ8/KAwjZJ+3v6g6OEDKZT+xC0UovgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JB+VaB5SGS6HiD2NjeE1JJL4Jin/q32gTsokhM4MK26D/vNyV+5ert0gPPhHMJiaDloaoep4qm52JBPkdMHyNtLQq2QBF0/wKbxUJFQc+CBdUkYT+m3SSPPaDEB0Cv51e+Cmev/es5wAAOwlGfmocC9WQMs3LhOdCRpDPI/RRDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AiV7k/0Z; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFUgFvXzs7YKy8iNEGZUPUD01+yLftee+A93nA/Vpot6nwuzHuA7x6CyDgQ8L9dK7TC+8LIculdyZRRnYQXfZ9WHIkn7L/oqODidtaZ/zGumlhv/KFjDCjKEZ2UX5y0nGcwdLnSsCyuU5Ponn1p0Dc1C5JhflvVq6RFrtO4FrW4EIfXn5r/ULWGyCdo75/CGywgDlOEnkjyhg23xJDS/pPRQvgy5kBcOni5rLr5Pktrwp79zD5z5fsUDDWklYEeU15UP4F+NOvlqVBN7TOueGChYhGfIQJRyCrjpq8Jx+LxeUvq/CdXDRmAa2teY1+i5N0N/XoVwEm+v8w6jUyhm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjz/+hRXrRT1TN+GmPsK+9EeUP5afNROOS/roqGFiJQ=;
 b=cCgqzH3dUlZjNYKxzpfMuIhJGOCICST95IWeFoBIfxRxE86inSmTLOmjrMDnnmVyK4c9KWVOsgZ0qS2ymltnxI/K543m7c4GXbmApojBaJbP5O7GLX9L/dofahGD0jhFkCToG/xJ9Yvt16js+q/DUEQgCNzR+/fZZvFc5JqNS07+nnz181+hayzWWu3X8d2V2llGSqEjuXe2GhIlz4e7t/JAho+ONY+CORFS2pOdS6JlbVslwdjEw/GSaCUzWPVysn3TR0BSYsSuiwvx0Cbj5FO0oz0E47/eFrImbyifAWbsWBSTU2ry4l3khe/TykG0YzuUa9XE5S1g8deVIf9Bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjz/+hRXrRT1TN+GmPsK+9EeUP5afNROOS/roqGFiJQ=;
 b=AiV7k/0Z283eaal0DhXTI91ltOT2YQsrhhKI7Nen3wCeIElsEf4MrAU0ahb7fZ+nqeIjB/1MpP2nX4a9njKE8TbqNoVgTp+jXjtFh81BdCCOIfgo5x87cqL5CzraEP35/+xAA5s9anckeKqmWl+07dcOGZqOVKjMBNM+UzC2uoc=
Received: from SN6PR04CA0096.namprd04.prod.outlook.com (2603:10b6:805:f2::37)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:24 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::7f) by SN6PR04CA0096.outlook.office365.com
 (2603:10b6:805:f2::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:22 -0600
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
Subject: [PATCH v6 04/22] ACPI: platform_profile: Add platform handler argument to platform_profile_remove()
Date: Fri, 8 Nov 2024 22:41:33 -0600
Message-ID: <20241109044151.29804-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: a1aae2bd-216f-4dfb-3c2f-08dd0078e7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vng4NDlPZlg5ek0rVzQ5S0F1VkIyME9KdDJxdDVId1p0Skd0TVNMYUVqL1ZH?=
 =?utf-8?B?Z3BiVXV0ZEhuN2cxQXdERndZMEhzQUM4TjUxVGk5K1YxVlpTNnNMV3NhUU5z?=
 =?utf-8?B?RnUyYUhIREZEb1g0TFQ5SDR1dUNDMlBveWxiZzZ0Y2QxVXJ3RFVVWGZtdVRH?=
 =?utf-8?B?c1lWMzJldVN0SEhMUUlVTjBFWklVVUNSVmZTOGViNXdpU3NsZ3JQeXMxRWhl?=
 =?utf-8?B?Y2Z1cGpHU2o4aGFpSTl3NkdZOEhjbjRTeThnTTRhWUUrcnlubWJybnM4cFRl?=
 =?utf-8?B?S2ZBajY4SjlYVG1nR2hNQllRam5tZWU0VnZNNU9LZTVreUhvUVdHNzA5L0V3?=
 =?utf-8?B?WDVYMlppbDdjSkVsT05hd2RKSGQ5U2NHQitTWk10U1YxTVZqYnZmWUtnQ2lI?=
 =?utf-8?B?K0ZlcDZTRWF4Q2grUjRuUC9ZSmlBREkzM21pZ0VXcTJUODJIYTFsQUVyUTBv?=
 =?utf-8?B?ZEFuS2JEQ2dyQk4vRno5MmdsUmpsUFBsYUgwaGRlK3VpOERtQkhEdGNJM2sr?=
 =?utf-8?B?M2M1Q0lHUkN1WXQxWWFHZzRNUDdRd2ViMXdRb3pVd2NWdVdFNmNacGsreUVh?=
 =?utf-8?B?YmRjMWZOeUFYejJQeXNnVnUzQWswbFBLckN5RUlqRTVNYnFXMktCejkrZklv?=
 =?utf-8?B?cWFQTENUY1dxWHJYZ1NCYk1Ucys5TDluZEFDN0FJUzZ3eFNWNEVwVGFUZUNR?=
 =?utf-8?B?bjdaSUZ2NVJlc2sxOFpWcHU1MkZlQmdFK3dOaUkwc0w1VGMvQnV5a3ovakhD?=
 =?utf-8?B?TDFWRXIwbnlJL05jNUxxaXBiWUlGWk1lV2FUV2VESEZBY2Q0NzR3WmpSeXVj?=
 =?utf-8?B?SG9GTkxhWCs2YzYzQytOcGIwRC83aUlhMHVVdEt4b29FTmlOM0tKT2VGNllB?=
 =?utf-8?B?cUxHQTE4MDMvK2k4NXRiUGhGSnJnYjh2VStrQjkybWFBd1RBUjJJVnhjUWc1?=
 =?utf-8?B?RG8yOHAra0trZHlWU09VOGdod2h0TzNENWpaRnB3cStVUnZ5cEZDc3pYZm5Y?=
 =?utf-8?B?ZmlJOWZWbFA4U0k5MmpFOFFROVFrem1mbkVaTDZDTk5WUEROZldYNXgvNVFG?=
 =?utf-8?B?SDd3RkJlTXI2eStRRU1wQmJaVDdoSy9zVFg4QXkyNTFUd2dvckVMVXZpZkVV?=
 =?utf-8?B?UkEwT3IreDBpKzBDVldPeGx0Z0JmcXkxVzEyOUJpZE9oTUpNbzhYYjZ4WXhs?=
 =?utf-8?B?eDU5TVN3eWNzS3pmeUZYbDJxdXlCNVdtNHkrZWtaOTFTZWdJakN3NjVha2Zx?=
 =?utf-8?B?YVNHVmVSQjFVbXdLT2kwZlZNTkZWSVNEZkUwYUViVFN5T2Zyd1drT2hxSDRM?=
 =?utf-8?B?bnFYTldMaDYzS2E2bGl1eXFvOXM5WTVXcEtTT1lXVU1abVVOeHpLaVUvU1ZF?=
 =?utf-8?B?enJCeHNBem1qVnVOejVnZHU2VGQ1MjZaNEVncDFPaWxIN0hhZXIzS1lDQ2pX?=
 =?utf-8?B?TWVhN3B5TlVlTTl2Y2FqckxNTnJRSUV3dTRKTWxhWUpaZS9PZ0xEL0t2MnZX?=
 =?utf-8?B?U2VmNTE3VHNLaE9Jd241OEt5aDU2NFArYUVEaFZsUm41QmlOSllpV2VVOHRS?=
 =?utf-8?B?eGxBRDVlN1EyOG51R04xWG9QNzUvRmNiRVZVWDN0T0s3RHpKL2FxVlFlUEZh?=
 =?utf-8?B?TjF1WTh3UjRHQzZ1NVF5ZWtOL1Q4QmZadUt3L3ppRlFzbkorQktCcGxNcHBK?=
 =?utf-8?B?U3U4cW1QVXlKWVVBQ1FIaUZPRDd3ZUxtZmlVQUkvVW1sSGZlbGVTSHBUSFVP?=
 =?utf-8?B?MDFMWnIzdVQ5N3BFcGpCYndzZ0U5UjlOQ2dlOUFYa1BkYThUcXk0Q2pHUWU5?=
 =?utf-8?B?cXZaRzJwckJNYTBGRGw1ZS8wcGIwOXRDWDNNb0RxSUVlSHUvdUtwSWF6YVo2?=
 =?utf-8?B?TGlWSE9Uei9maVo5OWd6ZlBvMTBIWE4yUFdCeTdzQm0rMWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:24.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aae2bd-216f-4dfb-3c2f-08dd0078e7f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932

To allow registering and unregistering multiple platform handlers calls
to platform_profile_remove() will need to know which handler is to be
removed.  Add an argument for this.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
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
index e5724e76a2082..5c4d48e4b667a 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -289,7 +289,7 @@ static int thermal_init(void)
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


