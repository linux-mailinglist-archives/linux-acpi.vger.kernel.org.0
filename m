Return-Path: <linux-acpi+bounces-10007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8494F9E650C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9351884B32
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4FC19754D;
	Fri,  6 Dec 2024 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XCIvd1c1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04A1917FD;
	Fri,  6 Dec 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455666; cv=fail; b=gCMr6B7xH3RLMJOK0Q+cgFK8XfWGbXj5Ed6tuOrVOybCktm+32tmM4GdJCb22DkXeL1CDn3ltxzC57l8gN24QidyKD3d8V9dhQqy6t6IFxkZmgdI1mQWfFyYf7C3HddbvLhYgZL53UEamTGqmCrJOA5azCe0cYw7es1/OR4NTwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455666; c=relaxed/simple;
	bh=l2U2KjFfLUmyApn2ATtD6b4JTW7rGlGqzZsqU6yv/I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plgTxnoDoMuRHl6NYhGM29eklMORq6xf4tiQC3k6aCQBz/4AZVo0SYZPA91IJInKlw/KcOv40kLrF7LEUI9SaWf+lZH4z6zFczHYj5wYY5Y1liHe+zbPmfgtWgOPiy4+M96U0vPeDex3zr72yYdY95osFbkpU3tzu0j5VX6XYl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XCIvd1c1; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hv59tU+Zb1lV1PQuzaFF0KbdXB7EfFmSwDON0lio/R5CVs502Vc/FWuIp8kwIu1Ti7GFrT7QCysSQLggS293yPUZC35B6ZJPxbGvvwNctmLobCNFhRHmyjdIA0Tq/nlDdhxxL8J4U7T3z8A9lY6hG7sZth201qJdpMrq4L3tCFdO6jJnGkvMMgb9kDpOWNe/pMkf0bzXAtqMnKBVh80mz3G2Ds8mrKQQnPB8udbwF+pJI1KamkyUQI69c121RcTzfwzAj3wTD7n4I03jXQdY/hnF/3NgDU6n7jC/1ldPtPysvXqupyxuGwvQnT9zmzGuEBDiXHCddFrxuPoEUjUwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUTFvONGs1tTyLtC91QLAACJkBeUgHTdatBQ/+u7ljE=;
 b=H8vE6Qv2vZjCxpvMl+WdgrlQ9z+xDPQtwTC25Ud95a+m478LM4YYu3XuwVM4AltthdgbAFezMjMA0NPPORr7OAudQ6v6fM5iFjZ5bbqUbHXJOc+fzXv7dLjiSIewhleeLrC4+CSFkQhKosPbO+70VtVV25xK0uW39fhCCJwTBxAnaZ0QWzwNJvz7zj70W/RbL9xBHCuCRhfPJKD68hd1edpgolfNjFhb5Y8vY0kBzDOtigh7/UIsT9yLpd86njaUUBRv/KA9mLlbBwAEKZEGBtjVd/EVfk71OncA0upk60DC+TlGTHI6nFekqAaRE2qVD+J7RePcSZoOqlaZ0Y9mWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUTFvONGs1tTyLtC91QLAACJkBeUgHTdatBQ/+u7ljE=;
 b=XCIvd1c1YoUUXoRDncLRQ32dW3pmD4XMMil8kMIz349pZncAzKygKW1UEJ+925qHjY4FHN0ZN90IQJtbZcdWg/Acm4p0GIVSwWg/2zXmvw25SLqBXOQ/ngvvkV5nHTHklJR9j4SXsdJU7BxHjO68Vy1MFXdX2hiXjdiyvvmsQu4=
Received: from BY3PR10CA0007.namprd10.prod.outlook.com (2603:10b6:a03:255::12)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 03:27:39 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::4a) by BY3PR10CA0007.outlook.office365.com
 (2603:10b6:a03:255::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:27:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:26:28 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v10 22/22] Documentation: Add documentation about class interface for platform profiles
Date: Thu, 5 Dec 2024 21:19:18 -0600
Message-ID: <20241206031918.1537-23-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b29437-0bb4-4069-77b7-08dd15a5efd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1k3dEo1VTZjNDlmUWJkbWR5SnlXbURCbDdqZU51Q2tyRENkcmc5UEpiM0dq?=
 =?utf-8?B?WFUydzNjeFBuOWh5eDBSbHprbURmaUJ3MGd4d29DUVRFRHJoSWVxWWg2TW53?=
 =?utf-8?B?bE5uN1J4RytuUFd1SFRNNjRJdmFndldwYTNiZlFYRC9HaDRYYUNPVExTOC85?=
 =?utf-8?B?QXg5R2lCWFpQR256TGJucWlTa09WNjVPZFVOQnplUWs2c3pTcTVwdnJ4N2cv?=
 =?utf-8?B?Z3Q0Mmc1b0MvNWhVQkhmSlN0YnpLUTRRTHorTTBzeGpvRHJoNDZqMVpTaEk1?=
 =?utf-8?B?Q2wzbC93b25kU2VQZFZmdTlrZkNxb1VCb0V3Q0doblVCK056SWVtZWVjSXFx?=
 =?utf-8?B?L0tkbE1aakIrWllnaS9FNHlyM0pHVGE0QXVFZFJCK210N1hGUmhEYnU5bHNk?=
 =?utf-8?B?S2p6QnBmWm1kRklVcUpPZnhmY1FUOTYxQzRvSUREUWR0Z0Zvd1l3M3lGVTI3?=
 =?utf-8?B?M2pyT002NVJPSFMvQW1hSGpvNkhzUU1LR0RoRUx3WjcvUUNTWm1iYllNTkNw?=
 =?utf-8?B?MFc4Ykhyd3lrSkZyR0lRVWNLcUxFNXdIZUE5d0krdFFmWU9KNG1sWVB2OXFF?=
 =?utf-8?B?ekl4WUxWaFJYVlVXRUVvTSsxblFhQmdBTlAwMlpEQjhNQlMzTk40WGZBeXJG?=
 =?utf-8?B?QkFMVVJFRmJPZmdQZHg5S2dETm1sNitsRG94Lzk1UVoxejM1NjlDT1lldTBy?=
 =?utf-8?B?TkpYaUdBaWU3TUg5S2tNTEwza3ViOHRCZE9IWXVDZkI1SUMxRjM2azdZUGIx?=
 =?utf-8?B?NGxYM3FyeFcySGxGckJ3aUlzMW5JTFltNHpRSGZPNTd0N2hqcndaeGVtVmZN?=
 =?utf-8?B?ZXNZNlF2S29TNHNMSFZuelU2dlR5cmw4OUg5SC9LMko2eWM0aXgvamNBR3BX?=
 =?utf-8?B?aTJzRG5pWXljSEdaZkFIQTJrV0VVNHFRWlZzN3U5YmU4bWdENXpOQ3NWOEx2?=
 =?utf-8?B?b3dHQURmd21uRFlOTVQ2L1BQTUJJTVFpRkhEUGVtQVNYeFpIMVJ1V1oxMUov?=
 =?utf-8?B?RkViZFNjWUpRUXJYWFdWTk9zUG52dG40R1JJRkFsRzBHTnZMM1FZQjIzNE1R?=
 =?utf-8?B?RjNkTi9RMHAwbG1MREd2U0F3Y256cUxYajFob0ZZQWFGYWdtb2YvRGFJTVlL?=
 =?utf-8?B?MmE4aTc1RHR0b3JnZ29lTjlOOXdTTGI2a0NKc28ra2tCd1B0eU9NMkxMVVpZ?=
 =?utf-8?B?TTFLbjVvRDNSZVhYTWJFVnR5R2FQQng3a2pXa3NNM21sUU1IQjlxZkxtcHNO?=
 =?utf-8?B?RTVJR09pTVdSdm5KY294TWFORXJmOTBZOWdmUUZPTFJ6YW5vempGVUVYOEhN?=
 =?utf-8?B?U052UFBuNG9rRW8rQzhXK05LMURmTVhOcTgyQkZCa3l1WVduc3Y4OVpIVUo0?=
 =?utf-8?B?OFhhRnVvb2hpVytJYit3Z3RwcDNMSDVBNFdCajk4QlNUdmJJdkVJNEUwSDQv?=
 =?utf-8?B?ZkhWNVQ0RTQ1Z2dtVS83ZlZ0SktuRy9tM1ZDdUZWSW5qMllkWE91WUNDcGo1?=
 =?utf-8?B?b2hmTEI1SXdJY2FzZDBESVQzM3JEdGI1K2lMN0dUVlVjUnBCcklsbHFxcUl4?=
 =?utf-8?B?MlNBUUhwZ1hXcEhyKzBkZ1A2cVgxWVBJbEhzZEkrS2NFOHFOQldFanJjUURQ?=
 =?utf-8?B?S2FKME9lOVBKc2NFWC8wZnFZQlAzRUVtaVRQR0tKaHNXMXcyYlBmaFZHbXFa?=
 =?utf-8?B?SUpBRTYwNkJvRmptYzA4a0xQS1MycHEvTzE0Nklya3N2OXBRNm81UDk5Tklr?=
 =?utf-8?B?d25UcUdGekhVU0dKSmpNdU9tKzZLSnZlZ0ZRM0gvNUJqK2I4UWVNSVRVWTZZ?=
 =?utf-8?B?Y1R1UGNXbzZDb2JxSVJOVldDdXhZQUY1Z1VadmlaM25xeVZDa2xwQzdQNHoz?=
 =?utf-8?B?d09SMWwrU2o2alVVNGFaSWVFZGFGaFFiSVFXZjZCYUorVnk1NGRrK3lZWXZR?=
 =?utf-8?Q?m3zeM1q3JAg7ljVsi0yEzKjv8OO61L6M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:27:39.2381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b29437-0bb4-4069-77b7-08dd15a5efd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031

The class interface allows changing multiple platform profiles on a system
to different values. The semantics of it are similar to the legacy
interface.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * Add custom section
---
 .../ABI/testing/sysfs-platform_profile        |  5 +++
 .../userspace-api/sysfs-platform_profile.rst  | 38 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
index baf1d125f9f83..125324ab53a96 100644
--- a/Documentation/ABI/testing/sysfs-platform_profile
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -33,3 +33,8 @@ Description:	Reading this file gives the current selected profile for this
 		source such as e.g. a hotkey triggered profile change handled
 		either directly by the embedded-controller or fully handled
 		inside the kernel.
+
+		This file may also emit the string 'custom' to indicate
+		that multiple platform profiles drivers are in use but
+		have different values.  This string can not be written to
+		this interface and is solely for informational purposes.
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
index 4fccde2e45639..7f013356118ae 100644
--- a/Documentation/userspace-api/sysfs-platform_profile.rst
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -40,3 +40,41 @@ added. Drivers which wish to introduce new profile names must:
  1. Explain why the existing profile names cannot be used.
  2. Add the new profile name, along with a clear description of the
     expected behaviour, to the sysfs-platform_profile ABI documentation.
+
+"Custom" profile support
+========================
+The platform_profile class also supports profiles advertising a "custom"
+profile. This is intended to be set by drivers when the setttings in the
+driver have been modified in a way that a standard profile doesn't represent
+the current state.
+
+Multiple driver support
+=======================
+When multiple drivers on a system advertise a platform profile handler, the
+platform profile handler core will only advertise the profiles that are
+common between all drivers to the ``/sys/firmware/acpi`` interfaces.
+
+This is to ensure there is no ambiguity on what the profile names mean when
+all handlers don't support a profile.
+
+Individual drivers will register a 'platform_profile' class device that has
+similar semantics as the ``/sys/firmware/acpi/platform_profile`` interface.
+
+To discover which driver is associated with a platform profile handler the
+user can read the ``name`` attribute of the class device.
+
+To discover available profiles from the class interface the user can read the
+``choices`` attribute.
+
+If a user wants to select a profile for a specific driver, they can do so
+by writing to the ``profile`` attribute of the driver's class device.
+
+This will allow users to set different profiles for different drivers on the
+same system. If the selected profile by individual drivers differs the
+platform profile handler core will display the profile 'custom' to indicate
+that the profiles are not the same.
+
+While the ``platform_profile`` attribute has the value ``custom``, writing a
+common profile from ``platform_profile_choices`` to the platform_profile
+attribute of the platform profile handler core will set the profile for all
+drivers.
-- 
2.43.0


