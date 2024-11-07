Return-Path: <linux-acpi+bounces-9398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFC39BFE14
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427A41C21EE8
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C721DDC1B;
	Thu,  7 Nov 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DTzrAPBZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8B1DD0CD;
	Thu,  7 Nov 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959436; cv=fail; b=CjzorEdpzb5e8JG/Ayctd8S1lzoG/BP+UA6jUbYE16lvMeH5rOs8TQMT5Q4c5CppUTOOJlgXXtTgX97ujkWPA1Kk8ftjIIxFbl0naqxnHVGqOq8tGMdXnEhqmBnJCE3wTuT/jpLN8g2zY84d06aJVnwLTnvwr8aKQNDWzjzT1qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959436; c=relaxed/simple;
	bh=ygdLyhxsL1E6CrOOFkf3Wil/fb1df9UANwK8eafvuvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Et5QoEMX5xj5Cu2essp4MKAlx5GzjE/Am6L7q5vCxshzRSZgjuxpOsaa4XPQqiGA4FBDGYFn584Pd2sCnI9SuuTZ1oJIzQuPC/cMKNpwcx/OgXETATMiLMev4DPwSZ6HX3sOImOSsrv7Tw5S32XzWxolRKX2uuazid7+eoVQhD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DTzrAPBZ; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXL1gWWOVhTnceKCf+EzUDom2145JrWiXq3dabjVFi0zdREDhXk0qrSzrXWXF/qYGKni3Ggh+Zupt9RVuEjAspLFVxLpxD0xy0iCy4vX49cG0nW9qOTe016ElC7hhB8HWjG8xerfoqeFwV4UAqL9USsOEEtT684ur3qI3ngoOrXN9rNy/an4oFaB6pp87Aq6TcsxLMu/DjN7fBMlsVt3XGwsCUiZ/2VjjF78udnA9o5iNi/gqVbdX+G9IXtvVr5HR+nwK4cQfuL+RTVB1ebpJ5Zibee0qoIvsF1I1Tg2zkiM2hkHlwoljSQwam9qDsI8lVGcXH1FK3sYOl1AoNRTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnoVOYlNJzRgfMoBu5KuIPp1sDfmHYMmm89hNzr+CpM=;
 b=fe8f55Ib2pPr6wKONaaujDp2k/clK7UU/44krhJdBoaIheZa2MJ0KvARjjLHDfMxuc7AG3R52KY/twfpz1cXD+z4nS2U6K81NYM/ay1kHVMIiCOz1xaFVgpx+K/F/vNhS6PVjbyTq3MoiEMMLKJSK3hp2mmfdvIJxRbsrWdnkqA+oGlBCs4lpbU4ItvLqb212VIV8PTdcnaSqtvEmufjNcFertWupXlXzNBKiFFfGjXtxtpa0mmxDJRa/uZu1Bn/8z7ULwlLV92zRGEfbXNaco0Psevbbz2dnCVbt73F8a/aRQbQV/qqYpj3PZ0SrUtXoV2aCWSl9HdJv0TTJQ24eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnoVOYlNJzRgfMoBu5KuIPp1sDfmHYMmm89hNzr+CpM=;
 b=DTzrAPBZ+ULPzxDBxZsYnbrXJ4qgNW/VTuQm/mVhI1PShL+grkFwce1Zuy0sDrYkCKvF2ozvza20MYOFsUUXXuAcotQnSGTJo2LGDC+tZiaDnNckqI5nd9YKw18BjYIAABf9nOY94CRWHTcCAfvWKJ7tVfH+yWVZbOOnuEDtqOw=
Received: from CH5P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::21)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 06:03:49 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::4f) by CH5P221CA0011.outlook.office365.com
 (2603:10b6:610:1f2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:46 -0600
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
Subject: [PATCH v5 13/20] ACPI: platform_profile: Notify change events on register and unregister
Date: Thu, 7 Nov 2024 00:02:47 -0600
Message-ID: <20241107060254.17615-14-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbc2ddb-161e-441b-2df4-08dcfef1f2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+sp6/TA46r8xwq6cFouHZxXimImlWxYlIUWC7WFkVcKa9F5y13h1/kUVg1su?=
 =?us-ascii?Q?I/cQ3m9KsYS/4VnjRh8MrBgcpXMNjW/ZQvL3BVd4CSPP/suzvA8WgP4DjNtS?=
 =?us-ascii?Q?CYtk43lg3L7K5vL3PPDEj7kuDpYvnvvyhrxIK9rFFhblmQKLEokAIjEn9Dl8?=
 =?us-ascii?Q?w3GcfmDvxwEJiuV9osWL88yLllzoAjlBl1oKmaVmqCZ+AGdiFo2nfnLZ8PrX?=
 =?us-ascii?Q?ich3Yv+kVS9e0Jwph9Pdndu05xgKAg+HFq5WOWPuQ18y4lXQ4+UZFQhmFCin?=
 =?us-ascii?Q?kap4AhM3gCtZ+jpB0VBfW5UQEBAfoaP2k35LnjDwHPb0oqUOuKpp7rt+7Kcw?=
 =?us-ascii?Q?vAOPVQSv0iIKh/urvphL8H1xVX6oaT44Efr2rahcBQmkHTgsCv34791RLXeK?=
 =?us-ascii?Q?pdQXblKKq7kwiy5Sk0cWyube9cloKXBYZciJMP38pZ/SAmjC5MAJGuKVBJAy?=
 =?us-ascii?Q?au9mMQMDp5s1JJwcnEIsq7nyJemQOpVZa8x1Ha4J1PR4wHUNFIJ2g7Ahr88D?=
 =?us-ascii?Q?qonUEzxioP7tiwBJLEctfaBf3YbBHuE4VgCH057otCSuhVSAd+HpZrUdyAPM?=
 =?us-ascii?Q?fY2DX4nzK4VrxntDSx0bYMcecIGQ6CRdHk+dpuX3z9SDBtI28p2X9xRaoIdE?=
 =?us-ascii?Q?mb7y9TDkQ09nC/FKhBjDyiXowmzKJX/dUCVsQdAwcZpbkGPghioLDkVLUJe5?=
 =?us-ascii?Q?k3j8RfKPN5nfIY5hm17Ka7mpb3CbzP5NDu/SR5wlqqSriML1XkuE+95NqLB1?=
 =?us-ascii?Q?5o0stDTjghpWDak+tIWI152Nf0esPivRvPV3pMe58hTWUO26ZXMky7aK1m8+?=
 =?us-ascii?Q?n41IH3/7bZb41aPHdTbchP9VbcxdZMzGXtnVau8KbikLrwq31bIHEP2A3oCM?=
 =?us-ascii?Q?gIoHcjMzPJTNnS9rV41Hn02VCiAm0AYbkp7TuYl74v4ofjwm4MqGi+7CZHAH?=
 =?us-ascii?Q?AIlxp//3Ahm0y0lQMmV8QOIR1He3JOzJsvr6+PllSo8ctF/a1dSLNI/6Ecx3?=
 =?us-ascii?Q?fbH3eCxa/pCfd8zw7uruv8/PZ4glJcU7Pb0BRuUlRuL/kiEBkIHfk7zgQNx3?=
 =?us-ascii?Q?kjQiYl7m9XnlZkZwUpETRSBMUuQiSLbEI9KxsuvRkXX165LEibF7yfpQbCk5?=
 =?us-ascii?Q?Ch1v9hwBTcEwfpaaXVzB6WaQo1ssZ0xEoFEAXUEuhMRiHUa5UBPhEKTW0meo?=
 =?us-ascii?Q?6B8JmxkOPS2wU7J+2A5ES54sMt5Bd7jxaYyM6OvMS+blqEdZlnVzJksms0PB?=
 =?us-ascii?Q?hY4cpO5Z47dEINTMEfd1lQMZB5zVbNYLZecSVVWuetvzGT8CDgrDKgohxHJz?=
 =?us-ascii?Q?zPghx997HqE5IRnyur95vVzUdKZieYqE8LLMJ9mFENffYhZnhC40K8NQpyCl?=
 =?us-ascii?Q?gGjgWjZuHbl0rQGozMpIzhKrpQwlvVH5cSm0DPXte2/IPt6Jmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:49.0360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbc2ddb-161e-441b-2df4-08dcfef1f2b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 35e0e8f666072..510e1435d3980 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -399,6 +399,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	}
 	dev_set_drvdata(pprof->class_dev, pprof);
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = pprof;
 	return 0;
 
@@ -421,6 +423,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = NULL;
 	return 0;
 }
-- 
2.43.0


