Return-Path: <linux-acpi+bounces-9299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246C9BD071
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ADF1C21694
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C0C143C45;
	Tue,  5 Nov 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M5ei7LHA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE113CFA8;
	Tue,  5 Nov 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820821; cv=fail; b=qTjl38XTnLOGRaLQhcBU+9whaoFTTC4xdNMOWM9EiSG9+8qdNLUKL2BPv4DNI8Hjs69i7+WIjb2xnguPhgEvLf3ytRpATwRFiMc4WvsvOibfQUSKVg4emm2ynVJUjy1uYI9TMVyqWWKyP6u0fF5R7zDTewPNLrFXDBLfTQIlX7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820821; c=relaxed/simple;
	bh=BmMR1Enibk1nJMvtTQUaBjCmHf+VJwF7HpJDuAA3Jlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEPrmFwcL9BVH1PJVWCErTejLBwr/1Uo4BhB4yb5+0/4z7HlJH7fTaEG1Zpkx1XOO6QxW9sQqoB4hYQcmBx2GEq7HLMPyp34Dt/ITjk6CYycF9lVC3xLSnzgBXY4QiPyxUpp3pmzVoQyJ2HkZzeeOdA6HemSZwdf/iy9WBVroWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M5ei7LHA; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqI+pM5pn1PG/rhAAFr6E/IqIfGui+kVaJMbsAzOGOETYw+LcolTOXHwSwTPOuiWomNFQk+O17zBZcrBqXnmHwUeNjPvjMYYipWOXik950k3HUrOlNLGhWs7TO2wXFZ4n3ar1Co5ec5OMRwFRu6C2lu0iG3vWCJk1nscWpfe/gQkVt7buTiyKTXZFPYc7B1aOVm6kb4VGeaJDAn9Qkh20M2q+iG1hn43cQ/g1Iw2bIJ5Z1VbVZK0Ra0g44N92zF3AXakxTH8CDM/e2K3FwN8SJ3OvQbBp3yMrAWNBoGTH2Cj1X4lHsE/m4NDN8JTEdQN3IMgQacd39JmqqW3o93piA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akdffAgsWFY5qLva447baJQ/DW+tvIatLdlKwEunKCY=;
 b=y81DnYwytWgjirJ6RpCycPOrjp+BBvT38hRhMg0qZ8splRdcRTq4xsz3vb4i97HiKzruvTbIvb4LPpmGO0Zxo8Sr9A1xtLSjvhtTmR00TSaveII7qqNIsjFuOWNPc7+UZVJjqULRQ+PCY4yWQ1mjekHSp7kwsw4F9TJV4DTKDzrA9RbSY1Zap77vwEe7Usg/KHk6H93WHjnAiHko2IC0kWNnnC0Q6CADkLzGGORUO943ajuWiviyMYHvAOaZnwFd0+I0qhySVs06Ml8ZIcfyMWqlmOUD4LuFmY5kDvbmHwqQ2OKYIsuQdTghX6gyYoV4iZnCw0y8IaKpIEhXRxrBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akdffAgsWFY5qLva447baJQ/DW+tvIatLdlKwEunKCY=;
 b=M5ei7LHA7hvRIiAPedggKuKO8ZKaTTX7pVAaPrub78BN9n566tlDAr6tR2jaA9chWup6lrErzJG+r2uOVbFlJEx9lHCBN/bqvVsfARVyn5buKysRjr1bjZuLcK1gGggXbWFH2SCDaHUPHqO0IoWbVJ7As5L9bJGd2csOOzoFFK4=
Received: from MN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:52d::12)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:36 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::7c) by MN0PR04CA0007.outlook.office365.com
 (2603:10b6:208:52d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:31 -0600
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
Subject: [PATCH v4 03/20] ACPI: platform_profile: Add device pointer into platform profile handler
Date: Tue, 5 Nov 2024 09:32:59 -0600
Message-ID: <20241105153316.378-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc0725a-8d2b-466e-53b2-08dcfdaf36ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3MzRmVmNFhSbTl4YzZBMTZ2bWJxc0U4RzJjSkhRWmloc09rMFptQURJbE9h?=
 =?utf-8?B?SXZHdlVBeWMrdHZCWHIzUU9BdEU0TWRyR3dGSDZOdHhNMFU5ckZKK0kzREVR?=
 =?utf-8?B?bUxVRHYzNm9MbS9Qem1jUEU2MWJFaHd5THZCeXFDS2d2dSt6NDdZKzRyKytD?=
 =?utf-8?B?aE9vS2UzSm9zVCtTVFRKdWFKNGpPT1lub0p3c2EyVGFqSzFUdEJPVWNtVjRS?=
 =?utf-8?B?aFBqR3dqKzNEZlIxSXJCT3pGbENuWldkTGJnUEpvTWNjL3JzS0kwSTJwemRx?=
 =?utf-8?B?L2poaVlsSWFQbEo1WFV1UjdvTDVhUldsOGJIemY5Y2cvaHI5TWNuTUZtM3NF?=
 =?utf-8?B?MXRESTMvVkh4RktsR0xsSzBWdW54ejhYdXZHY3ZQSlpmbkFCK01VdGp4ZHRX?=
 =?utf-8?B?WkNObExsR012UWpDOURDWU0xdkhMcXFuMEgzL1VDa2VBRERjdkxSN0NUQk45?=
 =?utf-8?B?dkk5aThMOWkzSk5pSzRGdE5SNWdSOGRYZ2EyVVlEWGkyaTgvMGk4RGlyNjd6?=
 =?utf-8?B?RXRBMXoyc0hwNGVWVzEycVFCSkhSUDIyMXR6dXJFNXdFV2t3ZTNRbkNHZE5E?=
 =?utf-8?B?U3o1WkJ6djdZVG1jRFZSTjlscHBGN1pMWkp3RjNLQzM5Z0sxUXlMUVNFZmV6?=
 =?utf-8?B?dnZ1bERGRjdaWmRsQVE0ZXAzbUxpMU9yVlloY1FnbTRjMVdnT1l3YW42ajN0?=
 =?utf-8?B?dU0xVVF3L0NjbWVmUzJtTWtacmc0eDRqYittQUxDN1lZUnRrRjA1M0lVVlRT?=
 =?utf-8?B?UU9lVWhHMG54WFpvZ3ZBbzJzdFh5M28rSXB0N0hsdXMvcW5wY0taTlplcEk2?=
 =?utf-8?B?bXNzWHZubWZGcEtGOU9GcHo2NWsrQ0txeFhDNHhxTVJpelA4V0VQWGtLbU5O?=
 =?utf-8?B?TmxUaHZoVDIvU2RVMHBHeWlQNlBqOVFuZzhkRmpaVkFpSjF6Vk9SVWh5bmV3?=
 =?utf-8?B?d0M1N3BxT3Y3YWVncktRVFkzTEZHUWQxV2c2R1hRTUV6OThIMGxyaDRGVzR4?=
 =?utf-8?B?MXczYS90Zm0zRUJ5UGpQZ2hCTVBHOGphNUJNWFAxanNvUXBCWmdQS3MxK0FG?=
 =?utf-8?B?aXMrVWVZSkRFc0FZa2srb3RZOE5rSnd5QzZTTXNaL2NDd1M4ejRBQ2lxTzMv?=
 =?utf-8?B?bm5pRS93TTZMb0IrK0NjM2M0d2IrVHI4SXMxempLMzdFMUF5ZEZ5NXNWenpF?=
 =?utf-8?B?N3pZOEp4Z0dqOGpFMWFPNlcyZERtVkh1ajdwUnRES2pqcGtOZktKOWp0MnU3?=
 =?utf-8?B?Q1ZoYlF1aE95V1M2U21FM1h1L29nRWhWaW1oK0FGNFQvcjVsemZmRm1lMDNl?=
 =?utf-8?B?SG9COUxVNG1wbXg1QlVhSEN3Ni9ITTRNeG9hbWZ1cTRCSU9FN1RBeGZqOEll?=
 =?utf-8?B?aXZIYklNQXg0U2hYYnJ0Y1ZlVE4yeUh6cnZldmQwMlY5WU1MMlFQM2NUUGNH?=
 =?utf-8?B?ZzY1V1VydzkvRVVtTGY3MzcrZDV1Z0VpOVRQbncxVFJwTHpHSU5jVjRvMWow?=
 =?utf-8?B?ZXg4MEVwbEtTcEtBNlNyUEY3WDhPVDgvcUUzSzMvSzhsL21sRWNWK2habmtH?=
 =?utf-8?B?YmZMVFBRYmNUVHFLd01iQklabkx0TUhuQk5waGp1bi9aajFKeFdBbDM5QXhw?=
 =?utf-8?B?Z2dyK0d2Y3crc0Z2S0ttMWtqd3FjNGVremNSR1RnNm05ZGlDU2VaZGEvK1d5?=
 =?utf-8?B?K2ZVQm5JZ2JqQWJMT1huSDhxOU5mdStYNm1WZ0xtOTlubzdYMFdJNzVVYldz?=
 =?utf-8?B?YlNHUDc0WkxEQlcwZlRWYW9nbE5DTU5LZ1I1OC9LMldDeU9OWXVmTitoalVE?=
 =?utf-8?B?WUdDazhibGhFUkxnTitMZTF3a0UvejBBMCtKcWhpV2NMbDIycXdDYUhCRFVW?=
 =?utf-8?B?UktOQmxDeHlHU1NNdlJwZEF6WEc3dEcxclhMc0xwU2FLa1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:35.7641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc0725a-8d2b-466e-53b2-08dcfdaf36ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928

In order to let platform profile handlers manage platform profile
for their driver the core code will need a pointer to the device.

Add this to the structure and use it in the trivial driver cases.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * add alienware-wmi too
---
 drivers/acpi/platform_profile.c                     | 5 +++++
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 5 +++--
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 5 +++--
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 12 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a13..5d9f3f7ba71c5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -179,6 +179,11 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
+	if (!pprof->dev) {
+		pr_err("platform_profile: handler device is not set\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&profile_lock);
 	/* We can only have one active profile */
 	if (cur_profile) {
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 61aa488a80eb5..5f45f8e8cd69b 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -212,6 +212,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	tpd->sdev = sdev;
 
 	tpd->handler.name = "Surface Platform Profile";
+	tpd->handler.dev = &sdev->dev;
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 53fbc9b4d3df7..aca4a5746bee1 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1873,12 +1873,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int acer_platform_profile_setup(void)
+static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
 		int err;
 
 		platform_profile_handler.name = "acer-wmi";
+		platform_profile_handler.dev = &device->dev;
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
@@ -2531,7 +2532,7 @@ static int acer_platform_probe(struct platform_device *device)
 		goto error_rfkill;
 
 	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
-		err = acer_platform_profile_setup();
+		err = acer_platform_profile_setup(device);
 		if (err)
 			goto error_platform_profile;
 	}
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e2d0cc92c4396..1b94af7c0e0c4 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -406,6 +406,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	}
 
 	dev->pprof.name = "amd-pmf";
+	dev->pprof.dev = dev->dev;
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c7c104c65a85a..78621b2af0ddb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3911,6 +3911,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
 	asus->platform_profile_handler.name = "asus-wmi";
+	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index ac0038afd98fa..c03b1aa7dfb5f 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1017,7 +1017,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(void)
+static int create_thermal_profile(struct platform_device *platform_device)
 {
 	u32 out_data;
 	enum wmax_thermal_mode mode;
@@ -1057,6 +1057,7 @@ static int create_thermal_profile(void)
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
 	pp_handler.name = "alienware-wmi";
+	pp_handler.dev = &platform_device->dev;
 
 	return platform_profile_register(&pp_handler);
 }
@@ -1125,7 +1126,7 @@ static int __init alienware_wmi_init(void)
 	}
 
 	if (quirks->thermal) {
-		ret = create_thermal_profile();
+		ret = create_thermal_profile(platform_device);
 		if (ret)
 			goto fail_prep_thermal_profile;
 	}
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index b145fedb6b710..730f97aab70cd 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -260,6 +260,7 @@ static int thermal_init(void)
 		goto cleanup_platform_device;
 	}
 	thermal_handler->name = "dell-pc";
+	thermal_handler->dev = &platform_device->dev;
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 26cac73caf2b9..ffb09799142bc 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1565,7 +1565,7 @@ static inline void omen_unregister_powersource_event_handler(void)
 	unregister_acpi_notifier(&platform_power_source_nb);
 }
 
-static int thermal_profile_setup(void)
+static int thermal_profile_setup(struct platform_device *device)
 {
 	int err, tp;
 
@@ -1625,6 +1625,7 @@ static int thermal_profile_setup(void)
 	}
 
 	platform_profile_handler.name = "hp-wmi";
+	platform_profile_handler.dev = &device->dev;
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
@@ -1664,7 +1665,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (err < 0)
 		return err;
 
-	thermal_profile_setup();
+	thermal_profile_setup(device);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1f94c14c3b832..24367c3590c99 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1103,6 +1103,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	mutex_init(&priv->dytc->mutex);
 
 	priv->dytc->pprof.name = "ideapad-laptop";
+	priv->dytc->pprof.dev = &priv->platform_device->dev;
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 03da2c8cf6789..5a53949bbbf5f 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -178,6 +178,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	priv->handler.name = "inspur-wmi";
+	priv->handler.dev = &wdev->dev;
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c8c316b8507a5..222fba97d79a7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10616,6 +10616,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	dbg_printk(TPACPI_DBG_INIT,
 			"DYTC version %d: thermal mode available\n", dytc_version);
 
+	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&dytc_profile);
 	/*
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6fa988e417428..daec6b9bad81f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,6 +28,7 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	const char *name;
+	struct device *dev;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


