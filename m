Return-Path: <linux-acpi+bounces-3283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E784D5FC
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 23:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5A11F24FC8
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Feb 2024 22:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7958820313;
	Wed,  7 Feb 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="piXKrhHe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800121EA78;
	Wed,  7 Feb 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345889; cv=fail; b=OUsOsYb19ZMQuge5NZpC3BAvjeOzcCtobF4aoM4xLyWxqlA/izFMTaaUX8+SyKrQUoOTqBRYhX9dVf7eM10yo/pEnjO6Sl4VxXoMnYI97IMyoJdnVzSeuZjPaxmQvl01pYCe0Js2FiBsu7A285/+x5FzrjVqL/vbTst1b0nJxMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345889; c=relaxed/simple;
	bh=bKtWl/av5sGbB+HXhTeeti15etgUSnlYTvSfu/FJGak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZDn3kMxxILN/80cp5RY4BKTsaNKeFbRa9oB9/aag7AMC9yTNiwsTE2LWP98CPgGsODQqlZKT9foIiVbmSrOb2Aw38FRK61l2MXpisqnq/YapCcsy3JezKvwEmCiGF8kfheWAyChkpsCI832uKseVwjjze/5QkTYoGErVaFUwGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=piXKrhHe; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1i5upamS0jBhZFpmqwGrvky90s+0kfhOa8CaBc0AJUT3ZK4X2z81QfwkRKpIEUi1mljtRVgUHMYRO+4JxzipIEa2LSAB6HPzPiSAaYHrBTYxM7XMzqs9tUh7d8Kgpg8z8ENo1LwiKjDCdoHhAUKGwLZVXqMxCoVAYRV9ZsgsvREg14mJPNRzGXk2v11kuh1smrOZlCHWjHtH5/Kby5HMtSlOFpRmm2YVhE+W5TQrD6Pv/c1+FF0h6pkff02ab4c50cickXypACcbOKm9yiEDL0PW/rTZJPOq/k8WDOWIuyNS3JrR5saqz95W3e2xElRba/hknszMvhl3izvCNMRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvA6Y+p4JfiaZn90WKszcx08xYhO9dzis2L3CNdP2sk=;
 b=Kpc+pl567pcOmhfLumTxnmcUW/o19wYNXhxJNoaSvTZN2LPJ8q7lhvukY9z4RyAZqdbTOOnRmWnc/UkoSFtS1kOUEUkPGB0NsBidD8LRxp9FakPurwRIrNJgDlX1XZ6n9rY3aH9W0jfL+yinCaNb3v+pk+6/KL9iU77T28iUx6VYmtnTAcy60WTBRsmKES4KHTRdnddGlxGMGg+v2Wiiqmt0z9NE+iXSL093cbDIVrQQfTHJv2o+A/Q5rspudZ6LSr47PBTROsmil4qN4JsFlJY298XThgk0IBPQZHQV9vOwkaoNuurFwKbEcgafcdSJzDaC6lC1PLtEAfsuPCe3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvA6Y+p4JfiaZn90WKszcx08xYhO9dzis2L3CNdP2sk=;
 b=piXKrhHexjDBPH7A4gJ/Iis6MkctvzbKU8dFfxMryCHuaYbsSmdSgW0MWUdzHF05Kg7zo0vxI6gqLwxH82eNBaJTYCig+ufdECMdu2KN+DUygLjEqHGUqME30SjRHlnXRZPq7nuGRwELVx53uL1u+B2P5U6wD73ym6+/I9uLRF0=
Received: from CY5PR17CA0048.namprd17.prod.outlook.com (2603:10b6:930:12::9)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 22:44:43 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::a5) by CY5PR17CA0048.outlook.office365.com
 (2603:10b6:930:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 22:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 22:44:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 16:44:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Melissa Wen <mwen@igalia.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Pranjal Ramajor Asha Kanojiya
	<quic_pkanojiy@quicinc.com>
Subject: [PATCH v4 3/3] drm: Drop unneeded selects in DRM drivers
Date: Wed, 7 Feb 2024 16:44:29 -0600
Message-ID: <20240207224429.104625-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207224429.104625-1-mario.limonciello@amd.com>
References: <20240207224429.104625-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: f4065828-154d-4bc4-8701-08dc282e60da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1b1X7m083qjhSi+NNexLHp+OfDCvEZBm58o5SdcXhhcpDwcaAm0X6adFFYlNMsKE+exu+5abaXDBGD2dutOdoVTrgNek/R/PNxAjzbBlON4d2cnqZO4UsSH/oJ4/M8mmzSto2vrpOLsJtsE2rJm+Bf/iM+ki4Uk9njy0+j6RfQDwq5xRYF+MkqbRM5sXS+D+1ayHC+YxUbZoKu4Y3ZNuwnbm8iQb6+0jqPT05YqnhOtBh6DRGGoEck0gwhlEDr5kNNzvsrMAkb4Zyy5cLxgPvi3GoFBncM6UqbMDFUL0eAh6F0UDtSuYw91srJGFsjOQrpJUF/Bd1uuSHgdkUcwLiQ5yYeUvGv8qnmczE2FMS74HVUSWOUkHM5ISOqapRVQTKMyFTFYpoAwBoQhkJRrhccYTzJTrRbyWb90UD8UaYKujB516pX89DDdOd3FfxZX8Gfjc3PcAeAWs0PodrHi5Iiv8z/fesUEbXKMzqLmxPukXb2G2MV79Ic+odWQ2ammIpx5j2WuurSPNQPFpwIR5Ro0XbF41CcFSktmlSVYafxNis62isCKEQ89o1fUv/Z2tRIHeyH5hjIATqhetUJZxL1IcXHac2JrYOgHwHLUOGI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(26005)(2616005)(336012)(16526019)(426003)(83380400001)(478600001)(1076003)(7696005)(86362001)(70586007)(316002)(70206006)(4326008)(8676002)(54906003)(8936002)(110136005)(356005)(81166007)(6666004)(82740400003)(44832011)(36756003)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:44:43.6121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4065828-154d-4bc4-8701-08dc282e60da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753

All of the selects on ACPI_VIDEO are unnecessary when DRM does the
select for ACPI_VIDEO as it provides a helper for acpi based EDID.

Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig | 7 -------
 drivers/gpu/drm/gma500/Kconfig     | 6 ------
 drivers/gpu/drm/i915/Kconfig       | 7 -------
 drivers/gpu/drm/nouveau/Kconfig    | 4 ----
 drivers/gpu/drm/radeon/Kconfig     | 7 -------
 drivers/gpu/drm/xe/Kconfig         | 6 ------
 6 files changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 22d88f8ef527..b2178a5a947c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -22,13 +22,6 @@ config DRM_AMDGPU
 	select DRM_BUDDY
 	select DRM_SUBALLOC_HELPER
 	select DRM_EXEC
-	# amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select to work
-	# ACPI_VIDEO's dependencies must also be selected.
-	select INPUT if ACPI
-	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
 
diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index efb4a2dd2f80..6921ef67b256 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -6,12 +6,6 @@ config DRM_GMA500
 	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
 	select I2C
 	select I2C_ALGOBIT
-	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
-	select ACPI_VIDEO if ACPI
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
-	select ACPI_WMI if ACPI
 	help
 	  Say yes for an experimental 2D KMS framebuffer driver for the
 	  Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index b5d6e3352071..476da09433bb 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -22,13 +22,6 @@ config DRM_I915
 	select I2C
 	select I2C_ALGOBIT
 	select IRQ_WORK
-	# i915 depends on ACPI_VIDEO when ACPI is enabled
-	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
-	select ACPI_WMI if ACPI
-	select ACPI_VIDEO if ACPI
 	select ACPI_BUTTON if ACPI
 	select SYNC_FILE
 	select IOSF_MBI if X86
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 1e6aaf95ff7c..61f531abd3e3 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -20,11 +20,7 @@ config DRM_NOUVEAU
 	select ACPI_WMI if ACPI && X86
 	select MXM_WMI if ACPI && X86
 	select POWER_SUPPLY
-	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
-	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
-	select INPUT if ACPI && X86
 	select THERMAL if ACPI && X86
-	select ACPI_VIDEO if ACPI && X86
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	help
 	  Choose this option for open-source NVIDIA support.
diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
index f98356be0af2..12149d594100 100644
--- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -19,13 +19,6 @@ config DRM_RADEON
 	select INTERVAL_TREE
 	select I2C
 	select I2C_ALGOBIT
-	# radeon depends on ACPI_VIDEO when ACPI is enabled, for select to work
-	# ACPI_VIDEO's dependencies must also be selected.
-	select INPUT if ACPI
-	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index e36ae1f0d885..cf60bdcafb0c 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -19,13 +19,7 @@ config DRM_XE
 	select DRM_MIPI_DSI
 	select RELAY
 	select IRQ_WORK
-	# xe depends on ACPI_VIDEO when ACPI is enabled
-	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select ACPI_VIDEO if X86 && ACPI
 	select ACPI_BUTTON if ACPI
-	select ACPI_WMI if X86 && ACPI
 	select SYNC_FILE
 	select IOSF_MBI
 	select CRC32
-- 
2.34.1


