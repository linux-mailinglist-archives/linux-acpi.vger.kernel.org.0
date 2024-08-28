Return-Path: <linux-acpi+bounces-7929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA4962D3A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9743B1F2199A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E321A38C1;
	Wed, 28 Aug 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GFnjsNoI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1F7E574
	for <linux-acpi@vger.kernel.org>; Wed, 28 Aug 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861064; cv=fail; b=PMjowhF17GFpEyTchaMqfz5aRKlTWlP2qxGPT/V0etZxXq7HdHDG65m+TJBauXc/JhZbnAu5woSo18895DmEOouukN6NJMUNjRQFxJ/D3r3ouZBL64tpRLTlfOasf4LIP1vIw7vlYPV+vI11C0P/Y8Bn1J4al9OfU07uh3sAXFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861064; c=relaxed/simple;
	bh=I9t6pKik8IJzgA8pMrTj+7uRtgdoFo9rDTPbnwCWwlM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DIyNQorgU1WWHKH8uBlkTq8qab4w8lM+gp5WczKJch4mtwYa+yv3jJGTwpnmFRzUb3/27O5qVUkOYCOdj5VmfZ4cVjS0EbrnD79K9/css7O0b44dJ0y5cQ30hcM5wuhDDRIn7mhm1ZCl2IyoLt7MCHZVIpHU8DyFReaByFzilXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GFnjsNoI; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X77XX1C58woOMwBcaYminLpExhdAyESxWh1BtD1EIXbHY5iLFLqt4IBdzA5KTWXmeqXeTL58V9WgSZZO3kGD26VPhOZkqmgebrBaY24ll/ZOFg9lF+UOrvphTpvjdfsaJc/pmyuFWk1SUTmiXdE4QNDPZx6Dr5CPsYKQxq/b3wWY8CpO6Cw5LXBU+2a9bZiRc6sn9VbSepdX3V2g8ehUntXi9+OWwH4EhoEjLu/QKBwHFh2oHGOPxPpHwjcVM53Tsxp+MLQglv5k3dOXA/mTN5bDwcxaJBCl7wcqybfllsLXJQexf8t8eXzfptYLNE+QC0YvJFheD2PMq3VWDeU7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGIOsU8yGKblcrxSgQupcmQNS9pommbkvGsjdC8fz0A=;
 b=WUfPv2xTcqLyJ2JZW/J3xIVsyzsYzSb5xMxEVu8KxQn8gm19BXyLRweq74Om0mp2zinUpxTJUl3e6NsHUwbqpHZK1mK6U0QAQrx8kegCUaYQizfeQ+X3YdFje9EZQQJ1QxPtJjjTDQFf97hB9OUJ3EgyrYdbbsOVdKmBxwuC7LTrBWqtbR3VfInlf7PiMSUB1QzlbXwPTR9lxH2QmZ+0rFy1Z2DhM3cWdB+5er4YA2AcDn00h0BSGhdy2eNaNBTrYg8JxY0TWgZKDlG3VSiNXLu2wOurOLFVwssxzhqBEROeSlv0P9VRBMYXeRwJgTs3cKg5QhnxzU2k2ZcFScjUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGIOsU8yGKblcrxSgQupcmQNS9pommbkvGsjdC8fz0A=;
 b=GFnjsNoIhzW6vziWlW8ZGnx6i6XsvYdjW0sKqQK56U1qIWD8aTIHjeYo1qmMO25Wp1y4IE8aGNAd8Ze/UPtuNIco2u4wXK8i4t7gHz9His2AwZ8E+x7maetsT67g9xBFZcxDo68W8aFsN4ViNH3xwPUEnMgCWis7PhYTEbkEBtc=
Received: from BL1PR13CA0403.namprd13.prod.outlook.com (2603:10b6:208:2c2::18)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 16:04:16 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::45) by BL1PR13CA0403.outlook.office365.com
 (2603:10b6:208:2c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19 via Frontend
 Transport; Wed, 28 Aug 2024 16:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 16:04:15 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 11:04:12 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH] EINJ, CXL: Fix CXL device SBDF calculation
Date: Wed, 28 Aug 2024 11:04:03 -0500
Message-ID: <20240828160403.65771-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: eb762d0d-d47d-42f9-9d8d-08dcc77b10eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmvkN4e5bKyNIAlszcnOIY4/+BcM3tIEf0krabM3qILbR+UjfqJzB57pqGJj?=
 =?us-ascii?Q?UZ2SAZ85Mvfp/v26nweU7DiJmNtbvqjPCDX6rmzE3gImZo3TvD4QN+kyQ+7A?=
 =?us-ascii?Q?7fonvk5j7mZqQ7JtxX5fDATjBGWYxyxe9uomirYuHWuOGDVPi2QL0zSvK1ul?=
 =?us-ascii?Q?f/M+D0GuEAGZFyl2kpQke3qTVcLAN+xt6f+alwJqTHZSFT2qnyVBa8YOlxOJ?=
 =?us-ascii?Q?CT7qNkcI3nKhWyg4dMpIlfq3cILR0JfuSWrcdDSPE7AoE4PuigimjLMw01J5?=
 =?us-ascii?Q?YCS90LNl3pJpUphF63eQxhh3hLN71/ryOXJZRsRpbd6uC+SBG5TA1aiyFJNG?=
 =?us-ascii?Q?RQguYAixHsh/9h9lU+7hYGWdqf+U/iJNBYmrI/CdyrQdYSuvndUluGLY47YO?=
 =?us-ascii?Q?s1GdcdhVvnhZmRDydH2h3iAy1L+mStq8IB+KvpsZUy8/TRDDIl8l7jpGOKEZ?=
 =?us-ascii?Q?Bf3lmqgx6UVftzkVM7PDL/dN/AZpeGd5Vg8WoLheoHXt29LsPdUzL5XWd4VY?=
 =?us-ascii?Q?g7FL0abaizl+blpqY4YpXodzlS33hMFc2hye7suv5o9CQ8B9bG/tRHdKc0iP?=
 =?us-ascii?Q?D3acP/CV+HuFbL01xi7pNI1RymLVeYNkNmtivRk3nsE2yBedZjOPlUP73X7i?=
 =?us-ascii?Q?geY3DOdfg1YiaH/TdEs6HEugaM7AfH7H1Sfl+xDdCefwb5Lh/Hf+WEGaVCtn?=
 =?us-ascii?Q?ivHAHfSaOEDm5gwas6Gjl8DiZVazeaicAOsRQS819ncVt6WMLJG26NG98A5A?=
 =?us-ascii?Q?xA3yLSEEoDN7IM2iGub5ZGpTW1sc7m9zhS/0HhRZUL5cOSpKX/KsQmk5BBhu?=
 =?us-ascii?Q?gK5NPIPmd49TSRdl5kMdexNwAttu6wJVfo0V4vU3V/wQ8IZTvGH7zuCmfB9T?=
 =?us-ascii?Q?gvcq1Ohi7aYEp4UzL1L9CTDqaUPPieGxQzbSCIAhQQbS0Ce/ogJX6SMfYHYo?=
 =?us-ascii?Q?MEs+FvYQiMAd+ZrTsw2f2Wv6K4HQikfWB8LTYQdkY+CsK835DcyqTJG9oSjc?=
 =?us-ascii?Q?QbGFUKms8RdhiOlwoLunyOVQfBK8A8/ZX5K1Y0tGAvsyKnb15imTw4E+6Wm+?=
 =?us-ascii?Q?ig5e5vVqRhVYeQy79pOZfmK3DcuDOzInV95jDVoKUeArMZ6JDenYCkcIb9HH?=
 =?us-ascii?Q?v3eWVY9zMCg3yvty6CJiUp3BBB1NXDKdIUJFlzop1Q8wfURF5QzjL/zKZKfo?=
 =?us-ascii?Q?QpQAuxJhsiKl80nNPp9R0O7fJ+Nftnrt9H2s3+2ppO5MFQHwb1VPMmlC9UiN?=
 =?us-ascii?Q?wys9HsAxoYsmJNblL20WRBhA/JKP5MCUHtQlwzif9A8iXyb+/BDVJmwnrmEB?=
 =?us-ascii?Q?ENhyBZR/RX7dnh4inUNs5Eemoh+Sp1HSkvA438SDAaR2IFq48xeIH9Ux162P?=
 =?us-ascii?Q?tO+lRjdT/6AWt4XB9pOsIJYSrS5nxWlN2Us++8oWh8GpOu99qgFqc4rAnJra?=
 =?us-ascii?Q?jkWUwtuYGcreTD8vmhNGP+LV8ybHiLJB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 16:04:15.7924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb762d0d-d47d-42f9-9d8d-08dcc77b10eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177

The SBDF of the target CXL 2.0 compliant root port is required to inject a CXL
protocol error as per ACPI 6.5. The SBDF given has to be in the
following format:

31     24 23    16 15    11 10      8  7        0
+-------------------------------------------------+
| segment |   bus  | device | function | reserved |
+-------------------------------------------------+

The SBDF calculated in cxl_dport_get_sbdf() doesn't account for
the reserved bits currently, causing the wrong SBDF to be used.
Fix said calculation to properly shift the SBDF.

Without this fix, error injection into CXL 2.0 root ports through the
CXL debugfs interface (<debugfs>/cxl) is broken. Injection
through the legacy interface (<debugfs>/apei/einj/) will still work
because the SBDF is manually provided by the user.

Fixes: 12fb28ea6b1cf ("EINJ: Add CXL error type support")
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj-cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 8b8be0c90709..d64e2713aae4 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -63,7 +63,7 @@ static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
 		seg = bridge->domain_nr;
 
 	bus = pbus->number;
-	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
+	*sbdf = (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
 
 	return 0;
 }
-- 
2.34.1


