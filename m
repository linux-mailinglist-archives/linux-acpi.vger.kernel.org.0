Return-Path: <linux-acpi+bounces-9867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2909DFA89
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322DBB22883
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7811FCCF8;
	Mon,  2 Dec 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g2NnIKfM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D32B1FC7FF;
	Mon,  2 Dec 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118736; cv=fail; b=i7SW4ORqejgPebpOe+yTtJ8/Wan2nfsXCzoxkMYeAgV0ZxapUscKz4JiLifowRZlwJKWfhVSUr4PXvL+4yv05y0toQw3XClP4umRixpNtqNehW+c963Oi+1V5EpW6W/QBvHirno7jzj3MQU40MFjmqmhuyUbi4ZWWabdspTltOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118736; c=relaxed/simple;
	bh=wf5rKNmIsnUUNoTwfFtQuOKmfayAw2AHgYGdmMq1vBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f04NNqWJO8+W2UpVNLnUCly84baHtQmlUPLhjTpcLYmMdaVoXv1WraqAuAsrIrXI6Fv42ZMlySqzKwfqlRuu+Nd0NGqoBMZ5Ve7pFyM1tYkjdz3lL8XMuVy9JxBjxUu2Sw8dtdNVW//IOxYeeMPJbQwUyMB4LjoB1gsVUK5EscU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g2NnIKfM; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgMyCtM035mUk5MD3qSOujVM0FyhZhsCbwn7kIGkfXHDwPn91EvThXWEkhRCizinokvYn9piMWFJBKixfRme5D8flCrNbBnUuJ4sqM97qMhqcYz6bFXYBJrev8CWjx4/AnaATUkzChe8bFQGGK+rzCu+FPNfymIhPpMnx2DrlZFPN8JM+rBAJ9i+9tjeV9+b0r8kYKgQ+xzQmF9KLynmD3ouHBI9DEbU6IWsu+F5b3pv7S5+dqiBFhqhbQ7XOVs3K6C5S+9/M+GJ9AuudL0YmAHZRfaxsPo+hp1HFV6LxcXpGF4z+/tjv9uBrvn/R5ZRQpcG8uBYgmx/2xDzwNPjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7AsA2wn+UuDjCVQLXzWcZ19ajtJVFU0lsgjVGz13nQ=;
 b=EZEEcR1T+VRMhhVyArlTFvchsnkTdOuG9efdpr6XDZjMZwdYW2Bphp3qSm9AcIP7q1qFp4Ipf4ULQIEXXUbs7aaT8QmiJ9IuZhS/5+tI4he6GZ8KZjJk4FHgJs/M3qoMqpzYiSK3giyumGGaEGQYPOTUXsNXZmnoQd0Wadc7UQe0yOVv4zr+qnV70CqWUnQlgHfB+lnJMrid4hgGnYLupPXySu1s+8SUbP2KFqzyRybPktxlsxctn/BZO8jpZpGB6xgBqo8lAXkw31d+jTSJj8r6nctNjRDnOC1+F70pYLB9xX96xtpAnE+tmCN0L5qixbtcIEWXxF5GBUUS8krrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7AsA2wn+UuDjCVQLXzWcZ19ajtJVFU0lsgjVGz13nQ=;
 b=g2NnIKfMuN6JD9AjbJpdVglnD5kKsgHDwIV0jn9EEX8+Q/4eMS5jizuXkdH0oRlFuP2kLzuebbX1jwQBxJ8+wgzgxZr28KGd6m2BBLRmEycwbwc1bU/batAfM09C86/AcQImMV8gINFQT0h4nEkQ5t7yCevuGLEp+m/8mb085E0=
Received: from CH2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:610:50::12)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:52:10 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::26) by CH2PR16CA0002.outlook.office365.com
 (2603:10b6:610:50::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 05:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:52:10 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:52:07 -0600
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
Subject: [PATCH v9 22/22] Documentation: Add documentation about class interface for platform profiles
Date: Sun, 1 Dec 2024 23:50:31 -0600
Message-ID: <20241202055031.8038-23-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2688015f-fb79-4489-fb9a-08dd129576a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X2EFd16EQYTgGDqcT4QNzfxkPqgb1LiWEhplhWM7cJcvLhvQKqgiod50ex5N?=
 =?us-ascii?Q?Bjpcv0C06Qt2AD7uvIb0Z/uq0Bl8fdSWwxcg5k9mDhBNYPuzMoMkzCSpb9fU?=
 =?us-ascii?Q?cWXhcmE0X5y+S6FD+9lC7KxBfbwaCZNFm8Tyc6u6z/L/+1KkBU2QZNaAmrtR?=
 =?us-ascii?Q?TYzDvmzwOucQWTzOfgojPGh9t/JO5hmIn1gShBY/XsS1OKsh0g+rqmpMVpjG?=
 =?us-ascii?Q?A5t4U3NwnZU94Q+fAICYCcgG0C2FkUZxeh5ec/D8kk+x0BSZUpFglBO6N2TA?=
 =?us-ascii?Q?UEKv8MHGKOzl4sSrM1oAYbzu5E6hxQNRYoMJZXMNfRLkrdI8vW69dy5oe30h?=
 =?us-ascii?Q?4jg2SB+TMRNbB1wU+kxm/xDSAGRHRzVy37EGmC9PvpZuAZmmKsUpT/e7nWKV?=
 =?us-ascii?Q?OJt8QEYrcKDPGS8d+2SnIuOQMiCuwh6Le74HqTpLH4oLJrvNgRo8/wgItguQ?=
 =?us-ascii?Q?fNZYwyUjziOWTi9izTTnnlwhK5QVl+jadEo9IqjA9DG0qLr2shKLzjHoEaa0?=
 =?us-ascii?Q?2O+LHysfqDbmp/UEwADHDymvHg0Pke5Yq7zd3UHucwBZ9BTD2Q4IR9Lbo2q4?=
 =?us-ascii?Q?Dch7Nome8ycVG7PVuEjCoZh2DXHZAc2BDB9simMv09I+FC0OmitxyNFHYl5O?=
 =?us-ascii?Q?daaTdcScTw9QfpTuTlc7YSkIRKvZ+AuQkgj9LZTVuKIcWMZ9CNobwWGqCr7T?=
 =?us-ascii?Q?kHv7LsOBQafxPlHcNaoKdHm165M8tKatOS54LWqAvbF8c1iykVatbKFhCCAL?=
 =?us-ascii?Q?Y3K2v6MCqodbcgB188l8USoj3hwXOwz80UtRYiz8bI5cRCCvtxn4mcmFhQQG?=
 =?us-ascii?Q?J1R9TPuQ7aVuFIvRK3NKocsGWKDRrIdQ9iARxMmIjCIJh21wgm7/iPvHYq2v?=
 =?us-ascii?Q?AC1peOWZH5ci3nQ4VMp0t014hQYK7sZhtIrZVCztEjea+SmOVq1wqyrN/GsM?=
 =?us-ascii?Q?K2OapNkjnnuMpN/7iQj7Gazpn9FDHSM/VdsPT6hIqdrNSqZbr4y3E2rfIl0C?=
 =?us-ascii?Q?M66LrRtPzxlQ+MYB4OgV+cyE23wZIV8IDn9BvyfzorKSPaXeqSRhmSvOACUa?=
 =?us-ascii?Q?moCQ64P5yETPjTEiDk3Xstg7kQzn6Ra9qF3pRqkSsWC9l9dTZt1K/ecsxnZU?=
 =?us-ascii?Q?nBZA0gig7S+cBMhZWxEv0rTQdguEX+JjpXVBo0bJEyjjHIvOGlCmbyuPxngX?=
 =?us-ascii?Q?zNhSPKhLtUCvgddtOHJ2gUP6jn9TTdjpgx9qGhkvyQMQXGZuV9APAI/p5LlU?=
 =?us-ascii?Q?9fDQgxtbZcXX7hdgv8n+x6IWcwmMIm2k2rxnoxsHDU2qi4Du1uNtntC2P+th?=
 =?us-ascii?Q?2FWPwfz40VWEAYF6L/o6F4IKF64NpWYkr7nMIJehDE7Kbyv+82wH9iUVd0Do?=
 =?us-ascii?Q?rpNLqntBRr/UP1bux6RINNND4NBPpDhIpLb9uGe+PnKFwlkvtzivuOYfCaKN?=
 =?us-ascii?Q?iLeoebVT7a0aRPbHCJbgFdNKsQfogFRy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:52:10.5426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2688015f-fb79-4489-fb9a-08dd129576a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945

The class interface allows changing multiple platform profiles on a system
to different values. The semantics of it are similar to the legacy
interface.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../ABI/testing/sysfs-platform_profile        |  5 +++
 .../userspace-api/sysfs-platform_profile.rst  | 31 +++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index 4fccde2e45639..0aa384c75095a 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -40,3 +40,34 @@ added. Drivers which wish to introduce new profile names must:
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
+To discover which driver is associated with a platform profile handler the
+user can read the ``name`` attribute of the class device.
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


