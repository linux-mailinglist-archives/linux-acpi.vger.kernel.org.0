Return-Path: <linux-acpi+bounces-9845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317669DFA45
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FDE281813
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF951D31A9;
	Mon,  2 Dec 2024 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j7PUNoHa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309E23741;
	Mon,  2 Dec 2024 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118667; cv=fail; b=crJhQijbJOLiDO34i01EnJHyke+LfXokP2WYTSBdQ5bV+N1LZateQe6oF9R3ZLAF0GFIkdFr7/lE9K2eLSFBEftVO6D0b8RtBF5dehG3HbHh7kpWbEoWXGu8ZYsctdTv/WyI2ZWFongz/khw+hL9K2Phb8gE6yiE1QNT8htI0os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118667; c=relaxed/simple;
	bh=JlHiB2DQ6hHyb7Bft/37NzNFmeswk1l6euONOkiEOr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HSpxHAjdqsK541ZjUO22ZeySrYbolnaZeSVNWFIv17FzuHpDhmroxf1HodOnREA91ZQnPLyw+BEYOvZbZwC7+zvej6S2/4W8SP5Hh2uIvUTVyWnYwXxVDe75sYGsNCn8wOLa1uOUA/56YvPOD6QhAQnRXL8aU/+WYmGt0kYBZkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j7PUNoHa; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n713hDY/X+2vTiZkQ2ydkTczy7Arw41lFdFX0CnZxsIqUppmkNQSZ6cMLyvnwSFjVIzjllAQ+ZxnWyzhs8AYpqZjaMtW71F+7RYZubLi/r9J1DGtvimEC+88u1c95rChJTxJJoUCtC++VbcFAs583tMo9i8NK03LAMpk0Kk54tPejKJZd5yNtHzwHzMOxyJJRF190+dWdNxfdP2uWnlxWXS242AcAcfGykB9xTByM+5AVSOLr8dON7TozdJ9krnyBXeR4dhGZBFoZT1VtZEVsxdZB4qVqX7wPINMiVgaxzkXuXjQ8iRxVZbOfZyGfsNMxqa7a8JXMCCd9cD5Aw3duQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cvym9LTpjapT8AXR8nLXDhBuq68mHEweg0u8b1oxSY=;
 b=IuW6ExNouqjZVB+BsZUgwzY2gHrlSrcnzBx2JkJkHEWCJlYdzOZcVtb2NVFdIW1TJ2/CC2AElF+4QMuKovdQN6Rp+v86enTrBOCvPMIQF3OXgofcjG2dZ1s+4FI62VkIoZBWcMVrPhrgxj+VrVCYl2zcsAJK72oqrTwp36BNBGSsoE4ZglfoEodR3ds3RaI1FMjezP7kjU6YoaaEvD3l5aIjXRCtH+fJ6wgl2A5U5mCZOsFRH+YHnhQOAyL3zchnIXMOpYVsAYq09wyjjSfaUsbtEc2gkrMHsxp5rQykoJplEh/W7CrfSUztnET3dO5LgZs2kBH5JiInRHPDzdcijw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cvym9LTpjapT8AXR8nLXDhBuq68mHEweg0u8b1oxSY=;
 b=j7PUNoHa0TqjsPjAj0b2BOKRGbUN6mc5Q6XnBV9t0HWMb3hjaIKgmBkLZa6G9aIE/O7PqpGR3ThR2zylrL8OsUbD9L7e84/QlDIpf3wDa6frcCV24NKHhjv2a3FUkkwCyxpuTkZnXMXVOtoBzty/TJp3oHVMi46Zvb2mfg1TrwA=
Received: from CH2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:610:50::18)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 2 Dec
 2024 05:50:59 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::a4) by CH2PR16CA0008.outlook.office365.com
 (2603:10b6:610:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Mon,
 2 Dec 2024 05:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:50:59 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:50:57 -0600
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
Subject: [PATCH v9 00/22] Add support for binding ACPI platform profile to multiple drivers
Date: Sun, 1 Dec 2024 23:50:09 -0600
Message-ID: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfef0c3-ec53-42fd-2393-08dd12954c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCtOYzZQcTJBY0EreUQwdnNHZmdZR0FsZDlSdGlrYnY0M0U4QVBvbmRaRmtn?=
 =?utf-8?B?RDVnVzZ3L2xxcUtzWmoyR2VtTktWRUR6eHVKZlhUMUlHajhKb0RNYmk3L21D?=
 =?utf-8?B?eHIrNGhQbWpOdGdySEhmOCsrazk3OWlDM3dRRlljLzZ6anJrVVdYSzdDWjZS?=
 =?utf-8?B?R0cxdlhnc1Q3aWlLaXVLK1pMM2pZMDJmYndtSmt5ODdRVHl1eFpOZWJEK2Ez?=
 =?utf-8?B?MVRPaHhyVGRPRFRMYXJUMjZwZ3FsL1VpWW4rdVVBNFRIOGxmV2FXRWd6SjRU?=
 =?utf-8?B?UDBOK1dkSFI4akpPSVFnTjVvemcrMGRnbzR2TFhoQkJ4OHN4ODZISG1QSXJN?=
 =?utf-8?B?c2VxL1BqRE12YW1lbkZycTJ2cW4zUEVUTlJiN0gwU0wzVGl1dU53TWIvcjEw?=
 =?utf-8?B?Q1B3eVord0lTZk1qMTB1TTV3ek9meittbW1STjF5TTlJUU9ldXVtTlVRRndp?=
 =?utf-8?B?LzloVFlGQ2hpQ2NaZlVkdnlEY1MzSGg3N09reFM0dTZzTGZERXVsSUdHaXR0?=
 =?utf-8?B?VXkxaTYvdHpSQmtCZVNnTis2MFNQZ0l5ZmMvQkZRSGNYWS9neU8yT0dvRGJQ?=
 =?utf-8?B?SFdDdVdPWVh1Q2dZQUY2VGFwR1VPVWJRWXh4NU9TY1lDTGNNbUxvaTZ4VXYw?=
 =?utf-8?B?U1Z6eDJyWkgzelFVWWswNVlLZ3lyY25NUVhyRFBWYWFhUDA3dzhoQnl3cVFu?=
 =?utf-8?B?QzdTa0s3SEF1bjN1TWk0cXlkYU5lQTlaMFZYUFdtYkhOU0hZc0tOVk9yK0wz?=
 =?utf-8?B?VlF2M2JweGZCOGUxV012ckp6MVJmQUYrYWl6aVROMDU3ZVljS3dTaVB1TnlU?=
 =?utf-8?B?MXljSS9kQ25iL21yOE9qSkdKZWdRMm5CMlhOMnB5elR5TFppU0w1OGVaYWk2?=
 =?utf-8?B?Y2ovU0w4ZFR4dUR2RjdMaTF6cGNDaG9BUk9RMnVPTFVCUEMxQWxaWnhPZ0xo?=
 =?utf-8?B?M21YM3BnUk9Ycy82Vk1HQ1RLMWdjcVg0LzdVVDVKMzI2Qm1HbmowQ0dQWTdC?=
 =?utf-8?B?U1FseTJObCtYNzQzZVN0eDFjaDZnNzY5ZkdWb2p1OWc2V2RuNXRlTGpjUmlG?=
 =?utf-8?B?VGVSem8rZ3BJQmR4U1hJdzJGS2RCSHdlaUp0K0ptc1VHQkRad0xCV1hKYVdn?=
 =?utf-8?B?cFpob3RtdnFaTUNXaXFEbi9yRGpVVjl1RjVhWFYrT2ZXS0dhQ0d6eUpVTGRY?=
 =?utf-8?B?aG9xWVlpMEErS0VUM3FCYitkdXVIWTdmdkJtTlh5QjFEVWViR3ZId3JVK1Fq?=
 =?utf-8?B?V1dybGtFNDcvSlBYQTc4UnAvdDB3dHJCbS9sV0F6bnFjbnJlM1pQNExtTHg3?=
 =?utf-8?B?WWR3SUx5blZ3MVk3d2JHUzdhd1VCR21wR3lQVzh5aHViNEZWZTZtS1NrUXd6?=
 =?utf-8?B?OUlWK0NLU1N1VENXUTl1cmpnWUppc2RDY3lWNkV6SlVwYVM1Ny9XZkU0aHlo?=
 =?utf-8?B?WWR5YzM3N1pBU3dnN1Y1SjFXbmEyQ3FsOFdLRzl1MkJlbmFzVlc4dkR1UFVX?=
 =?utf-8?B?a1prTzAwSUltUjlNd29kY2hIdDZjNEFtMWdMVExxNnBHeVJzSTg3ck9jK2Yx?=
 =?utf-8?B?ME53NlVUNy80VU01M1lWM256SWVRTkxBUDNtNHBIWkxTSTdwUys0SlJXYk8v?=
 =?utf-8?B?WnBqb2l4RWlMMVFPa1JjNmdMdk8rbm1MYU5pcnZHV3MwamlSYjRFRm0xSkNp?=
 =?utf-8?B?RmpHWXlkNS9YRmdjNE9yUDdwc2RsUzRtL3VxSFMzMlo4bW5oZ1kwNDF0UHZl?=
 =?utf-8?B?Q2NMclQvTHpmSzN2ZTZOOVhZR21ySTQ4T2VKaDRDWkZKa05vbnRBQzAzSFBJ?=
 =?utf-8?B?TjJWWHVoK09LNjIrUVZGQnZZRTlLeHlFOS94MlBxMVhjeG8zWmQ3MnJod0VD?=
 =?utf-8?B?QVc4SC9sR0lYeEREOUxuUnJGSkRnNkI4NFN1WmtrUEZiUk1WOGFnV0VXcWcv?=
 =?utf-8?Q?DWpKGdJ05WKnsHfOtRxlkfOxbZVmhb2U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:50:59.5419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfef0c3-ec53-42fd-2393-08dd12954c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

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

NOTE: Although this series changes code in acpi platform profile, I think
      it is better to go through the platform-x86 tree as more drivers can
      be introduced during the kernel cycle and should make the changes to
      support class interface when merging.
---
v9:
- Rebase on top of 6.13-rc1 tag
- Fix LKP reported issues on patch 2
- Use Markus' logic update suggestion

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
 .../userspace-api/sysfs-platform_profile.rst  |  31 ++
 drivers/acpi/platform_profile.c               | 523 ++++++++++++++----
 .../surface/surface_platform_profile.c        |   8 +-
 drivers/platform/x86/acer-wmi.c               |  12 +-
 drivers/platform/x86/amd/pmf/Makefile         |   2 +-
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
 drivers/platform/x86/amd/pmf/pmf.h            |   3 -
 drivers/platform/x86/amd/pmf/sps.c            |   4 +-
 drivers/platform/x86/asus-wmi.c               |   8 +-
 drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
 drivers/platform/x86/dell/dell-pc.c           |  38 +-
 drivers/platform/x86/hp/hp-wmi.c              |   8 +-
 drivers/platform/x86/ideapad-laptop.c         |   6 +-
 .../platform/x86/inspur_platform_profile.c    |   7 +-
 drivers/platform/x86/thinkpad_acpi.c          |  16 +-
 include/linux/platform_profile.h              |   9 +-
 18 files changed, 541 insertions(+), 214 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c

-- 
2.43.0


