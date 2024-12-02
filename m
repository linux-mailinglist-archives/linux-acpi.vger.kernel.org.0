Return-Path: <linux-acpi+bounces-9846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62519DFA49
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A795F281813
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2CB1F8EEF;
	Mon,  2 Dec 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3iU0iHt8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94A23741;
	Mon,  2 Dec 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118695; cv=fail; b=tl75YXXg+OVlKs/PR2aYZzSVp9WLYUDm7mciipng94j50UfgPwqmSduuK2Bl83Y7goaMzEx89pfCoSf4wTbV4o458NmCFtNc5f+dfhVxfSrGalSZPedesNO1p+19ws9fNmqTCKB/Dg8ar22qQsmw1wVB4YIZqTAETdhPJ6J6P7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118695; c=relaxed/simple;
	bh=2GfJ/SjUIoNaiwHOnGXTGKoy8oQY1NZVgcne1nh591o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK3F/zZafiSq7gs4J0oJRVFNI3fiH3vC6vzUA7v0igTxWADkGPeDpyMieukq6+xfJlBhQmzQc+m5dZhXXT9+NBRamV190YdEYJwQHxCLQSj2xSV+BZCDNYk0ubT+Hq/R64RHDxCHtX8dtMQQQ6Gss8z7YvFowoko0kP3AaGU+RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3iU0iHt8; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdOm/KiNAGNDaK7QSyb0OeQJVdnMpT8n+FY1pat1KicpYXYNa4qq+qFZHDXU/a3CpfpPDp8PG6bGrN3yBXpyK1A9JX6lkXF3caKPGpRxGDUMp2X7z1K+/TtPVzaO+dQ+A1MFCDqkgq52E9JRhp/0y4Y+dAQa2T2Y+qX3Vf4RfQ7NvTwNA5wyxHMcU89lhV91TbGsq+1gcosdpJkmCIHJ5hnSGgstaufikeXvDpvDdJecZWjbijZmUJj173JVHrcdhnDHEcuRF6aHyGjEf1+A8PHQT1Vioct6+qc/5Nb0wKzoV4BJ9W/U+Pkd3KDbUj5d6Fwzr8S3ANFAfpDDNbnqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoQnBgUUl7eonCm8N3+8uE69DCAavYY1OE4Xsjy+5YI=;
 b=Lj6BYfryWZHAN4hin1mzJpcrBACDVce5jrI/V46SR81+CAgK4SQ+ev/4LtwrnzEvEKuKocHoAGG4AnTjEMMfMNEnOiT0eTJh6XpLtw+C0gpvdIkDspPJksqPxNSglrXjQh9njiifl2EFEiO2X+GIr/SjLY09QpneJEvzzFlz5dcx+fUqxgStBQ+07Em8NBpAYm3Xg1P92+goTC4BTMnF13x3sAR28xnoxDRVE6ZcvqkEUryCDhoKAwTBg6YYRb1pNV8HvIYKEcWxyrtIrfDv6xlMPhQ+wMiR4JFLvry4+83EsXg251gOEC/KZwjOysQQYdTNKv1G7bfoQ9NjPXQuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoQnBgUUl7eonCm8N3+8uE69DCAavYY1OE4Xsjy+5YI=;
 b=3iU0iHt8D8HZC1Lz3T8NG5rPLjl255r9FM1M84dD4tJLT7z9fRNWqdp/eCoWQC7Lcwd0XXRrWH7feXhjqNiAktSGarsaI5PsLSnabxVhWIYmTOBehEr2VZx6fwhjpAGBsZMIabz9+Om9bW5/q6zrabd6Cz1rF3UPF099RAai7wM=
Received: from CH2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:610:50::16)
 by IA1PR12MB9468.namprd12.prod.outlook.com (2603:10b6:208:596::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:51:30 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::1e) by CH2PR16CA0006.outlook.office365.com
 (2603:10b6:610:50::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:50:59 -0600
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
Subject: [PATCH v9 01/22] ACPI: platform-profile: Add a name member to handlers
Date: Sun, 1 Dec 2024 23:50:10 -0600
Message-ID: <20241202055031.8038-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|IA1PR12MB9468:EE_
X-MS-Office365-Filtering-Correlation-Id: 377c3ce1-a50b-49f4-59ba-08dd12955e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MG5WRjE3S1NPc1Q2VytnbUR6YXJmZjFVYTRMcEI2QzhYY3hxY2RDNFJhdFNM?=
 =?utf-8?B?UTBvQjljSTh6ZEM2SEJBQjFEOEJUV0E4ZnpLcjU1cGYxb1A0VFdhYWtkYWJZ?=
 =?utf-8?B?NWVhSXJrMmpXcFZwNDgwWGJnVzZvUnN3TllIZFZIMENvNzNvaFNaOTNXV0ZZ?=
 =?utf-8?B?LzNIOTZTSFllZzRISUZ4U1JyOFc1N3hUbW5kd2wveXkvOERMMGJzRkhkdkpT?=
 =?utf-8?B?WjVkeWJqNG1iSkFnRksyek1nZDd0Tzd0cmpqZ3BrbkNpY1dPZW1VdUxyckdS?=
 =?utf-8?B?Yjc3dkI0cjZXaFUrT0VJcGFrSmUvRlpHOUllV1VVWThndkpEQXo3RUZSTG9r?=
 =?utf-8?B?blNvaXExY3YxTitSTktOWVV5QkMyY0ZCcXFmM1NKLzI4bkNYSXVFaFQzR0Yr?=
 =?utf-8?B?YnBFNUhacmY3b3BDTVUwU1dQNEZUdE0rR1NuSGNNYnAzSlBOUk4wbHNCYUtI?=
 =?utf-8?B?SHEvUThLT1lESnlpVnRLdTVOb3NaOUJvYlF1Y3g2NHVwdU5NUklmd3ExdDZz?=
 =?utf-8?B?T2o3d0sxeWZZYklpemg3eUJuS1Q5RVdkUDRzd0VKS3dBS3pPOTdxUEdhK1Rj?=
 =?utf-8?B?MmlqWGVWYTNYQmdwcTV4RzBkdG9BQkRaUVhMcDJSSmFwM1lyZXU2V0l0Mkta?=
 =?utf-8?B?N0FWcG1oSzlzM2hieU56TWdpekwyL1QrM3ZIeWlVWkhyeEZaaTBMZE9JRUZj?=
 =?utf-8?B?YmdxM2hOZ0lwN3RZNEVGYUdhaS83K0xjcExqYXhHK2ttMHVheG56SDVHUWZz?=
 =?utf-8?B?YkhVRlBSZkNVcXpoRVZJOE5sU1JJZDF4M2pBNUNKc2x0WjBGY0I4MG4wOWxm?=
 =?utf-8?B?V2V5M0phL3AvWVlUSmhWelIzc2Q1VFpTOUtWeEpPRzBOdmhwRklUTHdXakVp?=
 =?utf-8?B?RllpTnJPUkVVZjJuWVVvV2FnKzlORGFOUlo1elQ2eit2MzIwYm52WFIzYy9O?=
 =?utf-8?B?TE96V3FzaFVlQ0J2NVZCdEo2WnduY21xLzdDYzdWMEdqNGU0SFFnVHJOR3hI?=
 =?utf-8?B?bHd5a1ozdk9QSHhrMWlYOWlRcUJobGZ2elUxaG1XdVdWM291alJUcTZ2Vko5?=
 =?utf-8?B?SEUxZlFkR0w3SHZ6YXpHakRudHk1L3BXbUEwNFdpT3FaTDcxWWpsUEljM0ZT?=
 =?utf-8?B?VVA5aEhNc2ZwajdMSTU5LzBCOVhTVEJmVlY1c2lIZnAyQzh4dlNQRGJZS0RK?=
 =?utf-8?B?RW0zMzJ2NGg0ajZOeW4zc1dCSmxrSVRzWDFJUU1OeWFjb1lKbzJGWlFjS0kz?=
 =?utf-8?B?WTNGdXphOXFGUVNhWHIwYjBXcDlGckM4S3dEWnZ3Z1hEc0hsMGkydTZUWXRx?=
 =?utf-8?B?THJQTFN3d1NobHdwMUo4dU9CYlMzS2xRUlpESEhzanJjVFpzNkZjSm11Tkp0?=
 =?utf-8?B?VG5IWkNEbU5tV1lQVDJhZ2JTZHB5RUlNMkFSRzBrMFVacW1JMmdDRHAzQUIz?=
 =?utf-8?B?QVVqNnBMVjBKdU9Bc0FnbmpCcDYrbE8xM05oM1NGUEtjRHNId3Y4ZDZqWVdQ?=
 =?utf-8?B?Ymg4R2liTUJEOFJWMEtrTFJCWU9lRG14dVJpNVg5ZGFWM3JPQklhVWxiTGlp?=
 =?utf-8?B?WTBQdDFWOUdodEhJdC95VVBkRUx0Z0duems1UFdSMXNDVjJBSU9zbzFqWE1x?=
 =?utf-8?B?aFEzOGF4bEE0ekNrSFZzUkZFNkY2WGhwRUxVRkZXR1cxSllFVm56Z0lna1Ru?=
 =?utf-8?B?dklhdm1Qc0tURFNqSlRrMnRUcnI4WDlFbkJET3IzRklnRkdUZHkzSUJmM2RG?=
 =?utf-8?B?dFk4di9iQ0MxaTdXdCs3bGtDTkMrNFlUcmlnZkU1a0tpZEdZcFMyRlk1U0pZ?=
 =?utf-8?B?YUttdThLb0NxVm8xekhrUkVVakdUdi9ydVJ4K2hoa2pVUUVQWUxleHQxUFhV?=
 =?utf-8?B?VzFjMUFFMmJwQ0M2WU1FTU1Gc0N6RFFYWmJvYXREc2FwS0VGeHVJblJBL2pZ?=
 =?utf-8?Q?ty2tXAodUqaK3VevPlXGVVLxKV5r2meA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:29.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377c3ce1-a50b-49f4-59ba-08dd12955e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9468

In order to prepare for allowing multiple handlers, introduce
a name field that can be used to distinguish between different
handlers.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 1 +
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 1 +
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 1 +
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 11 insertions(+)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 08db878f1d7d4..9d3e3f9458186 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -211,6 +211,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 
 	tpd->sdev = sdev;
 
+	tpd->handler.name = "Surface Platform Profile";
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index d09baa3d3d902..53fbc9b4d3df7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1878,6 +1878,7 @@ static int acer_platform_profile_setup(void)
 	if (quirks->predator_v4) {
 		int err;
 
+		platform_profile_handler.name = "acer-wmi";
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 92f7fb22277dc..e2d0cc92c4396 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -405,6 +405,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 		amd_pmf_set_sps_power_limits(dev);
 	}
 
+	dev->pprof.name = "amd-pmf";
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ba8b6d028f9fe..a08dc936276b9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3876,6 +3876,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
+	asus->platform_profile_handler.name = "asus-wmi";
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449b..f88d898447511 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1156,6 +1156,7 @@ static int create_thermal_profile(void)
 
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
+	pp_handler.name = "alienware-wmi";
 
 	return platform_profile_register(&pp_handler);
 }
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 972385ca1990b..3cf79e55e3129 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -247,6 +247,7 @@ static int thermal_init(void)
 	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
 	if (!thermal_handler)
 		return -ENOMEM;
+	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 81ccc96ffe40a..26cac73caf2b9 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1624,6 +1624,7 @@ static int thermal_profile_setup(void)
 		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
 	}
 
+	platform_profile_handler.name = "hp-wmi";
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 5d2c1f0d1e9fb..cbdc965eeb248 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1102,6 +1102,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 
 	mutex_init(&priv->dytc->mutex);
 
+	priv->dytc->pprof.name = "ideapad-laptop";
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 8440defa67886..03da2c8cf6789 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -177,6 +177,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
+	priv->handler.name = "inspur-wmi";
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 6371a9f765c13..0e03c41e028d4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10571,6 +10571,7 @@ static void dytc_profile_refresh(void)
 }
 
 static struct platform_profile_handler dytc_profile = {
+	.name = "thinkpad-acpi",
 	.profile_get = dytc_profile_get,
 	.profile_set = dytc_profile_set,
 };
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f5492ed413f36..6fa988e417428 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -27,6 +27,7 @@ enum platform_profile_option {
 };
 
 struct platform_profile_handler {
+	const char *name;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


