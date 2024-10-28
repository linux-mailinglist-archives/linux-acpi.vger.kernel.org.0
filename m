Return-Path: <linux-acpi+bounces-9020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835199B2239
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68431C20E3F
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDC18BBB9;
	Mon, 28 Oct 2024 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xl2vboDX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CF17BEAD;
	Mon, 28 Oct 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080940; cv=fail; b=A5GgbD1m5FCe0/2mthCojb6/sv2zbqFzz6UsAn8DKywXjQWGgmIGMGwjo0bfs7L8skNdXflc8zWtQOmSd5LqwOhj52hpFYO7Ev/m1xVMMhGDOitP367cLce7xjcSKObA1gFB33ACdTEr2HFeTWhLn2YukZumQt4T51Gb7ddvHqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080940; c=relaxed/simple;
	bh=ZU6BROkzA7zNj0KMLGX5e4LqRYTYQfMk4VlEv6kwjzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFTDgX0+wczk7T6thXc5cE+43GdR5PcauNPLesmqsf2DbqbnWY4FfU15zFSQCnBqfMq6EUwiNoZlBJG3CaJw98wJF5UI0ks+3c+rMUUrN/mbcobMxC7qvOEhAJNCuIasVZl5L6kLWngydz9A3czEA8oWmsugrP+3RpbEGqntzBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xl2vboDX; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4Lsw7zr9Am7eZ3LypcM9dO4uyg1ibBHjSbEfq8Rw+VWZW/yeFOjaDXk02/yh21AX7dTrJCnmNjKuFHs4Lzy7+iIjrTRIbwJ8pVLbdO2CEyRgumm3z8D2RudUmJVJKje2X75Z10pEWfET3lfREuutM1yJ7C54R1TvPDfwnGox0PTNw12QOv15bgAaALWmoQ02YOrPDLuCychmbT6zfZ8rdFJEpSRwaDl/C+6rCK3hTRvEL4L9TXEd8GkJJh4SOXnXG+2mjhlW0giJMOV+D4+wzqzNfT/KKx06OBMhQPJovI0C3riTbZg/6eRhPRiJXZKGD2mVtdEUIGzxI778TSSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oupYGz8RlTP+v31HqWoK+xtYXtdkCJXiniT1MB2+KEs=;
 b=SxDzuGOQnRihzcOxtohDiTYZ3pJPKFNVaQupd4s45Tdzy2zxHeDNGKux/ebOx3caqDgmrLYoHA5LH6hUMEWDyMnMQv0npomDcAqh/kAUdeohjStuhQTg8A7/PWzhLRq8UnYUN3dZXS2N8TFQB5P+03KGyPRoLoKOk4N8gEXetUeVgunse3Reit36+VMNaQb/0ryTh6m+epxgkSpodyEw/F8qjhyIuu8CnHnXtlvi/mYgIriuolD8YP91wIXFEmn/OrjeqjEqtkfB8S6Jp9fikaqQcq8sr4NgC//KEnjdXxNryzZWXW3i0eV2z7OA9yydrzNphfRYtSB4RAPnsSyBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oupYGz8RlTP+v31HqWoK+xtYXtdkCJXiniT1MB2+KEs=;
 b=xl2vboDXN4+ADxMGgVO4koAZqzg+WfuxNUY7hggsRTPE7Q+XnKOc4dSmVgFh7EuQgC5TO+nblM7kKbUus0+s/amxls852f0Ndom7C8ZUH5BvKsBAyBk1++NZuZC3Zbs+/vo1ZuWVCA9cUUeUzXOjtAB/hFUHlbwthoGN6rt1c6k=
Received: from BLAPR03CA0084.namprd03.prod.outlook.com (2603:10b6:208:329::29)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 02:02:14 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::6a) by BLAPR03CA0084.outlook.office365.com
 (2603:10b6:208:329::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:08 -0500
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
Subject: [PATCH v2 07/15] ACPI: platform_profile: Only remove group when no more handler registered
Date: Sun, 27 Oct 2024 21:01:23 -0500
Message-ID: <20241028020131.8031-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: c176e1da-4c67-4e16-41ac-08dcf6f48ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aC2GAVC/pyVbVORenrMU6p0+go0orczLiVSngAVrvDrMAejzThWiWMZvNTG?=
 =?us-ascii?Q?GTkyaCCghVQP3m8szQJmnREZ41d8gpnQZn3494FbhQlVDEawBCZ8CpSOcZDh?=
 =?us-ascii?Q?dnDTlqtxrglLlhE1CUx0WyGdrRtopX3QfLsp/wfovEjkawUAl86sMPBmXTQh?=
 =?us-ascii?Q?NfvfCEmwFS4cpAyYb2UKvL9hZ6FTCRqrdm0iezNwQHTwSLy40XBmh/LsiS5d?=
 =?us-ascii?Q?uZJYxYKRV54e09NKdvE3Fg4uPbnq9SPL4iTr7nQ5icUxL/dO3gYRi3oiqRbq?=
 =?us-ascii?Q?/8zYGDSSFz/vzbInaPtOUiXrFKKdDr9p2KJ2YQGdYm4uLb1+uj1udPoEQiVj?=
 =?us-ascii?Q?KzzV0uMW3quBE7xTv4veioV5kfCG3C9dD+J0er1jH9Adyow+JzMpHF5AxVGK?=
 =?us-ascii?Q?GNv0rpvYmZUHbuml4wpJiNfXbWm5bHSj+tSYl2TDeKyTf54LWkivynfWFfUm?=
 =?us-ascii?Q?a9y1GjAWWAempSAYKsUN6PSGAATZo3wgQ1jDzBF2o3/mftzqZtPNVQZeDkRn?=
 =?us-ascii?Q?7u/JDqOyhXW0s51xhiLx0kcNb1GD8QErtYsZmro2Me7A4rtMWp8C6LfcOt3R?=
 =?us-ascii?Q?y+z9421JJ4+jPPEzvJwRJfgYqZgxJv2XywnyTBAN6Eut7r9BuArbcKpAJs8F?=
 =?us-ascii?Q?zVdyxB3ZyKsKu0g/6lt//pWKt7K1AxA2xueymWbV0ijajfTZnuPfyCdDO2P7?=
 =?us-ascii?Q?qObT7Z0j3AfnK+rtjAwl0CM8i/Ql27TIBFwdfcOEioTmrrjiw7Yrxmoqa3Lq?=
 =?us-ascii?Q?LSE2YkL/gyXhXDWzQksKU3VggOLWGROrRDaeyd+6/OQUqE5MtlI3Vd+JmKYl?=
 =?us-ascii?Q?2aIerru3Y99vxpATN8ajf/Zq7wyrgk+b0GVCxBjQhuUt3ze+02Wm/NfDueF1?=
 =?us-ascii?Q?PkwtofzuCcX/++tAcf9wkIbr2xhMg8E2v98NY2JgJ+eywzbzentcBw6GnF0F?=
 =?us-ascii?Q?LracPncCVVe02N3XGQFzXndTX1t/cEu/c0QPtZg7gEVe1JOdR/juZMPdcY4w?=
 =?us-ascii?Q?VYELL6k4eePiBQ+VHYmloSRGubOLDfJyXq9BypqlIPciRGMY3A5d4bUpxdtO?=
 =?us-ascii?Q?SSzeNaucjEwdqfywQHvsn0bpJN5+syzNGIkRoD4aW1cIKlWjQFW49CxhXVK0?=
 =?us-ascii?Q?7l5uG3abXrr8YxS1h8iYppEs+PDx9T58h3BhllK3t/dgEncx6ehp2f2Kq683?=
 =?us-ascii?Q?NCkWcgOUBqkhZd0iwZYPDFY8UYo214rp6CF4UowMKaiWb7kSa0tPvr/47woq?=
 =?us-ascii?Q?yDAhg3fEtfA5TwknlXRidssYvsNRvqcETEpZfoiZESA8rJhQExExSDrOc1KL?=
 =?us-ascii?Q?wyi29eg71WtFbX3UjIF2gOx3NXNVUf4GYP8WLF4chqlc5Ynvj3VFPsXQzFNc?=
 =?us-ascii?Q?da0Dh+RL2zLaBjDCBDZL+K28eOsTxEmguWEos6z094wA4pzGZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:13.9623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c176e1da-4c67-4e16-41ac-08dcf6f48ac5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

As multiple handlers may register for ACPI platform profile handler,
only remove the sysfs group when the last one unregisters.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 100d6ffb10cdb..ede1550170f1a 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -23,6 +23,16 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
+static bool platform_profile_is_registered(void)
+{
+	struct list_head *pos;
+	int count = 0;
+
+	list_for_each(pos, &platform_profile_handler_list)
+		count++;
+	return count > 0;
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -207,8 +217,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
 	list_del(&pprof->list);
 
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
+	if (!platform_profile_is_registered())
+		sysfs_remove_group(acpi_kobj, &platform_profile_group);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


