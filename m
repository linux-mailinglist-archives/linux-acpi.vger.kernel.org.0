Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9F6D7A2E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Apr 2023 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbjDEKqp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Apr 2023 06:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbjDEKqo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Apr 2023 06:46:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC6C49F9
        for <linux-acpi@vger.kernel.org>; Wed,  5 Apr 2023 03:46:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so39089120pjp.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Apr 2023 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680691602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otykqullkWmg0A8KD35JF+HvspAaLoRDA6Fr6QFOB1A=;
        b=UQ0uumG4XH81lWfK6pVQa6G5b2bhg0H+jTMz7NTZVbIIyh41o0CBkytB6xZpFe/MDh
         Yffh5qenGWrU9TxMdihhNju6UMyitiMEbH/S8wc2qQG1KulmNjPVmxbe+5lvAhEFomTo
         UVZm4lhSh/J0/m6bMtf8ttgxYxkKl7fMCt60yIF06Ptxf/mvXyFUkNGGUYB2n0DaTbEg
         azqFX9oSbODaFFg4PbBU08adA+7I25vr0zw2LIqhUF9vuMMdUc7mKurF6cxQ3IPMwZvq
         T3aNBPO0bWfwSYeSYziw6ebXlP1MKTFYUr1w/FPVCAfBHvf9/tdCNmCXNug8DyFs3WjS
         4MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otykqullkWmg0A8KD35JF+HvspAaLoRDA6Fr6QFOB1A=;
        b=O4BnPoTEysjiQCWx0CoG2uTfyG7rGl+rOi51KiFDLjRbEDV0kyKxcQyFhi8A4RxMnk
         Xd0lHQjcYe41O223QliJ2mVcmHYq51ntZ2J5EhpI3ihQDHNpXazsRdjHOND11SlfETYa
         x2K/bZgQwKWC0Qaon/q51MHcjSXzgBprWjGAkg5p6nffDiE/oUn1SUf/bVEHQCiYlmxw
         mUAajqrFzYla9F9hCfX3z3nliY/LEUl2J2TzOKQAY/3qn/3ryhHKm6xRLNfuaZZkXccU
         FC1Esjs/4OOJ882OeV9k6A3UlUSkm8ZFy4LmHBjVT/F9XoPvMl1oZwNiUWJaxEZw2nSB
         SDOA==
X-Gm-Message-State: AAQBX9dGN65yFOT/e4WX2VqSNyvZ5QHw7f/VVpgYOpUT+A1dx0Ybmz6n
        DnJhNish3cotZwa2v5pui8lLqw==
X-Google-Smtp-Source: AKy350bK44iNVZ3LLDOTnB4w4y2fswThth90M15FEkZbqe29HOhrRwzj1s6JWfRQJI6BiNBgiUWAxA==
X-Received: by 2002:a17:902:e294:b0:1a1:8edc:c5f8 with SMTP id o20-20020a170902e29400b001a18edcc5f8mr4558701plc.56.1680691601853;
        Wed, 05 Apr 2023 03:46:41 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id g20-20020a62e314000000b0062b5a55835dsm10319322pfh.213.2023.04.05.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:46:41 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:16:28 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Weili Qian <qianweili@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V4 23/23] crypto: hisilicon/qm: Workaround to enable
 build with RISC-V clang
Message-ID: <ZC1RhA1Wi0B54sTO@sunil-laptop>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-24-sunilvl@ventanamicro.com>
 <20230404-viewpoint-shank-674a8940809a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-viewpoint-shank-674a8940809a@spud>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Conor,

On Tue, Apr 04, 2023 at 10:59:41PM +0100, Conor Dooley wrote:
> Hey Sunil,
> 
> This one made me scratch my head for a bit..
> 
> On Tue, Apr 04, 2023 at 11:50:37PM +0530, Sunil V L wrote:
> > With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
> > allmodconfig build. The gcc tool chain builds this driver removing the
> > inline arm64 assembly code. However, clang for RISC-V tries to build
> > the arm64 assembly and below error is seen.
> 
> There's actually nothing RISC-V specific about that behaviour, that's
> just how clang works. Quoting Nathan:
> "Clang performs semantic analysis (i.e., validates assembly) before
> dead code elimination, so IS_ENABLED() is not sufficient for avoiding
> that error."
> 
Huh, It never occurred to me that this issue could be known already since I
always thought we are hitting this first time since ACPI is enabled only
now for RISC-V. Thank you very much!. 

> > drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint '+Q' in asm
> >                        "+Q" (*((char __iomem *)fun_base))
> >                        ^
> > It appears that RISC-V clang is not smart enough to detect
> > IS_ENABLED(CONFIG_ARM64) and remove the dead code.
> 
> So I think this statement is just not true, it can remove dead code, but
> only after it has done the semantic analysis.
>
Yes, with more details now, let me update the commit message.
 
> The reason that this has not been seen before, again quoting Nathan, is:
> "arm64 and x86_64 both support the Q constraint, we cannot build
> LoongArch yet (although it does not have support for Q either so same
> boat as RISC-V), and ia64 is dead/unsupported in LLVM. Those are the
> only architectures that support ACPI, so I guess that explains why we
> have seen no issues aside from RISC-V so far."
> 
> > As a workaround, move this check to preprocessing stage which works
> > with the RISC-V clang tool chain.
> 
> I don't think there's much else you can do!
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Perhaps it is also worth adding:
> Link: https://github.com/ClangBuiltLinux/linux/issues/999
> 
Sure, Thank you very much for digging this!

Thanks,
Sunil
