Return-Path: <linux-acpi+bounces-9385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A59BFDED
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBFD283F90
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAD18FDAF;
	Thu,  7 Nov 2024 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nNnzefKF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8DBE4A;
	Thu,  7 Nov 2024 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959412; cv=fail; b=if0ml3yvFGjLOGdrESsdJ0PTziel1QScEMbbi5amXTjiHB3ApjsyJYCX/OhOGnkVvnVmqWLEbu+i0sPkqee4tlOz0W8jAwqu6iFmA/hMuTWFiHTYsWkrVmj+ccwNuteMkb5FbotszJckc6fIFnOOdTMTt5ueNQp1/N5a9HfLBd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959412; c=relaxed/simple;
	bh=3odpgO/buUOaVL4JL3g6zZP7Y3mpJ/lLTWRYxACOsH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vug3G93Y+DVTvoA+dxg37rP84ul3HAq6GO9oR88pXDv++bNL5wwIvQsls8WJ5fmjW/nKRXIZ/OGAKVGMFp2FhJyfX+gP08PTlXt6j9ATk92IoD22bc9az1nJdM9z/fr0lSLFrVOAiRnh1/haRKb7z5nHccchvp41r/00FjuLxSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nNnzefKF; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ik3GfUiXQAWbeTfh7P+8gyenT5Sudk9+h7yNoXYNpMxMo1DW3WgCwd77zN5AzmW/Ht/kYHlV0gQ4Su2PY2k4q+ug8ogBSySLo08C4zg1dVYzz2YISkeQMNUMtQwjrzfLgeu3EZK2IFXTceoOhstBbGPVxZ0hFEf1CmKHMNvGP5x/gx35sMp290w7KQSrcrr6W3Sc7bDSeYdteMFHMhD7+YpwHJ6+RRGjGMf8Qa9COqi1Smz4fGrFT09XVpDtQ/WKRVpwvxM6oVQw4pSmdcyA84Pcjymvh6Po0/o0PBYP476oSWqb4TXTwMiHyqBaZAxGffsZAfFW3fK8m6cF+80Zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SzVqZjHtGnV9DIQ575xKCFQ1K8gpEv2CGKMndcK3po=;
 b=epaXPGnEEHvW9qs0ibm2e9eULTIOzdKjB1oLX5LRvCs/AyOSeor43OyLPXOflVPZvdx6/VqR5hc2GXGU3nQ3AaX870hOzVC/UzWPcarLTnhGUhXlah2Gsr9+V+WyIpnqweAot1KmJJAhbnKJMqhe+BELkhAmpqPGT2BAMbx07dht1dwawqbarSQeRC9rokun9303zxJII16aSPID2NsQq2PUMf7knLNL9M6bjmgZkDh8xEL19WyaokLktNE3YwbsA8GDDkt420ydfzhVtX1XDqW7poj7MQzCddc+H+wF/v7ofNVIVgJUwGDZDA1s7Q9BM2+ArvM7H0shkvzxitoeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SzVqZjHtGnV9DIQ575xKCFQ1K8gpEv2CGKMndcK3po=;
 b=nNnzefKFavZdEJc/AykfZVzVWzUTazCQqnp5uZflh0nkiljwAgA05vCGVwp5sYw+rzalRjzGLOFMRIOHkS80LnPQfng2CPLxycC9YPR8Q9SmsTEu9J4eR4QsZouPlQqG7/oheV3TIeO94ibsOJ7KjiqDLzDv6sVquRRAthftol4=
Received: from CH0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:610:e6::33)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:03:26 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::dd) by CH0PR03CA0298.outlook.office365.com
 (2603:10b6:610:e6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:25 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:23 -0600
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
Subject: [PATCH v5 00/20] Add support for binding ACPI platform profile to multiple drivers
Date: Thu, 7 Nov 2024 00:02:34 -0600
Message-ID: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: f394a93c-62c7-4236-4356-08dcfef1e4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnJVZkljekRXRjB2TFJQbXRvVVRCOWR6eXpMa2QvTjVvdmRjamdsNU5McWVM?=
 =?utf-8?B?ZUJWYW56Mlo0dk90TUpORlZrMzZLbHAzOFB6VVlGU01keUpVQy96Y29aL2RU?=
 =?utf-8?B?WHdXQlYvSlpHNmdzUWpwNEtMa2V4K3gvaWszVWMxckgyK05FcE5ORE9SQXNX?=
 =?utf-8?B?NE5LVWJySTQ1K2xzQVVobVNoRndYZno5Q200cnloSmphaENTc2VxaGk4Qnht?=
 =?utf-8?B?ZFk2OVlaajlKcjdOMGN4Q3AvclI4bVNLaGMxUUQ3M2RCdWNkYUo4eVR3OEJO?=
 =?utf-8?B?UHlIcEh3bkIrZ1NDYTltZlEzWkxMSURweTlDVnNManprRzRac0w1dUVsczF3?=
 =?utf-8?B?MXVpK1lvMDlydHhDekNHQldZYTE4Q3hoSFh3UUxEd1dSYjZQMm1kK3J5NkJw?=
 =?utf-8?B?dUN6SmNKYnhtbGp0cUFFcm5rMU9pUUs4RGxGV1ZpM0NobU5EMklXSmE4T2Z2?=
 =?utf-8?B?S3FlcWF6dXB6aFZtZENvUHBIek4vNnZMbmVFZ2ozSjUxNkkra0xsY242SnVp?=
 =?utf-8?B?S3BaK2F3T3JXS1IveEljYXFwbUtsVnBWcmk2dXNOdC9LV05RS3BtSnpIY2I2?=
 =?utf-8?B?VWpEZ2dyN0VvbmVoak9PN3VMeVlubWJtckQxbzlJSGFXSG5YejFISGVvYzN0?=
 =?utf-8?B?QmJpelp1MkswbCttSUo5SFJIcDB3UUt4elovM3NHVEpWUzlaZTdYY09VZnVB?=
 =?utf-8?B?VnJ2dFpLQzFLSDBlc3gzZTlES056U3dJeFBaM2Q5QTdOTGh2aUFXOE5NbFEr?=
 =?utf-8?B?c2RTM0YxWExYOGd5Q2dBTVFjaHd6bnpKZlFNVjZ4TDJ3UG1qbHhsdC9zNzJL?=
 =?utf-8?B?WGlpTXpDT3lMMmlrdnFKbEJXemZGR1VadFFSY1lQdG9qNC9sZlY2SDE0QzRi?=
 =?utf-8?B?Y0VxUWxZTVU5cVMrSkNpQVVVaEVxb0gvcjBQMzAxUU1JRTJ5TjA4OUtoWlVk?=
 =?utf-8?B?LzFSK2IrMFQxR09iRFF2ZDZzOXlYa1FWYXVjOWZZaVJZS3hPTWU2ckU0a2ZN?=
 =?utf-8?B?NW5nYWhKSExIRUFiSWZRT2NvWitJdTlueUlMdm4zWUxMQlFaWEVTVlloaUJO?=
 =?utf-8?B?MnlGbjVuQU1Mb1dQVHNST0k5SktoZ2FHNFZzbkNDRXFFTSsrcm4vMnR5YzJV?=
 =?utf-8?B?L1RFUnA1SEY1elhFTllhRW1tS0EydjNaSFhzak1CeE1hR0NHSE9MQlNaT0R3?=
 =?utf-8?B?NUE2OUpNeDZ5RWpOcTNrUS82V294Tyt4ODdYRVg2dTMwa2c1dlFjL1dpeVJt?=
 =?utf-8?B?RVRqMlI4dnBjWlVOQTRSMWo3OXl1RDNNRFV2YnhxZ3pXL3VBWGI5YzZMVWcw?=
 =?utf-8?B?dXQvdENtSkZ2cnVpNkxzbENOQkdESHVOdUt6MmQ2VFpzamkwNC95aTBnak1C?=
 =?utf-8?B?Vmo0T3lZZ2dScEtYVEwrSCt5THMyR2RIckpNRGYrY2RQV2FsQ2VKbnpBQVM1?=
 =?utf-8?B?OGt0OGxzSzVaS2pvUkM2Z0lQTzFHTU5LNE5CRTczUGk3WkxFbVpTSGdPckxl?=
 =?utf-8?B?NHROMXlVczJqeUVGOVdnSXRzZmN0RDBNWWJGa00ydklUZFBpdDVzc3l3RDUz?=
 =?utf-8?B?WkhnRUkvdTFETkZFWndZMGhpWWVnckMwTm1mRzhrdDNKdnRod0x0eFozL213?=
 =?utf-8?B?cnpwaG5BWkVYSzY1K0FvNFZyZU44UThKckh5QlBqYmJsVVR1WWlnbXd0UlFj?=
 =?utf-8?B?Nk90K3FscXhaZkVXZkRVR1d5ajcvOXJkNEZJcWhiWDhzZVMzL2QrcG5rZzBR?=
 =?utf-8?B?NUJCQnNXVFNLVi9JcW1hcmh5ckZoRXdDTUFEN2RqdFZ5RGQ5Z3dFdDZzYjE1?=
 =?utf-8?B?NjhIRmhVMWsrNFJMZjBndEVobjZWd20rQTBTbC9WMkJNL2h2SUNWVUs3RG5s?=
 =?utf-8?B?cTRUQVZwTlNPamFCd3kxZ0xQMk4yU1R6TjE1V0dBUkczZHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:25.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f394a93c-62c7-4236-4356-08dcfef1e4f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233

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
v5:
 * Adjust mutex handling
 * Add missing error handling
 * Drop dev member
 * Add cleanup handling for module unload
 * Fix crash on accessing legacy files after all drivers unloaded

Mario Limonciello (20):
  ACPI: platform-profile: Add a name member to handlers
  platform/x86/dell: dell-pc: Create platform device
  ACPI: platform_profile: Add platform handler argument to
    platform_profile_remove()
  ACPI: platform_profile: Move sanity check out of the mutex
  ACPI: platform_profile: Move matching string for new profile out of
    mutex
  ACPI: platform_profile: Use guard(mutex) for register/unregister
  ACPI: platform_profile: Use `scoped_cond_guard`
  ACPI: platform_profile: Create class for ACPI platform profile
  ACPI: platform_profile: Unregister class and sysfs group on module
    unload
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
  ACPI: platform_profile: Allow multiple handlers
  platform/x86/amd: pmf: Drop all quirks
  Documentation: Add documentation about class interface for platform
    profiles

 .../ABI/testing/sysfs-platform_profile        |   5 +
 .../userspace-api/sysfs-platform_profile.rst  |  28 +
 drivers/acpi/platform_profile.c               | 494 ++++++++++++++----
 .../surface/surface_platform_profile.c        |   7 +-
 drivers/platform/x86/acer-wmi.c               |   5 +-
 drivers/platform/x86/amd/pmf/Makefile         |   2 +-
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
 drivers/platform/x86/amd/pmf/pmf.h            |   3 -
 drivers/platform/x86/amd/pmf/sps.c            |   3 +-
 drivers/platform/x86/asus-wmi.c               |   5 +-
 drivers/platform/x86/dell/alienware-wmi.c     |   3 +-
 drivers/platform/x86/dell/dell-pc.c           |  35 +-
 drivers/platform/x86/hp/hp-wmi.c              |   3 +-
 drivers/platform/x86/ideapad-laptop.c         |   3 +-
 .../platform/x86/inspur_platform_profile.c    |   6 +-
 drivers/platform/x86/thinkpad_acpi.c          |   3 +-
 include/linux/platform_profile.h              |   6 +-
 18 files changed, 488 insertions(+), 190 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c


base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
-- 
2.43.0


