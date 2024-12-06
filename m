Return-Path: <linux-acpi+bounces-9998-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE239E64EF
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945B4160F0D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0E1A3042;
	Fri,  6 Dec 2024 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ypm3eEFx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946F190486;
	Fri,  6 Dec 2024 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455558; cv=fail; b=FRpSayUc9j3SVCwX6MQwtqHMulU4GYu5IfLtPqr1MN9pGijOPOJ3VqoWIjbrmyZyXuAh7GLWq0BCCC5hFToC5lLqLj5aKoLtVm3x55qvmcbA39j4He7+kxzBsry7/3wa6oZ3P+Ayoc9c4Dtf43NoO9Le8P3n0OUkLxp7biUWh5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455558; c=relaxed/simple;
	bh=8j6IZ3JMmu+41jCwPsnsdKYImZaIW8m1wBbpxlRKS84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7SirOF4pt98nQSj0kMxBIbqFiTX5ylr12Qo2Kv6t39x4vovpLXBy7Os1njsOAfM1diP46i+42Fj8YC63RkAfJ6LJKnSNJuwWZuTHiLMlRSH1RfuEIZM83uBZEsh9EX815XU83VgHcnHbZmZxAsmb/1OwEU5AKBzFQYhsm+lnjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ypm3eEFx; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzFqoOdsfBmlM2zSn/A0gZApBQfoV+KEv7Su05/PhOm3jundxGtA1ecvHFjkDsyP86BWteHcChmzj3coU0OdEr3tbmvGi51pTPvF2xlANQFXnJulW1IHX8wzdt/TjS+z2pULRfKctt6TJH7sZ6ptmikOrGADl0Tey5grMdSWzUtoeDresgpqNF7/DmTd5RoNcD/MC/ZAdhX48skd+KD9/1fRrQp64msDF2d0TTsVKzSJEgFGNSJOP2BRjRjnXKV7m4tpXozd5L/eYl6UVg19kxWrpzf/VTm29je8nhdJdegRblRddoiqLKSPVJrnP31E5Y61TXk0Knnrbf8qPPPuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twy81q1cppJjIV1vZtEfQ96qEDUlzNcYT3qqr3gwMdQ=;
 b=hdPGb6ihAzAY5DDdchSh2DUKAjJP42IFsIem5pzrseIC7iuBaV7SHzpeHRtJP5t4adn9HlmZYkFYgmOGLUiYNEiMHQJSG0ziQsRipYd05Cc78CzgzxrEmcToa2rik0N2zcJaCMJS3BzHTbOSiaa8YWsl57lrOpIs2Zs9tdK1XVhDRAmObvFPb5q12zBEMvCMw/2UVkiN2nAvnqSZLSXWNzrI0zN/PoiRxs6i2wl0i6/VQOhFL5WZs0VkkA+BDUUuOM+BGTUzGTnyK+fHbmendqAkURAgCY5bey0kgWdKfrfhDuqFKm5GeAcq+9SGdTKqoDHBguYBjw3SUsr7zVLh6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twy81q1cppJjIV1vZtEfQ96qEDUlzNcYT3qqr3gwMdQ=;
 b=Ypm3eEFxycVgPeZwPcWjbgjgRHuNg07164VaH9x6DvYiTEZ9ByqezclTFZ1uzhjXVshWyEeOjp6s2Kud8HalmBnaSEMyv0J9PHRzXNq6Bvcx+8fzBP5lvm9n2y3xPRSXT02VZY5148RZGmpnolftVqtwGDmuD+qAh04aCKryzhg=
Received: from MW4PR04CA0049.namprd04.prod.outlook.com (2603:10b6:303:6a::24)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 03:25:51 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::83) by MW4PR04CA0049.outlook.office365.com
 (2603:10b6:303:6a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:51 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:25:48 -0600
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
Subject: [PATCH v10 13/22] ACPI: platform_profile: Add profile attribute for class interface
Date: Thu, 5 Dec 2024 21:19:09 -0600
Message-ID: <20241206031918.1537-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 100f811b-ac8f-48ea-ac09-08dd15a5afa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG5pdTRUSUpqSFdsMXhPcDJ1V2ZES1dVeGhuRGVaNVRiQTVaeEp1UEwyUVJw?=
 =?utf-8?B?WHVzTFpuMGJPZVNJSnJlN3ZPQ292cEFvd1ZuekxzMEdKRlhNSkR3ZklJckIr?=
 =?utf-8?B?ZW9oMUN1eEhNSEJFZEU1eVptYUZWV1dkU0hVSTZmOXh2c1hBWXVzY3Z0YVlr?=
 =?utf-8?B?YmZyVk1waTZZTnNhU21xT2o2SS9DdW9qRDAwbS9JSWdSTHFQb0R3VVUzZ084?=
 =?utf-8?B?cSsyN1lFdzBQUG84aWdaRjQ5TVFnRHRRSFNlb0ZBU2xYY0RnbW9TbmY4M00x?=
 =?utf-8?B?Zmt0d01CVnJVajNXeGJQK3llYzRkeGZIaGV3OFhrcG9jZm4wbkZPNmk5R2dT?=
 =?utf-8?B?QXVOUVBZaWRZMzZ1Mi9EMkNpVml1R01zYVNONmEyUnBZMXVDaHdhOTM4ZmNJ?=
 =?utf-8?B?RjJrWmttNHFkKzFqajRzNFliaDYwcXlobldpUkZrRUpFa2VzTkpDM3NKQWRy?=
 =?utf-8?B?M2FmWEJrT1NZb1JBczE4cnhiT2dhNEdsYUdqM0d3dndYUDRobUhJVSszK0V5?=
 =?utf-8?B?blhBeXBzTzh2U2V4R1FqdVVWakdYUGFDN3p0OTBQeCtEUWs5OEFCYTJIZGpV?=
 =?utf-8?B?MnM1bjRXQldwWlFDWlRJNStyRnN3UWMyRU9UNUl1eUpqdUlyNGcvUXFQNXBn?=
 =?utf-8?B?Yyt2KzNxaTM3YW9ETkJlbzlkRlA4WCt3MzhLUWdCQTBiSjI4NXVrejhxOWR3?=
 =?utf-8?B?aUI2UzRRL3NaMVpwTVJIRFlIbjVVbHBmbUZUR1pTbkwwQjVLVFcxWTlyMUhi?=
 =?utf-8?B?RllHUnhHcHp4TmNtbHI4S3YvZElkdWd0VHJxcWFvTUdXM3kySWdBdEw0dXl1?=
 =?utf-8?B?bW8yZzVxYyt2NDk0UDZZSjBvNXozYWxtSExCaDNSL1FwdW1SL3NCbFp3aHlX?=
 =?utf-8?B?cUR4Z2pwY295dnBxamVucjYzZk5hV2xObTc1R0FlN2FxdWRsZ3Bia1AwQlhx?=
 =?utf-8?B?NWhEaW5DcVB6dW5aWHY0ZFRPU2laRE9ZcklhNGJkMUQ1SGk2akZVK1dybDdK?=
 =?utf-8?B?ZTNlSjNRZW0vZ1k0cnFCdFBxbGwxZVlnQkxwMEZRRmJQMHdkNm9QVHprK3h3?=
 =?utf-8?B?cEZTRndXeEp3cDJxUk1aRVM4WDBKWFF2amU1Y0lwdmIzWHhVN21SN3FPblNB?=
 =?utf-8?B?d3lSMmgrM2VNOWlCS2lTM3djU3ZtVDRUSUplT0xDYTdiODdIYUNkMW5iYndO?=
 =?utf-8?B?MGVYelNkT3QrL05YS0VKYXpwK0IrZGU5RG5FVmlGbndseGhnQUNRaG5ac3pF?=
 =?utf-8?B?UkRLd0lFK1pBeFJ1NUVwa3I3RSszMFE5VXg1ekw3Nzkzejh2amJOMWw5QTJx?=
 =?utf-8?B?eWxyLzFJV1hzamR6ckdFakpKdytBKzJ4bHF4Y2lCR04vU0g0OXdOZUplUTJK?=
 =?utf-8?B?cWJGYTdXeUJSSXJHY2lGK0dTYVY0c1ptRjVuYnpWQ3c3K1dqRjAxMnhRQlU3?=
 =?utf-8?B?MWl3OEFBMDFFaFpxY09TVTM0cklEeUFWYzhHdC9VbUNaMHBkaXI4VG5iQitG?=
 =?utf-8?B?OEdHdG51R0pvK0xwVEFqTE05YkhHbmR1dFZYOTVsalBydDR4MzRGc0F4dmNl?=
 =?utf-8?B?NVhDTjVkY0dUb3Z3ZmdDN0w2ekczMU9lOUxBYjNQejhMWHNXVWI2a3RkVUdP?=
 =?utf-8?B?MGNIbmhzaXhWN2hLWmgwL0xuNjlUQUkydDV4YUNzOW5OeWdteGc2YjFsblZn?=
 =?utf-8?B?TXNhazJ4SEVYQjNta0JTN0RjZndmTWU5YjFtOEVMaE9EVXJqdGhadERjY1pM?=
 =?utf-8?B?ZG42N1NXR1g1NEV0TEJBZWdkVHpSdXZRbjRBeDlXREgzYlRqY0cwN3pvSzNG?=
 =?utf-8?B?S0JnUjJKRnJ0c1IySGg5MDJBM3BPYmNXMGNSVXRnVHhRc3daMnBsRUE3Y0RW?=
 =?utf-8?B?NEV0ZmtqNzF0NXFLRmY1bmVJRGcxQmg0WDZoOGNBR1pSOUdaTTZPajBmdGNr?=
 =?utf-8?Q?GJ4AuAWgNTfVmLYtAj2w+XJDPvF7Fxd1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:51.5679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 100f811b-ac8f-48ea-ac09-08dd15a5afa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159

Reading and writing the `profile` sysfs file will use the callbacks for
the platform profile handler to read or set the given profile.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * Whitespace
---
 drivers/acpi/platform_profile.c | 105 ++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 885f41bca6c25..d2c83cb258296 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -47,6 +47,55 @@ static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
 	return len;
 }
 
+/**
+ * _store_class_profile - Set the profile for a class device
+ * @dev: The class device
+ * @data: The profile to set
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int _store_class_profile(struct device *dev, void *data)
+{
+	struct platform_profile_handler *handler;
+	int *bit = (int *)data;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	if (!test_bit(*bit, handler->choices))
+		return -EOPNOTSUPP;
+
+	return handler->profile_set(handler, *bit);
+}
+
+/**
+ * get_class_profile - Show the current profile for a class device
+ * @dev: The class device
+ * @profile: The profile to return
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int get_class_profile(struct device *dev,
+			     enum platform_profile_option *profile)
+{
+	struct platform_profile_handler *handler;
+	enum platform_profile_option val;
+	int err;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	err = handler->profile_get(handler, &val);
+	if (err) {
+		pr_err("Failed to get profile for handler %s\n", handler->name);
+		return err;
+	}
+
+	if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
+		return -EINVAL;
+	*profile = val;
+
+	return 0;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -81,9 +130,65 @@ static ssize_t choices_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(choices);
 
+/**
+ * profile_show - Show the current profile for a class device
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t profile_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
+	int err;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		err = get_class_profile(dev, &profile);
+		if (err)
+			return err;
+	}
+
+	return sysfs_emit(buf, "%s\n", profile_names[profile]);
+}
+
+/**
+ * profile_store - Set the profile for a class device
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to read from
+ * @count: The number of bytes to read
+ *
+ * Return: The number of bytes read
+ */
+static ssize_t profile_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int index, ret;
+
+	index = sysfs_match_string(profile_names, buf);
+	if (index < 0)
+		return -EINVAL;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		ret = _store_class_profile(dev, &index);
+		if (ret)
+			return ret;
+	}
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	return count;
+}
+static DEVICE_ATTR_RW(profile);
+
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_choices.attr,
+	&dev_attr_profile.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


