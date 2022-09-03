Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27965ABE2F
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiICJh7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 05:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiICJh7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 05:37:59 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9820AB4EA6;
        Sat,  3 Sep 2022 02:37:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWsgIBNjfGgQAA--.8093S3;
        Sat, 03 Sep 2022 17:36:33 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>
Subject: [PATCH 7/7] MIPS: Loongson: Enable LS2X RTC in loongson2k_defconfig
Date:   Sat,  3 Sep 2022 17:35:57 +0800
Message-Id: <f9c9a777efe4766297a5b460fb9221624b879c6f.1662190009.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1662190009.git.zhoubinbin@loongson.cn>
References: <cover.1662190009.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXWsgIBNjfGgQAA--.8093S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur4fZFykZr43Gry5ArWkZwb_yoWDArg_GF
        y7Kw1kGr4rArWrCa4xXw1rWw1Uu34UWa1kCr17tw15X3y3Kr13Xa9rAr15GFn8u39rKr4Y
        va95JFyxur17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbyAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JUza0QUUUUU=
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

This is now supported, enable for Loongson-2K systems.
Other systems are unaffected.

Signed-off-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Qing Zhang <zhangqing@loongson.cn>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/configs/loongson2k_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index e948ca487e2d..e15f34857956 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -280,6 +280,7 @@ CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_OPTION=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_CMOS=y
+CONFIG_RTC_DRV_LS2X=y
 CONFIG_DMADEVICES=y
 # CONFIG_CPU_HWMON is not set
 CONFIG_PM_DEVFREQ=y
-- 
2.31.1

