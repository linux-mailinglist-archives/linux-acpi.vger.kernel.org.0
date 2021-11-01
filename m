Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682304411EA
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 02:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhKABvi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Oct 2021 21:51:38 -0400
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73]:14848
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230460AbhKABvd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 31 Oct 2021 21:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyWpsamNA0FB7T+ieUZkwJviJTfoqBG/HBb+b3rvFL9Cv0/RZxtndLgmwrmPkAu+lmpwi8NrEQCx0AzDvC1M8SvtibadACT08uuoqwWrmyFK0qSiY9S4O/TKcbVJqcdkqMmO2cczzTS93R0cob+7Fv5oXXGeQAOi2FM6gVgAARgqj+V1itsqO8117KRoQNV7Az9pXq0XiaAae25gn0hVJqnXsf91xqhmD9JLu+FvVFJ4/yT8pzreCszwfBbCHnhQ8+N+6bWDJGlKRuD7rjacJlXXH3dx0HLjfxEsoft5sh9nQ2uQWdmV0iBJkjJnNmOERTQ90Z9Mt8dvrH/qnJnuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrT9X8HO2PEvzQ5fWJtowJynMMlEZECB4y+QGa6cWks=;
 b=Xt63eqp+WUzUVbIG6M+ixIfKWJOvKvDb4Rj5XydfR0hXvmsWdRtpw+bHE/vDhvPXF6nQ7sxtCJPGTJk9cndUK7YzXC+1L//4W5GtkWCxVn1BnGCpF/rOIJmfvG2Ua+pGLGqVCUMSetJHgzXUayK+D15Zr3pHc6z3VqIORUk75fOfvAZAxWQsr73sPeGkMSf4fMN+x+4oneeubRn3fMkbNpCf61Z6DZaUZW5T6xoGzVzyRk7mdQkbCuYf2OvlxusncV+vsrREdD3+qqmDV2No7O/nO3CCnVzXwRMPvVsAmEJe96hySRs7VxeKVpcblr/mSdxV2BDdycd8WnVNdlUGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrT9X8HO2PEvzQ5fWJtowJynMMlEZECB4y+QGa6cWks=;
 b=CVrlss75sAvb9SIBUr1DcSsjoCszTPwOS+hA154/+R1QDTjS0VGvXnKrTqMnd6veaobZb5ucEODbI6mA1bhsGFtPyugF/rM1QhDjKVGRWxx1maVVZf+SrwItybgB7s4DFzQxgqblbL1fDStzCQuMdadryuab06XlGQdmYw1MJ9Y=
Received: from DS7PR03CA0306.namprd03.prod.outlook.com (2603:10b6:8:2b::14) by
 MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Mon, 1 Nov 2021 01:48:57 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ce) by DS7PR03CA0306.outlook.office365.com
 (2603:10b6:8:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Mon, 1 Nov 2021 01:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 01:48:57 +0000
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
        Joerie de Gram <j.de.gram@gmail.com>
Subject: [PATCH v7 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with SCI
Date:   Sun, 31 Oct 2021 20:48:53 -0500
Message-ID: <20211101014853.6177-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211101014853.6177-1-mario.limonciello@amd.com>
References: <20211101014853.6177-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fe9dee-0a6d-4534-c2df-08d99cd9c4d9
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912E3DD6BAD30987284F9E8E28A9@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDko4nPwbUerF9EXny1+Oe2NFTOnzrowbSZf/3WCO4WY4p0JfgPhwbk7adGHtx3/ULxqYj6F83hcLQmwpexCieMWbge5+Hky7vjZU1U6LF1uZqzBY4+pdxeIgbo4xpWQNcKrkCVNgcBfZvyOpRtnDvmPgt80lNtteIvyj1bmZBu4u9k/Go0UWz+4i6749RqRDDQRscm5nAc96KDQbekDx7oKtGsUMRm8xbiilCrDxm/QjDMuGD4H4ghAhTf2sHHQqAq3IKcuYvOVkRj5n8NWcuFeo6PnayB1gynb+KJ8mchXJn3ggzxu8/kF28M6A7wz/lUqAQuorNLokl7lR+eFksjyjNXxnqjyvhRn68mMldwSXcaWdDBiBA/7LZVr+UI7+8M/HmcRYDcISbn6jaN/SHN6dIq8uT9KxCKCnbHP2hy2fOieCIB6kGUqRDVu/64/dxmEkARWsPvwRMih9LkHcrx1VGWJPrRkrOqEI7wj4A+v09Rdw+C1w7ovWT1QcMUEnLmN+I5xQ1uN/jLQdi/D+GZ6darYKo/t01LAGM19tXcp+sean+rbDd/m5304HWMgcFC/X2BYQHB3Q2p2vPT1j0qoyAFLKLvzL2lrthrU23hHPs7CZz+lHnFBpKyXMRlVbHJ07Bjxdm1lWhOc59r5EqhRQ9vNqDaWpCoLPEGsuVckiGObtVuSYBU2CaLWf5/eKV8Mns65KS/RTY2Ic4oUUPTDGikuU9yUzrPf8NPUGw4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(16526019)(5660300002)(70586007)(36860700001)(4326008)(316002)(70206006)(83380400001)(6636002)(426003)(26005)(336012)(1076003)(2906002)(54906003)(186003)(8936002)(7696005)(508600001)(82310400003)(110136005)(86362001)(36756003)(356005)(44832011)(81166007)(966005)(47076005)(2616005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 01:48:57.3218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fe9dee-0a6d-4534-c2df-08d99cd9c4d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
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
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
Note:
 This is *possibly* a fix from fdde0ff8590b, 56b991849009 or other
 changes in the acpi_s2idle_wake handling, but AMD didn't support
 s2idle across the kernel widely until 5.14 or later. This is the
 reason for lack of a fixes tag.
Changes from v6->v7:
 * Address comments from Andy S.
   - Rename function to not have _ for prefix (use do_ instead)
   - shorten new comments to be a single line
   - For debugging statement use `irqnr + i` instead of casting.
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
 drivers/pinctrl/pinctrl-amd.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index d19974aceb2e..112e5eb6d03f 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -598,14 +598,14 @@ static struct irq_chip amd_gpio_irqchip = {
 
 #define PIN_IRQ_PENDING	(BIT(INTERRUPT_STS_OFF) | BIT(WAKE_STS_OFF))
 
-static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
+static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
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
 
@@ -627,6 +627,14 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 		/* Each status bit covers four pins */
 		for (i = 0; i < 4; i++) {
 			regval = readl(regs + i);
+			/* caused wake on resume context for shared IRQ */
+			if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
+				dev_dbg(&gpio_dev->pdev->dev,
+					"Waking due to GPIO %d: 0x%x",
+					irqnr + i, regval);
+				return true;
+			}
+
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
@@ -652,9 +660,12 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 			}
 			writel(regval, regs + i);
 			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
-			ret = IRQ_HANDLED;
+			ret = true;
 		}
 	}
+	/* did not cause wake on resume context for shared IRQ */
+	if (irq < 0)
+		return false;
 
 	/* Signal EOI to the GPIO unit */
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
@@ -666,6 +677,16 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
+static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
+{
+	return IRQ_RETVAL(do_amd_gpio_irq_handler(irq, dev_id));
+}
+
+static bool __maybe_unused amd_gpio_check_wake(void *dev_id)
+{
+	return do_amd_gpio_irq_handler(-1, dev_id);
+}
+
 static int amd_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct amd_gpio *gpio_dev = pinctrl_dev_get_drvdata(pctldev);
@@ -1004,6 +1025,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		goto out2;
 
 	platform_set_drvdata(pdev, gpio_dev);
+	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
 
 	dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
 	return ret;
@@ -1021,6 +1043,7 @@ static int amd_gpio_remove(struct platform_device *pdev)
 	gpio_dev = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&gpio_dev->gc);
+	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
 
 	return 0;
 }
-- 
2.25.1

