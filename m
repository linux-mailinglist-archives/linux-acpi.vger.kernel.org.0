Return-Path: <linux-acpi+bounces-2917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC7D830D69
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 20:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D381C21A76
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 19:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086FD249EC;
	Wed, 17 Jan 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zBzIoY8s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A224B23;
	Wed, 17 Jan 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520722; cv=fail; b=LCrNrdTluO2nr7f53eqJ/yahQfI6tGRN5VxUYcsUWTI2Q3UQapWFksGSEdGoTxG6Hys9hKM9itWpT7I0XbzieGBVbTPf5ytaGu2RBM3R/fUVvhkkjI+ceQeO9eVs93rO85BIIQ1bMCGZdWFUWKpuVxEIICrcTFsE1q0cE8Qiduk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520722; c=relaxed/simple;
	bh=+x1N+t00ljn+sxdNp6K5m2A9mQaPPypw3371agLxmRU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=krhuPTjbY6fkR6YhPPkgAbPNp9nlozSsuFy9Auf46gVhl8m/pVUjN2OqT8NJcdFRMU8n0/rcgXdmPyk7VTDtLDxeGjv2BN3yGbdgWSpIyYMWZlabLOGMVSGnCzGDrcJk7gKwRFo1K7sRxa0LzswUBdhGUkHafLqtnWqYbwzRSXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zBzIoY8s; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm2p2egViA6stEw6wrGiVZpdEUfu4OZK6dn2e8iopY6O5xQh8CktqO7puPAWGbEfTratvS3Vd+Dmk9ZEBeqg9LgznuECbr0zHx5lPNs2PMQh4z9iXT/yDqXD0eyDcj7sL/c1Jb5W/Isay0bCtY2vsDemcxGsXZ5FAulNHDhVMDCFQvW0EvDmfbVMFXVa8tLrpZtBD8UAXLttFHQ3tRlLzSoLm6EJnZldGbwzePk9+JgDTHaZX9fcUMZxkB13/bMAS1aycmjjNRsehA7WLARVvxamqhgdWq+lsGqjJ87TG7N3yecB2E3MKfeXUEnP1hjbofgZI5TqtZxTVwDRA3ddVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5HGKo5KqgnUiK6FdpoTAfG8DPjgGueTDJmMl2omqlE=;
 b=h9X5cQAoIiX+aJ6xhedh1BS8k1sljOQp0LDdLeSbnK5ShSRtrP1/LmymTJMb6D7DXjYaYJeYJ5O/seZ+kvnyrbJWGOKgSQI3En/VE+qU1EGH3DHJ/3jDupAZzLSLN3YC+ko1Zsg6FmzgyABncGNopFqfTxj3rX8GFqeKKIF+GhOIwLOiZZykDpOiBv0YpYP6A/UMT6VNM2O6vNrByZOyxcviV6gUK2kOp0kAcAnWTu6cCOVCRlIJudXDUgTwWt4lXKsAKMQA5NTo+5eCFTtfWxBBbOqk4JOumcpbPB+PsGeIkHl/AsIvATQpBMp7+0Yqgg5Ber4MjpEnpT3B5UH3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5HGKo5KqgnUiK6FdpoTAfG8DPjgGueTDJmMl2omqlE=;
 b=zBzIoY8sLkJv3tjN4bbDyiN6Nnn3RWEhyNDKpTqOeX08grFX0O2BzkEpLjgNyPoC2q257yrOzKyLe471AusKa93DihiSMw0+d+B/YwbT5GYZ5WwjkoxD2VDjuWOstexDCrxYRBgR+DvGX1H+fX7ntiGDRUCcZ62GOfYH+GLzBjA=
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 19:45:18 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::bc) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Wed, 17 Jan 2024 19:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 19:45:17 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 13:45:13 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v10 0/5] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error types
Date: Wed, 17 Jan 2024 13:44:56 -0600
Message-ID: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: e845d3ff-c8b6-411e-46db-08dc1794d54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZVGWeAL1rGj0nfm9ufmAl0FYARyxdcOLxsXUW/yLPYxDVUD5S/eGF7wn0sbfJtE00ZPpWDzjhEblRh+phVibbTeqprindZNTwPiStmVqCqrn/U5+3+isUnPKWIF3yQ+87MgXmyMcZM+qQtx0l23NB1t212fQhYJDVbxxRgESJ2n2BMsflB14qQpgKgFfzYhrRV3NJ+9W+ml7TBnPmLKZIHjESDZC5vVTz9mqixRMWzEE7chps4MYXCfEd0TOSn4yTBjQHQ7/aSo6yNLx1AVVUPStRRolSk0dVPKzh7KV4VkE4ivvSgyTJBwSmr8ZBCQvhzJic3IuM0tHLo4opuZu5Ugw8XGRDBFdRhFmbl2Z11xWk68fdVSpdK8GzlesjVAnFLh3AYwI/dYpOon5HFx5WqOo6nBQfKObegt5y5hFOiJrqC5z21nmA1AoLIE/vO01jde2Q0rlxBvnDk51iEsX03dwjAMHBOjLKrBqp0Z7/n2AEYLEMgGbEiTkmiYG5wMFtru2mDnyW/XBmqetl0rlFTevwgIgoR2McOds+j4hy89Z0agHe74R54z/gCylhpq2HUyOKo6BXOANoVrVv4NCO97Yyjxrez6fY++PEC1ecl611TK1WO22mv0bGLmMx4GZCyWDTu+8zhIjxo37shYRqErVgmjMOTMkhkCmNGRIc5z/ptfL9UCSoQMcvCvc+pponmvwHtkAQdp7vMmOvQqhGH3dJzWKXYoeO/ScXLW3PbEGIHWpvxUB0JvucC5YLHeF+acd+d74B9MDrulDDA18MGj5xUhjeoScGa+KqJc6OZg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(86362001)(2906002)(6666004)(7696005)(426003)(83380400001)(1076003)(16526019)(26005)(110136005)(4326008)(316002)(8676002)(8936002)(70206006)(70586007)(54906003)(478600001)(7416002)(5660300002)(15650500001)(2616005)(336012)(82740400003)(41300700001)(81166007)(356005)(47076005)(36860700001)(36756003)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:45:17.9999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e845d3ff-c8b6-411e-46db-08dc1794d54a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

v10 Changes:
	- Fixups in EINJ module initializtion (Dan)
	- Add include/linux/einj-cxl.h to MAINTAINERS under CXL subsystem
	  (Dan)
	- Replace usages of IS_ENABLED(CONFIG_CXL_EINJ) with new
	  einj_is_initialized() function in cxl/core/port.c (Dan)
	- Fix typo in EINJ documentation (Dan)

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

 Documentation/ABI/testing/debugfs-cxl         |  22 ++
 .../firmware-guide/acpi/apei/einj.rst         |  19 ++
 MAINTAINERS                                   |   1 +
 drivers/acpi/apei/einj.c                      | 194 ++++++++++++++++--
 drivers/cxl/Kconfig                           |  12 ++
 drivers/cxl/core/port.c                       |  39 ++++
 include/acpi/actbl1.h                         |   6 +
 include/linux/einj-cxl.h                      |  45 ++++
 8 files changed, 326 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/einj-cxl.h

-- 
2.34.1


