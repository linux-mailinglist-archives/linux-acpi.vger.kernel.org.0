Return-Path: <linux-acpi+bounces-9171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C219B739E
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D872B23A5E
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89A1547E2;
	Thu, 31 Oct 2024 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h04SUTy+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EF14EC46;
	Thu, 31 Oct 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347845; cv=fail; b=DGUUrb/v/Ei1PhIXuSu38mGKTaIPQOrCIRZTvzcOMJiCasVqpjpsaRr4Jub5u/1l3Rex/5TOz4vpRzaYRgAyjM/xG0dLzAdxEEsorwM1UKqQEQsujiH0Otd9WOmgaByhtKDLig1cPMc4OozKKgKatk4d4u9hpHwMgvvU2YESXO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347845; c=relaxed/simple;
	bh=NA85YAzU5HGhnAyOn7Slgl06+COemEDtnALxY7uCu9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvSs545s75YOUAKIeJ/l/JTmwsiYYHT4r8tXRuPA24TaUIblkuQPUY2MycZU8Ilwrjfxg6Iqyq1a43G3fEgYIC6Kkh9lh0sAF06+S4nzMrRebd9C3Y4nHpU8MY+R1JsotkYb9nqT7RiyhO+cNqjEuEzShs7ouKOGproT+F0vFA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h04SUTy+; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXbbxQGsiFbf37vWu09V0+GYjZzRfr+5DvfTough3JXEVdogudM3dXjDE/HZwKVGz9Dyz29kqMZ1faYs3PY4lKQxYzU0IC3WkFzCk/acJmUHcft4d0BTLlaAfUuZx8dOHJJNXXvQeJGJPdyoboXjsZ7wkwHkaDYJlZeC011FNX5UKDhbdZDUBoL2X6R0k/S3TWB4GV2pY97HtTwB6cpI2weVoCt5ao+++zQipcCM+Ey0yi51U8oDtFJMBub6jkf7QyRFODeZXo2E+HRu1hYOcsr398edJvkJGkBIPelLHV6BratRq0XNgD9WowOB+RTDKmJ0rc4WnYOdQAyVHUyvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XyZCGQydisWB0aecSxy6A4iPT3N6k+B+VWHygPISz0=;
 b=fOf1O5sSaRHoPQ4nCqgVzwC+SgIPrhjuYDaCp/YKO42uKl0Pt9HhSaClC+74SqKWREXxwk+BozD4629iX/Oct0jdItOLlvAgtfw9Txk+z92GyMk1Lmp9ZcQvJ5kRpFldJmS/rWXWOoAnUcneoNgxQxfuHCqhmDshR/oY2U62SBgacZjovwmNcj5t3/jDImK+BirIcdu33fgF8bjyrJIsmbq6V2DuwPM8xNnArXScshZghvi+C+d5EqHg3+X5V/O92PihK0giwWrBQtgkPo2d11J0vMTrAXOWTnMJgJMN5latqa2ype5IUF1hbIVt6oNquJaJoFYGjnFc2qpSwivpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XyZCGQydisWB0aecSxy6A4iPT3N6k+B+VWHygPISz0=;
 b=h04SUTy+VT/blGEvKhtD/cF5tBCBesHMuI4UHd0i0lOgKky8vROuvYm/N12Qec6OklKVLy+VK1C6Uz+FdmY+l6HsZio1uP6Cg3tchbFNI/3RmafE/qkUy6uP628kcipuifFW4PAzYNKEV2BwT3tty9Q4I+pLe22atv4Sv9tt3ik=
Received: from PH7P220CA0065.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::22)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 04:10:39 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::d0) by PH7P220CA0065.outlook.office365.com
 (2603:10b6:510:32c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:36 -0500
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
Subject: [PATCH v3 11/22] ACPI: platform_profile: Use `scoped_cond_guard` for platform_profile_cycle()
Date: Wed, 30 Oct 2024 23:09:41 -0500
Message-ID: <20241031040952.109057-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c031ac0-a45d-4e1c-03c1-08dcf961fa62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a3u0qQ6d5K0TEI5xulIlGRPm7Lpl7h15YvVYAALDjygJXDnP5Q7bW6zEIGM6?=
 =?us-ascii?Q?zt9I9qMB3uUhjrp43PKQHuG6mturH7yNHLW05oKHLX0d0xySMAD6qKSEPZrd?=
 =?us-ascii?Q?oVZI64rT2ELKhXwP50DwqAVgj63N9XBFlt1h5QZ1UUtkkEi8Z/kmA82vzmJW?=
 =?us-ascii?Q?+AVC7RKAqggRAusmXsct9NdoZku+e99Ssq/nda+dGw58Gn77/2VI5pfhWb5w?=
 =?us-ascii?Q?lQaPLmGDe8DFHhcwQkmjXpaxs1VAi2FutlTt6x2Z07x3CxdqMUF8KgQRsYSm?=
 =?us-ascii?Q?jFCI5vYiAWUjeiAxF+kAv5sMc9rStU6oC6JyrWyb4bd3xeaPL8fcQghsUv1b?=
 =?us-ascii?Q?COFVufl4VJKVuyoqO7TzpZpFBToGJn6CzUoZ2cYY5oNPI/PvbV7oCPHU24VC?=
 =?us-ascii?Q?yFjvn1Rcz0GPNCRzXIWfxIJH/Oqa6wVhwFH75mB+WMRyViDHR+i6i0O/Az+r?=
 =?us-ascii?Q?X4fZCMry8RlgFyKeyNTQ90Qj+STxRfWMWPeo3TmWdo2QqcDO7QWFC/UXxhHm?=
 =?us-ascii?Q?7lDu63Ykm3ULR1KbNl8Zo8s8z4xY5Yj1lMAQloHpSCdiibLvyGMWYuvcK1Mz?=
 =?us-ascii?Q?1xMlu9uGhfdynm1qqSUU6dWYzwO6f7iJRDcvu9bJAkzXnv3SGjv7ng0tx8xv?=
 =?us-ascii?Q?XalN6cBPyOri41f1rGn/cqthdkmdSdTKqTmrtMAFCyS8rJ3Xgy2aF6p2ydpi?=
 =?us-ascii?Q?LROAo3ITAa25qF54SNmYUPM4QfboWb9ADCvy+4uuafph3hGozAPsFjD0C07r?=
 =?us-ascii?Q?3mj2cAuzE5RnrxlIdG61NDvulOGS0ZpEHcoX9Ow9VbDBhNYB/4qATXGkVy3J?=
 =?us-ascii?Q?yICrX0z0N3IspSpTvNQfIOtSFzg+FpxKT618Lf58yop7IL3EYxi2DvA5H63X?=
 =?us-ascii?Q?0wdrT4LsktOsnAoreMO3dOs9VlJhT1dzDUq5QZivuxEF79V7gyxhqH9ogKb6?=
 =?us-ascii?Q?ziS7zHNBD1j1qpf0kEofcbcc+QLaEY1JpiRImH5snK+tVHE+BtrFFHj3Fb2H?=
 =?us-ascii?Q?/lGBWX+1QFQEoDBBTzlyTPUtLWW/p4jZr/qmkLZbxqFJMCoecp5sAp7nFzZR?=
 =?us-ascii?Q?0351u3AUMpZZiMhymo80pk5RoT0eYcrTGgiY8bx8Tl8L7UF8YItuzg+rZIXk?=
 =?us-ascii?Q?9pOHe9+zxw2ylSIL9qQEcJkBNuOYAKDn/YDWAHlr0Ri9xMix6BLQMP/mSjFK?=
 =?us-ascii?Q?HagStAN1UzTad1TJJUoYa3B+XvwhnPsV5CPffj1mIJILKMb9BlSQbIDqywDq?=
 =?us-ascii?Q?uMsirfwCIP8lVplG9o0MuYGIXeg2bti0hEU0eZtLFLU1JpT6/ObGbpiMrXz0?=
 =?us-ascii?Q?RYnGeILhHbtuIhhYoAONgH4qWMz3yaIRH3r+S6f+/27CPbdfMFywNDsGW+n5?=
 =?us-ascii?Q?qb8Cb+5Yzy8XTb9I3S7AlUrAUvMQd51/AeLZSYRQGu0fPuonXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:38.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c031ac0-a45d-4e1c-03c1-08dcf961fa62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

Migrate away from using an interruptible mutex to scoped_cond_guard.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 39 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 63a5f5ac33898..2d971dba2d917 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -124,36 +124,27 @@ int platform_profile_cycle(void)
 	enum platform_profile_option next;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
+		err = cur_profile->profile_get(cur_profile, &profile);
+		if (err)
+			return err;
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	if (err) {
-		mutex_unlock(&profile_lock);
-		return err;
-	}
+		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
+					  profile + 1);
 
-	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
-				  profile + 1);
+		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
+			return -EINVAL;
 
-	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
+		err = cur_profile->profile_set(cur_profile, next);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_set(cur_profile, next);
-	mutex_unlock(&profile_lock);
-
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
-
-	return err;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-- 
2.43.0


