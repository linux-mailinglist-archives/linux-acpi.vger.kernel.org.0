Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62DA42C7A3
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 19:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhJMRdE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 13:33:04 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39670 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJMRdD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 13:33:03 -0400
Received: by mail-oi1-f180.google.com with SMTP id m67so4827591oif.6;
        Wed, 13 Oct 2021 10:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVnFB119/oJ5Al/x8zsLYr57TgLUXHPieJqQ8mO5qxk=;
        b=vnRA4c70LUW/m8eDx1zY3o2hjezWXFY8JMqPpcKcpuT3e8Gv/bIHb2ykiVfAgOnwi5
         xjMjFkGc+mlf6TZJ7xa81ZyxPyjrXatnFfPmOaM7xUWNjBKwO+EipJj6Dl65jiNFFdRG
         r2qfxZUxxFT8dp4nskbIYWSROhd7YqLCNHej8yiLsrZknqq9Z63HGCtbd3xrOBjuAuiI
         SyBNUAmOTvQfLee/LM1OAs3ZSpVhDxRqN5vVYvn8fx6IuYO1bfBENp/E83dhGXs5waKi
         y2zoZ+gl4Ks7Nhl01npvdCfMlCu1o0R3T9kkHCIm9jQRuiKiW5PJpBnAjA11clbU9Nhv
         CPwA==
X-Gm-Message-State: AOAM531A4Q9hnGlmeolqJRQd6BuQ9AqLO01XqayP4Dbfq3k4oVb3e5sh
        H2x5O068AHBcIe3vOf1k9LwDM4Urzps/ipawPRQ=
X-Google-Smtp-Source: ABdhPJxRkW6hoNk6Jbw5tsZbBcuUzSiuzhUWnX3E2Ar9SgQUV03dvgOo/KQMNROTgnmJga5lEI69QNlnUHem1s2Zxzs=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr9377920oif.51.1634146260119;
 Wed, 13 Oct 2021 10:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143707.80222-1-andriy.shevchenko@linux.intel.com> <CAGETcx_mNWumqmYzytvKG+FvPLA=DWokbbtFv=EGet41G6cQeQ@mail.gmail.com>
In-Reply-To: <CAGETcx_mNWumqmYzytvKG+FvPLA=DWokbbtFv=EGet41G6cQeQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Oct 2021 19:30:49 +0200
Message-ID: <CAJZ5v0jJyjYAreubd6ySrt-61Ca4PJUOu6D8VXC1k1GTyVyDZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Add missed header in fwnode.h
To:     Saravana Kannan <saravanak@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 7:21 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Oct 13, 2021 at 7:37 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When adding some stuff to the header file we must not rely on
> > implicit dependencies that are happen by luck or bugs in other
> > headers. Hence fwnode.h needs to use bits.h directly.
> >
> > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Acked-by: Saravana Kannan <saravanak@google.com>

I'm going to pick this up, thanks!

> > ---
> >  include/linux/fwnode.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 9f4ad719bfe3..3a532ba66f6c 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -11,6 +11,7 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/list.h>
> > +#include <linux/bits.h>
> >  #include <linux/err.h>
> >
> >  struct fwnode_operations;
> > --
> > 2.33.0
> >
