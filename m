Return-Path: <linux-acpi+bounces-21411-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OfxHmJ2qWl77wAAu9opvQ
	(envelope-from <linux-acpi+bounces-21411-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 13:26:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E69211960
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 13:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44DE630A65C8
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B939A7EC;
	Thu,  5 Mar 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPJALvc+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC339A7E0
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713266; cv=none; b=UMthR7RbIEkDiUaUyokxhp1UxzjiRouo++/OGgDw1JW7WTzfTAdxrtG8r6OcXj4GaSYBgj00YkpyVupYN6Q0nEn9Q6hvhtNOdrUNF9DWVwsN5Xb9fIuZYRNwkOBumkqjjvm0R5kbNitpkcdDkwdzJTzG8v5HUK+FkkksTDmFmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713266; c=relaxed/simple;
	bh=D86PuWa6NH/eoJoY2tTCZyyoZIoFdAsfvzQUv8BN9yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8toVrmYWwkkTTSjHxVGQuOJ/9yHexRefPqG3jZSpjQFLzcJg8yZEBZD9PSBt/z0sV9JxYDxlRJ84HW/trN0g3tDEZ8UeyHsL8eUxH2aScKPZ/GHv0dyWWEuaWDbVCtS0r9//wagfOxMI2PwV/EEJ2HYx2Qr/ZqOaXI/t8C4I/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPJALvc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95C9C2BCB0
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772713265;
	bh=D86PuWa6NH/eoJoY2tTCZyyoZIoFdAsfvzQUv8BN9yo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XPJALvc+j4Seljolcxf1ol97pkrI0ldueLzPFd0VVai+kfynpI3kROF1JcPdT/TdB
	 sCPmpcIDERkA6CvT2MF9FI2H0bqQ2FcuzyaiYa30DkYWVOVnH7/NX5eaCLBmot7Ns9
	 hWSDG4sZKJN7WzwKK1G/ucBvkE+xkBj53tP95ny5+o0Fh7HgoA/W4YfAmYr1ucX6kL
	 9WiwI6Her2js1Krrdjs+GbU+yEy7/j50OhQU0tdQt7FVPfacZ4AUKtfT4nstXNvMw/
	 pi2Y8s9Y5JRDoK7rTIk8yxF5fM+aAb6kocup4we+5BqBdAvU0d7ant0gClg+AyhVwg
	 lCqVj+TDX94Eg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ed9a23aaeso1258815fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 04:21:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfbhiNfurfnBoaSIK6AZ/pHGRrbQ58qTNstiP6CaqzpBGogBs0NOf24JeRPHDiKxzFdiY0De5sclNs@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqDObTzPZN/9ng+qiOT/wr37KvDgygNHnaayDSv+VxJaJPton
	DUT5S28/c8nlecXp7QAdkYvXL+ZP/KOzILHFi29GmzVj+DGWlfl+tIyY9wN8xQtiKh6KTVPp5dY
	M7Vhpx1t281cew7JE5pEPScqdFiClcdA=
X-Received: by 2002:a05:6871:529b:b0:416:3a7f:5ee5 with SMTP id
 586e51a60fabf-416abad0f51mr3151965fac.25.1772713264846; Thu, 05 Mar 2026
 04:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76675c4d49d3a8f72252076812ef8f22276230c2.1772282441.git.houwenlong.hwl@antgroup.com>
 <b5d7f0734005eb08f31e7b9b72e253efcd2614ab.1772282441.git.houwenlong.hwl@antgroup.com>
In-Reply-To: <b5d7f0734005eb08f31e7b9b72e253efcd2614ab.1772282441.git.houwenlong.hwl@antgroup.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 13:20:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ibAwNi95giT5tF-7UvZ4SijneHkOtOB1d83SbjYLv4MA@mail.gmail.com>
X-Gm-Features: AaiRm53W5_8nGkWmrEPfxN-dAJp7siRIAvcpD9cmFBt1l6FZ0NABi8Po-9KsTTU
Message-ID: <CAJZ5v0ibAwNi95giT5tF-7UvZ4SijneHkOtOB1d83SbjYLv4MA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI, x86/boot: Remove {set|get}_root_pointer() ACPI callbacks
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Kees Cook <kees@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Sohil Mehta <sohil.mehta@intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E0E69211960
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21411-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[antgroup.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 6:05=E2=80=AFAM Hou Wenlong <houwenlong.hwl@antgroup=
.com> wrote:
>
> After removing pvh_get_root_pointer(), the only get_root_pointer() ACPI
> callback is x86_default_get_root_pointer(). Move the implementation
> directly into acpi_arch_get_root_pointer() and remove the
> get_root_pointer() ACPI callback. Since the set_root_pointer() ACPI
> callback is also only x86_default_set_root_pointer(), remove it as well.
>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  arch/x86/include/asm/acpi.h     | 15 +++------------
>  arch/x86/include/asm/x86_init.h |  4 ----
>  arch/x86/kernel/acpi/boot.c     | 10 ----------
>  arch/x86/kernel/x86_init.c      |  2 --
>  4 files changed, 3 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index a03aa6f999d1..1286e044c623 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -17,6 +17,7 @@
>  #include <asm/cpufeature.h>
>  #include <asm/irq_vectors.h>
>  #include <asm/xen/hypervisor.h>
> +#include <asm/setup.h>
>
>  #include <xen/xen.h>
>
> @@ -160,20 +161,17 @@ static inline bool acpi_has_cpu_in_madt(void)
>  #define ACPI_HAVE_ARCH_SET_ROOT_POINTER
>  static __always_inline void acpi_arch_set_root_pointer(u64 addr)
>  {
> -       x86_init.acpi.set_root_pointer(addr);
> +       boot_params.acpi_rsdp_addr =3D addr;
>  }
>
>  #define ACPI_HAVE_ARCH_GET_ROOT_POINTER
>  static __always_inline u64 acpi_arch_get_root_pointer(void)
>  {
> -       return x86_init.acpi.get_root_pointer();
> +       return boot_params.acpi_rsdp_addr;
>  }
>
>  void acpi_generic_reduced_hw_init(void);
>
> -void x86_default_set_root_pointer(u64 addr);
> -u64 x86_default_get_root_pointer(void);
> -
>  #ifdef CONFIG_XEN_PV
>  /* A Xen PV domain needs a special acpi_os_ioremap() handling. */
>  extern void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys,
> @@ -193,13 +191,6 @@ static inline void disable_acpi(void) { }
>
>  static inline void acpi_generic_reduced_hw_init(void) { }
>
> -static inline void x86_default_set_root_pointer(u64 addr) { }
> -
> -static inline u64 x86_default_get_root_pointer(void)
> -{
> -       return 0;
> -}
> -
>  #endif /* !CONFIG_ACPI */
>
>  #define ARCH_HAS_POWER_INIT    1
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_i=
nit.h
> index 6c8a6ead84f6..254221eec395 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -132,13 +132,9 @@ struct x86_hyper_init {
>
>  /**
>   * struct x86_init_acpi - x86 ACPI init functions
> - * @set_root_pointer:          set RSDP address
> - * @get_root_pointer:          get RSDP address
>   * @reduced_hw_early_init:     hardware reduced platform early init
>   */
>  struct x86_init_acpi {
> -       void (*set_root_pointer)(u64 addr);
> -       u64 (*get_root_pointer)(void);
>         void (*reduced_hw_early_init)(void);
>  };
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index a3f2fb1fea1b..6365a75d9e1c 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1828,16 +1828,6 @@ void __init arch_reserve_mem_area(acpi_physical_ad=
dress addr, size_t size)
>         e820__update_table_print();
>  }
>
> -void x86_default_set_root_pointer(u64 addr)
> -{
> -       boot_params.acpi_rsdp_addr =3D addr;
> -}
> -
> -u64 x86_default_get_root_pointer(void)
> -{
> -       return boot_params.acpi_rsdp_addr;
> -}
> -
>  #ifdef CONFIG_XEN_PV
>  void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size =
size)
>  {
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index ebefb77c37bb..4a1a70366b71 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -121,8 +121,6 @@ struct x86_init_ops x86_init __initdata =3D {
>         },
>
>         .acpi =3D {
> -               .set_root_pointer       =3D x86_default_set_root_pointer,
> -               .get_root_pointer       =3D x86_default_get_root_pointer,
>                 .reduced_hw_early_init  =3D acpi_generic_reduced_hw_init,
>         },
>  };
> --
> 2.31.1
>
>

