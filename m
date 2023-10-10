Return-Path: <linux-acpi+bounces-573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B97C415F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7DE280E9B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE8225B1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1YOLKyEZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33A2745F;
	Tue, 10 Oct 2023 20:03:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FD101;
	Tue, 10 Oct 2023 13:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxQBRBLE6GnNP6OpjS7T4genGJN7P57/YHuLq1THTLDzSrYQJXpNvoBL0HlXSQyv+fpvMn/RZN7QoH/Flz4VzI6+dYKs/zewyQkr4Ph0my/9eTbY7xKgO8Zp+KJzYZzKfmjuz9Haiw7M1TKFFxYiXMYim0UhYDrwEdN3F1Oe9SS9DcOc2kYQFHsMCrshl0fcTKw6HE9RfMVYXo/vDGwxzwMztXjURIHjOBG32n40+PhvWE9x7pyjfCT9pCYsm9gX8oq6e+Od/KxUyCKjFRgXVgVjLfRWDoMZ8/gdf0i+V4yfhWjNFzOiiruyCuSM9YGMdbN9ck1hgn9XKqYduC7t5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pwb5rD5rHeOk4Ys8jvsX2T9TXZ3zjdRZ3ky5mycVjM=;
 b=GWNSy9tRJ4SLJxNJdUJ3nK57TrVkCHpUOjHrJAmXTubdbgfMk6a4wljOJJsmzCzZoTQJYZ0zryDZoXKSxqnuK6CcxnQEW1avicWV7qfxu07XPeACMGsIldQBEj90UB3x7WC1KJfBpEmPytcWX8NOGmnCmPVWtvILu1tmHHOPNxIFP+fJPMbeYBzE0potCXD6QfdjZHI4lOuF+WWcJNjkBROgzjcXeTCCxFyMXhF/3194qU3k0wORkMTpjKIjDnTfoidgru9CsNUpi9t62WeVUQCX/SgzBe543dqo5vzZpATAsyfHSnjb8qI5pveos7ikkBIVorQfBy5mWuN/NcB2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pwb5rD5rHeOk4Ys8jvsX2T9TXZ3zjdRZ3ky5mycVjM=;
 b=1YOLKyEZU7K+hr21nvKBhx1TuNyt92X6K8g2KgafSMpyDKiR+7I9l80tLMppDCZa5yl6sYHgjrNdstw1vEYI8tNJ9hxg7GClAmMaZzzLPVVGFrIsY+Uqq1BXAXqhQhkOCPyRee+Ps3icCJTA33M8UNB7sBfHZG4MUqQ3kGX67GQ=
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Tue, 10 Oct
 2023 20:03:41 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::e1) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Tue, 10 Oct 2023 20:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 20:03:40 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 10 Oct 2023 15:03:39 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>
Subject: [PATCH v6 3/5] EINJ: Separate CXL errors from other EINJ errors
Date: Tue, 10 Oct 2023 15:02:52 -0500
Message-ID: <20231010200254.764273-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
References: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 361e08da-2e64-454c-ae8b-08dbc9cbffaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I8DJsY1GkPks3JAxu243ekhKPjPi9bm57PQJuC/U1ktV0Hr7jJTkyJNA8m0IsNOoCoZ+tT2kgS5Pzn+L2zXI07/mHnmdURlQcSHJHxKD0CZjm1WSwL4VJgoYyuqxrK4puX9LYf2DDgBit4a2q8wJHRq1NPul668tXcub0Op/qpQHf9l2MqqWc/yKefhYwWbvth/DMilbSnLZqspi5Uq+FbPy2ibJvKBwLSANjbZixnsQfPkQwdEsDBQmlmXpHWu7v6wxFQxfsVukzUY5hSiqlVTGqMcsi+G1IQT4I1lgA6z+njkxGYfCXfrYkXxMidw6fxSR6JMvqTvH4hSDFS9ACoj6jFnLY5Ot14ZpwCB0jSAIXMraL/b/3yOcZFiybPs4MiMuEU3iERILsa2lcuJA4YFHDmQt0IFxsOo8jV+O9D39qCrnj3dxLrTCprHOE3Ekoi8EUcHC/bC5TcUcdwACjHl5oNhajGofM0JnEOHDm95KpjH5IYMNw4ByjLgjfYwexlqEhXLG+enyPrDYA8NlpE+RmXE+kY15T+qoEkXQBzORDvj/cm8f9Y51nibU8zcFIchnXwjvlSfT3WiwdEHNNoCwYFyndoqNFoa/tiKiTFuqkNjCpd7hsLn8R3Eb/hacfqpW2ASsAQSQRh8jbGEFRdQf8BHTx178fqNOUGHrBOYz2rKpJn9nCW37sLYuvSxyZSozPeTGmwO47qRsLF0ZzFhXLJWR2h1cglEKNdwj5oUxZ8iYGDz0cVEopIY+JolGgwsaDivaAN/JMP+XbWnrqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(6666004)(1076003)(40460700003)(356005)(40480700001)(70586007)(36756003)(82740400003)(81166007)(36860700001)(86362001)(426003)(7696005)(16526019)(336012)(2616005)(41300700001)(478600001)(8936002)(2906002)(47076005)(8676002)(4326008)(83380400001)(5660300002)(26005)(316002)(110136005)(70206006)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:03:40.7367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 361e08da-2e64-454c-ae8b-08dbc9cbffaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Separate CXL error types from other EINJ error types and disallow them
in the legacy EINJ interface under /sys/kernel/debug/apei/einj. Support
for the CXL error types will be added under /sys/kernel/debug/cxl in the
next commit.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj.c | 56 +++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 013eb621dc92..330329ac2f1f 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -36,6 +36,12 @@
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
 				ACPI_EINJ_MEMORY_FATAL)
+#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_CACHE_FATAL | \
+				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
+				ACPI_EINJ_CXL_MEM_FATAL)
 
 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -537,8 +543,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	if (type & ACPI5_VENDOR_BIT) {
 		if (vendor_flags != SETWA_FLAGS_MEM)
 			goto inject;
-	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
+	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
 		goto inject;
+	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
+		goto inject;
+	}
 
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
@@ -590,6 +599,9 @@ static const char * const einj_error_type_string[] = {
 	"0x00000200\tPlatform Correctable\n",
 	"0x00000400\tPlatform Uncorrectable non-fatal\n",
 	"0x00000800\tPlatform Uncorrectable fatal\n",
+};
+
+static const char * const einj_cxl_error_type_string[] = {
 	"0x00001000\tCXL.cache Protocol Correctable\n",
 	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
 	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
@@ -615,29 +627,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
-{
-	*val = error_type;
-
-	return 0;
-}
-
-static int error_type_set(void *data, u64 val)
+static int validate_error_type(u64 type)
 {
+	u32 tval, vendor, available_error_type = 0;
 	int rc;
-	u32 available_error_type = 0;
-	u32 tval, vendor;
 
 	/* Only low 32 bits for error type are valid */
-	if (val & GENMASK_ULL(63, 32))
+	if (type & GENMASK_ULL(63, 32))
 		return -EINVAL;
 
 	/*
 	 * Vendor defined types have 0x80000000 bit set, and
 	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
 	 */
-	vendor = val & ACPI5_VENDOR_BIT;
-	tval = val & 0x7fffffff;
+	vendor = type & ACPI5_VENDOR_BIT;
+	tval = type & 0x7fffffff;
 
 	/* Only one error type can be specified */
 	if (tval & (tval - 1))
@@ -646,9 +650,31 @@ static int error_type_set(void *data, u64 val)
 		rc = einj_get_available_error_type(&available_error_type);
 		if (rc)
 			return rc;
-		if (!(val & available_error_type))
+		if (!(type & available_error_type))
 			return -EINVAL;
 	}
+
+	return 0;
+}
+
+static int error_type_get(void *data, u64 *val)
+{
+	*val = error_type;
+
+	return 0;
+}
+
+static int error_type_set(void *data, u64 val)
+{
+	int rc;
+
+	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
+		return -EINVAL;
+
+	rc = validate_error_type(val);
+	if (rc)
+		return rc;
+
 	error_type = val;
 
 	return 0;
-- 
2.34.1


