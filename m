Return-Path: <linux-acpi+bounces-2918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0572830D6A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 20:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769AB281F4F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673E249F0;
	Wed, 17 Jan 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aralbiP4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43894249EC;
	Wed, 17 Jan 2024 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705520736; cv=fail; b=tqn0ELnvNezDZYTytmpehJu/MZoqyp9rL/1/3dodCjFIGylErfFY8utcd0qOdwUdI2JQlOk9zRVSK2D376WD11XQCcBG/If5ljsv8UGrwwaQH5ovSxyF6crW5863C49CcYvmokk/2eKbo5VGJDLKS0DPAj5Cpf2gEfMMT/LtpFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705520736; c=relaxed/simple;
	bh=9zbJL1jK0e8ha2NrWg58pAE32faVkLyM56FnnKYwKfE=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=YLuXO17Lug85Ga6HrNy2SBpJSmSuNT9Vlg/N3W0vWBOyB2irvnjyKdjCv1YFLphRSHFKcBilEZLSbLDkYkwEG33A3LPPMSkI4mAUz3r0T8EACaBn4fdinE47P2+KVsn1Sb4sXykWAnMMlmKeRvvDjD4BgfcZM6lrhMkHAPId3HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aralbiP4; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0dLwmoNedrPui1qiXFg8AyehZ4vSzbthoi0jWR9zsWQGdQeKTAVJHn4eC3WkQcCuqD135DWr/LvOIXUNjU9GOmAHtvbfPO/spHaU22wDYeqm2flDtqJ/kdxLpouo3LtXjhqr9iB7p2BJP/xOetwHIviY87drbilCaVIMyuAjslWZY2XwsfVKfahZ1Z92lFZQELFfq/9STZZOWP4D6csAWi62fh9q+Hp4pikcEXAAPYa4GbVFgitfKu7pezhT2pTU+d+vn8VDkr2vhKTFH33AaHDuejAq3zYLTxKEkxGTmL6Uwi6z1A9kQxqHkE5qTFE9TH9J104Ugw3Nja71rTibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE1Nayuo6cmerUv2S5v/MoIHyvnDMrrJcnis/eL0ayE=;
 b=dsoPllTgWvLJyPmvg57MoE/0+I67mChrCINvOuC7yj9Yzbw9BWJp4BfaS07W9422euJNOir1ulxi+owwrv5LtwHurJYmHiVVUQ3Nh7cl9wW4Z+n0tixkv4fte/DpazHKUQpDURxdJBaJ1HOgmcLSUGwZp/koARlyVj1LWZESOZEqH9/6RFPYdzsYM582hewQdpkLcuBphJxXjNbFIHNp0Z6eHmbqRQdscLdxmweuKqOnJg7hos+t8R1bRHGv0BF+Gh2C8bUMVS+w+WW0/lRIV5KrMFObFFUDa1Hrm/9c0X7AQjh7LN4XsFQoBeSR/6jVPxSaWbeAb3lSE9aEa1xhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE1Nayuo6cmerUv2S5v/MoIHyvnDMrrJcnis/eL0ayE=;
 b=aralbiP4HM385RqU1jDCxUtLsUQCAZ1LWE8bKjjGCry/w0tvQuL2zzXHvxsxylzerKkKw0jIIHYHDRI4/W1iQBoXeR5bFHXUIK3jvC1QKBT2auRSE48DL6mp0lybleMt1tpTM6nZHFXV3rqH5KTq52jCi9jaHD0LHn/s0w97dqg=
Received: from BL1PR13CA0287.namprd13.prod.outlook.com (2603:10b6:208:2bc::22)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 19:45:32 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ca) by BL1PR13CA0287.outlook.office365.com
 (2603:10b6:208:2bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.19 via Frontend
 Transport; Wed, 17 Jan 2024 19:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 19:45:32 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 17 Jan 2024 13:45:28 -0600
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <dan.j.williams@intel.com>, <dave@stogolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<benjamin.cheatham@amd.com>
Subject: [PATCH v10 1/5] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig option
Date: Wed, 17 Jan 2024 13:44:57 -0600
Message-ID: <20240117194501.298233-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a16f29-32fc-4c81-433a-08dc1794ddc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbl8WgJy7ZM4Plm6LqmKTYgxagTQqlqxtp1EyP/uKXe1ZXXagRQusw7I7qUOPuybrei2BjNuP/aex+XD5PrlV8kkST4lEhEZYDY2ktR632s5qPvr0G8v+Gcr0X3qZ6JZeol1rhyBVElgPXXFZI4vBuHCndvyIvGrY4wstACmdjTYDes3QMmGKIYqmagChTTEDyPPhqRgE5KOzMpZsauy96ZADYd/u5OKSO5TBIanWzi+W1Ms+sDEZ8cnR4GYu1Dazx1VehCm27qsiD7jsRQipkABi691yIviQmvoveG2NOzXm+5KRyYalfWDCMc4AigkohSmr/uzKQtxjwLq5T08g2yjg6HkDrFn8emLhel9bYc1jld9gM23S3bt24A75MEGWZkFzgJ1U/Ulfwt5lnjG6pbI4Cww9iY5CSj3smd/JEI371WEA+dERY3iQK8WQZBzA+DiAT+ECQCjZ7dzUBXr0jQS2B/Vr+BnhLFx/bZEMjYhJNXLoU6Z13ErQfAwEaM3/8OuYetc0FGdUOpkNHvcvMObBlztMXGGiHUj+WqB+suxdlf2mupgbgrkfr4ABcy/WIy51ciVMgt4lloGfUnc/02BY3Nr89h3oT90c6wPZEpKMa4UmJTbuSVS2ScrL8dxWpTt/yJZ4pS0OscUlz3Y7lrGwtCkzBLptOhTOIr4tOBsV6aDwUfL+u7D86TrsC/oQ4b9oZys33+8khoR8OGKdB1ifHtXmg6v3qDE4AtLGkn735W3zO+AfnHqjZIjeSTA8k2wNL7fx9GbgklZSR4RfR9+H6rT4K+jMncNDN9FwXc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(4326008)(5660300002)(356005)(7416002)(40460700003)(81166007)(8936002)(110136005)(316002)(54906003)(70206006)(70586007)(8676002)(82740400003)(86362001)(7696005)(478600001)(2616005)(2906002)(6666004)(83380400001)(41300700001)(1076003)(426003)(26005)(36860700001)(336012)(36756003)(16526019)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:45:32.2786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a16f29-32fc-4c81-433a-08dc1794ddc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

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


