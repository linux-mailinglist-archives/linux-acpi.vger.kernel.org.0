Return-Path: <linux-acpi+bounces-2410-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD73F812192
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 23:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E160C1C21070
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976B224E8;
	Wed, 13 Dec 2023 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XiqqJBMk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B8BB7;
	Wed, 13 Dec 2023 14:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvSPV6AoT8NgjgXEZlbZsShKZhXbjT6cG88Dz4Yx3898P8+i5D2TiUq/dqh152GDg80rE6XdGgOqMd7OxOQVyyLc46cZC/0fAyver3V3JCHU/LKBWGKtvQ6mQbzwwxamfQGbp6j4+Ey0ak8XkUQT8cyiBkCG7xvKs3MgxM8zm2PmG8/OAOe5POvH1nooMj73SxSjJOmFjZiOIAcRPR1p60JgANelqOWy19XT1ISdOXyv3BXj1VPgKsQWVLBFEtft5dS0OwPVq8kFgZMETkq1pvW8o3wBE7/Mf2940q5GRqBbf1CN9TFikaRRpnwHmJ3RAp/kb7dVI9r6SGCsM6Wlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk/k14x8jZfp8IR2NlKESJtduUFrSO0o1SF/3LFTFkw=;
 b=F6aXX8IZAUMuq1kKdDCJVMJTsmlZvRz7dBe7zWlOBwuP1bKgDOYtyGWky8qyBKHpMVlovVWXf0flFhyFs0Punou7Tf3pAOjDSF5ZGwK3HtgZN9i7BGHSA5YlSzJc50CYGWDqyLBs5r5KHcNFBNXZBnmYyXalucqGunLbFYqf6ULZ2KqkvA/r+BThLOet7jAHLlFrr01JEvmGc0JuRH826EXQkms9T5zqmhwpog9cxbvCFjgbRtSiRX3aWnR9slSkSz8LP4xSKsd9L2JshltBEDRCj6jgdy0cn1oSZUj++AWxviFmuX6CIOi/aGYi+c3sCBvBfFzgeRIf/sXIr8nvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk/k14x8jZfp8IR2NlKESJtduUFrSO0o1SF/3LFTFkw=;
 b=XiqqJBMkXxSaRaHHDMto4mYVsDyQ3q9L9m1RWsxNuW96cPEZTzHU1HHqBhzuNxWI+2sGKn32k7ET5ZNL+ZvBktWHFBa3tQP2crk6vp4pCmQfJak2ZjgvSCfhQCCZshJ8VU2YzFYNM3YINTT7ZJgZDc4MrtJfv7TydEjmP1VMzZE=
Received: from SA0PR11CA0114.namprd11.prod.outlook.com (2603:10b6:806:d1::29)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 22:37:10 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:d1:cafe::c1) by SA0PR11CA0114.outlook.office365.com
 (2603:10b6:806:d1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 22:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 22:37:10 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 16:37:08 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v8 0/5] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error types
Date: Wed, 13 Dec 2023 16:36:57 -0600
Message-ID: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3ffe25-db14-42bf-3cff-08dbfc2c0b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Q3HbTQl/rc8RRZF7IPXBADV3Ve4wLawnullHUkVWiD3JjziA3hG3sqA/YCkP3ya6N319+Hx5tpYC8F4UEHnGJE7eHxvuIXF7Jwky1hBJLPnmhLB5Pn4Yo40jZ4ZppXnuiVeTTitZTdx+5FmLiOF9RpqUPv7MNqa27Oo30EihyYSg7+9taLHI8BB3htflYiOhRkdFgCa+la8+bUPGtUaVganCRkaHTUWvGpRBsygkYkS/SJMwY+ytt0+YkjltbbMGusRBWuW6ApFOjsnIWGTY6yivUqZYwpgl4hv8TPXkxl0+tmkIv1x5VnFLiu+ZG2Cfy0riKgYln//jS7SMqD0CfQor18XBbhWmdGAbyQXgNBwrlpO+88kG36DCgMP0qTzfUL9N/8v7mzcV3O7RRSc6LLm7cQueT4efukvtSMkJ63BiuTdqS8tVlcbrX5pRp7/d1IjIEEvG23nfiOfI48sM6bXvv7MWV1AEB4lSZD7rrjtQjn533iBY4cQWRw4w9QB9mcuBLlEcWM7NuXdzn1tcntC4qoUFGT9fgAIEPmMR0fQLYCwYy1qtmu76O3pC3n39CIV+MazVKWujC97yT/q3z+I54EbqD05rDlLElpiYsSZDf0n7m5NeQSLR0wXx8z+Js5gOkz9K8NMDAZ6BFkobYk5E+JVhMWpZ5tgBAY6J7BpxHl8klOjtzqhC5kuDWECE5BcMln9BJ+Y8yFows4eaNwHB5C7qLITCw26oV/3utE++xfi1gCfCnZtnrpktSpzQX3y5xlDa+3Qd45DHTVKRnRUTZ2Haq+3DdhfL2HrIbY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(478600001)(40480700001)(40460700003)(356005)(47076005)(81166007)(2906002)(4326008)(6666004)(5660300002)(86362001)(7696005)(7416002)(8676002)(8936002)(15650500001)(336012)(16526019)(26005)(426003)(2616005)(70586007)(70206006)(316002)(54906003)(110136005)(36756003)(41300700001)(1076003)(36860700001)(82740400003)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:37:10.0516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3ffe25-db14-42bf-3cff-08dbfc2c0b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203

v8 Changes:
	- Remove callbacks and use a shared header instead (patch 4) (Dan)
		- Add CONFIG_CXL_EINJ as part of header rework (patch 1) (Dan)
		- Add wrapper __init function for EINJ module (Dan)
	- Move einj_types debugfs file to be directly under debug/cxl (Dan)
	- Move dport directories to be directly under debug/cxl (remove
		portX directories) (Dan)

v7 Changes:
	- Fixed a bug a permissions bug with einj_inject file (was using
	  0x200 instead of 0200)
	- Fixed a kernel test bot error
	- Removed a "magic" number in cxl_einj_available_error_type()
	- Bumped kernel version in debugfs documentation entries
	- Added Jonathan's Reviewed-by

v6 Changes:
	- Reworked to have CXL error types under /sys/kernel/debug/cxl (Dan)
		- Removed CXL error types from legacy EINJ interface in favor of
		new interface
	- Removed cxl_rcrb_addr file
	- Added optional patch for CXL error type #defines (patch 2/5)
	- Changes to documentation updates to match rework
	- Change base to cxl-fixes branch

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
  ACPI, APEI, EINJ: Add wrapper __init function
  ACPI: Add CXL protocol error defines
  cxl/core, EINJ: Add CXL debugfs files and EINJ functions
  EINJ, Documentation: Update EINJ kernel doc

 Documentation/ABI/testing/debugfs-cxl         |  23 +++
 .../firmware-guide/acpi/apei/einj.rst         |  19 ++
 drivers/acpi/apei/Kconfig                     |   1 +
 drivers/acpi/apei/einj.c                      | 169 ++++++++++++++++--
 drivers/cxl/Kconfig                           |  12 ++
 drivers/cxl/core/port.c                       |  33 ++++
 drivers/cxl/einj.h                            |  58 ++++++
 include/acpi/actbl1.h                         |   6 +
 8 files changed, 310 insertions(+), 11 deletions(-)
 create mode 100644 drivers/cxl/einj.h

-- 
2.34.1


