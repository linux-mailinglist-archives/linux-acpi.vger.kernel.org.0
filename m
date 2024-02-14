Return-Path: <linux-acpi+bounces-3495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C038553A2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 21:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6FE1F2A8A3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8613DB89;
	Wed, 14 Feb 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RKEtIp0t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6913A888;
	Wed, 14 Feb 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941256; cv=fail; b=sgInWgJd2SflYEKIEEZosYiek+oB5Skgal4IeE02tFfFU/EuvXR3Fhf2URs0CfILpqK3tqz7U6qHN1TnHwZFP9/qMs7eeJZeVM1OMdE33j2ZbtU52jNiMH6UN3P5Ub1WTjId7xwplSOuY25RpkUjGy5MyLs+M+Xkf32wtdWhDgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941256; c=relaxed/simple;
	bh=GwivG4XEeXcNhK6WwUOywnZAeCnoCtk8f2qLh8Gg1TQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mlkh334OhMl+QMmbPWxU878eXfeVbrpZ3sYPqbF6AMQRvosQgVgieALy1KhN8pB/7cH+01PJVyuW6tLL9bzJ+krOyAFPOS32TfAsQEYgE3/lMk+S3Xei1/ASrDeaK9jbXRJ3NqB7TWV7VxPA8a5ppwc4KhfmcSrC6ns0d09SQyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RKEtIp0t; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvuN74ykXsGH2AvmFjYuK2VNSdOVh4z/Olf64SEFuAAxaS4wSnQW+Uvml5eir7la+wgzftFn/Kdnf+IKRCbmUWJsDrg+748fQm1686NBydJPsVph8GuJMKUr/u5ZCDFUANBzZ2FgDPQmu+HDTWVDZWY403evluTv7Pzt+Gm+9rAMWBjG0QegSZRpgbwsVHt4dDyyJ9zKijMseJeCTIXJE4QC51EFXGV14L5QEYnZcHrf/OkwRxWX8KkUwCJhv7LElteaEl6VxhTBRdlgg1QdPlRva6uSWkN0aCs2OpXqyqu5lLjKbm02kx9+MPNOJtIooRh8PylkEi/LU40gB4oo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTCagCMnFunnvbx5R49BtqnI831x9dC6sq58WX09weA=;
 b=W3AMkEOX1UAl+2K4rSm61HZ+mCtRWR9jc7T7h5rWf6dsvn24MHmgyuRo4oa2fQfh3McSj/YDuPqd08/xQPygX61Pxa98jUIN6CNsK/SbaktNQqos4Hj3t5C6oJgw3m88wpgPT6zqxS0JKtOfoKV2DCANB0zfiZOLZyogDr2prguIY4iPqvQK2DsJa6JxWssnP/dhpZ9ghw6g8we58O5gCEvLdCqTGk5PVw05caDIZDus18XOxaSrYNjd0thQxfxLWJrQ7cumx3edIyDviL3buml3yxOAf2AS/GkX0i2dl4mgvaZExOplXCB6CoVXt/MI8sw3TDjG3aToBiCphO/wsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTCagCMnFunnvbx5R49BtqnI831x9dC6sq58WX09weA=;
 b=RKEtIp0tq4kaGKc9Zixg4lCQCc+L7TSa+SjItWxch46u0nfDlv5f7YuxdnnTHiYmtWFcLW8xweFEbctKIvmvrkwM6EygW/6Y9r20oqn/laIWPG0RSewSDRueW4J+HD6kYxUGpV46GcG5kd8JT6/q8xK9uROR6RdkiHNEE9tFOFo=
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Wed, 14 Feb
 2024 20:07:27 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::76) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28 via Frontend
 Transport; Wed, 14 Feb 2024 20:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 20:07:26 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:07:24 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Date: Wed, 14 Feb 2024 14:07:06 -0600
Message-ID: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: c9776658-5394-4ac2-afef-08dc2d9890f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9CYMuCwAjovcsuLvqwcco98r9syhn5mT8eqPxqWpapsAAsyjbNVD6hDmgY46inzwxkv5I/Pytf7dLqv19Jg5AEvWltBACsCO7ZAelJBoC8vevv16gRO3gSAnNiGcOTVUa5iVOj0477sg/WtI3j9O0cTWF3zWP7iKTfWzSMKSTJdCGEFC8rLz+TRxednr1oma45SSb6tw9gVv8d3YPFJ2qGPbJ25yZplpvmr3+uWIrkCMhcuwF3adOgZs1w26e1MveG8HtA+t7u8MOmvJ5uzTuFvlHtdcTy0K8Bl3GRw/vujtoZz9rcxhrYjHSJtIvu6hFpHi/Pk75sO8noy25UJuutsMajZNwpbWNJ21HhMR1CFgZecFUqscUI6CU5o/WbaqFvxKbB0ixO8eeUkBwgeXDNMhpAQQt6XxVtyM1lrGUyrJez/CObmPh5VmMTwYZADQ7bx5Aiovy0oN/1b1hN0D1eH44cVLDf7pgRqRHuCK8YQPJU2RX5gm8gwZC4VNG5+G8GKRFkfggQ1Uye3Gy8IqSJjEPwBUmBWEu082fcjHBpm9ulvclwdvMpUCFtM0G64iW9Pq7F4pCdcY50uaDBiw3/xsi6FCSTp0XNe3Erbc5Xw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(7696005)(2616005)(478600001)(41300700001)(15650500001)(7416002)(5660300002)(8676002)(8936002)(2906002)(4326008)(70206006)(70586007)(54906003)(6666004)(316002)(26005)(16526019)(1076003)(83380400001)(36756003)(86362001)(110136005)(81166007)(356005)(426003)(336012)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:07:26.8595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9776658-5394-4ac2-afef-08dc2d9890f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121

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

v11 Changes:
	- Drop patch 2/6 (Add CXL protocol error defines) and put the
	  defines in patch 4/6 instead (Dan)
	- Add Dan's reviewed-by

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
Ben Cheatham (3):
  EINJ: Migrate to a platform driver
  cxl/core, EINJ: Add EINJ CXL debugfs files and EINJ helper functions
  EINJ, Documentation: Update EINJ kernel doc

 Documentation/ABI/testing/debugfs-cxl         |  30 +++
 .../firmware-guide/acpi/apei/einj.rst         |  19 ++
 MAINTAINERS                                   |   1 +
 drivers/acpi/apei/einj.c                      | 202 ++++++++++++++++--
 drivers/cxl/Kconfig                           |  12 ++
 drivers/cxl/core/port.c                       |  41 ++++
 include/linux/einj-cxl.h                      |  40 ++++
 7 files changed, 332 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/einj-cxl.h

-- 
2.34.1


