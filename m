Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356305ABE0D
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiICJgW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiICJgC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 05:36:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B9BA2F384;
        Sat,  3 Sep 2022 02:35:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkODtHxNjJWgQAA--.4203S3;
        Sat, 03 Sep 2022 17:35:44 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/7] rtc: ls2x: Add support for the Loongson-2K/LS7A RTC
Date:   Sat,  3 Sep 2022 17:34:53 +0800
Message-Id: <d9f4afa882f470f049c928435f6350ee41515725.1662190009.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1662190009.git.zhoubinbin@loongson.cn>
References: <cover.1662190009.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxkODtHxNjJWgQAA--.4203S3
X-Coremail-Antispam: 1UD129KBjvAXoW3uF1xCFWDAFy8uw1fXF13Jwb_yoW8JF43Xo
        WxW3ZIgw18Ka1jgFWakr4UtF47Zr95W3WUGa4fXrWvvayj93WDKr43u3y5X3W0qw4FgF4x
        ZrykKwnrZF4vqFsxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOF7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M28IrcIa0x
        kI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
        jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JUx8nOUUUUU=
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This RTC module is integrated into the Loongson-2K SoC and the LS7A
bridge chip. This version is almost entirely rewritten to make use of
current kernel API, and it supports both ACPI and DT.

Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: loongarch@lists.linux.dev
---
 drivers/rtc/Kconfig    |  11 ++
 drivers/rtc/Makefile   |   1 +
 drivers/rtc/rtc-ls2x.c | 366 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 378 insertions(+)
 create mode 100644 drivers/rtc/rtc-ls2x.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b8de25118ad0..7ec64306ab70 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1338,6 +1338,17 @@ config RTC_DRV_NTXEC
 	  embedded controller found in certain e-book readers designed by the
 	  original design manufacturer Netronix.
 
+config RTC_DRV_LS2X
+	tristate "Loongson LS2X RTC"
+	depends on (ACPI || OF) && MACH_LOONGSON64 || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  If you say yes here you get support for the RTC on the Loongson-2K
+	  SoC and LS7A bridge, which first appeared on the Loongson-2H.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ls2x.
+
 comment "on-CPU RTC drivers"
 
 config RTC_DRV_ASM9260
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index aab22bc63432..d5a467e9eec8 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_RTC_DRV_LOONGSON1)	+= rtc-ls1x.o
 obj-$(CONFIG_RTC_DRV_LP8788)	+= rtc-lp8788.o
 obj-$(CONFIG_RTC_DRV_LPC24XX)	+= rtc-lpc24xx.o
 obj-$(CONFIG_RTC_DRV_LPC32XX)	+= rtc-lpc32xx.o
+obj-$(CONFIG_RTC_DRV_LS2X)	+= rtc-ls2x.o
 obj-$(CONFIG_RTC_DRV_M41T80)	+= rtc-m41t80.o
 obj-$(CONFIG_RTC_DRV_M41T93)	+= rtc-m41t93.o
 obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
diff --git a/drivers/rtc/rtc-ls2x.c b/drivers/rtc/rtc-ls2x.c
new file mode 100644
index 000000000000..816d1b5ade02
--- /dev/null
+++ b/drivers/rtc/rtc-ls2x.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson-2K/7A RTC driver
+ *
+ * Based on the original out-of-tree Loongson-2H RTC driver for Linux 2.6.32,
+ * by Shaozong Liu <liushaozong@loongson.cn>.
+ *
+ * Maintained out-of-tree by Huacai Chen <chenhuacai@kernel.org>.
+ *
+ * Rewritten for mainline by WANG Xuerui <git@xen0n.name>.
+ */
+
+#include <linux/of.h>
+#include <linux/rtc.h>
+#include <linux/acpi.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/bitfield.h>
+#include <linux/platform_device.h>
+
+#define TOY_TRIM_REG	0x20
+#define TOY_WRITE0_REG	0x24
+#define TOY_WRITE1_REG	0x28
+#define TOY_READ0_REG	0x2c
+#define TOY_READ1_REG	0x30
+#define TOY_MATCH0_REG	0x34
+#define TOY_MATCH1_REG	0x38
+#define TOY_MATCH2_REG	0x3c
+#define RTC_CTRL_REG	0x40
+#define RTC_TRIM_REG	0x60
+#define RTC_WRITE0_REG	0x64
+#define RTC_READ0_REG	0x68
+#define RTC_MATCH0_REG	0x6c
+#define RTC_MATCH1_REG	0x70
+#define RTC_MATCH2_REG	0x74
+
+#define TOY_MON		GENMASK(31, 26)
+#define TOY_DAY		GENMASK(25, 21)
+#define TOY_HOUR	GENMASK(20, 16)
+#define TOY_MIN		GENMASK(15, 10)
+#define TOY_SEC		GENMASK(9, 4)
+#define TOY_MSEC	GENMASK(3, 0)
+
+#define TOY_MATCH_YEAR	GENMASK(31, 26)
+#define TOY_MATCH_MON	GENMASK(25, 22)
+#define TOY_MATCH_DAY	GENMASK(21, 17)
+#define TOY_MATCH_HOUR	GENMASK(16, 12)
+#define TOY_MATCH_MIN	GENMASK(11, 6)
+#define TOY_MATCH_SEC	GENMASK(5, 0)
+
+/* ACPI and RTC offset */
+#define ACPI_RTC_OFFSET		0x100
+
+/* support rtc wakeup */
+#define ACPI_PM1_STS_REG	0x0c
+#define ACPI_PM1_EN_REG		0x10
+#define RTC_EN			BIT(10)
+#define RTC_STS 		BIT(10)
+
+struct ls2x_rtc_priv {
+	int irq;
+	struct regmap *regmap;
+	spinlock_t rtc_reglock;
+	void __iomem *acpi_base;
+	struct rtc_device *rtcdev;
+};
+
+static const struct regmap_config ls2x_rtc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+struct ls2x_rtc_regs {
+	u32 reg0;
+	u32 reg1;
+};
+
+/* IRQ Handlers */
+static irqreturn_t ls2x_irq_handler(int irq, void *id)
+{
+	struct ls2x_rtc_priv *priv = (struct ls2x_rtc_priv *)id;
+
+	rtc_update_irq(priv->rtcdev, 1, RTC_AF | RTC_IRQF);
+
+	return IRQ_HANDLED;
+}
+
+#if defined(CONFIG_ACPI)
+static u32 ls2x_acpi_fix_handler(void *id)
+{
+	int ret;
+	struct ls2x_rtc_priv *priv = (struct ls2x_rtc_priv *)id;
+
+	spin_lock(&priv->rtc_reglock);
+
+	/* Disable acpi rtc enabled */
+	ret = readl(priv->acpi_base + ACPI_PM1_EN_REG) & ~RTC_EN;
+	writel(ret, priv->acpi_base + ACPI_PM1_EN_REG);
+
+	/* Clear acpi rtc interrupt Status */
+	writel(RTC_STS, priv->acpi_base + ACPI_PM1_STS_REG);
+
+	spin_unlock(&priv->rtc_reglock);
+
+	/*
+	 * The TOY_MATCH0_REG should be cleared 0 here,
+	 * otherwise the interrupt cannot be cleared.
+	 * Because the match condition is still satisfied
+	 */
+	ret = regmap_write(priv->regmap, TOY_MATCH0_REG, 0);
+	if (unlikely(ret))
+		return ret;
+
+	rtc_update_irq(priv->rtcdev, 1, RTC_AF | RTC_IRQF);
+
+	return 0;
+}
+#endif
+
+static inline void ls2x_rtc_regs_to_time(struct ls2x_rtc_regs *regs,
+					 struct rtc_time *tm)
+{
+	tm->tm_year = regs->reg1;
+	tm->tm_sec = FIELD_GET(TOY_SEC, regs->reg0);
+	tm->tm_min = FIELD_GET(TOY_MIN, regs->reg0);
+	tm->tm_hour = FIELD_GET(TOY_HOUR, regs->reg0);
+	tm->tm_mday = FIELD_GET(TOY_DAY, regs->reg0);
+	tm->tm_mon = FIELD_GET(TOY_MON, regs->reg0) - 1;
+}
+
+static inline void ls2x_rtc_time_to_regs(struct rtc_time *tm,
+					 struct ls2x_rtc_regs *regs)
+{
+	regs->reg0 = FIELD_PREP(TOY_SEC, tm->tm_sec);
+	regs->reg0 |= FIELD_PREP(TOY_MIN, tm->tm_min);
+	regs->reg0 |= FIELD_PREP(TOY_HOUR, tm->tm_hour);
+	regs->reg0 |= FIELD_PREP(TOY_DAY, tm->tm_mday);
+	regs->reg0 |= FIELD_PREP(TOY_MON, tm->tm_mon + 1);
+	regs->reg1 = tm->tm_year;
+}
+
+static inline void ls2x_rtc_alarm_regs_to_time(struct ls2x_rtc_regs *regs,
+					 struct rtc_time *tm)
+{
+	tm->tm_sec = FIELD_GET(TOY_MATCH_SEC, regs->reg0);
+	tm->tm_min = FIELD_GET(TOY_MATCH_MIN, regs->reg0);
+	tm->tm_hour = FIELD_GET(TOY_MATCH_HOUR, regs->reg0);
+	tm->tm_mday = FIELD_GET(TOY_MATCH_DAY, regs->reg0);
+	tm->tm_mon = FIELD_GET(TOY_MATCH_MON, regs->reg0) - 1;
+	/*
+	 * The rtc SYS_TOYMATCH0/YEAR bit field is only 6 bits,
+	 * so it means 63 years at most. Therefore, The RTC alarm
+	 * years can be set from 1900 to 1963.
+	 * This causes the initialization of alarm fail during
+	 * call __rtc_read_alarm. We add 80 years offset to
+	 * ls2x_rtc_read_alarm. After adding the offset,
+	 * the RTC alarm clock can be set from 1980 to 2043.
+	 */
+	tm->tm_year = FIELD_GET(TOY_MATCH_YEAR, regs->reg0) + 80;
+}
+
+static inline void ls2x_rtc_time_to_alarm_regs(struct rtc_time *tm,
+					 struct ls2x_rtc_regs *regs)
+{
+	regs->reg0 = FIELD_PREP(TOY_MATCH_SEC, tm->tm_sec);
+	regs->reg0 |= FIELD_PREP(TOY_MATCH_MIN, tm->tm_min);
+	regs->reg0 |= FIELD_PREP(TOY_MATCH_HOUR, tm->tm_hour);
+	regs->reg0 |= FIELD_PREP(TOY_MATCH_DAY, tm->tm_mday);
+	regs->reg0 |= FIELD_PREP(TOY_MATCH_MON, tm->tm_mon + 1);
+	regs->reg0 |= FIELD_PREP(TOY_MATCH_YEAR, tm->tm_year);
+}
+
+static int ls2x_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	int ret;
+	struct ls2x_rtc_regs regs;
+	struct ls2x_rtc_priv *priv = dev_get_drvdata(dev);
+
+	ret = regmap_read(priv->regmap, TOY_READ1_REG, &regs.reg1);
+	if (unlikely(ret))
+		return ret;
+
+	ret = regmap_read(priv->regmap, TOY_READ0_REG, &regs.reg0);
+	if (unlikely(ret))
+		return ret;
+
+	ls2x_rtc_regs_to_time(&regs, tm);
+
+	return 0;
+}
+
+static int ls2x_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	int ret;
+	struct ls2x_rtc_regs regs;
+	struct ls2x_rtc_priv *priv = dev_get_drvdata(dev);
+
+	ls2x_rtc_time_to_regs(tm, &regs);
+
+	ret = regmap_write(priv->regmap, TOY_WRITE0_REG, regs.reg0);
+	if (unlikely(ret))
+		return ret;
+
+	return regmap_write(priv->regmap, TOY_WRITE1_REG, regs.reg1);
+}
+
+static int ls2x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	int ret;
+	struct ls2x_rtc_regs regs;
+	struct ls2x_rtc_priv *priv = dev_get_drvdata(dev);
+
+	ret = regmap_read(priv->regmap, TOY_MATCH0_REG, &regs.reg0);
+	if (unlikely(ret))
+		return ret;
+
+	ls2x_rtc_alarm_regs_to_time(&regs, &alrm->time);
+
+#if defined(CONFIG_ACPI)
+	ret = readl(priv->acpi_base + ACPI_PM1_EN_REG);
+	alrm->enabled = !!(ret & RTC_EN);
+#endif
+
+	return 0;
+}
+
+static int ls2x_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+#if defined(CONFIG_ACPI)
+	u32 val;
+	struct ls2x_rtc_priv *priv = dev_get_drvdata(dev);
+
+	/* Enalbe ACPI rtc wakeup */
+	spin_lock(&priv->rtc_reglock);
+	val = readl(priv->acpi_base + ACPI_PM1_EN_REG);
+	if (enabled)
+		val |= RTC_EN;
+	else
+		val &= ~RTC_EN;
+
+	writel(val, priv->acpi_base + ACPI_PM1_EN_REG);
+	spin_unlock(&priv->rtc_reglock);
+#endif
+	return 0;
+}
+
+static int ls2x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	int ret;
+	struct ls2x_rtc_regs regs;
+	struct ls2x_rtc_priv *priv = dev_get_drvdata(dev);
+
+	ls2x_rtc_time_to_alarm_regs(&alrm->time, &regs);
+
+	ret = regmap_write(priv->regmap, TOY_MATCH0_REG, regs.reg0);
+	if (unlikely(ret))
+		return ret;
+
+	return ls2x_rtc_alarm_irq_enable(dev, alrm->enabled);
+}
+
+static struct rtc_class_ops ls2x_rtc_ops = {
+	.read_time = ls2x_rtc_read_time,
+	.set_time = ls2x_rtc_set_time,
+	.read_alarm = ls2x_rtc_read_alarm,
+	.set_alarm = ls2x_rtc_set_alarm,
+	.alarm_irq_enable = ls2x_rtc_alarm_irq_enable,
+};
+
+static int ls2x_rtc_probe(struct platform_device *pdev)
+{
+	int ret;
+	void __iomem *regs;
+	struct ls2x_rtc_priv *priv;
+	struct device *dev = &pdev->dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (unlikely(!priv))
+		return -ENOMEM;
+
+	spin_lock_init(&priv->rtc_reglock);
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0)
+		return priv->irq;
+
+	platform_set_drvdata(pdev, priv);
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->regmap = devm_regmap_init_mmio(dev, regs,
+					     &ls2x_rtc_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->rtcdev = devm_rtc_allocate_device(dev);
+	if (IS_ERR(priv->rtcdev))
+		return PTR_ERR(priv->rtcdev);
+
+	/* Due to hardware erratum, all years multiple of 4 are considered
+	 * leap year, so only years 2000 through 2099 are usable.
+	 *
+	 * Previous out-of-tree versions of this driver wrote tm_year directly
+	 * into the year register, so epoch 2000 must be used to preserve
+	 * semantics on shipped systems.
+	 */
+	priv->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	priv->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
+	priv->rtcdev->ops = &ls2x_rtc_ops;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, priv->rtcdev->features);
+
+#ifdef CONFIG_ACPI
+	priv->acpi_base = regs - ACPI_RTC_OFFSET;
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC,
+					ls2x_acpi_fix_handler, priv);
+#endif
+
+	ret = devm_request_threaded_irq(dev, priv->irq, NULL,
+					ls2x_irq_handler,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"ls2x-alarm", priv);
+	if (unlikely(ret))
+		return ret;
+
+	if (!device_can_wakeup(&pdev->dev))
+		device_init_wakeup(dev, 1);
+
+	return devm_rtc_register_device(priv->rtcdev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ls2x_rtc_of_match[] = {
+	{ .compatible = "loongson,ls2x-rtc" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ls2x_rtc_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ls2x_rtc_acpi_match[] = {
+	{"LOON0001"},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, ls2x_rtc_acpi_match);
+#endif
+
+static struct platform_driver ls2x_rtc_driver = {
+	.probe		= ls2x_rtc_probe,
+	.driver		= {
+		.name	= "ls2x-rtc",
+		.of_match_table = of_match_ptr(ls2x_rtc_of_match),
+		.acpi_match_table = ACPI_PTR(ls2x_rtc_acpi_match),
+	},
+};
+
+module_platform_driver(ls2x_rtc_driver);
+
+MODULE_DESCRIPTION("LS2X RTC driver");
+MODULE_AUTHOR("WANG Xuerui");
+MODULE_AUTHOR("Huacai Chen");
+MODULE_AUTHOR("Binbin Zhou");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ls2x-rtc");
-- 
2.31.1

