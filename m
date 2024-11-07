Return-Path: <linux-acpi+bounces-9395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1A9BFE0C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4281B23601
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72761DA0ED;
	Thu,  7 Nov 2024 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tTPxi6y9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78337197A7E;
	Thu,  7 Nov 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959429; cv=fail; b=e0kCdkgHFm2Decpq2mDzcgbixBVeakTIl4dEFp1pxqn1Oooa0Vi0Ov4iqTTRYtNDEoGIY1ynV1Hs2HnXq2RRBP+hQC+1LOvik/V6NF5rnE2i/gVOPCQvRgJs/cOgaf+kpHMQhyyjhZA7ePN0eOreleexi3tqQZ6AHLXiRgKo5k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959429; c=relaxed/simple;
	bh=QsAXOgS6tiGey7CpnUZrLRQVOLxqlxqGQKPNtyXWShM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4sbd+YOATcAppuZTXP8TuMyz5esmNQ3gE5ija3G43KNWdvcyD1sdEIf1aqSGx4WykUHfaUCjwiTLr2SqXnNQAaEKGiFgxFkHcwN/am4oSMB6lbhvW+mBw2F00EkCSDQW2VhpxmOXkrIxqlKl7JC7kQ9325hLdjHGMODRgIvDmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tTPxi6y9; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxgYpNE6fDFh4Tur2mCNxdDSYsox2v2wglHEbEIOtOrCMQ0BlHVB9X10ct+j+tZiQSplcTyVNLZOfK48FgweKx3vlS8BwIMoLcUHhRuuBIp+yGX7zshJfrPqQrauSpaC6XtYpOmymfDgJu8yMwkzqgMf3aBx5IWCUy+qHbkWXuunP/KH7SAD1aFQDG0/ZdAY5rP79mXA0splivmdu8L7e3oWfnlup2REMvytGKjmfaSEmN+f3obhoOJStZrs3tDbRSPhp2ZzVmV6WWNMThlEz0P5WuKWA4y7e+whY8v7lg93jjzULJAjrNRw8VzfRzaPpOO1oruv9Ontml+ZTulbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+458Bkc3jM9LeqcDeTMlbe5a/JNm3coZ7L9HhdhC4ko=;
 b=Nbb/ATORou7SS1R+7B59LBiB+y27GgOglyRbXO4/ySxZr0hQW4moJyjeP09+XpwDvAD/Swb5mY37gao/Yv/nS6vZpmrX9YwrtC2JfODnohdAIxcapvWIFq8/rVZlGV8+hxRQyjkZTMcg5KHu5ef8rrBBuY3XxRBA6hpFFQwRG0exE8c0D/fQ1KfSYxf4//+53CuLaBP6wSIcjb4TRNT+9cGyqjfKDOELw0Iwlk4By4yONwK7T94Oj76G96uC43rbtQMKbHgy3SAxvD8HZdR0HTwLunB0gDofzeQWMtBlWVY2P5NjOvo4D/7PDdRhXHqbUWk1fB6x7kXusy6MEYK6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+458Bkc3jM9LeqcDeTMlbe5a/JNm3coZ7L9HhdhC4ko=;
 b=tTPxi6y9zCgbwbNHtftWzP2bvyqsylAMaMDbTwcPcJRzHW0c5ELK6+02quMyh4wHYqR9ZcYe2RTcHXo0Yq3D+8xj51z7uRCrV5tqUZs1K2bRzKv0DdlZgCd4Af34b18XdkrV0AP44Qg47TPN/AoxSgK2iO044aEz4sNBalKNtkA=
Received: from CH5P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::19)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:03:43 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::4d) by CH5P222CA0007.outlook.office365.com
 (2603:10b6:610:1ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:41 -0600
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
Subject: [PATCH v5 10/20] ACPI: platform_profile: Add name attribute to class interface
Date: Thu, 7 Nov 2024 00:02:44 -0600
Message-ID: <20241107060254.17615-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d43da61-ea95-441d-e807-08dcfef1ef58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1FsL5X7vfE1teHQYcy4i2BkLeFd+3KD+zg0ocyRpsy3mr+r0fhADn9hXUkXJ?=
 =?us-ascii?Q?TFk11yLKWCyd7ru+ZYumKu1UDW8BzO+XrrOt9zm77POC1fPhWGCVTtzMs5GO?=
 =?us-ascii?Q?/eKFCwdIFazABA4xKNZWqdG8x/g/2DsigOrIuUNtRWP9VtwGtsI6c6HWYiHn?=
 =?us-ascii?Q?UeemWMrS13xaogxmJq48+GFu1OHhTgNdx2jeEDexsa8unMMmhoFXgEmbuHfM?=
 =?us-ascii?Q?b86PDqjrWPbOB8TejOKpURvDmh4NxXOPXXex9NzihvsbH9Av8gCYRZXaSrIR?=
 =?us-ascii?Q?fFxaaDbmV7utuom5rS138IhT2a1KLR5rJVDPv5HdZdffOKU2TJFdvFLOde1s?=
 =?us-ascii?Q?f5cD+yO3t0xlSSlQeJJfbMe9T4Riu/uE7nYKO9xhwWUuwNsMdG4RXc+C2hfY?=
 =?us-ascii?Q?TlJW5cZB3yvDVfSCZDcAbfoFSB0X+kz/kvwRm9UuyZA9Kimp+ncbXd8Gsxiw?=
 =?us-ascii?Q?3CZSUFPJXX9NgbbMml+9bMqbfCHr8hL3dWI2djFuYoCGLKVfjegLelbcPNFn?=
 =?us-ascii?Q?Y5uY5gaAjdILLmM2PJghixtPMW2KiN/1ERMEoG6QJouf06OC9A+BiC21/QY1?=
 =?us-ascii?Q?S2X7Y4+t52QY4vqGTfag4tSQopEJIj46LqWSnAkvEKOzgXtdvVkyZFkp4bmC?=
 =?us-ascii?Q?uhqtvcZtX7iGpgvC+WtIyHklyE3HPNeVJxo/GVlEHbTKz6sI+GKyDN7K9h4j?=
 =?us-ascii?Q?GfkDnaPScW+ip1JfAMss0vSKbYl2r51Ki0tOqaSxDX3HH4B3if04lmvMmjic?=
 =?us-ascii?Q?3F7Xpe4Poq0ww8f63D+16P4xCi5G+uH9iXOYAnUU/LXCmxwcU4tND2WkqIjF?=
 =?us-ascii?Q?xFKEFF4xfdjhT86l0MdUlCxZEAGaLlWYUWDw40kL6SKPSHdxcT7YZ++PlwrN?=
 =?us-ascii?Q?Lv+KFhrYClmRE17pxqUiJM+mPeim3VAP7p60CFa+3Li1RlRqWtaaumni5fHO?=
 =?us-ascii?Q?AK9w9S0loxn4gNTwCaw/qCgr4QfI+5gKvoW0SvWGHrRuSOhYD5wSnMCjcGUO?=
 =?us-ascii?Q?u0CMMyW1XB3td8DXLa9LeYVYah+qNVSYh5PH3D8xE+PCE7TIsyvaAXl9N/0B?=
 =?us-ascii?Q?VLmE7gf1MRWSAv1W+OAntDEJbqaXIV7xntAF8Ibb50RJcqv61UckrvpWwmv0?=
 =?us-ascii?Q?KafjoaUlHa0KyqiUYieD/wVl3qt/1J1SR2pnWPenuPCeCvUuEh8o9iPhCI7d?=
 =?us-ascii?Q?YZnKox2zCzW73vQ6Yqje3iT3SriHDZ1gWxXGhS3JvX6nNcvLiQzvni1rId7V?=
 =?us-ascii?Q?DBB2r4Lam4REBZq5uDUTJAH5PfpdUOSP5mYOiGF1/Xi2JqCImkjCp272VT7n?=
 =?us-ascii?Q?B7KnPACcsMQdCbCbSfgq0JksMxc+34yaOmSc4TLrblSMHq0R6CRTI9fVNuUW?=
 =?us-ascii?Q?akyBIhhgvITb/A4a4///qtrWmhQ09kuVUfCEzGZptXIIZEo+Cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:43.4359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d43da61-ea95-441d-e807-08dcfef1ef58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

The name attribute shows the name of the associated platform profile
handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Drop newline
 * Add mutex for sysfs access
---
 drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9caf070f77f6a..f605c2bd35c68 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,8 +25,35 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * name_show - Show the name of the profile handler
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+		return sysfs_emit(buf, "%s\n", handler->name);
+	}
+	return -ERESTARTSYS;
+}
+
+static DEVICE_ATTR_RO(name);
+static struct attribute *profile_attrs[] = {
+	&dev_attr_name.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(profile);
+
 static const struct class platform_profile_class = {
 	.name = "platform-profile",
+	.dev_groups = profile_groups,
 };
 
 static ssize_t platform_profile_choices_show(struct device *dev,
-- 
2.43.0


