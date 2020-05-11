Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE51CD21D
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEKGzL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728353AbgEKGzL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 02:55:11 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B74C05BD09
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2020 23:55:11 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so6706296otf.6
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2020 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqE5Hd6mfokSG+/fYRFQAPgofHTiWpj3lFcNor9u7kc=;
        b=Zg11uLNU9ywU36wb9YDC/vWtcGTb03E8YdiJ0DCgs4CFFAhhLJ1RIkzQzTryf4jaxq
         YBJ3t796heGmNrxmFjgB0VQTo7gXh7lKcxbrgk7foaMVMJXw+Q85cSbM5phLukcsZFCs
         JpbjAyYV1ScyY/FKb29xvy2GrG2b+MgCM+lL69Gad/0filOPGUKUtPBP/8oVwJzjYyIF
         WnJCLUCIJaRirrMuvApKGEUYBFVgcqxhvopk0NZjyh4bcJHCwHAhKMB6wVz5p77Hbo9k
         UOUF+8QD3dj1w8UciJreTMX2LRuu1u6lG/TBpwlZ133chk1H3o1BD2irZMo33jbUFdr+
         LqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqE5Hd6mfokSG+/fYRFQAPgofHTiWpj3lFcNor9u7kc=;
        b=Lm8ii2mlRtdbPrX7foJ4QIfc6q7w7phNdFxDky4QzILIVeMW2gZUmhEMrCiJfO26jY
         cKhd+xP838+AThIFOjx3SuOOfBkL84Q0PhrZF+Dfjg7Gp9lKLg/8YmWBc0+7gB+bB0aE
         2p2nXgUVRHkfxWAtefC3Kko0dDzENQbKmGLlZhefmT44eZZfb8VPHDCPp5By+RxgymXJ
         Dx3u5KN0iO4Fm5k2zNNao68pZMaLaQ3A3jKzucRq5qXPg5K+pB9YQGUdiKSAPmK3H1dI
         p02IcJTidlULICCDpGSi40J4xCz1K9Yy5tDz2eIWc9mhRqveKEKRqq2msnJUbxpvc6Zx
         ci0w==
X-Gm-Message-State: AGi0PuYE+tAaCkeH5A1eyu5IBQu5Lg8K6UWzl4gq+bherZHnBYpGSVar
        M95hoCZ4dgbaRdEQQGFWfyfYD7sKMpy06QGGKtTqnQ==
X-Google-Smtp-Source: APiQypJx8MZQXkFp5WsraQLtG72h4Sny3Lasm6pZs7q/K/VxbPocZXTT3hNxCb9DL3z70CaYxjtiG9/cPAgn1SDWbQY=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr12002639otp.144.1589180110526;
 Sun, 10 May 2020 23:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <13031978.1nyG40egBz@kreacher>
In-Reply-To: <13031978.1nyG40egBz@kreacher>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 11 May 2020 14:54:59 +0800
Message-ID: <CAB4CAwfpO6=24tdVBtZ258hAE=sMyww-P9t1PC=BALhy3rHxSQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: EC: s2idle: Avoid premature returns from acpi_s2idle_wake()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, May 9, 2020 at 4:44 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If the EC GPE status is not set after checking all of the other GPEs,
> acpi_s2idle_wake() returns 'false', to indicate that the SCI event
> that has just triggered is not a system wakeup one, but it does that
> without canceling the pending wakeup and re-arming the SCI for system
> wakeup which is a mistake, because it may cause s2idle_loop() to busy
> spin until the next valid wakeup event.  [If that happens, the first
> spurious wakeup is still pending after acpi_s2idle_wake() has
> returned, so s2idle_enter() does nothing, acpi_s2idle_wake()
> is called again and it sees that the SCI has triggered, but no GPEs
> are active, so 'false' is returned again, and so on.]
>
> Fix that by moving all of the GPE checking logic from
> acpi_s2idle_wake() to acpi_ec_dispatch_gpe() and making the
> latter return 'true' only if a non-EC GPE has triggered and
> 'false' otherwise, which will cause acpi_s2idle_wake() to
> cancel the pending SCI wakeup and re-arm the SCI for system
> wakeup regardless of the EC GPE status.
>
> This also addresses a lockup observed on an Elitegroup EF20EA laptop
> after attempting to wake it up from suspend-to-idle by a key press.
>
> Fixes: d5406284ff80 ("ACPI: PM: s2idle: Refine active GPEs check")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=207603
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Fixes: fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
> Link: https://lore.kernel.org/linux-acpi/CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com/
> Reported-by: Chris Chiu <chiu@endlessm.com>
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
Tested-by: Chris Chiu <chiu@endlessm.com>
>
> -> v2:
>    * Improve the changelog and add more tags.
>
> ---
>  drivers/acpi/ec.c       |   24 ++++++++++++++++--------
>  drivers/acpi/internal.h |    1 -
>  drivers/acpi/sleep.c    |   14 ++------------
>  3 files changed, 18 insertions(+), 21 deletions(-)
>
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -1013,21 +1013,11 @@ static bool acpi_s2idle_wake(void)
>                 if (acpi_check_wakeup_handlers())
>                         return true;
>
> -               /*
> -                * If the status bit is set for any enabled GPE other than the
> -                * EC one, the wakeup is regarded as a genuine one.
> -                */
> -               if (acpi_ec_other_gpes_active())
> +               /* Check non-EC GPE wakeups and dispatch the EC GPE. */
> +               if (acpi_ec_dispatch_gpe())
>                         return true;
>
>                 /*
> -                * If the EC GPE status bit has not been set, the wakeup is
> -                * regarded as a spurious one.
> -                */
> -               if (!acpi_ec_dispatch_gpe())
> -                       return false;
> -
> -               /*
>                  * Cancel the wakeup and process all pending events in case
>                  * there are any wakeup ones in there.
>                  *
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1994,23 +1994,31 @@ void acpi_ec_set_gpe_wake_mask(u8 action
>                 acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
>  }
>
> -bool acpi_ec_other_gpes_active(void)
> -{
> -       return acpi_any_gpe_status_set(first_ec ? first_ec->gpe : U32_MAX);
> -}
> -
>  bool acpi_ec_dispatch_gpe(void)
>  {
>         u32 ret;
>
>         if (!first_ec)
> +               return acpi_any_gpe_status_set(U32_MAX);
> +
> +       /*
> +        * Report wakeup if the status bit is set for any enabled GPE other
> +        * than the EC one.
> +        */
> +       if (acpi_any_gpe_status_set(first_ec->gpe))
> +               return true;
> +
> +       if (ec_no_wakeup)
>                 return false;
>
> +       /*
> +        * Dispatch the EC GPE in-band, but do not report wakeup in any case
> +        * to allow the caller to process events properly after that.
> +        */
>         ret = acpi_dispatch_gpe(NULL, first_ec->gpe);
> -       if (ret == ACPI_INTERRUPT_HANDLED) {
> +       if (ret == ACPI_INTERRUPT_HANDLED)
>                 pm_pr_dbg("EC GPE dispatched\n");
> -               return true;
> -       }
> +
>         return false;
>  }
>  #endif /* CONFIG_PM_SLEEP */
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -202,7 +202,6 @@ void acpi_ec_remove_query_handler(struct
>
>  #ifdef CONFIG_PM_SLEEP
>  void acpi_ec_flush_work(void);
> -bool acpi_ec_other_gpes_active(void);
>  bool acpi_ec_dispatch_gpe(void);
>  #endif
>
>
>
>
