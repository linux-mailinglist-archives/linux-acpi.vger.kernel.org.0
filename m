Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5235C3C9352
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 23:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhGNVtS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhGNVtS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 17:49:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A90C061762
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jul 2021 14:46:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h19so5599693ljl.4
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jul 2021 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kkx47XtFT4andf4j6+XLwaIFXb1/TY0mcTSZA70oExg=;
        b=mZQW8Bl1TsprNKvsHxbtBPkhmyLNEHyui11eyjwnv7i9Hm4BHXmkkxGi33WThxGdTp
         lTsk3NeXiykf0NhZw6V7+FOuiOuHOiNujuRDtL94fDKmLSZnKzMJtra7rzlwivgUmzKG
         IscDwJFA27cUhKnR6HK0tcs/ukVVsA72w15LsS0bvfiE6RJh1gx7ElBxVXYrgoPGquAs
         LuxwG73FNjR5D0yDhoKWQrwo074RNcFht7FIbBguL4DXLGJP6ootlgLj4OxuyUApFxaI
         fBphBSBk0XiRXCfXtIC40mSu1SOUPxj2aCE3vYgElf1WKH0NeQ1qWEqwoY4d4Aa/l4Sy
         +Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kkx47XtFT4andf4j6+XLwaIFXb1/TY0mcTSZA70oExg=;
        b=il+1zkeQg92/zdC4i/Lx+8GeBHFJXHC/Icx5fJLCGzDEY6T+uFR+X7ub9NrInvnbPE
         Kzf+dZRz7gjtjJF+nIPIaLWHTFagcm5A/wjCn4rGxbiDviSbGmzfqGR03eWLl2N4DHhe
         CCGNgNdqm/6GIsWy/3jb/rptqUBZrK17HUqcTUDkDVLqo7cpEYygP2C38aX/Il/4za4e
         ABWFCO2SjgRpiDygdVPZsOnl2hjrqlL0GNyY9gpkb+o4clrR01UIu/ysLc1oT9VK3oU0
         mkiFcX7f3YM0euBrSw9q5wh9FaIpUjwBaGSWgUXwTlcVseH6d0wpNgswdgXhIHoKaFB9
         YCJQ==
X-Gm-Message-State: AOAM532i2e3LAZR/Hh6rm3x333RpLEgE5a1Nx05naY/3qcK2jCsgn8EN
        e+Sl7DomEqiYavbxTv5MeyLyvw==
X-Google-Smtp-Source: ABdhPJyhOGJkv1RNl8mKS0Gzs1tPAwUCeQZj//vkcHlFI6f96xJB/wy8xmwt4gXe0nUZqPO9+gIfIw==
X-Received: by 2002:a05:651c:2c1:: with SMTP id f1mr46097ljo.128.1626299184213;
        Wed, 14 Jul 2021 14:46:24 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id s21sm370837lji.57.2021.07.14.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:46:23 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
Date:   Wed, 14 Jul 2021 23:43:45 +0200
Message-Id: <20210714214346.1397942-2-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210714214346.1397942-1-mw@semihalf.com>
References: <20210714214346.1397942-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit d95c7d206b5836c7770e8e9cd613859887fded8f

The Microsoft Debug Port Table 2 (DBG2) specification revision
September 21, 2020 comprises additional Serial Port Subtypes [1].
Reflect that in the actbl1.h header file.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table

Link: https://github.com/acpica/acpica/commit/d95c7d20
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 include/acpi/actbl1.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index ef2872dea01c..7bbb3e2bd33f 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -482,7 +482,7 @@ struct acpi_csrt_descriptor {
  * DBG2 - Debug Port Table 2
  *        Version 0 (Both main table and subtables)
  *
- * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10, 2015
+ * Conforms to "Microsoft Debug Port Table 2 (DBG2)", September 21, 2020
  *
  ******************************************************************************/
 
@@ -532,11 +532,24 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_MAX311XE_SPI      0x0002
 #define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_MSM8X60           0x0004
+#define ACPI_DBG2_16550_NVIDIA      0x0005
+#define ACPI_DBG2_TI_OMAP           0x0006
+#define ACPI_DBG2_APM88XXXX         0x0008
+#define ACPI_DBG2_MSM8974           0x0009
+#define ACPI_DBG2_SAM5250           0x000A
+#define ACPI_DBG2_INTEL_USIF        0x000B
+#define ACPI_DBG2_IMX6              0x000C
 #define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
 #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
 #define ACPI_DBG2_ARM_DCC           0x000F
 #define ACPI_DBG2_BCM2835           0x0010
+#define ACPI_DBG2_SDM845_1_8432MHZ  0x0011
+#define ACPI_DBG2_16550_WITH_GAS    0x0012
+#define ACPI_DBG2_SDM845_7_372MHZ   0x0013
+#define ACPI_DBG2_INTEL_LPSS        0x0014
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
2.29.0

