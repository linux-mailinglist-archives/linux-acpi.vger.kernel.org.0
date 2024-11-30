Return-Path: <linux-acpi+bounces-9822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE289DF0EB
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14DDCB220C4
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A4B1BD4F8;
	Sat, 30 Nov 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8jwxZxj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BD1BBBCF;
	Sat, 30 Nov 2024 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975573; cv=fail; b=F2/MHd/KKqLcJG+4vkWxNI+bVbFeA2jArtA96SfpU1laxzrFQj/1vRVyrAIH7tWHErYt0HHWiPPMc3vxM4xRzibAFlGI+iLNz0OnVk+I37s/PYK2jp2TfuEI9FasRp9fXiAhLJsbtrfmgqSSSXLxfmxScbSvqqJMEmNqZYs6Nj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975573; c=relaxed/simple;
	bh=wf5rKNmIsnUUNoTwfFtQuOKmfayAw2AHgYGdmMq1vBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKLaSOr93m75Ck6Bfj6q2rIkw+/O/EvoMdmrLM1M95aHw+PJKsBlJsMuFrXF6/mOWax1p104fjcxJXTEvU7dQ49z7JX+7JavEaijlcd6NekaLEvsYo3tYJzqUSvMqnT1ZqsZhozkWvMNOsN7P3yxfOAVmkMSpg1ryNv6qp/SQmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8jwxZxj; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6U2fghf4qdEsfzbP/JNoIMa2QtSwi6CEBj+GqoixjD0zqb6qW88H9H5lt5yvAbnux9f8pu/9vBEXNClL8dKDFSp4QBzxgDdOBeG4S0tpVUjB9XMhX9y1hh9QJgcv20CauRAi5M9e5vZNWSkARJ1neCHdYY57PQJaxzEieZGCcLhy/byazqEwCtqivXD34WEd9g7TCfqu6K7+fzMJygGPn67HIC+dI6QQ1DB46u5+BL8FEKBODtRwiNYGgHTk/lZ3hKC/OnMPB/3ikURMlB6HdwWVyNEpEwGMX56uRMZ/6t9ueCzWyd5ZNOam6GBIbU7wwIuVKJQ5LenCTC4W+IEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7AsA2wn+UuDjCVQLXzWcZ19ajtJVFU0lsgjVGz13nQ=;
 b=fmHtdbvcAjE+OJE++mXLYNcswZBFch/i9j71LRVXW/aopEAe6snDilh3h0dCuMSmjG1xibQlSx/4iWTmM6KD5aUxpB4EXcpvHmOSYDwtbZKF5mQzq6YpXJ5SbI60eooDIG7VNUoHLjF/QYUO86PsZqY1EI0FF96e4Yc6VirKKIYjm9B9ujGiZZ9Yg7pY99HLIDQFQU4UpOg00MudGSndWKejlBK/wuf31UmXglv2iXneJ9NJ4Q45N+UaTuDl9VZpHrmKzC7oklZWPnPexEFxpoyyGmHQZ0fhY12e9uqr24hUSOzs9M63IkyVXer6QOMpZwqotyms2G5nJhbChy9n5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7AsA2wn+UuDjCVQLXzWcZ19ajtJVFU0lsgjVGz13nQ=;
 b=Q8jwxZxj5HOKFD367gFZ4ns1k9JEaeU9qmHx/KumKGdOFwWblsVgA+6k/mOurjfclWjS9h2WLAbFUTiGu5D66zQyYDSfNr/8Va0KuQG0VxZ6s6OJQIzkBe/DNenFQz53lbMdfUysYBvi6m3y0R+IoosrSA1ceLV6dg2FDu3uwdI=
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:06:08 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::45) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:06:08 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:06:03 -0600
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
Subject: [PATCH v8 22/22] Documentation: Add documentation about class interface for platform profiles
Date: Sat, 30 Nov 2024 08:04:54 -0600
Message-ID: <20241130140454.455-23-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: cc87589b-16a8-4bd2-18d1-08dd11482333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvvKAGSU1R22XhjCVdMHWjxtChSO6Kdk4bL7WXGvOcwKXznRApCyxMERqomk?=
 =?us-ascii?Q?ejQxd+GcV27Lhhwz9hQd8i7h4puHSMgIVIQJB4+mxbnxLyzKoVhJz6yBDRKZ?=
 =?us-ascii?Q?WL8J8PaoG3A7TXefTKeLeQnmL+qtvp/Nq6UnB3se6bwYoq8M1BQCj7mbpzvA?=
 =?us-ascii?Q?xZB5dn0M98UfYKnqaK03+3ZDAtN7b+V1qq1rirrJtNNWY8DdUls4csZXjbbo?=
 =?us-ascii?Q?BayBYQ7L/28isZTGxFmwcInQrXZfmHFYrk5JGITzx0ho14dnr8r3DyD4bQSv?=
 =?us-ascii?Q?nFIU9RsrEDvClKhygrHEocfFeJ/xNW8YGXO1avW/+MyIijlia2OuPENHnv85?=
 =?us-ascii?Q?D06JiYrXd4qOi85/g8GHG6aw7PdkQ1HQ260oif4s23y4cnsTicp+ug7tRcYy?=
 =?us-ascii?Q?yDLKX/Z/5zOtR7M/5EtS7kfeFk8dhuEwXBSvH6Esru9ZwhjzRuQsR7ZCSFkt?=
 =?us-ascii?Q?5ewR3qTCcbPQgIPKqUhECaIeLx9I0n9arT7coLxOywgoPoCfkqr1p5dh99FD?=
 =?us-ascii?Q?bLX5GEzzMuBot4BEl4rpFdvcpWTZzZJx611VnRuKbxnvdD3Z6zYbSIwVM2j+?=
 =?us-ascii?Q?J+FL4rDRkKFYrgST6gtPyeLiktHfhV17aMOvErdz08/wwH+rpByAvj26RCYb?=
 =?us-ascii?Q?WGuq2/1yUIpPDs+HDnYHmnlkCvCDLwDdojE+gBOz6rz/AcqifFYudjL0oo0S?=
 =?us-ascii?Q?EuXYTEEFjJ5EeQhjVDsQP/dnzvdNl2V+qVDtNwsAsFoWo0u6kGTa3VJQhBrm?=
 =?us-ascii?Q?PtZtaMVIa33cEKS6FBlZBC80yemIV4A4qZf+75KzVqGNxNs/1Y55XZF+5jt4?=
 =?us-ascii?Q?1O8fOG6ZKvZxfVjJHwQ2KYnzotRoEgARmzXGDLjh5/jrHI1umi5B/ZZ4eRPr?=
 =?us-ascii?Q?i92CZl2oHYwfycEEZWxjqZJTRROrtT/ASkdgd220kzQgHq96vc37DBockHQz?=
 =?us-ascii?Q?w1/on9ParbiXapm7818fuhPx5g/w9BXM2MoF9YHSpTP54qvFZdH9bb+tMSSq?=
 =?us-ascii?Q?fChdqdvxPelL8Flwh9Kzr5hu5+sTvTDtHLMB84fPW+ZP9bPVBYPCrtjHzz6B?=
 =?us-ascii?Q?O6lCf9vA/M2G4qkhNJVM/iMh9fT+64bZwZmTjxOII9BTnH+MhUR/VpYSjPTd?=
 =?us-ascii?Q?JVdJKx/32iS1WyQtG4NTELGmq5dnFp/wULXGtXYA0YrWoPhpdj7mCyeB1Yfr?=
 =?us-ascii?Q?OVFV+2/3sk/98eZW/RxN9T+k5Ipzyp7cLQOns0czuxwkxCXnz9BLR+PqVgu8?=
 =?us-ascii?Q?do9WxDWgz8SDXZkTe9BFSMwDl5a58KN19m3kMPwrDRTx5S8HVdTedtZHzOP6?=
 =?us-ascii?Q?avrUy0utyG1WkwttbW/B8qStxlO7txknt9azy/ddveee4+P5HxsVa/+K7Nku?=
 =?us-ascii?Q?xEjtIww/V7LnrtVUwyXCLnnmJu12px///hGozSXQeJo9d3D/sHuLQs8C6pT0?=
 =?us-ascii?Q?zA0a6bbtZnv2RnvTQK5ndELJ9p/GGzYr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:06:08.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc87589b-16a8-4bd2-18d1-08dd11482333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

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


