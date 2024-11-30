Return-Path: <linux-acpi+bounces-9815-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFED9DF0DE
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A3A1641A1
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58B01AB6FB;
	Sat, 30 Nov 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2h4Pulvg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AF19F41C;
	Sat, 30 Nov 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975558; cv=fail; b=u+YFOorsDr7pMA0wrUZsUerYWXvj1ktkbQg/ktY3H82aigXBCLBrQqFbEQRko2JmvDrNkOFyoy6dcFN1eN1zr4CVqt9ZRcdjIpAZCbRxvdyUopZ9KREh0IrNh1KCMb4g21vD1Plh7uEOSSJ11IGDX2DijCtJh+AFlgcL6eefvs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975558; c=relaxed/simple;
	bh=FivEVQiSvcrqfbiILyAdo9Dr0Eh5WgZGDz8iwEejHcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGS/Y7yVcATUPB/aCs/ox/YUGYZtBSjggdZXbADXJDGKX+hOza8uBK3RAk/ue1Qlc0Ei98phFZUxM/3xnREsTOr4rGIbSX/EBmzCJ9xtoyASeQ2m3JK7rA58Dk5OzxZC2vzZft4VCSlYNZsW98Cdf+f37kTUhlIoO2OxgJuu91I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2h4Pulvg; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4DKLL8hwUk0JyI1+lgSTampWNMMHdoCgRczbscggSd8UQcfDZ50cXaTBabFYFwrRhBEPlVXvHLw/2P9h3wjGdrXSIwID04SyYYF+ScTd9o/fVp3q4+k3VthgCW28tHgq5iSMxaCyUYJ30lScSd0hqvgMSPkk1mCJMY2Yph7KEEh64rSJIlrHJuyXyM2PGelkuxIVOGNoFWKzSC27VODzZRdQxAYnpRPCRzMJ8DN1mNNSk+bnYM60oI3hC2sH8gS9Cu+gNhOGg1Pt3Fdhkr70LS/+qkbteflqoHlQ9FBTIcU9HhffFqSg1vKdKtadoEHeTUA1OSAXUv+tN+3QjDy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6Uyj5RLLZRUpnauTTNAsnw7YZmXfOqC4zYTLtxs1rI=;
 b=W08PyN0TrDIRP7s0Udm5lTqO7dyK3idz/cgoIhMzKlbbqS3iLy4dspoU3V9F0eX0dVB+yahq7wtpXkQl6JEZ/3dw+4bqhGE2yM8Gwtgw83F1n9vZL0kM41XQFdAh3ocTOo/61qYt/BVX9f2Q8Yzrfd0IYEu4hIFJ4ZllFXcDETBgIZJzfRkKvNyjteUNmB2qTb8KdziALB8G+8yLPCKF59ulADFi45EymyK1NJkR6jw7t5tLn37WDbCU5ASboOxKvoLpLXyZW6LS6ZA6oNleSo2U7tBY8ZfdbUshBUGKtV2p/QW2de9DCmm0G1sQyXtmSvvGuO8PbL78gONlMHxZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Uyj5RLLZRUpnauTTNAsnw7YZmXfOqC4zYTLtxs1rI=;
 b=2h4PulvgNDzUKyuCYFfF7NzC43TRL11oFZ32OuWec/dz/ks/qMOAvij5Vm6FlQpMcvwbnBDOXY98vDGZ0wMuOEGswydBIlF1tQ3hY0W/x3N8GHM8JXpArcaK6guE0Qu0nUga4/p3Cs4noerwO9w++fSnnpK8Tcy1ZrGS+UUVdgA=
Received: from PH0PR07CA0041.namprd07.prod.outlook.com (2603:10b6:510:e::16)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:52 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::3a) by PH0PR07CA0041.outlook.office365.com
 (2603:10b6:510:e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Sat,
 30 Nov 2024 14:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:51 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:49 -0600
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
Subject: [PATCH v8 15/22] ACPI: platform_profile: Only show profiles common for all handlers
Date: Sat, 30 Nov 2024 08:04:47 -0600
Message-ID: <20241130140454.455-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa4fe9f-bfc5-4116-4bab-08dd11481967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A41QvsaugtCQ6sLJa777RMWP4yK0uKwIf22f0FaXGYqoz/T+0ZzNRg/MjFIo?=
 =?us-ascii?Q?vYUgUUqzYRAKFfObPgeuh1Zm2QlF27m0Cfn4i9B85VbHXZvHqR0Ohcv2yf0/?=
 =?us-ascii?Q?FTfrvif/dLxIQulTfKTwZP8uU8WNEdyD6ss2wyZZ9TSwylyoDPGeS61SZaL1?=
 =?us-ascii?Q?rvu6pVKHbg0UekU4tv1tVwUHRyMYVOtB/JM4q6yQUeIapCTYDAfRae4RkHQF?=
 =?us-ascii?Q?zlKQR3fd1H8RL5s6L6d9Vl/Mp6hCZWsU9F6uMUxyqY03HOF5EdzKVd5aSAaD?=
 =?us-ascii?Q?4+4WOdqUB7YCN0He2omGhCUUEv3751fRPTZRV8tv9eLuBPvDEOsJxwDPayI4?=
 =?us-ascii?Q?zmw/EjRns2NooKOgHUvs7aWoeyHrbgvoCqpmGvgeRQ5VgjRXm15wfcmN8C/X?=
 =?us-ascii?Q?g6MdWRHWPIOfXK7ulPzlblwhIwtgrtRljiTGnESVpolzp/XEiGaoB/W2AQgW?=
 =?us-ascii?Q?RD7UEniOCIaZ5R4j7eWt3zH6PkhJ+/GIvnPs7xUGOVq9RPZFKxcu0WHAfyyK?=
 =?us-ascii?Q?zRCZ6DzPoAmYl2LTL4G0fym3GIE+uBleKMZwMMgG7oX3K29VKSyc57nqJj09?=
 =?us-ascii?Q?TDLlP7kctf3uEDVzmjh7Yz96mm/TrZIxHsTRbk8b8dFBWjCrxUjbNEznb/Rs?=
 =?us-ascii?Q?gDwohgtoq3oZ3DE9XX6R0St4g63R5yTA+nq2FIL1IXOEjO9B6cnd77aR5vTW?=
 =?us-ascii?Q?aUIzKCi4xkioO7I0BI460tR69zjF+Pkv/wJWVtR2Y3dT3qW78XaQzggz+bS2?=
 =?us-ascii?Q?y6K13XO6A8G/UrhwImT9dytd1VdGlt2DHGOMWUWKCQWk+HT59IXAPPrk5N4H?=
 =?us-ascii?Q?+gimRglMFwAuf1rdZ3+ic45I456CRYkIi/uKIsG7W+IrmdmBsev86oY2IFwO?=
 =?us-ascii?Q?3dU1j99UklMXaiRaOzfLtho0x3oBmmO9ZuxhY5/2g9SplVqav69b6zpCG3vp?=
 =?us-ascii?Q?NXe+Kqoc6Ikoyw6tMEIlC7ZG9MBxTSIJV39VnTtLLT+uU5ifhmd9tevNF7u2?=
 =?us-ascii?Q?YFJMyphfKXoCC0DrGnLMQcko+YRi7s4AyGRXtBA3SGIwn6+bH2uAw4jgmrKK?=
 =?us-ascii?Q?6HOqXnK3kL1Q2LcYBgODOuXg+Y1u5ycqDTwK1K2DHmnxlzN6CcaFAJ4s/iNn?=
 =?us-ascii?Q?nf/9l4zPRYFMdXgFlc6peVH2wE3Ec6eB9h4jGqKSsS+zWK9Tndr7BSnDGDO1?=
 =?us-ascii?Q?lM0ywl5YuMriav7n8COmmCjb7IqQnYnYJ2Ztcvd/s8xi1R4sC/K3amoxUtA1?=
 =?us-ascii?Q?LY4RwdUCTx5V6WQASQiXcs2PMux3outxluz99Nm5Fe+yhNqLs8thKKwX2L6U?=
 =?us-ascii?Q?p/Wu+LbFB0kvqg/4TVrG6O/EOCLDPnwpTH4oTqyBqeYadnSEGVTd9J2q8SYO?=
 =?us-ascii?Q?w2PW0OPBrYAt20shO4mvEV81Q/eCdIGXVL03ovk8pU+9+I27ocjMFzCIybnU?=
 =?us-ascii?Q?2qjt1RD1X9HcY/+nKejI7WgKDZYxk9/v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:51.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa4fe9f-bfc5-4116-4bab-08dd11481967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 56 ++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index e93b79f654955..40826876006b5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -195,26 +195,54 @@ static const struct class platform_profile_class = {
 	.dev_groups = profile_groups,
 };
 
+/**
+ * _aggregate_choices - Aggregate the available profile choices
+ * @dev: The device
+ * @data: The available profile choices
+ * Return: 0 on success, -errno on failure
+ */
+static int _aggregate_choices(struct device *dev, void *data)
+{
+	struct platform_profile_handler *handler;
+	unsigned long *aggregate = data;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
+		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
+	else
+		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
+
+	return 0;
+}
+
+/**
+ * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
 static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+					     struct device_attribute *attr,
+					     char *buf)
 {
-	int len = 0;
-	int i;
+	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	int err;
 
+	set_bit(PLATFORM_PROFILE_LAST, aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-			if (len == 0)
-				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-			else
-				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
-		}
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    aggregate, _aggregate_choices);
+		if (err)
+			return err;
 	}
-	len += sysfs_emit_at(buf, len, "\n");
 
-	return len;
+	/* no profile handler registered any more */
+	if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
+		return -EINVAL;
+
+	return _commmon_choices_show(aggregate, buf);
 }
 
 static ssize_t platform_profile_show(struct device *dev,
-- 
2.43.0


