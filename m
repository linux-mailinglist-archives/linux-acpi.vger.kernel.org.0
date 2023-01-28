Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0173067F597
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jan 2023 08:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjA1HeJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Jan 2023 02:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjA1HeG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jan 2023 02:34:06 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAA3B3F8
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 23:34:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so6771800pjl.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 23:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48cPMwKfIB+JYXBPIFLFeL3uIHX0dr8TubcBcaVKSWg=;
        b=eVNLr6tMgu58ayq3Ao3L3DJzKMEFfj2tbmldarzOO8OyCpMG/ZZ2rlLfICfMDBCo5+
         VPYoXRhj8EtItKKFrhehPMIQ7V1tPMG99UpZlCDM+Mf1oyRyrBCvCMbMtihyB6F18Nao
         9o2PNPcr9v3ZFB/7Z1DSqGc7acdqB66aVOInvkxBZPLNSmIILNTUYiDsDD+44ujq4lEd
         cLTSvGeHYw69BwlArYctelJXJx5wZKHpPd5Qyzrkwm48CtOFvqXRpCvtFZ0A4kHJNfdv
         wjR9G1GhyqmB7Hs2pnSNtyQ6eABh67bfwViZQ35v1D/NA5ofowoPu+IqSZmLzYz9vXhP
         J71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48cPMwKfIB+JYXBPIFLFeL3uIHX0dr8TubcBcaVKSWg=;
        b=oylvXH3NDOL0FAXKddNg6j+hEWtd/y+sotElhHnIikqlB6y3/NXaAVtXHwrDFuT4w5
         rTgR2Zxpwa1nr2fMxKQjpOvW1Nos2F7JBoFUn9peeHHkLRC2KwGO3vjmMhFDFnWx7NJK
         TR6mtDRgAB2RRGWYc0IH6pEGE+4GKMQgaju8i0airgp7qmwfCE6RV4XV6HWUztHthM2D
         YUwxk82ETGxVw2T5buNALQ+75cugp7dBJ0qKsrNPq/vT9/zFSgkxLt+ZfhsQQ4PEk7Zm
         /4f9NvtaPS8BCqCgEVB9bD3xBwBa0QZUCBnjpkfmUpegrUDzgGly9zGG4zsojk4IIeQp
         lwIg==
X-Gm-Message-State: AO0yUKXrsa0/+R+gHFzgs//GnR02EwwdGMgYMx1YrR7xnTZ3wDrRbwf1
        E9Zd94OaHy+Eu9ECl4y42CDPTO6pQA85Fu4y9CDMEg==
X-Google-Smtp-Source: AK7set9myMbUwY2oQoYCC6s/hiNjKYlL3tr83m91kF4ZOSzpcq9WlGrvx111fb4zpvHUxMc/iM2X6KckP/ZL7OtRtIk=
X-Received: by 2002:a17:90a:64c5:b0:22b:ef05:ea5b with SMTP id
 i5-20020a17090a64c500b0022bef05ea5bmr2696800pjm.50.1674891244385; Fri, 27 Jan
 2023 23:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-2-saravanak@google.com>
 <Y9OXs9+uYi31dYJD@smile.fi.intel.com>
In-Reply-To: <Y9OXs9+uYi31dYJD@smile.fi.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 23:33:28 -0800
Message-ID: <CAGETcx_g8yKQQQVtNt+6cB8hS7OY9=dqm4tDhm1ZJZqG5nzSLg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] driver core: fw_devlink: Don't purge child
 fwnode's consumer links
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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

On Fri, Jan 27, 2023 at 1:22 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 26, 2023 at 04:11:28PM -0800, Saravana Kannan wrote:
> > When a device X is bound successfully to a driver, if it has a child
> > firmware node Y that doesn't have a struct device created by then, we
> > delete fwnode links where the child firmware node Y is the supplier. We
> > did this to avoid blocking the consumers of the child firmware node Y
> > from deferring probe indefinitely.
> >
> > While that a step in the right direction, it's better to make the
> > consumers of the child firmware node Y to be consumers of the device X
> > because device X is probably implementing whatever functionality is
> > represented by child firmware node Y. By doing this, we capture the
> > device dependencies more accurately and ensure better
> > probe/suspend/resume ordering.
>
> ...
>
> >  static unsigned int defer_sync_state_count = 1;
> >  static DEFINE_MUTEX(fwnode_link_lock);
> >  static bool fw_devlink_is_permissive(void);
> > +static void __fw_devlink_link_to_consumers(struct device *dev);
> >  static bool fw_devlink_drv_reg_done;
> >  static bool fw_devlink_best_effort;
>
> I'm wondering if may avoid adding more forward declarations...
>
> Perhaps it's a sign that devlink code should be split to its own
> module?

I've thought about that before, but I'm not there yet. Maybe once my
remaining refactors and TODOs are done, it'd be a good time to revisit
this question.

But I don't think it should be done for the reason of forward
declaration as we'd just end up moving these into base.h and we can do
that even today.

>
> ...
>
> > -int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
> > +static int __fwnode_link_add(struct fwnode_handle *con,
> > +                          struct fwnode_handle *sup)
>
> I believe we tolerate a bit longer lines, so you may still have it on a single
> line.

That'd make it >80 cols. I'm going to leave it as is.

>
> ...
>
> > +int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
> > +{
>
> > +     int ret = 0;
>
> Redundant assignment.

Thanks. Will fix in v3.

>
> > +     mutex_lock(&fwnode_link_lock);
> > +     ret = __fwnode_link_add(con, sup);
> > +     mutex_unlock(&fwnode_link_lock);
> >       return ret;
> >  }
>
> ...
>
> >       if (dev->fwnode && dev->fwnode->dev == dev) {
>
> You may have above something like
>
>
>         fwnode = dev_fwnode(dev);

I'll leave it as-is for now. I see dev->fwnode vs dev_fwnode() don't
always give the same results. I need to re-examine other places I use
dev->fwnode in fw_devlink code before I start using that function. But
in general it seems like a good idea. I'll add this to my TODOs.

>         if (fwnode && fwnode->dev == dev) {
>
> >               struct fwnode_handle *child;
> >               fwnode_links_purge_suppliers(dev->fwnode);
> > +             mutex_lock(&fwnode_link_lock);
> >               fwnode_for_each_available_child_node(dev->fwnode, child)
> > -                     fw_devlink_purge_absent_suppliers(child);
> > +                     __fw_devlink_pickup_dangling_consumers(child,
> > +                                                            dev->fwnode);
>
>                         __fw_devlink_pickup_dangling_consumers(child, fwnode);

I like the dev->fwnode->dev == dev check. It makes it super clear that
I'm checking "The device's fwnode points back to the device". If I
just use fwnode->dev == dev, then one will have to go back and read
what fwnode is set to, etc. Also, when reading all these function
calls it's easier to see that I'm working on the dev's fwnode (where
dev is the device that was just bound to a driver) instead of some
other fwnode.

So I find it more readable as is and the compiler would optimize it
anyway. If you feel strongly about this, I can change to use fwnode
instead of dev->fwnode.

Thanks,
Saravana
