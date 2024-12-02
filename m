Return-Path: <linux-acpi+bounces-9848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9218C9DFA4E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5021606DE
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930741F9425;
	Mon,  2 Dec 2024 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5QiFK9Aj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B51F940F;
	Mon,  2 Dec 2024 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118701; cv=fail; b=P1wOFNFyCXo0IlW8vF0IIslJLjtxPkcB2mwtwO9+m4qMWy/ohxGl1WRsCEZZrxe4rz2ktWwI8DKOOM9mNeXieyiSs8O1WE4jZK6AgWVBmRB23iqI/0y9FxErrAqFxUQUK0bazy1bKWuKVNSa28lHS2l58TKikhtpFkcNtHZgZzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118701; c=relaxed/simple;
	bh=AhcQq/qoPABsrY8CsoC/m8lNX7jnLQEA1NZQjsy9xjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJ5SkSiJ47D6KVSwxw//D+eoC33xQLdc1wH+9gWA56ex4Zz9eJdPtP+r2ili9/CpLIxPziTraQPmV6Yb/aqchl0/8u938zxD0PFNiNqy45D3PKr/KxRHf8HKlRncoFEfgqBI2Px9f9/mMJCgmJlGauZyBEdwu0/3bQU4JC7ddOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5QiFK9Aj; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbXZHh7muk/jSfIvFNc3NMDqW+66p9mMdxujZM4y0i9sASOivZmWR+1kOFge3JRueB96hXKuKAipMHXEgB7LW1paJgWmPaYMXxOc+MKN7tWvpAI4ujARtSZHE2e3FC4L1gzL10e3mFWARQpdFkx9xNknTwviusgmfCMOCzSiE5+as34EncxkRqHtsHhFPnnZc6KXzIAlBs/AW2n2biBO55bHeY+jhkPnadH/tS13FWBWWWCmaHSPEAlu1y2NR3v3zAfqd0aNypbdqpbUO5mTY2V0bUNZboJ+2Zvd1H/3YpH+Vc411uHJunc/QcJlp3DCf/nI+trSjS6wrVmLtB0DyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnx4s0xfHI8MWMTVeFUsyesOxs3tBhsZmpwtkndEF7o=;
 b=I5+y/Y8GOMPsRSumD1djhb5uIo+9lGUOo5l5TiG6yFSuB1OEdMkCbdSXxODFd3rVotoqLrhcboHidlXmHATUbPHcRzceVymqjuK36qmBAI2kxdWsT0QOdzIj0rPRpMOsLrj1b8/5qoxnJIc/115tgLysqYuVDDjTCMqPGxlqwOQaozrzJknOs4OtyFzKTcm90m+k0qG4PBKrxhpYdQ7/5btr5+SLNIGr8rvDJNeJ2D+5ezarZ2nFVhqvF1KrQBCIM3P3J8nSLnDULZANsZilfaf2i6cwpqLnCVFuj7YLrVGC0Dv/xLhPFYxJ1B6Ik0kkQVjDURj1E2DgK/i9f9pDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnx4s0xfHI8MWMTVeFUsyesOxs3tBhsZmpwtkndEF7o=;
 b=5QiFK9Ajbj1kfF2oTBp2Mtp05iYKFi2ywN4FsgnY2rBuQ4ePcW9DqHFUtmCnvI1qJSab1P1ZFQyx1qqtz23BwuGoQFA2fxNnGVGGXh6KkMbQnsbBNiqNdQWB7oi8hLDWcxxGcXldZj1zPBfX12n6pq75H0eIgifTyZd4fC9t4pI=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:51:32 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::c7) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Mon,
 2 Dec 2024 05:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:30 -0600
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
Subject: [PATCH v9 03/22] ACPI: platform_profile: Add device pointer into platform profile handler
Date: Sun, 1 Dec 2024 23:50:12 -0600
Message-ID: <20241202055031.8038-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: f8cd0e09-77e9-4c5e-4d57-08dd12955fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWwzKzgwbW1Yb3JvREN3MkNDTE8vdnVRdDd3bkdod21VTTF0ZWFHMUl4bWJ6?=
 =?utf-8?B?QnZHWGk0WDVkaVRwbkNaU1Q0MFl1cU1CeDN5bnlLemxSekU4ZzBwbGQ1aHpp?=
 =?utf-8?B?ek5ybzZQZjA4Q25YU0NnNVN3bVNqKy9xT1p6d1ZsMXUrbEIzTDUrM1U2VGFU?=
 =?utf-8?B?RXp0TjZTVFdBTm9maFdManBrN1dwUUt0ZGRqVzBNUWFjdmxncEhLeXZ2MDJ2?=
 =?utf-8?B?WkZQZ0xqRjRjY1pYcHpNdUtEOVo1U0Z6NFgwZGM0ZEpFZkd2T3NsTjRvaEtj?=
 =?utf-8?B?ejVFakFtOHFCSXhVNlV6bkFkR00rV2pnWEcycDBTV3F4bklxNVNCd2N5c0M4?=
 =?utf-8?B?aWhib3JVMjB1TDFGbWxveU15eXRlODlGOFJoMi9hdXNrdFF1a2ltVjlVeWpM?=
 =?utf-8?B?SnFndEI2cmlTQkE1RkpObUhpR053dDBYMjUwbDBudmxUSVEzYWVyMkR3dnZt?=
 =?utf-8?B?ek5NaTY5MW5DdWVldk5BWlJ5UWdxZzZkUktsT1BpdVFsR012M3dnK0FxRm5h?=
 =?utf-8?B?d2w2WWZZK1kzRnpVc01ScUdPVFo3eCtzb0lZNXpsZm0xZ2M4TVlQaUlweklv?=
 =?utf-8?B?OVFMWi9oZUJ5Y3g0ZlY5NHU3NXEyMUxyeEVQOU5oQjUwZ05sVU5pcWxaeGFh?=
 =?utf-8?B?YUtpNTRYQkpKdExtM3hYclZrLzBtcjExUUs1RDhkb2Rsa0gyS1pNNDJ0SGsy?=
 =?utf-8?B?cTJRWjFUQktlaWZjVlFFQTJCdGVMcXhpM0ZkTnBuNUZBMEhxWDVZOTVubmF1?=
 =?utf-8?B?U0hWM3VxaGhaSTRWTXBHUjFTUjBzWjRlWDBJTnFkYXpMMWI5cHVmbjRHVUdR?=
 =?utf-8?B?bC9WRWNydkFhZkVPVmFwZ2M0N2NSLzc2LzYxdEE5WUZsbkV1QnVTTGoxVEpQ?=
 =?utf-8?B?ZWMwcWZESlowaUNEQjQ2bFl6T01PTDhRVEJ2NnpsV20xUEcyZVVYYmFGSCs2?=
 =?utf-8?B?WlBSYjRhSVRVQVArMU9zZW9aUXc5bnEyM0kxQnhDVjZjR1dXVlBjaThqUWs4?=
 =?utf-8?B?cktlc3FJNk5iTkV4cnVJRFczdXJqWFNuUFYzZUZ6SDdBbUtSRjlWWlF0c2JG?=
 =?utf-8?B?T1VXN0NjcCtxeHIxSDRCblFYN3BGTkxMZGRtVTVYWWIvRll6TkdxbTJEa2pq?=
 =?utf-8?B?eUlGUWRaSFllc3Z5TEFQWXJsK2NiTnpZc294M1ZCZzJRUko5YmpuN3dvaEVn?=
 =?utf-8?B?QTdZRW5nTHFDbmg1Z3h2VCtzN0F2Rjg1MmlkNjJNdTdTbC9PaVhVVlhXSGRv?=
 =?utf-8?B?ZDZCdGlKOG1WKzlUZjV3V3EwNE9nMmU0cHBseEg3L1hwQ3ZRVGo2QzMyaW8z?=
 =?utf-8?B?bHFFU0taRWlBUUxpMmtFSUVXcVAydEZ5bUdVbVVWb0M4c1dMZzJ5MlM3QmxU?=
 =?utf-8?B?aG51R2V4YU5uaWVMOG1hTjZWRWg0YU5qOENiUlpwV3RnZnBOTlU1bkRxS2hr?=
 =?utf-8?B?UUpQbkwzZTBOOGFTL25tRWl1SVMrMm5jVzYreW9EeUNhbEdKM040TEZJaGVR?=
 =?utf-8?B?U2tsSzZtLy9KYkdqWWNKRTJDSkc4Q1U2cW96WUMyQjR0ejd6VXJPWndZWlJs?=
 =?utf-8?B?Ymw5cmJKTXRUK25uS25STERsdVg4aW44NnR6Z0tlemJ2OURRaWZQa3R4NXFX?=
 =?utf-8?B?RitsZmZCcXNOaFVFdm02dENtNVBkVFJaSThUeDJDbU5Sa2phZzk1ekcrSFd1?=
 =?utf-8?B?eFY4dGpHak92NXhYcGlIQVI2dWlTWEMxN1NTOVdzYm1lVWFtYzlxaWZiVTdU?=
 =?utf-8?B?VWpZYUk5aVMrOXZvaDZ5UktpeGZpSlROUnNhSGlqL2NMZFZ6N0R3QmhQeVY4?=
 =?utf-8?B?eTVmaklVRHRCTWlscHY3cHlqMTRPR0VQeDdYTGgyYXRpSDFxVjhobTJPcDJB?=
 =?utf-8?B?RVVxYkg4OTV1RHZyMVk5QkZvWHRlUU9mV0RyeUZUelh6WmtyZmZQcCtjZzdQ?=
 =?utf-8?Q?d+gwsECdyNZbvDHdofVq0oUZeZGNwOEg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:32.0645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cd0e09-77e9-4c5e-4d57-08dd12955fb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

In order to let platform profile handlers manage platform profile
for their driver the core code will need a pointer to the device.

Add this to the structure and use it in the trivial driver cases.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/surface/surface_platform_profile.c | 1 +
 drivers/platform/x86/acer-wmi.c                     | 5 +++--
 drivers/platform/x86/amd/pmf/sps.c                  | 1 +
 drivers/platform/x86/asus-wmi.c                     | 1 +
 drivers/platform/x86/dell/alienware-wmi.c           | 5 +++--
 drivers/platform/x86/dell/dell-pc.c                 | 1 +
 drivers/platform/x86/hp/hp-wmi.c                    | 5 +++--
 drivers/platform/x86/ideapad-laptop.c               | 1 +
 drivers/platform/x86/inspur_platform_profile.c      | 1 +
 drivers/platform/x86/thinkpad_acpi.c                | 1 +
 include/linux/platform_profile.h                    | 1 +
 11 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 9d3e3f9458186..b73cfdd920c66 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -212,6 +212,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
 	tpd->sdev = sdev;
 
 	tpd->handler.name = "Surface Platform Profile";
+	tpd->handler.dev = &sdev->dev;
 	tpd->handler.profile_get = ssam_platform_profile_get;
 	tpd->handler.profile_set = ssam_platform_profile_set;
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 53fbc9b4d3df7..aca4a5746bee1 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1873,12 +1873,13 @@ acer_predator_v4_platform_profile_set(struct platform_profile_handler *pprof,
 	return 0;
 }
 
-static int acer_platform_profile_setup(void)
+static int acer_platform_profile_setup(struct platform_device *device)
 {
 	if (quirks->predator_v4) {
 		int err;
 
 		platform_profile_handler.name = "acer-wmi";
+		platform_profile_handler.dev = &device->dev;
 		platform_profile_handler.profile_get =
 			acer_predator_v4_platform_profile_get;
 		platform_profile_handler.profile_set =
@@ -2531,7 +2532,7 @@ static int acer_platform_probe(struct platform_device *device)
 		goto error_rfkill;
 
 	if (has_cap(ACER_CAP_PLATFORM_PROFILE)) {
-		err = acer_platform_profile_setup();
+		err = acer_platform_profile_setup(device);
 		if (err)
 			goto error_platform_profile;
 	}
diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index e2d0cc92c4396..1b94af7c0e0c4 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -406,6 +406,7 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
 	}
 
 	dev->pprof.name = "amd-pmf";
+	dev->pprof.dev = dev->dev;
 	dev->pprof.profile_get = amd_pmf_profile_get;
 	dev->pprof.profile_set = amd_pmf_profile_set;
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a08dc936276b9..14d84cad01b49 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3877,6 +3877,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
 
 	asus->platform_profile_handler.name = "asus-wmi";
+	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.profile_get = asus_wmi_platform_profile_get;
 	asus->platform_profile_handler.profile_set = asus_wmi_platform_profile_set;
 
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index f88d898447511..78aac76132788 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1108,7 +1108,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 	return wmax_thermal_control(supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(void)
+static int create_thermal_profile(struct platform_device *platform_device)
 {
 	u32 out_data;
 	u8 sys_desc[4];
@@ -1157,6 +1157,7 @@ static int create_thermal_profile(void)
 	pp_handler.profile_get = thermal_profile_get;
 	pp_handler.profile_set = thermal_profile_set;
 	pp_handler.name = "alienware-wmi";
+	pp_handler.dev = &platform_device->dev;
 
 	return platform_profile_register(&pp_handler);
 }
@@ -1225,7 +1226,7 @@ static int __init alienware_wmi_init(void)
 	}
 
 	if (quirks->thermal) {
-		ret = create_thermal_profile();
+		ret = create_thermal_profile(platform_device);
 		if (ret)
 			goto fail_prep_thermal_profile;
 	}
diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index c0dbbd3b23065..b9a6dd7b321d9 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -257,6 +257,7 @@ static int thermal_init(void)
 		goto cleanup_platform_device;
 	}
 	thermal_handler->name = "dell-pc";
+	thermal_handler->dev = &platform_device->dev;
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
 
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 26cac73caf2b9..ffb09799142bc 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1565,7 +1565,7 @@ static inline void omen_unregister_powersource_event_handler(void)
 	unregister_acpi_notifier(&platform_power_source_nb);
 }
 
-static int thermal_profile_setup(void)
+static int thermal_profile_setup(struct platform_device *device)
 {
 	int err, tp;
 
@@ -1625,6 +1625,7 @@ static int thermal_profile_setup(void)
 	}
 
 	platform_profile_handler.name = "hp-wmi";
+	platform_profile_handler.dev = &device->dev;
 	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);
 
@@ -1664,7 +1665,7 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 	if (err < 0)
 		return err;
 
-	thermal_profile_setup();
+	thermal_profile_setup(device);
 
 	return 0;
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index cbdc965eeb248..b6586c473ba91 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1103,6 +1103,7 @@ static int ideapad_dytc_profile_init(struct ideapad_private *priv)
 	mutex_init(&priv->dytc->mutex);
 
 	priv->dytc->pprof.name = "ideapad-laptop";
+	priv->dytc->pprof.dev = &priv->platform_device->dev;
 	priv->dytc->priv = priv;
 	priv->dytc->pprof.profile_get = dytc_profile_get;
 	priv->dytc->pprof.profile_set = dytc_profile_set;
diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 03da2c8cf6789..5a53949bbbf5f 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -178,6 +178,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	dev_set_drvdata(&wdev->dev, priv);
 
 	priv->handler.name = "inspur-wmi";
+	priv->handler.dev = &wdev->dev;
 	priv->handler.profile_get = inspur_platform_profile_get;
 	priv->handler.profile_set = inspur_platform_profile_set;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 0e03c41e028d4..58af9020382c1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10638,6 +10638,7 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 	dbg_printk(TPACPI_DBG_INIT,
 			"DYTC version %d: thermal mode available\n", dytc_version);
 
+	dytc_profile.dev = &tpacpi_pdev->dev;
 	/* Create platform_profile structure and register */
 	err = platform_profile_register(&dytc_profile);
 	/*
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 6fa988e417428..daec6b9bad81f 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,6 +28,7 @@ enum platform_profile_option {
 
 struct platform_profile_handler {
 	const char *name;
+	struct device *dev;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


