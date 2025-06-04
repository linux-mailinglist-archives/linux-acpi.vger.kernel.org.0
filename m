Return-Path: <linux-acpi+bounces-14126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645FACDAEC
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 11:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C425316AE89
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279228C849;
	Wed,  4 Jun 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxA/Gsue"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F428B7ED;
	Wed,  4 Jun 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029015; cv=none; b=eZkD+SMnR75Tp4tWMNkLDYcjejSDprkxK+wxBAYyFpivy0MSECrRWV6oTBzwDNioN7mPKkAyKhDI0QYR8qV2X1hjxitggOU3W0Sul5eSjKSlwzZn+3fTKsZU74Mx1nw+gm0OcbZPRBaWJ3GwNk2N7UpNGN3tEmw6FPx5M4HX/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029015; c=relaxed/simple;
	bh=4XsM1mwEJuog2VF4KvPV9bu4b1v/w/WR88Lnj3fYsiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZS/31ZXZre6YxxlhFGHURIBu5Wb9VDkP6dLQxOIIBYOy4dVPXc8o7lgwkmsqYKr7qwd/IDfeHofHJ4WClLWJ2nmnxkSzdrpFUxAn2yurzpFA2sU8lEu9HnfC43O2Si+i4ZxqHXAh0btYVE4+M5RjQxMIFJMl4IJMQrWUPX1q1FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxA/Gsue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2EFC4AF0B;
	Wed,  4 Jun 2025 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749029014;
	bh=4XsM1mwEJuog2VF4KvPV9bu4b1v/w/WR88Lnj3fYsiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HxA/Gsuemf2DcY8BMao+TEFANZzj9kC4BFUIUBnZvpvBowABTB6Y9Imy4w648NOiX
	 XuUYVwSHC2OV6N1jG1bQO5olYOEB/Yxba5F5FlKiN67oMBBmQORLCwWSKkOLssd7vl
	 Gnuxgmcdl65KLhmLEvgEdXlKjojxy+Bv7vCbyniFc/uSEH+D2Z2WI1jOJq2tPU8eAH
	 7kAc/4zkqPtWHcVWYFHhhrYVEPJTOBNQwj/jEsY76/Zc2Og4P+g2N36varhaxI6NtC
	 Vqvp1gWUqKi6qWKNnekwgQbrEowFm51TsnzHbeV72QK8/7O0ZpHYza/I/fPXw5LMX5
	 Sorgx8gNDcH5w==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-408d7e2ad03so1944230b6e.1;
        Wed, 04 Jun 2025 02:23:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVC7D0HHhYpgbStfA8L/AsbBnOAx7KcICmFoUseVtzWtMC51xI80cdOoWpZQI/758H8GCHHFiOg8NkEoZWY@vger.kernel.org, AJvYcCXIwHgdvIzNqfBpF3+uK80zqnGhvnxERTzuQaug1LGygtNVOYEPzVyDTqMF7a6UGANKIKQUVgfdW4ZO@vger.kernel.org
X-Gm-Message-State: AOJu0YyiMyg3WQM3ROIrYQA5ihv7zVDJaKKYKKCA5+kQScX94ilWgwWk
	J5yD77PDfL+NLyiDrFSdF8R1czaFXGgihZZasVyTzotmobM5fAIKzHPJu7DYdNe0nlUrLO9V977
	wXckbvvN4DmvXiJUf7yHaoltiff5u/sw=
X-Google-Smtp-Source: AGHT+IGeAE3e+SRqBmPSi7SR3JkCnSTrhPk6TQUJbkYXOJBaJph89XQsZ/9euL5rpS9aR/+RIGtXcIQJms68QE8EtpE=
X-Received: by 2002:a05:6808:2f19:b0:3f8:1df6:40f with SMTP id
 5614622812f47-408f0efeca9mr1826673b6e.15.1749029013555; Wed, 04 Jun 2025
 02:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530175420.1277-1-khaliidcaliy@gmail.com>
In-Reply-To: <20250530175420.1277-1-khaliidcaliy@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Jun 2025 11:23:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9A4XC15mDLcZyop2TOOV=KTKNDZsqnUbza0NqH6f9sQ@mail.gmail.com>
X-Gm-Features: AX0GCFtryV6M2hjXcKMBFG1uUYrgw5uAzHIOlWehu-0nziEWbn8Y6MGpxkoEw1s
Message-ID: <CAJZ5v0j9A4XC15mDLcZyop2TOOV=KTKNDZsqnUbza0NqH6f9sQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] x86/ACPI: invalidate all cache lines on ACPI
 C-state transitions
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: rafael@kernel.org, enb@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 7:54=E2=80=AFPM Khalid Ali <khaliidcaliy@gmail.com>=
 wrote:
>
> From: Khalid Ali <khaliidcaliy@gmail.com>
>
> According to ACPI spec 6.4 and 6.5, upon C-state

Which section?

> transitions (specifically C2 and C3) it is required and explicitly
> mentioned to invalidate and writeback all modified cache line using
> WBINVD.
>
> However the current ACPI C-state entry using monitor/mwait instructions
> it have been used CLFLUSH by flushing the cache line associated by
> monitored address. That what all about this patch addresses,
> invalidating all cache lines instead of single cache line.
>
> Let me know if there any reason and decisions behind the current
> implementation.

I think that Peter has answered this already.

Anyway: Is there any practical reason to make this change?  For
instance, any system that doesn't work before it and works after it?

> Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
> ---
>  arch/x86/kernel/acpi/cstate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.=
c
> index d5ac34186555..eb3d435e08ad 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -222,6 +222,9 @@ void __cpuidle acpi_processor_ffh_cstate_enter(struct=
 acpi_processor_cx *cx)
>         struct cstate_entry *percpu_entry;
>
>         percpu_entry =3D per_cpu_ptr(cpu_cstate_entry, cpu);
> +       /* flush and invalidate all modified cache line on C3 and C2 stat=
e entry*/
> +       if (cx->type =3D=3D ACPI_STATE_C3 || cx->type =3D=3D ACPI_STATE_C=
2)
> +               wbinvd();
>         mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
>                               percpu_entry->states[cx->index].ecx);
>  }
> --

