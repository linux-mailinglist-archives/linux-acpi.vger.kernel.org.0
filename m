Return-Path: <linux-acpi+bounces-9674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5889D2C6C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1391F212E9
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8E1D359C;
	Tue, 19 Nov 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="edfjn6gy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEE1D27B4;
	Tue, 19 Nov 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036879; cv=fail; b=ZZcJpsHRh8cGXhg0GjsrVFst9q1W8uxU3lizVBkFtNY4rjAg4AD81ux3FfQAte6D2slIVXKN/EwTx9KLJs97tK6oKPfaRTPDDHl4GPuqfx2JK14z18ZpdjJm5gitMb65wuGx1gct1fCSdF0KV/XiG554viUzJqW/Vvx0IH2dHH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036879; c=relaxed/simple;
	bh=JewyXTxhFRqy6h34+YKrMpsgMeLgKwlZqckAx0I+7ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDb6+Xi9ci6KFLohI+lYejQJH7VeZnAhjpuHrkzx8Sdeg04z1QVPf35IwjAq4/x1DnSgXhcp8KLsONaHkdLNsjCW/CfiR1TY8swwQeWh/W29d5BzShC3vBAV5Hs7Ph5LVroj6ve7m3lIWLeasw8tzn9o1fr9uvzLvT5Rc7NmBbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=edfjn6gy; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUikfqQSy70sVX+2YpY4GE8ND3kaigEJ0BeUz+SCeY3zLGxy2CyhoIjEnzNrazNYoBsor4Yxmg9/fNV5frWpTmSOnG5wIXbW+E7G7mJsSST2Lh6YgTofO906SCl1GZrUGsqnzJu2uLuadLsqmbvWmW8qGKikY3PLA2xfTf2nSYPRlUOVSQkEksUJPF2+67b5FFkTryESzkdtKJqOmBWYsLEp6hpRY5l7fqn8p7TJLs++Hl7RYjeKXTFCfKXRU06cpSnc6/1G5OZah/Dyv4xuNocOUXwTzuenuUs5o7tEHoeDoehXaEGINF3FFbA3gAzzvRxuW9n3JhcamBQIWiQwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=qh4oE13lfHnjG5ST/HYAaapJDcq5n8FwrbiUJmSXToddL5a7BhrNPRQMmEA+wDcnpSaURV3XEb/JWtPr04+BLDX0u6pwF1HY7phH3MqNGV+7jzL1igE+Q83DinTiN6nhTKgtGppRnThlB7FandwBYBG5msyyPaFvX13VtKn3BVuV0ygWPJKmi0ftyGajwpr9m7e2jRf4rzki47oppMBXhrK6R9mkl+43Cc9dxpKJSoQxYGoQLRpAgrtiV7PUAxIEX5oc3fVLROpvYnCLUdwxSaRnZJYp0fvmW9NlPLFP8xBLu9g9HOF288inFOFLxinZq0Oazixg2gvFf507xoEHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=edfjn6gy6/zYuhhLkGa1y+/NRlN79wzmD1ZoBvyOryd7MbwLTRAy8HSo7slqCIZeXU/rR+4pvO0ERK7P9HTyF4TSo6FlBkhNkKJkrkxM91i1plbElgQMCsjTC6E04UAvCeHM6Gix5jMKOVUWQ9DJxkUmikyig+cvehTq2MA3ceA=
Received: from PH7PR17CA0041.namprd17.prod.outlook.com (2603:10b6:510:323::24)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:21:12 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::32) by PH7PR17CA0041.outlook.office365.com
 (2603:10b6:510:323::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:09 -0600
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
Subject: [PATCH v7 08/22] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Tue, 19 Nov 2024 11:17:25 -0600
Message-ID: <20241119171739.77028-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 976cc9e1-d22b-4d36-4ffd-08dd08be90b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEhVZ1NsR2ZYUUxheWROQVJ3VVNmWVhXbnIvV0pqQzFPTTQyN2FyVEhxVGox?=
 =?utf-8?B?azAzWkpEVWx2bTdiT2lpUXE5LzRWWmdBSHNENVBsUVVkRmtaSkZmMHhJZFFX?=
 =?utf-8?B?azBkWXNhMUV5aHN0RlJISTZQVVZBUHI3c0g3cmlZVXFkR1IvUTJSZTJJL0dr?=
 =?utf-8?B?WUdGaGZsbDlHdG1jdnVWK3dPUU9zT1VYL1dkQUp0NjJiRjVFYmlHaWZzSTFz?=
 =?utf-8?B?SWNpSU1mWVFlZWNJMXVTcGJwdFprclA2Z3NxcFJ6Z1BrbWpBaG1ZVXhSS2Mr?=
 =?utf-8?B?enkzNXNaRzBWci92SGNWUUFBelk5ZzlWdTNQc3RVcGJKdVF3cmpEVXNJWmtD?=
 =?utf-8?B?M3FISjBPZ1ViMXd6VnFyQ3E4c3JaSS9PeXpNUU9ud3loYXgrK3liYnlvdUVw?=
 =?utf-8?B?cnhCQXYySHAwM0kzZVFXZERERzZWTXpSaXRoNDl1MzhZZmZoMFhGSXhwQ2xY?=
 =?utf-8?B?c0t3K21FcGdoRHhYUmRsS0hLQVF6VytxOGV1STdRamNONC83RHRYcmRjWWx2?=
 =?utf-8?B?dHJuZ3hzRDZJM0MxWEYyeUJRV0hlVDloQjdXWlV4Tm1QN0tpaWhGdHZkUW1Q?=
 =?utf-8?B?TjhVNVh0VXFLUzhyK2Ird0FodWQzMEo2ZHVWZjVYZUFtVW9VRE5wTnZLNDJH?=
 =?utf-8?B?ZStpVzh5VEJsQmc3RWdSa3dmMWx1V2ZZZVBpY3NsNmEzelROZkRYNkhDQVd5?=
 =?utf-8?B?a2YxZVlUemRvWWxLbTV1SFNqL0pTNTRaWTduRHhNbUM2cSt6K1ZmMUs4akMr?=
 =?utf-8?B?UHg1eUQ2aFpBYmU4QXYzSHJ5YmN5SGJQWDVpSzM0UVBUanlyenBtQTFjSnhZ?=
 =?utf-8?B?RE5kZ3JSbzUySklwa0NRVzQyajVHc3dQRnZzSC9Ra3hBTnluWGFHcTdNdGxI?=
 =?utf-8?B?RWgwYk5yM3ZtR2FZbUgydEZUR1VRejRLRGVpODJ6WnZMRFprZEtNK0gvdmlH?=
 =?utf-8?B?ZTdDa0FZVUZhbGM3NkxVUjZNam1rRlJiemh5Um1LTXZ4YVd1UE83UFVwRW0r?=
 =?utf-8?B?OWUzeHNZdDdBTUNCaUJLNkFycHp2N0R2MTlwQzJVc2ZCUDVJVTlvVXRYamNC?=
 =?utf-8?B?SUY2QkN2RDh6TG5oeExaQnJsSkc3Z0xFTE5IVmx3aVk1V0JyRGt5L0dOaUkr?=
 =?utf-8?B?ZFBsTExlUGsxMTIyQUlOL2t5cWczRFpyNmEzS3BkdE0wd0hUb2t2S3pIcGcr?=
 =?utf-8?B?czMvamVRbnRjblB2YXlyRmFCVHBKTW1IZWR0ZmZtMnhJOXBNcmM5ald0ZCtt?=
 =?utf-8?B?cVNhMWg5MnduTGQ5WTFhbnR0MjRJRDhKY05DQk9ka3pGRG9GS3NvRnIyVDB4?=
 =?utf-8?B?Tk9EWlBTZHQ5eGtBRERKakpkUWtCMy9RamhLbWV1c29zOFFRakVKQnJZZnBs?=
 =?utf-8?B?VWRvbTdDWGJ6RjNFQU1LN1RocFBHczFtOWM2Nm8vQTlEV2pWT1oxY2FVOElY?=
 =?utf-8?B?cUwzdUZzbUZhN3VQMUlQYThKclhNb3BoSzF0YnErMVJBTXFXV3MvMzRNV0lo?=
 =?utf-8?B?dmhvWTVlcTRpSmRBL1JkWDBrZTJDQTlaYnJUdDVjTk9vKy9DK2h4eDhleUZS?=
 =?utf-8?B?TS83cDdEaUFCS0paVHBjTVFPdXUyWk5JSHNpd3Fnc0I2OFdhNHRoV2hBcWZv?=
 =?utf-8?B?V3BnbWdYblMySTJmYVlNTDU5K0hTRlEzQklaTkxmdjMrWnhOb2l3TmhlRDkw?=
 =?utf-8?B?N1BXN3hxSndvTzJOaXFyNmNxZlhsOFNHZEVpZDJ2dEhUM2FkbXUzODJhWW5N?=
 =?utf-8?B?TURFVzhpRXFvbHdiUURVZGdidHQxcHVobWk2K1lzT0JOVWJldTNJVTNQUHFj?=
 =?utf-8?B?ZEpkUjlZWFJ0V3dxd0dCQlNqNmVSUWpGMHJxTWJ6RUVuaThQbkxSMW5jTlNs?=
 =?utf-8?B?RFZuY2FmdDkwYkZNUW1vTHMrQmo4YlpibEx0QytVNkFBUVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:11.9173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976cc9e1-d22b-4d36-4ffd-08dd08be90b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 45ffd85a71dd5..9729543df6333 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -184,32 +184,26 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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


