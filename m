Return-Path: <linux-acpi+bounces-9162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F09B737F
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AEE1C24095
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52413B5AF;
	Thu, 31 Oct 2024 04:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rMckm5bH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429F80BF8;
	Thu, 31 Oct 2024 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347831; cv=fail; b=rEvRzUUeH5IuVtLEGR6X6x0DG5rmy7js485/eH47eBlIUXwPDPkipspPpPE+RJelUkmg3OdsoBWsFCd5ZQ8DefSqSZfuedQEyKBgZTfgT9OgtLyfRKnRqYJtW55pTxvlhWsBIpjs0jnG+AnUaiQC8IzCKW20F6nN6fEAwQLR+28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347831; c=relaxed/simple;
	bh=Wg1hEDlde7m+l6dG3EQUa5AXHHyziQXnMdR1NCKx0eg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M9GlmYP5aw8Kcs1PT7gGaqPh18L6/NOz50Lr7uAqUVSF+EvzCxIdZ+e/i946hGtU0ed2pw06J9keiiCxaFlaCts+WDxk5IQksXqgJY+R6SvrvHmc+tR+ZpgUf84sGkncT0uTR6wt5pdYSXiit8E5XcQCwtlGEKTAiM1tEg58kjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rMckm5bH; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktBgXrVUfaUQE87D1XcMfMxme8kH0nnstJczfuSc+rA4XBVJfd9zZyLAuOPYHPbmtLUDdfN+wW5WDRHV4n7fFyPXQZKl0IxAh6rxoXILAY73EA3c5dG6LpzDit4i/cTlzCyPVcgB8ArA8A/UJYqJKTI5eOC2BL9yEDF48FZWY4MxVGG9/CLn9Izn55WFjaVD5O0RixVGqPWBDcHt854TpA/gTujQl0od/Dd1mk+iXJzivwQ888eoNPbovEqUNsZppeys3TvvrSPz2ngmmSpk1bIapRaH6BFtTQ0PlllyTY7ERbtGO9vOOMDvtmSLa5C9CgjyLh7jVXmMmDTN//QoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02p4+GuHVzKplMFtqUukAaxUsF+xBroiW+dOD9sQl48=;
 b=HKgpq76GTNqhdY7079znoh/JWiBxHZdjhpfCbNDrk3ZLcn/c971xds4GGSdnUJzg1j0m+k0i+pLjAb75j6a4eKzOZnG3t3hv4H7nmwcc+iUSzEMwX7VDONpvLH7K1xxAbjq2Ol3DaZwwLfinCPvzRbyv1P+JfLFijDXAPAZjc7AlO6qMuAk3YFTpQY+YjHS6ivk75Uyats+LmNYRl4pZCxAXSLZtV3JNRKVeFLNWM6aRn7JIeeCLbGYiXVyv7axQqXwD8+EJO3KggGs/eOqY2ulPeHTer1a3Ftsddwb3lb2BXCyRPTxVUHUge+fWbdVdn8f0cypZI9OfJ9YYOm7faA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02p4+GuHVzKplMFtqUukAaxUsF+xBroiW+dOD9sQl48=;
 b=rMckm5bH+PTpg8ImOS7vRRG7vPDO8bbPgTz9cDmh9LmPvNKFVJVTPSn6wlfO/o3Q48mSZbGyehS4s+K2sI9rqfTvdza3l7wNHE7e/uoZZHkBztppHagQ04UWYsaI5nDGy6P7tnXO0ni9UwOa31jeTYMjLq+qfJr7oSCILy3awUk=
Received: from DM5PR07CA0094.namprd07.prod.outlook.com (2603:10b6:4:ae::23) by
 DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Thu, 31 Oct 2024 04:10:21 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::9b) by DM5PR07CA0094.outlook.office365.com
 (2603:10b6:4:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:18 -0500
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
Subject: [PATCH v3 00/22] Add support for binding ACPI platform profile to multiple drivers
Date: Wed, 30 Oct 2024 23:09:30 -0500
Message-ID: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 400f44a2-1804-43f6-bbd7-08dcf961f00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PtuECe5QJcxuopbjfr+3IFUcjsOnHw7Gg8iox4S4NmRG9kxFcbEnIvq1VvsK?=
 =?us-ascii?Q?/WF5oGdBJ3+zNHpCB/y5w75YC5R2XMek/XotKoxnFEv5SE2Kj/cUZm6wbmL6?=
 =?us-ascii?Q?jr2tP0FbBGci3wkcRWp9DOK5JPE1+0eDfp1vD/fYjULB+4bRrCB/PzMXo8rp?=
 =?us-ascii?Q?aY6InGCdqimt0YVRMzpmkuIc/s4bXtNxr2Lyu6iis/tno9a7nZXPtKS1OGSq?=
 =?us-ascii?Q?CVJ+gsHxFBVGEB+ybuUqVHG9BcY5Tji374h60voP7KSI6UOvBQZxzKnGNx7N?=
 =?us-ascii?Q?YJNP7Q/uXkHo4zNMJp73PYHa48U5HayfkyK3jEw+UV1tE4Wwr3hIBVHUbqj7?=
 =?us-ascii?Q?UsNtyMmu09ngO55qgpg/FDGd7r45ZlXB2DlX+vt5qjiD7NkZy7KCGprFOfUg?=
 =?us-ascii?Q?DHeUU2a6ORuDpyFRgGhz/5ykFqHWZfq9258biEv+z0YM9haGxKMID+HnLapb?=
 =?us-ascii?Q?/Zh4mWFwAjo/om1iAbJWYzzW+x+K+06H+vXuSyP3JF3a8wM9962ekL33G7LP?=
 =?us-ascii?Q?+Vwe4urzWCmGGjbPIv8NWlqRnpn6OZf/qtXP58bVmMh5Qm+Z2zArOzMK6YzP?=
 =?us-ascii?Q?A1uBFiOq4TqwmbJYijBYMuHK/gbWN6ejT3O5b2n2E35zyKwTgGrLsqYakdAr?=
 =?us-ascii?Q?+fIa3LtqOfm3arEpoITxclsbiQmj4OHV9UaZH2svuOKb8y4W8XJCbUJ3UtuI?=
 =?us-ascii?Q?4KwT7SAoKtAH1j3KGGiFuubB09n/nEfqIeh939qMd5+fVabgdCYpoVL4f6+p?=
 =?us-ascii?Q?xOopylcHmV6SwG+4aCPqJ3bdgdRMKOr/7I+1TMZyROPLqfaaPYjyaDpz/K52?=
 =?us-ascii?Q?sqWKp6Ak7sAB4e2hpXxv9TtSPDC/KoqdFEk5vSmNjv2KYGb9SP0/FRopWitX?=
 =?us-ascii?Q?g81btwEHYuRnGNOdmQ5eh4uQadUWQvROzMuIaoJ+PuBUt9TFTEtbileLqAqD?=
 =?us-ascii?Q?yaitXG5nLpXjYyvQR97L3gk3ije0TiBblCB3n7i7EePpbddBsat50l/vaq1M?=
 =?us-ascii?Q?gfafmmmtIBZFk7kfJW3erNbj+Qw3LX/2BQ+mYPpfvOTvWaal/ubH2zqDkUJ1?=
 =?us-ascii?Q?U5kYh9OkF9qVXkYz+7eHfIOg74wDcWMAHWw5XsBc+8FpjzAWBcTwcLFXhrIl?=
 =?us-ascii?Q?IG10WvHFZjCGnkPpkRZaocjH+tBO/2C8K2l10Wls/LRoJwG6e+b5c9cXDTvQ?=
 =?us-ascii?Q?m+HnDVtgF0/th5SuOCBEz0AdiFwPN6EVoGqsyegEFaVv2n0plSxAaj1uT2dk?=
 =?us-ascii?Q?/phah8+Guhro8jteujX7YAXez2QrWlIPZm8UF6m+HYRUxSJuMjyC7tWYv01r?=
 =?us-ascii?Q?whRrDcEBAOjTCqlmSEL3epgTuFGImBiSUFtHw2ON4O33JDQ5uMZqgy8NZeQh?=
 =?us-ascii?Q?E8zs/PvyAiKgQ6LxymtL1+YASvzeWAePbECBWkJqrgcR7EwCQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:21.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400f44a2-1804-43f6-bbd7-08dcf961f00c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

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

To avoid chaos, only positions that are common to both drivers are accepted
when the legacy /sys/firmware/acpi/platform_profile interface is used.

This series also adds a new concept of a "custom" profile.  This allows userspace
to discover that there are multiple driver handlers that are configured differently.

This series also allows dropping all of the PMF quirks from amd-pmf.

v3:
 * Split to even more patches
 * Add concept of class device for platform profile handlers
 * Add concept of custom profile for legacy sysfs interface
 * Pick up tags for some patches
v2:
 * Split to many more patches
 * Account for feedback from M/L

Mario Limonciello (22):
  ACPI: platform-profile: Add a name member to handlers
  platform/x86/dell: dell-pc: Create platform device
  ACPI: platform_profile: Add device pointer into platform profile
    handler
  ACPI: platform_profile: Add platform handler argument to
    platform_profile_remove()
  ACPI: platform_profile: Add a list to platform profile handler
  ACPI: platform_profile: Move sanity check out of the mutex
  ACPI: platform_profile: Use guard(mutex) for register/unregister
  ACPI: platform_profile: Use `scoped_cond_guard` for
    platform_profile_choices_show()
  ACPI: platform_profile: Use `scoped_cond_guard` for
    platform_profile_show()
  ACPI: platform_profile: Use `scoped_cond_guard` for
    platform_profile_show()
  ACPI: platform_profile: Use `scoped_cond_guard` for
    platform_profile_cycle()
  ACPI: platform_profile: Only remove group when no more handler
    registered
  ACPI: platform_profile: Require handlers to support balanced profile
  ACPI: platform_profile: Notify change events on register and
    unregister
  ACPI: platform_profile: Only show profiles common for all handlers
  ACPI: platform_profile: Set profile for all registered handlers
  ACPI: platform_profile: Add concept of a "custom" profile
  ACPI: platform_profile: Make sure all profile handlers agree on
    profile
  ACPI: platform_profile: Check all profile handler to calculate next
  ACPI: platform_profile: Register class device for platform profile
    handlers
  ACPI: platform_profile: Allow multiple handlers
  platform/x86/amd: pmf: Drop all quirks

 drivers/acpi/platform_profile.c               | 330 ++++++++++++------
 .../surface/surface_platform_profile.c        |   8 +-
 drivers/platform/x86/acer-wmi.c               |  10 +-
 drivers/platform/x86/amd/pmf/Makefile         |   2 +-
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ----
 drivers/platform/x86/amd/pmf/pmf.h            |   3 -
 drivers/platform/x86/amd/pmf/sps.c            |   4 +-
 drivers/platform/x86/asus-wmi.c               |   6 +-
 drivers/platform/x86/dell/dell-pc.c           |  39 ++-
 drivers/platform/x86/hp/hp-wmi.c              |   8 +-
 drivers/platform/x86/ideapad-laptop.c         |   4 +-
 .../platform/x86/inspur_platform_profile.c    |   7 +-
 drivers/platform/x86/thinkpad_acpi.c          |   4 +-
 include/linux/platform_profile.h              |   8 +-
 15 files changed, 303 insertions(+), 197 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c

-- 
2.43.0


