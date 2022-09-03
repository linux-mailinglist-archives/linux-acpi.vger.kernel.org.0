Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65E05ABE17
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiICJgZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiICJgD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 05:36:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A53E303D6;
        Sat,  3 Sep 2022 02:35:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkODtHxNjJWgQAA--.4203S2;
        Sat, 03 Sep 2022 17:35:42 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 0/7] rtc: ls2x: Add support for the Loongson-2K/LS7A RTC
Date:   Sat,  3 Sep 2022 17:34:52 +0800
Message-Id: <cover.1662190009.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxkODtHxNjJWgQAA--.4203S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW5JrWxWw47Wr4DGF47XFb_yoW8Ww1Dpa
        13CwsxKr4DKF4ayrn3Jry8Wrn5ZrZxJr9rZa13J3y3urZ5Ca4DZw1UGF4FyrsrAr9Yyry0
        vFy8KF43KFW3CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMmh5UUUUU==
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all:

The initial DT-base ls2x rtc driver was written by Wang Xuerui, he has
released five versions of patchset before, and all related mail records
are shown below if you are interested:

https://lore.kernel.org/all/?q=ls2x-rtc

In this series of patches, based on the code above, I have added the
following support:

1. Add ACPI-related support, as Loongson-3 + LS7A is now ACPI-base
   by default on LoonArch;
2. Add rtc alarm/walarm related functions.

Unfortunately, I have only tested the Loongson-3A4000+LS7A1000/LS7A2000
under LoongArch architecture.

NOTE:
The related functions of rtc alarm/walarm depend on ACPI registers, so rtc
alarm may not be available on the DT-base environment. Such as Loongson-2k/3
under MIPS.

Thanks.

Binbin Zhou (2):
  rtc: ls2x: Add support for the Loongson-2K/LS7A RTC
  LoongArch: Enable LS2X RTC in loongson3_defconfig

WANG Xuerui (5):
  dt-bindings: rtc: Add bindings for LS2X RTC
  MIPS: Loongson64: DTS: Add RTC support to LS7A
  MIPS: Loongson: Enable LS2X RTC in loongson3_defconfig
  MIPS: Loongson64: DTS: Add RTC support to Loongson-2K
  MIPS: Loongson: Enable LS2X RTC in loongson2k_defconfig

 .../devicetree/bindings/rtc/trivial-rtc.yaml  |   2 +
 arch/loongarch/configs/loongson3_defconfig    |   1 +
 .../boot/dts/loongson/loongson64-2k1000.dtsi  |   5 +
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi     |   5 +
 arch/mips/configs/loongson2k_defconfig        |   1 +
 arch/mips/configs/loongson3_defconfig         |   1 +
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ls2x.c                        | 366 ++++++++++++++++++
 9 files changed, 393 insertions(+)
 create mode 100644 drivers/rtc/rtc-ls2x.c

-- 
2.31.1

