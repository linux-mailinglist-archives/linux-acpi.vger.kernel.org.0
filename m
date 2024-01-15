Return-Path: <linux-acpi+bounces-2865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526682DE5D
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986611C21372
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jan 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79A617C8D;
	Mon, 15 Jan 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0XzMCFCj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAFE17C79;
	Mon, 15 Jan 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAFLZR6JYWGTbExrvR3JoGr9UEX/dHaW6KqMUlBhSV0eq/2EjZwjgObTbKuoFrs2Ul2usHOFBrlIQQDr6XBYw/0JfVIR13FFEWLZW6aZHuUhUje9nOFXIxq7D5+2Ogv6+TDre+A1MBrSi26iBVFh5BRo5TiCnHxXbgl7rVNURBGpxnHgVk6InW+qCUtgKQE1kkbX7gedVdc5hXiBcldDxNNlsZa98dcIoP4HD8cOpvPyMoK3OG9J5AP2DACeyCyJKUzDERkaSyMSlVdX9dIJAc3sPIhVE7ArpCP3b755BPRO55JeRjQQ/S1PIzvfVwsqaP0CrdD8Dd/pLP9BjZZhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE1Nayuo6cmerUv2S5v/MoIHyvnDMrrJcnis/eL0ayE=;
 b=b3U6EY+YCr2oM0J17hkHwmbgNuOyF39BW7hSAmobaKXWNIZhKz4j8G1Do7ngmuOw1EEanvT4u7OQUsFYmTtU0pMbBkrd/W+Y/PpCdVsCtYGHrQOD08kdBhUK7hx0PZRZmnUXuPb32ezsPmZ03d6OXII4J3kcsQXtlSt5u2a0pnPhuwub23FCCVsNje5VuaR27o3qkBhfR+md0qVQ0Yb95SOaxHIhLNpyLzJsaBgC0eYbcT1C2DhqjOeU5KQMhO39zq8ARRgej/qypdqc1/amDw6QOUyF51q1Alksjcd4rcoQ108YAce8846uuenm4YHxl/MLZdeGYZ0SG9s3scSOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE1Nayuo6cmerUv2S5v/MoIHyvnDMrrJcnis/eL0ayE=;
 b=0XzMCFCjbSg2SYtBQxEcUIuWBsOwTYwH51qdS2nLPVG2QriX3xChIHqC7bsNV3lEcYgAFkr0xwexoRJ8c+kc1CLaIoWG2oSG0y2h5Ya0U98zouGXvcV/oe8P6XbvMM0GM0x50YaCexnGnKJ3UM8HB4dZXiJCShMbtgotUHeqpao=
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 17:20:39 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.15 via Frontend
 Transport; Mon, 15 Jan 2024 17:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 17:20:38 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 15 Jan 2024 11:20:36 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v9 1/5] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
Date: Mon, 15 Jan 2024 11:20:03 -0600
Message-ID: <20240115172007.309547-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad1a214-eed0-4b48-d7eb-08dc15ee4b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9dLcGQpLNVJvTo1n0MKLPakcYkLa30N1crZPzN0djtFisoW+0YlSjQbQnhi3RECHoTzCcWqDI7+VzaTPrUeeG6N7RN9VQLqgUeB0y0cbbnQhyt11t3aK63mhrnukM6Q0gtzPWIjPAveF6jrIIMcHobwpJeooy3nsCZZtEn7O3px/V1klIlac1Os9xF9e/PIl8wzhNPsYpcWs2UrTXWFl/yNUZajr7LRrRzj2F53M6AkyaettB4bdTGWdpCYRNuZIK/5FZcS5/D8899ZcIKllwiT6fBJxB/TShgi9qWQwnO51pFWb9OEohK7mNYoooJ2kyJJdMSw/sPTaJCcyubQOBi/fTZoU7ThQ7ayGL+aSXBPzqQ+MLS0Zo2cy17vukiBlY0olnLmL85g0eLy1haKj+uw9SxSrWGgkF5Tfiw5RJ0M4WbcQGRGxZHK4pbv2FK1dw6h/72COSPTKowlgoTIVvDd96yl7kKhL1iUI6siGeJJpXVFLttl64tLMBF9T0QD2GsS38I1GAJvU0DY8N1QZSclH1AdtHtqXxowTLJJ0mYeVTVoLrQbzae2Yhj9rg/1JYS6zou3BEwBqqnnidVdkXS8QT7K4mjAde19e2WPMJGqKcwTnNkt8WrEnbWSmu4yaAGUsNfH9jhZImV3ERQf8bqyPmoYcBnhyxDeBpBuecqh0SF3JMAgoQe/+76J3nnscHOfNnpxMxlRrK66RMvrVHCAJG6oYeOcu/+jamuiSo+Pwmo7zu6/vj+QoGzh6tQpG3jhG93qxm1KFfGYh1Wq4mxPSfP6zsuuNTXNPrhJDoWA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(16526019)(6666004)(336012)(426003)(2616005)(26005)(7696005)(86362001)(47076005)(7416002)(5660300002)(2906002)(110136005)(41300700001)(83380400001)(8676002)(70206006)(54906003)(70586007)(8936002)(316002)(4326008)(36860700001)(478600001)(81166007)(356005)(36756003)(82740400003)(1076003)(40460700003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 17:20:38.9157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad1a214-eed0-4b48-d7eb-08dc15ee4b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178

Add CONFIG_CXL_EINJ to cxl/Kconfig. This option will allow for the CXL
core module to access helpers inside the EINJ module, while also giving
users the option of disabling CXL EINJ error types at build time.

Also update CONFIG_ACPI_APEI_EINJ to set CONFIG_CXL_EINJ by default.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67998dbd1d46..95f215a2e5dc 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -157,4 +157,16 @@ config CXL_PMU
 	  monitoring units and provide standard perf based interfaces.
 
 	  If unsure say 'm'.
+
+config CXL_EINJ
+	bool "CXL Error INJection Support"
+	default ACPI_APEI_EINJ
+	depends on ACPI_APEI_EINJ >= CXL_BUS
+	help
+	  Support for CXL protocol Error INJection through debugfs/cxl.
+	  Availability and which errors are supported is dependent on
+	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
+	  EINJ documentation for more information.
+
+	  If unsure say 'n'
 endif
-- 
2.34.1


