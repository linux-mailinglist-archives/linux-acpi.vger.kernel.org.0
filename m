Return-Path: <linux-acpi+bounces-112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E09C7AE04D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D3AE280F82
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7552723764
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 20:30:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676D179B4
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 20:01:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57810C;
	Mon, 25 Sep 2023 13:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBOb9x8bpH/rdUh0aHJX8cE+F/Nh7qSLSz2R1jHqlaSZj3FtZpT/KIzjRkKgKcYnQBRKQE0lg+q9ajeth8WIMzbxM+nxOZ1I4sHimTRaybyxUuvfz/X0tRdzDKHEyNnsmNYcywglJOE0JVXL5fOxkHWXpFtKzIVkw3H+z2R1HuKVDaFvxp9F5BeCWAk5xE8phMGmdKhnJfkehKa3U+tZ8/fbRStl6tM5yIxRi9nvHRh+3a+7/lXCWdh4b6DhRpMdzEAuHro5gtbpfcNhCWBOpWQnzKjuVWmq8vIt3SE8z9vy90RgK4Xs10WbYX/XZRlRSKcM4Ezo0IYuPCNugxmSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpOyy1OXQt85m+2zwrVasWvxUQucWNtFTMUXD+HTuVk=;
 b=SzNaOhm9EjIQA+kb4zXYJKCYP1BvQNkbiUAuRnkskHsW2rb1iTjrJmw9WiRUYJwuz72Ytb2IsqNdZ9f9uw7bVmw/F5cMInbsIrdPATJZOiFZVQfqjXQeSAAIhA/OesgjyqOnuUS3Tl6YnKVLVh2mZQEw5Nz/1+6UZbZGIqGHQB2ok56hUJ4JFcWtziR9a1Y9J145mi86rerJtCdhHBis/DpmhOuvfqAguKjPyP/Iq9lZ7pbz9tkwB8Uj4cO5t1CvAWjYaGXrxziiAFzDI5wAspX9kqL8lgwQKigyBNF9P5x6d0Z13G59dyeoWvn0S78iGxv2owbjghDgHNpl12v40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpOyy1OXQt85m+2zwrVasWvxUQucWNtFTMUXD+HTuVk=;
 b=hIoXAHphAggv5+hR/qpf2uzAh0HQcM9bgiDGuwiSQDWs3K9It+gPYvwMmZcJ2Iuw3yFs6bKib5QNLCNDk5OI3ezZSjMGXvObAREeZ6zlLA7538iX6YunvPd3LhQ8Uz6PxrGngeRT4x+/YJKtsCIF+wgDeJ9iDWby9XZDNZZifYc=
Received: from SN6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:805:66::20)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 20:01:54 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::f4) by SN6PR08CA0007.outlook.office365.com
 (2603:10b6:805:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 20:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 20:01:54 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 25 Sep 2023 15:01:50 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
	<yazen.ghannam@amd.com>
Subject: [PATCH v5 0/3] CXL, ACPI, APEI, EINJ: Update EINJ for CXL 1.1 error types
Date: Mon, 25 Sep 2023 15:01:24 -0500
Message-ID: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: abc8f6b5-b4ef-425b-7371-08dbbe024438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zm5OgNQrCukGL15rFidoEMrvjg5PzgByqak841M/13f72DR1DnAKzOhb+2h9pF5lQJaHT9YgdDvLP4wfciYFbcX0J/qjgtEVeAenMxGNl3Ge0xYwonNui/Ppq7RAy86AJJIlhpbx2xrQgdpuQeIUQQOh5ynnEXIkF88MdPsKVwecTj42gZyoPa/DPEOANuTShXeHUXqxqpWdHEb4mJWkCjfY3mdYQxXf1U15lAPZVdcj+nP9BW2MOG1xJttSs0OY8hzmqpAD9HGLooQ+XoysP6KPXXjuTyi1cw2YfOWisD4dT7p/Yx1F5VpC61Rx4f0kS2xg79FVUuZIaitz6+L3ZYFuSHYCvL31kE4nIiYBowN//YZAuiIQvZ63xnyNCfgUkRqU3mnseC1JoimAvSAhHGIRX7JIdOKOJCP9cKpi1f82cV10jq/2bPGfKFxmIts2W8LI0jsQaqlaMTLyq3FKMidpUtQHfqd+ZCWuXrB1hFMJQMNsKREDF7g8RVWbtot8p343Luc7/wc94VQbPUr00SCUgA9Mmt8NkuDPAubCElBeJ6JgighCkWGPQ0SkCCTxN+2MLwnrZv3mbBSqZUt4Er59h8nx/ErAjbYDeMt39XAToSyunbaiTCj79KXa9j6CCH6VtsQoP9UKmj5OPFLmgGx7rxUiuCmB5eVC9jwKeKfbWCe1jsOrJuLA/ffLf+WRQfqnUD01UFGfi1VE1QB17gNRuCAcS5p2kcg7KVoqW3bc8Sc3QoW0BklpoMEYCiyW6c1iXJ7WUltFqRe6E5MuQxZvqCfjAqM77MkFeibsSB8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(16526019)(26005)(316002)(8936002)(8676002)(2616005)(54906003)(40460700003)(4326008)(70206006)(70586007)(110136005)(5660300002)(1076003)(40480700001)(41300700001)(36860700001)(6666004)(966005)(86362001)(15650500001)(2906002)(47076005)(82740400003)(81166007)(356005)(478600001)(83380400001)(426003)(336012)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:01:54.6194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc8f6b5-b4ef-425b-7371-08dbbe024438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v5 Changes:
	- Removed device_add_file() in favor of using sysfs_create_group()
	  and an is_visible() callback
	- Add setting cxl_root to NULL on cxl_acpi driver exit
	- Add real path for cxl_rcrb_addr file to documentation in addition
	  to symlink path

This patch is a follow up to the discussion at [1], and builds on Tony's
CXL error patch at [2].

The new CXL error types will use the Memory Address field in the
SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
compliant memory-mapped downstream port. The value of the memory address
will be in the port's MMIO range, and it will not represent physical
(normal or persistent) memory.

In v2 [3], the user supplied the MMIO address for the downstream port, but
per Dan Williams' suggestion [3], the addresses are predetermined and
the user only picks the error type to inject and the downstream port to
inject into. In order to inject an error, the user write the error type
to the error_type file under the einj debugfs directory, then writes any
integer into one of the files under the cxl directory.

[1]:
Link: https://lore.kernel.org/linux-acpi/20221206205234.606073-1-Benjamin.Cheatham@amd.com/
[2]:
Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hNQUfWViqxbJ5B4JCGJUuHpWWSpqpCFWPNpGuagoFbsQ@mail.gmail.com/T/#t
[3]:
Link: https://lore.kernel.org/linux-cxl/20230403151849.43408-1-Benjamin.Cheatham@amd.com/

Ben Cheatham (3):
  CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
  ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type support
  ACPI, APEI, EINJ: Update EINJ documentation

 Documentation/ABI/testing/sysfs-bus-cxl       |  9 +++
 .../firmware-guide/acpi/apei/einj.rst         | 25 ++++++-
 drivers/acpi/apei/Kconfig                     |  2 +
 drivers/acpi/apei/einj.c                      | 24 +++++-
 drivers/cxl/acpi.c                            |  3 +
 drivers/cxl/core/port.c                       | 75 +++++++++++++++++++
 drivers/cxl/cxl.h                             |  3 +
 include/linux/cxl.h                           | 11 +++
 8 files changed, 147 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/cxl.h

-- 
2.34.1


