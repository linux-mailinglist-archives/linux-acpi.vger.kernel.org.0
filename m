Return-Path: <linux-acpi+bounces-2866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B382DE5E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 18:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB41B1C21D52
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D317C95;
	Mon, 15 Jan 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PwMMT0l/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0817C7B;
	Mon, 15 Jan 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONMb4Ysek26MFxgXkr+2vpHO/yvna/m6+byHZhB7ULBboGnMeE4iT0OhdExXY+99AMeIFI9dJlHB6E7cfTz3M9RpkjAhx71F8psvkliFmw3jJz5S2ROmBfgmwoY6SlV0a3uEo0tjcKF5uC5Z1q4UVCAhnau+fEAC23Yx4kNIaErMSh4akE6FbFlDRJicYoDiW5K3f24aDof5fM0olURKTCV41NQzLjVlPfOG4f8sVXz+2HSzF9Nv9NAoqG6eONhRm85qOpwiUE8gWBotu8fSrmMN0kznSphvCF+0mWMxbfWlZK9ZaAZIyNQ5vU5XbsMNbmfD479KwyjgXUmtwFPt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kzjgVKOBXPLOd9x0CGGBOaqaprj3QY2UgevqnYifa4=;
 b=mAdv6HlYEcmPqOwkZEAj2d8k+kwY6waZkNtzXESP/BDXCOzcbFu6dibHTqJFgIbehkfOgprO2Mdm/S2u2Zjb61HEjgh91IJCrSaNcLwOtsVrkOkir2jbylnBoNN0yenotvb0w/bPm9HgiMR+FFahvpG/suNJMp315Lwxp00n/4nnmx4OxTgGqxEmGfxbXur+btkrnEIJ4PRvWvzPohtiQikHC8EqXYM5HbHC6fjXzpI8eI+cSCmZyFf++1eYY+q7Zd0OMzQIXEVQ9fc4am219juWxJmtm+j/e4PqHUxlIqKz41C4qZk5PE1Cs34jMF943gGacyVetH8F1gGM5OmKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kzjgVKOBXPLOd9x0CGGBOaqaprj3QY2UgevqnYifa4=;
 b=PwMMT0l/FTPO1K8a1zEJNxRotwt+0+zq/e9uJIhfCrrPmzyPvX/qrU3guvoHKMVr3H+miQZ/VWlDOhaiCwRoIp0YeOIfPI4E10vk2aMczvdNnDa+G2I/SwZEjQjxmj/lqmE+89fzX6E3ve3GoT6QhgchvzoHhLHbwUTf6o6RTfM=
Received: from MN2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:208:120::41)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 17:20:53 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::13) by MN2PR10CA0028.outlook.office365.com
 (2603:10b6:208:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Mon, 15 Jan 2024 17:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 17:20:53 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 15 Jan 2024 11:20:50 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v9 2/5] ACPI: Add CXL protocol error defines
Date: Mon, 15 Jan 2024 11:20:04 -0600
Message-ID: <20240115172007.309547-3-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be4db05-4256-48ae-93e5-08dc15ee53fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LcpIfmn26mbXiFOqHMph7EZvyqabvZUi+inl0LWJjL6HaDlnAHnnjDyz+Ya5dpbMidpeR98LCusuIUofC1xQctDILZPnWvVo7+a8D706T2SLPdyAMumtKbEuOycSArxJYY5ldinKTNajxbJA8L8N84eRvsxlg40pe15gEw5t2YtJ/WtwLG2mFcknVmlUncvEEhmF6G7CBCAwaXmnsm6OJfK6k23wX1Xs/JJavheYOfzbK1sP2jCFv4RCFgW+Z7uQcW86seQ5z+t4/v2n3xfRhNUP/CqeStOYfDiPFMfiE2ReQvV2mjs1V/nk8d4EdSuCHBSyB2oGGRQFxobwBB8HETtx1HPaqxLFBx6cVN8p+k0XF27SEdl3gy0kz/QGB9UrgZtraoszmwZ1XgEGeHpnFUE48MzrnpVnl9mzQQsj8EVvpmI2bp1erSgk1CJolYuSiHtad9T2Maqy3LxbUwMLszH6b6nmeWkQ7INaqI+I63Ob1avImDfglDvO8lFOxO/bJIVg6THv8iR8Q4IZfsreS1T8ehpFD3/4QFW182MLvYjYHpYTCWmYexCPD5/ld47qFplvI1PktWwI/8An4HRtjVmsA5h2RtNhXv4G/qemJU+sX0/8EDg8Pmhbc2DX6Q+2+OkE7ahbrRy+kq1dcNDn05XDJUaHTyd0f8l96koYi/vdz+yLE4Moqoqi2UaS7LXmDIo5W9FprHXo+Mu7Bi78eSp2sxjwCJSIKmINUCQ111/HxbaHja4Lbt0XFc6GgnkkeI6X2Yh+bgWx0H8JO4lY8nWr0PZDVKtPJJphcOeOYTQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(426003)(26005)(2616005)(336012)(16526019)(83380400001)(1076003)(41300700001)(7416002)(47076005)(40480700001)(40460700003)(36756003)(86362001)(5660300002)(82740400003)(36860700001)(478600001)(2906002)(316002)(966005)(54906003)(110136005)(8936002)(8676002)(4326008)(70206006)(70586007)(356005)(6666004)(81166007)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:20:53.4916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be4db05-4256-48ae-93e5-08dc15ee53fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

Add CXL protocol error defines to include/actbl1.h.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---

I made a pull request for this support in the ACPICA project which has
been accepted (link below), so this patch is temporary and I expect it
to be dropped once the kernel updates from ACPICA.

[1]:
Link: https://github.com/acpica/acpica/pull/884

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
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


