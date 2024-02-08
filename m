Return-Path: <linux-acpi+bounces-3308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66F384E941
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 21:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D97E281F67
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2A38389;
	Thu,  8 Feb 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nv4/UJCD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640138F9D;
	Thu,  8 Feb 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422514; cv=fail; b=p37rOEVfNTuqdlJ9y4mcfT4wrD4rdWMb5RoNvZWWEigPtkUNm9vcw89fxzJ6qBAdPHboI4SRpHNBvtx+AGNj9FirJ9vsJeIqcw5TklxaNYYDW7QYcDR+V1Ck9ZxC0pCLV2QiAo01+1TAH+iSG4TZZw9o1QququzDOIO2UnL61mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422514; c=relaxed/simple;
	bh=XLnYU8UrZhpHulYofq559kIxqoHkQNSLgW2cUZDxLUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtepeK74ovQCxX77wKXPPtFQrQrNTk/CIMYBtdBSP2a2FBLrQLTaTLqbJj6rNqvPr7Sl8EGBmfkk9l15UHfVfVeprTif++zHn1BKYWXHm28bcCma35RzXLreIaKM92fPjP4j9csAFBxZqmd3SnG8KOffWX11bD263GFswaJubtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nv4/UJCD; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/VDMfzNMp6ke4B5foMDVAYLc10HIoR60pg59D6KzvKq4sFsLoz37DsMt4cr7maMti8cQ3XHtpfhoCxmStoofv6ww6OVDrMgTasZeHNAQhgVkUnzZCUSK0g+9C/9pORu8oD00j8HmtYmHPnmQKN+CpVk3yUEJc6OPlIYQJNjpOKwlm4BbnRZfFoD7WGdOhAhg37PGlrD6nz2Wi73b61kxuNR9TDo5AqHox29M8EOh7I5Ete1JyUVqV8V2osyr8sUjCh5aIEJRfu5J284QxW6pecoZ8yuoJzmRZU0le/vXK0eV0Ub9+AYkPIMMQRow6AbqfAB4k8ZsKxgKrJLYtn+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtdrTip3zbGgGOjU6FyLvef5VVUAAFBkwzvO037G+rw=;
 b=DQ1XDiH0GGqepz3z6OQxipt8MeDa/DoP1sNTTj2j8wdAZROimet6d+VJ6OSkCsGyqXQYh9vqvJPSWXvdfeeFrJQ6+5/0uoTs7eLWO78vlVAbqSQHqIuZm/YTJgRPXOZuDem0Gb2hJXG5vDjR7fMGwol9sje8DzLaObLQAz7WMm1xgjW+Uapz0gNkKQcZ7+UHVeGsO4Y441jsd9T9uJsDGpLy5DJmQZAzNitE/FQkrbX0qP/sZ5gbd7lmdc5vEjnijLX0XmyYmNo5cQ8YkUtxA8w9VNgE12MxoatbwG/1GUtWFalA6DafxD0Z0AJt8CRLtZwi85m4eVVS1O3bM3oIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtdrTip3zbGgGOjU6FyLvef5VVUAAFBkwzvO037G+rw=;
 b=Nv4/UJCDWQzGw2T0XKgzv7sl8hlRB6OCozXW6TZmAr4b24e5iLny9TaIi2AoREB4tWDsU1P+g/4i7DbsRNS3tkZkqBH50ID90Y51mC/VT57HEX08CQNH7MW+JcaR/AubiuJpX++PsUiKGpZU1sgrWCVZWEhzVALfZE0gSWD7w10=
Received: from DS7PR03CA0028.namprd03.prod.outlook.com (2603:10b6:5:3b8::33)
 by SJ0PR12MB6829.namprd12.prod.outlook.com (2603:10b6:a03:47b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 20:01:46 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a4) by DS7PR03CA0028.outlook.office365.com
 (2603:10b6:5:3b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 20:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:01:46 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 8 Feb 2024 14:01:45 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v11 4/4] EINJ, Documentation: Update EINJ kernel doc
Date: Thu, 8 Feb 2024 14:00:42 -0600
Message-ID: <20240208200042.432958-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ0PR12MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d6bcdd-e91d-4a54-c979-08dc28e0c76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SIBNxVV79/DcAkh8p8DTTtjwzZc1oSmclAIRmE0CSR7dICWJild78U4+M2+PcUdKtA9Rt9I4LzMoee+1ijkxzHqwSdyxYULgvEjbhgmXw4v3sBtEn5NjPV+ruovawHJnRMduNvHDDzJubeXz71hoZhqbcU7SNVkneYh6kbcBSFYj+/m7SyafMHQhImFWKS4A11/rdkd4XBVz9J1fFdRYXP0n7eDy3hkF4vvJoBCtPBvFeYZ5KdYPJLg0h7n66GKBkfkgsj1tRJ415YQYNffpxO9hqHw5b01XvuDekaHV5yKKCsS1zGXM+tPzJL+BnmOdbgsqWo4/aN7f0wqDxJiHyIU278G16EXKQdXpXVc00TXrxA83eQpMjOIo32jOBLUDMMf0OJmBGqMuWrbLXt1oEAPaUfSUgL1kIEuz4ccBsWDLfSZvu7HP0mnP6pM7vOd3f+Jyn5UsSaJ6tvN6nn1owBjkC/YoaaeCl11IxX0ZLS6eBpfU3Z7bZ3J2U5LbebCWjZeymlOtDqNqALu4seS/ag89mEOXb07RtOkxgK2cUJYkMrjT7ZPz0Q0F0o+QspzKXVxCLdBHEY5hQFAHYqOIhvo/ylZXBMRkECRevlregsM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(15650500001)(7696005)(2616005)(336012)(70206006)(1076003)(4326008)(5660300002)(8936002)(8676002)(6666004)(7416002)(2906002)(478600001)(81166007)(82740400003)(316002)(54906003)(110136005)(19627235002)(86362001)(83380400001)(356005)(426003)(70586007)(26005)(36756003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:01:46.2189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d6bcdd-e91d-4a54-c979-08dc28e0c76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6829

Update EINJ kernel document to include how to inject CXL protocol error
types, build the kernel to include CXL error types, and give an example
injection.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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


