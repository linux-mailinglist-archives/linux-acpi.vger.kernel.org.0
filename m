Return-Path: <linux-acpi+bounces-9310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3718A9BD098
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72B21F21B7E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E21DAC95;
	Tue,  5 Nov 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VdBfmK6f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A370126C0F;
	Tue,  5 Nov 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820829; cv=fail; b=NqElhn8s+ryCpDmiY/b1A17T/Ty+GrdUb93d3BN3C8oNgQRhKuMRCfUBBdsauqKpN+/27l6C7fNiafaJdVKO92dnBnX7onNvbUyEJhFPQV1dx6d0I6M0xKzLblXGu13YZ37kTvNRLZm84bUmKRmDl1H7bmTNAFEx9U+93yTExcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820829; c=relaxed/simple;
	bh=Cd0g23FeVtwAj5O4/KHsSeyaSM6F5ZMiE2xkf8UVSBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpTvkEvCA5Cc9o5lmYZrUwqdY/VKPUynO3JWDM+zWOvi/wqqDQIf3SYInoh9mPS5pcOUOZhn5YiatIrjRlpH6kQn4MwT60P8dyEPMWLXliv1gRRnUk+fdqUVcMWNPGoHoP7tbZaqpAQoXT7AYx6xPkurSnSG8/tu8oBDOFajqRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VdBfmK6f; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpGMVVYC3XDxEfrW1vSwvh7NPyfQz5t7gsWSnTcTDI3+7o8/AQCSya28v7dGwUTqhD0MznQ2NJpjMyokCCM3uoTo11mEhBf3QCgzOL4gHMFAl7/j3wAO4RBNVVemuO9EZYme44GGr5rh0CmLd2Fydih8f1jLi1jK7c2FUMmiuEIfiT+ScgQeOZjD+QaNVJl0++glk0WYMkOoDWiHZGA7Kn/wcLteV7RF0TmR8NTopMwCK3MsQhf1wFUz+08tDuy1kRZ1rwFemCbDuYIw+kM1gdjSwDPb6yOIYkpRSSXXBHsq+9Ku5BBnBWmykTR0hvLLFCaUpOmXVX9WtkCmql0Ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3aTvu3Ec310NAKYMzm+n8TYQ55+AteNFEeMXomJjW4=;
 b=ffMWKetZYU7zJh+3lwUPHpknBsffrErqStljvswWjDNHu3DN9g37RQi7sudaHy8pXQEsMUIyBMiOrf1gYx9O4I3N86zQOnDad7ATrH8xjfCj3PJS6b/YbAPKiZCaPmzdkdNOPBkkd78Bqb4vAvCj8mi2ryRgfdAZf1UU9HB+w/2H+KNZO4wQh2anNLzdHLwwDQN5gM9qZKPmyQt+XZ/gIlku9FHp+HBxntoZJPMN0HPPdOMKkGpOqxh8iorRofMCnT/4xyIs93dOO06tHEE8xDo5Q3rpTH99Zz3mLIz1Flj5JBOkgUVQceK+16LNlNDG30ujZqwcbfaDl9cYvBJE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3aTvu3Ec310NAKYMzm+n8TYQ55+AteNFEeMXomJjW4=;
 b=VdBfmK6fNT4WgnjPBZawflVDShzb+f2UyvWNdFaIwolXvxkH5CW0pNicfOEfKetiFPY8VuvvJ8C/U5SnDOrxNBhYy8OP6xR/vpwGJYIFmJXk6nn01W/5sHJ/3ofEv2nNKHDtkihvG3AT6MSN+EO51U+licDSP2cukhvbB+C792o=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 15:33:45 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::ee) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:43 -0600
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
Subject: [PATCH v4 15/20] ACPI: platform_profile: Add concept of a "custom" profile
Date: Tue, 5 Nov 2024 09:33:11 -0600
Message-ID: <20241105153316.378-16-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2590f222-c1e0-4e68-4cfd-08dcfdaf3c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qDhSwBkIGzo01cErq1GPEi4Cr6B/8wDFLiYmawQX8EZIMb6+E4TUgNFbIEvU?=
 =?us-ascii?Q?64qlY26PhsUMZjotWT76v7x14BbydcLXF/nuABtVYRbatqqE8n7wmwLWyFAA?=
 =?us-ascii?Q?FjYMLyW8dkAk3xgY2Sce1n0U7DgTz6yQAQ7UvsFV2XtBeotQE5nnqihZQd/u?=
 =?us-ascii?Q?+tc7GmbV7kkyb7oRHQrldQlys+MsHuFW2EaJG3tYKWmL1SGIApinYVIEV4pw?=
 =?us-ascii?Q?yQkEIuDQc2G5F1FMnmknDKaps760V8IKICpocqyYwHfpD1pcsYm6TUGdDOqf?=
 =?us-ascii?Q?1ZUXjHvwpnCJ1lMlDGoKi0/O9FU4eVDBvx61TFtLe19SaoYeN9Vhh9Bwobur?=
 =?us-ascii?Q?qYpsyLKRWkjAs6Xp2WkHX5pbgLn0SPqlQVyDsDQfJ35NUEAjTz4DSDg9jGW6?=
 =?us-ascii?Q?PhhQ88+83szojWR1fDXnwjZ8nECwIlM6kV7Rxo7CUf7C2AMYNnxj9H3WrAYF?=
 =?us-ascii?Q?YJUpm1NyIrqOyv5I24e4NUI2clp9rkr51c09dN2fmjSB0jhk2qkxVqwIUfU/?=
 =?us-ascii?Q?3Y5Z65vmbxccO6GkvzcXLza2AV6RpPyLGjTmfV6zllnCluhB7vC9bGrYDmBO?=
 =?us-ascii?Q?t63rHXXEu7sarC0aHszMZLo8YJy38ESTrwd9A33szHOKBtVFfHIUhmn7mttT?=
 =?us-ascii?Q?3ZWgqq3cVIKtexVMP/fMt6lLAUH+8fnru8e21+Z/92a7zquPG01/6/06/mEQ?=
 =?us-ascii?Q?JzluEpwEciVwVMBFV/QlcpbtsuKxSLwfKhFYeDNMxVy3UPg74Dt88NjmGpQL?=
 =?us-ascii?Q?YZDeuXWJmYregZ0Ngcn3kj3dqsA6XRgBx/CPk3X/UpVnZe0IKOfWGh8UrWgk?=
 =?us-ascii?Q?GW+h9ipJhEXZ5tMEXm9gwI4GdADWdsJRHO3bHvE+gkpd+f0/2N/7mYB6tXi+?=
 =?us-ascii?Q?bXy9XBEFMy9zK7jAZ/l9RS8vCwdOTy9fQih1MDyxHGMWx6gv8sG+WaNHcC/q?=
 =?us-ascii?Q?Rae6Am3l3xxmaUXsUBS+eaf0G/YAYrATgrjCY86iQdMbAxNhXsySo+ka22lP?=
 =?us-ascii?Q?7i/PXGVGrL36mG2NEiX3U/1GkOclFHLB4PKp8iCjhy6KBCGZVKd3qHtoCZQ4?=
 =?us-ascii?Q?j7agUB+rJtXbVD+KyoOAAPbZqnyL629FQ0O82IXlErAACZfZSmqwLg6s0EQj?=
 =?us-ascii?Q?xdtynKFZRnk16qSwu6Akfc+KFE/S0Ca7Fw1TcuTDZlV1PX2DqlR6r9U8I7Ic?=
 =?us-ascii?Q?IZCtiwKGFeLQ1xeseUIxssa2KtMJuTZrdLSYWkAXihbiVTWff3cQsfXnBbPv?=
 =?us-ascii?Q?JJsq2SIRlLjiFz9WZAsT8foy18ChJQfJgj76wVxh/SbJnEv9msEt0xOC2JxO?=
 =?us-ascii?Q?NBlTtmXsdwKHjt7j0BTX45xbO2CLsUC6fz/BYfTBqOrGOIMaBZ3RqE2PtMCW?=
 =?us-ascii?Q?XtLqMvZKuOqNWrtUt/M3MDENhwCKE7FlOZlnEdSA5fc6Hy6SFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:45.0962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2590f222-c1e0-4e68-4cfd-08dcfdaf3c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

When two profile handlers don't agree on the current profile it's ambiguous
what to show to the legacy sysfs interface.

Add a "custom" profile string that userspace will be able to distinguish
this situation when using the legacy sysfs interface.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 1 +
 include/linux/platform_profile.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 8de7c8352673e..d8c2d195106c2 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -20,6 +20,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f81c3afcb7575..d2a2ab4c6cee9 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -23,6 +23,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-- 
2.43.0


