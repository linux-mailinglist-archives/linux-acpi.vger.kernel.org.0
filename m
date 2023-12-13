Return-Path: <linux-acpi+bounces-2411-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9CF812193
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 23:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74361F2145C
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59898182B;
	Wed, 13 Dec 2023 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FTTmIBHZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DA7CD;
	Wed, 13 Dec 2023 14:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRs7Rz9lPv1Tk/xUJ0Ua/Wgbs+odMTv/cYb/qlUmW78iD/279L3rEVWphrrd1XCg+DSkC1zoPCPCvYgLc4A3DJYFo6PE0FTAdUpvzwoERfm0Ybsj9Z7g/AXQTap84e4fy/u6mo3bWYMXt28tMIoTcu20qNCNTanbLsDAMzElCP2IlDheLwK8gX5br1EOJ3sZ1zwSKaV3bso5yps/fI19VjEFYMgP7BnxJ3jgXmtqoXD4s673IFdtXBxOxJa4CXuEgDuUIIEn0dcJQC7nt2zZRyIUjYFF/qH7ug8l9iheB/Bro0MJEMl2v3TGirNkvzft3jCsfRNv1EnMX92z8RHa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7KmFurK05tlaO0Jo5x3vuDo/DG7ALfXDDITVqi4IS4=;
 b=KkJyK63ZOeCZIjvqsiK7xFL5YAw6TyMA7U99qTCXEsAFT2vDOrDZyQtEOCTbGAWutFmOdolZIAAcQaed7KdHgT/ilN7MyZXZWFwPMtCw0TdZ3MQKUsX3+tyvK9bHa9hYPoDzyhxMsX1hd4YOHbyAtY7PBAjxM5y0YA/nBBTwBiOIkdE+d7dcAI96ecsgdOlnI1MqFtHAKV+kwxFIJfG/ucL1q+rdd+BuLXMv3nURMGdYWaRaaN7UDYP2lrRGNo4CqNw8TUCEG74girF22RryjS3v/S4kTw4tlb+x9EXRqxzn35M9kq1y2+5lTPnvZGgdVrCYHvmyEuCkqezK1Uue2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7KmFurK05tlaO0Jo5x3vuDo/DG7ALfXDDITVqi4IS4=;
 b=FTTmIBHZc1VBOd0J7J67Bd21CzePi/sGjepUl6wOt3fW7BOS6hpHxpfNEKPdeVGH40GCr3zvotITX5T+ySgKctzlRXP4+4iVgb1R/zA6il5H1zQA5DXuT6bE7rQcafus/TGxZYweIiCkDA++i0Xjh7kbVVXMEXp/9USJIirnkCs=
Received: from PH7PR17CA0068.namprd17.prod.outlook.com (2603:10b6:510:325::12)
 by DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 22:37:28 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::6) by PH7PR17CA0068.outlook.office365.com
 (2603:10b6:510:325::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 22:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 22:37:27 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 16:37:22 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v8 1/5] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
Date: Wed, 13 Dec 2023 16:36:58 -0600
Message-ID: <20231213223702.543419-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 19322675-5b89-47b2-bb6f-08dbfc2c15d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SrAUKeN4/TjOueSgUQrCfnv+79gpatHmsGD2l4i0NVMAuCDzoHq7ESx1ZyhShbVaa8hwmW9IhbaCzgykuHeyQQLPoJiAGddFHYOSQ/35eZRWusoKGzRNmjs+OBp/8CidJR46gA0nLt57PcIL8fHbbXl+APG9VTqGiDxzt6JYJuWujNIcph4Qnq0KAJ/LzadyrLqVnafYEadHz5Clx256OeXUq8brYzNXk73BbWWVqoRKIZ15KTt6+NHWQt+Aax0g9IxSR0tWZXxXOvrRRviuqIYDC8MdhskHUK/Rld2yoxECiMpyBrXBXFOpfEtDaPc3UuP4KLsQvReAa1FHH6pzAP3MOO5q6R9k03vjmCDB/4ffZ3GvjX9EvwK39Vj4aLg750Z709v+b6SQls2UNNwzHMB/9vD4UvY/mdwc2Bv1VAQSxxOU9TloLu5JTzJaK7A1oOtcThIhzQiRZ9wvSKdbsDD1odXsi1/B5nSCKtbHetq1ONNB2F55zFaZFdQdF/wNYy4ajaY4xJwyi/F0K5csGQJUsR42OtQ5iDhDR5fw6FhomgDCgZM/wF8dIYSpRkjPKTYXFa/gvtWtzaLW8rIq0anIq+3gEkVg9tNnofucBcMIR1nQyf9aVFUq7WVlJ9S2YbWCJe1/+WqSeEseoK7VQj5vAJWgxIKE7IjL4ki2moEGXOQpOeFF2Vxyiy5POwi6v+sMLbWFymYsYxv/cefRcJk7b+WsKIyXlVFnI+dOR+qWqQSVJi91k32Vr1dg9djnMoXyyh7qdcPGKZbryDKaQ4FhDpQnV6MOerwsYRmnXG4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(5660300002)(7416002)(40480700001)(2906002)(6666004)(356005)(82740400003)(7696005)(2616005)(26005)(81166007)(86362001)(40460700003)(16526019)(36756003)(1076003)(110136005)(54906003)(70586007)(70206006)(316002)(4326008)(8936002)(8676002)(336012)(426003)(41300700001)(83380400001)(36860700001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:37:27.7259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19322675-5b89-47b2-bb6f-08dbfc2c15d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802

Add CONFIG_CXL_EINJ to cxl/Kconfig. This option will allow for the CXL
core module to access helpers inside the EINJ module, while also giving
users the option of disabling CXL EINJ error types at build time.

Also update CONFIG_ACPI_APEI_EINJ to set CONFIG_CXL_EINJ by default.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/Kconfig |  1 +
 drivers/cxl/Kconfig       | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 6b18f8bc7be3..4c3f0ec5731e 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -55,6 +55,7 @@ config ACPI_APEI_MEMORY_FAILURE
 config ACPI_APEI_EINJ
 	tristate "APEI Error INJection (EINJ)"
 	depends on ACPI_APEI && DEBUG_FS
+	imply CXL_BUS
 	help
 	  EINJ provides a hardware error injection mechanism, it is
 	  mainly used for debugging and testing the other parts of
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 8ea1d340e438..6f4adcd733e5 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -154,4 +154,16 @@ config CXL_PMU
 	  monitoring units and provide standard perf based interfaces.
 
 	  If unsure say 'm'.
+
+config CXL_EINJ
+	bool "CXL Error INJection Support"
+	default ACPI_APEI_EINJ
+	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
+	help
+	  Support for CXL protocol Error INJection through debugfs/cxl.
+	  Availability and which errors are supported is dependent on
+	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
+	  EINJ documentation for more information.
+
+	  If unsure say 'n'
 endif
-- 
2.34.1


