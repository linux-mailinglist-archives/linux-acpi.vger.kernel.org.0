Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C0374FB37
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjGKWrG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jul 2023 18:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGKWrG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2023 18:47:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E510D2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 15:47:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8bbce9980so42205365ad.2
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jul 2023 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689115624; x=1691707624;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=RtH9FmNVb+GZQwIzxQc1bZ4di4brpl9MkUqFJmWCtvc=;
        b=a2eIKlTz8dhU4v0VoMbIdtxZYTNG1qd2Q61S2J+ik+8IsH0xI+hTEwF05curWxz7p4
         Tvq67dW2xZE6lwmgh7UCrnKOGqv0YjRmkMuhP7LsizU5bfIG3GjbZO+yZjQCW63SSk4W
         SCUR24lAYmeIHD2pLWiIkwBRFwEXtz/vdCHMvmWJ2eahUhHPk/3EsiDla25aVrtFkOD3
         en0WAIQ/oQgU6vOj2CNfVvQxqYJrjkMrAJ8YioLttR4kftfaJirT1WqE2nxuiV5+35gi
         d71TMwEMvAx18ydEqkdULZozZJY5idbMp6XX+aTZazpjY9Cszw4V2VuWCQEzh0CCsW8J
         0Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689115624; x=1691707624;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtH9FmNVb+GZQwIzxQc1bZ4di4brpl9MkUqFJmWCtvc=;
        b=WTUAaC/61R1Bd4sa+OtB06b3T6rEJqVFs93ZiCUzxkfWgQCrcY5KcbgHkkDFZ5iaoF
         Y1AqgOjIHFOCuMRqwvN3JPIvUDUacuOPnLy/oIYkc9smCMCZnw9e5mIq0Esp2r2rb9Dx
         DbsPen0HqX1GSAGOeENeCsjXvd9mfn1opm8Ui1Tj2fAVqMuNkZMkQKUQA1WlRRyuFEEJ
         X0KVENf+CqM2dt8zn6ExClfRNAEZFtlKTmALIcsjqol4xq29LPoksSM07XaSWSk4jEB4
         4vKf+KnSBZbzNtuFeaiqhgicLof1MsPCbgD1JX3IXFbH6R/3OYr6JNg0SvDIlA2hZr/+
         k5SQ==
X-Gm-Message-State: ABy/qLaKAAYjJ70dlhbic8KptWmSqf/2OjvF30VqRgMClAyjS0muLcoT
        pwjneI1CBdVrMP622CFlk8NWUZBy3n2+a/1LFb8=
X-Google-Smtp-Source: APBJJlGOTkndJ/ubNgA9o5A7E+MoK1VYx5vSzty7LtJIZ4yKJq6UfY4CgPD3o++V2ZI94wmOSnGF0w==
X-Received: by 2002:a17:902:e746:b0:1b9:ce7a:8603 with SMTP id p6-20020a170902e74600b001b9ce7a8603mr11204102plf.66.1689115623919;
        Tue, 11 Jul 2023 15:47:03 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902aa8200b001ac40488620sm2454762plr.92.2023.07.11.15.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:47:03 -0700 (PDT)
Subject: [PATCH] RISC-V: Don't include Zicsr or Zifencei in I from ACPI
Date:   Tue, 11 Jul 2023 15:46:00 -0700
Message-Id: <20230711224600.10879-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI ISA strings are based on a specification after Zicsr and Zifencei
were split out of I, so we shouldn't be treating them as part of I.  We
haven't release an ACPI-based kernel yet, so we don't need to worry
about compatibility with the old ISA strings.

Fixes: 396c018332a1 ("RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index bdcf460ea53d..a8f66c015229 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -317,19 +317,14 @@ void __init riscv_fill_hwcap(void)
 #undef SET_ISA_EXT_MAP
 		}
 
-		/*
-		 * Linux requires the following extensions, so we may as well
-		 * always set them.
-		 */
-		set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
-		set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
-
 		/*
 		 * These ones were as they were part of the base ISA when the
 		 * port & dt-bindings were upstreamed, and so can be set
 		 * unconditionally where `i` is in riscv,isa on DT systems.
 		 */
 		if (acpi_disabled) {
+			set_bit(RISCV_ISA_EXT_ZICSR, isainfo->isa);
+			set_bit(RISCV_ISA_EXT_ZIFENCEI, isainfo->isa);
 			set_bit(RISCV_ISA_EXT_ZICNTR, isainfo->isa);
 			set_bit(RISCV_ISA_EXT_ZIHPM, isainfo->isa);
 		}
-- 
2.40.1

