Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA45268E442
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 00:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBGXNh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Feb 2023 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBGXNg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2023 18:13:36 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B682E0D0
        for <linux-acpi@vger.kernel.org>; Tue,  7 Feb 2023 15:13:34 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id x10so483055pgx.3
        for <linux-acpi@vger.kernel.org>; Tue, 07 Feb 2023 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AFMKctRHnvie2TeWTzee4bAAZ/B9stjtKlQ5Rg5dBE=;
        b=j0Tge9KuUGleo3rmNMVG+QsSsd4faRAZpuEp3rGxHGDhY+lkA3+0DCnxR8aegHCge6
         cO0TbwUtPTs8ITGXBDCSAQO6ScEpLgHfJe89u3fO0OELaPM6cQ25W1Z/2mhyPFAPxErT
         +Vnksrfba3xmk4ITm4jRjvKIHCMA28JBC/RrLHhBq5DBHqKA0VH6Gpw731c3AqZwyECo
         pwNMur97GJ6HKq7cdIQGVdW7MAUtD26fewkxsrZk9OaJ62gxASiMh8lVnw1t3Kh9BETZ
         h8KDDmNeGAhEvA+25IuTB5zo2BvvpA65MrykazQgkAcxj9Jtc8eKN3ah2/+Ap7D87cyY
         erKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AFMKctRHnvie2TeWTzee4bAAZ/B9stjtKlQ5Rg5dBE=;
        b=F+93Z6jWhDcK3k7umQ0WKk8XBAiHySOYb2kAqRpBPmjA3/bRoEfWVKocPs9XK7aI1P
         mQw++WrsOZxou8jvYul+tPzIvZ+cY53NDAn5pJOg4v4VNBRKimAb4j5qzhNi6EVTnvKR
         pbatybyxzTvtRCXmiwWWTOvGEa1jqZU/bKuT5G/ciSAfnfpniOHp+PP4IAFuGxszPafM
         r47jaQrFXYeaSoUQCNLDF0PEoWYLnCUc+cVB0euF8QQfR2GnLUWotqUC9p9FwUn0HpMu
         WvgRmh8z+WTsV4M+DZC+Pbf8Hj9NIG+mlT/qHqD2Tto0d82pnQvWqM+QI5kkXixYvwbq
         m17Q==
X-Gm-Message-State: AO0yUKW2a/wqBV15hUTiwr+9Ey+tY+IMNlt2DO6OmFLgGmwXlLVcwIVy
        EcWADgd9SmSsH5UBGYb26ilsneeJu9CdHpWZsBYrlw==
X-Google-Smtp-Source: AK7set82dqdysAxpE84w5h03BnoQzNzUIi4BxGlTnJGDsUP2gPvZIr2q53Al8msJwacCdnSqWBN5d7cF28SdbrlA7dA=
X-Received: by 2002:aa7:8ede:0:b0:590:7829:f566 with SMTP id
 b30-20020aa78ede000000b005907829f566mr1202351pfr.50.1675811613191; Tue, 07
 Feb 2023 15:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20230207014207.1678715-1-saravanak@google.com> <CAMuHMdWWc6pbrxCETL+VcXiwesfpUE7r2xc9U9ti5aTietqzDQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWWc6pbrxCETL+VcXiwesfpUE7r2xc9U9ti5aTietqzDQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Feb 2023 15:12:56 -0800
Message-ID: <CAGETcx-VmYRO6Qw4cJ_=QQXzOJbOUS8B+mesqm8n2NrT2d54Cg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] fw_devlink improvements
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Tony Lindgren <tony@atomide.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 7, 2023 at 1:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Feb 7, 2023 at 2:42 AM Saravana Kannan <saravanak@google.com> wrote:
> > Naresh, Tony, Abel, Geert, Dmitry, Maxim(s), Miquel, Luca, Doug, Martin,
> > Jean-Philippe,
> >
> > Can I get your Tested-by's for this v3 series please?
>
> I have tested this on a variety of Renesas arm32/arm64 platforms,
> and on several RISC-V platforms.
> Apart from the regression related to dynamic overlays caused by
> "[PATCH v3 09/12] of: property: Simplify of_link_to_phandle()"
> (which you may decide to ignore for now ;-)
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks a lot for the extensive testing Geert!

I'll take a look at that issue with the out of tree code separately.

-Saravana


-Saravana
