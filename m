Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234907771A7
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Aug 2023 09:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHJHlw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Aug 2023 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjHJHls (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2023 03:41:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510810FF;
        Thu, 10 Aug 2023 00:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XY0ZRJkwGPUz8gnWLkpoHmYzep7Rzj2nHD+ijKE0FuffQ3jUbUX35l2UuwBwBGHruGYw32NzREhWgKfPAImRPfEdnGvYpNUMv186a8nqMg/Ub5u0mNCotp7yysk5xyqS6bxHTTjCeaAZoZDf4MteFL+odLDRq/TUey3L2Yz33ctd/AoaY1Yk31YxHjevgTbXBgIQWAXwrGL3P8byOy6UtpLM6K9+IbkM+G+qYtZDXxRefcKbrYqgB/mmAkjSvW5UXUmc4jrnU2V5G9LcuEUw5A0Zy8YkJDj9rIHZXipb61Kt5OyCGIxbe+NxLyer0Wmmnndd9ulTf3Pf/w+VEkINlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICfFFCripL2P4ocC0bWkvw3oRf/7mOzyprGso847CcI=;
 b=C81a/DM26WMN+wz9lik08J9gK1NuXWAU2avpBVVTF+cgYdsSVgqugLyTA1smKxQK07v9lPqFDu7UdTmlBl/v6MQuqMeWFS37Z3An1PmJbUMcv9JklfsrlgwgzDXrKQB8dqHL2rM7NUMip8CXNfcc937+G1HwggufKVB0yyYNGtgLTu9RkG4oxluUepSJ+i5n8FxMgaYGZ84QlyRi4yUvjmjdKhAT7k83JFndP42Ea551K++ffKQsZGLR0bWpLyVeNM30SyOzAgi/WLqxwF4fvBSs9N6/9q62jmlpbWnzTMpuH9G5YxN/bWvvHolyH6RyiAVFZjsra2WMhtOMQYaXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICfFFCripL2P4ocC0bWkvw3oRf/7mOzyprGso847CcI=;
 b=QMs6GZW9mIsmNh4tAwYm0npMWnMwY7Xe5z+O0iGH9xPBwmwhQmwV9L2mqaqeAbYPcNptlo/UF1KnFVdd8Ph9+7N01qu+bDNejLCsnLlffbZ8OeoYTmWQL9q1qNON8lCGTEVQnJ/K05GRz8WjJ4cs5oi/13lSIp026o04li0fsUQ=
Received: from CY5PR13CA0034.namprd13.prod.outlook.com (2603:10b6:930:11::19)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:41:37 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::97) by CY5PR13CA0034.outlook.office365.com
 (2603:10b6:930:11::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Thu, 10 Aug 2023 07:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 07:41:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 02:40:20 -0500
From:   Evan Quan <evan.quan@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <Xinhui.Pan@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <Mario.Limonciello@amd.com>, <mdaenzer@redhat.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <hdegoede@redhat.com>, <jingyuwang_vip@163.com>,
        <Lijo.Lazar@amd.com>, <jim.cromie@gmail.com>,
        <bellosilicio@gmail.com>, <andrealmeid@igalia.com>,
        <trix@redhat.com>, <jsg@jsg.id.au>, <arnd@arndb.de>,
        <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH V8 6/9] drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
Date:   Thu, 10 Aug 2023 15:38:00 +0800
Message-ID: <20230810073803.1643451-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810073803.1643451-1-evan.quan@amd.com>
References: <20230810073803.1643451-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: c95fb823-bc77-4b40-501e-08db99753a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bLHUSTo0KOuv7BpLGGBmvjxuSNiNtREtFmRMVJASuHRofiYkORD61UrgydP0Ikl0Im9iOKHpzJW9Wq4S37SP2o3+6h1S7MD4sHTgFFTpiKjyMNaMJavYEhTvKzY3GLJAdNEOTdbe1oC6Vp5917tz46+BDTw4bSnGgxaSeUCnJwMCgdo2kYybXGk8xoTRm29hU/it0A81HaIC9eXL6sTYJ78VGFeFhUmJKqGLWAJlIYTIPkh3NQPk/ofM45tAT/mMPeMU+iG6yj48EvyLLiXSHU2b0GO+i6fFi+OMdPr6t+U5G0XauvkFGyurpsNJcFoCXafokllWi6fSHThloqWbp1CFRWuIh+tnwKMidbLvri1sTwHFLWOT6oJ3Ul3otvxwPmjGywjEcCE34uldftvfF8FI0wNRJJR3abPtqQfC7SrddgoR+Hw2FnCza9OukCu/UCOpOvC7nXIgm6hTi4JjZ5xXS806gw6ZFFXlvVQR5tK728k2BH7D/kNf+BpeTcdhEbh6HoLFCrSukETDoWAZOobqCrO/BM0UsFWpBLpnqkPZzwOx9Kd5qI5sJhwRrBOIVwyxvfqUsqaAtNuD+XlFcO13zvGaf5PMXuj9n5pwUMT/KKgfy5KK517yFCAeDPRL/M3NwLM+emT0TBMiL524VM1w0gTprSg2BlUcPvKhUECoE7SZh/tkF1cVZnG2y5K2bJ57OoNTYRoEeb/LBr3yeIQunBYmHbyLMPlXKvgC5d/M+eObeEBhKxV8sqaar7eJfVguvUSqU1hiZAGiVzwjsx1WdE85d3mZ+qSHF5QPiVrckhwrzW5DbQncaB3Q4b8GTSVYdszKrrn0tPK6EkQaNkjLZMwthR2m/GW8sMzBLVorAlkEF+XTPdGG3O4xxyoD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400008)(451199021)(1800799006)(186006)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(6666004)(478600001)(110136005)(70586007)(70206006)(16526019)(26005)(1076003)(336012)(54906003)(7696005)(4326008)(316002)(2906002)(7416002)(41300700001)(44832011)(8676002)(921005)(5660300002)(82740400003)(356005)(81166007)(30864003)(86362001)(8936002)(83380400001)(2616005)(426003)(47076005)(40480700001)(40460700003)(36900700001)(2101003)(83996005)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 07:41:36.9389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c95fb823-bc77-4b40-501e-08db99753a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With WBRF feature supported, as a driver responding to the frequencies,
amdgpu driver is able to do shadow pstate switching to mitigate possible
interference(between its (G-)DDR memory clocks and local radio module
frequency bands used by Wifi 6/6e/7).

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
--
v1->v2:
  - update the prompt for feature support(Lijo)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 194 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  23 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
 5 files changed, 239 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a3b86b86dc47..2bfc9111ab00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -247,6 +247,8 @@ extern int amdgpu_sg_display;
 
 extern int amdgpu_user_partt_mode;
 
+extern int amdgpu_wbrf;
+
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0593ef8fe0a6..1c574bd3b60d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -195,6 +195,7 @@ int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
 int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
+int amdgpu_wbrf = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -981,6 +982,22 @@ module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 module_param(enforce_isolation, bool, 0444);
 MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
 
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
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ce41a8309582..163037bd6d16 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1228,6 +1228,173 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
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
+	ret = wbrf_retrieve_exclusions(adev->dev, &wbrf_exclusion);
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
+ * @nb: notifier block
+ * @action: event type
+ * @data: event data
+ *
+ * Calls relevant amdgpu function in response to wbrf event
+ * notification from kernel.
+ */
+static int smu_wbrf_event_handler(struct notifier_block *nb,
+				  unsigned long action, void *_arg)
+{
+	struct smu_context *smu = container_of(nb, struct smu_context,
+					       wbrf_notifier);
+
+	switch (action) {
+	case WBRF_CHANGED:
+		smu_wbrf_handle_exclusion_ranges(smu);
+		break;
+	default:
+		return NOTIFY_DONE;
+	};
+
+	return NOTIFY_OK;
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
+			      wbrf_supported_consumer(adev->dev);
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
+	smu->wbrf_notifier.notifier_call = smu_wbrf_event_handler;
+	ret = wbrf_register_notifier(&smu->wbrf_notifier);
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
+	if (!smu->wbrf_supported)
+		return;
+
+	wbrf_unregister_notifier(&smu->wbrf_notifier);
+}
+
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct smu_feature *feature = &smu->smu_feature;
@@ -1320,6 +1487,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
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
@@ -1416,6 +1592,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
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
@@ -1471,6 +1656,13 @@ static int smu_hw_init(void *handle)
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
@@ -1623,6 +1815,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
+	smu_wbrf_fini(smu);
+
 	cancel_work_sync(&smu->throttling_logging_work);
 	cancel_work_sync(&smu->interrupt_work);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6e2069dcb6b9..244297979f92 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -22,6 +22,8 @@
 #ifndef __AMDGPU_SMU_H__
 #define __AMDGPU_SMU_H__
 
+#include <linux/wbrf.h>
+
 #include "amdgpu.h"
 #include "kgd_pp_interface.h"
 #include "dm_pp_interface.h"
@@ -575,6 +577,10 @@ struct smu_context
 	u32 debug_resp_reg;
 
 	struct delayed_work		swctf_delayed_work;
+
+	/* data structures for wbrf feature support */
+	bool				wbrf_supported;
+	struct notifier_block		wbrf_notifier;
 };
 
 struct i2c_adapter;
@@ -1356,6 +1362,23 @@ struct pptable_funcs {
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

