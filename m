Return-Path: <linux-acpi+bounces-9316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C09BD0B0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD441F23351
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7301E7657;
	Tue,  5 Nov 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SzZ8RUfy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D439E13C80E;
	Tue,  5 Nov 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820839; cv=fail; b=cJRXgwcooCVAb+xukJaM+87ETDkIXG0MsKWy7S0mdkzQzeAD5b1aAPjNbvX+bTNvn3yhfSWK33JuKDfZf4fw+lngio/u7XIUfj9HExT1B8B7s4AZPrZAG+0bgZED20F2+A/1xAvPHTo6JI9PYH25+0YLP5qbs8KcGYo/Pm+FCco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820839; c=relaxed/simple;
	bh=h7UuvL7RUVev5uvHZ1pWhoJtMToiKFMIm87x4l/APr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9GUdiYSnZrgRuqprXMAh0xuEMEOywm8mObMy5qi/QfW6DaOVOAV2HS0jd4lFDzrR2Bs9PPHNhmv9LIdgDuGEj7g7BtXyYN/VIpWnMOLRTLnTxbD+QKKXXEBbzEXBZyvdx5xjxYM4xiVG58ekQl+Zr3V4+CI6aFCRmSvRLK7rFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SzZ8RUfy; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5ernT2hQbdDpwlairVTdve6Bk17pimXLIRzSvdXbYsJH/m1NFVlu8oNjFrTLgNuyqLsSH0IlIKJpGPO6GlYHjHrcvJK2zpPIs/iwMc7Jalo+UJKOWLgaIfacoKj0sY8IxndKROq1kbrgtCFC3qj+UIJjT8o79VlRhdv0T6ZoUgOhsG7HaOISvAtiE0nMVi8GiY227NjgKdTihqSTQC++yplYGh78Fy2WDNQ1KixZqHoweynlFducbIJ0g1WVxF2Lo1RELanHJ+ITBaV8fUl+nryJR/bhT9Nwg9Cv38Mts7Y5u2MopdFW+Ir84+SNuzDuqbCBJLkPjAnCJnEMEHbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBtBAl+R8h1wq1/q1GN+IGXuNYZqj8oUNSJT/F+/2mo=;
 b=KcCkkNbv7PJ8R1obLEZonVVoVkNDVIkBZiJDh1l9l8/jZCbq/H+VfCzon6fiNK1nvu+gyFeUJYLJDffIthgD8RJ7NXu/Dm482LjGouQzfYICxp4ZzcF/W/RF3hAY1T3CwKC66ag+k2yiBZCWr72f550/jHT5SexsxK3FnYkBGOsr2SIhqFSroRRYo3SK2h6k2PNUizUPcd40etU+YH6nE2Sa2MJ0sXBzgZyxVXMKbhawWBc0jq2qM3Sj0J3XmlNsN5h0GEId3CQC5Jo4T8OuM9m6DSqzy0c8lTDOlkt3mPErlwuXfs9KTgoXgPPIySS7t/RB4JMP3bQFokh07C0qcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBtBAl+R8h1wq1/q1GN+IGXuNYZqj8oUNSJT/F+/2mo=;
 b=SzZ8RUfyhfewU6Z7l/kehJWdTG5KbgzRZ5ziIBcAU+VxLh5tXiwbZGj5YTtP7RTDO1TdpQCYbEgYAq+4R9JCfu3HPyYhF1o5GMWflRXM01eGV+/vjGPxE4F7KtWGUb2AEWD3NGLD9MHTSEMy98Bb7HevNLyJhOfXWP/sQBEqXe0=
Received: from MN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:52d::12)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 15:33:50 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::a1) by MN0PR04CA0007.outlook.office365.com
 (2603:10b6:208:52d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:48 -0600
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
Subject: [PATCH v4 20/20] Documentation: Add documentation about class interface for platform profiles
Date: Tue, 5 Nov 2024 09:33:16 -0600
Message-ID: <20241105153316.378-21-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 0990ddf7-7dab-47e6-a076-08dcfdaf3f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wagLuZn1eNsKJwQz06Tn86jKXML0XK7wQOljQiiGeP8Ix/qul8kt7oR1dGU8?=
 =?us-ascii?Q?Nhuc8MQB6ZnskbzU0gRPn/reDzr77XDzRM3XTNTMZ1hvmmd0+e3rui/NB74x?=
 =?us-ascii?Q?REZVTir8PLjxHIlW89l0+BPnhxWcbWtbash65mwV2GOJG7BUUGvW9nMEN06y?=
 =?us-ascii?Q?AxZ4M5hqGrAVUbrTIZNqmJ0vd/NsiAd/mrGdaKSmEodu2aZjg8hFnwq0ReSi?=
 =?us-ascii?Q?1bVNAsiAj1AEubdE3aO27P1jToBmQCdwx5FsZH8D9VAocZtQmeSUWjxSb8/X?=
 =?us-ascii?Q?rHoZqXhNq7stgGyeHcvHMKe/LgSeOiNOO3TwKC56kQbpqEMP1EGwvl92ZJuu?=
 =?us-ascii?Q?OdbuVYwLbjltZQNwsY2JQ2pQ8l6DFpol0JccBUCpeyi/ODuj9vDb+3EFZe44?=
 =?us-ascii?Q?RaylsupCgmCAgPnaa6mOH9drX7aAFLoOZwGlnFgoW6p64NGvBELX1Z+QzNL9?=
 =?us-ascii?Q?sOz0/sHbkucVAPQoxlm2XFtqC3fgMnNTLpv0/bWGbjzMEBKNGkWIqdzRXC4v?=
 =?us-ascii?Q?SxPhqRP8p1ZHUpw3TQKY+soprlC4YBlYc+C3ZSgfo0wfvoTdP+SZgA+VUp20?=
 =?us-ascii?Q?J2gBcehmxLzoBfcwJ5lNlAHI+u9MJhvBo2kRCL0M5OaA8sttiFp8E2vw+ajL?=
 =?us-ascii?Q?HZNeMEer7r+czgQH5IJDUTrC8ogBH/gqToWXc/PYQ9GsessinydyH79/Fz4+?=
 =?us-ascii?Q?N5awLYJepoUpmEM8917htSj921zTlc03Nq1LqeMtvAhvhpaf+d/0pcixzk8+?=
 =?us-ascii?Q?dav0musK4NdW2TfNvt6OQ+XNH9CpahdfUaMW6DG2FfMVzxcXnYNeMB6yYmC1?=
 =?us-ascii?Q?s6tphxVowWsIFex6MKAPb9EX40HnWUBS8r1l5nzy7gJkg4pJznwBR9X55e8a?=
 =?us-ascii?Q?EPjG/R1gAaqDIbS4mEBtKea1dp9JLiUdNv9P7hi6WekDYKD42a2yff6Gaf2E?=
 =?us-ascii?Q?3ZB8GT2bjYu3S6zkUA6HIs7JpDlyj85OiwbHplcrmVVbgCC7i9Z0rocfbuaW?=
 =?us-ascii?Q?ZGbqfTKH1Z4MkRVIhONFcuKkb4n7F7seViwBdtM2yHi68YRDA0/4RYn/wxsT?=
 =?us-ascii?Q?/ManpboyMconJDMuKah0FvfncKK9clTzEqKASrBZbf330UQBbJosJ5hYkefl?=
 =?us-ascii?Q?+ues8oOWKqlsJ0DKPLNSg6n0j2Vf1TtxwULx5Y5lG2VQW3PhHr1sDitHmInB?=
 =?us-ascii?Q?0s9ytZSpkxunGs8LOVBce24/i6PF9dFf2fXtUb6m/QO8mRR/AcSKsRhVWF99?=
 =?us-ascii?Q?2Ep7J90TAoW/5pkuNU9Hf/2RNw4W0GMvASolP54tLJwaE5CPQiQRwoMe8kuC?=
 =?us-ascii?Q?ZDqHfh9LnecY+9ovJeT+u3hYTc89rhfoG1i90MI6wkUYI4dKtNiQVoU76SRW?=
 =?us-ascii?Q?uQGdjPOgEM1w3PX/MXsSrbOQAiR3BDYTAegjxDvNjmiyfYQ8Iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:50.0922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0990ddf7-7dab-47e6-a076-08dcfdaf3f38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504

The class interface allows changing multiple platform profiles on a system
to different values. The semantics of it are similar to the legacy
interface.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../userspace-api/sysfs-platform_profile.rst  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 4fccde2e45639..418c61b096304 100644
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
+commong between all drivers to the ``/sys/firmware/acpi`` interfaces.
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
+same system. If the selected profile by individual drivers differes the
+platform profile handler core will display the profile 'custom' to indicate
+that the profiles are not the same.
+
+While the ``platform_profile`` attribute has the value ``custom``, writing a
+common profile from ``platform_profile_choices`` to the platform_profile
+attribute of the platform profile handler core will set the profile for all
+drivers.
-- 
2.43.0


