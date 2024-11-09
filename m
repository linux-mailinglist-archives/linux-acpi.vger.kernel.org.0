Return-Path: <linux-acpi+bounces-9466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA59C29F1
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1751F22DF2
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B4E149C51;
	Sat,  9 Nov 2024 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qdq5PoEm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B571487E1;
	Sat,  9 Nov 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127356; cv=fail; b=V5uh9XLeBTLx+Bi9kbLyk7r9qmN4X5TNYxqDsI7OPYsbw0eremWtGI7dqEYxIchsYhUmyMj1W5f6vZGU/MJ2OQyxOpN3rRMT9F1kQOGB25bvBLztJWq/n5ORafn9ncY3OC1nd8i3fHJlTINg489yvY7+4icD5Ky39Upwd64vB8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127356; c=relaxed/simple;
	bh=JewyXTxhFRqy6h34+YKrMpsgMeLgKwlZqckAx0I+7ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dy1CfJODhPJwhFlJxGTJqvqgeANYw/fBlw/+2HPWQF5ZaAunY8If4HU+qs1dJ77NI0xWhy78bjn5gj91ckfEae22NuVLMWGYVKx1oIrsr9lKeO7cto3O4Tl6q9mvTH/BCcvvlnG4a7ujORHncPvxV4unhfziWLReSOx0c4NWvog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qdq5PoEm; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joHCKdAm+rc0b3ZqH0NmCcJzLjY7qj6FwsSv40nh7fWQFdDOCQ4Z9uYuWAU31MVnf00YFfT4JQjiGy+s1ZjcyIpCLcvCgvVU/iVxy0oIH8xWPiu00zsOvsd0Vqat5YepsTS1FrkIxAxUxt6o+l9mZgy/QvBQv+hGqDRzSlcgOJyykrTl7+mwyEJJJ5hmiBMRPX1cL7hjYIGKTSC6k14pX6U8Swz7xP8FGZt5CfqTv2iq3vhLSc6BR0JMvHYuGDQePpofmy+g7d3Jk61cEz3/ykFAc4BS/JUxKOfwXbqCMYSOvc/+SYQMwMBDh9ftKRhnQpWI010VtCNAARs495srfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=eEdXocRJzCkfZzbYd5cds0RbuNsEfxPo0P8GkyrjhbG0FjpjonvjSOxaKGVx3171mZrJKtWaHwh2F9qOBdpZn3jtqkVAbg0xzbTE7wGqqkamnsklB5RZXa61HiHrPr0AuWyWukCTCPReeDI6M8CNhOIJaAflAHUYRkoKpToZpWquU1lhufVt4/Qxzao9CHQZDjIPl/XAHAcSwBMyrztc1w7wrY844f0qnYtrytjstjSPqQ30tZrTCxbUc/xHd8wsBvCmg2Nc1fLuX/iMsM8UwNRmsf0nPGBXxE/MHwCOeliedAcyXVKKJgWPzywYfVJrlIZVv5Vn0z6tpMDiVe6USw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=Qdq5PoEm0w6daE4ETcqy10NjkZvP13NVPYw7d3BBYIeMUsy7H64c8r/scNO7ZLbAuHFgqAyTT1sMuPY4aMnDJclbkFWWoiPobOzCXZMO6XTA+H/kr6BTesofM5WiESvWFxbjx4Z8bbqgm5zk6KYzsOiG2/HEaCAwob51RrmC9P8=
Received: from SN6PR05CA0027.namprd05.prod.outlook.com (2603:10b6:805:de::40)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Sat, 9 Nov
 2024 04:42:31 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::fe) by SN6PR05CA0027.outlook.office365.com
 (2603:10b6:805:de::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:28 -0600
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
Subject: [PATCH v6 08/22] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Fri, 8 Nov 2024 22:41:37 -0600
Message-ID: <20241109044151.29804-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: b8437734-645f-4aad-01f6-08dd0078ebd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUxLcU82K1R2cklJQTlhdkV1aVk4dm9OTGJyenV0Zzh2R2VQZC9pQ3FrSmZv?=
 =?utf-8?B?TDg1M1pZVGN0aXJzZHhzc3RWcnlkZjcvQ2txT0xEOU9EVVozYStwTG92ejUw?=
 =?utf-8?B?Rlord1p5eHdIZm1PMWZVdm13c3k0VXNCcHM5YWNyMWJYN3NJbkFyeVU1QWhn?=
 =?utf-8?B?a1oyREUwLzFjL3dZcFlTaXUyaUU0K2hESGpqWStaWDk3WlZqK3hlRU9udFpn?=
 =?utf-8?B?TkVFK0cvTExKUktwQm12eVNjS2hjN3dsbUs5U0hVbDhBYlJCYWExUSt4WHJM?=
 =?utf-8?B?Ly9UMzRvUjhYdTRQcGdDdzh5cmtuZzFrM21vNzJwVEZHWkhYYUlnY0ppczlJ?=
 =?utf-8?B?RjJ6RzY5cHJTSkdQa1VCSU54Z1FjaXcxU1VBU1IyZ3kzWHlPeGxBR3FRZzhi?=
 =?utf-8?B?VXNTZ2FlOU52REMyYWNmb2Q2cGF1TFBoZjdXRGhWNlJWZmpSYTBSakVHdDNE?=
 =?utf-8?B?ZmtHTDVsYUhaTnR0ckRJYW1WdnZvMHhTeHRNQS90WDhaL0w2bTRheVRaL1ND?=
 =?utf-8?B?VXhTaXplVTBSQWQ0K2I5RWl1RCtHbG5OendaMHlhaklKS2M1cGpOc0hnWVc2?=
 =?utf-8?B?Y0ZPSCtkbFpGbmlYU3o5Ty9aL1B5KzRQVlozcmpBTVhYKzljZzlhUzR3bnhM?=
 =?utf-8?B?a2xhZExEZ2VLVFVOcTdGcXkxdy9acjdVem44ZExXWEhaMWQ2akQrSTdDY1F1?=
 =?utf-8?B?dW1KNE9VUGRjeE9uL1IvekJxZlF4ZU1FMEJ4cmY1WnUyYzVUMXJMbjZ3N0gw?=
 =?utf-8?B?ak5aZnhWOE5TSGU1YVdPb2dDSDdveDM3d2xNYkNFZWJRaWlGNHFBbmpyZTVK?=
 =?utf-8?B?SkIyaDhHZVhXYmhRNUJsS0piTjFadWZ1ck40cituTGJOTXVCaUZBZCsvWVBa?=
 =?utf-8?B?TlkrNzZBMGVtN3VnczA0dFIvR3dzamJoYmhYUVVxV09Qc2NnWnNjUDV5SUpz?=
 =?utf-8?B?T0pvYWhGNmUvbEVCQUNBclJCd2t2SDBsL3g4Mm5xenhWVjlmTmtlSGJVRjdU?=
 =?utf-8?B?NFNiL3dja01yY2k4eDZIOHNvNVpQTFdhSExjM0lkWkp5b1NLbFA0b0hyUHhR?=
 =?utf-8?B?MEQyNzdWS1k2c05QNzk1dWdkeVRlMUlGS2Fra3NUQlpldzN4YTlKQ3ZUY1hh?=
 =?utf-8?B?RXpuZVh1QWhjcmhwNHRNcC8reDJhbTJYWmpFMjRFUEFzY1BkNnR6MDNCN2VG?=
 =?utf-8?B?N3FKQjN3Ty8yOVlwOVVuTFJUeDB2M3ZScStQMkdsQWtMTkxCS2x3YjBIYlo4?=
 =?utf-8?B?ZlRpMHRZZDJuaFRQMk85MXIwbTF3eFBqcEJhWmFvK0s5ZjVWN1RjaVVBZkVi?=
 =?utf-8?B?eDNQaXEycFZmT3hocy9WSmpuS3NUZzR1RUVrTUZJSGVYdng4VnJQZ0NEbkJX?=
 =?utf-8?B?ZnRqaEhNRW5oSi8yZFlCRnR3alROcFdNTnZBSDFKbzdYTUhuVkdocTlzVDMw?=
 =?utf-8?B?eWNQUlZDbzVlWUpVU3FDNXVJaXpTVUkrVEQ4VnpuWjB5TWhFYVhEc0Npbk14?=
 =?utf-8?B?cWxkNkNGOHY5ZTFGc2sydEVyajhIQzVGUXdQUEVwOTVDM3NaUlFSTEpqVzJP?=
 =?utf-8?B?NDFqTEJKaWp1SWpIS1FPN0xwSnQxVC9XZHA4S1BDWEN0WXU1QnJqVlEwMGYz?=
 =?utf-8?B?T1ZUMFlNK3JvK3EvREozOXY2OXQrRklpU0J1RDRxY1Y1Um8yRHQ0UmRjV1N1?=
 =?utf-8?B?L1ptWXRJLzRvd2tHeVQ3aERaT3ZqNlZOaG43c2hseC9SRlE3TXU5dUcyT2Fz?=
 =?utf-8?B?NmZaOUU3R2hqcGticnZUdU9kK1hBb1F3Q3lNZHlHNmxkQTBtcUxrTHBPejM3?=
 =?utf-8?B?cHlnV0l6bVdERW1XWThLdTVHSEc3V3ovUUlVQmxoNDVHNG53T0NhdDZuTzJy?=
 =?utf-8?B?dXc1UVBEcWpQeVozeDhHdW1GYlZKNjd1TWd4MFlKVHplb2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:30.8050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8437734-645f-4aad-01f6-08dd0078ebd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 45ffd85a71dd5..9729543df6333 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -184,32 +184,26 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EINVAL;
 	}
 
-	mutex_lock(&profile_lock);
+	guard(mutex)(&profile_lock);
 	/* We can only have one active profile */
-	if (cur_profile) {
-		mutex_unlock(&profile_lock);
+	if (cur_profile)
 		return -EEXIST;
-	}
 
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err) {
-		mutex_unlock(&profile_lock);
+	if (err)
 		return err;
-	}
 
 	cur_profile = pprof;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	guard(mutex)(&profile_lock);
 
-	mutex_lock(&profile_lock);
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


