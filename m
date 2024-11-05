Return-Path: <linux-acpi+bounces-9305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2812F9BD088
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC351F237C3
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F1817BB0D;
	Tue,  5 Nov 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ji/DC1ib"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12A16DC01;
	Tue,  5 Nov 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820826; cv=fail; b=i+W4YS/b1phE7U23Y1bxK7Z2EzeGkknr3/vJOC6y5WJW+gPntGtSN82I2culM9csqR5Ew2r4oyifsg69lLBWbPYNXibKtKvGMLuEKIyp0cUyPM1tN16Gl2fE5bSVCaxeflYsxXbqf5NgwApm3km+7+i8t6rofnv7J3fC15cJPdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820826; c=relaxed/simple;
	bh=ZiSnrAZqpknDKmRTcVtO5k6/JrorA98CRKWnE2qaNnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cActgx1FIutYG1mokfajtrkdXFKp/6aRxIbY3EpbN6DPeDMuGoeY77NzOLbmNAnmV2y1d2/R1KXv596y6tCJdICGVy6OxvZm0iqKeo2P9gR8INMta1+nnZOoGlbB1IbXC9/aJLpRIm5VX33vhS4lLdGmR1H/jN3dPJ6rRPd6OU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ji/DC1ib; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZyLT1bkgoff+yg7tGTBSum72kEhWbNi75wjsthMNKwasDPFCAVFnIeSH0eZKEPZzRAJ1dwRimsmbQWFWw/5j1iRt9GBf8R+bPeDnyD2oVAjJRSf5Y9nqbTpnbR4ZpU7e+6OUUz2pR+GTyG8WkobYH26PpTL/CrwvFAtbvlZ9ScFvwVRMwUB8F6OGKA7LRAqTCvEGXvk7ScNAwzLPcJ7k4E+zIAayJrrO+OTn8AjStR/c61vex4QoppINrJEmcaaouD+iDZekPLwk97RRn27tu9hVt8CoBRlOb9dZ8hVwNauCHXR1M1/CIaaCHbrULcLLR+pEAMVwqbVSQ/20MXzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naMIE5K+E2Bm+Lw6C/PWo8a1NL6TcZTaCbH9D8/5SRQ=;
 b=VPrH6UcZ8X5Vj7Fkyj+xJHOZkPBRn1TrgMj6ZQ6KWGaN21HM2XgtZeBzQMiSQMQelUl4uL6UQdmwMl1qBtD0Q7HoQLxpis3ITIdR9aGgcdO2r4G3oV3jP9SACG3tiDsXhW8T4PIv4p1cR/DfF9TWo/H8GBaRugC9GB5FYqIvga9VmenBhjteDvVNCbkWqosqEajj7fmVG2q7tSgxYhfybKxb8TcK4/98bhxFOnKjC8FnF74qJ3mmBpQSK9pceZ0Tz86STLqFPPrHSe/LiLdHMt/2u5C909yi9ZmNBnDagSxHsWopokcDa84uVrgcmu+ufCrT9cUKr4RCB0Weru1r2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naMIE5K+E2Bm+Lw6C/PWo8a1NL6TcZTaCbH9D8/5SRQ=;
 b=ji/DC1ibGhcNgIp/8VRnSsGsSASuwZoY4ir5xSn38ZWTPovotAaCwg7wC8q5RucCOX5uo2UgbsGgLgVIZCCiPVbycGI6pQatm29MTNyisrvOUEb34Ywkx1FdVBx7rnbYUEQ6JEjVmyU5QEZ3LAJyK5PHd1jBQRoR05kWMfljGvM=
Received: from MN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:208:52d::28)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.31; Tue, 5 Nov 2024 15:33:42 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::a4) by MN0PR04CA0023.outlook.office365.com
 (2603:10b6:208:52d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:40 -0600
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
Subject: [PATCH v4 11/20] ACPI: platform_profile: Add choices attribute for class interface
Date: Tue, 5 Nov 2024 09:33:07 -0600
Message-ID: <20241105153316.378-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e95df9-60b1-4209-9cc5-08dcfdaf3a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pfe6BQYxa98EN7ZFNRNWOjzMoTai5ByULv4sy9YIBnS+Z1rSf4zbQNKud5hS?=
 =?us-ascii?Q?60qmLE9GIbViXu1KSLxLd1xjf/ATg4beOroYiaE6ondH/s57RLIAWYWayvZj?=
 =?us-ascii?Q?wyNeX572zY4mOvaxeuvUsEdJKky8oPI3y19dbb1gKL6jC+aQMmQLbc6K2/cj?=
 =?us-ascii?Q?vX5fZD+EkGVAaiVVeKlB9nv9+UYJ7XkC405oScb40pXQEWwNE1Lv1VnWWY6X?=
 =?us-ascii?Q?nNytoQHH6yspkZs0wUCjrqVAAoFOCs3j7m25lA5WQ8DxLWHdr0hkMpEnWib5?=
 =?us-ascii?Q?AUU+SIZW6/llqx8KLffZ2BZxzlcWi+jqQJVPdRUwXP0hZk1xpiNc1ZrzauM8?=
 =?us-ascii?Q?aXkUjYVFV4MEyEy3TDJ7JtZ9HmxreBtJe4FX9ijCeD488ym5jlEijIPsJso1?=
 =?us-ascii?Q?1DU8q9urv+rO8fCT8MnKsLNqZvE6OCv5cuLx/VbIUIZY6DeGJFDe/W18daLH?=
 =?us-ascii?Q?4lM54FceKYLKTIohvRBtGxmAJBNdcWvzEvoMzEgCkcwIVhVXKsTeA+EoEaiu?=
 =?us-ascii?Q?o1TLaTYe1PKwPgI6ZR4vOqbsS0BWrmXM7trwNDUlwcN/w/hwa5R2ws59h510?=
 =?us-ascii?Q?wYc/pu5ffxoBy3O6MMvl8+f8Gur/5jJBzCui5DpJDJHCl9Sgecl72qT/XdaV?=
 =?us-ascii?Q?90VFGcoghj9p7vpxwI32n/sGhWxDEJAaiupHl7o/XQmY2Y89yUHytlThtBIx?=
 =?us-ascii?Q?Mtxl4uOIOl2RXRiqBA4NhAwZjGH/kBL6mihZ1vA+53U4Et24kPyBJYMRkE8e?=
 =?us-ascii?Q?GEKtCdAeuhxoIC2Pi5dtlbGxpgMFIYAiYISX9F0bCd12ieB3i+svQcASSdGa?=
 =?us-ascii?Q?icWex3cy2CCY752pVvsXmX6YYp8lNi3wZAeQ1/o8ey0K6QkOxZuCAqVTSN1C?=
 =?us-ascii?Q?OF2hDnIW4S8IkNviSII3NWlMsNOv59HTtqvcLgmDy93g0aGHmcI+d0SEZ/4n?=
 =?us-ascii?Q?/xYDbm7JrBaPlnp2fLo4/LcHfyDfWwtMG5iILmy3P19Xah8qGU3wqu4BSf62?=
 =?us-ascii?Q?npXlxz/1E3rbz2L8d0k3C6oHTkHmIzxQBdpEYR1YTY6IoD/fTHKevtoOZiXp?=
 =?us-ascii?Q?olhd+HW1FfmmYhMUousbmjQ/nbHb96DyDGUZ/+hmYjsVZ5YaEvaBiodT6WvY?=
 =?us-ascii?Q?HW7BBHIqpMUJCq3ntBga1K6R3qEAk7g4RCarKhL+6md4rVvbuaaOfOU561/e?=
 =?us-ascii?Q?Jlpr2vVc6qJUKD8YaprQVCzxM/2fGLH5TChGGnNJlR+LZFlhPd8oNxugBg9a?=
 =?us-ascii?Q?9A2Heo0K82dIuJLq9HRPF2ydzwWIF2nGQehPBWhDTH4cf0ozmKlywzTEezGQ?=
 =?us-ascii?Q?xfHncDiiYgqF6UqT7V8MIJdtu2CpeCP8eYOGULTnZY/2tKJYzR9gpjxbGtI0?=
 =?us-ascii?Q?BVUEy6V0f5cqWMB/FZvE+0H5Yp+xVwCb3f954HXwWz2maDurFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:42.2016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e95df9-60b1-4209-9cc5-08dcfdaf3a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

The `choices` file will show all possible choices that a given platform
profile handler can support.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 63 +++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 986bd636be226..e1b6569c4ee70 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,6 +25,47 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDR(platform_profile_minor_idr);
 
+/**
+ * _commmon_choices_show - Show the available profile choices
+ * @choices: The available profile choices
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t _commmon_choices_show(unsigned long choices, char *buf)
+{
+	int i, len = 0;
+
+	for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+/**
+ * _get_class_choices - Get the available profile choices for a class device
+ * @dev: The class device
+ * Return: The available profile choices
+ */
+static int _get_class_choices(struct device *dev, unsigned long *choices)
+{
+	struct platform_profile_handler *handler;
+	int i;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		handler = dev_get_drvdata(dev);
+		for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
+			*choices |= BIT(i);
+	}
+
+	return 0;
+}
+
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -41,10 +82,32 @@ static ssize_t name_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", handler->name);
 }
 
+/**
+ * choices_show - Show the available profile choices
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ */
+static ssize_t choices_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	unsigned long choices = 0;
+	int err;
+
+	err = _get_class_choices(dev, &choices);
+	if (err)
+		return err;
+
+	return _commmon_choices_show(choices, buf);
+}
+
 
 static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RO(choices);
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_choices.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


