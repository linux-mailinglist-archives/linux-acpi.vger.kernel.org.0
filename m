Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABE4C77DA
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Feb 2022 19:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiB1Sdt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Feb 2022 13:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiB1SdB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Feb 2022 13:33:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0602263E2
        for <linux-acpi@vger.kernel.org>; Mon, 28 Feb 2022 10:17:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgSxRXC74tBlKaaxbv5e5aDKUY3GOsr5bQ679aYOkZJzEz2wpFiEViXLPajIUQw33Y6c8XJrME048DQr0fuSTigQes7RYG/gSGv/udLIZXISH1LHHEEuqGLVGUKyP0xxHvYa7fs9lCg80q43rmwddPcC3r8kiL80zs9Pc6DiLWoYV627Hv0K6PWhCUVJ5kQTWMDuT9jaHfpMauk/VBX6Oxh4/zuLROyhsztOwwQ5Xt0QpVk2TXP3yExI/zIuebtC0/BCIWCb4TBPkBXiPRk6IiiMAhAYH5NvtOtEnxjduu9VdamTwRDJkWH27dTH5FUo9bNFLkDeSIv1MiaYSgALjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhSR6MCafjDaE9YhERaYdlPSYamQLRLVchwIxEk2CuE=;
 b=V2Mx+ACbskteZdeMpUUMmZ3rb5UmgZieuJTUcfaefwsXTCX070cNiNBnohMg1Q9RXgjKaaC2/+bdPdJXC6qRE4YQS4AFHWEVvpJ0JselUzjUxEQEP4FH+HbneDUeXqRbRDBXuVEWy4eZdTDdfNPxZjK9HeYbSpoIohpeFEQmRSsN/ZsKItGjPO1yy1ypCkL9gs9fkkDOlIpB2GOFitIPY3862oIyL+ma0LKLWs5D/gskcOsn50KxyoZ3wxuWpEP5RPxl6Zf1G1IBXixzlD5m2vuFnnwLW2JT3iOS7kiAjoNvl6GirUrBmHwU1M+4b0NfVe0OQzFhLqbcoO1yXC8q3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhSR6MCafjDaE9YhERaYdlPSYamQLRLVchwIxEk2CuE=;
 b=vG7V12vDq3Hw0OzdA7wOP8jIG23H33KAAtt4+OUfJuuvHZgSB48ACfKdYEjKxcVMeAAUFhC/09Kda0S0BLnQA4gSoDukcLRdEMmw2lpX7PJ9zl8vf0iiJWQMmseb5YwzuzwFJKGFKQBKLwFwqkMffoRNU1cwlReWr9YiZVeDINg=
Received: from BN9PR03CA0536.namprd03.prod.outlook.com (2603:10b6:408:131::31)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 18:17:09 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::1) by BN9PR03CA0536.outlook.office365.com
 (2603:10b6:408:131::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
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
 2022 12:17:07 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v3 2/3] ACPI: bus: Allow negotiating OSC capabilities
Date:   Mon, 28 Feb 2022 12:14:45 -0600
Message-ID: <20220228181446.1975420-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228181446.1975420-1-mario.limonciello@amd.com>
References: <20220228181446.1975420-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d957138-1fdb-46e4-d8be-08d9fae6886b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25590C96023187611239EADBE2019@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0Y1RMmfWf8p5JkQGCJMT5GHwnhMkGRWm8v5WIu1GrUMMO3QwEUsNR2Vuy8Cb8o2SPtd/NJmWUmTbT5c9U9hF8QeVuY6+i9SOkyT2KbErKxi7eYGopZlNNLHqTWlxIcaeb2SrMJ5Ix24R79HsodUK2wAJZ1SaeGj901MImgVDsVJSUFrmdHyak/OsKy+kOxpPERe0OwkBAGpBbAfBK/wRu24TBxecOjPryP0zU+LRLo5ZYEWNMV9AmUS5O9qo9oGJNoaeGtYKkbXqgXVae1yXmn+svMvYaGQ4zD9EaNzy50SQEMlMWk2UpV2lLahaPRhVugFGK2pHehPlwt1tdYYwco76XIsukFPYNcoUQkEJgAZz26A/g7oUZy21YM6W+ZFzDFuXjnk/K2jv1g4grnKZqzrDCX24EiRVuDJNZT9+BxT6LF3yNwnLWE+BYRIuk6/G0rtfxhLQsNuP9Qgfisga5E5RR3Dgi7htPMUgfgDpIsVl77jp4Cz1DcipcUjVAGJhXr06DTvLpbqEkBXvzOba0H1fpV9IcZRpXlxM8tg84429/UHbRzBl/dcMAyo02zMBKLxElaxzXRG7DzLlQ712M0r5xIyQtHZMSBIo9BYyDNp/uAk0AMceWDXFGnPIeDI6wv69Gi3f8c6eUgNDogHgNcb3NQaGHkGOfMTqOrJjDY0zQBfbC6gVL3axLLTSG9pNT2bCwO5908SbNdrQdzoog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(8676002)(110136005)(4326008)(70586007)(70206006)(508600001)(8936002)(5660300002)(6666004)(2616005)(1076003)(36756003)(54906003)(316002)(44832011)(81166007)(16526019)(336012)(186003)(47076005)(426003)(36860700001)(83380400001)(26005)(82310400004)(86362001)(40460700003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 18:17:08.7202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d957138-1fdb-46e4-d8be-08d9fae6886b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently when capabilities have been masked by firmware during a
negotiation with OSC_QUERY_ENABLE set they're silently ignored
by the caller.  If the caller calls `acpi_run_osc` again without
query set and the same capabilities, then they instead get a failure
possibly leading to downstream problems.

So instead when query is set return AE_SUPPORT which callers can then
use for determining that capabilities were masked.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v2->v3:
 * Add kernel doc for the acpi_run_osc function
 * Correct a logic error
 drivers/acpi/bus.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..81647591ec27 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -184,6 +184,18 @@ static void acpi_print_osc_error(acpi_handle handle,
 	pr_debug("\n");
 }
 
+/**
+ * acpi_run_osc - Evaluate the _OSC method for a given ACPI handle
+ * @handle: ACPI handle containing _OSC to evaluate
+ * @context: A structure specifying UUID, revision, and buffer for data
+ *
+ * Used for negotiating with firmware the capabilities that will be used
+ * by the OSPM.  Although the return type is acpi_status, the ACPI_SUCCESS
+ * macro can not be used to determine whether to free the buffer of
+ * returned data.
+ *
+ * The buffer must be freed when this function returns AE_OK or AE_SUCCESS.
+ */
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 {
 	acpi_status status;
@@ -243,16 +255,19 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 			acpi_print_osc_error(handle, context,
 				"_OSC invalid revision");
 		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
+			acpi_print_osc_error(handle, context, "_OSC capabilities masked");
 			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
-			    & OSC_QUERY_ENABLE)
-				goto out_success;
-			status = AE_SUPPORT;
-			goto out_kfree;
+			    & OSC_QUERY_ENABLE) {
+				status = AE_SUPPORT;
+				goto out_masked;
+			}
 		}
 		status = AE_ERROR;
 		goto out_kfree;
 	}
-out_success:
+
+	status =  AE_OK;
+out_masked:
 	context->ret.length = out_obj->buffer.length;
 	context->ret.pointer = kmemdup(out_obj->buffer.pointer,
 				       context->ret.length, GFP_KERNEL);
@@ -260,7 +275,6 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 		status =  AE_NO_MEMORY;
 		goto out_kfree;
 	}
-	status =  AE_OK;
 
 out_kfree:
 	kfree(output.pointer);
-- 
2.34.1

