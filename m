Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034BB4D79D4
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 05:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiCNEIS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 00:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiCNEIR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 00:08:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A683D4B5
        for <linux-acpi@vger.kernel.org>; Sun, 13 Mar 2022 21:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4ilep6W+ltJaCR8+ESxG62i0GzcZdOk1yXyARJYgUkOxERX/1q4CcwadltYd2Ke2R8IzOYRSz1JiKSLoZNFL1fF3VOEXwI4gTS42A8fDZxju9HoM7DR3C896thtnpuCLDDP1TZvUiTJI/5MOxHjBRsBbaRuKxr4aifFVbqLa/LHYShEWqnDvkPfVHfWqrspLn9imSDWI3XEtsxx40CbjpZojzHIikzaYZNtVZ7o0oK42YxgNorexVTSn09ryWzV1OK7t+93pDm2CYFaPO+qCTMZZjC5vH8SJvJ3PRQRfkRjY86sNPuk1k0H87Jv3uJqa2b5nDh2awUBAvKLmU/qDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRJ7qyKuqK22GV7R8lDvVJJyD2gDoSl6kOAELdJZksg=;
 b=VIGkY37+K+WgtXDyhBJYdkfWmw086WPXsE72Trv5VoOGy5O56rQGEiikVqyNT3SlLMMqNxaDsSe/qgYSScDcxZfoZ2Wyo9MRtisCI98d84UKDWliCkrwzj0dM9n1q94XVyUCtonk4YVxjC2y7sp5ic02iEjoHBwsxKVQI9cLUfQ6TjOZhHVJDXoU9z+q3Zo2k7F8WQlOh6m88cU+EGNjX0l1jacWqoIXfF1cSG+RnDniufjfkk3Ch3ONZKGxfmxYy7abMSP+d9MgARi5l+2Z1x/b/0wdbqTLaJ3+rIwhhCtcVVaE4oim6xRHHBakV9geIrjMYM0h5iCL35oOLjepJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRJ7qyKuqK22GV7R8lDvVJJyD2gDoSl6kOAELdJZksg=;
 b=zX7duzT8/NkT+yWhUfiEUK35vCip7NVB2I3m0uForvdYG6Yy2+TfLVjU9+G5ohZ6q7eVtB0B67wnWPy85AxVvpScG1ywn5LJUsLbi2NWktQ9HPrNRo4B3XoMI7DAopHpTCYbjTzG4ed2GBpcm+rjvlGQt3S0N/o39b9M0YhRXmw=
Received: from BN7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:20::33)
 by MN2PR12MB3343.namprd12.prod.outlook.com (2603:10b6:208:c2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 04:07:04 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::8) by BN7PR02CA0020.outlook.office365.com
 (2603:10b6:408:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Mon, 14 Mar 2022 04:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 04:07:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 13 Mar
 2022 23:06:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v7] ACPI: bus: For platform OSC negotiate capabilities
Date:   Sun, 13 Mar 2022 23:06:32 -0500
Message-ID: <20220314040632.985-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 594a4d52-6e59-4b7c-5df4-08da057017d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3343:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3343A4273E66A6B741E988C9E20F9@MN2PR12MB3343.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MI2Djx0mp78nidvay1tch2VVWOsXPrEmKXEKMqqGkl9uU/p4HmD6PKyNGR8DeMfWy41ZzdRWMNK5aZpDjrJvU3v+yRxPYW6IwQk6TjNxVNRzYOAer5edUCUPw+fbt0ZFrhSDWTBlv0R37aSFw5bKxTYZqt8jGcWFSG+l+NNXDTdD7j9k092Yu0H4q63EteH+Cs/XaHB2/XZQQbZMcjk6VUvzRqie6XdZU0qkuLVA5TA+u631G+LMYHw0D34cTeBta7GtpMMVGu/Duq9YvUbNrPxo8j/j6YSRA91HJTJWco5qcpqV6E1mLgcQatvLuM0sqw+n1Dqd0itCBGMa/4k5R09sX96KfaZTw3fpOahUJOqq/oQC3VBSIru2qyUxqbGTi4fW9EM61qKjIOghL4cpxtLppF7oSEYfcuNmR2jPhCNUIaFHvJ9QHsfsf8S/IdqCNwAiMnzRiOItPmps5BnmGk4Ix+b13KmPaI0xnaWaHVsQ+P9igZEeflWP6xR/qd0kl1aSJkSRhwWFqAJrny1x8yqsJCbD3WhPazM7YpLHpr4p0Hv3HUIFjK/kc1DM11i39i634iHEX81HUBCukmzpeoUudjKPdkQXlRJysXjF60j2fPXa4X9tBoBe1MdrdMtbziG1PTTHIQugdWuR3khBjVX1Sz5IZCYeMTgkzd0eg02iIPWfFHBLh/RilJGAkx2FAKt/gfjMiklw0qwZt+XpjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(356005)(81166007)(40460700003)(186003)(83380400001)(63350400001)(16526019)(63370400001)(86362001)(1076003)(2616005)(7696005)(336012)(426003)(6666004)(26005)(47076005)(36860700001)(36756003)(508600001)(82310400004)(316002)(54906003)(110136005)(70586007)(70206006)(8936002)(44832011)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 04:07:01.9729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594a4d52-6e59-4b7c-5df4-08da057017d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

According to the ACPI 6.4 spec:
It is strongly recommended that the OS evaluate _OSC with the Query
Support Flag set until _OSC returns the Capabilities Masked bit clear,
to negotiate the set of features to be granted to the OS for native
support; a platform may require a specific combination of features
to be supported natively by an OS before granting native control
of a given feature. After negotiation with the query flag set,
the OS should evaluate without it so that any negotiated values
can be made effective to hardware.

Currently the code sends the exact same values in both executions of the
_OSC and this leads to some problems on some AMD platforms in certain
configurations.

The following notable capabilities are set by OSPM when query is enabled:
* OSC_SB_PR3_SUPPORT
* OSC_SB_PCLPI_SUPPORT
* OSC_SB_NATIVE_USB4_SUPPORT

The first call to the platform OSC returns back a masked capabilities
error because the firmware did not acknowledge OSC_SB_PCLPI_SUPPORT but
it acknolwedged the others.

The second call to the platform _OSC without the query flag set then
fails because the OSPM still sent the exact same values.  This leads
to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
tunnels can't be authorized.

This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
same capabilities to the _OSC regardless of the query flag") which subtly
adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
with query bit clear").

The _OSC was called exactly 2 times:
 * Once to query and request from firmware
 * Once to commit to firmware without query

To fix this problem, continue to call the _OSC until the firmware has
indicated that capabilities are no longer masked.

Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
the same capabilities to the _OSC regardless of the query flag")
introduced, explicitly mark support for CPC and CPPCv2 even if they
were masked by the series of query calls due to table loading order on
some systems.

Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v5->v6
 * Redo the series to only change acpi_bus_osc_negotiate_platfrom_control
   This fixed a memory leak discovered from (the previously accepted and
   now dropped) v4.
Changes from v6->v7
 * Logic optimization suggested by Rafael
 drivers/acpi/bus.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..0483f3cb7c53 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -329,14 +329,30 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
-		return;
 
-	kfree(context.ret.pointer);
+	do {
+		if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+			return;
+		capbuf_ret = context.ret.pointer;
+		if (capbuf[OSC_SUPPORT_DWORD] == capbuf_ret[OSC_SUPPORT_DWORD])
+			capbuf[OSC_QUERY_DWORD] = 0;
+		else
+			capbuf[OSC_SUPPORT_DWORD] &= capbuf_ret[OSC_SUPPORT_DWORD];
+		kfree(context.ret.pointer);
+	} while (capbuf[OSC_QUERY_DWORD]);
 
-	/* Now run _OSC again with query flag clear */
-	capbuf[OSC_QUERY_DWORD] = 0;
+	/*
+	 * Avoid problems with BIOS dynamically loading tables by indicating
+	 * support for CPPC even if it was masked.
+	 */
+#ifdef CONFIG_X86
+	if (boot_cpu_has(X86_FEATURE_HWP)) {
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
+	}
+#endif
 
+	/* Now run _OSC again with query flag clear */
 	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
 		return;
 
-- 
2.34.1

