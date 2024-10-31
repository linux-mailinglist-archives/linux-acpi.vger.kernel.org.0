Return-Path: <linux-acpi+bounces-9170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C29B739A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BE61F251C0
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762914EC60;
	Thu, 31 Oct 2024 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gawAFDzX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943AC1494CE;
	Thu, 31 Oct 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347843; cv=fail; b=UVbU8Jsj72TmY0+Py3VlBP7ivpUEqgJbqEk1VVtw8Ho3rtkBRTp8mIjuq1Y9iQcm4bC3Oo90I1co4luQeRZhXfssrOPG4NuM2tj4h6xpda640MhsilH1jAdf6uPYX2/T9/Ym/gS6GXWUZ/3H0utFuKAcA20Ze8l+23c99xyqDu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347843; c=relaxed/simple;
	bh=kssn2NDK6gU3O/WAz7m7+hTS3LctO64s30kaUthU5Nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAVeUiv1SmBv54v6pAHfHEV3fMMLXXwudhMk2d2votbgprUu1QfCMWzRB/6+QfwXgfzvPZzxXuZs5V3S0bFNV/oR09bZvdbSrZmC5fuaU3LvV4aVikbvz8yvQqjHLOC4NfUrgXgMPTLOs/hIMZeTrdrXwl/GB6+r3R4Tr32FIWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gawAFDzX; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLq9iZ1ztTiyz9ZAhnQMtS1Ba97VJNVPfTEq5PKP8OCMmCg+Hnk9hEj194w99hGrW2lSWAtAixxc6GC/osQkuzzuwp56mLwd8oNFZ5jFJg3i7shqAzsNzerBXoRzbuu2Grbzw5Vp2nQOubfOmrkhiLEuGDWEsUXLpip9/uO1ywaQsFA91FmO9jZE65Ehxjhsln3emXzy3dFd90WxQO7ISeBh7N2yuN4FiFbdoISrP2OBPk7shSYullOlEJB3smmdjvd3Jt9G7HxpIJKrCnHF/uN8kc4A4QeArCiQ9y1I7nJY2TUKAvRyimw/i125mNdnRs3Axq1o+aGIWCqLN10/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMe5H6/SASpOQUoahDlnuWpv0h9KbKCpZ1FiZ5ixcT8=;
 b=H1cZUaHDeI5MV4fA+rkE0qRDoZbuk+7YptYLLLFYpojeCb/Xcqr4757HfnqIYnN3OD1b67zEtQZqXF7eHK7BHobTocSEyQ5ucYfCCNaJ6zO+4up060xhsEdR94bvCZ59jppoMWy76SLzK3XlpdrLeThpITG7t6NHcuj3VBXQsgnC/yL2WCrFEY3TLJS7/G0TApSOgRvoNvNOwUvwvvoIe+e8xZNMxE20rMCIJ4ZeDR+lV9r7kML4TuJIzJlvi3Q9Vgyf1jM8FEHUFNXx958oDRU+lVK60l7O+MwPT2pUZCO0fy4/iWKFxkg7QdMrXbcRMCymZqP/lUrNIunu/CWC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMe5H6/SASpOQUoahDlnuWpv0h9KbKCpZ1FiZ5ixcT8=;
 b=gawAFDzXoMTVngq6fcndr6WUhekB3/sfgKEb+ZJsHJQNUIBWuHcp9FVRyHqI09EhZOuj0il6AGL5j5iTD4SID+I5rBfhy+XpgksDfwBXn6C6refqjKdhzW4evFFD2Q/jByyDPQkteAQ37NxgBfXegODQfc4RwHzQCKQUeWBKBVE=
Received: from PH7P220CA0079.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::27)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 04:10:38 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::d1) by PH7P220CA0079.outlook.office365.com
 (2603:10b6:510:32c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:35 -0500
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
Subject: [PATCH v3 10/22] ACPI: platform_profile: Use `scoped_cond_guard` for platform_profile_show()
Date: Wed, 30 Oct 2024 23:09:40 -0500
Message-ID: <20241031040952.109057-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 004dbde6-2708-4b27-cf8e-08dcf961f9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuavviVrhzqIQovrKVQV/SOynpX0D09vdwiR3QQOY8wwqskQO5/sJoDrivB/?=
 =?us-ascii?Q?ocor47GjYaCHGeNH2FfEq7CkluT7xU1y7JMZqurZ5rhwe4+R6KKRv4paJjng?=
 =?us-ascii?Q?U/3rJDs5NxllMUNBMW3pgWhvp3fC0V+KQFlj+B5Gzu6EIqmzYDLOEHTDINyC?=
 =?us-ascii?Q?R2YX+/87t2aSx7OhL/UV1nmtQHlslIx3ietjO2g49ENBxXOjd0VfzEdbDTHp?=
 =?us-ascii?Q?BnGRD2rtTtFK+ootitQxnlzy+o9MkOiSxjUnaNixwpvtguDFKDIh/rhuLqhw?=
 =?us-ascii?Q?w1ZddRTz72MEUu/Y6mpSh1158GK5CapfQrEy021/AU9HRoFxG8YvgiiZAt3r?=
 =?us-ascii?Q?db6kIY9M3pDYRl0xrxE11gYaMiqkMwqqdbnskSI+U6IGO3L71PZUCUXMbpaX?=
 =?us-ascii?Q?NFvB2QBHN9SYwD+sES2MhI0v+9n+aBHJGg6GkQZSN8lsdhp7CjMS8ysiXwdy?=
 =?us-ascii?Q?d23ATpbXb9DwZDa2oJCb3Dft7VbnxphjfxJGbmfKSdTxAMIPWiwhklhZJucC?=
 =?us-ascii?Q?JQfNPwrTvM0eX6rrVlT2Pju02CUPib9AkRUpDz4aFXxrlUMlhdS2hvO7Mj/0?=
 =?us-ascii?Q?y/dYsDk3AXoZQOS8SMkLHuhx/BVQpkYZm556zRgB439q0ro4vNvfo6kSo94v?=
 =?us-ascii?Q?53r2hdywLNeNy0PPxmnrMHkapFqoFQp9lLPph8YRw3c9VvLdjjbhYOHaJXve?=
 =?us-ascii?Q?RAy+CYMs5tdGVGC0HzI/5U/CLyNWH/7/eXIXS8UlsG2gczI+64Z1GjgkGI9Q?=
 =?us-ascii?Q?pb0bhOkBra7XjQVuid0Kr743Nx8dBIsC3GbYmgcywPBDmcbw0ImBPjDU9WAa?=
 =?us-ascii?Q?xOLpgEX/L2iZi1uDRy0Q2roQjlptcJVVqiVKjFYs6JOUzy9m5xtuFGwsnGn+?=
 =?us-ascii?Q?GVd5FVf0YuiVb/fmEDo1yu13n8l/IRZJkjndXoSyh85cWc6RZc9SLAcwTj1b?=
 =?us-ascii?Q?V4v6zZC7TPjWDmWMG5VG+5HEimxYGhEVQ+Q9I03zUnDo5lYeabT4sgtXZosu?=
 =?us-ascii?Q?SEb+XKAISOnwuFIwNlcudv/eLDEKo/mpSsP9d4AQzv5medH7zOl1wfqPtvzL?=
 =?us-ascii?Q?LN+Z+E9qPFNE3Ijzz2ahmRfYE52V9s8O3/x3f3TKg4xan2XnZ9Gv8gfEvTmS?=
 =?us-ascii?Q?cRRR9mXWThkW+L/qowWnZaR25ccQg4tadgQ2q/JhblELBki6XqtinK/j1ohe?=
 =?us-ascii?Q?NOhLDP5h/dA5bVqryPDmlQu4bQovZYu1ITRsDibUMaf5rQSom55FydWT0zbJ?=
 =?us-ascii?Q?xVT4wWD4hIbqK/tHQxtGT8mYW+rH3sRIGBYB+vrq2ZuyzE3xvwrYEXRLvCzV?=
 =?us-ascii?Q?Qop/x4FR7imLsUd0E9DOY7OKc7l5xa0xC7p7NEKi9HTtkYwaurhIwAN1OpVD?=
 =?us-ascii?Q?r6nmlifdwrbqWltiDFzf0M/zhg9RjatC94UklZoXGK2cTs+m3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:37.6076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 004dbde6-2708-4b27-cf8e-08dcf961f9cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

Migrate away from using an interruptible mutex to scoped_cond_guard.
Also move the sysfs string match out of the mutex as it's not needed.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 36 ++++++++++++---------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index b48dd34301f13..63a5f5ac33898 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -75,35 +75,25 @@ static ssize_t platform_profile_store(struct device *dev,
 {
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
-	if (i < 0) {
-		mutex_unlock(&profile_lock);
+	if (i < 0)
 		return -EINVAL;
-	}
 
-	/* Check that platform supports this profile choice */
-	if (!test_bit(i, cur_profile->choices)) {
-		mutex_unlock(&profile_lock);
-		return -EOPNOTSUPP;
-	}
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	err = cur_profile->profile_set(cur_profile, i);
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+		/* Check that platform supports this profile choice */
+		if (!test_bit(i, cur_profile->choices))
+			return -EOPNOTSUPP;
 
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
+		err = cur_profile->profile_set(cur_profile, i);
+		if (err)
+			return err;
+	}
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	return count;
 }
 
-- 
2.43.0


