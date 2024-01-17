Return-Path: <linux-acpi+bounces-2922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA1830D6E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 20:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7412B21B7A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72096249F3;
	Wed, 17 Jan 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c3U1bbd9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712B249E6;
	Wed, 17 Jan 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520804; cv=fail; b=qwpj3/6T9xjoCCm6ueq6kt6EARMgL6CF6ML+9iMeK31g9G/lIaowRJi2u+heVln9yWEoo1FWDbFwjcnb/3dhlhquVfd8v/91mByJUK76p423nnwfzwGDS6ydVB8LWZK3e7HEKf1yJYmPjd/KQ3XFDUz1pIhXAhQEdNRMXtkwHSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520804; c=relaxed/simple;
	bh=oqrcFpSmloJ0ujgX1EfpmmUshQE5fbVFGi4XHyWBNuI=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=clktE8ttxFy/ta1x9wE0C/xpM3gd96bliBwH6M3FTnKaZDppLy3Yc0bZLEecapXwH9GPl+9kdVH9rpfizPdrWoksnBA+F6YRZ0L8BLEmxXp6e0019RJjc2hN5FGcOT09w+t3pJtpWdUw3Ot1g9kHumfiOiBMktKAcSMdvzA36Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c3U1bbd9; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5iBgdgIWfjRZd2VeYiM01lhovrIBLc1ntQVxUVkMsrwQUC8i8VILIYzKAYfx8bwwq/cWyChE91xatFJamYsfw7QhsQUccuP1gwUIzbRlOVoKxM6HuHnlgwiSyut9Nm3rbQj7Nm4E6Sk5Ncia2XsaACB/0oILrocFI5kBIF5NlSvz2kTZaiDwz5BpFpdJLnRC5fljs5M1q2bT3DWT8d7OmAyhX+nwGMNNOHB9kiIYnc1wUqJQbS+/hlItWHXLrOd4Sg05k79GBFWNIKjypBH47P774CmsyIY4SriVUhCmipaf3FFzpMXd0pn08sg40skRPvu9Yg15u4076XHwO51Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqhhHGaj3Y7oKTCj5iaf6t7b1djS4Bc+6uGSrdpCjCI=;
 b=GpDKeDvu6oJHDB5+YeUjDhksYLqbwMe9tsNWvtvptptg3jsgkqkFLmkt7UE8eU6iU8F9amEEYywobUOMuwZX6OmoYrKgsYkjF4RXqoJotF+yN81PrM6GUbSpHQWNt5s4oqZUrqty1lHaN+is7Ge0hTVupN3KsUNN1x7Rzw9+6W/KnQ68apZez7a9wB+EtkouIWT6EaG4viL2ugtYtyScB6K87w+pJtddyB03lB7YyeJOxoXHxV77Ey+76OE6AKgb0WzFlZMYoPs/VBHtUeb3qNgBJbHADMdYZ0cnc+WKdKm+l/6rf378ni//Zmv6TYEB3H/5HkUNr9C0lVlGR9OOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqhhHGaj3Y7oKTCj5iaf6t7b1djS4Bc+6uGSrdpCjCI=;
 b=c3U1bbd9fcwlkUv9xYM2oK4KQLZk0l44hOgF6i1nEbhU5tpuHTVxf2HEVpoCGv/u4h3CXYL1wCfOCL6JGIzCm1w6EjI1C222RQIM55ChLZIz2MIahiv+XermIwSyX8o8FYdolA25FPD5osNeerRnqDXOmaRSvuMRgJnnw1aCyLI=
Received: from BL1PR13CA0435.namprd13.prod.outlook.com (2603:10b6:208:2c3::20)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 19:46:41 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::a1) by BL1PR13CA0435.outlook.office365.com
 (2603:10b6:208:2c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 19:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 19:46:40 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 13:46:38 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v10 5/5] EINJ, Documentation: Update EINJ kernel doc
Date: Wed, 17 Jan 2024 13:45:01 -0600
Message-ID: <20240117194501.298233-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
References: <20240117194501.298233-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 94eb1b87-8eeb-4f33-f4b3-08dc179506aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S17VzGY3ouGpn4c1UZwHWMcHCig6P7yw80H+kli/ehLWUrEMwUlf8AVmVC0GKDjPXqHyZLjSQ96CP6IEsIYIvU3fUzm6ViwxNOerTpERe5DFAiQxUYLbG412nAwx3si+eO0Nae0hiuAOOGYaQvumGRmlEtg0hWxiSfaySU/3BSlhN8TxjqObrYrJ9uvyFdYTEYlwBlFbHQAgT1azlf5deqffY40VwkdaM96x+tHwkzz/A+7YGQoFJ3c2qDq2xiQgHjN+lPUXVdfs9s51heuKWjrHl1jtiIlTMWuPLVSyv5uUd6ZeYO2i4ClWWqJMg2Ypf+qQj+v0kWSlEwb7zUGXLTbgebm04evGb8nQveR3oLtONruApMaJMKaz8lihLnhXnwjbctKgCu1/lQ6FKiuv36QGXfdwbtEiB23c7wQyUge4pLl8GcQbG0EJe+o/oGaXTfGC+b8tG/4Oi9dDlslQiyuk2lW0q5rMep+j8oZ/kbF5JU+4hBlGW6lc9JO5I5+y7ZFp2u0Ho/83VXhKCK7Z4/MFM42MxYZbmpsVBgC6K6BgJAS8oEjICtBpRNMNrf7D+NalRldlIKGZ+BKE25uWr29f3SduB5SXATmceMk5WVBwDSs1KuYs3+xwgsm+bAN2wBN6MuMfXYD3wyCyx8Yzb4OKnlZ6dAivPmToVfHuTu+/7+0d8fMYkvDDr3baPfrh1Lu4hx8oWQe0WO5aFJyX5M9GOnfnVi+gfqOHRYIP5QcEW7pXwxsAslLwW2Q6XDVZcq4XI9ALt8oVBGuODOU50TQ5xpwjqtZ++t5CXT+xDJA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(26005)(16526019)(1076003)(6666004)(7696005)(336012)(426003)(36860700001)(83380400001)(15650500001)(5660300002)(7416002)(8936002)(8676002)(4326008)(41300700001)(47076005)(2906002)(19627235002)(478600001)(70586007)(54906003)(110136005)(70206006)(316002)(36756003)(86362001)(356005)(82740400003)(81166007)(2616005)(40460700003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:46:40.8732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eb1b87-8eeb-4f33-f4b3-08dc179506aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

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


