Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED209485950
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jan 2022 20:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiAETjZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jan 2022 14:39:25 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:18657
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243638AbiAETjZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Jan 2022 14:39:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGxcj7XaQBs32bLQyiKgjDMvtO3K7kBvZP3XEQGSi84BkTP3tHtu8JxQKWx8/h8ay1jGKEJcP2plDmr9H7QWnBQg6K7l5A14xI5jv6QKDJC9QBuGUrykbNHesnFwPa0jzDw6oEfvAfuu6iV109SjJ7e2PWv9eqTu+rO1HmjavWXc+Lz058oLgauzd7emZUAmqxjMNAy4JJC3I9h4+N/rnohC8lsN/WsEn3R5ZSyORdlgOiyZYMFwdHLUqzVLA9MKZtCsDE7QrrFAOvkqVHCWCpKRYgt+Y+oTH+XVmYgxp8u4nKq3GIrctO7YuT7TdcSVumnf2QZEy1UvekBZCvTuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOX3fuuEgIT+HSFL10JvENZ9R/2SC5SH8WdA97egsB0=;
 b=CXWHGhNDzpurpRsULpoV0yUYuNX2msLp2Cnf4ipn2SEh3vgK3Gyrtv9+IXehnEEJDz/OgLC3d+5P44b0gmBLP87N/08BFgcRAC4JKmMiqDa7Osii00H+4/b49s38YtsgYATVTJILJLlCaQq2Den3pzeqVT+TZd0WZRQzQiU2PExq2UQx244VtwlZsh/vk5nvIJkDv78158/iVTNXu92ITEx4vsMjr4Oltxk2iBEB8sInoJeFyv/gkhnYpweY9Q+nyZZsNgGXMAFpAPZLztLisngwH41piU0CGRpuB/sWKGn0wBv90vXFHkZEJRKZMPtPwm5KKb6ItgSSIXZI2lq4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOX3fuuEgIT+HSFL10JvENZ9R/2SC5SH8WdA97egsB0=;
 b=W6pIZTHrUa9+Uu4a96kCx4A+TnCOgo+yN9jGs+rW9I2x1jFf/Jzc0RYJ6jQUoXWlEhY+/ju4B8tRruRuWLma4MWF9HYiSsE2vWN2HCDv6xgkyzthc/4Cz1gqHoBAX/m6eDlOBJbR+YKfxAd+jNibXOig6JZyQVWAa/vxQ9XqC3c=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by BN6PR12MB1924.namprd12.prod.outlook.com (2603:10b6:404:108::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 19:39:22 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::42) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Wed, 5 Jan 2022 19:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Wed, 5 Jan 2022 19:39:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 13:39:21 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
Date:   Wed, 5 Jan 2022 13:39:07 -0600
Message-ID: <20220105193910.25678-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 469308d8-0229-4862-d3df-08d9d08312a9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1924:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB192423118CB03625D801E484E24B9@BN6PR12MB1924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uchRwBUfYzORScenx1Q/jCS/fHsOnRk6xOUy6QgGyqETIwitUQVL4GuEkGzobMPjW1CKcnaQKH1ibG0nyTV9J5tXBS6spI/tESR0HaMd8kke6OHHY6YsMxGLjXhUuPi8qpc4wL2dvYRfWFzm+MUZfAiPs3C7uuxyf5bBH9Js+Z0iVSY3JcsTxgS8vLehbe8C0Q/j/GQgvjdcxKkLXvO8Wyp75pjLPZ+btSPFxhSGFo4lclMIP1Bo8+Nwq0B12HidCdfwV1c2U/Mv2xfZZEhW7xb1CckMpYKWzuMYt22OWMIc+ZCVwhzpNTD1jNp+WfuB0WhWlKwjXAR/X8nxnDIWSAcoRyz4t8WakqCh9MzWUWXmG8a1GDCq0FFkd4Ia+8MKhpMvJi3z4Sd+kf24wK+1iV7OSx/7El73zjd8GQCgNWLuRk4PfVzpZ60CxB7Kx2zdwGR1DkOf9k1hEuWQZxoR6X2wJ7rzAeJ3TlRkt3wG8KQboLBPIdBrcimje9+U5BDFUF8mQuPmNftCJ8ltY0ynsLpZkUnWhw4n7MNxR/49SZC4Pjdgr15aaPLmHkJBgKvNx9Ywx99f0F9E8OxH01yr32fW5VRXM8GOw0pb3Y0tP83c+/m0TAPTS8JhenXyTQl9MTPzaDkqFs6VxM722d3wtWKB+yTOlupH2yix0j1Mj3cmAQfqEGXRMy0iXNhAYZyNngZkLkN88CMbnYnR4ooz3D9dDejm+lFLUoqWE0p/3OVcrFpd4fVsngfk9s0A+A9ZrBryuVeZSgFmvNpz+aKEYfWmBYNL2Z5PPQfXmQbQl/Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(44832011)(2616005)(336012)(70206006)(70586007)(36756003)(16526019)(186003)(8936002)(82310400004)(8676002)(26005)(40460700001)(81166007)(47076005)(5660300002)(4326008)(426003)(508600001)(86362001)(2906002)(316002)(6666004)(356005)(7696005)(1076003)(83380400001)(54906003)(110136005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:39:22.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469308d8-0229-4862-d3df-08d9d08312a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1924
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently the Linux kernel will offer s2idle regardless of whether the FADT
indicates the system should use or on X86 if the LPS0 ACPI device has been
activated.

On some non-AMD platforms s2idle can be offered even without proper
firmware support.  The power consumption may be higher in these instances
but the system otherwise properly suspends and resumes.

On AMD platforms however when the FW has been configured not to offer
s2idle some different hardware initialization has occurred such that the
system won't properly resume.

This patch series changes the kernel suspend code to conditionally decide
whether to offer s2idle.  When an AMD system is encountered all the
prerequisites will be checked before s2idle is offered to the user.

Mario Limonciello (3):
  PM: suspend: Move some structure declarations around
  PM: sleep: Don't always assume s2idle will be enabled
  acpi: sleep: Don't offer s2idle on AMD platforms without LPS0

 drivers/acpi/sleep.c      |  6 ++++++
 drivers/acpi/x86/s2idle.c | 36 ++++++++++++++++++++++++----------
 include/linux/suspend.h   |  1 +
 kernel/power/suspend.c    | 41 ++++++++++++++++++++-------------------
 4 files changed, 54 insertions(+), 30 deletions(-)

-- 
2.25.1

