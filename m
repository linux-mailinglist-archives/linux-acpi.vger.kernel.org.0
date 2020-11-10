Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC02ADD64
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Nov 2020 18:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKJRup (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Nov 2020 12:50:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45923 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbgKJRup (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2020 12:50:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so15304533oie.12;
        Tue, 10 Nov 2020 09:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KK1FDCmdwdfvxqO791W8Q84+D6lSjpER05CHZff/fQs=;
        b=gMvfahDCmtHgqlct+4rbSs0WSBIDxhU9Tu68uQ0unuGrJGAJRQcEzXiCFTQTmFSIik
         ZB0aRWmIZOa8BUuKeD8jyR9MS/z8c+FE3sDQ+WfoUYbi0Fh1gRx/ki8uQcj04IYrbDmj
         z7aQDrCZfDeGs7CCiohKybSeaOWDdM8vaz3JUbEGutXogxPY/6ow+gMnzG/Fw/GIarWf
         NXS7MAHGaEg/ELDhzmtK/qWraqIMYKPNOzRSWjwrqGX4voNEWJldWu1cDt4/XgwwjVcA
         WjxYhR1R8nkFhmDxhZ9M0mnFXPZjdUpB6J6q3awc+qakmr43N2B+ZmunARA2h7hYFDis
         R/Rw==
X-Gm-Message-State: AOAM530nJ099szHcHvMo1YdDhweluIKqtW+E84UdJFDUoUnSh2ETZhy4
        LF6CG8/BQ5UUwHEQhTRVdigUtGhxWXGcA07adOH0B/YW
X-Google-Smtp-Source: ABdhPJyObWDok1yrGBZMArZ5kaaLv96DnwKwvTrRko4zOcN8h+AdOW63Sv6U27UJnBwdtwYUqC3e7CiZsj+n5rE/2+I=
X-Received: by 2002:aca:1c0b:: with SMTP id c11mr151372oic.71.1605030643896;
 Tue, 10 Nov 2020 09:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20201110130338.143077-1-f.suligoi@asem.it>
In-Reply-To: <20201110130338.143077-1-f.suligoi@asem.it>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 18:50:32 +0100
Message-ID: <CAJZ5v0j24AngG5Jx6BAH+XE4APa0SAQHGZ2tnMgeyvc4hnkrHg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: fix spelling mistakes
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2020 at 2:03 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/firmware-guide/acpi/acpi-lid.rst       | 8 ++++----
>  Documentation/firmware-guide/acpi/method-tracing.rst | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/acpi-lid.rst b/Documentation/firmware-guide/acpi/acpi-lid.rst
> index 874ce0ed340d..71b9af13a048 100644
> --- a/Documentation/firmware-guide/acpi/acpi-lid.rst
> +++ b/Documentation/firmware-guide/acpi/acpi-lid.rst
> @@ -19,9 +19,9 @@ report the "current" state of the lid as either "opened" or "closed".
>
>  For most platforms, both the _LID method and the lid notifications are
>  reliable. However, there are exceptions. In order to work with these
> -exceptional buggy platforms, special restrictions and expections should be
> +exceptional buggy platforms, special restrictions and exceptions should be
>  taken into account. This document describes the restrictions and the
> -expections of the Linux ACPI lid device driver.
> +exceptions of the Linux ACPI lid device driver.
>
>
>  Restrictions of the returning value of the _LID control method
> @@ -46,7 +46,7 @@ state is changed to "closed". The "closed" notification is normally used to
>  trigger some system power saving operations on Windows. Since it is fully
>  tested, it is reliable from all AML tables.
>
> -Expections for the userspace users of the ACPI lid device driver
> +Exceptions for the userspace users of the ACPI lid device driver
>  ================================================================
>
>  The ACPI button driver exports the lid state to the userspace via the
> @@ -100,7 +100,7 @@ use the following kernel parameter:
>  C. button.lid_init_state=ignore:
>     When this option is specified, the ACPI button driver never reports the
>     initial lid state and there is a compensation mechanism implemented to
> -   ensure that the reliable "closed" notifications can always be delievered
> +   ensure that the reliable "closed" notifications can always be delivered
>     to the userspace by always pairing "closed" input events with complement
>     "opened" input events. But there is still no guarantee that the "opened"
>     notifications can be delivered to the userspace when the lid is actually
> diff --git a/Documentation/firmware-guide/acpi/method-tracing.rst b/Documentation/firmware-guide/acpi/method-tracing.rst
> index 0aa7e2c5d32a..6ab6c0964042 100644
> --- a/Documentation/firmware-guide/acpi/method-tracing.rst
> +++ b/Documentation/firmware-guide/acpi/method-tracing.rst
> @@ -98,7 +98,7 @@ subject to change::
>     [    0.188903]   exdebug-0398 ex_trace_point        : Method End [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
>
>  Developers can utilize these special log entries to track the AML
> -interpretion, thus can aid issue debugging and performance tuning. Note
> +interpretation, thus can aid issue debugging and performance tuning. Note
>  that, as the "AML tracer" logs are implemented via ACPI_DEBUG_PRINT()
>  macro, CONFIG_ACPI_DEBUG is also required to be enabled for enabling
>  "AML tracer" logs.
> --

Applied as 5.10-rc material, thanks!
