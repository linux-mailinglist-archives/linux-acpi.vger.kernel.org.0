Return-Path: <linux-acpi+bounces-1267-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2C7E29CB
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4469F280E56
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E728DA5
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966328DBF
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 15:09:45 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E4B3;
	Mon,  6 Nov 2023 07:09:44 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5872c652a66so286202eaf.1;
        Mon, 06 Nov 2023 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283384; x=1699888184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFpDfKfGfQS3hBcBBeYU7HxGjQMWrTdntKCbYzTULPQ=;
        b=tI2aFwH+2AlGeigNnPXyv3YX7Iq2bsyLAE3JTDVDcBxwS15QAKxbiMfVfW17I/7Bkl
         J4HjUDV1WepxI2DkIMg0QIMRqSJp1+NS5p5j/a2EBSq2cz8R7zSwtM1pl1+8VJ4mdDR4
         bVCuCcxyAOP/5fF4IIPrQDSqgF7VZw4CHBqUBGxZmqFSPD/uLDau22AfwNv3bRNr0ZrQ
         mrfzPvmJkO+cDZuOR2NAlQidZEUQ+PWewJrid6KlXZSFfLpQ1dAI1cCao1GBcpmiG465
         lKxMmP/wSHEUjGD6irU8KGG1alSFw9DSbz/1k0WdSm8rXB2YsLOgbCRQg+IxoIm7SfPx
         oYFA==
X-Gm-Message-State: AOJu0YzwxhgpvEep6uwo0RGgjCUOceAPYZdeMMit6d0YGjofPNflPH1d
	BOgyyn2DdQbRMMP88nobuXRevKuM1xUquShaWMeEYcMO
X-Google-Smtp-Source: AGHT+IFEqLz/U68qrMzhnOqCITe+la6hVxQfbh8yLocADTaNOEREesO5YSWMkm6MCiU2v9aZjjXWmt4yQtLqqWqpQsU=
X-Received: by 2002:a4a:dbd8:0:b0:583:ec88:e0 with SMTP id t24-20020a4adbd8000000b00583ec8800e0mr29278014oou.0.1699283383662;
 Mon, 06 Nov 2023 07:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103104900.409470-1-ubizjak@gmail.com> <CAJZ5v0iOY3u_jBmf=_3AnqEWHb+eTA6DtTfoU3tb=0RB0O+szw@mail.gmail.com>
 <CAFULd4YPVcWL6_bo2T4O=a6ed9hTOakp2m1_XBF3w-uWhyd4dQ@mail.gmail.com>
In-Reply-To: <CAFULd4YPVcWL6_bo2T4O=a6ed9hTOakp2m1_XBF3w-uWhyd4dQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 16:09:32 +0100
Message-ID: <CAJZ5v0gFTdVH7Kr3cHcb+stGx_E-rm=B5h+z4ZFqfY=M9=Jffw@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Use %rip-relative addressing in wakeup_64.S
To: Uros Bizjak <ubizjak@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 3:25=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Mon, Nov 6, 2023 at 3:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > On Fri, Nov 3, 2023 at 11:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > Instruction with %rip-relative address operand is one byte shorter th=
an
> > > its absolute address counterpart and is also compatible with position
> > > independent executable (-fpie) build.
> > >
> > > No functional changes intended.
> >
> > I'm wondering what's the exact motivation for making this change.
>
> Mainly to be consistent with what the compiler emits by default when a
> symbol is accessed. As said in the commit message, the %rip-relative
> access is also one byte shorter, and results in a position independent
> code.
>
> > Any urgent need for it doesn't seem to be there.
>
> True. It's mostly a nice-to-have change.

OK, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and the decision what to do with it is up to the x86 folks.

> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > ---
> > >  arch/x86/kernel/acpi/wakeup_64.S | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/=
wakeup_64.S
> > > index d5d8a352eafa..94ff83f3d3fe 100644
> > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > @@ -17,7 +17,7 @@
> > >          * Hooray, we are in Long 64-bit mode (but still running in l=
ow memory)
> > >          */
> > >  SYM_FUNC_START(wakeup_long64)
> > > -       movq    saved_magic, %rax
> > > +       movq    saved_magic(%rip), %rax
> > >         movq    $0x123456789abcdef0, %rdx
> > >         cmpq    %rdx, %rax
> > >         je      2f
> > > @@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
> > >         movw    %ax, %es
> > >         movw    %ax, %fs
> > >         movw    %ax, %gs
> > > -       movq    saved_rsp, %rsp
> > > +       movq    saved_rsp(%rip), %rsp
> > >
> > > -       movq    saved_rbx, %rbx
> > > -       movq    saved_rdi, %rdi
> > > -       movq    saved_rsi, %rsi
> > > -       movq    saved_rbp, %rbp
> > > +       movq    saved_rbx(%rip), %rbx
> > > +       movq    saved_rdi(%rip), %rdi
> > > +       movq    saved_rsi(%rip), %rsi
> > > +       movq    saved_rbp(%rip), %rbp
> > >
> > > -       movq    saved_rip, %rax
> > > +       movq    saved_rip(%rip), %rax
> > >         ANNOTATE_RETPOLINE_SAFE
> > >         jmp     *%rax
> > >  SYM_FUNC_END(wakeup_long64)
> > > @@ -72,11 +72,11 @@ SYM_FUNC_START(do_suspend_lowlevel)
> > >
> > >         movq    $.Lresume_point, saved_rip(%rip)
> > >
> > > -       movq    %rsp, saved_rsp
> > > -       movq    %rbp, saved_rbp
> > > -       movq    %rbx, saved_rbx
> > > -       movq    %rdi, saved_rdi
> > > -       movq    %rsi, saved_rsi
> > > +       movq    %rsp, saved_rsp(%rip)
> > > +       movq    %rbp, saved_rbp(%rip)
> > > +       movq    %rbx, saved_rbx(%rip)
> > > +       movq    %rdi, saved_rdi(%rip)
> > > +       movq    %rsi, saved_rsi(%rip)
> > >
> > >         addq    $8, %rsp
> > >         movl    $3, %edi
> > > --

