Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B64C77D9
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Feb 2022 19:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiB1Sds (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Feb 2022 13:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbiB1SdB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2022 13:33:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D656370
        for <linux-acpi@vger.kernel.org>; Mon, 28 Feb 2022 10:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3h4jOXGhW2v/ouc6R9LfPym+hfGSdCivnCO/FHDLuuL5jkXD2qf6glv4fDL8zS1Ayj6zRh/rNMK7byvUhpzbNpeAZI8+Lb+MnzzywejRRJ8DVMX2DMSJ8jJni0VBFEOT0IjPt1y0qN0VJ23LZRDzTpDmjQoaYe9Cu268lbNvpeE3aihDGXv3d63Kn7PcMY+9F1ExkkmoQHmTs4wyvV5RAmbupc0PIG+gZy6FpyA8hWKJ5DdC4wyK2O6gmMj+v19POdP7Aa7CfEecTrtGBRZeuTxWlnZ73n4/leP4daAY7eBb1HwNl82gaejfER65eCSOqeWmKAtaTkQM5uZ9rsjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1viixYNsfeXcW4s8FAbBh3TKd7FXZx4YwLk6BOOh+9U=;
 b=gN6v8hg8e6e5fPZ5tfiTCAdDCOFz4oTEeAr+iAJU50mlSdOJO+CCuOBkwBLPeEfEG/bYdT5GkSGoCYGZOyRNjPwc/GKR1ImmDsUIQmRnSStNUwJ8iRKKXKtLMrsWNtCLimWAROtW/+GytqzRFCX4pxlXWUMBmS/whc6976+NlnV+7y7fKLWnqKg+55IiT3tNofV9NRWoaz04Hp7OduB5jHwO43SmY2gTScvKr8jp1YJjT8iTS1Q4xm/HkL+g8hQCtfwo9TDGe8TXOkoltAUkHCMU9QGUPbOHKCO21o/MsnDjTlAIvgjTZVrsepQzQs0yFzPN4hSAlIK6szigRmOaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1viixYNsfeXcW4s8FAbBh3TKd7FXZx4YwLk6BOOh+9U=;
 b=dO+wom/b/YfbWx8G/cUGVJi1Y/7I3F1tHI2YCjPMwuPn3FTMB3uAq8Ycs7/AApXohU7mWyfdIsRHjjeQFSew4MMy2pIjjVk18IhzU6hba42Y75+Y2sG5953xruTy1xUbAa73Cjj1qTPJvOoNLE/sZYWXkJXKgNeT/LsLoWCzbao=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by BN6PR12MB1410.namprd12.prod.outlook.com (2603:10b6:404:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 18:17:08 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::a4) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Mon, 28 Feb 2022 18:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 18:17:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 12:17:06 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 1/3] ACPI: APEI: Adjust for acpi_run_osc logic changes
Date:   Mon, 28 Feb 2022 12:14:44 -0600
Message-ID: <20220228181446.1975420-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6c68ab-5603-4814-7a4d-08d9fae6882b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1410:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB141076076AA11423E99607A9E2019@BN6PR12MB1410.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB2+gFpXbVMrO+yor73txxaOQLdOHl3gaF8Z51cn94r/9xm/aj9mdTBJYXflLeimviqNRPPPRSTrWkQ9DiVIQSlvB6cuFTk7q6sAfGcLxv0zX+l3VEuTjQ5fczbrWMerny64fUnu9snHQLSbR38wjcDuftaMDI/SpI3t9s4ZkCCTvduzZp4PJdTn1wd96GbnTWbnpYPVIT2wK9DfEbtwZAruD1H//xaazQla8ts+3iZ6uVzV8UncJvYavWDpd0e7QHLJ479orJF1AszCcA3OGkg7TD4qjeAWyvJ9v41tfRWB4ZHcw0t5sWyHOFIgao6xe840FQmmJNUVZqoQXynuiOCjg46b1FlT9F2rj3sVj50KcflIV6P2I8Nm/zhGl/JQM2bfDX57P5zCOFYwVsJFdBtfwaGBYw6gCz4EplGwlRYHuFe0/P6iJ4niEiG88pgcZ/VOuU0cFpWCDPo2NjOdx1fX1RauCLW28349d6bbuinmV7RI86euu5Le8O6msQHJwbiwQDadF+FvV39M2VRdqefElgq0c0gKreInHon5/I1JjKnl5/HZXlMGuAF3d82sqluCZxw9LzQwSpotfJUYKansUmwWPYYaa6PltKw8KDmG9Fpj0UPzOWMYcHkIg1TNa5j72PoWw7qjmdwYa+gDLWUjx3j0Z/loylMLobppBYmufxeGq6brsJp61V4mC04f8N2V+pOBMR2gtO3P9cyk3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(36860700001)(26005)(186003)(336012)(426003)(8936002)(5660300002)(44832011)(16526019)(2616005)(47076005)(81166007)(356005)(83380400001)(70586007)(508600001)(6666004)(110136005)(82310400004)(316002)(54906003)(8676002)(86362001)(4326008)(70206006)(2906002)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 18:17:08.2827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6c68ab-5603-4814-7a4d-08d9fae6882b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As this function calls the OSC with the OSC_QUERY_ENABLE set in
OSC_QUERY_DWORD, ensure that it continues to operate the same if
the function has returned AE_SUPPORT.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * Add Mika's tag
 drivers/acpi/apei/apei-base.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index c7fdb12c3310..f7d1aa687fd9 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -780,6 +780,7 @@ int apei_osc_setup(void)
 {
 	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
 	acpi_handle handle;
+	acpi_status status;
 	u32 capbuf[3];
 	struct acpi_osc_context context = {
 		.uuid_str	= whea_uuid_str,
@@ -792,12 +793,12 @@ int apei_osc_setup(void)
 	capbuf[OSC_SUPPORT_DWORD] = 1;
 	capbuf[OSC_CONTROL_DWORD] = 0;
 
-	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle))
-	    || ACPI_FAILURE(acpi_run_osc(handle, &context)))
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return -EIO;
-	else {
-		kfree(context.ret.pointer);
-		return 0;
-	}
+	status = acpi_run_osc(handle, &context);
+	if (status != AE_SUPPORT && status != AE_OK)
+		return -EIO;
+	kfree(context.ret.pointer);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(apei_osc_setup);
-- 
2.34.1

