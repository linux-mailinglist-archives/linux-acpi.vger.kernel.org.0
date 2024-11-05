Return-Path: <linux-acpi+bounces-9300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C19BD073
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C995F1F23327
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DFE14A0B8;
	Tue,  5 Nov 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lSzG5P+A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98E13D52E;
	Tue,  5 Nov 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820821; cv=fail; b=rEyV/DJnAQLGjEhJiLk7KMm+rBVfKenofMG6M8q1deA1aXK47fnxrS7ZMw47KZOR6s/evrzdQ+Hc4b6jc81z4mUv2OKW+iisTCjQBCqtM92A8KnCD2KVdRKhkvypII9MvQPOWuox+EJOJZO/sw7CaniOSjQVtssqOmOH51mIyss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820821; c=relaxed/simple;
	bh=Hf4w1lZfBgnE3Sq+P9ER52v4RFaq4g6HvEIEXOsuI1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkzRPoCxLH32ZssqVJG11BhwQyS59AA4/uyab99vDx0KnXAwRcCKuTaB1AentV56+i/qgsBopQnNgjWEmXObmlqg8mh7a94Eb/hD0YxLCwfl5iX9gfc5kcS735ThXeOblLEAXWWvh50DFcTRlxrSJ4PBAtgisBCefSJ1SdI57BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lSzG5P+A; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnZ97z9toftLSjMzFRhRic8jbOV3xPW+D3YkRqZxplf5TRph3HvSGXrMsDK5tJupubVt7mGiUMQqOfy5bh29XeyNarF1tEdEYpNyfxuvkiuS4tgmxi8LnT2rBpHYQ4d2bi2dkQUHPIu4t9T6njJ6+pU0X1KqLjTC8amHYjXBmO0DTKdsji7of4hHYErP9qB/WxFWe9taWSXbhWshyrmC0/UcfR0c8Axc3+zIX4icy/UvzO4t+qQRYA9y1evZjYzkOgUXWQGr7FNso8KDeIndqWdA3w10kVmoM7V+uH3fBpt2v6ZX6qqkT7FX4JmWGvxmPPDhaK6hsCLXoScWGTs0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oVr6vEiyIil7hu0Gy4FhGVYc4++Na2Ht5xVbuuI/U8=;
 b=pKXJk9+d2YYRLtZtEhd4AZPvnPOwmM9CWsBxMdR3Ti9Pchs2/PezzkaraZ24SAmrDdeMUByJOAGtnleF+PES60Cos5pfUN6VbK1Zh9UADKaUM+aX8UTQw19pDczFjp5QwCWxDZiS7kwAX9FkjPYxkmkpnYm7MUDiVTstS0kYEftilDZx71UfV8ZrsGvKofN4Y1h7qvuEEE/lUzfc+UPwvVOD0ji3cl4TFt9QtG3u9lnFBxCLh41PyQGBmR/YhvvDrxv+5432K0GBjDC7S2eIHzpDW4Iu57d4znUJV46/ag42bRjhIac7lSf7+3SOEHWJEFpaf9BmHoC7JqmRmaVWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oVr6vEiyIil7hu0Gy4FhGVYc4++Na2Ht5xVbuuI/U8=;
 b=lSzG5P+AwfGLUsXNFvo0VeAgma+URK7QpslxSfxQni3cmMAVuyTnKK50944i770lj0P1s6/AcwkJb6x5aTEgyqpoJxnP+vMCq+OiQaJh6FTFBI1lq0FCKNxVxKLeozBxxps13uByNSsmmTst1NlRo2VMw38ZT/OmDSEtda6F3T4=
Received: from MN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:208:52d::11)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 15:33:34 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::1b) by MN0PR04CA0018.outlook.office365.com
 (2603:10b6:208:52d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:30 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 02/20] platform/x86/dell: dell-pc: Create platform device
Date: Tue, 5 Nov 2024 09:32:58 -0600
Message-ID: <20241105153316.378-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4a8b8a-9d99-47b2-3b15-08dcfdaf3571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0U1S2tFUGZab1RSZnVzandPb3VRTHBRcThyb0ZwQ2QwOWpSblF5T2RuM3V6?=
 =?utf-8?B?MGxzeURubnRCN2JPTXg1OUIxU1ZYWTMwNmRhWWJmSHZZZU5TVUg1T3E5dVhB?=
 =?utf-8?B?L3h0YjN6WFJycVNMcTVVaDJZSi9xVFNVWTIvTzAvSzcrYzlQZk5sWmJRd0NK?=
 =?utf-8?B?cGdIcUZxV29Fc21YMDA1eE1jZVltckprTFFwcTNDdHZTbUNYOFJuK2prbDg5?=
 =?utf-8?B?M1B6TXlKNStFNlZ2RHBZdWlnVTVkWkZ6c1F0dXlyRlhvejJYTW5IMGZoZVBn?=
 =?utf-8?B?UGFqY3p5SWYwTWQ2WmpNdndZanVjZGErUnp5bzQxVTRueVBJcGc0Ky94NVY3?=
 =?utf-8?B?eml5Qi9FbHVSbk1KTzVjL1AxZXZQVjRSbUI4NU9HWFBmWGtPTndRK1hWdHVH?=
 =?utf-8?B?VGJYaFF0SG5saXEyclE0dzhQeGpnRnRBbDhYMnRKK3l2Qm5PNk5UZlB6bDBB?=
 =?utf-8?B?UmxsdGIza2JvRUdBb1hUOXlyRDNwc0s1VHgzck1NSkJ6TXQ5RmhpMWV5U2F1?=
 =?utf-8?B?cmVZMVFpaW9yaVhkVmZXMkRKMWpQR1Y5dWN0T0JCZnJzTzZ2UVhPRkJ5RDBk?=
 =?utf-8?B?MXkrWFp6dEViVGs5OVpJNHdCZzJmTXlYN1Q0eFB0TS9jS1FNTDBvQ0lRa2N3?=
 =?utf-8?B?Y0NDcjBxcmdIUW5GdkxRZFdvUlBkcDYycThlM0d3VnNHQk83a0dtN3p3STBq?=
 =?utf-8?B?SDVJMWFvc09FZ1hWYXdna3FKbTdVd0YwdklJeXlMLzM3Zi9lanp2Q1dXTDBS?=
 =?utf-8?B?c250WXBWK2UyK2hFNjRNUkdjRzM5bjQxZ2p5dDFYUEZiVTFTdWxTZXlXcUhK?=
 =?utf-8?B?UEcrWmxER2hKbmxlbXJKQS8vVDNzUkdoN0NLWDM0dVk1V2JuY002OHBqdjgz?=
 =?utf-8?B?bUl4TjZqVkxyNVl4YlFSajFZUUh2WXdLNHZnSDVPeDNzVjlqaG1PUlJKeFg3?=
 =?utf-8?B?MERHbmxsZlp1M3dqVG9qeTJEQjRzcU9VL0VjaW9LMFlWZkJRdEE2a2ZWWElQ?=
 =?utf-8?B?STQyRVlDcEpTQ0xia2lPNmcvcnEyZ1BTeGw2TjF2NlNOSGhNVWoxaVYwbFZJ?=
 =?utf-8?B?Mnh5aDBmMVJabGVidWJPZ1ZiQ0NpSEJNTDZNckxzYTl2aVNGcDhhUm11QTFo?=
 =?utf-8?B?M2JGTjBtazUweVh3aU1xcUZYOWp1NzR5bjlNUjRJbmlmT29uNFRhaUxJMDNv?=
 =?utf-8?B?RmZLc09ZYUJmdDYxNExtZ1pSeW9aV0tPMjBDWmxSL2oxZ3o4QTFReWtKVHVu?=
 =?utf-8?B?aWNieVVIUnd2T1EvQjIrWDU3RlJ4NVFUdUkxVGI5T1Uwck1Gcjd2ZWphTkZy?=
 =?utf-8?B?K0IrUUJ5SFNlemVnMnFIMGlWMzNWdjVLUG82bkVWT0hrd0xUbWhzcGhZVEpY?=
 =?utf-8?B?SENKVmJXNzBKRVJienV4YmtKcTdwaDhkMTVJVkc1YzFmclM4WTBZbGdOMlZD?=
 =?utf-8?B?L2tZSTBjRlJndllGMFdkZVd0Z24yK2NCRkx4YkZjK2dpL3RpeE1MQmRkTCs0?=
 =?utf-8?B?ZldzZkF6amZVZ2F4R2tBMUp4MlpmODRxcDBUYzFma3JtSTA3VzVXaG5RTkxJ?=
 =?utf-8?B?TWpCVm1TWDh1MityT0g1enQ3UXp3UUNyZCtmRm1KaytOQzNFeFBlcXNvWHYw?=
 =?utf-8?B?eDBTd2RSTWFlQnNXYlpjTldJQkd6dE9MS0lvbXJBVFhhSVpIZ0NGSUN6NFJO?=
 =?utf-8?B?bWZTMm04d0djdjhXUk84ckQwOHNxZCtOTEpxN1E0QmVySFFUSkh5SkZPdkw5?=
 =?utf-8?B?Q1EvRkhtN09aZ3VJQ2ZvS2szOUhweGNnV0NyZ1lVTXlkb1lmdUZqMUZKcHJx?=
 =?utf-8?B?UzJXckRGZTNxaVFEczZnUXB5RzVrTDZ0Ym1QdEYvaUNuSWxFbHpqMVlIS2RH?=
 =?utf-8?B?RWNsMGYrd1RTZ2F3c1NQUk1USWJEbUZiamRJOWRDZnNtOWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:33.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4a8b8a-9d99-47b2-3b15-08dcfdaf3571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

In order to have a device for the platform profile core to reference
create a platform device for dell-pc.

While doing this change the memory allocation for the thermal handler
to be device managed to follow the lifecycle of that device.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/dell/dell-pc.c | 35 +++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 3cf79e55e3129..b145fedb6b710 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -18,10 +18,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_profile.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "dell-smbios.h"
 
+static struct platform_device *platform_device;
+
 static const struct dmi_system_id dell_device_table[] __initconst = {
 	{
 		.ident = "Dell Inc.",
@@ -244,9 +247,18 @@ static int thermal_init(void)
 	if (!supported_modes)
 		return 0;
 
-	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
-	if (!thermal_handler)
+	platform_device = platform_device_alloc("dell-pc", PLATFORM_DEVID_NONE);
+	if (!platform_device)
 		return -ENOMEM;
+	ret = platform_device_add(platform_device);
+	if (ret)
+		goto cleanup_platform_device;
+
+	thermal_handler = devm_kzalloc(&platform_device->dev, sizeof(*thermal_handler), GFP_KERNEL);
+	if (!thermal_handler) {
+		ret = -ENOMEM;
+		goto cleanup_platform_device;
+	}
 	thermal_handler->name = "dell-pc";
 	thermal_handler->profile_get = thermal_platform_profile_get;
 	thermal_handler->profile_set = thermal_platform_profile_set;
@@ -262,20 +274,25 @@ static int thermal_init(void)
 
 	/* Clean up if failed */
 	ret = platform_profile_register(thermal_handler);
-	if (ret) {
-		kfree(thermal_handler);
-		thermal_handler = NULL;
-	}
+	if (ret)
+		goto cleanup_thermal_handler;
+
+	return 0;
+
+cleanup_thermal_handler:
+	thermal_handler = NULL;
+
+cleanup_platform_device:
+	platform_device_del(platform_device);
 
 	return ret;
 }
 
 static void thermal_cleanup(void)
 {
-	if (thermal_handler) {
+	if (thermal_handler)
 		platform_profile_remove();
-		kfree(thermal_handler);
-	}
+	platform_device_unregister(platform_device);
 }
 
 static int __init dell_init(void)
-- 
2.43.0


