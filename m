Return-Path: <linux-acpi+bounces-5467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC48B63D4
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2024 22:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2B5B243A6
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2024 20:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756B17966C;
	Mon, 29 Apr 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FhDmLLkP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E3179641;
	Mon, 29 Apr 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423541; cv=fail; b=aT5e1fl2RRG6NvLiM2JYpthr9hukJ+LHAym0hUGp6rjVcHtCBw9IIGJsI6HrMgZP2ZZBjpCPr84k3UHj1Bq6IVROK4TquDPy0liV3MDcKFnn1+90qmOw9cMM0IOAd6q63hWAKywi1FJOZEf06VkiAYM7AFlPzJ+8lmkBqmbHdYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423541; c=relaxed/simple;
	bh=1ReBNU5gzSMRM7Kj69+zdJtSxFYn2bC8zS2aJcE2M1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o/X4ps3eZbBjLpCOmBUG+tArPJEQsjv15y37o/djo7khNs0jwNktnTkasF4iek12JVe1Qg9XOH8aGHMMh10Bc1nAM4Z2B84pKb8Kxphtdm0HxC3Y2FNhU9kFnDKkp3YPR7QsDPKs0iDKYmbCz93OdS5O6IWBfxukwpVcm7GX8p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FhDmLLkP; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpKdz2Q0gTsOobu26lGKVm/GzWD8hqciqXNEPVMbhh1b6lOhUEexceOGRoZGR8I1FHljtRrlAw+F8rXmLfByfbcTZQOET+ZVISVL5VT5nRkBYvIIfL8jIPBh2s9U9COw6cJUJqBSwggMBJcB4WpU1UQSkmBIkpfnxIDP/ceoewayKLKJD952Z81jgFq8eJfHG2S2MN+F4ZL/gkC4MQHzxI0T4dTGoJEoEBh1QXTjb/p2+QKQ1dh81TzX5+ZgEBl0oyw/X+o9V2kUlgUSXuOaXqOmg4x1Rj2zbt6TNGqx14MjZRXLX4EO1yBe+8cnLbSGrV7f4PO4RTSkm0umr3AHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ1GIu/JT7P+sCgsaRxAqmHs7qx2Nd9/svHXFW5vIFI=;
 b=nvxsItfXtXlA/gesKAK0QtrGLKuzYGGopJL7nkFxoyGyiNz05kJUy2BqdKI7+iw2BjqWZOXRTNDa96t83xp/CVpxCHrkAU/DsmWJtY4nRy7g7tyB2QlZQ+qKKlybn42LRQ7yba8Mq/Z1cydmNf+ZXyl/dUESaU6FG0poODnFebPfzSpqteH++4Rx817XLlECjw1oA1JyWQLnGh8DB4ppUXyt75CDn3a2JD7NgnVgYt36fAKChFYWYRqxf4dkaz332qlS5vqlTLFUqcMfWkMYsIPnUbNB1zM/Yz1yZwOR4rhWgj//+K8XKUvj450i4aJfl1hlqv0qUGS+wDUxYMlB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ1GIu/JT7P+sCgsaRxAqmHs7qx2Nd9/svHXFW5vIFI=;
 b=FhDmLLkPI3gsvHtLHJTmiPNATI/KTtgiqhNRdzJahmyUwH9P/ebru3wVysOAqBvYXAOQeQ+GWy6UAZhg+jky4PZINhmbW7WnHslZqJSoRUSaafaua8pbHWAmgAI2qA/0AY0Mn7moPUyKsiHBsny/WI2CcGUMBnRfiiFg9Q31y80QNNR9vQn+3WkcKppel+Kig3s5dxI79BgAfTJOozpisOCieXNZQ4lBNWson/WuGGID1mS3EsaNcFBilpWquqI764Vy9PK1PA8k+teRX89NYsQcC2fx23cz01G5C2S6rpMpuIhHQb/7quiPALlqU4x6hdE39EgF6yBEhCFR0w2oPw==
Received: from BYAPR02CA0015.namprd02.prod.outlook.com (2603:10b6:a02:ee::28)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 20:45:36 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::8e) by BYAPR02CA0015.outlook.office365.com
 (2603:10b6:a02:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 20:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 20:45:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 13:45:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 13:45:21 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 13:45:20 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful shutdown
Date: Mon, 29 Apr 2024 16:45:19 -0400
Message-ID: <20240429204519.1618-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0836fc-b545-4684-f8d1-08dc688d523c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HaugNHiDNBWADoua3GsxnQk+dksPnz3HNJMrMiipK8ahxAdHYCc4/9Evptuv?=
 =?us-ascii?Q?6Yr5phq7/8FJK3eOIGxf3Eg6dVJgnk7ogLNeu9b1C4G4TR9Ylipkkk4Bw7Ow?=
 =?us-ascii?Q?m+W0RQ5vJfBaTa5Jpyh/2OOal4JqCYFtLpWsgqrPym4B0PwHoD+XIYdGCJqC?=
 =?us-ascii?Q?bu3XE5fd8PKTvv2zCvk1isHzZzePpjQKZkVuU149Lo8oUZu2l1lvh8PMgbYH?=
 =?us-ascii?Q?NDAuJp3X0/DNRYhYFv0Woj8zze3W09BMG58W8IvFFyvuoJyMyJTsiRJQntJD?=
 =?us-ascii?Q?IxQe7NF/d8k7tGAcYViH0VeEhK1gps0EojZZtSl4kO8kAyHl43UM5B9dsy2d?=
 =?us-ascii?Q?d1hTwoUGL9YXCr6b7bb/G6bQ1P6lhfbQV2iEASetPiuJZyKzSKT9XwlVkk2H?=
 =?us-ascii?Q?YstBlxpASfq7KOs4dBtrou6/wamtSoeOm5g8GTBGeF2/+yYeORjyViXbex56?=
 =?us-ascii?Q?QKb2TsVR2ZuAUF8z9KTu1M5cjMVpTHQdYnxE2EL7P5rC6D3XdpXgWuuXWjfE?=
 =?us-ascii?Q?ue8WbLX59HK4jQjQopuOBYTPxXOtk+3RJKzC3FHL2JB3ObsMOhc9LplFZyD9?=
 =?us-ascii?Q?LuglnxNuDeZ+8IwweV8CRMuVYgbhAxaaTtskvgmbcqnpLdYBMspEKkRosjKp?=
 =?us-ascii?Q?l0N7Tq9PsnIEso9IgaM8Z+SgHAyCk5IU88opZCIz3ynzVMjfQ1QeeKT91ZD7?=
 =?us-ascii?Q?Vm0FwMCkKBoPDO1r8uVSfGZmg0KbgKbBJUvvjyv1HklZ5o60HhFuOT9AgegT?=
 =?us-ascii?Q?R9c5+0iXuG19zOmNQOA65AjSZCtQS2BAHvr6RxRj6yoMhWicHXvKk0Y7dpFS?=
 =?us-ascii?Q?ufOOUJ0MjgZF5XmkX7axz0Gvv4sMVE6Ua1xCavdlH0Ik2CdzuqoaAp6CQ60s?=
 =?us-ascii?Q?xuBlQCr8DCl+Jv6eDzTUybkjXUroAU2Z1omxPBo+Iql+F520HnK0+ZhdwKqi?=
 =?us-ascii?Q?eZSC1aUfcJ/P5j0r/p4kPUlAEgfmwJbY52bX9O6wrGI9X4Yr/l9T3szwGWvJ?=
 =?us-ascii?Q?d9HOXVeXhlqOC1oPjpMk7b2zeIb/iVIgMio/zA2CO72uusGBwqZ08rlQX6xG?=
 =?us-ascii?Q?dLEsyJiva2c6vHVM9MxEVxsvr3a/tJDX2l3Zl9XuC6OBM81jBQel9LsynXpk?=
 =?us-ascii?Q?vAWPU6MTGNQdbqBldWRjP63CvC2nh5TS8AQmPPtEmLed6jVzNBMSVcHOYdo0?=
 =?us-ascii?Q?dqtKsCsRB22eDbUehkChGZRgEEQDGwLZIQemK/cDoLxbcyrVXjCNkv9UKpxS?=
 =?us-ascii?Q?qvuT5jqzLyG4NWseWP9wVIOeWZMpKrhSZS3FoK6jPws5AwccKTHPoVYpvgDt?=
 =?us-ascii?Q?Ho8LsDac9Ov3e9+iwNzwIBGlTQMbL+gZep4VhnES5efbhbyxm4IFSRBKZUJn?=
 =?us-ascii?Q?14wpZlg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 20:45:35.8860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0836fc-b545-4684-f8d1-08dc688d523c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

Replace the low power mode with a graceful shutdown.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/power/reset/pwr-mlxbf.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index 1775b318d0ef..4f1cd1c0018c 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -18,7 +18,6 @@
 
 struct pwr_mlxbf {
 	struct work_struct reboot_work;
-	struct work_struct shutdown_work;
 	const char *hid;
 };
 
@@ -27,22 +26,17 @@ static void pwr_mlxbf_reboot_work(struct work_struct *work)
 	acpi_bus_generate_netlink_event("button/reboot.*", "Reboot Button", 0x80, 1);
 }
 
-static void pwr_mlxbf_shutdown_work(struct work_struct *work)
-{
-	acpi_bus_generate_netlink_event("button/power.*", "Power Button", 0x80, 1);
-}
-
 static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)
 {
 	const char *rst_pwr_hid = "MLNXBF24";
-	const char *low_pwr_hid = "MLNXBF29";
+	const char *shutdown_hid = "MLNXBF29";
 	struct pwr_mlxbf *priv = ptr;
 
 	if (!strncmp(priv->hid, rst_pwr_hid, 8))
 		schedule_work(&priv->reboot_work);
 
-	if (!strncmp(priv->hid, low_pwr_hid, 8))
-		schedule_work(&priv->shutdown_work);
+	if (!strncmp(priv->hid, shutdown_hid, 8))
+		orderly_poweroff(true);
 
 	return IRQ_HANDLED;
 }
@@ -70,10 +64,6 @@ static int pwr_mlxbf_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Error getting %s irq.\n", priv->hid);
 
-	err = devm_work_autocancel(dev, &priv->shutdown_work, pwr_mlxbf_shutdown_work);
-	if (err)
-		return err;
-
 	err = devm_work_autocancel(dev, &priv->reboot_work, pwr_mlxbf_reboot_work);
 	if (err)
 		return err;
-- 
2.30.1


