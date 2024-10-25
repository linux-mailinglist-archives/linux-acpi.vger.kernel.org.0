Return-Path: <linux-acpi+bounces-8995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292F9B0F07
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73BDB25420
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DE8214431;
	Fri, 25 Oct 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bx11NF0g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A8214423;
	Fri, 25 Oct 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884690; cv=fail; b=jkoZRyKMTSNv5sAPLAuMxckdfdAltv9jxs5p5QFpiwcDSL6Ev2wk37h+76pm+0dzFC4jqWqOyN7r0RJF7Zg5zOpWnQINh+A/69o92XLREzoe02oi/OhzLe9i/dzzVVilXpPirB3g7Mv8Y92SIWaWGfkk+AAjoSteUotjpgKay0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884690; c=relaxed/simple;
	bh=dIJb0QFhBgrm5zW8lPzoo3mcj7ROXAuZgMmOQH2hFwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOV3s9DdStJ4WvNFpqWK6ujGDxtvlJVq1X9j879SWZlDzbvI/vpee1sNOP4xRI1wZc6+7i74wYbA9sKzBKfZyF03QAzZgzT8GXfiSWhrZKfouW1Vyi2R+dgzQxmSehRqGIipHxKLDAK3WZ6hCS5c9dGHKbgzJ3eJfKRU/fwysl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bx11NF0g; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOhXHAZbw7RnNU+nOP6+bAukBlbyTFv/pBw6ZS7nFGzOxrsm5k2cyZ2Ys2gggaWZzri2G+5T2y9VztsyBI59vSk2qOklh3JEqddWl7bTYQlIE9N82F7ggLsYBS9W3WOkDBxY5IfjLqG9iq2EndPJhsuFNw0Cpq77cxmDHf3I/glIGY54qFmuD9ouwkJcKp0GgdDaTi7E7SctUMqhZI9f4l3n4ywl8YvCV0DRa7SYAPYbzTqtZZvLhOFXQNvSg883ErQrbkzrdnhErPJd36cMCDAv1gkQO8Se8BKY8MZ18nI/A2kTeHCIKTuBsN/89QsD9dprHu0FDZoXajQBJvM9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zr7QLpTwdIcmp3ofgNzIY9Zzj7NcyKmHo1AdKkpWMSw=;
 b=svhcJPUN6TVtgUk07hOTy1TYVj8PeYxpEFkPY6L+rs3/LZxQoh7uNeWcP31x3OVXA7vhU4GzQ8pGlPq3q1/yNN2Dlbjw/WG2De6U1NiV+10lxhC9po3SF6GRC3G4l8Ya3Vg/he6wtlUCYArN8Vt+SADsvh6nsmPF0YMkrQorhzzs1cresuUUcrzohlFoYBFp++7bWnxnvOFQxNpREsBxBMIbr46uXRiI12N1Io3eIBKQ2ewNAcsKIbE74DKxVngwqifxw7m9nUHCye9T6fOm0GoPVt4xLxc53NWlLMYbV8FJFqJaN9drH5cz31F9Xp/JhJSTJeqCvgDuq6doAlKbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr7QLpTwdIcmp3ofgNzIY9Zzj7NcyKmHo1AdKkpWMSw=;
 b=Bx11NF0gOYn2jUK4sO7sgIo2MOCfcUzY2hhR8fZjdfnb8I0xmiAsn/JTaytjUTU6wSSrkUqksOlv6EB5NDHutZzrpLde7mSI89glzUovB+IQqTZ1b2vUeDz9F2ysrK/LgCqoCBQ517FLKB1NZpC01vomlK0BO1wJrsVfDKio8Pw=
Received: from BL1PR13CA0237.namprd13.prod.outlook.com (2603:10b6:208:2bf::32)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 19:31:20 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::87) by BL1PR13CA0237.outlook.office365.com
 (2603:10b6:208:2bf::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.9 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:20 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:17 -0500
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
Subject: [PATCH 4/8] ACPI: platform_profile: Add a list to platform profile handler
Date: Fri, 25 Oct 2024 14:30:51 -0500
Message-ID: <20241025193055.2235-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 841f7e13-03fd-4e19-126d-08dcf52b9a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUspQmn29qbPWoOSO5VY5XrrgGqde9e7upGjSKvYWXvr4Cru2ItzZjO7RWhf?=
 =?us-ascii?Q?vu5yQ8X2WtJPR2h+zQsRwaVlX0RQ/N2mpUNGukoXDY3gwBfbm8j/pPXGkDZn?=
 =?us-ascii?Q?jDfbV6MGgHB08CfR9wV+Asq6+w8S4fFSMs/aqrZx2AFl9GurzJa2Smaki07h?=
 =?us-ascii?Q?kgf3b+kUzLgFbm+bonlD0tkr/dNOhwikF6zXKJJrzJjE5L8blRvXJMdHH6Fp?=
 =?us-ascii?Q?3K5xGeGv9coiMtD5I6b3l4BOeaAvbP9fhg8AgJROotT342JVmMB51kAyGLa+?=
 =?us-ascii?Q?QVm5FrQI2QdCtB4sUsVadS2gMtxBFqAEmYaWmzYWptJy40yHDJPZKdfnH2pB?=
 =?us-ascii?Q?k4nJBlW64Ip8QMMYL4XHxr5auvAn8yK314BzR5c8rEA8QE1E21w/g/38Ixq2?=
 =?us-ascii?Q?q5/ltJxoKdilYZwqfj5U5eI5lO4plBhX6cy1qIdguFt8XIRap1JEnziC0fMu?=
 =?us-ascii?Q?sK1gt0ttLZRje7JXQvNvp+4p0E0t66NjeRrQ4nvaOhKrFvb5DlvQrvvOolpo?=
 =?us-ascii?Q?16co9/z63vkU8RfcQJQkGCoDHA6CuXxf2tRtPV8azGR9wnCWyird9NPuVb5S?=
 =?us-ascii?Q?w8Ul0DpjsUs4Z+UOdqg4lKE5E1/MA0HHeDzrHMfnqtEtSNDRQkJIJZMH+Uow?=
 =?us-ascii?Q?NIBlJbF9ZKKyve4/7kkL3whE17VioeHUaDAZApBSmGcZLAI2QV2fc57zryF9?=
 =?us-ascii?Q?CwWGF0dqams06LCTHRGR+ol6H3mV//H6n2DaF1p3xkZyqYpKgj2sPH48JeY7?=
 =?us-ascii?Q?QDDjNS+b2frVWBFP+aRXKI55VpHQZk6VZvqeg20E3za2TVaA8MDo1dPa68oL?=
 =?us-ascii?Q?UXVhhsfXNfzL0kbqgVpxIWm4kDHMfgl/CsJ+TVdLxbhIC3P3wq0duxqBtVLa?=
 =?us-ascii?Q?OdXN6uyMjWlM88JLoPG8QG/uytREBZK/KuBUAOHyusB9e7cIpF58zyYcnAux?=
 =?us-ascii?Q?17UZnSoH5P88aDsUF/3DPF+JfVQWGaGq3knwUlLdoXvNErXQGwVYBkcekmeg?=
 =?us-ascii?Q?Hz2Zh8vIzza5p5N96duSf/Aya4suZbOJ/oFkCWGLjYzxQHcroeuNngRVXp+7?=
 =?us-ascii?Q?OxEfFQX5U5C+RcCF43GB8eULR5G7wSq7njSiuRxaB2t1Rdmx0l/e9Au1Fy4h?=
 =?us-ascii?Q?txE3/GrjVhlksbq0fiVMt7taQKt8W+xKJyPw82othEw1V/GYcS9c5tHqcnhw?=
 =?us-ascii?Q?wRNDUxcdzve61VQEZkqD9PY9Z01Bf2yK0/iZEdkNrfW7gX5BVs6oSM34w1gH?=
 =?us-ascii?Q?oSef3qXgON4PkgNy4IGxnKkNCpcPJ3CcVN6ZflOx+sZxmTWdMhL3wcEvinPv?=
 =?us-ascii?Q?myiAMgM5ARI2WZezdXi8vK5arXGGCM7e/3fXa0ngAX+RsKjWGp4VnNHHVHjC?=
 =?us-ascii?Q?mydIO1+ZFauUjtbH+rtTTMKLMGSSD+f20Y/PFBWXmk+D3GfWpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:20.3101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841f7e13-03fd-4e19-126d-08dcf52b9a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

In order to prepare for having support for multiple platform handlers
a list will be needed to iterate over them for various platform
profile handler calls.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
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


