Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428DB43E419
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhJ1Os6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 10:48:58 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com ([40.107.94.66]:46688
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231132AbhJ1Os6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Oct 2021 10:48:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0m4cI63hApUN098ldJXWzDcpbrvMxGiLcCbzBB9n9wtWWeL3wWww/V9v0DZKfntsIXwxDdXQoIum5qMyx7T9TOPaErNOPpTnUDZ3WAjyzXRWAA3wZ8eY49seVFkw7MiXPp7+dh8pKlkCOSfEVoDgmWvI7QRISzeCM+arv2ZU4f1xoDvPEK5cOYOkCIAL6igHcHqV4appvxl1qyCl9C6Ru3xPWdTuDc5Ood4SakMKYdRJl8tdKkDoaJROwDkprtJt7rNiFTVOdMIneLkWx8EmPJ99X6NsOCRYu39yc3VL1Z8kZpdAtGdDVNJz2cRtZdDY+rJT+o4lgAL515kqrWmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3+fbLTMKIXLPqEhilPADCAnB8ufxCqSvRSA5Vsy/M4=;
 b=QQW7VH7ucIoFRiHBWxEkXtIhcHj8cb5xUxYh1enPiYCnCckKC5caGAW1u5sNzwZ+d1je9SkfW8XjsuNQHEWw/mVKjdbopAOdJuz4SuvsMMrsU1Bsu995lo7kFD8qAVyXHNxo629hfUPr81i/zQ1kB1rdQfbF2ZhAB+EMwNrTvzJJ1dPvHxguOxRZmOrETweK4kfo9Ify0vE6GHOoF/m6hOUDMQl0JVyRdUxhpckaiWsGvwN+NLeBJGvbDjgtFepimf5DIrTeTY+jfffe7oknfiUZTKkUafLkHL2ZB8dLqL9qqSNBcW8yjOGlEKfP8g7DPFogpeV7/UNjrEfHh3dy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3+fbLTMKIXLPqEhilPADCAnB8ufxCqSvRSA5Vsy/M4=;
 b=t8AMPLdgGipbSLwmTIGjqwOLrSY1txyqv6oHngacCzXhJYi99BSyuJCtZzD+BvmV6Wz/wDesnhTOnR0HSdInkJnA1u4WVTqJnPeqHI4tpSJJnss3lN/o7Ef/QmO00TZptLWPgWQHIpc2V48SlSPWbEVFM99M7JYhAwK1i/nOmqU=
Received: from DS7PR03CA0185.namprd03.prod.outlook.com (2603:10b6:5:3b6::10)
 by CH2PR12MB3862.namprd12.prod.outlook.com (2603:10b6:610:21::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 14:46:28 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::4b) by DS7PR03CA0185.outlook.office365.com
 (2603:10b6:5:3b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 14:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 14:46:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 09:46:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 1/2] ACPI: Add stubs for wakeup handler functions
Date:   Thu, 28 Oct 2021 09:45:40 -0500
Message-ID: <20211028144541.12617-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b2c401b-9fd6-401c-4079-08d99a21b976
X-MS-TrafficTypeDiagnostic: CH2PR12MB3862:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3862B82E7C5A28E1D734F5DAE2869@CH2PR12MB3862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmUg/vtEM6McJwSz6pD8FOs6CXEpFJMZqEukJwDhRTAyO5TQ5qgWd/MfrbX9pzCyKUBmmnbM7zTZa9r+4cnzIAiFtJML1R0oGVWeQ5EK5YVh5xZ56mGf0cbPzVK4KFttomm+KaoSbwIq3ybqqmDYrC0qb296ZjTWny1RXyjYp3SKvbW876O56sfXPBdYN+rllvkmhUEHaWjzMjFgBMXjOiMFxfwcI3Oh2kGYfPaa3h+CEBFbCD2dMy5DQ594k9TL3GpVHERNRDUDuDNzkSAUtGfzloO9dbbDx1gHBuNpd2oIQl31yxidVOCVaydGuLVUHC3xmChD5gB4k2NWwE2eG4JDMW7Zxq4X8RTBb3JG0ouxvOz+rwWgATqDUJdQq0e4pGDnj7uWSRvODWxUQeyMHd0IrE7hRrQgFgJI00Wx09y7VVrT8c22rSd6UUSSyLixLSzF1P7ToyaocPdKOgjnhtpSFSJ3T6iHqL12VgfXRxq++A1+WYXLILhvvlffYINbjpN+E+RMcQjAPWJaMlD/rmJTrnwg1ssxVdwLWL0xzpEt3g22ahbkZZyEPsxp7JfNdhuGHr84biGhyojfO9aGHiMcAXmK9Rx3Xr/HzkuQqLT6GzqQm98wvh8beni/gefy72GgCB4IVCi9gcZQ1NJjgKJjMSSfwseDI7Mt7CwbEFMdpsIt5QtA1J/r66QKLushf2SWOh+2A2j8X90R9ISJ+qL88FMYF4F7p2NSg8IO+Sc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(2616005)(508600001)(426003)(26005)(2906002)(4326008)(7696005)(70206006)(86362001)(5660300002)(316002)(110136005)(44832011)(8936002)(16526019)(6666004)(186003)(47076005)(54906003)(356005)(1076003)(83380400001)(6636002)(70586007)(82310400003)(336012)(8676002)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 14:46:28.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2c401b-9fd6-401c-4079-08d99a21b976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3862
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
added new functions for drivers to use during the s2idle wakeup path, but
didn't add stubs for when CONFIG_ACPI wasn't set.

Add those stubs in for other drivers to be able to use.

Cc: stable@kernel.org
Fixes: ddfd9dcf270c ("ACPI: PM: Add acpi_[un]register_wakeup_handler()")
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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

