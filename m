Return-Path: <linux-acpi+bounces-9317-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A349BD0B7
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5866DB2455F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D114814389F;
	Tue,  5 Nov 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ib+hAAz3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B2145B14;
	Tue,  5 Nov 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820849; cv=fail; b=Jc1K51sUmiDeHekFgn1FX5rNmkEHIdLEmY7D7l6fzyQVa/IcbyF0QCZOwY7fW7LgPqTsNzmL8U4txvF1tTAc5U0d1giCAU6hm8SK94ukwE81G5sCCNblA4Kh24iL5RBeNuYf7oi5bND4ni4UpTqsi3pCrl2mXrE51IqBNNa0Yeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820849; c=relaxed/simple;
	bh=CC88Q+zb9x+qJyFWT0r7BsGTISAdvYfUNOCDT0p7LSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvTQ6RbyUqf883WXlDUbLhth7HSq3dLp0dLY8Amaw/PYwP8mvGTVUBYlO+oLHgjwspLtAKw61XVUDIKaIhIXjrB2gYmULMgfwWCObOm3yidgV1IEqHxYgn2YelC79ZjhSykFMZvzLNCUCn+4HAo1V+O3aMWF+eq9Rdpz6oBvdhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ib+hAAz3; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI6wIUIBDQdabPZ3W3tjs/3OxPk2PQpKgUHHIY6N0LpHMnk23EIxC6j9ZDZYcnSMzLGCPbWvVOYR6txmcwq7Ta+fbn+CtietX3mFu2ZR8ms5Ew7DXyKfTnXKratcIHAHKoc5HbC3iOdGg3G2E2AjVnHjLQxybx+tV7PCy4rHmAfTd6LrDm0NBeqJLxCT2O7wcNXcrKVMn00sAhid5LHwRJwjP6onTBziYzKIGjcomIsxggMm/P/ZNiiXBqo7UY580mp3Xr2KmiuITb5r0oN0j2bmEg4xNxiJ2+1XqWhjoDphHAu/aA7oPYxGEifWIX25iE1OjtRzPTgx+KbZNF/pFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWrFpOP8j0p7ioctz6BKIQzkCfCwrDMVuzyTi8lgzZo=;
 b=PoCjjbvAaX9/qAC3/pBHkxLUfVijfw0fnXpTPTLnI9frIyngru/IxHbDRGjABPJlfVkYLtV3NawPABoZE/WbuKFxrynTrI3PzE54yvJdl2+LjYMEBIOd+599IRPpgUR4A+TaUv8ecCNT5oIEYQy8ooCrveWPCGHztJM/8Tj6jbbf28pqmS+ZL4p6EpzFuHId38TuoWJrwghunruggnEVlxPdFnlKNuwV+plsfDzDEqct2aRa3RStPVcGjYBkDMeRwZGIHmoKzQxe1S1K08aeoei6kVVS/0Qi0fq8NGLF4g+Q0tNaom23Fg5WRFc0ATVtKe+ZKIu+qVOZ1lArIE8Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWrFpOP8j0p7ioctz6BKIQzkCfCwrDMVuzyTi8lgzZo=;
 b=Ib+hAAz32cTi4es0BxJlPOqXCD6OR9HNnwkcTFr5MenQAbczsOz6Lyo5cpVz/xGHk3AOH0N3ls0fM6m/6/IXFMAlquWfd7O/Yq1vPQZ/RdUCDl92HpMcKt+Pb+n5sNbMCsjJ4ZlrsUnvyv3D7kxhKX3wFSSFpWV/aN3Z3y0dnFA=
Received: from MN0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:52d::34)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 15:33:39 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::70) by MN0PR04CA0029.outlook.office365.com
 (2603:10b6:208:52d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:36 -0600
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
Subject: [PATCH v4 07/20] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Tue, 5 Nov 2024 09:33:03 -0600
Message-ID: <20241105153316.378-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 62af7fc0-497e-478f-c653-08dcfdaf38a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFVCTm9WeHZRU0lzNzJlUmtGS2cycVhSWU1XekJMNHVlUHNscGdJNklMUWly?=
 =?utf-8?B?Tzc3Q09qTFNXZnRReVRXWWY3N1N1Q3ZSaVVXNE5IMFFKYk50K0hLRnh1ZFRi?=
 =?utf-8?B?Nk9tY2szdWpYV2FIYnlsWnZ4WGNyUEZXZ2ZCZzBJZ3pqbWd3N0h5LzVoSUFx?=
 =?utf-8?B?WTB2cjFGTk9sVE5tekthLzBiUXRxT3NhSE1yQ2VPbXBEYW9zZFhZdWRWcml2?=
 =?utf-8?B?R1NDMnI0NkpBRHJXaEpDb0FpN1g3cVp5b0J6Rm92ZGs4OWdsdi9UVFhKMWJM?=
 =?utf-8?B?NWpML1hrY1hHSllTSGJhMlI1U001N2JVUTV5MXRwL1llSTFYM1dTYTRVV3o4?=
 =?utf-8?B?dVBadXdXRGNlUEZWRHh1UWkrdEFIMzNNNjFvN3VWWko5aVZHa1BiQk93RElC?=
 =?utf-8?B?b2dKb0NOclM4ckFOaDg5RHd1SkdIVy9MS3lFMWlvNW1xV2VINEE0M1BVeGZK?=
 =?utf-8?B?Tm9vTVFZTjBuVDhPci9kSmFQMCtEQkdwRjU2am4zYTYvcGNwS3Z0U21Dei80?=
 =?utf-8?B?SjE4YlFMaFFVV2dBbFhPRjhwcWFtK3loemJ3MDRMSnlibnVXYldER2VwOVhj?=
 =?utf-8?B?Z2h5SmY5SG9XQ3pUZkczSU1CcXpJZzZQeWZhcVB4WklIY1VMUmcrSmMydUhq?=
 =?utf-8?B?MjUrbHBjMEJyT3BtRnlhM0VzejAwZitTTjRzMVlmRmhsbUx3cnIrZTNxYTBl?=
 =?utf-8?B?LzY3bC92aUNXcHVJc0V2VnRFS3RaclNkL0lETVM4enJTMk9DTko3TWVTMExx?=
 =?utf-8?B?TTZpWVViNW0vL093NWZ0TXFON3hmWkVMZTVpSFRjSGxFaXc5VEVuUUhIVGZG?=
 =?utf-8?B?Q3d0NnNiU0JEWkRNN0JXSER1OEt2UUhTdmI1eU9jZmw2eU5waHpzSnRmMm9C?=
 =?utf-8?B?SXMvbHZHcm9ldTgwdDVCV3VvVk1qR1V0cldlZGEwRW1LZ2xocWZYRXI1Z0Fl?=
 =?utf-8?B?NEZMZkVFY0RrY0JKandpWXJyN0UyME1WZG9mNXlMblpXWmYxUlJYbVhGVWVF?=
 =?utf-8?B?R0F4eFZSYjFRYURSODYrbzJRbndiYVBwYjhwcm5SSVlabmFmckpFWHlCUDdS?=
 =?utf-8?B?aktocThFeFZKR0IvZFBHOWdIYjl5ZHF6QTVPRU1yODhIbnpmL3ozdFU2eHdv?=
 =?utf-8?B?WTlUMUtTZFFWVVpFOEViUnFtL2JmaGs0WHk0Q28wZzVCSE1hQUVJNmsrS2pz?=
 =?utf-8?B?SjVVbVUxbkl5RTUvY0FCUTRsZ09oL1Y0STU3M1luNnJpVTZzTStMb2pUS2dZ?=
 =?utf-8?B?MHZSMmt2cnJGbFRFNEVhN043bm9Rd0xueHRXUXhYTE0rbmR2MW5YQVdnd3FX?=
 =?utf-8?B?TkNKMHp3UENzUTlPdENhWUZUS3FMdHBtdWxZUmJXZzN4dGxZYzBGMkE5ZFJp?=
 =?utf-8?B?NFVob2I4Y2RNd0FWeXFGenhLdEl5aWpzQnhjMkVTRHZuVzgybUo2K1pteURu?=
 =?utf-8?B?QWkvc0lrNXZIU3I2MzB0L3FQYTBwRFNEbUFGVTlkbnlidVZ6elBrNWF3MFZI?=
 =?utf-8?B?NExINUlJUTVvbVZCNzYzdFpGWlU5NDlFV2phNXpQdFpFU0diZXlVRUZmYUV5?=
 =?utf-8?B?b1FzSjNXVS90OUFtMHljWnFPOXNodW8xMTVvODN3dTRCNDZUUkkxRFI1dFBV?=
 =?utf-8?B?VmNyQjZKVjNnSjZOcDRJb2h1Uis2dHZQQk9Cc0xFYTRZcFlUOEZ3a0xMMG1O?=
 =?utf-8?B?NjNZRjhCVVIyeTVJRkFoYW1yWTVWcGQyNE4yUmo2Vm8zWFFVU1pvc0pXRGda?=
 =?utf-8?B?VU9JYUJ3S2hKbXhaTmU1NVdLcjBLZGlpZmk4OVV0MVc3RnBsbU5sT2I2Ukxn?=
 =?utf-8?B?ZCtVSC9ReWh1Wm9YRW1sczViOXZER3F2WXlBLytqR3AvUXhzemoreGc1b0d0?=
 =?utf-8?B?aDliSUM3Ri9KUm03UGljeVMyMklPYlQ2SU1YNzN1aUUzVUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:39.0766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62af7fc0-497e-478f-c653-08dcfdaf38a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 70e7f1ba68676..4454c4a903c8f 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -188,32 +188,26 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EINVAL;
 	}
 
-	mutex_lock(&profile_lock);
+	guard(mutex)(&profile_lock);
 	/* We can only have one active profile */
-	if (cur_profile) {
-		mutex_unlock(&profile_lock);
+	if (cur_profile)
 		return -EEXIST;
-	}
 
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err) {
-		mutex_unlock(&profile_lock);
+	if (err)
 		return err;
-	}
 
 	cur_profile = pprof;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	guard(mutex)(&profile_lock);
 
-	mutex_lock(&profile_lock);
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


