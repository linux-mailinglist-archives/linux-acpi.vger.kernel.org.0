Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B3635CFFA
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbhDLSGB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 14:06:01 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38869 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbhDLSGB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 14:06:01 -0400
Received: by mail-ot1-f47.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so13640842otk.5;
        Mon, 12 Apr 2021 11:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxFfMLp+11/U1kVBkFA7VCERIwGoytrzbv2ZEzy0Egk=;
        b=C34XhHd8CrInnhixCKE9uF6Hzt9Q9XmHS5Md8k2a2t1KdeoTn3KJ/m7J+RQSXUS25y
         boF7jaDPixpyAvznP9k62yyOhE9ucWffWRi9BSjjUXgffNPansYoOJjR9RUwKKc5OGTP
         OiKCXGQGxI/VY88cdTiaxHsfXrTe4W3MW7uDw9jypfG5Max82wBIvRQ/BwHBOlWhzF65
         H6fZY9PnQt6DN30hUe8tVX9EjB59+IAevpZo3UdaqseCzHm63riO38KtA09UJZOVqsKg
         dqoe49YoNraO0TYRJG45eoWWtU+a4cSxf6P/LQ5M+609pOiBts33aFq5HJxX28sZkHZW
         h1Gw==
X-Gm-Message-State: AOAM532+FBHini7cVx99CGWG4EsrJl/14DHa+zLII3xmGugWsraW9Gig
        ov2Unmv06wvn5BdFRdnQdy+6I50f9lXXjJyiBb0=
X-Google-Smtp-Source: ABdhPJx+ROAYPoDHg8Kv+g+kvtgJzou978kwiAXLMZZwqhXyLzjacHyl0s5dyunB1b3t5UfKi4qjIgDbNj3jtwIxLFs=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr24903704otb.260.1618250742718;
 Mon, 12 Apr 2021 11:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210410134718.1942273-1-andy.shevchenko@gmail.com>
 <CAJZ5v0jQ=UU8FgFFF_ht_v1dZwhp-32wi_QNaZuf6vBaORU41w@mail.gmail.com> <CAHp75VeW7w-tX96B8Gh=E1meTHLzuocqaM2MTLyokc5hETVj7A@mail.gmail.com>
In-Reply-To: <CAHp75VeW7w-tX96B8Gh=E1meTHLzuocqaM2MTLyokc5hETVj7A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 20:05:31 +0200
Message-ID: <CAJZ5v0jTQziFzc7pZ631=iigm6nv7xKAYyaA64pssAPKTA522g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: bus: Introduce acpi_dev_get() and reuse it
 in ACPI code
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 12, 2021 at 7:47 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 12, 2021 at 8:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Sat, Apr 10, 2021 at 3:47 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
>
> ...
>
> > >  static void get_acpi_device(void *dev)
> > >  {
> > > -       if (dev)
> > > -               get_device(&((struct acpi_device *)dev)->dev);
> > > +       acpi_dev_get(dev);
> >
> > I would do
> >
> > if (dev)
> >     acpi_dev_get(dev);
> >
> > here.
>
> Hmm... I don't see a point. acpi_dev_get() guaranteed to perform this check.
>
> > >  }
>
>
> > > +static inline void acpi_dev_get(struct acpi_device *adev)
> > > +{
> > > +       if (adev)
> > > +               get_device(&adev->dev);
> >
> > And I would drop the adev check from here (because the code calling it
> > may be running with wrong assumptions if adev is NULL).  Or it should
> > return adev and the caller should be held responsible for checking it
> > against NULL (if they care).
>
> But this follows the get_device() / put_device() logic.

Not really.  get_device() returns a pointer.

> Personally I don't think this is a good idea to deviate.

Well, exactly. :-)

> Note the acpi_bus_get_acpi_device()

This also returns a pointer.

> / acpi_bus_put_acpi_device() as well.
