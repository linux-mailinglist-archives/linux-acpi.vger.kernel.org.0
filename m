Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C793A6A8F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhFNPik (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 11:38:40 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44965 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhFNPie (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 11:38:34 -0400
Received: by mail-oi1-f178.google.com with SMTP id a26so14707539oie.11
        for <linux-acpi@vger.kernel.org>; Mon, 14 Jun 2021 08:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+Ao5EOS1rNsnHYwPwhdeli96EemqTzYZPx2ynmYjBI=;
        b=GpRC5MBq90zOzvbNER/fZlFsgGDqBJoKU2UwfAB5g5PNEDuCoDsmhB4wxAuGs1Pou3
         G0hIT8hLA76+2CtWO49kXVSnCYsRlvUZLxkPX4UTznfa3u170DHHuRwRbMj7J6UV8lGk
         rAY35PszDnym4AqozsM1YhOPLXpq4Zf7+Gd6B0mzBUNo6lmhDgSjH1CJNKGdVqlEi3ip
         dVW/eTZHiUnMU8995G243vQdlFgJk8qHm7YnluKwsHC4jkeKXhS/Cci1Yk2hVdEs0/0R
         o/D5I/vfnbsgElmep9E5iv3EEUTPvtY6Jb2LSEftRMN/7RcwLoR5q454ahDPf6K/cvR2
         lGDA==
X-Gm-Message-State: AOAM531Ae5Vj6HK0f+cH5l4nIxhSUWTbHoXdBeFM4Xca/0aQcjHqYh7O
        dUIQ5qyTp6s2cWmUNvdyC+jIiTAwwX9I8Q4Uqn0=
X-Google-Smtp-Source: ABdhPJydiNDRiMt7L3f8M0wPUnRv+5m0CYsGf3qzV8NxkV+y4mZvjcvsNLf1nsx0i7DmzQpJJtIkyAN0uBMNfpeqeWg=
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr10337820oiw.69.1623684990099;
 Mon, 14 Jun 2021 08:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210612223401.9273-1-majortomtosourcecontrol@gmail.com>
In-Reply-To: <20210612223401.9273-1-majortomtosourcecontrol@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 17:36:19 +0200
Message-ID: <CAJZ5v0idK5cneSF8+A1SrHcs-WHQLmTeAJdB72yNNfH5QygWoQ@mail.gmail.com>
Subject: Re: [PATCH] acpi: sysfs: Fixed a control flow style issue
To:     Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jun 13, 2021 at 12:37 AM Clayton Casciato
<majortomtosourcecontrol@gmail.com> wrote:
>
> Fixed coding style issue.

I'm not really sure what issue you are fixing here.

Is it the redundant braces around the nested if () statement?

If so, the flow before and after the patch is different.  Is this intentional?

> Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> ---
>  drivers/acpi/sysfs.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index d6626aba4a6a..0e685ca8f78f 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -254,15 +254,15 @@ static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
>  {
>         if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
>                 return sprintf(buffer, "disable\n");
> -       else {
> -               if (acpi_gbl_trace_method_name) {
> -                       if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
> -                               return sprintf(buffer, "method-once\n");
> -                       else
> -                               return sprintf(buffer, "method\n");
> -               } else
> -                       return sprintf(buffer, "enable\n");
> -       }
> +
> +       if (acpi_gbl_trace_method_name) {
> +               if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
> +                       return sprintf(buffer, "method-once\n");
> +               else
> +                       return sprintf(buffer, "method\n");
> +       } else
> +               return sprintf(buffer, "enable\n");
> +
>         return 0;
>  }
>
> --
> 2.31.1
>
