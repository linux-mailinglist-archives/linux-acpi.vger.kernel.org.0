Return-Path: <linux-acpi+bounces-2869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDCF82DE65
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67401C21E91
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DD317C9E;
	Mon, 15 Jan 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4nJ4fr6m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDB17C91;
	Mon, 15 Jan 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVxX8OMOpQIogsqT3FYdoNxqUjAlwbsogl46QSnla1coAdSpTRpdiukV1Gk1Q3LL8gPkxE7XAipmNVL/2ojqJWzmzVFUSHRXKeHL2551V44xLIxG1btlV7j+LAZM2MW2vcVTBUm2XbBDzoPfigihHeQxA6nY5xPBo5fz/EdLDE3Jw/mlpzX29wBmCZ3TaY20LDYRmIf7uWOZSjPsj7ED8MH5WvSdfUZ3yUcuAKRNABz7HjUF2fEKVmQ9oIey5NoXmlKsLcRQqqf51ftZjqwrxBQJH+a5Qr7pYaWR3+3lSbG9jfxvLh7sLj//KYXTRrFMZ5AFo53Bb2uSeecWAyLTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNi+RMOURb1Rp8Rc6Ghi28eCqTP30Yk4bHvDM81X2FM=;
 b=H90hxezCnGRhV9pYLC8unG62suw/PSs/KFd+/LHJYsWmd5c/VyhH01HuBBqsVt5Z/AZv57cFHfE+pOKAB64QdogSkfQ4RCpwSOCSoDdwlaXhfnREo57HuMSUJuzlDrepP9DkwYxS4dwmzjPhgOxR2Z17550ou1//beAOQwiClZrXvBBR/8PPXwwWKx/WRiJmG6TT+g4CUpnxJEcOmNLkVjg1SlDsODMCNbXJbbdeMmAGt5iizzBhTmRU1VJAHi6qoqvwGY5nUUYrPty2OjdMemBmnHutLxk87jv9fv+CQ97DZeY8cRHXM9xWm2UN3BPocWqB2s+p5xrJpDTRgQLMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNi+RMOURb1Rp8Rc6Ghi28eCqTP30Yk4bHvDM81X2FM=;
 b=4nJ4fr6mhoFMx9d8icumXzq3Xo5SJxMemTO1XSnro0eo6gFlZbimcJP69+RwHpJgD9VaA4lvY5wXT+8mmfoyp7IzTy20LZP11pCk/1r3oNMByKyKWtbhQ0H8NWpINwHEn8ZLHJrQH26xt9FQbty2grBIPqPsnTjH1WARGU4QwQ8=
Received: from MN2PR19CA0055.namprd19.prod.outlook.com (2603:10b6:208:19b::32)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 17:22:16 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::a2) by MN2PR19CA0055.outlook.office365.com
 (2603:10b6:208:19b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 17:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 17:22:15 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 15 Jan 2024 11:22:14 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v9 5/5] EINJ, Documentation: Update EINJ kernel doc
Date: Mon, 15 Jan 2024 11:20:07 -0600
Message-ID: <20240115172007.309547-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: b65add91-0597-4fab-2a5a-08dc15ee851d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PKz8SroE6wvqjpnQD96ITrUg8co2U/u6VfI1wGyg2FDRGBgERfuhgU1cnao7br8c7IeD1HKBqD7y9lGNlxDHStXHDomjo2LE5MuPPIQlLfpGtORV07qoVyjOsTBrAKNkkFAex6KVXdBqpVtqS8nrUPhZHq14f8g/RMCcaA+WTmFIWvImoMRyYOPbq7t44SAss03Az96H74CiRtQMOjkqVfNbHI9e5SEONSNhppBnjIoFSyPrmYH256R33ZFgtx9EPIjzeh22A7dwDSBlwW+bDXg86S6QP9r8X76MW/dPa4KUIXjW1z0OiDApbDHwMlKDM7ZpO8A7gsc76AhmXa5vmiodiYC2iRq6QsnyMM8Q0Z60vAHw9g1vW6IuvdsQq/mRN8deiet2j60rGde+Bm2Uz+Q9uqpy8WPJcPqiHsRaIoLSGeF5NgqtKb2ntO6mPXPLco+ck9MuEP2khIX9fj4EmuPvFqDRsZAoNPT1vAljXmixusedDhIap/bELU1iqD6bXYBN9u/plKtWYS2OSkvY54AQo+hGk99ZSWNdWn0LKBpdHH8jEAkFeOaOT4dFE854k2B/QbiUL++EKRt/TCy99xfm7oWGZYP6pfVhHcR2hsF3SQrA1cTy8RgyHvhKAbW9YDFLfYwR1RKh0ycZKOYpdLTLF5u99AW6OQL9tpD7nm11j7OB/JEXPw3Yy324hTcELDoN5cQh2eBfzdPH2H0mRsC+PwrdiPXhNAesreF4qtEb4QQkk2b9bj6zxZQYvLI+pxkuiQk+jO0gu5ZgJxrPLHDzK+XysENUrb9q1DkdFqw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(16526019)(2616005)(26005)(1076003)(19627235002)(478600001)(336012)(426003)(6666004)(7696005)(47076005)(36860700001)(83380400001)(2906002)(5660300002)(15650500001)(7416002)(4326008)(41300700001)(110136005)(54906003)(70586007)(316002)(8936002)(8676002)(70206006)(81166007)(356005)(82740400003)(86362001)(36756003)(40480700001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:22:15.8979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65add91-0597-4fab-2a5a-08dc15ee851d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..a8f26845682a 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -181,6 +181,25 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+CXL error types are supported from ACPI 6.5 onwards. These error types
+are not available in the legacy interface at /sys/kernel/debug/apei/einj,
+and are instead at /sys/kernel/debug/cxl/. There is a file under debug/cxl
+called "einj_type" that is analagous to available_error_type under debug/cxl.
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


