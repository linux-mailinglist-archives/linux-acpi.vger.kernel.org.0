Return-Path: <linux-acpi+bounces-9014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E299B2228
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCB21F21BFA
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D314386D;
	Mon, 28 Oct 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEaLAsom"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF021DA5A;
	Mon, 28 Oct 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080923; cv=fail; b=R1+E7vgiRQ459ofyqEywd/hPjvk4A3/ZATATj//GuTkBccg3SmAA5kwUEKKZuUbYjRIYGKSzG3V5BryzeBwi9CV9WJOs2pPAR4HZJJXB28EpxMrBKJcrtRYHfNYOP+O42TiRJopBiLOv9h2xaCgnGQWnwB0MHgHUqEOty5f2HWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080923; c=relaxed/simple;
	bh=edLuP1KV8bi7kPKEgc9KJU4e22Z6N6dRC9HOaBQSjWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d+rqrXUAFUgP1RJ0cbGK6hS62bYfgDjU5kE7JrHBqe3oAN3h7oLH13nE0/QclRh5TmTCbuMvvcPw3rwWEhiuTpqt0zdjTvjqg9E7i/wUMaX8a6q0N6mx7db+x+reChboeJ8mxg8e4TcTZheh9N5gCqjArJyRX43pRKtm3oMGBBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEaLAsom; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y73dotOE8Gg55xGpcWs6W9WhZB/mr1SfbIqmUocU3nRld5czjrTB3CM1eNrYgJYUZ9olGGxjoq0nHAopdEMrX9u43QSKn+b6LfMuHaQY64ri+zzLNL2sKjL/AqsVc1KzGPr/rKOovUoRocCM9hMIKT1dRg3c8762Z/RN2aAbhgiQKkuP/V5FmlI2RNSuOhOWTLxKYqAzFfOhaNlIGziB6TkK0vvHbfIC9ndk1IjIcoAEAmG+3t3zXhqZKCY8BZtQbdSAjDecB7SfNShBErkRiWS9aRuRrPRX4fN/jnG/S4yV2EbgobLskwgJ2x7OygR3rWrSvQpPElRcXiXl1duyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Woup2oO7qjAL1nUWO7zY4NXRiNlo+EFKnv932ZK6EAw=;
 b=I1Sfpq7kE7E9d8Tb9rGeEZcOyfdGrVVx0LyAuaV5JAvKWKNr1gC2msGJ6ONW6xuHQFLXfX5mFWHON/JbuG7gPTqwRz6MYdtnPzRXqR6q5y3z5SgYqZ8t5HMsUb7lxRwA7EsKwvpmSesgwYMIreRVaqnB2p9fPpkKZQBbeQSTG87/4FCh2TgKpwv9xCBz0MD1Dd+i8lRaSrLuGJLgt6SfHX1S/owl3HZIZukEKE+rtC6FTzhw/fp30xl/su4TQwMwLQg9egHneKgiSnNxvZxlm1GOVTuZA4qMoKe+UFmfMNx9aTjQw4YxpAAdBVl/8I3MQPlgMr4x7cV88H8k4BCFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Woup2oO7qjAL1nUWO7zY4NXRiNlo+EFKnv932ZK6EAw=;
 b=PEaLAsomTXHoKz/Ru6QfUIrJtGQDhfxcO7aNY0AY0oPYTuaboNJlSB7WV5+HQWJvnfQPE++fOJMpRsyohDi4kv/hekKS6w7CwN6C/FQ+op9rbfiAMXquxVaSEd2h4A2y2OKMtzoTuJwFFdRRbpmwbQ8HnKSGqnH2ZfaoAeuTi04=
Received: from BN9PR03CA0791.namprd03.prod.outlook.com (2603:10b6:408:13f::16)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 02:01:55 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:13f:cafe::28) by BN9PR03CA0791.outlook.office365.com
 (2603:10b6:408:13f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 02:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 02:01:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:01:53 -0500
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
Subject: [PATCH v2 00/15] Add support for binding ACPI platform profile to multiple drivers
Date: Sun, 27 Oct 2024 21:01:16 -0500
Message-ID: <20241028020131.8031-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: c1640493-ed6f-4a79-3a5c-08dcf6f47f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BsJXv2BXtINcFqOfSrkGlcvdZNA2uH+CkrZtfuOVlcvZVYC2P3TJh6BipVmY?=
 =?us-ascii?Q?eMsAv4VdWfQd0Bu7LKp9HrbnJ94FMjvCMc3gh794khgSSgp1Q5r/hFm5NiXo?=
 =?us-ascii?Q?jHQ5W4efiWhJs0IE9Coqb2CeXslES978bIdyclLasDMHe0IdNzGJfbZ0pMcD?=
 =?us-ascii?Q?Q9FKaeUMMoYxirImKhJnOVwtT6HvwUvFv3kH7IhzkIDU88aouuy7LjWX+rhU?=
 =?us-ascii?Q?CX136WboM23HkOC+c412QNnV3NBfBj0F2kL7kpdtayh/BGlWbgdczOlrvRtG?=
 =?us-ascii?Q?RKEb1BIEPBXil3LdTccNoGO7plsHhrkmRpEr+3Z4kNOWG3wkRyPUUBBkiyqU?=
 =?us-ascii?Q?0mvr/dzlGHO0Zakl3ptt7YyjM3lHqWYkii5mUmrGwL+jSUX7r+sQj24XC/ul?=
 =?us-ascii?Q?EL1BHZv7FP5pBokrZZ7CY/slYnsr/boRUdu9Bu6EV4Dtdu7iDDz47s2AatmW?=
 =?us-ascii?Q?z/9kkEz2OF0BT81ZeB7CNk481Wst03p1qSbv9Tz5P8YQwo7Q9COzSylbyFfq?=
 =?us-ascii?Q?hy/m44S8HK8sMHwFUQDs32TI9yaRzpvy9737aoBOOTa7TdZmE25r2rtHgNxa?=
 =?us-ascii?Q?Cp/C4dxD1TcbdmYvEEmVXiTDSe62ZUT6TFJnsfN19YNCWpRycXBiQbYrRtkk?=
 =?us-ascii?Q?O7JsfTRhTUlvQlM19ZZuq9jfD8wkzED/LMeWK9jWL/pzjH6YS6iUJh7Og7v+?=
 =?us-ascii?Q?74/JStYrjmy5PBAmSowfak2XLYftu0CbgBVr1DdvrUXmWyR5IXRiGpI6RryV?=
 =?us-ascii?Q?ANMPeNk88oQ0iNRbY8Hh5e2SKRGjP8B48NPmwThpE2qjFOrGCBOrI+2ujG2z?=
 =?us-ascii?Q?xYIbJ49a0gn0LI4BxhRhCap8R2F0xE72aJF1tRRAeD79c7yM9v72kYS8rer7?=
 =?us-ascii?Q?Coxfl+i3h3DyQHcsAL/rkA8tGETriYSrhC4JpDx1hnXOfBd4wHqlcUVKhBMm?=
 =?us-ascii?Q?r6k99793XzdeMPm0YQuXB2roKwbBsLtW3CdJR4GfTa89Mz49M6epA3nsZwrV?=
 =?us-ascii?Q?va9uPCxeb0h3N0qNA6XsMyGewtoHzfbWOZy6yRfl5I6wtRQ1qpgOrbwymuq8?=
 =?us-ascii?Q?/c4Sc9jpQgTkDxZw42EkeZ/7suJpkKFgL6BDvga0GTxAE7OMJj0QLkrpR0VM?=
 =?us-ascii?Q?AynLTSQzf2tx8qytWFbi+/CnVY3Bc7l+aSJDHJA7fqgC0zgIfrvR4mox8oP6?=
 =?us-ascii?Q?pq9aWPaKms3LjyBTNhvX9sAL+9pmeVms96WkvT+0zZFBMVGXDjMsQm88ncJp?=
 =?us-ascii?Q?qLvvQaCOi0H0hFlcGgt4f3LyXIVXtWiEcGNSgtSvzS/EiElwZ7zjlQ2WaIg0?=
 =?us-ascii?Q?xTEkfooNggsaPhIiucAd9Q55a6DgTNq0S0Ip7H66aHZl1AUhll4A3P3oiFXZ?=
 =?us-ascii?Q?/yi1UwnAel1yR5W237L7GtafyQjtypT4D0pC1xRN+MbWAzpvUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:01:55.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1640493-ed6f-4a79-3a5c-08dcf6f47f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

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

v2:
 * Split to many more patches
 * Account for feedback from M/L

Mario Limonciello (15):
  ACPI: platform-profile: Add a name member to handlers
  platform/surface: aggregator: Add platform handler pointer to device
  ACPI: platform_profile: Add platform handler argument to
    platform_profile_remove()
  ACPI: platform_profile: Add a list to platform profile handler
  ACPI: platform_profile: Move sanity check out of the mutex
  ACPI: platform_profile: Use guard(mutex) for register/unregister
  ACPI: platform_profile: Only remove group when no more handler
    registered
  ACPI: platform_profile: Require handlers to support balanced profile
  ACPI: platform_profile: Notify change events on register and
    unregister
  ACPI: platform_profile: Only show profiles common for all handlers
  ACPI: platform_profile: Set profile for all registered handlers
  ACPI: platform_profile: Make sure all profile handlers agree on
    profile
  ACPI: platform_profile: Check all profile handler to calculate next
  ACPI: platform_profile: Allow multiple handlers
  platform/x86/amd: pmf: Drop all quirks

 drivers/acpi/platform_profile.c               | 258 +++++++++++-------
 .../surface/surface_platform_profile.c        |   7 +-
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
 15 files changed, 190 insertions(+), 181 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c

-- 
2.43.0


