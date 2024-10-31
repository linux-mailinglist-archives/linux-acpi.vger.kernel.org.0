Return-Path: <linux-acpi+bounces-9174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDCC9B73A6
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1061C24006
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507713D886;
	Thu, 31 Oct 2024 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IVObesI1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3413D600;
	Thu, 31 Oct 2024 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347878; cv=fail; b=eureNWxfAEFzTxbI8e/7aNBemzV5pAZsyrNnMj6JZwQJPVCVAERdn9224G9aAVL1KrPT6OlQcQGuVzmgA1s2Th7AKKWu0G3vy2vqke9Y7Wda/J+NbwvsoaNlk5/2aEnmgn3uQcGVMtpWwThei5AU7PqZ9OrYq+22EKOkveF8U/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347878; c=relaxed/simple;
	bh=aUECkS8rU1nY3fzqvmb1sAn3nx5yAPU6ohrRg++j6KE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxDp4d7poL7WV69Xu75+rED2CFNkJvD/KQX6kBlAkXsy2Tjauvw3iNvyG4KhjbK+ffTaUVoqFnBo4YV3UUH/NudT+2nZB4JPK1PGxzKr1MzLOr8ZaHfbvqQ7+Ft6McVXqw1Qm3Spi3C5FyZ3RzyT9q+lpKhRihk1QjHiadU6YvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IVObesI1; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAwqsGxft0ZMVznLkxaW87PcGfi0ZrGfzqZvBpfzn6XgULyfLCm1eZl2FWP0+KITjz0qMwqUF4Jucg3uXg3YxLweSacpY41e+rCEviBU8UTjrJy1M6UU6NefjKqxJE2vA0Q5aghBrU1IsDR+FjM+DhfBVhici0lXRDalpmsFfURY3XAaBV22sFtT7jVbZdi4kGT7rzgg+y2JPoC+KDkWMRkYfeTdD6x/CUhod404fC1g39exwOIAm1tJ3Vtw6DbF74I60sgvtS+zkHpsmKG0AGukuYi7KCJMYH70UybutHHXNVxGgEW2D6UaRslZlMzsNB3mqlqRDhaYUAmmdJy57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EzwS4FBEC6WJMYqrXUBj/Gnio3mHsXYP9NCxxfe/YI=;
 b=nSVYXGaQokQrbBWJQPZPbBouZ2ZhuiYgTqyF40MDBFHs8cuBNEjGiMfzzKwhvkU5Yrd/B11b5nylkBwUm6T5qRKw3EjEVeHtCceGmhP2GfBt/RKldEb4wXM89fMFGOruDeZqAo6oeeLTZGWGgmzlH2TEY/+BV6LBAryo+5JHScW+mTWyRo+ohjOrsMFjXc6NuiUx7h3kwYfE0Sm1Aa19MOOnNA+b3B2RtBayc7e+ZB+dOojUia5nDZ3C7O/9PsH0DQb8GZtQ/dImUmbgZtRitYnPcHvfkAXKSrW0Jp3sxSfBChxYF9w2fgVmJRi4IYRLchzQTVWgLej4IZVqRiL7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EzwS4FBEC6WJMYqrXUBj/Gnio3mHsXYP9NCxxfe/YI=;
 b=IVObesI1Gn5zTR1/e+ixQGRb03JyCU37J4bfYlychm0pKGPIU1H18ReD4xaBBKcN+6sXELKdBByixtN2+Trg9iRVRVziXXhyTT9KY44VkybskVCBDGCNZAWAxc8cC6599kBsI2HYOVLFv5D8DL4ECt8kYyeL2PBt5V3/gp2L8Lo=
Received: from PH7PR10CA0005.namprd10.prod.outlook.com (2603:10b6:510:23d::11)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.34; Thu, 31 Oct
 2024 04:11:14 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::13) by PH7PR10CA0005.outlook.office365.com
 (2603:10b6:510:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:13 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:41 -0500
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
Subject: [PATCH v3 14/22] ACPI: platform_profile: Notify change events on register and unregister
Date: Wed, 30 Oct 2024 23:09:44 -0500
Message-ID: <20241031040952.109057-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acfafae-5512-442e-538d-08dcf9620f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7iW/Zc6JwduaJx1C+t4CzYq+Qj78edATH94x7irk2Wwr2wG/Ob3rWTUW991W?=
 =?us-ascii?Q?e4uGHaPx7FSwk49hiEFXtKPZ2F/9a02/FCRwf7pVZk1yMJTwKuJW8I4bywtZ?=
 =?us-ascii?Q?ZrFf7xW0vJgqBbGoxK2Rd/jQO/GLid7WD3aM41vB5cZmZ1iUxyE+yL3TFRar?=
 =?us-ascii?Q?Dupk2/ANaGFWF1y/m8nr3QedqZDhnMWzVorRi602SqRszYMTqi7gO5YqizwT?=
 =?us-ascii?Q?ZgbHc/UHEvXZUjZeYhER24wihhIJw+aTQpRkmBn/39qkuAGvFXhahKLGL6cf?=
 =?us-ascii?Q?o+5GZR1XzKH7zOxi+nrQCPe0i7eG9WAjpDLI/ktGwXvyDWh9smNPI6q8sggJ?=
 =?us-ascii?Q?Ky6gqenlmRjGhJXwoG5hpVqafP2wYN6i8Ym0jpMasBiOKg9Q8u/f8o69IVfo?=
 =?us-ascii?Q?3HT24oTks/SD9+ckcT2goukOZca5VsqJToS58YKnUEzmtKd851nAoIinwtg9?=
 =?us-ascii?Q?MGDhvod5JXlWlJEwewYFBEv5alBdwr8pD8lmdOF0f/xxlaxXALuMXJrRfoA1?=
 =?us-ascii?Q?Md8lyWoop/5YbNMjiKp500oFqvNfwdEFXliuD8k3krbI3etGYbMdvh+OdJiI?=
 =?us-ascii?Q?FxDhS6pdCDND8IwSwGVKped8T2f8hdKC/BtrAbqkdTli7RbXOLFPSLC012P9?=
 =?us-ascii?Q?XmVkN0hvHgsJ6c1PgLw7XDpVblxtiDOUrFlK9AK6sHun7NCUYoueg8LHWfYm?=
 =?us-ascii?Q?rxQ/v2u7jwUwaj4x/iVDP93RmMauyxGoMzA/HgohrEcHOGQl17WJ8T1/vgfN?=
 =?us-ascii?Q?Mk7CEN0xDIQqEK60teXqEO+bIzlskXJr01hS8flteHBEFt1A5+eNIpM6SaCB?=
 =?us-ascii?Q?tIrcz28c0dm/xR/EYRnyIIjZY8n+jCTfoOeEaHYTanLtXGRkg4KpJnJ71wqS?=
 =?us-ascii?Q?gpQkZFbY2Ns4yAqE2L/hDYk7RnA1hEFwNhP8ICWDhNfuCMDTIAPLNTm4u3TP?=
 =?us-ascii?Q?fIeKi6hN3mgGbh7OQHDb/K+aAIyXMvIaNfy4YNBBYsJlFGWSXiCgJCyTgUGd?=
 =?us-ascii?Q?NLcCXW04T9+eSvo5j9mpDLRndgqnCnmKx+RoAT2cdbcv+X49Y5uLSVXQl8QK?=
 =?us-ascii?Q?0Pll6lzL4idJ0yuIoVC+93vryeVtUQcyoPuZ0YpZO2ZmKiVTBf4/3cGsgoep?=
 =?us-ascii?Q?xALV1GEfPMi6xvpbOukF4cKMrGBWco+sAK52V30yWAyj5c87avVYa2U/RLbD?=
 =?us-ascii?Q?4jwSsnDPxQCh7ZXXgxVBtLtmUGO4ROCO3eCDCJX3EFSSKdkr0E96jxM82u2d?=
 =?us-ascii?Q?v72eM2ME+ot3mX3e05ZZAy18TUa+ZXPc5KXVOpbzpBjUJT4UXkjKdNHv8IMS?=
 =?us-ascii?Q?Rv4I3VHTTUv1zgYXZLIItZdd1Gi4clYtw5s3QWsnCKKmnS+G6O27k6+5vvpA?=
 =?us-ascii?Q?npC5MC4ifdcMkT7qkYKJelIWyeBMlRtPoy4pCnr9AxYZPv/0vw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:13.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acfafae-5512-442e-538d-08dcf9620f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 57c66d7dbf827..7bd32f1e8d834 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -182,6 +182,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (err)
 		return err;
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
 	cur_profile = pprof;
 	return 0;
@@ -195,6 +196,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	list_del(&pprof->list);
 
 	cur_profile = NULL;
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	if (!platform_profile_is_registered())
 		sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
-- 
2.43.0


