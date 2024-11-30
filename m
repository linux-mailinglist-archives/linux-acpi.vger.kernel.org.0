Return-Path: <linux-acpi+bounces-9811-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A59DF0D3
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197F0163738
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058951AA78A;
	Sat, 30 Nov 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c/LjrBqr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEDF19E99E;
	Sat, 30 Nov 2024 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975549; cv=fail; b=AW2xvJfKZhRatcKh+qIc+uE3VvSNUNZ0ILYD7Dmmz+u8dr14VpnLgRQGD+7UhYAF9k+uWyb54G98lZhNhVhU5qr8dwKQ31hiAUwq7tT0n7ss9e3pvs9VbpIw6/QD3YoWiamxQpdxO/qog8fywlXJUXTwirPger0Fu17fRPPES/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975549; c=relaxed/simple;
	bh=DVbufMv2cR+FoQSgLi9r41SU5f9qJwfd5FmEJpPVzaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zf6JKoLynTHQzjrzsn+kmQ9R7Vz94sPiLaW9zDdJM+Nllr+VHyM1FbLp2ei4TINX4FvnvlUhQq49zh/4RyY9w0TYUEIHo/EtcUY1aQXPYiVkaAFqR0WBHr1Yx5dgeDkKlLyF30uitsC53qHi+hC97k9gYmEX/31SGk/QBW5gPMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c/LjrBqr; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoWZdIWwcd+GjOOmr6LzWJzDROuietMKAzeQLWriE6LyX+UO/joXhoMFA6jlXdxtsEvPQECpLPYtfJMl2YkcCwsE0lbhER4nL9tJRLEYFB7G75MUjfwhcosriDtTO9XodlybOl09mHf+IVG1emzcTDjb/1vYB6H2ldE45Ug4dYGHfeIk2C331/KJGWh4Xd72ZWRLKH3drWgHpLHgYz9yQvT7n9jA4EtdwlhwBsd+U2I9ZeuO7L+XLOm9C3dg82ukURprbWufFWGZeFyAsbFD5S6mlI0kXBU5w8K9K2xlh+42GOOmb/jvU2ipcGR75r3rJG5LnYcKPjL0MQksoBnTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDXx9JQ2KLp0jPqHncOkllsoPJc+kZfrcqYY2hdE8+U=;
 b=FrRBKApQZurbpkXOJckhFb4kYdhGVCEV5kHuZWuMj8GvCOEfC2V9hOYjeo5T5M2Is8vNBDusrlwLDa/WhnWZYvI2yZSBPFG04FwvqB9N9sVTxJiVmY+W6d2qPlXoBXoFnbVBB5Lfu/x5zKEM6OtaEz+VtGaEDeI8nHBnW54vh2ddJhKdaObNMYqWa7BFsVbqiDvv+Oxn07hA9SStR3UqqO2cmS9NbusFk8yUMCDQDr55SxpfziaAwiA9aPWT097pRt4Zai6bJkl+/HiyZ8LT4ujB+DLiF7iDUZ02Q/kqs0aPt75PzgbHfC0X4KJ1VrBqpd66oflqkbfCJxHhcqT6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDXx9JQ2KLp0jPqHncOkllsoPJc+kZfrcqYY2hdE8+U=;
 b=c/LjrBqrxuicRnMh+WTVJ7MB/2w4CGzbJuhP17Pq03yKlnPWzZPmYBA7buft+y9602KA+zquV6mtbr6jKWNkIQjIudO0A6I0hS3G98I8/fuckaqx96Uon4IBJ6bI1xS/trt9YBOjYkrgqZ8iJqb4CXR2crGohY+mpq8j9H7sJRs=
Received: from PH7PR10CA0011.namprd10.prod.outlook.com (2603:10b6:510:23d::12)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Sat, 30 Nov
 2024 14:05:43 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::10) by PH7PR10CA0011.outlook.office365.com
 (2603:10b6:510:23d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:39 -0600
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
Subject: [PATCH v8 11/22] ACPI: platform_profile: Add name attribute to class interface
Date: Sat, 30 Nov 2024 08:04:43 -0600
Message-ID: <20241130140454.455-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deb3eea-ba52-4f15-6419-08dd1148140e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTN4UVZOenZjQnd0QzBLYWZlSmxndVhTNXV1RWpYdUxRM3plWTFXNlNONE4r?=
 =?utf-8?B?L0pOSmhrQmJkdC83aUpWNHNtMDlLdzYrNnVFQmFUNnJCWmdYOXlqdXhHQmRT?=
 =?utf-8?B?TDh4Y2t2L1hoRzRUS0h4aE54OG4vOSt3SWo4Tjgyc0ZLTFNRUVBkdlNLdUpH?=
 =?utf-8?B?b1crL3BmMCtPbG51TmtvRWRCamZTZk44bU1zbWVZR0pETmNuR1hUOUFuOTB4?=
 =?utf-8?B?SEFYRTRiZ2NzZ3VDRHZTcFh2NHBraWRMeWJHQVV6SVNydG5NdWowc3o3WW9v?=
 =?utf-8?B?Q0NGeVFMc2RoNVZlTlFZY0k3bXRQcTBUTlNoUFJBS3l5VjhEZE81bmVWcmJv?=
 =?utf-8?B?dDFGd1J6eU9VU1ZndVZERTR3b2dIeGJ2bUdVbnpZaExxNlZ0Zk52UndZOGJl?=
 =?utf-8?B?SU5wamZPaTc2ZjZIVW5UdDNPY0NGd1d3amtVVzNoNnh6NEZoQjB1bU9LTTFs?=
 =?utf-8?B?Mm85eURrWUJPbkhvOGZUeHlXQ3ZLUkV4UFhuN3NvMm5lU2h3T1YyMUhzcGM5?=
 =?utf-8?B?TTI1c2dVa2NKSXRWaGxlYWwyMnNBTWg1Q3VCWW4rNWNubUtWcmhhT0tabXls?=
 =?utf-8?B?bFpPTHhQTm9oNUcvUWNjWTg1WGQvbHNJWjFiNlBPQmZhTFVTK2VEdUpvbGIy?=
 =?utf-8?B?UytFeDZVYW5qTGloeW5ZcVpXMk0rdHNpOEk4d3FmSFRJWC9MWlhaK0wreXVq?=
 =?utf-8?B?VlpmWWFuQkRBQjJSeUNEM2pYUytVWDE2UXkvT2UyQktNRWZneU9saW1ueE9x?=
 =?utf-8?B?b092d1drbkFTM0drdFQ4b1c1WTZoSUJkV3FVSmtQM05lZ2NwUGl4dlBXbm43?=
 =?utf-8?B?RW1qem9WTWd0TUt5RW5XNnRxWEhTT05tcm13ZDh0c0lpWU5UQnYySncrS1Z5?=
 =?utf-8?B?OW9FdUdpTmFxSzJOVklGbWtuaGxtbWtqaTlEZWk1MjZLcDNmTFFseHVMOW5P?=
 =?utf-8?B?b3ZyS2E4VEpUd3UvNUp5bTNnNlJWaFhRQkkrME4yclVWb256d1JkOWhNNERE?=
 =?utf-8?B?SFFESkJuSmcwa01EMXpOMWFPSUZzRnNvTjFHcnUybkNOZjNGZDBoVlplZjQ0?=
 =?utf-8?B?bmJCbmVtdWZPZnM0Ym4vZm9FcDJyT0hNcXJTd1FNeWNSVTBFS1dESzlaWlUx?=
 =?utf-8?B?THQ4ZkNWQitFYjJkTThwNXRQc1liaitBaTU5ZXRzT1VsaHVSWUdkTFcvWVc3?=
 =?utf-8?B?UU9sU3ZFRzFwV1poZ0FpYi9kTkY3bUxKV25rZG84V3VsYWV3Rk5hdFZVOXhr?=
 =?utf-8?B?K1IzMVVjYUxUMnNvQnVXOFoyVkFxZ29zbUpTS0dkOHVZbmNJYnl3RXBiVnAx?=
 =?utf-8?B?YWYzSDNiay94YjFXRml0RFdIOCtUS0lBNEhnSVVNQVNiai9jd0ZuTnB2VlRG?=
 =?utf-8?B?aTNHV1JwR3dqR0wzOGhjc2R2ZmlEQVpyQzA1c3h0YVBVRHlqNElYSTdPS0xE?=
 =?utf-8?B?T29jSkJMQmN2ckY2NCt4cnpqV3BBRG13QWNTSWxjc0FvOG1jalAxd0UxZ3NV?=
 =?utf-8?B?SzZrMzgyb29iWWtRK3FZL2swRWpLeFUrNXBsL1d3WDA2UkVCbEdxbXBkTEk2?=
 =?utf-8?B?MDh1NGhHNDc2bVpWOG5OWnRHU3A4dnNmTDBYSUtGNEdKZXJCb2E0TXh1Vjg1?=
 =?utf-8?B?aVZvcXBXV3ZYZC9xekp4MnhMVkRhS1F2emN5czU5b1NHLzRxM2xCdlBHRDRI?=
 =?utf-8?B?T3MyUTVtV1c0UkRNRHROQVRnbWlzQW9xdTBURHpRMkhrU21FWnNFK3NpV1ht?=
 =?utf-8?B?M1hhT2R2TlhhTEpjRzI3ZE80RXdyUHpabXk1NzJMRVhUN0tRWVgrT09DSzI0?=
 =?utf-8?B?OWZsY2J0RnpzbmdhYmV6eWZJOW9DRTkvZjdpZ2FtMlZoeEhROVlUVkcyTmZD?=
 =?utf-8?B?TnZPaFRleHJHS1U3STYyQWJrTnoyNnEyMndiVFdueXNUbks5V2lxbTlEUkxi?=
 =?utf-8?Q?L03IQEdDGwQWSOBXeix3jWbv08x7+n16?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:42.6564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deb3eea-ba52-4f15-6419-08dd1148140e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

The name attribute shows the name of the associated platform profile
handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 * Whitespace
---
 drivers/acpi/platform_profile.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 36f7b568deba5..eec842bd00643 100644
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


