Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADCD4C8C03
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Mar 2022 13:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiCAMw5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiCAMw4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 07:52:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F699EE2
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 04:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajUzbf/dciPmgBJPSKdcw7GNCJMgb5qCycwwLV3RddJ6xZVN0gHNXd0GPl2qyCgKdeYEng8HAxeXDXrgQyiSf51A8qgUU3te5xbu+Xtp7dLYMBQ7Lu7pfCTkwt1W7Vz5+Ntrl8ZgieXBqJJoxGEZ17zTrSIpoWENxjlykBaAY6OJf3sitxm4nx24234OO+NBqQEdoXZ6ea1hwJEdXSqVna/L8k9uZoRHTew/V4TxvFwgp3MowLkU3y13w2O7XqtAKLY8vVP0pyQLiD4xW3G2zAJEdddFjfJlD9Uj1xq1+dLj76G2CuEOsD7XzjiJ39Qi9j6kneJ4/zTZi7/M7gDcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/XhbGxt4J+ZR9xQAFTF7NzE11yrUNjrYTFN6okxtd0=;
 b=He0/tf+Qy8uNLbTAb7QpfBJsEY9uA9zVjVa+jo7wmJMqB1TuRSqM6kzU0dwmr3/cYl2sjT/KTEyhYPOiPt/PX8IoMZ+pZyixqEGi4STsTkzzECYWIp92jKiH6oZvPNMaYRxAa+Y7GByh7UMGbfEea4QYsqyOzmHWCrQ/msweSYMhgLzioz0e3sY7xYNGgOYdpc68ZC+Z96QvdH/84PH9VqCuwrge2IxOCUJZr+nltnJzD6TBR8bDtT5sbgbn8WComDurjIHdGjb996XY+9nW8dma0YbmqIyZeReNoftMOIaF+aIJWswtlEcgIUoS5Fkvc7Z9Wm/HIJMs5Lpv8hHpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/XhbGxt4J+ZR9xQAFTF7NzE11yrUNjrYTFN6okxtd0=;
 b=aebaMBMK51oS2pjCykFyFSbBu8uw+zYPiS461aqfFNsosya3Jo3EKoAnpKLIDK5ba/4s/iru0Myh+glIAVi0ZMgrMlj1VbIZ1AmSTSrdlFZRM91RsZ2IFlhXb1N+ywEhCE1vXU2aZtjBavduCYhDemCB1BZHZ1/yzKzE0UcM1Ow=
Received: from MWHPR18CA0061.namprd18.prod.outlook.com (2603:10b6:300:39::23)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 12:52:13 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::d5) by MWHPR18CA0061.outlook.office365.com
 (2603:10b6:300:39::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26 via Frontend
 Transport; Tue, 1 Mar 2022 12:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 12:52:12 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 06:52:08 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        <Xiaomeng.Hou@amd.com>, <Aaron.Liu@amd.com>, <Ray.Huang@amd.com>,
        <hdegoede@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v4 2/3] ACPI: bus: Allow negotiating OSC capabilities
Date:   Tue, 1 Mar 2022 06:49:07 -0600
Message-ID: <20220301124908.1931221-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220301124908.1931221-1-mario.limonciello@amd.com>
References: <20220301124908.1931221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75bafc98-4305-456a-74c3-08d9fb824e2c
X-MS-TrafficTypeDiagnostic: DS7PR12MB5717:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5717D0DBAD416A26172515B8E2029@DS7PR12MB5717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vjorvpvRYvU3/FZYDacbqP1ooWBwtK9XqrqdvOy5zaDXOACCiXDmOPoRuNeDGM7OA28k8ywaCHBarZWo5Lh46iEBu8lywp982gPuzWI/0/oBmIw/sRcgPC9bZg2XKpRT5P8uqZZbat8NNUyu2zKlwLcZ6RFeGc4kI5kFcGtWwBDIHpaZX9xExW+NXMrbvsV/Vm076Bnj6w3+tTZgA8eNB8GPlJCoQ4Bvuj9wp+248A00cSUzEFveQfi5Zb4XXdtqcDSIvTlWmzZlKkYcE/4Mjvj9G4QcBQgm/Y1Q67pazaBS7npBjtvxr6/hnLGXMIvApUSTxiWcOHIkTnEWIgzD81eg1plFTI8wg4q/Tsyr0oCaeqluOH6nm/w5EU1SbRa1oi9uRkOUs56vklUaiWG2CWKNAsONwXb2AElVGbDROI/5fayEzfHF82/HMKiU3MvaznF9yDL67FAHUOnnousSv8Z2jUOW/PxhsxLzr+RqbMM3zHkESyC3ihhuvaFZSrhQrZymgF1uJIBpABmkWbHtIra047yNf1iYhIqb0e0LWnXvgmPUg/ztIhPLnj/6e2/Lg7mMdSTr0dZs+sYPd/5R0Lk+u10ZsbKoF+QyWEOQSdmV+ln3OIzdT1uVSyJ1BcYjaLJkhABD8uf1Gf5lX8VYsIfzp9ERObBFcDFJV35igxZ5LWvwv/vUcNMReg2yucX/rGoSJ88PPPVECyEFkheCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(356005)(81166007)(36756003)(36860700001)(83380400001)(47076005)(8936002)(44832011)(5660300002)(2616005)(1076003)(4326008)(186003)(426003)(316002)(8676002)(336012)(16526019)(70206006)(26005)(70586007)(86362001)(82310400004)(508600001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 12:52:12.3617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bafc98-4305-456a-74c3-08d9fb824e2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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
v3->v4:
* Correct kernel doc for AE_OK/AE_SUPPORT not AE_OK/AE_SUCCESS
 drivers/acpi/bus.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..302619ad9d31 100644
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
+ * The buffer must be freed when this function returns AE_OK or AE_SUPPORT.
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

