Return-Path: <linux-acpi+bounces-3305-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7784E93D
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 21:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6711C2113B
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6681638385;
	Thu,  8 Feb 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8sC2a5R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7619381C5;
	Thu,  8 Feb 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422471; cv=fail; b=o9j/26o1UXYwYBcxO7ey5CUzqPbJn4VPSK46W2aOyilWMpprAwKghJHd5lopPpmPTlyWLbhiITrQluLkFAG2CVWtGxs1HJzHdwLzukgstqPiOGZHt5cVsUm2CMZsAdtL2MJD7Q7L4CID9K8C6aVRUrxC1MFvWS1N9WhEP1pPo8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422471; c=relaxed/simple;
	bh=MzE13wBHCafikVW22sGGLZm5lxsBCq9XfSiNA+V6/tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFqbeGqS4UTqGS2v118GtYaz/Wmpfb90sXI5o581l/qNYbUHS5c38v7vhlgFThLzfNF7pQYCo8KH+mCuQZrUOL5Z8ubAu5jBDDvPzeHpQI71y8BFd1u9Txes+d3uX5ZLhplBwV1nQteCEz3I1MeoC8UEXmh7B0OypNtfBCLIcV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y8sC2a5R; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKKfKWsAwSjUy70hN/bqWc8u1chnlhVxMk4kiUd+PMN1s68YBraW180veenWv20+T8KSCtEQBZW7KshjJhnsop6zzwfpAT62gTMQomnjnvvziSap9s2CkWFhJkrzARFiCDc1fz+ty1uvBiwqbLYZAKCm16AFkvEB2nmTGPCvPHFxSIexsrqJNC0bf/fMWo5YIELO46u+h/ykzcZ7sYFog+X3J1iwE4sUpliHtgyR5GW7rTUvLN0t7ZJN26QQXYMlqzl/0kQX5MYCoy05+wwHSyvKDH7cAbunc+kVIuE8ttZTJpNVJhqibZIeFsHkxQ/V9KQr3dm3ViSnKaX3JOQocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU/kJGfNcdh8x/1kb+QE6e7tVM3onZ/EUJWuZz8SSy0=;
 b=RFle4PN/LDV1E3bKKjMWl0aXv740viAywONuL2GNkj3A1PChtkxJBB/5l7z3toN/xMcqmIVYc+9bU+w252gvp19f/tMUIVq5HeyCPnYv2z903eIDWqveighuccFosjAhfaipOGIwm8BvRWUqdNhRONEcFzbknzgHXBjMJLy67wZ6yLEWVcPZ0gMqjTId8eZYae7rB6vMuISFuLqURq5tZXrDBWewsI09eW+las3Je6CaHcpyKK3XcIjlXquL2HfFPhWN+aBh4UPecsTxr36wdwFywrtQsfRxKDqBqsbPP4PSR7OluP+l5OVx/+6QOkRbA15h1B8QElb73Dz0unbqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU/kJGfNcdh8x/1kb+QE6e7tVM3onZ/EUJWuZz8SSy0=;
 b=Y8sC2a5R8mN5MoE1og9/GSJoGriPawn46R43P1uGRceEpUBwrqVAyhrYN46tLSmVttLzX308fsauql2/caJNvdAbdTx1NEKrLORtqs7WkS+VaJqMvSu4NpUDOL1cbUEKGWTV28LPMdBFqd8JzvbgQRW6OEq8uBNZZ+0kA5JENTU=
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 20:01:04 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::6f) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 20:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:01:03 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 8 Feb 2024 14:01:02 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v11 1/4] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
Date: Thu, 8 Feb 2024 14:00:39 -0600
Message-ID: <20240208200042.432958-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: d99c921d-4798-48b8-bb81-08dc28e0ae25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eG6fShT6E8I9rtiUa07Hr0KiogKqsjwb8wOxkqUZNAgujT2rFUK+lNP664SOqUXqwZ5TG/wWvK0/0nYKLs05jBL9EgYvOm9XnTfZoPyu4muAoIpyccNtRvgUzAyRkEM0GQNumAxA3jQHytNb/s1whno33WiHP/J3DtSDu9QrK7VFmngwp8aNHHhMCnWLo9Cs8gz7kdXbXqHUCQnhyqJTX5TuDEPf9Mdd/SRFwPPTSRQFNIga1J1sa+kiNgDFlS59y84YrNiEZoR1AfX5OO4vWOxCm6fLnOYO4ePtSz8GTrvjlmdmGQBvmAT4KCFxAovQgJ9IlqhCc4IaG4W+0rkIo3OE6Y7UQ/+VurqmDiW28XG46CNwhV6c6Dvx8GhmZWmB6YJ4uFWGmc2x55CB2kA3yN0Jacw01JBB7Hei9+ndhBdfziYhXSQK8g1yrSUkWYJn7h+FE8e9qL9T1nb6ApsDLuamqYJM0hNxtZQ/KSnJijXcX77yXhR1+T/9eIU9khOKPJcczjwF+ER1Obokg4/zywptH9YE+LnfDmY5H40Cu4cnHCFD1L1zqzH+MLOfjUQuSGdhdoO8CldoxrfATJP6bzi7n/dYBMD6lhLCmDXnzcg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(26005)(336012)(16526019)(81166007)(7416002)(82740400003)(36756003)(6666004)(5660300002)(2616005)(4326008)(7696005)(70206006)(2906002)(54906003)(316002)(8936002)(70586007)(110136005)(8676002)(1076003)(41300700001)(356005)(86362001)(426003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:01:03.7699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99c921d-4798-48b8-bb81-08dc28e0ae25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

Add CONFIG_CXL_EINJ to cxl/Kconfig. This option will allow for the CXL
core module to access helpers inside the EINJ module, while also giving
users the option of disabling CXL EINJ error types at build time.

Also update CONFIG_ACPI_APEI_EINJ to set CONFIG_CXL_EINJ by default.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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


