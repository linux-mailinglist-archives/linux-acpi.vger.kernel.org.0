Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFB413ED2
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhIVBCd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Sep 2021 21:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhIVBCd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2021 21:02:33 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118D3C061575
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 18:01:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q81so260562qke.5
        for <linux-acpi@vger.kernel.org>; Tue, 21 Sep 2021 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tzoNjgBHHVVO82xDeud4XNE313zYxYkqzxc5/NZ08A=;
        b=GGlDWC0II2CLW7KwN7qe9pvg/MIQUgcJy/JGJ9kxJCBAUvijhRdOhhHOGA+kup9px+
         qAogffQY4KGcU9sBWz0CbucL69NEN/RunSCzX1GkrxkdpNRjnpnR6QHTH3DaQkqQV8P1
         xMrc5wA9n/s7NWLxjWZ2u45FgRGkKDZvYjTinKj4JMVyzlIDyZhrBstuUsYW46FwdKFA
         DWYay8U3ZkffzSmhKwFNZX6vcoJ73Vyoe2l+BpccKiQfV4P+wk48MyPmCREDqEPvTPoc
         8hnaVD4Hv7EdtjCH6LCxwH180X4eUhlg4DRRsZdJKK8txL8c8kWvg1+EI6ABqnpUXVhr
         Jg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tzoNjgBHHVVO82xDeud4XNE313zYxYkqzxc5/NZ08A=;
        b=WGOqM07GKGgW4oMfx/efBVkwAno+rz/NPsR8YxzWcjAT9YXV+KsLOYam3ia6CXEriX
         fel1BuE20GehTYuKIRgc0Ic3cmqxkC05iwVT7DDt9JnUbPYqXxs42/0039CIHlrdZhsN
         L1G6V6mpFIAzUYx4BZXaYDdDicdtIEqpXdxTHL4qM129kGZa8J86J1fh1kQLNP9+RWHb
         Uu1MIwPiuagZ0f0Zfn3QmjZoidSvHYRpKA8CjkxcfJMuNys2AmzD4ZCkqzlw9sGP8NM0
         YSSMxBNnhRuVDDVgyQpxlVab935+OdCr8fb/BDDER6vDD01yqTWqf3iZb5y/lwCPLkcl
         6aug==
X-Gm-Message-State: AOAM532ACdATxMrNq98nz2OBHemr26qFsCk4ETE6yei2KHhRkWb38wBS
        8fjgyjE4WATz77B/0EOuh5EUOP+kmoNS59GZcTf8vg==
X-Google-Smtp-Source: ABdhPJwFpus2NfxEVSKg2x7IV+xzPb+fbtcnBYodXLvkDbaDUMFmm0/qPQBnMspUGNvlOl5b8upBbujF82BPPlxlRp8=
X-Received: by 2002:a25:e750:: with SMTP id e77mr13431650ybh.23.1632272462992;
 Tue, 21 Sep 2021 18:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <YUoFFXtWFAhLvIoH@kroah.com> <CAJZ5v0jjvf6eeEKMtRJ-XP1QbOmjEWG=DmODbMhAFuemNn4rZg@mail.gmail.com>
 <YUocuMM4/VKzNMXq@lunn.ch> <CAJZ5v0iU3SGqrw909GLtuLwAxdyOy=pe2avxpDW+f4dP4ArhaQ@mail.gmail.com>
 <YUo3kD9jgx6eNadX@lunn.ch> <CAGETcx9hTFhY4+fHd71zYUsWW223GfUWBp8xxFCb2SNR6YUQ4Q@mail.gmail.com>
 <YUpIgTqyrDRXMUyC@lunn.ch> <CAGETcx_50KQuj0L+MCcf2Se8kpFfZwJBKP0juh_T7w+ZCs2p+g@mail.gmail.com>
 <YUpW9LIcrcok8rBa@lunn.ch> <CAGETcx_CNyKU-tXT+1_089MpVHQaBoNiZs6K__MrRXzWSi6P8g@mail.gmail.com>
 <YUp8vu1zUzBTz6WP@lunn.ch>
In-Reply-To: <YUp8vu1zUzBTz6WP@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 21 Sep 2021 18:00:26 -0700
Message-ID: <CAGETcx9YPZ3nSF7ghjiaALa_DMJXqkR45-VL5SA+xT_jd7V+zQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] driver core: fw_devlink: Add support for FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 21, 2021 at 5:45 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Wait, what's the difference between a real fix vs a long term fix? To
> > me those are the same.
>
> Maybe the long term fix is you follow the phandle to the actual
> resources, see it is present, and allow the probe? That brings you in
> line with how things actually work with devices probing against
> resources.
>
> I don't know how much work that is, since there is no uniform API to
> follow a phandle to a resource. I think each phandle type has its own
> helper. For an interrupt phandle you need to use of_irq_get(), for a
> gpio phandle maybe of_get_named_gpio_flags(), for a reset phandle
> __of_reset_control_get(), etc.

That goes back to Rafael's reply (and I agree):

"Also if the probe has already started, it may still return
-EPROBE_DEFER at any time in theory, so as a rule the dependency is
actually known to be satisfied when the probe has successfully
completed."

So waiting for the probe to finish is the right behavior/intentional
for fw_devlink.

> Because this does not sounds too simple, maybe you can find something
> simpler which is a real fix for now, good enough that it will get
> merged, and then you can implement this phandle following for the long
> term fix?

The simpler fix is really just this patch. I'm hoping Greg/Rafael see
my point about doing the exception this way prevents things from
getting worse will we address existing cases that need the flag.

The long/proper fix is to the DSA framework. I have some ideas that I
think will work but I've had time to get to (but on the top of my
upstream work list). We can judge that after I send out the patches :)

-Saravana
