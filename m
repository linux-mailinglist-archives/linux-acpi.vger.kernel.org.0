Return-Path: <linux-acpi+bounces-9679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06449D2C79
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B4A1F22CE0
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4702B1D6DD4;
	Tue, 19 Nov 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fF/2LNgx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917F1D5CCD;
	Tue, 19 Nov 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036886; cv=fail; b=fUEd/IEvFVqslOEY0MGppp7ZMCkCW2bFeBeaH1tH8x9scT4rQTvj/unB3ugCpncJwKsdIqsTtth/+0PFtEU9Q7EQ36NmR8FVUwWCjkG57PXYu5fGVnSwGglUtTN4ePoZDlJQoQ7x8PtalBVsQYq963RotJe/HV5eUMovqKq4R7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036886; c=relaxed/simple;
	bh=o0zMirAhO4Tp1P1JyMZIkB2N+NyjUc4RA+EWuEMlWKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyHZjmGUpG+JD6JMdUm5apDm0Z7kYUyr9E/rBgmmkYius0GYT1RAW4lzN4fW02R4sboPrv6jZONXDZWkbTz+XDUX1PoOPMojL9biqCJu7f40SlaAXyvJrKIj4kNb7ssPW4D0DDIri2XNxNOT4G4dkeX54321xqbRlc5BUqPKw1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fF/2LNgx; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSVmJzIYANTgFmIIxmcZmxZ3rXmBw4cFrwIyii0cFkwQ0E4AG5euSsV3YCzqDnHPPzCGPedk8Ej0aZCKd9/uenQ0tHjag/K77aq6mV0GLQVw3GYyMW/REPg3YYbRyZVAEM8KB/9Zt5OIEyIz9szSZic2Sp6jFSUUU9HqUaugsPCDfWNbbJB+N2nlvvkcvKFT0jjSf1OxHyYP/y0kbsGXGDlrQaUi1qnnb2NeAByFklJPOaxodc50S0qst/NylzWL/ZYRSp06bqUq8xE4pdc6HceapyGFfhvJP6ES5qk03u4gHnidwyXLXrm89qMJ7r4SWYORzZ1+gQEmsoZX3Qyoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVfARja3a+pd0OusscE7B/9Ps+rg79WGoSSVHrXd6dI=;
 b=WO6W6Fm4/gHnT8vlMQEKx7Kj8U0nXQR+pWtzJwHIv9HbY/2mBc6nNvs+mOgw4wcBadIDzjUK5HbTcfwpc8NLtYCB0egxGepe0VFUxRZdhWhzuG2Ay9LKt7wT98ZHc7GL3mxhvcxaPJ2WScAWbakDBMHMYJPRHkCCSj1PFmyKAE8ivkrh5pKe8/SXXrDVLBgCa+YOYpsniExuStHnAkxq+ULu0bWqFZfSe/tngw7G/4H/qnAGIwl0Q1Vvpe5C/uF0ZbFuKFdsZBQ2E7AM5m+y1RgpxAhZ/bUF/D+JA3q9RjFH2F03Ka8Dqwtt0Dyd75L6ONW3DwbEgwOdXC2+FKV4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVfARja3a+pd0OusscE7B/9Ps+rg79WGoSSVHrXd6dI=;
 b=fF/2LNgxy8OzmQ2uf7FFmDhheSgHvFvSDwEY1nk8std7HdE+fbve6zaGns5HbXtt4/plpeX0be5HGOwmX1UW59vXKcsOvbRlhrU2IDKgDksaJjROx89bLisf1CP83T7UxOxD45Jx/leHaKxrQJQQPeXfu2b0tnxuEs7Lsa/GJTI=
Received: from PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::9)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:21:19 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::95) by PH7P220CA0058.outlook.office365.com
 (2603:10b6:510:32b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:15 -0600
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
Subject: [PATCH v7 11/22] ACPI: platform_profile: Add name attribute to class interface
Date: Tue, 19 Nov 2024 11:17:28 -0600
Message-ID: <20241119171739.77028-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: def880eb-132d-4da0-ce66-08dd08be949c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HgtyRz/wEdCIlHu6cEAqePB4oeIxm6pXqh8B9t6pX9Dosobo71uRnXOWIN+j?=
 =?us-ascii?Q?lZzq83GjN9w05iaVGMRJ9GXvnjTlnuMEYhC+Rv01AgoS2RJPSfPhjdgxDqPE?=
 =?us-ascii?Q?6WYp3xm1cXH1inVYUUz3QYfjQbZRNEsbNWX0h9AfSH1Bu3F6uzQ0HJBN2Amd?=
 =?us-ascii?Q?9ycgzLXABDtuntupEIPXp/fQ06z6lvimR9PB1zdRp1CyjjrPMwIixnUGaNdX?=
 =?us-ascii?Q?h2uW7PQX/ahAHEQObvYaWDyQbl0VoMab8IAGMjTPDTKEXn5FjK4Fk0Ap3+Eg?=
 =?us-ascii?Q?LXMgLSDtFdUJkbFbRFjFSwMfoVpEzAPxPWrYbFH163XK/lVAxvTXw8Ihporo?=
 =?us-ascii?Q?ZRJxfnq1uk6EEjs9ChC+zvWuiyh4WtP6t32Qpkgjc6zhpOZJXxGlieQ7Zcz8?=
 =?us-ascii?Q?mKkE9SJAoLr8V/66r4E6kPp//hZsUgGJXJAjFfs1ktW1Kf6e9LCzMiezByqf?=
 =?us-ascii?Q?MqKMxARHFV4rnKWQ+synr2BzTgmvpKlgE5IQTUytIL5JnyStcUUPQmJbxO57?=
 =?us-ascii?Q?SI2zS8uBoHMaY9KP+32TAvNhHm9AW3NGIsimxISdKKxIIQ+60Tw47pirunCB?=
 =?us-ascii?Q?SlBIN/Zqg2NCOkq7+D9fTz2LxbFs4Xp67AVmpEGZTFRz2Rw8hV7Vua+KqnZz?=
 =?us-ascii?Q?T0BlDmGfO2dl55GsW8MtXFYWM1YcYKGdnYJIU5/83IadFDeGvnp2qg0WBABk?=
 =?us-ascii?Q?pFqxwg/eo3PXrTSyCWIyo1JWpDQs+LPv7N0O5x7KN29XKTAFQmDoapca9BaY?=
 =?us-ascii?Q?K8uFBX0BchxaEHKIK/tpuF5L+5m3aNxnMAynTSe/7BmDj+COcNOhO8XpQu7D?=
 =?us-ascii?Q?HjS0JmtzJQtvbMiDQryMLopPJl2f7yKNVxjFxnw6hqxT8qSyamJQ6wYKRJjn?=
 =?us-ascii?Q?5oyJHIQ0mrfuul/dZJqAqbVVET2OdsRJ1+BeFrSQcA+xJuiHUmv9vcHmLXgY?=
 =?us-ascii?Q?9VDb7t1z/wbPwyYy7mvGi8Cv10rzN8fvtTWmb+fccZ4h2ypGZ2w4/LiUSGvz?=
 =?us-ascii?Q?0Y+3PlwR+VFLlfslPTj72iT8LiFWpdkc+9sZinXiN5UpZYW/+OjytjkQMIL6?=
 =?us-ascii?Q?M8t4NGNoEIPQv0DQ/GuYwHxkFudgkv4jpjOvCigEYXEcUti3iiFfHZu3SKE4?=
 =?us-ascii?Q?nzc/V0s1IrKb0O4e1Dh0pV1Zol27ocZFoSVvXK1b9c2DdaAfEkGIGKfcIrdS?=
 =?us-ascii?Q?YkSmy9a1+5qhPNKVe+38pEBefxh6mv6sIwganpi9QOfPMSEDfF+JLbEt+WLg?=
 =?us-ascii?Q?YFu2EYtQjD89RSGzouYMkyKy9R2kOYdqWr6Ac6yQ6NpVjF2/2ckKqjBV83Qq?=
 =?us-ascii?Q?3yL7Cv9EAANO20z5GtaLCODGdRKt0zgMO9/+CyWZSN6oIAyo8JR0QhfVx5XQ?=
 =?us-ascii?Q?e/UVAWf7lE7G2smRs6uf9KLwOEB4si5ntGkH9oRAqTrAuqFW+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:18.4872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def880eb-132d-4da0-ce66-08dd08be949c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260

The name attribute shows the name of the associated platform profile
handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Drop locking
---
 drivers/acpi/platform_profile.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 3524a2b4618ed..a9d7ec3c85844 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,8 +25,32 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
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
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", handler->name);
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


