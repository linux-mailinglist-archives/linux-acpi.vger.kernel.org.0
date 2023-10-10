Return-Path: <linux-acpi+bounces-570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC7D7C415B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED78F28100F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6687225B1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZABM6UWl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FD32186;
	Tue, 10 Oct 2023 20:03:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58373CF;
	Tue, 10 Oct 2023 13:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKS5wB2Zhj9jF1WH87KikVNOeChHdVfe5+6ru9lDqhzm2uznJGLkWoaU8vynBrUhT5H2PKHN1mot67WF3bPsyEsTdQ/smoe2se+tTio9DVjwrPpgIl8FGHQFjydvX5l6+75yOlhjWP8g0gxKTb3iYxAO5i0ymk92Jd9XF67+wXB9nVQFFLrRG/LUYOsqPqAkolAdw/y1OIGSFxL0y/pmuCq++OrGidwyPOY30mnWX1zq6j32I9T83QMwcRk5RUjbQ/gHgN9USZr5LvxFP4q6WUOSAMs+ewG33iuAWlXwImU7syHR0/p6p8D9EAi4kjpxmJDhb8/pBzzikF5ZfeJ0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH3CYiLVgCawzg1RpXy5QE1S+kncjemUHZcThcYFOjI=;
 b=C8kPCx7W5Q4nINnUo8fBBMhU0z6KxSolkD3r6bXoEK2mMK4/sdnOa6QVrj519JyOwPT6SnYla0MN/zVxqxakdv4dW8Nj0oTOoFezZn1bpdz2zVv4KcHtwVyZCUqG+bVPPGhqCdHUZbfYnpFCSfWIqHPoMtKxg5AIAyvN5wWKlf15Fyl2/LWbsIfFeTi81o22P/zcmWbfPhuMAML56o5PX7YQdbBLYAG1vmzbplSkJXIBsxcvUQYMnpEGDRE0uL/4OqHgjjfgBh65XvEG0hvKCTud1D/obsctfv7lyxu0+SU+mdfmPAw6shOrgUY3Mm8nby/qsviaBU0pRMSEYVUCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH3CYiLVgCawzg1RpXy5QE1S+kncjemUHZcThcYFOjI=;
 b=ZABM6UWlboyx0l8Q3DHjK5P0mLstCNQ+FT+JLh3dmT7LQoWK3IMzpaV65eQsMtigAfF/2hmZksXPDOreMbfD8Iw0aq50ABLnuuk0KG5L5yo7NL5WXY6PoOa0FWrT4ZZfnNY9T+au+ntj3CrTvmApfMJB4P4CkOf/m5uUK++lzRM=
Received: from CH2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:610:4d::14)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 20:03:04 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::2c) by CH2PR19CA0004.outlook.office365.com
 (2603:10b6:610:4d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Tue, 10 Oct 2023 20:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 20:03:02 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 10 Oct 2023 15:03:01 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>
Subject: [PATCH v6 0/5] CXL, ACPI, APEI, EINJ: Update EINJ for CXL error types
Date: Tue, 10 Oct 2023 15:02:49 -0500
Message-ID: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dc0c75-c963-4961-6328-08dbc9cbe92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iL+W7M5oyYMw2Mag55OYpBMhhOorxUgrgy4Z5Ju1rJ6KpYNymFooRcPxkKcYio46kk34tS67DLI2ckML7skl1c+tbFBNhowQX/Hdai4qogvJGXYEwTpuaPkWX/3JC0b9Q51/vwT2D6Nwt9GNtziSRPKmsp+WkJWagjp7t4R3sHQiX7xZhMgbswaKEY28nDW2gorK+caHkJ395Rx9PKwWHsvPMSFaWNzoz2NPcxc/ZzaB/FOaq9ucOjWEDGqN0JR/mTXSv5wSxFMjhku4r484c76Bq3xlVuTNBW7WDes7CPSNNNH1M24XHm0CWjLY2n2+XZGQN/HS5RXMv5BxJ95rfUyb6QKrTs9f1gUc3A6rb6uROB3gEcWTjtCcYF/mNCk7y8K0RP1onev2tNUv+wu5tIJ7vi8G+JQ6rvPh0Ao7APzc4X1fou3TxoyUBOlGTABD45rncN2ZjO3dV+V0Uip/+K7r0YiAZeGx9UKIFAgM9fHuEhwFsY9QAqTAkpZB0ORQfV/UIUNaKi7sm9Sm4w/s+t/2XC7D6/CPqE5zduMk5WPcOaFafcBpehqFyAoKZuov1u//nzWpG9bn03LVVza0jOHIpy6arLI3W15K5Txr3TK/j/S//j6oQhLaCb180Cf6qNIHpnjj5r6eGIYYr/rk+NtGkKB7F2MXq83nzpmpopZ9SMAwIvQMoXv9DrblnJevP46kZqua9GIZifSAzewHMkwI57lIf5/FoJGWureDFXXiovGmelVVfB5+IV05IWOh3mu2X/uBNazVEf28D3Jncg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(478600001)(26005)(1076003)(16526019)(40480700001)(316002)(70586007)(70206006)(110136005)(7696005)(54906003)(5660300002)(83380400001)(4326008)(336012)(41300700001)(426003)(8936002)(8676002)(6666004)(36756003)(86362001)(15650500001)(47076005)(2906002)(36860700001)(40460700003)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:03:02.9598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dc0c75-c963-4961-6328-08dbc9cbe92b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 drivers/acpi/apei/einj.c                      | 149 ++++++++++++++++--
 drivers/cxl/core/port.c                       |  84 ++++++++++
 drivers/cxl/cxl.h                             |  10 ++
 include/acpi/actbl1.h                         |   6 +
 7 files changed, 281 insertions(+), 10 deletions(-)

base-commit: c66650d29764e228eba40b7a59fdb70fa6567daa
-- 
2.34.1


