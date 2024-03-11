Return-Path: <linux-acpi+bounces-4247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C867878192
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F721C2287F
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Mar 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6793FE51;
	Mon, 11 Mar 2024 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4KFdxBfk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF84084D;
	Mon, 11 Mar 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167129; cv=fail; b=a0UvNJhDRqAIJ1rMTlqC5GIoLafA08K4S7M6ZtmPRv/8yy9nDLoADFIy8jpGqVxzOiHUxM8AKeaWQSIpyGmvMDs9Wy5jse4OkjJjdwxt78gc8VCdcYOKMOyqFbFobwEVl9YK8IyJfwMPIMB+OHm6cVECe5weX4zvKCE/oCYwaO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167129; c=relaxed/simple;
	bh=sAhuR08NHWs6165Y3ZJu/We+kzZmO1bDsOPtSVyuHS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iB1AJcbuZ9jFXbog+9d0TR8RuyR77FoHZs3bGkg6BH+0ntxvtv37PKRN2YOT59OOWBc7FcKb6BVsM6MvNkF6cnOoXH52MtrRAiSiCSvNuK1mtk7J1fk2AOFV0IJudZkXhiAbx1QUDizMHwy6THGlB0Q2+elx7cYscTCG60UpuvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4KFdxBfk; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyu/fmvpK0R812X3ONzd44/FkSUvnq+p7YN/4QUB7+9Ir9hFgchdrP2EPErqmyZO09aD+ocYHOwdy71LNVJqQQzMO7YdTz3B33ogsyRfMud3aM7UHgn5g6Bmn+2Y2lSrRua+99LS8pexWzR6Go2p9hYaTovko24WtXo+w4tKEGT57MhqlYFZchnf8PMljEXHVJe8l426aVA15HXp1bkkN4xmPjWbtHl3VVha7sbvIcRYxWRrjL72C2icvqzvzuYuwGwqztGyhmdAzgJB7NFgCIKZkguPq4eqyiGH4/9EaG+3QQc454y4no3T5IyjZyIR9/fGYKPW9QAF4Rt4knF0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lnp6uvOWIEmePSruyrvyINxBV6hWwDzcXeL8m4CWtdw=;
 b=eiNzA1Y63Qn7BVdY/MV1qVNEaWqpIgBfHt+RtYw0KCPFOlu+cuPSNjqJN38MRbj09kJFqDiFU8ucZvfFSYt0ixUSFvmX2UwTRdeyAjT9LIV78N62u41Q8Sn3iYwRASt66MMQCcZz84fWZZWvbz62fdN4ziPYokHxpuAcrOVE97HmAoj7yPwIDgm1Ti6pMsfy8aoGtGx01hQusl8y+AWQ4e6G/SlPmBHW75+TFSPk8YXni9IN1wv5LYlAWc1+QwcglTNgHd7vzg7497CVybUxQXnlm4s+j5AWbsHgZKNTKKh95c2G/88+M/gEy0YwMRAZTkdX+6URf0u+1KtFX8cZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lnp6uvOWIEmePSruyrvyINxBV6hWwDzcXeL8m4CWtdw=;
 b=4KFdxBfkD79Hl3A/SG7y4+0eyvBNDPiOej9osuFs8ntnrPSAEcapG0QdhePooCL1gVCI13u6zcTyH7KnauWqpFy3Rjbla6mumBgio1rNFcM/4ILwPU+PHmAOUo/5PgWfWqtQ0MKBBM57R5Y/0aLOPUPfpl6xHS+buFlCzjDkuqg=
Received: from CH0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:76::35)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 14:25:25 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::5c) by CH0PR04CA0030.outlook.office365.com
 (2603:10b6:610:76::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 14:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 14:25:23 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 09:25:18 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v15 0/4] cxl, EINJ: Update EINJ for CXL error types
Date: Mon, 11 Mar 2024 09:25:04 -0500
Message-ID: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 1016bc75-1ba4-4f86-ce7f-08dc41d71708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lZ8lvxQ5jysL/djVkKqVNEoVrU5NbHq+id9fffo5kEWT2rsQP/oBsqq0Jox8VUAq0c41V5xaEgL+elvwGIxsxisEwvhPUXuuyRMp5Af1kGM1OZcmk0ZrGpOYFTv9cusy014HahkqY10uKkNahYs3N3YDcFx8FvtLUn3/0oL54kWVfOl5dXI/1xDpDeRiuADTMfloEOcQNMd3jk3YdiokbGgR1oC6mBG5V0hR78vcWXaxsLRKLkBdwuAT3FycBGnr+H9qZI11Av5hxYuVQxivRlEX//ar/4SgBnbJM/Yq0tuGR2nR4HuJChSfyhNdqajXpbfr1h4qIU5TnZEhr3HaHEgzMw4o74QYp4nv1FdRx4dWh3CvREb8yeSkRKdAkhUwwMXDFNoSogxoL7VZYdQyTJU+3J56qqf5fexf7yKbxMJoYyppwhMdKXoJYdvO/b6txQWV19g4BDaLUa8B/nEi5rdAuf2AXXBAe2i/mJjPv9WIdmudCERQBFAMWT0nHVIig3SLrUa5UaMo2RXn5+AMchZScJotCZWyGoDR0mOTWrzzI405lt84/hBs5lxp+aQnc5PyqNFq8SziDrlts93J8VQDM0hKxSAYnACsxK1mwpElpDHTjqDD75nIDL8w1LWnXpM/tccuKkKRajmALdmYQ22WFgxiHI4oIWZgI2J2CV8rmKs3xNz3wRQPQHf74NKfQZp77+83YAMFRtN+5B+4sQXb3oZCFGKvsD4x34o5oV3RGqQDElpuMc7EndqDUzIM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 14:25:23.9370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1016bc75-1ba4-4f86-ce7f-08dc41d71708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

v15 Changes:
	- Update commit messages for patches 2/4 & 3/4 (Tony)
	- Add line to cover letter about CXL 2.0+ errors being available
	  under legacy EINJ interface
	- Add einj_cxl_rch_error_inject() for CXL 1.0/1.1 error injections
	  in einj-core.c
	- Remove checks for einj_initialized in einj_cxl_*_inject functions
	  in einj-cxl.c (Dan)
	- Update commit message for patch 1/4 from recommending checking
	  einj_is_initialized() to a more generic "safegaurd against EINJ
	  not being initialized"
	- Use more specific headers in einj-cxl.c and einj-cxl.h (Jonathan)
	- Use ACPI_APEI_EINJ_CXL_* defines in place of BIT() macros in
	  einj_cxl_error_type_string struct (Jonathan)
	- Move error_type_get() above einj_validate_error_type() to cleanup
	  diff (Jonathan)

v14 Changes:
	- Remove einj-cxl module and instead compile as part of EINJ module
	  (Dan)
	- Change CONFIG_ACPI_APEI_EINJ_CXL from tristate to bool (Dan)
	- Fix CONFIG_ACPI_APEI_EINJ_CXL/CONFIG_CXL_BUS dependencies
	- Remove EINJ function exports (Dan)
	- Organizational changes for CXL content in EINJ kernel
	  documentation (Dan)
	- Demote "EINJ table not found." print to pr_debug() from pr_info()
	  (Dan)

The new CXL error types will use the Memory Address field in the
SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
compliant memory-mapped downstream port. The value of the memory address
will be in the port's MMIO range, and it will not represent physical
(normal or persistent) memory.

Add the functionality for injecting CXL 1.1/2.0+ errors to the EINJ module,
but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
Instead, make the error types available under /sys/kernel/debug/cxl.
This allows for validating the MMIO address for a CXL 1.1 error type
while also not making the user responsible for finding it. CXL 2.0+
error types will be available through the legacy EINJ interface and
under the new debug/cxl interface since they target the SBDF of the CXL
downstream port instead of a MMIO address.

Ben Cheatham (4):
  EINJ: Migrate to a platform driver
  EINJ: Add CXL error type support
  cxl/core: Add CXL EINJ debugfs files
  EINJ, Documentation: Update EINJ kernel doc

 Documentation/ABI/testing/debugfs-cxl         |  30 +++++
 .../firmware-guide/acpi/apei/einj.rst         |  34 +++++
 MAINTAINERS                                   |   1 +
 drivers/acpi/apei/Kconfig                     |  12 ++
 drivers/acpi/apei/Makefile                    |   2 +
 drivers/acpi/apei/apei-internal.h             |  18 +++
 drivers/acpi/apei/{einj.c => einj-core.c}     | 123 +++++++++++++++---
 drivers/acpi/apei/einj-cxl.c                  | 116 +++++++++++++++++
 drivers/cxl/core/port.c                       |  42 ++++++
 include/linux/einj-cxl.h                      |  44 +++++++
 10 files changed, 401 insertions(+), 21 deletions(-)
 rename drivers/acpi/apei/{einj.c => einj-core.c} (90%)
 create mode 100644 drivers/acpi/apei/einj-cxl.c
 create mode 100644 include/linux/einj-cxl.h

-- 
2.34.1


