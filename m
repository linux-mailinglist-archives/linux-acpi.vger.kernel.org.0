Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EE76D7ACF
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Apr 2023 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbjDELLa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Apr 2023 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbjDELL2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Apr 2023 07:11:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873125266
        for <linux-acpi@vger.kernel.org>; Wed,  5 Apr 2023 04:11:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kq3so34047528plb.13
        for <linux-acpi@vger.kernel.org>; Wed, 05 Apr 2023 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680693085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5pxL1NLKIe4ynxwYg+dKy42GRofGXnJPceoZyaJlGsY=;
        b=nvs4osDtFN/XDWVyPnDEUElo8Qbrje5CpeBg/PRBc/WdVbgB9ZU0SrUP1hJq2ju3DS
         z9NmJtkGv0DmufyQvLSFnMKjudXf7+3pdmCuK3uwUnVW7GXp/xRnHkpSKUXlNdTWmB5V
         DbyxwDh01RVrM8HzDoq6knV0uPtMzz7vvOk2W//B8ywv/geATFJI8BNsXBlXzKRVMhs7
         VBRFzcpf5O9Tok5o0AYAwQVtUKRyzD5YIjNP/3kZCxSTycUIXisvyUc5EceMPZM8cuwe
         Meuv2kYW8x+xr8lpCGba+wjBDn/5Q9hhsYYVTFEA4wW4bkE0HV6kcujI83/l7uALfWQI
         W7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pxL1NLKIe4ynxwYg+dKy42GRofGXnJPceoZyaJlGsY=;
        b=VINWi8pcCSZ7mYZGdXHRtfRfImUA019gGOPJ6gsNqad3B14W5Dt7vqkn2qYAzYgRoh
         lnvCEsu5IuuUbTqWeTyozLtnJd8TZeYQp4PXYlAzhjQsJ5kBYmrBGBndCsPwwaucertr
         sqm3jvy1KIQhFxEXQXO005tFL0kEd/TLccQCmGw0HKb05EJHM3uER/w4DgCC8vqH15dq
         e4JFFpTNYe+cIN4q0SVjZHCnxGwO3oNrYSuamSmxvXwO1nqPUU9XuqCzb3wSSyCqq5c2
         disSZX5pW/oV11mp8+Pi+3ub/q4Qx2HWVVjYFCIBG8FIiES62n6dRTE7h9IDyhFT+guS
         MGYg==
X-Gm-Message-State: AAQBX9dOjQ5rUpM/LoLafL1S4AqucEcqsk/RaXZVVnM7Lc4cBaF93ToG
        G/naKMzUuEN+GNCH7sisqL9F/w==
X-Google-Smtp-Source: AKy350YYKcA8GasuUJIRqwG4r5R+Rypm/Vk1KsMv+WRX/0RgSaLSzcfBQVqYKrxKXrfWFx4e0DEqbw==
X-Received: by 2002:a05:6a20:8347:b0:cd:1709:8d57 with SMTP id z7-20020a056a20834700b000cd17098d57mr4852595pzc.1.1680693085020;
        Wed, 05 Apr 2023 04:11:25 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id h18-20020a635752000000b0050301745a5dsm8963209pgm.50.2023.04.05.04.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:11:24 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:41:13 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 22/23] platform/surface: Disable for RISC-V
Message-ID: <ZC1XUdD3DFnNauQ2@sunil-laptop>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-23-sunilvl@ventanamicro.com>
 <0c433e15-640e-280f-fcb0-a8fe081d1bcc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c433e15-640e-280f-fcb0-a8fe081d1bcc@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 05, 2023 at 11:33:00AM +0200, Maximilian Luz wrote:
> On 4/4/23 20:20, Sunil V L wrote:
> > With CONFIG_ACPI enabled for RISC-V, this driver gets enabled
> > in allmodconfig build. However, RISC-V doesn't support sub-word
> > atomics which is used by this driver. Due to this, the build fails
> > with below error.
> > 
> > In function â€˜ssh_seq_nextâ€™,
> >      inlined from â€˜ssam_request_write_dataâ€™ at drivers/platform/surface/aggregator/controller.c:1483:8:
> > ././include/linux/compiler_types.h:399:45: error: call to â€˜__compiletime_assert_335â€™ declared with attribute error: BUILD_BUG failed
> >    399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >        |                                             ^
> > ./include/linux/compiler.h:78:45: note: in definition of macro â€˜unlikelyâ€™
> >     78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
> >        |                                             ^
> > ././include/linux/compiler_types.h:387:9: note: in expansion of macro â€˜__compiletime_assertâ€™
> >    387 |         __compiletime_assert(condition, msg, prefix, suffix)
> >        |         ^~~~~~~~~~~~~~~~~~~~
> > ././include/linux/compiler_types.h:399:9: note: in expansion of macro â€˜_compiletime_assertâ€™
> >    399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >        |         ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:39:37: note: in expansion of macro â€˜compiletime_assertâ€™
> >     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >        |                                     ^~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:59:21: note: in expansion of macro â€˜BUILD_BUG_ON_MSGâ€™
> >     59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >        |                     ^~~~~~~~~~~~~~~~
> > ./arch/riscv/include/asm/cmpxchg.h:335:17: note: in expansion of macro â€˜BUILD_BUGâ€™
> >    335 |                 BUILD_BUG();                                            \
> >        |                 ^~~~~~~~~
> > ./arch/riscv/include/asm/cmpxchg.h:344:30: note: in expansion of macro â€˜__cmpxchgâ€™
> >    344 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
> >        |                              ^~~~~~~~~
> > ./include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro â€˜arch_cmpxchgâ€™
> >   1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
> >        |         ^~~~~~~~~~~~
> > drivers/platform/surface/aggregator/controller.c:61:32: note: in expansion of macro â€˜cmpxchgâ€™
> >     61 |         while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
> >        |                                ^~~~~~~
> > 
> > So, disable this driver for RISC-V even when ACPI is enabled for now.
> 
> CONFIG_SURFACE_PLATFORMS should be enabled for ARM64 || X86 || COMPILE_TEST only,
> so I guess the issue only happens when compiling with the latter enabled?
> 
> I'm not aware of any current plans of MS to release RISC-V-based Surface
> devices, so you could maybe also just explicitly disable CONFIG_SURFACE_PLATFORMS.
> In any case, I don't see any issues with disabling the whole platform/surface
> or only individual drivers for RISC-V, so for either solution:
> 
> Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
> 
Hi Maximilian,

Thanks!. Yes, COMPILE_TEST gets enabled for allmodconfig builds. Since
the whole intention of COMPILE_TEST appears to be able to compile-test
drivers on a platform than they are supposed to be used, I think it is
better not to skip whole set of drivers but only that which can not build.
So, I prefer to keep this change as is.

Thanks,
Sunil
