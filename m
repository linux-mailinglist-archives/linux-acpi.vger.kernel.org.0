Return-Path: <linux-acpi+bounces-2415-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB2A812198
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 23:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E3EB21032
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A7C81831;
	Wed, 13 Dec 2023 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Goi6OXqh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98E5B7;
	Wed, 13 Dec 2023 14:38:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut2m2+jliYs+E4X1lMR+R6OGuuelyVLs4trEwXjFuto82F61+DKN6znztAUtB5y2Y3ONWnfyDTWVLXSIZWdk2bDQu2OpL8rv67FpWn9cAefvu4EQhZjM8ogt47+daI4UKo89GkeXLUIe3GBU5lQHrunrG098NPOe78LYFWEOA4rV6UGuRyYOeZmsgsRU5CyHEew7Fvl2hHEilWqqjs8giGRF9GGgdNucyfGRe4ll97hLFoI2m05/HVjmA6fneXzujgZWL/DJ7iwDy8jgOTrUVQ6Y3AGj2YMURtlr9i/wCEEqFcz7yzZQFR/HUm1KbGJuvJtG2pqlmocLWCfy/EhRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl5gqUYgur5j+LfplT5R3LCfXzBWLbZ6qrs6WIFO54s=;
 b=W6ZlfTzKcYt2bE5TrZf1FEtwJZPT9t03rbI71r1o3+1Fb+YswR2aHtNj+YKGiN/k7b5N1213f/B7/fe6kDpDMXJshK7BgaU4oZjOxLvcI62g0ALvRUZ2wzsblt5v8wlfk8Q2VfztEkBZljEnXtzhQyDQH6i3N1StyEgaDM28k+/l7JZp/hA6ujDbWk9TeUxBJatBy+CQYqWfZc5cF06AMZO5GBj0Gob9mNj8626ku6jFJWz69illfDLyjaVJAjNww0ALsh6bD1gdQNGO76ZQaMzOHdOD31fFiZaHWhDVRhAnhIvbAq6w9kbPnShHBVQkvm3eNZEMwXWHV3f5a82yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl5gqUYgur5j+LfplT5R3LCfXzBWLbZ6qrs6WIFO54s=;
 b=Goi6OXqhVEv5T6qs5SDjWo7FXYQeWymVKrvtXBbbpWVZ0TyiKEzauZZuD+vHKuhIMNYdlO0XG6ivlVZRJT/G78KKzZtu+AFDe1Yy6qZazDmPYJ8oeK3iA/4YkloG3S6pfpcWLyi04yaaRwVGRMTFWMtCsomxW8ei2AzkLon8btc=
Received: from BN9PR03CA0851.namprd03.prod.outlook.com (2603:10b6:408:13d::16)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 22:38:24 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::2e) by BN9PR03CA0851.outlook.office365.com
 (2603:10b6:408:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 22:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 22:38:24 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 16:38:23 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v8 5/5] EINJ, Documentation: Update EINJ kernel doc
Date: Wed, 13 Dec 2023 16:37:02 -0600
Message-ID: <20231213223702.543419-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
References: <20231213223702.543419-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd85590-cc1c-42c9-3850-08dbfc2c37b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ExhzuDPf9IdGYYB0IXn6g8K6zbt6LQPDvBgdKKrbDtzk8XEOWjkK1U4RED9A8q93g0z7MWfdZcyEWZH6S9syyECp2iZzYoYO5sn5dHmbuBFhOBo5qdM8YZ03r9R/iKI4bQxlJvK1VjYO7/6BsqqEnsaND3ZrP0PVierhliYcSox3PLsLBr5tzW8ICAVnwo+jOTY+C9hvjKf3j8Yo7DcWaCnzWP5lwPUys2xP/ZN2P4mJpEdo/hkB3Z1XpJ2AqwDdO6hHd4Z/OtAASF1uIoRuAgF5Ex8TGQA/hXO4hiwiwi9i1XA0qF13cRR2LMI/lhqzn5T157xLsYSHubDROs7XQbtewz+u4k5tq8m4xiDnE2nx3hVn0T9xFlYHpVwuSDuW6YzsEMDIog0k7QKSeOb4AinSPjg6fk6CFM7I/hO/0xemzQKD+XI2JCJFlJhzWTDJOKffAEDGCDOM+wI/s/rZjfqh+4koUtRh/ievyQqnGdyXoaZLxdSREixXtP8z4JuHpNtG4J3avIvK46OGi+Dk3rdWK8ixNRCQgw2NGrVLleed1f+TIKuLiPbq6yKkK5Lrn6s3DD/y9KgMJh2eCKQ+HiboTSIQ0jYAXge9EzSKIcXXM6NOwlkZ194fssFdVGI2bK86+ViG4fKEWLww1lZueDc+do2eu8SnFWY5Jr+7mMdvSnIHFBSrvVbMjZH127lDI4cxhCSRrDQiXVpSFqy4zHWlfcVTf+Mca4Y/y6wXFHsuYCVcMXWNfHgcreCSiR/5JSflT7x188tVM4JYtJpA1BaswWRib1AnNX9h884UH2o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(70586007)(70206006)(54906003)(82740400003)(81166007)(356005)(36756003)(86362001)(110136005)(36860700001)(47076005)(83380400001)(426003)(26005)(336012)(16526019)(1076003)(2616005)(19627235002)(15650500001)(2906002)(316002)(478600001)(6666004)(4326008)(5660300002)(7696005)(8936002)(8676002)(41300700001)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:38:24.5619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd85590-cc1c-42c9-3850-08dbfc2c37b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index d6b61d22f525..a9d3f6926cae 100644
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
+    # cd pci0000:0c                 # Navigate to dport to inject into
+    # echo 0x8000 > einj_inject     # Inject error
+
+To use CXL error types, ``CONFIG_CXL_EINJ`` will need to be enabled.
+
 Special notes for injection into SGX enclaves:
 
 There may be a separate BIOS setup option to enable SGX injection.
-- 
2.34.1


