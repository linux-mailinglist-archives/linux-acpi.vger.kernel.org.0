Return-Path: <linux-acpi+bounces-3740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31585CA85
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E35283910
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB92152E00;
	Tue, 20 Feb 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SwkLONtW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9941AAC;
	Tue, 20 Feb 2024 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467198; cv=fail; b=g8dMh1gqXMHwXjekE42CGLFimk9rfMr4CgGCfVO6yJMP0gbUDURsoroyCSU5APGZ4fj7SvH14zyTfgAfAubrKuNRlCy1/1wiYffaMGUyX1S142mSDO7kz9x5Xntc0Jr6cQO0U787UKZkShaqB7R98yvxPPQO9PVOs2usyc37Az8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467198; c=relaxed/simple;
	bh=D4x+DsExJV9XUfdph+jiE9i9mkuhFK0JT0tqJzrmsTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izm3Gr/6n1HaypYlt9w4Q9kjdNz2P1odVjT/NR0RtzSREn4cncu+qAV0qiKIIVbAG9HAcORE73jc51cKKJ7MZeca3SDv3fQ93nAgv8Gj9kk3j4tdnYPARXJvmPXtovZWximmjY/CK0VkAro7FpNnqGDEvGEZDbzq48aHvRG3ArM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SwkLONtW; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmF1y+GYdXXXKQ5iP9St/SoxiQkamdUleiB3kxVpi9CdSzqNAPubNXugWD9ValXsq2ALp+6umDyQ2UJjVOtJAfyaw5GTxmX0sEYSLG+uCXWYrx2d1sQNnhXp3/cSxWQcLHI1clU+cZ50es2jaIOqEgqaXTAhLzvm+e4A3m5tjoDKP2LbObyx+EefhuhV1Zrvt1LZEEokw375ma+kPCgW/t9fk9liJKGnS6LScNUZp8QnzjCeKyGQCE3E+C0FwkYQV1bHD/ZE0l75AyzUnKfKCC5LEt/j2iA3aj5kcf9XrEqc8kUZZGvYFncxPuSDi37q7Ynoqu09qvVTJFBnAnb+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlxMyomHGM3/6tpI3AdRWHoeW+p22bBY77GnErVQa4A=;
 b=ZvtGjytk7LG6xPw/PzJ/qh1pTnD+SpNo9iyynePvBs6NdS1RyjzKb69tUcfUWKG1OQeDK7PWBWHmThjtrY8clLm8WaGasXlu6SZm3xU6bIULZwhwQx5y+Jtaf7kX+wJOr6QT2E8kvDFS30rNqMFi7FeyJN8QcJ4pSWUyx2lDpPAjj9Sq96+Gx/X/tCe6VS5sBEqCjSORUC5MptVZF6tVf7nBBnQOQl2lCR4C81qTpb+Rc6L5ADlZTERZk9D0koL74N/OvOhsmJV1uvr5IVJqxtof+JLIKLeVCY1I3IkxBKwIJyuwY6ledpuwCtfE0n0yFyhN1Jz4HfwZ+gIAC/KeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlxMyomHGM3/6tpI3AdRWHoeW+p22bBY77GnErVQa4A=;
 b=SwkLONtWwMoow9t61kg4G4D34xcDMjhlcD5Xmc3uOAnQwFgVo6vX/XBI87ZVAShnbZTcLtxJkI/4DlpC+aloUGtnM7EkJnP0hAydOU5mU/kygkQo4QnV6nkpA4jkWWzqJU3djxs2cPrKxE8E1Zp8qr325ge+ns8RAg/pdaUjh+I=
Received: from SA9PR13CA0082.namprd13.prod.outlook.com (2603:10b6:806:23::27)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 22:13:13 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::e4) by SA9PR13CA0082.outlook.office365.com
 (2603:10b6:806:23::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12 via Frontend
 Transport; Tue, 20 Feb 2024 22:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 22:13:12 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 16:13:07 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v13 4/4] EINJ, Documentation: Update EINJ kernel doc
Date: Tue, 20 Feb 2024 16:11:46 -0600
Message-ID: <20240220221146.399209-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
References: <20240220221146.399209-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed64091-f0be-4990-9c7a-08dc3261212e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EeD7kALFmnKjTAOacbahXxyY4J+BCJa/+8QTb3vanp5tFoOuu1Z3hwlkdUuH35jfsDEf24LNqrBlqzVLyhxKOxnKjHlxSwG4j3/5CXD9dXE3tN8B3p+LoIplQhqgJ7pRbCm1g1DoZ83fqBw1yn8fBf+gINBGtg+poY2Xmeb/gEWzTDak5yF0N5jRU2ApuUelIp/QY2E6GVSCGVqgG44DMUnT4zi3m4OCDRCEYE+vVpl/u14IxHw5LFcJQTkne0H/DGChFdfv+xnEQBOrBPwirmhsulJBGajmISoTYBiCb7OJBY6uQke2KVKFgDps2fWRAGQIoFfRY6QDTzd8UW0Q5QLCwDSw+yJ/uYSwX9+HlLu9ayk0Nz5a5hu8L7LXb1CGh1OS9YhbWJHvoVRoUN94t4dfMxN1yf3qBWGr2Nc+m24vmVQN/kOsJvfBqfc4AEsBbC5u3RllJum4izRvkHRpznnn4KYbCfhx0bOqkQ4NFqWwe5w1gueO/CLfn2gW5M+gL8EGeUXeRLibtzQAGCC1WX9dkL1gKzec+Q6lmEQXWQMwVE487AHWKAtLEOUZFVyy+bp3daRkmqQM2GsoYEKa6hArhI0Nv6e9fP6HEt1F/VmXA0CAKlUVOdT2nA/ww5IK3K+C93JX3luknfbalgHUKQ4LmPloNKaQ0t/VwuwLMf8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:13:12.9218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed64091-f0be-4990-9c7a-08dc3261212e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..23741ec0de75 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -181,6 +181,27 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+CXL error types are supported from ACPI 6.5 onwards (given a CXL port
+is present). These error types are not available in the legacy interface
+at /sys/kernel/debug/apei/einj, and are instead at /sys/kernel/debug/cxl/.
+There is a file under debug/cxl called "einj_type" that is analogous to
+available_error_type under debug/cxl. There is also a "einj_inject" file
+in each $dport_dev directory under debug/cxl that will inject a given error
+into the dport represented by $dport_dev.
+
+For example, to inject a CXL.mem protocol correctable error into
+$dport_dev=pci0000:0c::
+
+    # cd /sys/kernel/debug/cxl/
+    # cat einj_type                 # See which error can be injected
+	0x00008000  CXL.mem Protocol Correctable
+	0x00010000  CXL.mem Protocol Uncorrectable non-fatal
+	0x00020000  CXL.mem Protocol Uncorrectable fatal
+    # cd 0000:e0:01.1               # Navigate to dport to inject into
+    # echo 0x8000 > einj_inject     # Inject error
+
+To use CXL error types, ``CONFIG_ACPI_APEI_CXL_EINJ`` will need to be enabled.
+
 Special notes for injection into SGX enclaves:
 
 There may be a separate BIOS setup option to enable SGX injection.
-- 
2.34.1


