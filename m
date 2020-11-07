Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671182AA3F5
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Nov 2020 09:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgKGItt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 Nov 2020 03:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgKGItt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2020 03:49:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B33C0613CF
        for <linux-acpi@vger.kernel.org>; Sat,  7 Nov 2020 00:49:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q83so4544978ybq.17
        for <linux-acpi@vger.kernel.org>; Sat, 07 Nov 2020 00:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6WU5XJ/qlfBh5YZsFPkg9rhMeyoErIKJCIfbV8EW5YE=;
        b=dD9J/n8G7DJiDwk4rEqBIeBWf32Gb+p1BKwuSv6yg96ucvQmYVFCsRDdSlkwibS1sE
         vPyCIx1hZ0qWhZV5w52bbGcZkVGWm/SUddyRyVZ/oi1ttKt6h9pRHwkIzrgqDjbV+Ad6
         lbc3ZNGMQrH/srcf1Z+e4ajxyJTsdIMB/b5Ify3Riowa+xpccCWmS8jmsdvSNeLNUysU
         HtkF6iq2a06S9t/IEgfNd4wUvQLOEvSPYL61vslWy2sFYZYH3NBKoeFoM07Xf31CIg4J
         igW5BREAIj2RF32EduPaw4ARttk2oBAtxDR0Hjg5wp7nOtTpCf1f052oAmsMMCJoYae9
         ahug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6WU5XJ/qlfBh5YZsFPkg9rhMeyoErIKJCIfbV8EW5YE=;
        b=tTGNPxhtb/WTkfvKrV4r9Nrx9J/3sS+Q9JdL69TV91+VuAcxpc4iTCG5h4kVQlA97X
         xgI7LwdU7ZIM4GAPiYmJzROdjCrOIhSEmrB6LBWQqbyEn6ueX86hIKCX3CBhC8W4Sj78
         1cCzcO0xrTZgy+r7juzE6PQtoGxhl+CY+nHkaITowts07971KGStkg85yXgSDBxqfSWA
         Q2wM/1KNsfO1ZkMdc3Rz+OX/EUcxkcvCItvheQ4Cd8smPLL/hNNLo5V0RJGBYh0ibuNH
         2JqU8cYZIAuy2GmdbipeaKG4zG8IXkBPuziRj3EolMYfnBTTp4PSsRZ2jofhlN6DZal6
         rRFw==
X-Gm-Message-State: AOAM531oK/S0hnZg3a+SE6nYNcXRwvwxpQrrcetdfQh+kQjsVdDOwFkG
        VsP2e+uHK8Xy+fWw1Cqte4YPtguKXRxDDJyPPGI=
X-Google-Smtp-Source: ABdhPJxIjWsegcqOUyZ9K1yAMY6YrV/UBt+/dKSQPXQWzEHDzYKRIIWBi8IWSXTzOPIWQwR9aNMbAqGiXCApsn9sJbs=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:8404:: with SMTP id
 u4mr3292320ybk.48.1604738988042; Sat, 07 Nov 2020 00:49:48 -0800 (PST)
Date:   Sat,  7 Nov 2020 00:49:39 -0800
In-Reply-To: <CAMj1kXE=V96pJ7xK=9xMh-1Eph4FH7S4WDXDyJUH+82_Zn5DXA@mail.gmail.com>
Message-Id: <20201107084939.3512560-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAMj1kXE=V96pJ7xK=9xMh-1Eph4FH7S4WDXDyJUH+82_Zn5DXA@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2] ACPI: GED: fix -Wformat
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Clang is more aggressive about -Wformat warnings when the format flag
specifies a type smaller than the parameter. It turns out that gsi is an
int. Fixes:

drivers/acpi/evged.c:105:48: warning: format specifies type 'unsigned
char' but the argument has type 'unsigned int' [-Wformat]
trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
                                            ^~~

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Fixes: ea6f3af4c5e6 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/acpi/evged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index b1a7f8d6965e..fe6b6792c8bb 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -101,7 +101,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 
 	switch (gsi) {
 	case 0 ... 255:
-		sprintf(ev_name, "_%c%02hhX",
+		sprintf(ev_name, "_%c%02X",
 			trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
 
 		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
-- 
2.29.2.222.g5d2a92d10f8-goog

