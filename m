Return-Path: <linux-acpi+bounces-9683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E89D2C83
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2604A2814AE
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB21DA636;
	Tue, 19 Nov 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x6hO2YJp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372681DA0FC;
	Tue, 19 Nov 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036896; cv=fail; b=YroDzWn7bX1SeUwqlLJZ6hmhfLgYFkZM7lo2dyrRkhJ7WB9nbWcS1KzCdapFn56M0zGgxxZQKw2i+84Jv8Egpct1S+vKotXF8H5YqN4HkmBOjZcSdp11RDWaVvBTW9ER3bo4IVzIf9BT89plgqRsiiagZWNRE3taias27xEwCqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036896; c=relaxed/simple;
	bh=op0V9TbFKl0DZPBs9kLX+o10ntgPOBPf/FzMzaojh48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZYeBdGxnBQrXyG+1oem7Xd6cehzgOd6rYq+qJqeICQwblySXtaA5yEyI1bzptYtJORTwCX3175VsYUQobTqtqPd4COaVLyhzSAVxyKOh+SY8+eUTmRgIhhAOqELab6Wdp3E+yo5DXmpm9ZrFHfcvOSylszzMVCQ9aauQ0PLIt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x6hO2YJp; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5qWlj2w1k2sTSLe4DRUkJ2B++9FxtAFHexg3IfNAi9nMuTjeUABdniE5fhuFXkk8uiiLTlig94wPjT2WzNTYgew12xdYtOk/9fFnGjoeuycPUrRgQ7XDtEzj2zODEGgaMhlcR1kBtGFE8Humut4Dcjhy8lc1HC4C0iFRZSgnzVZ9lhS0OlSV3zQdwZmco/DPJGl4roTIr1bgJUHVVHUVS60n/S6JQd6N9g+T/i3o52EXlhibNDBr6I1KslBdWbi0Ugv5x4nDeyxV4jwj5Ix0djSyitlKpU3niLIuM975cgqCDLKWqEzaL75V7cP5cdjlNKDzS7Wilp3SP2t3gMQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vn9zVmIz/MhRGI/WHjMYzAQOjJN7vyUN2I6tvttNBs=;
 b=NQLPFVJU4V96kRA5+iNEIQa+KeDI3dOXajI4ZkRG3TY4llRgE2pwWzYFB8jIU6cda9UnF9fRPVe6x+NaE6eC0wUI3mVHmM9rSlubQwPoGspqAKo8z3zrX91AeB+1nTIZwmdRE+LzMUUr86OR3zmTuI/bWl9KDMGU2FKB1n3IQTmdjCZwOsj5cnDst4IoU8kKanT8iDcLQRb0yHF+19cg6E3OBBCt6kAskkpy8czvLStsvtSCZb1Stv3KT+N6v3RjcJgIbsmLcYnEC13h/G4n1tv1LgiUe+OsX0QDwNjwIrfHAcHB1is3rWnFrx/WzFVHKsMkggZ7+BgGcBk5pl/pWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vn9zVmIz/MhRGI/WHjMYzAQOjJN7vyUN2I6tvttNBs=;
 b=x6hO2YJpCm8Vgc5CDZWTvP4EC6GlJx2NcHyn/ju2nPJz0hoU1JWvF/lMLglkjTuyxdNg0V09+OQgrugvlc/NB90QCez5po0MGbDriZbUlhlCbuOtQma+6DaVwIy4EfByZyA9HnNmwa+1nnZmYhl+qxYwDQaOLPZXI4Yg4GxBRIM=
Received: from PH7PR17CA0026.namprd17.prod.outlook.com (2603:10b6:510:323::19)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 17:21:30 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::3) by PH7PR17CA0026.outlook.office365.com
 (2603:10b6:510:323::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:28 -0600
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
Subject: [PATCH v7 19/22] ACPI: platform_profile: Notify class device from platform_profile_notify()
Date: Tue, 19 Nov 2024 11:17:36 -0600
Message-ID: <20241119171739.77028-20-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 696112f5-8a63-4bc9-aad9-08dd08be9baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hlkUdCYmENVSgZRLl5B288GbNX5kz8K6KfD/++d2uMCsrZHqyoVfbL/pH9xT?=
 =?us-ascii?Q?Ah5qglWl6BS/S0z1ap8swGEchLdNmQLgfN+b7QE6PIVWLXqi7doNxwM0rHK0?=
 =?us-ascii?Q?EExcB67AqJFTzDUr2X68aEZs73BYRXGZVhra6fxueljAAExEucara5cqETgh?=
 =?us-ascii?Q?v65KOHzw6+rYIymKt4CFgPKDyBA25HVy+tC5FnGgAj1WUq/fjbROAmKannm2?=
 =?us-ascii?Q?tjI1VPDvUdJu/63BWaUr0jHgoNF63eZom95rS0+WPVQd3CrZVBMWuRpwt0Lw?=
 =?us-ascii?Q?NO/rjsRhIiEzKf7gpoE1BjSshtJ+zPI6z/PbbJnAD7mg1S2CvObLZ1BmhGRz?=
 =?us-ascii?Q?HEnhhgAexRLz3LShfzLInv68cIMEOVQ3lK/tL+yFZMz+T71cgpWHO5CgC3LC?=
 =?us-ascii?Q?JaQRUCk/QrkVg5d0omRExaAKKJLa1aejMFV0OY7g+ilbGkP0tbflwepMAFVp?=
 =?us-ascii?Q?df3rVX2NsycujktpyWMgDXf37RhNSsmCauodanAFiS170sktWf5UE2c8oC1T?=
 =?us-ascii?Q?9c9ewDlmVPkHaswFQcQvxNYO5xzgPYGFo1wt3qHVwdf/uDkUc3JUYoI5/n7y?=
 =?us-ascii?Q?8MjRbsgWVMqo+6GYXvmtuGEdu70ZSVpN7DtNGNtc9okuKbW60KQjryDW6iEp?=
 =?us-ascii?Q?bwPe+ynZw2addfyRe+v27DIizV1VL5raCdo0LemfNLHRb5ZMfPK56b1O1Quo?=
 =?us-ascii?Q?gyUYz+NGL98tY11IU4SEFxr8UB/JbIE81wZ4g9ND/SK1397la8Irs9BKZVu6?=
 =?us-ascii?Q?lx3HRdByzujPwOEOOCF7dq+RjyT/GbwCfIg+OoGTXEcHDHgeNHIl3R6i7VM1?=
 =?us-ascii?Q?wQ2zJM9rZHauZqdC+VDgs+FMoT+ftdTvD1bWQ9pO1lPEZevJLUeW1EVNzp7e?=
 =?us-ascii?Q?Dr0+mHQHsmMmnNN8UQeYswZFOZyOYk2/qZP3y98t4vrdvpshV3RmI6D+KfcW?=
 =?us-ascii?Q?tOlwLy+dTybz4UGym34RJBvejRYPbF9JY/+l/Wsjz4A6m8f2YxX5YXVQDZnw?=
 =?us-ascii?Q?BGgYzF+OhpvfO5cQQR4incWJD4MprnmkQ0Q80siARs98kKJCmtY12OMe+F/i?=
 =?us-ascii?Q?l0irKpsYSDlCLqE7Tf8k54fii+GpL8NWs4m7iFQ12YMZQviSOQp+2XssZtAd?=
 =?us-ascii?Q?NTmNsGJ4tWUjk+DuY7OqllCIm96tqQDoJabnQvymkG7Jr4PUOryCo+XdKPUq?=
 =?us-ascii?Q?LjoNZB2dRH1oF6Bbkzm7ZMsd/+/VJP7pKuKZu4oesXUCRoRR0gW0l9C8p+YP?=
 =?us-ascii?Q?YNiSO30ZA9ABJZtEV0fnIauAPssBl6s4QPCIdO4/+Xd4RDfO+MpaCrvTKLg4?=
 =?us-ascii?Q?CNFn3p4nBmliK0RiAuXOo24dOy8VjgRbO6RxZYE4Y2SxE+k+duF2h/R0m9Cl?=
 =?us-ascii?Q?VTM18/zkHESiPaqZXbqMSOLDxs9gSG0jZuZwtqI2x5M0Ig/9Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:30.3549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696112f5-8a63-4bc9-aad9-08dd08be9baf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294

When a driver has called platform_profile_notify() both the legacy sysfs
interface and the class device should be notified as userspace may listen
to either.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Use class_for_each_device
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ca997f4e9a5cb..e88b355a72112 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -402,6 +402,10 @@ void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	if (!cur_profile)
 		return;
+	scoped_cond_guard(mutex_intr, return, &profile_lock) {
+		class_for_each_device(&platform_profile_class, NULL, NULL,
+				      _notify_class_profile);
+	}
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
-- 
2.43.0


