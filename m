Return-Path: <linux-acpi+bounces-9681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD49D2D13
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A64B28E48
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A61D90A1;
	Tue, 19 Nov 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uio2uQA7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F01D1F76;
	Tue, 19 Nov 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036890; cv=fail; b=pHykVmgG4bA6ZQQQZqowpEGxXg1hOdvAHAcC6uFnHmTMPltfrPpsZruirXBVmygdssOUb0xRNKWGOrgeiuXOvdcHpTqJm8a5dXdyCoUfVL5PIi3QANfRTDw9cOJfGZD3SB+SszRILMRTqJzmrodsO4ii4uxe7NYe+capr1kOwpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036890; c=relaxed/simple;
	bh=2rt6Y87tQPRlcT8Df+nkb4/NaZ8Whknr1aC5eHRa6yI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MH130yhA7ZgfCCrL9tMvwcf4Eum/kSVT+h//ak891HU/ZpTt/1bZ4jnVD0njAEYksxNY5TerNQRbc5JZZpuCCzuEvY8cHpOvtdZL3nkQDDiJB8BtbP1Pb00L6UEn4ULjeexI5sAXWXOdew2Hvis27SJs4PGxCsmFrfD+wAud09I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uio2uQA7; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8KnARZzceNsJKH0B0XiFxo382Tj/n4vdQhf1vqXSr/7tns+i6NJK8CnP90V0S8CZtYyPGvjJxeVnpzWR8JxlwFBkFbgJXsRkNEVHvahE8nd1Ujt+z0j/gHwH5deIKzcKa32qYsrHpzbFDViwbVuSX4+Z+xle4qyaXL7PdKz65wY+gMOUwX42qlqR+l5aafP9wdGSoxw32ne16zXsnTKPfUZXdn75uNL16/3zVFxW12aZLmXG7hSdN9B2Vkl2n3Sac/25/lHljFRHc/6gTCJ+DVirWOMUaF8BzzmtLfgLljQfhVwLjdh+OrXbvEJ9Rbcyu+gvU9kg4dMNNMWAHJ++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJyqyRORx3PN3Q7CjJn9UtLhUkcMdMZ1mFaWGk31Er0=;
 b=P8oo+Ntmk6CfFMKHicLqylx8XZ2t8C5c0aWyeoHEG/Mqi5gpzsITCqt+6OsZw9GXltEg4RN7Lzb04MIA8Q+vluFSj+oyag8eueNgQTa5bFhuFRo58ch5XQTvOIlyS03aVUXLxoMPjNhqA2Lb14ALHXtgrMOR62S7CqU0rKXtHToiQVH3GedF1Zvst8mDtBB3UoYkfGFd//VlTSEPa177MKV7SiUizYTxrfxPzHQFTWzxayMpJ0SRUxFqlNaBQvh36svRCUNMa9yJ4si0RzTy92Xdj3jZ6XuU8cUBMc+QER0NpOn8tzCGpC8+IJsjuzNyU/rv0cSnpiA88MRXlS4OFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJyqyRORx3PN3Q7CjJn9UtLhUkcMdMZ1mFaWGk31Er0=;
 b=Uio2uQA7S2C9gacRfv+zby0M6texHqmWjJsgM8iOj8Ww3gCnb1TbCGjAArArZ4CiiPE4raYI9S4D9tUr65Yrbc8z/fvb24gc6gHqbLWyikc7fzqxQmJppKcr5i6h4Qc+YX4ZUs0mfwTmo7pJZidiPVtUhCZx/l5AFhKHSPTUalc=
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 17:21:24 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::20) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:23 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:21 -0600
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
Subject: [PATCH v7 15/22] ACPI: platform_profile: Only show profiles common for all handlers
Date: Tue, 19 Nov 2024 11:17:32 -0600
Message-ID: <20241119171739.77028-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: d45d398b-cfb5-4904-76cc-08dd08be97e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0zpy2WirGQ5U6D9OMg3/cYB3A01A9pezztk0G82lzh2Nu6PncKt6pdritQOr?=
 =?us-ascii?Q?hngnwBNkZlHxiamqBSd5icBRUL6EpW8VP8fzNRcpoOcegKfq+Lpz7jotIgno?=
 =?us-ascii?Q?5M/qD8cH/nZGquYVn4x1RPqwd0RaC23DT8r8l8LEz2Wb6XmDVAZLiBTMJtzZ?=
 =?us-ascii?Q?ilW8TWVi2TWVg52/ydZ9J/C6Qf0R1PtYIcrYqaEwi/8x0oGEi84YrxeUoZc1?=
 =?us-ascii?Q?CSiHdFoZVL1etac0mB/oMguDsAXtVa1V1uWDeUTBVzJHsmvGox8PaEM9AWZp?=
 =?us-ascii?Q?4KlCsa+TS/wc/BwlYt4wwfeF0rjxSV48XcHdVQ9+1ptt0MEbyNnwiS5Amc85?=
 =?us-ascii?Q?L6Abbm0IOvitBz6+xMxGabS4+7qBd9wOm9cWks1K306tj+E2/CZds0Zua06f?=
 =?us-ascii?Q?khklxFKEjDT0gYOTVSiB57PK4YF4mmlXScK78XE7w3/coz9TFQFTMaIfLSzL?=
 =?us-ascii?Q?Vg4D29SIZhDsxtw2K/qDWVAwKVPIhNJY42IUL2xMxXjL83pRQOQs8YR3vTic?=
 =?us-ascii?Q?Z4j0Nl7PNhfGTYdLS6JfoXBIyAVINKRYOxzB5oVsxZdn7+rn0m401HFY0Pja?=
 =?us-ascii?Q?CFCgSO9xOc5rFqLG2FXMgfC4ItUBwU1gwVVb8ItUt2tzLFukpisCWSNDuB+r?=
 =?us-ascii?Q?KCdC6/6h2F2uv80wHXOBXCQv9lL9kTb8fS7nbM2NSr4MSzZrnL+GS8iQteh8?=
 =?us-ascii?Q?2c8uJRs0TKJIDQ++u2MPQMENaOH5yONJyuN909+MboVWCMl89FWdGUhE2DGY?=
 =?us-ascii?Q?HVwaX4E2nneFjBHWIGexleTQiFIfFCbe2NMwB9mpbd5K9YtYjupX/uVNSRLg?=
 =?us-ascii?Q?yEeAeJV1dg0aZYuc+z7dFXeWhtFsUzMvXX1+E3LuUben0P7qoHLrMYzZECva?=
 =?us-ascii?Q?HxAa8I9QzZX9YgHlttOg3ovsV4sIOk5WWcPr175ZLbnC9BP0Qm0tJeRteCXd?=
 =?us-ascii?Q?DrEBMgZvXWb/NAKhUO0gIa+X3XyRaF7zEf3CR8by/6pTgehvmQBC7EN71b2Y?=
 =?us-ascii?Q?qaJv1fWM9+qdKe6KTnRQEXw26HhUqXP75momhEw59762CIWkCymtR0LYKQNm?=
 =?us-ascii?Q?6FG/gAB2P4dfqNib9hZrDaLioeWvKf0oxU0gMjy2S3jiRYvukHiL0E3reCEv?=
 =?us-ascii?Q?CBEk603z8hMbf1hzS5x9ejpQqO3ygXLnYqvn9tPbAs8oyNS8MYZgm3f5Pqir?=
 =?us-ascii?Q?MG/WtrTv0fGbEKRxeRMeNH6SoqXQ0fQ0YRzVPOajiB//hgV8UMm0m1QbJiRj?=
 =?us-ascii?Q?tvW+9L6dm0KcTVvdb1zn+x2NQD6yTlgRzLnqot6pr8J6wW3+8tvzw1NV5r5b?=
 =?us-ascii?Q?t/I4zqY4/Ex6BX5smae8OpAUMYrVsIrjeHHDUKukNCJxToJB9njN0woCRRdg?=
 =?us-ascii?Q?CtEeXrQczIiA7QTmWs4FiSU4JVdN00lTcC81TRcsTtDTY1RlLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:23.9562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45d398b-cfb5-4904-76cc-08dd08be97e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Add Armin's tag
v5:
 * adjust mutex use
---
 drivers/acpi/platform_profile.c | 56 ++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index de0804305b02c..db2daab5b2a44 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -192,26 +192,54 @@ static const struct class platform_profile_class = {
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


