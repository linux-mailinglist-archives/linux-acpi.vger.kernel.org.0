Return-Path: <linux-acpi+bounces-9461-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A179C29E1
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BE81C2167D
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01013DDA7;
	Sat,  9 Nov 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1jfRtubs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EFB13BC35;
	Sat,  9 Nov 2024 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127348; cv=fail; b=QW5IvibyokjQp/iqM88j+Rz8mh1PKFXGau+zi2bNuamYNgYFWM4icxkpEaYZAPO7CLdMQpSJkr6YBF62dEPeuE5kt5j/1pzpRA9gJAFDvJKaAAMuWq9NYpBMkdycUCXylnS4gs6Dthcw0iEdDTF2JEu9/g+83pDC5gcheU7TMJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127348; c=relaxed/simple;
	bh=pmiwS7Cn2IBK/mY0my8lyXOxLznshvN34Vbg+Yax69E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxE7mv5qgH9tFe41uoc42DpVFYK5tuIjKvrGqj55UBGdfvwr9kTJwE8JSMF6NGIybkp4P0lWfsrKzbce4N689rAEv99DmBRLu3CqHs4owH3TrBesRejsB+Sewm8DkcsWBnUqp8KW+ijKNBtfOU9Az7+kVV0uoldOoPDSgtzCBhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1jfRtubs; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErQS7Yfojhgdc9E3RIVonDjZYOIVJ8P/VDlhCwOhI0afUC17rgYXwyDSA2cj8YrKXroMrwvtJSsOBr8KcqxFI5wmil8hkX62ift6x/SLbbD8hfBTHIFF0Mc8lWbN3NcTMx9B/FcucKyagjbHRUALOL+29lgDJCyDA/HnojJyKctm/Vx+pkFlDzpBhttsPilNXCY/3993OunqrOhAmGGIl1C0E4HjagdPV6hiXorzh2nYjrPZPrcE3/00p1wipyFyaCof881/SzEsubtetQufw/ij8zj/RR5xHwLYqXXdo+Kw0wMWeZF9eK7qmnrrX3tx7s5D3PWJM0MYKsM0gp5rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RTcnTJSuJrspg9JmB8gQxmk+Ggi8y5bR2Vd3IBVqP8=;
 b=R2gG5N7CiSB5q+T7tgvMBr4d7gdbUP+y91gwdkHMN+QOfqKzSEPGAURpGtE/ZJUP/oSmU4aD95SOLun/au3DmkhJpHRvBjHoUb+k+qAUONk5d2S4B0gmBq6bZMhXAgXGTWKw238dbZ5pETFaFVWSnzOjeeUuIgPir5HwUX2ORFEBXbFoBPMA8+6zoe6OnXyOu/9xfqpDeuMTEFUDSpS0n2x42BWayXOc9A3yXIhYGJ909Nv2k8JnPFqyTyvdDbE+jcHzWr0T3kSGI1vz3QLV5L45HdoBCsqYyVXQBMAIdLqNr+BNsNqCxEa+FhE/tvvbS93yJJmLZOJREZXWu3gh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RTcnTJSuJrspg9JmB8gQxmk+Ggi8y5bR2Vd3IBVqP8=;
 b=1jfRtubsRMeitUgTTU5dKoFX7OlBndbD492RlYV4/7oeiU5b9ug6JLp1yvpHHrN1LR/FNlu3bWmcG9lb7AQbaEHYLL5XzNFWzVtnTucFlkEOhOGL1TU7XLfCdD/+uDIr5a2+u6HtDJgIfhetJ6pErtKOBudZy9zsRX0thQhfu3I=
Received: from SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) by DS0PR12MB9347.namprd12.prod.outlook.com
 (2603:10b6:8:193::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:23 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::e5) by SN4PR0501CA0037.outlook.office365.com
 (2603:10b6:803:41::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.12 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:20 -0600
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
Subject: [PATCH v6 03/22] ACPI: platform_profile: Add device pointer into platform profile handler
Date: Fri, 8 Nov 2024 22:41:32 -0600
Message-ID: <20241109044151.29804-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d0c419-f69c-4334-8b46-08dd0078e700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWJCYnBxTzVZR0lmNTA3ODI2SEZJNXFoamVaYXFWS1BHWnZ5Njg3TDhKakNj?=
 =?utf-8?B?dE9yQkdUUFJPMml6Ym9HL3M2ZmpkVHJNQmMwajZGY0V6VktIRmgxNzIzb2w4?=
 =?utf-8?B?dG83a0cxYU9qYTlyWVEzWkNUSktyckdmL2xNUkRlTHZuRURPL2RHQmNSYjMv?=
 =?utf-8?B?TS9yQ0U3cTlwRkdDcFVia0YrUlBJaDVuQTlSRlpxdUtjaUlPMWw0b0xMUGpB?=
 =?utf-8?B?b3lrMFV6RVhPYVdUc2lzSkhybjdvRE1YYUd6enNzdkJCN0EwKysySW5venFU?=
 =?utf-8?B?RzZ4WjZzNGFoaFBWZElMTHVKOGEvRTg5Z3Y3MFR1LzdUbWhWcjBCSFBONUxY?=
 =?utf-8?B?SlVPT3JQaEhpbjRDcEYwalVVbWRJNDFVczB6WDB1UGtBSU1NUEJNUUliNGw1?=
 =?utf-8?B?alZCTHIzL3YwZzIxM3RKcE5wRkRUYWhWMXJqYTFySHhUYXpQeEl2UCt4Rkpi?=
 =?utf-8?B?LzRibnhaL29jOHVEVVJPVVZ4NU9ZOWNxRVJNWUNSZTNweFN6azdrR1JsRFNX?=
 =?utf-8?B?RFB4SUdkaTRhL1NhcU9kZXorejdSc3Y1OTVsbVRmTkozZkdYREJQU3AwZXZn?=
 =?utf-8?B?b05rMldzeTU4ak04S2U3TGJGUkZScEVkbkdyUDZPK1dzUG5VenY5YTI0WDRG?=
 =?utf-8?B?R3pENWx0MFNBYlJDSHhVaTZkTTZlUW01QmhWTzlHVWc5Y1FZTldIekRTblZS?=
 =?utf-8?B?bjdJRThNbWROZ1o5QVMrcjlPRC9ldUZHY01YeUU1SWhyWDdGUnJydGZMSCtu?=
 =?utf-8?B?eHViMHRndDVXVDFaQ3RXYVErcnVrbWlvSVFvejFjOEhwUnFDc3htRVBNZmI3?=
 =?utf-8?B?L3U4YWwvai9rd0l2Zkc3MnFaajE1VXd1OWtIRDFIODBnMTZVUGJxeCs1V1k0?=
 =?utf-8?B?NGpPaFVzZmsybHg2SGFTdW02L0lGNDl1M05PcTZCZUdhNkxidGFvdEJrN0xs?=
 =?utf-8?B?RkRxbWx1QS9DNWRTZVhHWlBONGk2QmZodVlrdStoZ3hyNlJtckVnK3N5c0Jj?=
 =?utf-8?B?V040R3loUHloVnlkY3RZNEplemJUTER5S1JLdk83VmlOZm9xNWhIRDNSQ0hK?=
 =?utf-8?B?VzBaSWhGVlJUWVRibUJTbjdmVUZTalRjaHlBNy9sWkpQbHNYSUg2L1Y3Z2s0?=
 =?utf-8?B?djQvNlR4MnhvR3l2YUZtNzRrTi9kYWtNK2RtMGNWU21wZmxFM296VzNqWkNw?=
 =?utf-8?B?Q3ZFUEJRK0NzeEJmaXdUVHVWaDBIY2drRnNEN0U4SVpSM0FxcHBTeXVhYnA1?=
 =?utf-8?B?Z1JwNnhtNldMYXUvQUhvdXlhbFEyU2lJR201VGQyMDdrOVorWDZiaGpjNGR2?=
 =?utf-8?B?V1ZhcGVMdmJuQkkvSHNkWG5yb2FYVEpZWWRUK0JlTE1Jb0MvQnpvQjVJMjg4?=
 =?utf-8?B?Sk5MZUswSS9STU5EQ0ZUcUR5cURNbUxQK29OakFpTzZrbG43cDFVcXoybW9n?=
 =?utf-8?B?VGFnZDlsY2ZlVVY5azVtQkNWMENyd3ZTRmZmNkVZN1JYK3ZRVHVPendVNEFn?=
 =?utf-8?B?M1VaL1RNWUlkTkgzaUloOGVoaUNURmErQ3RwWGpIYzk3Z09TYVlrMTZ1VERY?=
 =?utf-8?B?Qy9leWFpUm1Ndnd6dldLaVZWWkhQMUpTQndtN2QvTEJTN0w4anNwRHBmNEli?=
 =?utf-8?B?NWwwV0plcFZLRlkrZFJIOFRCUEVXUTJYSGhrYTltMnZUTkdNMGVpYSt1ai9v?=
 =?utf-8?B?MTF6cHlyVzhMMTFhQlBFNWlPL0hDVjl6RWFGYVpicEF6MDN2dVRtOWJYRDhN?=
 =?utf-8?B?ajZqcW1GUDdwNis2TEthb09LM0l1MEh4ejh2bHd3UFFaOGtFaHBpOC9CTVJO?=
 =?utf-8?B?aEtocVJPNmVUYlZFWWhhbUF1SVl1c2UyZ1o0NlU3elRRb1dkZmlxeGhwRnBL?=
 =?utf-8?B?VENnOExtNmxseEhmOHVLd1FYbDdKbUtFbUZqU2o4Zlp3bEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:22.7345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d0c419-f69c-4334-8b46-08dd0078e700
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

In order to let platform profile handlers manage platform profile
for their driver the core code will need a pointer to the device.

Add this to the structure and use it in the trivial driver cases.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v6:
 * Don't require to be set
v4:
 * add alienware-wmi too
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
index 805497e44b3a5..e5724e76a2082 100644
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


