Return-Path: <linux-acpi+bounces-8993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790899B0EFF
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A535283132
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734A20EA56;
	Fri, 25 Oct 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eh/oAF5Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3B920D50E;
	Fri, 25 Oct 2024 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884682; cv=fail; b=N+U8P9ZQQDLx8BS8QR51jLxrCxJbPCr8xdYXvMU5qTk9QEVyQypPFrVZe8eCjeRQRd99gFX7OwnX76cjqUZaRRek8xlhjPp9giSznd+Ko3aa56p9/S7TPMbfgH5DkaFo9d20qioqLi1bVM/vPAb/T32JFaJI6RtyKpsI3Wl6B2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884682; c=relaxed/simple;
	bh=gBsO93LxXLrpSUB0cQo8jB4mNoNxiCoYwvz8YjiIGLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXzxMU111tPoxz/sZlejgPSuJzc0lw8mCLpREurIhK4pBfPH1EbpwyQvo2FKd7JaAhNz62U1PRtYgM3SFxVz7Uhefs6b9+S7mDdUUtT8KBFEwkDyzj749sTm01MXcr3F8NEoghgti2oOGWP+NJ+r6XD8mtPTmMOR9ogMDUOwmU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eh/oAF5Q; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqMlyye4Rk3NcstzZ3560OuB2YA7dHviucqs7GacoaHzJO11mNCUALopGBoCT3OINgn2HUMb42afxuJeQBK1+WLGUwPR/gHkc6A1kCVC3Eg/N2D2VTg4ypAgQMGLYQlPpw7SmoOcdIjyuQm02TxvyBCbYbop3cgr4Js8VzhKzTABE+38TSlhWgK9dVy3U5Q1N1U/cTP37ttWQtqk9mmUKJbQUWmnoNWk9OAt0wdPh/QrOrl4cL2M+XfSNTlNTP9cOhWKnyjTuEeOhiTXtl7B29LTVMybXb7e3nnFUDuS9ivMP1j93Iew6ELx+epnW+/YMMPd8gEnaTo/oi+ZNEAwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX0zSg9sTkJ1rkpfVbkJvszGd1a2nk8KGfe+WG2+cqU=;
 b=hswdL73Kgj1iRXrMhtcSbGoPXEYx8EOR44/9wQeAw3JmucXr0BOaEvv/EgcXighbvCmA7MwpGASjym5/SMohZIlzT5GdSU8tpHbfEMD/LIX/aw+hz4vcq0AbE6/QzkEJR8X0GOoCVNB4FG+3l1onbdhNjqHw0kTaR0MIuAtOMu7GFSfOiJkTLgXGjnaYH+DH7DiLm+hIM3286i1WGyjfLIsTb1CyQ5TiEGAhLxNDj8VTxEcFmH2cW2vujZHYmy6ctvLh4XVTLaYrxSiLKVjX1g1/pIg5Ja9Sc9j6RPvCYI5U2wiqR+shtyxXPCqCG6FuIF65sr34iM56jNYlWVF39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX0zSg9sTkJ1rkpfVbkJvszGd1a2nk8KGfe+WG2+cqU=;
 b=eh/oAF5QgS2osXfQT7vLrg3qqmh+RWkCmO/RCDTGllU5iB3nmGeRNUCFmB+mEjsTpzv3zxkfM9W1px1fkFQHlf2CSTt74X3EdjpjcTYDOmAqTwdM4Ml5AJ4KFZQ5558OHJFDRrg2SObjOrIzz3Ig2XizphegPgNRQM8bXh4kPfE=
Received: from BN9PR03CA0173.namprd03.prod.outlook.com (2603:10b6:408:f4::28)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 19:31:16 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:f4:cafe::9b) by BN9PR03CA0173.outlook.office365.com
 (2603:10b6:408:f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:15 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:12 -0500
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
Subject: [PATCH 2/8] platform/surface: aggregator: Add platform handler pointer to device
Date: Fri, 25 Oct 2024 14:30:49 -0500
Message-ID: <20241025193055.2235-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7d86b7-00c6-4f43-a0fa-08dcf52b97ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ntqk6YsVgvOlUwbkvgQnX10peoi8VO9vAFuX7KVoFQDRIC6ptm2Hc1qmBWO1?=
 =?us-ascii?Q?c6oPbjgSkQ9f5xNPUKP+SetZJK3IChFUfwzVZQcvrhO/1rMoOKtIey85sIXw?=
 =?us-ascii?Q?L7C7NTxOwn0fbxpmiEL0Edbp7Cd45P9W5JPkJmRcJSVNNtKcMSmaS7nRlAtz?=
 =?us-ascii?Q?+7Zz/9jOSyIIcCRmjHuDRgcpbqE68v7xwa73YaAwVg0laHsaYYlmIIrLCfCG?=
 =?us-ascii?Q?lgBSxa7Oq1Diy+0HcCO1y++c5LNEJgO9yfxmQsjdHOGJdxyKTTmgQFpIZF67?=
 =?us-ascii?Q?rYGdwJq4b/+Jq81xi5bQBZ0ONTWql08gayZ2XliXL6oaH8mqR+pM9mCXQdQ8?=
 =?us-ascii?Q?vs+L/kvpnjF4RJ3BWEq2UkePYvB001dp2NUEuICrSxjzY1gBJ79Sx51PqqsW?=
 =?us-ascii?Q?FEgW4GP+SCIPzEFd/PimgsllZWHLDqken997Kky50uyXr2dBAqDe6gxxvXCf?=
 =?us-ascii?Q?I8o95UpL1vpiiZriuzc2zB7eZIwr9p8pqf7ZvW3OhB8kqO2lv1qyLEdQAkQk?=
 =?us-ascii?Q?Fl8UjpFlCz8Tb7s6DnnfGbCI21Xe1bkJrbOZM1DmrxvjhM4DX8MuxOxd53Gr?=
 =?us-ascii?Q?5JEwYc6y8SWa8ORGJFAuhsOIHwYHxSF3b3ZbKT8p3/pVLAATeGzBUGorO0yC?=
 =?us-ascii?Q?s/t4akGf42G0HHYDR7JGvSlVFffp2VcPVwlIvL5vAbFe8BSOxbTSwegs/Kvi?=
 =?us-ascii?Q?O/1OnD4yICZwjX+VJI/luPCIm8LswS5YPokFHA/n0JNeokPK6h2GkAqqa4xX?=
 =?us-ascii?Q?e0arM/0J/Xu2YH1LhZ9tPEEM2g8lZ6rS1xXap+O9MyfvUzvuXSRoI4SbeZGl?=
 =?us-ascii?Q?A8eisH6jo/fLH1+mWpPXbADmalw8A318f0o5UbNcTyraQnx/ZaCn89DrT1Bp?=
 =?us-ascii?Q?U0hWWvC18tFZ3ldZ8Svjl6sFI9kYZ27c8WVuHav0mCNL1d69LaF7NRsLWWXh?=
 =?us-ascii?Q?8iYqefs5CyQ3iEfh6a51WyhXhsDlZ/fp9STAPKFTp0wWQu/QEsMZhhkVzxP0?=
 =?us-ascii?Q?rXwAUX5PQpY26nStY3nzqY87txN6JXOARQUqODoaDJ5KWqNCJ6kbtZMMGZe1?=
 =?us-ascii?Q?jfXL55vboF0Ay8kiIJlaoUiZRQwSP4CsMSGgVMRnhsfooQh0ZmnRnR4wPVr6?=
 =?us-ascii?Q?tAGcFtJhRntQ1WK4xyo85zfimNuXhBqhyB1ewz6BmBQGhRW5yv7fooy9u9vD?=
 =?us-ascii?Q?hEMvRoERL7JdShFTXxB7IQqw1H8905UEVOOfihoPa8WEn834NVC7RZ36oBfp?=
 =?us-ascii?Q?73RRnSKQcnK3a7icFvK8Lg5mztu/JiAEPNPm+R/JZB+xXJimxWyxQRckXRrq?=
 =?us-ascii?Q?IO5l8WzGT5RSBe6xt33r6BqSv2xxtr0N+bkBhMbQ+8m2QkFR8otFgs6xVWsw?=
 =?us-ascii?Q?m/+HoP573BhptZBD+yYKOV4rYsZLau+y2bC+Pez89y/yaGBK0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:15.8180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7d86b7-00c6-4f43-a0fa-08dcf52b97ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

To be able to reference the platform handler in remove, add
a pointer to `struct ssam_device`.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 include/linux/surface_aggregator/device.h           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 61aa488a80eb5..958afd7bce223 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 		return -ENOMEM;
 
 	tpd->sdev = sdev;
+	sdev->tpd = tpd;
 
 	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.profile_get = ssam_platform_profile_get;
diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index 8cd8c38cf3f30..6a72b5bdc8782 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -164,6 +164,7 @@ enum ssam_device_flags {
  * @dev:   Driver model representation of the device.
  * @ctrl:  SSAM controller managing this device.
  * @uid:   UID identifying the device.
+ * @tpd:   Platform profile device data.
  * @flags: Device state flags, see &enum ssam_device_flags.
  */
 struct ssam_device {
@@ -171,6 +172,7 @@ struct ssam_device {
 	struct ssam_controller *ctrl;
 
 	struct ssam_device_uid uid;
+	struct ssam_platform_profile_device *tpd;
 
 	unsigned long flags;
 };
-- 
2.43.0


