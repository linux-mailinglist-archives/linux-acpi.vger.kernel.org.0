Return-Path: <linux-acpi+bounces-8997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A649B0F0A
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2711C22139
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACE215C4C;
	Fri, 25 Oct 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WmyuSHN/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A80214427;
	Fri, 25 Oct 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884692; cv=fail; b=Ewvx2ixcDETztCpMV8Reo69NNUSZ5t1FW5eqS6vt2/tWFL1yCsPVqcurhGc3ZlwCa2Ypp4vW34VshsXK0hgfrKlhGaypWkvMb+To+jIZ6mBDVaM9onSHSZH8jfSBvko9OhF3TDVCTV22sF7v1MtQLrRlfe11yuvAq6X7gSAA4K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884692; c=relaxed/simple;
	bh=k/ANqFqNEwWa5R2ML/JsuMGBll6V454USlLRd2ET8Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1gbIlNL2+mrQbOZxCRcEJTzEChDfrfnD80IbuIJiA6RNBEyQ19HpwB859Fs2BX4+OQlD54PWSJpi4yM/ucrs6meA208IXrFf8OAPMUIokhbWNc6xp6P5Z6VoS0UJt3WWlqdi24+Z32fE8p8ylqHFNP9QUFhCQQfLK5zEU0+Wt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WmyuSHN/; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lug6okoZi58DWxp6/2GAWt1uN4MDNhycP5up9FN+FkdumMcyeTdR8fciWM0V/6rjO8GGN7EqGE0/0iJ3Ml6orvMYPZ3r1VCp4NS5nIF3L6PnfF046rIH5fUAdlpjpFnxTCrGas34SbRRP/3JwiTCfhdNdi3QaFt0AN/hy5vLJT/HFIDRTA6KWfuEetPFk4qtoEhyHuoTc1wAyv2ax95It6mJZyDrr9Me9EU7ATD0jHzSdXDiHHYyKhTo0x85w3iCBPCkRuARegj6og0/tYPDdW0i/jQtR6rZZ+YSpuC6n2FD8dWC+v3chiTodlzVFyBX9dwC9hAQlSQfxBWp1y0I7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI4g1QYxLoaoVfoLJKM4B0sPq2gWIRwShicRPPMw/d8=;
 b=FJ6BFCFSTDJxj5y7BsXf/osHvyesP4hyH3a6Isv7Voxp91M7kAh8mJ86TN+tLSynezj03FhGhUTQxHAW3+aWCOZpMso9j/h5v73aKzjDg2tNLh2JNNvCnQpDA1qMDZoOVr3WoliGOOqRvxwZTbNFwWgIuYLNsLTbiG9X9gB9oVi0ocaqaxsbivMRN5XaqrVBc8TJ2lrmgfZ+CxsV7PpDI7DGKOT5r7sqk2YP6Ej7p6bqiTmkA1sIXZosYmF1H84kXoFVpCCmh//cmKcOdci9LQNpjaNwtNO9HxLpHdhixjOBp31gBUgHJ5vQA/EdVnAeq7Gl/14ZbQxMKK5xd3mx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OI4g1QYxLoaoVfoLJKM4B0sPq2gWIRwShicRPPMw/d8=;
 b=WmyuSHN/MYnqSnFtzpZJpltLMcC2w8Qd0uv/uiEbNkpS/Y90Icw7O0HPm6YeJKk2PwvbgmIiOwMrZ1LK2sCULaEbZ0impe8HZrevGMe8U2IXm0irVfiNb1L7+qHQouVIrcOIfdD74EkbRoHV+SI8p0CWAI+JgkTsMER8Ig3yttY=
Received: from BL6PEPF00016418.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:7) by IA0PR12MB9047.namprd12.prod.outlook.com
 (2603:10b6:208:402::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 19:31:25 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2a01:111:f403:c803::3) by BL6PEPF00016418.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:24 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:21 -0500
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
Subject: [PATCH 6/8] ACPI: platform_profile: Only remove group when no more handler registered
Date: Fri, 25 Oct 2024 14:30:53 -0500
Message-ID: <20241025193055.2235-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef99606-3026-4fc3-b790-08dcf52b9d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5xjng2U4MHVH0zv1hVTPKSonS6Vzc5kujFoS85UCvjiQPqicTBhg4Zi7H2IB?=
 =?us-ascii?Q?8bC5DYKpauCc+ijP4bPXj9u/HfVlTECrxvk1CsUVsDurZi8EQal5Oqq7QVV0?=
 =?us-ascii?Q?JFZkysR0XSHS9iC5fFXqg/crchiobCUwQtZTrsFYSPjakymq9/rTVEaNMonN?=
 =?us-ascii?Q?j8SV4Xx4qrON0zYLtH7OU5vUmcJKxoE6m3z5filBDIuwE6Whqn3++w8wYNFn?=
 =?us-ascii?Q?3RiNQ3+WJ2npF8xESWhvLDjtlEvuGvDzHXt5EQa5rOtPngvp4MhOcedeqT+C?=
 =?us-ascii?Q?hP2c08ToTOG63CZCzdyn07xRZ3OSrRajMJZdIu+JWW6gzlej9FM34DPiYxhP?=
 =?us-ascii?Q?CwIoBarIWO1ai/2658jfEo3qU5ZnYRu1mCl/bQ2IGzPoGAMoc30Xzy5awxEL?=
 =?us-ascii?Q?6x4KdOm7YlZANwh21o+7EEYalrz8N6MMUIVICLOzQflw+fyI+H6sjxBPL8VF?=
 =?us-ascii?Q?5tsWb84jVXW0Y3SEYPceCBJbTWYxta4c3IhdzEFOLcH2aBqhwIarUOBFFz3w?=
 =?us-ascii?Q?7xH3KOWkgWdtbIBMxjS+RNErovmxn6XcHN/lAOgRVH3vmp7w9NIbZfaF4Iab?=
 =?us-ascii?Q?QHOP49nPIDYfIkQLjy4ihCeaOC4sptV3XcdoZ/Prv8bsoQZXDyPOQ9mq82E1?=
 =?us-ascii?Q?ElqDchZdwcyAWGtIhU5VUPgIz2w0zHNdydveFdY6wJ1/Y5MGQSQnRMbylwR+?=
 =?us-ascii?Q?WSvAKC/BGvUaPzk2uzxq9733pYfZI4wabI0Md0Gwzn9I1vfJVJf15Om90a9g?=
 =?us-ascii?Q?qUvZ71knnN6X08cF+qeycR6J/OZ4qp/qiAjIAS3AL8wit5zn8ydOmsokMTnC?=
 =?us-ascii?Q?33bxbLHRwnxyY4hng00Oy4ny50D53PhES+2rfuJRTKvd6BMhNyQ9r9cIfsYC?=
 =?us-ascii?Q?FOo6XWqNIEc3U7rmxZEPOwRBTt/nyY3/pNAXD2UWvwUzmJ2bs0XFdicXVOnl?=
 =?us-ascii?Q?nHy10RQOVFSuPggzbPl5/S1fI7xALM52sgZ5HpJgZTHIOSeKupNTVMucqjtU?=
 =?us-ascii?Q?Cwz+2gKZ+TyCyt7/+5h/5zJadNhKOy+6bS7hSi+xJTyY88k0ZKXs4qbHABsh?=
 =?us-ascii?Q?Zup4eAbmmVkID823ZZkP5TJ8ZxBvDQ5Uqw8hU0Xi354pLOLTmPMnSRlB7Vid?=
 =?us-ascii?Q?j9oePVoXACrVBUixbAmDlFT3M0qUOw/FkXDGWzd8MEoM/NOH1915y1aNdxsJ?=
 =?us-ascii?Q?iloBLrTFYgcjQB9G1xDiq/vaUaV1ZWEv5ELvR3OHC1Aff5rH9WbTUeRKHK4Z?=
 =?us-ascii?Q?fAzkQv38hmiBYPDsVHsMQxHDE21P8dVDQ1OGGrCVapiKm0Ht+RaBPIDBjS+1?=
 =?us-ascii?Q?jWZcICP1XP8SIzSLCUpExxSjTABF9p27ZPqgv8G/qvmZgO05EjtW4Ay6oSpq?=
 =?us-ascii?Q?iQNUXL09Yee9vjay2E0hAMjcu0agj9n70I2/j/oaWK5fnuR79w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:24.8535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef99606-3026-4fc3-b790-08dcf52b9d2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

As multiple handlers may register for ACPI platform profile handler,
only remove the sysfs group when the last one unregisters.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 81928adccfade..091ca6941a925 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -23,6 +23,15 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
+static bool platform_profile_is_registered(void)
+{
+	struct list_head *pos;
+	int count = 0;
+	list_for_each(pos, &platform_profile_handler_list)
+		count++;
+	return count > 0;
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -206,8 +215,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
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


