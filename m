Return-Path: <linux-acpi+bounces-9297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48689BD06B
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF1D2837CF
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58B71750;
	Tue,  5 Nov 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ejzVGoVF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B81F95A;
	Tue,  5 Nov 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820814; cv=fail; b=Z5HpTkKn4IlvhlOQk74HdQdwPZKKAk6RixrwIWJ2W0qoOO7CGuyZ3sw9EUtsaArc/6/FeDhbeoVXdXcqItu1PmtIocCjHYSolt7Mqe3dmrzXRMYM/z1ZCmx58kFMXbFw8J4Ax2CpPCfYCalBQdickWm9tNtObeQXobFTcv3OM2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820814; c=relaxed/simple;
	bh=noSyjIaHY9ZqJHbjyAfubUmb31YFMDAJzr6v25ahXPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nl/lkNZCsnxK/51absTvUPIHs+5Nyb+2e49BYd5adYFhAfB3OkYgLRmdEUvYmwCANIY7SpvsXhf7XXh0vsoXlc9K0OrpKCztVfa84bBfYmO+tVGIYG9v55RR8BOGgTU5EGA3WwD+R+tXNmQEpOFVawwGZqhNhFSsAYWe+sLmWFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ejzVGoVF; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClYtRmUxOCopr3N3A4PG54UzaS3eSxX1oE7JYT/PIwqmpT3OePsMC9Bp9k1hDLqTzk7APKMC8stDBc4etMrU3kPS1cWlTTsm/hyAKkBLfCQSgZdJQInFLKU7FFinPtwypJd3ZQwbndY2hzzpudO+8T/+qUXXq8/V6Gu0fVbugQ5HffJHMWWfMn74UCGtRKzgthT3jYii3YvQQ0cD1l7hhSMszWdTtUb+KVJSPY9B0fHQK6y9whdEwHQljYRAoybqt5fyfm/hOCH8lqvDNFcUhxTQ2z37s/2XG9bBf9+rKDoV+AUK134eapvv1YxhQ95qoLAwu7CaW52H2UGaRFoqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uvzLnMRAQBWQ+S0RojCzMh99pAtnwvMtaN8r3Q4qLY=;
 b=A71+QeB45Jh0GQtEdp0PDtvWBaNizhK9OICuEtao+H4bdbMabGXFhovfg7RnaV/lk8dUF70EKBapQ0lLcbCHwSFVN+cSmzZACN8Q8EZO0KMDMJplybdXtqQ1DIe3wE2wL7QkLpG3rsryzovMDQhnONO11sfiLF7l0eGLrFzmw/7EQqg4Svx/LRZr1KBPrk9MRT2HQoOxpzDsMWwIhxUOMuDPSl6ej9NgYSQsfbwofemr3qWkNyNYLncMgD3WEaaxm+4yasINQhwDUoM4VxLnkXngxk3mqehD0/JaeqRHYBgwD5fFTgHmieoeuUpRwId7kQI4CUzQrE3mc7gnw9TIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uvzLnMRAQBWQ+S0RojCzMh99pAtnwvMtaN8r3Q4qLY=;
 b=ejzVGoVFT2ZQeQgUKfBF/VAzAp8JgP+gsJDi6kMC0S7seGW0BfZuj1jNAuxcuRrSjlhIGuE3yJqTkKEJ2UZQXXxu+L+H1D8I6ooG96TwuFwVw7tYp9/nr55q3pA96Sj/gb9/l8hqwNnWgNNMGfS5k6yd+3McnCn9VozHRXRX+vc=
Received: from MN0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:208:52d::33)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:33:30 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::a4) by MN0PR04CA0019.outlook.office365.com
 (2603:10b6:208:52d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:28 -0600
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
Subject: [PATCH v4 00/20] Add support for binding ACPI platform profile to multiple drivers
Date: Tue, 5 Nov 2024 09:32:56 -0600
Message-ID: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6d6aad-f494-43b2-533b-08dcfdaf3362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0FvUzY1bEY4a3Jnelp6ZGVlZzc0Uk4wSC81WENjcDd5NTZmc0U5Ni82elIx?=
 =?utf-8?B?VmpmMG0rR2p0KzRncnFJc2JEMmkrRWl2WkVxakRLMVpYYXo2eVZuRVdrbHow?=
 =?utf-8?B?Z1JsdGFBU2lMbVkwcmxvMmNka1RnRmIvRmJRSWNDRGVNSnRiQmlnMmloYlB5?=
 =?utf-8?B?ZlM2aGRDZFF4VWo5cUpoaVQ2emxOcm02TnptTFYrNldYNnN2QUp3MGxGb00x?=
 =?utf-8?B?MzhtSDdSSE1tUGJNNTJRQlJ6eG9CRldMMlBMQVJMUWpJaUdMclJkWTNMcklI?=
 =?utf-8?B?bVRaNnhPaHU5Y2s1cUJ5NFhWcks3cjRmNWxFdTVpcldlcXZ2QVUyTytEMFhq?=
 =?utf-8?B?TmxZc2Q0aFcycjdTOU95RXNQeS8vNWhjdURJZHVZM0tveWo1dENrVEw3UHdo?=
 =?utf-8?B?UW5RU2N4cEZlVGVEN3QyRFJkVUl5VnAzdE9lNzV2bnlscU1yaWhmZlg4SGdE?=
 =?utf-8?B?T3VPZk9Md21yTFN3dVh0YmtRSHpRVGM2RTB1ajVqVU5tU2J6WUViOTVkVnQ5?=
 =?utf-8?B?aXdrczFHUVRpUi9JNkF4VXFzWDBQc0sxSGxsaU04RzRsR0pXUGV2R2pac254?=
 =?utf-8?B?THJ5bjJRK2gyNFlSMzg2VFdaN2Z5R0RKb2xXWnM5UnJGQ1pTK2VGT0dBMXEw?=
 =?utf-8?B?bU9lK1RsUnhRSDlGc1VLSS9oak1wQU45VFloUFNiV3lBTUMwUHJwMXBkUHR0?=
 =?utf-8?B?OVpXc1RZbUx1SzlDY3lrTnVQUCtrVUE5R0t3Skl6RDJKVy9OL1NqOE1maFJy?=
 =?utf-8?B?bndGb0lxaWpuaEo2Z1VhSms4NFUvRE4xYk9pa3Y1dkhTV1pkak5ENlVkVmNJ?=
 =?utf-8?B?ZHZ2OExJSTFjd001enJwZGlETm1RWFVmd3R5bWpVdzBadHNta01IRkVFQmNK?=
 =?utf-8?B?RHBXZzNmQmdGTUV6VjUwN2JBSldTTmxydWtMdUdMQllPU1k2aUZPTytVTFg1?=
 =?utf-8?B?dWdKMDlOMkVONUNuSDlabjlDL0xyR0NIZGNNWXhjaGlZdDRqNFNtUTdkR1Zr?=
 =?utf-8?B?QzVLSGREQjZPcFdETXp4dU50ZG1uWHNNRFdjLzQxY1UwUFBGM0grNzNTbkxN?=
 =?utf-8?B?SDdJNENBa3FPL3kxWmNpdk15eTM1WFM5bXYxMHBzTDlTSmx4SUt0UFc1dVlU?=
 =?utf-8?B?eW9KbitlRzJISjJoWmd0UXQzKzJucXhGdkEwY0ppY1JKaGJENXVEaUNtRXJl?=
 =?utf-8?B?U0NMQzROZ2toQlIzM2gyQ1Rpb2tkS2o5cHU0UGtCRUsvMG5xVmxDUS9XdVJT?=
 =?utf-8?B?bnU3d2w3eTdDbEh2SElGWVpNUnJSblcxWnpMUWUzSlViTEVUYTlFZ1JNL05X?=
 =?utf-8?B?NVBqbXNJQkpQeXZxSGQzbEF6OUxGS2JsR2tML2pSWkFSVnJlQzV1SmpVTEFz?=
 =?utf-8?B?TTJzZjZERzZQZnZMcUl5QTJpelFmdGh1V1ZRcVhoMjdUVmlTWnRMNmRkRlBx?=
 =?utf-8?B?YW1kcVZ4SzRBZ1AvRTNjcjB6RkFRMXV2NDNqZnBia2plTHVmS2laMzllNGlH?=
 =?utf-8?B?RXo4OWtDS2RDY3FMQ0V0Uit1R2pUeXI1aXBFNDRKZCtHZ0IybTNOa0M1RHVE?=
 =?utf-8?B?QldneTRLMDJub1JwL2lKdFBoWmhGRlA1MUcydE5pWmU5MExvcWJjR3oyTHZt?=
 =?utf-8?B?VUFPbXVLejhJUDI4QzFFOXMwTldEeWpvMkFldFQ2SmNqVEZTblhma3ZPcnRi?=
 =?utf-8?B?MGtQd2JhMjMyWVJkYWxMTDVIV0pIdFdtNFBKUC8yNXdsdzJDbEU2RTY3UnJQ?=
 =?utf-8?B?Vko3Ui9OSXZSSVZTckFCUHZ2TVZFTjZtd3BQdEVJSGhXeUJKTnVtaUJQcW5j?=
 =?utf-8?B?M1F6NWIyblg3ZkU5RUNaV1E4R3pVYXZIK1ZrTEQwY2FkQWd3Ulk4SlV1TDJM?=
 =?utf-8?B?aUhxRDZCNTNmWUxnMUVBT3VoZ0UycGJPMTNHOUI2aTFRQ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:30.2328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6d6aad-f494-43b2-533b-08dcfdaf3362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123

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

v4:
 * Drop the list; iterate classes
 * Drop patches that didn't make sense without list
 * Cover alienware-wmi as well (recently merged to platform-x86/for-next)
 * Drop requirement for balanced
 * Rename platform-profile class members to 'profile', 'options', 'name'
 * Drop the name in /sys/class/platform-profile and just use ida value.
   IE platform-profile-0

Mario Limonciello (20):
  ACPI: platform-profile: Add a name member to handlers
  platform/x86/dell: dell-pc: Create platform device
  ACPI: platform_profile: Add device pointer into platform profile
    handler
  ACPI: platform_profile: Add platform handler argument to
    platform_profile_remove()
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
  ACPI: platform_profile: Allow multiple handlers
  platform/x86/amd: pmf: Drop all quirks
  Documentation: Add documentation about class interface for platform
    profiles

 .../userspace-api/sysfs-platform_profile.rst  |  28 ++
 drivers/acpi/platform_profile.c               | 446 ++++++++++++++----
 .../surface/surface_platform_profile.c        |   8 +-
 drivers/platform/x86/acer-wmi.c               |  10 +-
 drivers/platform/x86/amd/pmf/Makefile         |   2 +-
 drivers/platform/x86/amd/pmf/core.c           |   1 -
 drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
 drivers/platform/x86/amd/pmf/pmf.h            |   3 -
 drivers/platform/x86/amd/pmf/sps.c            |   4 +-
 drivers/platform/x86/asus-wmi.c               |   6 +-
 drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
 drivers/platform/x86/dell/dell-pc.c           |  39 +-
 drivers/platform/x86/hp/hp-wmi.c              |   8 +-
 drivers/platform/x86/ideapad-laptop.c         |   4 +-
 .../platform/x86/inspur_platform_profile.c    |   7 +-
 drivers/platform/x86/thinkpad_acpi.c          |   4 +-
 include/linux/platform_profile.h              |   7 +-
 17 files changed, 456 insertions(+), 195 deletions(-)
 delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c


base-commit: d68cb6023356af3bd3193983ad4ec03954a0b3e2
-- 
2.43.0


