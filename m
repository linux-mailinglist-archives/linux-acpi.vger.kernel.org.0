Return-Path: <linux-acpi+bounces-20814-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF6LJ/IngGnv3QIAu9opvQ
	(envelope-from <linux-acpi+bounces-20814-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 05:28:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0953DC829D
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 05:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EDD3006B26
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 04:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD728F935;
	Mon,  2 Feb 2026 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WqFwtzKD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BE527B50C
	for <linux-acpi@vger.kernel.org>; Mon,  2 Feb 2026 04:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770006509; cv=pass; b=TO0R5ypF6pm6Mr2Oe1CfbXucT2aGV6kRyM+Za3hQtHu5xvjh46doU8Z4NkIoksEVv34mN0nIsqCTDlAupH7phDG5oE+y+PlP8KjGqjeG6s0CvkCRPPRr5T+v50oq1JTrPGNMMJG/oq4o5/WzTX4qDoAwCe9nFmGm8JmPxC683ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770006509; c=relaxed/simple;
	bh=pUVGgthQ839+VjER5eMc/k3P643CMKy+SrYbAa3c6hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ2L+Ili74BwdsropIA3fnYgoiV/situPcgGObBhmEGcDeZnhRkpkjaNdVvVO3+d0flm/XdFhbKvZJMujSgQA854G/G+V1Bc5eHrN/jGLLDL4b1l1VEs40JNeVAk2E+P9R5gEPzYoOOuonT/s8g5DIbZAJfWyJF9zmBnfw+DB+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WqFwtzKD; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38319cbc8fbso35841901fa.1
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 20:28:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770006505; cv=none;
        d=google.com; s=arc-20240605;
        b=NGzGkxyVNrOfskmR93YNJUXYN+SemyfoveWJ4j3WDElJwe8X/Z0uKgLJDCjX1WDFCV
         YFWplRsQyBnmvERkDF1WtYdzXhwXNmre9gDBj0hjwtwDsK1ITgP5D1wqZiwlgr1WVNab
         bbRiexD6mFOeLeQO7Kgad4hfBxBuDWWV5pngjzdsGNpUbDJLefC/qI0t3uESkJd/z6QH
         hfNGi/jOvjYAyso3TWPH9kqYm/pkNcJLV8wEvV5dgpNT+6gchIIjH48ZZVD+d8bq3LSR
         FwXklS4d/NERi5G97FOmDyCLehCt/xQX1RoQsO74axlDjCkaX9oO94vFvknfGGJf98Gl
         epxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2RZFio6MipuyvvHseqe3FSKD7GaQ7TcS4ZKkrjtcRy0=;
        fh=uc3DXUQ1YEnNSEf2bgrgKcBTUzTkea2H/BeqhhdWPdA=;
        b=PetqWLGeAdOb7kMBqR/92BKmYYhvRz7CGupkEaFY2O1QBbeDrUpTQsukNLwE0TGq5o
         5fc4Y1cJPH05icK3OmaXOpGs/Mo7LgiffJ7ISruIKkbaacbM4eYVHU8h3wsBWSciTG8j
         KLkoNdlm4lZ0lCW4J8FPE+S4G5VYC9AAosj8Nfo2FhTXblzDo87vgPCanRb/euQP1PJ5
         GXNpbK5nhavMXoilrmUata/ggSCaKveGbDw8R/D8d1mGsiPLPEWb6Lgn3IClmN3hiIJR
         o0231lv9/DFOH6pS8LVm+Q4u0aFQoy+KLrFPZ/hZikUC9/WKwDJuw0snWTX7/87Dg/cc
         DWbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770006505; x=1770611305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RZFio6MipuyvvHseqe3FSKD7GaQ7TcS4ZKkrjtcRy0=;
        b=WqFwtzKD6L7JZ5vXdcSuMzkgN1S7tJC17gpW45FmKVC99FTd/ox1Am8QF1nr2nlIcU
         GYQchnSQ8veZ2sCggxuCa6qwt3sGJvcMwamAAVyROgjLhuviyfLe0tqIVYf50xt7UumO
         e3eFIvCTap6NOYDWH7NYWGnK5wTJ7PuMRBWfAMcVg8DMZ1QnIF39vQyEVqE8GsR0pgqa
         5LVWIKKknLe0IlCWXIWAmq5Icq7j6BGsQZe23EssiplS0wLS4pUgDc2cQRgu2vP9C3lX
         PlQnfnF6TcEeQSSkUo7dnxdYXjefxf/6V5vFwcvhRzuQ7dKFZeobnI2zu9j/xQSUymmY
         cfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770006505; x=1770611305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2RZFio6MipuyvvHseqe3FSKD7GaQ7TcS4ZKkrjtcRy0=;
        b=EvhBbxICRz4rV5toahuqgQC3b2IVQkuOedbXs2BweN0zGib8UoniEwPXGDGIfUJ1Wz
         W6XffIUKH4quGUBDdn4qQdSJaHgWhNm0kwjbBX0hYewtTIk/qntI11CFim22JHstJDTO
         NHzFhg8R0GciB+Vk4QSA3Ewz/Rf3NFpZUDCoLN6A/3NaWGhIOdHfRVyex4evWyURkNqq
         crx/PaOSCPqADOY/dwgB7TOOoc+V482333ZAhE2UWBIcECPKPHesZ2xn8FeM7QHbdbnP
         RM9kzYtzkhGyACmc5TEDKjdf7yj1aG2iBoOedM2TW0csBdYpkNEpo0x7xWzS/bmAz3S9
         G9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUICxQwVoPV0uk0Xk2hcwREohQTt26ENrSJG/vXfMhOfl+XkRYMELYkp0odoCkMcydKmZgW/j62fYnI@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTfcXtYr6LhWFlkojBiepMxJgMMBjqBdIwedj4CR1t1qWqcD1
	5v8aWetAU4nm8sI1wuV0ZLB7dxIf6S2MmZkQl04GErA+DkBBxFggQ4xVGzt49nOQIE4r+kI93cl
	lLCl76q2z8pzQaGGlHPg4KYHHTuYo1CYeNm+zP94Gmf8kaqay669CXno=
X-Gm-Gg: AZuq6aK4GNyXaVI9nLwDnFiBJIvGmyAgBEK/zPxaGNBD61JKw+n9A6Lc9t0nbOtQq8o
	PdaXgx/RZF6tmdFu4Lw4+jw3tyQCWgO71WFAzlI3z//rsGT9/V5PGZMbs1VfL1qfwSN2wJ3lUSm
	0zux3Im9LnHtTFqJE/oqOwlFTBejl86zf+GhKxGlnXOxpXk4iDErD1NTtH8y2IfSE9CnSCrN5Ai
	0Lh9H9JHAH+UFn4zW77i1GSryEp2t22Aq9vOj1O0/PJX/HZxzFC58MGJ7GXKlX9gvrunPCWrF5F
	xA==
X-Received: by 2002:a17:907:74e:b0:b8d:be69:78bf with SMTP id
 a640c23a62f3a-b8dff5dd77amr628734866b.20.1770006490652; Sun, 01 Feb 2026
 20:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-3-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 2 Feb 2026 12:27:59 +0800
X-Gm-Features: AZwV_Qh6sUTHEto5Wt3yZWj9_zPb8qdXk_-HeJ2r0Rjdk_jaW_mUHlx9PsMyamI
Message-ID: <CAEEQ3wmK_4y-woedO0htdh3tnO=4SEGwRUrDsGLYRWwsPF105w@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 03/17] RISC-V: Add support for srmcfg
 CSR from Ssqosid ext
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20814-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	FREEMAIL_CC(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuiyunhui@bytedance.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,bytedance.com:dkim,brainfault.org:email]
X-Rspamd-Queue-Id: 0953DC829D
X-Rspamd-Action: no action

Hi Drew=EF=BC=8C

On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Add support for the srmcfg CSR defined in the Ssqosid ISA extension
> (Supervisor-mode Quality of Service ID). The CSR contains two fields:
>
>   - Resource Control ID (RCID) used determine resource allocation
>   - Monitoring Counter ID (MCID) used to track resource usage
>
> Requests from a hart to shared resources like cache will be tagged with
> these IDs. This allows the usage of shared resources to be associated
> with the task currently running on the hart.
>
> A srmcfg field is added to thread_struct and has the same format as the
> srmcfg CSR. This allows the scheduler to set the hart's srmcfg CSR to
> contain the RCID and MCID for the task that is being scheduled in. The
> srmcfg CSR is only written to if the thread_struct.srmcfg is different
> than the current value of the CSR.
>
> A per-cpu variable cpu_srmcfg is used to mirror that state of the CSR.
> This is because access to L1D hot memory should be several times faster
> than a CSR read. Also, in the case of virtualization, accesses to this
> CSR are trapped in the hypervisor.
>
> Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> Co-developed-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> Signed-off-by: Kornel Dul=C4=99ba <mindal@semihalf.com>
> [fustini: rename csr, refactor switch_to, rebase on upstream]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  MAINTAINERS                        |  7 +++++++
>  arch/riscv/Kconfig                 | 17 ++++++++++++++++
>  arch/riscv/include/asm/csr.h       |  8 ++++++++
>  arch/riscv/include/asm/processor.h |  3 +++
>  arch/riscv/include/asm/qos.h       | 41 ++++++++++++++++++++++++++++++++=
++++++
>  arch/riscv/include/asm/switch_to.h |  3 +++
>  arch/riscv/kernel/Makefile         |  2 ++
>  arch/riscv/kernel/qos/Makefile     |  2 ++
>  arch/riscv/kernel/qos/qos.c        |  5 +++++
>  9 files changed, 88 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa218..e98d553bd0ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22505,6 +22505,13 @@ F:     drivers/perf/riscv_pmu.c
>  F:     drivers/perf/riscv_pmu_legacy.c
>  F:     drivers/perf/riscv_pmu_sbi.c
>
> +RISC-V QOS RESCTRL SUPPORT
> +M:     Drew Fustini <fustini@kernel.org>

If you don=E2=80=99t mind, to help support RISC-V QoS resctrl development a=
nd
ensure interface stability, could you please add an 'R:' entry with my
email address?

> +L:     linux-riscv@lists.infradead.org
> +S:     Supported
> +F:     arch/riscv/include/asm/qos.h
> +F:     arch/riscv/kernel/qos/
> +
>  RISC-V RPMI AND MPXY DRIVERS
>  M:     Rahul Pathak <rahul@summations.net>
>  M:     Anup Patel <anup@brainfault.org>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6b39f37f769a..35a6238b02c5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -595,6 +595,23 @@ config RISCV_ISA_SVNAPOT
>
>           If you don't know what to do here, say Y.
>
> +config RISCV_ISA_SSQOSID
> +       bool "Ssqosid extension support for supervisor mode Quality of Se=
rvice ID"
> +       default y
> +       help
> +         Adds support for the Ssqosid ISA extension (Supervisor-mode
> +         Quality of Service ID).
> +
> +         Ssqosid defines the srmcfg CSR which allows the system to tag t=
he
> +         running process with an RCID (Resource Control ID) and MCID
> +         (Monitoring Counter ID). The RCID is used to determine resource
> +         allocation. The MCID is used to track resource usage in event
> +         counters.
> +
> +         For example, a cache controller may use the RCID to apply a
> +         cache partitioning scheme and use the MCID to track how much
> +         cache a process, or a group of processes, is using.
> +
>  config RISCV_ISA_SVPBMT
>         bool "Svpbmt extension support for supervisor mode page-based mem=
ory types"
>         depends on 64BIT && MMU
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 4a37a98398ad..2590b89b8f72 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -75,6 +75,13 @@
>  #define SATP_ASID_MASK _AC(0xFFFF, UL)
>  #endif
>
> +/* SRMCFG fields */
> +#define SRMCFG_RCID_MASK       _AC(0x00000FFF, UL)
> +#define SRMCFG_MCID_MASK       SRMCFG_RCID_MASK
> +#define SRMCFG_MCID_SHIFT      16
> +#define SRMCFG_MASK            ((SRMCFG_MCID_MASK << SRMCFG_MCID_SHIFT) =
| \
> +                                 SRMCFG_RCID_MASK)
> +
>  /* Exception cause high bit - is an interrupt if set */
>  #define CAUSE_IRQ_FLAG         (_AC(1, UL) << (__riscv_xlen - 1))
>
> @@ -317,6 +324,7 @@
>  #define CSR_STVAL              0x143
>  #define CSR_SIP                        0x144
>  #define CSR_SATP               0x180
> +#define CSR_SRMCFG             0x181
>
>  #define CSR_STIMECMP           0x14D
>  #define CSR_STIMECMPH          0x15D
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index da5426122d28..183c55e32b96 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -122,6 +122,9 @@ struct thread_struct {
>         /* A forced icache flush is not needed if migrating to the previo=
us cpu. */
>         unsigned int prev_cpu;
>  #endif
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +       u32 srmcfg;
> +#endif
>  };
>
>  /* Whitelist the fstate from the task_struct for hardened usercopy */
> diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> new file mode 100644
> index 000000000000..84830d7c6dc4
> --- /dev/null
> +++ b/arch/riscv/include/asm/qos.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_QOS_H
> +#define _ASM_RISCV_QOS_H
> +
> +#ifdef CONFIG_RISCV_ISA_SSQOSID
> +
> +#include <linux/sched.h>
> +#include <linux/jump_label.h>
> +
> +#include <asm/barrier.h>
> +#include <asm/csr.h>
> +#include <asm/hwcap.h>
> +
> +/* cached value of srmcfg csr for each cpu */
> +DECLARE_PER_CPU(u32, cpu_srmcfg);
> +
> +static inline void __switch_to_srmcfg(struct task_struct *next)
> +{
> +       u32 *cpu_srmcfg_ptr =3D this_cpu_ptr(&cpu_srmcfg);
> +       u32 thread_srmcfg;
> +
> +       thread_srmcfg =3D READ_ONCE(next->thread.srmcfg);
> +
> +       if (thread_srmcfg !=3D *cpu_srmcfg_ptr) {
> +               *cpu_srmcfg_ptr =3D thread_srmcfg;
> +               csr_write(CSR_SRMCFG, thread_srmcfg);
> +       }
> +}
> +
> +static __always_inline bool has_srmcfg(void)
> +{
> +       return riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID);
> +}
> +
> +#else /* ! CONFIG_RISCV_ISA_SSQOSID  */
> +
> +static __always_inline bool has_srmcfg(void) { return false; }
> +#define __switch_to_srmcfg(__next) do { } while (0)
> +
> +#endif /* CONFIG_RISCV_ISA_SSQOSID */
> +#endif /* _ASM_RISCV_QOS_H */
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 0e71eb82f920..a684a3795d3d 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -14,6 +14,7 @@
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <asm/qos.h>
>
>  #ifdef CONFIG_FPU
>  extern void __fstate_save(struct task_struct *save_to);
> @@ -119,6 +120,8 @@ do {                                                 =
       \
>                 __switch_to_fpu(__prev, __next);        \
>         if (has_vector() || has_xtheadvector())         \
>                 __switch_to_vector(__prev, __next);     \
> +       if (has_srmcfg())                               \
> +               __switch_to_srmcfg(__next);     \
>         if (switch_to_should_flush_icache(__next))      \
>                 local_flush_icache_all();               \
>         __switch_to_envcfg(__next);                     \
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f60fce69b725..a3c36d18145c 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -125,3 +125,5 @@ obj-$(CONFIG_ACPI)          +=3D acpi.o
>  obj-$(CONFIG_ACPI_NUMA)        +=3D acpi_numa.o
>
>  obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) +=3D bugs.o
> +
> +obj-$(CONFIG_RISCV_ISA_SSQOSID) +=3D qos/
> diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makef=
ile
> new file mode 100644
> index 000000000000..9f996263a86d
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RISCV_ISA_SSQOSID) +=3D qos.o
> diff --git a/arch/riscv/kernel/qos/qos.c b/arch/riscv/kernel/qos/qos.c
> new file mode 100644
> index 000000000000..7b06f7ae9056
> --- /dev/null
> +++ b/arch/riscv/kernel/qos/qos.c
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <asm/qos.h>
> +
> +/* cached value of sqoscfg csr for each cpu */
> +DEFINE_PER_CPU(u32, cpu_srmcfg);
>
> --
> 2.43.0
>

Thanks,
Yunhui

