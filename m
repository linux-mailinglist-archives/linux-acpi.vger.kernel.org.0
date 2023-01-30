Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAD681901
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbjA3S0k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjA3S0Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:26:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EEA3D905
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:24:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so16433894pjq.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GmsS1bMG3vhs9nYaH5ehvEVh7IMrCbQji3r9uemxws=;
        b=FdQa5Nr8gTa9dhRoHNHv6DLl9MMrt0b8LGra3FlgdVR0HXDLToZe7M4Vw8FA842bxO
         ANogiCr8CkEluK5rksyrobBwZAKJ8A7G98bpLiz8xri62Tumhak9vvXobe/T1z4+dIij
         Jlqnftn2IXrjlaveSNTGwhALA2SpVI2d8kvV9HY86Y4JMm+idqkTZW4FJJkA1grLa2sm
         x0PYL9hJD9yklIp6Iu+3fct8g4Ub4r9NHKkc2cqYsfctvGHE+Vyr3INej/nu/6q7BWpl
         03u7GIFOwrw/uDqPq7+wghYTYt8n5mYmkRz3QQNQr2axPeRxPYEMQorPSn4SyB0vyC3z
         ggHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GmsS1bMG3vhs9nYaH5ehvEVh7IMrCbQji3r9uemxws=;
        b=kyrbq4VnzD1ksqk8kFSxk/qjEYxMs/ain3kG5G+TQbUm6xpvSfq5mody7aSjXARZhe
         kzrls7AnAzK0y88BPingW6RlgjUA5vOuUpjVRiz4E2120J/umvt0E89zE4Gbu9QWEQ65
         M0H/fC1Ksj1hg3A8dYpB0LjeCy1QQjgt+rqql3h0FcoLTsJtc19d5vcVj4Z19E6otz9v
         y4ktkjAMRudBzKimYvKcxCP6FZ1wq7wuxMAv+xINM4naZX2V7bCsatrHWFvcTOjOtOuR
         lmCkdWI8CSEQeGYqLlCf2sKor0M4a9n274j1EEJTzlrPH8cCEBq/xFcdRSb4mVCNEySJ
         h7pg==
X-Gm-Message-State: AO0yUKX/qu4zEuGBfUTUFlBA1Fz6tstOFeLxPJCCNdUeKA2Rcxw+jjXu
        hsEYzUxRRrhVNAoF6M2TLbBPfg==
X-Google-Smtp-Source: AK7set/NaUdxXOXi68TuA9LtTnJuAZDAOVCnERp8kT07lTkCp48tqSeuSCZp3ML1m7atqGjopshDlQ==
X-Received: by 2002:a05:6a20:841f:b0:be:7d46:e5 with SMTP id c31-20020a056a20841f00b000be7d4600e5mr4161873pzd.56.1675103059928;
        Mon, 30 Jan 2023 10:24:19 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:19 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 23/24] MAINTAINERS: Add entry for drivers/acpi/riscv
Date:   Mon, 30 Jan 2023 23:52:24 +0530
Message-Id: <20230130182225.2471414-24-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI defines few RISC-V specific tables which need
parsing code added in drivers/acpi/riscv. Add maintainer
entries for this newly created folder.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5c25c20d00..b14ceb917a81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -450,6 +450,13 @@ S:	Orphan
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
 
+ACPI FOR RISC-V (ACPI/riscv)
+M:	Sunil V L <sunilvl@ventanamicro.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	drivers/acpi/riscv
+
 ACRN HYPERVISOR SERVICE MODULE
 M:	Fei Li <fei1.li@intel.com>
 L:	acrn-dev@lists.projectacrn.org (subscribers-only)
-- 
2.38.0

