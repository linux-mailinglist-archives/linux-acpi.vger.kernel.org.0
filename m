Return-Path: <linux-acpi+bounces-9666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA159D2C57
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BDD1F213FB
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803BA1D1514;
	Tue, 19 Nov 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zoFgiADi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4131CF284;
	Tue, 19 Nov 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036864; cv=fail; b=l2oemHPdKJzMAgkTh+VB+78Lc4he1VZWhMiAvgXxxMHTdDm43XClyyLl62qys5/wJiJPm7B++IUR3uUP6IhJ54hOSh4LOaEyyp6wENI7yr1kcCdsVISzDNPtlb6VX29pwEjShDu2tqrL4tRYzvMYBhvnOZ9pk1+L1DwaszgO1xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036864; c=relaxed/simple;
	bh=u0bo1iUqU7MrdandF2NBdSaOEBYA7UUUOOIVI4k5lI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwoMPl1OStOxjwNwpP4UzqZyED5Bjpnhgz5J9tJKwk1/1KLx7el6xjQoqTecRXtSv6TXDFNYEBof7I3ORzpsJ3NVy6CG3+Y0DR7wfcAgfZvwRJkgma0U15zFmx+v7dFk5MKWVDUKzFJ9Ed9eiDD8FjMQiaAmF4TMNt4wkwmXILI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zoFgiADi; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUqQBsqnsWUuZb0HZQLcc9kgQq/Csk2tM0/KGMAlmnt1iqyeyMTUZTMYBjaFqTX/qsZ78L+5R+OCeIQW4CKrqwa62G4vL+ABR1zdbEQ4Obl2o7I52udJlBgBv4EJul8vPkxN9E4cA/gDRu9SKjqFtKgM+8mvdv+HIx5LR/eJvzrNLJU+0OJy7EdqAie0lXBNy/tkIGTTnfVHjBDh+hsa/hjgVEF3Nt29Y8AhuzMEQBd2vK+JPfWGNrv4jc8w0yK15NCnE6qVdvgws+OLfk4PuaGiAIGrATJGe+1OB6X5rdHi+LUfCyjEWHfijp/NIVYzO5kakkJ5obAvbXhwlR4f+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uWW3kn3OTm0oKBEIgYyAINqQsNJvVclVIo8c/F8oqM=;
 b=wBFBO5mKc3Bb5jmstmGtUBKZdRorRGswFUDkiDZXiFqEPSs2bJJYF8ohY51V2Wz+ZdrtqLhPxcTi00ol8ylFetJSJJrYN8srapIKQx0I399KAydiEkOXXf34XR43dFx03HWeLJ111pLYf/4nmgFehNl4llx4exbl6qiqFxo0gZwR0rdS3ZtxE0Yn1w2IRhvSLGP1mDCVnP1sbm3NtfjTzdMHJGn446KskOHF78+j50k/UvMdSxoGj+0bMm1pTDAEISDU5WpZ1rktZaTQTyqSUBw/BuvI3Mhx7uy9a33LpN5KnGOhBmLxXcXY/VmAEyeSCZ9jKqR/gtSBgeGC7BnmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uWW3kn3OTm0oKBEIgYyAINqQsNJvVclVIo8c/F8oqM=;
 b=zoFgiADi4paK5qTXzl4nUicZrM8fOzBaDx5f3KTFtWG4op60epbz0RUdUTVRKwXPLR6QODncIq7qE9EalrORBGNfZRqjO6b5su3UmKL6sqgZHY1UMTE6kSGQpDqoKoi2Kj2I71HKspTOKdHuD0BivMVwN65LOnycPVRWTQBR+Ew=
Received: from CY5PR15CA0249.namprd15.prod.outlook.com (2603:10b6:930:66::16)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:20:59 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::14) by CY5PR15CA0249.outlook.office365.com
 (2603:10b6:930:66::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Tue, 19 Nov 2024 17:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:20:58 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:20:56 -0600
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
Subject: [PATCH v7 00/22] Add support for binding ACPI platform profile to multiple drivers
Date: Tue, 19 Nov 2024 11:17:17 -0600
Message-ID: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e403fc-b999-470b-b403-08dd08be88c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2dmYURkZXcrdWd0ZzQ3SzFhbUQ3dm1rY3dUNmRHMTc5TTVwZHo3bkhpSXJi?=
 =?utf-8?B?d3N3VU9XUGp4M1hYWUVrNXRPS3RzWHVzQ3NFNy9TWWM0SmRSTXlYelFKMVNM?=
 =?utf-8?B?djQ4VTNORElpaWM2bzBZSEhQeU5OcmR0anZxM055bG5UWSt6bFlVRGF3aFhO?=
 =?utf-8?B?MGhOSkN0ZDh3R3hoY2ptb0lVKzdSNnlPVEZSaEdvOCtreUlhNE4yQjFteHZQ?=
 =?utf-8?B?WnNPL3ZBTmRCREY0NVhOWTFuVGdhZzBXWHBMV1d1UExtdDZPdHNWMVJ5bVNy?=
 =?utf-8?B?Nk5TSDRPOWJEZHV4Wi9Wb04xYnlueDVkRUhtYURJeXlkZzhYRkdNcXNOeUpu?=
 =?utf-8?B?WU9hb0lCOEVOM25KWjdFaUlDQ2pQYUkxVkgreHFvVDYyOWRZUmhzQmZiQWdt?=
 =?utf-8?B?WVhCYzJLaG05ek5yUGRmc2pCc0RGY2hlN3ZnOXFSY3h6aVl0bnFoTXNIZXdu?=
 =?utf-8?B?WnhYRDFvRUdSS0RNNEtzdlVHejI4eFp0aDNRVGZyT1UySWZsS3p0dGNjK0Vs?=
 =?utf-8?B?VElrUy9PRmN5SHF3RXBhMXdtampMZUJRTEJCN3VtNElVTU9vdmZLYmwyNFpz?=
 =?utf-8?B?S1gyZ2Z6WWZuclVLc2I2ekMvQnZadk1KK0xqU3R3T0l6R2E3L2xkbVRpcmFk?=
 =?utf-8?B?TXIvWDMvN0hPaUhUSmVXaWxKRmtmQ3lDVkhiakxCR2JZVDlUWnNPS25wMDhF?=
 =?utf-8?B?RFNoWnJCaWhuSWdMdkZmeGR5ZmRsTTFBRisyQjE3bXRsWnpscEl2Rm9NT2g4?=
 =?utf-8?B?b0VGTlF0ajZjYUpxV2hSNmVSQXl4YVZDYXBGWloxbmQ4SzNubENxakdIaDZm?=
 =?utf-8?B?NVA1M2UzV3NtK21xSjVxTTl5Z2hFS3A4QlBndmFTc3R4VWNTRzJocC95c0FC?=
 =?utf-8?B?VXJxck9aeUwzcGJudVEyWlBJZ09Kb2FoQzd1ajl0NW1rR05BMjU2YVpSL05K?=
 =?utf-8?B?Vk5YR2RKMUNSdnYwSloyTkpGRmUrY1YvR2trR1lZMkMxUEUvZGRRZytlREFE?=
 =?utf-8?B?V3dBL2NGMXhCU3hGcGZRSkpPVWZRZzU4eUhKMWlINjU5ZFZSZnhzY3lsSUdl?=
 =?utf-8?B?aUMvbHR6NnZrbW1CR1dZM2Z5a25kMWttVnBiSS9wZjF2enpFcG5KcE1vT1dS?=
 =?utf-8?B?TG9obnB3UUFueGFpNWJ4b3BhTGtzdDViL3kxcHYxeE4yTm1SMml6dUpSbTFP?=
 =?utf-8?B?RUEwa29qYktEeUV5bmFqaHNTMHRJYmJZUnJyemY1MFM4QzZKWi9zTzhwV2dH?=
 =?utf-8?B?ZFBWekdlSFZBamRrVyttT1Y5ZTloOVo2R0lmd3F2WnZ3U2Jzam1SWVdRWjdn?=
 =?utf-8?B?TUVlL0pCdlMrQ1JpQVhFR1h2V2IyUCtMbVc1N3k3eGVNam9NYk5RT0V5d0ZM?=
 =?utf-8?B?NEFMUGVVUUpIL3QzU3YzM1JRbVBLeTJrNXh4ZUlzcTRDM3dTNE9JbS9wL3RQ?=
 =?utf-8?B?NGM5bUR0UU5IZXhCQUZoYmtPTTJwdWk1LytCbFZkcDFzc1drSHpFTHpNL1pP?=
 =?utf-8?B?V2hwb05JbldQZkNBV3d0ZXgxZFpub2VmR1lNWWlJZkc2ZEEwSFZBd1gyT2F3?=
 =?utf-8?B?NGFBcHZQM1BKQ0RDdVFTeExWT1V1eVFweWM5M0pHR0l3ZzNiejlmckZNaGoz?=
 =?utf-8?B?Um1NbXB2RVNtWU10NWFJMnZkQWMvV1ZYcGJlVE00WmtoSlMxOUNIa2g4SndL?=
 =?utf-8?B?ZEI2YUpya0Nzd2x1OFBFR1YyUnVTaUxEZ1pGL2t2WWxRSjZNQXEveWN2ajRQ?=
 =?utf-8?B?czF3RjJIRTZFVnh0cC92d3pDb2NOekpKNVhhOEh6OHBZVERjMkhScEhHeEpr?=
 =?utf-8?B?bWF1STRvazlMQlU1ai9xZGxJSitHZ09XZlNzSGs5blhjSHV0Z3J1U1NQTkF5?=
 =?utf-8?B?cEhGU0VRUGJQRkxpeWxPaWNIdUdDOExEQ1JKYmd4Q1llanc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:20:58.6488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e403fc-b999-470b-b403-08dd08be88c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

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
v7:
 * Add tags
 * Rebase on pdx86/for-next
 * Armin's various code feedback (see individual patches)

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
 drivers/acpi/platform_profile.c               | 525 ++++++++++++++----
 .../surface/surface_platform_profile.c        |   8 +-
 drivers/platform/x86/acer-wmi.c               |  12 +-
 drivers/platform/x86/amd/pmf/Makefile         |   2 +-
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
 drivers/platform/x86/amd/pmf/pmf.h            |   3 -
 drivers/platform/x86/amd/pmf/sps.c            |   4 +-
 drivers/platform/x86/asus-wmi.c               |   8 +-
 drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
 drivers/platform/x86/dell/dell-pc.c           |  36 +-
 drivers/platform/x86/hp/hp-wmi.c              |   8 +-
 drivers/platform/x86/ideapad-laptop.c         |   6 +-
 .../platform/x86/inspur_platform_profile.c    |   7 +-
 drivers/platform/x86/thinkpad_acpi.c          |  16 +-
 include/linux/platform_profile.h              |   9 +-
 18 files changed, 542 insertions(+), 213 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c


base-commit: c6a2b4fcec5f2d80b0183fae1117f06127584c28
-- 
2.43.0


