Return-Path: <linux-acpi+bounces-9673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89C9D2CE2
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD574B33389
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33D1D31AA;
	Tue, 19 Nov 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KUrnSnw5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150A1D2B3C;
	Tue, 19 Nov 2024 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036878; cv=fail; b=uERnwgBnXDvkMWXFbWHNxjudG7jzxhkTd906O1/JL8EJ6il7zCXvYOi/Z0DkFUmsGOIiz2xnsW78F0+Aww21O+9WsXRVW2oDZykDXXb+Z4gu/FP1etcOYeqaB5vx+YJ0ICvUnsApYBTgWCmv/lnyUdmIkP90qYnQYznTEYvtG3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036878; c=relaxed/simple;
	bh=vmgke1hNgi+9jY2YjBI6Ei/XWu/10vuyZ2DT0pBncCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huo83eeQO3AHWkBSCP27DJzAt3/3MOdDD1o7xxjo9JcaBX6ZzLFn0WzzL2OmAzmwEHHcHhPHtwI7g5YrbS1v8KJ6KZM16uveJ6TpcUbbLXoOwmcBFmdmfMmrk8KzPjBAf+nB//D6Ttq9fGHpnjW8V7Eji3MjwHtKUqJtvszGCjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KUrnSnw5; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qygAIZ7IyCjqHVLXHTp2vHqSrm0dHvMQDwsNBUsh1sr2+UJDrsXSatPZYFhiUM4eXQpgba6tJEEn8eendGBr3kOiKsOcKZcq4hSzZB3YSBLw15ebP9xpBzSMPnXUjuUA4uSejO9IzhQeYCMXNjpSlzkVwi0it4blenIUiNVHR2yZ8Bw623N2/HcBxvQHgzoJ1YLoN/SXoryLONv5p/iOG46FbBLzTM1M84oL1TO3fxCdUnvKt2w2YobLnYCbEY+DcJvI8qwnKPiB4xTFti+24iUIDByPUxZpXBa8u4Ea+a7bzuJuRVuWEViNyRe5cxwrGkL9Z+gmdAEq3ne05ABqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JOepbNXpw+MaowhRv9S0+a5ySr6FY/Rm6BniVYK8xY=;
 b=ot92jfqwm+3DYOWGD7X2+aazbF4sAnHBdhdrCd1LnyCWzi30jIW/iva3ts3CcoGmt5mugDrK++mX35yabGAGODXvwf9xySNIoSR9ZrKmu5sdhuJ6exYZVJ5Sdssjulm0uknuYQZJArrkzPzmGtoG+ax1qB5rd9PypC22o89MbfFTzRyI8CpXt20zjRjIEe6CxyFrrWD8DBpSpXc7DTmm1mq0cZFPdImBriBFvAv1xSIVvFL9cl3bwY3OcJrUcgQjOg0GRaoMhR7MLAaI0ygmsBO09Pi7sWCA4WiccaTZ02LGeVClz5ZXEt3c+Qt22h3IKnkpqyg36GeoaianF8Er8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JOepbNXpw+MaowhRv9S0+a5ySr6FY/Rm6BniVYK8xY=;
 b=KUrnSnw5SlUZPe7Pzz6Tqvyi7wvFgQUdhtyb4x1IZvcYzKxvhfvpJLzFUwrE/nr9M7GXRjd4JL5+Zg4LJ5NSFA7eSxFueBcAl1w0r3bICW54xcsPUlMjPpVFuarwc/BcysJpqPO8s59Z6NB4F4rQV1fWRiYuzqe4GSOtShzebGg=
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 17:21:11 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::fd) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:11 +0000
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
 2024 11:21:08 -0600
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
Subject: [PATCH v7 07/22] ACPI: platform_profile: Move matching string for new profile out of mutex
Date: Tue, 19 Nov 2024 11:17:24 -0600
Message-ID: <20241119171739.77028-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ac4448-5c7f-4907-7cda-08dd08be903d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm5RQit3Y3JuVWJZVmYzaUR2SFNJVUlxVFZDNi9LRjJvSTFLbVFtM1JZRThD?=
 =?utf-8?B?dzNjTW1Xc1dseFpaeE1UZXNVQVB2RzIyNityYXdNcTRzM2E1eHppVzNQM0V4?=
 =?utf-8?B?bmNSc3VtWDZJWW1vcm9ubzJqWXpUNndCdkFjWGZYUC9sc1N1czczWXE1T2Nk?=
 =?utf-8?B?TXYzYlFrWkhpZW5HbUhVV1UyYmZJbjllV3B3b1BVZGNWemdvcTdLQWdNdUVR?=
 =?utf-8?B?UDJNUjltMUE5eTRZYk1iRlozekZQSjduU0RVcVdwMlBzWHZEekpCQ0U2S2E5?=
 =?utf-8?B?ZEVER1JlODh5bnlQS25wN3VydmlwazlqaXVYSVowZEM3cEhTZlN4WGlPKzUx?=
 =?utf-8?B?dHhkUUdaSHBJK2dES3BrT2E0NmxEWHRZcmRJVldmVlB2YlZFMkp6TUtlU0ZQ?=
 =?utf-8?B?NkZVMzJFeWVrSjRNY1AzTyt5d3VPYWNKMEFqWWkwUXN2VDJqV3c3MUZySk5W?=
 =?utf-8?B?WU5tcGJEOFJLZHptNWRScGI2NHRuZS9NT0dsSVVaQUEzUko0ZHozOWdmZU4w?=
 =?utf-8?B?NUVpZVErUGVxMnJ4OE5za0oxOGtzMnliSndrNzN4L01WMW12ekdpckZhdEtN?=
 =?utf-8?B?UGF5KzNIYk5icmlCTFQxZ2tVem5WRUdscUd1aUhpMlpzRlpSZ0FJUW5VL0hx?=
 =?utf-8?B?N0ZhZlpuazFscFRuc3FPRm1OQmdVOUlHcWQ0cU5UbUM0RWRKV1JsRVRqUDVr?=
 =?utf-8?B?T1k1K0JBNW5WVVg1b3A1cHFtL2xUQ3NHMytYaCtZTW5od1pqeXZMUWxibFYz?=
 =?utf-8?B?djM5bVZwVUQ5b1o4UEdxOHBGWnFyb2hoNmt1YnJibTQ3MUdpd3dNWm1uZ0xU?=
 =?utf-8?B?WFRzdnMrVW95ZXlmd1paNFFNYmJMYnlNcW5qTVBHV0VhUFlKZTJXcDdDRXlW?=
 =?utf-8?B?ZXBSSXM1cVVtZEsxdTc5ZDlpbUx4VUUyZ2ZOVHUvRVJYSnV1cS8zVGJzZ3kr?=
 =?utf-8?B?eS9yejYweHhjUm14bVFKYjBmR1ArRXVxa0hHUkR3R0JMRGltR2VmVTV1Zk5Y?=
 =?utf-8?B?d0VuZ09QbS9sYVkzVk50YUhIbkJrZ3lKaS84N1VmVkUxajhCYnhmeCtVMVNt?=
 =?utf-8?B?c2lEM0tEekNYOTJNbGRrbE1NQWxEL0tNZnMxWWZWaFh1SGx6SWYvemtGWXB1?=
 =?utf-8?B?UUhuZ0VkcnFhYWtYQ1NQYXJaVk5DT0JNeDJ6eXlWNXBCNTNlUzAvc2YwNTJn?=
 =?utf-8?B?OG1mWU10TFlRaDhsdUlRdGw5VGxXS3dLc0VlWWhCMFJXU2ZHVFdXejcxZjJn?=
 =?utf-8?B?d2EvQXBjRFlRNmg0cGlVMmFkd0hMOWZJWFFqaTBxdVpBYkxnRHFYY3VHVFFD?=
 =?utf-8?B?cVBucEdhMUxKWmwyY0U2K2NtYldoV2lpZm9FdzF2NlFlNUJUUmF1ZFp3YUp0?=
 =?utf-8?B?WDQzMU5FWGFVbmVBU001RWp2ME5kcUFEWHJ5cHpWVUdscjhjYjh1N0Z2UWRN?=
 =?utf-8?B?NEx2QS9zRkhxVVc1bW5kRmVFQTJ3MzZTTGJMSUU3UVpsRFhza052amtlQVJo?=
 =?utf-8?B?Z3FycFM1Wk02WW0xdyt4R1VWMmppUGI5eUR4eXdCaWRYS29kNExmbjkraWNz?=
 =?utf-8?B?WlU0NjJiZzU5T1VpYjlmRG9BZmlRZlNQc0lKKzdtSEZtNnI2QmdEWnRqTnYr?=
 =?utf-8?B?WTQ0YWZaV0tVcHhtU0NJV3A5dzNGaFBaanBmbm5xckI3N3ZzeWNmYks1bVB5?=
 =?utf-8?B?K1BIZ3F3SURpOStJMmZzU3J2UWpKK3k4N1Y2TG5wbHZka2oyRGF2bjBQWEZy?=
 =?utf-8?B?ZzhiRG5aczI4Wk5HUjBpTVFpRWlKSDZXdm9Xait6VmFZWmlqYnpIYklNRGJs?=
 =?utf-8?B?YzBjVUlOQ25BV1dSS0tMVEkyNDRlRDUrUGZJTmdVSDRkMWNxV1NidzRYbksz?=
 =?utf-8?B?ZDVtRGFibG1HcjlHS3RrZ0R4d0FzSGZaYVd5Uy92dHJERlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:11.1516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ac4448-5c7f-4907-7cda-08dd08be903d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

Holding the mutex is not necessary while scanning the string passed into
platform_profile_store().

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
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


