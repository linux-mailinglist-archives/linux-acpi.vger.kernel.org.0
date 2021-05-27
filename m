Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83C2393115
	for <lists+linux-acpi@lfdr.de>; Thu, 27 May 2021 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhE0OmI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 May 2021 10:42:08 -0400
Received: from mail-db8eur05on2054.outbound.protection.outlook.com ([40.107.20.54]:44129
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229853AbhE0OmH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 May 2021 10:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dJcotVEDVC02D74EkvCKj4B0nZgvalm7dmolyD4Boo=;
 b=dn7cdu8e7rT/fUHncG7fmsxuh0tKTMQRyeSrZJo2WF4aI5JIZwvGQNiW6jnUNso149DMRBypPXXBXTNrxgrEKe26mbjM7Ik8SdVpXFVnRVhWPNfrTe4CbwflgIunpMcwnsVU9r4ne0wfTY6XMPs9R3RF43/NnPDRggpzaQTo1Mw=
Received: from DB6P195CA0020.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::30) by
 AM7PR08MB5461.eurprd08.prod.outlook.com (2603:10a6:20b:10e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Thu, 27 May 2021 14:40:32 +0000
Received: from DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:cb:cafe::3f) by DB6P195CA0020.outlook.office365.com
 (2603:10a6:4:cb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 14:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT024.mail.protection.outlook.com (10.152.20.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.30 via Frontend Transport; Thu, 27 May 2021 14:40:32 +0000
Received: ("Tessian outbound f02dc08cb398:v93"); Thu, 27 May 2021 14:40:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 82125a5a2dcd52d8
X-CR-MTA-TID: 64aa7808
Received: from a78b983f623b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AC3A6F18-5B01-42F7-9582-BC99C81F770F.1;
        Thu, 27 May 2021 14:40:23 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a78b983f623b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 27 May 2021 14:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bITp5XhPhFC0uycsu7BNFOPd4rf//Gyhq1Hbhoey1MTjeKwdDHDoYYpgIuW+c1fUNXT14v8dlVXDvKX8nwalPUXdJnAaPeOcmA2In6MK8Xwe8enUD2DyKbaprt7U4jdf2Sin4900+rk2smp1/rnfldbm/hPTSzjWkEWBQe1sFew/3jtX1yEdrKYhyUNF93uiM6ECCe+3CCxgQbPxQXMRoUOP444k1w+CFDPKPLn6zmvOp5yrBOTFTqHCYMvsWajxFvJCMYPb55yDGKwXZWU9tMATR7bUXatdbu69K7gw+0WuP3R77/DXlmyaXOp1TFaR7yfze4r3biaQm4lzv98yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dJcotVEDVC02D74EkvCKj4B0nZgvalm7dmolyD4Boo=;
 b=j2uOp+3TAAxbg1XYy9AUD0KS3HoawO47Km1zIPRD6JgCPN32r2efG3S7gFd3/8XIza31n0+EnJMF7vWkGaFVDtzo2RRZd5tAa3TtzNvJOCaWJo7+KBdJ+uP3b14wlUil3lTAS+SkIrTqlE/RJoYqbNLxMh85ATPNlDBzoL2CCG6ZnifmCK3XsItd/46WHpNFra3sgjMdI38hxJ26A4ubZBuml4anG2VNaAJk5RaCTelAagFE4RSX5kkzCCMBvOQMCgJ/FCoY72MYHdRhsbmfFgQ7PTNRzh+M2tISuSoeOi7b+Mvh03/s1zjaeicrljo7oVF8h0GogcV7C5H68LTBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dJcotVEDVC02D74EkvCKj4B0nZgvalm7dmolyD4Boo=;
 b=dn7cdu8e7rT/fUHncG7fmsxuh0tKTMQRyeSrZJo2WF4aI5JIZwvGQNiW6jnUNso149DMRBypPXXBXTNrxgrEKe26mbjM7Ik8SdVpXFVnRVhWPNfrTe4CbwflgIunpMcwnsVU9r4ne0wfTY6XMPs9R3RF43/NnPDRggpzaQTo1Mw=
Received: from AM6PR04CA0039.eurprd04.prod.outlook.com (2603:10a6:20b:f0::16)
 by AM9PR08MB6916.eurprd08.prod.outlook.com (2603:10a6:20b:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 14:40:22 +0000
Received: from VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::8b) by AM6PR04CA0039.outlook.office365.com
 (2603:10a6:20b:f0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 14:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 VE1EUR03FT016.mail.protection.outlook.com (10.152.18.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Thu, 27 May 2021 14:40:21 +0000
Received: from AZ-NEU-EX01.Emea.Arm.com (10.251.26.4) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.14; Thu, 27 May
 2021 14:40:21 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX01.Emea.Arm.com
 (10.251.26.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 27
 May 2021 14:40:20 +0000
Received: from e124191.cambridge.arm.com (10.11.7.12) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 27 May 2021 14:40:20 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <nd@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>
Subject: [PATCH v1] ACPI / PPTT: Populate cache-id from rev3 of PPTT in ACPIv6.4
Date:   Thu, 27 May 2021 15:39:55 +0100
Message-ID: <20210527143955.38591-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c71fe608-0b65-4e75-af2c-08d9211d61cf
X-MS-TrafficTypeDiagnostic: AM9PR08MB6916:|AM7PR08MB5461:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54619D86B291C9E6108883DF94239@AM7PR08MB5461.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9fmyo2ruDtnqR9Qc0bg8W7khiqVVULcRB2FqSCTRbWlEhjUsXbeyvrgfoke08WksD1U4WV+whtbGnPTvOCbbfb4yzS2CsszUxQtNyojcaMYqrAugpRzd800kjNOX4CceAIK56oVTSe81Db0HTjOTtu69+ltFWpdfo9HD2wLipNtTpgnJBA5nnEJYgRWmLPIW98cjJjyePAI6sbK/qOE1nrc16zC/kS+OHdMeFItKXJeoYZ2hsVTV0AGGxMYIngfWlqQ5Fv4huuNDALiBZeNZb0w85mSNreT92tjUo8GBRUMU94ZSSR/WQAvq2/ktPontsMtfNkmesvl91CQfmA5HMsmabjoVoYNacnog7SWqoNS7g6K48kauKpXU0Zr/X7OgAhK4dtCloOza56Q3it6sgO2pVIn78pHT35Qvj8ltCyTlYHYrzUh5BPKsU1uG9APmmX0PpcWqjRs50nFXe5MH+ipk0I2Jv3eHwxL/3HFkYfpNy7TxJz5hyGr0mftfA5aH6tvFSel1mxeb814qoPx5qXAP8Gqsd4sMb0HJ68bdq/4oOYRNfrxXufY9k/NVXz0/3uuHJcFqJDsowg2g/rZdVUtZCYNkdhaKc3o43SBnVG7Mewzz+k5BR2RS0RPbHbbmL24xaLeYxtEK+wC5UeMbT5u+Gkd4wntpcWL2JjSkYBM0DIqUPFww5Lkhlagi4/AZ
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(70206006)(82310400003)(356005)(1076003)(70586007)(82740400003)(86362001)(2906002)(6666004)(36860700001)(426003)(54906003)(4326008)(2616005)(44832011)(336012)(81166007)(8936002)(316002)(83380400001)(36756003)(186003)(47076005)(26005)(6916009)(478600001)(8676002)(7696005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6916
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8a3432c0-0c89-4251-2ab3-08d9211d5b3b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2XG83EV6EpWcaOhqQxKprUra3bSL/OxBBV2J9tGyNB1Yoy/869eAiUgpQP8O86i5MMf/GEPn1FtibfY96KCf92YKQN6LKWOoVQ0pPrFZPHHtZfWhWVje93NrJHd6pacHRXll7hvnjon0d/lpfui6wN1Sr49uIp6U3383YYpfk6ZVmLgoioXm4kOmQvupDgFxDP8wVOfv/xVsVpDiQKb1/YRpoP6Qig+9y9xdnYsnil5H9Pfo4JTU5imBJPn9zlpYRQ4gIfLrsSbXWU9OCv6TNVrmiUgUKII0OOr+F8C2p2rjTfnhVGlBPe1BAwk3GVip5tnSWlSZa4BCHi5XgJKPUNgHhHZedSm456PIUaGyHMxC6Ufq3v0eMgWyO+wJT0QBq89MFyQuMwSLBQTLw+SMNIg+Cs8BO2JcHTBlsozLEg9E0CTGkg+bNfXEZIyArYFJVUYgW95I5KKHHoiZgbT4p45JGlArH6TZMqJFcZYGhLlHb6h04i3cfEqTDzfdDurMBqt2dmkuLos84yyoWWgPEI4vlmnw4UepEzlf4UKxKGKha3JSygriPoDCaPeG44vD+cNmc0ZWlTZO1HE8oDyot/1W9u0xsk77680NMHYp7ZmqefFQCiMQN1udN42HehWo2MyyZaNKBi6u2hzVmbvTA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(82740400003)(2616005)(81166007)(478600001)(8936002)(7696005)(82310400003)(316002)(83380400001)(6666004)(1076003)(36756003)(2906002)(4326008)(54906003)(6916009)(336012)(44832011)(26005)(186003)(70206006)(70586007)(47076005)(36860700001)(426003)(86362001)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 14:40:32.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71fe608-0b65-4e75-af2c-08d9211d61cf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5461
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: James Morse <james.morse@arm.com>

ACPIv6.4 adds a 'cache id' to the PPTT Cache Type Structure.
Copy this property accross into the cacheinfo leaf when it was
provided by firmware.

This value getes exposed to userspace as:
/sys/devices/system/cpu/cpu*/cache/index*/id.
See the "Cache IDs" section of Documentation/x86/resctrl.rst.

Co-authored-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
---
 drivers/acpi/pptt.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 4ae93350b70d..c18a30154db5 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -344,6 +344,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
 
 /**
  * update_cache_properties() - Update cacheinfo for the given processor
+ * @table: The PPTT table - for testing the revision
  * @this_leaf: Kernel cache info structure being updated
  * @found_cache: The PPTT node describing this cache instance
  * @cpu_node: A unique reference to describe this cache instance
@@ -354,10 +355,13 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
  *
  * Return: nothing. Side effect of updating the global cacheinfo
  */
-static void update_cache_properties(struct cacheinfo *this_leaf,
+static void update_cache_properties(struct acpi_table_header *table,
+				    struct cacheinfo *this_leaf,
 				    struct acpi_pptt_cache *found_cache,
 				    struct acpi_pptt_processor *cpu_node)
 {
+	struct acpi_pptt_cache_v1* found_cache_v1;
+
 	this_leaf->fw_token = cpu_node;
 	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
 		this_leaf->size = found_cache->size;
@@ -405,6 +409,14 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
 	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
 		this_leaf->type = CACHE_TYPE_UNIFIED;
+
+	if (table->revision >= 3 &&
+	    (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
+		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
+	                                      found_cache, sizeof(struct acpi_pptt_cache));
+		this_leaf->id = found_cache_v1->cache_id;
+		this_leaf->attributes |= CACHE_ID;
+	}
 }
 
 static void cache_setup_acpi_cpu(struct acpi_table_header *table,
@@ -425,7 +437,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 						   &cpu_node);
 		pr_debug("found = %p %p\n", found_cache, cpu_node);
 		if (found_cache)
-			update_cache_properties(this_leaf,
+			update_cache_properties(table, this_leaf,
 						found_cache,
 						cpu_node);
 
-- 
2.17.1

