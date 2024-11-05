Return-Path: <linux-acpi+bounces-9313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731AD9BD0A6
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DD2B24342
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ECC1E2619;
	Tue,  5 Nov 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HUphLA1A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC81DF731;
	Tue,  5 Nov 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820833; cv=fail; b=KXSwkvNrVQvam/Svvl2JNn9mlLe99sEkwZuVAwf4hD69E0Y5gWVv+vrS8OGu7FiR4ii+MlrOkoPCdjDfrj/HOj47IJIeh5uhVF2FHdc0SFv44iga0usd9ux23bbSWgyXiRU10n2tV7KO5g2kdyx5kWbHLaHfMPPaP6HjbYnQwD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820833; c=relaxed/simple;
	bh=ny3iW6DOlZU8HQaxcPXox+hKvSEiG1vFhL5CaxmL63Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3t68pFirN/MQsW2SZK65J3NWPnagbnn85y+P03v0n+RJ5exxktZWmtVK4rYNcCldvsaU/rOV2sjhuN78t6xQDZiyqivrJHwj0lh0F5xmB/aBkuYxkIkkwbMuU0xZkoJ5Jfqt88k32x0ZHN+jDdhHD6UMWapB8MeALtj8gA4jqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HUphLA1A; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7CBsAGkO0bA/5Yvamgt9AKvl2tWA+gtQq6ai5K8fHg9lrHd5fNoC0W0l0T9j0Ov/ErySck3cMmoulKIjJRACQkFPEzMnsXP0QeiE6Q2hdD0rQvCV9InLiNH8GKsQY8Qnn9rXi4AJyqUMJUrPoSdqwezruCgrZrFrHBqAA+Xuyig7TcXEPsf0btxy74rhENm11BoLWYtGcyqhNYjrWffnC+wQ0mUm7IBPb7I3Vwl0aNs7hYLLfkcpAtXXf2ZgK96v6AnGivIXSoL8vw2AJshSOCYeiXDwrmEqrZKISW2ynO2bE8HuOvX0dY60lNtPvptYQ26+3OPNhgk8HNdgxMpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JP3To4xH/AA3ZnPv9aOvigXqmgNlgcBHoMsbj8A2T4=;
 b=QUm15SZg63Do0HkbgHzEQl0zZR1kQfE9zMC+2X+sLYVFkZJKIoIwZlmiJtIutFkIkl7N7xLZGYrsh0FWtN2Jt0HPQtKicp+7kNLsczjN7ErIQY+LhJyenaDZ9p5i8IFkLhEA2h/WzbBq8q2S+S47oq/NCbuAk7QO4jntcU9qQnaeFLHoGV7j5vznnGGSoivQ1GGAEJWOV40+EoyQ+f5oP1B9BO6oSdN7qheI0Sel9+8hyL+/xMYJ9CQ4h6XTZ1XCJ+6lnJelbNqmvIaAPAUEyvbpMaKcC6GsLvGbgDxB8draRReqWX6xo/Rl9RwXkWh2uGN0Fdmu8201EHgZkaHXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JP3To4xH/AA3ZnPv9aOvigXqmgNlgcBHoMsbj8A2T4=;
 b=HUphLA1AekvuGJlXYFpjqVdnk/nYD+Clj8p5dhq0usHPLbpwY8tZk2fujDdL8q08fEVEi2sXbn8egM5FLktR+5sBZCdmUzBSfHzj/ol070p7tU7xUOi3ektNeAiwhHrNVdnoUxXVDOJqC4cidNTk1WPGvbYxtnXM4NSypmerEGY=
Received: from MN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:52d::7)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:47 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::28) by MN0PR04CA0011.outlook.office365.com
 (2603:10b6:208:52d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:45 -0600
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
Subject: [PATCH v4 17/20] ACPI: platform_profile: Check all profile handler to calculate next
Date: Tue, 5 Nov 2024 09:33:13 -0600
Message-ID: <20241105153316.378-18-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d838e77-fb61-45c8-183d-08dcfdaf3d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afNngmcMqPrxtZGW04jW/zY9r1V/Z3xEoArP7M6BizyqWQ0QCaVo/1DbRYAD?=
 =?us-ascii?Q?59fdd6fNCVv3eJdEtyycGeJgX6myfwpDMMuc5hsG8sEQiMmt9q7qqMWqW4PF?=
 =?us-ascii?Q?pyDtmbY6O/Oe1rasOk53fHpGe9Nf2PcRaKBlXR5Nu/lDy8gao+17OpOqq0sb?=
 =?us-ascii?Q?TEO/AEVGRTv36bRFDMrgAKHbpbZpGCFKbLJyLcEUROJ7FoqHXQrf+yPIOBnP?=
 =?us-ascii?Q?rob1qthXffu1IhnVGzWafj1gSsvNADSTOmrAULFUN3FO5cRLsOL8+wePQkyJ?=
 =?us-ascii?Q?nmxoP5buDJ83Q/iKBoZfgpz9IzwS8vYpeglsGJACu6Snx4dxmTnWRliF69eT?=
 =?us-ascii?Q?aHar3XXLfson0xq5oyGYqEg3yiYwsoLEXsGnouwsSh2huo3RnCQsOTiQ4VqA?=
 =?us-ascii?Q?mGIhnucdlOisZpg8HffmMwSL+2iGE/o1kPGs/KHlC6cw3s+WDMg9QVCq1qZ5?=
 =?us-ascii?Q?okqy5mQeDlFNmQJD4jmrIsrFUcDQ44ddJgFo6xOWrtjHnb1qXstXY7dHKnxi?=
 =?us-ascii?Q?SxWCPHnBxR2Y/qh/XcF2lkmtNmyy1Q4/EGXElPgCJmtwwnG9WT559iIvu3g7?=
 =?us-ascii?Q?W9THqBotHzaYUxfiRfjdVnHVE5IdoWXksgWOL9OiH9YqNAyE4+CVaK2nqFwg?=
 =?us-ascii?Q?5wVbTbQlOcOcr4EnyPTLEMoT2S64DzJe9b5U1XWym1yoOoYE5SxZ3Fdnq1xI?=
 =?us-ascii?Q?yt18z84DYkP8eNVlvarl1rWYOQiJL7aaeoxhxi31g5PhltX6Hhiq20sWRpgT?=
 =?us-ascii?Q?BpYv3+WqirfSvIVo3N5uCD6id+m6RLskk5suVBTnzbZ4v/91oY18ioZkU5Lx?=
 =?us-ascii?Q?Xpl/0Ex3dTsEtlxv3VkO/b7v8n9CrF4KfOM6DcaepghfQb8FII6F5j3OzSC+?=
 =?us-ascii?Q?+dsm36E7P4GiLDXEHjxd4Ddu8fGQtx9yXaNdaDzIzcX2fCoSlGbeG7K0RLw3?=
 =?us-ascii?Q?sR2icN/6dFD6RYTQkeVYgqOhuTXSeTGwju2QmQRH5jHgRGEjhkc2thCJ4dyV?=
 =?us-ascii?Q?b3TtY/pJJhcpxTWNkXEtE7a/cjBtpspg8Cs0Fn/66UbE7hdd0RO8QC50GO/L?=
 =?us-ascii?Q?Cfz1MdRb5KvHxhhrIsiTeaZv7jv5IXHWTQ0OfaKh9baiMQHM9zbRim/HxurO?=
 =?us-ascii?Q?IGe0MPguN8X8bR2IJnrfdZTjg12th+ueDHVGIw1umCspkNlQ+k5GFMQExbBm?=
 =?us-ascii?Q?JR6TrzPiUHogHSyYou6aewT+2jsKzI3TgNv+2RG06HJL04cYDt/ZpXcreGv6?=
 =?us-ascii?Q?aV6aGWTip06AGsK5lKVu+poCPfBfdRAwe+SauVdSBwYhK4kW5aro2toQtp22?=
 =?us-ascii?Q?LD3mDVSWxIDBvogxDELH1IqbT/g7k36TIfY0pi8zIpxBBjNKxaLgtPOnBv0c?=
 =?us-ascii?Q?h5qldGPR6gIg+BQmBljUshOPaCRdIg2AsNjloFFVDsAGTu31aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:47.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d838e77-fb61-45c8-183d-08dcfdaf3d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717

As multiple platform profile handlers might not all support the same
profile, cycling to the next profile could have a different result
depending on what handler are registered.

Check what is active and supported by all handlers to decide what
to do.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 35 ++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 7861fccc2e58c..568485e285061 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -378,34 +378,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
 	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	unsigned long choices;
 	int err;
 
 	if (!class_is_registered(&platform_profile_class))
 		return -ENODEV;
 
-	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
+	err = class_for_each_device(&platform_profile_class, NULL,
+				    &profile, _aggregate_profiles);
+	if (err)
+		return err;
 
-		err = cur_profile->profile_get(cur_profile, &profile);
-		if (err)
-			return err;
+	err = class_for_each_device(&platform_profile_class, NULL,
+				    &choices, _aggregate_choices);
+	if (err)
+		return err;
 
-		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
-					  profile + 1);
+	next = find_next_bit_wrap(&choices,
+				  PLATFORM_PROFILE_LAST,
+				  profile + 1);
 
-		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
-			return -EINVAL;
+	err = class_for_each_device(&platform_profile_class, NULL, &next,
+				    _store_class_profile);
 
-		err = cur_profile->profile_set(cur_profile, next);
-		if (err)
-			return err;
-	}
+	if (err)
+		return err;
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-	return 0;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-- 
2.43.0


