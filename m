Return-Path: <linux-acpi+bounces-9687-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A73D9D2C8C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CAD1F215F5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5CE1DDC14;
	Tue, 19 Nov 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XOrnoCeK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8B1DD885;
	Tue, 19 Nov 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036901; cv=fail; b=nxLtkrHJ1Lw756pvacd0/v4xgLZ4eTNDha/GoAvDyk3if+RMDIfWjF5ighCi1apEoXZWvFsJUbpiWQRiQbi7IAPhB9cRlXuNBPCLSIN6QRH33dSC1q423/fvw9EXm4PzVwsj/XuN73y+xNMspa9mTnOgAIPboDownJQwvOrb4TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036901; c=relaxed/simple;
	bh=/ijD+PUIhicssB7moXneLFJ/twRbt+uNOZkim5O1JiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6fhI5uzKnseO9/jhgalbbNdh+W36RcTgSHzZ5PHyaCsMdN7qQxKqV3+5WDJUBlZYtEDB2LKgh6U+vqF6yXcf54Kuvf3diKryd2h5VyxacnaBEeRe+n+g/5ThQDQHjFi8C8mn+Zg47avn81E5VXNBXa+2KB59vuAertICdFQyjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XOrnoCeK; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiS6MEI+dNMpYjeYKRcxJSuZI9092036lt5KuuHHPffiPJEkV4366uqilz7zReOcPhB4vhkp3sDwIHGGFwKgzp5RaLjKuYX5BbqBNITl0xWD4TlTGi0GqHyYuOQ+OgqCyv8bnx/LT6kfzIKwuKz6zjEsbaEZgqU88IxuKZg0fELw7iRMywtix4kR6pNVRsn1XM17zcv4PgueYCeHRoLXdVshlizFO9Zl1Aga/PFEkKFG381NeuROAxnN6RABteXp9RnOQdq/4aPUQmdujDJKInPzLPWA2OXLaHK4VihPb/LCSAzP42/RYNAOxSmxiFMNgxsP/ksgbh/WwOWLQCY8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AzDiAVdPZo1X4zMIDEdTxASEFf9b61AT6G4X2TX4TA=;
 b=m+h0ldZE69dK95mC8oXZo8UEz+ZP5Nq2g9F0qKikUtdzKudkTg9t6LNwVbGLtEUV69APLthzUFMfDMysitAbFfUF6X/PFjGF+fFVdacfniLR2ogrIwZQlm/NEwixDx6gwe8osk01su9lrlslWrHyAzmWrBcNTFGOoVYWPXHhkcE4bLOoICVhJoXDD8CfAGVxM2tZKEigOGKeIBxKVpjL1/t/TZhv5yHoKP4wsR159bdV8WaH8OShabC4ENFn/MB22oJ5coPyUAOjkYWQKj7TWRQvBYfLSIJu4Zut8rHN1LI8tv+9JZn+PPIqnsyHMkjGq6h2e3Z9wfOfcyFcWF0i4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AzDiAVdPZo1X4zMIDEdTxASEFf9b61AT6G4X2TX4TA=;
 b=XOrnoCeKMZnh1imad37NdUAs9yCRLNMvy6ypNHk0tRjH15qNiLFVwSfoe7XyWvDifbmJhMfNrzYPmBYZinkqAygPvudnLMLIrLv22zIN3eOWkF2KExCeJ97ivcXAsud3PTzYG1D0SfYZdw37USxuU+9UQ7VJ6GeBlXM1WNp9yW4=
Received: from PH3PEPF0000409D.namprd05.prod.outlook.com (2603:10b6:518:1::50)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 17:21:36 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH3PEPF0000409D.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:33 -0600
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
Subject: [PATCH v7 22/22] Documentation: Add documentation about class interface for platform profiles
Date: Tue, 19 Nov 2024 11:17:39 -0600
Message-ID: <20241119171739.77028-23-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c272c68-6453-45b4-46da-08dd08be9f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5SPm2S8EHlrzBwDV6HQmAmR21vVjw4TnDSN94dlnya9rhbEM/nkRuCxdAoUM?=
 =?us-ascii?Q?J412WxrjGiABZPKhck8vgbSiQ9ig4y+0vP4Jolpv9yRuvk7GSypaDAx2zypQ?=
 =?us-ascii?Q?geNucBK4QahdsUGPJ8EIZRWhlmA9O1yMzuypCoW7uKS6B1bnSr7kSl9Svvni?=
 =?us-ascii?Q?aGzfqulSqlYU57MaI6oIKvp3yMXm7ug/JfSb8OiL53e9JGkmrUVuuSgF/sM9?=
 =?us-ascii?Q?cPh+2mcgm2n08t+WsRxhGaYUnq6cXND0UU7FzAaB2S7x359dFSLUgdPCqScD?=
 =?us-ascii?Q?iZhcpjzJjf9M0qqJlBPMh4XU7xUMSiaAyFoNGgqXrFbfqcd6iR8Dgl+ELzWG?=
 =?us-ascii?Q?8Cy4VIci2IR2kpGPIQ1iM1y1uMKV+cY8mkR6m7hFwlsQOROAewVDa8xz3qU5?=
 =?us-ascii?Q?qQnxxd9/KEs+t7YRpibjVeeALz8Fw/oLPuKefGOYJhnynj80Ar6uTucO9BUU?=
 =?us-ascii?Q?Xi3g7meSl7o3nYZwdP+wQW5WZW2wxCCl1gsX0nAfPfWvmCXxFRihb3XX4azM?=
 =?us-ascii?Q?x4+ZVDLaxci7k7exL1lklABkvwt2/Pk5FCe1PSkZKRTfr+cCrJxFmFsncDQY?=
 =?us-ascii?Q?hatYTx46iXfQIqxFe4E33eXusy+wBlav/TUEFQ//kKzCv/9hwuS9xyVOvs1D?=
 =?us-ascii?Q?vDTHI+FTRt29Etjc4PbwVmWmyc5qiToIVTsq146VIAecqP7ZbTjSOFdNf1Hn?=
 =?us-ascii?Q?k9tkhPnSXn9ACqqjyvyReTlaaJ20UgLMx9/cOwVXp18oilFBCys+JJ8yvG8m?=
 =?us-ascii?Q?pdhdYQedr6YNlGYiYoYtSvpq/7MsbD+S+Nb5mYHppOW726gXKnLnL4ENv3Ei?=
 =?us-ascii?Q?MvbAsU2Qil71wakb6WZVpJcFI6HjGvdh4AXGHV+wsm9J092KGrLRRAy9p34U?=
 =?us-ascii?Q?+7LsvwTkZLk8m/V/89gLKKBVsx5jcimGxYS6yXhn2VKovMYJNyVECCL9rxzr?=
 =?us-ascii?Q?KLr+hmCxtfBbDiW1crSKqSS6YKPijiZc8GQJvpq8d8Ytu83PfrGm3xprBHHI?=
 =?us-ascii?Q?P3gr95YPjXM9mDyJxPBIyvqu5jmzjKNFTxyGI6QgPCdEThnSOhBpWk4kXae4?=
 =?us-ascii?Q?bbfhuc9BAAeSUcHr5DzZnJsVok/9/F/4bLn/NGKWMWGBrDOQsVuRlqmuRvC9?=
 =?us-ascii?Q?G0Owch2dP0MW8OtdS/IxyQesHJkNIBldmQhKlKmYXM3A0EJXgCvxuE5RIuAf?=
 =?us-ascii?Q?tymhRrYDz2Nht8XNer9BMzWHiJuxRWNgBt4nBB1e3ZVIA/WPeHrBuRwRr1Ha?=
 =?us-ascii?Q?IaT2Pspb2zZA3Z0BrquO49RjSW0QDzzHZgGmsAskVcgyO6pQZU6KWRhNgLft?=
 =?us-ascii?Q?fZ7WMxHdFe3w7ltRXGoGKz5DJ1sCNeg8FNFZs2FLMhr8Gk4FRNOS+Gra5PW9?=
 =?us-ascii?Q?XusFGBKgszOXqHs3gOZHcweWIhszjy5Blr8ZmVfMYsM4L4oLqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:35.9728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c272c68-6453-45b4-46da-08dd08be9f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

The class interface allows changing multiple platform profiles on a system
to different values. The semantics of it are similar to the legacy
interface.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Add tag
 * Add description for name attribute
v5:
 * Fix some typos
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


