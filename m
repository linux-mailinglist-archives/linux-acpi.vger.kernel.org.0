Return-Path: <linux-acpi+bounces-9022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA09B2240
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC819282049
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E4718C345;
	Mon, 28 Oct 2024 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIG/tNxY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7617C7B6;
	Mon, 28 Oct 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080942; cv=fail; b=q+VgNHS3X2+W4vJ407tPuILf4McuqxmpZiJAiQyoPztxXG2FmRW75FHWmFxjZva6E+y3TmI1/VGISiZueq9s8L2p/V/qc/mVaKvz+fFy9TBs5RmJUUJoRY8lIIl2Nmdvr7A/A9mcukSqzHPGY0z29QqvTeLXt+ziHoxXozGIOjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080942; c=relaxed/simple;
	bh=peMEyDjMFmdHm7H88Ur6wcOkl8YlUwv14hgn+PXRF+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbUzl2/qYBUIsdpj8YXQUshyPEZVktui26Z3VagJYhlilzmMHmwkwjyo5ZT1O8olY37hNFPdCNJpp0Cn2CAmJjCzy8CcIid9+Kdh54MGbuaAFSsscQ3LhBd8noyHalZ+rlXw+FC92GP9Di7Zr4OY0RSMqEJO1DKDBn67DP3CUvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIG/tNxY; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um30/a44E8a+qEzDMsM5sFp4mANDSUmMMK8GTpohJVh1kWwJJc3+A9ouUhqxwqRtiZfKGYdPVrBrovw3NSp27NjonkjuTzJXtS3YgwaNhLbEzFmTI7pOkqtBTdsvO3A4iLn2ETedOaS8Ejiob/FNU4l4fFYk1jL3nLA0MhVokeUA1sZHsLlFRiVQLw8uSlVuVK9VQh2XwcDWF7hHkphovDXeCd2lR4veq/o7OdMSy8ZDKTJjYb9Y0/UT94FqPnhrwNqXsN4T5IH4XEDsVfuFfdnwMmNJ/BTY+dSM+gKYUCdjtTxi6QF7UTV2RuKobuie2e3ln9iC+bhRjAlWoNrs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBZo9vCmFYLeayd4nVsafVPbyl/X4puzMIYHQcMpcF8=;
 b=dz0990ndHGSVAtUv+9wcQ0s7rtt/A7sPW7tRhP7Ql+hHDbqTdV4ix48tCdvWJSLFEVwUOHqVtUBehVX1g+uH8eV2gd5Mknbnu9VCfJZw9IVri3p0SJwzAMgbEQGI0oNLDktbhkJ0JodA9zOaxf/k3zUXarrH+8Xmtuv3qjKjxm8wGvZFykOzVTkBLbLtDk/kegDyF3xTEXiWTwclzBYTaFypVvtnROYbsZ/dM/7S+o+Urfr4InwGppplD68Cdbsck7Tc/a7Bp3qr2KSdm8LnJAxJKlEvOJ4DG6UzosLV3uk5hoSKKkHYmFlCZubsFNLao1Q3DY9AXxBxmTkyiFPaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBZo9vCmFYLeayd4nVsafVPbyl/X4puzMIYHQcMpcF8=;
 b=cIG/tNxYn05Bb/Toiu0oA2KxY4/lm7ITP5Hcinpo9NhwjbJHFuq2Mo+8vCnsUP31fuh89Mo+cpgCGukSawfQ/QWh9WmtdV7LiL+/rOhHlsgSrIYHA8bLWhvrBI6WU6GdqIWiAC845z1Sqn291zWKQw+GDG+Vk5A576BCXg+GGEc=
Received: from BLAPR03CA0064.namprd03.prod.outlook.com (2603:10b6:208:329::9)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 02:02:16 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::b3) by BLAPR03CA0064.outlook.office365.com
 (2603:10b6:208:329::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:16 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:12 -0500
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
Subject: [PATCH v2 09/15] ACPI: platform_profile: Notify change events on register and unregister
Date: Sun, 27 Oct 2024 21:01:25 -0500
Message-ID: <20241028020131.8031-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020131.8031-1-mario.limonciello@amd.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 945d3c06-6038-44ad-692b-08dcf6f48c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzxKUqIOZUWoUYrEAabpfbatVCYBKg4zghGAtqqUjoc/n1hd815XZx/YqhY8?=
 =?us-ascii?Q?FOPW9Q3qNtjiBFBJOa/vTj/UpJ7aUbhRplRxxYN212CL51ZHWKiwfG6jQOOX?=
 =?us-ascii?Q?mCL3hULDSHCxgJnRyWcIb+bgRZU30T2NfnlrGWYIKG5yf/PxKfptsaXoedbs?=
 =?us-ascii?Q?84gQI7LPnSDn2bMmU5RiAU6fYOoMhCyWyALlMnNfd//720DxmYN70rMYZuXB?=
 =?us-ascii?Q?xfKXocqmesdDepYJzGFNAfEHbZ3IktT5sqxFc0SZp7IopvKdy3FMpo486/NN?=
 =?us-ascii?Q?VCaIdnG1AulZ2XHzJ1Zoth/iz1DJmJGQdmRxmwrOcxV1EFxIPJ4lDwEFs0FQ?=
 =?us-ascii?Q?Xu4MDzGCYG5o2gKAOSjQZd3pvPph/mI9fV9CKLqqN2iDd4cR8nVWvqDLkCKQ?=
 =?us-ascii?Q?/1M2hBad9qZSeUmJAhRSmv66+hulgvzvJ7OcMAQ/+3b1y/jYEqKn9hbZLCoS?=
 =?us-ascii?Q?X2DbQljg1LKHTqWwUuaSrKr1lK54ZHcAdNy73hzoa6z12/U2jEh0f8E4xrHo?=
 =?us-ascii?Q?TtoaQt8QcpNcE6Zk1eYsqpe+b4jHqxEIWzwCjTtG2s4Xaq0KAiRSLlfonQTz?=
 =?us-ascii?Q?Y/PV+xhJULRVGJKYBQneAaFS938T36q3I/61O+eAvmCJIX+VKKq0LcXoRGm9?=
 =?us-ascii?Q?KXqj+iJ7spVlhyRso/+JW99pDOJAHZD2P5v8sK6J7+sCt5uWC5He66LcyMTO?=
 =?us-ascii?Q?7E1gataWiv9X4Mj9LkumWxbHuUJYGEVgPjH4hPFu+kqp7tuVn/sad/JDQmzw?=
 =?us-ascii?Q?pGWF8wMGnpZaQQs1uFIcCHfOHq9WruD3DnO/zs6GBbvnHr2xU2uI7HP03/KB?=
 =?us-ascii?Q?+FtDHI3g9Ou1+kr5uww9RZ/JmGYqe/2DxnCpji/VSDZfA0R8zlX9bnLAnJP2?=
 =?us-ascii?Q?2fw54zpYtJ1+M1Zod8AY40VcsUCfEp57Qx2d7qiqPZ5W9L/LT3Utxoj2dYdC?=
 =?us-ascii?Q?gCJw8dLyN64MTlDewciWg3Dz8rhQGllysSVG1uCCoW8IZHMZN3b2qIzUeN4v?=
 =?us-ascii?Q?HjGm5FRvODBtZ5E9rTRY+qCE2bqYqthfKEkJu4N97UKEEjx9m9q2yaaojU6S?=
 =?us-ascii?Q?+8N8gsm8E+ZoBohZXrqpguu6UHSoDMiGwWtIhm0WJ6xXoo12huvFTEgejerN?=
 =?us-ascii?Q?iqM7rMNj0EK74XFe/LlkMwLdCHoli/RH5skEmc4N+lDigULZJvAHqaNMOgOy?=
 =?us-ascii?Q?E+XkmQj452EawcdShm68K62GWfv+6uke8Hh+yP448Q9/4U7ZuTuBFAFxbvwl?=
 =?us-ascii?Q?jhX8W3SChxh8GdeQyLbFZ6PaaaVkDjvRFALrebyw2m6sjWr6xsPveWwDhTyp?=
 =?us-ascii?Q?RM8LHBt2P/CTT+koOQgKMIpqPJYcAuosdEdgAkOPrTd5rfOAI6aYPcuLk8QX?=
 =?us-ascii?Q?/27aKRgGVxRFtqedLBPrrF6q2kvJMFcmxYL9bWw8Nm+sre0mjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:16.7747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945d3c06-6038-44ad-692b-08dcf6f48c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c0d0775831214..5fee467614eac 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -210,6 +210,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (err)
 		return err;
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
 	cur_profile = pprof;
 	return 0;
@@ -223,6 +224,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	list_del(&pprof->list);
 
 	cur_profile = NULL;
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	if (!platform_profile_is_registered())
 		sysfs_remove_group(acpi_kobj, &platform_profile_group);
 
-- 
2.43.0


