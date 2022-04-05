Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72934F4173
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Apr 2022 23:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiDEOqo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 10:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387048AbiDEO3X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 10:29:23 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705AF65F8
        for <linux-acpi@vger.kernel.org>; Tue,  5 Apr 2022 06:11:29 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id z33so18742500ybh.5
        for <linux-acpi@vger.kernel.org>; Tue, 05 Apr 2022 06:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAsOg6u+dg8eBbb3CVSjFCBlnUar5puK/bkdtZok73E=;
        b=CoseDsX1dG/6vU8WhcxQTR17vXC6WI1mLEZF3ODGpW4ravhJR2KrLYJ0tUEcCOrgVS
         nnnH/hkzCRUaoZWjkX2YiPlJbge8ZCBk+h7nGl1T6/+a5t2wMhHBq3MWw/NNGsoc70Kf
         tNlq0EF7KYJHQOgTpSJ/9gWAqyQ2X1weEUnJWgnfFKTCCVfmKJBi3sG64gD/D0Yg989R
         C9XC8UVwXl+EiJyCJt7eGD5L8gqkjoXhT4QV4EW62TY/D+h9OX9D4v1BiBFNiWqBPoy8
         9tohBatZPQr5K6rUCK0ee7DP1SN0WYC2WekS2qslnU4ltFPQgcIxSrG5r4/H0n6afrHl
         W76w==
X-Gm-Message-State: AOAM530y8TKTDey91Ceq/TKsq4okOPlMH6BRHidypG4DMwnGKu5Vt+d+
        Jy32Wmpeet6nf0/WU1sW03mvSGRoZc1u6eunkOs=
X-Google-Smtp-Source: ABdhPJyVsjELcDDNs+Rco1Cbg0YxYcCGONQb5xUjKRULd+J6rZz6LFzO2hTQvNMTlzwIrPpPXTxadfxySE4uUhEAsM0=
X-Received: by 2002:a25:9d8a:0:b0:633:9668:c48a with SMTP id
 v10-20020a259d8a000000b006339668c48amr2551773ybp.153.1649164288285; Tue, 05
 Apr 2022 06:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647525033.git.vit@kabele.me> <YjM/yphbAQHxJIxg@czspare1-lap.sysgo.cz>
In-Reply-To: <YjM/yphbAQHxJIxg@czspare1-lap.sysgo.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 15:11:17 +0200
Message-ID: <CAJZ5v0gBbdzUO9MRxbKESEnaeaNAu-+3oP6ADMretch=iHPNJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/x86: Check validity of EBDA pointer in mpparse.c
To:     platform-driver-x86@kernel.org, r.marek@assembler.cz,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert Moore <robert.moore@intel.com>, linux-kernel@kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     vit@kabele.me
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

First off, this is not platform/x86, but arch/x86.

On Thu, Mar 17, 2022 at 3:12 PM Vit Kabele <vit@kabele.me> wrote:
>
> The pointer to EBDA area is retrieved from a word at 0x40e in BDA.
> In case that the memory there is not initialized and contains garbage,
> it might happen that the kernel touches memory above 640K.
>
> This may cause unwanted reads from VGA memory which may not be decoded,
> or even present when running under virtualization.
>
> This patch adds sanity check for the EBDA pointer retrieved from the memory
> so that scanning EBDA does not leave the low memory.
>
> Signed-off-by: Vit Kabele <vit@kabele.me>
> Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
> ---
>  arch/x86/include/asm/bios_ebda.h |  3 +++
>  arch/x86/kernel/ebda.c           |  3 ---
>  arch/x86/kernel/mpparse.c        | 12 +++++++++++-
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/bios_ebda.h b/arch/x86/include/asm/bios_ebda.h
> index 4d5a17e2febe..c3133c01d5b7 100644
> --- a/arch/x86/include/asm/bios_ebda.h
> +++ b/arch/x86/include/asm/bios_ebda.h
> @@ -4,6 +4,9 @@
>
>  #include <asm/io.h>
>
> +#define BIOS_START_MIN         0x20000U        /* 128K, less than this is insane */
> +#define BIOS_START_MAX         0x9f000U        /* 640K, absolute maximum */
> +
>  /*
>   * Returns physical address of EBDA.  Returns 0 if there is no EBDA.
>   */
> diff --git a/arch/x86/kernel/ebda.c b/arch/x86/kernel/ebda.c
> index 38e7d597b660..86c0801fc3ce 100644
> --- a/arch/x86/kernel/ebda.c
> +++ b/arch/x86/kernel/ebda.c
> @@ -50,9 +50,6 @@
>
>  #define BIOS_RAM_SIZE_KB_PTR   0x413
>
> -#define BIOS_START_MIN         0x20000U        /* 128K, less than this is insane */
> -#define BIOS_START_MAX         0x9f000U        /* 640K, absolute maximum */
> -
>  void __init reserve_bios_regions(void)
>  {
>         unsigned int bios_start, ebda_start;
> diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
> index fed721f90116..6bba0744d32d 100644
> --- a/arch/x86/kernel/mpparse.c
> +++ b/arch/x86/kernel/mpparse.c
> @@ -633,7 +633,17 @@ void __init default_find_smp_config(void)
>          */
>
>         address = get_bios_ebda();
> -       if (address)
> +
> +       /* Check that the EBDA address is sane and the get_bios_ebda() did not

Comment format not adhering to coding-style.

> +        * return just garbage from memory.
> +        * The upper bound is considered valid if it points below 1K before
> +        * end of the lower memory (i.e. 639K). The EBDA can be smaller
> +        * than 1K in which case the pointer will point above 639K but that
> +        * case is handled in step 2) above, and we don't need to adjust scan
> +        * size to not bump into the memory above 640K.
> +        */
> +       if (address >= BIOS_START_MIN &&
> +           address < 639 * 0x400)

This line doesn't need to be broken and maybe define a symbol for the
upper bound limit.

And if the 0x400 simply means 1KiB, it would be less confusing to use
a decimal number IMO.

>                 smp_scan_config(address, 0x400);
>  }
>
> --
