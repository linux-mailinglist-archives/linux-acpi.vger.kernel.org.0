Return-Path: <linux-acpi+bounces-3498-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36F18553AD
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 21:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474231F2AB38
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12E13A888;
	Wed, 14 Feb 2024 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YdR9Sr7K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8013DB92;
	Wed, 14 Feb 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941302; cv=fail; b=AeG1WaVlAWUZEkPqpyO4TCu2G8pLLyiIUf1ZUuaiu3KvWxl6cKCT0ShXSMVLenYNBX1N5QsC41aqA3ANzRZoxD/nhu28iQWavnDa1fzLejqymHiQrSw7bCvc/FAYScV8tP10i4CM4hmjBlAZRNE70kw3SfCI4vBeCC3fqj4QpnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941302; c=relaxed/simple;
	bh=9bGWH6UQsRyfN7pAHYyjwqDWKEdunHgPJsX18hik3dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snVPjQI5QfYUfqwnrN7hotYNSF7t4e4MS3CBw7J5/B27Xv4FGemsoT/0AoFB/JUGi5RmOunGGM7aSUmV2YRGFv56Qe0MkaQerCiUG9UKCrAWFQNoQMLCbqNrbjexwUI5q1mjJk05Nzo71kupighcXr+Nkaxirqa7U7IjTLFHYSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YdR9Sr7K; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfvuYGF1JybJ5Ph11dupFoWsOI0wZ22PFNGhZy8P8gZ6HyttVFwv2mI8hgsbqPArMGBO7CxSpR0uyxfDF+L3HnAjPrgX2krzD1J/UxDOMOgWEWl6IO5RcHt7HFZVYbBX+N5ZEVA2Sebq9dMkfUhvBBaWMIv13OIDLFOrWKnjw+wBVrVlf7HniHjZBQS3fR9u1uyCiMYuxEdJN7wyenOpII2Y1Vo9D4AHZR1I9+aKswOiSKgcjlPMuLjLe2hRDMohP3FIonYQJ0G5bayiavmGeM/eMqqqVaDYuWiZC3XoI65c3++kG9vvP46D2DaBN4q/lD7ABQsFl1VsClLgoV6RPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+V+UaTxdo5dngRzFCUy098HJga3urEEs/GVqyPEssc=;
 b=QOGn+DEa7B6QsVx8SgKodI+rIYcna4GrdR73euzIC+P6S+hX61COVjLs3L14+8BpuSlx0w8nEHDF/wfmBBi7LEWnN/wzneDR4GUshNlA77KUmJBdiVwmZ3WYEMJKUVa8MnSOLZc4NrP0UcpT/6pZLJ7a5uHjeaDpQ293sPoWjcJtI0AfaWbM/4dTfbuG/nLbsA3k9OlkTo8Rq2ehY2rkWVkqyf4pXO7ZuApdaqkkNWZaf8X1HZeKijqUc2PO+RViClv3YGLLuMX+trgtRHVzixx7ih9f3QkqR+Olo92OlrGY+zMSyby3Mk+IGOhdPRC/XGbBAqUHc8NLkjDAyokLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+V+UaTxdo5dngRzFCUy098HJga3urEEs/GVqyPEssc=;
 b=YdR9Sr7KVm5BqKF2gThtLzNWMCJTAkFq5tNSRhuGyN7KJOpWBqQZtF9zJW6BdKS/AMuzC4SPsbueHmA0ZvnT5Vs+CYY+GNtfGw9j/HRkMbZmQ+4dtSlC4Gy5Xe+NExEnuaGoSP00o58YJZBSwvOs7pzCg+jY1eTR5jhZ4nGWa6I=
Received: from CH0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:610:77::35)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 20:08:14 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::75) by CH0PR04CA0060.outlook.office365.com
 (2603:10b6:610:77::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 20:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 20:08:14 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:08:11 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<rafael@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <benjamin.cheatham@amd.com>
Subject: [PATCH v12 3/3] EINJ, Documentation: Update EINJ kernel doc
Date: Wed, 14 Feb 2024 14:07:09 -0600
Message-ID: <20240214200709.777166-4-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 445a8468-b9ec-4447-5a66-08dc2d98ad13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ejKIVrM0kPzg2mZvPEUXmMN8/fbkgjeFtqqpzdTK4PFMQaQRIK82DeibrqAid49JsEJlVqHWitCgdCZfTNwdwZZFTBMZO8RvBhidDiCy6MlQGy1Xr1+2+/sUlasKxibVAQp4XyFmRJH6Wj6kubeFcHMIaP6M8BQgrglj5jVoUPyCaPUUJBRrAKKMKbrtf/dcW2ZG6bhzxmiSNgGtYm346uAxxss8bRnJEuL8QW5GCKcoxP4RjnfcdQFFZJUxyeOimxj4GCu7gliAtq9BiwOiCfJfvzYWMGd3HF1gYOG2Qx5XLiD+5bqE3SxhUIaEs5GhgIUSAbWR+ezZrID5cW+FFqO1h/8g1snc7eU0iHtuBbJWSfxIiL9zDB1pyf2svUxleGPH1o3kMj/fJq5L7rj4NofnsrN/p4/Saz9a4lE6LR6gK+0aZ6L29dtmHoxOREDk8KaLpWmZLlRvDOrFuIJ2i83X7DKqnRvH0gKOIT2nGvZeQVM/TigrZulU7o5QLkMIoaZiWZeo+zA1IlCrWIQZNfUpGyFOQPvjsbG2j8peJQXu4nFHAxVZB0Pgb+jJiAbJ6dCaQ7e6BAw2WaJC51FI9bRFgfggiY/EVwjSKW8su9U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(5660300002)(4326008)(8936002)(7416002)(8676002)(15650500001)(41300700001)(2906002)(86362001)(356005)(83380400001)(81166007)(82740400003)(36756003)(1076003)(2616005)(54906003)(7696005)(19627235002)(426003)(316002)(16526019)(110136005)(70586007)(336012)(70206006)(478600001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:08:14.0523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445a8468-b9ec-4447-5a66-08dc2d98ad13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..f179adf7b61c 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -181,6 +181,25 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+CXL error types are supported from ACPI 6.5 onwards. These error types
+are not available in the legacy interface at /sys/kernel/debug/apei/einj,
+and are instead at /sys/kernel/debug/cxl/. There is a file under debug/cxl
+called "einj_type" that is analogous to available_error_type under debug/cxl.
+There is also a "einj_inject" file in each $dport_dev directory under debug/cxl
+that will inject a given error into the dport represented by $dport_dev.
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
+To use CXL error types, ``CONFIG_CXL_EINJ`` will need to be enabled.
+
 Special notes for injection into SGX enclaves:
 
 There may be a separate BIOS setup option to enable SGX injection.
-- 
2.34.1


