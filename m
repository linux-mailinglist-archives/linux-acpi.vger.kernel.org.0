Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C247C42593B
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Oct 2021 19:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbhJGRV7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Oct 2021 13:21:59 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:45775 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243253AbhJGRV6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Oct 2021 13:21:58 -0400
Received: by mail-oo1-f46.google.com with SMTP id y16-20020a4ade10000000b002b5dd6f4c8dso2100046oot.12;
        Thu, 07 Oct 2021 10:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRS9W9aYA7YdWQXQJjG/aiOW5ROYwoQLPuWu0OWbdFI=;
        b=l9TkqxbrFxiFPfT8L69Pb5NWWiqUbWrL6HAEIcGdjVK5vwSBkrCK3C3PV3EO1csfN8
         6wvIdnlIK/1Iz9OAD8EDD5nPf4jYM0VQZtlxkNVTZcvMRdY5IyII4G5OCANudR1ABpoy
         IT6rByNhktYEkI3QlPhSkjsbT6dbNoWK4xET0GoHUX/K0lsRUZSHAtA3l4t9KQpAa/Io
         GXdXw7woN2nzQmXvjQbbKsB3IPmk4pZDR58+5SEIhPxgj1LKXVyqvhtt12YwvAHm0qOJ
         v5VeR08HoWUfc8pdf6ExYZCbFxMpUDZbDgnTLfH4hkqvkYW0RLV1Hhwm7ZkX8m75ZwTC
         5SFQ==
X-Gm-Message-State: AOAM5303XSmwNepGZhTlg9tFItLTH59f2zNPoTV+jbLxtqDUeKjVaqyL
        w/rZtXL/GManmJoCKxw/H90slmbuYXAfonxR4rc=
X-Google-Smtp-Source: ABdhPJzeFDGczUHdstuoM/GQcLNSMSRwrYuwJDUIsKQLkq5Ru7MjdScPDlrmNeRstIpg6hGwi6j8+iM/I/6PVL+DVY8=
X-Received: by 2002:a4a:ca98:: with SMTP id x24mr4183071ooq.91.1633627204058;
 Thu, 07 Oct 2021 10:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211006051318.117094-1-miguel.bernal.marin@linux.intel.com>
In-Reply-To: <20211006051318.117094-1-miguel.bernal.marin@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Oct 2021 19:19:53 +0200
Message-ID: <CAJZ5v0h7OVzjJNP9BXw5XucL3JQ7tY9wHLD8TZXjAKx_gxiDtA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tools: fix compilation error
To:     Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 6, 2021 at 7:13 AM Miguel Bernal Marin
<miguel.bernal.marin@linux.intel.com> wrote:
>
> When acpi tools are compiled the following error is showed:
>
>    $ cd tools/power/acpi
>    $ make
>      DESCEND tools/acpidbg
>      MKDIR    include
>      CP       include
>      CC       tools/acpidbg/acpidbg.o
>    In file included from /home/linux/tools/power/acpi/include/acpi/platform/acenv.h:152,
>                     from /home/linux/tools/power/acpi/include/acpi/acpi.h:22,
>                     from acpidbg.c:9:
>    /home/linux/tools/power/acpi/include/acpi/platform/acgcc.h:25:10: fatal error: linux/stdarg.h: No such file or directory
>       29 | #include <linux/stdarg.h>
>          |          ^~~~~~~~~~~~~~~~
>    compilation terminated.
>
> Keep the same logic from ACPICA, just identify when is used inside kernel
> or by acpi tool.
>
> Fixes: c0891ac15f04 ("isystem: ship and use stdarg.h")
> Signed-off-by: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
> ---
>  include/acpi/platform/acgcc.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
> index fb172a03a753..20ecb004f5a4 100644
> --- a/include/acpi/platform/acgcc.h
> +++ b/include/acpi/platform/acgcc.h
> @@ -22,9 +22,14 @@ typedef __builtin_va_list va_list;
>  #define va_arg(v, l)            __builtin_va_arg(v, l)
>  #define va_copy(d, s)           __builtin_va_copy(d, s)
>  #else
> +#ifdef __KERNEL__
>  #include <linux/stdarg.h>
> -#endif
> -#endif
> +#else
> +/* Used to build acpi tools */
> +#include <stdarg.h>
> +#endif /* __KERNEL__ */
> +#endif /* ACPI_USE_BUILTIN_STDARG */
> +#endif /* ! va_arg */
>
>  #define ACPI_INLINE             __inline__
>
> --

Applied as 5.16 material, thanks!
