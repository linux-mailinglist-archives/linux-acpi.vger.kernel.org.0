Return-Path: <linux-acpi+bounces-1103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EA7DC13B
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 21:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB32728131F
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D31C286
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KbL4DL9L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF01CF9F
	for <linux-acpi@vger.kernel.org>; Mon, 30 Oct 2023 20:31:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465CF7;
	Mon, 30 Oct 2023 13:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4xmO0ERQNKwFNz9rTLss37McpfMhIJBPjAezWCbY6uTiR2hUeK7U+qZDPsyZ0VPm5dCqZJb5utgTuMedjizm2Q6+eySV3FeGzErlTZuF/slCG+vak8IBhPeSk90pzPvSamGuWfqj3FomipuMr7g4u6IS58OtPDJSZEBfGmOtvGh+hrqklbJ3I5ADJ4KVrSKMPznRt6SW1r/gStRNk+uifK1qzcg5ZVioDJjytyBH+WuXWD+j6oo5bUiF2igdZCG8yqTUEjlhUcdQzNQSXTcQrzFfd9c1/4h9oTKkVIWV/5A8MmvySZuuecwbSRx0ldx/AvrVhvEHyrQWtJjQQrh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP3EL+M4hgF5eTaEklAuYHcg03jh8G8NmSEpWJDCPMI=;
 b=kVJfxDWUXpB9NBAHhHzaWiAeQOZAc50QYZ4sIgQRgB/tjEuGt6EuCLMtpQWWMxwpyHpDFbP8U0+vi7CPmnN1X8GfMUFNoAwBaLGjiTUM3Q3BgULPGytA2/VmnGjXQFshisuB9RMBKZBm45eUh+bE4+VEqvpLJ8i+u78YwH+Ev65DIY3w4ADriCdbHf2Ca7/d39wxc3NeROkrX7xg4GnxdGGkUNFC+KQUSk3U8kcnZ7zGAG7bVRLhHlhadHdRmCw/ev0UhSFeH87mViwBPnTVlFBK8sijKGGGvHV1FXXTFCIHygXACWjjYGaTD6eY7N/dbAB6LtPcGBT0Cvq/Sekpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP3EL+M4hgF5eTaEklAuYHcg03jh8G8NmSEpWJDCPMI=;
 b=KbL4DL9LUs0V45vkJJu3fNbwVCuprqcKOiTuXoomkeQcCldSW5eQPtWakXgsKgcAU0725yzWEquBLnvcVh/leaM2mWplIRrmbjF5AnlCU8dtGijBEZYr5MfFTxAqhiemBmmLeaIFdesss38RDKUmFu8h3SsbOLjxu06mF337Om/iSYMZlWifToECh6WsYvYMHYcA8wZNNiO3RixzUaWy41hvYCeWUObie4RcLNxcW2t7nOR4ayCWUUgnc5Um1lR+/cYqlEQHqyovwXbTJ7ONaWMv1RcyB76YfOo2c2phfdEZBtXgeb+QW54qDAk5Uu6PDVcG1W+lCZHKtftt4PZ7BA==
Received: from CYZPR14CA0003.namprd14.prod.outlook.com (2603:10b6:930:8f::16)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 20:31:10 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::51) by CYZPR14CA0003.outlook.office365.com
 (2603:10b6:930:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 20:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 20:31:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 13:31:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 13:31:00 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Mon, 30 Oct
 2023 13:31:00 -0700
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
CC: Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/1] power: reset: pwr-mlxbf: support graceful reboot instead of emergency reset
Date: Mon, 30 Oct 2023 16:30:58 -0400
Message-ID: <20231030203058.8056-1-asmaa@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f707b9-3903-481c-caf8-08dbd98726cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rTqdfmlxaMe2otod8hY7RpL7TRmnFgljYFCL4URI/wlSR7XkffAq/5i3P8zcHmf2+eQ/n/sgT/DXghS/wLH60yJuPxMw/0Dyrr3Ubz501n5XDiaUePOSsUyWuCU3lrgs/kjzu/qlYyBRsXIE/6pOIGmNHJ+XpkdT1hEtMNwhRh0d93Y1DQzfyfwg0N6z6fw2EkeRbzwyz/91mq9iWsZgYecd1goc56AepY7xtN2I6HQ61hp7ihot2fGO9qhO/R0oPnBIj0/OAABhWnITIj5iXa/aEyUDuFDnbhRdSSppo0mMl9FB7fpXHT1ePZFnuRxdUD5sxXdKNb+fC8URWm/L8K1gymsOD95ET9RgHXQrXTqvuvYWAomL5XlvADX+dzaHQFho9TaMuuOe0IFqHwbFFgPbZriWrn8rM+u7ngiVyQhxzlENBrwcQYos2PKGPXUgoeFdKPYK48miZytVRnXvxHvxGjFYKYy9P57/JZxHqqILOxbf2Kwvsj7G+F6aD02yipncduXmQxZjyDzO8eBgTJEtgw6xJB8v7q/tybEUcQX4Yu/Qr2W4Z2dNxTmMMZvv4HMtqENLUwcXuOwS0FJnkF5xB3QnMbKB/HIGowMyy+6Nb7thgkvaAWKYFXLyuDE13iLsUT3l6P9TUjwwlXwLCrm2+xCnDuBXJ+IiTrc5tWrgeUlQzbSLywQoP5jBQ7V114Xxm/GUM/ZKJpPl9ai5VVCrsx1p5yh5uRohY5KINik=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(83380400001)(478600001)(7696005)(36860700001)(36756003)(86362001)(7636003)(356005)(82740400003)(5660300002)(41300700001)(26005)(47076005)(336012)(2906002)(426003)(107886003)(2616005)(1076003)(70586007)(110136005)(70206006)(8676002)(8936002)(316002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 20:31:09.6353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f707b9-3903-481c-caf8-08dbd98726cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

Replace the soft reset with a graceful reboot.
An acpi event will be triggered by the irq in the pwr-mlxbf.c
to trigger the graceful reboot.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/power/reset/pwr-mlxbf.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index de35d24bb7ef..1775b318d0ef 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -17,11 +17,17 @@
 #include <linux/types.h>
 
 struct pwr_mlxbf {
-	struct work_struct send_work;
+	struct work_struct reboot_work;
+	struct work_struct shutdown_work;
 	const char *hid;
 };
 
-static void pwr_mlxbf_send_work(struct work_struct *work)
+static void pwr_mlxbf_reboot_work(struct work_struct *work)
+{
+	acpi_bus_generate_netlink_event("button/reboot.*", "Reboot Button", 0x80, 1);
+}
+
+static void pwr_mlxbf_shutdown_work(struct work_struct *work)
 {
 	acpi_bus_generate_netlink_event("button/power.*", "Power Button", 0x80, 1);
 }
@@ -33,10 +39,10 @@ static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)
 	struct pwr_mlxbf *priv = ptr;
 
 	if (!strncmp(priv->hid, rst_pwr_hid, 8))
-		emergency_restart();
+		schedule_work(&priv->reboot_work);
 
 	if (!strncmp(priv->hid, low_pwr_hid, 8))
-		schedule_work(&priv->send_work);
+		schedule_work(&priv->shutdown_work);
 
 	return IRQ_HANDLED;
 }
@@ -64,7 +70,11 @@ static int pwr_mlxbf_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Error getting %s irq.\n", priv->hid);
 
-	err = devm_work_autocancel(dev, &priv->send_work, pwr_mlxbf_send_work);
+	err = devm_work_autocancel(dev, &priv->shutdown_work, pwr_mlxbf_shutdown_work);
+	if (err)
+		return err;
+
+	err = devm_work_autocancel(dev, &priv->reboot_work, pwr_mlxbf_reboot_work);
 	if (err)
 		return err;
 
-- 
2.30.1


