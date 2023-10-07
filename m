Return-Path: <linux-acpi+bounces-505-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6DE7BC615
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4ED28218C
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816A168BD
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Oct 2023 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UVZioiXn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A611C82
	for <linux-acpi@vger.kernel.org>; Sat,  7 Oct 2023 07:55:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678CCA
	for <linux-acpi@vger.kernel.org>; Sat,  7 Oct 2023 00:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv50VNBltoWMcSbDhT1mpcJEL53onkx1jyXvdf7RExHjrhUkDsb9LDJwJJxwK+hAFaEVl8vz7UNufAAEDVhoyIrp1gORDDGO59UIOyvTxdy4FQ+I+8PLmaeN0KEqVxme/Prz6j4ZeHDSqsa0XtxCBoHxeHIAlcbO8OWrpNGQX7p/RvbF5/pHXgXsJbJgeoSGwjsdDyzxX+kNYCwvt9xOt3218t53ad9JwsiBrBPpE5vSs0NiiYOsytNgLA60Z8uDLWqDya/iTm/GKAkPGZdfeGDlfUr9ZWSNyfQwwsVxaKylRE/Kl68kql4UpOch61tqiytqvCmsWtKOSrRTiLrfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kma6cLhT9RtYJiMiV4vkYOEApFbOhlSamhWoyRsxbQ=;
 b=XAWoA879dF0csszLImZ1IqTfqpciQ/bH5/eYUrsuZ7X+MYalAmkAhkC6fIEmXoUCLCIDzRCwEVPWbNaiNxjEZopq3iGFqIVaP6ItQ9usep/sI2XWKLAGJeH5z6+3ypW/cw8mxuu6oCuWOrM5hQKHB1EMOyCvF5t+CSCz81GapQ9O56D9rqHNcCEIHdig5rwvf66hypUTdq1aP1wRuiXNUz85J9eKSVITQyD2aCslhJUiQfl6eZRnLn+aO3LFlcNI35oitThlZELbCHJnTc9mzkysgg6dx+KCTVGezXDyuxHMiS09eFleBcQBJztdJrO/5O0C2TT7t2gaQulR3MYNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kma6cLhT9RtYJiMiV4vkYOEApFbOhlSamhWoyRsxbQ=;
 b=UVZioiXnVl0k7NvFkgojPMi199H9Kj7c+7oxdOJPD2IoAUCx7WkS7FGMTNUdvWL00f1HTc27+90IDE61i5M4tnk8Pd7Lh8VlDWC1jTx7TRmCgo0263dZQgOjyQvgFC0MEFywg1xCDB3NcAznoCPl9EGA8VEbBPvE/zbn0fTI0yE=
Received: from SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::12)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Sat, 7 Oct
 2023 07:55:32 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::d8) by SA1P222CA0124.outlook.office365.com
 (2603:10b6:806:3c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.34 via Frontend
 Transport; Sat, 7 Oct 2023 07:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 07:55:32 +0000
Received: from nv14-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 7 Oct
 2023 02:55:30 -0500
From: Ken Xue <Ken.Xue@amd.com>
To: <andriy.shevchenko@linux.intel.com>, <linux-acpi@vger.kernel.org>
CC: <rafael@kernel.org>, <cwhuang@linux.org.tw>, Ken Xue <Ken.Xue@amd.com>
Subject: [PATCH V5] acpi: trigger wakeup key event from power button
Date: Sat, 7 Oct 2023 15:54:34 +0800
Message-ID: <20231007075433.555715-1-Ken.Xue@amd.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa7a7ab-043d-433e-3563-08dbc70ac7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ThSpb5f06pSQxov/wYLOha5THDJQIu4RDVwWPDAw73Ua7AoNiiHgpF3hDx1Vdyjvh4P9QvGxGfRtCUl3HDmPjVTm0vzSeeLW1RZJYywoa5zYVWV243kjYsj+bVtdj5uDJzOG2tpryLJ5iRdnFaZ+rjQDuZWmGzwK2b3kLrGGnYkVCn83CVbR6YlrJaVze/1PJ9ApR/Uzf5+Q9m6nNUIRQ7571VS1Ium7B2vdSrt950mT9udpYOXLqbFJqr4qkv7HEPEAoVbtzagCPwXMrZxFe1uAm3cfWt8NaZbT6OPetb0UN8ILxnLrANsL7zAdHtksqK7Zje2k2+eIJKsGR3Zgjv/F2nASm4F36LOxqcIMki4Z6vPhZATaP5Q4Motxfh5zfFHHM6tH+zYMZsiAo/hVQPh6nOJWxzb7UQM8NuN77gutt/mUy+yHzOvbyNj7+Uf6dXs8Rk1Jecxyz7bLQLUpmoCTI06NIGJx3r0zOIv+2pE0PVWWw3xlyg1Ay+15BvUOS7gYJrCUd75wSbNuS0gIHCsoALQnJwDb6gIvxIXYbA5jfKQBxboMBIZa3JrQE2GbvM+XwPJuMyj+pyIHNcn6KihGhwESPhEb5N2K7JdWR9iSoNNIV+g+9boJSvPZHfeBNnOfWen+zAH9s3lfLmLY65t+pzx4yByU8/4X2Wyt6ixi5oIkhizDphb1T3K6O0xHJr3fiy0kvKGt/9Y9Oo2iiPaBqExea9qaODeUcSMi++UJ5Sr0KuyhkbUzsRCBRIfzvesC5GUrmdpqfetBQfA1fQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(83380400001)(40460700003)(86362001)(82740400003)(336012)(54906003)(2906002)(8936002)(4326008)(47076005)(8676002)(5660300002)(16526019)(2616005)(316002)(41300700001)(110136005)(36860700001)(26005)(356005)(70586007)(81166007)(478600001)(1076003)(966005)(426003)(70206006)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 07:55:32.0440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa7a7ab-043d-433e-3563-08dbc70ac7f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andorid can wakeup from various wakeup sources, but only several wakeup
sources can wake up screen with right events(POWER, WAKEUP) from input
device.

Regarding pressing acpi power button, it can resume system and
ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS are set in
pm1a_sts, but kernel does not report any key event to user space during
resuming by default.

So, send wakeup key event to user space during resume from power button.

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
V1->V2: fix some compile warning/error caused by lack of
        "struct acpi_device" declaration by including acpi.h.
V2->V3: use "forward declaration" to fix compile warning/error.
V3->V4: refine coding style and commit message
V4->V5: add "select ACPI_BUTTON" to fix build error if CONFIG_ACPI_BUTTON=m. https://lore.kernel.org/oe-kbuild-all/202309150947.YLjvs2Vv-lkp@intel.com/
---
 drivers/acpi/Kconfig  |  1 +
 drivers/acpi/button.c | 17 +++++++++++++++++
 drivers/acpi/sleep.c  |  5 +++++
 include/acpi/button.h |  4 ++++
 4 files changed, 27 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 00dd309b6682..001da6233fcd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -53,6 +53,7 @@ config ACPI_GENERIC_GSI
 
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
 	bool
+	select ACPI_BUTTON
 
 config ACPI_CCA_REQUIRED
 	bool
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1e76a64cce0a..3baddecd66c6 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -363,6 +363,22 @@ static int acpi_button_remove_fs(struct acpi_device *device)
 	return 0;
 }
 
+void acpi_power_button_wakeup(struct acpi_device *dev)
+{
+	struct acpi_button *button = acpi_driver_data(dev);
+	struct input_dev *input;
+
+	if (button->type != ACPI_BUTTON_TYPE_POWER)
+		return;
+
+	input = button->input;
+	input_report_key(input, KEY_WAKEUP, 1);
+	input_sync(input);
+	input_report_key(input, KEY_WAKEUP, 0);
+	input_sync(input);
+}
+EXPORT_SYMBOL(acpi_power_button_wakeup);
+
 /* Driver Interface */
 int acpi_lid_open(void)
 {
@@ -579,6 +595,7 @@ static int acpi_button_add(struct acpi_device *device)
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
 		input_set_capability(input, EV_KEY, KEY_POWER);
+		input_set_capability(input, EV_KEY, KEY_WAKEUP);
 		break;
 
 	case ACPI_BUTTON_TYPE_SLEEP:
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 808484d11209..f816606abd71 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -20,9 +20,13 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/syscore_ops.h>
+
 #include <asm/io.h>
+
 #include <trace/events/power.h>
 
+#include <acpi/button.h>
+
 #include "internal.h"
 #include "sleep.h"
 
@@ -507,6 +511,7 @@ static void acpi_pm_finish(void)
 	pwr_btn_adev = acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POWERF,
 						    NULL, -1);
 	if (pwr_btn_adev) {
+		acpi_power_button_wakeup(pwr_btn_adev);
 		pm_wakeup_event(&pwr_btn_adev->dev, 0);
 		acpi_dev_put(pwr_btn_adev);
 	}
diff --git a/include/acpi/button.h b/include/acpi/button.h
index af2fce5d2ee3..6126d665aa42 100644
--- a/include/acpi/button.h
+++ b/include/acpi/button.h
@@ -2,17 +2,21 @@
 #ifndef ACPI_BUTTON_H
 #define ACPI_BUTTON_H
 
+struct acpi_device;
+
 #define ACPI_BUTTON_HID_POWER	"PNP0C0C"
 #define ACPI_BUTTON_HID_LID	"PNP0C0D"
 #define ACPI_BUTTON_HID_SLEEP	"PNP0C0E"
 
 #if IS_ENABLED(CONFIG_ACPI_BUTTON)
 extern int acpi_lid_open(void);
+extern void acpi_power_button_wakeup(struct acpi_device *dev);
 #else
 static inline int acpi_lid_open(void)
 {
 	return 1;
 }
+static inline void acpi_power_button_wakeup(struct acpi_device *dev) {}
 #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
 
 #endif /* ACPI_BUTTON_H */

base-commit: b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4
-- 
2.35.1


