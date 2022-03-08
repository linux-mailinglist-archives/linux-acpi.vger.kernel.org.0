Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293344D2476
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 23:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348727AbiCHWpp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 17:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiCHWpo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 17:45:44 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF603593BA
        for <linux-acpi@vger.kernel.org>; Tue,  8 Mar 2022 14:44:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7Am3qIeX5rdw7Sc1c/+g6lPJbLbhdC/Jp7cM6j7bUc7ziHMYEy3NnTT2Xx1YkXXTveZ3U0zVX1516iDMrQIVuQBrKWPXkoEhVoRnoU+39RHMx7DNYb5wEevl7psgj2YvzhWKlesLCGjwFoDGLiCurKiBWZFCoI8+CPICKrHPPDC+BYueKiUuqbhBVDEwnmqJF1lKrZKE/sWFY9+7C0HLCz96C358NEqFqp6EqfH5Ar7vFK5vgoR/9ofAekz5BEpQjNCpA7HBdbcyV4hBGJtlmYWOtQTkCI+mdI2astRQk2LtKw44ZgKecXdsdpEqh7s9boZ4/YiCeD08ictQLm4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AISdV6RZC96O4iwcFYTA+0urZV5LCUHR6b6MB3OgChc=;
 b=BivpfCHJxsT73TzEFHSqTVpIhPCFw2UidBKRlhGB08GRNU6CX8JUlBkngDAuFJYXvjM4+KAAwf2aOKRcnku0eBy+C1tzi9GPoZin8pSc4vG8v1kJ9u/Dx9Q3Q6FyWdMkDw6mepnrW2hYNvrAehcdS3TB7H8iZIianjvYQtsxgi34Wpm/oYsCgBV4ryyP4Sf2bTIykuJiDh+BOC/zbRPgXvzcAEH38vVycioY8AFYTz1Z2HeBKZYsTGuzYNZmQDDppP13myZ9xTkFg4/a2MTg190ENTGpY+PLmESxhpZlL4r9vxP306LcVoU7yjvbSJnd7+nsDQlb1Az/lzwZlYBnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AISdV6RZC96O4iwcFYTA+0urZV5LCUHR6b6MB3OgChc=;
 b=IQf7X/0Tn0ivXp+eCgwnEmvRnAiiaO6pDccrARE6NWXr2/nz4VdFOn1QCf+ooDSffwpIazISQ++8LRXojaT3AYh5uf/0ChTEeAjQcJR6oZDXLXZq02dI914TyKGeGdf0JgEslBUcuGB3fhl7xZ/75qleqvPGbTNmHhfoK8c15iQ=
Received: from DM3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:0:50::24) by
 DM5PR1201MB0186.namprd12.prod.outlook.com (2603:10b6:4:4d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Tue, 8 Mar 2022 22:44:43 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::12) by DM3PR03CA0014.outlook.office365.com
 (2603:10b6:0:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 22:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 22:44:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 16:44:41 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] PCI/ACPI: Add support for `AE_SUPPORT` in _OSC queries
Date:   Tue, 8 Mar 2022 16:42:00 -0600
Message-ID: <20220308224200.2691564-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dbf800e-89a5-4e9a-8a17-08da01553cb9
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0186:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0186F42E5C80994C76696AA6E2099@DM5PR1201MB0186.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rg9ebe3e46p4Qu36ClnZJinXPVm/JW7PUL4RYLX/Iqx8QHoAc1zE4d/o5wgnULtd0aMFO7X30P3Gk38ny4W/38ufr862wRqvtvFYh71Ft/upkIFEi4GISInQVlaqiASvx0wV/PI/CKb56uSwQhwHLD5JJGpyq+qaB07BSobdzfB/B/7JnQvG9wWfZVct2m7BTC0eDdA3Uj+oDmHti2vL89hraxraZKXjbJ45nNAjTgEu3cTv+iZlWOxyptvvreeygjIVAjGGlhogiUdnvZIplBqAEeDbeOWMEfhb8V3F6GqNhohpoKN1FBySaBfoJUpQpyDReE8Wuooc3VMnJv5+IDC48wawAi6IPrmsMSL9lKVvm4Vj1JD2RDeRtof3+ex1e6AD8bFiGSNd3bkuglfCNsGxLj4L5+eFDu8hth65GTT3DjmTnrLmR7SxJS5iSd8WzTyomfiZffnxRw6JoG43ozuw6McTFbFr91CFgn3ONa29zISNin+89FJ3+0fevkFktGmt/yLfa8+W3TProdvgzAQ2DH+6fzYPiHcC0YEqSQk0e1maaglsUW5k6MhPKRGtHrZY1T/qKEPUJJgNC8pb9gEdF4WR0zPM9r+fh7MZU++sJXIrN9+LcKBxdYhhWpjMEJJlchIA4OxiyMj5b8owcbu2slgfztx3cE9K7cs4VVjHGfPZlSU+4ob1ryKl8xq7INZ42l9GpPgQkgtBOR09xzpQJAFqydE0pkVf1TUQP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(2616005)(336012)(26005)(81166007)(110136005)(82310400004)(356005)(47076005)(6666004)(83380400001)(16526019)(54906003)(1076003)(186003)(508600001)(36860700001)(36756003)(40460700003)(86362001)(44832011)(5660300002)(8676002)(4326008)(2906002)(8936002)(70586007)(70206006)(426003)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 22:44:42.7893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbf800e-89a5-4e9a-8a17-08da01553cb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

commit a412caea5a2d ("ACPI: bus: Allow negotiating _OSC capabilities")
added support for `acpi_run_osc` to return `AE_SUPPORT` when negotiating
an _OSC.

This was fixed in other kernel consumers, but `acpi_pci_run_osc` was
missed.  Update the function to detect when called with `OSC_QUERY_ENABLE`
set and attempt to negotiate up to 5 times.

Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Fixes: a412caea5a2d ("ACPI: bus: Allow negotiating _OSC capabilities")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/pci_root.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6f9e75d14808..2eda355fde57 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -171,7 +171,7 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
 static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
 
 static acpi_status acpi_pci_run_osc(acpi_handle handle,
-				    const u32 *capbuf, u32 *retval)
+				    u32 *capbuf, u32 *retval)
 {
 	struct acpi_osc_context context = {
 		.uuid_str = pci_osc_uuid_str,
@@ -180,7 +180,26 @@ static acpi_status acpi_pci_run_osc(acpi_handle handle,
 		.cap.pointer = (void *)capbuf,
 	};
 	acpi_status status;
+	u32 *capbuf_ret;
+	int i;
+
+	if (!(capbuf[OSC_QUERY_DWORD] & OSC_QUERY_ENABLE))
+		goto skip_negotiate;
+	for (i = 0; i < 5; i++) {
+		status = acpi_run_osc(handle, &context);
+		if (status == AE_OK || status == AE_SUPPORT) {
+			capbuf_ret = context.ret.pointer;
+			capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
+			kfree(context.ret.pointer);
+		}
+		if (status != AE_SUPPORT)
+			break;
+	}
+	if (ACPI_FAILURE(status))
+		return status;
 
+skip_negotiate:
+	capbuf[OSC_QUERY_DWORD] = 0;
 	status = acpi_run_osc(handle, &context);
 	if (ACPI_SUCCESS(status)) {
 		*retval = *((u32 *)(context.ret.pointer + 8));
-- 
2.34.1

