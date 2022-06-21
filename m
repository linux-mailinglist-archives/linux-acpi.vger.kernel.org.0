Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F27552E45
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 11:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348763AbiFUJ2M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348393AbiFUJ2E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 05:28:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C6BC1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:27:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id n15so3091036ljg.8
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8e6CPzPX9uApajCNlf3OZqOW+gA8MhL7WPc0wiikTqU=;
        b=il/sljDYx3y2Rj9aqTxNbHbIQ6aPBlIM7Pdno2uuS3KhdGKi1EZgd2FZY9hkCiRxUf
         tXXC5pVQluIx7hzrqJkyWQa8PUsf0LJEY1Ckb5XU825NXkHH39idMeeWYYKj8nx3j9ov
         AVbtVZ20G4hmmd8vqMhW2AI7pWnxAilWfxN8qOYRJ8JpVhXsc4uZLRjZa/oRuq1Ek4Sq
         +NfhopYiugeI1pVHBPe7y9TDcyBtvwaAB6nO9UYiHGVr7CxQDXuXLfNpVecYHKp31Ryx
         lOS1h5CPu7upadyDALbWKNDakfbwsuKkASE6Xre2cbymdQ6fljJLXzGYJ8RPK+fnUTP9
         WVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8e6CPzPX9uApajCNlf3OZqOW+gA8MhL7WPc0wiikTqU=;
        b=Awhckp4eyyJRa/goSzWEdhXcJS/It6lLrgpX/j4lYWLD4r7zePNgO1OW4dVkEjk0Z5
         qjYc30ZblA3V0SOUu/tFShv+Lyd6SYKjwQlHiiHvQGQQyuB1QZCJKkGaP8TKqo8HJ4AJ
         Wgi31E9xdICqAbWZI7NO3n80WiTxbvNJtr7Tx5pEGE1cdGMYfpNwn5M5kxoPklsNwVj1
         lNmWxI6AFUUQliqsze02nbBvsuQhPj56arDDUXrP7mBlO25Sj4/tJOj6HRuW88geT/mO
         lF3y2S0XYXcldGpX5ZuqlSxkmINYeC/bOOrvbMELZmYwkB+a0TtdJM3MsInL4c91OlDN
         Ytkw==
X-Gm-Message-State: AJIora+HgNzifewNHcwSvBWwsz7nHH76tTEeMGMkpsy+HZMUJxmwTb5H
        Rt633fUVq7zkebAT9cxlLad12stiuimRyNCjcI/yRA==
X-Google-Smtp-Source: AGRyM1sBSSnPQfUNpVkNAnJ/02rMsTXl7DvXUFqZ5omPctSopVyLOUzYU7be4FE/ZwsUBD8Qkkc/Jkri0LrTRGe/ZjQ=
X-Received: by 2002:a2e:a58d:0:b0:25a:6348:9595 with SMTP id
 m13-20020a2ea58d000000b0025a63489595mr7562439ljp.72.1655803672117; Tue, 21
 Jun 2022 02:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-4-mw@semihalf.com>
 <YrCxUfTDmvm9zLXq@smile.fi.intel.com>
In-Reply-To: <YrCxUfTDmvm9zLXq@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 11:27:43 +0200
Message-ID: <CAPv3WKch9hC3ZjZE0f4JntqFDY04PUpQ1yzsgShThmhkqV01-g@mail.gmail.com>
Subject: Re: [net-next: PATCH 03/12] net: dsa: switch to device_/fwnode_ APIs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pon., 20 cze 2022 o 19:41 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:16PM +0200, Marcin Wojtas wrote:
> > In order to support both ACPI and DT, modify the generic
> > DSA code to use device_/fwnode_ equivalent routines.
> > No functional change is introduced by this patch.
>
> ...
>
> >       struct device_node      *dn;
>
> What prevents us from removing this?

I left it to satisfy possible issues with backward compatibility - I
migrated mv88e6xxx, other DSA drivers still rely on of_* and may use
this field.

>
> > +     struct fwnode_handle    *fwnode;
>
> ...
>
> > -             dn =3D of_get_child_by_name(ds->dev->of_node, "mdio");
> > +             fwnode =3D fwnode_get_named_child_node(ds->dev->fwnode, "=
mdio");
>
> The rule of thumb is avoid dereferencing fwnode from struct device. So
> dev_fwnode(), but here it would be achieved by device_get_named_child_nod=
e().
>

Ok, thanks - will do for all occurences.

> ...
>
> > -static int dsa_switch_parse_of(struct dsa_switch *ds, struct device_no=
de *dn)
> > +static int dsa_switch_parse_of(struct dsa_switch *ds, struct fwnode_ha=
ndle *fwnode)
>
> Shouldn't _of suffix be replaced by, let's say, _fw?
>

I thought about it and can perform such naming update in next iteration.

> ...
>
> > -     return dsa_switch_parse_ports_of(ds, dn);
> > +     return dsa_switch_parse_ports_of(ds, fwnode);
>
> Ditto.
>
> ...
>
> > +     fwnode =3D ds->dev->fwnode;
>
> dev_fwnode() or corresponding device_property_ API.
>

OK.

> ...
>
> >       slave_dev->dev.of_node =3D port->dn;
> > +     slave_dev->dev.fwnode =3D port->fwnode;
>
> device_set_node()
>

OK.

Thanks,
Marcin
