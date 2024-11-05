Return-Path: <linux-acpi+bounces-9304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDC29BD07F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6111C21DC9
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A497174EE4;
	Tue,  5 Nov 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bDMfZBLi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB315573F;
	Tue,  5 Nov 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820825; cv=fail; b=H25CZO07u9zLBO6WBUuTtyvzCi/clzQFHrGycxaP9xqd67H6n7GigqN3P1IG3s5Q7P8RtLgbfHe4eiGO95Q7z4QkbxHV2VR36btb0zu75rq3UyYuNaSqyyesEpvexgwDp2cLpCMhSQdt4TK1kKI5Dd2Uhg71D70g/1Pjb7YFKSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820825; c=relaxed/simple;
	bh=w2Dm3SR0v5D689dffnqkc4HrQRF/FCuKE23LW6i3O04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2q+wIAaBazRuQaheOywnIYAnKV96vM+6HNyV0rrK7BZnRWoPEZhO27KbCxW6dWhAcnye4yBKkvLUx/1tFE2RF1KI8pSYxrZNzhLXJSQRYDnRLnqRogtDJ9haiDC0MQvE/t/Ng0A8y6YsE4LMY1df7CmlvkW3Ee6n4BfH0NuqK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bDMfZBLi; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUeQHpR1ziwlKXfVEE3MYm1haWRzlMqONuBCrMOg09Vi439aGHGugsV8wkWy+QQxrXmK5/t6YoiMFegjN7PdDeiyLjQ76rjNjT9O+MbAsGuh8n2fPgMjKHfEKnZbIJP5ThXfzpTO1AcF+djBlDqdwWe/dhcVIZ4V2n9VJYr0wGM0LEndJfSuo5rO8Y4w8dL13Hg8SVauPyeNyF2QnCFZCFQw4cVoIIB9vQXaASdab0hMNpt5A9dVRGz71ok83haCf4yUAB7Q1bPMLdHWdgdNv/JmwaZSdmG6yyB4QNsPOMy99tADmB6TuiQhpSpTYYMXUlnkCDONdd2U4EY3FEuFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ad1/6TojCvY4jp/TB6IgLBEzjel4m/AXx+akqf9shs=;
 b=NOkWcD3N1pulZDRa/AqiSRkqwOVN05S7MLr687g0FNuLrX030Oj8R6adha6YicpZgwyQTJ2r5Is3lCNSfWmLqTIgPFplfzK7r7JuW96dOZK6XSuduG0n7uMe+bOUQV5ymuiFDlgYY12hqq4luxIA+mZl6MO8jM+73+ATILnLxf/5B71XBrMy6ywmLvu61clEe9vDHBunUvSmJ6U6/DOEbbfIdo5Vlv0ZvE+T+//TwT0v9szk5HZP2EXT9ce6Kq34EUUD+epB3rEhc3HpSoNuCfpli1iTEsY0st7w7OocUydkWKPLNxKT44jalP+ZeKEQLsEcL7MXRxcntsv0gyI4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ad1/6TojCvY4jp/TB6IgLBEzjel4m/AXx+akqf9shs=;
 b=bDMfZBLiYS4CYIfQWvSYnt4+tP+21oXw+3VoHSzEvsaOCsAyKNRk+Gvy+F6mESLcpnIZgNdKI3A2naUiyy6sjvVwcBedV8fGNbVVjUzWPJYLt2d4mTjShAELbvqGzClI1KeFGP9O8UUwj3G9IS6Re28LiZ+Nwc0UTAmu9tP8VmA=
Received: from MN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:208:52d::17)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 15:33:39 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::27) by MN0PR04CA0026.outlook.office365.com
 (2603:10b6:208:52d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:37 -0600
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
Subject: [PATCH v4 08/20] ACPI: platform_profile: Use `scoped_cond_guard`
Date: Tue, 5 Nov 2024 09:33:04 -0600
Message-ID: <20241105153316.378-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 12232ade-a9f1-4667-d670-08dcfdaf38f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ga8nTEjOykxLOu6UuVPBln9lt/vJJOnhuDZuxtUOHL+4Th+r6fED2GDztF2i?=
 =?us-ascii?Q?34YrC7Dt73S+3ZweiZuSTWCUWZhKwid7x+BS1Qi5SOrAYcROrSI19Ouq8DSB?=
 =?us-ascii?Q?2XGyB5hwvNNe/WX2FW97Zw8KROeTnnPl1O/U+864GGJA+TixNRqhccmyKjtm?=
 =?us-ascii?Q?DTed5fTgdYdfJleQVXR1ZxHHQLdauNdIFmfS7ZWQoOadzqY4iXu32L9pmWmZ?=
 =?us-ascii?Q?Fp3mljB/6CMPzlsNQwFf114snjO7vGjmTifZ1wc2TSfxb5AgXtMdijaCZWtj?=
 =?us-ascii?Q?AQUL2JI1TjPw9QJGZt8NlcGCn0AGD7qY7ZivdEQrSEY0QifcvFNnP5ekS9qr?=
 =?us-ascii?Q?7L+LSdELeP49xWB1S+rD/+PXh03IfOTOKqxhLEZX1y4jHRR9tbws668hC4HH?=
 =?us-ascii?Q?un9+nsVXL5jP5ej6XfdDhNJFLxRPDREEjobIz0LwJWMhyOBEdITfHejP25U1?=
 =?us-ascii?Q?yo7k661qrGrZQ56z5HJfMOzDvj+ACoE3QlPPGhu3/jXw9apxNo6ahZuN+Nvg?=
 =?us-ascii?Q?2SnXI/VUJpgy4C9R80wFX+0ka9eE8ofhH1NbOjZlMP0utmQvzyms/FLDb3NH?=
 =?us-ascii?Q?NUP9c/MeuLuboQoRvfd1nnwyHZb9NjP3R43VVlOpd0v0kRxw35ZlxaIrauzL?=
 =?us-ascii?Q?z28tW/VkQe2E/yx6hyMMjfRiZCa63xkjTHdynAECBMzLSpVaKQKuQHE2J+jO?=
 =?us-ascii?Q?smTimEh5oTDD9ZZRYhV+DfX2oC8+EhGh9zlVXtjqXjwhfyb+7+iIdPs0EbjK?=
 =?us-ascii?Q?s6HG6qUDeJctagrTB0cfbzZGLO5r7/YSC4bLzfXSLq3M7sBCXZzScHP/YHBK?=
 =?us-ascii?Q?vC3MztwdG4U+zvw2uIb494JIMjmkPkp2NtV39qq9OVvMPARuvow9F+TofbLp?=
 =?us-ascii?Q?RjRLVYfflBS3wVp9OBAbuIT+FC6iigMreQQEG9eMqJw7ErN8Z8hFDczvACBm?=
 =?us-ascii?Q?9gg4WPFq8pcWe6c55AH8HxMgBiEiqF5zK7djUd4BfLJ9Y03KY/ajFMG/K4q0?=
 =?us-ascii?Q?OTDkG+E9Qb1cBqgNTMdkOBfQCkJO0toJvbFMPuQmsgIiRejmcjOBGwKZg0th?=
 =?us-ascii?Q?2PzHVdW7mxE23YRCIl6cUdhy/CyMAf5mYHSs2vkk8J9gLhyWmqAthbUOb0AH?=
 =?us-ascii?Q?hxtlY4pcpcD8p4sqfxuFe8Wk1vA3Ou6DJWc7FuhzFG1nnSYoCYE6X6B5szuN?=
 =?us-ascii?Q?lUlkzptX+fAzEkh9gt/jUROy28mRCjqJO1GpqGPZKYmEQXdRurd3H1eT8AcJ?=
 =?us-ascii?Q?PpLQ4B8AjwkoSotzXLKjgs8NKy9PPWN6JktaUMXJ6CGkRfLNk46jRoSXLvdW?=
 =?us-ascii?Q?p3MD1qizifwjnPDtbJwUO+IExdI4EZwVOVdQjXGJEZFpoxiyI6OzCPsITUv9?=
 =?us-ascii?Q?ALaYzjgM/YCJ4n3ysm6B5mL7FLDCxiz26qbM4rW+TRu+a0Evkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:39.6078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12232ade-a9f1-4667-d670-08dcfdaf38f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145

Migrate away from using an interruptible mutex to scoped_cond_guard
in all functions.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 114 ++++++++++++--------------------
 1 file changed, 44 insertions(+), 70 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4454c4a903c8f..fd1c4e9dccf0a 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -27,25 +27,21 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 					char *buf)
 {
 	int len = 0;
-	int err, i;
-
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
-
-	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-		if (len == 0)
-			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-		else
-			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	int i;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
+
+		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
+			if (len == 0)
+				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+			else
+				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+		}
 	}
 	len += sysfs_emit_at(buf, len, "\n");
-	mutex_unlock(&profile_lock);
+
 	return len;
 }
 
@@ -56,20 +52,15 @@ static ssize_t platform_profile_show(struct device *dev,
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
+		err = cur_profile->profile_get(cur_profile, &profile);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
-
 	/* Check that profile is valid index */
 	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
 		return -EIO;
@@ -88,28 +79,20 @@ static ssize_t platform_profile_store(struct device *dev,
 	if (i < 0)
 		return -EINVAL;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
+		/* Check that platform supports this profile choice */
+		if (!test_bit(i, cur_profile->choices))
+			return -EOPNOTSUPP;
 
-	/* Check that platform supports this profile choice */
-	if (!test_bit(i, cur_profile->choices)) {
-		mutex_unlock(&profile_lock);
-		return -EOPNOTSUPP;
+		err = cur_profile->profile_set(cur_profile, i);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_set(cur_profile, i);
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
-
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	return count;
 }
 
@@ -140,36 +123,27 @@ int platform_profile_cycle(void)
 	enum platform_profile_option next;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
+		err = cur_profile->profile_get(cur_profile, &profile);
+		if (err)
+			return err;
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	if (err) {
-		mutex_unlock(&profile_lock);
-		return err;
-	}
+		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
+					  profile + 1);
 
-	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
-				  profile + 1);
+		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
+			return -EINVAL;
 
-	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
+		err = cur_profile->profile_set(cur_profile, next);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_set(cur_profile, next);
-	mutex_unlock(&profile_lock);
-
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
-
-	return err;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
-- 
2.43.0


