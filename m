Return-Path: <linux-acpi+bounces-7780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442C495B53E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F46E1C22A0C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE81C9450;
	Thu, 22 Aug 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4yzCY7H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF3175D3D;
	Thu, 22 Aug 2024 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330746; cv=none; b=qQkgfhLl9V12qaQqTa762dDedungZAfTVPvfGRMUJpYjtFjMkHF3T1JM5Wdr5nWrcW5Kt5zeEwvSDvN4SeramiU2wim7IGF089n6AEgyraFNbGFaN3qVhdDsVFuJjDyHwocQl2/Kh0e3ZiYI/QxpHD8QWpK50fmS6wfrKzDtpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330746; c=relaxed/simple;
	bh=Di4p4+v0FnEne9jMrOmDxjF40ow+E3giutnpqT8Zfpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C38nthEIPdSwJyEdidhDjxP9/A4g9EjZH66WUbglaUZFvLSMGY25Kxb250uDVPvCd3uVCj24Is8DnSbF4qb6FM5kP9qzBufk6PyzOLE4z2LfO7baOrj/hCdE/4eEWHNhJsrGpQImTXeJbLgpWTM2demSuh4rUVWNx6mllFAy6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4yzCY7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C65CC4AF09;
	Thu, 22 Aug 2024 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724330745;
	bh=Di4p4+v0FnEne9jMrOmDxjF40ow+E3giutnpqT8Zfpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J4yzCY7HcA8m2aJMdsb7b1ENWoDQvWRsrLRF/4gWDMOUdjq7FXuGSbhyJ1fSozQh7
	 UJUKAligizCA42iB0djcWYLail3/OA0zM5xUMBnwqnc7DL8px+V4+H10xi/GS3JNnf
	 8stYdfawiV5374AhNqG4bsEP9HyZfjm8RzMQxmPccq0IE6+f7HqYNqzfAINoQ9O6DE
	 NU6LJftEHqLNTe2WqEbncgFtYaXJgEdindz6b7CrWD57QMDEvRwzm6QqkVlYKgGqls
	 gKDf5kkoMUZkv1mrNpf2YTlH6jbJIJRESBdcQeRFYx3rY4VuyLe87WJ+IXBnfCvVuS
	 wYwNBHDmr4Fbg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-26fde6117cfso478480fac.1;
        Thu, 22 Aug 2024 05:45:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV71sdK15zBxDW/ZRKpDUIF4YLshfUur3z2nW6Y7EJFBmA1UDPL0AjGbfMjcdn+w3kgENBUzhJWdIuI@vger.kernel.org, AJvYcCXL/7nElQKVcOVpQz3upPprTZI5aWq8lU5r7k5h5/SynqWV53eMuqSjGwNwITMU26gMyuzFJa71onpma7iU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sgvcub46y708oiGLpfW1V1+r7Yx//JAZqqu2Cqe5oVXGhNhM
	7c4/3Y8xkWNkC9stoulp0mSPRfKsspgfxOvHpfTnsuQFeoiaZ+FQ8vYrXx9YgNKHr7vrwgQJIFx
	XG6nfS+AEWk/QgbKWgUISbIFzltM=
X-Google-Smtp-Source: AGHT+IEGZb5xMPcTDknaCvwZlHGd3VIcHVI0Za4rBBAcqzy0ZHdXm2ZdDarUZL1QWmVcLeZ/jBrVDJapPwn24bb0dh8=
X-Received: by 2002:a05:6871:5820:b0:258:3cd8:5108 with SMTP id
 586e51a60fabf-2738be91c4amr5580162fac.44.1724330744758; Thu, 22 Aug 2024
 05:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822124000.1171321-1-kirill.shutemov@linux.intel.com> <20240822124000.1171321-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240822124000.1171321-3-kirill.shutemov@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 14:45:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvH18RjTTDCvRCnofXSFLY6JBTsHspQkjyk-XeLXP3CQ@mail.gmail.com>
Message-ID: <CAJZ5v0jvH18RjTTDCvRCnofXSFLY6JBTsHspQkjyk-XeLXP3CQ@mail.gmail.com>
Subject: Re: [PATCHv4 2/4] x86/acpi: Replace manual page table initialization
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

On Thu, Aug 22, 2024 at 2:40=E2=80=AFPM Kirill A. Shutemov
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

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 73 ++++++------------------------
>  1 file changed, 15 insertions(+), 58 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index d5ef6215583b..f36f28405dcc 100644
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
> +        * function must be present at the same spot in the virtual addre=
ss space
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

