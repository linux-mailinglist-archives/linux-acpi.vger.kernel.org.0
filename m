Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7539D74831D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGELok (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 07:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGELok (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 07:44:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E437E3
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 04:44:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5440e98616cso422980a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2023 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688557478; x=1691149478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=heYxA+Mau07N/7p/yYCay8/E0q4AKYFHNWyC4Hmd8zw=;
        b=LCVJo1iC398QqSGBbSt3HMGRz4/6jQ17VocWqxatr+VH8bVDf8rSkxpkL7m2b/QlEt
         eQ8pti3q69C8zwvPmUiTV8DW+nE3IcQyXVe0YeoX9x2vqVwDmjtDjPqfIl2pyeMnhzik
         KToCLoPAtvpLYvDLkAWK6X90EERvIcNKunS7pZGI7D/EmJVvpBJah4xbs9FlTLtz/RcN
         FetDHam8n3J+ilgWlmeRK9W0uLNSN3E0XIP6RA1NH/5q6I1ObXbnt+OYNr+4/rQLiHyP
         MAZNa7QoBTTaUCTpG6MXQK+S04oTo3bGbjE1ZRU8IWiMvwTTc4AMuD9mhBnrtC5ZkJ3B
         Unqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557478; x=1691149478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heYxA+Mau07N/7p/yYCay8/E0q4AKYFHNWyC4Hmd8zw=;
        b=iKwekpWH0J2YZbbtn7/skyjsTFHkv3B0wWhJ7YRzxj0Xk+hmHdfhc720COFq7L2y/O
         o1FewlK4guU8h00QPB1zDNv9tLlQj7CcNB4jdlDvq1PZGy/TXWA2Y7z5EWElZ7e3H3iC
         aOdRP0e0HnuWSrlSDsc6g+UHd+IhKtER6SfN6rqT+GQAU/HSufusJhZbtlhBinn3PG34
         xRGVBfeANdvqUPtFPusVa1RT4jyLxhhfyD6MZYc+g7CjPyRE87GpP6vaufAO4vuTVa8e
         K5rFmkK1f1xl6Ymsgv9sSpABvXyLKtwcTtyEpkA3SBqqJdOfvCNtarumncFb7IkiEoc4
         FS5A==
X-Gm-Message-State: ABy/qLZHQ3Mk9dlK/yeUQLK9LJMzDVVjL1e2Bwd6hF1WHMNdwuvQRvYR
        Ik1H0pddtBf+vylVwwGFaqnphw==
X-Google-Smtp-Source: APBJJlF8iWM4sc1lZLKemHqMLhwUFgL4HgU3QAOE3GBa+o5h14Fsgs8Q290OJZcMEJ30fWvXqRIU8g==
X-Received: by 2002:a17:90b:3ec5:b0:263:70d1:ba84 with SMTP id rm5-20020a17090b3ec500b0026370d1ba84mr2812548pjb.18.1688557478638;
        Wed, 05 Jul 2023 04:44:38 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00263f6687690sm1177900pjh.18.2023.07.05.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:44:38 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     conor@kernel.org, sunilvl@ventanamicro.com, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, cuiyunhui@bytedance.com
Subject: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
Date:   Wed,  5 Jul 2023 19:42:47 +0800
Message-Id: <20230705114251.661-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Here's version 3 of patch series.

V1: The FFI (FDT FIRMWARE INTERFACE) scheme has reached a
consensus with the Maintainers.
Please refer to:
https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cuiyunhui@bytedance.com/

Changes v1->v2:
Adjusted the code structure, put the ACPI part under the RISC-V architecture,
and put the general part of obtaining SMBIOS entry through FFI
under driver/firmware/.
Please refer to:
https://lore.kernel.org/lkml/20230703-71f67eb66a037f5c0fb825c6@orel/T/

Changes v2->v3: 
According to the suggestions of maintainers, the code has been modified as follows:
1. Modified the commit log.
2. Added description of "ffitbl" subnod in dt-bindings.
3. Add stub function to the function
4. arch/riscv/ and driver/firmware/ use CONFIG_FDT_FW_INTERFACE to control
5. Modified the ffi_smbios_root_pointer() function logic and printing
etc.

Yunhui Cui (4):
  riscv: obtain ACPI RSDP from devicetree
  firmware: introduce FFI for SMBIOS entry
  riscv: obtain SMBIOS entry from FFI
  dt-bindings: firmware: Document ffitbl binding

 .../devicetree/bindings/firmware/ffitbl.txt   | 27 ++++++
 MAINTAINERS                                   | 13 +++
 arch/riscv/include/asm/acpi.h                 |  9 ++
 arch/riscv/include/asm/ffi.h                  | 14 +++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/ffi.c                       | 40 ++++++++
 arch/riscv/kernel/setup.c                     |  2 +
 drivers/firmware/Kconfig                      | 11 +++
 drivers/firmware/Makefile                     |  1 +
 drivers/firmware/dmi_scan.c                   | 97 +++++++++++--------
 drivers/firmware/ffi.c                        | 42 ++++++++
 include/linux/ffi.h                           | 29 ++++++
 12 files changed, 246 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl.txt
 create mode 100644 arch/riscv/include/asm/ffi.h
 create mode 100644 arch/riscv/kernel/ffi.c
 create mode 100644 drivers/firmware/ffi.c
 create mode 100644 include/linux/ffi.h

-- 
2.20.1

