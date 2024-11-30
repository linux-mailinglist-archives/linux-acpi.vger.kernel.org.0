Return-Path: <linux-acpi+bounces-9826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C669DF103
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3DC163A9E
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996E1A2C0B;
	Sat, 30 Nov 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3lDlvuO3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05019F485;
	Sat, 30 Nov 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975670; cv=fail; b=X0b59mDWE/rYDpxDeOKP/yoTdPYZEOwxpw0Etd+3VohdPg7cC/y123IOqxSylZgbCs5k/x40L4Y8VuXPkCRwZfu43qjPn2hyG3QA1rlpoOqwbyXHcAzGE3AUtZ6O5ReQ5/2YgZCN4zF7olFyF2xTiSFkMkWLJ4crHO7WUyAtvss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975670; c=relaxed/simple;
	bh=hECZMkZyOmPdRV/C1pJPOiwKMNq1IeQEeYFCaag9Rmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wpb85lOf7rxoVd46mU1vqFrY/l3l9QGqatN6f/SCHHYHgp9F21VgR3eGIIYHQMj9uyTUTGeF7TouxSabwOsidGT9FX/4VdbPU46YuBBjWzFUFHf/ALtJsKkjMFSbYUVDCUwQBNyN0aLWzN9IxWH3KRP/u5URt7FMerpbc47aYF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3lDlvuO3; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dikaDBmaTy/LSDML67CbQOEyM4e/3SKyCHZgH0Ogrn7UiHXND9tsFVaL6Z0W3fJzz/RfgxHdPERU7GVmvbUYx6qevtpavXjcrJWJbZLxdvQtflOSTbxmejRKo0/WS0CresI/aodChLreoyGIM6z9uY9bQW6fhOH8AFKu90JnKIqKbzuByUTbY7pXmtrOowvoMfzgnu0MV9gLr6nVY3nAuxmSH+ft88Xj8Lznk6E5E2lpjFJOQ8n3gJaHy12ewxUP1+kE8sXHR524KCwVT5vd9yw3AKQHDnlUIZ3JH4C71ZYj2L1OaMBra3xioqrhrCSH4iMXOjkbHWjoKTXevk2kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmzaxmQPUpba4J+WKUoRefh7jYYsfc17cMXsX7vJa98=;
 b=u9THBrN86X6mF3TSWz9oYhZwb8LS0PrRUB/fBjSySrba6NNj57sY9YOnB24E+IS0xWnEn8UT0yauN6fNbZbRBF0Bqji5GFybU1PP5xMVz3IUkZc3ecsmWEJcIakiOVtuQFNRU12aQ07KZefg+qm8dRhUONFe1a/RTBW+4D8FngYPiIPy+qWXjVYQtmZWqv6AfEm+dxtu90Rmy1X/1+TZvxNr3GEurfy8vu3emPkJqGE3bubSBJyCtAGxWYAU0NtMxHMHVHXL6yg7rqYpk+/2BDDyf1iGt/o8Xjd32P15SjfQJYIqp3IUD3dg8m41ophitzv1KxYgAArYG7kLCf9RuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmzaxmQPUpba4J+WKUoRefh7jYYsfc17cMXsX7vJa98=;
 b=3lDlvuO3d3jqZmrIn5qvwq9yW6/CshIFmSFku/7fKQZQH1lOy92pFJ37KAteUQuv/QKI4HxTxY48iYFS/Gsbru6OHpQ/aBSPohezeNBJKkfuLygWqY6mIaMjOkoOgFmgws7hJzMmaAk0Myg3xHaEk0qLJlIMvtjJXtyLIdIeSwU=
Received: from SA9PR10CA0008.namprd10.prod.outlook.com (2603:10b6:806:a7::13)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:07:43 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::c9) by SA9PR10CA0008.outlook.office365.com
 (2603:10b6:806:a7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sat,
 30 Nov 2024 14:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Peter
 Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH v7 02/12] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Sat, 30 Nov 2024 08:06:53 -0600
Message-ID: <20241130140703.557-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140703.557-1-mario.limonciello@amd.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee11a37-88bb-46eb-1d4f-08dd11485b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MbmB/H71QINcrsoL8ELJ+Vua/MzxE7mx5bFiIXhfllyphJ7HmesQwx1RMa/b?=
 =?us-ascii?Q?Sk04Kg1JTPU/ZotsPnTx4X7jFQJpfOp6jmskLNeN+meTGnoFDNYo/69oRaHx?=
 =?us-ascii?Q?ruyvgfSLejhIXTTbd2O4xlQPRLKz2BBNsqsFerzBz2F7nV4MOQQF30aHyiO3?=
 =?us-ascii?Q?GIwGwRKyuWLsNwLvtGVoo0FF9TGMi5WJQcJXub2nGls8wG0BqwovIIdEZeaM?=
 =?us-ascii?Q?b46XKseBGTnToI7W5wmIIy0QTGTTM9AlReb5opJGM8VjCan1u9oS6DD9dGTA?=
 =?us-ascii?Q?AIf9n7KNDzqkiHRUCTMaHoTGtWhhrAVXTdYG9isF1brDIRqQTvi4ZSk0SnGr?=
 =?us-ascii?Q?UGCpxFAOQbUGRs9FoXjPOlBtMpRd57hvZLU+ZNzQXy0xwdzZq4hNyv6MGRo6?=
 =?us-ascii?Q?HDPV3kpPbCeP8FlEWRZgq0+gLUacRi7pnyKdLIKEvx7Et4d6Ys2Sjr7W5VxD?=
 =?us-ascii?Q?5yn4NEi3BpolZTnMJ9pt9WWUIKeHvZ1rDHtH4Zskdeuwi2J6kx8P9v/t5G6D?=
 =?us-ascii?Q?gfmq8poWD0kDcbXxZbQ3K1LGmZGAaw55KJ1RePxt9ZaVYzR6X7OpIpgNsBnB?=
 =?us-ascii?Q?ZWXb/3kSD8jnw0mfHkWcQtAS7ZK9xilNNirpPAY0lCsOc06fHXV2k5zJ5N90?=
 =?us-ascii?Q?C6CWs2OM4kzZmka4TV7uCqLlGYW8sbVInqc+RjCUZkp84/KRdhn0TitB6y04?=
 =?us-ascii?Q?We2BZE0Lt2GaNQ4M112pv+NWbqpJx0IrQ5KwYhyX7sM5jx7Tt+DJlA6cIWNJ?=
 =?us-ascii?Q?UehsVA4EYTEqwqAXOoZCGMR8/iDz2dQMLF+vfxgEE5Lper/gtX03Zh0xSSDa?=
 =?us-ascii?Q?tqyc6An8MUksTv/bvAUk9/hFvUI8s6kUdOAtfoj2SkmkHQXOzCy+WgGrnXvW?=
 =?us-ascii?Q?E7Dbtlo9cewyGBd5OF4yfic1iyMCtvSQQZrWsHuYy2/9s3PkHn/u/HFYGlAs?=
 =?us-ascii?Q?KA+BFnnjRC4gANKelGzUT8DWFF8XlXPI59dIlCdwcrB15cjyJVoQD28PZIRf?=
 =?us-ascii?Q?B43qudnLOf6lMQnb4P/2hE6bYxJpATJB+uBjh79d1z3/4uMHgvFDFD0Rnkd7?=
 =?us-ascii?Q?w//sSLpRXcG9HTUFLo/zoKzB9olOHL5fC4bTPn9dLOeUhdExX7AAj6YHLjNC?=
 =?us-ascii?Q?Z4Kgc5Jagosr4TO4aIld7ncKK94gAs6cH7uSYDv0bvpUvfuYSh0dKjPVNWrT?=
 =?us-ascii?Q?uxIs8JOmjWHZ9b14aQgMrKbvjWdO/b3sZ/bqz6LvHFAQC9iqtG75pXk8CB0L?=
 =?us-ascii?Q?i0Ehz1jWnbWaid4c6IIvd96lyR9YBoCOccInZmtUMH7uSpaXH9+bNSiyueSl?=
 =?us-ascii?Q?lGMkEKl0uUIUGPUBot19h45512HdpScKNWEfD2Nei3h5hn6Fa5sfw27JNDFw?=
 =?us-ascii?Q?MexOVcfix4V5g0x+0BCDfu8WPhfKAY2P9YtgTDN9jIzGnwpCxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:42.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee11a37-88bb-46eb-1d4f-08dd11485b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

Introduce the `amd_hfi` driver into the MAINTAINERS file.
The driver will support AMD Heterogeneous Core design which provides
hardware feedback to the OS scheduler.

Moving forward, Mario will be responsible for the maintenance
and Perry will assist on review of patches related to this driver.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1fcc56bf2fba..62f384c41b36b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1085,6 +1085,15 @@ F:	arch/x86/include/asm/amd_hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp/
 
+AMD HETERO CORE HARDWARE FEEDBACK DRIVER
+M:	Mario Limonciello <mario.limonciello@amd.com>
+R:	Perry Yuan <perry.yuan@amd.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+B:	https://gitlab.freedesktop.org/drm/amd/-/issues
+F:	Documentation/arch/x86/amd-hfi.rst
+F:	drivers/platform/x86/amd/hfi/
+
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-- 
2.43.0


