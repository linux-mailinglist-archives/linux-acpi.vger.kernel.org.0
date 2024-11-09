Return-Path: <linux-acpi+bounces-9473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87189C2A05
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9660F280D5D
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FB17838C;
	Sat,  9 Nov 2024 04:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JZDBIXBc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FA13E043;
	Sat,  9 Nov 2024 04:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127376; cv=fail; b=Tk1/jBBYMsgVilpnv6Yqby2GEJ8uwMpA1/aSVWa+qWtfD3Zv2LYxCVw5YuYnFinlAujEJmKkMnrKUA52lpWKWmWqQKHdt1ecn8hqLDDPJzdfImLUDP836PZkmg2zacZl+n+Pu355Zm3l2PadKgl11wSO0mUv+pXO2kP5ujPGz6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127376; c=relaxed/simple;
	bh=C+p2hzq4u4uIsrCC4IXSD1x5HQQJ03WNBhXnryrH2eQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZCaCbVL1hNEo8ZsXYtbbuSFpEC/dcKVe4Rfh7AuF0s3ThyqDgHa3ps0kjjWimWOubX7JXPPJP9LDtdWVhap5Cj+kpd7nUbsGACYx6MrUW4baoCi68hSrwrVcwbQsdfo6szZbnvN/gjG3eyoMIC+W11K4ewGBbxFsen0oLYli4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JZDBIXBc; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJo6r0vIjGGm9Nd1JmBzMQs397MkQqfDA1PS+2JbvHwPsrpko5Yn2aknSjdOMDyXiRzinKgjoZHYAYTx/KYq7g14FMYU8hsbmR8Cna+AV6ey7dZjidhS6lhdKVcBrUYMw81m9d6WseOjztZmNG81TZer7mpCr4g9e4l8spOsFYfSBY8u27EtOZqrh6fhk5IiKF2oJnYHmP9cfvWzXp996KpdOtJUUB+2wk9b4j90F7gh1bkVafFrFfWXY1V+V6L2f2VG5tjuneAXrv/8v+beH4it43DlPnjZgUOSSEzv+agWJX/wRtG5FkgQP5s0tZh7WD3qqNeIY7oM1yfXSqmqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g81IshNh8Mcuu+0a63QTns1Nusp4GpGpjTLC6h9atmE=;
 b=bmo4Evp9Tqa2ZEZ3WKGIudv03eClETDXKiKfzJXlVh7DAehQS3A2hgsHncbBpnH120f9kbQ6SP/TpxgmeVM6IdHqODdg9gMERc3zNFdpVF5Leg3D75igh1fYUYojHPGUpnfRx4977TzHXVHMNFK+9QitJ41X4OYZ1LJi3S7cbTn5GuP7XE1/zE9BJ6+rl0HLIkPmvgr+j+hT9Jb9CJzFOlq+jDSgr4qDqPupsB8Q37qLn4/2lVaINS7WjwgDLPiTUsO4FE1I/h5YlCGWK0CcLiAvrLwTEkluR2KH9iaZtpWzDIoO3telzl1ojv5rU3eJ0cEBDUszQ+WxuMVVdgTtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g81IshNh8Mcuu+0a63QTns1Nusp4GpGpjTLC6h9atmE=;
 b=JZDBIXBcO3T4v/osnzudp1FWL0iiBD5MZK9vIcvYLigqwfMD0CK5CUPFmyoBFEop/JT5WIPEF3idw3PY4gjPiZB59mWPzvf0MgM5haTFqYbb3dmZtzKEN2w/zl9hhNkssnfgQaSkcbnPgRIasyfYmUGWwPn73mABkHEbz1UaVWw=
Received: from SN6PR04CA0087.namprd04.prod.outlook.com (2603:10b6:805:f2::28)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Sat, 9 Nov
 2024 04:42:50 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::71) by SN6PR04CA0087.outlook.office365.com
 (2603:10b6:805:f2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:48 -0600
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
Subject: [PATCH v6 15/22] ACPI: platform_profile: Only show profiles common for all handlers
Date: Fri, 8 Nov 2024 22:41:44 -0600
Message-ID: <20241109044151.29804-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: b42df97f-595e-493d-4f41-08dd0078f73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WG17Tc7nRUTrj0m+Z8HZWOlURUCJQPIMbc2YxOgbcXC7hClcwEliChI3cTMS?=
 =?us-ascii?Q?ooEHR0XHGZUfp1w4vyMTCBQ+PCSVssTvTvErVOj7Ji3w9GDQ3rL/DjRkRheU?=
 =?us-ascii?Q?VsX3n/YYSvVUiYI90VJyvE1Icmhqhpyb2gANw+pR870Okd4G4Ha5IlOx6Qzm?=
 =?us-ascii?Q?HTPHbIJ/cftcODvKVqvS2SbiMHemtJ8yiG013nh2NF1V0AKljBVDCzbdMkNh?=
 =?us-ascii?Q?mJDBv8rxf6kYgT57qwlVbywGmDKLbGW5idk1XnDFECInqLi+MZKHMqAD6/xa?=
 =?us-ascii?Q?IBMe/Ap/NIsd8MzkTwPQlZzuKbFs+6/hC35Xstd5Kfay9HKpXRBsyKmPdUYJ?=
 =?us-ascii?Q?/08wKMxiulK2/xVJjKnn2v/i09uRQiwt6Ik+ZL5pVqcfUN1Khx9JK1Tdlvtw?=
 =?us-ascii?Q?HkxKuIy3j0N3AGsLAYtDTxq9xpe6wsLoVfZugJgnSpi/xzh2Ga1Eg7kVHzC9?=
 =?us-ascii?Q?FQ0z+VakVqHUt0FlkDUU4Nk2bclg6fVLJNh7GKeeWUmKJIW51J4lm7We7gAn?=
 =?us-ascii?Q?UNZJ14t1vK6yfPrh44GvL1PTlBVt9CfXwF53dcWTSa+2rGEsM1p+RL9XvGjf?=
 =?us-ascii?Q?s+YcRmYUyKgC7MiGtXXg/tCGFjPSUttKdrNSBm18fDPWN0KMYtYC49V/r9+9?=
 =?us-ascii?Q?HS5myoKBST1ktaZouxz6q7pDYcIeGmbQOEAm00td8Wra45QEUbvt2QxBr+R0?=
 =?us-ascii?Q?bCKD2ojnyF5sv5r+3XhhHJvDG5+QI3JyFxmJK/S5P8XS6MY8tcbly7J9zxPQ?=
 =?us-ascii?Q?ScWpnltf3IdgIGLqI4ixEDHuR4ZldJpL2WTkq14i+PiXC2/qyLhP4tE6Xxty?=
 =?us-ascii?Q?MGb8RW83gLwe3ujvQUP+5tCFJqyAWJesJAOfkiJCru3AaoXQHTvAGJZLxp5w?=
 =?us-ascii?Q?lpJxs4b6poAXjzgxdUM131/cNlWIkCIUxx8qzsfD093Nsq0JL9c5mouV/oyc?=
 =?us-ascii?Q?mKAt9h4JZfagtfwKRqV3iwoSfMJTjWaIsGRZ13q7q8r3eF1LGlaLj4E0Brvd?=
 =?us-ascii?Q?bP2/n7TJvEjHTAXra3e7l8JQsoC3Fp5vFmJhIpiZki0ax3hqwwBZqSoKmsY6?=
 =?us-ascii?Q?pt3QdLtDUFuy6wxpmu7JDaFVWID5mA2f3YJcZT18sccT8Y3gVTzFUFXWvjbs?=
 =?us-ascii?Q?kLZWXuqwrBjNR+3hxEx5erwoWSnaGHPcizTMV3exQWJ/rTHva0Mlp6vbrd4Z?=
 =?us-ascii?Q?XfKP9lF+mDovFYY8y1Kc7gtLdNI6rxLErmnwOdoIVmk1E7jRu0mTolW4ohSH?=
 =?us-ascii?Q?l+37gcUnXKNq2Bk9rqDvmOjvYO34m4xp4b40YIW24yak9+6WDVBeiU9zhDrQ?=
 =?us-ascii?Q?dxCKI7CCKappljgL3pN0LYAxefSJ0LYKKjHAyXkMJsOkzC5zeBPd8+oEX7T7?=
 =?us-ascii?Q?HJI6SxtlBThKZWh2btXTJS/ekOAjygVDAaRvpsxfEa7abBzk+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:49.9894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b42df97f-595e-493d-4f41-08dd0078f73f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * adjust mutex use
---
 drivers/acpi/platform_profile.c | 56 ++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c4d451782ff18..c4e2c75116988 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -206,26 +206,54 @@ static const struct class platform_profile_class = {
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


