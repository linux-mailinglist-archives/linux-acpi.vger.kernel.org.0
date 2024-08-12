Return-Path: <linux-acpi+bounces-7536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9420594EFD0
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 16:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83781C2204A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF6183CC8;
	Mon, 12 Aug 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a1IdOeQw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E48183CC2;
	Mon, 12 Aug 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473650; cv=fail; b=niVy5AF0qCFOadSFtTEFEn176LanS7YSoGkejqMOtYC6kJ1pXZ/oE7j3f3BEYZthbdWv6XTX0otZ6ws7heiVqHJ3/e4/tJdpUeTN0WSqgK7IgFZMOTKNm+RKJRa+fN0rMKTxkf5g3bNjNoYssThxVZHO760tIo23Dn9lQkRRIMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473650; c=relaxed/simple;
	bh=2MtEtfiGxaoDyAp46W0KM5srPrBdINyfF17rd1Frooo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9NH4oDI9dgwQsl36VLBhIDucmS81r1ClUGjQNkWw+ThsLF1k8cC7sxyZQNqEVgmNKeT33t5jJFEZBtneYvNdAOnrWGsaXNzTDT86svJduKC1WOCM31h+787PM4t0k0IqQhN9djEsRImXBWgfFp4gjyLWU+cguFMHWN0wE7xogs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a1IdOeQw; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSghbY/jto2Pc3EMZVF9OYG9K0FGbFNZbhfUtBhn+l3xbDnNEA3UFxDpuJkc9SxKtNkeqWLTfOrJn6xy3KGyyqrQyB+2nECD9w6I4axLz93cXvKDAgt+Efl1xlP2e34e2BxvA8iEyybZ71NhxGR0DJCoFa6LlwuBmUzVnMig7eWu0pTIeE5o0Ic/lRDWXG2znNL09HMAWWEva2FrCqeDyaCuEn18lVyKZhkaQa4Q2vak7yUi5Vi2p+eCBBrmOO4XBjZa4MdACPtCVd4NepsEqlPkcldGfmwtm35BpHMk6yV+vUChcW3zwVkX/mfdhWYCjOxEhsy3gPJlIUo4fr0sPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm/ncd9t6TwilhTRFVFX8f/aVxa6AkKSi7ex+Kv/NBA=;
 b=hw9MV7Izy+uLuHXvNM3kNCEn1MWXitIXhJRDpoH9fAJIYRKDiwNMitoADZt2HpAtggr9js434KWLX1qVL693j5dBZcbhUwf/W53CmDrbT5iSHnAEp0rMNvsShOcNJ9umWRvTOWuY0SQiqEyYg6//NyqGmjsskUDdjkCHxqqEleAtIbLpG8syAhiz3UxaV1WEq1YBwVY6jMcAIxDDh1faqPfFRuEJX6eLdq48xA5r44ABZ2M83e2K5K/JmeGf8m1wgQdf4smPgP8DTlKEVuS/dI5VGsJFcQntouFmJVKjqZ8fB4KW/rGmI7oVL2VRpqqewaAa+UuzDYv5UD1OTWicFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm/ncd9t6TwilhTRFVFX8f/aVxa6AkKSi7ex+Kv/NBA=;
 b=a1IdOeQw3SsCsgCagX1fGWVFo2HZwqRYlyhnVkgOtiZVZq0k1tDRmWdsTahRu589JxPexaZ6wIhan3aV6lUSefyPvB3l0iGZJVouNm8FFFS0szdzDxKh5PTazVXDiiTdov99GC0jRIDgEda4sZCATMXPFtru1U83V/d2IcXX5Gg=
Received: from SJ0PR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:332::6)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 14:40:46 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::84) by SJ0PR05CA0061.outlook.office365.com
 (2603:10b6:a03:332::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13 via Frontend
 Transport; Mon, 12 Aug 2024 14:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 14:40:46 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 09:40:43 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Sanket Goswami
	<Sanket.Goswami@amd.com>
Subject: [PATCH v2] ACPI: APD: Add AMDI0015 as platform device
Date: Mon, 12 Aug 2024 20:10:18 +0530
Message-ID: <20240812144018.360847-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: 415b96c0-d8f6-4e81-8e59-08dcbadcc097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YefD5t8hOR7LEMF8PVDpuQathf3NnnwDc+meQe3+2lGixraFB4ja85sv17j6?=
 =?us-ascii?Q?/cXWaJq6uorqhGPNmDTnhmkQQvc6PX9OalhPMOmvfx2E5rtSBgyrJydY2KvF?=
 =?us-ascii?Q?KPPlNIKL6zvhsOR9MV4v8HA/ole53GXDHaOGNJkibubC+LSoGddY/+CzpMvJ?=
 =?us-ascii?Q?YMjAyCFgQ4Mf25e99LcT6Jb1B/JYFIaYCYJ9hFTU+LJsJnmf8SG4w92jsrsH?=
 =?us-ascii?Q?ERe8XvGakEwUQLHmBo3/VK2qpCygfumsuVrjETF2PXZEv1FPllLDK0yjknnU?=
 =?us-ascii?Q?4pivQW0s8JIJShHEWc/OlI8+0I9JU5n44aXmaBpcdu36C9tdRa2/Z83IFxbe?=
 =?us-ascii?Q?/Yf40haFh0S6/ZIK0sp/Fi0iZDsk1zfP5XVh57+A3CzxiBTIzY5kO/juC1CK?=
 =?us-ascii?Q?SR5jzVMFHXqiYwpI90VCjAhDuhFDUrt0ht+nzCFaE3VMw/abqTcGMn+ENDjm?=
 =?us-ascii?Q?c61WmqavxnGXuvx1cgstiQ0tRr/d7B3hxD55NEotS/gtHBRHGWr4NsMA68o+?=
 =?us-ascii?Q?CEyFIqBWB/OCaS4LPaeOC/Fn4sxHiEpGNWilw1vDivBD8f5bDQGjU9pHznLC?=
 =?us-ascii?Q?QORQMIJhV4zch2GNrDyvKCnMayxZLJcKfAXOJcRQtMC940SmPICTjCxzMLMo?=
 =?us-ascii?Q?329A5xaysbjXE2z0Nk+mNVGws4wmUaCkw5dVFa88YAxJIlJ1fbsKiswkK3HQ?=
 =?us-ascii?Q?ooKWLHE/5+RxNx/yjevaEGCc/UuQfZEP/zV1E89XOiKPSr9zeJlt+X5JrYbh?=
 =?us-ascii?Q?uratex2HWUFrZzZcMGWHcJYCuWIgTeOk7tGbXmt2sSxzFpdAI6GE1Y5iJ/vT?=
 =?us-ascii?Q?nmaxXUM0wk4urEpYMlxQGrZfc6U7Hxn5+zCWcGrhS0ePmJPcTdWIx0ehTFCa?=
 =?us-ascii?Q?WdjlSXF62Aq4ujkF/yH02k/vTXWmO1epg+gPZtx4yINpl5jW9bub/QAq/6nj?=
 =?us-ascii?Q?RxE8lBEFIHIPY/7Lh8Lhqj151LsMyTPUB9xtFRuTB6YXY02Jigxi1AOr+YTY?=
 =?us-ascii?Q?pIFKI49hrtoJ3izb3Q0nk0oArs++TXob+hpcaIDc0IvdNEJhaIRQkvxzuDVq?=
 =?us-ascii?Q?IbuOSzsB/L71SxLhzOUat9i7pDgI2qvRAwUIfqs+nfY+BuXTfLAq+u9gRFjZ?=
 =?us-ascii?Q?IYd22xARlNHCAlugM8tG91AsXk8q3Z/tSWsYPFOcrHfITZUZU45jtx8A4x4d?=
 =?us-ascii?Q?z8Q9aRFHmouncOZhVOoIAukI2mlln4SmSUGfoYksdgkwHLJ4/bWwOti/6go9?=
 =?us-ascii?Q?SyM5YyKJsXH4CQw30JkgR8LoAD/5qMUi4/ruWalm7STpjWI9SrygjUg1mB3z?=
 =?us-ascii?Q?ZEqIXInVfkwjPQgPP6UOuVGqNWL8XJmTwV10WFiQ9W7/0Mga2KzLX59NPbsX?=
 =?us-ascii?Q?S2txOO2Erli+3l6o/zYM+A+Ucc02vGm5F+FKfqohnHzuc1v1fE7oIXdAhQ0x?=
 =?us-ascii?Q?7epH5E/5ncEWalZ5VktYIxyNLlYs/+FZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 14:40:46.5090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415b96c0-d8f6-4e81-8e59-08dcbadcc097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057

Add AMDI0015 to the ACPI APD support list to ensure correct clock settings
for the I3C device on the latest AMD platforms.

Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
v2:
 - Sort the apci ids

 drivers/acpi/acpi_apd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 80f945cbec8a..800f97868448 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -118,6 +118,11 @@ static const struct apd_device_desc wt_i2c_desc = {
 	.fixed_clk_rate = 150000000,
 };
 
+static const struct apd_device_desc wt_i3c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 125000000,
+};
+
 static struct property_entry uart_properties[] = {
 	PROPERTY_ENTRY_U32("reg-io-width", 4),
 	PROPERTY_ENTRY_U32("reg-shift", 2),
@@ -231,6 +236,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "AMD0030", },
 	{ "AMD0040", APD_ADDR(fch_misc_desc)},
 	{ "AMDI0010", APD_ADDR(wt_i2c_desc) },
+	{ "AMDI0015", APD_ADDR(wt_i3c_desc) },
 	{ "AMDI0019", APD_ADDR(wt_i2c_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0022", APD_ADDR(cz_uart_desc) },
-- 
2.25.1


