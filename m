Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324F6B747D
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2019 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfISH6h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Sep 2019 03:58:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32772 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfISH6h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Sep 2019 03:58:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id e18so1992038oii.0;
        Thu, 19 Sep 2019 00:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gzgxvKneHeLUz/ZHsURkSXb+QEFiAaX6Im27DEWXsw=;
        b=EvP1JxongnASLSTqxOC9cg6vKdv5o9oUqmH+GEgNkYS1Q4nEDEfFMDgkkdySM+OY91
         4g7TtX1pdRTKz0TBxHMC7ZiBH05YaTMMqai3sOb8HzPQFFl2hDgnkxYxu1tvbRfB8EhV
         7TXMR592oEpkm87xfU9VliFz8dPddluh2UH54/a7tcNGPfTkkqFF4ZJNPAE+NzuiPxmE
         5j/3kZxu2kRx5K0hqeqtvlVwbmxbldZthB9peLibZh5QTRc7dGPyalpPOXM6L3Wtb9Km
         u4TWqheiybRsz9lAYrC1xAVuQH3nNLdPzjTkzQpTnDv7Gb3Ww6+JPo0CUcX/jjpv7rEN
         WcSQ==
X-Gm-Message-State: APjAAAVPbAfGWh19jzqOeU7NbXZNSNC74LEzeMXTRxWcRpUvct3X9JpL
        C7d/KG1XAZPl5E8yVCVv7gj7bAHk/UDtG3/xt+Y=
X-Google-Smtp-Source: APXvYqxf1sEYGXWTjnimeWPrpnLdxl6qIsuH8BxLaYq8kEqCjkSoUa+pku/AhqCl9hYvN40oGfj9lkPMxStg54f52NE=
X-Received: by 2002:aca:4890:: with SMTP id v138mr1333545oia.57.1568879916166;
 Thu, 19 Sep 2019 00:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com> <20190918133419.7969-9-sakari.ailus@linux.intel.com>
In-Reply-To: <20190918133419.7969-9-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Sep 2019 09:58:24 +0200
Message-ID: <CAJZ5v0hhOowv93-7wApvetr10bO+geTX_giH_2kHWmsRGdWFFw@mail.gmail.com>
Subject: Re: [PATCH v7 08/13] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 18, 2019 at 3:34 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> %pS and %ps are now the preferred conversion specifiers to print function
> names. The functionality is equivalent; remove the old, deprecated %pF
> and %pf support.
>
> Depends-on: commit 2d44d165e939 ("scsi: lpfc: Convert existing %pf users to %ps")

Where is this commit present?

Not in the mainline as of today.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/core-api/printk-formats.rst | 10 ----------
>  lib/vsprintf.c                            |  8 ++------
>  scripts/checkpatch.pl                     |  1 -
>  3 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index c6224d039bcbe..922a29eb70e6c 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -86,8 +86,6 @@ Symbols/Function Pointers
>
>         %pS     versatile_init+0x0/0x110
>         %ps     versatile_init
> -       %pF     versatile_init+0x0/0x110
> -       %pf     versatile_init
>         %pSR    versatile_init+0x9/0x110
>                 (with __builtin_extract_return_addr() translation)
>         %pB     prev_fn_of_versatile_init+0x88/0x88
> @@ -97,14 +95,6 @@ The ``S`` and ``s`` specifiers are used for printing a pointer in symbolic
>  format. They result in the symbol name with (S) or without (s)
>  offsets. If KALLSYMS are disabled then the symbol address is printed instead.
>
> -Note, that the ``F`` and ``f`` specifiers are identical to ``S`` (``s``)
> -and thus deprecated. We have ``F`` and ``f`` because on ia64, ppc64 and
> -parisc64 function pointers are indirect and, in fact, are function
> -descriptors, which require additional dereferencing before we can lookup
> -the symbol. As of now, ``S`` and ``s`` perform dereferencing on those
> -platforms (when needed), so ``F`` and ``f`` exist for compatibility
> -reasons only.
> -
>  The ``B`` specifier results in the symbol name with offsets and should be
>  used when printing stack backtraces. The specifier takes into
>  consideration the effect of compiler optimisations which may occur
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b0967cf17137d..b00b57f9f911f 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -909,7 +909,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
>  #ifdef CONFIG_KALLSYMS
>         if (*fmt == 'B')
>                 sprint_backtrace(sym, value);
> -       else if (*fmt != 'f' && *fmt != 's')
> +       else if (*fmt != 's')
>                 sprint_symbol(sym, value);
>         else
>                 sprint_symbol_no_offset(sym, value);
> @@ -2007,9 +2007,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
>   *
>   * - 'S' For symbolic direct pointers (or function descriptors) with offset
>   * - 's' For symbolic direct pointers (or function descriptors) without offset
> - * - 'F' Same as 'S'
> - * - 'f' Same as 's'
> - * - '[FfSs]R' as above with __builtin_extract_return_addr() translation
> + * - '[Ss]R' as above with __builtin_extract_return_addr() translation
>   * - 'B' For backtraced symbolic direct pointers with offset
>   * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
>   * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
> @@ -2112,8 +2110,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>               struct printf_spec spec)
>  {
>         switch (*fmt) {
> -       case 'F':
> -       case 'f':
>         case 'S':
>         case 's':
>                 ptr = dereference_symbol_descriptor(ptr);
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edfe0f059..a60c241112cd4 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6012,7 +6012,6 @@ sub process {
>                                         my $ext_type = "Invalid";
>                                         my $use = "";
>                                         if ($bad_specifier =~ /p[Ff]/) {
> -                                               $ext_type = "Deprecated";
>                                                 $use = " - use %pS instead";
>                                                 $use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
>                                         }
> --
> 2.20.1
>
