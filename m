Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712A13445B4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Mar 2021 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCVN1s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 09:27:48 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45845 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhCVN1j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Mar 2021 09:27:39 -0400
Received: by mail-ot1-f49.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so15873924otf.12;
        Mon, 22 Mar 2021 06:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7NLjzCmdc7lqJFi0FRfh6j8DYgTAI55Gdto//+9wfc=;
        b=bQEZUFzsnn7oZSlfiqd0oUo1Q1iFV/OZqdAmJXOeheDb6pXOm8RV/GPXsL7A5MWuN6
         qyLYpsqOS44mGl+huZ97hPa953tEL1XxtajDhUone9UkftHCUYAw2wdd9F9odyohAsW7
         0H/pxtxUXmm39W7U4iRcV6TudEsBf2olOQJ8BF42vBmjkyEqH/ZrDSXMt/wnUItgE8Nd
         ooO1Fc4JoXEfPIr8K749u5CH2+YZn6dmIm/OoCzvD1E2a9vx3SFyaCY0u8BXZBfgfE1k
         d22/yNu7lGHFCAgLHhDCU/G1aFDFEK6HGZB/V3hYpehValFUQ/tgS1cXD2Y8SCXo2yJL
         HpTQ==
X-Gm-Message-State: AOAM533HMhuvZ5Oa8vrQq9Gx+AYF9wcpiFo1pEzUH6paehqJClcczHsl
        uNbFt5WZf773WBLnNfowTxxSz2EdvK+EIs/FFMM=
X-Google-Smtp-Source: ABdhPJwoZAbuzFvJN4AM4LX7CnRAX3/NRAdpDKl5lAPXhxKPAOZcq+So6bIupxyrfvzrZJd0xZ/j8HVZpcO3HoDgHCk=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr12036047otr.321.1616419658585;
 Mon, 22 Mar 2021 06:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210322105805.1498602-1-arnd@kernel.org>
In-Reply-To: <20210322105805.1498602-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Mar 2021 14:27:23 +0100
Message-ID: <CAJZ5v0jbKmkWxV0CFpQ+3q5GOJVVx5QfzLVu-Mvo-subYdjuPA@mail.gmail.com>
Subject: Re: [PATCH] acpi: avoid -Wempty-body warnings
To:     Arnd Bergmann <arnd@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 22, 2021 at 11:59 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The acpi drivers produce a number of avoidable warnings for empty macros
> when building with 'make W=1':
>
> drivers/acpi/acpi_processor.c: In function 'acpi_processor_errata_piix4':
> drivers/acpi/acpi_processor.c:133:95: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   133 |                                   "Bus master activity detection (BM-IDE) erratum enabled\n"));
>       |                                                                                               ^
> drivers/acpi/acpi_processor.c:136:82: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   136 |                                   "Type-F DMA livelock erratum (C3 disabled)\n"));
>       |                                                                                  ^
> drivers/acpi/acpi_processor.c: In function 'acpi_processor_get_info':
> drivers/acpi/acpi_processor.c:251:77: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>   251 |                                   "No bus mastering arbitration control\n"));
>       |                                                                             ^
> drivers/acpi/processor_pdc.c: In function 'acpi_processor_eval_pdc':
> drivers/acpi/processor_pdc.c:136:79: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   136 |                     "Could not evaluate _PDC, using legacy perf. control.\n"));
>       |                                                                               ^
>
> I tried making these call no_printk() instead, which would add proper
> format string checking, but that turned out to be a rather invasive
> change, so just shut up the warning by turning the macros into empty
> "do {} while (0)" statements.

This is part of ACPICA, so handing it to Erik and Bob.


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/acpi/acoutput.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
> index 1538a6853822..b5484ef31f27 100644
> --- a/include/acpi/acoutput.h
> +++ b/include/acpi/acoutput.h
> @@ -433,23 +433,23 @@
>   * This is the non-debug case -- make everything go away,
>   * leaving no executable debug code!
>   */
> -#define ACPI_DEBUG_PRINT(pl)
> -#define ACPI_DEBUG_PRINT_RAW(pl)
> -#define ACPI_DEBUG_EXEC(a)
> -#define ACPI_DEBUG_ONLY_MEMBERS(a)
> -#define ACPI_FUNCTION_NAME(a)
> -#define ACPI_FUNCTION_TRACE(a)
> -#define ACPI_FUNCTION_TRACE_PTR(a, b)
> -#define ACPI_FUNCTION_TRACE_U32(a, b)
> -#define ACPI_FUNCTION_TRACE_STR(a, b)
> -#define ACPI_FUNCTION_ENTRY()
> -#define ACPI_DUMP_STACK_ENTRY(a)
> -#define ACPI_DUMP_OPERANDS(a, b, c)
> -#define ACPI_DUMP_ENTRY(a, b)
> -#define ACPI_DUMP_PATHNAME(a, b, c, d)
> -#define ACPI_DUMP_BUFFER(a, b)
> +#define ACPI_DEBUG_PRINT(pl)                   do { } while (0)
> +#define ACPI_DEBUG_PRINT_RAW(pl)               do { } while (0)
> +#define ACPI_DEBUG_EXEC(a)                     do { } while (0)
> +#define ACPI_DEBUG_ONLY_MEMBERS(a)             do { } while (0)
> +#define ACPI_FUNCTION_NAME(a)                  do { } while (0)
> +#define ACPI_FUNCTION_TRACE(a)                 do { } while (0)
> +#define ACPI_FUNCTION_TRACE_PTR(a, b)          do { } while (0)
> +#define ACPI_FUNCTION_TRACE_U32(a, b)          do { } while (0)
> +#define ACPI_FUNCTION_TRACE_STR(a, b)          do { } while (0)
> +#define ACPI_FUNCTION_ENTRY()                  do { } while (0)
> +#define ACPI_DUMP_STACK_ENTRY(a)               do { } while (0)
> +#define ACPI_DUMP_OPERANDS(a, b, c)            do { } while (0)
> +#define ACPI_DUMP_ENTRY(a, b)                  do { } while (0)
> +#define ACPI_DUMP_PATHNAME(a, b, c, d)         do { } while (0)
> +#define ACPI_DUMP_BUFFER(a, b)                 do { } while (0)
>  #define ACPI_IS_DEBUG_ENABLED(level, component) 0
> -#define ACPI_TRACE_POINT(a, b, c, d)
> +#define ACPI_TRACE_POINT(a, b, c, d)           do { } while (0)
>
>  /* Return macros must have a return statement at the minimum */
>
> --
> 2.29.2
>
