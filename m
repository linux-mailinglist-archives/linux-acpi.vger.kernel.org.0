Return-Path: <linux-acpi+bounces-3959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BADA8683B7
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 23:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D8B1C2409A
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379DF132C24;
	Mon, 26 Feb 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uco0ZEmf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600531339B7;
	Mon, 26 Feb 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986445; cv=fail; b=IR1QA5ewatbO84SKVK8KqMt1v4jhTehAk+HoK2YJj4+HjiRlkCVhBIcO/xBxV/2mTWYC3s7fBcMPZJq9cieFySe12XReXvfUVTWsi9eYk0mr9ePdHd0ZkU+cH49HoUS+QL1W95fXD5MDQmRTXy0khvUy55MIkBljZdRfU2HvIvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986445; c=relaxed/simple;
	bh=kt0aDf+BAgAsnagpK9WPb69A0AVD+FVzzvjHy42SBiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBPtnyT3TBFb3kD0o+uXB0jcN/I2eQeSF0YUCBm+oarlEJeiyJNjtJNrvFytihTeaHfo8zqU+eKNMQFmTOWbcuPOYyzZUjz4khBDN8EcBAamYTu8lXbzAlVYS4BKCjb8RFgqTyc8u/ZQzo+Cfqus2TOiW8LvcCVtoFZVxs4re9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uco0ZEmf; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Chm3BUPRybbrENWBVzA62fwHE8ZBBFVHjYKN149M4YwCi/oZKH8XNraV7JV7FHZuwA/+cJ7Xvz+uVvWRgsfsjVbKwUzcV0ToPv7DwtwkQOnb5Ax2Ae96ksiyb0BNNtJ8gTSToqMQJ4vTJ7oovSQwKn6mQRGCnhpoQuNmAPKb9YmidVKJrxPzQLkHF7oUjIihW5z2XfgipwEgV8fT548C2U43fhUyjh91fH2iDv7kIrHzyWUJVFkNVHzjCim3Ude978EpzYhlhrw5ipX56OVvN70SheLgU1jR8+UnHIJT2PV+lNEdSEzM6kC4rzokkZKhqjYGJIh4yBE8V3YveVi5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INRPZCib1jMmM9tf+8t28f8mVe4jK+A3IlnHnIKyu8o=;
 b=ZjOCFzpS8rbU3YeJ9FLoGgV4XtZ9l0Wo2TBAvdxshJUkCqL0R7eovyae6GN5N7d0fTzoATWptruy0qVLoz71mqp62/YiQerKOSzYfHIhQ8yONokxYV7PSPK7cVibYn2CApWlxWo9Mt2FlyFMJyfEExhdUDw5gtIe6pOGViy3PW+p1DWiWvr7ZooRuFw1R75meyHK4LqSzWSousDpjVIgOiqAVio8+YGrvvJQsRrXqkGg3wozjweMS9tLaWynJWQPqPtCLshVRDQ4vI+Ma7vwsW1wSiAcOe9p6s64mp5iL1znucDw+NbhoCHsESjle+W0puKeXvWl4D2xCuLCu5d30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INRPZCib1jMmM9tf+8t28f8mVe4jK+A3IlnHnIKyu8o=;
 b=Uco0ZEmfuWQAhNa6DYzT1Bg9omzP6MIGiAeH9vhJmrFwx4twQtqo3HJ7pqMaStOjdRsORKZLyYGfyjgixACQ9My+xnQ6m19TsnA1ATMUA5f5kckfktFrD7Jvl+QOqdg7UoVxwCKRDtseqerkmoDzY3hwxLKcaGe7mUvbrtEVPco=
Received: from DS7PR03CA0277.namprd03.prod.outlook.com (2603:10b6:5:3ad::12)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 22:27:16 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::b0) by DS7PR03CA0277.outlook.office365.com
 (2603:10b6:5:3ad::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 22:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 22:27:16 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:27:14 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v14 0/4] cxl, EINJ: Update EINJ for CXL error types
Date: Mon, 26 Feb 2024 16:27:00 -0600
Message-ID: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: f0655aa2-58a7-40c9-9a15-08dc371a1673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HubnMqyfLTa2JD5V0br4y+0EzwGLkTt50wfq238MAxjhzxwogo3NlZWAxZPuTzhQ+cxA8LFL/8NtK5Mep9wbsMvM6SNrsy2kwDmkUaHzipWm7SimSSegCOkCxK7r2ew1j43zjie0zzuTEYLoOlds4sUsbaDvlL9wdfqTZFvquuR5DZRclVg6O8Yl/5HukBGDbm+9lx0x2nT3GIEfVg26BqEmbZ3iaeKAsTdW1ymEh/wBR2cHBLdjP8/oIgh8PmhzDMN5oQzX67vPaPORwb7BPv/w+xJ79b/QUTR90O0NPCD99rAsz0KNEvTxehk1LL5CSxS3nwVroB59nX35bitYl8K0+DkLVo4+RdTJqF2aNCNQsLIsSosoZUDTRVmJ44TUk9mvt8YlTNQFDD/HHhKRmjjHcCOBhwRw5JDNqhh/psCOOxEc+O8ynvtUHdmk1CHKU86M0mwRaUINPTjuylvqVpTlxaHXLWSNB7+xEPZ1clilNiXvUxek8a8UufT9Ebgjl3qUBUyuwJ2EIVG3lQ6WJMw94uFCPrDPxLa5YzBWuh4SC4kWQd7bdzaaNKFGDYnCkRjxo8LUH/hrQ6DUH5nn6QkGAZ8D8fcI5385MvuporttWSiISqNyDzao0Gecw5KJB7dy/N8rx7tnzkQ50NmrEoE0kCnmT405CRzSFg94N2HgxKv3x21Oe/2czmBBY3xcYH8h9H+pmxucfeyKBmiyraQj1QWipe9pIbjhrVkKaqMhpmpIejCTp8oyyeRiuM4p
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:27:16.4182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0655aa2-58a7-40c9-9a15-08dc371a1673
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588

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

v13 Changes:
	- Create new einj-cxl module for EINJ CXL error type functionality
	- Rename CONFIG_CXL_EINJ to CONFIG_ACPI_APEI_EINJ_CXL
	- Move CONFIG_ACPI_APEI_CXL to be under CONFIG_ACPI_APEI_EINJ (due to
	  new CONFIG_CXL_BUS dependency)
	- Add an optional dependency to CONFIG_CXL_BUS on
	  CONFIG_ACPI_APEI_EINJ_CXL 
	- Change pr_warn("EINJ table not found.") to a pr_info() for when/if
	  EINJ probe fails (Tony)
	- Add a clarification that a CXL port needs to be present for CXL 
	  EINJ error types to einj.rst (Davidlohr)

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
 drivers/acpi/apei/apei-internal.h             |  16 +++
 drivers/acpi/apei/{einj.c => einj-core.c}     | 124 ++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                  | 120 +++++++++++++++++
 drivers/cxl/core/port.c                       |  41 ++++++
 include/linux/einj-cxl.h                      |  40 ++++++
 10 files changed, 392 insertions(+), 28 deletions(-)
 rename drivers/acpi/apei/{einj.c => einj-core.c} (91%)
 create mode 100644 drivers/acpi/apei/einj-cxl.c
 create mode 100644 include/linux/einj-cxl.h

-- 
2.34.1


