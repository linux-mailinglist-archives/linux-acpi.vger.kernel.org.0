Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC9372CB8
	for <lists+linux-acpi@lfdr.de>; Tue,  4 May 2021 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhEDPHZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 May 2021 11:07:25 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33507 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhEDPHZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 May 2021 11:07:25 -0400
Received: by mail-oi1-f181.google.com with SMTP id t8so9089883oij.0;
        Tue, 04 May 2021 08:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoAjfrltSVyzvHATSeL3gfPA6CxQb+8qG4ggVE86NF4=;
        b=pW1VPaG0RvrooohH5oP+KMyJzW4ZcmLxQvKJCYKQQHs6osToay/4x39O9qOswENULW
         yiIjBYtq+M6L0m1NSYmAy0wV+sZsFEJzRijDg8TUtkLzcH9/1WuJ+ucTPjvpyykzdldY
         oP6HAvk3rppuIUf3vcI0Ga3ZkSTtqJLzPn8twIpJnpMpEVYcV92Md91m4c56J/2NDCaF
         WDj4t8o58fL/j+5XF1pXvqlaWAtHu+F50jlNYii/KZiqsoMsoxa+P+Ityv6omWiU3D7a
         4NF+O3qjOp7gPs4zYvZB5l/mqtzO2dpNppKywZhGagrZt6+XfJmmSwlcGYrKEUIyGt5B
         FECg==
X-Gm-Message-State: AOAM531jhgC3/C7v5/8IOMHtOzTVfMRqDnWmJrWQEQR7F/dukIUKi14Y
        X3fLw1z20Z0oS9ccGODgbcMw9A8gAlXFnEEV244=
X-Google-Smtp-Source: ABdhPJwVsXKxb3GOizSOvfMCjDGsNHTB3bqdiC6ZUtdfFWJdsnaPFHeqKA75hPeaVxAyaYI8wOgsXoF7XIrl9NTEgxQ=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr17430830oib.69.1620140787763;
 Tue, 04 May 2021 08:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210502172326.2060025-1-keescook@chromium.org>
 <0fefece0-f8a1-6ee1-114f-0a2bb412b986@redhat.com> <YJAN/nwldJKwTV/V@kroah.com>
In-Reply-To: <YJAN/nwldJKwTV/V@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 May 2021 17:06:10 +0200
Message-ID: <CAJZ5v0ioc1t62C68g7twcJRQixiB2uxCpcW3QFu6Rpwu15jUzw@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Langsdorf <mlangsdo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 3, 2021 at 4:51 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 03, 2021 at 08:17:14AM -0500, Mark Langsdorf wrote:
> > In 5/2/21 12:23 PM, Kees Cook wrote:
> > > This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.
> > >
> > > While /sys/kernel/debug/acpi/custom_method is already a privileged-only
> > > API providing proxied arbitrary write access to kernel memory[1][2],
> > > with existing race conditions[3] in buffer allocation and use that could
> > > lead to memory leaks and use-after-free conditions, the above commit
> > > appears to accidentally make the use-after-free conditions even easier
> > > to accomplish. ("buf" is a global variable and prior kfree()s would set
> > > buf back to NULL.)
> > >
> > > This entire interface needs to be reworked (if not entirely removed).
> > >
> > > [1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
> > > [2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
> > > [3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/
> > >
> > > Cc: Wenwen Wang <wenwen@cs.uga.edu>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> >
> > I have two patches submitted to linux-acpi to fix the most obvious bugs in
> > the current driver.  I don't think that just reverting this patch in its
> > entirety is a good solution: it still leaves the buf allocated in -EINVAL,
> > as well as the weird case where a not fully consumed buffer can be
> > reallocated without being freed on a subsequent call.
> >
> > https://lore.kernel.org/linux-acpi/20210427185434.34885-1-mlangsdo@redhat.com/
> >
> > https://lore.kernel.org/linux-acpi/20210423152818.97077-1-mlangsdo@redhat.com/
> >
> > I support rewriting this driver in its entirety, but reverting one bad patch
> > to leave it in a different buggy state is less than ideal.
>
> It's buggy now, and root-only, so it's a low bar at the moment :)

So dropping it completely may be a better choice.

IMO let's let the Mark's commits go in now and we'll see later.

Thanks!
