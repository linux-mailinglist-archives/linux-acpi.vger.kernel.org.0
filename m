Return-Path: <linux-acpi+bounces-8998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 206499B0F12
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D7B263E7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB122161E4;
	Fri, 25 Oct 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nc0rtOoI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3921443D;
	Fri, 25 Oct 2024 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884694; cv=fail; b=ErcsRxr7+3PKbq4D1X/Dp6IFxHGOf9xTGo1Y7lLtvfaSfEPtDH3ELnff6MX4CJjCPGmg/YrCxa8PE2wTFE5WXhlKldWjlVuI9BeyImZZTPrJ+OgbJfClVH95kiDeYuE/7FUfqRxu2LeM5dRKMnAxGX5X/MI8eYtWjySuHMPmfYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884694; c=relaxed/simple;
	bh=wusaujXCnZwPF/O4STiRL9V+S66uhGOqJ4ezGxrisgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSvWBUFT05z5aoxTh59GOE8s8bkBMA5EV+ZRzX4GV2N1EBNPJKjyIfWZmX9nerDSDMIjew2HyIDf1FsOru4XyGO8LHkaEYV5ta31DvLKrOqHMOLdz6PJm/3mIRgnuWBnAlnqSgWk6LswxTf6Mh5T/2pA2EB+0g/BU7f4Yw15uWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nc0rtOoI; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNpuHvK508pBaBDEalgvXqIoEr+7ZCV+OQu80aUBrFHP1H449pM6C2olMwyNCrjDOVb0t4O6mbAG7L/tVhA3TAdYCni4Q25A8YQT/X3cufKjZGG0ov4XZEwOLBxs0iTYUXWQj1aZfcklH2oiw+QSbeK9EISg0A3GXthP/i6OkJ2a6rYyJDdlSNsyco3kczA1PdnAuq5kCTGRvXNbN18Bm8qvnZ/6QV7b4QcT2tTFGamGyOuiDGzGbfrjiGzeg1UarnRQ3gIOMQm/d+/wx0I3xs1fR2dxhQ5j/eGACPm5invP+C6NrL28tdPw+NC300OP0d4oTtv4Jj6jiEYeiLWfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKiQvmoZtD8CSvVYQIfxEjMiSDJjjVblJNgXAD+Fd1s=;
 b=BrhKNwBAt/lc8vp46f3QiTwFEIplBEu921F2VrO0ffxcEqBi0wp+OAcm4dvW8yyuqQK4sZ+GfUwWiNcgQdyrsW3xWaxMZku3qgZmiHj4cFrUewQzDYrfxttE54Tra9PjLCN1xZHDls92cUzqLIlBSVfgVxneFeWwfALcNDTv5jO9lVPHjWxL1iRU61DyqY4AnsNv2Mgy89XG3t9we3T8ZlyQTl8IWjIAbM43qju+jewOxX33/oKWJpYgYmuE2nLf4ft2sQ+D1arCe2NcKqtWd5jqYbfGVs0/PQBx2w2LW6CDZDBosh+5iJF+HlOpYExeI2ze6XHc7HXXPNnJ2V/B4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKiQvmoZtD8CSvVYQIfxEjMiSDJjjVblJNgXAD+Fd1s=;
 b=Nc0rtOoIPoGerZrtOdEUtRieyRE7vROV7200f49JI2OlnOT6qy4VkQ+2PpRzD53Qv5AKlBqh2KvYArHBKr513kOQHQ/sPgRs+4eoJJ3fBNsenaZxM41dzgh9kCG2gj1MUr07gtJnaBRz8e4pXCNpwbGtva/5VNchs7bayemBZYI=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 19:31:28 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::e7) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:27 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:24 -0500
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
Subject: [PATCH 7/8] ACPI: platform_profile: Add support for multiple handlers
Date: Fri, 25 Oct 2024 14:30:54 -0500
Message-ID: <20241025193055.2235-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025193055.2235-1-mario.limonciello@amd.com>
References: <20241025193055.2235-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7c0259-3995-4fa2-d020-08dcf52b9ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRo7iDhYkeFv/Z9mOomfQLeeg3o9sfS/DBoE5HS210kpkZoewUrXkr/3mve5?=
 =?us-ascii?Q?R/WBKE65c9ye8Vt4yieU4ESPGmzMNkxEAGhh3LXSQBNknql1Mrb6QcmTShQ0?=
 =?us-ascii?Q?fgoBrAgibEOTaTq6VCnhVIc/9kVb1LA1qrSLAzkSC1EyJ+3JPZtVYZJVaJEC?=
 =?us-ascii?Q?TkaSaFOtvStfsVNt7hwOxVTX2wbDaY3pqOM86JWQ4I8TxFnmj5ICvbihh8U7?=
 =?us-ascii?Q?i5FrcekvlXu4BoTGs3N2T1mq6EAtga1EtfwagGI+9WUTnRQTthzmSNl2x/ZW?=
 =?us-ascii?Q?aPYBGly4RacGkXT6koyjCtHS+lKpNetcJH9qZcWxExYqQ1TMZDBuxl0NpBBt?=
 =?us-ascii?Q?fYrZI3aWUHTlaGhe69YH9nMDaEZupevPZFEt7x1fh+NXNT1LR8+oo4omtm4B?=
 =?us-ascii?Q?ntgs0olWBACoIVHmHVmjdHL9fSrVWI7r3t/bGIOEulj+bnJN9vDvIq+S4+b9?=
 =?us-ascii?Q?Oy7SC4Cs+AgX8n/9YkVfDYzQgnS97A2poTc/mihRaUNV0PzQRNJL95SenqK2?=
 =?us-ascii?Q?Efr/oGEsrbqXVzwC1wEnFV5gh/qFGjRxMD3tefULRzGCbeyOXS8cE2l872Uv?=
 =?us-ascii?Q?th3IQIm6Z+7coPmK2CN3JdkU7a7Kl26ufrcufDlVSkNyQ/5fSeHii7z9Ol8a?=
 =?us-ascii?Q?X+Y80H9pk87hvBsH2EigUef03OGKogoo1KgDUggos1X3kr6ld1AnnO+737Z5?=
 =?us-ascii?Q?GPqUa+zv4btIFvr73hl7H6ocTYiVN5bShLHJEwJYpj5qOQifR9nYYUop7cDM?=
 =?us-ascii?Q?yyzX8BXOh747DAzEAfA8uZiJoGKfaK8jpo1dYM4zNdKahDEWsOGhk9o1pTr+?=
 =?us-ascii?Q?XlAMnA6LsqXnrBot0ymGDyAUDn9ZPHuH4OS4X/gv1pscp2Ya5eop/O2VXH3t?=
 =?us-ascii?Q?2g60872m9qW+IXaGSwr1XwmR52K879XRU0IZkSl6qXbaQzRWYaMdsXoRBC6o?=
 =?us-ascii?Q?e5JQ0Xwm9RoZxmhWJNh+LKyk8IcDCIrrNOi/OjyWQIzPYxtrJvNJS5gVcScC?=
 =?us-ascii?Q?2+MI7D08rk6yZR+zQXgL6C+CGlzCOogjSwef/A5hJrHQLxgsyp02N7ie2aEr?=
 =?us-ascii?Q?UPuYsqOG+5D8CYedcklEN67+k5bwLBOnl2grHgWlCrbQP8Ckrw6wwNtjTViG?=
 =?us-ascii?Q?aYnKx5W0kgmk24Mj4gez/xwW4AARE3BVBuRlYXjGHwm1c49o0XhwnJCWVP63?=
 =?us-ascii?Q?HnvcMMgxNes6lFBAGHEZ3MSgJ6ojBt2//DMJI5r2VFhTCDVME6FeOyPuzi4G?=
 =?us-ascii?Q?sBvYX+YCnSueJ5ZQpHAvQsC5a+At1WWYX4zyQggstMbXn1waOFiXjPXS07hJ?=
 =?us-ascii?Q?X/OPG35+lNZeeiKKxmF/WUvq8ERPIU2uo9k3m53qhN8bgbNoXTcA3nmA3Lwq?=
 =?us-ascii?Q?2dIP/3d6vQBA/qpIqy59Opvz/L5YQV9oCR1GZLNPPpmPMrgquw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:27.6616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7c0259-3995-4fa2-d020-08dcf52b9ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694

Multiple drivers may attempt to register platform profile handlers,
but only one may be registered and the behavior is non-deterministic
for which one wins.  It's mostly controlled by probing order.

This can be problematic if one driver changes CPU settings and another
driver notifies the EC for changing fan curves.

Modify the ACPI platform profile handler to let multiple drivers
register platform profile handlers and abstract this detail from userspace.

From userspace perspective the user will see profiles available across
both drivers.  However to avoid chaos only allow changing to profiles
that are common in both drivers.

If any problems occur when changing profiles for any driver, then revert
back to the previous profile.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 203 ++++++++++++++++++--------------
 1 file changed, 117 insertions(+), 86 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 091ca6941a925..915e3c49f0b5f 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -9,7 +9,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static LIST_HEAD(platform_profile_handler_list);
 static DEFINE_MUTEX(profile_lock);
 
@@ -36,26 +35,26 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
+	struct platform_profile_handler *handler;
+	unsigned long seen = 0;
 	int len = 0;
-	int err, i;
-
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
+	int i;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST) {
+				if (seen & BIT(i))
+					continue;
+				if (len == 0)
+					len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+				else
+					len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+				seen |= BIT(i);
+			}
+		}
 	}
 
-	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-		if (len == 0)
-			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-		else
-			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
-	}
 	len += sysfs_emit_at(buf, len, "\n");
-	mutex_unlock(&profile_lock);
 	return len;
 }
 
@@ -64,22 +63,20 @@ static ssize_t platform_profile_show(struct device *dev,
 					char *buf)
 {
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
+	struct platform_profile_handler *handler;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!platform_profile_is_registered())
+			return -ENODEV;
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			err = handler->profile_get(handler, &profile);
+			if (err)
+				return err;
+		}
 	}
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
-
 	/* Check that profile is valid index */
 	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
 		return -EIO;
@@ -91,37 +88,48 @@ static ssize_t platform_profile_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
+	struct platform_profile_handler *handler;
+	enum platform_profile_option profile;
 	int err, i;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
-
 	/* Scan for a matching profile */
 	i = sysfs_match_string(profile_names, buf);
 	if (i < 0) {
-		mutex_unlock(&profile_lock);
 		return -EINVAL;
 	}
 
-	/* Check that platform supports this profile choice */
-	if (!test_bit(i, cur_profile->choices)) {
-		mutex_unlock(&profile_lock);
-		return -EOPNOTSUPP;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!platform_profile_is_registered())
+			return -ENODEV;
+
+		/* Check that all handlers support this profile choice */
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			if (!test_bit(i, handler->choices))
+				return -EOPNOTSUPP;
+
+			/* save the profile so that it can be reverted if necessary */
+			err = handler->profile_get(handler, &profile);
+			if (err)
+				return err;
+		}
+
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			err = handler->profile_set(handler, i);
+			if (err) {
+				pr_err("Failed to set profile for handler %s\n", handler->name);
+				break;
+			}
+		}
+		if (err) {
+			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
+				if (handler->profile_set(handler, profile))
+					pr_err("Failed to revert profile for handler %s\n", handler->name);
+			}
+			return err;
+		}
 	}
 
-	err = cur_profile->profile_set(cur_profile, i);
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
-
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	return count;
 }
 
@@ -140,7 +148,8 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
-	if (!cur_profile)
+	guard(mutex)(&profile_lock);
+	if (!platform_profile_is_registered())
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
@@ -148,40 +157,65 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
+	struct platform_profile_handler *handler;
 	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
+	enum platform_profile_option next2 = PLATFORM_PROFILE_LAST;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
-
-	err = cur_profile->profile_get(cur_profile, &profile);
-	if (err) {
-		mutex_unlock(&profile_lock);
-		return err;
-	}
-
-	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
-				  profile + 1);
-
-	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		/* first pass, make sure all handlers agree on the definition of "next" profile */
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+
+			err = handler->profile_get(handler, &profile);
+			if (err)
+				return err;
+
+			if (next == PLATFORM_PROFILE_LAST)
+				next = find_next_bit_wrap(handler->choices,
+							  PLATFORM_PROFILE_LAST,
+							  profile + 1);
+			else
+				next2 = find_next_bit_wrap(handler->choices,
+							   PLATFORM_PROFILE_LAST,
+							   profile + 1);
+
+			if (WARN_ON(next == PLATFORM_PROFILE_LAST))
+				return -EINVAL;
+
+			if (next2 == PLATFORM_PROFILE_LAST)
+				continue;
+
+			if (next != next2) {
+				pr_warn("Next profile to cycle to is ambiguous between platform_profile handlers\n");
+				return -EINVAL;
+			}
+			next = next2;
+		}
+
+		/*
+		 * Second pass: apply "next" to each handler
+		 * If any failures occur unwind and revert all back to the original profile
+		 */
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			err = handler->profile_set(handler, next);
+			if (err) {
+				pr_err("Failed to set profile for handler %s\n", handler->name);
+				break;
+			}
+		}
+		if (err) {
+			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
+				err = handler->profile_set(handler, profile);
+				if (err)
+					pr_err("Failed to revert profile for handler %s\n", handler->name);
+			}
+		}
 	}
 
-	err = cur_profile->profile_set(cur_profile, next);
-	mutex_unlock(&profile_lock);
-
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
@@ -190,21 +224,19 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	int err;
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	/* Sanity check the profile handler field are set */
 	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
 		!pprof->profile_set || !pprof->profile_get)
 		return -EINVAL;
 
-	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err)
-		return err;
+	if (!platform_profile_is_registered()) {
+		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+		if (err)
+			return err;
+	}
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
 
-	cur_profile = pprof;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
@@ -215,7 +247,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
 	list_del(&pprof->list);
 
-	cur_profile = NULL;
 	if (!platform_profile_is_registered())
 		sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
-- 
2.43.0


