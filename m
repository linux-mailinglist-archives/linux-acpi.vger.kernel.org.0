Return-Path: <linux-acpi+bounces-9311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59B9BD09E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED661F21CEC
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A71DD88B;
	Tue,  5 Nov 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O5cMdkN6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF41D90A4;
	Tue,  5 Nov 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820831; cv=fail; b=V91ZQuSbBgqK+4I9nNj36b/PMyELS2NjP07ogmHM5iGm9DjTIgiilrdwUrNPkbi4+vY+UHKeG2gT/vgk2QpANblesZsruBAIaoJkopG5sMELXD81xS8ShnfH2yEM0aeYNhRXhTYHqMBeq8payTHh8kbP5S+LaKMDHfBWnJE8J5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820831; c=relaxed/simple;
	bh=bea7+oj/yKdwscoVFM7DQQ3Vx8PXYMWZ5pqVEEdBUNY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjG0lymvBtU8TJSQMxBMYTwiXNOZcBjAWkm+1BEetMwzkbELROmG7vlN70dzgX18ChPHWJ5slWCKoHnQXz95NQcCOe79xayjlRoXszryOTsbimJkYLtsz+xIFfr/TEGEsOge1jYAjOhtYYcEqTdS7xZ9wLBcPj0Xl+AKNB7z22I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O5cMdkN6; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flMH1Acp1dYzHKW8Vdc0xZ6IbZRc9vhv8l0Qk9oPpcpYerESmhszSteAxGnsfPZ2iq7gsFLlZzmOaoVSL5T88hAM6018ISMD3xCbKffMk3Ttj5TKJn9GBlSo0FkTlKYHfOFi2wwr4zhhWLhI6A0ug3aPONUeAPKm69m6Dc33XpYOck4gWdHcSeoglWF7RG0lOj2y29WUQrGOi36G12wZHF+HkhzANe1tUDvVebfIc/Q0rjnOa8GGEPRSYPut4pHD0J7vzQFBuf/UBeIxWmwRT6lydVX+2tm+wBSFV4AO83RDFQNKxWoJdPdhnXgCIRfSlS9rxqZ+vOQF4gUBFDp9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC/7QRb8PV1yuawMDK+R6YepIHiT9JZOu655rTlMd5w=;
 b=onqXbYxhDJjIY9jrWcMru4/4z93pjpmgOjbUv+J5pYR5JdXtAsS8/G1m7DuboMuKdNn/8me9X3Hik1qAgHm9YfiMiNNnzaZxBs83+xulxZI16fOV9hCecLKliYkQvOz30rM9w8TtDz4VAOXqa5ZM7QH3boPVMFaTJTMMfh6duABaV98hNaTSEVHpffCoTrsyuQf1hOvN0bPJvFZPd+f22+ijg3yWTyjiljMawPVG6LvhTyDJ9Oo4wz3KFhOK2GmJiOuy5nUR5jYNy7asiV3t0h/nK46oOtfKqza10tQFqaZa+/T+5FgYqVaWLig5p7GV4OmVxq7aYse9L2/SQfJNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC/7QRb8PV1yuawMDK+R6YepIHiT9JZOu655rTlMd5w=;
 b=O5cMdkN6XTNsMfUybN68MfsQlJq4rM7G/7zURyDF5VgWtGVy4v02O5deXqqOthowgw6TPJWTlU0wFkEJXbrjolRn5V4SZ4xiarzhrrMAF0o0x9DsnZuGHfcPNPdvyHWkanVF2SES13z6rVaRow6Vdeu/hhQ1gZIr8C3KHLe4d0I=
Received: from MN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:52d::20)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 15:33:44 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::cd) by MN0PR04CA0014.outlook.office365.com
 (2603:10b6:208:52d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:42 -0600
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
Subject: [PATCH v4 14/20] ACPI: platform_profile: Only show profiles common for all handlers
Date: Tue, 5 Nov 2024 09:33:10 -0600
Message-ID: <20241105153316.378-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9754ca-d5e5-452b-7ba7-08dcfdaf3ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?At4D5pdUM0KpNDuiG9tHBJK2K6wPe1hBfTi1qQf4Kc9BDQnU1e2a2VHNLOxM?=
 =?us-ascii?Q?h6BqwgI3LMQgb85pjrjHLft8tfl+B4v+R1fHDGINqovjVpGaS02896E2NN/x?=
 =?us-ascii?Q?Ca8txDbO7Q7btIIMBbsKag7WW+zAaExT5SFPxR/JV6Nk4OX62vrrTJkNAZOV?=
 =?us-ascii?Q?auxsWRMLaQdEYygLy6omn0fpPBx/sf8vQXmZ0tSRXCnjAtXzXfStt79FBrl1?=
 =?us-ascii?Q?blyBajHgw7aCKssHyvHfYPOgIxHASBAqPCks738p+pcdKR7st/7BeQqbtzyP?=
 =?us-ascii?Q?EkE5sSUb41uuH8svilsNHq0U3mYyt7vvU0+Dqm+OF4Mgy25j0VwM7E6E1bdS?=
 =?us-ascii?Q?WZvKTMu+dVijcMtNK66UWj/WbsjFJzDdRjm6jIptZc3I+b27ejMrstUW0kqf?=
 =?us-ascii?Q?ggb5ycmYDiuEaQ+xaLfV9ORTnQHK03yryRHseGDJMtdekBh938NG3fvOP9zS?=
 =?us-ascii?Q?JlhEclM8xgbBCmJjtNjevB+1mZeYVSVgPsHHsgaCQhpwZfQBLX1KS5blq6EY?=
 =?us-ascii?Q?K4soe7q0+VRVcXOgOVK0FBTZ086b9MUMOheajzNytiiJQavLJjkLKBq9jRLI?=
 =?us-ascii?Q?ChJjeIQNOSktYXseJhFc39s64391kUl6NaRlDQByRQWDDj3mJPwTRBa7q/Oi?=
 =?us-ascii?Q?RUu6ipuocGtmr1GJMonr6lAi5c6vHTqhB4ZDpQHE6XD7rJGYl8k6KthlcAuQ?=
 =?us-ascii?Q?+ICF0c4wzAdueMIARWRztBtp9xLklsUiPlTNIyh+/C33ENAc+LNWM7zpEpc1?=
 =?us-ascii?Q?jBySUkMqX687ZmIbxIfyiSQIUbI6H2Q06+/sxZoeKDyFjm8VtO4amypuPvqb?=
 =?us-ascii?Q?8YMUOo17JolxGmPRDGpAzF9nzq+Q19cQ8YrpJiMxWy/cHA2Rg9dn5oiOGd7T?=
 =?us-ascii?Q?LqeqL0tl2hAofAm25We+qMrOo2nxKlhuUQM1gqBWTtbvUVRC5BL5WfcP3heq?=
 =?us-ascii?Q?JjGcZ8UFelWtpI9V7FQM3WxmZ/5GECJsBx7cjF51bMEX6g4wAZyaFNNUY6Dz?=
 =?us-ascii?Q?SPkthAErTvUrLab5dvkHB38eGjTKlkNSXxo5AcamqoseM4BAgZQLT1Kkr32+?=
 =?us-ascii?Q?UDJzEB+R0BhAXvDSUD3F8JH8HvdDjmi9MIWSRF3F4KRol80gpawXDx9qx+Yf?=
 =?us-ascii?Q?uHoWoeHbUFh3hav3+InOCnuxE0sfhOT0LIIYEhe9w72O94PtyJPYytotnHEa?=
 =?us-ascii?Q?qL5zkQuY5qYqMr++spyMe60tdseLS1innR0W80EiX7mM4BKjl+ZSPyktMDvD?=
 =?us-ascii?Q?Pksi+cmeAQxjxcHlZHBg11IzMtrmdHXOjvYoNyH0lQkcdl4jqOpeAfLZg3Qg?=
 =?us-ascii?Q?mFqg7LXeeyScfjWfdM9iAsopKN1OjUZ6iksG93oPpGMJnVn14ND5P/ikURiM?=
 =?us-ascii?Q?KgLJ6SXnPp7TsD3npVQFPY8ZTpMpjrBfmAlncjTrHRMqMUbR6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:44.1078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9754ca-d5e5-452b-7ba7-08dcfdaf3ba7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 55 +++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c9917daf683cb..8de7c8352673e 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -235,27 +235,48 @@ static const struct class platform_profile_class = {
 	.dev_groups = profile_groups,
 };
 
-static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+/**
+ * _aggregate_choices - Aggregate the available profile choices
+ * @dev: The device
+ * @data: The available profile choices
+ * Return: 0 on success, -errno on failure
+ */
+static int _aggregate_choices(struct device *dev, void *data)
 {
-	int len = 0;
-	int i;
+	unsigned long *aggregate = data;
+	unsigned long choices = 0;
+	int err;
 
-	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
+	err = _get_class_choices(dev, &choices);
+	if (err)
+		return err;
 
-		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-			if (len == 0)
-				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-			else
-				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
-		}
-	}
-	len += sysfs_emit_at(buf, len, "\n");
+	if (!*aggregate)
+		*aggregate = choices;
+	else
+		*aggregate &= choices;
 
-	return len;
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
+static ssize_t platform_profile_choices_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	unsigned long aggregate = 0;
+	int err;
+
+	err = class_for_each_device(&platform_profile_class, NULL,
+				    &aggregate, _aggregate_choices);
+
+	return _commmon_choices_show(aggregate, buf);
 }
 
 static ssize_t platform_profile_show(struct device *dev,
-- 
2.43.0


