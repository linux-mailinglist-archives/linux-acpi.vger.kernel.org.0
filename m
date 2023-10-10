Return-Path: <linux-acpi+bounces-575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE37C4166
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 22:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EBD28149F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D36E225B1
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Oct 2023 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TwM9m69Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54A329CEB;
	Tue, 10 Oct 2023 20:04:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A47D12E;
	Tue, 10 Oct 2023 13:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJBe18LS66bHYBs+60TbEBG/opK1LUIxsLXBTgyBPPmHgt6xWll9ioL4/r/DXUMoDj0jA3QnJ/E9VGFt6Em8s+y+8ASncC7nzpEgxJmeVVP6UjqgCeLlmRX8Il6IqV28/A1384BqCB8YskZvRIhatPPhnA1VL+lueCbWc8ZDiR75Cnfb/Lno1eibwaZQ97GFfh2na0DXehHn5f/ANeXp2y4xSwSZLAdzQqwPzeMhOkF9YAgGQ03/19zpF7Tosni4Z3ROuQlqwi6+G7EH7YPrpwOXOiH/H5a/+vIzPkLoFQHtkaKF+gKYw5TyNmQCskNZUzIy5qeCu8tDG1iwtzzrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWirr0iuG6mAxg2Xd3VxPkxEOsVowqCmylTmVWaSNvs=;
 b=eS3h3bhjt2JkyNHSRMmqvYPcR/wvPf1xJJhfebt6ILfXcNKN9MS9nyFl6tIzGTj9RfOXvEnAUavEW0hbiVdMHAi995/l9Vg0AA8FnCGbBCBu6bAL605tDDQX48iTs56l2uGmRiXmwC215Vnn/n13GhZa7MeLxlmUSKn9TZvVIh/hSPqSfhUKKVIxhSr1jjYYhWLgGxBnV+UTFRAOddRBN+54ulmUcwuLSquQNYQiAYVD5o52yguNayUa/pTiJyvZnxRoJUDZwjR4kL8DzxaWDOyL2eB89NQA+KuifBvAc1vlGme8cKKWSbT8kenqJUG4PpqN0/NZ3trputMRB+dubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWirr0iuG6mAxg2Xd3VxPkxEOsVowqCmylTmVWaSNvs=;
 b=TwM9m69Yy1iKtymTX18bS9zhEEB2A69TUvWwbx3o/LSMqRfM3FWhbaM4pqC1gqC1pzVH9cGpGhWeQLvl5/vQd/wn+EMn1A5O0IEC0bXXxQNBf2pCC6S8RD1zZB+9YiaWcRnLCP1HVRSV1XxA+wL3LUsxHTdYp7yXzTl3JUhCEGk=
Received: from CH2PR19CA0013.namprd19.prod.outlook.com (2603:10b6:610:4d::23)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Tue, 10 Oct
 2023 20:04:06 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:610:4d:cafe::77) by CH2PR19CA0013.outlook.office365.com
 (2603:10b6:610:4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 20:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 20:04:06 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 10 Oct 2023 15:04:05 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>
Subject: [PATCH v6 5/5] EINJ: Update EINJ documentation
Date: Tue, 10 Oct 2023 15:02:54 -0500
Message-ID: <20231010200254.764273-6-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
References: <20231010200254.764273-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 7144ffaa-674f-4956-033b-08dbc9cc0f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I+t8+JDvPkcjEI/KzfKdD69yV2FRqpszbpxSh1+E9u9V8FXD7f6naIWwG1pX2XN5GJJLymLBbCgCP62eRaf7fJ6amLoJj68DiEIr+p3fqSLBeYUBZhiVJs5vsyNB+QtqHfJTP079cdjiL/6wSz7hF+shBmsHJ/CGwwRoFlDPu6jwGY1PfWvjFJSi4pxJfp3vJQcvxSyBtYskcIbAyM4XqmdTLLsQvZJbOECcvBo4otX6YXAxX1VJ6OVi0CYU2tK15XJQZTyEMXUidT4R5VePioy57aPxhf48tULudBeWuG0zi9gT7Z+X3LQtvAy1MT+mGw/vz4sWBFU1ahgexSQKsQz4x0Mwh7lSFtnm1PNnRGP5PQsgy66yM2QU90L8YiTsqiKV6Jc4cA+X0ISAhrmaAT4LbzlzR3h4Kt0YsNQ+kqlZWYBBmMscaAaH/WoPMQNoX2WZaJ63nN5ep5uaKBh+lK+zqjOfo52ljjvYUtLT2tfpkSBnBXPfPkwmfmBSfnYM9w5TMNbiyFH7s33Gc7b7g6A3Akqx9i3zWgbtBfZcwCrQ+KXY0aSZzQLOQeiLDsZK8SmDCRLbN6GT0Y9sq/CMoxxqDDHlqnkxCBYy2OYEiIBvg6+MUpC1ILCQLKJpsBCPRVQF9iD/l38RUICJNQjoIfOX4KPnKLgupN4fe2YlCsbtSVed7/9KZyi+M+kn8aU80B2cEIHVQ6W2TKxLqNLMVV53Rd5DihxN2EyalbL3Uo0NBPfqH2LrHYsnJWchJwRMJDLw1oNHr5b9KJi5KEdM4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(40460700003)(1076003)(8676002)(6666004)(7696005)(70206006)(478600001)(2616005)(336012)(15650500001)(426003)(110136005)(54906003)(19627235002)(41300700001)(83380400001)(16526019)(8936002)(5660300002)(316002)(47076005)(70586007)(36860700001)(82740400003)(2906002)(86362001)(81166007)(36756003)(26005)(40480700001)(356005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 20:04:06.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7144ffaa-674f-4956-033b-08dbc9cc0f11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update EINJ documentation with build requirements for CXL error types
and how to inject CXL error types.

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


