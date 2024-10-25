Return-Path: <linux-acpi+bounces-8991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4799B0EFB
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53621C23F57
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4112064F1;
	Fri, 25 Oct 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ai2mzTVB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14BE15B97D;
	Fri, 25 Oct 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884680; cv=fail; b=m9BNFCRPIoWx54ceuGdN+TqknxjxBiPgr3NzSMMKNB48WVuHhQEGOVFMuK2RrkQ0kKkOzKMP7b3nzloE1bf3H5s5OCnb9tSM4mS7pSERpBOHLWgL1Qba/misZ3/XydIwXmZGTsELndoT09anktcNL0fc+buG3acv3/OIp0Hiz5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884680; c=relaxed/simple;
	bh=ezHTV/PYaZYGIs0VkJFmPRRYtwDfJiCr4cQlb/Yk+P4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FH+TaHXe4fCuiLjFyLPYzsgIbKTvSOM85izPsOfbA9XlKYf6gcQQoHKaVGuW5WBjn7CqyrDKJ5tfeGhKMs7VKp2zbKKAn3OmuWDHgT6AW+lZznN/yMPz3k/OGEX2pmJoEbdCaBvFTDMWO+Mp5A/YTA5055UDM6Hb2BvK3Z5s4Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ai2mzTVB; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmlR06a4SeM8JUkQ7FqC+zxd4oc4iYOKySTObx4Ym9pAjNPmz9MiHB+xFVs9PbxMby3KlyOHWUT0hulpXc7WmEf6xfL01p2q8EQN7cCYnmGb2iJ87zHOGl/4ldgUQGzAI5BvQqQtUqaCTa8ftWwPYxQBuOmpFXpzL1VI70xbUUibUZF/we5BSbjPLIVhKCLlDYqDVg9I2etLTpCxz7OI15sAfmcOoicxynP+hscYvZIMPLRTdDS9jk59eOG6/av6tr09ECU3gwGLgBo4bDoCPCiG8/RkzQIgetNMHs38LuFYyp+ImKOkgBuxDUVX+kwwcjCqiCqCNNF/5PG7KFoUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weyLomKE7CRB7niSUgLHYkNbqa+ykBnTja4ELsCDPm8=;
 b=tUzUHo7gcD4d795MMuPNZs9GsGRzSFFxhQk6aRup15APoWaK9zDAE2/pky9Yo0D/Xtdv0aZJd7y4Yjy6DpLN9c2xt1GJe2EG86td/EVN0+1ayEFNt5gZG6fdsBTwNkMh3ZCHHw5i6TIQzNi19XNN5LRGF7LpPpLSZGudymx4OR1VjvvvHbwa1LDeDvym6laRcXjsx32f4SlqAAhYhDNi6xvyTAk+eaTzun8D1tMFuDeb3tbdWDC0kWMwOGN/fR9ZOFou8fHn4EFYUlnHR4brdorml1Sn7/9g0DMUQE8UG6GFVDQMpQN7IZckY0875jToHuqRSlBCsEUZKckla7hISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weyLomKE7CRB7niSUgLHYkNbqa+ykBnTja4ELsCDPm8=;
 b=ai2mzTVBVAEcQUGJILgYMpwcvudAttrry6vm4Vaww1Q41myFzj/Pqeb7eZqZAhuvs1+3Fi8oYbZpSzHa61+iSCIzwFvXcpWCSrjx9p0Be1HyIUNEkLvdFPJdifY22nf2iWltouGwocc5vRYXGKosLByQuXf0RcEOGn7H++ikKUQ=
Received: from BL0PR02CA0098.namprd02.prod.outlook.com (2603:10b6:208:51::39)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 19:31:11 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::f9) by BL0PR02CA0098.outlook.office365.com
 (2603:10b6:208:51::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 19:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 19:31:11 +0000
Received: from AUS-P9-MLIMONCI.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 14:31:08 -0500
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
Subject: [PATCH 0/8] Add support for binding ACPI platform profile to multiple drivers
Date: Fri, 25 Oct 2024 14:30:47 -0500
Message-ID: <20241025193055.2235-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 8669a073-f799-4771-9ec9-08dcf52b951f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eE+vcL5iKGVPXYJVYob384bZ2Eabofyt9FIaAQ1uNpFSnEJwU7sS92yDEaCR?=
 =?us-ascii?Q?jU5U62E4ln7lBzD8wDGAMPnETfRVKJ4gXzN+/cLx5PmsKkEG1Y3VicEA46uI?=
 =?us-ascii?Q?MKWqzJADwdudt8VslgKnmscAUgrBuGXxGIiwxtuWxBiDNHjWMrL+bKmUDQMY?=
 =?us-ascii?Q?Lr8bXV1ks1NpBRtRLfyB+wNQAID0UAE11jCi3sgQO0wtVNllj9VwLNGL16TG?=
 =?us-ascii?Q?OWyCoU2XQp0ceLt8hMHoSVyVqtPvsTqF6tXMe5BxWIywpXbCtmOxlfxl+j7N?=
 =?us-ascii?Q?p/mUwSd80FeLSku3EfXCgUeEt2TMGmkik5nCOyJwh+VZPWlrOigVk42+1EXB?=
 =?us-ascii?Q?Rn7K2SrOWXfosMUaG84u8NcIiQiiFOh16BRdPGbW08bznORea8ekcpkv67dL?=
 =?us-ascii?Q?C8FBYVj6eNeCT3Um6xnJsWUYxD/ycpn6KCqL/MK+0SUNkHX6IzzvqWteHcIr?=
 =?us-ascii?Q?2AdnJVlck3pdGpbCtJxfMwrPNcJHwm+I+JGG7RKlROUfbp//u6iJsbwejs5F?=
 =?us-ascii?Q?azpA7SuRpDMAjI5Hbyuoh1xBoANERMt5oNm7BAG9+VhNCgNF2PSCCs5Si5sP?=
 =?us-ascii?Q?IXjVUgODFpbXOA8A1hT9SDxlCQohlu+DeEL/TzCGzCzoZwcO/SK/BF0FqMPR?=
 =?us-ascii?Q?qAHyKR9KGwF4w798Mz5knrfeZceLNoFlwYEN02ksY9Z5QP/v1hRDmooHACWM?=
 =?us-ascii?Q?a4NGUn7j3Ru/YFnILSI4wik44mDaGVQg7N7zsPtUSdpNQ8mkIEhJGm5CeqjY?=
 =?us-ascii?Q?/fI3ogSWgW1FVyx4QtaFhZ3EYmovLsq4KPfS2fNuUG394/E3RV7q2Rg7zPS5?=
 =?us-ascii?Q?rR/Y5VDsZw9QaKDEaWU7heLCSG5czKSatAmScjT7WDHBts66k8mMx1oktJuX?=
 =?us-ascii?Q?BLOqwJcLMkWCXyO7Xi6DsvOwEd6YqnyDq5AvyVcNYd2b2DeaXxOxuZfgdypu?=
 =?us-ascii?Q?TRvfVOMib9djeOsjvQrUFu3u/bX0N4OH4lVE+Y5tq4W8mgp6B9x6Fqt+HIEk?=
 =?us-ascii?Q?7ftUhcAKSmT7iLac1o12CIqlx9Qx0SLXWU8+HnUgSxZmnvyjiy8kzHFlbmG4?=
 =?us-ascii?Q?rJG5Zpf+FoDZHctYHbG7oTRemPh0gAYylOaDTZX/5GQbdolNctjbbHiVBYvA?=
 =?us-ascii?Q?vAcvYopt/qeAfapoIQTtxr8hKs7hGDxNxZ9RJuP9SbV1UejCPx/96oPf2k4S?=
 =?us-ascii?Q?7COo+HLDg6VFi6Hs79HZjkS7wxuXOh7oeoYQwZBerIWJNBSKft7K7Df1kab1?=
 =?us-ascii?Q?Z+fwbs90WM3xqmOKuT1l+4i3TFzS4xlW9rXKw+WvBxScWLC7ve1Obgjnmoq0?=
 =?us-ascii?Q?RntaN3G5GFsp2u3rH6Z6r84fXyDVqVztztH3Mo47TT7GlR4J+z5ftMexTYkQ?=
 =?us-ascii?Q?sELR4fHobsGDt4AcQ5OyXztmPzG4MzA3kw4MldazM5n59yOOkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:31:11.3419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8669a073-f799-4771-9ec9-08dcf52b951f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949

Currently there are a number of ASUS products on the market that happen to
have ACPI objects for amd-pmf to bind to as well as an ACPI platform profile
provided by asus-wmi.

The ACPI platform profile support created by amd-pmf on these ASUS products is "Function 9"
which is specifically for "BIOS or EC notification" of power slider position.
This feature is actively used by some designs such as Framework 13 and Framework 16.

On these ASUS designs we keep on quirking more and more of them to turn off this
notification so that asus-wmi can bind.

This however isn't how Windows works.  "Multiple" things are notified for the power
slider position. This series adjusts Linux to behave similarly.

Multiple drivers can now register an ACPI platform profile and will react to set requests.

To avoid chaos, only positions that are common to both drivers are accepted.

This also allows dropping all of the PMF quirks from amd-pmf.

Mario Limonciello (8):
  ACPI: platform-profile: Add a name member to handlers
  platform/surface: aggregator: Add platform handler pointer to device
  ACPI: platform_profile: Add platform handler argument to
    platform_profile_remove()
  ACPI: platform_profile: Add a list to platform profile handler
  ACPI: platform_profile: Use guard(mutex) for register/unregister
  ACPI: platform_profile: Only remove group when no more handler
    registered
  ACPI: platform_profile: Add support for multiple handlers
  platform/x86/amd: pmf: Drop all quirks

 drivers/acpi/platform_profile.c               | 234 ++++++++++--------
 .../surface/surface_platform_profile.c        |   4 +-
 drivers/platform/x86/acer-wmi.c               |   5 +-
 drivers/platform/x86/amd/pmf/Makefile         |   2 +-
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 -----
 drivers/platform/x86/amd/pmf/pmf.h            |   3 -
 drivers/platform/x86/amd/pmf/sps.c            |   3 +-
 drivers/platform/x86/asus-wmi.c               |   5 +-
 drivers/platform/x86/dell/dell-pc.c           |   3 +-
 drivers/platform/x86/hp/hp-wmi.c              |   3 +-
 drivers/platform/x86/ideapad-laptop.c         |   3 +-
 .../platform/x86/inspur_platform_profile.c    |   5 +-
 drivers/platform/x86/thinkpad_acpi.c          |   3 +-
 include/linux/platform_profile.h              |   4 +-
 include/linux/surface_aggregator/device.h     |   2 +
 16 files changed, 165 insertions(+), 181 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c


base-commit: 1349dd7dc21c63c9bad0e91fd1bf5f1ada34b0e2
-- 
2.43.0


