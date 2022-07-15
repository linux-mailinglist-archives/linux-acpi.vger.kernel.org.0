Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B27576A83
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jul 2022 01:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiGOXQL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 19:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiGOXQK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 19:16:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434F90D97
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 16:16:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bp17so10152826lfb.3
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IvphjXNHmWQnbzb931MiSgLgcDW7fVsa67JAKlnt2zQ=;
        b=rioWjnPOeuTYTniQE6/dH+2YSvHpAozZvGxY8riSs7TgVioB4KiqF1hKkSQ5SFhak+
         4gj8boUlAV9DqeDKGajM5x/odFeIhb8HxmWVHrG4r35qqW9OlQ+ZPd+ByQWvYTcz6JRC
         vHebvOHPlX9i/zQa+NDoOCMr5OrNYHK1kdcM3rlHMnn87G8dKEZavq5lxqjH12yyElVZ
         gbAPHauE9O76FACEu0j7TAHKj9gs+OghDnkF+3Aza7sLY2XmiJ3MJw+KLhOkWF8f357m
         Fu3fo7a4xuID4u6c6h40iVqbtN5+yJLXkdRQej0naOm1/mwT5+ZakqbrziBjifIQl0C6
         nRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IvphjXNHmWQnbzb931MiSgLgcDW7fVsa67JAKlnt2zQ=;
        b=58GJOaRk+uNE+h03Ezwv+ZIdqnVGKtMUpRgW/tqKTjrfmhSVDzUAXGSiYwPRozvT8/
         gku5cjhPJIyDowV9NZZbpHtUkPHrobB4IarflwMXMPeYaWRk2+m0HdNirsuh3/qgBRCo
         N6/Ma+WzodViN+6FUHMOdiXsn+ji5Xw8pemuN+adon9qj+BYJ4roQwrYRttcOdQF5Vv3
         I8woiRbFNdhObvTmr6eFQ3dFRfuEwbSkyg6MMdKvkyIgPq2CNja7FqisogDRTwbFI3co
         GN7w6fYYWhaHV3a9NHjkiQotS91y41lAbek50glPfqIR4Wvxpmq23TBwlQyzlCNVC3lk
         QDXg==
X-Gm-Message-State: AJIora9X5fEMwSrjfBRMWFIQEvS65jdU/rq1VaFH4lcVVNtI1LqzrMfu
        cjHkOCyJUClxxBJ0+U0xHgXZnUmeSOSIdcPnJZ7yQA==
X-Google-Smtp-Source: AGRyM1v5XkIj2H4TwKER8mooe9PSuvdVtwkFe1FfiqbIdUSmKu3shWwI/Ie1gPCXfIufrbeQ1xEQnKFi+oUYtQxEZ0E=
X-Received: by 2002:ac2:44cf:0:b0:48a:1251:1cf5 with SMTP id
 d15-20020ac244cf000000b0048a12511cf5mr6620890lfm.680.1657926966385; Fri, 15
 Jul 2022 16:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220715085012.2630214-1-mw@semihalf.com> <20220715085012.2630214-6-mw@semihalf.com>
 <YtHBvb/kh/Sl0cmz@smile.fi.intel.com> <YtHDHtWU5Wbgknej@smile.fi.intel.com>
In-Reply-To: <YtHDHtWU5Wbgknej@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Sat, 16 Jul 2022 01:15:55 +0200
Message-ID: <CAPv3WKcf7U_KLuxg5zgyQZru52QEAgrHq2dO7dD4JGMMCLq05w@mail.gmail.com>
Subject: Re: [net-next: PATCH v2 5/8] device property: introduce fwnode_dev_node_match
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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

pt., 15 lip 2022 o 21:42 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Fri, Jul 15, 2022 at 10:36:29PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 15, 2022 at 10:50:09AM +0200, Marcin Wojtas wrote:
> > > This patch adds a new generic routine fwnode_dev_node_match
> > > that can be used e.g. as a callback for class_find_device().
> > > It searches for the struct device corresponding to a
> > > struct fwnode_handle by iterating over device and
> > > its parents.
> >
> > Implementation
> > 1) misses the word 'parent';

I'm not sure. We don't necessarily look for parent device(s). We start
with a struct device and if it matches the fwnode, success is returned
immediately. Only otherwise we iterate over parent devices to find a
match.

> > 2) located outside of the group of fwnode APIs operating on parents.

I can shift it right below fwnode_get_nth_parent if you prefer.

> >
> > I would suggest to rename to fwnode_get_next_parent_node() and place
> > near to fwnode_get_next_parent_dev() (either before or after, where
> > it makes more sense).
>
> And matching function will be after that:
>
>         return fwnode_get_next_parent_node(...) !=3D NULL;
>
> Think about it. Maybe current solution is good enough, just needs better
> naming (fwnode_match_parent_node()? Dunno).
>
> P.S. Actually _get maybe misleading as we won't bump reference counting,
>      rather _find?
>

How about the following name:
fwnode_find_dev_match()
?

Thanks,
Marcin
