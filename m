Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CFD1EB213
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jun 2020 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAXSU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jun 2020 19:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgFAXST (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jun 2020 19:18:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE40C03E96F
        for <linux-acpi@vger.kernel.org>; Mon,  1 Jun 2020 16:18:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f1so13138503ybg.22
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jun 2020 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m13wCjxvuAss7NYvH083DUgqdGzlzjUJaqo6EGXo6l8=;
        b=hGSPlVHMPFqP8l1gdyaycFTDNYeJq+dmve4OcRx0o+NeFXjZUheZXksaQ3egykT3/V
         y3TrMe5GShycYHLIG9qR1qiVRi7FAG/jm43g8+Ud2xrrKhyEfB4RKkxmvPirR5YEKEDZ
         ZETulQIHcmg24tf9rxwGMM7FbhCEyAx78T7pYUbp+woYvGe0RFIl3qSPbmvVSpXfKVCc
         Tghecr2RnKGgHCBnF88MYyD2bMpevoM/xqi5YP+CqERPdo96+ROU7B14cSkX/GKFXAC/
         06Xdutj2ar9pRf2+dnMQTRlul7bsHDMZ7dWvbohS19s78wWY/19IxeUhRQTS4s5V5a2s
         pn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m13wCjxvuAss7NYvH083DUgqdGzlzjUJaqo6EGXo6l8=;
        b=c9OH87Hc1egHV6yFX6svpCytl9DpRKMkFwHk3LqPsJBHOJI/thEinAVMKYWxB9iI4F
         cHiKnyAX/eKnUn6u/oEfaP6yAW1ZWPBcAwJBnvaoFbPbgr1V7ojrbQ7WLMLrjjT+C56h
         thRAQrHXfnz2pnh2btujVh6Azt3x1cVUs1c/5bwfQhz2txz7TtncBpJ/g3kxOMufcaEq
         BW3Mj1s2AES3vPuloONYyS3QG4b0bH4rsbpWAU8jPdpO7417q4eZmNHHxthJHNDPmSDr
         jaPtF+uhozXjT1RE4khEqZ58Fikk+lpK10AK72n71GRtQOC84S/D65KDaKIS9zHm8tCH
         1teA==
X-Gm-Message-State: AOAM5300n8fNk8GQbKgqG/2UeOeZFDVVMinifXVfHbu0apcSFDf3elgV
        YdoZXqHSdj5IKSyOhYqJefs9krVl1T9ET9JnLqk=
X-Google-Smtp-Source: ABdhPJwdKP/WIyb9zDhrdkpb/1aIfGh8Qv+dbXIL0nNPDlwjoNFg5jPiVanp/p5l0pHmiW9OMy1EYfxKlHO/6B0TWDI=
X-Received: by 2002:a25:d28d:: with SMTP id j135mr34423503ybg.208.1591053497544;
 Mon, 01 Jun 2020 16:18:17 -0700 (PDT)
Date:   Mon,  1 Jun 2020 16:18:05 -0700
In-Reply-To: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
Message-Id: <20200601231805.207441-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAMj1kXErFuvOoG=DB6sz5HBvDuHDiKwWD8uOyLuxaX-u8-+dbA@mail.gmail.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] ACPICA: fix UBSAN warning using __builtin_offsetof
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, dvyukov@google.com,
        glider@google.com, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        ndesaulniers@google.com, pcc@google.com, rjw@rjwysocki.net,
        will@kernel.org, stable@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Will reported UBSAN warnings:
UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6

Looks like the emulated offsetof macro ACPI_OFFSET is causing these. We
can avoid this by using the compiler builtin, __builtin_offsetof.

The non-kernel runtime of UBSAN would print:
runtime error: member access within null pointer of type
for this macro.

Link: https://lore.kernel.org/lkml/20200521100952.GA5360@willie-the-truck/
Cc: stable@vger.kernel.org
Reported-by: Will Deacon <will@kernel.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4defed58ea33..04359c70b198 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -508,7 +508,7 @@ typedef u64 acpi_integer;
 
 #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
-#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
+#define ACPI_OFFSET(d, f)               __builtin_offsetof(d, f)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
-- 
2.27.0.rc2.251.g90737beb825-goog

