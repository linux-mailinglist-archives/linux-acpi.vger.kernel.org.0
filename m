Return-Path: <linux-acpi+bounces-9018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C91169B2233
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED113B21C95
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9CB18872C;
	Mon, 28 Oct 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N57rapsk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D631187862;
	Mon, 28 Oct 2024 02:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080933; cv=fail; b=TCvZKbagjdTA9HqhsIW3M3hirOOG6nHCMxM8E0HGu6/50caoJJAU+Wt2Gtij6WcUULCACdaPfSPn7r6O/CtPY3fxgqI8hahztL3ljc3u3PiUcYnx1ed87Tb8TqmbS3HDTYLxTgffPWb5/+D6/i9Jje+EQO2ZvT6nVzxIwD7hjTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080933; c=relaxed/simple;
	bh=BemhE3FLBJt8TXb7tQ33+yfm7BmIFqxRNCRy01CsV3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgIx4mfbd6O3T6pWOmTGCZnd1oqEOCO8nc4M2H888qUA/fq/XWzRAaipYTmxzYtur/r/lYja6I0u4aMt8oRzQNISEWqEAT4/rDgV/vH33spY9uaQ4H3TexYjI4rIT/cugjSSVgj9u+mBPLKucB+YDRcBxjivkreTosMcX4+qshA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N57rapsk; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGdr/3sZUK6h/9TneziCVV+ULRZPGbbvgfmFe7e47Abz6NBbj0mkKWsbvUw3A1xSzMw2TPn0y/pkZfEzV9h+7gtnNmHyy47Gl3R9HXRmQu2t947AbGmwCcpZAzkDukJeVOTgkaQTkIg+6symrnDrePbKkLLCGidL1w+5lz4RWnMToARHD5XRhW0ktE/EupGcMxz4uzGvb2dMtiTkFWXnDV1OqO/6edd40w0XZiyeyjvdDKvtgcIVjh0tnjDOCMuxIMddDZT0sDTnA4Lxwl8fS0DUsUsL7OVTvED+3nA6JpQwSJ5jkJX5IRXIXjdgtpQgS3BVCeww9FUGdtQgOoCB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpxkTbpsmel7PNy9hFdoS5mAlgzObBowHU7VZLZDO1k=;
 b=NYfgUVJJJkK8whGbxe+ZwK10K578WXp9mp4Q1IkJtI3ZYPom3Zc9Hl3yRFLNn0TKRslN3LmJxCtY+/DBm69M+yVONARQFBMRNh3l8byKoZseX6ZOxbmgplaW75j2/SF8CAAUpeV66ivv7HWM/NkctfLTf4935gR4x+lElsET+JhITEzL0jpK6pPqogt2ZfvMghf+YpdzAR8+aB8GtiRhPtsDOvjyLrj7UnL6lY/hTHgaN4IfhJgD21rtYcRxiLRMBucgWZA2Yk2c2Llr7i8oVji+HoSlxmgk8D1eIrenRDaVYqW8fkB5oyeAGf6pJ3IWpwfdZd/Tpq98ClIZQBwSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpxkTbpsmel7PNy9hFdoS5mAlgzObBowHU7VZLZDO1k=;
 b=N57rapskgyruY5CF4QDilAMXEVWicbUn7IOKYQxNYaY0VRCcXNfJ98mXhSKJjdspgM0ZeSIo3mZV38VH3X5NmJKUiSdbvY80BwlkqI6rYZpcNzP/qm9y7x+efNqZU00uOxxQcolJGSxETnTJpM5yYc3DkL46kMWI9y6YR5AcCyo=
Received: from BLAPR03CA0074.namprd03.prod.outlook.com (2603:10b6:208:329::19)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:02:07 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::7f) by BLAPR03CA0074.outlook.office365.com
 (2603:10b6:208:329::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:01 -0500
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
Subject: [PATCH v2 04/15] ACPI: platform_profile: Add a list to platform profile handler
Date: Sun, 27 Oct 2024 21:01:20 -0500
Message-ID: <20241028020131.8031-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: a83fc542-e641-46ae-0cc5-08dcf6f486e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ybfkYNvnljLWX07BoGsajzBMrNX1f62noKmr5lXaABbghGytqoZqTFBcoQVZ?=
 =?us-ascii?Q?VoHwbDh5v9yUkddXbybdJZZbSE/QtpHW5e9J2kk13W9Oxtl5mMmDpQbXDq9n?=
 =?us-ascii?Q?XNky0J97cymeZEu1fpxQHu2gvIhNWPBuPU5qi1zeLl0Uz9zUuZZVX/vLb4Id?=
 =?us-ascii?Q?dcog1IbWVPlxxe9IUfHKblsmFl5Z1UDr+zxI5u0+Q/ZXbsZJN4FdB/ofjPUO?=
 =?us-ascii?Q?yRMLZw/SRG7lGfJTZkLLSkbVLaNnVPlfCjKZcfn1yZJGAITmavKsnC76rONc?=
 =?us-ascii?Q?7W8HJHrBXf9RNHQVrLW5tr0n9xJv7pvBcbe7GXytCR+jKFc86ssW/x/o6H5P?=
 =?us-ascii?Q?EoZDvDltXANBdTSxnhHtZ0y6183gyOZelKGJrVOaDJhWc8XyN//jER30WPfl?=
 =?us-ascii?Q?OBCWe8pyZkg0XgdLwcFlS6s/Tr/1bOur1Ao1PNqG4iB7d25Nn1DaegXUb3Ka?=
 =?us-ascii?Q?r4yrAUOfzOk22umKiebXXYvDWM0D8ki8SBGG+Vjo01pFxlblrtT0qr6lpBd2?=
 =?us-ascii?Q?R9PE1w85njL7yiAJFFPF3kLYcqdHylz7eb0VZW/MmmvNR24Q0gg06DKI42G/?=
 =?us-ascii?Q?YzgZDBvwQ9RKYxo6p9r+cbusDF3o0FNU0GYCeGnkIgHwv5jJ1Rx1Dya6yH7a?=
 =?us-ascii?Q?EgX1u4levoCs27N1W7GW9WlqAkneebj1oThb5qmktcaic9dIgMJyIEbqfvWh?=
 =?us-ascii?Q?TKz+H8bQ+wZweKDeLojUPkJLBwqdzwFFu/1phfoSOyk7Mxv99vrwXGmZ9sj8?=
 =?us-ascii?Q?rcnlNBNqIukuwfY2+P4nh3NqYZnki9HpdYzGa4II/+FMz1UHU3Ur2xTiZF+J?=
 =?us-ascii?Q?i+4CODohIe1E4zs+9Dy9qdU0fgM7JPNScXZWZss/AXBR6U4ifpD+jZDM2E8f?=
 =?us-ascii?Q?yu7oIX23QUQHYA02RfDtqgLyiSn9KW1N1sQsZR6TDVWGPstNct66Tm+OkziV?=
 =?us-ascii?Q?5Z3jTeXLTHOG36SK3ZjL3/vcIbljYTsmjWn2dF9vXJ13n+Au1PSHr1feOElY?=
 =?us-ascii?Q?1zkR4rerCAJZyMLrR+gVooU+P9KIL/LJywSp/TLI5MyQ6RU2tMiCI4nC0osY?=
 =?us-ascii?Q?Lv106+LB6lO/FaUMqH0bN91rHA+c6uImpdCbYhb0R0XwH8prA5T6/VA+hvIa?=
 =?us-ascii?Q?PDI+rrKJN9QcGDKrkypiYdG7l561yP+vU0Sajcfo5UOiBMgayzlGfDznfKD/?=
 =?us-ascii?Q?m2XA4+hT0Rrz0DCiMWK+AjHUKjN2WYXLlVydekNfaNSs04EODZ0zppfcIMs/?=
 =?us-ascii?Q?vy4ERfe0OqkCOeKoaKZlLBvy9jklzndnr/aurCmvmjQO5CtUafnsOc4kDC8w?=
 =?us-ascii?Q?655Bj325nPrkn1bj8XN+yADQ9OLG7Xmy4uDHJoOvmkFn6ejTz1qkGvn8BHu2?=
 =?us-ascii?Q?GzuxA43/lTQHmG0FkBaD/AjaVhRpcWVMm//peJEwbJHwvkhM+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:07.4622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a83fc542-e641-46ae-0cc5-08dcf6f486e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

In order to prepare for having support for multiple platform handlers
a list will be needed to iterate over them for various platform
profile handler calls.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 5 ++++-
 include/linux/platform_profile.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c24744da20916..0c60fc970b6e8 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,6 +10,7 @@
 #include <linux/sysfs.h>
 
 static struct platform_profile_handler *cur_profile;
+static LIST_HEAD(platform_profile_handler_list);
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -198,6 +199,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		mutex_unlock(&profile_lock);
 		return err;
 	}
+	list_add_tail(&pprof->list, &platform_profile_handler_list);
 
 	cur_profile = pprof;
 	mutex_unlock(&profile_lock);
@@ -207,8 +209,9 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	list_del(&pprof->list);
 
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	mutex_lock(&profile_lock);
 	cur_profile = NULL;
 	mutex_unlock(&profile_lock);
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 58279b76d740e..9ded63a9ae6f1 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -29,6 +29,7 @@ enum platform_profile_option {
 struct platform_profile_handler {
 	const char *name;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	struct list_head list;
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
 	int (*profile_set)(struct platform_profile_handler *pprof,
-- 
2.43.0


