Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9900276F99
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgIXLNh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Sep 2020 07:13:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34671 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgIXLNd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2020 07:13:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id h17so2796648otr.1;
        Thu, 24 Sep 2020 04:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vw74ycCgBHC0q8oTAIx0tHNkNEToJ5HsGmMW3OjG2c=;
        b=t9CiWyWXtJ77yoQQfZLVuqy+qNz14TntqXKYIZMk/H+IkjYk0LprSCpnaZyHSyLXBm
         1BGCZlyG5bcuv/qb5WlDOHkaNmihfwT2rBgweRnUs+C3PaB5iy/UGbtAP4dTo+UKCwl4
         Fwe8nFIjEk7lsFlsHs97ayLjmER6vz+N0u8SFvklNmgwrSTraXxcs47xXZMtG8mQ4jn+
         l8z47A+x8CuakKZX+PikSiz6NN/LBFeaNjqMREw153q6SELBPUrNFCFxKBbqr1h5AMTY
         n/Kiqwv8Tep0U8joFf2bVXC7loidVA9nrrn5g3LA/6uYcIFkEzhj/zAjRcd8O2L2+ZXM
         XjnA==
X-Gm-Message-State: AOAM533cgl0aId4NSf2idDoxO0+QxcAuoCx+Qf1h6t3yvYQ7TemOjZ5X
        in8agg5EYs6NFxTIw1R4jB6i4hH9icz1NfZA/vw=
X-Google-Smtp-Source: ABdhPJzE55Dn0VKs5nRnVqlMfMDK7flu5vsN32QgZuAP5WRxnUrOVaBdYpqp33AmOAAfA/kGrJWwq4bwCqLmDpOeVvg=
X-Received: by 2002:a9d:718a:: with SMTP id o10mr595177otj.262.1600946012489;
 Thu, 24 Sep 2020 04:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600816121.git.skhan@linuxfoundation.org> <9e2c6cccabc96fe1e5304e2fa2dfdad28ca5ac9c.1600816121.git.skhan@linuxfoundation.org>
In-Reply-To: <9e2c6cccabc96fe1e5304e2fa2dfdad28ca5ac9c.1600816121.git.skhan@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Sep 2020 13:13:21 +0200
Message-ID: <CAJZ5v0iS2wpvvJGLsEJSSdCJ0tf4DmJ9fQWVU3PzFuMB7Zbkjw@mail.gmail.com>
Subject: Re: [RFC PATCH 05/11] drivers/acpi: convert seqno counter_atomic
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 23, 2020 at 3:44 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> counter_atomic is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
>
> counter_atomic variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
>
> seqno is a sequence number counter for logging. This counter gets
> incremented. Unsure if there is a chance of this overflowing. It
> doesn't look like overflowing causes any problems since it is used
> to tag the log messages and nothing more.
>
> Convert it to use counter_atomic.
>
> This conversion doesn't change the oveflow wrap around behavior.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Both this change and the next patch are fine by me.

Thanks!

> ---
>  drivers/acpi/acpi_extlog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f138e12b7b82..23b696b7eb14 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -12,6 +12,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/edac.h>
>  #include <linux/ras.h>
> +#include <linux/counters.h>
>  #include <asm/cpu.h>
>  #include <asm/mce.h>
>
> @@ -93,7 +94,7 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
>  static void __print_extlog_rcd(const char *pfx,
>                                struct acpi_hest_generic_status *estatus, int cpu)
>  {
> -       static atomic_t seqno;
> +       static struct counter_atomic seqno;
>         unsigned int curr_seqno;
>         char pfx_seq[64];
>
> @@ -103,7 +104,7 @@ static void __print_extlog_rcd(const char *pfx,
>                 else
>                         pfx = KERN_ERR;
>         }
> -       curr_seqno = atomic_inc_return(&seqno);
> +       curr_seqno = counter_atomic_inc_return(&seqno);
>         snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
>         printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
>         cper_estatus_print(pfx_seq, estatus);
> --
> 2.25.1
>
