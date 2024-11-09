Return-Path: <linux-acpi+bounces-9459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5C99C29DC
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7856C1F22C98
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE77A13C9B8;
	Sat,  9 Nov 2024 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYy1+n6J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4363BBF2;
	Sat,  9 Nov 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127346; cv=fail; b=pIfDga7EfDJd2IWPIQBOWhGsEYaDUJmEmMR4jyam+qDHko9WmzcawnhXg8bTf6keAD0/Qnm++xOTeMu4JkK1vJR+AR+K+BeWNkaMd5ENp9UsWENg2z1Snu8CgGL9a7i8tg6UzKnNoCX5lasdJROwnfxu7QkIRWM9FcdgkPHgZd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127346; c=relaxed/simple;
	bh=NIVfQJDudamk4kAdjZ1pFWmr6mnKOKQnOf7asbqfHts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MbW7+UbLBn4lZWkr3P5MIXNHcgudpWAVQz0YDgb1O0U5/6HZCvBn67CROLenwgSx8eJ5gAZIe6fqy/NpjtMvmWM0xIMKuRicpzpd+btYfono7+l4VLq544MY6xAoSYRt1Kpf8w02ahMDHCe9yjdDqnKT1uIVXQ84IF0ctEwSAvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYy1+n6J; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5Y6Dqxc6AXJ5N3c1HtIylJ22+BrbdehOD0sXFfrnPRCaTadrG3MfAy8VpVMoRb2mg14dtpY8POxpQwCF9PQYmzlCKYpjmCz1cElZvSRGv51XyutNDgQCU8BdeFzDQS3jx1SZ72LNrE2IptNwOpyvvdso/+zISavzEEPAnHF5R9gF0RsPUBFfG0rbiZ85z4+ElPKQS4X8UAfTrRKYH/khv3UIPZanOfMfcVHxrhMg0KJdh2zNiSuD8ZEyY8Sv3xqFqozWutpw4OHCFHigOS2Cy/ygxH/rtgOo/6tvfo0k0wri6pdmshHDnAzP1tBSOCh4x6m9UTQtPAuT2ZBQ89o9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTlb+nhgKaUeVff1RjkbqoKhPCcz+Ro2cOyIq8tRrUk=;
 b=FhlwbqbRJcUNEs30CPNM/BAho8FK8M545a6fIenShf7+NbSkYjmCm7gnU8vrw3XucCt5B++vPTcXJ5RQCAm/yVixJqMh2qUpId3bgO9DnARXJlH9HpCJWHgSuTPjB+5trSBsfmcO1Ez55mzZLbPakgrOjKStqjfhmpOpy6U6GKtgnOMMUJ7GOmTC/V7ZfT7CZqeWRdmSdjtMoB4lWhg1SJgiGouFhgoFyjXrLlHnuCtUx3AZkZ40rx3egkQzTgi2M2okYbhGJIGUm+FPOAgOnwECOM8QlC3daSIwqiQqPwZJCEyxJ/ThPQB/OFcTb5KijjUq+suSFj/zEeHpq/wDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTlb+nhgKaUeVff1RjkbqoKhPCcz+Ro2cOyIq8tRrUk=;
 b=YYy1+n6JPhc/OBvEsDxrsTMLD50R3k8xahT8JV+iS5P9sE0pK4wZEnMhynbE2O7SwTN+7Br928Ho9aETRzS65FHfusvXU2s4uFOfHH9wGUsOT55/aNoF2zEasaduWQZPkOxq+2k8YDbTBuQgR9m1GnRtR63I9z8D4K3J3l/gin8=
Received: from SN6PR04CA0080.namprd04.prod.outlook.com (2603:10b6:805:f2::21)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Sat, 9 Nov
 2024 04:42:18 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::54) by SN6PR04CA0080.outlook.office365.com
 (2603:10b6:805:f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:18 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:06 -0600
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
Subject: [PATCH v6 00/22] Add support for binding ACPI platform profile to multiple drivers
Date: Fri, 8 Nov 2024 22:41:29 -0600
Message-ID: <20241109044151.29804-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3739ea1b-c6bb-444b-5387-08dd0078e444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVBsSkFMZXNZRUx0TGRDenY1ZElCWEw1S1hrR0hESjR6dDVLN0xnMWx3aCth?=
 =?utf-8?B?QUVTaUtwdFhUUWlHWVpHcG5FMytrMHVlTWE1VjZoVTJldzAxODFxcjRvQXBU?=
 =?utf-8?B?N29meUdIc2g4VEJraDM5VFk0WGNrVFNkWVhxVWFpMGNYRTZBNGNlWmtvaGVZ?=
 =?utf-8?B?ME55V0JEQjdsWkRyL2hLM1k3NzRUZmJKaENsZ2UrUmFTdnp5cXhIQm95MUti?=
 =?utf-8?B?U0s4RnN1VVRZV0tMS041dHBRWEY4YlN5N2xhTVJzNmFMekkwRG82V3ZGN0RL?=
 =?utf-8?B?QUppT3JzZUhWMnB6OGo3N2FxUnlzYmd2dEgzcDBldFo2cDNWYUFQR1NFaVJo?=
 =?utf-8?B?aFp4c3ZMaUMrTUV1TCtMajFvUHhPVzlzaTZHWDcycFpueUVETzYzM0pqemNV?=
 =?utf-8?B?R1F6RzhDaUZLOEFrNVJKSzJmS1lpbjQ2YnNBNWZ5dXhLOWZ5bTZ1eHBxOXdw?=
 =?utf-8?B?WVpYUGxsRktOUkNRRTVMenNLNzlGTlB5M3VQc1d0WWpKbGF3dXpTNFNWdWF6?=
 =?utf-8?B?cjR6SStYenhCSDI5aU0wVElCZzkxK2VpQ1JXT0J6eDNkcStxMGxuMEtnWjZT?=
 =?utf-8?B?ZHBJK0k1MGY0QlJNVWw4bit6ZHEwblpmOE9ldlZYQlM1N0VZT0FWczh2QStp?=
 =?utf-8?B?UzU1bHlmSkRPczZ3OHQvMnluL3kzdmJSTGI4SmJuaHdEWXZ1UWJwL28yRzhZ?=
 =?utf-8?B?RHRoL0g4ZFdvd2g1aEdybjdUTk1RN2hZNm9kTXNMS3NabjFXQnNiV0RBUFMv?=
 =?utf-8?B?QjkrbElKaVhMZzFPYjFaQjFueXBxQjhIU1A3QXFMOHlHSTM5OTlsYWpQbzd3?=
 =?utf-8?B?SFAyaVU5Y1hDY3NjQUxabkpmQVhWdTFYRHJPUGNSSXBKTkgxQnRjeUZDSktM?=
 =?utf-8?B?ckFIOXpiWnNvU01LekY0YzBQNlV1d3p6NjN3VjlYM0V0dUpUQ1c0ck0zWnpJ?=
 =?utf-8?B?RTdFSW5XcGl0WVFaZjFoa2x6aHB2ZTlrWWJwOGRkc0haMk50MnZIcmdtK3hV?=
 =?utf-8?B?YXlYNCthb2dEaWZvWUdmaDZVZk5POVUyY1VJL1VCNHdQT0l6UVROWUZGTklQ?=
 =?utf-8?B?ZUU3N0d1T01uTlJlbUZxN0FFek40RzhpUmlCUENuVzB4dDlnZVNaTXJjVUJv?=
 =?utf-8?B?N2NIejZsYjNuSG1YV3kxMlBlci9lNmM2b2RQMW13UHkvT0ZoU1pSaTRObFBW?=
 =?utf-8?B?RFlVendiMElxc0E2ck0wT1cweG9JdDZwb0E0TngzVWl4ZXpwOHlmbUtqODFN?=
 =?utf-8?B?Y2Yyc0l2K0hXSU50QXg5YnlreXR6QTJrNm1QTUZTSUNGWWxabE4yZzQrcCtO?=
 =?utf-8?B?YUU0clVFd1BFOEY3QjFNc3JNRHAwamE3R1VoNUN6MkljTUZ6MG1xc3BBSW1r?=
 =?utf-8?B?T21DUjdVTFVEekpmVGhFNUVwOGlLUzM5LyswZUg2N0FuaWEvby8rY09ZdUVT?=
 =?utf-8?B?Y0pxOVhHenU2eHY5R3pTWnNpU1MzUExHZVRReHA4NTVnU0xXSzJPNWZ6YWxD?=
 =?utf-8?B?UEM3UkRLVzI2MWZRSnVtOU9yL05mY2dwclR6WVJwU21KcnpKM0doenMvV2gw?=
 =?utf-8?B?b29kcTBMNTJyZ3VRZmtGQXQzNUNJWnBGa3JZT0lxbTYvbTRmd01hK3c1bUx4?=
 =?utf-8?B?VktSdUxaOWlWK1ZBNnhzazRtcmhBYkh2czFmWGt4VGxHWXFoNTVDU2RyOW5n?=
 =?utf-8?B?UkFuZGNnbmpNSTlKL3EwNkljejBEakF3Mi9hNzFSNXZEK2VBUVd6ZXg4MzVy?=
 =?utf-8?B?OFhuR2tSVTZ1d1VzQzNvK2J0a3dzN2JxczdMOWxVYVA5aHNwZDZIQ1l4ZDgz?=
 =?utf-8?B?MHVUdzJSNFAzbDZIVGdVbjNvaGdRamdJSFB5ZVRvOVZhNGZIRVdhanhodTlE?=
 =?utf-8?B?SCsyM2N5NU5adFpHQXlmRlVLMVk5RE8zZVhJWFEweE4vUEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:18.1455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3739ea1b-c6bb-444b-5387-08dd0078e444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

Currently there are a number of ASUS products on the market that happen to
have ACPI objects for amd-pmf to bind to as well as an ACPI platform
profile provided by asus-wmi.

The ACPI platform profile support created by amd-pmf on these ASUS
products is "Function 9" which is specifically for "BIOS or EC
notification" of power slider position. This feature is actively used
by some designs such as Framework 13 and Framework 16.

On these ASUS designs we keep on quirking more and more of them to turn
off this notification so that asus-wmi can bind.

This however isn't how Windows works.  "Multiple" things are notified for
the power slider position. This series adjusts Linux to behave similarly.

Multiple drivers can now register an ACPI platform profile and will react
to set requests.

To avoid chaos, only positions that are common to both drivers are
accepted when the legacy /sys/firmware/acpi/platform_profile interface
is used.

This series also adds a new concept of a "custom" profile.  This allows
userspace to discover that there are multiple driver handlers that are
configured differently.

This series also allows dropping all of the PMF quirks from amd-pmf.

---
v6:
 * Add patch dev patch but don't make mandatory
 * See other patches changelogs for individualized changes

Mario Limonciello (22):
  ACPI: platform-profile: Add a name member to handlers
  platform/x86/dell: dell-pc: Create platform device
  ACPI: platform_profile: Add device pointer into platform profile
    handler
  ACPI: platform_profile: Add platform handler argument to
    platform_profile_remove()
  ACPI: platform_profile: Pass the profile handler into
    platform_profile_notify()
  ACPI: platform_profile: Move sanity check out of the mutex
  ACPI: platform_profile: Move matching string for new profile out of
    mutex
  ACPI: platform_profile: Use guard(mutex) for register/unregister
  ACPI: platform_profile: Use `scoped_cond_guard`
  ACPI: platform_profile: Create class for ACPI platform profile
  ACPI: platform_profile: Add name attribute to class interface
  ACPI: platform_profile: Add choices attribute for class interface
  ACPI: platform_profile: Add profile attribute for class interface
  ACPI: platform_profile: Notify change events on register and
    unregister
  ACPI: platform_profile: Only show profiles common for all handlers
  ACPI: platform_profile: Add concept of a "custom" profile
  ACPI: platform_profile: Make sure all profile handlers agree on
    profile
  ACPI: platform_profile: Check all profile handler to calculate next
  ACPI: platform_profile: Notify class device from
    platform_profile_notify()
  ACPI: platform_profile: Allow multiple handlers
  platform/x86/amd: pmf: Drop all quirks
  Documentation: Add documentation about class interface for platform
    profiles

 .../ABI/testing/sysfs-platform_profile        |   5 +
 .../userspace-api/sysfs-platform_profile.rst  |  28 +
 drivers/acpi/platform_profile.c               | 537 ++++++++++++++----
 .../surface/surface_platform_profile.c        |   8 +-
 drivers/platform/x86/acer-wmi.c               |  12 +-
 drivers/platform/x86/amd/pmf/Makefile         |   2 +-
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
 drivers/platform/x86/amd/pmf/pmf.h            |   3 -
 drivers/platform/x86/amd/pmf/sps.c            |   4 +-
 drivers/platform/x86/asus-wmi.c               |  10 +-
 drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
 drivers/platform/x86/dell/dell-pc.c           |  36 +-
 drivers/platform/x86/hp/hp-wmi.c              |   8 +-
 drivers/platform/x86/ideapad-laptop.c         |   6 +-
 .../platform/x86/inspur_platform_profile.c    |   7 +-
 drivers/platform/x86/thinkpad_acpi.c          |  16 +-
 include/linux/platform_profile.h              |   9 +-
 18 files changed, 553 insertions(+), 213 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c


base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
-- 
2.43.0


