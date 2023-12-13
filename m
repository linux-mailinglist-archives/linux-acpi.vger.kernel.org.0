Return-Path: <linux-acpi+bounces-2413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93396812196
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 23:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23235B21015
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D650224E8;
	Wed, 13 Dec 2023 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aqFUEwTL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E1CD;
	Wed, 13 Dec 2023 14:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVIdFYvcks/CusGRxDFkUHkcWxYmhVdRxgD0YkHeEqK2UkUI7tyMNQ3uhRg9a5Vyl253dXskQmyXB7mG3AzWHuj90+fJYZaaOnMnH4MAnaqhX9k67fR7dy2GoLwnlKcKSo1ySaDrmH2EIyuLjcMzlJzTXBnCAdFmLoVDzYXjXMFUcjmokB6cbp30A1bwAcm/en8JfThkws0DSEXBLl/MCKiCt3A1WK0KJlRuhlhHb39gnVA3QUo3KIwCS8G16rxiTwDqhXCMs7Ll9qsXXepUsswM1BB5c5u94Qh/sGMWyOv/UlGFe0es5l01KeeJb+48f4paO6xzXs+aez6O0X08Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KLZr8xp+VaqrgFkQC4+WkAB6bLmosaAs7WhRiutUOM=;
 b=isVrEbwA0bc/PDngS8ce6RkdEx9ETEL9/ToDuSN3I5z+JXiVFtb5Coa8npIoogxQWIMpAhg1w3dJOnyM6A3rAjDg0dmYVK//bH3R/Y4GS5fsWJ3Y5ttOhpH6ZpKy3H+u6+8Znu3VsGSA9e/UAcmc+YD+N0/OclUU6Th7IG/7SuYQcE+j78+3ZMgYGJxohK0/dEA88MhU0BJs/PLeby3MsCcW1F02tl8byI60eHIFO4+d6Z/1dBHbAM9/CxE113JN8pAW/PRyX7xZgXVvDPoYKCHprKihLah5FqypPh5swJ9CdZKJ2RcNER67qo1vSpdH7vUDks6quLZuVgPY3W8W5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KLZr8xp+VaqrgFkQC4+WkAB6bLmosaAs7WhRiutUOM=;
 b=aqFUEwTLQFE79hwxiBUPnZy+H+mNwT6geCw3Bp/nzfLCGDn1Yb6jZvUHjjP/rFmLFGUviaffh/qcOsLDiToyRKVguJr0iLWn0OTb5HBzJ0IIu/cq0Dw61d/DCkzmM62+yBmkyq9ufMYly49FNVvhgQuGIlQ09M41tmCQRrPFSJY=
Received: from PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::15)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 22:38:00 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::c1) by PH0P220CA0006.outlook.office365.com
 (2603:10b6:510:d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 22:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 22:37:59 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 16:37:56 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v8 3/5] ACPI: Add CXL protocol error defines
Date: Wed, 13 Dec 2023 16:37:00 -0600
Message-ID: <20231213223702.543419-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: a85b365f-110d-4045-c39d-08dbfc2c28eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xXhqmcAocQCd+vGag/kpp5Cq2uvkcSZVrHh2TiLlc/0QPBW5QVac1B87fCuXxnzR0d4gCSbtgsxgyjvyOH25FwaBy/368LbLwyvjZ3mQA3cZb3ObKNx7vXmvk0d0CWOu4Gdn+tk7HDiDCYjNDQMjRJXF3QLz1mM1ec/rXVDFjAabcVF2hes7z9Rol+xugtgY2I+yN6hcqPBeM5vEnswOXOZEt+CNvYZ5qPolMd08LFWo4XtZI5gSxicN7rVGs5ncCWRPuebTvG7M2B+0YGVOSmVJyHZuy8gogl4bbM+QFsUdmaeBVmuk9zsw7dA9/HZLh719BnkPeweJuYsqP7Ap3y8fXtP9zzniqjc2nuApG8l6Yq2IizYXZKR5rGA2kflnFoWoM8d1wSxosmqPIQbqIYTfuRCtY5w79EEOCDl+nsC0sVwRbxsSwGVhAQf7swfgsp/EUgaW1UntJkgmsk/Mgeazuc6hRfh4Lzgl5uegv86Cm9LJ8q4ir50cXLF3eTKAuBwDzs1EGzygGwampLSMRS+xVh3ieAYevDn6VS6VrfJjs7BPz9PllpgP7aYQFYCzcBCwLK/ViYWriGlySLGCm7T1hpiDOL7cWyAixHZSmNSyRetjEanxMSEYE6346sjq0E6nt4lWuvbwgidZXiwPp8ylnyJtx3dmxF6n8P58nRPvP63JULNbdHDPrEct50RAKM7/inF3OYy2ujkfD6BFmKs5tjmo+7e7eJVB/XpSCL8DURgFWcSwUiDNL05rsc4MwEzaekxnqPgRns/6QZjTES59Nbk54yA0DLKXLUxhY/A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(2616005)(83380400001)(47076005)(41300700001)(26005)(336012)(426003)(16526019)(356005)(81166007)(36860700001)(8936002)(316002)(54906003)(8676002)(7416002)(2906002)(1076003)(4326008)(5660300002)(478600001)(70586007)(7696005)(6666004)(110136005)(966005)(70206006)(82740400003)(86362001)(36756003)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 22:37:59.7732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a85b365f-110d-4045-c39d-08dbfc2c28eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439

Add CXL protocol error defines to include/actbl1.h.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---

I made a pull request for this support in the ACPICA project which has
been accepted (link below), so this patch is temporary and I expect it
to be dropped once the kernel updates from ACPICA.

[1]:
Link: https://github.com/acpica/acpica/pull/884
---
 include/acpi/actbl1.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index a33375e055ad..1f58c5d86869 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1096,6 +1096,12 @@ enum acpi_einj_command_status {
 #define ACPI_EINJ_PLATFORM_CORRECTABLE      (1<<9)
 #define ACPI_EINJ_PLATFORM_UNCORRECTABLE    (1<<10)
 #define ACPI_EINJ_PLATFORM_FATAL            (1<<11)
+#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     (1<<12)
+#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   (1<<13)
+#define ACPI_EINJ_CXL_CACHE_FATAL           (1<<14)
+#define ACPI_EINJ_CXL_MEM_CORRECTABLE       (1<<15)
+#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     (1<<16)
+#define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
 #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
 
 /*******************************************************************************
-- 
2.34.1


