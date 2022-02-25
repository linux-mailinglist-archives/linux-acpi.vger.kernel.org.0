Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E530D4C3E16
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 06:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbiBYFzd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 00:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiBYFzc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 00:55:32 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E541E503E
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 21:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6LYksktbRT3SRe04MNNg6b0uy5BWT2Qp/EDJ5u2tkVEMY+zod0YUDRQZ+J9vioyiLRNfep5QRcAZBFLOFpqHlmXnrbRdiL6Za5dylEAbOAbuWY7428Mj6oEPhmQQahxfxQDhU+AuBYyagMydfcO1zudsGuBA/bNmxwutH3VLK5Ai76LHFDeY+DBSLdztugsp8ShzfDSajZrE4lt+F5ku2aeWUu/qYgIfKno8HwGVFPMaOmXm6/WK5xnlZNzbLJSgDzvnmNRz51rxGO3kgjpBjHaz5zfLJtNmzybGSMIgvpIiCTnad55gRmJt1OV66Wdwz5C3qcnW7xuHA+3bmdABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNG2JKMGuoBq65ORMwgFZ5BvB7pV2aaxZrwKdR3zEGw=;
 b=ZWQghx9PJ1e4l3CpHMO8EW2MN4V+tisecVBnvzJ/SpRwAEWB7JKYHEHiiCsbMUBMvho1A/nUW3g9ygZrlLZE5SQHwrrlLkqfcbWoszGCtoG0HducW1UK3YP1iq8lVhFnWCtr3EcBMnHBR/M/4u/dqhInVUWlLTM2fOveF6JV9QTznZqsO/XL6G8PUtvcrf9eSLfPunKN7xs0RtOo9MDPeMrIAyHEBCKkCUu6GeYfT5LwPSP+aDKoa4h7phIx97pbukP5z8u1RSlg8shMVsEbhGt+esIJ0BO5qFcQUZ1sd1vREYaPhU75Rgk7IIOkRN/qznGu87uPO0Qfk0lxQNuCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNG2JKMGuoBq65ORMwgFZ5BvB7pV2aaxZrwKdR3zEGw=;
 b=unjCj3dKanSaa4AhlgekmaLzuhw50VYO8IH9IeWRi3RVXIfd4aifpPhKiGYuOLHrD6RHBpmKsN+MhpCrm31sF7+BHbxq9agbBugLR4x15dXq6JmbOmHPd0TA8LuhEK7pgCF41QoHdVs58p+lRM1Y6MsXgdbWZxCca06G2g6jRro=
Received: from DM5PR18CA0085.namprd18.prod.outlook.com (2603:10b6:3:3::23) by
 PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 05:54:57 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::38) by DM5PR18CA0085.outlook.office365.com
 (2603:10b6:3:3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Fri, 25 Feb 2022 05:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 05:54:57 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 23:54:53 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v2 2/3] ACPI: bus: Allow negotiating OSC capabilities
Date:   Thu, 24 Feb 2022 23:52:23 -0600
Message-ID: <20220225055224.190669-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225055224.190669-1-mario.limonciello@amd.com>
References: <20220225055224.190669-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 604f8db3-f2e0-46f1-d1fd-08d9f8235a47
X-MS-TrafficTypeDiagnostic: PH7PR12MB5997:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5997F21DEB371B4C2CB1D47FE23E9@PH7PR12MB5997.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1w41Ts0kxgtWuo1G1WKXvCy7C0I8/EthUQRkm4WWnE1VI8nXyqLX9OqpLjCO17v+hcUBxBxG4cSixbEvuVxePw0g2odai4+53NS7dDA9b5VkpMtCrLNXy4AmV6HZlyAoi58TlvkCzhwvVar2lM7xzP+jSb5bazVvnnrwSc3O4ulw20L5YQdX7UIKHysc2YQ+9HD49BuFYdrcnX6PAQUo0ofCdpEkIUxhyn/viPQlGg2pCHXQ5M3EPGRa0LjCkX0DgRP5xa68xwixW0FpRoOBVQc4zMEdeWdVpWsLY4+rj05zTv1/ffyrL8xMxCsh4ZlhhM3jA2Q3wX90d6Jo2pLsG64+jYW5l+OGW8XVn9sd2tR4CzYBRmPts6xBBZyV0RqY8lgdJxb0+WaE2LWTSVEZNA50MAafL0ISkjmGlspA+5N52wXquRyee17UwQTWcwCQrpn7ly/ACmFcz3Y7HqgoQtjzArvdnfUBuNgj8utcHBSbLRhHt75VfEsC8rjWQHo22zCLCttA8hPoDcerFvsrpxb6E7D3IX7eZlq1LZE7CztsVZ24qw3W3OLFghheIgdIK4NmUSNAFcRkZhjEcQ7+0LY3DTx6m3l90yh9WXCJP3ZPSFvVFL3dI8i1p6zunGr8P6hebDVOGmaU/LfY2dYVKzVg6h9h3OcVIrt84ljFEvow3DGhizo7ROeZSszH3G4FyUGQgs34MpJuiIRXOR7Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(4326008)(8936002)(82310400004)(86362001)(5660300002)(54906003)(44832011)(316002)(508600001)(110136005)(81166007)(356005)(40460700003)(6666004)(16526019)(8676002)(26005)(2616005)(426003)(186003)(70586007)(336012)(1076003)(83380400001)(2906002)(47076005)(36756003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:54:57.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 604f8db3-f2e0-46f1-d1fd-08d9f8235a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
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
 drivers/acpi/bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..f0f9e0934c10 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -243,16 +243,19 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
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
-- 
2.34.1

