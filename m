Return-Path: <linux-acpi+bounces-1262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9181D7E26E9
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1604B20D74
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26C28DB0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1C1EB58
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 14:14:40 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747799;
	Mon,  6 Nov 2023 06:14:39 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-582050ce2d8so766543eaf.0;
        Mon, 06 Nov 2023 06:14:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280079; x=1699884879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bi/AtLKXkzT1gGrzBKI3P0s6DBVld8spaSFbXp0Chkw=;
        b=dSOJJfsCZyP/VFZq5unavcPP+3FRifzEbaPkU+cB5IiaF3UBQfJ1phRK2IQAbhQBxB
         zpn//ZPNOZD/1tCQAiAyZ0FpUhLJGjTmBk70v5rJQKWHb3udvQNayz8+SBU7JihCH/CO
         Vhlspypqbj+LxpyjLAP3MxC1gG9hjDehByM1e8BaUHBC68WTvoTdQt/ElmeYp1jUgg/D
         oRcVhaGszg0jKhMeJ9N0lldoNnNgNjo9/6zzz4dJQ+OX5GuroD+GWhRXZDwGZ9/kXgPz
         G2vrDnZzUBXE/rW1P3zCuGTeKlYgThscT+kpRrK9QFNFRGAMdzrk13nP2UYXponjZuMW
         NBUA==
X-Gm-Message-State: AOJu0Yy4piUJrBOJjNhxQ8doWqlkGjU3K9PNT826HMvdguRUn+rB3Efn
	sX8SUTgXmibo7VOFZlHha4HCmRmqEV/NisEdRGfbTz2i
X-Google-Smtp-Source: AGHT+IE9jVdxadw4LpkCU0/Y+BuTANpPBRbyRZeuWcwbf1QsXYgVeZYjfIgd008rx8YZXl1jPBv5Ftq9qXZYoPCjXe4=
X-Received: by 2002:a4a:3390:0:b0:587:947b:31f4 with SMTP id
 q138-20020a4a3390000000b00587947b31f4mr5561208ooq.1.1699280079018; Mon, 06
 Nov 2023 06:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103104900.409470-1-ubizjak@gmail.com>
In-Reply-To: <20231103104900.409470-1-ubizjak@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 15:14:27 +0100
Message-ID: <CAJZ5v0iOY3u_jBmf=_3AnqEWHb+eTA6DtTfoU3tb=0RB0O+szw@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: Use %rip-relative addressing in wakeup_64.S
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 11:49=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Instruction with %rip-relative address operand is one byte shorter than
> its absolute address counterpart and is also compatible with position
> independent executable (-fpie) build.
>
> No functional changes intended.

I'm wondering what's the exact motivation for making this change.

Any urgent need for it doesn't seem to be there.

> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/kernel/acpi/wakeup_64.S | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wake=
up_64.S
> index d5d8a352eafa..94ff83f3d3fe 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -17,7 +17,7 @@
>          * Hooray, we are in Long 64-bit mode (but still running in low m=
emory)
>          */
>  SYM_FUNC_START(wakeup_long64)
> -       movq    saved_magic, %rax
> +       movq    saved_magic(%rip), %rax
>         movq    $0x123456789abcdef0, %rdx
>         cmpq    %rdx, %rax
>         je      2f
> @@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
>         movw    %ax, %es
>         movw    %ax, %fs
>         movw    %ax, %gs
> -       movq    saved_rsp, %rsp
> +       movq    saved_rsp(%rip), %rsp
>
> -       movq    saved_rbx, %rbx
> -       movq    saved_rdi, %rdi
> -       movq    saved_rsi, %rsi
> -       movq    saved_rbp, %rbp
> +       movq    saved_rbx(%rip), %rbx
> +       movq    saved_rdi(%rip), %rdi
> +       movq    saved_rsi(%rip), %rsi
> +       movq    saved_rbp(%rip), %rbp
>
> -       movq    saved_rip, %rax
> +       movq    saved_rip(%rip), %rax
>         ANNOTATE_RETPOLINE_SAFE
>         jmp     *%rax
>  SYM_FUNC_END(wakeup_long64)
> @@ -72,11 +72,11 @@ SYM_FUNC_START(do_suspend_lowlevel)
>
>         movq    $.Lresume_point, saved_rip(%rip)
>
> -       movq    %rsp, saved_rsp
> -       movq    %rbp, saved_rbp
> -       movq    %rbx, saved_rbx
> -       movq    %rdi, saved_rdi
> -       movq    %rsi, saved_rsi
> +       movq    %rsp, saved_rsp(%rip)
> +       movq    %rbp, saved_rbp(%rip)
> +       movq    %rbx, saved_rbx(%rip)
> +       movq    %rdi, saved_rdi(%rip)
> +       movq    %rsi, saved_rsi(%rip)
>
>         addq    $8, %rsp
>         movl    $3, %edi
> --

