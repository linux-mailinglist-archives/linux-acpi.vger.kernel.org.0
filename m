Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A896EFA3A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Apr 2023 20:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjDZSpM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Apr 2023 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjDZSpG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2023 14:45:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E65986AA
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2023 11:45:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24756a12ba0so5193693a91.1
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2023 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682534701; x=1685126701;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39lPpeZJ6Vfq5QIqd0kQjSRRWCoPA/qmtkXRKTNu56g=;
        b=0cTuHZsz+N1jNTSkL1VOEIXLta2nzIDK/QbZnIPF852eIN4/wy+BhVCrhX+aN/xiWq
         Pv8Xl1lrAsfRMHTAPqE0dD2zudgK+WM13ls67lFNlX2d9l7OHYZ0my8/qgS+OpPBbXS+
         2z+QXiSeWX2lV416QR2qREaa5lGfE5QamuUn4krS9vrilqtLpmfxdn0+t3ARTYK7nKRN
         +YoiaJhWjD93At8jHJYvd1pLLZRfh1qnpcxcZsNNeup01xnSGt1p/Yo4ruFnF3NuZSlO
         Cv4D/kiEjyEGrSlEa/CD8W0PXqoIgw5IzxsUfdFzP16WeBAlKG6nQHZfXug9NKXds/tk
         Supg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682534701; x=1685126701;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39lPpeZJ6Vfq5QIqd0kQjSRRWCoPA/qmtkXRKTNu56g=;
        b=e1oXDXK9Ybt3mFgt/DoENHFSdknF1Y6J+uM3YvP2lVajI9GHyW1WjNOXdtHxBJR0ql
         Jns0xPL5s04b8rFuFMVij8MSK/GxPGaMeLMsGGFBOeiqTpxUoOgavMsHNz0pxvnkSDbv
         oSOOWonqE72RRJ8emHmm9m5D7KY6Zhz1zPqycIYBHwNu7BUiJWSkzs4DstklfJsne2LN
         wuayE7zYgzoRDB4Qg6NizFGysXeNMZW7GLHc6Xx46zSZovjAIOuV/4yAcZcPyU/GiI8Q
         09bAuUt8qJaVhW/beFMr7tMupxrnVgh7eVi/u99xdHvlouyLYHwtAAQPXvV/wKYALZ1o
         /pnA==
X-Gm-Message-State: AAQBX9cPtVtPKZcDUnCS2LSf42SLHmspglWx7/dgxLRlwNOgiUmXcB3S
        AlMBGIMYTFNeek3rjom3z3+W8A==
X-Google-Smtp-Source: AKy350aIP182a8iZzH6HSor4HK3Xuh+akyVObent4Cuaa7ze4Zw4nZqWvOGmKTBK6pDR/bNTzXJfPQ==
X-Received: by 2002:a17:90b:4b0b:b0:240:9bf7:8df2 with SMTP id lx11-20020a17090b4b0b00b002409bf78df2mr23207939pjb.37.1682534701381;
        Wed, 26 Apr 2023 11:45:01 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090ae00500b002467717fa60sm10261751pjy.16.2023.04.26.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:45:00 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:45:00 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Apr 2023 11:38:37 PDT (-0700)
Subject:     Re: [PATCH V4 08/23] RISC-V: ACPI: Cache and retrieve the RINTC structure
In-Reply-To: <20230404182037.863533-9-sunilvl@ventanamicro.com>
CC:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, Marc Zyngier <maz@kernel.org>,
        luzmaximilian@gmail.com, hdegoede@redhat.com, markgross@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rafael@kernel.org, davem@davemloft.net, sunilvl@ventanamicro.com,
        rafael.j.wysocki@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunilvl@ventanamicro.com
Message-ID: <mhng-fd6c3622-ce6c-4895-8dc9-7dbaa2ab14f4@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 04 Apr 2023 11:20:22 PDT (-0700), sunilvl@ventanamicro.com wrote:
> RINTC structures in the MADT provide mapping between the hartid
> and the CPU. This is required many times even at run time like
> cpuinfo. So, instead of parsing the ACPI table every time, cache
> the RINTC structures and provide a function to get the correct
> RINTC structure for a given cpu.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/riscv/include/asm/acpi.h |  2 ++
>  arch/riscv/kernel/acpi.c      | 60 +++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 9be52b6ffae1..1606dce8992e 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -59,6 +59,8 @@ static inline bool acpi_has_cpu_in_madt(void)
>
>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> +u32 get_acpi_id_for_cpu(int cpu);
>  #endif /* CONFIG_ACPI */
>
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 81d448c41714..40ab55309c70 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -24,6 +24,66 @@ EXPORT_SYMBOL(acpi_disabled);
>  int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>
> +static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
> +
> +static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
> +{
> +	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
> +	int cpuid;
> +
> +	if (!(rintc->flags & ACPI_MADT_ENABLED))
> +		return 0;
> +
> +	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);

Unless I'm missing something, this races with CPUs coming online.  Maybe 
that's a rare enough case we don't care, but I think we'd also just have 
simpler logic if we fixed it...

> +	/*
> +	 * When CONFIG_SMP is disabled, mapping won't be created for
> +	 * all cpus.
> +	 * CPUs more than NR_CPUS, will be ignored.
> +	 */
> +	if (cpuid >= 0 && cpuid < NR_CPUS)
> +		cpu_madt_rintc[cpuid] = *rintc;
> +
> +	return 0;
> +}
> +
> +static int acpi_init_rintc_array(void)
> +{
> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) > 0)
> +		return 0;
> +
> +	return -ENODEV;
> +}
> +
> +/*
> + * Instead of parsing (and freeing) the ACPI table, cache
> + * the RINTC structures since they are frequently used
> + * like in  cpuinfo.
> + */
> +struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> +{
> +	static bool rintc_init_done;

... basically just get rid of this global variable, and instead have a

    if (!&cpu_madt_rintc[cpu])
        ... parse ...
    
    return &cpu_madt_rintc[cpu];

that'd probably let us get rid of a handful of these helpers too, as now 
it's just a call to the parsing bits.

> +
> +	if (!rintc_init_done) {
> +		if (acpi_init_rintc_array()) {
> +			pr_err("No valid RINTC entries exist\n");
> +			return NULL;
> +		}
> +
> +		rintc_init_done = true;
> +	}
> +
> +	return &cpu_madt_rintc[cpu];
> +}
> +
> +u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	struct acpi_madt_rintc *rintc = acpi_cpu_get_madt_rintc(cpu);
> +
> +	BUG_ON(!rintc);

We should have some better error reporting here.  It looks like all the 
callerss of get_acpi_id_for_cpu() are tolerant of a nonsense ID being 
returned, so maybe we just pr_warn() something users can understand and 
then return -1 or something?

> +
> +	return rintc->uid;
> +}
> +
>  /*
>   * __acpi_map_table() will be called before paging_init(), so early_ioremap()
>   * or early_memremap() should be called here to for ACPI table mapping.
