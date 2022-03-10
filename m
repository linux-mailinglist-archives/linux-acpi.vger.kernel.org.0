Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C64D4CE8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 16:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiCJPWX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 10:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiCJPWN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 10:22:13 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF8131F4A;
        Thu, 10 Mar 2022 07:21:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLJE0xixT022h3dyyGVJp6m7/Ya9Asu6A4MrXL+fGZmIYLI7BN8SgLxlONNuzgrYouNm2xGRyp0VB01whjHvPT9DESJSvb+4wuCh97D5/qjw8tv5oEDxIr+Ai0V6BSCaJ63due8S+AEl8tuq16jcxxHQW8E+Fr+H+mp9Dic7zepTLKa05TdPNhbdknAoEgQsWTuWVsSRo25la5yYDLhnSJN3hgW0Ok1DWx5Blb6pCUvDLhkYYRjggxU0lO3EDhJ6jqA6QYEjjMyZNZ+3Etz8RhKap4B/sh2iMtv0DXXnKh4DMvLTaSgm0WzHisXTnfbdMYLOMu/L647D+buHX3t0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2c4NG+ccv608RyWdPEmQ1k9HRtQ0Rq+TASTHf7B80Q=;
 b=PB+plGx/dNDt2Yy+t0Lp16gYLosyiqhbUl+yToZq5M3hNjs4lvlCfllmmrt/clonrkcGUYUt8yA0LXrM//XdiMFEdhbyDUI8P31BY1HH76IHrk40VAOcOjYy6qbf3j0Z55Ci7fA1ipmsW2Fa2kGzzhpcLw3ShlfKE54BAZh1GeNEy/k3bVLnKLzR+Jvq22JLxtmw3T0BjO1QgFfPg5nGz+JiHEbjQvOorAgj1BmrMOpqApZ8wwerq3PcdzN5NiWkUyKs7xr6Sr7VyrbFMo19jMIWF0OKwtK4rHh7kKpcgAt2XmLhnCgkLv1TcvaeR6ojwrIqdVqjf1uUUNwitVGVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2c4NG+ccv608RyWdPEmQ1k9HRtQ0Rq+TASTHf7B80Q=;
 b=kuJtTTl/SJl/Zwv8/ynxpuQVoOfKxgr7XNmuYyZYAhizbXm5SSe3vRL8BTKo/Y+BmcfBvi+qti503fW+qycC9UV6y4SBHpJnbIyC7AvnHuwyhJV+KWz6Squ9WWjOEE3HTpxbdhGqF0zZoldQtlIy3qOkP+naRmaGYaqYlF7lhzY=
Received: from DM5PR06CA0082.namprd06.prod.outlook.com (2603:10b6:3:4::20) by
 CH2PR12MB4840.namprd12.prod.outlook.com (2603:10b6:610:c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.15; Thu, 10 Mar 2022 15:21:05 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::59) by DM5PR06CA0082.outlook.office365.com
 (2603:10b6:3:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27 via Frontend
 Transport; Thu, 10 Mar 2022 15:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 15:21:05 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 09:21:02 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/4] platform/x86: amd-pmc: Drop CPU QoS workaround
Date:   Thu, 10 Mar 2022 09:17:05 -0600
Message-ID: <20220310151705.577442-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310151705.577442-1-mario.limonciello@amd.com>
References: <20220310151705.577442-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef46745c-b79a-4f6e-0332-08da02a99823
X-MS-TrafficTypeDiagnostic: CH2PR12MB4840:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB48404F6A688B4A171711520BE20B9@CH2PR12MB4840.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeTU4CWSGo9tGWO4uV1z8AzzqHKt5DRyWOuAQaXyNR901Uuk3OLoJRGtdS3h8QXLtCzl4PruK4hOedRvM8ROVTlo/KpAVz6w24Q+SDI856edKEVdF7B/z5e7FVClEDa+0MQ7Tc7zG9qiOXnc0hWDM+KtlcbIZFJo+Ifu+aJUnqdcNB9d6n8HdEknLTYENOkyEuzVkWLwCfNkDkUWkH3GvtN739dRhXVVhdJwXdcAdjXWirvI1mOsROn1ULu+WKp2Xs3uCIAAbn3QNFIrRB8nKm7+uwF8EovkHWkYq8q21LzmWY+oKlMybEeoWW5/WtdQJx767qkb0F2UvZqv1GceiXN3qPRBOMIeEHOUBldU5aXmgjDkKT9LMkqekO9I7dLbPCVBmuBZY1ZOYif/M7O3lBFVcn9xCEh18SFNm9dV84ofIeoIK8hXOn+vrieul5Q05Rj2rlQeC34f0ZFAfhxTmdgEy77gSiuAu8FZhszA5L91pwTHK0P5jxrWQw64KF3nUerpMVQUGCsl7EqI9/ia4k9+Ow11wcb6MsaZqVHwS3KHFmKRZQrKqZgJGRuf2954Xp2KfRzo4q29iHKVrohdf08BU7cngRz58+mG3kbdJeaRVtzDilePPHTj6KqXhwrnvTmFnWUh+2ixJygcWfr6YWSnLxqOQSC27PPGnQJuhVLt0pS5ZilsE4tv8Q4Z4BcjIk/RuKwBvJ3ffee78VhS4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(8936002)(47076005)(36756003)(2616005)(54906003)(110136005)(316002)(86362001)(70206006)(336012)(186003)(4326008)(26005)(82310400004)(16526019)(8676002)(426003)(70586007)(1076003)(83380400001)(44832011)(508600001)(36860700001)(81166007)(356005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:21:05.0569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef46745c-b79a-4f6e-0332-08da02a99823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A workaround was previously introduced as part of commit 646f429ec2de
("platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup")
to prevent CPUs from going into the deepest state during the execution
of the `noirq` stage of `amd_pmc`.  As `amd_pmc` has been pushed to the
last step for suspend on AMD platforms, this workaround is no longer
necessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd-pmc.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index c13fd93f2662..b636fbe90407 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -21,7 +21,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/pm_qos.h>
 #include <linux/rtc.h>
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
@@ -96,9 +95,6 @@
 #define PMC_MSG_DELAY_MIN_US		50
 #define RESPONSE_REGISTER_LOOP_MAX	20000
 
-/* QoS request for letting CPUs in idle states, but not the deepest */
-#define AMD_PMC_MAX_IDLE_STATE_LATENCY	3
-
 #define SOC_SUBSYSTEM_IP_MAX	12
 #define DELAY_MIN_US		2000
 #define DELAY_MAX_US		3000
@@ -153,7 +149,6 @@ struct amd_pmc_dev {
 	struct device *dev;
 	struct pci_dev *rdev;
 	struct mutex lock; /* generic mutex lock */
-	struct pm_qos_request amd_pmc_pm_qos_req;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
@@ -628,14 +623,6 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 	rc = rtc_alarm_irq_enable(rtc_device, 0);
 	dev_dbg(pdev->dev, "wakeup timer programmed for %lld seconds\n", duration);
 
-	/*
-	 * Prevent CPUs from getting into deep idle states while sending OS_HINT
-	 * which is otherwise generally safe to send when at least one of the CPUs
-	 * is not in deep idle states.
-	 */
-	cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req, AMD_PMC_MAX_IDLE_STATE_LATENCY);
-	wake_up_all_idle_cpus();
-
 	return rc;
 }
 
@@ -675,9 +662,6 @@ static int amd_pmc_suspend(void *context, bool constraints_met)
 
 	return 0;
 fail:
-	if (pdev->cpu_id == AMD_CPU_ID_CZN)
-		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
-						PM_QOS_DEFAULT_VALUE);
 	return rc;
 }
 
@@ -704,11 +688,6 @@ static void amd_pmc_resume(void *context)
 	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 
-	/* Restore the QoS request back to defaults if it was set */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN)
-		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
-						PM_QOS_DEFAULT_VALUE);
-
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
 }
@@ -884,7 +863,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
 		goto err_pci_dev_put;
 
 	amd_pmc_dbgfs_register(dev);
-	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
 
 err_pci_dev_put:
-- 
2.34.1

