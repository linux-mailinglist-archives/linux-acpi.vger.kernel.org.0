Return-Path: <linux-acpi+bounces-9403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DD9BFE24
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD91C21816
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEEE1E049C;
	Thu,  7 Nov 2024 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y2iv2TAY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F81DCB2D;
	Thu,  7 Nov 2024 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959442; cv=fail; b=Tc3fk+MAxpRpesoRdsJiVIz47znMctaHpuebMOTG5REjJulD3WzvpctDV7ehkPfPiXRgTOCqrxgq9QLnMfpGJ+Z7taLRZ2YzKXP5t60FvDOQd+2kurndsdVWlb+8woY02dGU/QNZ6JbSO8W5ub1ziXvewd1A7udH8OIRvZMS2jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959442; c=relaxed/simple;
	bh=cC4TbPX/VQOnAUsgBwm00InxYmXfz2kAuwh50Eqi8Ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzCjRE/VGTpE/ZwYEqYWnyS8z22yfMTa4d2ZmCBLkmU0eA5bHfK5ohNdukWLZT8A8f954XsIi/fy0Xyejq0G+rWn8xAVl3qk+vR0MkpT6n/a5eIGnFfa6pa98D9jWPTu/95kAku1+EMaGezSRaBcyYtEZULm3TslxuRcseE04ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y2iv2TAY; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSzlxci7NaDZKPujspxo8B4HZsYFtzPx3F8rsV6aKbfeS4BfKy4bMaR0U4KFw8EkkH/0yb/kJtnFz2SRqe6BzQqF82FQux2xpwkUaax6fzSZe9H1yWK1MkSRR5iws7Qoey1vYY0rpfLAhCkNbWHAFq9t3g3qqknDOWXj7xGGPSU4vKoDv6qp+0z1qPRrB986h7ofKXlMbRd3y+b0gixymxVQSA6U4EHEPMANccRvF3CFWNNSTiG24AU5GXkON6FvDhoxsaI4M8KvHulBIPaOZqNLkMCmeb0Fi2CZ0rIG87xr7Mn7ubSoMTGcBCgWHiv1o7237GoBuNWavGrUqvHY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1d0S4zb/ctgwx9iRMLS7vElenRqrsErndD/UwbSOy4=;
 b=gm5MN3uDW9AvfoOYQlizmiujTepLkI8w1kHYJCylWTJ/D9JkcoRCdoz23yvVUlgpCDhQJfGcUiOcdtGWuyjcVk4JxkRobXcNut+hJtQE0lnbvokshdUXo5BfeJiljtAJz9czAGRAdRs+AFMwK9w1MlUplFJvs62dICukyDab2lq7bBbGfaubnRrREsvZwbQgq/d5zvDB/RtGQgukC97Q6KltUexE4AW5kZnoyasPXchhhBU4rFc7B7QZbT/7YOujAm8nZryx/AWqjkReJnAeWvR3UcEsFsMIANjrhpAw2L7PXKKmElCf7ErATQjVLDI3KuACK/CBHwOaeh5mBw/Gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1d0S4zb/ctgwx9iRMLS7vElenRqrsErndD/UwbSOy4=;
 b=Y2iv2TAYbyLyF+DH1GB+MA8XhLaSB3yTsZej2sYV9VS2RgfInlMu7VFb7dFGoZB0OlbQDXRV3DT8x5W/xHnZlZIVDNLnGtJU8gqR5BUobsc8QC0AwhU3/ZlN4bAycY6gsVc+VTSE0AwOh86djHABM8tKze77QL7nytpP0efhpXI=
Received: from CH0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:610:e6::30)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 06:03:57 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::b6) by CH0PR03CA0295.outlook.office365.com
 (2603:10b6:610:e6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:55 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v5 18/20] ACPI: platform_profile: Allow multiple handlers
Date: Thu, 7 Nov 2024 00:02:52 -0600
Message-ID: <20241107060254.17615-19-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 51eb5401-3ca2-46f9-924f-08dcfef1f79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Yl8zHtshcz2a1Exvwyp4li08VjBVFoODLBUtw+oY1ND1CbSIbgFiOeMasCE?=
 =?us-ascii?Q?V+cQHZfUzuh6HxCisJLukZfw9FEtuJ6BPiBppCS/BtL8/aCjewPM5KODI8AZ?=
 =?us-ascii?Q?JyGiEiZCn2Ay1r1Q680jEEuqpKMD46/fNMGywrLaRvsy8XiDmEO1rmkF6ZC6?=
 =?us-ascii?Q?N0cEfI5K9BYYykFG91l8f9OxQWi941eCE4qKw0k3ZS3UHJnld0llK8eqHFPD?=
 =?us-ascii?Q?Vm9VU8noN9EMV7z0sPK3wwhFeDbKvQda7Tyma4yrlt07ycolU6dzCswpKNaR?=
 =?us-ascii?Q?0IRJIQhC3rk0rGNYjJVSGdh/wxCzpOdEf8/Djid0hXe5cJPO1gXA/dt0IE3f?=
 =?us-ascii?Q?xOg7ju4uRCHnUXtq1BZSTh2DzM3C7TugCOB9olXc9tUo/uxIJ6JBx0rlqkhW?=
 =?us-ascii?Q?OrB/QJeSPQo9QGcUrtlre0qb4MRWIdd1IiDmEqj+M7OH4Dl7l3+ax50lxCG2?=
 =?us-ascii?Q?zU1/ODpb6ITIr4rHqJ8UUjl8EWSJTpHrx51Jbq4YNf8NQ9W49UAwvtmWZsyS?=
 =?us-ascii?Q?egQ54kOR9T4rushCGBufRBq5nplAMz/DAcViUOZ4iWvWYRMJaKxCcKzukqSH?=
 =?us-ascii?Q?PJwSORQ0GcU6qhtqAsMmw79xXKIotQJQxyvuR/IJ1qLOO6R7lRRRcrp9UMyW?=
 =?us-ascii?Q?C/w6lMdqI/O8ADQlrf+vHL7ZXw7DXK3d5ZUdU1gBR7F2jIpHRxQrCcjlvtgn?=
 =?us-ascii?Q?CkWAvMK9zqjGB0wnAm7JujjxMe6T5vJmbI1n8/3H7eZ4URuG4q09LLF4T1Pq?=
 =?us-ascii?Q?McS/8CCxlKP+RdC1zX7dOmhSLcN/6oQg5qTdWvrAB5f1004gOqymY1Te0TGN?=
 =?us-ascii?Q?nwGwhbvQNQ8G3zAfbJ47cLx0F8faNrmq/rIXjF7cudc2hWQUyUbDWE8v7W61?=
 =?us-ascii?Q?gZYY7Krk7Z/YDaQbszCLTcPrjm691nKR2Aam/aHxZulUCSgP0X86PArVDGoX?=
 =?us-ascii?Q?R+AhqdGFWV492R/3Zf1cJhces/Di+3crgggg5ikNhD/7LGXFLWh/v1Ly/aDo?=
 =?us-ascii?Q?4li4D713KXukplMvab5t3AxpMHxgKnlQEKIeBwRTCxhjPdq070miBBMVF/c2?=
 =?us-ascii?Q?P+n5GfD33YjunNcVrvSOXccKNZAq7v4KR31p/wlBPI5//rsXlOH6Hl3WUhoe?=
 =?us-ascii?Q?T4mRh34cgtZwTplo+lIr7qGhhl8AKTZOAgzcGxDctu7WLku1cxzjSkpTz2Sy?=
 =?us-ascii?Q?6sEdKOO4m/lhPIIxZ/vmzuElWXsCOHryF+WvF0tei5UEYBmcnODFANCkcMpD?=
 =?us-ascii?Q?qXEFW/zd2lyc0uKpQtCYtfS9MCP0WmWeiTSb2766mWOfyUNZ2uBm4rKK/Nv0?=
 =?us-ascii?Q?ZKoz6g/RMbrdl3UCl7V6N80C4wo1ADFZnSlU8MwcbOpXRHHc6uf4ikebimlf?=
 =?us-ascii?Q?lm9lV8rC0FF1aqWlSNmPtciffZkcmuegCkPBxG3euiacqsJ8kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:57.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eb5401-3ca2-46f9-924f-08dcfef1f79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251

Multiple drivers may attempt to register platform profile handlers,
but only one may be registered and the behavior is non-deterministic
for which one wins.  It's mostly controlled by probing order.

This can be problematic if one driver changes CPU settings and another
driver notifies the EC for changing fan curves.

Modify the ACPI platform profile handler to let multiple drivers
register platform profile handlers and abstract this detail from userspace.

To avoid undefined behaviors only offer profiles that are commonly
advertised across multiple handlers.

If any problems occur when changing profiles for any driver, then the
drivers that were already changed remain changed and the legacy sysfs
handler will report 'custom'.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * reword commit message
---
 drivers/acpi/platform_profile.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2c466f2d16b42..63ef192f1a07c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,7 +10,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -401,8 +400,7 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(void)
 {
-	if (!cur_profile)
-		return;
+	guard(mutex)(&profile_lock);
 	if (!class_is_registered(&platform_profile_class))
 		return;
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
@@ -459,9 +457,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	if (!class_is_registered(&platform_profile_class)) {
 		/* class for individual handlers */
@@ -487,7 +482,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
 	return 0;
 
 cleanup_ida:
@@ -511,7 +505,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


