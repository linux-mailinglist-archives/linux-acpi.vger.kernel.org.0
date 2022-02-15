Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F054A4B770B
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 21:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbiBOS4P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 13:56:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiBOS4N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 13:56:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96901DF4BA
        for <linux-acpi@vger.kernel.org>; Tue, 15 Feb 2022 10:56:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCdg9dK+iR+GBslvpGrvWg+sgRyduEEF+4NqUpQyVYJExS5MemdwECUAw2drtIjzeKwzXqYqlCrf7e0ayTtvWqdbDQxLDhcX6tDa/BEgjc+Vk95SfZ1tXQUVbnkqbKIhaxP+zRdM1jLIZZQTZyyezvQq1nxPP0N5CLkZBVdiFyQP7R+EpAHeqOQh7DUvonSPo09LOe++/sCoDLko4oKhAWJYkI6AFTXFEjSfIGL2AGYdjwuThZPUUGdW4LVUSh8H/eNZ1BQyXgKGOaiJNaodhsVivhQgoTw0zM4f0CQRyDB0WWRsMZnZBju00s/1tSs75FTZ8xshD7RnJePXXox2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so8Oe2kIyQO63kMYf27Wg5tn18Um5skS7Saa/d3NVz4=;
 b=XX3fizVY4eZwP+z2pB1ql4sLLQGM74jmWHDRCR0g7EIuRDyR3mDbBIzUIMMPCOCLfRBaXhPhUn9xIReRqu8XhMWliRO5A+3yHwtJ1lHp5lEC8mmsZno+JeAxKMe7B2S0Zxq0i8SB5K5MN98lpWbaWN7Q78InjJfpi+mXZFcIdcdBPrzofHKfBKSijHlDbZugKKK+NhShgM5EwoVq7WavzUo5JrRP/s944uJ8SFYeepe2GAgzpeI0GR/a1FBZrXZDHSP92Qj5cx2jZoWeNFn32cBm1lZ6bjjQzRXueMve3k9hRoHrVucQik166MJavmuqT9hN9Gp3EkxZK4SEP5ZKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so8Oe2kIyQO63kMYf27Wg5tn18Um5skS7Saa/d3NVz4=;
 b=0aN+3P3z+cNYI+XzB60qNqW8hkmMdJsUZ1ILg6tSNgWmcqz2Rh2qULEkjcwuZ25GfTwRnA0DqaKFVGpwAwzIcf9JdiLtRttnMHSXMdjABfyDktFyGD/q76mXzLBs69t95sgXRTWnuagA4HWZTsfEQMJMvGYZMYsHp7wD9MBtyaY=
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 18:56:02 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::34) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 18:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 18:56:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 12:56:00 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 3/3] ACPI: bus: For platform OSC negotiate capabilities
Date:   Tue, 15 Feb 2022 12:52:09 -0600
Message-ID: <20220215185209.1046551-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215185209.1046551-1-mario.limonciello@amd.com>
References: <20220215185209.1046551-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e31b72-0c65-4f4d-8064-08d9f0b4cfe0
X-MS-TrafficTypeDiagnostic: CH0PR12MB5153:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5153CE630D9AD05229EB4CE4E2349@CH0PR12MB5153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsGG+lxDvGj335OumbfXg1ovnko1XtxKoGnGvwz96y9gPeEopAdTBNb8m0bqCtjQsZVW/o/7EEd4jzeotPgdM1TR/hmDf16AEhc1sGljGc8b6WXieoOo7NPY4qgNXy7enhSE7bfnM6CbqQ/tLnOSsyF1LFrh4H+gi2JsojdlSBr9k2jeKigoW3j0dow2AxZEDd8xXlTIkw708+1yhj7HUe8Xg25zICvI0gQvAzbb5kv2WqwaM/IdvLtadAwAacaaKt3I5m5WX6DGVj8vi9klYYwJT7dtpiqywgVIQvi7TBOnercna8zh+ZJ77juYOTSJ8IR/9tY9fuY15IRm1IbzNdBjBLtDZiL0XFtzShecXxlLff5UJL8g3pbBE6uYwdqYCy6eQThMzs9YmoMG0cOYe8GkHWpPcvhQCsBqV+KLxdRWuUguXFTkBxLoKBYS8ZWtGcCktvZYFL7pGb1HDJ4EzjUq990bpcmLTmZJ+SQh6HWNIrM7paPZMkBvDvcxICjfUzk1ycs7GBFrFYWGlDCscw7nGHW/WRBolpdzzBG28QEO37TGusBi73SbXIjFPw2PBqm7RdeNzpBtkSUAZiW0izrWZ55QV9q+fAlBJDVi8hhib6c8afScJvGjSuublWHxDsx76/s/tUPJ25yWyNVjJ1S3PYz6YLJ//P5P4lTllPLOq7Y81f1/ZW2XCiZv4nVmVcQJvqBglqs58z7hGOSOrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(2906002)(2616005)(4326008)(336012)(426003)(16526019)(70586007)(70206006)(8676002)(316002)(26005)(186003)(54906003)(86362001)(36756003)(110136005)(44832011)(81166007)(356005)(82310400004)(83380400001)(47076005)(508600001)(5660300002)(40460700003)(36860700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 18:56:02.1230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e31b72-0c65-4f4d-8064-08d9f0b4cfe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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
OSC and this leads to some problems on some AMD platforms in certain
configurations.

The following notable capabilities are set by OSPM when query is enabled:
* OSC_SB_PR3_SUPPORT
* OSC_SB_PCLPI_SUPPORT
* OSC_SB_NATIVE_USB4_SUPPORT

The first call to the platform OSC returns back a masked capabilities
error because the firmware did not acknolwedge OSC_SB_PCLPI_SUPPORT but
it acknolwedged the others.

The second call to the platform OSC without the query flag set then
fails because the OSPM still sent the exact same values.  This leads
to not acknowledging OSC_SB_NATIVE_USB4_SUPPORT and later USB4 PCIe
tunnels can't be authorized.

This problem was first introduced by commit 159d8c274fd9 ("ACPI: Pass the
same capabilities to the _OSC regardless of the query flag") which subtly
adjusted the behavior from 719e1f5 ("ACPI: Execute platform _OSC also
with query bit clear").

The OSC was called exactly 2 times:
 * Once to query and request from firmware
 * Once to commit to firmware without query

To fix this problem, continue to call the OSC until the firmware has
indicated that capabilities are no longer masked or after an arbitrary
number of negotiation attempts.

Furthermore, to avoid the problem that commit 159d8c274fd9 ("ACPI: Pass
the same capabilities to the _OSC regardless of the query flag")
introduced, explicitly mark support for CPC and CPPCv2 even if they
were masked by the series of query calls due to table loading order on
some systems.

Fixes: 159d8c274fd9 ("ACPI: Pass the same capabilities to the _OSC regardless of the query flag")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/bus.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f0f9e0934c10..0efd23aea171 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -297,6 +297,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 		.cap.pointer = capbuf,
 	};
 	acpi_handle handle;
+	acpi_status status;
+	int i;
 
 	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
 	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
@@ -332,10 +334,32 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 
-	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	/*
+	 * check if bits were masked, we need to negotiate
+	 * prevent potential endless loop by limited number of
+	 * negotiation cycles
+	 */
+	for (i = 0; i < 5; i++) {
+		status = acpi_run_osc(handle, &context);
+		capbuf_ret = context.ret.pointer;
+		capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
+		kfree(context.ret.pointer);
+		if (status != AE_SUPPORT)
+			break;
+	}
+	if (ACPI_FAILURE(status))
 		return;
 
-	kfree(context.ret.pointer);
+	/*
+	 * avoid problems with BIOS dynamically loading tables by indicating
+	 * support for CPPC even if it was masked
+	 */
+#ifdef CONFIG_X86
+	if (boot_cpu_has(X86_FEATURE_HWP)) {
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_SUPPORT;
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPCV2_SUPPORT;
+	}
+#endif
 
 	/* Now run _OSC again with query flag clear */
 	capbuf[OSC_QUERY_DWORD] = 0;
-- 
2.34.1

