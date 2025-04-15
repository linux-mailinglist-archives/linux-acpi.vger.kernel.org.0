Return-Path: <linux-acpi+bounces-13053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5828A89FBA
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76F7161498
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280E153BE8;
	Tue, 15 Apr 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO5HfdoF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F0A932;
	Tue, 15 Apr 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724436; cv=none; b=lPgfJgGMPPFFWh3H0a6zPe2KPYuFEhwHXNItUWy4EtczSGz7S9L/lZeO+ryPpJxqZZrf0LsUf+9P1rw3w1yNSvx2+z9UwNK3bMI3qhfQ3osJuOLlBBwxL7UL1xwLq44pHRs+URY+txNCpsproCaziVxmmJW3qrONCxd6+P2hHR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724436; c=relaxed/simple;
	bh=jBqHI+bna5jQDbCCCGpudQ1H27YZoGINgslqFhNnZlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bqc2opdpxjJURjLw5t8UDjEZ2KLwoGVUzA46f3EzcgaQWXe2Fr7s+/qEkmY8KSWvlP72Dl4DuJg4PUStAKa3rTbdka3OwzPUTfsO+HbYx9f2LUl0u/jMlfdn4u8xCpUzzq0JQHG2rYNxZ3NUDP013WrvS36CVxtfG4mbM56C3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO5HfdoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B965FC4CEEB;
	Tue, 15 Apr 2025 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744724435;
	bh=jBqHI+bna5jQDbCCCGpudQ1H27YZoGINgslqFhNnZlo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vO5HfdoFyVpnYPMsIgsHFfMzsesYc66RFEfI74GKHYEDVmmf2GhthxIXMJqNl5KgG
	 20p5Msq9OZy37i6FyhiXM1vwT3prp1pZV0n4DVWZhG0QlN3UGM2QUqDQPLIw0dWqf1
	 lmgcD6+3QeaQrk/g15zLMM2oXr8vVq4nXlJq7RYSCcO7HG91nG+x35qOUuXiQgJcmS
	 BnpEdBdAM8fLBR4mgiiSnBXuOZuBRnXbg8JxGy9x+JiJUMls9FtIR+HQ0jG3WZOjFo
	 wGc21uUrhcaLFj9MaT6d28bMPGewTgqDdxPR58WCGZYe8I0+5joRdltGf5tsOKyJUe
	 tMcm7g0OjrW2w==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2cc36b39545so2476445fac.1;
        Tue, 15 Apr 2025 06:40:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7DsTU1yNWmnGJrRDX/ZJXwhd/QFyD9N6y6C9mNGCYE0GeqDniqnobXQ/D6Dll/Zw3G4Q6ljTc8SMh@vger.kernel.org, AJvYcCWgHUz1ehyHpGpj3BzU7gGjh87M55oCCCfCQVz2xJGivCgHOtnkG7NxLgFddQpFxlONkxHoVQdG2vxXhg9l@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy90w/rr88+teWV77k8GOjN0I9MgLWqrKyB1NhC2GnkCX35ZH7
	6JbY1Qn/YB+unoATaba04ZLmX8F1NSbfBqg7/UvNIgqF4QOChXb+pg2V0qLRPusWbK2UPWIosul
	uaOWCCVhkzVY0q1o7+h6bLDrzLlY=
X-Google-Smtp-Source: AGHT+IGwQp4RCMoX/Ex/ugsZa+U7tcs33lsbbzGLmJ5tPP6AO+j4BvcSzanRIN9GeWvMuXjFLWqHZk0by6Kp8bHgemI=
X-Received: by 2002:a05:6871:3a0b:b0:29d:c6dd:cc6c with SMTP id
 586e51a60fabf-2d1c19ed86emr2258149fac.15.1744724375190; Tue, 15 Apr 2025
 06:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411194820.3976363-1-chenyuan0y@gmail.com>
In-Reply-To: <20250411194820.3976363-1-chenyuan0y@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 15:39:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBfq7rQvNFJevqD3s_cASFT2eBqC0zoDWBT1gAsfqkCg@mail.gmail.com>
X-Gm-Features: ATxdqUF0vK61_k5nZKOzVGybvEUCCpILP5u-HvmCN60N7zBpXWocDNmZ_JTao1g
Message-ID: <CAJZ5v0hBfq7rQvNFJevqD3s_cASFT2eBqC0zoDWBT1gAsfqkCg@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: fix potential NULL deref in acpi_wakeup_cpu()
To: Chenyuan Yang <chenyuan0y@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, bhe@redhat.com, 
	kai.huang@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 9:48=E2=80=AFPM Chenyuan Yang <chenyuan0y@gmail.com=
> wrote:
>
> The result of memremap() may be NULL on failure, leading to a NULL
> dereference. Add explicit checks after memremap() call: if the
> MADT mailbox fails to map, return immediately.
>
> This is similar to the commit 966d47e1f27c
> ("efi: fix potential NULL deref in efi_mem_reserve_persistent").
>
> This is found by our static analysis tool KNighter.
>
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 2b5e22afae07 ("x86/acpi: Extract ACPI MADT wakeup code into a sepa=
rate file")

Well, it's good to add the author of the commit you're trying to fix
to the CC list.

Kirill, what do you think about this?

> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index f36f28405dcc..b386ec4b87c2 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -143,6 +143,10 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long=
 start_ip)
>                 acpi_mp_wake_mailbox =3D memremap(acpi_mp_wake_mailbox_pa=
ddr,
>                                                 sizeof(*acpi_mp_wake_mail=
box),
>                                                 MEMREMAP_WB);
> +               if (!acpi_mp_wake_mailbox) {
> +                       pr_err("Failed to remap MADT mailbox\n");
> +                       return -ENOMEM;
> +               }
>         }
>
>         /*
> --
> 2.34.1
>

