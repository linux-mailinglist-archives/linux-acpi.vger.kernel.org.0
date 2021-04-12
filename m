Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4035D009
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbhDLSKb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 14:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241390AbhDLSK3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 14:10:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B2C061574;
        Mon, 12 Apr 2021 11:10:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j7so612939pgi.3;
        Mon, 12 Apr 2021 11:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwQeib1H2LAmGn6CcZ+mNA7UzYFYCJisfTalxUklkbg=;
        b=amGzCJApoGu5e4PDCb+QRLbBrOkO737RtGvuuH1Ji2RUHO4a+oK3sBIZvypXPzpvl5
         xEL5egDQ+CET3t8oS4RAtmrYUvxwDcyZUuIDM/oQj8H4j6ZkY6InUuuDrLHR+H06wh0s
         BA/x3494EzhOaYwVWLmu0iKg0Z7x40+Tnmaa1nydnMqwH7TlHkwMkgk0iy5NtfOWNCQR
         cCFHhYIZwJ/2TsP1XiUbz7VXgKNGLSTlLBOoIn6bWFW/S+puFvd+xa9NahOzEybY49pn
         5Iqekg3nDkoYHpJGPI5jRygkAhnzsL3m8TGox95BAoY/8lcjLxACWhNp5JxFmyC3nuQj
         pizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwQeib1H2LAmGn6CcZ+mNA7UzYFYCJisfTalxUklkbg=;
        b=iHUbcrchQqjCgzsAQnmYBhRI55OVDaHaUIPs93FP9kx6LKiBGijANzqpidovJfkSfA
         bQuTWD42ZAlQocGQy3iqRA5ta6iqBjYWzMHz4nEt0LfyRHTinc62e0TdlJyz50tLfdH9
         vFKlL6hn/CuWhsNkAgh5FwZe5WQRhjwBzBwHG+tzsrD2X+Je/hQnh2qbY8ltgCPUIRHp
         K8HJ9zkGSzJbUh/65wcRJSeot7jWs6spQvmMA852Wm6TdE4I7QTslSRFKIPE2k/NI3ih
         L3MO8I+JJ97unh54s93A6Jj07r7LiDYV9ZwlQRCeNP9RCWq+3hbVFPQ6nxGApxiRKWzD
         HLog==
X-Gm-Message-State: AOAM532wYUgR1sCsmK4LvEkKoHrs/BYSnRZfz7kWLB72TTYBN+Ve35qo
        LLooPMRxNbAFNY1kBtYAOpqlkr9YPaeD3cnqlqA=
X-Google-Smtp-Source: ABdhPJy0ASYFfIcOodmZNM4t3VSZ05VyiWvtLvALdkjI8ejUmfwl7L0tbMy91yEJ/Y4licvfkrYTLQQ+6EMRp0uXMjI=
X-Received: by 2002:a63:c48:: with SMTP id 8mr27784069pgm.74.1618251009237;
 Mon, 12 Apr 2021 11:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210410134718.1942273-1-andy.shevchenko@gmail.com>
 <CAJZ5v0jQ=UU8FgFFF_ht_v1dZwhp-32wi_QNaZuf6vBaORU41w@mail.gmail.com>
 <CAHp75VeW7w-tX96B8Gh=E1meTHLzuocqaM2MTLyokc5hETVj7A@mail.gmail.com> <CAJZ5v0jTQziFzc7pZ631=iigm6nv7xKAYyaA64pssAPKTA522g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jTQziFzc7pZ631=iigm6nv7xKAYyaA64pssAPKTA522g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Apr 2021 21:09:53 +0300
Message-ID: <CAHp75VcdZq9afovEP1Di6ScoFvBMuV0Es-XcuP60-Ewr9mfX5w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: bus: Introduce acpi_dev_get() and reuse it
 in ACPI code
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
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

On Mon, Apr 12, 2021 at 9:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 7:47 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Apr 12, 2021 at 8:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Sat, Apr 10, 2021 at 3:47 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> >
> > ...
> >
> > > >  static void get_acpi_device(void *dev)
> > > >  {
> > > > -       if (dev)
> > > > -               get_device(&((struct acpi_device *)dev)->dev);
> > > > +       acpi_dev_get(dev);
> > >
> > > I would do
> > >
> > > if (dev)
> > >     acpi_dev_get(dev);
> > >
> > > here.
> >
> > Hmm... I don't see a point. acpi_dev_get() guaranteed to perform this check.
> >
> > > >  }
> >
> >
> > > > +static inline void acpi_dev_get(struct acpi_device *adev)
> > > > +{
> > > > +       if (adev)
> > > > +               get_device(&adev->dev);
> > >
> > > And I would drop the adev check from here (because the code calling it
> > > may be running with wrong assumptions if adev is NULL).  Or it should
> > > return adev and the caller should be held responsible for checking it
> > > against NULL (if they care).
> >
> > But this follows the get_device() / put_device() logic.
>
> Not really.  get_device() returns a pointer.
>
> > Personally I don't think this is a good idea to deviate.
>
> Well, exactly. :-)
>
> > Note the acpi_bus_get_acpi_device()
>
> This also returns a pointer.

Is it okay to return a pointer in acpi_dev_get() then?

I will do it that way if there are no objections.

> > / acpi_bus_put_acpi_device() as well.



-- 
With Best Regards,
Andy Shevchenko
