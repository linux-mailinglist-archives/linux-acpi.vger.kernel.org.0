Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD536554E23
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jun 2022 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiFVPAt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jun 2022 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358885AbiFVPAi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2022 11:00:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D13E0F3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 08:00:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c2so28282961lfk.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ot619CPCB+Os3Ma2zzaC2EQcVEWPZ51BE3CwtG6/D/Y=;
        b=gRu32UY4Bm+ZmXkImTLAi5ks8x/VhZVMF8bm+1iriWv6IAOvsztz8SZ5nCBkLf3OJC
         tEQATuW6ysvNT0R5+g9gUZE3620Ht5OUsTXDyM754PAv+hP+6JDy0G1su/lus37M4Ghg
         qrBXbP2NCP/uwxDro5K2norKo3vMsCfN6HVtt3obD1OjDmqMSrM96ylCuv30zFpjUXR5
         ZHXBZXhcKgXRmX85r87v18m/Uep6tkd3spwYispgbXxpmdfcaRkiZELWD8TXE/EUb4Vh
         6jzc74qipm2b+UVw2vKoZFN0Ghtg4qw7395UG3glEG1IXM3QipBxVgdgmUdGtGN3FNdY
         3uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ot619CPCB+Os3Ma2zzaC2EQcVEWPZ51BE3CwtG6/D/Y=;
        b=uvEYSKvWFjwWRAka52hqG9bR6poUmClJMoFR/S2jYcQ22XRn7kC4Y0VUJ1IHBvzDe3
         apvCd0XpqEMqhwBypMjzAjAwculxBfrviO6YKT4jEaT5lZuqDyliPnIzimPQmw5DYmid
         wceAWS8AMTG46K8O6uRslWhgrD/vAxUTBGJtmHUDfVzWnucaQI2Nyp8Egi2yMpyVPkqe
         GF0KAUD32Tb0/nVjcHu4aVhZp40WqrZZd33MxJAt4rP3mX7EAO9j6/T5SSsYx3v0lw6b
         kEvNj6kgNJXIBdpLY01W212za5iC87adtCOjzRpRpUsQEQ+njYqvwA35A2ENCmBeqkEd
         iSJw==
X-Gm-Message-State: AJIora/UsQQydjtj5maEMlxviasZQ/AM26Pw2TIHQG0g8K7knAVnTQjq
        pMGDIZD2DDshReP+6LbElZAjo+M+jfrW2uyW6lkwHw==
X-Google-Smtp-Source: AGRyM1unI7r0V2nFtbd0hAmRtQ/C4hrOSHl9aG7WH7LVtA0iL1YvX6N5FIgi3bqsqZw20IPX+PzcHlNiajpNUeu6q5U=
X-Received: by 2002:a05:6512:3090:b0:47f:60f8:31d6 with SMTP id
 z16-20020a056512309000b0047f60f831d6mr2454957lfd.514.1655910033821; Wed, 22
 Jun 2022 08:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-10-mw@semihalf.com>
 <YrDO05TMK8SVgnBP@lunn.ch> <YrGm2jmR7ijHyQjJ@smile.fi.intel.com>
 <YrGpDgtm4rPkMwnl@lunn.ch> <YrGukfw4uiQz0NpW@smile.fi.intel.com>
 <CAPv3WKf_2QYh0F2LEr1DeErvnMeQqT0M5t40ROP2G6HSUwKpQQ@mail.gmail.com>
 <YrL3DQD92ijLam2V@smile.fi.intel.com> <YrL7Z6/ghTO/9wlx@lunn.ch> <YrMlEcKwpTmR5qj6@smile.fi.intel.com>
In-Reply-To: <YrMlEcKwpTmR5qj6@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 22 Jun 2022 17:00:21 +0200
Message-ID: <CAPv3WKeT_OaTS6es=WKx8gmQ=zuzv0EqfW=vPafNA2hYbhQJ6g@mail.gmail.com>
Subject: Re: [net-next: PATCH 09/12] Documentation: ACPI: DSD: introduce DSA description
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, vivien.didelot@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
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

=C5=9Br., 22 cze 2022 o 16:20 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Wed, Jun 22, 2022 at 01:22:15PM +0200, Andrew Lunn wrote:
> > > > It's not device on MDIO bus, but the MDIO controller's register its=
elf
> > > > (this _CSR belongs to the parent, subnodes do not refer to it in an=
y
> > > > way). The child device requires only _ADR (or whatever else is need=
ed
> > > > for the case the DSA device is attached to SPI/I2C controllers).
> > >
> > > More and more the idea of standardizing the MDIOSerialBus() resource =
looks
> > > plausible. The _ADR() usage is a bit grey area in ACPI specification.=
 Maybe
> > > someone can also make it descriptive, so Microsoft and others won't u=
tilize
> > > _ADR() in any level of weirdness.
> >
> > I don't know if it makes any difference, but there are two protocols
> > spoken over MDIO, c22 and c45, specified in clause 22 and clause 45 of
> > the 802.3 specification. In some conditions, you need to specify which
> > protocol to speak to a device at a particular address. In DT we
> > indicate this with the compatible string, when maybe it should really
> > be considered as an extension of the address.
> >
> > If somebody does produce a draft for MDIOSerialBus() i'm happy to
> > review it.
>
> I also can review it. Marcin, would it be hard for you to prepare a forma=
l
> proposal for ACPI specification?
>

I've just consulted this to get an understanding of the process.
* I will initiate it with the code-first ECR using the linux-acpi
mailing list, where all the technical review will take place.
* At the same time a ticket and the formal process for this will be
triggered within UEFI Forum.
* Once everything gets approved, an official confirmation will be
provided and from that moment, it would allow us to proceed with
implementation without need of waiting months for another ACPI
Specification release.

Unless anyone objects, I will include this thread recipients to take
part in review of the proposed MDIOSerialBus _CRS resource macro
contents, so it contains all relevant information.

Note: Once this hopefully gets accepted one day and allow us proceed
with Linux handling, it should be easy to satisfy backward
compatibility with current users of MDIO+PHY in ACPI.

Best regards,
Marcin
