Return-Path: <linux-acpi+bounces-9992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABBB9E64DA
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F2416964E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99718FDD2;
	Fri,  6 Dec 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pcx0vGz2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F0812FB0A;
	Fri,  6 Dec 2024 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455550; cv=fail; b=OIz3WokWUEf6KNQNxbEFT7zEYmpwZcfR5HoX/uQU453SDjRkVV+NqqhJ9wkkr8LGHWOzDLyKVnB0HpDlE2/hPbOpImMKeyNHgy62Mg4hMzy/KCVa44IMzr9u5Q18bm3hZ/7vVbyFn7/zlGevgRbUOW+AJo0gmzULWFV5nuoIPN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455550; c=relaxed/simple;
	bh=+xN18sNC5Ocgap1+ttPhDXae8uq0m/TFsmTPn/lgO0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTwf2Qb8hY3j7mUAa8pnllu+zNZIQooilvC9HIPYxl16XtVL0UnFlIX/sp8LFYPmA0liwNJ/w6HZfW2ZhM3AMKS7dK7F41WYiJ4SDkk7w+/PJd+gb8F88XrXoo7oWQ/rShwIstx65WoGLOn5Y87GZSZT04YaIVIsW2huL0Of2B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pcx0vGz2; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhQL+lKXdTUAjpnZwVP1S9uKynPxxRS2TJs33Xps/Npoh7NiEbJaQcLg7T/esbAaP+qqgGu0O9IIvpTujXYYZIiRnDBbZ3J7wNRnanBxzJkkNBdHYvwn6su1XyK990LUsUYWQ7uKxxM66ZKn+3aVO8lFK2sYzFCzzARwIYulbrEJ72Ucs5dLV2+8xGM/2FW9jT3pt3olF5SWvd4YfDOZubWhCYmasAhkhp6j/DXKRqOf4zZyqDgOd8MMRqH+0mvFzAESXYF7aGCdbz6rcEUDE9KLVOBw6y6xQb2umpGSWcADd9u45K/o6T/6jPJSmGCFaCdr7kvNagS3vXA6jW1trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+XaE8yyWjGIn19TzASAZzj0sYETWpxRAyipXeNBClA=;
 b=mKW4rbBA0uHRmTLhxXi2HCjkrFFt1WwUlrKAmzJ0Ws+wN+yvYIYb1bb4YEMuv8EcB9o3AGSwbe1ytqu8xA4qYTNmcqYY3XnOYoN8jF/hI/mpa9OVSi9CeMSZ3ZwhTqZqvWrAqWHqqggTSS693UgmV8WF7dGMo/LGwBtl9qvizxm7ikqgW1gtLp26O1xuXz/5BcOajShc2S4Tgwpr/Ob4Yn9sEIF4Ym5ifYE8I8pcG0ZOX1ldINOuDnOTY5sxLAbVW01zp8Iunx9FNB5E06jS8CORLok5sNQvPXR44ZE/beg5KeagGUrDCN6kPHVQczgM1pGmR2zJZqLDQ5XEytQg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+XaE8yyWjGIn19TzASAZzj0sYETWpxRAyipXeNBClA=;
 b=pcx0vGz2h7NbW1UacIreB5MdVtA5FAG0tavVKFH+fQ5xh9Y1lYaEPOwf9J5riH95nfCJhIsDYYDOuG6h6i8VeBlKTBorFEXHqMHXol/L5NXWet2n39GGqGZu9P+m1STnKCadPwJDs0JZCm8Fn1l37hhGPF1biOcAtkR8wWQmCdU=
Received: from MW4PR04CA0040.namprd04.prod.outlook.com (2603:10b6:303:6a::15)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 03:25:45 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::6a) by MW4PR04CA0040.outlook.office365.com
 (2603:10b6:303:6a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:24:10 -0600
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
Subject: [PATCH v10 07/22] ACPI: platform_profile: Move matching string for new profile out of mutex
Date: Thu, 5 Dec 2024 21:19:03 -0600
Message-ID: <20241206031918.1537-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 7231f82c-1bd7-4b09-8a0a-08dd15a5abda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFE0djIzUFhDMDdla3RieXdMRGdGaWFwd2t2RHU0SnRCRTBxb0dkVlF5Y0Fo?=
 =?utf-8?B?RHZ5YTlaMCtNTkJ4R1A4WGNLaG1RdHZGVGc3QVFIVzZLc05GTVkrMDlQcmxY?=
 =?utf-8?B?aEFGUmJlN2wzTE9zLzdoejd5TGx1MFN3by9zRVVtZVdMS2JKS0pNQm8xaU1s?=
 =?utf-8?B?YzUrbU9DeWJnNDFrOTh2RW56S25NbWNIekZwN3BDRXVDV25kaVdMNUVMVjRQ?=
 =?utf-8?B?RGZ4UkFLeU1sU1NSbkU0WkRNOWJqalN4cVltRHRiN3pELytidUdUeCtFbDRj?=
 =?utf-8?B?bTVPSEpSYmEvalhOOUt3UHpodDVQb2xXS04xbVpNMldlSmZQUmFWZkNsTE1D?=
 =?utf-8?B?b2E2c2FVWlVad2FkczlVbkdzWklLSkVZaEhMMlFScmE0WVVSQjQ4SGU5RjYr?=
 =?utf-8?B?USswT0QranRhMHFnZnZ6TTQ3LzVGSGUwV0t3cHVsL1NXbmI3Wm9uMS91R1g3?=
 =?utf-8?B?ZHlnVEtqRjNSQXp6ek9DZXMwdkNRUmFkbVY0UW1wVmRqWFdqQkJ0NFFRNFRT?=
 =?utf-8?B?MFhzTFhIdzEwNmw2cmg4NDlXTXB6bVRxZ2VyWGplU3h1OUtLckhuZ2dXcGN4?=
 =?utf-8?B?ak9KVkhuNnVpVjZSS0FNUFF3V1hXeVZQc2ExR3ZINlZic0ZsSHA5TlR2SXZL?=
 =?utf-8?B?S2dlVys0cE9JUjNYRDl6Q3pwd2RTamdKUEtTbmF4MEhmMzA2MDd2UjVaeThX?=
 =?utf-8?B?NVhaSTJkaGRsUk91V2lCTWtmb0hDaG9ldzZMamM1bDc2K3J4OXE4dVdmbjVB?=
 =?utf-8?B?WUQyZy8vcE5FS1NoV1JzQ0JwbDlRaUlFMHNxSXc0VEQ4UjN1OHRmVFZtVkVV?=
 =?utf-8?B?Y0JYY0k2cDdIY0wxRTlsQnVpV3I5Zit3dGxBUzdUZWVxck1aU0JSRE80NDJm?=
 =?utf-8?B?S3RyTGJpYTlsRm5OTnhHSEYxNTZRRnhMbEFucHVTb3pqWWdpM1MwL2N4T0Ux?=
 =?utf-8?B?Vjk2ZkVEMVMyZC9YZENJK0h5c2VXQm1lWTE1d1QwWXFCV01GVnp5Zi9mUHZV?=
 =?utf-8?B?UFlhbjIzVy9VRldHZUZMRVg1ZDdXc3FSYTczMmZzdEJDcnczQWQwS2o4NS92?=
 =?utf-8?B?dXlzZU5SUGxoejM5TXpFYkdXWUUxR2dPOGp6Qmpyc0ZONmhmR2dLcDVpeGRT?=
 =?utf-8?B?bWpxUENFUWlQd2pXNjVDNi9yVUJJT0EveHp0R1lhRkY2bWpya1doamR2MFlF?=
 =?utf-8?B?b29PMFlZTkJZSXNxSjN5cXZ2SFJmNlJldzlucjFsbm13YjExaHFEdXBaY3R0?=
 =?utf-8?B?K0NpZXZFMTlyZnovSXBKdGtyckF3ZlhSd1NUOFpub3FyTGQvU3BTcmgvS01k?=
 =?utf-8?B?QTNNa3QvVXZZZ3dyRERMdE5WeFlmVDRpZUJyQW9HYTRseWdNOVdKMU9Sbndz?=
 =?utf-8?B?L3grMDN5S2w1QnZienk5alk2eTBPUnNyR21WajFsbGcyWnluNXg0NmZqa055?=
 =?utf-8?B?SCthemc4RkYzSktEcUJOU2ZHNVA3OEV0WVhESjY1a1JOVi9tV3lJMlNkZFZD?=
 =?utf-8?B?b1pIM3VBZHAydjFsQXYzYzJIc1BxVkVNM3Q3b013aFcxb1AzcUFDUmZZNUs0?=
 =?utf-8?B?ZGg4cDNzZHRhenN4eWJYbFZBbWpDUXZnSThxQUJoclNnYXFnYjNSWlRsMXZa?=
 =?utf-8?B?dkd1ZTYwQ2g5QjY3OUtFUmIxRnhsYytKMElaMGMvYzJiNTV2MDdBWHZGUVVD?=
 =?utf-8?B?K1pFazJtamJrRUdEUi9BLzZ5cFNDQUtqOU94eFlNK0srbHI2MWczdUtBY0dT?=
 =?utf-8?B?SS84SzNFMldvUjNvL0lYbGV2UEtmMmkwelZyOGYrZnhYQ0ZlZDdubkcySjFq?=
 =?utf-8?B?TFM3T1UwOUFuRnZPTnc5eFcrY3Q4b21FZkRVMnNXcGl0T1ZFRzczRFdSZFFM?=
 =?utf-8?B?L250RnhOMVJ6M3E5NTlwYUxRbmpyWWovSTB3UUc0TkJ1TWFGYWg2NDAwZVlK?=
 =?utf-8?Q?zhF6PJpNngwTPSTV1Cn+DjM736z3ZK/S?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:45.1772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7231f82c-1bd7-4b09-8a0a-08dd15a5abda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

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


