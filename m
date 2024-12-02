Return-Path: <linux-acpi+bounces-9852-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E79DFA5A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ACA281968
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D3E1F9AB1;
	Mon,  2 Dec 2024 05:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pX/LnXVb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48A1F943A;
	Mon,  2 Dec 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118704; cv=fail; b=FVWno2bo6Ry7sSQDhbEltzrea35bqq2LtzIKMrSq3olVzEH/dmsFOwaNkCe6ySgLVGtiHmjpgw6Uwd9MDggsRYqpafEFAriZx2NTz+I15O8ddy8he6d2x0yg+FBrYSxq5mdYhvyP7td9L4MVGJjPWZw5mTdubAs6P7PiOShf9KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118704; c=relaxed/simple;
	bh=+xN18sNC5Ocgap1+ttPhDXae8uq0m/TFsmTPn/lgO0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5La+X2qRBKtg1UPYBhqlBB0+74enrmQ2obofmt+47ADtixmexz98NMz4XGMKftoHSb3zvkTabJk6Lm40DPKU4z+nLqbWHQphftW9T4fLB1EncOx1S1wK58d6lbdCGQBG55fAh5kbxLl5TwBETwtYOGN3h5puUGmJYsfr7gNPhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pX/LnXVb; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkmRMpUYDjdpTpUT0Rm0kTENKTrskdYRQ+whALPaKvqeQSqTgXDWSVWQD1WEh2url/kOKM0OugqaQIIVH3ZWnqTdSLQZYcjeQI2ixmjT+gQvzlEP8gVm0XjlGv9eH19uyIS48FBzo4Ckw+rEh4wrFwv4RKWH3yDMzJuosFY/tL7t4K2DlNOyVuiaTMzGeG9AZtGHUuPV3E6j9wryP4C3wXuE6NYcUYuGL/MKa80/AU3ZHQbNbkKni8W7e+5SbgD+QYKxKuIs2lQLny2WQbXwqf7xhvfpylDaYqsbx1laCULxFnrWEWrm2XZH8qE2e2q8cA8CUBjNyR2N0uFCzWad4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+XaE8yyWjGIn19TzASAZzj0sYETWpxRAyipXeNBClA=;
 b=OM+lKST2hXsDoGhqsSsfXyyP+jmTFgUZjGUvfQg3f0Mdq6CWwMtiCwAxvaKl+gg0bBTfsiFCmhdv06GvAw61+eQpHJc0OjBPiD0jW4gXQ4CnrvonmHnpT2lDlHzmd/JDmXJHLymoP5pw9F2IRGrstrJHy5WSNJwlnvCbkurxeGoib2vzw9oTVOdV9VF9Ig3gYHzuhuOuzcURAwh8F1CA3+yuFDXIA1BBiHjQvVtKxGBAmC68eQwsRLTNmteHIixo9n7Dgzw9gEMkrbmW018Gj1PikfcGgq8ViKIApVL3Ap4O6FmpJSIv4/UTSxaaydpHDWsgk46Eg0ZMa1jrjC6Clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+XaE8yyWjGIn19TzASAZzj0sYETWpxRAyipXeNBClA=;
 b=pX/LnXVbEN9MQkjuTzFun+HgQkJk+3osYrtioiZpDPLVFsSTZtne1Wnqh29xI8aqiLWtl8z+JfAGQe8/8YeFJvjRrUfJB2DV8VU8YEqnRfgEEl4mWjGEk4Glw4UHMNHQ3uWnK/2y/pv2qdbNeRijUkMMf1MO8kZhCkgJxOXEhmY=
Received: from CH5PR05CA0019.namprd05.prod.outlook.com (2603:10b6:610:1f0::27)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:51:39 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a) by CH5PR05CA0019.outlook.office365.com
 (2603:10b6:610:1f0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 05:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:36 -0600
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
Subject: [PATCH v9 07/22] ACPI: platform_profile: Move matching string for new profile out of mutex
Date: Sun, 1 Dec 2024 23:50:16 -0600
Message-ID: <20241202055031.8038-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a27436-31ed-486f-96af-08dd129563ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnE4cnpRZG9zcWVQTFBIZmpuQnduclRPWFBZN3RJWHhhempkT3NEYUdKREhW?=
 =?utf-8?B?ZzFkNjBRY0NvR1d6Sk5GcjRLMFRzSFk0cDJjZ3VETUVIalp5RjJkdVFjV0Vh?=
 =?utf-8?B?TUMzY2lDZVZSWThvWERyaEUxUkorL1k4WjhLd1k4UmZFM2FLbzJJQlB5aldY?=
 =?utf-8?B?eTVoNGpuVG03NVFJL1lkc3o2SVl1ZEJZZTlZOTRPR1cxZkFOKzFZQWt0ZjRq?=
 =?utf-8?B?WWhUNjdHY1dYaGFzWnkvK3VwUE55QldnVWEwbkNiV2tCRG1ReWorMndnODNp?=
 =?utf-8?B?VllmSkJ5c2tZTVFGbjBjZG9vYW1hSXBYTmwrbnhmRFo1Q25EMzYrTnJMK1p3?=
 =?utf-8?B?RC9TN1BqenRSakI1UHFMeVAzNXVnVVJoWUQrR29JK1A5ZXNUSnl1NUdUWXVZ?=
 =?utf-8?B?M25VOFhjd0ltM01BSGR0MWh6SHAvaDlCVFEzQVZabDg1Qm5XQlM2YnFobkFq?=
 =?utf-8?B?MjJ0dWx2L3dtdTVDcjFGTUVTVHZlQjhVWXQzMnloZmJBYVkzeFVwcU9QcmRB?=
 =?utf-8?B?TEtrcXV2VDZQRnBEcmVKL2hqOW1HQU84dUZpeCtoM2oxNTNLN1lFUHdBZHZV?=
 =?utf-8?B?cmk2MHdiMTkvbHNLYW9RNStVRTJHeldmT001dG5VaEJPUFFqUG8vanVwNVlB?=
 =?utf-8?B?cFVWdStqRUw0cjhKVXBZT1NJM1kwQ216QmZCbFBLNjBlUmFBS2ZMWFIyOTRR?=
 =?utf-8?B?UFRYY2dTNWpnZ0RvaFNZbW1zNDkvNGQwVVlFRzh6ejcxMzJxNXltMG9ISXo3?=
 =?utf-8?B?RnZoZjFTYkV4K3luN25EL2tRaXFOZVBwRlp3ZStkTW5OOFE4ZTlGVU15N1Rq?=
 =?utf-8?B?ZmFTWk5UWS8yMWxTTUVSbWFhUFhueFg4aThlSkU2UzdtM3RGNndPS2tqOW0y?=
 =?utf-8?B?d2ttTlVsTnB4ek8xY0tUMEFPN2d1NzRSVjhlQ3hoaGdLbitTWVlXMks1NDVP?=
 =?utf-8?B?SXB2eStLT3dFU1lWVWZsdE5JSTUwOWE3Znk0dElycWM2QW9jRVBZV052eFJ0?=
 =?utf-8?B?M3lLVFduZTR2aisxZU1HcjhaelVpTW9zei9WT2FZWnRDcWZLRXVnWWpQeEYx?=
 =?utf-8?B?OFgvMXdwL0FLR25CcE0wN0FVZWJrQVhCaFNXT3ZuZVJlSzZxdXpFdks1c0dC?=
 =?utf-8?B?b0FBMG5FMnhZVXVnNVNKUDRlSTA5VTdQMGM3Q1BxcC92dzRVWStFWGNKU2d2?=
 =?utf-8?B?dzYyU3NnZWhzdWwva0ZHVklKQjYrOXNzaEYyL1daQmZPSkVEdVlNMnpVM3Y2?=
 =?utf-8?B?QXZoNUJSaHJHSDlXS3pRWHdTWFFmUWx5RGtjaXBtemhWdUtwSVhJMVI4WFhL?=
 =?utf-8?B?OEMwSHdDWHFkODZTT3lxUUhLaGpRL1djdEVkb3l3R3NHQmdZRDlPOUU2S0xq?=
 =?utf-8?B?TktXZndlS3l5cVBXNzB1QnkrMzNSN0o3Z3lYdzlpdXJsb0NUeS9aZXZiMTJs?=
 =?utf-8?B?amdMck9kVXFKUUJxdzI1SThCdFdCUTFWUWw1dWYxeGNYUWRwOXVaLzI0VmQ2?=
 =?utf-8?B?U3I2SnVwSGtZNlQzbWVpcm5HZXlVYkI5UjJmRld4Sm9PU1RGQkI4UkxoUkZu?=
 =?utf-8?B?K1IyOWUzWjNwc29yYm1iRDRETHdOall6cWJvM1VMQXlZeXdzYmxXSDA4WlU0?=
 =?utf-8?B?UEdBem5DdlM1NTNLaklyMXlSbnRCWEFZbXAwTXIvZ1ZlaXFJRlRPNllIUmV0?=
 =?utf-8?B?YVZheW1SSW5hTWJiOHVlRGhHM0JZcWM4Q0RnaGNKK04rVmZuM2ZTVmNyS1Nr?=
 =?utf-8?B?aXdzWC9veEhhSVJycE8vcDJFbDFvSm8xVEJ3T3FKdTBrSm81MHFHbzV3S0dy?=
 =?utf-8?B?eDREczNMcG1YWmU5c2thWnkzUC94WnNySGJoR3BPWmdjeks5azFrV3VFMUZV?=
 =?utf-8?B?dk5QYjA3dG83RHZzU3pNUW56TmNrS1poWGZBTEY4OFliVDE5N3RURWtpMEda?=
 =?utf-8?Q?Gh1VVctuCVVZ3I+eOfSCkbwq9umEXb3W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:39.1286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a27436-31ed-486f-96af-08dd129563ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768

Holding the mutex is not necessary while scanning the string passed into
platform_profile_store().

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4f5623fc27c09..45ffd85a71dd5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -83,6 +83,11 @@ static ssize_t platform_profile_store(struct device *dev,
 {
 	int err, i;
 
+	/* Scan for a matching profile */
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0)
+		return -EINVAL;
+
 	err = mutex_lock_interruptible(&profile_lock);
 	if (err)
 		return err;
@@ -92,13 +97,6 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -ENODEV;
 	}
 
-	/* Scan for a matching profile */
-	i = sysfs_match_string(profile_names, buf);
-	if (i < 0) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	/* Check that platform supports this profile choice */
 	if (!test_bit(i, cur_profile->choices)) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


