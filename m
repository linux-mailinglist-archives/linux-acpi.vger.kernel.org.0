Return-Path: <linux-acpi+bounces-10005-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309379E6504
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088C8160FC5
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654111D9A48;
	Fri,  6 Dec 2024 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="InkH2ACW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2937194C83;
	Fri,  6 Dec 2024 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455596; cv=fail; b=XFcDOq0W+o7gLE0tca2WLQFyC8adDn+mrwVNG0g7w+bfeP35XtDAbNq22sGBLoD6nLkLFAV4TdySKm94DRFZJTNzJngn8AYM4pHMZG4gl9JJv0ijvzvG6fESujiGP/s3FO8uwcz5I2uYXRU+jPnFLb2N9BJIftbT7nJ+uZrLLhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455596; c=relaxed/simple;
	bh=Pby3tslwiaWul1jpe7jDQmaOMHbh0fenYAG674vWqvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3eYEMh9M4TWiTlDOY990qUFfg3DA1+s2n9OCelCKjQruO9CQx1uy1ED6Emsk/YtpjcX8XAVnbx5uACzFvhkRr27vEeBoHokQSo6HijM9KtB9ggyfgMFEVtTr0tXczbdr0MJm4ARotrrjtxaTxiToTlSPex8H7t5fcQTN8wBJV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=InkH2ACW; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS3llCSAyUsyVqQWYmdzq+PGGxgW4xBFq4150AH1Y2hCeZ1DGLYeM8aTnGymPowzlARD+sb/UKHOiUiNKboI7EmZopD+Z581nLUX/jAYFiwHMPVwfAQy+ACPgG6e7fBiUhMhUyLftOLimRHJmJqQ7ri+ht/OMlI6dcLbgHByiT3eQy6qpyCs3yN8IB2YRFC5rcQznFQjt6s2SN0tc9H1/6a1PDzzd7ZKPwsAlxCgYDdMyN2B9PNac71HlHhkmqtm+Fc+Ad2eVsbacKo/zC7MsOESwMNU2myoL7bNFzVBLZyngd49PR5PMsU9UqwR9h3dtnt7bNDKRRtgi0l9BhNRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyJY5aPn73/DA7rBV+lEr27Aq5GpXoB16YU2Ca577/k=;
 b=YtZVMZ5++VwZu0SUeIzgc29g6lT2O76SXGEyOp9IO5lJIRvFeegmHuPkj+dGfCRtzjKdPLXo4mmtK9QFrZUtqbcgG9Io2ptcxm1SSmrUFYr67NvvbKO9OiXBqgZZ3Gh4ddcgle9lSBX//mjgFypyduym12f8bSBizlN54EhiGV1/Fx4N2ww3byDHrWLShqTXMyU8DH/vewlZjQsNlnhb87QgDSNSYYE2bq1yK7MTy6Ql+hhocHHmBEFUiCFKFiN3fnu3cMyJHoVzT/lxrr6guRr5yFCjijTb1aYJ0FTrMnZ/cYueXvGEs3gqLvp6AqLKHqdrXstvY36Q+iFvXE+YPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyJY5aPn73/DA7rBV+lEr27Aq5GpXoB16YU2Ca577/k=;
 b=InkH2ACW0AQVmFFeR1sA8zJvC3fAFBQmRwhR7VVrjEg5TDt5Aw8s7jt7Qu8tPy96dQ0sCR5AJ6RAieDj5n8Iz221ocQJkJNaS/KyDM5vPyMFJRuokBl5Ke8hFkrs/yBaCoXvcTOIRLTfA9wNb0SkdpKROy8cyTh2uppxuTL40hU=
Received: from BLAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:32b::12)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 03:26:26 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::7c) by BLAPR03CA0007.outlook.office365.com
 (2603:10b6:208:32b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Fri,
 6 Dec 2024 03:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:26:26 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:26:23 -0600
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
Subject: [PATCH v10 20/22] ACPI: platform_profile: Allow multiple handlers
Date: Thu, 5 Dec 2024 21:19:16 -0600
Message-ID: <20241206031918.1537-21-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b174a3-f5bf-4216-7a7b-08dd15a5c438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXp4UHAvb0xRcTQ2TWJob3pwMXVSbjRWc3FyY0VGV3dOVktOU1ArRjc0MDlH?=
 =?utf-8?B?VWp0OVZrVVVUMW5qdkJ3TUxncEVBdmFNT3dJUmhDSG5aYUZ5bG0waDg1cll2?=
 =?utf-8?B?WEhHbUNlb3JKZm81Y0xOTEh5YVBQNlYzZVF4b2ZIUmJFbmxoV2hUcmIxY3VM?=
 =?utf-8?B?UStXYld0cnFlZGhzZUs1T3VjS1FBSkQ4bXpKY0VsczBYd0R1STV6RnhoV2tT?=
 =?utf-8?B?L3ErUzBvbTY3a0tBZjBHMUpNWUt1dkl2eGZqanlLUE5pVkFvaWdtVGV2M0JW?=
 =?utf-8?B?aTd2WnZSRXpzME15YW14QkYxZ2trcDZSYURSSWZDMEFzeEVPQm9XMFFnMkY5?=
 =?utf-8?B?dTFRdGI3MDczb1d5QjRrZ0JTRDZMb2J1TDRoU1dQN3ZJSGhicjI5TEVKOHhz?=
 =?utf-8?B?QytIbnN1bnY3cnVOWUhWK2dZeEE5L2tsNDJxZ3liS1ZGU08rREFLTXd5U2lt?=
 =?utf-8?B?dDBJbDZCZmpzVmxDK24vUW5pbGw3ZUdaUkRrTXgyTWlJa2FubE5QbGVZeWx3?=
 =?utf-8?B?eTlZL1FPejllb1B2L0FrYlBxNUdpWERPSzdNb2s2bkVRN1diZmhvZ2hRSTBy?=
 =?utf-8?B?UHBXNkxNTXcrazdYMnczRmRObk12amxpQ3o5ZVUwNTZwMCt5N0JPeTcwREZy?=
 =?utf-8?B?NVlFbEEvTmdyZFd3dnFlSGpiSVdPbnlhYlZVVXREZXVYaHV6bnlLWlhxYTho?=
 =?utf-8?B?Z3JxUWdpb3RFQTAzODlPK3ZIS3VsL2xsMkEvT09xSXRXYkJsRFNDQVdYanRQ?=
 =?utf-8?B?UGJidUMvVUNYajBzOFVyZm9zVTZMdEhhQlVaT29iUG5kMW14VVJDSG5oZ2Q0?=
 =?utf-8?B?VmovdjRkSFE2UkRlMXRRdUhIQzZKSXVNcGQwWVBuUk1BMzVtNEZ5MHdRY0Z1?=
 =?utf-8?B?bHVESXZtVWpod1VPTGFPRnZZWGpxdjU3ckxobTlObFZUa0xSTE5LVjZPYUJj?=
 =?utf-8?B?VGxSYTdaVnhqanBBMTN4aHNQMFhuajFMSXl3VC9kZ2VpVGtUNkFjcGgwRnk3?=
 =?utf-8?B?bmFwMHM4VU8yVGpLaDVIL2w3ZUcwZDAzOW9ydUo3R3RnTTU0WWJ4eVVzVjhS?=
 =?utf-8?B?Y3pUbXYzSy85QmpvK1RmcUt6VlMvVHVjUTZnd0h2UGpWVjlUQy83L1QwQmwr?=
 =?utf-8?B?Qy9hUmhKbWZDNGl3dkI3N0ZvRytnaFhyd2JiMmFZcFJkS2RtQzNFR01tdWFu?=
 =?utf-8?B?cGRXem9qd1ByeTQ2V2dRdDdiOTQvZWwyV0tsejBPRXZiMGN1UWNmN2RoNHpG?=
 =?utf-8?B?T0JqbXcyV3NDQytRZWhoQzgydWRaY2J2am9DQ1hZNXZESUlGNDREYW1HZWdU?=
 =?utf-8?B?YytuNzFvc0tQbitlZU1SZGxRYlkvaHcyZU82MCt3YlB6T2xldFN3ayt2ZENh?=
 =?utf-8?B?aGE2NHdzYXREelNpd2kvRHZxV2VKK1ZGOXZKQ0E4Y3BtR09qdGtPM1VJMis1?=
 =?utf-8?B?Ryt5SFBSL2M5VmNUNE02NzBGd0ppWHV0K2h0b2ttTnp3NGFHSUlMUVdsTFpK?=
 =?utf-8?B?cUZtckJHZE1mZHdyYlkvbkNVQWVicXZNQTdNNVFHMFBnaGsxRHBpMkROTThS?=
 =?utf-8?B?SmFUdmsyVXROLzQ3dDJaUkFnc0JaNks2U0dsMTJnNU45Q3MvUGpBdkRzSjZW?=
 =?utf-8?B?YTRwVDRKUEVoMGgyQzdHaGdSRnN6MlVYYSsybDdiODNDK2hidk5sQjJwM1Bn?=
 =?utf-8?B?eTJFYVI4VUwwK211cm5BUyszMjFEd2l3WkVBQUxzV3V1VEFsck16dGxDcmpx?=
 =?utf-8?B?NWJuNVNRT282eVFhMER2MnRWSmFpQ2REdEMrU3JrcklaTUNLaU9mUEN2TlNy?=
 =?utf-8?B?V0hBaE1JSEF4QkwrdzVHYWJKWi9LQkZ2eU5QVFVhVlV2SHA2QW5GR3FEZE1o?=
 =?utf-8?B?cFZjQkpvczUwK0VxNS9ld0RYclN1cnFaZzh3OXZVRU5SOHFZdzFUcGg1TklF?=
 =?utf-8?Q?B6C8LVfdg3FasPpPKc0Zk1Yd6zQ3ewJv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:26:26.1520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b174a3-f5bf-4216-7a7b-08dd15a5c438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

Multiple drivers may attempt to register platform profile handlers,
but only one may be registered and the behavior is non-deterministic
for which one wins.  It's mostly controlled by probing order.

This can be problematic if one driver changes CPU settings and another
driver notifies the EC for changing fan curves.

Modify the ACPI platform profile handler to let multiple drivers
register platform profile handlers and abstract this detail from userspace.

To avoid undefined behaviors only offer profiles that are commonly
advertised across multiple handlers.

If any problems occur when changing profiles for any driver, then the
drivers that were already changed remain changed and the legacy sysfs
handler will report 'custom'.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index e105ef48409ec..75a1415190ace 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,7 +10,6 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-static struct platform_profile_handler *cur_profile;
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -410,8 +409,6 @@ static const struct attribute_group platform_profile_group = {
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
 {
-	if (!cur_profile)
-		return;
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
 		_notify_class_profile(pprof->class_dev, NULL);
 	}
@@ -474,9 +471,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 
 	guard(mutex)(&profile_lock);
-	/* We can only have one active profile */
-	if (cur_profile)
-		return -EEXIST;
 
 	/* create class interface for individual handler */
 	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
@@ -492,8 +486,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
-	cur_profile = pprof;
-
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
 	if (err)
 		goto cleanup_cur;
@@ -501,7 +493,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	cur_profile = NULL;
 	device_unregister(pprof->class_dev);
 
 cleanup_ida:
@@ -516,8 +507,6 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	int id;
 	guard(mutex)(&profile_lock);
 
-	cur_profile = NULL;
-
 	id = pprof->minor;
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
-- 
2.43.0


