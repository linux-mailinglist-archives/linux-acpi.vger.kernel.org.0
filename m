Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF0552E64
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348335AbiFUJdu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348910AbiFUJdt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 05:33:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2A25C74
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:33:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g12so8663747ljk.11
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eAn0mkf8cbbSldcOsHVmdulCChq1XWCHxJvyevA7Xy8=;
        b=p4nsrDQU/HL9kiO/BSBR3lWKcRmz20yfkNdEtRFiNLVnFyObvB+2JDLTEPz7ZfSyAx
         yb8oXPhQwE7wAUNWhTOZJq9rPKo82YQXQT1v57iBWTtjuIlUiGV3ydbeVvOpNV7FIvKf
         uwypx613RgvnumfBL4EjeGiXKXumJD7NYUvRTFWCMTZlqmqFOvPQZB25F4VUc/BlUzkI
         3bNO0DGxMuBeZIB2Pr8Vpxlv1ykqtMJcBaw92L+A25T5Dw2K4bZpnInem7cMn/dTNbx7
         XJx9UovtyH/lBD5ZMglt4lEvpPjY9t9N2PL3lUOYHjaP+i0BTi9noXI9qYHbg9TRgqLw
         BH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eAn0mkf8cbbSldcOsHVmdulCChq1XWCHxJvyevA7Xy8=;
        b=w5qFmSZQ3+KkgGBSzLSoORMA48C6D78sloF7xZpDWqRztuRL6zC5E5EyITqq3IoBJc
         BUYiyqU9pOFgDZCy3jSwrtFc+5TNbDE+G7E9Dtst6ngYYMUk9/brulj2aPk0VGMaP8cR
         uNeeP60EYlDH4Z+ScYU6mp/5yl9rjuiN9XqjSTfi1MtLfsPV7Kztokbm7uaX+vl8/HRa
         z8pnoSDaSHGoV58IjN+nybmPf8elFEeUi5FAa8RnOlmWScIQrGgs/2lFvknBUm3YGKGf
         g7wMcUKd4dS7ilOke3VlI4dvuLaMC5knwLDaa1uFxeycjxsxP/PLnyelApBYD9BuEjLj
         tt0A==
X-Gm-Message-State: AJIora+hsextpYV8RTiyXBQ0rbDydBczT/kqxfpwO/TB++1gMaraQkKc
        rXS6aZyqZzhhGsq4bfbtOb3MK0ElQX07J1tgdobTFA==
X-Google-Smtp-Source: AGRyM1vhoowH12J1zPskShLlXyMV98854EH+GXf+cFtJNMVCeZhPcYPK3u6iSPHLdI8a5bE/oc6mJEfEqdg9mfvyvNk=
X-Received: by 2002:a2e:860e:0:b0:25a:6dbe:abb5 with SMTP id
 a14-20020a2e860e000000b0025a6dbeabb5mr5361078lji.474.1655804025707; Tue, 21
 Jun 2022 02:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-7-mw@semihalf.com>
 <YrCzBzKfSl1u90lB@smile.fi.intel.com>
In-Reply-To: <YrCzBzKfSl1u90lB@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 11:33:36 +0200
Message-ID: <CAPv3WKd+e5kYz7L0Fnw6u9wcPU6+r54EeEWvJzw8oCyj=m6JPg@mail.gmail.com>
Subject: Re: [net-next: PATCH 06/12] net: mdio: introduce fwnode_mdiobus_register_device()
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pon., 20 cze 2022 o 19:49 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:19PM +0200, Marcin Wojtas wrote:
> > As a preparation patch to extend MDIO capabilities in the ACPI world,
> > introduce fwnode_mdiobus_register_device() to register non-PHY
> > devices on the mdiobus.
> >
> > While at it, also use the newly introduced fwnode operation in
> > of_mdiobus_phy_device_register().
>
> ...
>
> >  static int of_mdiobus_register_device(struct mii_bus *mdio,
> >                                     struct device_node *child, u32 addr=
)
> >  {
>
> > +     return fwnode_mdiobus_register_device(mdio, of_fwnode_handle(chil=
d), addr);
> >  }
>
> Since it's static one-liner you probably may ger rid of it completely.
>

Good point, will do in v2.

Thanks,
Marcin
