Return-Path: <linux-acpi+bounces-7675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40806957472
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 21:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9181F23855
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6331DF695;
	Mon, 19 Aug 2024 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab0ysEiI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618271DD389;
	Mon, 19 Aug 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095620; cv=none; b=l85a685zk7qCJXK9FEeuBYmehxGOnouuc637nNP4eN9rWAvxDMHaOUm6fWm55hQm+44nysuyFaHughqkVg2tDpOte7k1U5bhqi/6Gi6edZi1n+R6gDwL6g51J+q8Qvv+9SwmImyvba85biWK/u59LfEDiB/s1MWvnQCp8/XoANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095620; c=relaxed/simple;
	bh=RhQG3+5QvIBcDMyvpZvXMVI3HKjSuVTO/dQjDa3Ckag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3Z+A1zSZmhq+j7ZeFJbWhXtGTJyLZ29Zi6hOd+G8VVFhxuq5pitHdcRvXZedQLw0WITBWBnkoMXoMNtbJ7N+DfWUTytZH1h7MT9MK2Ylk8tPny55vnqSJJtV8K4Dmv8n6sY/kWkDF7EHpM3buZhH0skFQL6iK2Zg5TbvvMN2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab0ysEiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC18CC4AF1B;
	Mon, 19 Aug 2024 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724095618;
	bh=RhQG3+5QvIBcDMyvpZvXMVI3HKjSuVTO/dQjDa3Ckag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ab0ysEiIJtw2hGcVK56Ge+bDCV3g/xHbvtVF2a9tuF6c5m2pjsPaIYjL4UwIAPwHx
	 pmEqMPX0fW/sxInj/Eu/CL5hXki96I9GpV9WSxA1q22EB9cMiT0N5bOdQGdxgIlPge
	 spq09rmavppo7BEfSWHeWoT83ReoDhRREBdZdcOYkTbqLf3Xxg8neupG/tT9cRtHrP
	 0vxfHd2JrI18NPtMqmlb8uNj1dGxaHjiv7ckKyXy6G+T7aFceq2OduIexKdzbcEl+v
	 oF0JZKYs42gcFrbkdasSfU+HZJ3C2wyWxW/Wj3CN5Zm9FU/AsFKCY7vqbNGFG3DDKG
	 E370/pRaod/ng==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-268e0b13471so654575fac.2;
        Mon, 19 Aug 2024 12:26:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUmM8gSilsIbUwSHedkRDR2MJZqGUIQJeN2HjN6L0mfVEZpVRts7pwgnhRRQBRaGa42CjlY3e39Je2YSnFWTvpwONwkf416vg5fJtF1jzj3GAOovjRosjMyIVjWWVvsn2um0JbZu+z5g==
X-Gm-Message-State: AOJu0YzpI/QM/9BSYX04tOMgMVEY0st1tAI4Qm1mJTzAabr9Bwa54vQ3
	O7sOfQLUDL2KddW/Ttwhn48oBvyxVQ5NMwi7OpYG04bYvrMZUsyyKZeEyIML8zt+FBrSzURb4ce
	5OfCABI98Ct7nR/aqQ9Ea3oQKzt8=
X-Google-Smtp-Source: AGHT+IG9np/OdfXLQsEwBXl36PxM0+tZIfv8EhtHrVPeVC+a0R+i7GLo6DzF3FddPjFmq/RSeJyyID1GHABHnSL3l7E=
X-Received: by 2002:a05:6870:7b4b:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-2701c0a0273mr6552882fac.0.1724095618076; Mon, 19 Aug 2024
 12:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com> <20240819070827.3620020-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240819070827.3620020-3-kirill.shutemov@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 21:26:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gE=iqsJVPrihox0JYpC4-q08p3ELnNst0g+ExYNYWT5g@mail.gmail.com>
Message-ID: <CAJZ5v0gE=iqsJVPrihox0JYpC4-q08p3ELnNst0g+ExYNYWT5g@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] x86/acpi: Replace manual page table initialization
 with kernel_ident_mapping_init()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:08=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The function init_transition_pgtable() maps the page with
> asm_acpi_mp_play_dead() into an identity mapping.
>
> Replace manual page table initialization with kernel_ident_mapping_init()
> to avoid code duplication. Use x86_mapping_info::offset to get the page
> mapped at the correct location.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 73 ++++++------------------------
>  1 file changed, 15 insertions(+), 58 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index d5ef6215583b..78960b338be9 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -70,58 +70,6 @@ static void __init free_pgt_page(void *pgt, void *dumm=
y)
>         return memblock_free(pgt, PAGE_SIZE);
>  }
>
> -/*
> - * Make sure asm_acpi_mp_play_dead() is present in the identity mapping =
at
> - * the same place as in the kernel page tables. asm_acpi_mp_play_dead() =
switches
> - * to the identity mapping and the function has be present at the same s=
pot in
> - * the virtual address space before and after switching page tables.
> - */
> -static int __init init_transition_pgtable(pgd_t *pgd)
> -{
> -       pgprot_t prot =3D PAGE_KERNEL_EXEC_NOENC;
> -       unsigned long vaddr, paddr;
> -       p4d_t *p4d;
> -       pud_t *pud;
> -       pmd_t *pmd;
> -       pte_t *pte;
> -
> -       vaddr =3D (unsigned long)asm_acpi_mp_play_dead;
> -       pgd +=3D pgd_index(vaddr);
> -       if (!pgd_present(*pgd)) {
> -               p4d =3D (p4d_t *)alloc_pgt_page(NULL);
> -               if (!p4d)
> -                       return -ENOMEM;
> -               set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> -       }
> -       p4d =3D p4d_offset(pgd, vaddr);
> -       if (!p4d_present(*p4d)) {
> -               pud =3D (pud_t *)alloc_pgt_page(NULL);
> -               if (!pud)
> -                       return -ENOMEM;
> -               set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
> -       }
> -       pud =3D pud_offset(p4d, vaddr);
> -       if (!pud_present(*pud)) {
> -               pmd =3D (pmd_t *)alloc_pgt_page(NULL);
> -               if (!pmd)
> -                       return -ENOMEM;
> -               set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
> -       }
> -       pmd =3D pmd_offset(pud, vaddr);
> -       if (!pmd_present(*pmd)) {
> -               pte =3D (pte_t *)alloc_pgt_page(NULL);
> -               if (!pte)
> -                       return -ENOMEM;
> -               set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
> -       }
> -       pte =3D pte_offset_kernel(pmd, vaddr);
> -
> -       paddr =3D __pa(vaddr);
> -       set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> -
> -       return 0;
> -}
> -
>  static int __init acpi_mp_setup_reset(u64 reset_vector)
>  {
>         struct x86_mapping_info info =3D {
> @@ -130,6 +78,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector=
)
>                 .page_flag      =3D __PAGE_KERNEL_LARGE_EXEC,
>                 .kernpg_flag    =3D _KERNPG_TABLE_NOENC,
>         };
> +       unsigned long mstart, mend;
>         pgd_t *pgd;
>
>         pgd =3D alloc_pgt_page(NULL);
> @@ -137,8 +86,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vector=
)
>                 return -ENOMEM;
>
>         for (int i =3D 0; i < nr_pfn_mapped; i++) {
> -               unsigned long mstart, mend;
> -
>                 mstart =3D pfn_mapped[i].start << PAGE_SHIFT;
>                 mend   =3D pfn_mapped[i].end << PAGE_SHIFT;
>                 if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) =
{
> @@ -147,14 +94,24 @@ static int __init acpi_mp_setup_reset(u64 reset_vect=
or)
>                 }
>         }
>
> -       if (kernel_ident_mapping_init(&info, pgd,
> -                                     PAGE_ALIGN_DOWN(reset_vector),
> -                                     PAGE_ALIGN(reset_vector + 1))) {
> +       mstart =3D PAGE_ALIGN_DOWN(reset_vector);
> +       mend =3D mstart + PAGE_SIZE;
> +       if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
>                 kernel_ident_mapping_free(&info, pgd);
>                 return -ENOMEM;
>         }
>
> -       if (init_transition_pgtable(pgd)) {
> +       /*
> +        * Make sure asm_acpi_mp_play_dead() is present in the identity m=
apping
> +        * at the same place as in the kernel page tables.
> +        * asm_acpi_mp_play_dead() switches to the identity mapping and t=
he
> +        * function has be present at the same spot in the virtual addres=
s space

s/has be/must/

Otherwise LGTM

> +        * before and after switching page tables.
> +        */
> +       info.offset =3D __START_KERNEL_map - phys_base;
> +       mstart =3D PAGE_ALIGN_DOWN(__pa(asm_acpi_mp_play_dead));
> +       mend =3D mstart + PAGE_SIZE;
> +       if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
>                 kernel_ident_mapping_free(&info, pgd);
>                 return -ENOMEM;
>         }
> --
> 2.43.0
>

