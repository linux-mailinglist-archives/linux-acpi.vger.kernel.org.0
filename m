Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFCB644D8A
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Dec 2022 21:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLFUwz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Dec 2022 15:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLFUws (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Dec 2022 15:52:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B42A705
        for <linux-acpi@vger.kernel.org>; Tue,  6 Dec 2022 12:52:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3AsWzMuPHYBq7CCl/e6sYK67lSsHU6EUPRGJZdsvPSL2cpRxAOCPRC6Sc1PJYVlBZ5eZtqvDLWnzVd5JgaZYFXjfpZqAiQ30LsBBCcJkzLK+20usQuEzWDkGK6Z3L++mYprVC+KD04+/iLKsZtHa3BIza44461Odu3NqYM6hgkNQ/ipQvYRf8vGNlinnVpPK0kHsZn5XMQmz4QERiUV2upaVKZV1rFUtSKDhTyhDZvE++EalgBnNJshzGOmR8Aq6PAm+JGj+ADg1DNLqTgEUZnytjp5LMu4yg/cLzZa+vHfRSKWHbNWhu/wrbuimYVNIXnSvawucZnRxHWxyo8Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO1whW6HI4gGVagQaoLWL+oQGibnbNvR94Wm1ltqbCs=;
 b=W+rEqbPjgF1GCDoknvYAPuHTnVyE45szXKrZGAYfxODb1r+iTuRfEGdbm2BFEFF5wfyLkiEnJYpdbzkOxoOWBzaTqJnoZAn7ReYLzlK/6Fv1u57FBXMelFwHbCB9dR8LjdB7C9RDmZOzcS6Xm6AnY2sMqccPB1dWIfOlhsKTlmVke8sM4AeHYn/3bozZ9fcxzKZ+1shKMjjCP5hXxRed2ItAeTL0xhgdnmciYh/IhcJh0B0sYv+8zWpRoUE/+oxL/BOW58JXU/H/gpDOceejyF/c6iqmrk2pHK87mVRK1wJnGctE8ex/PrGRpLcQaBoDEz+GHd6n7gQslb9x7sUCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO1whW6HI4gGVagQaoLWL+oQGibnbNvR94Wm1ltqbCs=;
 b=FGECJkmJRJ8S6CevCjvIiRMbMuc9u9rc8a1zc66KHZQCQL2X6SFD+OAodwhuAWpcD6EhDdjdjYyK3tw+/ItR36hQ2bptCB8HqBJzrp+sOPirzgK2PAiXijztaBSiK3Dq9bj+BkvqmM5kfUWC4hW8V0RwPJXfQFEFfzF0A287IXU=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 20:52:46 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::26) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 20:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Tue, 6 Dec 2022 20:52:46 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 14:52:42 -0600
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC:     <benjamin.cheatham@amd.com>, <yazen.ghannam@amd.com>,
        <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 0/3] ACPI, APEI, EINJ: Add new CXL Error Types
Date:   Tue, 6 Dec 2022 14:52:31 -0600
Message-ID: <20221206205234.606073-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4bd37e-7d0c-478a-ca4b-08dad7cbd406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rhGAS2cvMjQmopRQwOkWIRJLRfYs/KQ3yvpJ4/2lYGRb/qG3c9zAmDPRyt0exUtQE9b4g/SXeZTHxm1VSBaZla7KQlUf6IaKseNCFbcokQJY/9fukQicFSjMLArf2EzAAXx1w8Q1CjofptznA0Tll+7mW5ljYPDI3nEqAyPCU9F0NidV0bmLqA1rncw+x38OsmAx9XLIpuScWQzcVDFiYyEEB5qU7cJGNCmmkbWHvuTEkS+HpdCJ07zfiQIiXo0ZOsrV5PV42tE0Pf1kXcMBmVLAvUiJrhlA2pdeioVPkpa6JUym2ISfHJsgHnBTudcWN9Sc53YubdxgJyoZfuoHtpY0HwU6VCV+wpGRy3mT74MY6Qf+E8WJ7YKPCvuV8yqO+/R6AJ2927FlMO7db5tYxTurbuPLUZO5bqZAneIt82R0JFDgyK++hU/LI6YGWbSwBgxYiZty1/HUsY/Ri2UtGhc1aoF5xnMU4ztXcDOgNxuwI+haRkolzLKOnOlZM26x0g3OLQJf4X6R89KYOtUa1PFzRHirLEoXk7br5qkjiTLRL+YsfqT6Rd4BT/lDa3dNKGLLYW16tdFt3PcBoS5As+fHz+5F/isXeJvBsaicVgSeSKq35PfONrAO3bEC6nUEoJZWm8ro0bbCdyqphQcf5AU9ImihP+OSHtdPF9+le86UzM/LpUkK4sQMyW2LntDFsg6k9zpHuAOQFzAT7HzDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(336012)(70586007)(16526019)(2906002)(41300700001)(186003)(5660300002)(47076005)(1076003)(426003)(8936002)(6666004)(478600001)(8676002)(4326008)(2616005)(36860700001)(82740400003)(70206006)(54906003)(36756003)(81166007)(316002)(82310400005)(40460700003)(356005)(110136005)(26005)(86362001)(7696005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 20:52:46.1425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4bd37e-7d0c-478a-ca4b-08dad7cbd406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Changes in V2:
	- remove unnecessary comments in patches 2 & 3 (Borislav)
	- change bitshit operation to just use BIT macro (Borislav)

Fix formatting errors alerted by checkpatch.pl, including missing 
lines and indentations to clean up for following patches.
 
Create an array to store error type descriptions for maintainability.

Add new CXL error types so that they are advertised.

Quick Note:	
I sent out an email last week explaining why I was taking over this
patch series, but just in case: Jay's internship at AMD ended a couple
of months ago and I was asked to pick up this patch set for her. I also
said I was going to add a patch in aforementioned email, but I didn't
have a machine to test it so I've left it out. Thanks

Jay Lu (3):
  ACPI, APEI, EINJ: Fix Formatting Errors
  ACPI, APEI, EINJ: Refactor available_error_type_show
  ACPI, APEI, EINJ: Add support for new CXL error types

 drivers/acpi/apei/einj.c | 62 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

-- 
2.34.1

