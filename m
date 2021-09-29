Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A2341CC17
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 20:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbhI2StM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 14:49:12 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39922 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhI2StH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2021 14:49:07 -0400
Received: by mail-ot1-f44.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so4103610ota.6;
        Wed, 29 Sep 2021 11:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gh0/D+JLfsfJlqH0a917kdEGhqFFQged7ZchtYxclU=;
        b=xCtQUXGy4FV2eInUnDP7rXdgijsd9XUPGj4SjMQM0Abmz9o/POO0ishbCsGPehLCu5
         Lin22uDj/LGRt3dog3Jzqywmb5vVjf1ehqU9EErSpm6kv3DFPP80g7RAU6pbnY6KtTiD
         n+0LFQ1bsC15EjFyWFDQNqUi7816zzvLdsPrQlObm1zinSaVSL6X7PWJCpVsgUMyVO/M
         MnK21Nr5MA7JQEMu9FVt7EJbe6cSDgdg4VrqLLQ1W+zI77iuaIZnzSdbZKjdATFlwFgA
         sG01JuUmQR9lYhTI7zKAHFlh2lXJK4F/JsQ+ZNSAh4BuUThpmmKZHFgJ0TIr9bC+TOCp
         DhxQ==
X-Gm-Message-State: AOAM531bOqT0N5hWdNFH4rylYPZK+ZTsaOkyCsOGCPuHwAXohOwj7qj2
        bCuEBa4qR2PkvGJBsWrIkYWdTvEESc8wUpoAqHSkC1Au
X-Google-Smtp-Source: ABdhPJxH+pTTbk0IZjcDwThSOx5Jir6Y4UsNlmDuGsgVm/HkIDtlTJgQC59U2XUxYN6Z5+bFQKX+f2eMjXJsAaV2l/U=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr1348976otr.301.1632941245560;
 Wed, 29 Sep 2021 11:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210927121338.938994-1-arnd@kernel.org>
In-Reply-To: <20210927121338.938994-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 20:47:14 +0200
Message-ID: <CAJZ5v0jJRYQPSfVV_hCD6uxch+vU6kvWV9-KAfqHckHgkFOeaA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: avoid NULL pointer arithmetic
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 27, 2021 at 2:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are some very old macros for doing an open-coded offsetof() and
> cast between pointer and integer in ACPI headers. clang-14 now complains
> about these:
>
> drivers/acpi/acpica/tbfadt.c:86:3: error: performing pointer subtraction with a null pointer has undefined behavior [-Werror,-Wnull-pointer-subtraction]
>          ACPI_FADT_OFFSET(pm_timer_block),
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actbl.h:376:47: note: expanded from macro 'ACPI_FADT_OFFSET'
>  #define ACPI_FADT_OFFSET(f)             (u16) ACPI_OFFSET (struct acpi_table_fadt, f)
>                                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actypes.h:511:41: note: expanded from macro 'ACPI_OFFSET'
>  #define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/acpi/actypes.h:505:79: note: expanded from macro 'ACPI_PTR_DIFF'
>  #define ACPI_PTR_DIFF(a, b)             ((acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b))))
>                                                                               ^ ~~~~~~~~~~~~~~~~~~~~~~~
> Convert them to the modern equivalents.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/acpi/actypes.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 92c71dfce0d5..285bc7b73de3 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -507,8 +507,8 @@ typedef u64 acpi_integer;
>  /* Pointer/Integer type conversions */
>
>  #define ACPI_TO_POINTER(i)              ACPI_CAST_PTR (void, (acpi_size) (i))
> -#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
> -#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
> +#define ACPI_TO_INTEGER(p)              ((uintptr_t)(p))
> +#define ACPI_OFFSET(d, f)               offsetof(d, f)
>  #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
>  #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
>
> --

Queued up as 5.16 material, converted into an upstream ACPICA pull
request and submitted, thanks!
