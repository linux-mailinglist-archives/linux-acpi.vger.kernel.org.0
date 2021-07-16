Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71D3CBAF4
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 19:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhGPROc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 16 Jul 2021 13:14:32 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41884 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGPROb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 13:14:31 -0400
Received: by mail-ot1-f47.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so10540587otp.8
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 10:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KNuTw/A4f9C8O7wXXOPp5dr/FmMmVJJ2W7NnHC4GCEs=;
        b=KjGfC2fp/a/Z8Es2ywKgoPOroXSpjur1AuheEuudG647xC6Xyn30tw9pqQo8AUmm3x
         miLXKjBIjo91QSF7CcC7yNqacrYQxTogN6+7TOFAUi0Daxijn1t5YkzN9rkYZ9Fv4iQh
         OOKDpPA6eOK1iXNBZo627oN3dBrIzM6Ya7XjIM44IodfthxLyuJJCyF2agbvrggO4bYn
         Igkda6yafM9qiP5UPNad/F5gEFdIAAQAdPUAnUXtrD2yUrtWHF/OHuUK6fFq6ZGlF+IP
         8k1gK2ZuEZpJVBQ2nbXv7PjJ5VSWIuPIEy6YmLjFSoSK9qj2HFQz2kaZf3Q2VDtCbXGm
         33Gg==
X-Gm-Message-State: AOAM533Z+zY6OTGhPQ9cV3T3kbwo1DvB0NP1jYLT5D7PL4WcVwZ+NxuM
        88CnI/iAR5y2oBna6liM8gqx+BLWJZi9KCzf76M=
X-Google-Smtp-Source: ABdhPJw1JujzvbOp1ydZUW1nklRlfBPlOZ+7iC9huThdPtvWeFgpaIMOVTnw+lhDKgSgNPk+FwV3fn+tjyW9YjaOS2Q=
X-Received: by 2002:a9d:5f19:: with SMTP id f25mr9330215oti.206.1626455496081;
 Fri, 16 Jul 2021 10:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210705124206.1228958-1-chenhuacai@loongson.cn>
 <20210705124206.1228958-2-chenhuacai@loongson.cn> <CAJZ5v0gyun_85uXrH6jt-d3XjaOFZmHEYGnKKGL-XUb=4ZcrMQ@mail.gmail.com>
 <407870af.c1bf.17aa87f94db.Coremail.chenhuacai@loongson.cn>
In-Reply-To: <407870af.c1bf.17aa87f94db.Coremail.chenhuacai@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jul 2021 19:11:25 +0200
Message-ID: <CAJZ5v0juBC5USF_t-kF7Npk7onXF6SkKvwechuUYiM2jzFuN3Q@mail.gmail.com>
Subject: Re: Re: [PATCH 1/3] ACPI: Add LoongArch support for ACPI_PROCESSOR/ACPI_NUMA
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, chenhuacai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 15, 2021 at 6:49 AM 陈华才 <chenhuacai@loongson.cn> wrote:
>
> Hi, Rafael,
>
>
> &gt; -----原始邮件-----
> &gt; 发件人: "Rafael J. Wysocki" <rafael@kernel.org>
> &gt; 发送时间: 2021-07-14 20:30:33 (星期三)
> &gt; 收件人: "Huacai Chen" <chenhuacai@loongson.cn>
> &gt; 抄送: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Len Brown" <lenb@kernel.org>, "Robert Moore" <robert.moore@intel.com>, "Erik Kaneda" <erik.kaneda@intel.com>, "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>, "Xuefeng Li" <lixuefeng@loongson.cn>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>
> &gt; 主题: Re: [PATCH 1/3] ACPI: Add LoongArch support for ACPI_PROCESSOR/ACPI_NUMA
> &gt;
> &gt; On Mon, Jul 5, 2021 at 2:41 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> &gt; &gt;
> &gt; &gt; We are preparing to add new Loongson (based on LoongArch, not MIPS)
> &gt; &gt; support. LoongArch use ACPI other than DT as its boot protocol, so
> &gt; &gt; add its support for ACPI_PROCESSOR/ACPI_NUMA.
> &gt; &gt;
> &gt; &gt; Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> &gt; &gt; ---
> &gt; &gt;  drivers/acpi/Kconfig      | 4 ++--
> &gt; &gt;  drivers/acpi/numa/Kconfig | 2 +-
> &gt; &gt;  drivers/acpi/numa/srat.c  | 2 +-
> &gt; &gt;  include/linux/acpi.h      | 2 +-
> &gt; &gt;  4 files changed, 5 insertions(+), 5 deletions(-)
> &gt; &gt;
> &gt; &gt; diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> &gt; &gt; index fe0bb6277e4d..90afa44efcba 100644
> &gt; &gt; --- a/drivers/acpi/Kconfig
> &gt; &gt; +++ b/drivers/acpi/Kconfig
> &gt; &gt; @@ -280,9 +280,9 @@ config ACPI_CPPC_LIB
> &gt; &gt;
> &gt; &gt;  config ACPI_PROCESSOR
> &gt; &gt;         tristate "Processor"
> &gt; &gt; -       depends on X86 || IA64 || ARM64
> &gt; &gt; +       depends on X86 || IA64 || ARM64 || LOONGARCH
> &gt; &gt;         select ACPI_PROCESSOR_IDLE
> &gt; &gt; -       select ACPI_CPU_FREQ_PSS if X86 || IA64
> &gt; &gt; +       select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
> &gt; &gt;         default y
> &gt; &gt;         help
> &gt; &gt;           This driver adds support for the ACPI Processor package. It is required
> &gt; &gt; diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> &gt; &gt; index fcf2e556d69d..39b1f34c21df 100644
> &gt; &gt; --- a/drivers/acpi/numa/Kconfig
> &gt; &gt; +++ b/drivers/acpi/numa/Kconfig
> &gt; &gt; @@ -2,7 +2,7 @@
> &gt; &gt;  config ACPI_NUMA
> &gt; &gt;         bool "NUMA support"
> &gt; &gt;         depends on NUMA
> &gt; &gt; -       depends on (X86 || IA64 || ARM64)
> &gt; &gt; +       depends on (X86 || IA64 || ARM64 || LOONGARCH)
> &gt; &gt;         default y if IA64 || ARM64
> &gt; &gt;
> &gt; &gt;  config ACPI_HMAT
> &gt; &gt; diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> &gt; &gt; index 6021a1013442..b8795fc49097 100644
> &gt; &gt; --- a/drivers/acpi/numa/srat.c
> &gt; &gt; +++ b/drivers/acpi/numa/srat.c
> &gt; &gt; @@ -206,7 +206,7 @@ int __init srat_disabled(void)
> &gt; &gt;         return acpi_numa &lt; 0;
> &gt; &gt;  }
> &gt; &gt;
> &gt; &gt; -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> &gt; &gt; +#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
> &gt; &gt;  /*
> &gt; &gt;   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
> &gt; &gt;   * I/O localities since SRAT does not list them.  I/O localities are
> &gt; &gt; diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> &gt; &gt; index 6bb36fd6ba31..3ba8511cbede 100644
> &gt; &gt; --- a/include/linux/acpi.h
> &gt; &gt; +++ b/include/linux/acpi.h
> &gt; &gt; @@ -249,7 +249,7 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
> &gt; &gt;  /* the following numa functions are architecture-dependent */
> &gt; &gt;  void acpi_numa_slit_init (struct acpi_table_slit *slit);
> &gt; &gt;
> &gt; &gt; -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> &gt; &gt; +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
> &gt; &gt;  void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
> &gt; &gt;  #else
> &gt; &gt;  static inline void
> &gt; &gt; --
> &gt;
> &gt; Does this patch alone make sense without the other two in the series?
> &gt; If so, I can queue it up for 5.15, so please let me know.
> Yes, this patch has no dependency with other two.

OK, applied as 5.15 material.

Thanks!
