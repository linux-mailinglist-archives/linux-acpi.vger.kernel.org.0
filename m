Return-Path: <linux-acpi+bounces-9671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD09D2D93
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 19:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE581B32D58
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53BF1D2F4F;
	Tue, 19 Nov 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uE4qgv67"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255131D2708;
	Tue, 19 Nov 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036877; cv=fail; b=I2CS7hlXA2XadWmrHo1+2Frdxh1qlX3CZlQvhvamr7qnms53q8FkWcqRf6X0gW3S/LzNDcT6192tvMBCkC8nuIaeOKTyXzGNc05vyxnEQU30/NRXOwovtoBBXZzrWuvwtUltwiPMGSPGhBiGpRHc3WUP9j+xJoNRuqQ6olK+zHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036877; c=relaxed/simple;
	bh=qxZR0ioXhz7I9mrAT8p2DAj4zP/orxCZ1guCEIlDwcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt56qRUEAnl63xsOCzh+HUWQHopDCNtNsDNZQit93AMD7iZMnhPyK9VsVI6KCiC8u8H0C0XH7NEXHmfD4ZECUh7lzw+rpfQKZtAy8+FulRSZa+iAY6fZAKx22v7zBjzAJXi5nug8ftIXjvIci8n7f3zckDOgyAULc8vLiqk1ASo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uE4qgv67; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2wylO5jr9tjnFaHHZHHl2IhJHMKm1fO2NG4eJ391VD7qlxQ2W3O6rguP5hHPnPfFy//thiGdYXEPiA+JXz1imW2hMCQefvJQCmpzc8OLrryLFyiTTmCSV8L/vPN8DhV4ELX6I5QDS8LZjFugOoNE46H7aeEwS/a2yst8AdTtBk+rAeYNuvA3eLPMIJ2k9PjO0phnLcaNDaKomZdrwH0b50ulocToP1jsQEX5QO8K8gSMqrn+YXy9YVsHENejC/jbXLrfawJoOM8Tm2VHlpjSrApDbz7zewW2nU/4l1lXT8pDtZ9hpAivVyRnja08qQQhDRk9cIN5wKCMupnzJdPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb96Rfxdmtyo0JIpdtirBRC/6HMVRjTmHsGHHm4KVnY=;
 b=EyI3YNO2Z6KchJi9ZGJeNzpv88p44RP6zN41/m9ES4Sbom2gnrweoZbMM72O5cE1pvjdpe9mki90VOZLiVyB1x6bOlo3Po1a2TUjzQByfrHCzUFUBGvOigu1kW6PytIdwkDs//UO1ndjSHq0eT+9CLo1E7puYC2N228HQWnTuHdNvGX7Uocc3saSxgYARrh7LMxLljz28NbAf4LuJeu9mA0EKdjs8U11D3esFvGSECOd/c0mRXHej37mi59JKfY0QJdeRWoAdG9Qx7k5VFmCwRiM2QAGTZUJZDQoGqyQh5SKsPu0l8uuwhO9hWdVbD49RAEI5P6phHLbe6T6iWJYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb96Rfxdmtyo0JIpdtirBRC/6HMVRjTmHsGHHm4KVnY=;
 b=uE4qgv678V+t+69Pu6mXQnBJ8mG+hyaokDNHf3tSoXVDOQhCd8uukBHt9L1r32/Wbz8CaSX6AAYaKaVdV11RJ6IJpQjqzmyhLMNEoddF5gGrB9ie70boRQ6vnouftuWTrxJu2Xc+uLNl+OYmKIfS19/lJesn6c+j54UgmKlHGuA=
Received: from SJ2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:a03:505::24)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:21:11 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::18) by SJ2PR07CA0022.outlook.office365.com
 (2603:10b6:a03:505::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:06 -0600
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
Subject: [PATCH v7 06/22] ACPI: platform_profile: Move sanity check out of the mutex
Date: Tue, 19 Nov 2024 11:17:23 -0600
Message-ID: <20241119171739.77028-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd9ec7a-38fa-46a2-fb33-08dd08be8fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVJmT0lUWnAraWllSmF0VzFlTUpnYnpXWUVta2tEc0V6NnpoN040SkIxekZu?=
 =?utf-8?B?OVd2LytMREltdmJ5N3pwQWdHM0tEMkFlZkJJR2VuUGRnSzl2QW9FL1dMWnpu?=
 =?utf-8?B?Ly83VGcxSG10U3BqaitGWk8zUElhTG9lekE1VDIzR3EwVHR2VTZRWFlpTHBH?=
 =?utf-8?B?dTdVTUNRMlFvUThnOHRCZGIwVlZ4RGFhQWxpYVdwUXA3OU9YZTVXanVtSTFU?=
 =?utf-8?B?bk16djBLakJYUTBrY0o3N1dvNm5vcjN1VWIyV0Q1NXpSQWRZa2puTmN1cERG?=
 =?utf-8?B?cDNHNmNiVytreXFWWDdnR0plVENRQkRzSmxoMGRYS3hlcEFIbmhDdFovM1k5?=
 =?utf-8?B?cUVqMEU3Z2Ftc3BTMDlXcTl5OHFpdlhlZkJXMDVFKzZIa21HNUxUWWtMckE0?=
 =?utf-8?B?Y0NsRnVUdzk0RThXRTI3cW1NSkxYeS9lSHNkM0tieXFWUFBGKzIrV3Yzclor?=
 =?utf-8?B?R1pjNE9mUlVpQzVFMXAzRys0NVNDTVJtMjFHejV5U3FWMWxtcStyTEhwNG5y?=
 =?utf-8?B?SjFjUFpKMG9EUVlpUGZ4V2JGQ0VBSlozenlKcU12dTJvVUMwbEZQTlF4TDlG?=
 =?utf-8?B?empVR1ZGK2Jtc0hEMHFOZ3BmaTJMalNoT0k2cUZ1TXorVUpXanNaUnlDdEFj?=
 =?utf-8?B?MGFoTjZ4ejhqcHVOcVR2SDJTSGpoSnVsYjhHbEdJWUtDVEJxNjVkeExJWGpO?=
 =?utf-8?B?SG1RZVV3Tk1tU1EveTFtdEZLaCtGdVNudU9OVWJIdThxaTJPS1hOWkR4R3lC?=
 =?utf-8?B?QnF1aDFOd2ZJenJlWnp3WkpjbnZVZElSeDJHakNjWi9Ma0wyazdyWWM5NHR3?=
 =?utf-8?B?RzZlRUx6L2l3aUNtcE5mK3Flbm05aThaNVlQUW9GUXAzN3hlcFJkdDVkcUsr?=
 =?utf-8?B?SDNTOTFoT0krcFlVa2t2YkFGK2NEQVBsWHp1ZW5JWnhYSUtoMW4rV2svTTF3?=
 =?utf-8?B?b04xNTRodjUwT1JxOVVIcEkyWW1PK3Q0d1h3YXlQR3hucXhTY05lKy95c2ZC?=
 =?utf-8?B?Q0NETytlQ1pvejkraFRlRlJJVFpmbG5oQnNsRnN4SlJwc0VwbTdBQXd4amt2?=
 =?utf-8?B?T0FaZFRiRTgvL1ZPQnB6VVhaU3cvVW9FK0tvVlBnWE8xRjZ1cjVEYnJlaGJ5?=
 =?utf-8?B?WHp0OUlaVWZxak1YcDdkUTFYS3ZaUVV3NjdrdTh4c0pFLzBvbkNlSmdtMU5I?=
 =?utf-8?B?WDdKNVltNjBxRUNWRFVBZytUUkQ2RitIZzJaZGtseTRrMDdRam4zbzFHbExo?=
 =?utf-8?B?VzVDTDQ5YnhsbVZqcTR2OC9yMEtCaFlYQnBveFJVcTQvZ0ViM3RCV3JKeEJS?=
 =?utf-8?B?MGhnbUh5T25FWW9WSnJHYzZiWHdWdlNiZVFydTFZUlpIRVRGSzBzSVU2K2dm?=
 =?utf-8?B?N0xON0NtRnlKZEF6Qmg5dHFxM2FpT1gwTkpTaUFnMW1mSFVDSW1DUlY2NTVD?=
 =?utf-8?B?OEh2R1EvU3FCZytKTjlrK0VCZE9OMW5nZHEwc1NkcXJXNzNOZGdHMzBQYWtG?=
 =?utf-8?B?aTJJUTNQb3duVXZiOUlFMFFRc1R1aEFpc25zT21BdVF1UlZTUk03YkZnMlJm?=
 =?utf-8?B?T2NKUm5zSkIyNlBiMm9FQ0pnVzFvRmtlMUlhZ01sNStOb0pyZ3FPRURkdUV2?=
 =?utf-8?B?dzlOc0txYVFuOG5iaDZPeTF2LzRZai9XS3NyWGR2OEgvYjhWTzh5ZGlnNFdI?=
 =?utf-8?B?aHZLWUdlZmwxcmorZXN6STZtOTZpRUY2QlRxanF5TU1hSVBueDJKbnRoUVlZ?=
 =?utf-8?B?NjZLQjJIelJVM1JxVGc1N3NZSEYyczJockVTNzQ2ak5vdzF2UWNzSUM2ajFn?=
 =?utf-8?B?Ny9IV1QwQjVpNmJ0Y05wVjRoaWxhYWtJTEZSc2dDaitFeWEvTGVCeXRSb1ll?=
 =?utf-8?B?cmtWY2IwQ0MwdWExMCtCdndOYmFiYnEyQWZBZDBPMDlsbXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:10.5812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd9ec7a-38fa-46a2-fb33-08dd08be8fef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

The sanity check that the platform handler had choices set doesn't
need the mutex taken.  Move it to earlier in the registration.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Add tag
---
 drivers/acpi/platform_profile.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 927a2f7456c9a..4f5623fc27c09 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -179,6 +179,13 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
+	/* Sanity check the profile handler */
+	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
+	    !pprof->profile_set || !pprof->profile_get) {
+		pr_err("platform_profile: handler is invalid\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&profile_lock);
 	/* We can only have one active profile */
 	if (cur_profile) {
@@ -186,13 +193,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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


