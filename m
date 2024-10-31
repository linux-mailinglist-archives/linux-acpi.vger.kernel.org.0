Return-Path: <linux-acpi+bounces-9177-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5477C9B73B0
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D961C1F24F61
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3885175D26;
	Thu, 31 Oct 2024 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wt4Hl+5S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD191428E3;
	Thu, 31 Oct 2024 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347883; cv=fail; b=CAIPn84+oBa1qgXU3J5R7o8cDEmtjF7RxdnvOJezbzsyIEy/BJXlGdJ0yrH5C5qFIZcyp0sHVzx5Nsx4mQaMNF13r33Fhy5lX25DukkC4tFeVfzXu6g6rvO9dV4Ni6IHlx6xXpN5jMf/XxQ7ammD8I8feYf6Y0Jr7LQr6WYycTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347883; c=relaxed/simple;
	bh=qrb4y8DNgSCrDBbHhO0W2f8rcPdti6swkaWXkEoVYR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwNVIQr9MyVd2/+YYY5x8RUuVQHx6imDVJbwogS6DFyaitM7GydHs8gJfpn5T6SG+AoG+roURJzbKnz9CL406pr9jrX6w9x2x64tl/UTNTvZHnxnZTJ5EfNRgcLzBvsqDjLHZLx9XxSbUga78k8GScQO6okyMK4F1d81dlbZ/A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wt4Hl+5S; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfQUiQcrQwbEFddmke7tX/PYCu4uSo7pQq0YTqJmY6MqKWDeFLIhSLa5oWirBzz2htB5nrnXoeK9JVkFQyGcQX4beJG0d/Yru2H0HnIYvJ12Ydisy9I72koXeDylQ8paJwZywOiyyhik6KJxz2nXxFsAS0UCJisFCzzfc+R7fxfyPU5NfzXG8pGSGGO+23fYqvHsRzdoAzBNl2I0r4UIcbIpMvgrbadQ/q6ARsBnHkZXpQvCj68jpWgR6Dh8bUOdndSPhnE5dSQ4A3vwZ+YG0IDjZCIhbUsUBz9CAMq7wC1H4lryB7i/XjKGXD2uzjLn1gD8Tqc+V7Zi3xIt3RVYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZRw0PnuGSquX6w1fAZagDnZwh1ox+3Ian7/NRON/FU=;
 b=BQZzFcKIwo9fU0jgbKL/yHtPkAtop+lBbf5wi8OPPU7UlKqh3JPtape0yjZV0T8Ul+y/qb7f3W/QlRYQO+GrlvGEWtn1PZV0QT6xSuCHJQArwg/+FeyBhWG/SaPlON49Uhalg2uX7fDDJnVPS5uQRqWSFvKlTJh8iNy3QcvlAt3UthV//or5sD77dxsv7xN+mMqM4EZZJSU6/1b1370Y+FVTQ8PZ11nlYGa9I4spckruNfrs4fWeMn+WpZhio+94xWPEdKknYJaZp1HAidalcD/YeNznumSvTqHLpMZMeTt+J1o+M2JwZw/7JvTcKxvjRLpwmKjRnYRWuYw2TMczpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZRw0PnuGSquX6w1fAZagDnZwh1ox+3Ian7/NRON/FU=;
 b=Wt4Hl+5SEQUqrz2fQb4kj7usagNfB9AdefWIInI4w017FuX3p2//ZVgf2IaJSqc1Xr2i/B+9l0Wz6k+k0sRQAC5XSYoW3HfWpGNbb25BRbBDV6JCqZXTP9ugl/3sCnfnCNYWKMlsVS7sypVzUP+0JFWY4BcuaPjf8w/INd8lLQg=
Received: from DS7PR03CA0354.namprd03.prod.outlook.com (2603:10b6:8:55::12) by
 SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 04:11:17 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::c9) by DS7PR03CA0354.outlook.office365.com
 (2603:10b6:8:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Thu, 31 Oct 2024 04:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:11:17 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:11:14 -0500
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
Subject: [PATCH v3 16/22] ACPI: platform_profile: Set profile for all registered handlers
Date: Wed, 30 Oct 2024 23:09:46 -0500
Message-ID: <20241031040952.109057-17-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 057f5614-3275-4f45-3ce5-08dcf962114e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5liTDJdmhzzYsbqhI+MUeBuYt2ZVHrk3wB2+yGRmZNJ7SdQ3bsvDRBzodW9i?=
 =?us-ascii?Q?0oC+1UuKH9+Vr6QIIHXK3xlat+2HDzHHmALi9lRT/d8zzpHaBqvXETI6ZIzf?=
 =?us-ascii?Q?S64alTDHr5yd0oLftcgaZWb0ETksorSWtinvoj2F5mJmfaUSFQC//BPRGhlZ?=
 =?us-ascii?Q?YAdrgdONnXxkjCnAfuEH3jCSfjxy24YRdpqPky7tBA7WRVhliJRL8z1y7nTP?=
 =?us-ascii?Q?RjBbKf03rn4+UJXdT5UIt+fnqY9k2RALvzIAzxaF0cbn8xQgaPcTcQZ4pa3y?=
 =?us-ascii?Q?foIL4jf9eu45v3oQYjPiRgCUdw4cLbxJJSArmWvX9cjxvJjzImQXBEc27FSd?=
 =?us-ascii?Q?XyX9tugFYUppEwd5p8KMBdYuUDIVuFwNP1yteMUvbeCiu/FmD5E3kZXiL/wk?=
 =?us-ascii?Q?k0zNvTq3ES752kEGwXI4QrOzup7vzBlUO1o9iTVxUFmf+YReh2ZKT8QCHQEX?=
 =?us-ascii?Q?0DRq9wdIOXBLdtqmcpOSpEGlj9wU7MrpRTevTkSxH5bfAgQFZrS7NzZcm+dO?=
 =?us-ascii?Q?prr/sNAgq0SIHdTouKYWt2k/GAGe4BBSsFq4/s6StGNCeze5ecLmeYodcLw7?=
 =?us-ascii?Q?OTipKmRSnBdCA2NcvVLUWELMIqm8JQC4fmEk8wrhVJLS1jq7mjjN+WcCUM1B?=
 =?us-ascii?Q?j5kslP/0r/EoeILYnOnRg1nj4uAyzNjbkl14VF/miXN/TyC42aAXFFSXcHrZ?=
 =?us-ascii?Q?ZPIBK3xGJa5Yv91n/wyOwMOX7G7Z/elC/B1Z+LkqxpWsFcOORvonckJH8Fl9?=
 =?us-ascii?Q?djfaR+NQBsrxejE3nWClxHbA3UjPb4sGM+BlfEWNqbRde+edKgDapVe+4A8d?=
 =?us-ascii?Q?cqe6kYY2J1d4lHlRrA4W/45molS8Hot9VLFp3UxuyAgyE+VbwltbSdK4iRe8?=
 =?us-ascii?Q?oL+/XvOPDp7Q64zm6jnZDsTPHV5PP+ZJKo1uib1jz4Z+QXJsH/mi64mfBtnU?=
 =?us-ascii?Q?CxnFIdliP7wr7xBf0UoyVIGir1dW6QklydEq0vur8sVfHGWODQXkPm9TiEEW?=
 =?us-ascii?Q?IWGJy1OMC/JLaifhODtaa83yCK2jaQdmaZgAvv75qu9oYp9S2C55Is30YmV1?=
 =?us-ascii?Q?D+Nfa3uS8s/jNYCS7wIr5pRJbr5XKN2jw4m3XorZe5v9DvB+uKXiVf207Rlv?=
 =?us-ascii?Q?gNwzBl3tiqEAXWOjC4C65NEI+B9oNmOl+mNjWLq3KpG+PdtY3IiXvtJ74zKO?=
 =?us-ascii?Q?kGmxf49gj9Gj5ysLB9w7jUDlCML+oYl4W63UaMCJf4nSn7xSTlrUxvzZchOo?=
 =?us-ascii?Q?aiNn3j1CvHf1L+x2LjGRerszrQkVl63/HmCBQuhWrcfzM3IQo3zOvdO0tEX7?=
 =?us-ascii?Q?9gze/FbyEp3j4fUvbkApQ8LotwmcroWk6YLSdazAX5eWCJNX/fDoSrs1cvgk?=
 =?us-ascii?Q?kEGCz49LJb0CK7ZRb8vUXOI3m7IY1HXzeA5EO/yF33lOIGHK8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:11:17.0656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057f5614-3275-4f45-3ce5-08dcf962114e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

If multiple platform profile handlers have been registered then when
setting a profile verify that all profile handlers support the requested
profile and set it to each handler.

If this fails for any given handler, revert all profile handlers back to
balanced and log an error into the kernel ring buffer.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 90cbc0de4d5bc..c2bb325ba531c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -99,6 +99,8 @@ static ssize_t platform_profile_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
+	struct platform_profile_handler *handler;
+	unsigned long choices;
 	int err, i;
 
 	/* Scan for a matching profile */
@@ -107,16 +109,29 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -EINVAL;
 
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
+		if (!platform_profile_is_registered())
 			return -ENODEV;
 
-		/* Check that platform supports this profile choice */
-		if (!test_bit(i, cur_profile->choices))
+		/* Check that all handlers support this profile choice */
+		choices = platform_profile_get_choices();
+		if (!test_bit(i, &choices))
 			return -EOPNOTSUPP;
 
-		err = cur_profile->profile_set(cur_profile, i);
-		if (err)
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			err = handler->profile_set(handler, i);
+			if (err) {
+				pr_err("Failed to set profile for handler %s\n", handler->name);
+				break;
+			}
+		}
+		if (err) {
+			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
+				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
+					pr_err("Failed to revert profile for handler %s\n",
+					       handler->name);
+			}
 			return err;
+		}
 	}
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-- 
2.43.0


