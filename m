Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F135ABE0F
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiICJgX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiICJgC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 05:36:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78EF152FD2;
        Sat,  3 Sep 2022 02:35:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkODtHxNjJWgQAA--.4203S4;
        Sat, 03 Sep 2022 17:35:45 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 2/7] LoongArch: Enable LS2X RTC in loongson3_defconfig
Date:   Sat,  3 Sep 2022 17:34:54 +0800
Message-Id: <6d01148014a62d8d412790dc8442af40368c6f8f.1662190009.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1662190009.git.zhoubinbin@loongson.cn>
References: <cover.1662190009.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxkODtHxNjJWgQAA--.4203S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry5XrWkuF43AFWxtF4xWFg_yoW3Krg_XF
        y7Kw1kWr48A397ua1xXw1rWw4DW3W7XFnYkr9rJw1fX3Wagr13JwsrCw13Cas09ayUWr45
        AaykAF9F9r18tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbh8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUjoGQDUUUU
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is now supported, enable for Loongson-3 systems.
Other systems are unaffected.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <git@xen0n.name>
Cc: loongarch@lists.linux.dev
---
 arch/loongarch/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 4083d3051109..b240bc4e2021 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -660,6 +660,7 @@ CONFIG_USB_GADGET=y
 CONFIG_INFINIBAND=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
+CONFIG_RTC_DRV_LS2X=y
 CONFIG_DMADEVICES=y
 CONFIG_UIO=m
 CONFIG_UIO_PDRV_GENIRQ=m
-- 
2.31.1

