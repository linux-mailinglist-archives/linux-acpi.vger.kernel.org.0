Return-Path: <linux-acpi+bounces-4125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DB8728C2
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 21:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD511C21FAC
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E307B18E29;
	Tue,  5 Mar 2024 20:30:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A911134BD;
	Tue,  5 Mar 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670653; cv=none; b=IzlgGRqKiV73cbMlbeDnp50g3o+yr1gHgiqYn7x59QOFcEicMJ3mMlX1TlxzZyBfxpyIKUOvtlXcxudoZC5PSXSqqU5DO/pC/w4RUOoGO6cZ38xhXEJnRRDWk8ID302mSS4zV5SeRu7MyzPH8is53GZRDkXrY4A2CZvZ+3kxHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670653; c=relaxed/simple;
	bh=9C0XflL22G4FK2Xp6NX+RZBZfi99BNGkE22VoiRQ7Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8C0n4HuuIGnXrIwCVCCZNQVgQX97mgMYQLjXiOEfzCPGFQtNmfxBL+rvxOeHL/AlyHpLnEekUQn2RM5KOzY2p6CrQBuLAFtZUrLx05n0Yn6YrV99d9Kc0Vo7kidzNfkLKpGHzNms8aIDN0j5U5//8wY7mWQTPnwECGmMryV5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3be110bbff9so1723566b6e.1;
        Tue, 05 Mar 2024 12:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670651; x=1710275451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1KHeO8d/Gx1dKaGWO1Y1rxOFe+zyynKCQIDZAb8tjE=;
        b=mHfAihX8FsTGdnp4YRu/NprxzAYxeCgjz+Fg+S725ohQLK2bL8qT2rYboAno0NaDxB
         C9Lx+gdOG5Z3A2f9YFfv20t+aR9vqm76GijlvznhHyxMAUxmfjN6b2RmhFyaNAuK33eL
         /7b/VjdBQpe1dVqJ08t+xOTLmUBWP1eodnwFI+X/TVQl7dVZihuP/gtLXl3Aq1rhdvXg
         tsj302nA1ooPSixmtYVtpzE6c1qunrmx25pkQSV8Lbe43j0HJhGyItEhpQWCdmeDC7kR
         tDFTaLjm72nM9Qz1DskwlwfhlU1jFYJTpJkMeZZLzs5mYUl91Sc4Ek72YaYeWECO2NTF
         gKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvjUbjouSIAiTxQOOT+oRrDa3CdbOfrpKxKM4OukpKCgZ4P47DD5oRlh338lwbir3nW/GilL53H/SqxwghzGkKFZqKfv4eZkbshs+Q7akmiy/pA9EvOWkPznbuuJtPQFg93wXL
X-Gm-Message-State: AOJu0YxjgYMMyFEisWfRHN+CU6W1snuiD1qCErEyBknRYRBuvIN7qtoM
	sXlErJ3sQckWRkYbb81p8C+s0ZQtsRug17312gzPmuot3+m5db/7SxndfpGc97hQIte0792+kS5
	LXzT6LnkDTeXFpfzQ1lCoCfqTwpI=
X-Google-Smtp-Source: AGHT+IFlK4rv3fufHWWSM3/MUJ7IkPU7hUKs/lwzuEKN4nZbZ89nwuLN+wACA45JZBAgOuxYVxZjx7pP2r1JfdsD+e4=
X-Received: by 2002:a05:6871:58b:b0:220:fc89:d8ca with SMTP id
 u11-20020a056871058b00b00220fc89d8camr1720192oan.0.1709670651360; Tue, 05 Mar
 2024 12:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <07b62879-2445-4b0d-880a-be01a44820f8@linux.alibaba.com>
In-Reply-To: <07b62879-2445-4b0d-880a-be01a44820f8@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 21:30:40 +0100
Message-ID: <CAJZ5v0iggVOU4_o2qwe92e37r35ovLMGypvLqNevgydEdfNJEw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/cstate: fix mwait hint target cstate calc
To: He Rongguang <herongguang@linux.alibaba.com>
Cc: jacob.jun.pan@linux.intel.com, lenb@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	shannon.zhao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 7:14=E2=80=AFAM He Rongguang
<herongguang@linux.alibaba.com> wrote:
>
> According to x86 spec ([1] and [2]), mwait hint_address[7:4] adds 1 is
> the corresponding cstate, and 0xF means C0.
>
> ACPI cstate table usually only contains C1+, but nothing prevents ACPI
> firmware from presenting a cstate (maybe C1+) but using a mwait address C=
0
> (i.e., 0xF in ACPI FFH MWAIT hint address). And if this is the case, Linu=
x
> erroneously treat this cstate as C16, while actually this should be legal
> C0 state instead of C16, according to spec.
>
> Since ACPI firmware is out of Linux kernel scope, fix kernel handling of
> 0xF ->(to) C0 in this situation. This is found when tweak ACPI cstate
> table qemu presenting to VM.
>
> Also fix intel_idle case by the way for kernel code consistency.
>
> [1]. Intel SDM Vol 2, Table 4-11. MWAIT Hints
> Register (EAX): "Value of 0 means C1; 1 means C2 and so on
> Value of 01111B means C0".
>
> [2]. AMD manual Vol 3, MWAIT: "The processor C-state is EAX[7:4]+1, so to
> request C0 is to place the value F in EAX[7:4] and to request C1 is to
> place the value 0 in EAX[7:4].".
>
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---
> V1 -> V2: Amend commit message according to Rafael.
>
>   arch/x86/kernel/acpi/cstate.c | 4 ++--
>   drivers/idle/intel_idle.c     | 3 ++-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index 401808b47af3..f3ffd0a3a012 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -131,8 +131,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void
> *_cx)
>          cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
>
>          /* Check whether this particular cx_type (in CST) is supported
> or not */
> -       cstate_type =3D ((cx->address >> MWAIT_SUBSTATE_SIZE) &
> -                       MWAIT_CSTATE_MASK) + 1;
> +       cstate_type =3D (((cx->address >> MWAIT_SUBSTATE_SIZE) &
> +                       MWAIT_CSTATE_MASK) + 1) & MWAIT_CSTATE_MASK;
>          edx_part =3D edx >> (cstate_type * MWAIT_SUBSTATE_SIZE);
>          num_cstate_subtype =3D edx_part & MWAIT_SUBSTATE_MASK;
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index bcf1198e8991..e486027f8b07 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1934,7 +1934,8 @@ static void __init spr_idle_state_table_update(void=
)
>
>   static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
>   {
> -       unsigned int mwait_cstate =3D MWAIT_HINT2CSTATE(mwait_hint) + 1;
> +       unsigned int mwait_cstate =3D (MWAIT_HINT2CSTATE(mwait_hint) + 1)=
 &
> +                                       MWAIT_CSTATE_MASK;
>          unsigned int num_substates =3D (mwait_substates >> mwait_cstate =
*
> 4) &
>                                          MWAIT_SUBSTATE_MASK;
>
> --

Applied as 6.9 material with some edits in the subject and changelog.

Also, your email client mangles white space, so please consider using
a different one for sending patches.

Thanks!

