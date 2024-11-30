Return-Path: <linux-acpi+bounces-9806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C002E9DF0C1
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA291161D2C
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DFF1A254E;
	Sat, 30 Nov 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LCvtUZf/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4881A08AF;
	Sat, 30 Nov 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975538; cv=fail; b=al16TJ2/UKxESHRC4I3ZwuFiRa6wk2KKDUtOyC/wZgVLX06YeTl3hyjU8IEoMDdZPdjZp9vvOKUUDmnhMHVUliIjOTxOHkSa5mjmjEpcSfrDYk5pf+4h4QQgjHgsPxgQMeCgvlX4Er1Li7vqwy6lL+jY+pGb7zxot3tFMEkj41Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975538; c=relaxed/simple;
	bh=z0GlcC9vwRUmxS0LWl2nrqiX/2qAQj38IxksQe1F4C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQxHo14ignqSysoopP6Q+OqBwpOMLPkMLPOwEt0zpmIqSPKlxUL53gBKWZslTqr3Fbuu7C6KNdWASKgXW7Rx/iFb4wyxaUE0LL6FsiJAv3eWAE8Fepdxn56TDaWLYk0Z5DSOiYbyBheusUaKom6/7yMkeLzYRiU5iad6GgY4aLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LCvtUZf/; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J89VvtvmILQx6VHBAj35XWQmxyE24I86d4jJ9RQvSsq+smBiZcWDr7bZI+TZTNFMCTrjOpYlZFjy2FESFGES5TguuBfBhHWY5FxR5UhkoRI6UEMEck/Ps+7Xiz/hd9/eo1GKw5pSdqUP1i0eqAs8tI2NZnh62SOQYjLcnCIdpXvktUU9rGs9wNAr2TbqKJLhREgQWZRH5YftIyVZWciK8sOosLE90uLcPnC1Eqnn4zcEEBu6LfzLyXBPzYRB7odtdeSAYPNpnMS19p/XmWaC/91A/94n8py4rGpZdGr7uxYiHKHsuMGxO5VOEOwwKBVo9Elez6GlWj0p9Yg/aoi+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbrw9w+y1t+fOwFGCAec/Yj7kmTgUhQgGzFW3WCgW90=;
 b=vJgGfRz/6pI+DqoqDvNz8bIU/zOni2CDHJWkgBIACl89mo4DaLruI86gdz66AnsMmJNuYEx8JkpfZonzK0TfD/ScTlCkr0oJOScswpGR/3IN3kLXk8AVmRrENIP7TS6PPpf6TOLyzOieisFFa5B0D1YRF9kLOaJSEsDf3gv7jGjuR8UcfEtPZPSCWsEc4hfzhzl3tks2Pc9L2ZdjN7xg6Bl1cGsajO1e3dowGPF61JS0VkH0OegqkNAP9HfkvDUmYevo9f95CG3MUazZfkPPjpQV96vqvHuQ0yaLAzuA14scnejvYzZyqejkT41goieFMzr17v7OXIg/W8pXpgfeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbrw9w+y1t+fOwFGCAec/Yj7kmTgUhQgGzFW3WCgW90=;
 b=LCvtUZf/HQtUj74QhTzqy2wHuEevh3+rVWEtQnjBKobWgi1Qyn37HUb89IU6lqI/K+C4lWxkS/0ZEjBqT6rRdchEYPlm2uhrS7uA/UvMZnylCfk8LJF9zKAkju0R80CBA0z/PVSu46F4MNz0RuzNcwbsvaElNI1AXU/Zs3CMMxQ=
Received: from PH8PR05CA0006.namprd05.prod.outlook.com (2603:10b6:510:2cc::6)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 14:05:33 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::ad) by PH8PR05CA0006.outlook.office365.com
 (2603:10b6:510:2cc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.5 via Frontend Transport; Sat,
 30 Nov 2024 14:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:32 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:28 -0600
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
Subject: [PATCH v8 06/22] ACPI: platform_profile: Move sanity check out of the mutex
Date: Sat, 30 Nov 2024 08:04:38 -0600
Message-ID: <20241130140454.455-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140454.455-1-mario.limonciello@amd.com>
References: <20241130140454.455-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d2d5b8-35e6-43d7-3db3-08dd11480de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFl5alBCM1F3M2ZOanRqeHBNTDlHZDNCRStOZ210em5aVlNSeStLd21IUEMy?=
 =?utf-8?B?VFhlREZjeGdRZkVaMW9VclNDbHdGak10YXljVUhXWjRxZjRDdDQ0Q2JQQldr?=
 =?utf-8?B?T25ON1RWVm1ZbkdGdnZyQ3VYUmQyZ1NKSFVPWEI1VGhQak04aW85dVB0VWVp?=
 =?utf-8?B?OWV0alhFSUJZLzBCMmhiUVlSOHlLb0cwS0J0cEM1OWVGWXRHUlYxOWRLcmpW?=
 =?utf-8?B?TURwZGd6MDJaTjBIWFBsblcra3pKd2dQbjhyeVdWRGkvVG5XL1owMW50WURp?=
 =?utf-8?B?YWhQaU5DWS9jZEJnMVN1ckg0bTlacUoyZXV4bUhkZnJsek5wSnhubHhJQnph?=
 =?utf-8?B?OSsrc2xocHhuWmE4QnR5OHdHSnpQblBBVFhzYXllMVRTd1VCaHIxaGRKc3hV?=
 =?utf-8?B?ZE94MDFzTnhPWGsxay80T2p6Y1ZaTXk3SzcxOW5VSmZSL2Y2MHRVaHFzOVBr?=
 =?utf-8?B?U0cwWDJyWkd3NmxnZWRUbDdYczlHVUd5TmtqZzYyYlVidjhuTUdEeDRaY25U?=
 =?utf-8?B?bG5IcHdHTCtXZmIzdXgyZ29WV1pPK0VCOG4wUGFHcVQ5R3FYSVI0UjQ1YjRN?=
 =?utf-8?B?TmFJM0o5U1I0MVpXQktmS0pIQXNTNVpoNjhzdnFpSGxzQVYzZzR4czBEcXIv?=
 =?utf-8?B?U1hqbHlONGRTNURqYVU1alh5d2R6eDVGZTZoSlp3TzRrNkJreFoxRk1yVzln?=
 =?utf-8?B?WVoyU055a2wyWndTTHJJRGNDeHd3REVQWWR2S0huSE5XVFc1QkJDaHRSdWo2?=
 =?utf-8?B?V05FbW80MFVJRkRCT0JqTzcwVWVPeFBSKzRwU204WUhwbFhNQitxVzZPczUr?=
 =?utf-8?B?bnNjeEdlQVFpbUZzVGJFamE4UitGTUY3REQ2Y09La3JTZW50VlBYNFhTZUkw?=
 =?utf-8?B?dmRxekcvOWw4TUl0bDVGT1lBQlBNcytyZXVlUmFRcWIwQVpDQjZDLzhVdUUy?=
 =?utf-8?B?MkpMTVU0VithVkR4Nldpb3laZ0VuNHZpV3JvK2lZME5hZHdNYUZpeDFRK0hh?=
 =?utf-8?B?M3NXWXNQOS9rZzI5ZFQvc3RTRUhrZkJzdnM1dUlTYWN2ZGRoVjZVWklWeWlR?=
 =?utf-8?B?TDVnVjNJV3A5MXBCNWxPY1N4ajhTM0k1SXVyN3dkT1h1Z3I1d1NvcGREM0F3?=
 =?utf-8?B?a0pCMS9PcTkwWm9BY0QreXJqVDlkdklTK3ZIcG5Zb0h3NkhvczNhT21KaVN4?=
 =?utf-8?B?eWtqczhhcTk1S1NTSFluMDNnZU5BV05Yb3oxaytncGV5RHpBUkcxUE95amNE?=
 =?utf-8?B?NGZBOUxSZjZid1c0ZnVKZ2J6Y2l6Zm8vRVlqSDhxMHYwTjVKc0kzVmhyMitK?=
 =?utf-8?B?cVQzbHRaVnEyWjZpamRqT1RXVXVNeW1TYVVoSVVRbzZqKzhHbTRObXRMbDZu?=
 =?utf-8?B?a2ZHNEcwVzVJdFo3Y2JOZ1czRnk4R0RlSDIrem9rbzZQcFRvdWRCTkJ3MU9v?=
 =?utf-8?B?bFZ2YUVWay9IQXJEbFk0b25SZGpaTTh6UVZRRXFJVzgxdGJPbkZ2UU1aTHRr?=
 =?utf-8?B?VU1xQUR4eE0yQzhBMGVCdXNNVi9rcy9SeHU3SFdPVkppRjZiQ0NXZVFUbGov?=
 =?utf-8?B?Z2M3MWYvd3FHeExZUzNjTlRxYzJzWWZkYVFVV2RYNDJKSVFETFRCTFVKKzZ0?=
 =?utf-8?B?VE0xS3VVQVI0c1RYWTEralAyYmM3cmJHWHdRU2dBOTZHYzU4WGE4ZVlGeWs2?=
 =?utf-8?B?K05qdVo2aGoxckY3SzdNTE92cDB1RTBkZEhaM0ppUGE2RmtPbEJwZWxNTzdl?=
 =?utf-8?B?bXVNYzFmcldpR3p5MzBLN0tLNGZzTU9YUkNrNFFlUFRxSlpHVEgzMk9tT0lz?=
 =?utf-8?B?bkI0dU1heTNHU0E2bXdDdnlkTGp2K29wcVJ0Y05sc1RzaDY1TW5SVm5peVBP?=
 =?utf-8?B?WU9pVk9scG5QYlVXNHJPWmFpc21qSzdCV3I3a2hwM2RZSFRVN2lmNWdXcUw5?=
 =?utf-8?Q?EzSajGsU+rbwye3jaRVxGg7uej+1fQaV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:32.3007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d2d5b8-35e6-43d7-3db3-08dd11480de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

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


