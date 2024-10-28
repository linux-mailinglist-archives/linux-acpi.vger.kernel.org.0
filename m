Return-Path: <linux-acpi+bounces-9027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806089B224F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E841C20F45
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7618E773;
	Mon, 28 Oct 2024 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICYQkUVT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F127D18E754;
	Mon, 28 Oct 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080951; cv=fail; b=uxImHk2pueFXCW4y3wI/t3baKEVtulqw7tMzuCtXl4bPrBfRFQUcQZU6jfjYCY8wfgAeM2VBYrPCORfU2FBPMlycXyAC/mGy9UYDwv+H48A/4AXrRfXymHFzn1IfirzhpgCDr2DXxeoTz5MpcjXHQtl1fsvQL71g04ZCIJ5ZQoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080951; c=relaxed/simple;
	bh=aFwzSKPLz/YXemmVCdt8GJyf6EUcnLuQ4/HLB16K6Ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDs5yepy9G8tUrF3JDd56VOFJDFzR9r8+N9iGoxgK88HMWjPH6G1syMfNXnO4bkTGhnGMvqMx7fiRsr4Z2d9DMxaUUJtsi7CXYQIs8EE3PZhcY6zsH0HTHQb6MBU/Ufr9doKLXFI54kG9zrsiZiFTKVhZf4pqm+wTtPABGs1d4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICYQkUVT; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPCJ+Q4p/Z+exmQM2hMfuZYqAJhWgRuSuDIwrim6hL3y3siFdoKfBn/wAXa0Gi6tqiGThVH6hnYH/OS3v2KJdy2bjOgMYkc+zEVukxmIDeebJOa3cxPNalTjMMsWigi9cP4NK4v0s5/rhFshWF7nyPhFrSdbc4HkkXNQk742Bl8XVIRUYAbCeD71Lb3xA2/+XDumidIkuXRJZvrTCXYkCoD3DL/dnWdV+HOUfnpfB//gebT8OrORgxI3v9d/n63ZVojGU3oedYWyLfOnUM6PKoTcE2stWlapOQb0TVUVklh/lYslXAuvt36/SALPaeWBcI2MdKwgSeH/oNTTrqmYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kxczHy0H4hTAJE0R5okzA9R2sjEja1ZRGsbQuw3pv4=;
 b=RWIHAtSAr/6rrftr2i/fkQb0UDO/WmVtJqbgCV2CpPj/7jqWo3XJbe6pRtHxFYgXAzSTm6OANZZshYGQIMAIOGjm6DXzIuFGcVl9MuOV6UDEUFX8AWyo+v9JYe/7uzw/MeOdBOVUPyStCNBk7Kt6am9dsGp6YBVEYBhpcLOiKOTcZ2106Uc9tUeP1qqTjciVzJ7RD3ZkOogRCkWsHSNSA2+6FUVYHrt8nhut1jJiKxeUgpEB4RS4tdyuXBWVQAxVqt1tY0N+lg5ydQD8zmzqaqdAfAzcW7tZiwbRcz31ksKV9ed3XCn/Qa+/5szT8NxanHNP4gpbVUlAkQlU0jK3KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kxczHy0H4hTAJE0R5okzA9R2sjEja1ZRGsbQuw3pv4=;
 b=ICYQkUVT+6Z3rtkucM6863zA4Sg2G3c1trXel7U5TpgoPAV9wzlSgWcaUXvD+oNn37AkyAOVUlODRACap4ZtlZVZJ0xqPxPQ9qzQau6EANHcHh92/eqAedssVX55LWF+GqBRkVLoMAy2kgSo1rsshAQFps2nVimWtkycpkd9TN0=
Received: from BN9PR03CA0927.namprd03.prod.outlook.com (2603:10b6:408:107::32)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Mon, 28 Oct 2024 02:02:23 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::f9) by BN9PR03CA0927.outlook.office365.com
 (2603:10b6:408:107::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:20 -0500
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
Subject: [PATCH v2 13/15] ACPI: platform_profile: Check all profile handler to calculate next
Date: Sun, 27 Oct 2024 21:01:29 -0500
Message-ID: <20241028020131.8031-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd22a2c-adca-46ba-9e62-08dcf6f49054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6sw3KkCx1cRngOWQNcg+I0qHJM08XE08Ep6XViSlMq05ICbz1qb5H6k5M/9q?=
 =?us-ascii?Q?+5syauEzVqUf1lwcI7GCK7JKcWUolUOAWU1bL0Uz43dmafM50wzB+D3q93+2?=
 =?us-ascii?Q?g+w9HvqMtqHgbSvAE9OIsy/2SSCbPCRVsf7wQJJkMgLhezO6kq7TrKP4G9SP?=
 =?us-ascii?Q?fm9ys7nntp2pwt6NSx0c97rPeknuqRAJn74ONE70DjhTnY3ztMkRnwFtSnwL?=
 =?us-ascii?Q?ZUrM13wQxhUs6lUOaofe5Eciz+lSaR6mqrl/1gcK7HUWXPM9xpqq5e6hyTHH?=
 =?us-ascii?Q?Ad05kYti5re/wGB5577lyP7TAR8Rg+LnEko2+uEkMahinIkt2GgCVEPMV6WX?=
 =?us-ascii?Q?YTnJbbhk7YrJPbkaHd2MLaM2RI7V8IMlJF8vWvm/9dgE7COpXWnhpqlilmVd?=
 =?us-ascii?Q?9xyY+fvK6E5D2uV+uO5fwgMWHHVhdPq58x+koi2qYKNKWEnCFNze6wIXyPix?=
 =?us-ascii?Q?J5M74WsuHdMXbaTgP54dQj+5hY+jkgegnfWqQsNdVH8338qg8esv479Rldxh?=
 =?us-ascii?Q?bADy4BRoTF8uMjZJnLZ5AJLEcVIhyCWQ3MCpjPVVEBaQXJET2BvUernUaeIe?=
 =?us-ascii?Q?5bAVNXmRQDVQWVP1LmOXAPxKRw/Tn+Ww5tTIqtwDw/M157TkeukUYEd4buBD?=
 =?us-ascii?Q?1nJDjIf2tue+k55Lsav8m17QwDfkZMAiYTCQeSMJkq0rucScAwcmki40IMfY?=
 =?us-ascii?Q?Et4GvsxKOuT1DpNbXNyCP77Hh6FNREclPfc46gu5vQc0s6nRr57qUe27zyg2?=
 =?us-ascii?Q?PRU/SJ7VLquEXDju0lBDpmtCC2g28NUUeeTG0D/ocDbsT97VVO4Wvm8y5rKL?=
 =?us-ascii?Q?jiaqs+oQU7gJ1IjYlDxf2vlwevyuVctNDMTlAe45bX5hUx+vBPF1b0wZZe+K?=
 =?us-ascii?Q?YwksZY3M9jNs7QpHS4EOdhZWmdG40V3qRbBhXhxAJWPPZ6kRBhWWjvFNTgq2?=
 =?us-ascii?Q?ylJW5wocsWnm4s8fz9RRU+Mmpsdfd4p0+fxMcrZg5QNdZMoBLmA+xGfSmgep?=
 =?us-ascii?Q?9vO/kJG3JnZS7NRH7tLXchE8wbiPV9CFwjzDoHxMXIY4Eq2mew0dfF94qgtu?=
 =?us-ascii?Q?mbb57XEaeImhchhy5KSIZH2zTFKwNyJz89yqgigau/563XK3r1vtviM6v0TL?=
 =?us-ascii?Q?xFs2Sb/ufj3Nb3lPTT6FOL5+q215xnq7MfXvGGkvZV0dZZVd2tMFzhRHcIBH?=
 =?us-ascii?Q?IGfoOUsg4pOW0LHp3Zg85POS29pBMZ2qO1IdzOfuPf6ApVhdMEHvHb77mdkn?=
 =?us-ascii?Q?QcxACcvA5VM44r5yY002qm0AJrt04uClT9efD5Sul+KecDGCDc2VaOvKIEgD?=
 =?us-ascii?Q?LACfDYfku7neZwd8fPmomTNdXjoFRVyFwhT+RVVAbWMz2fvKewSARvsv8dIb?=
 =?us-ascii?Q?9ct2QLlzagBCBqjXylYuSYKwsBTJK96HUW16QK+qP58WFlmi4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:23.3060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd22a2c-adca-46ba-9e62-08dcf6f49054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

As multiple platform profile handlers might not all support the same
profile, cycling to the next profile could have a different result
depending on what handler are registered.

Check what is active and supported by all handlers to decide what
to do.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 52 +++++++++++++++++----------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d22c4eb5f0c36..e6ea5b600e2af 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -196,40 +196,42 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
+	struct platform_profile_handler *handler;
 	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	unsigned long choices;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		err = platform_profile_get_active(&profile);
+		if (err)
+			return err;
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	if (err) {
-		mutex_unlock(&profile_lock);
-		return err;
-	}
+		choices = platform_profile_get_choices();
 
-	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
-				  profile + 1);
+		next = find_next_bit_wrap(&choices,
+					  PLATFORM_PROFILE_LAST,
+					  profile + 1);
 
-	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			err = handler->profile_set(handler, next);
+			if (err) {
+				pr_err("Failed to set profile for handler %s\n", handler->name);
+				break;
+			}
+		}
+		if (err) {
+			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
+				err = handler->profile_set(handler, PLATFORM_PROFILE_BALANCED);
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
 
-- 
2.43.0


