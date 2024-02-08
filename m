Return-Path: <linux-acpi+bounces-3304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF5584E93C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 21:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BBA1F31A86
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA338384;
	Thu,  8 Feb 2024 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YnA6G06u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA03381BA;
	Thu,  8 Feb 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422459; cv=fail; b=mhl4MHr3sySq5ZymHRiVyQ6CBsz3iib8vK2+irn+Y6FXQKZz4bzJfusmO6p5kDsM7rtGAQakXvd1gjvB1DPLgeXOx58ZXFinFA4GEpr685z2Jsvry/v3n7nS2uFRYq7lUQCf/OR+d7CbqhRa4bSUe0eqnsahzFtYkT5asc+EjQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422459; c=relaxed/simple;
	bh=uvpgWzLOCSGhcVpvqFe4NDgnGqV4fSYfgbuK93ZxYwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hpg4ZJX+pJaLqlq9b+A3MHHoV12zVx5xdlJzLx/tX/Qbew6IyaTYhNIMYgpb72YMmLtU/6UgWTpqBrPvC8AW8grffkenPRKPMoXu4QnGQh8R0l+bL5OGvv6mzIAYQMTBhmvhtkp4RYjOV4DMiBhx6wX/EoZgm3T+RVhTpFuZVBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YnA6G06u; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAJb8XYYckenZvZUPXuXu58dSc2U4WTvLWo1USp3mTFn2kRoBBsewCQNEc6/kkPkx+Yz/3RSSzBGCDsg/ORmryBhoslDxO+RNJBRG+Cf8u42eUUOf37JFpVZJguEbI7r4tRXTEe6Sx/lrNleK/05v7l6Aw425aCSN2atfUZdfHbFI2nzGodjKEDX0JnBSj7mYhxX/TgihXwaNg+pI6RZetVbXANaDztW8+QsvanN/x991oSGcYowqydAMxxitQEl7qKpzOVtGUXxL1ALa8YfSzpYEte+ykzsjUagZTEQBIROJzOIDIfAp0iG6BWiQFIUQQvB7uOOidGgkgFOGAWl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd6SeU+XEQncctR+lLEINRW3NBTII4nUCmzUMz2P0Og=;
 b=mXT1Z/nBk5PqRTmPU6MEJg1hTltpgv6WApOSTfqSFz8J8iD4FnrX8ObDxX4bFXzuKm1z9gV0XVw1kTPuYYoABHu81oUZrPFh37Pk9QAoPqsUUxQcQzLJ25UzD9jTLfBTaKvy0H4ot/hHbASIJlME9tuKU0RFdLtnPIAITR2rpwPqkTKL9HTH1BjaeiVnyNlwfyQOjq+iXIUd54ha8i776VJkbUxlQILMjz5ojw5MZ09SLil/iBzSMpFXhfya4N0WzINaJK7LQVD9PCO1LpPIUHIw0k/49aV277FwMo+QX61im3KaZmoI39oRwn14gW1EldiHs/uQ9AD+DvekxhoHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xd6SeU+XEQncctR+lLEINRW3NBTII4nUCmzUMz2P0Og=;
 b=YnA6G06ur46zEMs/SBbC7WdgNoHtae9YJW09o4VegGejL788qehDBnjCVyEPHMNlsjfv8/M4BsX7m+9sfrOhQnbdcEPzRObdekLeNdPvxmfwUjSJeHmjvIwZQTkXoJHWq7zhMHvWHXeRDUjJ7hTW47HIdi2PfDoN59+yHAhRtR8=
Received: from DS7PR03CA0125.namprd03.prod.outlook.com (2603:10b6:5:3b4::10)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 20:00:52 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::6a) by DS7PR03CA0125.outlook.office365.com
 (2603:10b6:5:3b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 20:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:00:52 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 8 Feb 2024 14:00:49 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v11 0/4] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error types
Date: Thu, 8 Feb 2024 14:00:38 -0600
Message-ID: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: f5cf2440-a82e-4859-5817-08dc28e0a74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ahr0oyxogZHOmFEtGK48TzcJH+8XtfYlOX/lxLnTNG55hrccyIfSuq0jsr3TjnPXVnpscvuWTVoC520oo9yap7KI71SR0VsMBJ7+ulAytqU5eEuMT4YRj9fpjNOtK+Glc955cjP7TA7x/WayeRneF9AcNgvasTNVC7k9JkmxkNZEruo7gjo4wbDHEMP/JWeRcegEE4DlcY0Oq0iY/BTvinvtdKVT8KdUs+0IdrFNY9wPzp1bdGMki3e8cX3Neh4Kyc78bD6vmc4BRDfhCEaoovt+o8XbYNy0ymxUnrDcbsSMIudBIO+9fHCsyD3x/tE1O6b+g0QH7YXIWJ5ao+HdO6CLa7OyK6vtW7HIcOtDLgPol84Wfya8pt8pM3222jHoDW02RcqspnNYafjdoss8PyHl8DrSUbzLvnQwouayTPUfjX39hgmy6BylgpIBWo7u9jCqo13m+CDgRxm75cZ4Jdb4o01+3ab+Fx4z63QpvASrnY0NTtcMVe4xU3L4gYd3d9WfljFODZ/PLxNPYe3VyKKR1+fJLu7yBYIdYFrH1T1vbedvAJrKMm9Q9Az89n8WTwIRGT8Qk4tRU/8p3HtCWmS1PldB4SuWek3hkbY/SsA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(26005)(426003)(16526019)(1076003)(336012)(41300700001)(36756003)(2906002)(5660300002)(2616005)(81166007)(54906003)(7416002)(110136005)(15650500001)(356005)(86362001)(7696005)(6666004)(82740400003)(316002)(70206006)(70586007)(8936002)(8676002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:00:52.3479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cf2440-a82e-4859-5817-08dc28e0a74d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

v11 Changes:
	- Drop patch 2/6 (Add CXL protocol error defines) and put the
	  defines in patch 4/6 instead (Dan)
	- Add Dan's reviewed-by

v10 Changes:
	- Fixups in EINJ module initializtion (Dan)
	- Add include/linux/einj-cxl.h to MAINTAINERS under CXL subsystem
	  (Dan)
	- Replace usages of IS_ENABLED(CONFIG_CXL_EINJ) with new
	  einj_is_initialized() function in cxl/core/port.c (Dan)
	- Fix typo in EINJ documentation (Dan)

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
  cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
  EINJ: Migrate to a platform driver
  cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
  EINJ, Documentation: Update EINJ kernel doc

 Documentation/ABI/testing/debugfs-cxl         |  22 ++
 .../firmware-guide/acpi/apei/einj.rst         |  19 ++
 MAINTAINERS                                   |   1 +
 drivers/acpi/apei/einj.c                      | 202 ++++++++++++++++--
 drivers/cxl/Kconfig                           |  12 ++
 drivers/cxl/core/port.c                       |  39 ++++
 include/linux/einj-cxl.h                      |  45 ++++
 7 files changed, 328 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/einj-cxl.h

-- 
2.34.1


