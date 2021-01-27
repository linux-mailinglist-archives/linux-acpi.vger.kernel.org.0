Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6238E305D94
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 14:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhA0Nv1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 08:51:27 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:44686 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhA0Nuy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2021 08:50:54 -0500
Received: by mail-oo1-f51.google.com with SMTP id n19so523788ooj.11;
        Wed, 27 Jan 2021 05:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEOztENIm4lBjLjdgYkobjrAaOBHM+q4Q4zzeEUvgD8=;
        b=aq/4JlS4YVTtHcOXunMiXxGpgvBR62SCyXooVi1HjDDsiQ+F3u1lIL/xVn8s4bt+Np
         P+ggR4eYY9ZhzkAyH+J8URXZ8qlFk7/pC7o0VfpTkak+UsmnISEpXcdt62BYkJull06Q
         P9Hf3Eg0I028qzF+SYcmra+Vp6+Vey/gy7vfy621ZJC0vu/pbfeC8+inY1OIKpmHY1cZ
         fUbtRG892Vx0eHCp5xgW+cMpDEDXCIeSVg8WoUuogsX2PYvUwbanumCfnngRNZ+W2R1t
         44qIr0DueXndTH/e6yeT+opmrnteqBCmFL0nbhBxH7p2cAARwJsElR31vmnVShorBaRV
         Benw==
X-Gm-Message-State: AOAM533J8JEk4DSRARj7RKNPBY8tXk8WZeaVlk422I/+Dlvpbo2jaEvY
        6qms6F2dFWYDm41T+D+nxK9NB0kLoBklkbZFqIU=
X-Google-Smtp-Source: ABdhPJwxqmW4ZQMrt3FU6CfrZ9R3+3IKqVrt5Bs+JZW0EQ83HLgm8FeJZgkpuy6FUXXdfXcTpDHyyM6WOFBKti6WxHw=
X-Received: by 2002:a4a:cb87:: with SMTP id y7mr7786272ooq.1.1611755412554;
 Wed, 27 Jan 2021 05:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-5-mika.westerberg@linux.intel.com> <CAJZ5v0i+wCOFZOhyx6i=TUGMeWyQR4vXzDN06G6xheFwC66Tuw@mail.gmail.com>
 <SA1PR19MB4926907D028D3F924FF42A36FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
 <CAJZ5v0hQ_JZVfOpSZY0hxc01He9x7uzgU2rsKffmQubaeKy=EA@mail.gmail.com>
 <SA1PR19MB4926A9A1E4D0AD96FAE236B3FABC9@SA1PR19MB4926.namprd19.prod.outlook.com>
 <20210127124935.GC2542@lahna.fi.intel.com>
In-Reply-To: <20210127124935.GC2542@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jan 2021 14:50:00 +0100
Message-ID: <CAJZ5v0gQv2iKbyWLgEActwv1_ea0cMkT5dwvKBGqRtZE3Wo6NQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 27, 2021 at 1:49 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Jan 26, 2021 at 10:43:32PM +0000, Limonciello, Mario wrote:
> > > I would put that information into the changelog.
> >
> > Thanks, @Mika Westerberg can you collapse that in when you re-spin the
> > series?
>
> Sure.
>
> > >
> > > Moreover, have you looked at acpi_pci_osc_control_set()?
> > >
> > > What it does is analogous to what you are proposing, but a bit
> > > different, and I would like to preserve consistency between _OSC use
> > > cases.
> > >
> > > So would it be possible to adjust the _SB _OSC evaluation flow to
> > > follow the PCI _OSC one?  That is, if any control bits are there, pass
> > > them along with the last evaluation of _OSC with the query flag clear.
> > > Or is the latter defective and if so then why?
> >
> > Basically the only difference is another line cloning OSC_CONTROL_DWORD from
> > capbuf_ret to capbuf?
> >
> > Yes, this actually sounds like it better adheres to the spec to me.
> >
> > Quoting spec:
> > " If the OS is granted control of a feature in the Control Field in one call to
> > _OSC, then it must preserve the set state of that bit (requesting that feature)
> > in all subsequent calls."
>
> However, the platform wide _OSC does not actually have this
> OSC_CONTROL_DWORD at all ;-)

Right.

> I think what we do in this patch is already equivalent to what the PCI
> _OSC is doing:
>
>   1. Query bit set _OSC
>   2. Take the returned OSC_SUPPORT_DWORD buffer and
>   3. Pass it to the _OSC with query bit clear.

Yes, it is.

Given the way the USB4 _OSC protocol is defined (which admittedly
confused me somewhat), the code changes in this patch are fine by me.

Thanks and sorry for the confusion.
