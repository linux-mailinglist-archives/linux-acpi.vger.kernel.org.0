Return-Path: <linux-acpi+bounces-9800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48D9DF0A9
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E640716337D
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB961990C9;
	Sat, 30 Nov 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZOU9WpMA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D03F4F1;
	Sat, 30 Nov 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975526; cv=fail; b=kOiBN+lHzpUCuKzlEWlG5G2o8y86lwPRh1ek4QGNqsi5UkqlABKuqu/LRKAdbkHHwaz4r3aHmPSr6TKxvqlwOj22TmQ5TYVnuKR1i4mjznGYXbHNeGlcWJi8siZveqAY4+cLe03OdJKIXUmiq2Btm6wlel1JP89xk6xEP9mNNIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975526; c=relaxed/simple;
	bh=MFqwFsFkOEqA9i6JqkbEj1/en1k/YR53sHWAdd6erfs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UD7g8As7c4yVwbDEBiBt6Di40mz/ckgIrEAHo8Q4XhhamdjZ5iGmCW5ry7YSGooX6omwqPtckBs77kDPgugzQ29aTLj+HgFxOBQ2E/SnFfJ2Dx+qoNNpxIUU/wi8+IraFRi5767oKSj5X5l+VbOPI0cOgLK22EfqAWGPWqO3sa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZOU9WpMA; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wcqhq5ttR2/YFk9CIqjecuCR9swtY5hKBYBjLZB/JxYDKO2Yi9j8SKsTcquCmqMFjpbKYG5LasWK2ZnJEhDOWpdFpgh/lO7jJ1yHsVYLir5SgJaTYdY+tDBOU1BQkx8ixa0NDwiYFUFA//F4/KoqNBAmwnnX9nQ6bgpneNgNjNHqH1fonmcpz/bAo58cfGj9AZajDbK0qUT6ybIDkb8ds1rFFdNI03W6sjZPxwq99yfb/LE3vzbyR0cB6+VNdlDUZx59jnojNVeG57/EmIf2c3fFcg5I/TCR9tj7b+6VHdVJjmzkZVM2VYOo5qoLTo+uql/HX7apfIfmmRuFcod60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9quZ6TjWYeYyNdIRgc57kIDxYeATeY8LXqx+Zd+78o=;
 b=KXnG6T0s9VIbhKy0zKFRoaVPZF+X5MXXMt1ykzYZZWA+XIjur7adOYHSL3QLEnmS0EVywHvTkp90L6R+1JyYf0yxn+XlRqw2YcSxEXM9zuAdNeri/GumL+SG7h4z9p2AigZmhuTD7IIqBeAPUnjU/T09jV8NKCwC71gSEfkopw3qSfeK8dUK3e6efzgYiWoCEaBLUKPqjypiUCW8eabEXg/fo6TNzYUiGd05XRTybT4vg+xjlRB1bhzzU1KoCZD3JxQRxLkHIHCNTW3Nc4VosOUPvotC2aG+JaNrJXUN398eIlPlr90wk3Yufimy4C36Yk8thhULVsbS4F7ZZeRXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9quZ6TjWYeYyNdIRgc57kIDxYeATeY8LXqx+Zd+78o=;
 b=ZOU9WpMAAHToVPT1LkJrTubji6pxGOZxdkb8Bsud6y7bGe7glO3ug2MtK5WITHRXECfNaBDBxVP5oJ8FUV14A7nMgQGsFsZYcbhtsSeS+15qfpSvfyHJdmGZ3zB4v2Up4J0KEeRibIa1z+BamKQOPDNAkXwyg9e0K99oWbUpvuU=
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:19 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::4d) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.6 via Frontend Transport; Sat,
 30 Nov 2024 14:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:16 -0600
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
Subject: [PATCH v8 00/22] Add support for binding ACPI platform profile to multiple drivers
Date: Sat, 30 Nov 2024 08:04:32 -0600
Message-ID: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c88584-3e1a-44b4-9181-08dd11480607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGEyc0hMUjZycDVrSVYxN2NYQnowbmxSb1hlWVN4YjVmOThSTHFxenp0SFlm?=
 =?utf-8?B?Qm1NV25lSWdLd0pCUDlFcWFwdzhQR3FJOHluUFoyVmdUeXFPTkpQTVcvTkhF?=
 =?utf-8?B?ajl4K2RZRGg1VkdpOUxBc3VxMkF2dEZxMWdSQU40d1pTK1FQb2FpT3U3dDRU?=
 =?utf-8?B?MnI2ZjZpYXZIWGZWRURHRWpibk5zZzBMTjJUeUN1TUhWZXd3T1dlU1JPQUNa?=
 =?utf-8?B?VUdsb2dLNHdQR2F4UjdSeEEyeDVRMXF5RjM4WDV0bmd0a3N6RHZlVzBNbUdE?=
 =?utf-8?B?UWF3VVgraVliU25wQ1ZldjlyRWkzem1LdG1MQkVjMHh2MTFDdWJVVlFsa28y?=
 =?utf-8?B?aVVBZnRxa2lFR2dnVXNYaitoMmYweDZLeWhGbWIzRVc0bzZlN2pNS1JTUUM0?=
 =?utf-8?B?Y2djN1owOVRPUUcyNjdBQzNvdmdtUjZQcDJ1QjRiNnJXNlhwaHBNNEVOUFYr?=
 =?utf-8?B?S1M4WnZoWFdScCtPeld1bzMxZmVoTlE1VGJXM21nRWVhKyt3SHAyVk9FMFBE?=
 =?utf-8?B?R3UrM01GWkNlb2xXcE4vVCtNenJjN3Y0TnlwcHdHZXZEUWZIZFl3TjZTNk1q?=
 =?utf-8?B?L0FqaFlNUmtUVUY2RUZyOGovei9PSVpxMTJscE1CTXgyTG9OTXJ0SW9GTWlX?=
 =?utf-8?B?eHpidjFJOVFUT1BKSGdmTlpvbDA2UFZTSjEvWlkwa0NVNjlVaU9lQk82dDR1?=
 =?utf-8?B?bXc1OUYrSjZFVi9rQXhNNWVQMVFBL2NRYkRXUU1CVVpZUEROOWFPSSszOHlB?=
 =?utf-8?B?WHpxbXRrREsybGU2NkQ1aGpNcjU0UWtvQ2U5SXJXTTVRV1VmWXFwejdqSmlK?=
 =?utf-8?B?TTFRVVlGNHlkOXRvL3prRHlnZ2RxTXB1R2xxcXdLUzZhc29LT0QyMFpLMm9h?=
 =?utf-8?B?dEhJbGdaWkI3OXVRR1BGdW9jby9hSHBVQmpyL3diNS9TTnBOc3c4bTExTEVZ?=
 =?utf-8?B?UDNTQUg4Vm5DbXBON0srWU5hYlo0QVBwWTN2U1lMUDZrNC9qZXd6Y2ZBdk5E?=
 =?utf-8?B?dk90YnVjanJKVjMzck94N00vTWZkaUx5cUEzTEtwa3hEUFVPUEVqMFlOZS9o?=
 =?utf-8?B?QWZ1NFJYbEJBQ0FxYWtubzA5TnNiWEJnQzUvRGY1U2dkU09QVEFaNzVOUmtD?=
 =?utf-8?B?aS9RNk5mdFZQKytwK3E5YzJWKzRuQXRHNWxiQzI2aHhhK2g3Z1RDc1FIMHdt?=
 =?utf-8?B?aEF0SHp1WGVIb0MwOEVoQVhDdkVvbFRtZW04NFh0ZDJYS25FbTUyZGxQY1l4?=
 =?utf-8?B?NG0xNW1MNjU3SmxSczBjLzBCVTNmanRqZjJpVng2cVl5aHFlb1RwcGQySzRy?=
 =?utf-8?B?L2VLT0MxRzRWb0NLZSsrdWRwTGVUTFMzR2MzMkFudnJJemtSM0htbnBzUG9a?=
 =?utf-8?B?U0hKcnNkbUxpa2x0eW5RZ1kzSWZRVlZMSXkrNGMvTG9tN2lXblVtWFlsTjQw?=
 =?utf-8?B?SElad05RMGZFdjJ1SXVTMGtocTMrUzJhdkdCcGdBZk9Ua3RmWGo2ZCtuQkdx?=
 =?utf-8?B?cTZweGJmQnpoTytCWFdDZDVzSkVKS1h2d0QySWhoZTRDbkNFOW9NM2FMOFdK?=
 =?utf-8?B?T3QwQXZGMXhPeXBLb2hpdkdLWFNwMVJmQXBKbXh3TzRYQ0tqaGQ2VUNHQ1lv?=
 =?utf-8?B?bzFwYXJ6RStGU1JzeDNVSjU0dlVnM20xZTNpK3hIN0wwQm9uQ0ZmUXl2aGNt?=
 =?utf-8?B?cXdsT2YzWnhtTEZmVnpBTVI5SnhpOEN6TEJ3T0Z6eUtYUitPc0wxanJRVWpZ?=
 =?utf-8?B?Y3VwZ2JJODlwZnVnUDRXZTUyMFFUY0JiVmZXclRGZURxRS9RZHJTTktQVFRY?=
 =?utf-8?B?MHlnckdiVHg0N0xVcFNJc3VlcGpXMVdEZ0hzb011dnV4SmtPTjdmaXVhdDU4?=
 =?utf-8?B?Zms3clVqV0hpSjRiYlRSaEZmMmZqczJuZlFWSVhCNWlNZTZ2OTA2cHY3R09V?=
 =?utf-8?Q?OVmplLdKy18MHXO1ImdO5lfSb0CDTpG0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:19.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c88584-3e1a-44b4-9181-08dd11480607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236

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
v8:
- Rebase on top of 6.13-rc1 material
- Various feedback from mailing list

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

base-commit: 2ba9f676d0a2e408aef14d679984c26373bf37b7
-- 
2.43.0


