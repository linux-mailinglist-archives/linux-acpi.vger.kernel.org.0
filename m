Return-Path: <linux-acpi+bounces-9812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB09DF0D0
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67855B21515
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203EE1AAE1B;
	Sat, 30 Nov 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AIRSw85u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799131AAE0C;
	Sat, 30 Nov 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975555; cv=fail; b=hlWGXPsKDwWcv2HTeC4Q+1kM3xlfmSkOROcVPcPJaUxVp8lfeYQFGeynLqn/F1UbLeksTx6j6MWNidqRKiqO9jMWSBHyUiwCdk1pcWNfwdkxhXuCXHcVYRgyXB5n0dgQ1v7DqbMDfFsXKIm8AHeTQBlMwFpG2EEgPONeNtvrKO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975555; c=relaxed/simple;
	bh=t1I6XbTlAg32LuZyx/zXnSdsSg4Grm5d56jAKU8vPec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgVFAqWOLj2qUSBNS/dwKAXdNRiKg0mZj3zHGhVHpy3Wh9TWIRMllHwK9pcF8mylhuL/StA5aWNCKwLOlDcRDdpNqOXVd2Jx9UhVB2OYqlGqJSvP0UquHOZZIYEpD77U1U85eB2T2NhSqwVeWjVzJ+xdjBPIi4CgVH4UImpKREo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AIRSw85u; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAfOZ0Dbir25uyJf/mA4/TXu/W6Cee62sZXRM8NVhsSr+AchUNG4scUx4/VN+C1Rgd1Qzi2zkb00ysKcIQ0nqv+9sG21LW/cI38b2vzwpYMgyL/EE3pH/uaUPy74vsGYv1kTlJtTtJAbipPiYFZomxCrOKDj3h9ZvDd5JVc0tsht6ltLrzGoEgwRbkuQE0yV2Fp1hbpJ+XXsC7ABcpL4ITSxV/QVGNV8KRdc/szGl7IPzvkFOtsrk3ucNYzlPWfFRTk2L1mBAs2uy8XU/ob6leZcOxcL6Z+QSYDT9VwEkJ0SMobPKdsX9X0oVMrmYvREeS9mDjmtsm1Mp7/DgGkP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZRiBc29Tzl09/U6QRzkiEpEHzP9HtzUZIQBk5q6oLw=;
 b=J02DDQt0jKwSmEfd728uMa8/DYwDjYzY3SZercl1DaRE837IgOaqL7pxJxYuoayP/YlNiR271cEsIPAU4mQBrnUGPVvOlRsTYBNMV02kOk5xuznj2ul6Tki91jNujsRgVpyrJXGKkLlQgpcuC3ktHw3mOsguPvZEg5rmovnGfZDcpXBrEPtu4VI4jnT7Z67aJPAdXs4+O0l+xglvsc2ypPQeGAGY4C+dIXOlpq+gyfrcmtRHk7Nvrfog7IQoZmlNQTfTyqam+owmn7FW94i+mkA2ok/A800bveZVjSPGc4pkmhybbixGUnLFYAyqpbDmUd21nmQkFC7YuaX9rcuXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZRiBc29Tzl09/U6QRzkiEpEHzP9HtzUZIQBk5q6oLw=;
 b=AIRSw85uJY1CiNn7zqOqpas2HRIxLdfpJOvPbUNQQnOqMS0vn/ePPVxfhajrNViLiIcGxpn5Kt1Di8XDMhev2k4tgfY5D1vPvQ/oQpwc2FdiL7teD478hAbozLjcmMo36N/fXM4jgTrf0TFGaWGejGJdhdvti6VNlDa0ZAnkl0I=
Received: from PH7PR10CA0006.namprd10.prod.outlook.com (2603:10b6:510:23d::25)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:05:46 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::c9) by PH7PR10CA0006.outlook.office365.com
 (2603:10b6:510:23d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:05:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:05:42 -0600
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
Subject: [PATCH v8 12/22] ACPI: platform_profile: Add choices attribute for class interface
Date: Sat, 30 Nov 2024 08:04:44 -0600
Message-ID: <20241130140454.455-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e30b921-7553-4603-89a6-08dd114815f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENvRDF2enFJUWpXRk9CalNmUnJQR0ZKVi91cGlTUlFwaURRSGdJaDgwNUsz?=
 =?utf-8?B?QnAzcjB3emgzS3ZNcUo3UFRzMG1icmtXVU5JVUhydzcybXVsY0FQbkFQMzRU?=
 =?utf-8?B?YjdjWFU4cndIZ0RZb0FDRExwbzNXeUFTSys0VE8wZjhzUk5pVUpTdXA4eCsx?=
 =?utf-8?B?ajFUdmNjQ1lSV1ZQbHpUb0RHYktCV0o4OUFjVTErLyszUGxPRDNxWjZ5aTVl?=
 =?utf-8?B?SExOd0J3SFYzdTRDZmUzbnpZbk42cmR3MEhtM0k2VEh0QjRrRFl4aDNUdGdL?=
 =?utf-8?B?WjdDcmcvZmk5MGx1NmJMRXNOcVYvVnJYNDAxQWE3VW5BNy80M0xwM01XWEhO?=
 =?utf-8?B?cVZBazdxZ3hZeXZ3SXBzaUVRVEFFK3A4SVFobzE4anpIVmg2aWRTdjNEWkww?=
 =?utf-8?B?UFYyaFVicVR4RkdvZnhoVTNJLzUrc3RUZi9LMndRRFZtL2hTQU5PSVpBdVky?=
 =?utf-8?B?b2JGaGQrYlNzdnlJd2ZLL3JmRDBwdXhmZTlwQUg3V3lTVWJYWGIzYzFkNWxU?=
 =?utf-8?B?THhWbDVadEY0L1duS2REbWdYbjhhYjd3MC9rWWUwWmtZNFR1ekJIcGFJVFBt?=
 =?utf-8?B?Vkw0N3ByYndiNmliNmlUUmViQXJOeWx2dlIvV1QvV01ub0liMVpYVTVEMzRG?=
 =?utf-8?B?SlRINkxQTzBReGYxcGZBN09QVm9tczZId0t2WmZQWlVlY0NqT3BuaWkrSkFK?=
 =?utf-8?B?a3RrYlFsUDdYb0llWEtSQjRHQ1VuTGJZcGVFZm95K3JSbzFsUkZ1alpMdFhj?=
 =?utf-8?B?UjJzMWJVdnI2azd3eFNkM3NZUG5tZWhvTEhzM2RNd0I3UkRQK1lXZWIvQ05K?=
 =?utf-8?B?V2J2MlR5cCs4Ly9VNzVhbE4xRnFrdTRyRUdOWjIyZUorZW4zQm45cGVvUHhZ?=
 =?utf-8?B?WVRIS1RpeGlaNGVtUFV1MGd5aFpEMXprSHZVbmF5Unh4NVhSU3kxViswZ25M?=
 =?utf-8?B?T0RTdVZnaHV3WlZRQTdIRWZQelhXRFZDcWJWakJwREpXZmJ1VXpBTDdjNDdv?=
 =?utf-8?B?cUtxQlVWNDNMcFVNZ1VseFRDWjVxMm0ySzNYT0pUL0F4QnFJdTJFcVpHb3po?=
 =?utf-8?B?QXRIZFdib3MvanpiSzc4TkJ5OEFNZnhxL2hBaWZxUGRHSzloZDNMTFM2V1Bk?=
 =?utf-8?B?TUQ0NlE2L2RuQ0dkNkFVTThkbmVIL2MvOGthbUdtaWJsMXNlTkRBZUhYZjlk?=
 =?utf-8?B?MTZPTWdkUEQ1RnI3TVNCVXQ4dUVvbGpUd1NaWGlxQTA4eVpjRFdBU0wxMW1I?=
 =?utf-8?B?ckoxOER6Q0g0Rm5KRlZYQ2NjTWlYQkFCOXJjSlQyWTNiRHhBWVF0U2szTExz?=
 =?utf-8?B?aFhFMmpiS29zbEJUUnNBYUxhOTZZQktDVmI4YUpTOHlMSUZ2VGFUSkNqS0FH?=
 =?utf-8?B?MElTMUlieTQyWFhiYmt3aGI0MUhZSEVwSWpoVEZhdXNBNVVpVE5ONmluNlYr?=
 =?utf-8?B?eW1DU0dvZWN6dGhSeWJ5TkkrSkJpNi9CYmdEZ2tOZUNsZDJuWTNlTk1FVEpN?=
 =?utf-8?B?ZWRLZU16QTNCVHM3L3ZmR2Z6WmlEWXc5VC8yYWdvbDZmTlVWdk83UFNjUHVo?=
 =?utf-8?B?b21yL3pCaW1uYUY0SSs1ZWJ1YW9ML2RqczFQcExYTEpHVk5rWXY5YjVUQkRZ?=
 =?utf-8?B?UWRqN1c2clByZG5MUnEvckZvOXgwTWFWeGtveHFnUVgwWlU5NWZtQ3pKaHRH?=
 =?utf-8?B?R3hhRXBOWlhXN0dMZjRZaHZHWXF2Y051NUZzQVMrdHptWmFmYnJjckh5c2hQ?=
 =?utf-8?B?akhOdUVkZ3RQdytkTGxhL0RPKzlQc2pka09rOU1MTDFxQ3NpdVlOMzEvZ1l5?=
 =?utf-8?B?L0hVYWdiY0pvMldqYlZDVDRJNXB1NzVNTFgrWmxqdW5ENUswNnA4aDZHM1VS?=
 =?utf-8?B?cFBLZmhzSHNRUDh6OWpQckVyWFdPVCtmaElMZVV3d1lxU1BKQWFwUmRJamtt?=
 =?utf-8?Q?AmxDuiH8dm3jJReEyxhIgL9PkXdycCeQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:05:45.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e30b921-7553-4603-89a6-08dd114815f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

The `choices` file will show all possible choices that a given platform
profile handler can support.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 whitespace
---
 drivers/acpi/platform_profile.c | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index eec842bd00643..6a257e500b190 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,6 +25,28 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * _commmon_choices_show - Show the available profile choices
+ * @choices: The available profile choices
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
+{
+	int i, len = 0;
+
+	for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -41,8 +63,27 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr, char
 }
 static DEVICE_ATTR_RO(name);
 
+/**
+ * choices_show - Show the available profile choices
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t choices_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	return _commmon_choices_show(handler->choices, buf);
+}
+static DEVICE_ATTR_RO(choices);
+
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_choices.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


