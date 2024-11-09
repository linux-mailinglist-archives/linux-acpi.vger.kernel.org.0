Return-Path: <linux-acpi+bounces-9480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD5B9C2A1B
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30401B22965
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB17198E6D;
	Sat,  9 Nov 2024 04:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSjSz/pW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCC197A6A;
	Sat,  9 Nov 2024 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127387; cv=fail; b=JOb74QiJ8Kh4ICGRm+PNdrZFCaBkCktJ7xq0LGA08bE9vqbf2Mmuj3WKr5upRQ1XVeOSm71ifKzobiyCqdG17UMLVicOuEL95lZJg+h1FA20TR8wwJSQZTPeW6+Hfg04T6eM7SUNg9r/F5McvnYdvx5VwgJNcHZyMAzo9OL9OII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127387; c=relaxed/simple;
	bh=/+/ROlHIruuC8Ptk3wbPDnl/Q1PdBpPyHTOE4QQFJzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9/gfv84kkmQGeRrAN0UYbMrpB/U+23gMI2M3ZWRVxrPmkv9M5w+rJIB/E20T6roPbthd4u2HaXYdudeJ2u34vm4wmnxRlKg9wroTbmRY9ognMQbARrCOLuh6Z9ZFPn2l9ZJEoHqpFqRcK4vD0GJuig3ZBgLwQI7qc1XVOwHDlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSjSz/pW; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ellgB+9wHNiTkVpQi3zS129lXjeeNGUkZIsEhWZsQNT+TIfW4PU+jGoCpGuV4nb4/dVe1o0BDGTCBwgDl/oBoHWOMU+5wqwKPy913O2ZaHdz5Qc/4WsI4UVfEAexpEiNJEmzfDp74L9VMlnf2HCH1E2YyImRcX5bKH/1+gsEIv+r7b07n1QyDQoM4bBkIyfRyHgM/ULZbHmxnhYBBBRTtTJmciyQ78FeeWHZWaYpH7X2GBrmz4zyVw2rwKn4cVFUNMveE0mCeprVJC3irDw6Qr3ra/cLk9368bV4g0fBtJAT00F2MvyakpwuvDwyWuZUxJRNKazby5Ov7BC0PgVqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMYzj0HO6grQuskdeKK/x04e7ys9n7Ov1LkG/6DM3OQ=;
 b=MoWgFH3bh/Uwyq9wV72bOt8bg3QwN+n0hwBFz4Qr2FKAX6+PlIQ1t1KnGTW3Cdl2A9Xuat2tBBDzx2e4IPogaDqT1wh6+mt6ZYf9sS+TwMFnO32sfqxY1lKwOrkUmVbU0sZzuz1eRDQlsNcbM9QLbWsWiCRADktKdAj5xwQvWjTCRQOgBTgvbmPGmQY3BXjoeKDSIxHkKk/+qDe4rujzMCZJcOeJT2atXDq5YINu4xzecEvW8bmoSrSbmgpRy5hxJlrfiEZ1ttSobPApYDhqjCVIdzKehv4QgdhwJiaDjYyYvTUUxyM6I8tvudA3Qko2PO3k16s4Beerx2rZ0TX1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMYzj0HO6grQuskdeKK/x04e7ys9n7Ov1LkG/6DM3OQ=;
 b=VSjSz/pWlJaZgaeuOM77sZeEC1qhWc/FZ8lexx6kbr0ApiY0JCr3rIA9ukawe7Xkh6Ifc/BnSTX4PfCOvfdw2ulg4MmyXRSATgc1uDL4hor6ep/QlDzuksOu4OJOM8XQc3NfLF3VT5OyyRrh8ns6ipeoLaoLtS6uNIWaMWRYUME=
Received: from SN4PR0501CA0046.namprd05.prod.outlook.com
 (2603:10b6:803:41::23) by IA0PR12MB8974.namprd12.prod.outlook.com
 (2603:10b6:208:488::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Sat, 9 Nov
 2024 04:43:01 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::cf) by SN4PR0501CA0046.outlook.office365.com
 (2603:10b6:803:41::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11 via Frontend
 Transport; Sat, 9 Nov 2024 04:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:43:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:59 -0600
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
Subject: [PATCH v6 22/22] Documentation: Add documentation about class interface for platform profiles
Date: Fri, 8 Nov 2024 22:41:51 -0600
Message-ID: <20241109044151.29804-23-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a6b79b-46fd-4b88-55ce-08dd0078fddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vn4gPE5YCOLR/tto7r0y26CsmogVlqpgTEciqZD3WJxRhh/7u4+ku/7nmNUW?=
 =?us-ascii?Q?xXcE5pth8vFfDWhf6QSrZE2k4u9Kwe9ddWlov9BptU0BwEwC5SH3GSgWwc6f?=
 =?us-ascii?Q?zThWhwPwymPc1YkcAO96zKGDfopcVKd5KSxSh4Y3mqvEeks0SD2zWRTuN+tU?=
 =?us-ascii?Q?UEBPvJ9T4ARdnW31gt24F9fqpQ7FTeCuRfSVhoHWv/gBDYNE3hPT525wKfOE?=
 =?us-ascii?Q?QMmBXW6+g8U4zVXlC82yII5OUuKqP8vYsUjt0yiyFq6l8DDTY8ysVaaOEVQ6?=
 =?us-ascii?Q?hdiiWZ5sQBdXGOkBZymF8/wbAFnZlP1LEOo0gXcrVPuY9LibeDvQV/CUiRKk?=
 =?us-ascii?Q?Gej3AwYE49QxVJbMda/9/dNLyczQpw6+dI4yMZX6eczrjL9eUs9/CZNp6zwx?=
 =?us-ascii?Q?wLTBokoMdGzFc5nZXdEiwZiqwwEHu4AADnarBpTbVJIWdLCJ897j6o2Ja1Ll?=
 =?us-ascii?Q?NwsXyteUaNCDTWVulPtg7h3pT5ICgoNutE/eQyEns4Q6cw/pHFEmkjE91qQx?=
 =?us-ascii?Q?B3ckBrbbIckF2Sb0a/lwNAcIcc/WR9aI30MiHmZ6v+IhPv0BqTACZMdBkEJv?=
 =?us-ascii?Q?VQChcHJRXw8xYCBxwaRzjXB/VWMRlog6zYIsnlvNYMJARdTVHKDInoUjnDeI?=
 =?us-ascii?Q?4G9B5g5VrqPuJv1em9irTTuaT2K+1P12iNPxoMmnKjjArGE0IDfjKzF3l2c2?=
 =?us-ascii?Q?HSCSksZBTmi78wloNsNpbuJdKkq9z1eIIVQJzf66btWayCEsjXbp68026+nD?=
 =?us-ascii?Q?qid5ROrr1svdq9+LeriehY4XO7SyC+fY1JPfOpTNWYEDf1Z3P7Dw+FuqhddR?=
 =?us-ascii?Q?Gu4m5pStMoKb+lOzbHbTgJcQAKothcNIsQutO8QbU+uCF20S48o5bsd0CXOy?=
 =?us-ascii?Q?pmvrHwvyhDfRW1lpEjqnNozB+e4uRFGi8cmngUdBgM2zhWEanHuvn/kodz4l?=
 =?us-ascii?Q?dr4sVkhzcCORUMxit78Ioc3glkPhu1hCtJTbyokb95xLr4f0dbXRMKBQIT6m?=
 =?us-ascii?Q?8Ei2BpCnjhseID066HkgmNkESF6QNPKD9eLI0paaE5AnbGeLDvmR46lPmZpo?=
 =?us-ascii?Q?N6qcrTRm4UTjbE2D3yvycdfvxVV5Ekjk46+GX8xQt3QHBEWP+fNnG0KmGeab?=
 =?us-ascii?Q?lKL8E5cMj+WFyeaj0l8tjyx0VwoqH7vaYoGhy8DHM0IdrNb8dvTNRnhjYafD?=
 =?us-ascii?Q?hJlUCLHlwj3OfrcDlgyQdOz9o0wAHnMK2sXqu3VwK4J8vl6vYQz8utP+Fd5u?=
 =?us-ascii?Q?AvjbNtazabRT4dUHBpF7xnvJhdl7aCIYwdCuoVJs+MYQsjjXtiQgRTwx39ry?=
 =?us-ascii?Q?HdrLhSyXiMp7G+hMCqHCRE+LBOi5KeGpBd2IP63OV++SJ3qU0Zh7lrtq1Ovh?=
 =?us-ascii?Q?2g7M6fqtPc+oOUhgATMKYzj1cPon9u3zfOgVW5TLpRhIGIg70Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:43:01.0782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a6b79b-46fd-4b88-55ce-08dd0078fddb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

The class interface allows changing multiple platform profiles on a system
to different values. The semantics of it are similar to the legacy
interface.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Fix some typos
---
 .../ABI/testing/sysfs-platform_profile        |  5 ++++
 .../userspace-api/sysfs-platform_profile.rst  | 28 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
index baf1d125f9f83..125324ab53a96 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -33,3 +33,8 @@ Description:	Reading this file gives the current selected profile for this
 		source such as e.g. a hotkey triggered profile change handled
 		either directly by the embedded-controller or fully handled
 		inside the kernel.
+
+		This file may also emit the string 'custom' to indicate
+		that multiple platform profiles drivers are in use but
+		have different values.  This string can not be written to
+		this interface and is solely for informational purposes.
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 4fccde2e45639..b746c30432753 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -40,3 +40,31 @@ added. Drivers which wish to introduce new profile names must:
  1. Explain why the existing profile names cannot be used.
  2. Add the new profile name, along with a clear description of the
     expected behaviour, to the sysfs-platform_profile ABI documentation.
+
+Multiple driver support
+=======================
+When multiple drivers on a system advertise a platform profile handler, the
+platform profile handler core will only advertise the profiles that are
+common between all drivers to the ``/sys/firmware/acpi`` interfaces.
+
+This is to ensure there is no ambiguity on what the profile names mean when
+all handlers don't support a profile.
+
+Individual drivers will register a 'platform_profile' class device that has
+similar semantics as the ``/sys/firmware/acpi/platform_profile`` interface.
+
+To discover available profiles from the class interface the user can read the
+``choices`` attribute.
+
+If a user wants to select a profile for a specific driver, they can do so
+by writing to the ``profile`` attribute of the driver's class device.
+
+This will allow users to set different profiles for different drivers on the
+same system. If the selected profile by individual drivers differs the
+platform profile handler core will display the profile 'custom' to indicate
+that the profiles are not the same.
+
+While the ``platform_profile`` attribute has the value ``custom``, writing a
+common profile from ``platform_profile_choices`` to the platform_profile
+attribute of the platform profile handler core will set the profile for all
+drivers.
-- 
2.43.0


