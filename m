Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97943B7FB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhJZRQT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 13:16:19 -0400
Received: from mail-bn1nam07on2080.outbound.protection.outlook.com ([40.107.212.80]:36283
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236498AbhJZRQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 13:16:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEnxgrtZfrEb28uVAFbytEa2dtBFPxXDx3q534Y3dg59tunzI+BJEL1p8+zVCkSmgUBR2QISN+B6SvG6lGC/HcIy0k9cT9jAjHT2IL4twYSgEwasZPcmu0aSHWmPRmbafHuRhzsWco+OpF+egb65ecsWm+jifcgr6+078EV2kkrttFkbzr90GFfqvvTXRgqy22FQO3XZP9nc2cN6NvC5AbZl6FAXMKY6G5T8yeBK0e4iuFuQk1KxDBkAowird8fjEYzFwRnQbHuqN/rM/umDbm3ipCZ0bsHVMxKDFAP0JoC3+sW4UZpHzZxUaA0IiWdxyDuBscTpQb0ly4IkzBfm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OQ/bJZcqK2yPJv1amDsFSzdXLGa1Vx+yU8BFPZkchA=;
 b=cbEaoGUogpLyvlMSxP01CesAj3ZNqh3pBxo8hmJWEPAnuLf6VRb26UU9H+Q5lB3zHtikoTNbGH3ZLcMhr+6wuK3SDqRFWnmCiRiQVOHW4Ku0zfnlK5FwIFDNoM273GsxjPyvNhEEVbLwzSUmnZXvYQ38NjwcGQ1+A5JEvMtHoCR5PBUchG1c865RQazsh/f0jtn6EMKxtV86LdpSh4Ihv38yNna1LYRIq8XTdbnnUKMVfdZyzfOXsURpDhwS0VKtjs+ckeyX4BrlcO2p50b5WxPthRX7O7cBcWhuDk5y2F6gBcfDfJ8ikkzA4b9bsNkgB6vTbsATqd+2N3O1S7QmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OQ/bJZcqK2yPJv1amDsFSzdXLGa1Vx+yU8BFPZkchA=;
 b=msbK+hYTCQceL7bI2k+8U15Qckv6kJD7KyyTywlv2L5IEQT3nYsb+D1i/0LuDagHreuGUzLnt1M6lr8Ft8jp91khzRUl8aavpSPZppvXaBC3YyltYfZpFOpuiPX1k2XBw/eoqKqJ6Sxavuj3sr4mi3SQeo6KtsZj9rqR5rmnn0s=
Received: from BN9P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::26)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 17:13:36 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::6) by BN9P222CA0021.outlook.office365.com
 (2603:10b6:408:10c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 17:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:13:35 +0000
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
        Mario Limonciello <mario.limonciello@amd.com>,
        Joerie de Gram <j.de.gram@gmail.com>
Subject: [PATCH v4 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with SCI
Date:   Tue, 26 Oct 2021 12:13:13 -0500
Message-ID: <20211026171313.50-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026171313.50-1-mario.limonciello@amd.com>
References: <20211026171313.50-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2676d792-a936-4b49-88a5-08d998a3f204
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:
X-Microsoft-Antispam-PRVS: <MN2PR12MB422205F066110EE0048C0116E2849@MN2PR12MB4222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/LgYrKXiRGpgLaLZphRMSPpMKKwt9L+i7TNUx7Zjdi5OHHKrKoU5OmsoUjK6Ljqb9rexbi+2ssxD1nfirWV+eUd3XoFvmxOnIQ416kT+thBGTQnB/mZts8gE4vPbbpAFRu39o4KLYcX5yIyRO1AknT9gP22juCLgztyq0TLbfpmrY9EBqwocJ7Qea05Vqtu8Yk4hX1lFp9gHnkzRvIYivrK/rTrzAeJt5/4gjmhQHGCCoiIebHQ3HVNo3Z+117xvfI7gFW5hQeoeoqvZtn9ybfofh4k9hCsuehfdOJHxKRmRyjDXeRCP1kaOWimLFRROCFD0vOzVETAkcaaLgJVORH/ccdehkXdbmwMNwUN7nDL8Wp0Bx2giObwT4GfgftzDfSwWaGiogk007EbrLOipSrCNxWOqGcqKOaZgQwIBFfRfOMVb6z3kVLmTBiuK9TKhRF1mW2b/4DQf5FSoTA2dAAtWJ6LukCs5b3tLITejQUnVcIy55NI2u0Qg3M2YhlEKSVIGXHF658j16K5MiJBwFeG/uu/dfBd3Dlfda1NExkIhXkIAQ+Pk072XRdhQylLBYGSlrnwowuelZL3W4Wxc73cuoAnqSQ8Lzm/hOaLtO50Dz1Qo+lQ71c/+AvbrkH6EgTr43TBz2UuXZ8sb2ee/A/FjzUCN2fP531LZCa7j1ZknUkPgrB1IblIsgiIOiF9F9/mJMqb+iAmk0Yxsf6nh/myRsWT+w6x4ymcH8zJkKg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(966005)(4326008)(36756003)(6666004)(336012)(8676002)(8936002)(81166007)(2616005)(7696005)(5660300002)(6636002)(2906002)(356005)(426003)(83380400001)(1076003)(44832011)(70206006)(82310400003)(186003)(47076005)(54906003)(110136005)(86362001)(26005)(16526019)(316002)(70586007)(36860700001)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:13:35.6680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2676d792-a936-4b49-88a5-08d998a3f204
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some Lenovo AMD Gen2 platforms the IRQ for the SCI and pinctrl drivers
are shared.  Due to how the s2idle loop handling works, this case needs
an extra explicit check whether the interrupt was caused by SCI or by
the GPIO controller.

To fix this rework the existing IRQ handler function to function as a
checker and an IRQ handler depending on the calling arguments.

BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1738
Reported-by: Joerie de Gram <j.de.gram@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Note:
 This is *possibly* a fix from fdde0ff8590b, 56b991849009 or other
 changes in the acpi_s2idle_wake handling, but AMD didn't support
 s2idle across the kernel widely until 5.14 or later. This is the
 reason for lack of a fixes tag.
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
index d19974aceb2e..f15d6435a4c9 100644
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
+					"Waking due to GPIO register 0x%p: 0x%x",
+					regs + i, regval);
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

