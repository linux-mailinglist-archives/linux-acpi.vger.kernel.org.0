Return-Path: <linux-acpi+bounces-9994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA49E64E0
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F40528699E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71C192D69;
	Fri,  6 Dec 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nZpj+5rj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E654191F74;
	Fri,  6 Dec 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455552; cv=fail; b=cmw9VC7ENTH0HgjCcfWEyI3F4Hho57aZbi9MToRg0mr3eJIk+F3DKD72989fvrtsyX12qphCHiEy7JGmqj63+KaySnx/Ka1CvztbtIW8xThvGtzmoRNdVxX36YRn8kCo44WS+ZB4L1sK2pME0sO0czD4WioIqFrqPt4rh3b1Fc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455552; c=relaxed/simple;
	bh=8TwRzJ07cFwIQ2NazLrB11fm542Y4UBOvveW1k6rnJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKGiVW9yXYdComOiK5epUJBZvqlm+ZBb3ZSuWOrE7vMkup0YCZyqbMgbxkgDZWlGHCIT9o//cyZB09O4LeHLLlJtUzgxZrWPDRL4A2zy4AAyfyrbgECUVF8k1l19DPRPN+lW8EnXKKu8+2dWew8PPWwbc7ytOi7vb0U0fPQuhqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nZpj+5rj; arc=fail smtp.client-ip=40.107.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFgL/waPV3PSJAWGquzWJ18fUIOiHOpIyvrLmlX94sFO+6qzKaUpxjqCWqASL8fimmeUm4aXAlvwZ7/Dz6Pfh7j2YV1jWyUaCiq/rcHvTClqXKUsDEB9yIeqT11pF5A+3oRInitnSe7WNg+G8G3IF+JuuTIfAGBJdGSFLoXNh95GKX+2bM8r/cTeQjTIcRZ4+Bc0Xz3v8R/W/FODl8J/AQVWAr9HScqqxI7iedP4aazYhltbdimX59+PRu+VAyiLnoqTzWtEtEHroqfnvon1fqiwTB/UIuKsSHjsXdc54kryQGGQ/1AqQKis+zKwTOylibbKRJmUcPJItICQ4YbQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNQgXoRM05ChHUpIFMIBYhAgUYaFBj/pG27lt9b+pes=;
 b=kd2OYMRKp0fOCtss0D7eFfCtCMbDgOUHOxbQdAXjGHy/RFHRCLtYxHb/Y6+K33pMcwwQMrxIVoegAp3OFqg7h5kpiGAMsiYgwm+uDZiurtThwMdFv1TkQxu9YKeDFhlWCp2f6ZKvCc+aV44voybxa0JeXd8eCczUaU8o9GX0TFQQFsyHWtvi/POv+WTA26chj2UWXpnUPyma1ENw9Utx2B75bLtqye6tHtTijLZRuFcb5mUfMCU696BTMr4VcnCbxrTHEztEvBVvw7TZkKoltJfoRVqrm+2Vs159Pd3gsUTwApsu7+dWl42LWpvdVo61eUw+6maI9YeiA5+BLifmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNQgXoRM05ChHUpIFMIBYhAgUYaFBj/pG27lt9b+pes=;
 b=nZpj+5rjRfzldwlkLqMwb6It9XDdRczcE6MX/0TjUXVVNDNN8YTHqY10MmEriTKpQJXCP3IvqkIdTYQGdUR4NVA/iErAtKIL7C375WWBR5A+zSSReNar/vBFyzDrK4C1ZC6nobLqkhXMIdfPkpbPiVW9k8x3+xU+/WLY2o3tLgg=
Received: from PH7P221CA0090.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::25)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 03:25:47 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::1e) by PH7P221CA0090.outlook.office365.com
 (2603:10b6:510:328::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:47 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:25:10 -0600
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
Subject: [PATCH v10 10/22] ACPI: platform_profile: Create class for ACPI platform profile
Date: Thu, 5 Dec 2024 21:19:06 -0600
Message-ID: <20241206031918.1537-11-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ade6d1-c751-462b-bcc4-08dd15a5ad36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGxleTQ5NEwwQlg4b3llWERoVGZ6RGVqRHg5MEFkR2RqUTVPdEMxZ0ZkcGFC?=
 =?utf-8?B?N2hUYmJGdEJiZ0piT1U4a2ppTXJWUHhyNzlOeDJwWm02YVJjU3NtNCtxZVNE?=
 =?utf-8?B?TWNiWkU2eW80Nmh5TmxOcGxwNVhlQURoZkZOM0dNU2lhL3Y5TERHRlFML0Jj?=
 =?utf-8?B?ajArbWRzRWEybWFuRStadUtMbGJoZGh3dURxWno1ZVA1U09uZ3A2b2JGelVD?=
 =?utf-8?B?YmN5cHZ3Wkcvblpsbi85WmRLQjB5QVZsVFNVWkNoRXFpUmt1YXRhTlg0N29G?=
 =?utf-8?B?bjNDMDgrMXJvRkN5OS9DN0pjdXkxZE9TcUpBU3hEWmhLa0YvQWtHM2Rva3Br?=
 =?utf-8?B?ek4yeVZxYThVYVFiOUVMNlo1c2lIYUtCYWlHd0s3NlUxNTd1cDkzcnQyV2Rm?=
 =?utf-8?B?ZjJtUUFzL2FidmVhcUk5U2xtdGtVV2NnbGNiWlE5eEVuK3BnV29OaVVGWnc4?=
 =?utf-8?B?NWFPdEtwaWplcS80T29TQ09vMVZRSlpYUVhHS0FVaUphc0ovNVNlak8vQW0w?=
 =?utf-8?B?WVc1Z2d1UFRLMjF1ZGtDcEsyeTlpR1NMdTQ1dEtJc0hDZlhIWlU2dHdXQk5S?=
 =?utf-8?B?UkZvdWVacnNzK253L2lIc1FJYyt5MmZmTlpQWkVoOURzYXlMdlVSUkpEblJ2?=
 =?utf-8?B?MmJzMThWWFUyN2N4cWtabzBNekJxRmkzc0dCaitQMDR4bjdVVWJWc2VVTVdo?=
 =?utf-8?B?cXI5TGkwSWgvUUdKQXY3dEpHTXhMa2JWOHJRckwrN2RGZWE2ZnZoR2tuTVhY?=
 =?utf-8?B?REs1V3BKa2x0SFM1YjUxQmpWZUhqbER3ZGE0WFhYTHNaaWplT1d2T1pQQ1pR?=
 =?utf-8?B?NzQ1OWJBdU9IdFJGVmZnZElXSHdtcXlEU084RngweGZEdzh5cFRwTFBmMG5W?=
 =?utf-8?B?emNzL1o2MjBsWldFMkhYTmRsakJWQzNwNjh2SG51eXBHdEY4ZXZkbmRVSkN1?=
 =?utf-8?B?YVFjcXRpUFd2MEU3cS9XK1NFaEp2NEx4OEhMRzA1QUZFYUNNWWgvWlhIOFRO?=
 =?utf-8?B?czRGRHN3czU4MTRWSzM3VUhiMmRodWpQMjJiOTZDSTBNMFVNNW1PWGNJcXZo?=
 =?utf-8?B?UmpTc2pDQVdMM0hpZjFwZ1NQLzZtTFNpRmlLSjNQblFVdVNwbUdhQk0yOVQv?=
 =?utf-8?B?dHo5d3EreG13Qm5nWGxUNCtaRThXUTB5Rkp0SUtweW5DOGJVR0lWZlZWNjhO?=
 =?utf-8?B?aWp6eGFBNG1najVmZFNHcDVsU1hodnZOK1B1dFJTTm1YbjlOQ0swOExJaWJh?=
 =?utf-8?B?d3FtVEZwS1BNR1R4MUR1S0tKeTBmL2xNVCtRNlpNaGhuMW5ML2dqWU1EdUpE?=
 =?utf-8?B?UzFBQTg5NTF5alkvblR3cmZ2WTNIdEFPWSt3MmptOXR5ejFoYnJVTUFyaTUz?=
 =?utf-8?B?ZldJcHgzZXEvZ0F1ZmRhNTN3QzQ1MmRQaVdFZUptK3I1Q3J5Mm5DK0IxSWIy?=
 =?utf-8?B?cnFpV3R5WmxSMjBRamNzNHVSQ3VMUzdSdmQ3NmhyV2RRYTJTRW1oTVcvb0po?=
 =?utf-8?B?dUErenA2MDNjNThaclQ5RTJ3Y0hac3Y1bUFGZzVFY2twVU1nVDZrN1Voa0t2?=
 =?utf-8?B?TXZHWmRVbXQzUkt6UEJOV3duN2lxQXU2YlJIYktUMFEvbG43WVJaZXNsQkRo?=
 =?utf-8?B?YUJhUjN4ZWdiaDhORGtJOHdzdkJjZ1VqSndwemNYSkI0MDR5OEFvRS9ZbVJ6?=
 =?utf-8?B?SDJGMFB3VnI3SHJkeDQrWDc4QzNpRnNHUlRZUjJOVTAvNGszbzhqYzBBOTRY?=
 =?utf-8?B?bUxYS0JjcWRDcHcxcFdUcEY1OWY5ZUxaL2NacDljKy9yYkREUFhjWG1mNkJ6?=
 =?utf-8?B?cE5FTmVqTnVDYW9SZFJGaFk4cVB5TEo3VDRFbFowRDJmQmQ5NVpVNEdTb3BW?=
 =?utf-8?B?dnhLWk9vRnFCR3p5OFdyL1p4ME9PU2NiWWxCc3ZYcGlvZ1hTanppbzVXL0hq?=
 =?utf-8?Q?0ozvayHg+t1SxtYYfaC346ree1FRr3SZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:47.4904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ade6d1-c751-462b-bcc4-08dd15a5ad36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

When registering a platform profile handler create a class device
that will allow changing a single platform profile handler.

The class and sysfs group are no longer needed when the platform profile
core is a module and unloaded, so remove them at that time as well.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 82 ++++++++++++++++++++++++++++++--
 include/linux/platform_profile.h |  2 +
 2 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a1f0378f15e62..11eb60b09bac4 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -5,6 +5,7 @@
 #include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/init.h>
+#include <linux/kdev_t.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
@@ -22,6 +23,12 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
+static DEFINE_IDA(platform_profile_ida);
+
+static const struct class platform_profile_class = {
+	.name = "platform-profile",
+};
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -101,8 +108,21 @@ static struct attribute *platform_profile_attrs[] = {
 	NULL
 };
 
+static int profile_class_registered(struct device *dev, const void *data)
+{
+	return 1;
+}
+
+static umode_t profile_class_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (!class_find_device(&platform_profile_class, NULL, NULL, profile_class_registered))
+		return 0;
+	return attr->mode;
+}
+
 static const struct attribute_group platform_profile_group = {
-	.attrs = platform_profile_attrs
+	.attrs = platform_profile_attrs,
+	.is_visible = profile_class_is_visible,
 };
 
 void platform_profile_notify(struct platform_profile_handler *pprof)
@@ -160,25 +180,77 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (cur_profile)
 		return -EEXIST;
 
-	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err)
-		return err;
+	/* create class interface for individual handler */
+	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
+	if (pprof->minor < 0)
+		return pprof->minor;
+	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
+					 MKDEV(0, 0), pprof, "platform-profile-%d",
+					 pprof->minor);
+	if (IS_ERR(pprof->class_dev)) {
+		err = PTR_ERR(pprof->class_dev);
+		goto cleanup_ida;
+	}
 
 	cur_profile = pprof;
+
+	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
+	if (err)
+		goto cleanup_cur;
+
 	return 0;
+
+cleanup_cur:
+	cur_profile = NULL;
+	device_unregister(pprof->class_dev);
+
+cleanup_ida:
+	ida_free(&platform_profile_ida, pprof->minor);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
+	int id;
 	guard(mutex)(&profile_lock);
 
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
+
+	id = pprof->minor;
+	device_unregister(pprof->class_dev);
+	ida_free(&platform_profile_ida, id);
+
+	sysfs_update_group(acpi_kobj, &platform_profile_group);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
+static int __init platform_profile_init(void)
+{
+	int err;
+
+	err = class_register(&platform_profile_class);
+	if (err)
+		return err;
+
+	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
+	if (err)
+		class_unregister(&platform_profile_class);
+
+	return err;
+}
+
+static void __exit platform_profile_exit(void)
+{
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	class_unregister(&platform_profile_class);
+}
+module_init(platform_profile_init);
+module_exit(platform_profile_exit);
+
 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
 MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8ec0b8da56db5..a888fd085c513 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -29,6 +29,8 @@ enum platform_profile_option {
 struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
+	struct device *class_dev;
+	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
 				enum platform_profile_option *profile);
-- 
2.43.0


