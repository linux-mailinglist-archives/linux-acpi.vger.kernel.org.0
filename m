Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3CF4C4E59
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 20:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiBYTMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 14:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiBYTMA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 14:12:00 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D8920BCD1
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 11:11:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L729H5tyj4dI3lkJaSZP7K0bdXKRWqxlASNxQ7zLssH0gEpP0SVkBm2bB5uhqGw7+iy/ZYXswNbO6LtRt4hCj6eCOiJ5QgBQADYWsyLVTabR9bfF7IlR6AInPSB7pSRH57eFDDkr0yaMDbK4Gt0s3TL/nVCB3LRGXHWhLKh657qZ56Jjwj3KFNxTpxX3Wu7PaqrTT1FDHy3YUH0yKOiZL9q8vvsPWjsN3Moc5YmFSPCdY9tDmFWLAAcvfcMWwuxQLMEthX9CUare4ogUVFDjFsLZet8vtHrALQuPFzPoxj2+8Us8pWfZBM5cFBRuKscQqKrCa6vU/MKYe3OxVRjQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udoK6aGr7mCFic6AaKfxBsbYdz4uciC7RVMSgxHqHkw=;
 b=H4NgNYXFmZ3i0lWP85J7USgtt5Jt/dmM74FLdPmprpwL/QpSNkmYh+vnlrclXgbjkWz8HOD4zNrqGfsmy93Evd5WOuUhbA9zN1MjO/bQkqP9iCcXzh5iTACf/8RdtmMJvgQmp6BDICc5Uu552xch1+tZCZedGl7F2QEnGC9OYJeasubGf42prdw7X5OCSOC74KeYryEdTPebLOiqYWK7YGaqpE0X4BzghnW9Kp7eGJSTtTRPsddz8f22brJQxFpv8FJ4EPJZrTxZNa5dUgkyjA5bpNiwQdBxaQgYk//KHM/MDQhLgPNnpRym1w21+PBiOm5DxC4I5LpzVLkCjfPBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udoK6aGr7mCFic6AaKfxBsbYdz4uciC7RVMSgxHqHkw=;
 b=pBFg9A0z2wovpH77oknSkOqb8R8TEhWEpTxbBgM9SVqaqrbyhOwx8SJZrtPReiOzVu4bnfD+Uf3thZyGtGNLM0XAhXyDCSZajUJn+75V0OaFkoZf++QYMt6b/o/8V+8BBX/dqziEVCjeS/D7hWUyzZidWyCqIDm7eCl901qTUc4=
Received: from DM3PR11CA0008.namprd11.prod.outlook.com (2603:10b6:0:54::18) by
 PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 25 Feb 2022 19:11:26 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::cd) by DM3PR11CA0008.outlook.office365.com
 (2603:10b6:0:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Fri, 25 Feb 2022 19:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:11:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:11:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/2] Avoid enabling LPI on non-ARM
Date:   Fri, 25 Feb 2022 13:06:44 -0600
Message-ID: <20220225190646.1045695-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 155afb6d-89e8-4f65-994a-08d9f8929e37
X-MS-TrafficTypeDiagnostic: PH0PR12MB5420:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5420F4A67561D8B18150B1FDE23E9@PH0PR12MB5420.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urbQdUXn3dFhgSHkYmZdmZ5BX2q4rjaitC12nNqh9eolpmkC8ARttIJpyeb+2GJ+7QVxXn0BNzQQ9gQe81JUi632bUrojOXipm8gcKn2ZN5MD28D34bthwpzV1VAjIh+svjb1S/20ywZ/ys9env7dSlEFdM06WCkYTksfnMbBPVhoN3pfcyZeR+HJze1fHqj8vpPYaAiHsgsB5YfaQJoTCSBAMGgajfF2KFEs96AfrT13zQoYNeCUvx9slTX5FGa8/ANLLWoOrXK9Vqjn3ucC2ofNu5sKc5sijRbaGjwZZJcFCv1HIt5f35dC4C6OJqwRVWEBhzvo0Kkg1iDaJH2rrF9SefW4leXh+pdHw3hg6Qq6nnDYXrwXv2ocl6Ixv9xeWnwxz/XjDnpoDPJjk+bYMaTRDGB/HHY8/u0yWCvKlgPk6uol27Tt8Ssngcq5ZSfB79ABzz5mdR9UTY1S3txz+ravzww3bABsXSpZcxiuOIAhtCLiRR4gM42aHLE3HC10+Xm0YcoH+rP1uuVXI8ZgVH5NV0+IbZV405msNjtbZPw3RG2CVP11k3jT1+wbDVP+gQmZvg0FQLj8nOqPspVQGki1TjEaAvV4rdUKi2mdilLYj5W0j+JfgFPZ6VyTDOfd2Bt5B+oTDuVWVqB8QYTa16j+YFf7k/t6yEJAhEEIAw9i6US+c04oPGSSJ+knGg6GNuRgvyaq3/107nBr/N0FuZ+m7fFsyuEh7WA7gf26wt6RuL7MKOIo378Rpf284jLZPuCTxY71XbCaVuyg/AUFNvS/bZhQpGDqAR7Holeoeg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(70206006)(70586007)(2906002)(2616005)(36860700001)(1076003)(8936002)(36756003)(356005)(336012)(186003)(47076005)(83380400001)(966005)(110136005)(40460700003)(26005)(54906003)(316002)(82310400004)(16526019)(81166007)(5660300002)(44832011)(86362001)(508600001)(4326008)(426003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:11:25.1899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155afb6d-89e8-4f65-994a-08d9f8929e37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some AMD platforms the platform _OSC negotiation will lead to
`osc_pc_lpi_support_confirmed` being set and because the ACPI tables are
populated with `_LPI` entries the kernel will attempt to enable LPI.

On non-ARM kernels LPI is not supported and both
`acpi_processor_ffh_lpi_probe` and
`acpi_processor_ffh_lpi_enter` will return error codes.

When this happens there is no recourse though; the cpuidle code does
not switch to `_CST` mode, but rather it will continue to behave as though
LPI has been enabled and the CPU will remain in a high power state.

This patch series shifts the checks around while enabling LPI to detect
this situation and let the system continue to set up in _CST mode.

Link to v1: https://lore.kernel.org/linux-acpi/20220225031255.3647599-1-mario.limonciello@amd.com/T/#m90282a6e29c334d14b2854a27d7225fc57a22aa6

Mario Limonciello (2):
  PSCI: cpuidle: Move the `has_lpi` check to the beginning of the
    function
  ACPI: processor idle: Check for architectural support for LPI

 arch/arm64/kernel/cpuidle.c   |  6 +++---
 drivers/acpi/processor_idle.c | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.34.1

