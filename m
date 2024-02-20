Return-Path: <linux-acpi+bounces-3735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B285CA78
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBD31C21316
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19878152DF1;
	Tue, 20 Feb 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a9RyYgoP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEED152DF8;
	Tue, 20 Feb 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467128; cv=fail; b=IZzdxQ9CJma0+a5fKQ8bSnWOus+Lqs2VLOryvYlW7pyc9DLqpHb2VBFoiYOZlYojfK5Rdu8kXshj5Zblf+/XX1d+WeZWatYdRhES9/Y0q4d9mfAzNNEuz7Lllr/5w00pE6m5KVxkv2PmcVyCVOSaEdYrjkeEh9r0Qb4V4+QAkao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467128; c=relaxed/simple;
	bh=eh22yLGqwJg3trybnoE5ZaACKcUznftoTm888ya2pXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igXkMrJZXaCA2v5SyH2YQQNwZwp7gw5RlsI/YKzSzefrEPJW7kirVCrqs3nY6v+nSWgjSVpTCgTgY0dIQnPWvr12UF++thJH9eV3bUBdIZ0ttQ8sLtXfTCCHVpkRT3Ky+tQr6Az1/X4Xn27XnqkT6csdNqvsuexLZnLUGhgWrBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a9RyYgoP; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvKtlmywZR92y87w0UYUG4ewDTLjtPPor/yts30OBtVvqFALDCtJEZ6GXs6uDkFZkcRa4bpGEPWTGRDvZCeyzIYvVHDhVziil9eJb/Mpehm9yfn6aRADyYQpOl1SOGwZfQXLJNfWAQKqM0QHUP7lLlNyMQssh+xOqlnullbxS1TqlaU636VwVX0ZGqUiDcsfOS5H/38KgBM8T6IZfUPiDtQJX/vgHog1ZL5cJUtMADPY4Xw9kryzApNouQy+Hj7GH7tRy0hqC0txdIKgjPUkxI1Q1wi8UASVPYGlFMPEiV/Z1WdYSOoRNk6VwbPsKlRPdLddspPhU7Exqeo2LEbxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGoqGjNiPTX9scdgNOuSXtix5oxv8/3YNVJ5Uhg+UuY=;
 b=kA02MYIwvB2PV6AwgdVAVTEttXkzN0WryhSanWRcDUvj4MqaWScLCM+JGbBEp1sR6MLvIwOAfm5eB/CMhO9f0oJVpQ4wV36WqVbhPlZo/mzTmbQgc1TSAqCoAXjsLs3I17tsl5wDyWRbozoK/ZcYIvteRsX4dtPjLmuzV1ipTbN0XlkDbUMoBIV/1uco7Hv3wy7vbC9NwAboSIEBdpYejP8b75Swjla+h5i7uot6eUZSWekaQnhlQ8HIlAqRKDcc1Kdiac+vJWScfverAk6fWgIyVsgTT/LV+HoQvdLZcOHfewHxHEm1W+WJGM+IYh1igTSPfdInbZe9ke4qeHe0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGoqGjNiPTX9scdgNOuSXtix5oxv8/3YNVJ5Uhg+UuY=;
 b=a9RyYgoPiQvjtvjOW2lMxt6thzQPvyUa7ksbuWGlzsoxHXsnN6mGS2WyWSdYHH38NLubPLbU+BlcbYmxDiKdGFbceIFWXxbJgJ0lWg4bBtjNtQhVzFoIC/6gvy8SDDz2g+ooUl/nAEPork+WVjg44/XIjCCzhN8GDyZO4qjih+E=
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 22:12:01 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::ac) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 22:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 22:12:00 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 16:11:54 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v13 0/4] cxl, EINJ: Update EINJ for CXL error types
Date: Tue, 20 Feb 2024 16:11:42 -0600
Message-ID: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: c451ba35-8ad7-4cb8-d4b5-08dc3260f5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LrAQmT8Kpk18p5bnuoxdcHBk6SvYj5VeqeIFYFC1mxPlMQpVzsDSOU1ArlVyGt7F6ooQE2k/cnzqoWwzO7dP+V9c+60cq6FfrqwGVBIohdbl8qaDDGP53eJgsvH+mDQxqB2tXaaPZzKI1XTry/fBJDb4atCBX3N21nkNT7FcBkR7nlvrR6Ne0kBmdZvp1PtE1UNFLBGQUDOeC+DBC5ALlE0j6NGoX3f8PSyGeK2uZT9DUL2TAUWq4xmYpa3oYxJjNejSFUnlNYpX4t5VeolUllHEHgiysKFMgWCl4pqNtUu/4VGogBRYdJCXLGoy8y8vyujLuC5AZGg/1QgjrGHl0qSjganPX7sgS8+WKowUNJmHkNgoAgHITAtqz5idg9st158ayjKzd9ykKhmWJMMpvE5s11UuzY5qDvtWA0LlyS1hYaMuXPiCfmgI9szmnNql+se4+SiAShWN67kuZ3CMmXulsVVw6YzOTQmVAwZzD2sNu2pEik5lDwO5tTzRWUPVdt/9r53YfrGLDMElaq8lcOGQUZBAiyxUbhzg3GaBh+2HUyJxiFNcwerF6mR5fsfhqExm04P3DUX7JhkqNDEztFUNItgvPDYrU/3XGfVk+4WHQOSvuXyNZ8rk/VQf8mlydLw7STveB62Qhf3+G9HxeQwTr5AF2oJRLKn1EZbR/Vo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:12:00.3593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c451ba35-8ad7-4cb8-d4b5-08dc3260f5f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718

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

v12 Changes:
	- Rebase onto v6.8-rc4
	- Squash Kconfig patch into patch 2/3 (Jonathan)
	- Change CONFIG_CXL_EINJ from "depends on ACPI_APEI_EINJ >= CXL_BUS"
	  to "depends on ACPI_APEI_EINJ = CXL_BUS"
	- Drop "ACPI, APEI" part of commit message title and use just EINJ
	instead (Dan)
	- Add protocol error types to "einj_types" documentation (Jonathan)
	- Change 0xffff... constants to use GENMASK()
	- Drop param* variables and use constants instead in cxl error
	  inject functions (Jonathan)
	- Add is_cxl_error_type() helper function in einj.c (Jonathan)
	- Remove a stray function declaration in einj-cxl.h (Jonathan)
	- Comment #else/#endifs with corresponding #if/#ifdef in
	einj-cxl.h (Jonathan)

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
 .../firmware-guide/acpi/apei/einj.rst         |  21 +++
 MAINTAINERS                                   |   1 +
 drivers/acpi/apei/Kconfig                     |  12 ++
 drivers/acpi/apei/Makefile                    |   1 +
 drivers/acpi/apei/apei-internal.h             |  17 +++
 drivers/acpi/apei/einj-cxl.c                  | 121 +++++++++++++++++
 drivers/acpi/apei/einj.c                      | 127 ++++++++++++++----
 drivers/cxl/Kconfig                           |   1 +
 drivers/cxl/core/port.c                       |  41 ++++++
 include/linux/einj-cxl.h                      |  40 ++++++
 11 files changed, 385 insertions(+), 27 deletions(-)
 create mode 100644 drivers/acpi/apei/einj-cxl.c
 create mode 100644 include/linux/einj-cxl.h

-- 
2.34.1


