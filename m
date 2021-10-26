Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF143B7F7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 19:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbhJZRQM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 13:16:12 -0400
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:24017
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236481AbhJZRQB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 13:16:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGIUnd/PpQL3SK5H1CHbMsI4Z8y4IJgLQKwV/z425sOjZLAkTLat5lDv9OCPvGDCTycLNhCPrZX35azF9OZ02SI19jFStaVFlOU4Jld0FYREFdbXedFNQplhN9Kxz02hDtajILiCzTIK75LP6us9lue/CwBcClj12T7zXk/DHLA8NlEz1+CDKF2xpY8zyENUxV+/ftYCfMFPDMSU3TsI/Tdjg6bMQgoSnHn16mo76IPxMDzN5UQ3KAce2urGoV9Y/WZEKPBBnOEmysLfxaBvCqQ9mE3ODcBtWl5DSzLooG+NB/HRvAtE5gjcqcoT/AC1eG8lvhV/mc785i9nMbf5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIoYUMBxEY8Hxumis/F/0ZUQvKfrJtXqDE3i7c3HbgE=;
 b=E3CXHbU0sVt/75gznzpGXB7/YxvX2hOShGtPCegPdoS+KLiVfPe9INiETIcP55qXjCdFla56EjJK9dh+wr88RUQF+AwU51v8HbVWRyDH8/dwiBctkE0BMJDa2qEoPfW2NZMRLsq+2XVd/QDUxAbXPQ8gNk2h4OL536QDAZIRqj6/zJAbm010KafEqKnCkB74LLfc9+9nrULcEbpFAqgfYK9dr+748ABnq2DXa6H8rchuQ3GRAN06UUHrEhi18QNh0uUhi2GeiTQdjob/7MLRpQiLG0UtEGanKuY+2nc2kOjGFhYA1tQNrDwnWmabUQQwXFxiDr4qDeSZ9wTU5Eo/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIoYUMBxEY8Hxumis/F/0ZUQvKfrJtXqDE3i7c3HbgE=;
 b=txCoOlexwh5Swj+GYBW+rpfv/1j5vEnZiKkcTJU/FHcUrCvbZQ7xfGnTqUgFsfCprFgva1IaxeZphp4nuI2RlLY7r55TejiLqhkdyUEAT5OFq+4mtXieWefM7gxaxiZAc09b0s73Wj76znn0QedJQWc55kszYUO4ITfGuLM4Tkw=
Received: from BN9P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::8)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 17:13:35 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::ff) by BN9P222CA0003.outlook.office365.com
 (2603:10b6:408:10c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 17:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:13:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 12:13:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 1/2] ACPI: Add stubs for wakeup handler functions
Date:   Tue, 26 Oct 2021 12:13:12 -0500
Message-ID: <20211026171313.50-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49e42e51-6590-4447-4414-08d998a3f186
X-MS-TrafficTypeDiagnostic: DM6PR12MB4354:
X-Microsoft-Antispam-PRVS: <DM6PR12MB435494D41E2A07082BD2A940E2849@DM6PR12MB4354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lz8kH+myms4v/6ABYh/TQgHD0pbJOR9ntOQIjEQzkyprnKN8D/AiQHn2zA4YU5IsfOxQx6Xz1yTiEAHHsaFgXe9zh/GLSAE5s1Rg16o/oH1YIzmX5a/d6/diJGLpgrRjA+0sWibRxvpzD6CX3ynSakgyikHW10/jYM/g12rqdb6cI+i6FOv0/IQ0xrcHmDkQqPSjqcvfvPpcVzZpwhseiVEAhCluiRqS4hoHmzF/QJrTLG3EmeBXgzYJHzImsghJVDrYO2wJoJr3vrz8FOsz/gPPBs6elZLSGxA0Qaldqt5XHzR+sfq5JXxZTkJGkjY80CD+ugrrWMMFmjRbt/erZhq9NrFEBJykF5RmTKROaxqc7kMA0qlkAUTADAsPCpXqwHyjYW8RtBMK+GciJ/umnqViZcX/ntmHuPSYrnGFhOHPj4t4Kvd6O0wgkn3fvADuTwLbmoVeu1uop1uu8O4vfcAik0ok/++i8R2vuFEmQPIfEsVCjkw57U7ap+JBepyuE2Em42N5HCt/s/agmdX0vIzZ22/hODI14GUMYIlELPrrBRiTNPpgoFKdhI3QieXvgXdGgOXQDcK/J4L5oZvHKE8V5SXy81t9N81IT3RW7WKMwKsr1k5pJvgjawED7hywMQ8oyiryh23rgGMro5FptDFu0K58sl5UVq1ik0o0a9IfMO7L7sXk9byj+qI1HGYg/7D1+Lv+pVT5wTEzp+lvY8jSOTOISiOqS1n+EEey1s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(5660300002)(6636002)(54906003)(44832011)(110136005)(26005)(508600001)(316002)(2906002)(8676002)(36756003)(83380400001)(47076005)(2616005)(82310400003)(356005)(336012)(186003)(16526019)(70586007)(70206006)(86362001)(8936002)(6666004)(7696005)(81166007)(4326008)(426003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:13:34.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e42e51-6590-4447-4414-08d998a3f186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
added new functions for drivers to use during the s2idle wakeup path, but
didn't add stubs for when CONFIG_ACPI wasn't set.

Add those stubs in for other drivers to be able to use.

Fixes: ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v3->v4:
 * Reword commit message
 * Adjust whitespace
 * Return -ENXIO instead of -EINVAL

 include/linux/acpi.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 72e4f7fd268c..e29b4c1da377 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -976,6 +976,15 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
 	return -ENODEV;
 }
 
+static inline int acpi_register_wakeup_handler(int wake_irq,
+	bool (*wakeup)(void *context), void *context)
+{
+	return -ENXIO;
+}
+
+static inline void acpi_unregister_wakeup_handler(
+	bool (*wakeup)(void *context), void *context) { }
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
2.25.1

