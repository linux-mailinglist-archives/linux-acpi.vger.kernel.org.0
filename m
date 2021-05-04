Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25D8372C9E
	for <lists+linux-acpi@lfdr.de>; Tue,  4 May 2021 16:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhEDPAx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 May 2021 11:00:53 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36849 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhEDPAw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 May 2021 11:00:52 -0400
Received: by mail-oi1-f172.google.com with SMTP id i26so9034324oii.3;
        Tue, 04 May 2021 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xIW9Dposi9feXZy+NswqWTr7NRg3bMeiOam5FB0lac=;
        b=PVU3shzpRgbnGcRKm4gJHqR76nsCXbA+Gu4DUBIGEQUvr7RFR8Q22iY9okUoiEYAYI
         IxDboVP1Uz7t7bwGW/Nmjhkl5G/a+x4m42e64fbpZQF+uFR1EiXEG/1T+iuIvhur6Khk
         7ClKI4BDf54HBa48coQspLudJ/RRGdLYkgquVPdVXShRgXVfmiXNbZHVw/oI7waO8bol
         JsQvKNIPzwzd9M+ynfR2qb6rS/d5GWtWVoMEEBYN5yivR3yiCG+wStEdy1v6jdCLDSv0
         3Wl7wPurerkMdI3C2dNYCxdIe9mpaPnjNx79R+Z5xNPQEhCHiHne94ZmNH+dBrtckLmv
         Dt3w==
X-Gm-Message-State: AOAM530d6IfBo/QvpQ1Q2avatwnw0GCKMQ6VSepgnFIZ+wg/v0LGIwm+
        5tTsrAE/3LQZDuIqkmEWXFh0jc4hFkP0/nKDS6E=
X-Google-Smtp-Source: ABdhPJzlzoXQOO/OKh9uMlX2vlCUCMlznw6gXq0gZEM4wygvcplu2+GYc9ugX0LFxWrPKwR+ZP9CupBCtnLcu8cFpMo=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr17401333oib.69.1620140397577;
 Tue, 04 May 2021 07:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210502172326.2060025-1-keescook@chromium.org> <YI+CHjLBg/ob6ei4@kroah.com>
In-Reply-To: <YI+CHjLBg/ob6ei4@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 May 2021 16:59:40 +0200
Message-ID: <CAJZ5v0hohYm319Geqeb4xgJd+mn+G-Y6oWj2j_JifyaccMsh7Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Langsdorf <mlangsdo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 3, 2021 at 6:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, May 02, 2021 at 10:23:26AM -0700, Kees Cook wrote:
> > This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.
> >
> > While /sys/kernel/debug/acpi/custom_method is already a privileged-only
> > API providing proxied arbitrary write access to kernel memory[1][2],
> > with existing race conditions[3] in buffer allocation and use that could
> > lead to memory leaks and use-after-free conditions, the above commit
> > appears to accidentally make the use-after-free conditions even easier
> > to accomplish. ("buf" is a global variable and prior kfree()s would set
> > buf back to NULL.)
> >
> > This entire interface needs to be reworked (if not entirely removed).
> >
> > [1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
> > [2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
> > [3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/
> >
> > Cc: Wenwen Wang <wenwen@cs.uga.edu>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/acpi/custom_method.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> > index 7b54dc95d36b..36d95a02cd30 100644
> > --- a/drivers/acpi/custom_method.c
> > +++ b/drivers/acpi/custom_method.c
> > @@ -53,10 +53,8 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
> >       if ((*ppos > max_size) ||
> >           (*ppos + count > max_size) ||
> >           (*ppos + count < count) ||
> > -         (count > uncopied_bytes)) {
> > -             kfree(buf);
> > +         (count > uncopied_bytes))
> >               return -EINVAL;
> > -     }
> >
> >       if (copy_from_user(buf + (*ppos), user_buf, count)) {
> >               kfree(buf);
> > @@ -76,7 +74,6 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
> >               add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
> >       }
> >
> > -     kfree(buf);
> >       return count;
> >  }
> >
> > --
>
> Thanks for the revert, I'll queue it up on my larger "umn.edu reverts"
> branch that I'll be sending out for review in a day or so.

This will conflict with the material that I'm going to push on
Thursday that includes the two commits mentioned by Mark elsewhere in
this thread.
