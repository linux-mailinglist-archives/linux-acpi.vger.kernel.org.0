Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D2744D22
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jul 2023 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGBJ6j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jul 2023 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGBJ6e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jul 2023 05:58:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354810CE
        for <linux-acpi@vger.kernel.org>; Sun,  2 Jul 2023 02:58:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666eef03ebdso1692246b3a.1
        for <linux-acpi@vger.kernel.org>; Sun, 02 Jul 2023 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688291890; x=1690883890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkAY8od4kopgBrvcbw1hFpjzgJzWLikggNI5ytXC3Uk=;
        b=loY2CFs4lCMCrbHrZ0yHjXW0d09bE4yUX16zdqny9IfQYSrLVevitIgjVjuraQ1Gi1
         WAmfNin9IKUl2GQp00jw/CWIWhYqGbAHp8jvoeWHdW2tcmtEKvfGCCrVB8hx6Q4Sjqqf
         HIaVcB+YtGA+M3GO+XfmBpZplhMaqD7hiiyflwP4RFdvBAZ38PNOqc3mzDurTK86p+je
         M1nxappZcfZ3mae9G8be5IBvNUlyRsR6sVYEV+W25NJWKZ4q+aoamrJnQ3X1ZRNQGXL6
         Qmj/bbGQGyhVgTzIthLGGC/bHbI5sBzTGrTmwXacCHk2kbdGKz+PNnTZBecgIiHh5zI9
         UFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688291890; x=1690883890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkAY8od4kopgBrvcbw1hFpjzgJzWLikggNI5ytXC3Uk=;
        b=DmC2m/kQGz0e27Ww7C+kccdvmiLX9DbFYAcA05NfzNgKGm46VpVfeAXJuNGNeOVETD
         5rBst9Rb3wo83DXVL1hZ9vjvEbWb2rbDBFp9n2TlS5EAuhMqJV3moBIv7egMEbmgjw59
         Q0Mat3PSUhrE4poXL62UDq6ELYguM+cU3+wnYAIhOaLA+g/w5rkJt80/ZvuA9V9Q5Lh3
         WUXDnk8d24wki1ZZU8zOmfP8v9o5o5Chq0HDUBab7k+yk8UYiR7SEX/XrkNb6B0LCUQG
         3sCbYZflDz/5llMef3z5owgZsZK1sTs7s5HclWf64hOOmV0zZXP01bTb6IYI0TuFtc1+
         l98w==
X-Gm-Message-State: ABy/qLZjxTZB+ZC3PULMVBSBJF4sdXJN95lqEDKb6d47Qa0OAKal7TOU
        5SOIvg4Lej26ol6RQxUPHwH7NQ==
X-Google-Smtp-Source: APBJJlEXSgBPi382cT8u7InSOCN1bAAjdhLBtHtZTpazMFigPk1oiVbNh/c+TMlLCxgtWsKVe0Y3jA==
X-Received: by 2002:a05:6a00:2d87:b0:682:4de1:adcc with SMTP id fb7-20020a056a002d8700b006824de1adccmr7473435pfb.12.1688291890230;
        Sun, 02 Jul 2023 02:58:10 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id u26-20020a62ed1a000000b006827d86ca0csm1605095pfh.55.2023.07.02.02.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 02:58:09 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     ardb@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, cuiyunhui@bytedance.com
Subject: [PATCH v2 3/3] riscv: obtain SMBIOS entry from FFI.
Date:   Sun,  2 Jul 2023 17:57:34 +0800
Message-Id: <20230702095735.860-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230702095735.860-1-cuiyunhui@bytedance.com>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When we bringup with coreboot on riscv, we need to obtain
the entry address of SMBIOS through the FFI scheme.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/ffi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/ffi.c b/arch/riscv/kernel/ffi.c
index c5ac2b5d9148..c44f943a1cb5 100644
--- a/arch/riscv/kernel/ffi.c
+++ b/arch/riscv/kernel/ffi.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/libfdt.h>
+#include <linux/ffi.h>
 
 u64 acpi_rsdp;
 
@@ -34,4 +35,7 @@ void __init ffi_acpi_root_pointer(void)
 void __init ffi_init(void)
 {
 	ffi_acpi_root_pointer();
+#if CONFIG_FDT_FW_INTERFACE
+	ffi_smbios_root_pointer();
+#endif
 }
-- 
2.20.1

