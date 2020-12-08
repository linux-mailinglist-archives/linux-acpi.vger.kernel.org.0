Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE232D3238
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Dec 2020 19:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgLHSdw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Dec 2020 13:33:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43738 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgLHSdw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2020 13:33:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id q25so12332245oij.10;
        Tue, 08 Dec 2020 10:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nwl2eIST4DABwkqDFi6n7PMiHyjBtDdFKeFj5htDZH0=;
        b=dG8SUGBuwQ8/13323w/ojLhPxsAdkOG7tTBhMASnppKYH3PB6pfiuRHhv0+Yn1YpKo
         cErNkLK0FbaKRiWFvsS9dTKlogcp8ERpqTBL9HHwyVaMcPQ8E1EB1/FEUI6FeUUOexsm
         tIw2Sv803+qbc+gx8X/4ggqhrR0jf7NjZVE5Y2AuoPEBA7XtFJZ9yRt2jeFLklbXNFRL
         wR+1ViOhKZS79DTAPuar3B2zuauNdJcwA8Ko4ah9VQLGuHNoIrTGEAObGGV2AFnB8LwM
         Gg1ArzR8hzJptW6QIcTJWRrBMkAZ+VCc1ig6OAy0wBjAagWS2ZmzhH1dKLOdifpd2O3+
         ibhw==
X-Gm-Message-State: AOAM532FWFdpVwpjgRQkrk5vMstW0BUabe3FpsxBZvhdbdh9TKXjxoCi
        NxyOV7ZlNWiBTNoBn0a/bBTPj+bepBO642Ymv6Ubx7Fi9/E=
X-Google-Smtp-Source: ABdhPJyf2DneYRBFd0z5Uk2tyVRzaldPOpK8zd3rG3+W7oTKXAt04AReUbuGD7Nk3PFmyjwvwvP3Wq/n6Rf/LQ6ouOI=
X-Received: by 2002:aca:cf4a:: with SMTP id f71mr3920718oig.157.1607452385646;
 Tue, 08 Dec 2020 10:33:05 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201202171120.65269-1-markpearson@lenovo.com>
 <20201202171120.65269-2-markpearson@lenovo.com> <CAJZ5v0j9jZBoyvr4=2mTq1A8dc+rbUaf=Woy3PnpKh8Bbg=-RQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j9jZBoyvr4=2mTq1A8dc+rbUaf=Woy3PnpKh8Bbg=-RQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Dec 2020 19:32:54 +0100
Message-ID: <CAJZ5v0g0Cof-6-rjjWKv76N1Nr7j=AOWMGX_zSb=FBvq_VuOGQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: platform-profile: Add platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 8, 2020 at 7:26 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Dec 2, 2020 at 6:16 PM Mark Pearson <markpearson@lenovo.com> wrote:

[cut]

> > +
> > +static ssize_t platform_profile_store(struct device *dev,
> > +                           struct device_attribute *attr,
> > +                           const char *buf, size_t count)
> > +{
> > +       int err, i;
> > +
> > +       err = mutex_lock_interruptible(&profile_lock);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!cur_profile) {
> > +               mutex_unlock(&profile_lock);
> > +               return -ENODEV;
> > +       }
> > +
> > +       /* Scan for a matching profile */
> > +       i = sysfs_match_string(profile_names, buf);
> > +       if (i < 0) {
> > +               mutex_unlock(&profile_lock);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Check that platform supports this profile choice */
> > +       if (!test_bit(i, cur_profile->choices)) {
> > +               mutex_unlock(&profile_lock);
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       err = cur_profile->profile_set(i);
>
> What if this gets a signal in the middle of the ->profile_set()
> execution?  Is this always guaranteed to work?

I got this backwards, sorry.

The "interruptible" variant is used to allow the waiters to be
interrupted, so I guess the concern is that ->profile_set() may get
stuck or just take too much time?

> > +       mutex_unlock(&profile_lock);
> > +       if (err)
> > +               return err;
> > +       return count;
> > +}
> > +
