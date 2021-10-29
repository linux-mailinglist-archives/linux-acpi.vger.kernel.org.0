Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4644043E
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2UnC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 16:43:02 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:47605
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230221AbhJ2UnB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 16:43:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEWQSvmqAUT0TGcjipDVn8fdhG1Gg0A3ygCM6V4xIfpEa3vZlWrsq3SofFaYbrgSrynl2RujylvQ3vn0E7W4hUYw8PP97cKPgINmPKI7X3E6kinEUteQjYRsPqU8qbz3++mkFdTes8IenIqhfZ4s061hfb8hB7zKqES768Xk8W3hiAGxaVlMm1algc1SRZbV0w8jZzhFYYUOvh+hh9L78nmC6N4AE0GDUglb9fZ2iZfBiM2NbXvXikp3toNZy/Vm1epKxTO7b3TyYWT2azHBJ1yJ99Tqt6buDuxN0Rf0ITcS8bTcZ2BHv8hF0Cm/ZqlECEZyKe/uBz6pIVN0DHnLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia58ddQfrcc1j97nTPniCZQEvds7uXAs8Lkol0WWFIw=;
 b=XBzpKMJE4SstW1QgaKJa6alJw1xLyLRUeOMoiV7FdyFIAFd5MdT0JaW3YqAElAh0WdMRi9x+HxyOL9csQv1e+6+B2lEumxih50IgoN9rLKfn+E3UxT2EomLYpPh4jv9rKdYqxuT2Ngyo7u4tLpMYfDNfBRPbmzZTAlsgYfpXhj+Xi/o4YDaSI488KubA5WTVVq3BZSz7DqXVrm9tVHk0vbbGbUJ1qmM54Xuj5vIWi285D5YzgLMZCxKwZlttyD4OrcieZIy1hyrHufoqLuhU2tXoeoCu8qT8VSxlfZyBqoGNM8ddulr+WbgdDiwNsnOXIaWUH86wr4n6ckZnuKdWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia58ddQfrcc1j97nTPniCZQEvds7uXAs8Lkol0WWFIw=;
 b=LU/4RRd5iP0qJE051krotj/na/oKP933pdm75ZWPkqf95S9zwYrf8vVsf8+XfpxsS6Qn9sUtoUdu2prXzb4rQJ6Zy9nuCwYq4X/FXG21rBsmXzhhdUoGtw+q+fIohwgqK3NFucShoo0c0H4i1Z6BXqpeBrEpf75emxie1q+xRHU=
Received: from BN6PR22CA0028.namprd22.prod.outlook.com (2603:10b6:404:37::14)
 by BYAPR12MB3157.namprd12.prod.outlook.com (2603:10b6:a03:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 20:40:30 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::96) by BN6PR22CA0028.outlook.office365.com
 (2603:10b6:404:37::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Fri, 29 Oct 2021 20:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 20:40:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 15:40:29 -0500
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
Subject: [PATCH v6 1/2] ACPI: Add stubs for wakeup handler functions
Date:   Fri, 29 Oct 2021 15:40:16 -0500
Message-ID: <20211029204017.8223-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9dac8de-7ec2-4fdb-02d4-08d99b1c5920
X-MS-TrafficTypeDiagnostic: BYAPR12MB3157:
X-Microsoft-Antispam-PRVS: <BYAPR12MB315771B9E8145C822603A671E2879@BYAPR12MB3157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyHQgO5/NwnYpMArw0YNc6KwNl+zJBVsObyowOaEsJDwi2/u/ylLJyOwBQg4V2aeroYna8unmejUrAmRzJyDqM3HuV1u2VwqGgvvjOyJngCyftCRWF+FXxAxuevj6n7X3vVfjxAiXw8EoJlbbH2gtJpM0FCe60MX9IhDxvsmGAK0c1Vk0DgbW6fXCb72Fh0gV6e9bjttQPWO3t0uQseL3AYJqcUdGDqeiHz/sIEguMl+yNQf66AntLVPbmzgC6/0jXkXTrw1tqMM9mrwr/RT8cR5kI3MihGjyTLV2GrEE6e6Pk1y00G/42PzxZux9dmKf7tj9aN9TtbZ/MseFQrvzwdOxOyEHeC3qkNWip8tXwLQR5n/1yHOXNrP1Bpl2TqTq4IJH7k7ep+znJGINXkdjBT6nQIVLM/W3PBgz6OekSwjTf6vFc7kQTOY43BQlDJ38EoE/KkVv+N5VJ5e3u06u9wZ4Pb9rv2ohbR023WbSX8dmmRsmAd9TsBriHRz/q6dCET9Xo00Rjqv+KxCh2CO1KyhlPtBrHalKf8lfVCEInPp2FFWxiT8MfsfOFGkvdGKCZYOnIRXyKRSnEJjPrpjNzqsQyMD7TAQkjlFCEsdzx20qVupW0we4vCpTyzXrCEzNAURjRNwc4DQzSyeOLh3JuAkxpe4P5csSKEdE4m25Mc1UfbVYhzWArFUuHv/YvSTzxQ7YBKokFN+m65BnRtELNCoyy5a9+Ae6IWz6h/W9H8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6636002)(70586007)(356005)(8936002)(36860700001)(8676002)(47076005)(83380400001)(44832011)(86362001)(82310400003)(70206006)(26005)(7696005)(2906002)(36756003)(4326008)(6666004)(316002)(16526019)(1076003)(5660300002)(2616005)(186003)(110136005)(336012)(508600001)(54906003)(81166007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 20:40:30.5855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dac8de-7ec2-4fdb-02d4-08d99b1c5920
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3157
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

