Return-Path: <linux-acpi+bounces-9853-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E020C9DFA5D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C247160609
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE761F9F5D;
	Mon,  2 Dec 2024 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v08x+nmk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F381F9EBA;
	Mon,  2 Dec 2024 05:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118707; cv=fail; b=PDuMMk4MZN2vFZiSGqa+lbX5gKEkqLjMTLdw/OzVx9vjEx4LcZ8mL7bVM6Z3h4lwlRy/ff1TyRkPn/f3QIZscFaPgFSkjM/yNne7lbHqckY6Tkl9wHe7gGklryMPg09ywYxu15TUwCwLBS9wbtGd/KCCnCewD+7twalk3vRHoSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118707; c=relaxed/simple;
	bh=JewyXTxhFRqy6h34+YKrMpsgMeLgKwlZqckAx0I+7ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Trd1aTkXs3gjPmycx5uvs85/rvWJSPaQx8yqY1WzNdh4weX9sXBU/1ttL5T6jQHa4aqQM3vZX3nfn47AQzTggPpSFYgU8DDOfDxMOizOYQCkppYA3VwoQ7gqK1NhXMBTtLhWwD7r5OfipY4BPSU+cnAzZKKRY+G3CdJNknqYgr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v08x+nmk; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8H2KS75srIrOUhqa8mUH3jdnJZizWLiKGmfofcaAcWH2X6NIGVPPi2axNhtewjWtaZefpLXHQld8PmHRH81k5UlIYhPDcre4sO4PnUj8gFjl9kunnfxXEfeE2ttMIaMT5WK+C+twrC7cKmo1iB1kH7Ue2SA+zIo7Ia5M1pN8qAcRGhQbZ2CypKHi4jVA5DwY2n+Log4sg1ujKtVeFqS7ARsOhJUhiQvKkK4GaBrYxEE+S6KKT3XKBFLHo3oV4Fgzie8RVoU4u60E7T/NC60smyhgjasuY4lMvECU6ZWbc+drh9950qUUffmaLcBrtaOCoQNjDaJkLewBUX502FTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=GzTOEsPUivWb/QIFaI+QJ9Zx4kO+zDSGKOXAZO2RfIUSRFpCQu51hptkT8AEs4ZONXEMSiz++ZfsLCpaNy6bKiBDPYDZvnaMziqnPBQESio4QoVX53DvTPC3Q4FxQaXtS1shwVrHfKkZ77BZfeiCXoQuggsWHW/oyk2T56bJ5SyH5yM+ZbVxwfio/T+JaB3aU/0+OzK6jjYlbuj55VmtBQRpaqMqpBZME3G9xNxtdxBOuLnUxRTJ6YB2gRnJoJ3MXeVv87ih6IcL9D/Xfh/7YEBJ7n+LtNitOVMlBpZgXJjEmw3A/+soR7Udcmj8kB+Irvh5YePUyjBsKZke7rG4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=v08x+nmkvA05H6jmTVirxUqJJ0FegBHxtRInY7uF21UQNoPP9IdTXmgR7yBgQNrZMr7QN7OhX9TpBYV22zXmX/1FfxMWA+ZFkWLtV0wRA+EKnCKvf75Fzj2AeINwujDT+mMyCFs0Vo5QsC4os92jTRHzhJbX6HPDcZBRH+dov08=
Received: from CH2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:610:50::28)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:51:41 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::93) by CH2PR16CA0018.outlook.office365.com
 (2603:10b6:610:50::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:40 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:38 -0600
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
Subject: [PATCH v9 08/22] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Sun, 1 Dec 2024 23:50:17 -0600
Message-ID: <20241202055031.8038-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cd4ee9-ce26-410e-ae6b-08dd129564e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1V3Z3pKTTRwWEhkb3pxNFZMOVV6c2RJMkhEbkdyb0J4b3BxS093SU5RUXhk?=
 =?utf-8?B?ano0eDJJWnZsQzluNUNySStUM3EreTRBMmlzdFh0MUpQTUc5akpCNng5bDBl?=
 =?utf-8?B?RXphbVlnTHhoejk0aHpvczN0b1JyU0srYmU1U2x6NDVaMEVaMkd2QTFPNUM3?=
 =?utf-8?B?a0FsYVNnUHpjcnpnUnE0MHhuQWFQN0FGYVV1ZlJiMnlnOW53RXN2cTRBL2o4?=
 =?utf-8?B?R2xpT25YOTYvcmlNQUMvYmN6R01iK2hJS0VVVTVSbzE1ekVDd0svVkNMUTcx?=
 =?utf-8?B?TzhIbDRkUXNZNXBzZW41OUN6TGp0MlhDd2ZtUklIUVlibE9YQlNpYit0QW8w?=
 =?utf-8?B?RnhGMm5ZSnl5QlJhWUgyQlBpQkJTNlZaendrdk5JS2xzNkZpYVc1YTBBRlgv?=
 =?utf-8?B?ODZTU2NwRzIvVjlMU1YrSHVlL1RXejJ5ODV3bDI1R0dya2EwUUVFOUpjTFJt?=
 =?utf-8?B?clFwRXNlbld1Y2dETmpxZnVzNVhGaGJVMmEvMW8xRFVicmJqUFlPTGJMMkpW?=
 =?utf-8?B?Znl3dUtES2FTN2FKSHJCakZjbEdCb2czZDQvUy9oMzZBdVFqa0llTndtb3V6?=
 =?utf-8?B?RW9DNGhJZmNvVDBhRzhsZHB2TXRtNUVMR3UxL1gvbitCeGxWUmY4aHFIOWJS?=
 =?utf-8?B?Vzd6UGhvRlB0WGlFZ3NEamplenAwNUFvUjkrNVhjRVdsYTJVZkF4OFN1a0c1?=
 =?utf-8?B?M3oyRk5BQ1d2SjdoUU1rWWpEZml6UzNZMXBETUF2cWVkdmxCRktjd0NsVlRn?=
 =?utf-8?B?YU9oeFZocGNLVXBYU0lFUWVCUzU4Yk45cHpUUERSU2J4UTk5VTR5U2k2blJa?=
 =?utf-8?B?ZE5TbW9ML1Nxd2pKZTIyTFd5VVhuQjRya3pKTkZlN3BvTzIzOXcyc2w4WWo2?=
 =?utf-8?B?U2lFd2FoSThUT1hES1RiMGpNZkNoemFRNzNBTUJ0bE56QytQN2FndC9RSFpN?=
 =?utf-8?B?NFZGbHFCSERMVXI5ZngvUSs1aXpUTnlhMUlCUEpMenowV0tpSzF6VFJGeFU4?=
 =?utf-8?B?eURvQTlQb2dBVGZXeWE2b1JGT1dGQ1hFditiQzYrMnNEenhGU2dOUDFSVlk1?=
 =?utf-8?B?anVLb3NXM3hCSzg1MTJyNHN5Y3VoRlpFanRxdkZxZlZpejhEdXcrb2N4dE1R?=
 =?utf-8?B?M1R0amNaYk93dFMwdyt4TVFNbDYxdFZwOWFYWW9ndVdXQ2d4WE1NTnBNNk9J?=
 =?utf-8?B?WEpodWNhUzhkZmpLdENESGl6L0lZRm9jcjNhOEEzYlZvTzFmdnlhcm1PWmZZ?=
 =?utf-8?B?dXBtbDY3U0dDRmJJUkh5Tmh6ZEx1ZnRYb096UE1qVFkzZU9GbHVQZzdxSUNZ?=
 =?utf-8?B?MEJ2cU1lTG5XaThTNjJGa2MxdXVaTkxoaG4zUzNDNTh0OWdPcU1hZmh2eUxN?=
 =?utf-8?B?SzltZEs4blh4Q09LamlZUU1uenVSNlVHUXJsQ2dVN3lONHFOZVg4TFpkc2lQ?=
 =?utf-8?B?d21kWC9YZEJnVCttSWp1YWFjZlJjSzlEMmxwTCtjYlRCUkZoN3RzQm9nWmNq?=
 =?utf-8?B?TzN3Y1NWTU9EM2NDMitrZ0lsdjVsV0RxYjJ5cDNmdTl5TG5tM2d5N3BUZkR5?=
 =?utf-8?B?R0dwQUplampZYU9qVlcyYXQ0SktzU2F0U0ROMzNNYStzZTdWSGtMYkRvd0tT?=
 =?utf-8?B?dEladzhkUVhWdTVUZVFjdTVIMmlzbWVOS2pLYVVOMXVRTXk3Y1BYZ1BpQ3Ry?=
 =?utf-8?B?OFk2S2ExRG1ycFBVWURZSlVYWDFWbkVDa2hlMkZQWW5kaFZPY2xUQU1Cc0Ez?=
 =?utf-8?B?RzRqYzc2R0NUeEs3TkZiRGtzT3cvaVgvcDVjb0NxNHR5V2RNRm9wTDhFa1hy?=
 =?utf-8?B?Y2d6ZWFvdjBLVzJGcTc1dythZDVEaFNIdnJUd0JQNkwxVXUvMHNUOEt4WWNF?=
 =?utf-8?B?aHYwS2l0cmJWM0d5RFFtRDJ4NjEyREs0bDJ0VFlEcFdBaThyYjEzWkVhb3pE?=
 =?utf-8?Q?QFPXT4ZsOaCqCaj13UfrlrMM3T7PNEOV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:40.7767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cd4ee9-ce26-410e-ae6b-08dd129564e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

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


