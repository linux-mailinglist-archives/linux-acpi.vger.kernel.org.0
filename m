Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE255E6EE
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbiF1Nlq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiF1Nlp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 09:41:45 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159029C8A
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 06:41:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r3so22290116ybr.6
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0lBZBoRWVZwKeLsg5bhh62sfkY43Fuz7vbWyvz07jo=;
        b=hGw9T6CarZQ/NMBim5LFKd5YTY/o2ySRURtSkju9ltnp+I2dfsm1E743dkEP7vIdI2
         EF0DRNKbp1NoePxE8d03JMmSXIQyxTYmcA6StyWwY4r+YQPVJD8cCVXjq4KFryi4BOBX
         R1mZO/ER1L2SAM2BBGv6AMAXI5Jfk4vSpWXci5dnkjMyWFiBRxV+lukWKp040ydV0UYw
         pi8tg+vw420tIDHBWpl4HD2i87IuVJPBeZxJfEHlBvY0Am4KybIx85T311V7Sc3PDZDd
         4o1lrjtE8IrlXi97SmhrBQzUpnLpRq4Op7bcrYUqg0s8X0We4xxPIjbi6qZfZCCR6FAX
         0Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0lBZBoRWVZwKeLsg5bhh62sfkY43Fuz7vbWyvz07jo=;
        b=jTPv1aoboR+sHmG+OV8HbHzshg4fMe09Sz32Rtw3J19B7xpVjt503sHBVB1eHmGWyy
         FZc/Ney5Rj62D1AoJdh4PT7UAsn9aKE5LHL1hLaAPwoou4rYJCRRHy/Z6nRIumWoGlNv
         Pdf9aXB5QRZ6o63m5ghuGmkzhwmAYwGRdGwn1+Jpf1y5WFi/t3F3TgjoTFhRX/2EDx7a
         YcvzrcBfY50hY637KE3ZsF31bwu9sPac4fG/Q1S1/G8Ne9Cy4Ukl/HRRm9+VZizwB3hn
         dT1iy9DaIDR24Z83tMzjtxaWvV13EaV352uWNqxsAfKbT7rA0vKbfMau8zsStPutsIUi
         6GiA==
X-Gm-Message-State: AJIora8L1cQPlpctJG1OBL7fBUT9z/pgRsavnguDHTE08W1rZadQqTiz
        zcU7rr521IX7k13aG+5L3QVCEJv3+uaDunhVYZWRkg==
X-Google-Smtp-Source: AGRyM1vMJc6mshbdVpv82z3JrgHLSlBVD5A4IKCtkqq06YBNSTzatN88O/XMo49PG0TuIqgDUg33Srr26PKhV2f0pQk=
X-Received: by 2002:a25:1f57:0:b0:669:b6fa:167e with SMTP id
 f84-20020a251f57000000b00669b6fa167emr20917137ybf.295.1656423702377; Tue, 28
 Jun 2022 06:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com> <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
In-Reply-To: <20220623100421.GY1615@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 15:41:30 +0200
Message-ID: <CACRpkdY+MfDHGw4QrFy=A64y7dSrno26vuKbt_AnFbVm9y_hoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when fw_devlink.strict=1
To:     sascha hauer <sha@pengutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, peng fan <peng.fan@nxp.com>,
        kevin hilman <khilman@kernel.org>,
        ulf hansson <ulf.hansson@linaro.org>,
        len brown <len.brown@intel.com>, pavel machek <pavel@ucw.cz>,
        joerg roedel <joro@8bytes.org>, will deacon <will@kernel.org>,
        andrew lunn <andrew@lunn.ch>,
        heiner kallweit <hkallweit1@gmail.com>,
        russell king <linux@armlinux.org.uk>,
        "david s. miller" <davem@davemloft.net>,
        eric dumazet <edumazet@google.com>,
        jakub kicinski <kuba@kernel.org>,
        paolo abeni <pabeni@redhat.com>,
        hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
        david ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 23, 2022 at 12:05 PM sascha hauer <sha@pengutronix.de> wrote:

> Also consider SoCs in early upstreaming phases
> when the device tree is merged with "dmas" or "hwlock" properties,
> but the corresponding drivers are not yet upstreamed. It's not nice
> to defer probing of all these devices for a long time.

Actually this drives a truck through the entire approach in a way.

It is perfectly legal to have a device tree with dmas specified
but leave them unused in the operating system. DT just describes
what hardware is there, it does not mandate that the OS
implement drivers for all of it.

This approach really needs that the resolution mechanism
is aware of whether:

1. a driver exist for the resource at all so it will eventually resolve

2. if that driver is compiled in or module at all (IS_ENABLED())

3. If the resource should be grabbed early or optionally later
    such as dmas for console UART

Only then can the mechanism work in the generic case.

Yours,
Linus Walleij
