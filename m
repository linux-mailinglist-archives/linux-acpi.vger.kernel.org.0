Return-Path: <linux-acpi+bounces-1263-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD5D7E26EA
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970CD1C20B07
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FF28DA1
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILTZSDck"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880B1799E
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 14:25:58 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBABF;
	Mon,  6 Nov 2023 06:25:56 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so5514526a12.0;
        Mon, 06 Nov 2023 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699280755; x=1699885555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+IJUfXZsOW51np1tosDmPgs6aK7LQL7UbN0Dlaw73o=;
        b=ILTZSDck39PGDBOo4gHADOUKXS4NZvuSe39uF73FR72vuh5sd8uVPTI53EP5Pc69o9
         pISN0n/1BmKqk965mfuJsRfBbIwTB5Tb6aUzN35fop7M7XAhH7TV9MJojcOK8UBTLip4
         m/fRn4Btw6TKswNN3Ag0NJ6vFAAlhZBOu1tYYqvgS/TTUv80IOGWKpGBA9h4fp5UxDqY
         3KlNtddIoGCPhpGIxjMJ6qjQmU/Mce2Rdsj44Th1nuAszPzsSr9vQk9Ay0kzXjZbQfZg
         L50vFIlJVR4A26LjNyAkkA8ps7wi0S0fxb10sqhlrff6l976aHUzqNc7THjF8dRsK/gr
         f6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280755; x=1699885555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+IJUfXZsOW51np1tosDmPgs6aK7LQL7UbN0Dlaw73o=;
        b=jBINs8Zg6LaxnGfxF+/5ESw+mX1rk/A+Qp2XcqSPyt+tKH59T0x4ots7w14esA83m3
         VkISkze9bz9Y3b8tsd2QHf2WbeLNjIc5Mk7d0fxREbH5nJ1xlWqsjf8UJCZAE4myWyE+
         cUl/LHJRuiLp3Q/M1oqJozlh1U+YkGbWBjJDMdiwpRUwW3AG70Dwp7s1CV0igQkjY72f
         7LdIYHmdA7jZq7KSTgmMGRoN1+RE1UHHBzu8atepzcZQ9yH6t/M28kFCZIozZah76jPX
         zdiYWBlv1+7L0EHzKYSzwb5mXfsGiuatOPEVIPjyh1HpeNMgeZEXCaBbkuShePkzX4SI
         QSZg==
X-Gm-Message-State: AOJu0YygzCQ9WF3JGKGXMtR9aNBtSwRp2zjTJgB5gjjx9JwSeCDxl4RC
	q66tKhaSXMfMh1BtcA438eFCFWSne6+WzLVqaAc=
X-Google-Smtp-Source: AGHT+IEqw5OX3EtYIyMue2Umob88eYYxIoWxUZvwH8rdXlFYg/NsYYT/TdLOVqdYwrjrZhsibk7B2I8VDbgJTnl4tSs=
X-Received: by 2002:a17:907:934c:b0:9bf:b6f5:3a08 with SMTP id
 bv12-20020a170907934c00b009bfb6f53a08mr13644299ejc.52.1699280754821; Mon, 06
 Nov 2023 06:25:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103104900.409470-1-ubizjak@gmail.com> <CAJZ5v0iOY3u_jBmf=_3AnqEWHb+eTA6DtTfoU3tb=0RB0O+szw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iOY3u_jBmf=_3AnqEWHb+eTA6DtTfoU3tb=0RB0O+szw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 6 Nov 2023 15:25:43 +0100
Message-ID: <CAFULd4YPVcWL6_bo2T4O=a6ed9hTOakp2m1_XBF3w-uWhyd4dQ@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Use %rip-relative addressing in wakeup_64.S
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 3:14=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Nov 3, 2023 at 11:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > Instruction with %rip-relative address operand is one byte shorter than
> > its absolute address counterpart and is also compatible with position
> > independent executable (-fpie) build.
> >
> > No functional changes intended.
>
> I'm wondering what's the exact motivation for making this change.

Mainly to be consistent with what the compiler emits by default when a
symbol is accessed. As said in the commit message, the %rip-relative
access is also one byte shorter, and results in a position independent
code.

> Any urgent need for it doesn't seem to be there.

True. It's mostly a nice-to-have change.

Thanks,
Uros.

> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  arch/x86/kernel/acpi/wakeup_64.S | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wa=
keup_64.S
> > index d5d8a352eafa..94ff83f3d3fe 100644
> > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > @@ -17,7 +17,7 @@
> >          * Hooray, we are in Long 64-bit mode (but still running in low=
 memory)
> >          */
> >  SYM_FUNC_START(wakeup_long64)
> > -       movq    saved_magic, %rax
> > +       movq    saved_magic(%rip), %rax
> >         movq    $0x123456789abcdef0, %rdx
> >         cmpq    %rdx, %rax
> >         je      2f
> > @@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
> >         movw    %ax, %es
> >         movw    %ax, %fs
> >         movw    %ax, %gs
> > -       movq    saved_rsp, %rsp
> > +       movq    saved_rsp(%rip), %rsp
> >
> > -       movq    saved_rbx, %rbx
> > -       movq    saved_rdi, %rdi
> > -       movq    saved_rsi, %rsi
> > -       movq    saved_rbp, %rbp
> > +       movq    saved_rbx(%rip), %rbx
> > +       movq    saved_rdi(%rip), %rdi
> > +       movq    saved_rsi(%rip), %rsi
> > +       movq    saved_rbp(%rip), %rbp
> >
> > -       movq    saved_rip, %rax
> > +       movq    saved_rip(%rip), %rax
> >         ANNOTATE_RETPOLINE_SAFE
> >         jmp     *%rax
> >  SYM_FUNC_END(wakeup_long64)
> > @@ -72,11 +72,11 @@ SYM_FUNC_START(do_suspend_lowlevel)
> >
> >         movq    $.Lresume_point, saved_rip(%rip)
> >
> > -       movq    %rsp, saved_rsp
> > -       movq    %rbp, saved_rbp
> > -       movq    %rbx, saved_rbx
> > -       movq    %rdi, saved_rdi
> > -       movq    %rsi, saved_rsi
> > +       movq    %rsp, saved_rsp(%rip)
> > +       movq    %rbp, saved_rbp(%rip)
> > +       movq    %rbx, saved_rbx(%rip)
> > +       movq    %rdi, saved_rdi(%rip)
> > +       movq    %rsi, saved_rsi(%rip)
> >
> >         addq    $8, %rsp
> >         movl    $3, %edi
> > --

