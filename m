Return-Path: <linux-acpi+bounces-9864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CEA9DFA80
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB7B163231
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D41FC10A;
	Mon,  2 Dec 2024 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OcNwqa4x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DF1F9432;
	Mon,  2 Dec 2024 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118730; cv=fail; b=LJevqeavXZ7mhDS2h8800E1qrD6UHCeMiXsQx/f+A+7H/A5vfYCBMfQ9u+WXLykvY41zNVQfJ2qp/cGM3wipWTgGPmzcI8Pi+gQvS/uQ+V/uZHWhMJ+HbN3+97NyJzllysfspx6ZgOfu0IH75eusU7ashUxDnXwwHMX5mueGyqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118730; c=relaxed/simple;
	bh=Q9avaHbOthdc41LgOEuzAOMf3jR41UX86Qe6lJzXjYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcyfCnAVXoMC98CQPbrAvj5OuW5jq0gwSZAAvRM9kPFa+/Y9ii9KMTgKQe1jakNKN4WuCBWf7AFsNqjNFbnr+kdd0iTFNAz+dviPAyeFnX1m3HnERebzKqw444FpgghHu1EzG3mwQpwpABP5iZjkCQbfjbYU5rtr1obRCA+5LWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OcNwqa4x; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSymC3m2ozuQLxcRh0qpiHBQYw5vTp4qbvV+k1zVELGymzoQUEfcZ+y7Yq74E8qBbv4m2+/UbDkwttuicnqSoi64hIq8ENAWHSy1ftBm8IxZLBYg+76QNsWbGC0Lc0K+kjIgF49imtFfPAre9eqMUPi4EbfzYz6iAfdNfOH4QpfzO6eW3bOspcYzd66fZEU87/FZeMqJBZki8zACXBzHeey49ZnsskE7PyQFQ2UCJO0c7vXPpZFOY/9IZT4P/AaVuB/RKR8f7CagJ9F6eZhJnJyYNRG5gSkn72DucAFh3cx9BGW245QPDn1BfyYJRAogc51Y5a9wF9JhTHxi1TPtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhPbuhl5p8r1g6n/pTVVP/pO7JKpLp1XJelDnHFGo9k=;
 b=byxSge8amZNidXpeNQgI/1nm/oiKBzSNQBvTsNyJk49ThAwxTNMiFbOYhDeNFnYaeL3uBqz/aZllnCiKdqBDq/CNfnuIHk1BCsNhYW6kqvEAJEOh97opbKRANPeSAcnCxeSlZ6OF+NP3HactgPDfeo8Wf786FNCmOVLHsMGfEro8nkIrwW5WJyER5zSaxSRp7r7qKKCzPn/jbvvP8IHNc2iLvx9oORhoI1fBNgCp6GPV5bXWcKO6lyZzYjv2Z5/1pfO49oLROb76mfMWxPfVO2ZSdhtXteqbcNEjbe6wKZ8P8qfse8EuU9eNG2jWN7RstyfxKN8lMi6UiKFu9gJBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhPbuhl5p8r1g6n/pTVVP/pO7JKpLp1XJelDnHFGo9k=;
 b=OcNwqa4xYDLU4NNeUyG8w+gS456VoAxO/4+LokDWjXwaai5NssvQinWv81Bt1mywGsENUJ1yCugM4+HTrF+GDGvBj+5171v94OXcFEsdq9BMMat/6rMQxqixi21flNRknOGB87+6CfNi3nHQJcqKCj1ZsO7SN6CAtbzVrcjNXbY=
Received: from CH5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:610:1f0::20)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:52:04 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::e3) by CH5PR05CA0015.outlook.office365.com
 (2603:10b6:610:1f0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 05:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:52:03 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:52:01 -0600
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
Subject: [PATCH v9 19/22] ACPI: platform_profile: Notify class device from platform_profile_notify()
Date: Sun, 1 Dec 2024 23:50:28 -0600
Message-ID: <20241202055031.8038-20-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 816dea74-65e7-4790-7056-08dd129572b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VAYRfaJA4L6OniAokknEPiamWLpFwV9rJhwfAXFRQhejJxfNZnQjRYSYLbG?=
 =?us-ascii?Q?INsyfnPMmG/ucBT4P8oGKqf07mZUQS7FxyS0L9iRd4C8raOcdARdQkLVoiOE?=
 =?us-ascii?Q?jiw+kF+3jhwtR1s+TkMpGJ8MVz0SN2hGbTG2PieCojyKrmnVQisfgWhgb0IK?=
 =?us-ascii?Q?QBum1IpSFIYTSOQvPwZONJFyvlHZhbQl/o+7lFs8CGKVW9ZqmFZyhRA8Gy5X?=
 =?us-ascii?Q?xMKE3DofiG2uvFu3Z6iEb4wHuUm8XmqLKEisfs0rECfJOrzQFuTP7gJLUka5?=
 =?us-ascii?Q?Esl5zCKpaFPfVQlOHPGmCuZJmQaGIA3ZZUTHgsv8xRSfuZmZqDld3G8dLKnr?=
 =?us-ascii?Q?MxlZWlgDp3VrwJtGmoKQbd6TNf2RMngeh5lDpAf9V4LYZkZGHxnbCAqfyije?=
 =?us-ascii?Q?GXBc6kIMvH+VFPfoyZDJuFTQs6wWgX4w9a2vnnftWeBjSyxvvPwwJLwsXEYA?=
 =?us-ascii?Q?2YtunnFmfm4ybMqq9hVhXsle5LXZ916fjfCM9D8+akS5uQzuWy4U5kgbYLNx?=
 =?us-ascii?Q?BeLjDlALvvy/hJ/IJT2eVXgwNNITdrtcGFahuuzwdVr+zQU1A3PgVG5SiQuS?=
 =?us-ascii?Q?Fmt3kkBkzuiNhlQdsAdI2paz56uFZp7+UQ9xoH0vckcYM6yFpTPJgFkFsr6O?=
 =?us-ascii?Q?yUntnLmImfYpWqtf4jgFmc1h4v3IhbqBD8ULD27mWuWvJvfQKT1o5TlziWb+?=
 =?us-ascii?Q?gS3VFTwPki2vC22wFboouvoGnVFC05j9ReCwfwF6/BRQYYSLCqUV9zr+WfVg?=
 =?us-ascii?Q?bt9foqewmAuawXlRbARRdoyipYQZIhtW/HXJ+Uakr3YF8gSaQbuJqrz9Ow5F?=
 =?us-ascii?Q?nL8U/+O4eVeWBx0ZIriXrseoCmhCGFl3nbO4uMEhnHnSay1R6btviJrZ4DDG?=
 =?us-ascii?Q?QqV1bRR2IVSi007ktS80gg5mQH3vwUMROj+7i8sLI20Bf+bNS/ahdAkVzo+0?=
 =?us-ascii?Q?/vXyRBkyTRIu4BwPTtIaS/VrhGux0eG55SiTpSi2M5WxVnjJb7GuJl1V164r?=
 =?us-ascii?Q?Ro86OQnduKKaXcf3CP5FD1qSwgi6qaqWDDsVXHBZ2aiiLwCZwnNWc+Jv7x7w?=
 =?us-ascii?Q?vFK6qU6yqsuIKLCN08hg5VdM5CqWnyL3fRFb0sc7VbVEIKp5df7ok1T4gt1V?=
 =?us-ascii?Q?21zfrNMlU9QLZa0Kqll6wEM4a5n7HYPYI1ubUGLJ17TFLazi9LXYdyrfGXFi?=
 =?us-ascii?Q?sjQd+vnE2FJLOf5BbqyLsv17C8XsVl+1BTQPNG2s/9R91C/vNIPMP9oeu0zN?=
 =?us-ascii?Q?OC9RMDjsKKZSI60uhtfXOAtz6RJWBDhbFxe3e1ylkeMrM/xsqX2p6T8QrciV?=
 =?us-ascii?Q?b55h7QivmVgQlgmtKvvExbAtQhiYm984eRQkKlV1832fIj9aR9r0ZI14LZCk?=
 =?us-ascii?Q?AEvB3B00RN35XFVi0OeGTBGC0QAzuDiXWYQhFTRBRbMMNPnrAI1PskoNGH12?=
 =?us-ascii?Q?5MBWD55dqpQxLH1v1teTG3tMhkS8XiLs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:52:03.9879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816dea74-65e7-4790-7056-08dd129572b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807

When a driver has called platform_profile_notify() both the legacy sysfs
interface and the class device should be notified as userspace may listen
to either.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 * notify only one dev
---
 drivers/acpi/platform_profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 16746d9b9aa7c..289b5d43638ae 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -401,6 +401,9 @@ void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	if (!cur_profile)
 		return;
+	scoped_cond_guard(mutex_intr, return, &profile_lock) {
+		_notify_class_profile(pprof->class_dev, NULL);
+	}
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
-- 
2.43.0


