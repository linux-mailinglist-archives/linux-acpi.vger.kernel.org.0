Return-Path: <linux-acpi+bounces-9682-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9D9D2C82
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC041F22D11
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5301D9A42;
	Tue, 19 Nov 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CJ5vaEqq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14E1D9592;
	Tue, 19 Nov 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036893; cv=fail; b=MiBLBTG2bB66x+KoEkn+9sY/ha1UBu5LMgbwFhQSlbdii4Ooy17zuhgsT9epTGi0YMgJWbdyqTK1fVTyi3UQaq9WikSNf8CyBNTNc6MibJNoN9DKx8ylrfScleAjWRRZUbLwHOKQZ4W8vXlZI6VF7QPrfqb3Qcm22IR2gUS46aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036893; c=relaxed/simple;
	bh=R4FOJvOdpurkjZ6rAItGPYx1C5vNDKL/Ck1Ok8rE8LM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgVrXtSpyP2GHNRdICpIJVHPJuYEgnXiDSYim3Uqe0R+VhgIUJ/sjgRnQCxKf2nzR4KlUe609lZsbBtRi1YOhLfbAglLGEfT7EyHzM+xsCHlMa3X8PVq3MxyfZVp0elDr8ixbVxQv8UMZtpdyyifXoIucWI6kQ0mHR/nAvhUEWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CJ5vaEqq; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsqFqK7sU/FtG0ZZhPZ5zqAhj1EtSwzdSxBZNHpNgGFZsAKJ2S87ggtlhUTWcmH8ezsZZSta/gSwFRxIOUb+8zxtyCYmA34xdfKzMB5UWkS1/gtNNIYMOS+dyFQTsh1/0Jk+sjv6PApwIYNFNpgad+do8ffKvYtCGELyeYs+/tA6XM9No+gJa1TqIqF83LatuLS52qfh09rPrmMGrEzqmcCsaxmXitbYDp5+O26a5GpXEqNmkL9x7ZslXzHKfr27C8ZneTtIqi4tWPW0DoN0VtsgtbBrqLMm2grg5M+yh+6lYZIv5uwgnauOwxfRZkIrpcosrLy25S6idxVn6FUeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdz8VhuJ822zb+HDdL0/A5HVsWK/jSuxunFPEBpnYJA=;
 b=Kx+NOY2aQI0m2+kCeUYkQBE6tvnOuH6WO/sLtjcI2k0vXzoXohtshf16Scqf+wAq7dP3LnpMRnBT7QCrz6aexU5gb/Hxuxx9JhjAyypcYKV3tdjGRtCxMA8nrkJK6QbM3Ggfgoss+3kPivMbu6v9fpNtnbxXh0T1uNoJYneVjivGY6HCNHrOuKgtZgrPXRRccFVSzpA1+/L6FCUtheQD64Zyx1maZE7/Ucg0MgWBRGxWG3Ta4azs0a0Pir026HBn3x5162bby9dkkc5g7YWyAHDuGk/QKpAgBtGioRj3tGg1VNG4MumrDNuW1MehhuCVpCHmdFSUOOjS81es9b0GNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdz8VhuJ822zb+HDdL0/A5HVsWK/jSuxunFPEBpnYJA=;
 b=CJ5vaEqqcm+JXTQ99mmFiIUTnqr3uNqaP1rNQ/ANuzt9x/HpduRA98c0obm7Tnk0i0IqT+WHi27jtmuJ7fkZ3dwL9FMGQTMFXevh3CjflilwbJEX7eXRWMOTd3dvn9XEHuPEXtpNP9lLT+fwmTge+6AidQb5pxrMxUkenKaaICM=
Received: from PH7PR17CA0046.namprd17.prod.outlook.com (2603:10b6:510:323::6)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 19 Nov
 2024 17:21:26 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::b) by PH7PR17CA0046.outlook.office365.com
 (2603:10b6:510:323::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:23 -0600
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
Subject: [PATCH v7 16/22] ACPI: platform_profile: Add concept of a "custom" profile
Date: Tue, 19 Nov 2024 11:17:33 -0600
Message-ID: <20241119171739.77028-17-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d8a5a7-d0b1-4503-caa6-08dd08be98e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V8VVbOdcfUinJD86ja1k6NIgmwlbLMiZ0+0knu9KFuLnuthzBRzxS+6wSiuI?=
 =?us-ascii?Q?nBMAl7J4FY6zjh5bu6rC5B4UtkLqRbLQ0qBu9t5a45nHgk/awBESyi1mQHX4?=
 =?us-ascii?Q?Oa5lJkb+tjxG4IanV7RcWqekeZ16th3KeoTGGr9Q+CI5U/0ojU9p40FJgwG+?=
 =?us-ascii?Q?7zC7UugfxTyNdxp14ZgGQU+VaROuLkAhy/ocasCwl52qdbj0yrJljzbF9zvM?=
 =?us-ascii?Q?Wib3tSE68QOGNLaZt6CTf0c/tGWfl8CYz28D3cjHowHaimsHwvtaYEF6BgGM?=
 =?us-ascii?Q?6Hi4BztwTwbGGWt0pHuwE/WiYyBBGKsn3QVhwhgh1vxelmFW3Uoa+RTiLqYv?=
 =?us-ascii?Q?yHAVmZkZ7h9DV0foInX779jm87EMSGqw+FOiujNYuCoJHlZ3y1tu578i/ejM?=
 =?us-ascii?Q?G+jb9xeduZl/kDtK1V4RUyvITkJ+/GTg60vuXWkCzY9Zrs0Oez4Yvt5o4Le+?=
 =?us-ascii?Q?jtydOU3IGaNCYk8vwxn+0xAtOrmwLntczOkJzAxHf0KhsY3AFp5/JzpX2/Qr?=
 =?us-ascii?Q?IP22CqQAKKxg4e3x4Q/eCyyaVFurxej9LZhsB0NNeGQ9MjPBznoQ08JSPbfF?=
 =?us-ascii?Q?vkUUJdIVvoFQosOfMPEg+P1hzAOaC5TJTf+Beap3vVxmLOqw4TegUmKIK3yK?=
 =?us-ascii?Q?FKrsS/i4Cb3Qr8ZPUDLQViU6m1aV31qTpxhO2UnvRSl9/PFLyKOY2Y7xKDzV?=
 =?us-ascii?Q?pL/tIK5D/DU/84g2FyFIO7X89LFj4ljR7NkorWlSeF3uvVEZvHFFEH2SqnSu?=
 =?us-ascii?Q?i2AjfQpfvY+/df+bw47xdtjwxLdK0MqP6PQ6+jMIjdrqGz5z7JIP5sY6vX17?=
 =?us-ascii?Q?dMrZREiTYyW28uS2tdtUECRKHHy5fYo7t8aLVM47BJZ3oxhdgQzF6smMlt0s?=
 =?us-ascii?Q?pwOALO+KDQkNfuG33XMHu23tVhg1yRLFN7GjnL+t/+8xZv3Ztpu2tirgN34M?=
 =?us-ascii?Q?UPOjx0fdRxB21ZNFHtQueJMSvCZhVbiZO4h9vBKhdnlWqNzmMsbsU5n9VYmp?=
 =?us-ascii?Q?Uidbq9p0MaKyhDlNLgp+nigGF9x3MOeGOwVpK12dVLBhamWu9I3Zb/2hHFp3?=
 =?us-ascii?Q?307Q0FuzQyQGP4qImlsrJc9L3RmkXDpyWPswwyJyAzcxCwla94MdUMMJuzl4?=
 =?us-ascii?Q?Wua6i6X0Tsq4PjWdHDL25B42NqHfepko/er2kwvFuiABOMh6hNrtxZ0hhEnd?=
 =?us-ascii?Q?+lyMyJCBvNVGnJf2py/zAly8Ge7DqGpuir90zlqpnaRu68xmV6rOw1z6TywF?=
 =?us-ascii?Q?00dPLwCVWuDKH71EQ7H1NdHWcM7pnqiOdnkIQJ8Q2GECoDUmk6Zf+1N9Ikt2?=
 =?us-ascii?Q?TTTscpA6gtXsMibuLiYbMx5TK3IxchyxAJZ7BuLsNYgK6DCNLSezxblC+SQN?=
 =?us-ascii?Q?Fs4FZEN7nb9yC+95aGbWX+bcdHYh30AuE/JXsOXLPbOFSZgyjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:25.6830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d8a5a7-d0b1-4503-caa6-08dd08be98e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368

When two profile handlers don't agree on the current profile it's ambiguous
what to show to the legacy sysfs interface.

Add a "custom" profile string that userspace will be able to distinguish
this situation when using the legacy sysfs interface.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 1 +
 include/linux/platform_profile.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index db2daab5b2a44..d579de1b31be7 100644
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
index a888fd085c513..0682bb4c57e5d 100644
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


