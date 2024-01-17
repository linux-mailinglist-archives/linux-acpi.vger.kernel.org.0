Return-Path: <linux-acpi+bounces-2919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C641E830D6B
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 20:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B7DB21801
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 19:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C4249EE;
	Wed, 17 Jan 2024 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/SKotK9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33124219;
	Wed, 17 Jan 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520754; cv=fail; b=oMipmYkPNwCVzEtPW5Q5AyhBMQ1Tv59hilCasxAMWBU36eCTvUy+xx9ZUpWbxdcFpRlCJqz64MUPw4+aK+jVY4PxhBKkA37d5Xjuqo34rtvvGw1HvgCu6nD0xRjHCc2cVgszRUpIcxevj3C0mQSJrr708mayK3bX1aMbybU7BSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520754; c=relaxed/simple;
	bh=soZy5crzWsuERBdLHCgPVMSaOmu+Ubr1ojVwt3f4jIY=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=WJZ007h8VNhQP3PwGkmrEwrE9DYRvwtyJb5fFoc454xJk1GlCQJ2CfajqECLihGLElkCglq3BAqNFcVtxM9g/jEwh71NUsdHX9wpcqWa4nxgdLZBTB6t91QZD5NggVF0/tcPdat3wn/HLVqXWFRO9bHsAG2wRy/3RbvnEXK5mnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/SKotK9; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8BptS/iFnbhDrpwtVFTib1ShwbM3+IlYIJMiOBCVNi2P3zGp8h9aZB/x77uqffdPQZJF40d2HfbMJS6u1ecR3K6yV1h42XrGkbQG2biyIiC1+FoUH211ChLnqJg7n5YAcRD77zSTCbjjxstI3hSfQLZFci9J8Ghix6QjnpaePsmqbBeBe9O12QZRR+4uxIeVSYggevbD5ccVJ4V5Wu5vBiWlu5blaIvKB7eRxhtPpGspyoTUjerHdH5ZIPm25fDeCPIctR7U5bBtB81Cl/f/jLBmQHUb5DWT+a32KU0BMxHq+POZEM/HeN4Wghk1JPUeuxeEyRlHfXrfOZ649b59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kzjgVKOBXPLOd9x0CGGBOaqaprj3QY2UgevqnYifa4=;
 b=Cv+HTXjA96bXFLHngD4Bx4b01/eNXD7BQTX31kdAMD2HQwiD/qrooHIGatLlWcgnvPYo/gj468wA7fcmuuiCtJzwjsUT3zHYAVBPjGdxJVffPII9kjQgXt8KoPd9fDJGJLqjWYYgIshjoPDdzOh4/b/6jgWXvhMMGRCOc7eiZFKI/2EjtrTj0VQBvIWcv8SqlAulyYXIP7YU1SORp5ldmpL+lQr7Yd9JU0t9p/uGH9+ZQo0Bvx/BamPSqhdCoxOcQiuAfHqs5XXGQCAOpFOoSGAfQPg4K1KNREA6pF7mSAeSAQFV52Gn3AhkO1lLp0dH9IY5VALf0NGXImKjYy6ADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kzjgVKOBXPLOd9x0CGGBOaqaprj3QY2UgevqnYifa4=;
 b=b/SKotK9zISxn+P3lE4DqU53LOruBbYXE42R7yRjn9V0I1IiU+fQ9PdQyQ9YYcAWHDbNI24JN0mWCBP5yV6XeuP6fO9s+OOIHDLeBlirsB78DCn5e/cEAjjwsNufqKVlrCAD/MMojlfHeMYXr0YQsmHIPkyv0TtHh2VLcsBpZds=
Received: from BL1P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::33)
 by DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 19:45:50 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::e1) by BL1P221CA0007.outlook.office365.com
 (2603:10b6:208:2c5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 19:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 19:45:50 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 13:45:45 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v10 2/5] ACPI: Add CXL protocol error defines
Date: Wed, 17 Jan 2024 13:44:58 -0600
Message-ID: <20240117194501.298233-3-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d04676-5c88-4410-fa58-08dc1794e885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xEbqVMEvTf5sntuqn5gSTe0Pd97IOP6yVhKmTZ2kq27hil+UxUR03gjSAX98gycqnUS2rAL/jtBPvp/4ilfUKfz5iOztK9hFy10OMPKml0Ygdlml6d9/6asR2onZYQS/UCAZmSa5fWojBFiLptnHMP/hYa9BkZV8FQauYUshYWfJxEAMeS62I/r4wRKeJC4px0q4QjfvXPdq2PeSxM1IM3nvzeQC89uLvT3km+3moYWDnLw0zb/bLqMDtnjCQfhhippzjUz9L+F/sJars50RB/a1oIR/oJYUzxiXOJdbbzd6kbnA4P+/wwnEuV98aywFT0RsM8XXhQ0+Ntq6ScCJc9Tgdf24FM386kN8L6RWnpX8r50qKwGCq6vDO1whQFwvcHYshIzxvpE4e1KR0GXMOMYN2X53ZXtE0Nu9bGA8NhMyi8v/n6KoaCJiwonhhU+TnVT7uay1wEpN6qJDc1yNSJL+GNdvnIFBweXyui5ASUy/TffSUrNJdUGn/cUwMUBzFdgEe/NFUDDcs1Y2ulZgC6m63rvAgxzBIfkkd6N6if3DojigFyS3Ci6ou0uWO14Bgp5oJsQlUGA+E7cblM5YpNJl6Du68JXVQ0+Uxk/ONxmMR6txktPfxdNc6E0OK5tpsqvWd/DJsycbcyCbtvy2El81Oy/Vlm9FsgQ6bfgba4lEZLN5TfbiUin4rgPaBbY/kybTo99n0Fm/lMa0Err8CCRFyAXSEO4uTF9LiWvgmQv46fvr51wUlK3ENqDRt55XwU2AxtNyvtLTNXDouS6LGK1mvoOdc1GdrueYBb/khwA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(40460700003)(40480700001)(478600001)(426003)(16526019)(6666004)(82740400003)(83380400001)(336012)(7696005)(26005)(1076003)(356005)(36756003)(5660300002)(81166007)(2906002)(41300700001)(4326008)(7416002)(966005)(47076005)(36860700001)(8676002)(70206006)(86362001)(110136005)(70586007)(54906003)(316002)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:45:50.2992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d04676-5c88-4410-fa58-08dc1794e885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

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


