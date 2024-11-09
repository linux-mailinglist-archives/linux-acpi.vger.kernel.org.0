Return-Path: <linux-acpi+bounces-9478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443C9C2A13
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A821C2195F
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220D01953B9;
	Sat,  9 Nov 2024 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MofeEMeM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10A19414E;
	Sat,  9 Nov 2024 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127384; cv=fail; b=AvVbrSaBe84piIpU1/0gV7xTNCn5s+Pk+nkvWxu/4yh4L5uXRFJmLVkHwgjG0AP10FdBHqOkFtkTjW+EU/LP/m6bBjDwtZh9uOvDCfAo+lNyhIaw4+mYfLXJKte0L08+JXS/WhjnnjmBojebZibD8gJJ45vx2KqfvU/nnRXjN/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127384; c=relaxed/simple;
	bh=3B+dpjIHZLzwXnNd2dzibnbD3DvZu+qvT4q+s2VuMPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB6trqyjrwgS3kwNRfhc5S7Ssf2F2g1KEHBPOxFHVex1ndQglrZxT2mOWZGmxIEDOKQAehOlKMR71hHYbpo3y1rV1rISvPIBRFHD34HS9ka811hSU4H+kHntz0P7viCtmmIdPuJPzXscpbgpx/vX2+6XEuec5RgSq3pB67t+Vm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MofeEMeM; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYL3IZcV3WG/bxpg20puDremEY5J0+vZE10biTmXVjMTL3cNJUy7+qlky+0Lbb8eLCZi9tKuPbXL23cg0cyefmCwLWCCLdxDiGndUb9umq1QYbHBvaQFCi93Fgcn66egvxubqFTlKAnYh74NNiw1hWDusC0LVlrD+XS79kr3Saf9vci/7H+MMfs8r9gJ2M6wTgjFDLnZHeuxLHXWIs2ZNoT/45kuCj6wLQxVoOO7Nh6biJr3xDW4X57uqBYH/YeIYbxfQEIclMKrqlMz1DlMj1tj/CQazdnEy5YsKU+l5f41DX5Q7MYbDFUnvbB9P7gg9ZxhOYSyOtNUZe80Ta5XUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fC5Cm4kxPJvgqyqj/FkinH308BLgLXliGBafw3INL4=;
 b=bCh605xI/5/en/AWx6TwLKL01r54qtgApfo4DLWwfjpb8sIvwfIavSkbK2ck4YbRnRsw20+hq7+WG7NU+UK96LLsPTRuE1/zSy8zff+HqRlzRQYKrJZ/m6J3A1pybAD/2brbofn5BBIP3AD/Q0SVMP/aL300+nYtThpcRy6DLNKNSkg7GfligNzYzOtgKyEfMjI3+lbI5VL2wMYHBhNjp/yg3jO4uG6hSuSCB9bO2eDaX2+mOy3+ayUTDntKts8+swuGUPsCNMZBHAZVD5dcWi045WYdhDYuqGTEG0Ovthh+Fh7nOQG8KT89mw9+5h0Z32TFvDZBbBS9Y/ejxERIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fC5Cm4kxPJvgqyqj/FkinH308BLgLXliGBafw3INL4=;
 b=MofeEMeMd2Sr1GX9Eq3OmJxW401A9sPh6nWgllYVrm+m2lL6qkXH3fNfDEK8t45EPmtgEet1e8f3RcGd+yHOM+oyN3zhoWOb1uWd1EDyOWPiLqvont4yxVZgPr04TByXXaWP3OQuhv+3O6syGfrMUdLwauXLbs8IhOy9YCpjt8U=
Received: from SN6PR04CA0102.namprd04.prod.outlook.com (2603:10b6:805:f2::43)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:58 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::22) by SN6PR04CA0102.outlook.office365.com
 (2603:10b6:805:f2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:57 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:55 -0600
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
Subject: [PATCH v6 20/22] ACPI: platform_profile: Allow multiple handlers
Date: Fri, 8 Nov 2024 22:41:49 -0600
Message-ID: <20241109044151.29804-21-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: a1306266-45d3-4da0-e29b-08dd0078fbf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NRV8hp0wfkF7gRQj6IzOAVQtE/IYPjTHr/EAkLAV8AlG6pMhWKkSOqqFQlmP?=
 =?us-ascii?Q?ha74elQk/0H2kD2DMwPSu5xj9i02bf5jW9asFlWC0MLjUqJnTdhtLYq98SMX?=
 =?us-ascii?Q?9VO46HDiJ8P9wZBYOwx+wjNCIK+mfTwddbIBJEtUZeqJh48aBNbEvH2gCOG8?=
 =?us-ascii?Q?lpWiqPX6X3O+KC4l3RrIXZS8rZk32GccUpyQwZv41HQ5Sx7RQXcsqlLnRb1h?=
 =?us-ascii?Q?V0OQYzyUsFsy/ZRUDK/bZxWHa8NT5OKqGolGvlVcRo8Ls5cYQUlsHhgu/dO/?=
 =?us-ascii?Q?b316/WRtu2nyhqv21hfF/ijI7Mg0JXKeUt5IYAvHdOSN1oOoUBnOKk2/QOYT?=
 =?us-ascii?Q?X0D71BIbJ+F+5UiELpbAunsuTAUxau0PD1F4CVMQcDJXCpgUpz0/8INqXjVQ?=
 =?us-ascii?Q?FRNikp8ddfjDvL9g3Zga76728+vnJNy9geOUmX9yX1R7gJoa2J9OyOWTLrQc?=
 =?us-ascii?Q?l5Pge5N+7eG+F3DWvwjvEDz9U44PLGFK/raxfDhxzab9X5TYSxgjHRbGz0n8?=
 =?us-ascii?Q?fKXtB8hKCBsWe8vqfyxkh9dLdb4psvq7DKA2koEYccxXndMzmZHL2txLuqVz?=
 =?us-ascii?Q?z/aRKgqFwCvuqbnL+a3008fgaPha0vHt9BjDLUqPj2r2T8lyxc3X6YYodOia?=
 =?us-ascii?Q?8rzshkKHSq2YoxBVKIfAYeEJwHSQT8mwbeX/QeelBl1wT+PRLBiopQ23acQ+?=
 =?us-ascii?Q?HANvLyWKTxnrMt79BrrcTrk6h42mv+miR1rS+gU2Ueh1mqg2PsOHZiZ9SaHM?=
 =?us-ascii?Q?B0xXfTbV+7sYtNcevCq/L8hvYJCenu6AEKsfqzpr5Borzr0shNanaLtDBqVF?=
 =?us-ascii?Q?oGjDD1LJ9O736AOxFQUaqDXIk/6iaEQpYtcK8YVsTmuADU8ZLw4BH0cTxEZi?=
 =?us-ascii?Q?Z0MHNpCtnzOPBsMhHJDh8U2PQd1K58coJAYAVcCxJFSfUM8V3nCnEBflfcRe?=
 =?us-ascii?Q?TiF7rjYayPy4Mxvr6Z+2XTmBlODjfHjEVodqeSn8DGa80UUrJmogobZwNypf?=
 =?us-ascii?Q?UuulDKoBCjRrVTxXz4sLlj3OT+e5gWczDEf89LUtDYPPSge0xbKFCXDKtyAd?=
 =?us-ascii?Q?wGp1xRFCv4Utl8hQBF1JuicHEG5yo7YfBhKNPtYG/xgn4dCx7ruJ7iJLCJHn?=
 =?us-ascii?Q?hcnSSGGWnwJnl1I5PqW+hW5Ezlz2PlRMlxM6v92ZitiFV6qIQORA3APF3SP+?=
 =?us-ascii?Q?Qdz7UIgPS+JFfJF0mOCp8Umt0Cb4tMOtOaH1y9/yC0O90A96Pi4I5lMqX7Nb?=
 =?us-ascii?Q?+89VBdzST9zcn+0pIyFdOd7YNoa6QWdVueqd+HES7uLbILmgVntMKdgcR0/f?=
 =?us-ascii?Q?IcAmMDZTt/rgSRlWoLFv8p+nKXJRymZNUE55SpQzZ3F7vGLlZkN5anwDAadN?=
 =?us-ascii?Q?UFrSRbwALJ0BD5o32pZs1LmdqR7I3+AKppDTzH6jzBjl+Hc4jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:57.9230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1306266-45d3-4da0-e29b-08dd0078fbf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

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
v6:
 * rebase
v5:
 * reword commit message
---
 drivers/acpi/platform_profile.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 7ad473982ab11..0a8b86b44e161 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,7 +10,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -415,8 +414,7 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
 {
-	if (!cur_profile)
-		return;
+	guard(mutex)(&profile_lock);
 	_notify_class_profile(NULL, pprof);
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
@@ -480,9 +478,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	/* create class interface for individual handler */
 	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -498,8 +493,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
-
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
 	if (err)
 		goto cleanup_cur;
@@ -507,7 +500,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	cur_profile = NULL;
 	device_unregister(pprof->class_dev);
 
 cleanup_ida:
@@ -528,8 +520,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = NULL;
-
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
 
 	return 0;
-- 
2.43.0


