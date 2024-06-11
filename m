Return-Path: <linux-acpi+bounces-6304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8D903DD3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31741F24F97
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6775517D343;
	Tue, 11 Jun 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O2k1r7iY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15E17CA1F;
	Tue, 11 Jun 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113436; cv=fail; b=SkKPRDRDN+J9d1AUTEik8gvKpbvRorAVFnfMFZ1cbn2e2F3TAPyM6pYWw/Ru6DF6zMmadfrUBkS03ctPZOWHBGTYF2f7LIzpX+6AJOJSSedD/wt1+6kSdiDiByalPG0bKhAgH/AbmA4TVe7eQ9SXF05cZYmm1yPFJSg+Zm6zzIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113436; c=relaxed/simple;
	bh=ROlXKH6o+rIS464rA6uFufoq6Qbop8ScDtwKhsYkbXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHYx4T8/xIwZa0j/YCShI6fjwL0gPEkKF1eZHQ3f2znAXVy7iTPMq2ptDlYTr1oqU+y+S07omwNLZXQ64KG1uyBJ9DYGHvfrPqvOZAOL7mrkqiXTpIMM8sjwlHXFte1I+oA45WqWvfeyGLXxCkhnuQRrYCmc8PObpUhx+1c0j4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O2k1r7iY; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT9nmqKF0FfzKD9ZLIiyhhiEy4BzPuUxVzViVpEApMaa9+2BnKOkSnMCHZ971ZkNlXSoZDd1qCOpsICGfIVDkiTH/qMg85Q7Fp/z4tQy5+ncsx4coIFtOy6ulud41rjhIgO9tFZxBxcbumgIbg3CBaWpaHrMDO7z0E7IlOr8GAg1diihf9b3AfzVBoeVQTX3tj9V7PK7scIqD3ai7DuzpxOFkvzqXny+0urM4vdMyEy8ivmSwaQjFU/1q7HgYWBZasAShBAwRZPabZKxQ4lTM+FWa62CiTUlTKDD5q+v5j7mozo59krGIwSfW19KLVOShNQlLW3qMdRsozLgo8K97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n55CWXIMT1hDjJObWTuC7YscKKMeq6e3tU+2axSEIyE=;
 b=B071htA4hAyBdj1xXE9ioT6XCW9ONmYMu7hN9+6+C0J/GRjDD7EsHvHXub7RDwFzOMIjromJA18Taf8uv8zW4co0k6MmwkwYWbusHtzMNu/jURu4dmyg+Pddqtn+aFWDbt5SXVTK+v3o5qHLIV697m4x5vo3b+FseXGoVnM/QNhFx8Enw0+2Z6OLX57SNmoLsQLL4flvoIUmIDT7rt/CvBdYPkOAvIi/vHUT6V5CWrKgzah1tenxm1vga47GjUcGicfODTMjB0W9vBxP2UldgE9bWiECd3fjtKKWqa4NnDnsx4g28VBiPYGgPyjVqV60d1NlJuEy305ETlvoUrsexQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n55CWXIMT1hDjJObWTuC7YscKKMeq6e3tU+2axSEIyE=;
 b=O2k1r7iYx5IetDmQBUV7GqJrO4w7VCMqOgRDb9tzm4Wilv67YbT1Q+cbDntSH06BMz82zLUCGV1f9nStAjlh4HNkRBGoNpJTo5bpY2G6JD0vjeswruwkpoZPyq9ji+jl10O+1UBNpF9rGnPj8AsAEZrAlaDgnv5/JvfMeq2q+HZzkEib6HDUJuGcvQIuWT2g90uxKWxfCLcapquuwJzxh78vv/F+QpM+itu+XVK3ECOR9cPWH6hNoiCuuPlw8LQlEOMCMwGSxJpxxNZ7YvLfh2HhW36ODo1WgMXmtXT24p1heFyIONyZxMiut1UFBzggaBxQ4G1D4+IEnj5PnIbxUA==
Received: from CH0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:610:74::19)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 13:43:49 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::10) by CH0PR04CA0074.outlook.office365.com
 (2603:10b6:610:74::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 13:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 13:43:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Jun
 2024 06:43:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Jun
 2024 06:43:30 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 11 Jun
 2024 06:43:29 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful shutdown
Date: Tue, 11 Jun 2024 09:43:27 -0400
Message-ID: <20240611134327.30975-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: b42179d0-68ea-4aca-5a37-08dc8a1c85f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fXLNg/wJXazQ33vtKCFCk2VIPXddes2KTnxrYsP0XYxlnnXJ1eUAFvcGXAP9?=
 =?us-ascii?Q?+MdqdzWZwJD+sHN/9EM14a8qCn6kimM3xyKsOf4k6snN44z1OBe7DROaHKnD?=
 =?us-ascii?Q?KN4zygk7A2F6aLTyrod5g6eqAWLFb1fDxvzEJgPBe3SLFD/e15sDT7qmIPxF?=
 =?us-ascii?Q?Mc571TSEGjYHbfUojzSIoUE7aoIWyHKTnAGN5lQE0Ichi3lq/gysG463zfZQ?=
 =?us-ascii?Q?4DrYYL9endXs4MVtrmY16jSB88vnvx6M/+2ZFn44KcFSWNDe4mJviJ7vffDh?=
 =?us-ascii?Q?OkbIeI6PInVYXuyMxZwZ8EgY1L7FXRVnA2UoHo+tnPt6tGfLp15mgk3217sZ?=
 =?us-ascii?Q?KZhHikQLIiLP0ZPnDcgb1FxTimi3zRvBouXbHjqltbGEllgrf0CeoF66Swxv?=
 =?us-ascii?Q?eqUCUBNMLkDqmd3dhrOSGgneWA+SB+cX8f0K17HHc/KhVPCJW7fw8bVhZw6p?=
 =?us-ascii?Q?mKTx9Mlivstm4qmBNNp8gg7VJem9b8TSk8RehbqRdjObacRVTqxsVwbTKLdf?=
 =?us-ascii?Q?QyrMYHQlMbPLJtE5Ykkj8CWUnaFmTCSF6Lr3Omy3Du+ER0aom1kJaSZJj9a8?=
 =?us-ascii?Q?y0X66PDHBiOD7BYppZhNS5M51pjzCB8TuMoE5rNLoB0d3XpkbjiZfADMYbnu?=
 =?us-ascii?Q?JVPmVP3Cz6gEBfmnMoKutdr5hlTn5jJdIK6MvGjcIo6FwuX6mVxgX4h22SPZ?=
 =?us-ascii?Q?qpByQ9xYS7LlzZdq8fmzYeQlt5i6n19M1NukJgBe+t4Z2NynSrts56i0PQVT?=
 =?us-ascii?Q?HfPB1zdszZZREUQxzBRGbQ58FTe/jTNyxjjX2G/k5CD9TGNixypUnHt8ha+c?=
 =?us-ascii?Q?6PogUoZ7b2Mcryq/3AhawatGAeQ9hmDHh/1sL9KR4UiPDoBdHz/vH9E64t0K?=
 =?us-ascii?Q?BqaEPo0lPRE7q/J0+1KvwzL2RBmvoEfwNkqGkrclCY9Xbbt553q2uEntJSaF?=
 =?us-ascii?Q?4QSfEt7yHRzBb63nuTMJuV8wHZ8gATUi/1Oelw0x3ua/8bKBBTlFZIOj3Sjw?=
 =?us-ascii?Q?KvZ8fgyLoo2D7h3n+hgMKzXnd+dvohfOPlmO4ItddMt5h+pbtVkCu0H+tmPp?=
 =?us-ascii?Q?aGYyDeu9qD5u17Cxk/nh91c5yCuVnzdAHCyB4fPZzrNNoUPfpE88U2TsJdBG?=
 =?us-ascii?Q?FxXxQZtiyGtoTTFM1KH5UIxkAIzWqlOpJHcoDhFY/+Cdj1poFnHakQOM0RcQ?=
 =?us-ascii?Q?wRRQaqlXVFjb8jV4vy/1ukXRtaBDifVwZzcorYmeuR8GrzFRUZTB0HkUPuEg?=
 =?us-ascii?Q?b165TdrLPzJPVD/K1yiQGmC99aH/XCzWa10NQ+KtX9K/xE8B07XKVSyyEAXZ?=
 =?us-ascii?Q?sAwbXVIGG95HBznGU+X6LupQPKgcYI5BNz9CDNJlwZEGOf8ngQvcEVzS+Hwh?=
 =?us-ascii?Q?edXWoFClKOjvQmBhCjYbyMt2Jdnugc8CY6+d0BLB/oOrnpvRdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 13:43:48.8812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b42179d0-68ea-4aca-5a37-08dc8a1c85f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

The OCP board used a BlueField's GPIO pin for entering
low power mode. That board was not commercialized and
has been dropped from production so all its code is unused.
The new hardware requirement is to trigger a graceful shutdown
when that GPIO pin is toggled. So replace the unused low power
mode with a graceful shutdown.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 drivers/power/reset/pwr-mlxbf.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index 1775b318d0ef..4f1cd1c0018c 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -18,7 +18,6 @@
 
 struct pwr_mlxbf {
 	struct work_struct reboot_work;
-	struct work_struct shutdown_work;
 	const char *hid;
 };
 
@@ -27,22 +26,17 @@ static void pwr_mlxbf_reboot_work(struct work_struct *work)
 	acpi_bus_generate_netlink_event("button/reboot.*", "Reboot Button", 0x80, 1);
 }
 
-static void pwr_mlxbf_shutdown_work(struct work_struct *work)
-{
-	acpi_bus_generate_netlink_event("button/power.*", "Power Button", 0x80, 1);
-}
-
 static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)
 {
 	const char *rst_pwr_hid = "MLNXBF24";
-	const char *low_pwr_hid = "MLNXBF29";
+	const char *shutdown_hid = "MLNXBF29";
 	struct pwr_mlxbf *priv = ptr;
 
 	if (!strncmp(priv->hid, rst_pwr_hid, 8))
 		schedule_work(&priv->reboot_work);
 
-	if (!strncmp(priv->hid, low_pwr_hid, 8))
-		schedule_work(&priv->shutdown_work);
+	if (!strncmp(priv->hid, shutdown_hid, 8))
+		orderly_poweroff(true);
 
 	return IRQ_HANDLED;
 }
@@ -70,10 +64,6 @@ static int pwr_mlxbf_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Error getting %s irq.\n", priv->hid);
 
-	err = devm_work_autocancel(dev, &priv->shutdown_work, pwr_mlxbf_shutdown_work);
-	if (err)
-		return err;
-
 	err = devm_work_autocancel(dev, &priv->reboot_work, pwr_mlxbf_reboot_work);
 	if (err)
 		return err;
-- 
2.30.1


