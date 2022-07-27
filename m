Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD91582973
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jul 2022 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiG0PSb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jul 2022 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiG0PSb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2022 11:18:31 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462C459A3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2022 08:18:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i4so11140415oif.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jul 2022 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vrcDI9X9X/8Ry26dK2m6CeEEVy+vjVfPx3R3Bxv6JsY=;
        b=TPw1PvWGxWhDQl3m14gKafds+/S++NkvHiWPh7/J6Dq2XfdTfvWSXIAqycQ7bGv/kv
         HiClXi9Vaj46dpYOV+b68aOARBSwVZXIyUj4eDnjFurL+N4ryKq5bcTeK96Mn6EzV4VW
         AaGgnh1HHu90X1hKNIRlk3/Mru2/MFvfJ/TcEdt4yLx8QEwWUnfC6C+CX+xeYMSWDug5
         SU6QKrgchlzyYzpEcTew7ua2U/YlzoH82c0rJpdZ7PDiDH64L4Y6ILHkDhLVQ8A2txI6
         AVp1cwNC9DZObCoisrQOXw3oX4kmEiqcUyZLldrIO/HJJNkuLGXbdZlHcLE9VwEM+kgO
         kqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vrcDI9X9X/8Ry26dK2m6CeEEVy+vjVfPx3R3Bxv6JsY=;
        b=5PjuJL2t9DeriseZmgQco1Agm3GXd+MPn0tg5cFF8SZ5pP5Rz1IPTiSggXGLDWAlTk
         q5z9zZNIxxEUtYhhpCGwb8vOYyyPwiMRJ3tKm9/V/y7tXzOiH6aqMaFRSXaq+dA8dj+o
         MXOeIsoXdYNYHqFtMjGuGdF+0nGwJCL2Hwi8cCuqNOcYR22cx7owZVMqOAlTgYVNskWJ
         GBcNMgpTx5aC16651zor8bOBcjFLoLQb8tO40GEvSl8qmLZSsLxAt4CegN95mRbgntcZ
         nhLQSOb4018LajmZtu0+KNAfvP0/JxdOVJtJdaLFvAYyUEY+gaTpxHSIiT2IU+I1l+3d
         DN/w==
X-Gm-Message-State: AJIora/2z0hg6XoAsVzg3lg9opJAF5wVUpRWnx3Ej1E4+6UN9QHmx86t
        q/VpBs3pnYovjf+GkiwrB2LIqhdSROuv50SKTNktiA==
X-Google-Smtp-Source: AGRyM1s1idEvI9MQhEPWnauviC9CA374Xt9zKh40dD4tdqRLIs1zdxHVBkROvfwvSyD5P2CVYkGZq1zoxtjSE+FiLvQ=
X-Received: by 2002:a05:6808:4d7:b0:33a:9437:32d with SMTP id
 a23-20020a05680804d700b0033a9437032dmr2061172oie.97.1658935108070; Wed, 27
 Jul 2022 08:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064321.2953971-1-mw@semihalf.com> <20220727064321.2953971-7-mw@semihalf.com>
 <20220727143147.u6yd6wqslilspyhw@skbuf>
In-Reply-To: <20220727143147.u6yd6wqslilspyhw@skbuf>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 27 Jul 2022 17:18:16 +0200
Message-ID: <CAPv3WKc88KQN=athEqBg=Z5Bd1SC3QSOPZpDH7dfuYGHhR+oVg@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 6/8] net: core: switch to fwnode_find_net_device_by_node()
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

=C5=9Br., 27 lip 2022 o 16:31 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Wed, Jul 27, 2022 at 08:43:19AM +0200, Marcin Wojtas wrote:
> > A helper function which allows getting the struct net_device pointer
> > associated with a given device tree node can be more generic and
> > also support alternative hardware description. Switch to fwnode_
> > and update the only existing caller in DSA subsystem.
> > For that purpose use newly added fwnode_dev_node_match helper routine.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> > -struct net_device *of_find_net_device_by_node(struct device_node *np)
> > +struct net_device *fwnode_find_net_device_by_node(struct fwnode_handle=
 *fwnode)
> >  {
> >       struct device *dev;
> >
> > -     dev =3D class_find_device(&net_class, NULL, np, of_dev_node_match=
);
> > +     dev =3D class_find_device(&net_class, NULL, fwnode, fwnode_find_p=
arent_dev_match);
>
> This needs to maintain compatibility with DSA masters that have
> dev->of_node but don't have dev->fwnode populated.
>

Do you mean a situation analogous to what I addressed in:
[net-next: PATCH v3 4/8] net: mvpp2: initialize port fwnode pointer
?

I found indeed a couple of drivers that may require a similar change
(e.g. dpaa2).

IMO we have 2 options:
- update these drivers
- add some kind of fallback? If yes, I am wondering about an elegant
solution - maybe add an extra check inside
fwnode_find_parent_dev_match?

What would you suggest?

Best regards,
Marcin

> >       if (!dev)
> >               return NULL;
> >
> >       return to_net_dev(dev);
> >  }
> > -EXPORT_SYMBOL(of_find_net_device_by_node);
> > -#endif
> > +EXPORT_SYMBOL(fwnode_find_net_device_by_node);
