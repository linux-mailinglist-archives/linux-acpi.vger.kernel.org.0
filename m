Return-Path: <linux-acpi+bounces-10001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E629E64F7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CC41883974
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA13B192D7F;
	Fri,  6 Dec 2024 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="grCVmBF8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DE192597;
	Fri,  6 Dec 2024 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455576; cv=fail; b=Y42VpVDWExoR9HZBFFMUUIsB0dR0Q55wD463cC0+UD6wBvFNOID/dqnoMFKjAt9DSDKUl+sTOC99UKoF1tRvbWQuYGpeUiIF/BPE+CLDQPYw9f5jzx3UREslBnBEZ0WBZiHfJnXFxWKXJAmq9+PhfasjahJ0FmQZuWbevgt1Vzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455576; c=relaxed/simple;
	bh=KVqn7cR8jWBeZhJN8eGjfBFPDg6nAG6qCoMhJRJ+uTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4tQsOeqBLYCCbIZ+phf8ugVQ9DX5bEcqvJuvBzyt9ud6lPQGxrA8Q+LaE2vYQDCKFpQInE1VdBMqDPof03u1sHU/kzXCRx6uGpKHltFDWKpIaB6SBnY/LTQVSWt/yZ9Mdxf67JLcPZS/Hy8dtreigxo15YlQeIGyCIcLyAjElw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=grCVmBF8; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7Shh+Y6xCdN6icvVYS0XqQCp3pSye1iwXunFwpvbvl4XI2yDOLWx/cAJTya1Fs/97v9Bynmp/YNChmkiwI0+qooweNwYLb3gp75rdqltNg7sJiTmAvxseosff8EQZ8qBp4SlsCXRuVo92EDkQgPBOt+skN8rUnyw95Jkir7dK9yywdsCspqWr+m49/yzLdlukztH9v3/b7CrkCUa0HgSFzs3ZjNiNBzmeLsufwjn9ekuFdvDGiGRv7oNeMckrxXWpr2S6lqcoySkDh7XJ13Qv1K7nZwJWnEUjtKKVM1wo1aQJEAgPruMGK2PhxK9+JCjgK0NW77ZRe/lZsatKgMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6dHsPQDWl+kzyUKP92nC6SOqRt2FM5/W/XOE/tNYOM=;
 b=vGXF+27wR9ghxEvAJy0wIlIizJnr21L7uTIXjE3+tKaMBwSWQfumlCdwELw3Obb2SgrEXXPCt1x5L3HRqst0HQ7hsJAiE2ocvvEwLKN1VgY9uRZhTJ2ROrsLwvTMF9mPUDXkRJuMVCTDrpmIiGmwRb6TsodGYSF/AH8oofUI5haByGVtsYnImTZjZ4GJFLBTJ62hrh+sduZ1AxZKh3k8YaX4pam3eXG8KX9xwnwdfcso50xkSAdScNCfwt4epANJMFg2c7WtZ/Fw/PWgqdWJkpEFcYJIgL6uGllMCN0iqHR5xYRqV5a5Kk7Wcuq3ouJo5sy6ulZ1/VVWfAbFb/S/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6dHsPQDWl+kzyUKP92nC6SOqRt2FM5/W/XOE/tNYOM=;
 b=grCVmBF8jNZ13JZYCDDcfFZk8fmhJI8RUqw44LQ2TF5lhhQ2eJBTUQ+AruoQymtWSUAAMASDrl5UjBDuvqTZTYNtaRuiMIxkm702SS33TNQnc/tdqtXdLanuozQYkgbOxs11XaRMnxT4b/uA4xwMgyNxIxaOUCf9p0nQWJSz0+o=
Received: from PH7P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::18)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 03:26:12 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:33c:cafe::d2) by PH7P221CA0039.outlook.office365.com
 (2603:10b6:510:33c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:26:11 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:26:08 -0600
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
Subject: [PATCH v10 16/22] ACPI: platform_profile: Add concept of a "custom" profile
Date: Thu, 5 Dec 2024 21:19:12 -0600
Message-ID: <20241206031918.1537-17-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 76928b0e-3b56-48d8-b569-08dd15a5bb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVBPL2MrVW40ajV0VVVZbTRYL2w4ZmNBNGpYYVYyN1c2MHVBQVo0VTNyaWlT?=
 =?utf-8?B?VnpLc1A2Q1h2YVpEbWRxVTZrNTBRWkFyQ2ZlZjJWMnhWY1RxYXZkc3VPb3o0?=
 =?utf-8?B?RjZZQmdremsrV2NSb0pCY2I0aWJIK2wzRnFJbXpuZ0JDb1IyaVE5R2VWZlk0?=
 =?utf-8?B?bDNSV2JZMmJTNmtsaEQ4QkdNMldRMTJBU2Y3ZGh1V2F2U1ZSeHNyRWovR1RI?=
 =?utf-8?B?eStGblRlc3BEKzNwVG10b3FtSmlxREdjR3FJRXJsdVpiVjRFSEtDcWV5VnN1?=
 =?utf-8?B?cU1kWENsRWIrN01XSlRtTWNyYjA3OU1BMnRVV0dkU2JHYnlsK3NvWjRUeTVl?=
 =?utf-8?B?YWVHdnNJVzdNMytCSHI1RXo5YVM0MWhRYk5SbWF1SSs1ODJJSm5oUXZVOWpl?=
 =?utf-8?B?dkF6aEFSYkJBQmV3UnNBMUd6WjNGdXdpak85WjZsY09WZjJxbnloa2lwTUtm?=
 =?utf-8?B?WmxmNHFpeit1ZWlIR1B2bXNNbUlzeDNkVWhscnpEZG1sREcrS29lemdNdGVD?=
 =?utf-8?B?b3g2b1lPa3lCUTQzbkNybjRuZlV4UUpJUXI4U1hMU29UeUhQRTAzRlBvM2Uz?=
 =?utf-8?B?K1JuY2JaQ25ua21MUGNBMjVpcFAxU0x1VHRULy9KeGI1RjZRVnlvOUduRnYx?=
 =?utf-8?B?U0dzbllDRHdkNTRDeWZzMHUwc1N2Ly9sZ2orTWJzSWJCQ3M4KzVmSzR2cy9w?=
 =?utf-8?B?NVYwWTg0WjlSSldCRzZCWTFOb1NlWmVIQXZKZzAzT0p6eWhyRERWQ09LbUdO?=
 =?utf-8?B?Ymd6dWEzNVJ4dTZRNjVJN1dDbmZBaHdOTTlrVnVHVGtGQjd3ZHh3MnNhVmtL?=
 =?utf-8?B?YzFlaXNEcVFsSExWUHRoaTRSOGNYOFlCUmZqNjV5b3FkbTlMdmlDLy92NXc3?=
 =?utf-8?B?K2gzek9UdHlNUEljaXF4WHZ1b1VYdkhQRHc0OW45ZnRqd0xqMzRpaS83R1dR?=
 =?utf-8?B?cERFekdlVW1FUzNhNWdleGJqYjB0UXJiTHgyck9wU1loN240TnFrcUJXc01F?=
 =?utf-8?B?S2ZNeW53QjdWUUNjVE5qRFNnUmZsL21nWld1T3YwOHNoZHh1bDNSUDhkSmVi?=
 =?utf-8?B?R3d4V1JWQjVxdW5YTStjc3dzZTFlSE9tRGVmVHRXQ1F0dzlleXJVNXhyTWdn?=
 =?utf-8?B?WG1Kd0k1eU1LV2NUTzJpcHNoamd5N2dmaDBRV2RGRUVPaEcxVS9EWCtES0Q4?=
 =?utf-8?B?cDNqcTJZSCs2L2k4c0Y1UlN6ZHl3Yi83eGlabnhCOXVyMlA5SS85bDRveEth?=
 =?utf-8?B?ZkVHRzM5YU9Rc1dBYlhEUVBqTXdxdjM1cGVWWkFLak9JUHZOb1l5dE41aWpD?=
 =?utf-8?B?MUZCeWN6ZEw0d2txUTU3c2pxQUNMVVM5ZDJOaCtHcXc1ZDA3dkF2OVdvSXpP?=
 =?utf-8?B?cCtVYm81aWsvOG83SVUxeURQRWpMaXBONVZFSkU0ZWM4UFhsQk9uRWY2Rkxw?=
 =?utf-8?B?VWdhRlVKTUE4K2Rld1o1QzI4OVhDR0hNeVZvWFNmZDV0WGlVdEU5WjdIZFpQ?=
 =?utf-8?B?cm44dlVJdUdxYmI1VWxYSzdsU2pmU2ZneS9KaEFYNjFCcTJwKzd1Z0V2VW5U?=
 =?utf-8?B?QlVzSE5UMUF5Q2krYSt4WFF3NnZna0hOSTEzSWFxTnN6VGRHWlhIWC9TMnJt?=
 =?utf-8?B?NFNZclp0Z21NcHpEWFZ1LzdQUHVERmppcVZ3MDJEL2dYVFp2SlUrQXJyTHJG?=
 =?utf-8?B?NU4wNWpMVWRnNHAvTStOMmUyMHhvdktIMTh2MWRCNDY0VVo5dzBKdXpaVTlj?=
 =?utf-8?B?SnY5UXNFRjdibFJjZElxMi9ySnRIT3lhVW1KRjBQOXRyelFXR2w1UkZ0NUpX?=
 =?utf-8?B?eXFWTU1XeE12VGtqWXdCN1d5M0p5V2l0QVJNUmtYNHVEWVhIZXFGS2wycFll?=
 =?utf-8?B?QXUvWkROb0tBZ0l3RlA0NUorMU5wZlVCZmY0Q3ZCNFFhMUw0aDVvTFNycGMx?=
 =?utf-8?Q?XftZA0RrLtQqUCBuZzPIT+P0R1ITCSjL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:26:11.5304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76928b0e-3b56-48d8-b569-08dd15a5bb8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669

When two profile handlers don't agree on the current profile it's ambiguous
what to show to the legacy sysfs interface.

Add a "custom" profile string that userspace will be able to use the legacy
sysfs interface to distinguish this situation..

Additionally drivers can choose to use this to indicate that a user has
modified driver settings in a way that the platform profile advertised by
a driver is not accurate.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * Update commit message
---
 drivers/acpi/platform_profile.c  | 1 +
 include/linux/platform_profile.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index bdf69255ed9ca..54483269b8834 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -20,6 +20,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a888fd085c513..0682bb4c57e5d 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -23,6 +23,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-- 
2.43.0


