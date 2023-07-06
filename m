Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834F77493A8
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jul 2023 04:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGFCZZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 22:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjGFCZY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 22:25:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D11990
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 19:24:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3143b88faebso104169f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2023 19:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688610296; x=1691202296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1048vqlXkYGyF+XcnTYa3P+GBqsNCgfDORbZIMSrGAk=;
        b=DhyUYoEM+lzL9QbERr02EhFFYHChXal8YDSzaYHUSk2Ze4dGQn7daxWPR8mVzEhTPw
         bqUAHq0nr9lozZZud75z0XJFitgtT8VeNRHP2MrFWyCIJnLlR4MgYuRxLk23gRD2QHl+
         6SMVGkEa1Q0/7DKUnQkPV27I0CnY13vJI/H3GdzDTUR4S244CJQ4Yo/skMG6F+wCEkvE
         kHugkL4HqAfhJ/R/bOQIrUki9lzCmpCfHQa4dsdLYGADc03tbh3r/JKR6SlMGMT8O8Cc
         LvVXIJGkKJJHXZIquYwvLD4uK4+EMyocJbcaNZMTMVwuQ8fRdi2CtVtryOMUDsGcXdgR
         3abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688610296; x=1691202296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1048vqlXkYGyF+XcnTYa3P+GBqsNCgfDORbZIMSrGAk=;
        b=A5jF34fO7rNRYqVgudaVsgfMfXVy6vLf5x74JVLi7zbKMNBPygDdAwkcOJ1AmK1qLn
         2QTqFDzKGjHbyKr2eAAAu1xHZCBAya5cIenyqWH4FfyGNu0or+XbRmLRwSYSdZIFDnUM
         c8ANO69bNHUfFgfJCgsgUiHZCEZ8nRfhD/bZgUpDEy2KK/YNfpLp08h8FYp8TO0AIUeE
         PtOmUag6EQYtezzZ7X2aGb606jm5QlBJEJNHaoj/PEwQvayhCJRbvAHR+uWTWqyGNBJY
         D9NxsWzyV/9PoOp30tSg1QqYFj+YrbR3tQGzer5Rcf4TCDzZQ4kCBXSw/zNrqUj6LkGh
         gWjA==
X-Gm-Message-State: ABy/qLZNIOvc6YMfUH8FMvJyUF8+x7ly53xRdvHRgP/oi+Ef8sY+9d20
        q6ilF49ZY5KtvgNaMr378yH2CMbF7u5S5/k1UikoZQ==
X-Google-Smtp-Source: APBJJlEbQjDa7zV4kzY1QMr+RRPhlGD3O00R3/Q/5tLRT9VcuuHuuAQy1kfD+qZkasgWlox4owNuD+y+UUZXFlhGpwY=
X-Received: by 2002:adf:e310:0:b0:313:f371:aede with SMTP id
 b16-20020adfe310000000b00313f371aedemr450746wrj.1.1688610296508; Wed, 05 Jul
 2023 19:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
 <CANBLGcwcvK55dZ1__wvWCtcw=XoKt=qki8g6C_QYo+TBqqJ=TA@mail.gmail.com>
 <50F3BD62-78F1-456E-A44A-0C7D9A2D4113@jrtc27.com> <87bkgql8rq.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87bkgql8rq.fsf@all.your.base.are.belong.to.us>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 6 Jul 2023 10:24:45 +0800
Message-ID: <CAEEQ3wnaaMvJ3=7udvAjiP3q36nvqAwb8sh34f+nO8Ua_83yFw@mail.gmail.com>
Subject: Re: [External] [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bj=C3=B6rn,

On Wed, Jul 5, 2023 at 10:43=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Jessica Clarke <jrtc27@jrtc27.com> writes:
>
> > On 3 Jul 2023, at 19:58, Emil Renner Berthing <emil.renner.berthing@gma=
il.com> wrote:
> >>
> >> On Mon, 3 Jul 2023 at 15:33, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@by=
tedance.com> wrote:
> >>>
> >>> Hi drew,
> >>>
> >>> On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones <ajones@ventanami=
cro.com> wrote:
> >>>>
> >>>>
> >>>> (This is a reply to a non-existent cover letter.)
> >>>
> >>> This has been discussed many times with Ard, Please refer to :
> >>> https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16=
-1-cuiyunhui@bytedance.com/
> >>
> >> Hi Yunhui,
> >>
> >> From that discussion it was mentioned that that arm supports 3 methods
> >> of booting:
> >>  direct + devicetree
> >>  EFI + devicetree
> >>  EFI + ACPI
> >> ..but not
> >>  direct + ACPI
> >>
> >> To me it isn't obvious from that or this thread, and since arm seems
> >> to be doing fine without the 4th option I'm curious why that's
> >> necessary on riscv?
> >
> > If anything we should be removing option 1, because that=E2=80=99s not =
a
> > cross-OS standard (though RISC-V=E2=80=99s SBI direct booting is at lea=
st not
> > tied to the OS). Any application-class platform spec is going to
> > mandate EFI, because, whatever your thoughts of EFI are, that is *the*
> > standard. And if you=E2=80=99re willing to pick up all the complexity o=
f ACPI,
> > what=E2=80=99s a bit of EFI (especially if you only go for a minimal on=
e a la
> > U-Boot)?
>
> Well said!
>
> Yunhui, why not simply add a minimal UEFI stub to Coreboot (like Jess
> points out above)?

In fact, in the v1 email, Coreboot's maintainer Ron has made it clear
that Coreboot does not support EFI, and it is necessary to transmit
firmware information through DTS on RISC-V.
@Ron, can you help explain it to them?

> IMO what U-boot (or
> https://github.com/cloud-hypervisor/rust-hypervisor-firmware if you're
> into Rust ;-)) is doing, and just having a small UEFI shim is the way to
> go.

Thanks,
Yunhui
