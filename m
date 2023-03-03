Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33C96A988E
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCCNhS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 08:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjCCNhI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 08:37:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F1E3A840
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 05:37:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so2518426pjg.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T/9WMqfcgE40kVyTz05I09P0F9v/Zdvsnucdf4/Z5g=;
        b=NsVd952i/BHZBhEFqPB0CAAyWi/gm50kIMdyScloUumg7SedUmZwt9NFLFXnHXRstK
         xSS9oqI2a3GEV8qhMfvyEd2+/NW7qwvLoPj0XNSHXrPDT9E4wsGk5pV3jih95QcRlZMq
         a2YOhycG8NXvRU1jQWU3UmOrzvaRIGqGS42jrf0uNC2QGUsKgI1zTf+FzjVqolzhbuVi
         2wSCOEIgqpTAfAg8f6M6zh+chDDp2slPoCttzUnRmEVLtfahqhcOKVYL7C+YgQ0Yid3A
         3xq1z3Zy+0n8jd7leTKw3dXpLsQOsP/3WU/fWMbgxEbENIDTkPRjRsml2JeVL6CbPs3o
         6wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T/9WMqfcgE40kVyTz05I09P0F9v/Zdvsnucdf4/Z5g=;
        b=BWm2QMArEW7YZJ8qedN6h9p8W+j1XWidf3NNmU2xtIFcWN2/BewBBD/Ty0xHVWpJrS
         2bwbOg4Pt6gy1+TpYkJzStJiV1HJC9mSTx8P/d7wYGlDNhP0UgCda1Fkby9wKNVVsbqZ
         b82LLl/ELr6mqmHzV74ycJ7poj6r9kZr2Lnti78cpx5v5XQOphskgBNx/vl/g3GPaH+n
         V3/hYfmkohDn4v+4q3qWP8GZpFrJnyu8vuZ7A2PBAWbj5SubrcPsT9dJMVuB0MrmF6nG
         wvNHvYsQFiRiPhjEUo7LXIyPlf1LHvqiwuTP16NXySRrwV2UOzNgNOECXXtAPBQeuL0J
         WPxg==
X-Gm-Message-State: AO0yUKWrHaCEH6XdjsbjtMz+qP+wgeEbgGRJoZdbbTUT26O6QqvQxyKR
        tnhGHJLezJxaojhP5v3FHPZXfA==
X-Google-Smtp-Source: AK7set/z+6ZDiuui1utUYmSP8L/BHBH6V9+rO88q1JXkWBvdwaOSKgOqxNmja+IPl9m9DmzFf99T8Q==
X-Received: by 2002:a17:902:c389:b0:19e:7880:a5a with SMTP id g9-20020a170902c38900b0019e78800a5amr1801585plg.39.1677850624920;
        Fri, 03 Mar 2023 05:37:04 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:04 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Robert Moore <robert.moore@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 02/20] ACPICA: MADT: Add RISC-V INTC interrupt controller
Date:   Fri,  3 Mar 2023 19:06:29 +0530
Message-Id: <20230303133647.845095-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
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

The ECR to add RISC-V INTC interrupt controller is approved by
the UEFI forum and will be available in the next revision of
the ACPI specification.

This patch is not yet merged in ACPICA but a PR is raised.

ACPICA PR: https://github.com/acpica/acpica/pull/804
Reference: Mantis ID: 2348

Cc: Robert Moore <robert.moore@intel.com>
Cc: acpica-devel@lists.linuxfoundation.org
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index b2973dbe37ee..abb700d246df 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -891,7 +891,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_MSI_PIC = 21,
 	ACPI_MADT_TYPE_BIO_PIC = 22,
 	ACPI_MADT_TYPE_LPC_PIC = 23,
-	ACPI_MADT_TYPE_RESERVED = 24,	/* 24 to 0x7F are reserved */
+	ACPI_MADT_TYPE_RINTC = 24,
+	ACPI_MADT_TYPE_RESERVED = 25,   /* 25 to 0x7F are reserved */
 	ACPI_MADT_TYPE_OEM_RESERVED = 0x80	/* 0x80 to 0xFF are reserved for OEM use */
 };
 
@@ -1250,6 +1251,24 @@ enum acpi_madt_lpc_pic_version {
 	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
 };
 
+/* 24: RISC-V INTC */
+struct acpi_madt_rintc {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 reserved;
+	u32 flags;
+	u64 hart_id;
+	u32 uid;  /* ACPI processor UID */
+};
+
+/* Values for RISC-V INTC Version field above */
+
+enum acpi_madt_rintc_version {
+	ACPI_MADT_RINTC_VERSION_NONE       = 0,
+	ACPI_MADT_RINTC_VERSION_V1         = 1,
+	ACPI_MADT_RINTC_VERSION_RESERVED   = 2	/* 2 and greater are reserved */
+};
+
 /* 80: OEM data */
 
 struct acpi_madt_oem_data {
-- 
2.34.1

