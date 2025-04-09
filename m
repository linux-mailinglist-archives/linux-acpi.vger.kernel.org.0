Return-Path: <linux-acpi+bounces-12911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9085A82798
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1772B7B3C4C
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9857265626;
	Wed,  9 Apr 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6b+5FET"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B82561CE;
	Wed,  9 Apr 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208408; cv=none; b=HrS37vNeCabEs08KivMzJIH92z9aqduEHYEKyrWGl+AzRhKKtynxR3WP62mZmfiPatx5iN//nI/88DBjP0QXAVYjTAGXUNyrv2MwSGA3dKwtYhfGA1Ql0lz41LO2oyPFW1zQ1R0yp4JN2IyYtaXrxb5q8HJ6259ilO27uUMmL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208408; c=relaxed/simple;
	bh=BG/OzJES1M7Q6UgqXIWZo0kbqsw0xFTv9avIXvDfKl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF/9gaBXjh0KIPuqz1O92g9VO3SxtoIthdiGNLiDbdTw7t1NUufoNVAwm/yTIqOGFYEuZW3rwBuf8xoTlIcipVvugIqNeiTz4jUZoCdyF7rg+xRjzKS137YJlpwsfw/jr3WNPUm7XQL+bFgeFjzv/NXo1L+2CelDIcUQo9hdwDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6b+5FET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF9C4CEE7;
	Wed,  9 Apr 2025 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744208408;
	bh=BG/OzJES1M7Q6UgqXIWZo0kbqsw0xFTv9avIXvDfKl8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A6b+5FET2spOgRa2vacU9wjGBMCpfe11c1PD8P8XThPDX4dJUL2NG8ORLineivW1s
	 E8KhoXiacRx2toMKAt13wzybtd94ack8IqWGGzxRaQqJa1RuDhflgvhEutEiyNBjVj
	 YdGcrOD8CnUmFEjd2y6kr0JHq530JlofuMx3whHajwo3jL2HyBERFMjS2NFd6nUW5b
	 qBPe7eu0YmBc27zezOWBF2Svwvz60gJC98D1f3uc2diOLLxFGfZWWWguFa/VK0ctRL
	 DPbnQ+u8bKlEZ537fh9ztwNMEISzOxiRJpCrO+a1i+vxe9N0Zy1AxSVXCUNAcHT512
	 8/KZy+OrNJ7jA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso1181464666b.3;
        Wed, 09 Apr 2025 07:20:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSA+4BzIVsPgMWTmcoFq53J3ct23AcrcS5EXjxqCsOmqgPSn8Ipg7RrxTsRa2C9kPL6oLzY1flJozu@vger.kernel.org, AJvYcCV6ckfNUMr02JdM9vyEw3GzBCg6HJcwL9zXAEBvSSEwjYjZZqypF/Fkd/gYAhyEcN6br55IQyC7F/pT@vger.kernel.org, AJvYcCWV54g71DbphUGQOc6GOIgXOJ9mDxnEPIXmN/SV3FrukbtF0BRQsTGvGOS66CGzH+O3ZRA8CEuzWgETSvz2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hFmxfqRKDjnERpibyLcW7BEnDMgxJKxl/+AIhmKFkfoLRI3u
	XZxmffTgzwrERHPgYfqNrTw5LmyqgQ9Ag1GQF5ix2dQ80H2gwb8U+A7nXKgQEwGYD7bK2JfhVSD
	q6isKuFTVHxVxoLunWP8crCn5PBQ=
X-Google-Smtp-Source: AGHT+IFnF6UDYloYX0LOUBH6jYkuCNYIOTsP2lHmKeGs/z9SZN3K4qP8DEu2FfQoknF3uccBjAD217TToS6ep+829MQ=
X-Received: by 2002:a17:907:971a:b0:ac4:3cd:2cb2 with SMTP id
 a640c23a62f3a-aca9b607dcemr354551866b.1.1744208406974; Wed, 09 Apr 2025
 07:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409070250.3225839-1-wangyuquan1236@phytium.com.cn>
In-Reply-To: <20250409070250.3225839-1-wangyuquan1236@phytium.com.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 9 Apr 2025 22:20:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59A797mfwxjEe8SO0JioxkF3H0Rr0E_TK1qn0PHdRMXA@mail.gmail.com>
X-Gm-Features: ATxdqUHdB7qVVvs9U6XaymRSOHZ0sp8fImlHDnojMC_VV6MWDytUBwxnn0hxTYI
Message-ID: <CAAhV-H59A797mfwxjEe8SO0JioxkF3H0Rr0E_TK1qn0PHdRMXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] LoongArch: Introduce the numa_memblks conversion
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: kernel@xen0n.name, jiaxun.yang@flygoat.com, rppt@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, Jonathan.Cameron@huawei.com, 
	dave.hansen@linux.intel.com, dan.j.williams@intel.com, 
	alison.schofield@intel.com, chenbaozi@phytium.com.cn, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yuquan,

On Wed, Apr 9, 2025 at 3:03=E2=80=AFPM Yuquan Wang
<wangyuquan1236@phytium.com.cn> wrote:
>
> "mm: introduce numa_memblks"(87482708210f) has moved numa_memblks
> from x86 to the generic code, but loongarch was left out of this
> conversion.
>
> This patch introduces the generic numa_memblks.
Thank you for your patch, but it cause many errors:
loongarch64-linux-ld: mm/numa_memblks.o: in function
`memory_add_physaddr_to_nid':
numa_memblks.c:(.text+0x60): multiple definition of
`memory_add_physaddr_to_nid';
arch/loongarch/mm/init.o:init.c:(.text+0x0): first defined here
loongarch64-linux-ld: mm/numa_memblks.o: in function `numa_set_distance':
numa_memblks.c:(.init.text+0x248): multiple definition of
`numa_set_distance';
arch/loongarch/kernel/acpi.o:acpi.c:(.init.text+0x534): first defined
here
loongarch64-linux-ld: mm/numa_memblks.o: in function `.LANCHOR2':
numa_memblks.c:(.init.data+0x0): multiple definition of
`numa_nodes_parsed';
arch/loongarch/kernel/numa.o:numa.c:(.init.data+0x0): first defined
here
make[2]: *** [scripts/Makefile.vmlinux_o:72=EF=BC=9Avmlinux.o] =E9=94=99=E8=
=AF=AF 1
make[1]: *** [/home/chenhuacai/linux-official.git/Makefile:1223=EF=BC=9Avml=
inux_o] =E9=94=99=E8=AF=AF 2
make: *** [Makefile:248=EF=BC=9A__sub-make] =E9=94=99=C3=A8=C2=AF=C2=AF 2
  INSTALL /home/chenhuacai/dest/lib/modules/6.15.0-rc1+/vdso/vdso.so

It cannot be fixed easily, but I will try my best to do that based on
your patch.

Huacai

>
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>
> Background
> ----------
> I am managed to land the patch[1] "mm: numa_memblks: introduce numa_add_r=
eserved_memblk"
> but kernel test CI noticed build errors[2] from loongarch64-linux-gcc.
>
> Link:
> [1]: https://lore.kernel.org/all/20250409040121.3212489-1-wangyuquan1236@=
phytium.com.cn/
> [2]: https://lore.kernel.org/all/202503282026.QNaOAK79-lkp@intel.com/
>
>  arch/loongarch/Kconfig            |  1 +
>  arch/loongarch/include/asm/numa.h | 14 ----------
>  arch/loongarch/kernel/numa.c      | 43 +------------------------------
>  3 files changed, 2 insertions(+), 56 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 067c0b994648..5906ccd06705 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -186,6 +186,7 @@ config LOONGARCH
>         select MODULES_USE_ELF_RELA if MODULES
>         select NEED_PER_CPU_EMBED_FIRST_CHUNK
>         select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +       select NUMA_MEMBLKS
>         select OF
>         select OF_EARLY_FLATTREE
>         select PCI
> diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/a=
sm/numa.h
> index b5f9de9f102e..bbf9f70bd25f 100644
> --- a/arch/loongarch/include/asm/numa.h
> +++ b/arch/loongarch/include/asm/numa.h
> @@ -22,20 +22,6 @@ extern int numa_off;
>  extern s16 __cpuid_to_node[CONFIG_NR_CPUS];
>  extern nodemask_t numa_nodes_parsed __initdata;
>
> -struct numa_memblk {
> -       u64                     start;
> -       u64                     end;
> -       int                     nid;
> -};
> -
> -#define NR_NODE_MEMBLKS                (MAX_NUMNODES*2)
> -struct numa_meminfo {
> -       int                     nr_blks;
> -       struct numa_memblk      blk[NR_NODE_MEMBLKS];
> -};
> -
> -extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> -
>  extern void __init early_numa_add_cpu(int cpuid, s16 node);
>  extern void numa_add_cpu(unsigned int cpu);
>  extern void numa_remove_cpu(unsigned int cpu);
> diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
> index 30a72fd528c0..0ed384635566 100644
> --- a/arch/loongarch/kernel/numa.c
> +++ b/arch/loongarch/kernel/numa.c
> @@ -18,6 +18,7 @@
>  #include <linux/efi.h>
>  #include <linux/irq.h>
>  #include <linux/pci.h>
> +#include <linux/numa_memblks.h>
>  #include <asm/bootinfo.h>
>  #include <asm/loongson.h>
>  #include <asm/numa.h>
> @@ -145,48 +146,6 @@ void numa_remove_cpu(unsigned int cpu)
>         cpumask_clear_cpu(cpu, &cpus_on_node[nid]);
>  }
>
> -static int __init numa_add_memblk_to(int nid, u64 start, u64 end,
> -                                    struct numa_meminfo *mi)
> -{
> -       /* ignore zero length blks */
> -       if (start =3D=3D end)
> -               return 0;
> -
> -       /* whine about and ignore invalid blks */
> -       if (start > end || nid < 0 || nid >=3D MAX_NUMNODES) {
> -               pr_warn("NUMA: Warning: invalid memblk node %d [mem %#010=
Lx-%#010Lx]\n",
> -                          nid, start, end - 1);
> -               return 0;
> -       }
> -
> -       if (mi->nr_blks >=3D NR_NODE_MEMBLKS) {
> -               pr_err("NUMA: too many memblk ranges\n");
> -               return -EINVAL;
> -       }
> -
> -       mi->blk[mi->nr_blks].start =3D PFN_ALIGN(start);
> -       mi->blk[mi->nr_blks].end =3D PFN_ALIGN(end - PAGE_SIZE + 1);
> -       mi->blk[mi->nr_blks].nid =3D nid;
> -       mi->nr_blks++;
> -       return 0;
> -}
> -
> -/**
> - * numa_add_memblk - Add one numa_memblk to numa_meminfo
> - * @nid: NUMA node ID of the new memblk
> - * @start: Start address of the new memblk
> - * @end: End address of the new memblk
> - *
> - * Add a new memblk to the default numa_meminfo.
> - *
> - * RETURNS:
> - * 0 on success, -errno on failure.
> - */
> -int __init numa_add_memblk(int nid, u64 start, u64 end)
> -{
> -       return numa_add_memblk_to(nid, start, end, &numa_meminfo);
> -}
> -
>  static void __init node_mem_init(unsigned int node)
>  {
>         unsigned long start_pfn, end_pfn;
> --
> 2.34.1
>
>

