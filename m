Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F54699C1A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Feb 2023 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBPSWK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Feb 2023 13:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjBPSWA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Feb 2023 13:22:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0A850379
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:21:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k24so2730274pji.2
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9sxg5LZ/1sJSiDItv56ESM72UWoohRRXZed1vK0StQ=;
        b=I5b4VocraQIzy74N6/WkUSoEflR7yik4OQfTnlBnTTAhyc9/7L7kZrDieGxf5g+3nm
         8jov6jOgh5KiNaZd5Eaa7Vfd+keKgSYotzhC6UN9lRBO7zglAi7u1MIu4JtEtffb1qC4
         dtXduPqacGJKwS4he3LX/xaSnKLvpeDfpeAtrCDtAUe5w4SXN4V3liCjE7jYSJxAhPp8
         DASKy2oFicLS4SBOSKLvGzogHewOZG+O+NkMXBohSjcp/cq1irt5j+D1lDQxPVx9M2Ni
         dBAbL6WViE6T6Vldp2yhiqPJLShLBhApPxCeMBFjOnsg9MH8T1AV3a3db480pdXDA4YB
         xymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9sxg5LZ/1sJSiDItv56ESM72UWoohRRXZed1vK0StQ=;
        b=Qz+l/2rNKVRoTDBg9xYQVH4nUjvG/38y0Yrhmp4chcPPKBJpvWdd0xzQs0vckyUm0C
         aNE6k2hTk9z9gK8Gzu3aFfrmXp+FK8EMDBUwVPcrIBCTTEcZlcnXq/uuXRwns5s+0H3V
         osxb58syQ4FRxE59gWZcuyRPIbJ3msdI70WPpeA+/QLOncUPYanCG2iDCBwQ1B824fXQ
         yl3PHVFLZNmqNQDRWSzLh/fbdENQPEAuyrDgxOMR1cJn90gtq27fPVxFsW3BJEYjNHjB
         rBDgTaZiDKIHAd5Nxj2qMm6j8UfmZy0+3nRygwJ75PFPbLlnVvVmRXQwyx9MX5KlOvQ8
         WzfQ==
X-Gm-Message-State: AO0yUKUMnoHfSIQnB1PGq1ciV+0u5o4r4NKjPQlgQw0ZIsZ0cJEvh96K
        4mIlhundFybfg2xUrcgkdYJ6Vw==
X-Google-Smtp-Source: AK7set+LkiYEtVszqIim+13FtoK1iDZchye9bkxcSiZhQvPVVkT3nRpoNkcezYVva1ZFDzq4Dzm6XA==
X-Received: by 2002:a17:902:c943:b0:199:1f42:8bed with SMTP id i3-20020a170902c94300b001991f428bedmr3110483pla.12.1676571681615;
        Thu, 16 Feb 2023 10:21:21 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:21 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 06/21] ACPI: OSL: Make should_use_kmap() 0 for RISC-V.
Date:   Thu, 16 Feb 2023 23:50:28 +0530
Message-Id: <20230216182043.1946553-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Without this, if the tables are larger than 4K,
acpi_map() will fail.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3269a888fb7a..f725813d0cce 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -276,7 +276,7 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 	return NULL;
 }
 
-#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
+#if defined(CONFIG_IA64) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 /* ioremap will take care of cache attributes */
 #define should_use_kmap(pfn)   0
 #else
-- 
2.34.1

