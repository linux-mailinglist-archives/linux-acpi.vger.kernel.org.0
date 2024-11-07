Return-Path: <linux-acpi+bounces-9405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605219BFE2A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838261C21EFC
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE21E22E6;
	Thu,  7 Nov 2024 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cQfzosWV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8831E1021;
	Thu,  7 Nov 2024 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959446; cv=fail; b=lr83RO1eQH1IE0/PxJ0hjl+pIF8c8rF72UzJWLAucgy/J9P2284PU/bYPBBpGe85wDgipADBpKAZ+YJ1kAOAAC5xr32wofah/lZxfv2WFAvGWvtXIH8HF5HwQ8smz3hC+Z7P+Vs4pPJEP2qbAwE0k6wcC1DptX6mUsZXxbovI2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959446; c=relaxed/simple;
	bh=/+/ROlHIruuC8Ptk3wbPDnl/Q1PdBpPyHTOE4QQFJzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FboL7XL+78UDbOf8qVRZA/W7wOb72IkBKYooJtrKy0kel0haPcbHdb/i9ZK0uatF9JmWHjY1RvHFaZ80b8J2bNHCOB3dAFXY1aArUCjfNDAQBPJDOkgTcSajCxuMxH5q45gcAXgumrmFt0SHNHPest5j8C7sfWFWtxovQ57cAHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cQfzosWV; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs2kiiFqYTzWSVsEpx6+0JLjuX+G+Wb+3xF/o9EHKF2p8LzBzbGUdsExu39sCNO1tQglbPyvZjNnqISiGckvka3ajgj2CUW7tw6KJNUqpTuKAxbYsn8hSMyccq3dWapvDH2Y+/RWbGjQDwKUNSW5/4yQ5xStrj/vAv1T0POATBkDCnujS56Zwx5k8CHc52KQI9mUG171yRn3C728dhKmfGaCg/dglvIGcB7bSCWwDV7PPZ2SlXQMAnR8jfpMiC6TVYmLj6EotWalgrJBAd0phF5VtelC/JR4B/eGLzI9jX4JzHCvgl6GA979tHMJdDIjuWeaFcCXoirX81IYexurQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMYzj0HO6grQuskdeKK/x04e7ys9n7Ov1LkG/6DM3OQ=;
 b=BByhBn7UwfU28KDeFiy4sQSKny/4sOgx89bAnXrrThgSgJDjoiAPnC1iXOYaBYeA56rTpzDqVEpZ42SqVp2SC05bNJ+h7+pM4iw9W42KtpBn3QtT/WJLjgWmbCPpF5HAKnJ2r5E/Ye8SOw4kE3SkWgv/7Q6y+TOKiR4Y/mKL+uCefIqIWFeZysYXKw+k4cOVjXWZHdvQtImRLU/MxeQiF0JDYzxkqdTeGxTyKmNnPRqTpJ7Ps7EW/pJo2OE2MgBu4AkmMSozb5Q+WH+ij1RUb7tCMYWtAWSstxTZUPGGpE6vkvc4WPCowjETibqJkylaAN79A/sXsHfbmZID224AqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMYzj0HO6grQuskdeKK/x04e7ys9n7Ov1LkG/6DM3OQ=;
 b=cQfzosWVzhMaIL+FoTpVCKLdC+agqHJ6UKhK0fxpJqHPlK5lhbmfaSXefQ1YAWZ/8reIo4Xk1TyDCQkmBdf1UPtW0mn+i7W0oKQOM/oKMcAfglf7NG2nnXYJTr9F6LTy/jR5vqqVpJUdaljIRYjuJxS6/bw9YcyWrKqQo4aGjD0=
Received: from CH0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:610:e5::32)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 06:04:01 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::ad) by CH0PR03CA0267.outlook.office365.com
 (2603:10b6:610:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:04:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:58 -0600
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
Subject: [PATCH v5 20/20] Documentation: Add documentation about class interface for platform profiles
Date: Thu, 7 Nov 2024 00:02:54 -0600
Message-ID: <20241107060254.17615-21-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf4ad12-8653-4c40-d710-08dcfef1f9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zKNmSVcQE/bzmy+yP4SkyMUCC2qTqalsNxjc02NkUBA70jcMLGFkC0m92RGC?=
 =?us-ascii?Q?7TAsrYvvw1hOLCC7pGQqdO6tAIJeuCKU38shLpc88uvzO/vEL7VU8eK4Vlx/?=
 =?us-ascii?Q?4PsgJqEDpbmifr0cMollG+bNZFSMsoNARRebkU5MaSGkyk9TJsBVIiLTR8Jw?=
 =?us-ascii?Q?w3gHjaFRwUT0LASiZ3aneP82wQLQitg/LCpiab2dTO+BqrOCwePapr9KTz45?=
 =?us-ascii?Q?9kd6iAjpMGAV75TExS6zuD1v+gNL0y/Y7KZNsdG/3EibG+QhBPAMfgJAVPCf?=
 =?us-ascii?Q?/3+KZDllokPolqvmdtA0ESjHtK4dLSmwfkEauG7MNveal+Y8HCMZRl8VVYTK?=
 =?us-ascii?Q?3kCsa1wlHCpmEkeZLHXdy4UGbPoz74HTj8bIDOl2pjL90S2nLa/4aTodPETU?=
 =?us-ascii?Q?Ll771+sl6DegYmrig4ycYaVs2xDqk2ZDponSx2ABhXK3EU7vLJejI8b9YSZ5?=
 =?us-ascii?Q?+c5kLgyCX1bOQMujgohggrd4FB6FCjG0+maDreQP/g3s8p8GD9tdClc6a/hy?=
 =?us-ascii?Q?G2FlXd6497Kz/0sVgQyosAg58J7OzhH3TiXdYECB9taKCwZJsiy2WIZsaiVZ?=
 =?us-ascii?Q?ag3Yr5xSjnAz4H0kgx9k7QfmpvzKcWnJboOCwvpWa3XNYF+1hSN5jAbmvvMQ?=
 =?us-ascii?Q?MtmIa8BEfSHVOOk0kkpqucCdw4Xw/5nCdwPrx+iqWHnR56rH6nNKV1AyT/K0?=
 =?us-ascii?Q?7ZKa91KLoz1ItF64IkC0LPs0DMoEChOomY+ZnrbPaT8PN2p0qa/G4QXRLpZM?=
 =?us-ascii?Q?CjLGzWeJSdZ/Wdg9HV1iAk6po+yHqnSlK65X4wZjBcUY0sYfDaBVth32QYYa?=
 =?us-ascii?Q?GojLtFMrngo5GGSMRUD/SaASLuh0PNcNO+pcy5VAPhPZk6qLWF0l+bxOnCMF?=
 =?us-ascii?Q?BtBe93EdsRj/LDUd4+RHgVhiLgfWbdmv3cvx6rwo6zT4bBydibEoUBepo9TI?=
 =?us-ascii?Q?ArIFXC7YcKHnWugYIfVtMDwf3mUEQsYVkJspmqNxUA/Tyv4xmckckNAOAOb8?=
 =?us-ascii?Q?9yTXfia6zck74D2fFXuaaMlXeYLK50ApiY/DlvsSimVxgDii9Oge55WiBPOo?=
 =?us-ascii?Q?J3srM1NS2Y+qHVnxq/w+p+vBxBupNspV3vRhhyToDOZ3zXkKavnW4vYyIJPs?=
 =?us-ascii?Q?fBuC9P+A7c1Od3eiI9p/EzNyA7rXbgAcWHo3+m9dvOIq3vCCCvrcb5a+1AH+?=
 =?us-ascii?Q?y280LDdYZ/xVrC+IXHTq5dLI9uQmDlNFEoAHXAVcGsAHdTz0sObAl2RUMB0g?=
 =?us-ascii?Q?LAV2BVDKW8DI5E0NIedeE37AjxzUFxFRQEpjAsHDE58/f/iAd6vpQdFeqcRL?=
 =?us-ascii?Q?mNShQ9HV1FIBkTr7YAxF8F7zZbZ4Ju2qj8cFbA2lwboXeKdsGvuCHalzXIrr?=
 =?us-ascii?Q?nHAfp5Pp9sM7vlcKa8fw6LeM7vxCtjgyusWGBpeya0UQ4vkYpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:04:01.0370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf4ad12-8653-4c40-d710-08dcfef1f9d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521

The class interface allows changing multiple platform profiles on a system
to different values. The semantics of it are similar to the legacy
interface.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Fix some typos
---
 .../ABI/testing/sysfs-platform_profile        |  5 ++++
 .../userspace-api/sysfs-platform_profile.rst  | 28 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
index baf1d125f9f83..125324ab53a96 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -33,3 +33,8 @@ Description:	Reading this file gives the current selected profile for this
 		source such as e.g. a hotkey triggered profile change handled
 		either directly by the embedded-controller or fully handled
 		inside the kernel.
+
+		This file may also emit the string 'custom' to indicate
+		that multiple platform profiles drivers are in use but
+		have different values.  This string can not be written to
+		this interface and is solely for informational purposes.
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 4fccde2e45639..b746c30432753 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -40,3 +40,31 @@ added. Drivers which wish to introduce new profile names must:
  1. Explain why the existing profile names cannot be used.
  2. Add the new profile name, along with a clear description of the
     expected behaviour, to the sysfs-platform_profile ABI documentation.
+
+Multiple driver support
+=======================
+When multiple drivers on a system advertise a platform profile handler, the
+platform profile handler core will only advertise the profiles that are
+common between all drivers to the ``/sys/firmware/acpi`` interfaces.
+
+This is to ensure there is no ambiguity on what the profile names mean when
+all handlers don't support a profile.
+
+Individual drivers will register a 'platform_profile' class device that has
+similar semantics as the ``/sys/firmware/acpi/platform_profile`` interface.
+
+To discover available profiles from the class interface the user can read the
+``choices`` attribute.
+
+If a user wants to select a profile for a specific driver, they can do so
+by writing to the ``profile`` attribute of the driver's class device.
+
+This will allow users to set different profiles for different drivers on the
+same system. If the selected profile by individual drivers differs the
+platform profile handler core will display the profile 'custom' to indicate
+that the profiles are not the same.
+
+While the ``platform_profile`` attribute has the value ``custom``, writing a
+common profile from ``platform_profile_choices`` to the platform_profile
+attribute of the platform profile handler core will set the profile for all
+drivers.
-- 
2.43.0


