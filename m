Return-Path: <linux-acpi+bounces-9019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8B9B2236
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3244C28201B
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A89189F59;
	Mon, 28 Oct 2024 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OvRrvyoa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B061898EA;
	Mon, 28 Oct 2024 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080936; cv=fail; b=fHfZvppNZr9TPCVSYxIAax0UsgzboRyP3NuqPPJp0qUVzBkDFX3UtkONvffFBaBUB3yWu1YzDxt+XsUdiwu36okgz/z2iO4F5OuSMyVCh+3VkqGMotqTpzjWD+EYu/vM/9RDV47SMA4qoZdUfkExDN5+XmE2Lhr421U5T05dtsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080936; c=relaxed/simple;
	bh=6UVvI/hrMc3Z4NlfM4Auvh1sdIFbuy7FXc5WqSu8H9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaOzPzD4AxCURdSlpCt2lha968vitsSvJ6VoQYPp+8ygbNi3+CMorrX5C4HTTCchDPH+ZC8DeuuwayvIgVvsDqxVlYrvoANbKIdtXo15gEg4rv9uHhy7H+WvC4tvXNdLqyPJlWdUycxWvJjQ5dIIqoPcq9Z+ySjunoFw7p5ITBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OvRrvyoa; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpUExAF9X8dk72qHCwRDYZZrm2Qbf+upMU9CCMSFnVlJIhKBTPS4OpxHH7HBBlj63TSX85cq11tqgX/vXYmNIohqR5n8HlC/mlI3hhBCl32/yXx8iFcYbPRfmzq3EQ7a9lSF2BhLR474epbAio8njEjOZZ5MMYs3f7aCiW+yUcbZvRVHjueWL2rTsW1fUPqcwNFWQs8nj8wYBzVxQr7b68mbbV8wONvYWh3r5kwh7e03oyV3Xl7e3h5QmrjgZvWcXM9PHnvBhZwH8C6KBXl79y6kCN6O/Bnn7Al0mr/U4g3dKIADRSzn09PTJ4lrm4ORuCoMvdQUbIeYz6q3Y33nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bufHmnAAIirCmlj+rLsSytIevQgXf8dVoG+S/PDP2Es=;
 b=YeTrwroWSzGAR/nsT/Rvqi/8NmPoD7z9cMd6KKGzTju84OluyV16M28hAdWt6mBS9K7Q/PsAWg5VCnqixRxK1ICrVMQD3UYWqt0AzHbOjpMOkMYTGsyAqGw4fVTzcA2Jmzbr+8vy6X2DOBE4tk8yilyLMSMG98U/1t1uFwlVyPABsA0BHIWd5pHpWyyP6YkElfuCMakGnUpM8kolbHTCJh8bc5vABdL7KfszdIdLnAURYYC/cZpfonhmX6CgPiMBgRm5agDtz+5iL/vttHBQv02k1RFhQwb74YajeRGudSD1wm42c2qwkfbpZY41QjBb8k2eDItTk0AQ+1+qyT0DgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bufHmnAAIirCmlj+rLsSytIevQgXf8dVoG+S/PDP2Es=;
 b=OvRrvyoa2kAWUmZIfCuntXtezXrsihLHlVnaoTdU0Td7TjBT1XGXbtdURJ0cjr3UvFRz+9/uMo2l8PPRBmnFQX9uOwLNpHMV6H4VSYiiy1fDm8d5KdEeK6sudGmjncuI9aE93gEr2Hf5AKj7Gq0LHQPsZ99GD1a1bJnHrGD6+iY=
Received: from BN8PR12CA0008.namprd12.prod.outlook.com (2603:10b6:408:60::21)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Mon, 28 Oct 2024 02:02:10 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:60:cafe::3c) by BN8PR12CA0008.outlook.office365.com
 (2603:10b6:408:60::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:03 -0500
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
Subject: [PATCH v2 05/15] ACPI: platform_profile: Move sanity check out of the mutex
Date: Sun, 27 Oct 2024 21:01:21 -0500
Message-ID: <20241028020131.8031-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb101b4-e6d0-4dc4-d58f-08dcf6f4889a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7216G/gmUFhoDYmJxZj2Q4wJRE0TOz6Zlb1VZ8wu5WCPE4LOOAwwjC9Ufl2?=
 =?us-ascii?Q?fEf1dZGF02cn41BEDIhXhMxIYKqzO7tDR1GNTXl/EJVqk4mnxp5EcCV7REgl?=
 =?us-ascii?Q?dZqfXspWNzhjN6ZE/2hqcNYJuPHA9sKTpWwRV01uJvr1GHL6g2piEGfl2RBj?=
 =?us-ascii?Q?NDWub/HpK1X2nHWtLQLrt09YFjUqLp0H1hQW0LlmWsO02LKDRnCQc6Lj4bDm?=
 =?us-ascii?Q?OMSzShDjF3xcwHNW9nrDIjX3LLjYGoX8JqaJ78JMwjFfNOhQ8EtWXMJ5J1Qt?=
 =?us-ascii?Q?wFlGcAB1P0dnlOAG6C9wMGOZX9Yt+I2o1vfEJ/G2yYHwQ7gYlJu1GfUKP/Sp?=
 =?us-ascii?Q?IQbQSle/16DwEMDDL+HjVWvZQdONLbUtbWHn/xbT4bYvjl9eRynRmM9aiL7k?=
 =?us-ascii?Q?Ruqcmaqwx7qEQTYUx+wDMSsqlJcQsT6K70L0Kxjxzi4wEJHcUip3pOqNHQYu?=
 =?us-ascii?Q?hiBK7L9PqlCy5iZ9rl8dfbo4w8zcqDD5/Eqd2c+3xo3o/UB8R6TB/3m2bgiy?=
 =?us-ascii?Q?kF6Jf8lhHfwGUu1er565+GEx8McG7lrrtt7xwERcTG6zW+c24O3UqXVytCsS?=
 =?us-ascii?Q?hnBboALAzu3kcastQn/dt1yM/8K6ktfEU40UVcb0S55PyVoRkm0Lm51EkpRJ?=
 =?us-ascii?Q?NMfrlQhWX2roIDino6wnFNw2ou+o+DwMmuwgWFIJvPd5OCO+9bNhTjWeFyR1?=
 =?us-ascii?Q?+qWw6xPm9b0b1UJ/NtCz9z0Bc7+BYNHGraMUOXIEq6/Awwa4q9CJSxvjRJ15?=
 =?us-ascii?Q?EC5CLuz+pjS/o/K8fRK+yKm4NGHZxlcZDsJGeepixaGTBbqpQGNPbCTO2Xl/?=
 =?us-ascii?Q?z2sgp+/q0zdTxQVPeZ8EHTWMmAto1MFEzW4pJ9gDpaBfQ+0Y8hQ82Wd8jtLZ?=
 =?us-ascii?Q?r6w3fb3qj9rOGc3kuk1QTxt4rOcyI7xAdbMmuXwlAimFuyY3NPXUfsOouKJo?=
 =?us-ascii?Q?Ip8ZBqrr3POacwhMl9duyFct6MqyvN0d9Ml7BEvXeUDUwkR975l4qp9Oeu0d?=
 =?us-ascii?Q?vUh3RRlEqxqkAN1l9ZWTgZpJMm830rkPzeqN3aPvTG6jbelmyvqfh+2l2Unn?=
 =?us-ascii?Q?buwDmRYJK9+GSaQixMp5l+Sj3OS8ud93tC1EN3gPLyqFA9lByqEL7tTqHqcw?=
 =?us-ascii?Q?Ij0VXDK4mUEiPMa7imh6IAHFcLKFjFTXvoX7gBakBu+SPfAZgCZ7WtlfYhDU?=
 =?us-ascii?Q?WHQ3azpWHK96PmZggIHsJWuVK/9jIHLXVErc7XHiJWPRK8YEHoOlraRANdyE?=
 =?us-ascii?Q?HFDR+y6YUkT5JdGeRSbiEqmXF5K2gR/VdnrL9/u/BX021yGQMgFQOa/XKLF2?=
 =?us-ascii?Q?xMER6fwDGSPrQoacB4wFMKWxsoWLlQdzhkfV8HZVpl8MnBSFvY0rnVQIfm/r?=
 =?us-ascii?Q?g0ggJoZrmPQr9OndWgwYx1LyYlsSU2o4b8xImby5iiEcsFFWQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:10.3444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb101b4-e6d0-4dc4-d58f-08dcf6f4889a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133

The sanity check that the platform handler had choices set doesn't
need the mutex taken.  Move it to earlier in the registration.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 0c60fc970b6e8..c20256bb39579 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -180,6 +180,12 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
+	/* Sanity check the profile handler field are set */
+	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
+		!pprof->profile_set || !pprof->profile_get) {
+		return -EINVAL;
+	}
+
 	mutex_lock(&profile_lock);
 	/* We can only have one active profile */
 	if (cur_profile) {
@@ -187,13 +193,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EEXIST;
 	}
 
-	/* Sanity check the profile handler field are set */
-	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-		!pprof->profile_set || !pprof->profile_get) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
 	if (err) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


