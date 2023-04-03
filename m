Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9386D4BA5
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Apr 2023 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjDCPTF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Apr 2023 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjDCPTE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2023 11:19:04 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9110EC;
        Mon,  3 Apr 2023 08:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd9gvF0Ouot4CUc+quE6jUMihd74MuPB1jcmz8qUgH73mcw5WYAPmKkkBm1a0E7FZwH5NJosMFS8rXSdg7r2wlvJmPwo+M0zaGho645mnjstJUKSLN91bN4/gGCZCDLG03qMI3sxs47Cn1K4qgX3yoYAttuk76pR0V5GG9jQ50iGMuHk80Ri+12o79JJGt1M2pKz7Y9DB0LkwZTMpwrGAKnX4xb03XdFdFblvJXqIcCZZrDBQQfqAn30Mco1yJcuJrtfNASmi5NSMerH1S8F/jGljB09HWSoM/Dqo1NmmRUMXjWu45uGISjmhhRNO0dElqFc9tQ0YIyw3IHLSJ8eOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYcGyNnrNB0terW7sh19ex2GgrzJNQ4v508hQn8rhd0=;
 b=MUrz37ik8Q0z5g1UwcNf7OB1SlNvgJ5UPsc25/+CiyZ+akBxPeXyF6PaBo24SMi8Wy1GbB6E3TlDx5QHS23E28AFaopTgS3hdCjgckdbLf7uQ1a3dr0yD0tgtDpqGHKtkymz7Z3fRaiG0J8rJZYaxrUrpbNtL1axCQcqR/bf4kxPWfObgBrveXjylu/wO37tGpFw8qE5BSGYFkH1f2SxU4ILxX44hMDqpYl02Zg7XsObTv+XLC9W89Tx7ibfRk7F8TpbsBbTZZx09HIZHv8Ow6CKounRcjJkNMwmRYyAoWCSMU3XSB6zX2Bgv6AmyjvEqAcz3bzRNmmpFruOjUqymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYcGyNnrNB0terW7sh19ex2GgrzJNQ4v508hQn8rhd0=;
 b=ii5lAK7V8K42eHbY9C85sGWUof6/HDuDUrAjWhHi85CIB+tuoMO6NB7ye24ncAMBNRHaEOnYC23hkgDdckmAFcDNkV6g2fAJIoBt6aIUv2fE0zE+n1vDfUyn9REcw854cFcMf0Xp2pNg84Iag9/vD62UI5rLUUmwNWFwTlEuASE=
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 15:19:00 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::c9) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26 via Frontend
 Transport; Mon, 3 Apr 2023 15:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.18 via Frontend Transport; Mon, 3 Apr 2023 15:19:00 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 3 Apr 2023 10:18:57 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
CC:     <yazen.ghannam@amd.com>, <benjamin.cheatham@amd.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2] ACPI, APEI, EINJ: Remove memory range validation for CXL error types
Date:   Mon, 3 Apr 2023 10:18:49 -0500
Message-ID: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a449a1-440d-4072-9eb8-08db3456c064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ydfj2hl4ZQDGWwLFQtSuMxXVtHozl8LdPDw+6pBfmMKB1h3P2hVdcWi1RaVhPVxBZLV3IrnUF/MNHi04BfkEMot7QFLkO9rG8CNqcIiAGD+ItWhzlSGjQQS82HmVHvbayh3/s50sdZTE9TQsXQN54Wq8J7CQRyvwzHUa8nIrrLYFwnG9P07bfcwpIHcEVFE/LVV8JLIKcTtO1x+dazpV8pzSw8bInbv59UsR5KqaqmIoQ+y8/H9g4bzBWcJbQ4KtEAo1Sm40xyjOdQkApBdgu/vByTcvlLPYQvozFeflLoGJViSqEG/4DiS7kacXq8IzgJcUynYChEb9+uHGua5VH1oUP7YL6g1cRCo5RA4qmAQxXGwJWLF/ZwHoHom1qkub7PDfDC3uhdcLIIM9Obu/Fs8dpf3uJ8OQl2ENwA5Qs1FEpR0NFs7PGNj28Up2wT9HQjvFPWhifj23MpIYoZ6GHqZnfiG4Vp2OKKVZkLgJXQQmLKKVJBz7YMMFRyUgqxhZzjubtfzNEKO4XcJhhXtT2IOVo4/oEfKtIKGA2CoyGHf2tY5Oy+coYc96rYNv3QB0MFTdEqrLYRj2vj5o6e502s4PngFZimpexvcs9CUZGqOFD+f6fAetT9qE5A3fPCcJ968CLMhl5YvD6A1UBrenWwn+jbSExOUN+6hZ11IDKNaKbfIovIc7VPSgMl5N9DDfFzFrQv5ZJmg86xOfnNXwkMp4eAAZVwau8cnHl6lcu+PLiocGeaqso1PIM5Fii52JWfpK5W8Ulad9K9bW85zGBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(70586007)(70206006)(40460700003)(36860700001)(478600001)(8676002)(110136005)(316002)(54906003)(8936002)(81166007)(356005)(5660300002)(82740400003)(41300700001)(4326008)(426003)(186003)(16526019)(47076005)(83380400001)(2616005)(7696005)(336012)(6666004)(966005)(1076003)(26005)(86362001)(82310400005)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:19:00.1302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a449a1-440d-4072-9eb8-08db3456c064
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

V2 Changes:
 - Added Link tags for links
 - removed stray unused variable

This patch is a follow up to the discussion at [1], and builds on Tony's
CXL error patch at [2].

The new CXL error types will use the Memory Address field in the
SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
compliant memory-mapped Downstream port. The value of the Memory Address
will be in the port's MMIO range, and it will not represent physical
(normal or persistent) memory.

Allow error injection for CXL 1.1 systems by skipping memory range
validation for CXL error injection types.

Output trying to inject CXL.mem error without patch:

-bash: echo: write error: Invalid argument

[1]:
Link: https://lore.kernel.org/linux-acpi/20221206205234.606073-1-Benjamin.Cheatham@amd.com/
[2]:
Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com/T/#t

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 12 +++++++++++-
 include/acpi/actbl1.h    |  6 ++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..68a20326ed7c 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -37,6 +37,13 @@
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
 
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE	| \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE	| \
+				ACPI_EINJ_CXL_CACHE_FATAL		| \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE		| \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE		| \
+				ACPI_EINJ_CXL_MEM_FATAL)
+
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
  */
@@ -537,8 +544,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
+		goto inject;
+	} else if (type & CXL_ERROR_MASK) {
 		goto inject;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 81b9e794424d..c39837266414 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1044,6 +1044,12 @@ enum acpi_einj_command_status {
 #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
 #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
 #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
+#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
 #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
 
 /*******************************************************************************
-- 
2.34.1

