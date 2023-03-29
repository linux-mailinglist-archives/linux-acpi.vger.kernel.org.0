Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4706CEBE3
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjC2Olx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjC2Olh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 10:41:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AB69022;
        Wed, 29 Mar 2023 07:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVVRyo1vnfuAo7J6SosCJkDtb+EUWajmgFXCYNiq/I1ymC2+6R1CnLwIhOLVLjyxyUTNgPQ/d5m8bN0cv8cY/pii1j3KNE1Rijnxlp0aRW+sQRWcz7HAw0r5ahP7x2y8DKs+IrRCfZLJLncuPJYSwpeSGjMaD2rY9dqf48D/JENA/CiA7MVYQDbZ6oqQwGQPugdm5BdGmjx/MIt7s9WZhkPyhss5CpbHAPgULyy3h9+NWPgc0WU9fUdP3zLFV7yBlbJ2qt8brxTsfEsjUr8Rkf38MmYAgigEKsp4Cuq29JXH13B0jeeBbd8/9JVk04zI2Tv2/DvYI5Gg34Yyrp3mrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk9igTeSgTDPHlglZHnZh5rKWmOSB0QPUu6IHTW4sXc=;
 b=Xr+s3h5zEHMXtyvdrmwb+m3FRnWxHbPiMlUzFt/H7Suh7gSOQtP+C4+JnPDjYiDG9Xctv6rc4bH/oe7WlhU5Rf7pRUOcpcazlpV28WtsH3OV2IcbEiISxxmiStA3p47ohVX/MYmpFJOCp7g/pt/M/W1S0Vl+3TslGGCQ341bGKYEHvrk0MATIhKMBBM7/h1nxLs/zfBVc01iPiBzJrWe/i66QxMRDgtDJBGBaUsjwd08Wht7RdQCMnlXeqH3KAD3P/RG2prCjuJJkwWUla8cURhnG/cahmBHIs4rBGf6dwsGsPVOjZkpX+L4Ky2Pp7dDlRU/Pa/4AvchuR2fz9alUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk9igTeSgTDPHlglZHnZh5rKWmOSB0QPUu6IHTW4sXc=;
 b=Kakkluqs189Taf1S3PqmvYyzOkKet0mkWTgoySzWX34NG1MeE/gLAUsa99/L2QIl28ktn9Q//LxarjtbRm7sElL5b0d8urtReIDtx8B599+jMHjAqpLbLbpRseu6K8KuOZk547YD7SL0b84kdblZwhPRZ1dGd9eLF2Y4uTl6hBw=
Received: from DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) by
 MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.29; Wed, 29 Mar 2023 14:38:23 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::9e) by DM6PR01CA0011.outlook.office365.com
 (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 14:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 14:38:22 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 29 Mar 2023 09:38:21 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>
CC:     <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <tony.luck@intel.com>
Subject: [PATCH] ACPI, APEI, EINJ: Remove memory range validation for CXL error types
Date:   Wed, 29 Mar 2023 09:38:13 -0500
Message-ID: <20230329143813.25849-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5981f278-4674-467a-fd1f-08db30633f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yeiNY1a2okM9l3XG1dRYzxL40K8IJVoVXV7XvVeYTO0XzTablzmbx2nfSg0PckfpPdaZzeeSnwXB0vz7jw9arrr1ofskGCqithnQUDuuTM+j1yzvmLGJMUCt0W6u6czE+EmJ7eDPieczjYj41tkXNmzHo+7O8i7zxpZWabEYkALr94/hkaBUjm2wbY63kJkQVPnoj0u6A3w38oW4W/q60d820i0Z2yck/SFW9HJNCUDGlSmGqVD7q1+pcOhniD79WkXeAP7QZef/nwuZEWBccESEEiNGIewaVM2oljvdjfSJaGmzfDPvowZBqiAsH3w8p/WI9aHG5+YAQUYYEgOz4YyNeEwT4+8RjzM1Tf93t7dXhzMkfJdb8NgPld6kxFLP4SJwByXm/aFYPy7pMs8zQWBfxhFHc6kX7ahDQ3aUHIovjl+RF+3X9d2jZZpK+b1gPZGRIR+GMP8zLe0jj06SRPBqnLXvaPqsWhaAQdBMqq/7H2eDNpYmQX4Qm/2pTDAhhgNIRm271nPz4QN7iypt5qAjkL0VG2Azr/rTBBOqJ7yrHbMgAz/6IWh3s4zWy7UExd8QeMOYYtQhD6W3or1KOgfIfGhMB1o4UOJuvu8TwfyEXR7uWlYVCCnViYlWMT5dGDCCScd4J8k+MeKPr4FoxeljE+ni7uUO2WR2T1r0yrjpi3WSaZ1LLMHfCv/kV8d8IvVMLdk8LPNbWV0OFZ90PFSxCl/moCvN+2A1OHyWm/AFRRhOxKZTTUUriYx2NeOPCuws/YpHaC/1BGmtJBtOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(2906002)(336012)(426003)(83380400001)(2616005)(86362001)(36860700001)(41300700001)(36756003)(40460700003)(5660300002)(81166007)(82740400003)(356005)(40480700001)(966005)(54906003)(7696005)(478600001)(8676002)(6916009)(70206006)(70586007)(4326008)(16526019)(6666004)(186003)(82310400005)(1076003)(316002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 14:38:22.9227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5981f278-4674-467a-fd1f-08db30633f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

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

# echo 0x8000 > error_type
# echo 6 > flags
# echo 0x3cd5d2000000 > param1
# echo 0xFFFFFFFFFFFFF000 > param2
# echo 0 > param3
# echo 0x400000 > param4
# echo 1 > error_inject
-bash: echo: write error: Invalid argument

[1]: https://lore.kernel.org/linux-acpi/20221206205234.606073-1-Benjamin.Cheatham@amd.com/
[2]: https://lore.kernel.org/linux-cxl/CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com/T/#t

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 13 ++++++++++++-
 include/acpi/actbl1.h    |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 82004abb9643..4e201dfb7d29 100644
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
@@ -511,6 +518,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			     u64 param3, u64 param4)
 {
 	int rc;
+	u32 available_error_types = 0;
 	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
@@ -531,8 +539,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
index 15c78678c5d3..68588b2be716 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -895,6 +895,12 @@ enum acpi_einj_command_status {
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

