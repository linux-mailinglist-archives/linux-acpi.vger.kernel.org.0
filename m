Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AB64E18CB
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Mar 2022 23:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiCSWYF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Mar 2022 18:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiCSWYE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Mar 2022 18:24:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A362234075
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 15:22:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d726bd83a2so98389967b3.20
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OkSdEnZDxkie6HpV+Cq3FfZcGdO9k6Q2dedvGrihz4k=;
        b=kHBbs+54TQt8YvMHJ4P15RTiz6iMnXCDYI6xGPXQeLnigv02pyh3ovt9kgRJ1j2lLb
         t4+AOulByIuiIQh70uHNxxuclxQ/kSABl46uzAYW0Iwf7WaycffXcHKeDQq4ZQeN2izO
         98I8Fd89vVvic/c6V2SlbxEdUy0Q5/V0h0R7fCy3LMOjX8/QgE7sH4fxMcZ/BngDA4L7
         syOqscHseotKX75Nl/04HrFQ9UXUZTUc9qBOPT93mEsz+vf+rIQd8Kb3sWVBwZDMgccf
         TlCZJk7vUU623Vpff7hAprVly+y/6kpn8qfGsVhAJG6WBx4N5PBfYryxSAymDBy8gcyH
         YT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OkSdEnZDxkie6HpV+Cq3FfZcGdO9k6Q2dedvGrihz4k=;
        b=ziP7Oa3OWVP6S9lM8B9L/aFAWT1fj13S3ibGqhp0apVTAjF3RhkvO7IG5Y3puGLWYa
         DL12M5dy7d4X9u1eR8ec1Vm0txJNnwoB7nMpx8ddAQf418Pujt8LHrXf80hauUPf47JP
         +MIWgVMIYuh9wYlm+uO+QPaau2AGzOj+lOd4eg8GtTNMWDG+w0n5Igsdj8hQ/dgOifM1
         bodul1Ol3SGk2s/R/wsuivyMN2MaVaEWxHZp3o8ycqz8XWCYhi7XvPgh0DqYu55lWVqQ
         AqkU0vLJlQpwsaPpSxi0JGN6aNwvYKDS806udy0+KKHLF7Eyj55evrGoBdhJ6zK2bn4U
         +dOg==
X-Gm-Message-State: AOAM5320ZaNKi902qPEepl+C0MnX9b44ZYgAFZ9irSjK+NT3a12TcxsU
        XVCWXMvcXv6tenTm2KojDO3uI/Fj
X-Google-Smtp-Source: ABdhPJwBJbOZ/XB3qdeuKan76xVvlKrJlJwjVdqavArroy0vYh8wzbTjEMoyDcySwnRgwhJGfVbTY7DWnQ==
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:f299:d506:bab:fff8])
 (user=morbo job=sendgmr) by 2002:a25:d304:0:b0:633:64ce:99c6 with SMTP id
 e4-20020a25d304000000b0063364ce99c6mr16652532ybf.433.1647728561817; Sat, 19
 Mar 2022 15:22:41 -0700 (PDT)
Date:   Sat, 19 Mar 2022 15:22:28 -0700
In-Reply-To: <20220316213055.2351342-1-morbo@google.com>
Message-Id: <20220319222228.4160598-1-morbo@google.com>
Mime-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2] gpiolib: acpi: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     torvalds@linux-foundation.org, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When compiling with -Wformat, clang emits the following warning:

drivers/gpio/gpiolib-acpi.c:393:4: warning: format specifies type
'unsigned char' but the argument has type 'int' [-Wformat]
                        pin);
                        ^~~

The types of these arguments are unconditionally defined, so this patch
updates the format character to the correct ones casts to unsigned to
retain the behavior or the "hh" modifier..

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2 - Cast "pin" to retain the same width as the original.
---
 drivers/gpio/gpiolib-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index a5495ad31c9c..92dd9b8784f2 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -388,9 +388,9 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 
 	if (pin <= 255) {
 		char ev_name[5];
-		sprintf(ev_name, "_%c%02hhX",
+		sprintf(ev_name, "_%c%02X",
 			agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
-			pin);
+			(unsigned char)pin);
 		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
 			handler = acpi_gpio_irq_handler;
 	}
-- 
2.35.1.894.gb6a874cedc-goog

