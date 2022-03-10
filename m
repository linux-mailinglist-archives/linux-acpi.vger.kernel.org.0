Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183214D519D
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Mar 2022 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbiCJTSi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Mar 2022 14:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbiCJTSe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2022 14:18:34 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1681CF0;
        Thu, 10 Mar 2022 11:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuOuOtqPhrTz7lgBWFIi/oNhv6ElyKPy9EYrnAO5pB69Buns5/8ANrGDNZJe/DveiY2Sh9Np+pq+SpqOIJHtHccxMibBNsn39bVMgsARt98TiUGrTLsaz6TqQtEo0qiiLYXSuxxDmGtxSx1kcIdiVJbx0n1OICcdEsYahq0kFlmsuOQRxdifTI+C6+TDXn6h6Z1Noo5g+agBfaBhVt+awIN3P+cTMryNkpR8FgHfUgZ1YSjFg7KhsZ1HGgX7KXmXzfkSLncdfK88wuNat5a3vsl2lxVcoZu0jAps5JEHDXftKDtTKIo6X5pQVBOdCjxJeU6I5ZPKeBakDF+cscXo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq+gvviXlEKDwtsks3/N2f1EW+E5fajs29F53LmLNcA=;
 b=jUOwgUTgcOfJ2cVvOoxsefJ53gqA4NJCxxrp+JvKUhf7cVf1/E6OUqtJmQzFgvt3qm+J/MN25MNJKlsbYwszo2swK/d1DmdgRmLsKnse3V2SZOMdj/HVtrvTqaz9o/g3KTGPf6NEglXmbsUjI50qsqtwSboGwIZNrIo1vyahR+f5lm7Gut9pgVt16Vetp0NyWPJzHqPYXI8T0VD3TuxqBjE0w/Ut/MlB7U+cRt7FkfkkdXr4/hwfshxkL2JhJB17b33tnfWx5J4WJQAKEW1s5Q0JCd5pmB4PXQBViTZC04V9ouTWO66Ywzy+AgErKzeCiUxbLT62RofEMd0k8zDZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq+gvviXlEKDwtsks3/N2f1EW+E5fajs29F53LmLNcA=;
 b=I0+uwgnroc2R04rTlpF3MjOYZ9RpUTzXuQldiDrmEtJdZ7u0CXdAvhNvEIRPBtLttfcdbH8lVsaj6hyhVfBt6U/t6vynBsme5JfcrWHVejgp+2Gb9zIrhngKU5Y/58Q0K52mdKUXRRFjVyA2budAF+LWFYs4sAFgtnmLmhmSzPs=
Received: from MWHPR14CA0034.namprd14.prod.outlook.com (2603:10b6:300:12b::20)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 19:17:29 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::38) by MWHPR14CA0034.outlook.office365.com
 (2603:10b6:300:12b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 19:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 19:17:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 13:17:26 -0600
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
Subject: [PATCH v2 5/5] platform/x86: amd-pmc: Drop CPU QoS workaround
Date:   Thu, 10 Mar 2022 13:17:24 -0600
Message-ID: <20220310191724.1440-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310191724.1440-1-mario.limonciello@amd.com>
References: <20220310191724.1440-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7953e83e-da5c-4d83-774f-08da02ca9e6f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2411E01AE57BC32F3D4DE76FE20B9@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbd+qxilCNwyHgFykzw8t1cFdNI+11Q0kLGIThMGQt5alo053zkWiY/hqtNv9SCCdf0hWWAtptV0QKT6KOZDMbGG2zPyJvYV/f5I9Ba6mZg+Rs3gylUf84F5lv0urbK5TRF2yK6L1ODwXm6GlqTaYTwbc1DYO0vDIUzn9TvqW7QLevDmoPd8x/8SZ5qWF91n1/Bl1QFKaI+Uoe0jsIYf/1syVLMYsQLPj+KIujGyM0IFY6ctOrZ0hAYWy3oVJ14eL8IfaBFTpneimKx+RR9Fkiq/zRKUuj60AZWJeh9wZWXiDFLek5U1ErmAyhy5msscZowQtN1Rh4HV5hq/pOLhPrEJn/icKf5U6RPnTWHfkOe4CX9o0AdB+4euVXGIHlcEUiBlMAQMZtIKSN+JLdApqwvR1eKp/bO+74d0+87v3stu1gUMPtXoBXXrad45Wf5yAu5E19q8A/f6qlRFojtOF6ibsqiBsYB8wfu20dlQE39nIe96fiJThK/9J+BxIKBLva9BkbMHTDV17PNm/EGmKB4dUFqx1Y736A8aw5JxE0fOZRb74WaWYJaDp/5v1D+4rffR+G2nl49EGEfwBUkYnmPGj6KvJSMhY1kddjsr8HjV47MnJ4jLGQnsOcjZvtFxoeqCoA1RZsMJdsJ80qLc0yGgaDTbYth+SwbOMlroMFbr2rlHNZs4qVDbWtgGDX8FRR5P7jIWxKKw4h53ODaMmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(4326008)(70586007)(70206006)(5660300002)(8936002)(110136005)(54906003)(2616005)(40460700003)(44832011)(2906002)(36756003)(186003)(26005)(7696005)(1076003)(47076005)(16526019)(36860700001)(426003)(82310400004)(316002)(86362001)(508600001)(336012)(83380400001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:17:28.9226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7953e83e-da5c-4d83-774f-08da02ca9e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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

