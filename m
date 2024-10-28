Return-Path: <linux-acpi+bounces-9015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41B9B222A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04501F21C43
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A267E17BB21;
	Mon, 28 Oct 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HNmP2vXz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454215C15E;
	Mon, 28 Oct 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080925; cv=fail; b=bNUU/e4fATpjeb0Yp+F/OwShmlVnA6Pgava1D+gNbMV8g9Isvl+IBezQ2tIgTsHarr0YUy1Fnc74tKomUlRDts9A5b01Ttd5pOIsO/rpZDuwgX6H9cDo0t5pErnslNmQNtdTlT30KLRNAMTVECOwmffRjj/dECWrnHzBdGpq1L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080925; c=relaxed/simple;
	bh=de3AWWNWRwnOjI5JEhl2BogaBfwkYA0AMi6Mqnsngm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4ct9xYJBxeWml/aPhwQOqD0dvoHjFxLVO+rEBkpF2imLXv/wOyj6Rfl2rtVMncRelqWNaZcVeno++kyFcaybDlJXpAb0eDtkFSPjR6j+VvifE/pUiPWBYafQOz0au6R7pIItZYq8iBE59hSxvMS07Du+WNHqDrN4zaA9I3UNw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HNmP2vXz; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBaeVcakPJDFqfggl7xNdKyNHoYNz16+Xv3RrqRtv2gCjoR4tWMU7SbWfn4BaTBBmgjwGKFBeQrz5MHqMy1qYQJ6bpDixJ+m4UADDL44kgcSS5CcG/63byVyZy64PNV26QtoGl1bYHWk3Zh55xnXUV29oXb9udKqvKEwa08DwH2EkZ5L2Uu/J5s1YauSnydaGciCoG9adOhhU9NDaVJc6ShwTecf//SDCws4484ChMizwLSJHrjpEz79DmqQ88BquwX7JBLlo+vHoYoWCO87hd661mI3r5eZUlj6D5F8f4m3WCdR4OZ2hEOrJg7Z0M3PwnTaYCN9Fqok46RnsXDwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYjUGZfEpH17UmDTCllqNcF3L/ekuBp4y7Uh9aUsliU=;
 b=a58qUMKnUEZCMeM2jZ1NRJZsiTWBWhaKuDog1N6IiD/xXVv/kzv3iJ/XRuPYvtfhkgejDQPa0IxR8KMLI0tlvYEyzSrZY7omansuIXwansTcjd5t89PTM7exDC1uk4MC15LIu9XM6AxWXo3f3OoDKqKhtN835cotwnXazs8kAKvOctqas+qfGniI1Fanf8r9ZzgUt0mxjHRHyNPcUfiVWh0MFBZjk3cJGdnic9b2bZIeNCJRIUcnkq9ylaGqwBVnU3EKd9PjDu1wfaSnoaRmCjyAM8QkwuJghhShCj2SshYk9FFeE6IF3rhyTsedc62lKTb7LPX1ZlOg0LVvaBNF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYjUGZfEpH17UmDTCllqNcF3L/ekuBp4y7Uh9aUsliU=;
 b=HNmP2vXzqB7F0WTG8+Eej6ZlcDdjoIecOYHDrOrHQ0GVAM+hkqV+efbTmdXp9XELXa5d55Ohwsd2rhscRPmZRxnu7ux33k77YV2+uhJjhst8VCoerR3rQ+9nKgWTONQBaFmHkrjKNvxDg6XdaOJM0wtBidkkAkWQ9XM48QtZ+Zo=
Received: from BN8PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:60::34)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 02:02:00 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::6) by BN8PR12CA0021.outlook.office365.com
 (2603:10b6:408:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:01:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:01:57 -0500
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
Subject: [PATCH v2 02/15] platform/surface: aggregator: Add platform handler pointer to device
Date: Sun, 27 Oct 2024 21:01:18 -0500
Message-ID: <20241028020131.8031-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d75613-7e9c-46ad-cf26-08dcf6f48240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fob/NRHPivyvCHkYMcDYto/nhmQGbAwhpr1bFA54bT8A15CmHPnMuNbv4XOR?=
 =?us-ascii?Q?ZMYAe/zoJ1tG2K9XQjJEkfhwpSE8wrnexnHZdrtsrLoPSkOTLauMIV1wDqSC?=
 =?us-ascii?Q?MVhLJ2erW+vvJX4QSnNT+955q/r4joJsRi+5mYVMD7ywuKTXZ5zJfcS7QCAJ?=
 =?us-ascii?Q?9LRqCjjFktJ0khVzenejRwX75lf6czaRqkj7NoUkl+Q3RHLiBiP57qSAadtU?=
 =?us-ascii?Q?pjTWXKy3YUvZP3dNzpqRCt1s1fAC+zQ7XCytdJ/CEN9b4vAHqgozyU3FGkjE?=
 =?us-ascii?Q?03F7dsWs7WZ0pTprTYK0rM2vN+mpV24nJxVmW0jgF4oRD826zpBWIwUvKzmn?=
 =?us-ascii?Q?5XPRQOeSnC7gGXOadl25J9Vh2qoYyJmYbO1ms5vD6vhxBnKm91U5FwqXH16n?=
 =?us-ascii?Q?6YTPOIZK2BMab5XpHh5I6Z/E+I+L55Z20ty+Q9GTs9cIxRuepniSNq/EsquR?=
 =?us-ascii?Q?2ZRgiKAvckGr8SrbF4lLCjJq3SNqdGl4R0JQxkfgRbYn//Z5a7jDNdvqhVqx?=
 =?us-ascii?Q?S40HGqd+2nfu+f4z1kY2F3K3KLdpb1Ppwm6PNeffTeACim4IZM/zjKU/6tXy?=
 =?us-ascii?Q?y3Gs+eWadkAtgKirobAVDM5xdsGs2ZJb01sZ/RuwoCYLoeLiewMDin0q6HQd?=
 =?us-ascii?Q?lkynhnoqqvH+vSXbvPRPT+coK3k29aYDTetWbjVsi56M0ngoQs7xInR/a1Ls?=
 =?us-ascii?Q?ccn0D9NKrMB2245GErXmVlLwPawadhTe3nTptOwX80/VczKRhND8jnW4jF20?=
 =?us-ascii?Q?WbZ2OmJRS2P0fC4dk77CQZuNkk3qOJuN9TEK5T1k++OVkMp8KMfP80wy/RYH?=
 =?us-ascii?Q?TFBEe64vLrzNqXy/gYnMlVagjmNK8P4qwTEiKCSFOqz12TkMQrArwS6mBfNJ?=
 =?us-ascii?Q?NJonT59K9M+pQPzsqU3k2l4B+EV5fgTjSlVwPQoIDailKODqREGzbXbzM7e4?=
 =?us-ascii?Q?7bLwAV0bYbyCrywDfKy8V3pWAFPBjZKRDoZdRgTdwHpAb8FWP89iVkBCFvGh?=
 =?us-ascii?Q?CzicLurfmfAh3Oi+eoZ+g4f0yj2WUhwYseLrN50kxlL+qCVwoXs+h5DZkmbH?=
 =?us-ascii?Q?PvQ9tG6qDXh+4SR5sYWJqBcG6EccLc3/Lnz9LQFA7fXo81lMce2RuxSCY+Xo?=
 =?us-ascii?Q?b/N8Sa92F08y34vk9EDtnC0xbf2t4oTtxeu0gbiP9tf8MnQx3NyoETRnp+Yc?=
 =?us-ascii?Q?W1o0lfrBhX/MGwLN1k6a+xDGMZJb9frpaL9SGCXmGGmRiqxrjO6qtL/0r9z6?=
 =?us-ascii?Q?fAKYXu2IMwMVBEIAcr8lrIZz1M99cNw6FW8F5htgryqzuZ5+T4SuhYp2wEOg?=
 =?us-ascii?Q?EE5nV6Kcn5w/cvP1qUwEij6Nt36Re6KldXR9gjt9NNznFvvRw5IA7C6m1IYK?=
 =?us-ascii?Q?Kx97EbC2/xpW4bt8yaAqptePa2cXa52Nyn1k9d0PlvZoYouxOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:01:59.6881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d75613-7e9c-46ad-cf26-08dcf6f48240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443

To be able to reference the platform handler in remove, add
a pointer to `struct ssam_device`.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use ssam_device_set_drvdata()
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 61aa488a80eb5..a18eb93eebb92 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 		return -ENOMEM;
 
 	tpd->sdev = sdev;
+	ssam_device_set_drvdata(sdev, tpd);
 
 	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.profile_get = ssam_platform_profile_get;
-- 
2.43.0


