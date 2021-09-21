Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D24412E8B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Sep 2021 08:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhIUGW6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 02:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhIUGW5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2021 02:22:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24795C061574;
        Mon, 20 Sep 2021 23:21:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 5so12668198plo.5;
        Mon, 20 Sep 2021 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elgO1aD4E2/zWX2bOZo8g6dTIxy20GTBH0i1b/pULsg=;
        b=gV5dtlIRiqYK5U5MAl/6XclD8u77wQSn+on3gytiYYDajyvIz9y9WPMUXb5fCVgk3N
         cfDzmMbV1lj4cG5/qHhbbBSShnDuR0bs2fIhgcKviEzMK7ozj5+wZXghTlOo80VJazHA
         IwBCkrAfJAPey92AoL/WQ5YU3g9aoLaSgy4bf8EcshpLyRILgxao0ijpNYpMFMmy3O2K
         50+rwoafhLrYNZdyuNoOY9fHsJK8oF0ZpctrRS+TVPmKPqZZRtbJMCMRndaJ8b9DRzA+
         CU4pnTenlwplM60BMgu1AVSk7lNn6zshrVV1gUkeAAf02p7XlWrpsOltF4APFW2XzR2m
         VaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elgO1aD4E2/zWX2bOZo8g6dTIxy20GTBH0i1b/pULsg=;
        b=T/u98xkW6Du4OId2xFzzraguZVHfPjzR+54YCqDT0xgUs0Cr6BUlG6ZORbzvT1Sufu
         vDl2uoqq82fE3QpFTa2VLoG10mVIrqrvK+R+nok0JJsKRAvtonS3aMGf6eRB5SjwpBTk
         m/VTXKFwprdA/t5H3vNBZxYKcxYxZTSGrvwjYJ0AzU5NFFT2ZwQiXmNtRoBSZCEiLrCY
         HH9lMDEOnRYQzdQJeV6LfZ4u+6LnM7Ayfcw85GcVe7e2osy8WihYYa4w8WR7cvpO1hrA
         +X1HBCXPZhmZZ2VlpIdKe4rXHsgTa3scRLc2qsDH34tAajE/74kk0N/WeZAkkHDJc2bC
         MvWw==
X-Gm-Message-State: AOAM533c+MvVLpL6QVSwFm2Xl0nPbJRKljjCpBl2BGtGFCR7Lv7xiK3C
        ReJE2NEB1wPR8yKLHcsN6jg=
X-Google-Smtp-Source: ABdhPJxUu9xO4dVqm+ztCNRiEVpbrenXOt7VvOynoFU1fX9k5c3QudwfB3bvrXh2wLaDoTzj/ipUhg==
X-Received: by 2002:a17:902:e282:b0:13a:45b7:d2cd with SMTP id o2-20020a170902e28200b0013a45b7d2cdmr26161619plc.86.1632205289017;
        Mon, 20 Sep 2021 23:21:29 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id bv16sm1291125pjb.12.2021.09.20.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 23:21:28 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 977422360A48; Tue, 21 Sep 2021 15:21:26 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ACPI: Kconfig: Fix a typo in Kconfig
Date:   Tue, 21 Sep 2021 15:21:24 +0900
Message-Id: <20210921062124.250165-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch fixes a spelling typo in acpi/Kconfig

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1da360c51d66..cdbdf68bd98f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -71,7 +71,7 @@ config ACPI_DEBUGGER
 if ACPI_DEBUGGER
 
 config ACPI_DEBUGGER_USER
-	tristate "Userspace debugger accessiblity"
+	tristate "Userspace debugger accessibility"
 	depends on DEBUG_FS
 	help
 	  Export /sys/kernel/debug/acpi/acpidbg for userspace utilities
-- 
2.25.0

