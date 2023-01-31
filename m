Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE09682307
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Jan 2023 04:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjAaDwe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 22:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjAaDwd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 22:52:33 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBD5DBDC
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 19:52:32 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u5so9017934pfm.10
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 19:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2oMqC6O3ykvhG9j0cdrAswTF+nBN1dqlqqY6wkjud8=;
        b=JSmjU9S6UXkPUGeK7DMYHRXsknaDrjYtWOkHTdNveufaFNaPVNhWAl1U06uqpKem0S
         59/PoO7H4YoJkEXW8QYLwMTQq6bLHcwgAUCyt2A+AvxNhJvI88R7BTPte6gbRZf8Zn0X
         hGz+f58wgGUJQD0UJBqNvZ350neRgCgXqge8g+I/gUNGuy7fnBKE3KVj9tnw7UaLDlez
         /iM61jM+QZp15U/oisJ04uPgYA2Co3lFvInzl4nKUPUoythlQ6T3H/KpCL89VPAw89ls
         5/1SrVqr42DqQeAfCPP2iuwWhpfS6Fn/g/PhvOltyCpuk3O/5/LV0tsxmD4DMSumjmwQ
         2W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2oMqC6O3ykvhG9j0cdrAswTF+nBN1dqlqqY6wkjud8=;
        b=eTIT3fWQODgv4aOFBvoISMlZC669JrrDZF4gWAjH935z8aysbwjri7niJ8o7PdtG11
         RU00ZGm+b+y8ks22umSkRNRI7FDayqEOnF7Bk6UKQWRMnLQ7t+UFHZIz0kwHlBJ43RCB
         GRweGXcRLSVmUEGz+V3TNQ8PG2wqI+pivdFohEGShBzZ82iRuADGv9IPupTQoasP6Jdr
         jjgiyiFNwQhV2ZwXYSQ52zg3Y4qimb0Gs4qYsR4nSO+F0/tRN5gLwa/LxzKMGjA8x6z4
         smBqY0llFWhyaWM6u0XZ10S7xwMCovSLD2AJlelDQr7RTblztyZJbe/D4QVzlYV/TppM
         Oaow==
X-Gm-Message-State: AO0yUKVMHmfqtQ9E/DDqDFrq2/sFhGw6CBAWGghWbzsEXXce+pdlOOfu
        Cu9g2SMUAtS+MjiP2OrVzs8dGlwkA2dEOPdUHJRcbg==
X-Google-Smtp-Source: AK7set/L681GNUQm53Ht5BJnkOj3nZ2Nyv6dG38J0tUQYyRx8L11DTLagSd690f6//WITKlrU42CNeDoQKjMJzZaMd4=
X-Received: by 2002:a05:6a00:26c6:b0:593:b307:4d0b with SMTP id
 p6-20020a056a0026c600b00593b3074d0bmr1095211pfw.57.1675137151709; Mon, 30 Jan
 2023 19:52:31 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-10-saravanak@google.com>
 <Y9fWsxYJgNR0z6te@kekkonen.localdomain>
In-Reply-To: <Y9fWsxYJgNR0z6te@kekkonen.localdomain>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 30 Jan 2023 19:51:55 -0800
Message-ID: <CAGETcx8tRP5-TW0REw5gPhLA9qiSvO6W3hvTk-utG1umuJ3M2Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] of: property: Simplify of_link_to_phandle()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
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
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2023 at 10:15 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Saravana,
>
> On Thu, Jan 26, 2023 at 04:11:36PM -0800, Saravana Kannan wrote:
> > The driver core now:
> > - Has the parent device of a supplier pick up the consumers if the
> >   supplier never has a device created for it.
> > - Ignores a supplier if the supplier has no parent device and will never
> >   be probed by a driver
> >
> > And already prevents creating a device link with the consumer as a
> > supplier of a parent.
> >
> > So, we no longer need to find the "compatible" node of the supplier or
> > do any other checks in of_link_to_phandle(). We simply need to make sure
> > that the supplier is available in DT.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 84 +++++++------------------------------------
> >  1 file changed, 13 insertions(+), 71 deletions(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 134cfc980b70..c651aad6f34b 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1062,20 +1062,6 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
> >       return of_device_get_match_data(dev);
> >  }
> >
> > -static bool of_is_ancestor_of(struct device_node *test_ancestor,
> > -                           struct device_node *child)
> > -{
> > -     of_node_get(child);
> > -     while (child) {
> > -             if (child == test_ancestor) {
> > -                     of_node_put(child);
> > -                     return true;
> > -             }
> > -             child = of_get_next_parent(child);
> > -     }
> > -     return false;
> > -}
> > -
> >  static struct device_node *of_get_compat_node(struct device_node *np)
> >  {
> >       of_node_get(np);
> > @@ -1106,71 +1092,27 @@ static struct device_node *of_get_compat_node_parent(struct device_node *np)
> >       return node;
> >  }
> >
> > -/**
> > - * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
> > - * @con_np: consumer device tree node
> > - * @sup_np: supplier device tree node
> > - *
> > - * Given a phandle to a supplier device tree node (@sup_np), this function
> > - * finds the device that owns the supplier device tree node and creates a
> > - * device link from @dev consumer device to the supplier device. This function
> > - * doesn't create device links for invalid scenarios such as trying to create a
> > - * link with a parent device as the consumer of its child device. In such
> > - * cases, it returns an error.
> > - *
> > - * Returns:
> > - * - 0 if fwnode link successfully created to supplier
> > - * - -EINVAL if the supplier link is invalid and should not be created
> > - * - -ENODEV if struct device will never be create for supplier
> > - */
> > -static int of_link_to_phandle(struct device_node *con_np,
> > +static void of_link_to_phandle(struct device_node *con_np,
> >                             struct device_node *sup_np)
> >  {
> > -     struct device *sup_dev;
> > -     struct device_node *tmp_np = sup_np;
> > +     struct device_node *tmp_np = of_node_get(sup_np);
> >
> > -     /*
> > -      * Find the device node that contains the supplier phandle.  It may be
> > -      * @sup_np or it may be an ancestor of @sup_np.
> > -      */
> > -     sup_np = of_get_compat_node(sup_np);
> > -     if (!sup_np) {
> > -             pr_debug("Not linking %pOFP to %pOFP - No device\n",
> > -                      con_np, tmp_np);
> > -             return -ENODEV;
> > -     }
> > +     /* Check that sup_np and its ancestors are available. */
> > +     while (tmp_np) {
> > +             if (of_fwnode_handle(tmp_np)->dev) {
> > +                     of_node_put(tmp_np);
> > +                     break;
> > +             }
> >
> > -     /*
> > -      * Don't allow linking a device node as a consumer of one of its
> > -      * descendant nodes. By definition, a child node can't be a functional
> > -      * dependency for the parent node.
> > -      */
> > -     if (of_is_ancestor_of(con_np, sup_np)) {
> > -             pr_debug("Not linking %pOFP to %pOFP - is descendant\n",
> > -                      con_np, sup_np);
> > -             of_node_put(sup_np);
> > -             return -EINVAL;
> > -     }
> > +             if (!of_device_is_available(tmp_np)) {
> > +                     of_node_put(tmp_np);
> > +                     return;
> > +             }
> >
> > -     /*
> > -      * Don't create links to "early devices" that won't have struct devices
> > -      * created for them.
> > -      */
> > -     sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> > -     if (!sup_dev &&
> > -         (of_node_check_flag(sup_np, OF_POPULATED) ||
> > -          sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
> > -             pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
> > -                      con_np, sup_np);
> > -             of_node_put(sup_np);
> > -             return -ENODEV;
> > +             tmp_np = of_get_next_parent(tmp_np);
> >       }
> > -     put_device(sup_dev);
> >
> >       fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
>
> fwnode_link_add() returns int. Why is the return type of this function
> changed to void?

The return value of fwnode_link_add() was ignored even before this
patch. Since all other reasons for of_link_to_phandle() to fail are
gone, I'm switching it to void.

fwnode_link_add() is ignored because it can only fail due to -ENOMEM.
Not much to do in that case. We do our best and move on.

-Saravana
