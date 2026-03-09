Return-Path: <linux-acpi+bounces-21546-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGEaE13LrmnEIwIAu9opvQ
	(envelope-from <linux-acpi+bounces-21546-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 14:30:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D3F239C26
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C9B5301E995
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037EE3B8D53;
	Mon,  9 Mar 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0dcdh/U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D399F3AE71C
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063002; cv=none; b=tuAyRUiVAAJ8SPWvLkxw1m6q6aywhEHxRATqs8OKnqA4FcdJS8Me679m5+/tn4U9OXg+QoZWKnqlFhTpExb3eXofsW5Av6iLtE09ftugvsKXHhvwIBMBYLmiavZfwabxwrNADHVXqErlri6F1LOYngZfsYWlVScWnEWaxhng/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063002; c=relaxed/simple;
	bh=/UpE9x4v0F+CNAUIdLtq+XMTp7Kikc6ThmOhH3qFRSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3ZXFcl9xC4u7M22if0n5oSZTAkncIpCAamRlwjZ2hzH0X4xzaNyiRW8+0fkmlSVPrZJhH7QnF0YcyuGAsYmA1DiOIZw9DWvSdVCVu75IyOX3NvXENwHlMBBw6ACT9X3TgcN8kGhBYPBA5YFDjJ/ZrsOQN9CQ8MIKiKPF1mBtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0dcdh/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87314C2BC86
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773063002;
	bh=/UpE9x4v0F+CNAUIdLtq+XMTp7Kikc6ThmOhH3qFRSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l0dcdh/UsmikM8MhM7nnR9sFSwzhhnHrl5yw3ultKfrvKHqgLOPe7/BW9hdQAoOpy
	 2Jagib5TrJblrZ+MwYWhCwOlsEKFr5tiqHf2B4RgcY4YPgnSU/j6abw1W4rr/SrCtp
	 JquQI0E00Vm3CrfF9UO5M2Kd06qBxfeXDtxYUe19rW3uccesip9eGAdc4f877FcIYk
	 KuYxa3VsYebvqPtfvjUpPzU3BVa0qGHWfflqKVGSCTV4EblYvn7dvpEyvAon+iGnad
	 wTLQTTJDsWmUXfDWDAe+5vZIZcWeI+3fLilJuh1zyd8f083A0ym0NZLLJIWixwJek/
	 c9scmPFxwT/fQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b940f962a82so656059566b.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 06:30:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7ddE+yObVYZLNFJJFsrjiTwRheFzF4RqP5JgamTyHDMyQ5BkTb1jzxA2WYaPUSEfUiNJpW2Z5c48X@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqyVFBHY1S0alpqt5qIq+r1j32L3BMHoKMqvWmqrfL/MDLjgz
	grqoeShOX7y73OtB7J3inOH0iBefBXk8yQ+Jy19gnvj9s7iIkeMeRkaw3YV3JMlqTH4N5s3IH2e
	V6uoDKcJZlIqc0NiVxxXoaceeRK9fNeA=
X-Received: by 2002:a17:906:6a0c:b0:b8e:3d49:25db with SMTP id
 a640c23a62f3a-b942e00db25mr648759166b.54.1773063000939; Mon, 09 Mar 2026
 06:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303003625.39035-1-fengchengwen@huawei.com>
 <20260309041659.18815-1-fengchengwen@huawei.com> <20260309041659.18815-2-fengchengwen@huawei.com>
In-Reply-To: <20260309041659.18815-2-fengchengwen@huawei.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 9 Mar 2026 21:29:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Cy1OuReaoGotZvdvHWLic_ECESFVZgbvNpk2HVjPjuw@mail.gmail.com>
X-Gm-Features: AaiRm53999Ro86GVlT52rErQab9_tcwK7Kxxf4dLpRSgjEOSn5mzv7jn4vq_ISk
Message-ID: <CAAhV-H7Cy1OuReaoGotZvdvHWLic_ECESFVZgbvNpk2HVjPjuw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: Rename get_acpi_id_for_cpu() to
 acpi_get_cpu_acpi_id() on non-x86
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, 
	linux-acpi@vger.kernel.org, wei.huang2@amd.com, Eric.VanTassell@amd.com, 
	jonathan.cameron@huawei.com, wangzhou1@hisilicon.com, wanghuiqiang@huawei.com, 
	liuyonglong@huawei.com, stable@vger.kernel.org, jeremy.linton@arm.com, 
	sunilvl@oss.qualcomm.com, chenhuacai@loongson.cn, wangliupu@loongson.cn, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E5D3F239C26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21546-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-0.957];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi, Chengwen,

On Mon, Mar 9, 2026 at 12:17=E2=80=AFPM Chengwen Feng <fengchengwen@huawei.=
com> wrote:
>
> To unify the CPU ACPI ID retrieval interface across architectures,
> rename the existing get_acpi_id_for_cpu() function to
> acpi_get_cpu_acpi_id() on arm64/riscv/loongarch platforms.
Can we also rename cpu_acpi_id() to acpi_get_cpu_acpi_id() for x86?

Huacai

>
> This is a pure rename with no functional change, preparing for a
> consistent ACPI Processor UID retrieval interface across all ACPI-enabled
> platforms.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  arch/arm64/include/asm/acpi.h      |  4 ++--
>  arch/loongarch/include/asm/acpi.h  |  2 +-
>  arch/riscv/include/asm/acpi.h      |  2 +-
>  arch/riscv/kernel/acpi_numa.c      |  2 +-
>  drivers/acpi/pptt.c                | 16 ++++++++--------
>  drivers/acpi/riscv/rhct.c          |  2 +-
>  drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
>  7 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.=
h
> index c07a58b96329..202107aeb05b 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -114,7 +114,7 @@ static inline bool acpi_has_cpu_in_madt(void)
>  }
>
>  struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
> -static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
> +static inline u32 acpi_get_cpu_acpi_id(unsigned int cpu)
>  {
>         return  acpi_cpu_get_madt_gicc(cpu)->uid;
>  }
> @@ -125,7 +125,7 @@ static inline int get_cpu_for_acpi_id(u32 uid)
>
>         for (cpu =3D 0; cpu < nr_cpu_ids; cpu++)
>                 if (acpi_cpu_get_madt_gicc(cpu) &&
> -                   uid =3D=3D get_acpi_id_for_cpu(cpu))
> +                   uid =3D=3D acpi_get_cpu_acpi_id(cpu))
>                         return cpu;
>
>         return -EINVAL;
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/a=
sm/acpi.h
> index 7376840fa9f7..89c6c8f52cc3 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -40,7 +40,7 @@ extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE=
_PIC];
>
>  extern int __init parse_acpi_topology(void);
>
> -static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
> +static inline u32 acpi_get_cpu_acpi_id(unsigned int cpu)
>  {
>         return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
>  }
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.=
h
> index 6e13695120bc..1d23681b61b5 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -61,7 +61,7 @@ static inline void arch_fix_phys_package_id(int num, u3=
2 slot) { }
>
>  void acpi_init_rintc_map(void);
>  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> -static inline u32 get_acpi_id_for_cpu(int cpu)
> +static inline u32 acpi_get_cpu_acpi_id(int cpu)
>  {
>         return acpi_cpu_get_madt_rintc(cpu)->uid;
>  }
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.=
c
> index 130769e3a99c..c2eb4824d0f7 100644
> --- a/arch/riscv/kernel/acpi_numa.c
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -40,7 +40,7 @@ static inline int get_cpu_for_acpi_id(u32 uid)
>         int cpu;
>
>         for (cpu =3D 0; cpu < nr_cpu_ids; cpu++)
> -               if (uid =3D=3D get_acpi_id_for_cpu(cpu))
> +               if (uid =3D=3D acpi_get_cpu_acpi_id(cpu))
>                         return cpu;
>
>         return -EINVAL;
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..c1a8fba4c2b2 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -459,7 +459,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_he=
ader *table,
>  {
>         struct acpi_pptt_cache *found_cache;
>         struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> -       u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +       u32 acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>         struct cacheinfo *this_leaf;
>         unsigned int index =3D 0;
>         struct acpi_pptt_processor *cpu_node =3D NULL;
> @@ -546,7 +546,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_tabl=
e_header *table,
>                                      unsigned int cpu, int level, int fla=
g)
>  {
>         struct acpi_pptt_processor *cpu_node;
> -       u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +       u32 acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>
>         cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id);
>         if (cpu_node) {
> @@ -622,7 +622,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cp=
u, int level, int flag)
>  static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>  {
>         struct acpi_table_header *table;
> -       u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +       u32 acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>         struct acpi_pptt_processor *cpu_node =3D NULL;
>         int ret =3D -ENOENT;
>
> @@ -671,7 +671,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned in=
t *levels,
>
>         pr_debug("Cache Setup: find cache levels for CPU=3D%d\n", cpu);
>
> -       acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +       acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>         cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id);
>         if (!cpu_node)
>                 return -ENOENT;
> @@ -797,7 +797,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu)
>         if (!table)
>                 return -ENOENT;
>
> -       acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +       acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>         cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id);
>         if (!cpu_node || !cpu_node->parent)
>                 return -ENOENT;
> @@ -872,7 +872,7 @@ static void acpi_pptt_get_child_cpus(struct acpi_tabl=
e_header *table_hdr,
>         cpumask_clear(cpus);
>
>         for_each_possible_cpu(cpu) {
> -               acpi_id =3D get_acpi_id_for_cpu(cpu);
> +               acpi_id =3D acpi_get_cpu_acpi_id(cpu);
>                 cpu_node =3D acpi_find_processor_node(table_hdr, acpi_id)=
;
>
>                 while (cpu_node) {
> @@ -966,7 +966,7 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>         for_each_possible_cpu(cpu) {
>                 bool empty;
>                 int level =3D 1;
> -               u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +               u32 acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>                 struct acpi_pptt_cache *cache;
>                 struct acpi_pptt_processor *cpu_node;
>
> @@ -1030,7 +1030,7 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_i=
d, cpumask_t *cpus)
>         for_each_possible_cpu(cpu) {
>                 bool empty;
>                 int level =3D 1;
> -               u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +               u32 acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>                 struct acpi_pptt_cache *cache;
>                 struct acpi_pptt_processor *cpu_node;
>
> diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
> index caa2c16e1697..c15ce8c13136 100644
> --- a/drivers/acpi/riscv/rhct.c
> +++ b/drivers/acpi/riscv/rhct.c
> @@ -44,7 +44,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,=
 unsigned int cpu, const
>         struct acpi_rhct_isa_string *isa_node;
>         struct acpi_table_rhct *rhct;
>         u32 *hart_info_node_offset;
> -       u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +       u32 acpi_cpu_id =3D acpi_get_cpu_acpi_id(cpu);
>
>         BUG_ON(acpi_disabled);
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index 34430b68f602..506b661c60fd 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1115,7 +1115,7 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu=
 *cspmu)
>         if (affinity_flag =3D=3D ACPI_APMT_FLAGS_AFFINITY_PROC) {
>                 for_each_possible_cpu(cpu) {
>                         if (apmt_node->proc_affinity =3D=3D
> -                           get_acpi_id_for_cpu(cpu)) {
> +                           acpi_get_cpu_acpi_id(cpu)) {
>                                 cpumask_set_cpu(cpu, &cspmu->associated_c=
pus);
>                                 break;
>                         }
> --
> 2.17.1
>

