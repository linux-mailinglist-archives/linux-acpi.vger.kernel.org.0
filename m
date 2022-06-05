Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E330153D9A0
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Jun 2022 06:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348609AbiFEENY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Jun 2022 00:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348634AbiFEENW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Jun 2022 00:13:22 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501F93914A
        for <linux-acpi@vger.kernel.org>; Sat,  4 Jun 2022 21:13:20 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-30fa61b1a83so110454137b3.0
        for <linux-acpi@vger.kernel.org>; Sat, 04 Jun 2022 21:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MjRSm5fzYQetqVlpQBYSrGfumNiB0ZrM39dLqOPrH4=;
        b=iruy/VIRmrmVkPQ3JLz43LdlgzYIIgIh0TbvAdWum+0Rddx+fvFvZL+AZmkeq14EM3
         EQj2TyKZKOx/AidEftZoePqY5YpO4cwMuitvB+yKPScFqtDTdzo5ldCi4OGAOk3+UFMp
         j/kBbn6KV51/XQkwn8o9tfq6LNjmHBZoctzSxwBUBFOQBY/6aPKKgU+LJpKUd4lxHOLC
         a3pKPoOaZ50Yav85+Htu9s5WpYjwMqsKV6ln5h3Ivwjaws5e9R7ngDvbV4Yh0sJleDX7
         vOAsHme5FRTkYJMFVoEn7Vce2+XgoAYlewVpVngjjzo07L1N3f9jaxvI2/N8fznw3lB9
         3viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MjRSm5fzYQetqVlpQBYSrGfumNiB0ZrM39dLqOPrH4=;
        b=v29oDIxZXVD1DU94XLfQK9+qmhjfU6/hqiVzD6wufZM3l+TPFOQv98ji2jmx7KHrvT
         7/RuHk9azf3yZbwmwmWsnkdzp4521pnFXblWDDNTu10kqp65/d2noUVZOEfCX39usiLk
         C+mVtFR8J2i1lSz+K+2ytaOVaTvzxUYeH/KFQl9SK+lGu8tw3vC631NNfKIR/Vgu1H0x
         qscbK1izAVYNDZ0BlIEFyHAq5rqqqMsamjs/0rGv73eV8WwELFJPT4aHEw+byBd8m7T7
         2TjslJ76vtU0ZAgUyAKvPpl5/Js+LemiVYdzPBDCQxd7hD4eh6YFNIeQVoqhG5FsGBXo
         e3cw==
X-Gm-Message-State: AOAM533Hi2cESxFD2TILbsxUulp/9Q9y1qRGISf8OcBLPMLfu8eUSb8l
        7bX+7h+wmKkU2g+V3FH/EecoqZoAL+cNoKb5MFSc1g==
X-Google-Smtp-Source: ABdhPJzUYcFQq7wQgnRsS9UvlhN43rSEgXe2PJa6kBJxtfcgg8d502Y2JGKc3riC3LG/Qxh1ZRmB7415nK5yWOq+ZK0=
X-Received: by 2002:a81:87c2:0:b0:2ff:c948:ae50 with SMTP id
 x185-20020a8187c2000000b002ffc948ae50mr19620905ywf.83.1654402399190; Sat, 04
 Jun 2022 21:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-5-saravanak@google.com> <CAMuHMdXcHcuAn8UVS6RPsfenuCny4BgWNJFod41CFjdOF+w0sg@mail.gmail.com>
 <CAGETcx_uXXw_OtHO+_2DmZnHA3WCT5CeKbb_RWNqZtZSU1OB2g@mail.gmail.com>
In-Reply-To: <CAGETcx_uXXw_OtHO+_2DmZnHA3WCT5CeKbb_RWNqZtZSU1OB2g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 4 Jun 2022 21:12:43 -0700
Message-ID: <CAGETcx9=CQha3HyBmw1S2KS--Fqv_kGEKwyVT-GSQCT=Uxi0zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] Revert "driver core: Set default
 deferred_probe_timeout back to 0."
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        John Stultz <jstultz@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 4, 2022 at 8:18 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, May 30, 2022 at 2:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Saravana,
> >
> > On Thu, May 26, 2022 at 10:16 AM Saravana Kannan <saravanak@google.com> wrote:
> > > This reverts commit 11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61.
> >
> > scripts/chdeckpatch.pl says:
> >
> >     WARNING: Unknown commit id
> > '11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61', maybe rebased or not
> > pulled?
> >
> > I assume this is your local copy of
> > https://lore.kernel.org/r/20220526034609.480766-3-saravanak@google.com?
>
> I somehow missed all your replies and noticed it just now.
>
> That commit should be based on driver-core-next.

My bad, it was indeed a local commit, but it's one I had already sent
to LKML. It's one of the 2 patches I asked to pull-in in the cover
letter. I'll fix this once I get some tests/reviews on this series or
if I need to send out a v3 series before that.

-Saravana
