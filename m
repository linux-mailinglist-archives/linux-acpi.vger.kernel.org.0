Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CD4DC881
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiCQOQd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 10:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiCQOQ1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:16:27 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9648ECB17;
        Thu, 17 Mar 2022 07:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiXYAullecjtspQLDlDeFLALK0/rzHFs/E7bO4C/vGG9DEnYDFive76CzwjSjTVSanKtSaOqf9MCJh2NrHXYqdbCYP4np2Iou7DAuW7oWo/7BkIOliEBGI0o2bQhiQ/HyyHBWS4bPccG/trbmahxy91RHJhm9rqxvszQ1uaOHDFz5Zrz16CbzBjfQT1LrnOtJ8P4DVxZiIyq0fCcofQgsu1LTy2M8bjhQrkSVD+NmiBoqexkvSMVwtZBm06UHujxcvpCWkwmhC5FsxLaJKij7asdEL95YmPGcz6GQYirVzqygF9Krh1NBFYMsLdcIMXZsDMEpk6ScQp7zAKQraAZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccntNUft3rxRS8sqHb7obrLny0Zd4Tn96eaN9I0Y7Rw=;
 b=JwXK1rsyZ3k3nqoT6+MZTHzHGIFYI+dPwDieFIYp2OvbRPrbTuL/JLPcu/yacW1q26H0GfvYzk9mIlu9vGXCDhjz7v0CSPJ07IiDjV3rryT0jZAiA54MxTclk2MqQd8QExIagQVevGrN1X88/Zivc4xa8Jai0wQt38hKtRNjPkbzYZCFA9lnEV6uazxmyUvjDu5Dw7Jmfy3gkEFuG1sEJvEt6gdDlQI7Fd2mut1cUDv2uxpl+45y0nyo08+N6punhUtvAz3oAn6nE9wVDZ+y8ZdQzIxzYqdZYFy+toLwgwZk/Zi9JS4bwU0nodIJvasFcngepyMJ4rzg+RO5mbHKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccntNUft3rxRS8sqHb7obrLny0Zd4Tn96eaN9I0Y7Rw=;
 b=m50cmO41XHX7nxXh+rpt1LrPY6bpNbcKnd4YkEOYqqXn7U5YlaxAra3mvTh8X+EVPxUx98wQFkfzMQzpMigqc1rc0mcvQrFj5dVz5WvwFYatErRBzYl94kn2EzLfEvcRBx6bDLkls+hL815rNphvpmuykKma9tTqu+SGEjIn/wQ=
Received: from BN8PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:d4::14)
 by MN2PR12MB3104.namprd12.prod.outlook.com (2603:10b6:208:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 14:15:08 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::ac) by BN8PR04CA0040.outlook.office365.com
 (2603:10b6:408:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Thu, 17 Mar 2022 14:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 14:15:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 09:15:05 -0500
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
Subject: [PATCH v5 3/4] platform/x86: amd-pmc: Output error codes in messages
Date:   Thu, 17 Mar 2022 09:14:44 -0500
Message-ID: <20220317141445.6498-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317141445.6498-1-mario.limonciello@amd.com>
References: <20220317141445.6498-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801993bd-e654-47d8-f952-08da082089d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3104:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3104CBB20D2D14BDA1BE1B5AE2129@MN2PR12MB3104.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5H6kTKtajuNra4/JsoT26b/QUq7GK4vynXFQcoBtc9LT2zO5hH9g7+psVfRRVWoLH8DfKIqP+fpv9nSIkh4vCj0Ix/r0JYb56NLMcMZM9eSpsOMl8uZ8Nn9f2qB85FPoY3DLL/mPkEBCxrwacgV4t52tpmlSIgmbrg5hliZ7vt3LFkpOJjXgacmpCAg/gCdpzJNIE2MZvc1/8NoeFlBvVd1m0K6IPf1l+NeqLJ8/VPqOkjngcAKQg4xkLMo34/6xApthK1V7pXXIA/Dp07pD8LizKD7V9wnySVU6WJbYybTYhpIQG+l0TcJ+W6/YMmbz9HaDeyaKLjOE6wEHLXMmdNwp7IFkgX1bNJUaZTOaVkJoWrpqMChToTxLkyqMTpT4Cs8pHv49NEkBI7/uIg2H/JsEVeSnoVRQ1JkaM7qnl+8kW0zSJ0C/ZkNRqwQUmuOtbnz8najfv+mo9yu+rPC7GiDLkmdq1Tst3ciUC8oJnMC+BBRzVXqg6BDWxJrGwNQOOo/x0DZxqBM3SjwOYdIdbjR3xGcQ6FHd2ELe33Ljulc9VrKto6n26heyTt2PwD0Gz+pkwLGCYbKS8cOK9rr/TkP6HMrqkzVyBkeuRGBNSL0l2ayVMBmE+GlaqR1LnLjwIraoReXr2wXOUssbf/mtSWlV+j4NrvRfgfI0lERwdgqA4XWemzyAZVTtYjoUUCyeADoQdx9SdxOex+jjBV5sVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(356005)(86362001)(8936002)(70206006)(70586007)(186003)(44832011)(8676002)(4326008)(2616005)(110136005)(2906002)(54906003)(36756003)(26005)(16526019)(5660300002)(82310400004)(1076003)(508600001)(40460700003)(316002)(83380400001)(15650500001)(36860700001)(7696005)(47076005)(336012)(6666004)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 14:15:07.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801993bd-e654-47d8-f952-08da082089d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The return type for the s2idle callbacks is 'void', so any errors that
occur will no longer be displayed.

Output these error codes in the messages in case of any failures.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
changes from v4->v5:
 * split from previous patch

 drivers/platform/x86/amd-pmc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 2736ab587f2a..f36cf125b284 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -653,8 +653,10 @@ static void amd_pmc_s2idle_prepare(void)
 	/* Activate CZN specific RTC functionality */
 	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
 		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
-		if (rc)
+		if (rc) {
+			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
 			goto fail;
+		}
 	}
 
 	/* Dump the IdleMask before we send hint to SMU */
@@ -662,14 +664,14 @@ static void amd_pmc_s2idle_prepare(void)
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
-		dev_err(pdev->dev, "suspend failed\n");
+		dev_err(pdev->dev, "suspend failed: %d\n", rc);
 		goto fail;
 	}
 
 	if (enable_stb)
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF);
 	if (rc) {
-		dev_err(pdev->dev, "error writing to STB\n");
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 		goto fail;
 	}
 	return;
@@ -688,7 +690,7 @@ static void amd_pmc_s2idle_restore(void)
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, 0, NULL, msg, 0);
 	if (rc)
-		dev_err(pdev->dev, "resume failed\n");
+		dev_err(pdev->dev, "resume failed: %d\n", rc);
 
 	/* Let SMU know that we are looking for stats */
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
@@ -700,7 +702,7 @@ static void amd_pmc_s2idle_restore(void)
 	if (enable_stb)
 		rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_PREDEF + 1);
 	if (rc)
-		dev_err(pdev->dev, "error writing to STB\n");
+		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 
 	/* Restore the QoS request back to defaults if it was set */
 	if (pdev->cpu_id == AMD_CPU_ID_CZN)
-- 
2.34.1

