Return-Path: <linux-acpi+bounces-2864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA082DE5C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 18:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1011F22C09
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45617C7B;
	Mon, 15 Jan 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v9DqU28g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5617C8D;
	Mon, 15 Jan 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLPNVVIlOyyppZr85xEZO2ptM2BIwpCyuRNFnC+BeQhe5S0WXUAFCZiYcAmsrA1NiLAXZZFtwbOmdkHwl34Nn9nNVsJC2K7EsPzz/CHipBMCg/8rcpOZvVlbLLCnHBe50zpVzAOoeJXUdOHGUcr3HLn6DvJBK7n2ngDknlpiZtsH+sTcxzPRprkU/2Dx74unWWeULxryxSNlf7wzvhOLA5ciYudFlxZa9ZB6oUGoRagEPN5DTzW1apCHrxs7q1cJH/J+r90/3TUEqlLbu8uao/8wYCuP9F09n3XQ8nwJq956owXbXM4iHLNl6BJWVPO242XbsoqHKPyHvrOpvFNdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS50U4xEhHX9oTxL56B+9IKnbTUeXfN0YwroNh6Xv1Y=;
 b=R86R+7BLE7q705zQOKWaVBEXlsScQld1XpBeRa86vo236jaPMJQs8NPGDIN8TzkiedwL1JaoD63cXv5ORphw3TPDkL7OZQUhyZZ63Lo3jngZhRP/7R/IbP3xZ/3Hb2y4CDNPC9sDm5bUGQSBO+6NqN1Q8UePXbo24kBR67Ms6WRlN991w7rHivVpZXQN7/C13dCTIMh+qSRwFd44jnSgrRnVXzMHz6J0BMgNLVnNFP7GMi7PgQTt2M5HqMKpF37mkErZVIJoGlKfDOoei3fpkJ+Yqh8aBZbLaqmShFp6Dil685MNAsu0yzE9xOGhreSBrwHyCk7G/3d9XxYbbNhxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS50U4xEhHX9oTxL56B+9IKnbTUeXfN0YwroNh6Xv1Y=;
 b=v9DqU28gtxiuq3vQ2EO6lbM2s/u/amlbMjzB64sDbawVBBuRm+nM/31eoTihrENS7oqSvRijwlk55ij4r+VFISh4FB+WQSygVapPKkcgX1EUTsl/TDdy4GK7xACULAwGuk6GkTB3wdeE0nLx7MohRvQ4myg8xcS8nKTDUtQswcY=
Received: from SJ0PR03CA0153.namprd03.prod.outlook.com (2603:10b6:a03:338::8)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 17:20:27 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::8f) by SJ0PR03CA0153.outlook.office365.com
 (2603:10b6:a03:338::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 17:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 17:20:26 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 15 Jan 2024 11:20:24 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v9 0/5] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error types
Date: Mon, 15 Jan 2024 11:20:02 -0600
Message-ID: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc2309d-d0ed-45ee-d4cf-08dc15ee442e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jEYyp3nwec3fB9tYSSZCsMCnDF8RkD/GKLx51k3G04VCNiwQDbmjbiakyonSiaU++iBxzRIyU0aX5wf/FaomwvO3pFMcQtzX6LTlLfJEyZU3a0gZhCsgzh79kQ/RaZHJoR4L3xUmX9BV1NKfxlurMdJRMWz4HtCKyLs1sPRWwQgcnvA7zOrZzktasLJlmLbhUI7t/uWegG7uqBx8Az+FjZqgwhH0bRpUL31iSO5FJyVfVJ5MRvQ7Ajm9XxXqJeYxQTBpyyq3mSKVJdH6x2mCpaRP0pJh1plT1ivmZuZAWjhGpl3OyCiQdiFUGUSap92Af/5XwNIR1IIawWIjT3hUaZf/ZT/5ezEoB9LCN+G7ZQ9eI7qMEIDOQU1BaUM3MmY7S/wm3q1wRs2DVWuP/vSSNfIueg8RHdtOuunRN/GU6KEcjuMF9kNrAPd+weaPTRJCCAH147sKUw6k0CpFtrqf6+IGCY20zJTEHtsdAsbJicGQBZwp17yDq84ZPNvEJTH/46nRV2/lhvLUd9+kQUxe6ikxmAVR/NdzEE9x1L8G1Ih80WXR3w0oZ8h8Y/Vymfw2T48SZ73a8+DNAUvffXvGKsJGt8B2zZZ3hfTAnSX8zZyvYaHgpWoVtMhJ+lci9HLQGnsBY5poVEFoBVjvjj8eUG5osDXZAvnYUZ4t562YwbzV5YRxxqJjB53r8yqCNf/P2fMNBcBLu+hpWsvRek6/EylmX81PTZG4Qkpx3hlxmcFjF1uzfuQPDTrWaQGvPDwBF5B0WSWvv1ku6VVbY94wr8NItieNuRGkO1Ay/pzGWlY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(46966006)(40470700004)(36840700001)(5660300002)(40460700003)(40480700001)(15650500001)(8676002)(4326008)(8936002)(7416002)(54906003)(316002)(2906002)(70206006)(70586007)(110136005)(7696005)(6666004)(336012)(478600001)(16526019)(1076003)(26005)(47076005)(426003)(2616005)(36756003)(36860700001)(356005)(81166007)(41300700001)(83380400001)(86362001)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:20:26.8681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc2309d-d0ed-45ee-d4cf-08dc15ee442e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

v9 Changes:
	- Remove wrapper __init function in EINJ module and use a platform
	  driver instead (Dan & Jonathan)
	- Move cxl/einj.h to include/linux/einj-cxl.h (Dan)
		- Rework header file to remove cxl_einj_* functions (Dan)
	- Add IS_ENABLED() guards around EINJ debugfs functionality in
	  cxl/core/port.c (Dan)
	- Rework cxl/Kconfig to be more concise (Dan)
	- Small fixups to cxl-debugfs documentation (Dan)
	- Add check to not add einj files to CXL 2.0+ dports that aren't
	  represented by a pci_dev
	- Bump version number in debugfs-cxl documentation

v8 Changes:
	- Remove callbacks and use a shared header instead (patch 4) (Dan)
		- Add CONFIG_CXL_EINJ as part of header rework (patch 1) (Dan)
		- Add wrapper __init function for EINJ module (Dan)
	- Move einj_types debugfs file to be directly under debug/cxl (Dan)
	- Move dport directories to be directly under debug/cxl (remove
		portX directories) (Dan)

The new CXL error types will use the Memory Address field in the
SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
compliant memory-mapped downstream port. The value of the memory address
will be in the port's MMIO range, and it will not represent physical
(normal or persistent) memory.

Add the functionality for injecting CXL 1.1 errors to the EINJ module,
but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
Instead, make the error types available under /sys/kernel/debug/cxl.
This allows for validating the MMIO address for a CXL 1.1 error type
while also not making the user responsible for finding it.

Ben Cheatham (5):
  cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
  ACPI: Add CXL protocol error defines
  EINJ: Migrate to a platform driver
  cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
  EINJ, Documentation: Update EINJ kernel doc

 Documentation/ABI/testing/debugfs-cxl         |  22 +++
 .../firmware-guide/acpi/apei/einj.rst         |  19 ++
 drivers/acpi/apei/einj.c                      | 187 ++++++++++++++++--
 drivers/cxl/Kconfig                           |  12 ++
 drivers/cxl/core/port.c                       |  39 ++++
 include/acpi/actbl1.h                         |   6 +
 include/linux/einj-cxl.h                      |  42 ++++
 7 files changed, 315 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/einj-cxl.h

-- 
2.34.1


