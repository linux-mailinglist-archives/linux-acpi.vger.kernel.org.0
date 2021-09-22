Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5EF414A92
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhIVNdE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Sep 2021 09:33:04 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:55150
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231758AbhIVNdE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Sep 2021 09:33:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOSiyMFmnj/fquKpNLhYJNhMtxDiPJ5XI7ViljqJkpiJQRaTEJtHUl8L+MaJ7HUQLZoplGOHKlYqor07jz3tHKLQndZxjVzR0Nr94U3ZKj9GlLdKi4nX+uoYGc9/3c3KvkR4GCwE7eht0ied3V5CvinbuqYJga0VZAXq4VpXypxwyZ6BdRWi155G/xqYzo4wYwomquiq85qya0dBZ9whl5Ecj5Xn1avtpTHIxAPh8iaViOmfXp4YacH0OhLC/WwUBEnnsVwzQqXkP45CxCnaNCjwj3FeW8wSY4kVoLMrpXl/78rNBr3mbbzNv+t1kJL0KkevwBN81MtvdE5hKdWdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W17vBEOOy4aNcUdNEx+VEnzEDkVB7r32szqCEfv+Acc=;
 b=GbLQ5JqwkO0NirXTbOMBpVuBrBlPWniT66GIy0ZY+H0qlvdRJNucPnlVWTtDEObxLtr+oYrPQusZeoiVDKTjjVbh9Sc9KsfmfasjN8oUPTCUHeqaZZCwMIpGCex/XlYr+tTNRNDZRkm5DRt2nM/Txve2XNgeRZs0dHTsYv4twBduchdK3acBzB9zf7awZ++easgxPWf++/rgOQ3lmO6PZCRv1Hl3qJolp6H3pXE0IkbYNf2DHCiSwjhUiSz2MrqqDTrmJRLXw91ZapgrnYDSYvR3trm8mcqh6/Hu+JTL40lJP4eaIUdxWsXGAitL6/eTFjmop9LKzLfk5mMdV12Ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W17vBEOOy4aNcUdNEx+VEnzEDkVB7r32szqCEfv+Acc=;
 b=K+44rdE4IadMtexlksVkH6Ym6oKjIFyyEPIkUR2C4L7bT+F6h2j/ZSZXXkPAqgVry8DfV2JOqZ1U9mGMQw/N57KaZ0ZyzyhDT14HdK9Y3cWs3+0VIRE3rD8lwgBzuHKMRm2ZIxrxojCMVCqzCG/nwIlHkB4mdcTrvU9pO3NSEf8=
Received: from CO2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:102:2::14)
 by BN7PR12MB2644.namprd12.prod.outlook.com (2603:10b6:408:2d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 13:31:32 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::d8) by CO2PR05CA0004.outlook.office365.com
 (2603:10b6:102:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Wed, 22 Sep 2021 13:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 13:31:32 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 08:31:30 -0500
From:   Richard Gong <richard.gong@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lijo.lazar@amd.com>, Richard Gong <richard.gong@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCHv1] ACPI: processor idle: Allow playing dead in C3 state
Date:   Wed, 22 Sep 2021 08:31:16 -0500
Message-ID: <20210922133116.102-1-richard.gong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05186a4b-da85-4922-26d7-08d97dcd4a9b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2644:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2644B1B6272CD9D9DAE65F5295A29@BN7PR12MB2644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Kox1YYGvppGRXl7Q4az7s7ZQ3wf49pcOFMEF+aR1ZTJzEouymQ/gyAi8nQ6hh5rT0dppKyi8A7IHaiX/gymWXe4suunkpO2vYpBV4jnxQPkwFFxHRkNp3Ze//mSegD/X8zS1kYPI30FWaHA4lVMWW8v3Jpay+wgeecsgnHqzlIDH+iPjyW3YsGAOTr+jsbz6izo6XnBf+uOTZhhadCB6pMuZX3wtlo1l2Q/C9DZTlq8WO5QlOHPOrv0+cK18qXLAS8ns9PS+H9wj8bmcKPuZXSBOoNYIMrGl7+xyd+tBu0LEKVEcTb34Y8fft47ZVg1RNpHCSSZNJAEl05FDBuI9Zb5ud/W8REBXdWFv54MSvyW08hXmz+M9YNo6MhmHr/sKapmIgJJ6DTqA0VwYf2ZIAmbfYdQVZ2V5XRXXkYIgBsq5ya3i5A6m9G8kWTIirK/x3bxFwF03aV0MhjfSWqY3xoGmpAWR/vOBLmMdmyrGW0AdT8q2BhIRj2sz/fgC0yPbCh0ioZegmF7UchS2TxOqiOoro/qDTTZV6CXoGpZS3TACWw0Wh3D/txtO1YgKDl0AISbUAUgTPSth8LXkRkKZRuNl+7AtyfSuVX0SZz5bv/rH/t/MpUaF2uW0eCEETcxtMLxfyds6NYPxm/tmYEKTYf/LYdwM9VzG+MlEWnl6NMSFhXT9YYi+fwBdttQevQ69X6i0Q02VyuSivOViwf4DnJvgR7O+9TVsHPmBPMpEXM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(70206006)(8676002)(16526019)(5660300002)(356005)(70586007)(2616005)(426003)(54906003)(36756003)(47076005)(86362001)(110136005)(316002)(336012)(83380400001)(186003)(4326008)(36860700001)(508600001)(81166007)(966005)(44832011)(82310400003)(1076003)(2906002)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 13:31:32.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05186a4b-da85-4922-26d7-08d97dcd4a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2644
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When some cores are disabled on AMD platforms, the system will no longer
be able to enter suspend-to-idle s0ix.

Update to allow playing dead in C3 state so that the CPUs can enter the
deepest state on AMD platforms.

BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1708
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Richard Gong <richard.gong@amd.com>
---
 drivers/acpi/processor_idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index f37fba9e5ba0..61d5a72d218e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -789,7 +789,8 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 		state->enter = acpi_idle_enter;
 
 		state->flags = 0;
-		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2) {
+		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2
+			|| cx->type == ACPI_STATE_C3) {
 			state->enter_dead = acpi_idle_play_dead;
 			drv->safe_state_index = count;
 		}
-- 
2.25.1

