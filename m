Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1029E4411E7
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 02:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhKABvb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 21:51:31 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:33632
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230133AbhKABva (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 31 Oct 2021 21:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj1uuMQUbtqEBZ+W6odRLos3RlS+W0ApsHblEXVyblXEPd5EAXdavUzO62Tj+r/aKDDim3YzPD74W1SdSfXD9+up/KSR/1klEKsyoqLkEIW9J0GwtL+jUGRMOI4tFGcQ8uUTe5cQjVGfBk8Ac0ufb1d0huUC5Au1lnr14YiZomEYJf9aaL3gF4GKXqI0q5cXJ6SqE7MYUxgWWY0bYpt9dBGbo0R4CMK9Xc+SUEniYePlCKKEZ3+5nGMwVD97f51az66PUSLnGkx0XWqqaTmc3g/iuFvHUMebv3gr+DNI80MDsTcmSEEgeQqCOzucwmlifKp/BuiFOqiRgx9DBFNrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClUaccHing3kzMGC308MHFl97KTOjb6rqYqHLYU513U=;
 b=i2Xf0gd/GjN+BooeqsxW5KbYcqSPIhpgiOT5gl9j1PWS7pFyZwUPadH1lPksIK8VTlWKTSPso5m6C4WycVLBqLqFX8238dMAG6Nmx4J3gyVpr2iy95MkdizgELIz57KmbKeQGh3UtEpskjjfcRcZ11rtQ29/iRcbC/jkxY1m9JQPXQa6eFtwVTlLv5hzDh9JCaiDaj4C3uW98NKPdHaAxyptr9Ea0vSVTx/cd+z7dXo4ZPkiO7Wog3Z0Z4t6ycCZl/mvkpPwjoPU5yrGJ5oTZ39y+3s5p30cV+SfQz6R98eaTTs79W8z270rqT8Y34yT4f9LUR5EiTaaZDqF+G6AlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClUaccHing3kzMGC308MHFl97KTOjb6rqYqHLYU513U=;
 b=ggDKgKlmPC0nFtkD6WjAAgd9Qa6W7fUnPy6ACg8sxOx3g9bNsfYnkkMO5YNitOp+fvxWCgobe1MWCp4Y+yREmHhYUuvgtMvXZgefmYJAhAKJpbgXS2d3nm33m1COxiEtIUizved4zoEHY8UGiFINGcBA63/hs48pAnmmhNwNHP0=
Received: from DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9) by
 BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 01:48:56 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::92) by DS7PR03CA0310.outlook.office365.com
 (2603:10b6:8:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Mon, 1 Nov 2021 01:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 01:48:56 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 31 Oct
 2021 20:48:55 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 1/2] ACPI: Add stubs for wakeup handler functions
Date:   Sun, 31 Oct 2021 20:48:52 -0500
Message-ID: <20211101014853.6177-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3108b841-ec03-4cc2-eb5b-08d99cd9c43b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128D9A318874006A07CD438E28A9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJHYtU2Q/zIWP6HHXu5DF+o2F7xb72TtYgh1VYiOwXDSJUgMo6WfOOEkrecHsPmpOh2TILlbskRBzv+wAru5JMtTIUQWo7AWY4G7DerMcVpqRYepb2S1i74AljXF01GvTf3qoeMsfafIId/ow4BoDY5pxfmkCXJQ2oRi+HueJXLXc1LFIJtaiVhC14jQ63VL5bAZJ1emjBEMf2H6mLxcZ2L5CYBfdTWRI0bqIC5Win/JeYmbz3G3INzRzDPByrltJMQc/MSuBWqXAsFPryOpmlbliQGYy8Emtqnw/fo9YFALT2iWKj5pTlfYMIhJ0suqrzpKTHDOCoLfxAvdYLeESVUUELYeJN8yxac98JuUXoHjvwyG51TnjelssjF9dF0+DLeEyGFOEZ9pr0acD7PFnX3T6gFZ7XkjnhFMk7QIV1u3PvDdP0syuRcmY5du0eVnKkxZHGGVZgtJlWtWnuBn6cHwgfvEGSyzGMsZuS/MqzgyFkpd5rSLx7RexrlLQ7IcfRca9uTvCV04lVPwmsN/LS9LTy5lPYNbAzb47M6YGdFLR6a+OtNJ/JGGrIn+U+WHDSzFvHi/Sus1t1dyeeTutGhRtVsFUDiI1woBrlwFg9UDwtzFm1EWtYzcBzNTAHKWQU9826nm1Rn2poswA5SlmsnlTaAxlMTEEC/V5F4PKmXUyqdxf0gPVlFzyubAcdzLIWRiSEAqMbjjdmJx0MA/fxMSWE9hUJVCWnrpSC/zQ5s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(4326008)(6636002)(44832011)(54906003)(7696005)(83380400001)(2616005)(110136005)(336012)(2906002)(426003)(81166007)(70206006)(5660300002)(86362001)(47076005)(356005)(82310400003)(16526019)(186003)(6666004)(508600001)(70586007)(26005)(8676002)(8936002)(36860700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 01:48:56.2873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3108b841-ec03-4cc2-eb5b-08d99cd9c43b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
added new functions for drivers to use during the s2idle wakeup path, but
didn't add stubs for when CONFIG_ACPI wasn't set.

Add those stubs in for other drivers to be able to use.

Fixes: ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v6->v7:
 * No changes
Changes from v5->v6:
 * No changes
Changes from v4->v5:
 * Pick up Rafael's tag
 * Target to stable as well
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

