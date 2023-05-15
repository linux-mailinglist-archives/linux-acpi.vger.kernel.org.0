Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8C7023E8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 May 2023 07:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbjEOF4i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 May 2023 01:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjEOFzh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2023 01:55:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63BC4482
        for <linux-acpi@vger.kernel.org>; Sun, 14 May 2023 22:51:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aafa41116fso83305105ad.1
        for <linux-acpi@vger.kernel.org>; Sun, 14 May 2023 22:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129913; x=1686721913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38k1Pzb7K1cfn0j2an7l+ypiTAB8VfWPvQzIb1c40CU=;
        b=DF3aOoyY2x5iaGKXW2mCt0x/pQaAbDiKZZA0gDxjyLTyhSF3crH1dqxukCLNdHLfzQ
         ZzllGl7O4cpL+1Ul+Ds+6Hlon19xGezeeBDycdpnw1yNTf8V0jBLjijIo+4x3N7mMVMm
         isEMw5L4IMR6Yb/m9GcCKifj8e3SKkJs+3i2W3GBRn5jdibK+1JCAXj2pMZ63lvDHW50
         sZfCOt8sZJqQyLYQ+Oq/WAW56pMLyY47+byTDjC10jgBeL3W30bL0F7M6vHfzau4iz4q
         t0kqk1PSabd2sPNafnYuKBGJfSKY19q3eIGZWj6Wm7bKwjIEx1AbGBqBd0HU8LRKruDN
         NGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129913; x=1686721913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38k1Pzb7K1cfn0j2an7l+ypiTAB8VfWPvQzIb1c40CU=;
        b=Vzdhm4b0kxwCdBY2x2NSnq8yWoO+5IC2E2mNL9OGiOFvUu06ozAbqjZ6VjkHqk9G5x
         2P5ThoLnM5XD0VqL4Yj1Buq8y9JVzNFLdBxsduKlWQC4GijsRDvSMsX+p7fyBiFlKZDZ
         G2eTaeZVn5tMnS0sBcgfEUv/s8j4e/EMu5Bks0DujM6+mUj2XZezBa6XtsP575Nj7q5a
         oZh/AtVYsMuT4DOW4MDSD4+wA4YY19yOFVkwGzQe5DhzzWus4yzTPVALH2QhjIaGN/FA
         5jDd3hhySRH5Gzcj27al9X5rntQNc0BS/eK7+QWjJDuDG9DvrinAUEgAhS7+6b03/tdx
         qDmQ==
X-Gm-Message-State: AC+VfDzBx8cE2h+zmpDa6ycp3gNGpT4/hQQfWSHoxZtupXiH+KL/Prsq
        fmZbkYsVW7ioptt9Kv23J0vluw==
X-Google-Smtp-Source: ACHHUZ5cT0y2rm0ss7uQXiWI3AwrzqmHogjFI004ygSntqdlQauc3fg5I5daloTNm/BF5SXIXJdw8g==
X-Received: by 2002:a17:902:fa0f:b0:1a9:8ff5:af43 with SMTP id la15-20020a170902fa0f00b001a98ff5af43mr30429186plb.18.1684129913618;
        Sun, 14 May 2023 22:51:53 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:51:53 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V6 20/21] RISC-V: Enable ACPI in defconfig
Date:   Mon, 15 May 2023 11:19:27 +0530
Message-Id: <20230515054928.2079268-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support to build ACPI subsystem in defconfig.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index d98d6e90b2b8..d3d1fbf2dd5f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -37,6 +37,7 @@ CONFIG_PM=y
 CONFIG_CPU_IDLE=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
+CONFIG_ACPI=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.34.1

