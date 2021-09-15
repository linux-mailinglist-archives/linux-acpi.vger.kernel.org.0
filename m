Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18F40CB91
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhIORUo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIORUn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Sep 2021 13:20:43 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDABC061575
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 10:19:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y13so7207667ybi.6
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcARgMDO3sHmRKPtN7f2pmzPFunzoTl53IPz4NJSUaI=;
        b=dKM6iCxT5AAQBmagGlPrp9ttSolaaBPV0lgwA6vmAQjNnNbzqaa3H3COonvJb/XbWm
         2ihe9WBo5GOxOTwRZ+OgyvsAdLwtyZ4SBFC09Uqhjs2cM/B0SpCWhmoU0dfxd1S7IjUs
         CZWLXk+kkWjvkYkMK5CUcd5JAkYdpAyjR1QTWhQ8GNNAk2vvJioOhWoDvUesjf/8GbNO
         Z3eJSYo0cUs/NYdX1pUhkNHeHaY+ogdvGGDQzaWc7gScKuUJ7fcfOqms8y24HmFlDCRT
         XmswJP69F3LoGSvqLSbvmJm0Hwxf7yt+WhMeBbCgFy2kx2NX8vasm/fiKScjoNRqFkRs
         njDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcARgMDO3sHmRKPtN7f2pmzPFunzoTl53IPz4NJSUaI=;
        b=Dul+TOYen1vAcT3ROyDR43dh0GQOHxth4kxes0+5/OBVgzyC8lutMYAM+MY7EP0eXR
         C8Fyxx7jeB3Y62skmIsQiyx0liSLcl7FVaYUVBWjJWL3BnReuY4zq206/sEGq+qJ0KwI
         O+W2geNVUNafzPboDZL/2XzmYVFcB2IKSsP4UzYRrm8c8+QZa302nb71Wel6Oi/QEgel
         OVHbqshiaGqy7qnx4xthr+0X5eDqJpKc+qo15SMRdw2qlPuWv+peEOpjnVM8k5O1XZhb
         s7bllin3NqBeNaD6figEa2ybRUY/y9kpRYq0tGl2lttUs1y8rCgsWsOWZS11NP3Q3ShZ
         jsdg==
X-Gm-Message-State: AOAM5317/EUYWyBVDAK84/Mvgl+fyfJ1Rj9Dl2vGOAOM3Ztj8R3m5FWD
        ip+uNtD/9FTxEm3SQ3uzxkBczdHZ5aB3TQ/gVU/rwQ==
X-Google-Smtp-Source: ABdhPJyO2jRMPKX2+rlE4hInFo5Tt738OyUO7N0J4cYlu9nL/Yd0y23SxmKlAUGsgPZIE8l2eCiodmmbiAd9PAEkuOk=
X-Received: by 2002:a25:b94:: with SMTP id 142mr1334731ybl.508.1631726362131;
 Wed, 15 Sep 2021 10:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210915081139.480263-1-saravanak@google.com> <YUHjvKRX76Jf7Bt5@lunn.ch>
In-Reply-To: <YUHjvKRX76Jf7Bt5@lunn.ch>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Sep 2021 10:18:46 -0700
Message-ID: <CAGETcx8s9iKJnw=LP_p6rtB+Lx7orkKF5hicGWPGc+bL8kpk=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] fw_devlink improvements
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 15, 2021 at 5:14 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Sep 15, 2021 at 01:11:32AM -0700, Saravana Kannan wrote:
> > Patches ready for picking up:
> > Patch 1 fixes a bug in fw_devlink.
> > Patch 2-4 are meant to make debugging easier
> > Patch 5 and 6 fix fw_devlink issues with PHYs and networking
> >
> > Andrew,
> >
> > I think Patch 5 and 6 should be picked up be Greg too. Let me know if
> > you disagree.
> >
> > -Saravana
>
> You are mixing fixes and development work. You should not do that,
> please keep them separate. They are heading in different
> directions. Fixed should get applied to -rc1, where as development
> work will be queued for the next merge window.

Done.
https://lore.kernel.org/lkml/20210915170940.617415-1-saravanak@google.com/

-Saravana


-Saravana

>
> You are also missing Fixes: tags for the two MDIO patches. Stable
> needs them to know how far back to port the fixes.
>
>       Andrew
