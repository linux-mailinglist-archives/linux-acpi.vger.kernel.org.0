Return-Path: <linux-acpi+bounces-9175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546369B73AA
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAB71F2527D
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C313FD86;
	Thu, 31 Oct 2024 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5KLz9Udy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4626126BF2;
	Thu, 31 Oct 2024 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347880; cv=fail; b=Lj5C4NUy7WHItLsBfoMmztxZ2NXke5Kz81wUJPNPG1R2jAFNms1w2HVwKoPKGZvIDDsds57B/3Ump+ahF1jvAOeb1Y8uU8hNayk8xsPT8AIu9SDvDacCmI8uZ4Uej3jayBBhOFQchTZg8jQuZ/Gmd1eGSg8NXSvaJntfeJGr4Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347880; c=relaxed/simple;
	bh=OtCtHlpL5bk4vLAegdwWm3/Ky92bzSLwgrPBZOPM1rA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/o0Yh62SB7uZfzZHYOGPOM40pPDzNDRYjEXOvPjBwpxx+g08Kl56+QIdGFiAnY58N8rWnhrM2qySmVNskhHaHtAF64uk5bFy0bfohoaP51ZxrClsbxmvLOa8yaFqEfqzAeMPSBXRaf4OqWEqYuDILIQi0wcI4vGXIpAEGWjC4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5KLz9Udy; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrN0/Oz5XSxP0sR21Bp8KQAf6vKol6rXibbowHQ/mjHg+2M7dqCdR6Py0denpYSuYQQB5pz6yEG9YUm5D7/YSl7VUY1/pwQo6bJJ7Eju5VvQfDC26KVVZ5cAvgCSdRQZJgK0xUiSZx7AyMGzaQ3rHBTiMY5X6DSG5jleknxih3Aq1HlKToJuxsz9VtW3Ken6UGCuVFSv0AOhXuTR3u7mbEXzeeyBtFi7pn3BX7g41dEiWSx+zZ31WbRwlsZ9Wqit834aiYzGzIodg6R59/0kWfOP5tiXEBTIohH0UiEQjDFzHCkuCKqkk+YGr/+CjW2mz3Ez58Nf+fHuNdAsvrDGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTMgLG4xbIsY9gFb29ycOBwD5iLmIPptvlydkm4UJuM=;
 b=KWiAQGtVj2s1lxGN/r2e6w8Ch9o01W8ZHV23kLGFcXpe3YWGE69D08XuiIULSfV1TL0ZVMxD/nNXALqOKUBF2pUSficjSH2KNTS5NogfTD6EPl709AEaIShTa7SOj77Bu6x5ZN8QSaBbOiHLvrt5iiCBnTM64KAJbGys/D23PaRV+mwtOLXOcz7srTVIa+yZqB3R1LSy8hiPpQD/xXtB8D2kl33Wt2QQXnXMK7xg2Ri+n5C544oDlRtIdoXGjgHwSYKkf+i9miFuzI434JohfPG6IAp5ya1IxfaFcEIuL84kywXSVbWwxN/ZwaFbJ32EsRrfe+opg82kY7/Qf6t1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTMgLG4xbIsY9gFb29ycOBwD5iLmIPptvlydkm4UJuM=;
 b=5KLz9UdyVZH8KcqD4FMIea1rR1advafVoeDMWD5V5CsFKJmCXN4InDiYgHrGBQ6+/9BR4QF731jejIJJ7iBs+dhsy71p9pnFhBoRV2w16HcHELirkZzWMLqFTfyYpD3dQfSJNEMos4/4X27J5iHfBbFoHPriNIiH3xy32wZJW48=
Received: from PH7PR10CA0007.namprd10.prod.outlook.com (2603:10b6:510:23d::7)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Thu, 31 Oct
 2024 04:11:15 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::ff) by PH7PR10CA0007.outlook.office365.com
 (2603:10b6:510:23d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:13 -0500
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
Subject: [PATCH v3 15/22] ACPI: platform_profile: Only show profiles common for all handlers
Date: Wed, 30 Oct 2024 23:09:45 -0500
Message-ID: <20241031040952.109057-16-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: bad308c9-efbb-4e67-c297-08dcf9621007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0htAXIwqA//U5U8PKOmOfACotYNVuT/ckP7MsWqy/e3f3fkCCmApYlFpqtHP?=
 =?us-ascii?Q?vvjfTEa2GIhafbp1Oq7mA5aRJj7br+hqtPJZKT9ZIomFDKWNnEugDOPWEbEN?=
 =?us-ascii?Q?KzJjt9+D03rQyhNzZ1JzfxvYxbtcX4bP6aVrm0dU50TaJQNnZAbOA5SD9SNn?=
 =?us-ascii?Q?NJWmMqja/yp1sItJyHghqa+a73ytXy39ZMIcobB9/EF9v0Z3s1uh1KeMHR23?=
 =?us-ascii?Q?jliEGmUKcYfLyycvVR+UBsJGR1qy2ptciY3+sDNa44g2MQOchkYRNtXOjHPr?=
 =?us-ascii?Q?Tj8cpoNB2vgrUxxlfqhw2QneMy29SM3sBzLAqHuYxhA/2ldJQBZxZHr5tfls?=
 =?us-ascii?Q?Y/AdHmI9IFQ9RC79OqOd6IEDr9ewOLPFx9yvApL8PAZUvH4pm8ADpxrNL9Mo?=
 =?us-ascii?Q?Ybu7FCzfrHq1bdVU/Gjg3k9aKUuHZu8RQLyqUpM228hWQJRArwEHPQaoMUw7?=
 =?us-ascii?Q?gSG18pGBZZ9ZNWU/iM2aFHiH3KxUnbw2danbMSba+wahMTd0AZNawmtqQw3y?=
 =?us-ascii?Q?NDUVxIPfbvDaesB4CyhtNy1IFtiAotBjVxV91ohLW83xsZERXIO02fZSdnvs?=
 =?us-ascii?Q?5NesWf2aQrHj9XoC9z3QiJXVrKAm+r7wg8BAZIl8NZlk2KFscS+3gseeh1ez?=
 =?us-ascii?Q?zNLTx1QVw1lVDTEOkFbpf6KEPxGApwE9g3zvAKcKeil6U71EVru/G1SgLD4e?=
 =?us-ascii?Q?yP25J1nZnCBSnEjogCudNgSImbgTprHlJBFW/ceNA+IDYqjM2H7F7K1Tpj3m?=
 =?us-ascii?Q?+l3zRQP/5JLNRtHhmDOO7LcEldESk7McCU4Q7mznvAeI/j//fLwx17auEAT3?=
 =?us-ascii?Q?VJx3vMnTduRuBiQ53PLNaSgPoEPol7UJU28NUyOGBrbQuMlIM7pIDThRmSNo?=
 =?us-ascii?Q?V15rgehSNUM8iiO4VMq2vr3HFqarmlNCDB43KSQ5sE9ovYj6Q8xAqodngN9Q?=
 =?us-ascii?Q?Cu2PT0PA8/mWbGMbeMZg0ktjo1Ztq8i3aUy/s0+wzeZsmqR6G2VNEf8CewBp?=
 =?us-ascii?Q?J/n72TpHL4Uh/xmnnvfwRu70ouqG1dIXs6FCo+h4Ar8EdAABV4QmrmdAbtra?=
 =?us-ascii?Q?2AbKfKHZVuSovDg0cNYt9rJcSFxM3NYAUEYapERmLs+bM7Zx2u8ElxpSW8vo?=
 =?us-ascii?Q?3zeag06qaehqW3F/dOAyXRSMBCTzo6Hee9kLGo7s4ioiwtPtHsP/quEg+xik?=
 =?us-ascii?Q?l15JoYLdg6OqC+R3Dam38u3EFpWcwncIBlh+paL5ak73BiSG+oC8Auj+F8un?=
 =?us-ascii?Q?K8IJCtEi39k8zT+PePowUuzP6r1YT+uCsr5jt/uZbJ9v82Rzp4szH6AiO5V0?=
 =?us-ascii?Q?gRBbzxi7on8guQdxcYA/huSum3Vhd4mc4oWJh7yoN4PO+dIor820az3mWX5+?=
 =?us-ascii?Q?0m1V6LehwYOh4lzKk5hycRoCLVrR+hIWw7sEOZjBh8n2qs7VBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:14.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad308c9-efbb-4e67-c297-08dcf9621007
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 38 +++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 7bd32f1e8d834..90cbc0de4d5bc 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -29,23 +29,43 @@ static bool platform_profile_is_registered(void)
 	return !list_empty(&platform_profile_handler_list);
 }
 
+static unsigned long platform_profile_get_choices(void)
+{
+	struct platform_profile_handler *handler;
+	unsigned long aggregate = 0;
+	int i;
+
+	lockdep_assert_held(&profile_lock);
+	list_for_each_entry(handler, &platform_profile_handler_list, list) {
+		unsigned long individual = 0;
+
+		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
+			individual |= BIT(i);
+		if (!aggregate)
+			aggregate = individual;
+		else
+			aggregate &= individual;
+	}
+
+	return aggregate;
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
+	unsigned long choices;
 	int len = 0;
 	int i;
 
-	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
+		choices = platform_profile_get_choices();
 
-		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-			if (len == 0)
-				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-			else
-				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
-		}
+	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
 	}
 	len += sysfs_emit_at(buf, len, "\n");
 
-- 
2.43.0


