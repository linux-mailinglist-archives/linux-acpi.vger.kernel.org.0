Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE6E35D012
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 20:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbhDLSNK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 14:13:10 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46838 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbhDLSNJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 14:13:09 -0400
Received: by mail-oi1-f177.google.com with SMTP id m13so14300112oiw.13;
        Mon, 12 Apr 2021 11:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLRmIGD0mbtrbQWE0Wz075QLFoZ2M2WQQT4khJXSwzs=;
        b=kUI+/IAv+RCVodrsvsLq++s0fAz4nhefsBuN9M6ujTreL+GvdTO5BRDzy+ONu6rsRW
         VrR+/oV9dnd7tiBfRJ//aGkl15PEMjXteDXqCEgkjda7dVPqok40jJbBHRRd8ocZ1JUm
         RG6g5upa+uGI00pId3aTUaAyrPTvwdxCWiMzRPWe0k8aGpqDc/+H+23CV+mVIvbyt+rc
         PzxvZ8Vw9EBTSf+1pfQ+0+Lg3BpbiCrVeClEYCN/KrL1U2Mu4GCyEoDkDJGq4r6hO57m
         srhGvtqWZXgQZzkDYQA60KMxGLsJMZA1FP3w4adu8z9KrgG84gT0zfHEAqDRi7jOSD5x
         e6+g==
X-Gm-Message-State: AOAM531hHqWg9rzAhFJkAxDXzXF1ColzzU3kp+hceLmNDN95upoRroLe
        4X4xVVvZV020pINBDfClPBKjiXx8T/mUpJl43uyguF9B
X-Google-Smtp-Source: ABdhPJxk0RjgumnGUEVHGOg01bTZd8kK1/X40tZnDgvo74P9hdZkOj1C8QiGp+eODzXqdmYVynrW+vck8hBPGp1WvKs=
X-Received: by 2002:aca:aa8f:: with SMTP id t137mr315642oie.71.1618251169899;
 Mon, 12 Apr 2021 11:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210410134718.1942273-1-andy.shevchenko@gmail.com>
 <CAJZ5v0jQ=UU8FgFFF_ht_v1dZwhp-32wi_QNaZuf6vBaORU41w@mail.gmail.com>
 <CAHp75VeW7w-tX96B8Gh=E1meTHLzuocqaM2MTLyokc5hETVj7A@mail.gmail.com>
 <CAJZ5v0jTQziFzc7pZ631=iigm6nv7xKAYyaA64pssAPKTA522g@mail.gmail.com> <CAHp75VcdZq9afovEP1Di6ScoFvBMuV0Es-XcuP60-Ewr9mfX5w@mail.gmail.com>
In-Reply-To: <CAHp75VcdZq9afovEP1Di6ScoFvBMuV0Es-XcuP60-Ewr9mfX5w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 20:12:38 +0200
Message-ID: <CAJZ5v0jHWF2q550pAo+s2s+dN+FLKAQ8yzY9d1p1Ww3t116pzA@mail.gmail.com>
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

On Mon, Apr 12, 2021 at 8:10 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 12, 2021 at 9:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Apr 12, 2021 at 7:47 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > On Mon, Apr 12, 2021 at 8:32 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Sat, Apr 10, 2021 at 3:47 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > >
> > > ...
> > >
> > > > >  static void get_acpi_device(void *dev)
> > > > >  {
> > > > > -       if (dev)
> > > > > -               get_device(&((struct acpi_device *)dev)->dev);
> > > > > +       acpi_dev_get(dev);
> > > >
> > > > I would do
> > > >
> > > > if (dev)
> > > >     acpi_dev_get(dev);
> > > >
> > > > here.
> > >
> > > Hmm... I don't see a point. acpi_dev_get() guaranteed to perform this check.
> > >
> > > > >  }
> > >
> > >
> > > > > +static inline void acpi_dev_get(struct acpi_device *adev)
> > > > > +{
> > > > > +       if (adev)
> > > > > +               get_device(&adev->dev);
> > > >
> > > > And I would drop the adev check from here (because the code calling it
> > > > may be running with wrong assumptions if adev is NULL).  Or it should
> > > > return adev and the caller should be held responsible for checking it
> > > > against NULL (if they care).
> > >
> > > But this follows the get_device() / put_device() logic.
> >
> > Not really.  get_device() returns a pointer.
> >
> > > Personally I don't think this is a good idea to deviate.
> >
> > Well, exactly. :-)
> >
> > > Note the acpi_bus_get_acpi_device()
> >
> > This also returns a pointer.
>
> Is it okay to return a pointer in acpi_dev_get() then?

Yes, it is, as I've said already.
