Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4674D7A0C
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 06:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiCNFFY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 01:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiCNFFL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 01:05:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856920188;
        Sun, 13 Mar 2022 22:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD0TBPPp2TBu/KGArjYzOZ9ujMSvp5OTc7MtIL/ATUmjZAo9jGsuM5kT4a0VwbKWZYG7cBEkhzxrLv+QIIBgzL8gR6TP+JsjgkM6tbrWFAyKuT1I8R9UCaIh0wIGe9a/3bMTc7IravdjBn5K0ffB6UyZFyMA22NdX8KDU9ZYAMAyHFCvirv2/7AyX3XEmGUpb3DPGgyBS+UFXJl+gPtD6H58aXEjAS1CSLegv4A2ipDnCqFGPd0lcnG8BErTE1RWcraxLJ3p5njzDG2JRLCEQAtnTRJ6AZ8N+8mJcfA0drVIThw2YRUTwUCAv0YT8/ifc3nhj+Kk2QDiwrENrEiHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5TVyr//jUEN5D7p9K4Qe1d7lgRffNBF4GaGYWGSJio=;
 b=BhJ4lkdpJGiDfWacy1S/+4Yvytms2Ak8F/Xhb7AbIGSiuC1OLc50UFR3SdsGmBCvgBqMW9+0pqpJUPVHsYjk6WlSm1RieD1D4ee7U3UxkZMy+DcyNCIVf7rQHBELLnsrfFTnAw1FyMW3lIyQu9fbmEARqjLKWOBV7M1+TpBNoehp/Luj7S6x8embCo0G1s3ahTMXRKpLw6mPE/3KXmch539g5vjlt+Uic9iok4NiSgGbUC818CTdIgr18wvoUIGIemz//7Qs9D6cLMJYwWpOr4/k3MonQulv4Wqa6DOMpwkI961I3WRNKuAgSpZ3AXsTv1sN4TX/tceknopooN9Ccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5TVyr//jUEN5D7p9K4Qe1d7lgRffNBF4GaGYWGSJio=;
 b=IW3bCj3NLv9rpI/RwYnoj6FjRbXolhjPWpoqzlBJZv6Jk1n2/2C4kP8CjqowYDo7aP5HG4G930Sjn98Mw0DnX2Lge0qjScN9Lxbxtx5gDwgipxPF5ZR2P3K3fvD919boZXb73ZDTpZw3bulfz+jMXHxGiEVmXQBxtKNGqbmjJRQ=
Received: from DM6PR11CA0017.namprd11.prod.outlook.com (2603:10b6:5:190::30)
 by MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 05:03:59 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::e9) by DM6PR11CA0017.outlook.office365.com
 (2603:10b6:5:190::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Mon, 14 Mar 2022 05:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 05:03:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 00:03:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Goswami Sanket <Sanket.Goswami@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 5/5] platform/x86: amd-pmc: Drop CPU QoS workaround
Date:   Mon, 14 Mar 2022 00:03:39 -0500
Message-ID: <20220314050340.1176-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314050340.1176-1-mario.limonciello@amd.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45dc098f-b4b7-47ee-dedf-08da05780cb1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3902:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB39021E123C5474A45FDFBECAE20F9@MN2PR12MB3902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GnzFR2d/FiLKAbcwpDto1Of8w+/5A7oFEBG5KaLMQurOZR/u5UI5NzPPnK/XDVY+4x/Y/LyBRKvpjOZ54cxWHr77NGb6XeNw3VnYXL0HJHfA16GE4JQLjUtUB0RyiCc7nO3VI7UkCjeFBt/4zIYAoY/XE7cYJco7ZUUjDCoGdNyy9sXjHNU25czjnY1tFIbJFEjR7MU8V6U27cZwSPuH9MmxUz0F9ODzvmz1ncJX0o/iHLuQKXiAD1ZDW18kN4wDnpoWvANfB8GW1IK/pdQrKyI8sYchbxCS/gGS9bHgp2BwBuScoc5re4ra2mm+596ljtNWMCOs3+UTMmd1AS6pt4al6h37g3Ic/+v1aOGk21z6eR1k7h+WTleU7Y7YPFuj9xqle6suxA1omlK5RiU0iD1Fq9ypUTGGcoY7bvpIcffw1IB/26v9d2jaGHAZbeNbjftIjDD5fu3NVGx3KrD9/evKeNFzM4pW6hwDktTso21lybzG7M2MZhJ/ei5tf0F2vbtr8mP3v1h0KLcroydDvF4gXoEZdgKce/cdpOIqFDbXhuAIl26WVtRVb3M0/1lkRFyY3HGvgRw4UrMbl6vsLEX0topjvTtJ9aaiOJnDOSB9upZQMCD4BkWN3JN30dFt6KH5T3rIGFr2py8dK3D8eJ2jiHq6yn21NkuopSmvDnHB4xZ6ctY4ffz8ljAicv50MCICNMe8vlI01BRYWiAsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(8676002)(356005)(81166007)(40460700003)(336012)(186003)(83380400001)(16526019)(86362001)(2616005)(7696005)(426003)(1076003)(6666004)(26005)(47076005)(70206006)(70586007)(36756003)(36860700001)(508600001)(82310400004)(316002)(54906003)(110136005)(8936002)(44832011)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:03:59.2450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dc098f-b4b7-47ee-dedf-08da05780cb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
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
changes from v2->v3:
 * No changes
changes from v1->v2:
 * No changes

 drivers/platform/x86/amd-pmc.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 752a99d759d2..b3c6b5cc83c1 100644
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
 
@@ -678,9 +665,6 @@ static int amd_pmc_suspend(void *context, bool constraints)
 
 	return 0;
 fail:
-	if (pdev->cpu_id == AMD_CPU_ID_CZN)
-		cpu_latency_qos_update_request(&pdev->amd_pmc_pm_qos_req,
-						PM_QOS_DEFAULT_VALUE);
 	return rc;
 }
 
@@ -707,11 +691,6 @@ static void amd_pmc_resume(void *context)
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
@@ -890,7 +869,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
 		goto err_pci_dev_put;
 
 	amd_pmc_dbgfs_register(dev);
-	cpu_latency_qos_add_request(&dev->amd_pmc_pm_qos_req, PM_QOS_DEFAULT_VALUE);
 	return 0;
 
 err_pci_dev_put:
-- 
2.34.1

