Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474824B7730
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 21:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiBOS4R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 13:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiBOS4N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 13:56:13 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83760DF4B7
        for <linux-acpi@vger.kernel.org>; Tue, 15 Feb 2022 10:56:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKrWZyum5aek8v7Pa1tDeZIDGNzL2VeJI1Byazd9uQzyjRN/OmPn72kIg2yi+AHinYMve1BjmjczzkvmebmT4OSoaRfLc/ias4JddC6xOAgEfMlyGGNMsBkT22AbSv4YkKk8CKjDQ8hyhLv7fBfUl80twP/G5v/NbL46+xHFBd3OgxexnBEbuXx1xFdpXkT30RQiMa1RpomFJvApidvrjKqqroMf6m4KeKnonN7fzxo6wdBqqJW4SVC8jnUAGs62FtVJ0ccVPG7M9J/BsThLZjIVeHnk9cKDX+zzoM66VOlKUpVdKsmUPZaRQO3zgugoGy0iHREHyoZIaw7CUNPYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNG2JKMGuoBq65ORMwgFZ5BvB7pV2aaxZrwKdR3zEGw=;
 b=YkU7cWBbQIObhRuxlR7DCvS1kzjJSK/ADcQrBs+wW7KsLUBqbG/XbcutXsAIAyfw9OUnpCIExhdprhMTUP5K9SRtttjpssezCeThwt3AVQvYbAOLkxxsnNYl2BH/5hNGezd9P/PvjVboZN6EQx3vuAHp+/KyeC9Ni2CMT4DIFW1ZGC1Wyc0qYHkV+IFws2i1jMvseunfXAMspKfMh1Enn7vDufs+I26R7wKFvJkToO/Drztw16m9WRFsZyvMzKaUitMlqZ8zEzr9UEPaTfKWsCDmQ37HdzPowpecgWjkuwIfx/TMAAXfkdBNGs/ZHBWqcpoBFEOKEH3nyXCH/d3OFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNG2JKMGuoBq65ORMwgFZ5BvB7pV2aaxZrwKdR3zEGw=;
 b=mJEOpPVncpebkwl7fnGr2plVuB8SeqxxSi0zgv3Le88yTFfNx3JwZAbfRFeYYDwAEsg8QPP5N8zSbI6BofJPUyWZvF0MrPiTmHJ1BwIkdmAs2tL+nbSU8ZdzLUkF+xGxcCq4g6EvIJBq4yPtdvHPvvQBNkhZ99aDWX10O/z7IvQ=
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 18:56:01 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::3f) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 18:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 18:56:00 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 12:55:59 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 2/3] ACPI: bus: Allow negotiating OSC capabilities
Date:   Tue, 15 Feb 2022 12:52:08 -0600
Message-ID: <20220215185209.1046551-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 376659fd-a43a-45b0-eecd-08d9f0b4cf28
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB27738017161116B838CE34CEE2349@BYAPR12MB2773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glyD6tZe4NyVx6dsAhrX4UFnO5PfSHBOWSqV+Tb2rYVmiRgqNCQ0VRHLMSKFHoc48MwQH7SPrOErUV0zGnJQTkqxUg7mgJ6YEGEP8Rnx6ApesVen1nOELrstC++Nqwifs1uw4r3URir35NOMzcG5++stKb5AU4zCq1TAQL74PGY0Heb8NtPeI99SW1fiAmzci9/VB+FIIzMZnFPRGUZzuk7V+PfoDd1aI2M5ITagZLVvyAqH5hy6697aTZmLom2X7nuMXsm4u4kLHJ0VoTRNRtismheWscPpAp1J+RB+N0010omZcgPpy29WSdhoQkBZJP6Bp6xoUv+LOHzbvXQz1t5teSqdNiIxN0fM7s3I0SLqxyzzGwSbM0uLUYvVYh3/z/Dwm78ERVTVKIrlEH9hUIV7O4DDnX6D33mie+w6wgDZgaohLMZGaRWrDv5stcckMFwm2vUcCARP/dXQP3QWknFZtZygMZBn6LZ3ZskLMRiz/7xx0WgUlaUgzkZ6oyPGZtGD4X3d/TCHQn8Jr04q5G2CWlni8ugcN32HXZOOEZh7ATlh4a6la8uQKT3U7SFK8DnEYWpw+PPSIT8PTJuca8K0b5Dw4A57OuhK9NKQLXZWFBgz0bIFth8BFTml487rexTr95FBJHV8/9ZKLlwcaMmq1a5u8KNN9pzhm7Mv7tAOPA11zmq2GueUVp00q5H37BOzkw6yJLsfVL9Pd5gKsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(44832011)(36756003)(83380400001)(70206006)(40460700003)(5660300002)(508600001)(70586007)(2616005)(81166007)(426003)(26005)(336012)(54906003)(8936002)(8676002)(4326008)(316002)(110136005)(1076003)(6666004)(86362001)(82310400004)(36860700001)(186003)(356005)(47076005)(16526019)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 18:56:00.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376659fd-a43a-45b0-eecd-08d9f0b4cf28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
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

