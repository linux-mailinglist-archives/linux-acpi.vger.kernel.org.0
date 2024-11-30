Return-Path: <linux-acpi+bounces-9807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790B9DF0C2
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11B428202A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832B1A38E1;
	Sat, 30 Nov 2024 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J7hpyV2i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43E19D89D;
	Sat, 30 Nov 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975539; cv=fail; b=cXKKxm/vJZv+vBojemkRFlvB7Gb67pEENw8NeyEkyjcE4E5srfw1u0qMgxgCraWNPq5hr6rZP1MMMCQmIlsI8gRqJNrKh6wplTlXoSe0orzlLghfU8LQIpXk0fvRWK/BdlGvKcaFk2MOUDR9MwtiO0l9w3MbR/r9c0vl7GSzyvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975539; c=relaxed/simple;
	bh=+xN18sNC5Ocgap1+ttPhDXae8uq0m/TFsmTPn/lgO0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH04s30hCERY2b+306sEhPMOQwx/+MIKejh6e6SUWzKJB9x+3w6iCoXM7aoJ0aQFQYGtQ19mHfR68AFPy3Iu6qV+JSg5YMvbRTsJQEuOZDkJ+Ez6G8sECbX7qfRE3GxLY6C3dOIpD/fPix+yVwHNoowqMvMVwt1vh9byUUkU2R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J7hpyV2i; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhJO+bHDYeaIU3CfwJgTG3q2Xb3g0tF2bVHqlUlxXz1hvmFW9c4c7vUILJ0I1Px1iHcAFY89hDPD7dKaOuqu+nGc3AmpvOE6+6rq8EktrwCfoYnK8fDL0gMN5pw/2FXLniyMOIyRbTKQ6HFhgEDDTu3Ekjtljfz1rvWHvAvcOFDes91G4a+mt02jlXOXHushVHTmLzs2E1WgHaqlHDwG4Mp5HaoeqsME63O5eMval881kOffF6A/6qGmwb+viR7JZkvN5MICiX6tiWeKoOuqwnpDGQrZSQtj+elzguPIR4N9QgbYeD+YRAKRT5Ti39r2kaBdnhPlosVp/xnPm8Ymzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+XaE8yyWjGIn19TzASAZzj0sYETWpxRAyipXeNBClA=;
 b=ViX785Eh7wEH2gg+ydGXTYT7ivMsO5bFv/qLVBXciTJ1CJux8mc75S2wPv2oesT5jiCys45Rfr9L0ybKncuHFZ+NiX8QTwPj5dMzI8zJZp0Qepuzn7qcoEy6TZ24IbsVXOQj+yvljhVP62yDEQlaYFj+R0lp/be0IfBOJdhGgCsehfj3n6BGvFh1V6gOwuE72tu8DYuJDtOYhGD981/y5rcHSTb6+TETMq/0LXC4pD0NL5wAsva+CxmxV2A8/+X4BQLxon2wfkjmQBiKWWBio0xxn7AdRtK92P5E8wl4+oMjZB3wZKLb91ljf7EyJvoJXD8khj1Tcnq8BD5jJvHXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+XaE8yyWjGIn19TzASAZzj0sYETWpxRAyipXeNBClA=;
 b=J7hpyV2it861k2eOxK+pNeM+wBVOadlS8bVSqw84Cnoi6z7V9XglxmsvJG4qpAE5LZirbS3a6ywn223I7DKruPKzQFBPplVqYxNEXEFqhxzlXksRs8KNcMjuBm0aBjO6rme0EXdyEgTBPTLcm/2ETpm67HUFx7bn19cs5G10M5c=
Received: from PH8PR05CA0009.namprd05.prod.outlook.com (2603:10b6:510:2cc::26)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:34 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::cc) by PH8PR05CA0009.outlook.office365.com
 (2603:10b6:510:2cc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.5 via Frontend Transport; Sat,
 30 Nov 2024 14:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:30 -0600
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
Subject: [PATCH v8 07/22] ACPI: platform_profile: Move matching string for new profile out of mutex
Date: Sat, 30 Nov 2024 08:04:39 -0600
Message-ID: <20241130140454.455-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: b55cd38b-4d3a-4841-3239-08dd11480eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWpwOTJ5QXRnOUNKcHhEbWFTTWMwQkZGL0lnK0w5Y1pndzJQaGF1SExQbkRJ?=
 =?utf-8?B?aWxMNVNPMUNpZWttdlR6YmdsZUd3WjE2MUNtMzdDeGRSNXVMaFFJNTdmbGRm?=
 =?utf-8?B?Y3ZoZ2pZYk8yajIzSEVnUWZWRnpiQzJCSktIYWhwWkk3U1lPYWtsMWxxbzhQ?=
 =?utf-8?B?blJ3OFpHZFcyd2pJWUo3ZDdYbnpKWHFnY3dEZE5vZmcxeTc1TXhCNE5maGVP?=
 =?utf-8?B?V1owQ0NTcFZJZHNMbUNSa0dueVk0RW5jREZWd2RQVlRIRXZ1WFhqeXBZcDJi?=
 =?utf-8?B?dWRtekJ0VUhZVmQrM1ZtWWpTUE5uRHIxVmw4cWVPZlZjdkc5TnZLcXlkM1JU?=
 =?utf-8?B?VWZsWStGV2Fzb3NoTXN0RDlaY1JnRGNhZnM1eGdOT1cvejdRcHZucjNSS2VY?=
 =?utf-8?B?c3FXWU4xd2lHcmQ4d00vSEFqTnVLdERJeWwxeVd4TGhjZ0dXWVlVVHRuME1P?=
 =?utf-8?B?ZFNJMHVFc09FelRDLzJVdWYyNkpYbzIvR3dWbTNLa3ZzaFlKTUdYZVRVVFpJ?=
 =?utf-8?B?UkxXYzRyZXBkektTUzBDN3ZiSjNVRGlubHRUcG13bkdqL0pueHQ5N2xIL0ZR?=
 =?utf-8?B?bUJHd1IyR1F4NSs4cEJGME43dXFpZlJveTRHanNqcXdZZnJQWXJWSXYzYW0r?=
 =?utf-8?B?bHhIYzdUc25NSGNlT1ZSbXJQYWVGcS94M0pRcXR2WElSM21HVXVVd283ZGtM?=
 =?utf-8?B?WDRPVzRVRVZsMnIydHJKOTB6bU5PM28vaWxJMjQ5UExlS0xrUDZFVEtlVXpY?=
 =?utf-8?B?YkZqWE1nMkdmck9LVHlUQnZ5YVFPMnB1Z2xMTklUYUdvL2JjVkdBVWprOXpJ?=
 =?utf-8?B?TTZHUjZ4U1B1MXFrWDVtMFhmekR5bHlvUmhWMUwzcW9FNDlXT2xuNzVCcFQ3?=
 =?utf-8?B?UDNnaTloTDhJRlVJVmR2R0VPc1I0YVRjSnRRNHNWQUU0czU2TFZNblY3YkRM?=
 =?utf-8?B?ZE1CSTU2Z05UdHMzVGZFZXgvVDEwWHV2bitCK0VEaFR3aWJKZUhROEU5QkxM?=
 =?utf-8?B?OUt2WTJML3FydmdOcGtmWU1yTGJ3eXB1eDRtTU1JNW1kSXVUYkRGdGdjZ2Qx?=
 =?utf-8?B?OVlLYUZOeUk5cmJpUW5uR2YzaklUSm5aclpQZWFVQTJ1UkNRQTZDT3Q3dTR4?=
 =?utf-8?B?M2laWSs2QnF1ZHdsbC8wWUdYNmROYkd5K1NYQSs2c2k1Y3puckl1d3FYQ0lt?=
 =?utf-8?B?MlhGV2tBelBib3RxeFo0NTMvS21nMzRkaWkwbFNxSmxkZ1oxais0NzFlZnB6?=
 =?utf-8?B?SmhTeVlUM2JFRHRid0tnVnp0QXl1MU5xV1VuV0tvTklrVkJzZVJjbEZ1U0dk?=
 =?utf-8?B?V1ZIeklFV01HMVFZWUUzbkVXeERTNkJQdXBmVWxVUkdtanlxQ3dWOXZ0NTVy?=
 =?utf-8?B?UGFNaGgzS0tOWTJ0b0dVRURvMVlnWkh1L21naXN5NnVDUy9kZFBjRUp3cFZO?=
 =?utf-8?B?OUhZYmJ3ZUdYS0gzV1NqYjZwSnVHMGRDVjRTWGk2Z3R3a1RYZ2xmSWtaalZz?=
 =?utf-8?B?dU9BRDlOVkFhRlVucHJUR0R2WGc1blNFKzlIUHd2N3IvUnhVL3o2aEliTHE4?=
 =?utf-8?B?NVFCVG41WmJuSTM1Q1lWa1E2T09xdlBXbXpKeTM0QmNSaWcxNFNEZ3ZqTCs5?=
 =?utf-8?B?U1A4WVg4VlA2RGdnMEtPMkdCd1NRSnRYWVZCSDE0dFd5NHBvOCtPM3hRTlg0?=
 =?utf-8?B?UlRCZStlM0FVWWxWZnhyUGVzdXZQd1B3Vm9lM2RYVVh1K1MzR0NTS0VwNnlt?=
 =?utf-8?B?dzVJRWZCOStmTEV0eFNBWFRWcHh1Q1E4Z2VDQ2VrUVhHMjhtUkhZeVNhUFpn?=
 =?utf-8?B?cEdUY3Ryc0ZUWEVJWnVZc0dCU1BOTWtTTnREVmMrOVdvbE5Ka2pjRWJiT0dw?=
 =?utf-8?B?dWxNWHhXRHNLN1AzdzdReHl0WVQ3NG84dG9lbU5Tc29CRWRXZnpLWUNyYjZ3?=
 =?utf-8?Q?Pmv+/jWhSDkGrNXRqDQy0ZCtQe6H0UZ+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:33.9257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b55cd38b-4d3a-4841-3239-08dd11480eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

Holding the mutex is not necessary while scanning the string passed into
platform_profile_store().

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4f5623fc27c09..45ffd85a71dd5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -83,6 +83,11 @@ static ssize_t platform_profile_store(struct device *dev,
 {
 	int err, i;
 
+	/* Scan for a matching profile */
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0)
+		return -EINVAL;
+
 	err = mutex_lock_interruptible(&profile_lock);
 	if (err)
 		return err;
@@ -92,13 +97,6 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -ENODEV;
 	}
 
-	/* Scan for a matching profile */
-	i = sysfs_match_string(profile_names, buf);
-	if (i < 0) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	/* Check that platform supports this profile choice */
 	if (!test_bit(i, cur_profile->choices)) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


