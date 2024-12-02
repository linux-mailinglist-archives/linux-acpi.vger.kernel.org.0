Return-Path: <linux-acpi+bounces-9851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C29DFA56
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B5B21F66
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9AB1F9A8B;
	Mon,  2 Dec 2024 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cacak7Pu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735F1F9423;
	Mon,  2 Dec 2024 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118703; cv=fail; b=D9yx6XA57im6fJatO9SiqAqK4gXI0nljMri2Ex8pnDmd3AuZlgmsU8KCl/BZxG8ilOASSpbh/XcEEMo1uawBFF92d9yQSiPh82QyE+nwUB8SQYu3xkFarjaFNxqEoPGZikAbqWxdbhM+jahPByOwx2AxjjkVWASQRBFB0j1gMQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118703; c=relaxed/simple;
	bh=z0GlcC9vwRUmxS0LWl2nrqiX/2qAQj38IxksQe1F4C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LX1cQdxzVN6uotNOQn7jjTV5ZhPEoQzISM4y+dzO15rdzIhnydWVXUoz+TS2aF/qhkMTphVO8MMP34kUk/xlu4ptjgvmHSVBwogrFSRnv8zJn1Xz5M3yBdtDmuzV+vWOkmYmZP4EaFgpHnkbXy3+1BHLQsfkyyr2q9JNvvJL5rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cacak7Pu; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6n8Zh+5FZFiAipwpcGfg2WF15n7rJWJjcZ9raBbB9rddYcfMSf81epGSx8lTL+JzM0YXPe2CberYM0I77KflNIeKnxwE5/JtKJACs9ffQVWLfq/Y7bl7nnm7yrA3h74nL2/+okXJDGhmnmYbeGD3MQuoRR3FHiyMwG+Jm461oqSE+mDpEC32cTHFWsPj9v59GtP1HrykphD8A3FY8YtM4bqbPaoimUASCjT0HX0fOMi676h+aOfVXAB/CSPbwP1huSIDn7dZ8VoGh49SabhEFr25b4+EcnMpe7qyF2tnS4tJ72rkFx3Zty1iwFso3JInZDd0fyRZJtLf1Um6SdiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbrw9w+y1t+fOwFGCAec/Yj7kmTgUhQgGzFW3WCgW90=;
 b=ZVvYqXN/nvdvSGEDkfTJRviEEL1RUwxkdqeZ9A/kgzBqUGYiqBG1SlrL/oph1n3IRYRBh7nLINKglY8BMgKTmnYSndXZyUg5CJ22NERupSjLWhEjGRW4cvuo2N5amnIvd6gijpRKQ0YFFzxjMpBoeyO3dQ+yRPrOT2CTBMYBhIdA25sWSbPaQsuiovP5V8S3yxB91o+e+cfQQQKwKNWZhQFFS/Gs0WYAsBqCOpkeoj1FpbMRZo5/nXX65+Nx93OfqLqQrY5UxMgZ2tdr6Kdz0X5M9kdnnnT0adBVvxuTSkaAu1STsNODwPBlHzLKmOuthtzPLieCXpiLupcspJMEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbrw9w+y1t+fOwFGCAec/Yj7kmTgUhQgGzFW3WCgW90=;
 b=Cacak7Puvxq0zPdNUFrIrukzqoCHOQ6HTfAKyeWVgnJ5HpHIFGsect1PA36Kevu87Tr2xKoBrqMYhL2zHmRErzlBrwCZ4xcG1hVhOz8SrVvB2KrUmjzAF3UUxQzDnYU0ndFMxfZASU/uFI9waZ2HbCew5LlGkfToN5OsHOjDQIM=
Received: from CH2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:610:5a::21)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:51:37 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::3b) by CH2PR08CA0011.outlook.office365.com
 (2603:10b6:610:5a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:35 -0600
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
Subject: [PATCH v9 06/22] ACPI: platform_profile: Move sanity check out of the mutex
Date: Sun, 1 Dec 2024 23:50:15 -0600
Message-ID: <20241202055031.8038-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2daeb5-5d57-469c-74df-08dd129562b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2Iwd2FVQnhDd0ZSRXJsbkdTWHFSV1M3eHc4b294ajVKS1dkckxQTmowWXIv?=
 =?utf-8?B?RU5SUXl6dzM5ZkJTYUkxencybzJ2dHhBY2hORlprYjR0QW9HQWJMWDJHa2tQ?=
 =?utf-8?B?TXBSWE9YcGFjZnVUNjNpL3lha0s2RnlXWnJ4TjJzNFlvUXdINTFtcE1idXhR?=
 =?utf-8?B?T3B6alJqQlVLMmxaVUtCT1dVcStQZW1GQ09FK1pEVGQ5YTg3OWtNMzNrY1lM?=
 =?utf-8?B?dHl6WlZUSExhaW9ObzY2WlNXMkcyUnpvZjU0QldIa3c3TGpoRlA2S1BEcUdE?=
 =?utf-8?B?dGN4K2pLY1VJMXhGNFNCcUd3ZDFzeFB2QXBZZGowR2JSRFBVbUJ5Rys1REFo?=
 =?utf-8?B?bzVCamZrNDRmMWJES1NKbkNRdHIxeE5WcGZPeWxzWklqYVJNZlpIbXZ0T2F1?=
 =?utf-8?B?K0xBdUxmYVZBUkZNdmFPdlRkY0lZdmNZZXZVVW5SYkJ1Vm9Hb21kcEMwaFZn?=
 =?utf-8?B?WWdidldiSmkzdWR4OHBqS3YzcWl3WkloZUtYTDZPWE1mZEdNWkFUYkM0UXo4?=
 =?utf-8?B?TXRuVUh1UTkySG5EOWRzdTFuSi9MamEvSUdYZVVCTDFjc3ZicVVmWUxRSk1i?=
 =?utf-8?B?VUlhMWp5UkNMcTl3dVBJd0J3ZW93Z2NxMlVRR0JWdFBMbVB2eU5NMURLMkEr?=
 =?utf-8?B?c2ZVeElNTkFrRmtsL28vNE1pbW1NOHMzR056cDNVck9TSHk4Vkk0Wk1zMUov?=
 =?utf-8?B?REcveXhrd3FkZlFvc2VCc3hNWHd2NE10SXhoUDQ3MDBNT0hIclg2U2s2MTVJ?=
 =?utf-8?B?bHBUQXZBQ0VtRUN0NmVDTFpNSTNjWHVpNHp5NnE5RDMrNEJneGxRQTYzckJy?=
 =?utf-8?B?SjRwT1NxT3U5djZDNDlBTkEzNHhoWU5ZaVVpbnBBRVpkZTN5NXFuN21hMnNj?=
 =?utf-8?B?cnRCVGJlY2UxSXZDc0Y0ay9DTkpMTE1neG4wUEk4TUpLREF0bVpybjRBTDhM?=
 =?utf-8?B?QjQ3emdBRkdaQWZ0TVlyMkRsV1FLbGw0anJGN1dpUGFCYmpQOGVEWHpmTUdt?=
 =?utf-8?B?MDcwaVFHdkRoNUsvRytlcGpRWWo5cGsvbVRReW9MakZ6c3l6RGsxZXF4eThp?=
 =?utf-8?B?alV5RklJaGlWTUdQcGFUc2tEZnN2eU90YnNCMlBERXIxS2Iyc2dXVHg3c1Rr?=
 =?utf-8?B?VmExTlUxL0pMaFAxWXRFSUloZ3piRlV2Zkw4RDB5N2NEOFhQMzF1NWpSTUxU?=
 =?utf-8?B?ZXMvNVNSYitySEFEY0NtUyt6Rmh0aG1YMnQ3VkxFTDhtRmd4V1d3U0hsL0h4?=
 =?utf-8?B?OTBoaWhIa2pZRHJnS09QVWR1R0lZdzEvR2xDRHNXa3luNGV1TCsrZWlYZU55?=
 =?utf-8?B?VDhOR1JhNDYxOEJTVE9zTFhqalRjUE1zNW9ycEN5UXhVS2Q2UzR4d3pmUUlN?=
 =?utf-8?B?Zmt3QmxGV0ZvZVFhVmFnYlNISVpyUDF6VzNGT1Bva2Jwanl2MUdaV2JCZ3JT?=
 =?utf-8?B?SVc4b3h3ZDdiTmwwclA2emRRcmlkVUttek5scEMvZkYwZlZBM1JlcVlNWVZS?=
 =?utf-8?B?L3lkSk13bHBmeFZ3WkpDZXZ4azJBUzhveDk5c09Hc3RvN2xma044dUFMMHph?=
 =?utf-8?B?NVNRR3ZONEQ0SnlERitrWlR1RVRpU1IrcjRkSDVockZNeU5uTkVMOCtXQnVw?=
 =?utf-8?B?eWRsWGxpcEMrSHdJcGRwVnp2TEhCR1pzSkovd000YjVOcFh3R1BWbmQyeTlB?=
 =?utf-8?B?TUZmTDYxN3NwaE0rdW16eDNyRkVDT0k0L2pRN0F3Q2lrOXVLY0hZeEU5Nmsv?=
 =?utf-8?B?ZTgrLzhXMmJKTXRwNnBLRFZQcU8xWnNKR0tzRTFHR25WdEdoWVVRYWJLcW0r?=
 =?utf-8?B?clRla1lFOFB1cmQvRE9jUFVmZWxpNVBUYks3ZjNVdmJubFY1UC9RNHlhYVRM?=
 =?utf-8?B?S1pjMWtpZCs3TXViempsSkFIY05rVDUvakxIMTZlZVFPZm5hRWw2SGRHaHpQ?=
 =?utf-8?Q?EYAPy5OoCFFFE1D/fhBuDDHQnvsH4Q6z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:37.0986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2daeb5-5d57-469c-74df-08dd129562b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546

The sanity check that the platform handler had choices set doesn't
need the mutex taken.  Move it to earlier in the registration.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 927a2f7456c9a..4f5623fc27c09 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -179,6 +179,13 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
+	/* Sanity check the profile handler */
+	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
+	    !pprof->profile_set || !pprof->profile_get) {
+		pr_err("platform_profile: handler is invalid\n");
+		return -EINVAL;
+	}
+
 	mutex_lock(&profile_lock);
 	/* We can only have one active profile */
 	if (cur_profile) {
@@ -186,13 +193,6 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EEXIST;
 	}
 
-	/* Sanity check the profile handler field are set */
-	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
-		!pprof->profile_set || !pprof->profile_get) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
 	if (err) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


