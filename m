Return-Path: <linux-acpi+bounces-9991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0FE9E64D6
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7221884431
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD718FDD8;
	Fri,  6 Dec 2024 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2WIWsEZx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFD1E522;
	Fri,  6 Dec 2024 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455514; cv=fail; b=turZ3sy+CSLGWnH3IN418scUIlIWhsFSWqFIiCD5tQBTa8I4oGGPyUYUSK1F6UHUbRFqmNAG+b72POHL4e1iok2Padyx7914mWphHLA1PFupbsH64UiBZRVANTcjlKshI7n06i23MKm0cK1U/Nr6D/VthqXER38S0suwKZJ7/v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455514; c=relaxed/simple;
	bh=z0GlcC9vwRUmxS0LWl2nrqiX/2qAQj38IxksQe1F4C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWMjT89jwlHovqqsaVJDm2FMjpKYzBVxqLK0a1aXEp2OtnPHaf2abOyvCIVL4+hPA+j7c/DdUIn0WlSL7SKgYNqh5qESLkKVnNsGmdIU/3+U5kworEUFSOaVk15OZJD7+othlQR2ghYmyZ6WW7LHIPuEJIuocKdu4hg4NgNguYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2WIWsEZx; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMq+ZnwbAxIjKpmYKdr6lXT81kj6kYozPl7OsQVrCMD0YeeKAEbUXaJ7fgTWG8TKPRM+OFPuGNoWnT6agl6Hi1l0NEQCq7CUz/6odPvTFFnYaXaXn+o1QY1Xg0oCsUBaf3cG1ES8xRydpzdA9HEEIPpWGVwVaGcwPvgg+0RZrpzsvgADf6Tz1B9B6PG7B1TUtpTz5ZtYRxpiNWL7YgQO/67XwYuKGRosZ4zzorpTOyDDtymTkju4mq3k6H6Rzq/Rh7hypCn5eo4YN6v+10BaB2VCqj/L//p+UDeou28L4n1k2VzFM4okDDXYx+Sc9l131dftLATfRPrBoY5wH9H1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fbrw9w+y1t+fOwFGCAec/Yj7kmTgUhQgGzFW3WCgW90=;
 b=SyLE9ZVR6qpUfjLHCd2mnojoub7DeNQ+1/wXZQdZo4oj1y5ItvB4agocZtT1QodBeRWdACf2JuphNIYTB66NC3Tf8uVjYE3eLYQ1FiS3khcgU5DWroXUJ1PTs7Gw7ec/S+dKaY6yWJJ6zf61JfIzitIhyI/KYdl4JMqg2N/e/PIK/8VVG+e2oom+KmRxpTlKQVSyas3dTnfuOW4BU7id3avkw2ssaC0MgTza0gcGlzFqxNzxjJVAk4p0g5bvkj1+PCVmSzJdv05fxkv0kTFpqL08XGMjtrL7UDaCR+KPSQl0zEMioKtOyFZlxauzWogCYedwRN8ILN+FhJrEI3y6Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fbrw9w+y1t+fOwFGCAec/Yj7kmTgUhQgGzFW3WCgW90=;
 b=2WIWsEZxt11oib+fn8dYtI9212X+ShIShRBqtCCZLE8zQPLR1WjUMG5TDNWLDf5ziunnSEoVseZk/newr6g6Zu+EWJDziuVhd1/FoZTa3HK9zzth3B4GUtTM9jRd8807PBn97Dd/lONvJXv4aDCcSdotRYBlc0yiRIT8VRrimkU=
Received: from BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30) by
 SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Fri, 6 Dec 2024 03:25:09 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::b) by BYAPR01CA0053.outlook.office365.com
 (2603:10b6:a03:94::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Fri,
 6 Dec 2024 03:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:08 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:22:53 -0600
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
Subject: [PATCH v10 06/22] ACPI: platform_profile: Move sanity check out of the mutex
Date: Thu, 5 Dec 2024 21:19:02 -0600
Message-ID: <20241206031918.1537-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae44da0-8b22-4d10-10ce-08dd15a5961c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU5wc2lvb1l0Y0FZcW1FRW5qWDl5STljS2F5WldXeU9PZVBvaDhCNzN6TDg0?=
 =?utf-8?B?bVBEWnFKRFd3aXBBVFg0cm1Hdm1Tcm05OFdwTjArS0lrWHpWbjBIV0htaW1E?=
 =?utf-8?B?TFgzWVdmb1U4SGdVc1ZOSlhLYmxWaXNMa3p3bnh5bm1lNHdGSFM3cnk5UUtT?=
 =?utf-8?B?bTBTMm5ZSUUycjg2bjVvT0luWDVHMDFMSmdoRjc1TGxDK21IbzkzdmlmVjRE?=
 =?utf-8?B?V3lnZmJiWkE1amVQeW44RGFUR2NVc2F3b1FCaEdpMFZwUVc0UkVVL3JUTzBq?=
 =?utf-8?B?ZGhZaFd1NjFCbTREWkcraGNsOTR3N3ZQcjE2K2FvSUh4ZTYyaWg3VjEwSzdh?=
 =?utf-8?B?S0hSUFVyRzNack1KQ1NaY3FydzJwSVl3Z09MQlF1ZzF0RGdTc2Y0eFVWTmVu?=
 =?utf-8?B?ekFaSGU0NmVCbmluK2FueFFrZ2lmb0RkT2NWYUlYRFphUG4yN2ZqYzFzVVd4?=
 =?utf-8?B?VXI5bjdER2pRdlN6dmVoeFh3aGthWmpEaUxHUUpyVXplWW5YNFIrMGZZSVFB?=
 =?utf-8?B?bnF5b3FuV3BPTkFEVlhXcGNBdGFueHI1NnZOTVZyZnphb3EySjdubVZFS1Bm?=
 =?utf-8?B?ZEJKdlRJZjh0cThKUkZZazdWQmpvRU55U251N1BNeFFtM2IzSDBFRHQvZnZr?=
 =?utf-8?B?aVArRkNXYThOa1MxNEY2eTh6SGdxd1JScVpZR29IVndweGhpZ2p2ZW1QcG9i?=
 =?utf-8?B?eDVFR090L0ZobkRQakYzOGRmNXh1ejBmTnFtUmY2RzJVV1RYcWU4SHRLdVVU?=
 =?utf-8?B?ZEdSRTUyQmlRVWxyU1FldUNjSUgxUTJOK3hKaFFuc0FYMWN3KyszTzZFUUQw?=
 =?utf-8?B?SUk3Zmw1VUhVd28veDNRTE5OUUY2YnFvZDk3MTlwOTFtNkg2SVNWVmJkbDl3?=
 =?utf-8?B?YkVEdGlVQ1dEZlk2T0d0bnEvdGRObmlOYUwwK1JmZ1Q0dDlQNmZKTk9Ta0dS?=
 =?utf-8?B?NVJpMUhhd2FWK3JUeUdBNzc3bHMyVFUwVHhSdjFwclpONTFxb01UREEzeDVM?=
 =?utf-8?B?U09lWEZ0ZnJpdGZWQTNBcVpzMFVwZTZQTFIrK3pQS0xqLzJSUWU4bElCQUo2?=
 =?utf-8?B?UkNRRTU3R0FFUW96RlFpOHowOHFLT0xEMElyUGdITWMwM2IrM0NXREs0TFdj?=
 =?utf-8?B?a0pNS0x6SHcrTHZrZXNSbDJqOFFFaWhqbkxrMEw1Q0VsWWlzUlorQTY0b3Zn?=
 =?utf-8?B?dnBibFBBY0M1b3Q4cUNBRmh3L0kyZG1HVWpWbm9PbGZPa3RwVkR5VzE3SE9k?=
 =?utf-8?B?TUVhTDdoT3c3VllYSjJlMHRlcmZweTVzcno3c2xtZmd2enU3dmZaQU0wTlAy?=
 =?utf-8?B?UTl6dnhVQ2p3cEVYTHBadWRMcVArc2VFQ04rRnBoTkp6VndSUkoydXJLVkgy?=
 =?utf-8?B?VmZ4TTRQZ2VSandBbzc1bXRYTVY2TVh2Rmp2OUJEMTZiY3lXRldvNVIzUzdI?=
 =?utf-8?B?ZW9VcjI5ZjY1MldvN2ZJU1FCcHEzL3EvVXROVmMyUGVmYjdEQkIrQmR5Q3lZ?=
 =?utf-8?B?aVRQTUJ5WnJRVVFSNkhzMUcwTEI3ZThxMFJqazVjN0FtbGFCQmY2T2hxYnFO?=
 =?utf-8?B?S2txUVVnMzhRUjZqZXBlbVRvRmgxdjVSb21qVTgrV216MytYZC96SFIxMjlB?=
 =?utf-8?B?eFF0bHdtNnhMSHVDY1hUeEppMHZSZXRSNnpaNVlrUWtvZS9JK1pBRllhUnhs?=
 =?utf-8?B?TS9vZmJNS2pVL2cxcGVLY05NejR6Z0RNNUJ4bjNScjNvZmxXY3BXNzJ5UTBi?=
 =?utf-8?B?TXJIVU5DbWRmdDJBaldFelIvSWdDM1V5Y09NMWp2MWJleW5lblduTFBJdmxm?=
 =?utf-8?B?eldadExIaE1NeWlYRFQvWTBmbDVqVjAxZDVGdEVYcjc0VWIwYlViT25WdzZB?=
 =?utf-8?B?NE94OC9nN3pkbEJYT0dkLzVXWmliUHZ6WUFGc2R5WDd6Z3BHYm0rWVFKRlhh?=
 =?utf-8?Q?1UJvY8dOR3c02jXh4G9HqESXRuvO65K4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:08.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae44da0-8b22-4d10-10ce-08dd15a5961c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160

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


