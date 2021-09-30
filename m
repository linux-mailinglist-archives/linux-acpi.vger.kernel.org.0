Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF4741D2BB
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 07:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347737AbhI3Ffg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 01:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348079AbhI3Ffg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Sep 2021 01:35:36 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510ECC06161C
        for <linux-acpi@vger.kernel.org>; Wed, 29 Sep 2021 22:33:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v195so10091829ybb.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Sep 2021 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+NKKdRK9RfodRzKXI8O8ct2lSBYNHsM7sxE9hBdFgs=;
        b=JfRa6bsas3v+fIYF4C41qARornl22a530WFV/QpLTef0wGba+wr/ErL85dJ4Eg/biV
         cWf/DLt+lIfU+4J8RVGZ7yoeeKdVW6RTgQmjd38B07nP11nqE6eYB4N4LABgygtw79M4
         i7Njifo1MrZeppr8aG7Gu1BT5r1gdD3DRmTFdq3ei8Yntq+TbScnsGbvEWFS1adXCrAG
         pWhBpaScmjzrr7KsDAbQ3brzdtAyIR6APcXDIoizwQpI2NjYMLWM2xJ6rSWXZeEon7i5
         O0ZzKvp95fhdLXK9FF5q9AvaiUiRaUVKgskBYsb0FrNsOTjdYFGmhOibv/6oeX8gVAWD
         bmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+NKKdRK9RfodRzKXI8O8ct2lSBYNHsM7sxE9hBdFgs=;
        b=Qr//wFnMa9sNNkTUcrzim/zr3IFe10yG6/5GcgE/bRvVKoYaM8MKUTcKyl4AVzGAAE
         q8A8S8Sw9STB7DM1Lm2zZgEn2EXZzuaYmh3CT/y+WzLoicdELwKNGzyFbaDZiQQuy+yM
         65G4Yr747MPoybLM9xw3DlGJD/wIN5A8jI6fRhxGxK1GIEaBHhZTUq9/hk8Ytcu0vsct
         RQJnTO5fzk4K0Ke/db5fPX95kmHWkggBLXHwmjV5u2+VlDO/78xyqGRq7FWybjKHqDil
         iaoBCVWiDif7FHBh3hLhiGIcq1HB0PpYo7+q8oPlZ1qM5q6+/fUL7lryQUqfG6oBGzln
         v6bg==
X-Gm-Message-State: AOAM532PzZquqxOSjPKFJuCj0tI9pdId1iwodVxN2VSQcVl/a49Hja3j
        yKkORdp5Gmp5H6wTArDLgtb4R8GFHWi4gmq3NxSmpA==
X-Google-Smtp-Source: ABdhPJwQhot8JmlxGg0ZAE8LuycN8IkkPQ2598Nm1DbCQ1RVLb3/Grm/uxdPC06spevHQcO4XCptOiGMkXn2NNUweWQ=
X-Received: by 2002:a25:4684:: with SMTP id t126mr4148820yba.476.1632980032697;
 Wed, 29 Sep 2021 22:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx_vMNZbT-5vCAvvpQNMMHy-19oR-mSfrg6=eSO49vLScQ@mail.gmail.com>
 <YSlG4XRGrq5D1/WU@lunn.ch> <CAGETcx-ZvENq8tFZ9wb_BCPZabpZcqPrguY5rsg4fSNdOAB+Kw@mail.gmail.com>
 <YSpr/BOZj2PKoC8B@lunn.ch> <CAGETcx_mjY10WzaOvb=vuojbodK7pvY1srvKmimu4h6xWkeQuQ@mail.gmail.com>
 <YS4rw7NQcpRmkO/K@lunn.ch> <CAGETcx_QPh=ppHzBdM2_TYZz3o+O7Ab9-JSY52Yz1--iLnykxA@mail.gmail.com>
 <YS6nxLp5TYCK+mJP@lunn.ch> <CAGETcx90dOkw+Yp5ZRNqQq2Ny_ToOKvGJNpvyRohaRQi=SQxhw@mail.gmail.com>
 <YS608fdIhH4+qJsn@lunn.ch> <20210831231804.zozyenear45ljemd@skbuf>
In-Reply-To: <20210831231804.zozyenear45ljemd@skbuf>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 29 Sep 2021 22:33:16 -0700
Message-ID: <CAGETcx8MXzFhhxom3u2MXw8XA-uUtm9XGEbYNobfr+Ptq5+fVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: fw_devlink: Add support for FWNODE_FLAG_BROKEN_PARENT
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Alvin Sipraga <ALSI@bang-olufsen.dk>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 31, 2021 at 4:18 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Wed, Sep 01, 2021 at 01:02:09AM +0200, Andrew Lunn wrote:
> > Rev B is interesting because switch0 and switch1 got genphy, while
> > switch2 got the correct Marvell PHY driver. switch2 PHYs don't have
> > interrupt properties, so don't loop back to their parent device.
>
> This is interesting and not what I really expected to happen. It goes to
> show that we really need more time to understand all the subtleties of
> device dependencies before jumping on patching stuff.
>
> In case the DSA tree contains more than one switch, different things
> will happen in dsa_register_switch().
> The tree itself is only initialized when the last switch calls
> dsa_register_switch(). All the other switches just mark themselves as
> present and exit probing early. See this piece of code in dsa_tree_setup:
>
>         complete = dsa_tree_setup_routing_table(dst);
>         if (!complete)
>                 return 0;

Hi Vladimir,

Can you point me to an example dts file that has a DSA tree with more
than one switch and also point me to the switches that form the tree?

I'm working on a RFC series that tries to improve some stuff and
having an example DTS to look at would help.

Thanks,
Saravana

>
> So it should be a general property of cross-chip DSA trees that all
> switches except the last one will have the specific PHY driver probed
> properly, and not the genphy.
>
> Because all (N - 1) switches of a tree exit early in dsa_register_switch,
> they have successfully probed by the time the last switch brings up the
> tree, and brings up the PHYs on behalf of every other switch.
>
> The last switch can connect to the PHY on behalf of the other switches
> past their probe ending, and those PHYs should not defer probing because
> their supplier is now probed. It is only that the last switch cannot
> connect to the PHYs of its own ports.
>
> So if this does not work (you say that there are 2 switches that use
> genphy) I suspect there are also other bugs involved.
