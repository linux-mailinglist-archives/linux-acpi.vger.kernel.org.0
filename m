Return-Path: <linux-acpi+bounces-9988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125639E64CA
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CCB168712
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E116B191F95;
	Fri,  6 Dec 2024 03:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HNQNisG9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5118DF86;
	Fri,  6 Dec 2024 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455382; cv=fail; b=e1gdulCVsHQZZpieDAmUrvfuephrlkj6WQNUEQrdL+ADbnxgGO7TDERnlnJSFym5ujIeij1VRdYFncHjXR9vr/dPT6fcwpyR0jmFwTI24O1qttHw+eVHv2uV6+xboGckmOFiKHOUefDdZZFawSh75TYYzfT8cJxDk6sDOSWwLVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455382; c=relaxed/simple;
	bh=AhcQq/qoPABsrY8CsoC/m8lNX7jnLQEA1NZQjsy9xjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChFqjR8WYSNfQV0OYsPJOTqjJfNfx+DgARicNbZBKY4/EFKdfgCs7gpIhq78LrP/y/N2w0Sx8OtIg66hi4HTvEHVzWTvxBprpDp+46uNX/ZAPeLcfvhQUfo9UJGhn36DBf88RKPNoSMY3NcUBIubMgNE4C/MJxWQlc0CkEND3kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HNQNisG9; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV0jExH0XvTVIT0rCtIzxKiKiEd15kcOwBwyqHAW/zCe5NqANJDx3etwXB9BN+1+cOfv427C3pVmS78+lOzw/3CtzRxbAoBujh5lyBcgXEqhSkQXRN6IlPA+P4KLhoOPvSVnM59Nf7/9AgHdaF/rjLIqMSGkMWnX3LfkvaT9Pqx7PgCLM4ve8bh3/YXGTubUo7anI+naUEsCdoCLqWJ6LzZFwfyjLfOalTr2E7fK7V8At1qLjVm6yEcerISK8G1nZc+54vFmdVdYTX504pIqzF10nup684Vpvt4lyYMUBOc8KpyU5VCMEQrsz4HAILRb8zC7i1yLsdLJ6QNjNoCiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnx4s0xfHI8MWMTVeFUsyesOxs3tBhsZmpwtkndEF7o=;
 b=p7yEB3Wyt4aOFBXgQiGWjQK4Mzj1kah1vWDJiQaPieFD52aFyI1eaPuZbVGpIRBaw4s0YHNJ67bPS5VrczDWbqwppK6eSuTEkQwgAit4dc+zYSTOY7GXKwptaPHgiiiZb4AYNoKRVJApzHuMk9WXgQjcgSoFPB+Vl2S0Xu+q0ZLmbSzV7u78oyc4d29lKBIE/OInoldN1MpBjHGCWrkjHKI/INuY0TFg+nrw+ogDAljlcqiwY0AwelZcyqBvtIaxARqWNf1kUnVsoFs65xfxRQEBzp82O6qw/nlFw6MaZpAacA5gl61UuaPXBYQkMayZvfYqE6xmDKaSGYojO2MQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnx4s0xfHI8MWMTVeFUsyesOxs3tBhsZmpwtkndEF7o=;
 b=HNQNisG9xKSKBVrWjEdfHFlhi1VBox4j49pdsbA3vItMSH8qzZ79r4A1onee8menzj32y42bRLYac8bv0t9ydv1TINFzL9Og3jqKq7a/X2g8BkO3IRYfgqgPrQw6oTjNXyDHTbSre4igifTYH3cUPAn2GZKigOn4jsAS8AJN8b4=
Received: from MN2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:208:23b::30)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.22; Fri, 6 Dec
 2024 03:22:53 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::86) by MN2PR11CA0025.outlook.office365.com
 (2603:10b6:208:23b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 03:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:22:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:22:17 -0600
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
Subject: [PATCH v10 03/22] ACPI: platform_profile: Add device pointer into platform profile handler
Date: Thu, 5 Dec 2024 21:18:59 -0600
Message-ID: <20241206031918.1537-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: edd8686d-71cc-4981-8d0d-08dd15a544e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTlSelVSSVVibStyekZvVlBsMEphZEhxWUVOWHEwdExDc2ljM0g2STA4OFFT?=
 =?utf-8?B?d21jbVdNWXcvSEVWR2xaN3FKUU52ckl1WXY2WU45Ylk0bUhDVUg2QVVFTkwx?=
 =?utf-8?B?UmJQYnZ3bUt1K3g1QmIvVGpURDEzR256RzVHbEFPcTNjNTVJRjBQQ3QxWGNR?=
 =?utf-8?B?UUZtOU95L3dnSTdSMmhHdFI1eTlSVVFzTTkwcDJVdEtPZ2xYSlh2WFl6dWE4?=
 =?utf-8?B?RDJGdCtGVGpISFlkZEJsMmNMVE9RSmlrSWFyY0EvMjVQT2NEQXFrM3RJS01O?=
 =?utf-8?B?TExydDZiWWZMcTZWZmpjVWxmL285NldJMVZvUmFEZWZ4cDNDSGRVanhzZ01h?=
 =?utf-8?B?Vlk3YmZmYmQ2bTJiT3EzeWI1d1o2WVFTdU5DMmxJdk84bmsvNnZhL0JXcFQ3?=
 =?utf-8?B?OW5iSlh1RGV0UlRhVzRmRkQ4WlRxSUlPRElkRGE3eHozLytLTUNQZ3locjhZ?=
 =?utf-8?B?SnkvNHd6ZStJVWN1QWJxYVkwaUtjdmtvZHd5U3dYWmQrVUMzd3UzbnEwZkFQ?=
 =?utf-8?B?Z3JZOVpSTzhOblJKMlJOY0hzREJvNENUNXJpMDdWN0plWDNJZGZrVkVsQUJk?=
 =?utf-8?B?U3Fod01ac2JHb2dvQW5xZlJHMUF4SVJ6K0JQbHR5cW9SNTVpR1I2T0xyZEdN?=
 =?utf-8?B?eURwU3FWN0xDWGg0R3RYVzNtdC9ieWpIU2NuWUMrMGxsc0RhRGJOUElDY3VH?=
 =?utf-8?B?VWVnYWJrMmo4MWdmQ29lWUU4UHNXSTNPU0NYQklqd2RFMW1ucjdxUGNsK2NJ?=
 =?utf-8?B?ck1iK3QwMVczcnlWRml0T00xdGJJMDNKL3FqVnpRbG5hOWNnK3JKcnd5ZGNR?=
 =?utf-8?B?RU5wbmFjTHVjRUNiWDVkUWEwRHZQK2JLVHUzbERSeW4rN2cydTF4cjBmajJE?=
 =?utf-8?B?WjRaOGdXeEs0Skc3ZFk2YW5HcUlia0tLUnNwVGZESDNSZTR2Nm9QaTZXMnd0?=
 =?utf-8?B?QlVQM2NIY2c2NWQ0VEh5VDBUd3VNdjM3VitHaDVXTDF4eDIySVJsY25SbmlH?=
 =?utf-8?B?RlhjOXlLKzdHcHdHS0lpSmEzU28rRDRGYmRValk1UTkwTS82bUdDaHQrYWNE?=
 =?utf-8?B?SGp1UTdGUUprL1ltNWhqSEhzdzZXOUtIWDI4RytDbER1UTdkajJxcDloOUtS?=
 =?utf-8?B?SWlnSFkycUtGK3N2YmdLOEtrOE0rMzduTTlPVVovKy9PdEZNc3pJV0JTQ3hK?=
 =?utf-8?B?Vm5xaXpBcWlXWFdOV1laRCtqb3ZaR2R5NG5kZzY3dFRMMk5UMmVjdXc1eUVn?=
 =?utf-8?B?V0owb3MyT2dSeU55WnUyenAxOGNidDlkVEdJQVZablFSbHhDVTF1cUhyeFhY?=
 =?utf-8?B?Tjl2OVZlT2g1NzB6dktRRnpiaG1mbGEveUdWTzU0OElranJQRm5kQlJHRGlU?=
 =?utf-8?B?S1o4NmRaMnFqRnpqN1dXTWllSk84eTgrTkQ5ZFkxZXRmN2xkU2JHYXNtcitN?=
 =?utf-8?B?alNwSzRSRHFkQklJblhMcGU3UUttVmgxdlRWWEZYL0k3M05pMnZLR1h0YXF0?=
 =?utf-8?B?UDFXdVEwSUVpclkwbTZDWDJSZjIyRU1IL21QcklTUkJWL1BDTnlwK3ZkNjhp?=
 =?utf-8?B?UXNuVUtRWjAweUNZZ1dzNkZoeFBCbkRJci9FWVlJNktTb1RrT0RPUGxBNG9U?=
 =?utf-8?B?aHF4MWJ1SkF2M2NwUlRBc1ZnOGlEaTM1OHlTTDN2a3FhK081bEpLRk5tYXZW?=
 =?utf-8?B?OHR0dkRhQTlhZjBoU3lZOW5hdWt6Zmt5M2Jlc3VTZ0dLQlFSZGpnbVZ5b2R2?=
 =?utf-8?B?TzRQSjU5TkRsSGJhSzJJa3VZWC8vR21IemJVeENrOXB5bGpMQWtUZ0dLTU8v?=
 =?utf-8?B?RWRqbGhQM296SVlGM3JDWTk0am1CbUtxNW9VVGhhTjQ2Z0x2ZnVnNjFjcStR?=
 =?utf-8?B?VEk4b3dzNmVlY1VDQXd5V1FYOW10djIrazk1RmRrQ3ZEcnZLWno4aEgxRFZL?=
 =?utf-8?Q?4BBG8sGwrerO2nZfmYegRbuQBwE7QOYZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:22:52.5338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd8686d-71cc-4981-8d0d-08dd15a544e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504

In order to let platform profile handlers manage platform profile
for their driver the core code will need a pointer to the device.

Add this to the structure and use it in the trivial driver cases.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
 11 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 9d3e3f9458186..b73cfdd920c66 100644
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
index a08dc936276b9..14d84cad01b49 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3877,6 +3877,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
 	asus->platform_profile_handler.name = "asus-wmi";
+	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index f88d898447511..78aac76132788 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,7 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(void)
+static int create_thermal_profile(struct platform_device *platform_device)
 {
 	u32 out_data;
 	u8 sys_desc[4];
@@ -1157,6 +1157,7 @@ static int create_thermal_profile(void)
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
 	pp_handler.name = "alienware-wmi";
+	pp_handler.dev = &platform_device->dev;
 
 	return platform_profile_register(&pp_handler);
 }
@@ -1225,7 +1226,7 @@ static int __init alienware_wmi_init(void)
 	}
 
 	if (quirks->thermal) {
-		ret = create_thermal_profile();
+		ret = create_thermal_profile(platform_device);
 		if (ret)
 			goto fail_prep_thermal_profile;
 	}
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index c0dbbd3b23065..b9a6dd7b321d9 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -257,6 +257,7 @@ static int thermal_init(void)
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
index cbdc965eeb248..b6586c473ba91 100644
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
index 0e03c41e028d4..58af9020382c1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10638,6 +10638,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
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


