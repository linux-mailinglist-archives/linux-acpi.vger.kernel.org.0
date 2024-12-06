Return-Path: <linux-acpi+bounces-9984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C62C9E64BB
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA88282D34
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6333517DE36;
	Fri,  6 Dec 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4RNcdxy2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB934CDE;
	Fri,  6 Dec 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455249; cv=fail; b=u+aZJxbhJxeyT6uAsEm1xbm2viTCE2+4lY+2FgCemm0l21TUKUHFZA+fqAgOOLdwOWeiXAQXAJPOJxnQVbOw6IblJmoFElKMoU69FwaXRHRYcbORrv/E7gG/HwnsUsKPatVg9SFSjZPW5WowOEpC9qbzGLUmqcmaPQBdZtQfu9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455249; c=relaxed/simple;
	bh=MsLIw//eHDCbM7lKY0hFU0zDEhxKZAMOZ/jhK9qlVd4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TAMkCChSNGCYBJm86l4sJncyX5yeMSbiiIDInRm6lGJjzDZlfIJT3frs5BTXF+GaiByTKSvtgK5ygiu2K9WZ4r71vQaV3FsRhkDBiZJGnz5ig9QTi7qx4ljlUqO5eoIc4/UaZ0sYF7wiOG/kU/CQueF8MqeBIlDTanHVHbUHf2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4RNcdxy2; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUHhSbwOMVzB4FmgmQ66DyhS7mocjTeAAOYSJgKCT8gGr9uQTFANLbeT6UVDK7Ab72uMDYLQZF9TGuzHL1m41BNmOLvFiZ5zLErAG6efYFedsTuT6xFsNWVP7N9UBD168dlrxoETLSDqh2+/YZmmYAM6yZl34U9dBc39Calyd+J2uZMSekkMYq7m035mI7JQ3jxPuqWV4uQwD2DPzY6Jio8zHE1DbCy4Wt7Y+HRkm+pMwcMBj9HUfhiPgzJN0bDrGsnKEKsXbIOKSXs9Zhy4y68ndZ6vjEcI2tL6j6GDTPIbjpnDWMYGHwUf3iJohpdtqKe5Bm7WwqC3FkvKj+pjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaXvfC3f55zE4iuYdrvqQSm4/l0JwsEB6uZv06dc+Ms=;
 b=n8w4bhjYkL0G4QzMa0wC6aurNBURdIAlOB5OadlLbj/7SnEpEhN4S144Bn4UDYds7lka0ZYkySJZk0ZeBVKgxw21GOFZK75QGGiYVOIMIxGg/RALqTtMyOd/tiokKWBT/EI04sczGWLuzLKLcIFzxxm+HFWcH9WgLpA+IdQlcX9seIPAGuzRLxChaDav7gMRoo77xCI7/HtgAx70aoMexyuEmDn1QRgB5/jikTzXq/4Glv2WxHXWR/xyMyeO6/5MIglsVbW76zazd8q+lZn7KRqAaXGFPh0XiPhBVB5lv9NxzXW2AQjqZMkf1SAvUWOeT79iOTiOBe/9mH4Kj3935g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaXvfC3f55zE4iuYdrvqQSm4/l0JwsEB6uZv06dc+Ms=;
 b=4RNcdxy2YTpBGe1pb3dxqnU0oHsCtKe6INv5M0l8i3IZrfqh9tRU5wBugUwiLApV6pWgryfZYGNKgFObFKTCDloKXHDUNiz8aRaEKqVmMrnaET5BcDTjodbf3japZYrLnQZHuCwnkQx5/M+dWuh6dFa0phvPOOUBE5MdFaXvRkQ=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 03:20:41 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::3e) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 03:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:20:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:20:07 -0600
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
Subject: [PATCH v10 00/22] Add support for binding ACPI platform profile to multiple drivers
Date: Thu, 5 Dec 2024 21:18:56 -0600
Message-ID: <20241206031918.1537-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 00375c4d-dccf-4e06-3aee-08dd15a4f662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk56QzZsOHRtMG5iV2oxQVhyN0JXNnVXZEZnalVoc284ejB0bmFOdFV4WnB3?=
 =?utf-8?B?bDhTTHNmVytkSEFFWkxUcTE0WnVDMWpxSFJxbU1mZXBvN29Id3ovTzNORHkv?=
 =?utf-8?B?ZUdvRi9haWlIMHJHUVNIRDlXZVVNZWZsK21XenliZGlCV3dKZjhnc3Zvei91?=
 =?utf-8?B?RmtBNHR5RVBNbFJQamplVWlrWlVaTU9jVURydTVxZnFESFEzZVBEVXo5UTBp?=
 =?utf-8?B?cndsTklJaFNIa0QwUDk5K1J3eit5WGJyZjRZQTZHNCtKVW53QXZUb2F0L1Z5?=
 =?utf-8?B?dGN0Ykx1RGlnQVBZQXJ5NVBHNlo4MW5XMFVTSCtQcU5UUTRVdm4vVnNqa3F1?=
 =?utf-8?B?Y084cFZjNE1DbmVsb1lRUytYbVlBejF2WXpzTzN5ZklFSDN0OXJhS21NVSty?=
 =?utf-8?B?WDlvWlVJVXV1T1QvSmtaVjVJeVdHbnNYNnNyb3VPc21SWEZrSmZlbmozeEty?=
 =?utf-8?B?VzBwQ0tTVXMwdWR4UG5NeVd0OXVRRmdiVFMwVzI2Q2lTUFNCdllhd2ZDK1pP?=
 =?utf-8?B?TUN4eTFpWEtGRWFJYjJCUDNMdXBkWVdDV3FwU3dTcWdkRHJoZjE5RW1MMmFP?=
 =?utf-8?B?VjUrVFlpc0RKa1RiZnJydHJMWGozRU53bWV2aWIvOHRvb2hkM3o3djloMGhy?=
 =?utf-8?B?ZllzMEZQT2FTY2pxbmNNRCtxMzJmUGVsM3hRd0Q2NEp4SDR3MmVQNUVBaEcx?=
 =?utf-8?B?ckEzbWpsOWljNHk3N0tjSG5QS1o5bEpneitBMlg5OFIxT1E1TVBTTWRpSEJZ?=
 =?utf-8?B?RUJucDRwbWQ3NE1XYVQwMWYvaHdWOEoreUZob29ZdWg2bjMwWXZEZnBFQ3pF?=
 =?utf-8?B?QldtYnIyYVl4aUtSUExtWXF3S2dVejdMbm56SUhpMHlHZlZhNVVnbE5OYTQy?=
 =?utf-8?B?dHhQQkszL2ljb1M4Z1JPdUJJZHRyTnI5YkxxTEFKVGFxa1hyaS9CNDhDOFA4?=
 =?utf-8?B?VjExTUNWaEpMWnJuUkFHYTNHQ0xVeDRBRVVqeWU5ZDNWUkhjc3k3cHRYbWow?=
 =?utf-8?B?ZGIxRzJzZExIYVJnZlNaN3gwVTF5ZkNLTS9CQWlvSXdySTNTanZQbjVmWXl1?=
 =?utf-8?B?S1dESlUyMHFrWmRjLy94SnV1YTNOS2FJRU9sYjRlVWpHeTNjWExNL055ZmF5?=
 =?utf-8?B?bGxGRTVpamZ2bUgzdjhvcFpmWFJ5OTN1S2VLdHZrZk9VSHdsZEpNSHphREhs?=
 =?utf-8?B?WTB4QW9IZElKNW1ZaTBYRWU5RE5sU3UrMDFTNHJyc0gvTFNwVWVOUk5jZVhR?=
 =?utf-8?B?c0JYUEllbHJJR3Z0dFBqcmlzempZTElMZHdHVDFUTUk2U014UkpnL2ZSc0Nj?=
 =?utf-8?B?Z3lxRVBEbVc4UlNGV0dwTnk4eHczR0FQWkQ5azJOcXRzUGtoa1lYQnFmblR5?=
 =?utf-8?B?OERKWm0wYW1FSmlEZm9uTUw5VmZNblIvUmFML1dxTnptWElYTXgraExWVS9K?=
 =?utf-8?B?MlhFcGdmNEc3SlhHZlJjeFJjRkpyRy81bVRFSDlpK3paNzlFVU9wS2V3TXFu?=
 =?utf-8?B?V3l3T0FkMVI5byswUUhSQU1TcWdMM0N5RTdibjExZDJQampyTVh0clYvTkdU?=
 =?utf-8?B?TUJIamZpMDdBRTBQRDF2ZEdKVks5dmhXTS9TMFQ2M01qdEQvZFgzWG9Wbmdr?=
 =?utf-8?B?d0ZqZm9hZUloQTkzWmhWZTlmcmNLSG14ekptTCtrSkcwMjVRc0FtcHhVQWNY?=
 =?utf-8?B?bDRVK2pqZVlVcDUxWVVxaDhXYU1ZdTMwRlhWR1ZWVzBwN2hZZDJFVjJibEhK?=
 =?utf-8?B?L2kvakdaWnY1V3BSZDdNMk81UWdlTDg0cHg5SE4wSEM3U1BlQTU2UUxSZ3F4?=
 =?utf-8?B?QW1jWStRaXZUd083UVM4UW96bEYzUTNkazV1amZKVkc3Z09NK21GL2lHRXBF?=
 =?utf-8?B?cEYvUG1tYUhCSnpiMkZNZHhKckl4ZTZwaDBuSHpMUldnaUwzbklaQVNZWTRJ?=
 =?utf-8?Q?tJR8ryzaTmZFupOdrjJ2U7g30t6DcnyO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:20:40.7368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00375c4d-dccf-4e06-3aee-08dd15a4f662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

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

v10:
 * Whitespace changes
 * Documentation update for custom in a single driver

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
 .../userspace-api/sysfs-platform_profile.rst  |  38 ++
 drivers/acpi/platform_profile.c               | 534 ++++++++++++++----
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
 18 files changed, 559 insertions(+), 214 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c

-- 
2.43.0


