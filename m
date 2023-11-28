Return-Path: <linux-acpi+bounces-1869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D957FBF6F
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 17:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB48B1C2083D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8A24F88B
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ddQIin2T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6842D5B;
	Tue, 28 Nov 2023 08:07:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbngI0xxEj/tlAo9k5HrFjoVThOD8Fm/4+2nFJwPVU+8HTxVw6cYxFtKOXdutF99sNh8pe9OHV7IILvr0e64tVwVxTYgqMn/tlCTnAyM1NOv/r7wSJu3jgc56u32kDsmLXpdbh23o0qa7swSc+ZpvqOgaZDFeeXrb6YyyVIX1l4N/ZSrZPRfTA53AlilnqcXa1XG/1E8DWNf/umGvxfc+L0GMkH++iNcsJdHnsunPOZCWxzHgKEj92WFTlx3Ib0ZjWal+HqXnNlGn6rqflquUFcpyy5Lq5/DF0GJ3HrC1U7ZukkEJlPEIGerrzrSP9nTPplQEIV3fC48iuTLcj6IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyhWPjDT5OL94DNIxrTEut37EOc38L2ygt3gZjgvLYw=;
 b=ksKotXJnNzcjGl4Bl0+sEdMLzu/nP6ULZuoYma5Y8SG54J3fh1Hd5L9+zodTvWCqcabGbgJJOAnGCzHsXhm9zr8fy63/73WjBpTRi56YiZDTvdOhKX3hW9AY689D26ZHtBARUNpku7Ncod+n1AWe14NlmCJveWMCv8SQw5BdMVlSbxkCKfdZSHccpb2+nrSZZdE3XOh+zWxmsQ5QdMv8disPwfC8yOII6PsBj3abtgAKQ7mZvlJC56h7DTqYF9+ipVugEP+jBnOkzVeH8zkzXpTGTXUxk6iEeEMsXFFFqFdVuGy51VQjTaqISkbWvQiLiPLw058SyZi9lBmgvnNV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyhWPjDT5OL94DNIxrTEut37EOc38L2ygt3gZjgvLYw=;
 b=ddQIin2TDXZ8lz/snn4JLe39zXU88Bvaqbdjwd3kDEtJQC/liwTg2+CNGIQNQ4Njowvy42rU4tec4Sj4MIpl8BnZ4OEf17ZK146o/b9UynH6c++h0vuQR/6FiGJvYQvr4OS5xfvRpgNwGiqJJ1PkUaiTM/qyw6ByxdpWqxCGoEU=
Received: from CH0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:610:e6::31)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 16:07:12 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:610:e6:cafe::2e) by CH0PR03CA0296.outlook.office365.com
 (2603:10b6:610:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 28 Nov 2023 16:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 16:07:12 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 10:07:08 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 0/5] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error types
Date: Tue, 28 Nov 2023 10:06:51 -0600
Message-ID: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0387c668-2ab1-4445-e723-08dbf02c14dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aS5e77U04wMA24m/U7UHRB3OrQBAKSbWi3IsA9aJTYhV6z2KOlM1aeJ6az2tGPDaVmfrDMi0nlG7Y4w72b+/u8oCorcNQBcP1TSabiuluQc/1tcUhzz+s/ANZZHDaSUENt+0IhhDNIkXfI9dv+715v+TQpQv4nk1sniZl0sJVDeFci7wEF2JMk3BpWNtBDItgDdupEc2bodW4AN+PeZPI8W7+aHkqIv+wGpdoXRf4WOgtvxzhw34vbcNBu9AqMEVR1e/r1Bw2qWNCBdaEkqEduRlOwbyHiJyn2X8HDTCDOknAYDjt9WtKKcclCvFpw9DEDQuL2Up/oKDGLFuFhbFjl30r9x7zEPWn9PldwjoRJ9vzZ/MZuvi1uYDgq1kbIfESA9D4WuV/k6F8MgkJzXQZ+e/fXIOuy/cBE5e3kjD7mGpobdo+QyBogeYROkU2+y6yWUybdes0E1BUmLm/nlX+FHXICcTmX1iwQNzjsaEdktS5/5ieyUUrFdPukJwXMVMpAyuZnjP0q75d/FQwMx4C48Vm5zo6UvLni/X4VvlsrSHk8BQamRL+slN32+ag04Tp6/tZ/uteYvmtw9OYnMAnwPiplAQ2qrdd4ZP2T0WZyz+CYmfatJhegpIBrE8e+aGbDpTqGYk3LQYd9cvTnXa5tq6jyr5rxu9DQsSDFS0pz8gVwCzPLmJjVTyfW1iQvaUAGvs65CCx6RT84yity08N+Ig+dnAKp7W8hoQ1e/f1iKQZEWDZALQZWkPbB6pYFh9/q6JKYbpel2efXOw3KLjng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(40480700001)(81166007)(356005)(47076005)(82740400003)(336012)(4326008)(6666004)(7696005)(5660300002)(426003)(8936002)(70206006)(110136005)(70586007)(316002)(54906003)(8676002)(36860700001)(86362001)(15650500001)(7416002)(478600001)(41300700001)(2906002)(36756003)(16526019)(26005)(1076003)(2616005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:07:12.1590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0387c668-2ab1-4445-e723-08dbf02c14dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

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
  cxl/port: Add EINJ debugfs files and callback support
  ACPI: Add CXL protocol error defines
  EINJ: Separate CXL errors from other EINJ errors
  cxl/port, EINJ: Add CXL EINJ callback functions
  EINJ: Update EINJ documentation

 Documentation/ABI/testing/debugfs-cxl         |  27 ++++
 .../firmware-guide/acpi/apei/einj.rst         |  12 ++
 drivers/acpi/apei/Kconfig                     |   3 +
 drivers/acpi/apei/einj.c                      | 151 ++++++++++++++++--
 drivers/cxl/core/port.c                       |  84 ++++++++++
 drivers/cxl/cxl.h                             |  10 ++
 include/acpi/actbl1.h                         |   6 +
 7 files changed, 283 insertions(+), 10 deletions(-)

-- 
2.34.1


