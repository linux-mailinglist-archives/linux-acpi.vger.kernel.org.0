Return-Path: <linux-acpi+bounces-1872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63DA7FBF73
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 17:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FAF281E7E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7959149
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zLHsTA18"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8348DA;
	Tue, 28 Nov 2023 08:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crjElxsftwl3v+4V2HMHlzUv2lNGJBKF+/fPIVUiz2YHppaFEuhBHLJpdjNN3T7faGCH3dyTExiO0BxSn0fQhqDaHCx6zBA6s1NwQxV1ziynxuhycqQDLVXRhpY7nR4y1UZAjK6yyM7iQCBrQrD3yvEwSrDV96z9g4EmCjCTpgQ0o6hwMDUEjGPIl9AYbDxLvhhjTSR7dhVdAoJkQU7SjBxwT3xoM8jCeTx/JRgsZ0d6vZYCLV+nyC4GMiSfx3/3Jg18l6EHWnpvbbcCPcLudMYAsYq51H+TBREHyr9tW1WuJaiBWpV5csbwWWDHVlUC/9SCSr8Xi2ySgLLll2Bbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpdOUavzoqSck9qktjmzFE/mPcGFPOTqpJVv7ck2n1w=;
 b=K4vbmVHME33CoaIe5gtF0NBtFyD8oW0mtspHbrPKfD1Jbcv0ahwfCSTbOmktHeDsJcN7cvxYxlzokXiWZoBR4KoV3aRdJyvvoWUgcjrwKnmkdIADfp9LeMvQGG7Rfet1tcHFyMKaWDTyKFH1qLcyelBb9OFWuveMrqu9xlhC+mC8IN61NzaE2OMvc/axFLsveR4rnMr24MKq8YD4zv1vbTyd2Rxwx7lKDq930iNF6lA8gbIhl6yQ5oiwfTl5YNQDeKnPHfL5n4o9siizxrzz/cH4be1YPn/UJ0MD3xuANLRXDz10GFC8flqaazdZPiKscG6eyRIRLpsuPmNBfL01iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpdOUavzoqSck9qktjmzFE/mPcGFPOTqpJVv7ck2n1w=;
 b=zLHsTA18qrfdQbR8mTNHu2ySQHrj5NMRXyD9KwMySiRK8OAA0y+twkARVg7sljPCZ7TFy5iZS+r3L4BvvcNXhzTIVyvI9CjiOys8U5p9GSv6ypyLPM9q26KTiSziaD8OBOtSgpXZEeOJLDt+Suykbzs8bklIbCGhdh2GBj80xY8=
Received: from BYAPR08CA0069.namprd08.prod.outlook.com (2603:10b6:a03:117::46)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 16:08:13 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::60) by BYAPR08CA0069.outlook.office365.com
 (2603:10b6:a03:117::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 16:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 16:08:13 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 10:08:08 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 3/5] EINJ: Separate CXL errors from other EINJ errors
Date: Tue, 28 Nov 2023 10:06:54 -0600
Message-ID: <20231128160656.166609-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f16708b-423c-4eb8-29e9-08dbf02c392e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xtjAwOR1okEFeUvySze1nwMYOPI1unPq3H/ucXGUjpiDki4+T4ilTZReVAIhXooDomu1AyugIwt3+hTvm1V9aUnUFy+BcB84wwV/MYy2peCgM4WwbRxywJmg1gt8pEI6BCl8oAUVzccXFrvggvN/JTm1EZfXPS/FuU+WDjj0cc2n5NYqZ0RIPFs+S4pMaaJbSPJFKj8h0ENeGoJocpIz/p50o40NT+1fmd0oQ93UZVU2J7vK7JtAqQiZab/SNN9K99fk7pKCr0j0zNbzbHISI5ASgDJDzHx1qCOLITYZ8+lwazKfM++XDAMMcDfA4U3dmwjVsvDY0gl4PfQgCoCAD+uHZF97c/QXQlDFMOSE40QeWnjsIwBfk7Eqsz/qR1iZuICfLyGdh/3zMXExgi1WmuvqJHxG1FbzUPj4530oTVv/J2HwkEgEz0scy1wQFhWESyyhHjo1yVFlpl7aUPDPyBmKBOKM0Qz1e0+qcU9B6GfPdOGPC9qmlYYKt1QCcAuo/MinD36W4MRkqPFNx6TYbMK09XaUUgrxaZ1vxPX6P6N1hhFVwedM9sM9DNIa+ITydIPKPZUMpEquSEZ74/tfEXMG9/Xprm3DVqQeUkANtZjU9NnX2zCqHkvqRQHzEVmHbWKtlk/W/XaYJSCQu0h2JJtEDPEjXS5lxFE5bSDl90iNiCr19kd6jvBa0ZA7rQbqwEeMVRF6rli6yi5UEDzGWNFRoI2DGKFzdFkrwr7bzxUq+y3QJ7BXIu4+mhJ8ycHdcUStlwF/09C5ujbIvnT6SQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(41300700001)(36860700001)(1076003)(81166007)(47076005)(356005)(83380400001)(336012)(426003)(7416002)(82740400003)(5660300002)(70206006)(16526019)(86362001)(26005)(2616005)(2906002)(70586007)(7696005)(6666004)(8936002)(8676002)(4326008)(478600001)(40460700003)(110136005)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:08:13.0829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f16708b-423c-4eb8-29e9-08dbf02c392e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003

Separate CXL error types from other EINJ error types and disallow them
in the legacy EINJ interface under /sys/kernel/debug/apei/einj. Support
for the CXL error types will be added under /sys/kernel/debug/cxl in the
next commit.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


