Return-Path: <linux-acpi+bounces-1874-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825C7FBF75
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 17:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D34028267D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66DB59149
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Nov 2023 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="La+tLA2H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33F2127;
	Tue, 28 Nov 2023 08:08:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdBrRKwOlnB3QboGJwCel8hjV4ocbbSsu+PE/0mBgF4dFFE5/ElKYi/08sr1WurdNnkHGx43ePwDl5pEl4z/0xeOrv3RMZ/aEu0nFCVHhHerB5rkOfr1BMZgAzyL9FmbLiGx7h/T5sqvnttXcLqAO1/Xph+uVj81vZh58AkVzm3faviCbeFNr1qMSuMPOU68rVNVoIkY4qBymb7n/sVDIjL9zOs7S6QSmLgn4ezhp6TrrtqhnBcLAe7xsdI1JQ+YZTwvAIOW0WBXJda6Ut3Fy1hGq6O6IvFPi9t9+VKeoFoLZmnfCsVgR9wfpMjhncffi6WLax2c8rdPFJ1367cujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+maicyosk4giRcMRKR/SpjdeKPypkM5HpxIzjVaYC4=;
 b=aP6VLp8prNfMChQYvSX4r2mxv75kTHbD3DNOTLRcjYEKaMoOQBOXPcfUiwx+8ZIsus7ecCbGZdSJz8Gpn0KeAuPGLcY3YjfdtAh2b9SnRzCx6fiU4ZajFJXDLuHQI2RvfdnXbeE8V1Awn7GOcU0TFgZbCVxsYyEj5Gc44utki2PQWluzAPztJMqxQ16pnaAf3ObkeSuTe1bSgXq8JlTUUO7luViMHnjX9YIlzPtESH6tFPQ9YcSIaLUpMUx5ZAzBEPc4lTu1CuZr54j8S0iwP9NEbhyYtrxaGFA9icVf3KydGf4OHErYa9KzYC+xsxXnbPZihC9rwSavtRS5Yc/Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+maicyosk4giRcMRKR/SpjdeKPypkM5HpxIzjVaYC4=;
 b=La+tLA2HFnsf17lGi4V2hREEPS+E8L8z71E/5DnLUwovxo5jYcrkWcnE6iSWaKUOLEe+WOTaOJ3BE0glH+xLG1Jd0dosOPA3qDNAdMT/okquQFuhTpD7EQ8FL77duxEogi/HhXQ183IVtbNn1W/v28Kjn/xsfiKHbE/fVdPIRfY=
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 16:08:40 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:610:e6:cafe::ea) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 16:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 16:08:39 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 10:08:36 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <rafael@kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v7 5/5] EINJ: Update EINJ documentation
Date: Tue, 28 Nov 2023 10:06:56 -0600
Message-ID: <20231128160656.166609-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f7ca55-d69d-4f25-1b02-08dbf02c4922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wl1RDF3wO1CxnNQUAn5W+Al+FKOSLjmaRVbTB+QX6znnwGId1vUUiwa2khsQgPxB66dZBGziHSlB/XZ2eisIhBlu6ha5MwFSHbdUW5HHibqaQjB+yjlUHO1EkGRyWssMtICCg6Enq13jmIzABJkXGKbKVZ0hFF6cG3yutXWcnZJs0yokyr8mBsfsyLEivho6a9/cjJ2AQ2yIpnfKLTrsqaz9QHurbOnt3J1LMEdwPsw7zr62AW1sDzZO1v03RwExSd0XowsXwPg0wUuuTH4UlukN3c44SjuEPCnYTOGJAtA/sLkzvLNqnw7rSjIG5Gn1a7YD6m0y8PVZvVqtdLN5LAXP3zuu32qmikbRFrcMUIkjsul0qCSWkqkfztscp+MU+Z3lHIaE8q1pV0dpPkP+fcWGCAPIqaLvctvUrdYoMAbZbgRRliDVOYTlwqXN3B5wEB4vXQLFpVDt7+FTFYdavir7oEi9cquIXzOLocwqZXMqX318A5p611k3lys8fzDYjOZTprfzo9CTiC+rHhaK76x2E7trv58kSnckWLFkOdjJmWIDwlk7s7UUT2FiI2HURRDCbDMNFJBxeykJkVb2k55McWfLeFR3iohVbEY6GVnbXEa1E6cR5HjRBEyQ9VyB/chM8fNBKkbO/Q8hra8GszMw5QVI6G37u+6yJprm3CQRWoliNVm20bG4/yE0RVr9wqyJtRpXXEjbp/o22mdbrkenlDPqVA55ay/ZOP8/s1RbWxWGDSRR7ZbRal6vvJDFhDSPX5ryiY9UGfezI3QLeQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(15650500001)(2906002)(7416002)(70206006)(70586007)(478600001)(54906003)(316002)(110136005)(8676002)(41300700001)(8936002)(7696005)(6666004)(5660300002)(4326008)(19627235002)(2616005)(426003)(16526019)(1076003)(336012)(26005)(83380400001)(47076005)(40480700001)(36860700001)(86362001)(40460700003)(356005)(81166007)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:08:39.8475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f7ca55-d69d-4f25-1b02-08dbf02c4922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

Update EINJ documentation with build requirements for CXL error types
and how to inject CXL error types.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/firmware-guide/acpi/apei/einj.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..83afe3bac793 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -181,6 +181,18 @@ You should see something like this in dmesg::
   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
+CXL error types are supported from ACPI 6.5 onwards. These error types
+are not available in the legacy interface at /sys/kernel/debug/apei/einj,
+but are instead at /sys/kernel/debug/cxl/portX/dportY. Inside the dportY
+directory are two files, einj_types and einj_inject. These files work the
+same as the available_error_type and error_inject files (read the error
+types from einj_types and write the type to inject to einj_inject).
+
+To use these error types one of (or both) ``CONFIG_CXL_ACPI`` or
+``CONFIG_CXL_PORT`` must be reachable by the EINJ module; if
+``CONFIG_ACPI_APEI_EINJ`` == y/m, then at least one of ``CONFIG_CXL_ACPI``
+or ``CONFIG_CXL_PORT`` must also be set to y/m.
+
 Special notes for injection into SGX enclaves:
 
 There may be a separate BIOS setup option to enable SGX injection.
-- 
2.34.1


