Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86943E41C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 16:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhJ1OtC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 10:49:02 -0400
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:55827
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231337AbhJ1OtB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 28 Oct 2021 10:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8dmQkd8R4h4dazfkamLv33XvHjM94U4AETRtAr+2ZqaSrDapS6zZxYO+SDUfuqcN2Kl60vtSZbJomhkd2usySFKVEFnq3mHCoa+bdjDLvGY9aeD53sLJDisXWR69JaFVFgeeB+55ZmFsVflrfnwp8ZCrVCdQri7mIj/yG+1D9ujUJEJaozEWZe8x2FLJ500YVa/yjgyrWVy5R1Zbu4ffzNh3AGbV0YQ6jlTkA29N5Bub0b5wnWxZSVZ7IKEDITjTgTfYT3hzwZhhGTD0zhi0jGtXKC3zscEz7vt5ie9O7f7HFFWN0iyug1qzIcpFxCL4b8xgdmoBdcpZDxLvB7APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+5wrnvK2ouFcpV5tlDJyfkhkxIlRI+Q+KFHrjYzr7Y=;
 b=FiK5loWeeZ/M43ErbUMUjoQBko4Hl1I0hJIl+jO5wVAPau+tKymn/cl8T0e+sWrS2qamJi6Rn4h6WF38u/ujd8Et0eJb0ndlE2pmaPokEhg4Fbd/lZ0wa1g7N3x8Czlv/qekIffAX2+BmsXhG0Pxi4mtBjDzIewEqwb84QXbyL1tAVtIgsv6xkApwT87KK+JgaaOcmjXpyZxkd9qDcyjAsD+vR3P5aIGciY+CJtEZq2y3SR5kHmqZcPnd6S/rlHzOPY9LI9FpU2oydY+tyDnTy+lYplpIMECRCBYbHNlQXY2mKPknq7Gp955zjWOF62PisGy7niwEpPVfFjmZCb+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+5wrnvK2ouFcpV5tlDJyfkhkxIlRI+Q+KFHrjYzr7Y=;
 b=ISeZ2PMVxWuUmAyLSPaEi/WmTztIHzOC7SEDO+MNnkREu+Y0YO51qAjcx1Dpo41Texz+7IrdQ1DPABoZZqyFz+az5spPloeIbRE1uVopfOzllPrIM58AQgCRTYsuqJFVqD2t1YNuubNmD0ir60iSKbQn7TkpsmXaJ95bhIRCCLk=
Received: from DM6PR02CA0116.namprd02.prod.outlook.com (2603:10b6:5:1b4::18)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 14:46:32 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::2f) by DM6PR02CA0116.outlook.office365.com
 (2603:10b6:5:1b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 14:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 14:46:32 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 09:46:28 -0500
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
Subject: [PATCH v5 2/2] pinctrl: amd: Fix wakeups when IRQ is shared with SCI
Date:   Thu, 28 Oct 2021 09:45:41 -0500
Message-ID: <20211028144541.12617-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028144541.12617-1-mario.limonciello@amd.com>
References: <20211028144541.12617-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9190ba11-f0fc-413d-c345-08d99a21bbbc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5228:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52286896B9063CC1885C51F1E2869@BN9PR12MB5228.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVoBuArax5nKH3lIfa8IUeqmxSWUXhvHOoKyAf8pZ9tvGKmIOgX9TYc+N+70llz7HS6m5+cK2vq4JtyMOyWY26Ms2ddQoxuVdSC0k8DcKKxiDiXqGEs3iSBT6rZmctuIUSHR35B+AB5yOJf9Dybnag7n2b43EotUUT72BTazLmaspHDVZ5J5/ddet5zYer9LG0qZBr2VdtYOjXdON6gc06dwk2nq7X0nwlK4l2TIdtEcgqqjzfhY3rIv1dOva2MtY2pG37gPh2e8woxeMyLeRqrw2GDEpdwbNINcT17m/jooVamE7eGVwsDPwXBD4zNXJTGOBXDURQnUPOcy+83zT33xsX5QiL90gHOJmq6Ni+dvfA3M7ZxznpZ9Hx82lQE2pxT/U4CnwqGnjcQftK2ethlrTOEOTIw+0yo5TuLmTF3lLc2b+EPV/Y2hilKFiNnsXn4hOPik98TX8DdZeNORzxF8n07jtBAZjw82C06x7Wy3P03GMVAZvFnFdFKEKAZM9JlsZKXSYr4r8M5fpbCc8c6SfLGVHB94Y8hwt6CjrXhDhsaLF78xNeSNJLraFzPXy7osEU5HT1YGJTLK7abzOKWXhpjhxN2W2Q52U9VVGNSfoKiqgpeyK+U8e0WdCngC6Sym9ucR9s4zxjPndwHUerGZObEplHYr+wiLqB6eBt+aDtDViMudfrAye+NsWcxE5oIa+gBHNDograkYotjRciYeq62J7ci+CQYLQIMFJlE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(86362001)(83380400001)(2906002)(966005)(44832011)(82310400003)(8936002)(8676002)(5660300002)(316002)(186003)(16526019)(1076003)(7696005)(70586007)(2616005)(70206006)(336012)(356005)(26005)(36756003)(6636002)(426003)(54906003)(81166007)(110136005)(4326008)(508600001)(47076005)(36860700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 14:46:32.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9190ba11-f0fc-413d-c345-08d99a21bbbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
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
---
Note:
 This is *possibly* a fix from fdde0ff8590b, 56b991849009 or other
 changes in the acpi_s2idle_wake handling, but AMD didn't support
 s2idle across the kernel widely until 5.14 or later. This is the
 reason for lack of a fixes tag.
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
index d19974aceb2e..83fbcdad0904 100644
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
+					regs + i - ((u32 __iomem *)gpio_dev->base), regval);
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

