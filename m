Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1A440441
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 22:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJ2UnD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 16:43:03 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:50723
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230253AbhJ2UnC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 16:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjS/T6Qa1Q9Af0vjqB6YxPl/r6QAVVBQL4ynKJttV+w7y2yFmVITFH7bIA5hadblyzAxjWDy6tS5ZdTT1tA5KK7zbELcPIC24BCj+D1jR3yqZW9EQPZfeTcXgQZpX2jHvUN0hHWuEOmRiNSPSyklR9K5buaNNyQl+LNASGtYNSfLxya2JKXzenzR+QU1HSj1EKnHzHVpa6JnQsAGrpyh1f92/xKx2OwzP217GY9xUaFQ6eWzSzKVOqs70bGUStQzhvuOq+of6jJnOJtJvkj7rdjcC0esPC1+5Qtck7uDT48tYfg7nE9blT0ObqInlvTJQAELFa8KmtWNGXHS3kK/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr3SXXL8vhvhl9VPx/OMsNpp+ZzGewfqAp6ducxaWYA=;
 b=BqfEeajWO4NdpOWS5JBevHPMa7gZrMv+KoLGjVB7BtuhoKZxncHRl28R2qCiN0/fw01dOFm9XkXDhJOGmCRL9fekoKhoWgA/QVjYE/+MrwYSd9o1w8dJsCWfsoywWpOcm6oJFjEsw+Vi+wchujTr2NR/A6MUn9ZUZX8Z+tSJBov72fMGCqEK3FhroF8OcAnQxB6tvSye/1Ly4muhjAxYCpAblDNFs1mtG/1WoVBusYaODudkBL21sEOtQu9+6VwpUOeOSkwAUjJnyf5gY6hIYMKWiJ399RD5wSYc4iw9aCxFTq2qznadmu3Uq3AH9LhPFPAVtxQZWGFPOKoCpSXr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr3SXXL8vhvhl9VPx/OMsNpp+ZzGewfqAp6ducxaWYA=;
 b=O0NWCrW7qgLSeLDEoQV1NYNVgEw/P7ge57upOPbgT9skIFxDMeemzcl5/fh1pmW/oTieyHIJ0SQBi7ecYB+Ql9fEHmX/Y6B92FOW7pl2qu3d48EoUKoCj2WhB87Fou+6ALHroaFb2P5m2p9D4EGK/6nCh0KMGPUbd9R3GPZVfYk=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 20:40:31 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::3a) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17 via Frontend
 Transport; Fri, 29 Oct 2021 20:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 20:40:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 29 Oct
 2021 15:40:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <stable@kernel.org>, Joerie de Gram <j.de.gram@gmail.com>
Subject: [PATCH v6 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with SCI
Date:   Fri, 29 Oct 2021 15:40:17 -0500
Message-ID: <20211029204017.8223-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211029204017.8223-1-mario.limonciello@amd.com>
References: <20211029204017.8223-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72602cdc-67f5-46e7-46a6-08d99b1c59da
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:
X-Microsoft-Antispam-PRVS: <CH2PR12MB405550F5ACF3D0E8B224E427E2879@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8U0kZZu8YQAu9S6ILFK2eUVftkO6RIyfHAbOC9SGpyrtgWmshlqWVr28Xlq0xnQoqwao/M9WJJ1lse5IO0xo3kz44AH12g2vN/M8ZpsLEUXF3fYYNV9yQZ2a9PMOmXRIn9jzhmeEi1q/S11F//yoGW7zKXRNddK+5MTnZXhzDxUXJqcNmoNr2S8lR7Kr0f/jX5o4KrXky9c8gd+jgeGQpZeh4lbTBd5zEhnM0JqbXz6ZbKf2lswov3X2AuX+UyKBXWyL629bqhkhs/+ACr+4xbHl1wmbRVp+HJGhdwJilqt3HEg12xbHEvzO7FlYxsTBsc5smsIJjtYU+vOcBBzwcqCp1gtGnT6ooQbyRfO4BprWerOODM3ISZj6RKyb7VtMXBNJAWiLaMC5a48ZRCXkxV1UB5UIpNRggz+p2aEmaPJOuKy2jzhkrN8GiLHSRzLb2CmIVR6WRAPZJE77ZHM8cAFWKcHXaX0ixG5j0pxOlfFo/Rl6IBuTdFTKut9bOB9RkY4eB2W4P52hkPtqQEKhhTvlnIfYrC+Q9/JLPiRPt7hbJifLs4uwBnS/qlOVXC0WR9z+/qDvgIFD3m5P400r6o0dPoIRoiSGcLja1Wb5yzuSiYLzVPt3i5QaECMvYYE3glI1Ktijcr0PZefMmBOMhNV6ohn8GaB9NSUx4o+3w0r69Qwb0gqSb0Q9+79ve3MptUIKZs90SUtpHuqrSNNWUvBm8zC+fL98Kd761FADnR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(356005)(110136005)(26005)(16526019)(54906003)(70586007)(81166007)(70206006)(7696005)(6666004)(86362001)(6636002)(83380400001)(82310400003)(44832011)(508600001)(4326008)(426003)(966005)(36756003)(316002)(47076005)(336012)(2616005)(186003)(5660300002)(8676002)(36860700001)(1076003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 20:40:31.8052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72602cdc-67f5-46e7-46a6-08d99b1c59da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some Lenovo AMD Gen2 platforms the IRQ for the SCI and pinctrl drivers
are shared.  Due to how the s2idle loop handling works, this case needs
an extra explicit check whether the interrupt was caused by SCI or by
the GPIO controller.

To fix this rework the existing IRQ handler function to function as a
checker and an IRQ handler depending on the calling arguments.

Cc: stable@kernel.org
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1738
Reported-by: Joerie de Gram <j.de.gram@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
Note:
 This is *possibly* a fix from fdde0ff8590b, 56b991849009 or other
 changes in the acpi_s2idle_wake handling, but AMD didn't support
 s2idle across the kernel widely until 5.14 or later. This is the
 reason for lack of a fixes tag.
Changes from v5->v6:
 * Add a cast to debugging statement for an error caught by 0-day CI.
 * Add Basavaraj's tag
Changes from v4->v5:
 * Correct debugging statement that was obfuscated by kernel %p behavior.
 * Instead show actual GPIO number, which is much more useful for debugging
 * Target to stable as well
Changes from v3->v4:
 * Adjust to reverse xmas for newly added variable
 * Add a debugging line to show the values in the register that caused system
   wake to allow for debugging of spurious wakeups
Changes from v2->v3:
 * Add new precursor patch for fixing missing ACPI function stubs
 * Add __maybe_unused for unused function when set with COMPILE_TEST
Changes from v1->v2:
 * drop Kconfig changes to drop COMPILE_TEST, instead #ifdef CONFIG_ACPI
 * fix a logic error during wakeup
 * Use IRQ_RETVAL()
 drivers/pinctrl/pinctrl-amd.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index d19974aceb2e..c750ffd5c012 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -598,14 +598,14 @@ static struct irq_chip amd_gpio_irqchip = {
 
 #define PIN_IRQ_PENDING	(BIT(INTERRUPT_STS_OFF) | BIT(WAKE_STS_OFF))
 
-static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
+static bool _amd_gpio_irq_handler(int irq, void *dev_id)
 {
 	struct amd_gpio *gpio_dev = dev_id;
 	struct gpio_chip *gc = &gpio_dev->gc;
-	irqreturn_t ret = IRQ_NONE;
 	unsigned int i, irqnr;
 	unsigned long flags;
 	u32 __iomem *regs;
+	bool ret = false;
 	u32  regval;
 	u64 status, mask;
 
@@ -627,6 +627,16 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 		/* Each status bit covers four pins */
 		for (i = 0; i < 4; i++) {
 			regval = readl(regs + i);
+			/* called from resume context on a shared IRQ, just
+			 * checking wake source.
+			 */
+			if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
+				dev_dbg(&gpio_dev->pdev->dev,
+					"Waking due to GPIO %ld: 0x%x",
+					(long)(regs + i - ((u32 __iomem *)gpio_dev->base)), regval);
+				return true;
+			}
+
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
@@ -652,9 +662,12 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 			}
 			writel(regval, regs + i);
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-			ret = IRQ_HANDLED;
+			ret = true;
 		}
 	}
+	/* called from resume context on shared IRQ but didn't cause wake */
+	if (irq < 0)
+		return false;
 
 	/* Signal EOI to the GPIO unit */
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
@@ -666,6 +679,16 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
+static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
+{
+	return IRQ_RETVAL(_amd_gpio_irq_handler(irq, dev_id));
+}
+
+static bool __maybe_unused amd_gpio_check_wake(void *dev_id)
+{
+	return _amd_gpio_irq_handler(-1, dev_id);
+}
+
 static int amd_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct amd_gpio *gpio_dev = pinctrl_dev_get_drvdata(pctldev);
@@ -1004,6 +1027,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		goto out2;
 
 	platform_set_drvdata(pdev, gpio_dev);
+	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
 
 	dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
 	return ret;
@@ -1021,6 +1045,7 @@ static int amd_gpio_remove(struct platform_device *pdev)
 	gpio_dev = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&gpio_dev->gc);
+	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
 
 	return 0;
 }
-- 
2.25.1

