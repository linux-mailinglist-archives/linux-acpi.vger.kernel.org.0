Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E3737AD7
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jun 2023 07:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjFUFtd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Jun 2023 01:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjFUFs4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Jun 2023 01:48:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE06D199C;
        Tue, 20 Jun 2023 22:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y49PodKg7nLQvN8dcqf2cIxaew9fa+xCc7r8lnRahWOWyPj6SPgcnCvio2GyYxZp2fJV/4gzyZHZXZkqwT25ENNLj3K+D5bKbj2uxMuQBWQMa+X0qrXP84B4Woig1Afs5Gbf37LksSXA4pa+ILFfSv2Iysde5VXuJvUwDMnQatx0Fw4HgNtUlAhiYFARcvjpx9xIlNwXOXGnkiZrFRhS02rRTfHY2Ov5VIGBQx88gyk5hmZojDKmcTk3QeDc06jfq3GnxP82AGjxCUknz2lLNgNyLc6mrpQCQKeGdY4ZODNj7OJLdIEh+c6YsLuyFIXuFBSF4i/gHW0jpsj9x2l9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nm1/EACQ0Cz0UaQDUiGBDbeq90RNCji/7UFQqCNggbw=;
 b=RCWSLqJpUyhftXInDTgR4uyq/l5pPYR3qCnaosCMF0oKL2x+006KoaMKz0GjsoWk1LQzI7+zNQ72Zs6wn7/ZExZi/0aKdd6UwCtnRZ7olmv1R4yypQKDgGsu/o/2rDyGxNuZBbeESPG9okiSfilMYtbHBbOG3GL6MH2WsKOpn38ujJ17zTp+I/SaYTp0vgE+FpB2sFXo/FgnyTvln+SadaCikxI4eOTw9JHce3gDqBtZngaBXd1cP0HJjPREh7BdjEsbeh5yGAaKf9wKom0tpYr/Ypwy0kY+sWsyhycJtFQCqRhe/9xu7oBHcmKtyM4nI9F58ncO1F5iIEvvdn5xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm1/EACQ0Cz0UaQDUiGBDbeq90RNCji/7UFQqCNggbw=;
 b=DPijEggO4UA12oBz+TkzQSjgkVxbYSBWFKYGiiHcWR9Cm94mP413YkzpMoFRu2T7+Qxuf7aiGS9lpFI78vqO0iZAWX/JQ2/zrChJrC8Uk3X5prnVJs8bxinc0D/OFZuWiIYtMav5mPM9tdT9MP3EVgy9npvCAR09EpcOp7AV2Ms=
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 05:48:42 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::95) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 05:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Wed, 21 Jun 2023 05:48:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 00:48:32 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <mario.limonciello@amd.com>, <mdaenzer@redhat.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <hdegoede@redhat.com>, <jingyuwang_vip@163.com>,
        <lijo.lazar@amd.com>, <jim.cromie@gmail.com>,
        <bellosilicio@gmail.com>, <andrealmeid@igalia.com>,
        <trix@redhat.com>, <jsg@jsg.id.au>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>
Subject: [PATCH V4 5/8] drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
Date:   Wed, 21 Jun 2023 13:46:00 +0800
Message-ID: <20230621054603.1262299-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621054603.1262299-1-evan.quan@amd.com>
References: <20230621054603.1262299-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 11440857-9ad1-4db4-ea8d-08db721b2b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+CoBxKauZKkbcwx4sPhq/XIc/KCL6mIayJpxym6PPlD/9rHak6cN4AijG0Gn4uFiA+g74kAZhw2gEz1fIqzmhDECl/YkXZq6Nz7JiiocAOCnJL2wrr8GFcM/XrHso8G1EgWQ5WgcDdCXFmrm463fBc6g/Fcnq1lkqGBvIBvpHlu3N8ReXBZnL4h6jfpYPgKZsBVSIshgjxIBpNy56VGWnemzecu4Kfn4AbcbfJm73b4mGWdNiQoOH/TxuZMW5bdmaIcWWyzVnlR+k33YQhVucz6FColCirkxFv4g4RItTK1ExQbZccDVCSq5e6vO3Vz84yAyrcmD71NbAkpCsxbYxdTgiGCVRC/7DI4q/84xWrcMn4FfR0UvFeIGL6rjAj9KIaj0B21zhbQyYkYg6wuJsKeGDjsxvFATd2jNjLI2w+XiPr9ZDNn0bPNn7YbEml8QAhocWBtCjMnKmerromrtQkvmFouXHJ0C0349Wj1dhL+eRjKTvydVxDCNVJsXNLhtyE8D/tkANGnoY6Fo8rgYSp9aABtPt3svd5B9ycZk9gHgG4AxD/0HdwDYex0JOUUsGBHYN4+sb/RjSwkGkp+Y9IY7CW8Y1giM0/a0EoliQ1mzJl8bMJicr08f+maVT853VNc1qk2pHIjAnkPLz6A73t2haF/rmvau5y5u7DqtcWFHAYV86+rOBDBKSfjVcWVVjoqzmpJxnZJ2BC89xgeFgpfmqBZoHkicZX/ZoWS+wQ4Dwu1riEXmY2XmDkjCpD4cb2qAKiHLvKGnVpsyc5QBK9VOI14cZiCScsuYJXP/SbW9c8N0GRDPa/MzbFaoXqpoTYI78PEI8RkQrbvTJaxsCPEj4B7Z6mWSWvyplZ/K7zgZBzN562V1+DN7FppSsjY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(6666004)(7696005)(82310400005)(83380400001)(356005)(921005)(81166007)(40480700001)(26005)(186003)(1076003)(16526019)(426003)(2616005)(47076005)(336012)(36860700001)(40460700003)(36756003)(30864003)(70586007)(70206006)(316002)(4326008)(2906002)(8936002)(8676002)(7416002)(44832011)(86362001)(5660300002)(41300700001)(54906003)(110136005)(82740400003)(478600001)(36900700001)(2101003)(83996005)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 05:48:41.6494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11440857-9ad1-4db4-ea8d-08db721b2b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With WBRF feature supported, as a driver responding to the frequencies,
amdgpu driver is able to do shadow pstate switching to mitigate possible
interference(between its (G-)DDR memory clocks and local radio module
frequency bands used by Wifi 6/6e/7).

To make WBRF feature functional, the kernel needs to be configured with
CONFIG_ACPI_WBRF and the platform is equipped with necessary ACPI based
mechanism to get amdgpu driver notified.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
--
v1->v2:
  - update the prompt for feature support(Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  26 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  63 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  19 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 184 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  20 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 6 files changed, 315 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 02b827785e39..2f2ec64ed1b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -50,6 +50,7 @@
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
 #include <linux/pci.h>
+#include <linux/wbrf.h>
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_placement.h>
@@ -241,6 +242,7 @@ extern int amdgpu_num_kcq;
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
+extern int amdgpu_wbrf;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
@@ -741,6 +743,9 @@ struct amdgpu_reset_domain;
  */
 #define AMDGPU_HAS_VRAM(_adev) ((_adev)->gmc.real_vram_size)
 
+typedef
+void (*wbrf_notify_handler) (struct amdgpu_device *adev);
+
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -1050,6 +1055,8 @@ struct amdgpu_device {
 
 	bool                            job_hang;
 	bool                            dc_enabled;
+
+	wbrf_notify_handler		wbrf_event_handler;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
@@ -1381,6 +1388,25 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 						 enum amdgpu_ss ss_state) { return 0; }
 #endif
 
+#if defined(CONFIG_ACPI_WBRF)
+bool amdgpu_acpi_is_wbrf_supported(struct amdgpu_device *adev);
+int amdgpu_acpi_wbrf_retrieve_exclusions(struct amdgpu_device *adev,
+					 struct wbrf_ranges_out *exclusions_out);
+int amdgpu_acpi_register_wbrf_notify_handler(struct amdgpu_device *adev,
+					     wbrf_notify_handler handler);
+int amdgpu_acpi_unregister_wbrf_notify_handler(struct amdgpu_device *adev);
+#else
+static inline bool amdgpu_acpi_is_wbrf_supported(struct amdgpu_device *adev) { return false; }
+static inline
+int amdgpu_acpi_wbrf_retrieve_exclusions(struct amdgpu_device *adev,
+					 struct wbrf_ranges_out *exclusions_out) { return 0; }
+static inline
+int amdgpu_acpi_register_wbrf_notify_handler(struct amdgpu_device *adev,
+					     wbrf_notify_handler handler) { return 0; }
+static inline
+int amdgpu_acpi_unregister_wbrf_notify_handler(struct amdgpu_device *adev) { return 0; }
+#endif
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index aeeec211861c..efbe6dd91d1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1105,3 +1105,66 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 }
 
 #endif /* CONFIG_SUSPEND */
+
+#ifdef CONFIG_ACPI_WBRF
+bool amdgpu_acpi_is_wbrf_supported(struct amdgpu_device *adev)
+{
+	struct acpi_device *acpi_dev = ACPI_COMPANION(adev->dev);
+
+	if (!acpi_dev)
+		return false;
+
+	return wbrf_supported_consumer(acpi_dev);
+}
+
+int amdgpu_acpi_wbrf_retrieve_exclusions(struct amdgpu_device *adev,
+					 struct wbrf_ranges_out *exclusions_out)
+{
+	struct acpi_device *acpi_dev = ACPI_COMPANION(adev->dev);
+
+	if (!acpi_dev)
+		return -ENODEV;
+
+	return wbrf_retrieve_exclusions(acpi_dev, exclusions_out);
+}
+
+#define CPM_GPU_NOTIFY_COMMAND		0x55
+static void amdgpu_acpi_wbrf_event(acpi_handle handle, u32 event, void *data)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+
+	if (event == CPM_GPU_NOTIFY_COMMAND &&
+	    adev->wbrf_event_handler)
+		adev->wbrf_event_handler(adev);
+}
+
+int amdgpu_acpi_register_wbrf_notify_handler(struct amdgpu_device *adev,
+					     wbrf_notify_handler handler)
+{
+	struct acpi_handle *acpi_hdler = ACPI_HANDLE(adev->dev);
+
+	if (!acpi_hdler)
+		return -ENODEV;
+
+	adev->wbrf_event_handler = handler;
+
+	return acpi_install_notify_handler(acpi_hdler,
+					   ACPI_ALL_NOTIFY,
+					   amdgpu_acpi_wbrf_event,
+					   adev);
+}
+
+int amdgpu_acpi_unregister_wbrf_notify_handler(struct amdgpu_device *adev)
+{
+	struct acpi_handle *acpi_hdler = ACPI_HANDLE(adev->dev);
+
+	if (!acpi_hdler)
+		return -ENODEV;
+
+	adev->wbrf_event_handler = NULL;
+
+	return acpi_remove_notify_handler(acpi_hdler,
+					  ACPI_ALL_NOTIFY,
+					  amdgpu_acpi_wbrf_event);
+}
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b1ca1ab6d6ad..bf82cc192153 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -191,6 +191,7 @@ int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
+int amdgpu_wbrf = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -948,6 +949,24 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+#ifdef CONFIG_ACPI_WBRF
+/**
+ * DOC: wbrf (int)
+ * Enable Wifi RFI interference mitigation feature.
+ * Due to electrical and mechanical constraints there may be likely interference of
+ * relatively high-powered harmonics of the (G-)DDR memory clocks with local radio
+ * module frequency bands used by Wifi 6/6e/7. To mitigate the possible RFI interference,
+ * with this feature enabled, PMFW will use either “shadowed P-State” or “P-State” based
+ * on active list of frequencies in-use (to be avoided) as part of initial setting or
+ * P-state transition. However, there may be potential performance impact with this
+ * feature enabled.
+ * (0 = disabled, 1 = enabled, -1 = auto (default setting, will be enabled if supported))
+ */
+MODULE_PARM_DESC(wbrf,
+	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
+module_param_named(wbrf, amdgpu_wbrf, int, 0444);
+#endif
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2ddf5198e5c4..a8efdce4607c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1188,6 +1188,163 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_wbrf_handle_exclusion_ranges - consume the wbrf exclusion ranges
+ *
+ * @smu: smu_context pointer
+ *
+ * Retrieve the wbrf exclusion ranges and send them to PMFW for proper handling.
+ * Returns 0 on success, error on failure.
+ */
+static int smu_wbrf_handle_exclusion_ranges(struct smu_context *smu)
+{
+	struct wbrf_ranges_out wbrf_exclusion = {0};
+	struct exclusion_range *wifi_bands = wbrf_exclusion.band_list;
+	struct amdgpu_device *adev = smu->adev;
+	uint64_t start, end;
+	int ret, i, j;
+
+	ret = amdgpu_acpi_wbrf_retrieve_exclusions(adev, &wbrf_exclusion);
+	if (ret) {
+		dev_err(adev->dev, "Failed to retrieve exclusion ranges!\n");
+		return ret;
+	}
+
+	/*
+	 * The exclusion ranges array we got might be filled with holes and duplicate
+	 * entries. For example:
+	 * {(2400, 2500), (0, 0), (6882, 6962), (2400, 2500), (0, 0), (6117, 6189), (0, 0)...}
+	 * We need to do some sortups to eliminate those holes and duplicate entries.
+	 * Expected output: {(2400, 2500), (6117, 6189), (6882, 6962), (0, 0)...}
+	 */
+	for (i = 0; i < MAX_NUM_OF_WBRF_RANGES; i++) {
+		start = wifi_bands[i].start;
+		end = wifi_bands[i].end;
+
+		/* get the last valid entry to fill the intermediate hole */
+		if (!start && !end) {
+			for (j = MAX_NUM_OF_WBRF_RANGES - 1; j > i; j--)
+				if (wifi_bands[j].start &&
+				    wifi_bands[j].end)
+					break;
+
+			if (j > i) {
+				wifi_bands[i].start = wifi_bands[j].start;
+				wifi_bands[i].end = wifi_bands[j].end;
+				wifi_bands[j].start = 0;
+				wifi_bands[j].end = 0;
+			}
+
+			continue;
+		}
+
+		/* eliminate duplicate entries */
+		for (j = i + 1; j < MAX_NUM_OF_WBRF_RANGES; j++) {
+			if ((wifi_bands[j].start == start) &&
+			     (wifi_bands[j].end == end)) {
+				wifi_bands[j].start = 0;
+				wifi_bands[j].end = 0;
+				continue;
+			}
+		}
+	}
+
+	/* Send the sorted wifi_bands to PMFW */
+	ret = smu_set_wbrf_exclusion_ranges(smu, wifi_bands);
+	/* Give it another chance */
+	if (unlikely(ret == -EBUSY)) {
+		mdelay(5);
+		ret = smu_set_wbrf_exclusion_ranges(smu, wifi_bands);
+	}
+
+	return ret;
+}
+
+/**
+ * smu_wbrf_event_handler - handle notify events
+ *
+ * @adev: struct amdgpu_device pointer
+ *
+ * Calls relevant amdgpu function in response to wbrf event
+ * notification from BIOS.
+ */
+static void smu_wbrf_event_handler(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev->powerplay.pp_handle;
+
+	smu_wbrf_handle_exclusion_ranges(smu);
+}
+
+/**
+ * smu_wbrf_support_check - check wbrf support
+ *
+ * @smu: smu_context pointer
+ *
+ * Verifies the ACPI interface whether wbrf is supported.
+ */
+static void smu_wbrf_support_check(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	smu->wbrf_supported = smu_is_asic_wbrf_supported(smu) &&
+			      !!amdgpu_wbrf &&
+			      amdgpu_acpi_is_wbrf_supported(adev);
+
+	if (smu->wbrf_supported)
+		dev_info(adev->dev, "RF interference mitigation is supported\n");
+}
+
+/**
+ * smu_wbrf_init - init driver wbrf support
+ *
+ * @smu: smu_context pointer
+ *
+ * Verifies the AMD ACPI interfaces and registers with the wbrf
+ * notifier chain if wbrf feature is supported.
+ * Returns 0 on success, error on failure.
+ */
+static int smu_wbrf_init(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret;
+
+	if (!smu->wbrf_supported)
+		return 0;
+
+	ret = amdgpu_acpi_register_wbrf_notify_handler(adev,
+						       smu_wbrf_event_handler);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some wifiband exclusion ranges may be already there
+	 * before our driver loaded. To make sure our driver
+	 * is awared of those exclusion ranges.
+	 */
+	ret = smu_wbrf_handle_exclusion_ranges(smu);
+	if (ret)
+		dev_err(adev->dev, "Failed to handle wbrf exclusion ranges\n");
+
+	return ret;
+}
+
+/**
+ * smu_wbrf_fini - tear down driver wbrf support
+ *
+ * @smu: smu_context pointer
+ *
+ * Unregisters with the wbrf notifier chain.
+ */
+static void smu_wbrf_fini(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!smu->wbrf_supported)
+		return;
+
+	amdgpu_acpi_unregister_wbrf_notify_handler(adev);
+}
+
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
@@ -1280,6 +1437,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	/* Enable UclkShadow on wbrf supported */
+	if (smu->wbrf_supported) {
+		ret = smu_enable_uclk_shadow(smu, true);
+		if (ret) {
+			dev_err(adev->dev, "Failed to enable UclkShadow feature to support wbrf!\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * With SCPM enabled, these actions(and relevant messages) are
 	 * not needed and permitted.
@@ -1376,6 +1542,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 */
 	ret = smu_set_min_dcef_deep_sleep(smu,
 					  smu->smu_table.boot_values.dcefclk / 100);
+	if (ret) {
+		dev_err(adev->dev, "Error setting min deepsleep dcefclk\n");
+		return ret;
+	}
+
+	/* Init wbrf support. Properly setup the notifier */
+	ret = smu_wbrf_init(smu);
+	if (ret)
+		dev_err(adev->dev, "Error during wbrf init call\n");
 
 	return ret;
 }
@@ -1431,6 +1606,13 @@ static int smu_hw_init(void *handle)
 		return ret;
 	}
 
+	/*
+	 * Check whether wbrf is supported. This needs to be done
+	 * before SMU setup starts since part of SMU configuration
+	 * relies on this.
+	 */
+	smu_wbrf_support_check(smu);
+
 	if (smu->is_apu) {
 		ret = smu_set_gfx_imu_enable(smu);
 		if (ret)
@@ -1583,6 +1765,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	smu_wbrf_fini(smu);
+
 	cancel_work_sync(&smu->throttling_logging_work);
 	cancel_work_sync(&smu->interrupt_work);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 09469c750a96..ff0af3da0be2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -573,6 +573,9 @@ struct smu_context
 	u32 debug_param_reg;
 	u32 debug_msg_reg;
 	u32 debug_resp_reg;
+
+	/* data structures for wbrf feature support */
+	bool				wbrf_supported;
 };
 
 struct i2c_adapter;
@@ -1354,6 +1357,23 @@ struct pptable_funcs {
 	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
 	 */
 	int (*init_pptable_microcode)(struct smu_context *smu);
+
+	/**
+	 * @is_asic_wbrf_supported: check whether PMFW supports the wbrf feature
+	 */
+	bool (*is_asic_wbrf_supported)(struct smu_context *smu);
+
+	/**
+	 * @enable_uclk_shadow: Enable the uclk shadow feature on wbrf supported
+	 */
+	int (*enable_uclk_shadow)(struct smu_context *smu,
+				  bool enablement);
+
+	/**
+	 * @set_wbrf_exclusion_ranges: notify SMU the wifi bands occupied
+	 */
+	int (*set_wbrf_exclusion_ranges)(struct smu_context *smu,
+					 struct exclusion_range *exclusion_ranges);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index ceb13c838067..67d7495ab49e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -97,6 +97,9 @@
 #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
 #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
 #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
+#define smu_is_asic_wbrf_supported(smu)					smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
+#define smu_enable_uclk_shadow(smu, enablement)				smu_ppt_funcs(enable_uclk_shadow, 0, smu, enablement)
+#define smu_set_wbrf_exclusion_ranges(smu, exclusion_ranges)		smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, exclusion_ranges)
 
 #endif
 #endif
-- 
2.34.1

