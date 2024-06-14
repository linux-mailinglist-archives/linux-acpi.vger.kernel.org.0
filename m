Return-Path: <linux-acpi+bounces-6432-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3109092F0
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 21:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37ADB218E4
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CF419AA5A;
	Fri, 14 Jun 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2PnNtgx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A61487DC;
	Fri, 14 Jun 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393590; cv=fail; b=p93WjL2O97rpbla16awSGBPaT74neVFRGAFn88HXbI/hsvL32L7D3+lahn+daBpepBvCF93o1BHxBIPdYHysldKTWDcfNqKbZVaUupvaZZLSP4F5Oz3k/428lFRQscsgW62LzVEGBz96USILFuKAoYW1dxaTGeUHy3hkhISzeiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393590; c=relaxed/simple;
	bh=cK8pjwepLXgfTrySOHdLWtM/QnPPgBDEOoxlcXC7mcA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQ4y08r/UCHOzCc2fjf8bvgYFGUYFhsZCuww63L5c8w7dQ5y3oTBjyGyTLPYc/MvOdAeU0KS2KDiCQQCboN7IF3W/0paXSaskgHlWV2UL5xNuGW5PJ7AHKtfXOajLZ5mmFTvZHpHPfMDslbFrotvDvZQbwvY2VZ/EieTjsDfvRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v2PnNtgx; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj9t9eV8OitkY/AQU6PR7V7cIshP1Tbd6achRvzXe9JHn0jjQ4a/D2g79T6kM//hRORaDIOS6629m9hS+Qa7Fx9hZXgIaV88oohT0juqh73vONamQcdvp5OtwVGqg86/7D/x+w960a2Pm1gpo87MJ2bqQQYMqoOMaoyF2LXYnycORnDQvv5+EW+TSgQkiUSa1o37HtCxyCFZC/x0f2fJzAdPE0v1YED1jItP6Lk8Mya56fqNVv+TsiErqz8V+KoPOnRfGTDx0tiDHu8nVeHNBzjIJ1SoMspKxSCFO+CKthpWQKQdH94B7WWKkoE0vOM/ZZPiFT8mqhx5hxJUXue4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4/h0p/QIYwZk6tT1N8m80qTKMWloycVELW4aTp/ymU=;
 b=XFc8LxV4PAZIq6pY7vy40XTHt8TJVTM4kDOJ4Fy6oFpfR8JE2GxELZZ2MZ8mwaQb976/eHpryJsx3UxJ85M/JMl2r5YmaBKh8YuhyUsqTsmzb6wRzgAPKb2/pNXJ0EKv6Fiiu7mIee+Lld2ztuOKOorQsrQqzWVspVDWk30FmCl1DRyTYwEdkb7wbrtoJRDZZugFhpOcFnZ2uxA5BlQrXUYz7AbAwhbHrc0COOBnq7P0kvUoE2N4r7xDby4sskx55n2iZCMgKC659UnvRBLpsiR6SDDRKy2EnYOk65Cn8gCGK2C4aQU64IheXFp8Ah4CIZOl/uy3cl+FJHfxjPc3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4/h0p/QIYwZk6tT1N8m80qTKMWloycVELW4aTp/ymU=;
 b=v2PnNtgx7uCAuAjSncUlilYIzkBF8u4jeu05P0jhEcL16g0gco0ASPShjKlGcD1uxiPqevI8eEcCbOdIo3hYgdud/ECZqt+6XfKjq2YtlPvgXtRbVrklj5YpHyiDrA5itX8y0bQoWlDYvrfIUiw/xOrs7tL9l6WlnokukjtIwvM=
Received: from MN2PR17CA0007.namprd17.prod.outlook.com (2603:10b6:208:15e::20)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 19:33:05 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::6) by MN2PR17CA0007.outlook.office365.com
 (2603:10b6:208:15e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 19:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 19:33:05 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 14:33:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, PradeepVineshReddy Kodamati
	<PradeepVineshReddy.Kodamati@amd.com>, CL Lin <clin41@lenovo.com>
Subject: [PATCH] ACPI: Only evaluate the Intel _OSC and _PDC on platforms with HWP
Date: Fri, 14 Jun 2024 14:32:41 -0500
Message-ID: <20240614193241.7341-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 8084a9ba-0a64-4d03-49ff-08dc8ca8d016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kNrePXyNIEFfrsYFAbzYCzYDuFQkkneMwwQOLR9GaLFe5fRkcGVByUeit77O?=
 =?us-ascii?Q?FGV+topFxYz7bkCZwN1WwJ1pXZqnvuoIMtCFeVDoJMieLOr5zDAgbn9azFHN?=
 =?us-ascii?Q?n/SPtwrRYeuAtQjKGtd0TuXrUepEyNjjJNxdhhOTB1YPloSCNsp8XaJFOWSX?=
 =?us-ascii?Q?ghKe45bGevHE2e7aNGjW3owEBI9yR/DuxFiI0Im4SSOgW7kndg2Vqg+b8jhW?=
 =?us-ascii?Q?8hJJMtZ1Dy1Ybxv4EHROxwQ0R1n7ya/h+WznSbh12WQzgAjJmys8aoXvkLDr?=
 =?us-ascii?Q?+Filf8uoVd4tHMvTyFtzMteq2XN/UvEq4bGdA8TNOD/rEF5xRvDGLmt3Zu2P?=
 =?us-ascii?Q?XVT2zbzvF6v/hj9NB7jHtV5aA4k0zBM3dvT59dxDvYBEpTUE9sKZN9kvkLzl?=
 =?us-ascii?Q?q4YQq18q2ezc8/44StoaXXADTqrHn5uUwpgkr9HimH0ElVcOifgcnVUHsvms?=
 =?us-ascii?Q?cffQTttIFG7DxkHyZr1YGDfcg1DGdZj3pgsVHEMeiIFKptnPoShFCCTs9fRH?=
 =?us-ascii?Q?P4lX3HGMb7/9KuzscDvalUkfWpmzNk62Hu/+hyKbQc7AzbzBSCVbAUrbg96w?=
 =?us-ascii?Q?szOMT32qllng0Ztz7aFZryv3mT2g7Zud1CC3mYpaQLPy6wIUliPCoyQ7okWn?=
 =?us-ascii?Q?ySmEA2oLv4qUrbKmBly5eTSbuzfbK9pGoAAS/+V2hHvm+iiHuVE4c4KSF9ZK?=
 =?us-ascii?Q?Y5edY+5u/cnFApdeAbOhPA6JRIoW0PLaWg0f4iIWVYMdbnDr2+cTSZ5PaIT5?=
 =?us-ascii?Q?U92I9T7VZskRqNIGGW4zpVAjC2D4WirTQVFuvsJu6pWgMLfZSV355cEb7CaW?=
 =?us-ascii?Q?qZPusI9rS3L5/szusYmyN1RpwqJNP3swVjKp9N1uozbin1uSANNo8ko/6KMe?=
 =?us-ascii?Q?c+MR1R2EuYVRcfEFP1flQBna6BytOQxV5PnB3j48Px6FvQsbaTgQLY/fFcHK?=
 =?us-ascii?Q?IfvAo0f+sI6xcRhHPGgD2YFkdM0w1aGZYmBADY4OdGzMEXNdQrYzSDMehtxk?=
 =?us-ascii?Q?ywYsTBWBI5uTK3IGwx5SmRIUyUVklX4Inrz2F8Van+w3b65SBCIUKuEOlfBM?=
 =?us-ascii?Q?Hn99Ix91gitmNZoTHp+TSlcLTka352HfAvwnh6uqHo+nXGux42ZRmYYvsL2S?=
 =?us-ascii?Q?1iTc3boVpwJv6c71cCdq0Z7pgSRsqwXFbjGqBoE60CaZlEK2VUWnKhBqFvGt?=
 =?us-ascii?Q?4fEbRvHSCDCYHK9lFFHeSaczZymDFOjce/llmGxcYA68u7n1FgOTIqffyeed?=
 =?us-ascii?Q?TcN46sHlLZQIky/Bw6CoYMp4vIwXkE2yI9TQSkznB1iiYv4xlHnnGmPt0CZj?=
 =?us-ascii?Q?9vzf4ASZY71qkmI/WvR4AOTO5B0f9vJBbJMzhytMYVuzMwiW5GXAhd6q/k+2?=
 =?us-ascii?Q?pwkQJ7f4i1lKOTNuLwIUrhzzMV8pWnKo7QXJEz6ywE7tcAgfng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 19:33:05.0627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8084a9ba-0a64-4d03-49ff-08dc8ca8d016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

The UUID 4077A616-290C-47BE-9EBD-D87058713953 and _PDC methods are
only used on Intel platforms with HWP support.

Attempting to evaluate them and showing messages on hardware without
HWP is pointless needlessly noisy.

Gate the code on X86_FEATURE_HWP.

Cc: PradeepVineshReddy (Pradeep Vinesh Reddy) Kodamati <PradeepVineshReddy.Kodamati@amd.com>
Suggested-by: CL Lin <clin41@lenovo.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/acpi_processor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7a0dd35d62c9..84848b5e65d6 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -597,6 +597,8 @@ static bool __init acpi_early_processor_osc(void)
 
 void __init acpi_early_processor_control_setup(void)
 {
+	if (!boot_cpu_has(X86_FEATURE_HWP))
+		return;
 	if (acpi_early_processor_osc()) {
 		pr_info("_OSC evaluated successfully for all CPUs\n");
 	} else {
-- 
2.43.0


