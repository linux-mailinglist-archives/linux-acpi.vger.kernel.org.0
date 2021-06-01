Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415AE397314
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFAMTi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 08:19:38 -0400
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:8357
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231219AbhFAMTh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Jun 2021 08:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoFovivM+yZj/KmhUyEeHd5Co/zh79b6a6gxdHojTWU=;
 b=WoMsOgKq3920xOT8eLwKPqBAW197WLdT/EP8THwb4zsH5TmXMIAzaMiLs+oiyAI9plnnkxzT0Ng/n2MmUc4/OD1npr4oWhJGW+NHW0Et4p14uzGk2P3RTY7kiKwKYhsh3GeaoBDoxOVp3OgB5WWo5LwFZxsLBIdGrjYstIwOJh8=
Received: from DBBPR09CA0017.eurprd09.prod.outlook.com (2603:10a6:10:c0::29)
 by DBAPR08MB5765.eurprd08.prod.outlook.com (2603:10a6:10:1ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 12:17:53 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::46) by DBBPR09CA0017.outlook.office365.com
 (2603:10a6:10:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 12:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 12:17:53 +0000
Received: ("Tessian outbound 836922dda4f1:v93"); Tue, 01 Jun 2021 12:17:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7d8ea6065947e6f4
X-CR-MTA-TID: 64aa7808
Received: from 9fad9f6c37a5.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9191DD0E-C315-406B-8E75-1C2683A85FF9.1;
        Tue, 01 Jun 2021 12:17:45 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9fad9f6c37a5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 01 Jun 2021 12:17:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8XwI7Th1IqsL3zf8Gjt9ZLdzyoAtrZXvgmZ4Ho63jw/JBKro3/mXm2pe2P4FqNacHyTGWPtWczACBi9YYEYbiQHaPkSFZgn8T4S6yJGXLIzMJ5OMvraETw04KtXtaAyxLYV0qkYLNJaGeb7i77DYl4z3zyXxGuaCx4IC2215mX1iIlTzOasMxwFfppR6JOEMbE+kdwK6CchvksQ2XrhLyd8BKLODKSr1EPdfbKbKEMD6Kld+UVflNHdDmdLiW7iGbqlNTZ3zHjl2CsD4nYJua73x3THP2a7GJMbYGUQmydVzahep0fGZ9htrSlEe5Tw3tZwvNvTQSmSAMDcNIvG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoFovivM+yZj/KmhUyEeHd5Co/zh79b6a6gxdHojTWU=;
 b=df6IPQqMMWlTVXHB5IvW6AehDe/iekTEw145rf3x0MiCNPKIHTKpWcCkFuIoA5nFWiEhRcYJ/xyTwKcPY3Ib7osiBXnGOEU0C9ItzASb+ytfW8Rt0paRaO3WbXp03N+5cCIL1kBAYAsAN6Z5zDpE7nkNoiVCUb2mOfwlGdTZ7SLSLgHBTumHsJgTCsXeSeHowu1VAYmFTYeZuuhn9PfsXJ4JWdP6buzX+uKX/Dy7kw2rE4OzWdY/5ToFKloxZ9xQHJs++B+Ho6gxppG5s/ryymSmWPctqE35KCJpgb4kfazMQ8mr+RQU6aAiqlzOMkgGyqnrg+/W/9mo7VeDgR/FRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoFovivM+yZj/KmhUyEeHd5Co/zh79b6a6gxdHojTWU=;
 b=WoMsOgKq3920xOT8eLwKPqBAW197WLdT/EP8THwb4zsH5TmXMIAzaMiLs+oiyAI9plnnkxzT0Ng/n2MmUc4/OD1npr4oWhJGW+NHW0Et4p14uzGk2P3RTY7kiKwKYhsh3GeaoBDoxOVp3OgB5WWo5LwFZxsLBIdGrjYstIwOJh8=
Received: from AM7PR04CA0012.eurprd04.prod.outlook.com (2603:10a6:20b:110::22)
 by AM9PR08MB6722.eurprd08.prod.outlook.com (2603:10a6:20b:302::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.30; Tue, 1 Jun
 2021 12:17:43 +0000
Received: from VE1EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::dd) by AM7PR04CA0012.outlook.office365.com
 (2603:10a6:20b:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Tue, 1 Jun 2021 12:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com;
Received: from nebula.arm.com (40.67.248.234) by
 VE1EUR03FT051.mail.protection.outlook.com (10.152.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 12:17:43 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 1 Jun
 2021 12:17:40 +0000
Received: from e124191.cambridge.arm.com (10.11.7.12) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 1 Jun 2021 12:17:40 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <nd@arm.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>
Subject: [PATCH v2] ACPI / PPTT: Populate cache-id from rev3 of PPTT in ACPIv6.4
Date:   Tue, 1 Jun 2021 13:17:35 +0100
Message-ID: <20210601121735.53695-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b6010e-9ae9-42fb-8cef-08d924f7483d
X-MS-TrafficTypeDiagnostic: AM9PR08MB6722:|DBAPR08MB5765:
X-Microsoft-Antispam-PRVS: <DBAPR08MB5765E88191BB9EB8CFBC2497943E9@DBAPR08MB5765.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: r3fTALrvOBzya6RUfZMxHTQiPklDt4n/aEzln75qg+OKw0yRzOtw3izyyp5EUODrblDb8h0WTTriyax1JDQS7SRlJ1DOvLsKZebOw/Jaoqip+vijs2NEcm7Gpyrtz+lJfio70cnaczZlONRYSWiT6Ll1BiB+9GOzrMIUCWAZad16QNn745I9ef9tZ3nL94XziBzx7aKwo/q7jS2IyWmIq3UTQn+dfoW4/l3EzGtOd4xUCcupvod1EeIQyvKACm9CxErnG8Ru476b/taJsdOvbSEkkbOA5VVkmsIdqtdCC38KOY6YPXkdLi4iErAR+4gR8Rf+GbsC0V7HPHeeI9O8NgVTK7LmZv+MSiQ33Af43S222iPbdLxKbJenFXfL6eQfmZyQIS5TQ8G5eg+zzsMg9JFCRhmuq+Vk28Q2QHMkveVhD/guW29nTDmiozSEKPsW+H2VHyt/VojyYS3v3PgTLM/JY/KBgI2ZBwmCyrjoYYRUi5HCQcx/DeYgrlwl0mJ7Jl4ofse+Mx1CMUNmJE1djYaSiGT5z8ecT+nbt9FUas8Ppeaa4Pc2l2m7BZKb7iWR2Z/WEWZCEpZB1F9yAVw4DAbm7bl4NHkkDHvM2y3zDppn+j+kqHrG0pNfaSih5y8bMf/EVYCk58s6Bo+uOTAPaG9Z20fELrXtpu705ZOdQSQDwUZdFDT1ITwi4Chziwweia0mRzo8uviKfzwDTNZCnk3dq9xdSaT0nUYIZs7OBTVLQjz1YXE/IEmQDKsDKp2qT+rJtzoSYsYCCk1fyNxHH1I7VbDXVOiGXtpTVcH8O/dt3ExBLxt9TZcYzKx9kUeS
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(46966006)(36840700001)(7696005)(186003)(82740400003)(1076003)(8936002)(86362001)(4326008)(26005)(6666004)(8676002)(44832011)(356005)(336012)(478600001)(47076005)(2906002)(36756003)(82310400003)(81166007)(316002)(54906003)(5660300002)(426003)(83380400001)(36860700001)(2616005)(6916009)(70586007)(70206006)(966005)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6722
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4cd94756-328b-4bef-4da7-08d924f7422b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1pixdbIeXdQob1rA75RmT43RR+GZ1braIGO+fhhZJhGmaxiao7IpGY4wcHak9DF0uy57XgFsCvnYp/v8BENs6idKadcgd8QizCabi3dW7O28d6+BR0S66abpKsETgcJqbOQ9gVlN+6bBM5rtkyVH0n/UdMXiaR5F4E76hA7merOSEqcyUyif49SINgewFSjrVJNnaROI49NNV1ZSAdOHysWwQLBaYup3H7taBKTpPh32M+fIm8l8uVQQ9PsWE7KukBMoMG3hQSMAd3uJ3DiJMDlM/ticA9QuXhNfm4U6zeIWT81SjmR++CZIj1egFXQ0maVSIjweu3Lc3fb9OC4ICO+KZX1brjOcBbJWaEugJslGMj2v/LhqbNVS6P1jS1biEYbO0xiTcrlvtCrQNrEeJjhVRq2p5g5NfGh9RkTjNhDMgbtoYZ3zZHh8cktP+0n9PTvsOh8uJtKiUAq8IF7+krqr6y/eLyQYWbv4hF5cbWZbqAy48c21lvsHZxR9bblNOUrkA2Kd4HjDTiGhBP3H/gwR1I709HKxgmWkJYQy2Pve7D9fCC+iqCjIgqQTeL3C6wjKwRiwkZldxKkMSV06fv2klnH1xtupq6Iue5lnoIJPybbETKsiwTIsyeWVvoW8af8Mzoa9KUhhN2GXVyajdpZihmJixoRzohNE3s5nKOn+xMby31f9vMtS/HY8vzCBiKebZCCgTGIR5stCTLvGcwt7s+q1Zm2ptDiI3NNrX8PtVjRXn7xiMKbu6/Az1EElHTNdrtPqYuggAwN7qgLqg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39850400004)(396003)(136003)(36840700001)(46966006)(966005)(8936002)(478600001)(6666004)(82740400003)(2616005)(336012)(70586007)(2906002)(6916009)(36756003)(7696005)(47076005)(186003)(426003)(81166007)(82310400003)(54906003)(36860700001)(26005)(1076003)(86362001)(70206006)(8676002)(316002)(44832011)(4326008)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 12:17:53.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b6010e-9ae9-42fb-8cef-08d924f7483d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5765
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: James Morse <james.morse@arm.com>

ACPIv6.4 adds a 'cache id' to the PPTT Cache Type Structure.
Copy this property across into the cacheinfo leaf when it was
provided by firmware.

This value gets exposed to userspace as:
/sys/devices/system/cpu/cpu*/cache/index*/id.
See the "Cache IDs" section of Documentation/x86/resctrl.rst.

Co-authored-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
---

v2:
- Pass `revision` instead of the table to `update_cache_properties`.

v1: https://lore.kernel.org/linux-acpi/20210527143955.38591-1-joey.gouly@arm.com/

 drivers/acpi/pptt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 4ae93350b70d..fe69dc518f31 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -347,6 +347,7 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
  * @this_leaf: Kernel cache info structure being updated
  * @found_cache: The PPTT node describing this cache instance
  * @cpu_node: A unique reference to describe this cache instance
+ * @revision: The revision of the PPTT table
  *
  * The ACPI spec implies that the fields in the cache structures are used to
  * extend and correct the information probed from the hardware. Lets only
@@ -356,8 +357,11 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
  */
 static void update_cache_properties(struct cacheinfo *this_leaf,
 				    struct acpi_pptt_cache *found_cache,
-				    struct acpi_pptt_processor *cpu_node)
+				    struct acpi_pptt_processor *cpu_node,
+				    u8 revision)
 {
+	struct acpi_pptt_cache_v1* found_cache_v1;
+
 	this_leaf->fw_token = cpu_node;
 	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
 		this_leaf->size = found_cache->size;
@@ -405,6 +409,13 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
 	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
 		this_leaf->type = CACHE_TYPE_UNIFIED;
+
+	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
+		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
+	                                      found_cache, sizeof(struct acpi_pptt_cache));
+		this_leaf->id = found_cache_v1->cache_id;
+		this_leaf->attributes |= CACHE_ID;
+	}
 }
 
 static void cache_setup_acpi_cpu(struct acpi_table_header *table,
@@ -425,9 +436,8 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 						   &cpu_node);
 		pr_debug("found = %p %p\n", found_cache, cpu_node);
 		if (found_cache)
-			update_cache_properties(this_leaf,
-						found_cache,
-						cpu_node);
+			update_cache_properties(this_leaf, found_cache,
+			                        cpu_node, table->revision);
 
 		index++;
 	}
-- 
2.17.1

