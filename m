Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375E54C3C54
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 04:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiBYDQt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Feb 2022 22:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiBYDQt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Feb 2022 22:16:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFC1B7556
        for <linux-acpi@vger.kernel.org>; Thu, 24 Feb 2022 19:16:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nbvvfqo8BEEtR8SYp0/Ejj+/hsblrVe5CMMZ05ACavdGLosnQS6gCOU1g6/31fN0LfbNaDKnDv49Dl1WT0zJ2bDywaol9hKb+X51Fj5sp1UNpBHN9ZHM2s3eckFi/JW+di0oHxIBn+2h2ltxKn16nq2tpdKAmu9rxAAZYKr15lSMd7Q71QR7MYtcA/hCDD3ePYUA/QoqnsUXwdpE9rZnFEZs1vHby+lA0ZT+I7kgCVZiGGkUFRMZ9PW+P8K/Tq5GRJDdIm0M4F105983WjJB61YyzyFTnjEqgfrGfZzI53fgfaQQr8TFEwOuQT9EN8PibK3iCvawBXQcRCYat/D5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5bckbnCxqYlYdvKs7baQK/mRptTN5L3SA1emoBD3Ek=;
 b=GrGjkc5aNlooh59AuHJUFJ7EmF8fIzzbEVsowMDlOCQNdKszQ/xxwkkeSClGDyaLbARXpIEpBLuQ+CfPt/aUl/68KmnD9dsOg5gZ/l1zYq3edrULkCZ+aPCTtF/GpPYfu9ressdElwF7fWE7bVgbtTGwhDQiPiDU2pgw9vYWxrvDzm0RL3G8fvBmuu7de7Y6plMTaOwkBPJ6MGxfAv4kJ3N/7pKS4npDntmSoBth1ETlemD6bapeTWjmQB3jD2S4ThH13wa5a8BpEfq6HDLjXmQxmB8RLLSmu9Xq+QvC0IogIhoB1o0lQ0K0atjd2yQY9d3Lwz+XLHmI+4U/OF5ssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5bckbnCxqYlYdvKs7baQK/mRptTN5L3SA1emoBD3Ek=;
 b=QONQJiqRjmNQjCb3f7FKRfkR2hCV1wjyC8EabcerpE4Md6dWKouGnYST/DDVe8oxzk/w5Stk+W6GZ3WKVRNTqEL58zTyMnYrhUxMY7VJEhTifr4ge4PulTftGQmuSiIbqexdtjNXJtz0zdnFuAuifc6Y+osp6Kj7ZdmIrlFai1A=
Received: from DM6PR07CA0084.namprd07.prod.outlook.com (2603:10b6:5:337::17)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 03:16:15 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::77) by DM6PR07CA0084.outlook.office365.com
 (2603:10b6:5:337::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Fri, 25 Feb 2022 03:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 03:16:15 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 21:16:13 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <Ray.Huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Avoid enabling LPI on non-ARM
Date:   Thu, 24 Feb 2022 21:12:53 -0600
Message-ID: <20220225031255.3647599-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c66e71a8-e00d-4532-5b4e-08d9f80d2eb3
X-MS-TrafficTypeDiagnostic: MN0PR12MB5738:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5738A8219CB898B9313AD0FEE23E9@MN0PR12MB5738.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyrAclTHX8+lBSMDtXQ9z5UUkxMCSmFOvKA1EArh7YM7YSntCeUNDql4OiE/r8WPQxQPYXs1t65pU5dBD8pUpt0QPexwY28UWnJjAs5ycKnGinAdNiAM+T9cGxUlYy9S6sPsMa9pPmnmy/qKNnax9T1EZVynO+y6s7ZA+evmxhVZuBui3WT4xTfuagt/s1sN6GviD+5rXwtEKtN1h3dhZ6JyQIa001Z1/oFjRL8Mk3wLeR5KFRszfXpYf/B++Nz2AsbYKncgPEUKXyDVm5hvI6Vw7XPLYiK7AeqMe2n43hA6Uadv2kZVPv3iPScGe5nIj0aCF+jteTAJ99MLLO2mFDW9BJzSeo3r6KphohPxAsuXbD9h1UaE5n3TWkSDWXpSKBrGxwjJ04nw7KRUT3O6v/3GhiY+u9Qcrjzqh/FCCviegsuLcpNwmtfEYW0GtK8ybcDq+CY4Dp9NivpLd8yYn81srK1EBGBzeeOzRyITYYKhHVRWt+H0N0m6cmY6G8CgH61TwxuLQzZqcyG3Vw5DuHDHHM4526pzSE2QZvt9GUAIlCfV0docA90K13rVaYso6vBQST94gi1auvIg/IMjsDC/9D9+4pobhrICoqbtmnJwGSZ9nXSZXWOSuSvyUrDFQL6iZGA8FDB9bnjcgx3LEHUJrqR4B20u2kJiAz+sXmPEZwLDZhsPNMfWLQwCOvCHgf0yoBjKWGGlsRSgKipM2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(86362001)(5660300002)(8936002)(316002)(70206006)(4326008)(8676002)(54906003)(36756003)(508600001)(70586007)(2906002)(40460700003)(44832011)(6666004)(26005)(186003)(426003)(81166007)(82310400004)(356005)(1076003)(47076005)(36860700001)(2616005)(16526019)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 03:16:15.0467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66e71a8-e00d-4532-5b4e-08d9f80d2eb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
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


Mario Limonciello (2):
  PSCI: cpuidle: Move the `has_lpi` check to the beginning of the
    function
  ACPI: processor idle: Check for architectural support for LPI

 arch/arm64/kernel/cpuidle.c   |  6 +++---
 drivers/acpi/processor_idle.c | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.34.1

