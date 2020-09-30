Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4D727EE98
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgI3QLA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731045AbgI3QLA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Sep 2020 12:11:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA13C061755;
        Wed, 30 Sep 2020 09:11:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14so189195pju.1;
        Wed, 30 Sep 2020 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTDQ03JaaU0pCUT0VmAuAf0qZb00z72Lvx8xRhyXqcg=;
        b=NbbaS9N1eZCO1LqaL2jIO4aaR1z3M6G6u/IEuZZrZ6IZUr79twMPEwng0YKO/4c7DC
         mwXQXnBCxanU29NRbMvzmlZkDlZBTsT/Dlt7D+ep1JxIpACIAb7cwx+2mQkXXXqeeMQ8
         NGOj2Ux4HJv+LLyXJ5AhtVb8kWWDdli6m5ehBfADk7vxF9agIlSB2RGPrJeh9wkKab6I
         tE4HPtvSUzSI4dTcgJOTmJwNlZ9sYPEI49BwcaRNj7ovPd5qpLDh0Ov6BBtN/Tnb8S7q
         1NpCwwyGR2zdbAQ8MbHb1XYOqemIJOn/MaEdAb/814o22nfLLcjhQF6muKsIDFdVnAhe
         4yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTDQ03JaaU0pCUT0VmAuAf0qZb00z72Lvx8xRhyXqcg=;
        b=s0qyiGgoUs9sBh8yXcgdcjucjCmL8MZPuBUpFcWzU4mxD5HdyB1StNeyOUlJnH2A1d
         QhXQTWA2XRklBWpuGKWXQIAsOle37hXuL5jXL0qfHdJUIAH78DRnzwWC8uH82g5pIiFS
         oJ6m4kbo909afeLee7vH4PO7t4DjI7FlkYxq1aPLxL1Onj1C8SK0aXekiZu6+5urA2Of
         KckPT9F06HUrCowGX7B03ZDnDnn6BJuIVjQjqQRp9e0/e5oW9q1Xjcqu9pqRLYXsMlkj
         W7wCYqvFn6AgJEzsFO3rcYZRTK0uJul5Vrc9cx2q8nmSU/mEMbr7bVKxeS68ZaoohUIY
         wppw==
X-Gm-Message-State: AOAM532rR8W2Fl9l+PxJ4HvKlzJ2FNFzt/ptERpPtQD4ewQpSrOAiAek
        Bx91oNiFEvvAGmB6WkKd5l/rnMFAYZLAiygJGEg=
X-Google-Smtp-Source: ABdhPJypZxIgeasjDPmZIxv+YbCt7JPYj4LL0KUyS02Zd2P0g2L4oz+1uil2u/pivOftqlcbjoEUdXrwcMgr7re3JLE=
X-Received: by 2002:a17:902:ea8c:b029:d2:8abd:c8de with SMTP id
 x12-20020a170902ea8cb02900d28abdc8demr3252779plb.21.1601482258930; Wed, 30
 Sep 2020 09:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it> <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
 <CAHp75VfgEGydXN1A+Y=wn3iX1MbLhN8F9kYyfQwTZBJydr+0+Q@mail.gmail.com>
 <feb8567c830748c483c8c66dd4717003@asem.it> <CAHp75Vdd2QjvJvLGHa1x=RaSknEG+O+YB4eJA6+2htnZ=Gf52g@mail.gmail.com>
 <22753b53cd7d4dfba4ef3610f71cc462@asem.it> <20200930130113.GQ3956970@smile.fi.intel.com>
 <2c26adae711145639d0b982a354aff3c@asem.it> <CAHp75Vcq1WOcMNoKpOSpCD1mFSyvYsaX-h7KHTaAOPe=6S4e0A@mail.gmail.com>
In-Reply-To: <CAHp75Vcq1WOcMNoKpOSpCD1mFSyvYsaX-h7KHTaAOPe=6S4e0A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Sep 2020 19:10:39 +0300
Message-ID: <CAHp75Vdm9K7nGxsk8P_iGy4m=vi=95zpH1S4NuJbb7bekwZoXg@mail.gmail.com>
Subject: Re: How to use an ACPI declared GPIO in a userspace ...
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 30, 2020 at 6:54 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Sep 30, 2020 at 6:39 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
> > > I guess you simply didn't get. The "gpio-line-names" property of GPIO
> > > *controller* (provider!) and you are trying to do something with the
> > > *consumer*
> > > if I got it right.
> > >
> > > And of course GPIO line, which has name, has no difference in use from
> > > another
> > > w/o name assigned. You will need to request it by *consumer* either in
> > > kernel
> > > or in user space.
> > >
> > > To be more precise we have to look at your DSDT.
>
> ^^^^^^^ **DSDT**.
>
> > My SSDT table is:
>
> ^^^^ See the difference? I can't help here.

There are two ways to get DSDT:
 1. % cp -a /sys/firmware/acpi/tables /tmp/mytables; tar -cf
mytables.tar /tmp/mytables
 2. % acpidump -o mytables.dat # preferable

> > So I need a "consumer", but I don't want to export the GPIO using its number...
> > If you have any suggestion ...
>
> Define "gpio-line-names" property in the *provider* (controller)
> device node _DSD().


-- 
With Best Regards,
Andy Shevchenko
