Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB157672D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiGOTKy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 15:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGOTKu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 15:10:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA852DF1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 12:10:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t1so9312430lft.8
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vWjC7NS5BQ1MpGzvs1XfRmOfXwBAovBmo/t8uOYuvZQ=;
        b=pb6921aqIKlrzl7PxAmpJ/d2ulZWZMSPR4XuGKomz+Az4VpNno2NOSkDr9KTS5ik1c
         virPNQ+SqLCfsuOQM0M4UYKEfi0SiBwms2N4KuapUZjGEbW9nN7HB+EBGBUbCRuwQC7X
         SL0EmUn4Kh/PNH4APoqovd1kHkvdcvmhPvxM/3FoPNWznjWFoYO6QoLw95YZZymxdTN/
         EHfU/OxMKyUelrin9u1wdLc6ojjx1C3YJ4efoLz9g46WtkEhMmH/fvU0DCmVE8G1Gy1n
         sYs8QqWsjdlwzxMUvfWGTWtcNUZrY/Ds8TGIkmTqx/NnEA4hCyIkaj/n8M3kpx/jV0qZ
         /+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vWjC7NS5BQ1MpGzvs1XfRmOfXwBAovBmo/t8uOYuvZQ=;
        b=4YY6GvLoY6U6wzdYsHjDXnDiXl9vmVaTRjaQm4tBAZvHqAD1S7oQ4+zR5Mkqs2+lxY
         k6zniftIZy7zQ3Y3l66vh5oGjw3aryhCJtLEHVdqCojCzsx1Ltvene99L1MzTOVUrjlR
         g8sPWWCcB+cSyBqyvHJoBHUNlMlRXXqrX0s4FV5fGlP7PmU82Dg2j1LVLeAQCo61vnfg
         LFy6W4sOq1L0USRzPSZrXRTE4gp1aVlMlVwiiNDbI/NLD/mvMS8KK1TpT9TtdwjnJrMw
         LFQQ0LLN3UXITnkFaFhHFm5NQFXiLjxa1OjhedPzKpxQQNuuc8FAduKzkC7t8OT0qy3f
         EEFw==
X-Gm-Message-State: AJIora/r04NvVuzTAbnOFx4FGxySoOWe31pGkbBlGDQv/WwQbaD6Q5th
        FEtfDcajD2TBrxYBHYAlEVG4bG5mL03afmP9RoeHpA==
X-Google-Smtp-Source: AGRyM1sijNtGrHfNIa/mURAz2tJo+sqLJCG47hellV6iaDCF573UPhaoN0hUKORERf0Hj//ZYm3/etEttP/OBIyqHRM=
X-Received: by 2002:a05:6512:2285:b0:487:2538:f0e0 with SMTP id
 f5-20020a056512228500b004872538f0e0mr9341297lfu.614.1657912248155; Fri, 15
 Jul 2022 12:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220715085012.2630214-1-mw@semihalf.com> <20220715085012.2630214-2-mw@semihalf.com>
 <a5b55fb3-3326-eb3c-99e6-3fd6b7e4c2fe@gmail.com>
In-Reply-To: <a5b55fb3-3326-eb3c-99e6-3fd6b7e4c2fe@gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 15 Jul 2022 21:10:37 +0200
Message-ID: <CAPv3WKcSNrYiABLzHrYsL1gx9vZZ6ja2ZQiOj1hGTKzDmOKYAQ@mail.gmail.com>
Subject: Re: [net-next: PATCH v2 1/8] net: phy: fixed_phy: switch to fwnode_ API
To:     Florian Fainelli <f.fainelli@gmail.com>
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
        Vladimir Oltean <olteanv@gmail.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pt., 15 lip 2022 o 19:21 Florian Fainelli <f.fainelli@gmail.com> napisa=C5=
=82(a):
>
> On 7/15/22 01:50, Marcin Wojtas wrote:
> > This patch allows to use fixed_phy driver and its helper
> > functions without Device Tree dependency, by swtiching from
> > of_ to fwnode_ API.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  include/linux/phy_fixed.h   |  4 +-
> >  drivers/net/mdio/of_mdio.c  |  2 +-
> >  drivers/net/phy/fixed_phy.c | 39 +++++++-------------
> >  3 files changed, 17 insertions(+), 28 deletions(-)
> >
> > diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
> > index 52bc8e487ef7..449a927231ec 100644
> > --- a/include/linux/phy_fixed.h
> > +++ b/include/linux/phy_fixed.h
> > @@ -19,7 +19,7 @@ extern int fixed_phy_add(unsigned int irq, int phy_id=
,
> >                        struct fixed_phy_status *status);
> >  extern struct phy_device *fixed_phy_register(unsigned int irq,
> >                                            struct fixed_phy_status *sta=
tus,
> > -                                          struct device_node *np);
> > +                                          struct fwnode_handle *fwnode=
);
>
> I think this ought to require a forward declaration of struct fwnode_hand=
le and a removal of the forward declaration of device_node.
>

Ok, I'll replace the declaration.

> With that fixes:
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>

Thanks,
Marcin
