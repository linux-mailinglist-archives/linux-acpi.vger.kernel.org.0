Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF771404095
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Sep 2021 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhIHVms (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Sep 2021 17:42:48 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:16160
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229587AbhIHVmq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Sep 2021 17:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KntF4bsWtxqM5LTU2MiOcn0P1thelp/6vKrFYUYrXSwy1PDGOZkk76kjKXPjq3AuNQYtfP6hCXtZ5Ythnmr5i/ebQE+QDZrgThyYy727c4tVrmXU7FRi3ME0RKL6/C0SmUF8dtyDtcAaIKM8iQJvH8Qoq4PQYlwnJjhLU0XgHKTQtmpyxMFufynPpGaUyhYjEJvL9qTDNQwTy74KpKu1IKkGbqK6vJGpXBQfBkJwbnQflMuPuh37WB9mKNQsUYbqJzK/wVIse3YBwaJSOlpcFfiS1aX8gAaBA9vKWkx0u0wfNPYC5QMJu0QxNz8gG+nccVd2IzYrMT74RIVInRXQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2ovqgiWwlRAAcqM/cog39OOWYkrmkboaFdpu1R/JwW8=;
 b=TaIWcfdGz8TE5Nq6O+WTHEWrClfIp2JnOXa17dJHdfyV3gtKxYH73eQEUHq/umgwHO4ONBx7LiJJTVBe9s1PKHbg6p5FAdhwop4x+3bK03HJm/FzRwKZO9czw4d3fFyzi5uRM/qyWbsPYArwtQ7REk6kSj48rKkD8D9iPXiJVjmofZCzC6JknhvASrSocHKTd6R3XPrXMragaJgSmeL6EhjpACOuU+ygnSv/vkQMZ1PqtiRk8ZKSf1kXqbMPYInJeDDjz0D00dmeDFCPXEL9H0LkiiXcQQyo/FjoPi/Eyk902g1RuycDQib3SnnKa0mLSRaamZ1DuNLdrb+R7qDmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ovqgiWwlRAAcqM/cog39OOWYkrmkboaFdpu1R/JwW8=;
 b=i69NS4qyIB+RGMoq4l5nIbNcCJcWVdgP5j6MgO1HWkwCbivaVSP0XfA7mGBNZdHX8tbdY6+s8pAFdF2CJyl/yJ6AHjUubPDz//Qt03HWPb+I3iZkTeXlwsSwnK9d4lLj7ti/ecjSZenfvFyC9b0a8j23LnD804sGbUGJwhspEzE=
Received: from DM5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:4:15::14) by
 CY4PR12MB1701.namprd12.prod.outlook.com (2603:10b6:903:121::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Wed, 8 Sep 2021 21:41:36 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::4c) by DM5PR16CA0028.outlook.office365.com
 (2603:10b6:4:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 21:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 21:41:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 16:41:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" 
        <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] ACPICA: Add support for MADT online enabled bit
Date:   Wed, 8 Sep 2021 16:41:45 -0500
Message-ID: <20210908214146.8640-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5daa75-e89c-4c34-dab2-08d973116f1c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1701:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1701622D47D458261858BFF9E2D49@CY4PR12MB1701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMYTCloQU8vIoS5X5ik2ffwNbtRW3xCuKuYqsSgCRp+vtrDLvijRqQt6/TGKPUn0sXQ9HG1tULcA2oG+nFZBA3iGpnCEcgaj45pGv6DunoHZ3R7fPL/Lr5Zgnys+j800mE0sv59QH7JGk7kWHQpxhVCrZvhyQ62fDZwchsZDRwmQ4gshoCnSg14MT2DiWdvH7TUK5HytOeIhrBMrqjfNirxtfcW2y1dx0qQT8mN/Wyw70yobN869pcY0WwNuQ4F+eU8X0i/298/5aruFftckGZa0dAepn1Sx7MqDIvH2XJOuA64JKH99miGhGct1euubcz5faUh88vdATOZhzRMALvBRTHnyv4THjdowkHkmKiSJLBJktt9s/ErlWi0ulSsMoSYlyqo+LQH58nuy79CW9KVAOp/RWewwg2L37UgPF5B5v2Nh8PgXAzxXhy68pfZCBv97UglvVseROsgNJeFG2K4UWQx3nLYtj3RZjZ/CaqKqTtphtWMlBlxJX7z6GTkooSf2GzgI77pKqRwRu6TAzXGfT+FRjW8bUtkNNO4HTBsiCKTVjO1jSmzmlEHOS73RaAlx+QzJozBRdCm72V3qeZeyoGPfOy/pUzGVhI5vtqdZo8kDCYKR7Y0mU93ypvF9aAO0lmn2R7kWNJdxhzv4yRGOB/+ayZFGjvgmhFnV8XIfE4VFDlc1O///zgfBYy6TiXFiIRZK7/BxrAYfqAKUWBJwNk8JXhifGbc0KGZ4lW5MIsXR0xAiojZ3/j1kvUtXhuTl0AGCAb4EOKqG6QVjuTPmk/uI2BcL4D/IPJ1Z2YGEdot3uvH5CHG5G0PZVmeZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(16526019)(426003)(4744005)(8676002)(186003)(8936002)(2906002)(966005)(44832011)(356005)(2616005)(7696005)(336012)(1076003)(36756003)(54906003)(478600001)(316002)(4326008)(82310400003)(81166007)(83380400001)(70586007)(70206006)(26005)(86362001)(47076005)(36860700001)(82740400003)(6916009)(5660300002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 21:41:36.4476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5daa75-e89c-4c34-dab2-08d973116f1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1701
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The online enabled bit on newer ACPI implmentations will indicate
whether the CPU is hotpluggable.

Link: http://github.com/acpica/acpica/pull/708/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/acpi/actbl2.h | 1 +
 1 file changed, 1 insertion(+)

Changes from v2:
 * Split into a separate patch from the acpica pull request

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2069ac38a4e2..fae45e383987 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -808,6 +808,7 @@ struct acpi_madt_multiproc_wakeup_mailbox {
 /* MADT Local APIC flags */
 
 #define ACPI_MADT_ENABLED           (1)	/* 00: Processor is usable if set */
+#define ACPI_MADT_ONLINE_CAPABLE    (2)	/* 01: System HW supports enabling processor at runtime */
 
 /* MADT MPS INTI flags (inti_flags) */
 
-- 
2.25.1

