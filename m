Return-Path: <linux-acpi+bounces-9306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3299BD08A
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0150281BD2
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0D117DE06;
	Tue,  5 Nov 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K2vZAg8i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A87178CDE;
	Tue,  5 Nov 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820827; cv=fail; b=CLLar5M2qLz0JT4LP4ScXTyzx8IixLOM9w3wlxIXQJ0w6Ix41hylYvFtIDuHe1hQ0KN89T56uf7zKZRn1nhhRIRH+9D/5mumlGT0zn09RsqlEe+p+wxJqveSrGILqdqlLAHkV46fA1ts4BBoGtmj733vEsFO9lHtt1tp0VW/J+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820827; c=relaxed/simple;
	bh=A80apRvzFpvKnp/iSfY+2i4P14vmr3rdL7/mm8Jq4kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXEhbFtRXugT10ShEoADdUOzpoopUIDNsP9AGddVsRi9kaYziX/BBFT1MxPYjAbMz9AvWheGomYoH0Wo+GbxvehSlmwLOgXubEYcPic/O31sy6X+sKgce6pwKijZnrRTVfKDdDo7X/fXgBcO54x0tTEmWv9v3vU/+b8Dbq5/S8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K2vZAg8i; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKzn9IBZGrpiyrb4SB8zJOPPzooQUQBMcwZoL49nEX+flZaMTa5htMNa7io3gTomeRUKlTn69tLNJPiBhU5+9FC5EspblYlNQ9i0+hjxRAQpm4PSluK2b0YcxV2CwUCjpvXl+axca8Ug2ykDSWpgO+OCLPsm+ULxlbU8LjZz0zgeZSjXBMdyJpdgHP+yP/yZo4BaLoxfnC6IylTMwv/n5rgGuJdtQqH8ksRzOLoAfDWSNbGSPw4OKHZrnAJvGhDH7TZLH++6Pt7U1MZOrrr+VQXx1HZG8MpwkjV8bVLx7aA4q1HRx9dUiSa60ouK6PSeQ1jusnme8jKarjRgj2XIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z53q0LzTArxcJwMP/NfJsibGypRNuBSVtaP407naVoQ=;
 b=pkY2ANH+umVRrU4COLEqE4ApNsC4rWbNeiUNllRTTKULQtJRxq/apoKD6SjdvZ74h1djVjdcJwgD8I1RXewIrWczzRQ3iyHywOWn2Y2fnFPpPqDpCPj81jvEKsKPhC0QlQ2TDNDWGwXcIEHOs5IY651loFgrDccFQVB4xX3ONEzztZJKbMI7ZKkGK3k/NC6V5GnteLLzb6cuBQMt6d93RjRgX3eL7hEmYZKYbzjIb41ATi045Xv3g7XAbyD+cdVxcoqFA0oMY3S+1HHgm5hc09ugMnKMAT6szaxh7OgGyhe9Mbns9U9N+vnQo7uI/sOBryrXfYoGUmkVpcdQYD4kxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z53q0LzTArxcJwMP/NfJsibGypRNuBSVtaP407naVoQ=;
 b=K2vZAg8ioOrCg7kkD2FabKnHZY1tIXfWftct5nUUG/PSTysXIcluoWALLCmrHSuQwPD3/CIOtXFNiAyvb+c2so12nkckyVzSkfR3nE/kQy5SsyucYGNsuXpNRwgvcAd5GmlcTgzQfu9R6ZRp9AAM+7qa2e6JNiSs8kbeaZrYAQg=
Received: from MN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:52d::32)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:41 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::aa) by MN0PR04CA0021.outlook.office365.com
 (2603:10b6:208:52d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:39 -0600
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
Subject: [PATCH v4 10/20] ACPI: platform_profile: Add name attribute to class interface
Date: Tue, 5 Nov 2024 09:33:06 -0600
Message-ID: <20241105153316.378-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eb7893-57bc-4535-2a90-08dcfdaf3a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dUBVuAHDaGHkLeqa1ZMVDPbCaFCr15IyyBxk+eXesbPbi7S/MweDun2pjKOP?=
 =?us-ascii?Q?p/SQJqgkCPm/WLsjyF8JRSxYSxAigoHpm0b0hHOivfXdEi3Fe8M1z0hRWRHH?=
 =?us-ascii?Q?osCCMW9gLutHSnXwI+ia+HFsH2gq0TLrag8ENuOSczA2FIFanA2adkK27Boh?=
 =?us-ascii?Q?lepQZTZLYLH7YAz1PzkN1XW/W+PcP651AO1oodQi1SyJvqyFCzKj+MqCXXuQ?=
 =?us-ascii?Q?L1KhQX6cZe47WACMxR1ZetNITquXpfqQFF6ZK1KAK8p0vhSnezOnzqGfQYe7?=
 =?us-ascii?Q?uPIAPBCierMAkveD23VG92zvGxoooM+L+9sYH5QfVcfzafic2fYhKxS2THjL?=
 =?us-ascii?Q?2LDmN0iXlCZU0lFwWZerKKvQuVV+NQiT0hAvagrNmjwd5D1rP7sKOlsWoG4k?=
 =?us-ascii?Q?OhBobzOg7HvfUwUu0sPIh4znBE2m1zmVW5vcRffmiU1YPKiALLzRIKM46OMA?=
 =?us-ascii?Q?kFMfKLl/rsHtpkcHAA7z/s6GnzkhMDE7uiFwQ/NFy4mDTJae5VVORSlCjvLg?=
 =?us-ascii?Q?4b9Mqu5nHncX0wgX7djLO44MCUPAh4G2c3Ey3dBAXYDVivpIaDF+uS9yY+R4?=
 =?us-ascii?Q?CkTmCicfBuGhMDOGlBnul3oEBYU+VwBrAmHZ5X1WsepNu7ny+z3kEaAg07TX?=
 =?us-ascii?Q?JBHJBw9CQb0Ck+qTdyJ7zB4Z87+1HYQzJCHvSQGfL6bdEtihp0TO62PKYzwD?=
 =?us-ascii?Q?i2ABnc/mdBNyfyzaB9cqSfhiI/cxIHBZlwJqfcQx5njH17eApqA/LhqhiCkm?=
 =?us-ascii?Q?Afj9g+oMx+3dSodiJZD0xU/qD6KGMBh156NPZkPNAXXCK3BUX3qrqfQ9Jg6v?=
 =?us-ascii?Q?gDR2WOurZKbj03pKr7GqTzQkI65iB1Ugd5U4HPZEUbeF+Xloh06Qs36jZ62M?=
 =?us-ascii?Q?2lMC/Tg+ckWRDlz24Xi2yDhpJcIIYs6VTUYO4Y3zcq7Nx1oYvomzTn11gYFS?=
 =?us-ascii?Q?DjFLwt5kBnYr92DI97iWfPy0O92gOH4WIf+zoSEbzTWDNs1ooqbUarY7kaPO?=
 =?us-ascii?Q?PrEPwO7nmlpkfCoKJqgBhvPJf9BdJQ8sKGdF/bchYWFub5Z/lwevDC+BJpFE?=
 =?us-ascii?Q?AKIkf0aOBNmsZjqnGp3nAo4VyGBK94Dx8j/9wE6qHQ4OoA2QdMlMhr/gbT3L?=
 =?us-ascii?Q?ilLEj3EwPPv7eUH0CrcLHb7GyS+6JikIAu0n9Jh15Lv4zB/Vho9oeTuZ3gK7?=
 =?us-ascii?Q?BdrrEJQ/Tn2FpB1v+BCbPKRrOZvqSKf54wfHQs9drBAwx+bBa+7+ANsja8Nn?=
 =?us-ascii?Q?exkU+parKwpvoAZUYvagQ1E/iFe86Aa3K1tIcAPNddUfByAVwR5rqv+rK2RT?=
 =?us-ascii?Q?fe2+cX8sGpIaBYQpdzZBkcrTZAf1vuS9zxWLNHi3RSPwNnKPlb3qDP9dSw/b?=
 =?us-ascii?Q?8w+L2CE8qBWWQQp+YuJbOhmLh01pEOphqf22Kjl1V3sZZTrWkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:41.6547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eb7893-57bc-4535-2a90-08dcfdaf3a31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

The name attribute shows the name of the associated platform profile
handler.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index f8e9dc9a10d54..986bd636be226 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,8 +25,33 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDR(platform_profile_minor_idr);
 
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


