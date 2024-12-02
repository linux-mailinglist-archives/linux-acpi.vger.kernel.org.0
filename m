Return-Path: <linux-acpi+bounces-9860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289549DFA73
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFDB22C8D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0201FBC92;
	Mon,  2 Dec 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qnlpI3m/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB321FA27F;
	Mon,  2 Dec 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118720; cv=fail; b=T+pBUWn5HPQP2RWAUG8A6XBO/HbxqR4A0VwMtYbKHloC4y8cRyXl/bXj5CxmSgKO1jJC+S1ocITtQdFod1tHeW1EfOcV6feYyPP2mebST8vPN/qNl/FXaeDNmZi+8qEVm0v8jirbS+7eFemPtTSM9Cw3XdkSHub1zHADWXtYOrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118720; c=relaxed/simple;
	bh=Wf8Mf/SMm663C4HQysPYkEoNMVeUDOKQh0hZMgeYm0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bw5geilhiPMgky4ihq60Emfvs/bzpugKX+e0G3JAmgqFR8PadyS34SaYZcdNTS0S4Zd39ZXkzA4ASbHVzpqQ9P7Td/G031YO4U8dsG1gH2u6G2vZdg8edu/HJUxYhp6TdpLeyY9bfcLbANyfeQfz1pN95ahFLsrf8v+/zOey2Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qnlpI3m/; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYilkmQmrja4FYGhcYwOSix6Q0XoTOuxQRA5WTp80K6g3CLxC1eTSwQe5LBeO/Y8q/JuzyNZiIdZhQ+M9hOUwNX0eVvk5BTkf1PlR1nBlDGyztY4wduvEdeeITTWqSD/vtcYHKRIid9i9LlKGGxolFXnOWGmGBXsT4mfBBP6vSIlzsV3c6T3OthYbXq1DGuUwaK4s3uH231EsKFVCwgREQyFx6Y14Vq+etHCN0st5ClVICdEQR9m06PLe7teHY+AKe+pmgJDH+v26Xe5JVAvsUxclFloTerdDkGT4oSB6kEO8cJm3cOEOdZe5SeusEnHZv+bsyE68COH8XRaVJOWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNIfQJHGvNvzIfH9h40KQ9ngDElZj/c7E6vhFm+/W3M=;
 b=X+tD/UoxC5jNTYG9gFj2xAb2306Jzk987gZKiAcCkJPJg9RkyzBPzN1VW2Yfxwwc7YeRGufF5H04QyEh1BDa2nyT8rRge7hn7Sk6rLXp8O3iIChN2ZjNe3kRfh+u3ZsqOcTpHSvoppTFq78yo+iulUngZBdzRBUVdCddMmhCY1A6GibpfHiEaqCCVxR0PNnv83jlXvDhw8mrGL73y1GCLoRyilIHwhAEEt+5RGAwBEOLAuDmYsMVrKI+4yEqsmbhcAa38x6zhgsee3sQWz4JuHH7cD5dyI2yy1cOn3Nooch6wQwVcIAmdgebsrzuk31KHF6HqZBLhE7fAXWL3OGJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNIfQJHGvNvzIfH9h40KQ9ngDElZj/c7E6vhFm+/W3M=;
 b=qnlpI3m/8E3aYZaRIlJkUTjwXHe6i8BVS6reJzi587oWTeVQKyoCDY2zOVzjom2beR9clyZTdTKI0BOfGw/mKWFVs/jTaIHdjYKReJXZofPj9HissXHqjc5kfwcI6gAs9w2Sr80wdD0Z3BJJjfflUeRKTZgIJWoZtWEToDserdU=
Received: from CH5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610:1f0::13)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:51:55 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::8) by CH5PR05CA0020.outlook.office365.com
 (2603:10b6:610:1f0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Mon, 2
 Dec 2024 05:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:52 -0600
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
Subject: [PATCH v9 15/22] ACPI: platform_profile: Only show profiles common for all handlers
Date: Sun, 1 Dec 2024 23:50:24 -0600
Message-ID: <20241202055031.8038-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d27e4eb-5934-4e28-2629-08dd12956d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XIcHvAS5bFoRBsEW+yjEUpueUzsdDaFPWBT2CfgTAw6I2KJBLLAkAPM87ehM?=
 =?us-ascii?Q?ylC6UJDpMyycdBBj/k8Rg2WeGN063Do6wwK78gP2C9evt+K/4hf8pDki4ajc?=
 =?us-ascii?Q?Kwg1iIIeHwIe1VqylhlCcRGvG3Ok4O3cr427XOOeIoi+zD3dgC4HF5dX7Dpk?=
 =?us-ascii?Q?0H5BHHX3ep2hpPhgY+r21FyeSF8XH9lSgv/kBoN+l0OmRE2zvwlxpPjecSWl?=
 =?us-ascii?Q?jfixIYJ4TAOOfuGFKaIz1wb0DWLucnBIZ2iS2MvGl2KhBbkf2by46qmTUDWL?=
 =?us-ascii?Q?9+5eyxI3DAXhC+bZ3JiFjNOTUS3ceKrDaS/+/DgKpHpRabqVRkY3zsQaYaIA?=
 =?us-ascii?Q?4IBrgMOFeSrNpa2JwfdhgNLIuMGEnHLgrPiu6LikUQqRyFQJCti8PuyawNkM?=
 =?us-ascii?Q?/0sGJETGBfyoJMMuzH0VKPmBA3sEgjqGLDsTlQGXVRfUl352GqcfJMaSgoNy?=
 =?us-ascii?Q?dmIvSwOFRy/L0EQa7OPH0c/EPx+2dpikdybXO4nDCAgHBg+JvIoi5WcHfklT?=
 =?us-ascii?Q?eZ6g2HiPhLSxq10W8MHwgOKIiiFCjc4peNmQmnozp+W4VcSaj/qVy3qFQCSW?=
 =?us-ascii?Q?8kENy0JTxsJCI8YmOBago8GcZGRwMsgZ+pyAAy23AzBRUCS/XDjtaF1OVLs8?=
 =?us-ascii?Q?fsiww3TpkeeHIY0qmg8fgaBSScTYdA85bsGjX70UOwEct5pRgz/RbCyxFTOs?=
 =?us-ascii?Q?VWmj86FZAM3T1ku1bbkvoHKBABHdbGb7QOdHV4qfnbdxzPqV2lb36Sil4XzP?=
 =?us-ascii?Q?76XP55aJJ+VAyqRUx50txPUBYG41u/u+IJjxuNi5EHsEjtLdkB4GetUdj+Bb?=
 =?us-ascii?Q?7YsiKesbDbHJn9chqPsClHA6+ucpBNuktDTJEW+qPl8kZXI3LRtn/MU7a6lp?=
 =?us-ascii?Q?m8/taC/s7agM1No+2Thl6KXApuuVc4Bsx5cql4dzNDZog2L+XJjvMKrcD6nF?=
 =?us-ascii?Q?p1SYz7d+vl8FMhlKDIfOtiTjgaZ0AtGGOHTUdpTeAMHG9EVB9PWx1SWqxea4?=
 =?us-ascii?Q?39mu2Uu6jnloTNq9+wKPZ8rOZgdzqMkAyPgt5D7UKPdA8TVh0Ptn0bFNgpTo?=
 =?us-ascii?Q?zFEGbGm4jHUChF15L+1pqIMyRodQ0qKb9U4DTme1+ZElZ+53lgjMSiuh43F7?=
 =?us-ascii?Q?kR4qKn6HCH4MuLqFakj5slaLlcIJo2dhaQ83uoTG7p7wX2rEcuTIH/0aP/sD?=
 =?us-ascii?Q?l0nuXSCCCVIrC7fMgHtlSNfCOTKB/niyF4kewqWJekQtgbSnSpUFS067IB7m?=
 =?us-ascii?Q?t4Y1IO1CAlI28IvVSxumuqBfwQyPRr+AQQTO6LLgPrmBYLXtlyLXmMH5dIyA?=
 =?us-ascii?Q?sjsjjr0AHglHeBW4l3nptXGmCt4QLs1ipMRG7zYia/Vr2cd7I3xvg7oVTu4J?=
 =?us-ascii?Q?3Z/s8rOtQJmS45Mz0pzhkAJiQNRxngS8mUq64Gd1cJ8uHYt13Z0NKbN0DfXz?=
 =?us-ascii?Q?BRDpLrKYCJM8RBFI9esBGL57z/HP93LD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:54.9723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d27e4eb-5934-4e28-2629-08dd12956d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 52 ++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index bb0178e52ff6b..40826876006b5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -195,22 +195,54 @@ static const struct class platform_profile_class = {
 	.dev_groups = profile_groups,
 };
 
+/**
+ * _aggregate_choices - Aggregate the available profile choices
+ * @dev: The device
+ * @data: The available profile choices
+ * Return: 0 on success, -errno on failure
+ */
+static int _aggregate_choices(struct device *dev, void *data)
+{
+	struct platform_profile_handler *handler;
+	unsigned long *aggregate = data;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
+		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
+	else
+		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
+
+	return 0;
+}
+
+/**
+ * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
 static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+					     struct device_attribute *attr,
+					     char *buf)
 {
-	int len = 0;
-	int i;
+	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	int err;
 
+	set_bit(PLATFORM_PROFILE_LAST, aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST)
-			len += sysfs_emit_at(buf, len, len ? " %s": "%s", profile_names[i]);
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    aggregate, _aggregate_choices);
+		if (err)
+			return err;
 	}
-	len += sysfs_emit_at(buf, len, "\n");
 
-	return len;
+	/* no profile handler registered any more */
+	if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
+		return -EINVAL;
+
+	return _commmon_choices_show(aggregate, buf);
 }
 
 static ssize_t platform_profile_show(struct device *dev,
-- 
2.43.0


