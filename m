Return-Path: <linux-acpi+bounces-9995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B4D9E64E2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D9916A1E9
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6648194125;
	Fri,  6 Dec 2024 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KnE0FnnH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B35D192B8F;
	Fri,  6 Dec 2024 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455554; cv=fail; b=WsSiAcSyJON+T9w1QD7hW+l4qYCs1fd9vJLBb0J8ZQR2lYZo0iba4S8jo/2kX8aUHSo8cv1LVvlR1OaXr0Bf0M/DINe3DHRtpJIZnqK0BzQFNbCCKY8Msjdt6EDcW/ipHZYNc1C1BxWC8ZXRQrQvo2CSN0wDTW1HlA7enB7T+3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455554; c=relaxed/simple;
	bh=f7rRTPdGt5m3xhvPy2bnOdtnYov7yveNVfhJizBpXq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+qHgz1X8wd3RahYJkacVtGMDLjAOrwVOoXzh9SG6qmJI0O6mmzEgAKtNXLwzEGBq/79So8WSKgvaKM7+6Zq81xL/1WfQRl4R+lvhzEqBYp3fqIB9RI0+9MWD1D5JYJ1kwqb7ibfwm9NfJwgfYaxKXG7/CRA87a90Ua70taY8oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KnE0FnnH; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r83Swbh5CmK1yo3Ao3hDxTx5rf9spmoXzWL+n1KhvWypsI23wcfgpAHyD+6+8f/mIOYqWj+YdSFgtrk86ED4m0FCUs5sOOmTHvYAY9HOMP2lr6EIvKNW0ANmFET701Cdf7hzwNYxSx7dZlzqbMV3nOjs8zoLEw/A46f7Ky9j9vaQ5wpoBmUkFC5TR/Rov9wey4LHcPpi38KYNpVa/FsPM07Vo1ofYcdQCfN8BwWLh2vr8n7JfRkq8pn+jLcwJGX5ajd48/qLvqlEYJlSIqfOyhHBb3WI7bAaHNdai8n0rCJmvlpPd2SHUUozGiBvqLrINOJR0GSFv3YZB/cGWu2cxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHTCX93LZBSL0mOWadvLK2NWPAiijv6GOjt7h8l+o/M=;
 b=hLd9eaWZDGg2Y6EhTWITiDZohOvz+W+0UA7OPZ9aUxhlB629pNZTWUpCof9foCS2Xg8lBDgOdLV6+8fJ5pb2Zrg/65WWaCmv6ygoXjCDgObBeK2bn7ROsBYw77+8GsoTjM+f4FwJeht9ZSYjYzi132XXNfvUYvm+U3hGdHnPO2E+Wp7uJmMvq2kuH3OPw4fmiYEGYfOaIoYfjUzmvO/g9jEuJbtu0gTr7NYcgU6dYNT9A4zwgT+QL2v2kCNKwmuz7BagI7zr+RzuzWfNDDoRvHN7OkRyWc8+jWUmJwEaPOvO0hER2H6vHGzAkqvYoDZajSAEWpIH8TU2OLW3PEzgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHTCX93LZBSL0mOWadvLK2NWPAiijv6GOjt7h8l+o/M=;
 b=KnE0FnnHtFU6POyPPktmHIXm6XQEWvn/d4G2W+ospuoQkqorKINdk2bZ4cdPHgyPOVtgLLPgPJfVaXIuKZ6Jcjwg8ume3/ou18LX4DjK2ZOqZ1kcpCBDp8J+pN/R3f8wwF9GcS2TxLtzl9r9J3qNGXILmfD5cxIqOJyTJHBZG78=
Received: from PH7P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::15)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 03:25:49 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::d3) by PH7P221CA0061.outlook.office365.com
 (2603:10b6:510:328::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:25:12 -0600
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
Subject: [PATCH v10 11/22] ACPI: platform_profile: Add name attribute to class interface
Date: Thu, 5 Dec 2024 21:19:07 -0600
Message-ID: <20241206031918.1537-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: e57dc12c-ce64-465b-647e-08dd15a5ae01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG1CQzZ1VHdmNkV4KzJJZUtwdGhSbTd0Wmh5dmFOZ0dDUHBlYlU2bkdUTTl6?=
 =?utf-8?B?SE1FMkw1cE5BWnd1QzRoT0lGcjdqZXJqMmduMUpDUEFtdTdsaU5Ic3ZIUWZP?=
 =?utf-8?B?SFdKUzQ1R2J2QjBoeTc4c2hzZkxsMElXUCtPbVlIOXBsYkV0SjJTdk5HQ0tl?=
 =?utf-8?B?NVlqdDV2UkNEMjQrT2xNc3c3RWxndnc4dWgxaE10RFM2djdUWDU3ajdaalVu?=
 =?utf-8?B?RU9TVUtJRm0xZTZ0L250anlYUExCL1NZajBpV1dUN1BQbXUxeUVpQjBXZ0gv?=
 =?utf-8?B?NTNzNmVKOGVRaGRKbHYvajRwMHZJWVVoVWdyTVFwR0c0RjBaRmlSZTFnZUVD?=
 =?utf-8?B?ckU3dUxXeHo3VHY0Y0d1U2pGWnRRK1V3MVgvOUJ6Tk1nZHZRSFU4Zi9GN280?=
 =?utf-8?B?ZmhWV3RmYmFmNndJbVFRNlNCcndBRGtENU9uNm0zTkZRdHVEVGVSYTVZWXpG?=
 =?utf-8?B?bm1pN2x1ZEFWanB1ZWxvZ2lCTU5EL3BiZlcxM3NNRktlQVh2aGlOWFYxdzRT?=
 =?utf-8?B?QjFVVVRIaW1XSWhOcFZwc2VYNTJ4Y09KTVpERGdxcUNENW42ejZQc0VUUTB4?=
 =?utf-8?B?SzAyK2ZOb3VNWi9ic1BOS3k5ZDVOMGp6TEM1YnZRQmRiaDgvaEMyblBoeTFN?=
 =?utf-8?B?dks1WVpXVDBMZmhXRWtKWlRiVUQwb1RYdktsTENqeVU5b3RXL3BXYjh2QzVx?=
 =?utf-8?B?RFAwcldoMUlTbmgreUMrNXdXd0VHSXovZ1dXMGwrYmlhSnhIeFFlSEJNdHgv?=
 =?utf-8?B?VlpjM3ZiK1JaVUxEZ3NSdTJFblN6Uk5GWWRNcWJPT081UEtYOWlNaEFKR2hV?=
 =?utf-8?B?b1FBdjREdG1TcGtjdXliZEpteENWSENSY3F0Tm9TRUhFYjY5bVQwd0xwRy9Q?=
 =?utf-8?B?TDgrYlQ3VzNlMUR5SUMzenQzZVBoRnQzdGV5SlRNMDZkR3lwWStpQmtxWUw1?=
 =?utf-8?B?M2tQSGo2ZWloQ1ZGZHY1Y1RHNnkyRVg5bjJGbnI4MlVsRWNFV1ZWamdERnVu?=
 =?utf-8?B?bEZsdGlTNGQ4S1QxR1g0NFhaK2ZjL3E4K0RMTWFmTHcrRHNoc2lhdjNONUIv?=
 =?utf-8?B?VWU0Vm54cEZsL0RkOTVtT2VHdzFUd1IydUVHSXM3SWp2QlYwYTk1cyt1RHdy?=
 =?utf-8?B?RkJKRnlmZythUnpkakRaSEwzc25wcVZpeWNramRIaU5NVWZLdndqalV3UzBK?=
 =?utf-8?B?UmdIVGhqOEpUNmI1Nk10cmdQam1RVk1oU2FINndjWXJwZWlFL2lUR0V3V1B2?=
 =?utf-8?B?cmlrRnlwSGF2cWNpWVo0UEtQMmp5ZE9YdmlqSElLSFU3RmFZUERja2RBaWY2?=
 =?utf-8?B?U2xnaEFNMis1TGtGN1BVcVkrMlYxRlRhdnRQZ1B3Kzh2SnJyU2hwaC9FODVt?=
 =?utf-8?B?Wk5sbjNjajlndmhLV1J6ZkhYZEJJWmRRMDcvc1BYNzVUQnN3NTRMaGxmditq?=
 =?utf-8?B?WXVJQkZQei9YUDV5RlRrYmNkRXhwSVkwSkVqZFloeDlBQm90amFCU3g2aVB3?=
 =?utf-8?B?Ym9iM0ZqR3RSS3JSekxYTytFZ2ZoZlFrNjVoYmcrbG9rMmtleFBoZ1ZEN3dm?=
 =?utf-8?B?eDlaQjZ0eFJ5Zmp5QXh6ZWdaL2VWWUxGck13MHBVMSt4M2hIeFRKQU5aY0Jr?=
 =?utf-8?B?VHdnanBsNE9tZjdnUjNLTlYvbGM2UmlkSnpleDliQXVqbjhhTnBVTFRkZEhY?=
 =?utf-8?B?ejNyQzQ5N2xwU052TlNsbXFsdVBWejl0YUV3VWc1ODc2bjcwM2RjSG9mcFFj?=
 =?utf-8?B?NSttUWxIQUdzd3l2ZmVEamNxZVBEOWFVN1I1eURDRnBGUWMyMXVka2RXMU5F?=
 =?utf-8?B?NnUwc3NnWDRZUGhUU09RTlprcHp1TUt1V0JoTHJ4MDdkaTk5Y3hLMnhMMFlJ?=
 =?utf-8?B?elEzK0tISkVXNWNZeUUwaFErTEhyWEY4RnNUcGg0TW5HMzRjVW1WN2JEdEha?=
 =?utf-8?Q?ReA6obA4XP72bm29DyPVEDwH40PU16DA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:48.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57dc12c-ce64-465b-647e-08dd15a5ae01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

The name attribute shows the name of the associated platform profile
handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 11eb60b09bac4..49a8bd6e97ece 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,8 +25,31 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * name_show - Show the name of the profile handler
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", handler->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static struct attribute *profile_attrs[] = {
+	&dev_attr_name.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(profile);
+
 static const struct class platform_profile_class = {
 	.name = "platform-profile",
+	.dev_groups = profile_groups,
 };
 
 static ssize_t platform_profile_choices_show(struct device *dev,
-- 
2.43.0


