Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAA55EC3D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiF1SJ5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiF1SJ4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 14:09:56 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1835186C2
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 11:09:54 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ef5380669cso125458977b3.9
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYcXptv76jiUKLMxUytxxor8YPRPJV8ed1Ksm57QMfY=;
        b=gPaHaeaaI978b5ydBeuwCXwB7p5+rQlSV6qxfhLqvTHAolXdRgH8jO8iMj9MKGX2Mz
         fZH0DdWiowmwJ8lSWm0ZCZ+yjf0cCUVW53JB1iFi2sItpocpjFjm4tbySPjzqRplqQr7
         o2wkPTO8Ypud1ki4voNQUIE+PtXs2d0UJXppZ7zoWulorSoLG2mYpuxqKBiuIBzgMk+T
         klTK8NLAY3n5ZQnPicfJjI3Z5G7B6D2nzZmnN/5r+RBUnHk+tO8L+AfVimj9wc198spi
         6l2MXrGL1n/2vnY7thTm9OlNWdzJKD7gzIZTg23EjGMeP/fmtGnR7dG8XyT8cQiF0UJr
         uO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYcXptv76jiUKLMxUytxxor8YPRPJV8ed1Ksm57QMfY=;
        b=WpLZ4rRyWJKtiUO60QkzUq5+aFmPxexhuV7h4tQL4oWiPZR1ZOJMAzkMB5OKPbQYzl
         jsefbQ5z+Dh6TiJ3hLdbr19LY3+RG8BOSl2YxzGfyQd/GQt/pTuwzlkXJzjDqmbHLg/v
         A8MHKzNh7T/I2k+X4YidMJvyt5Ek8EWnjVWXN6n6KvxMNJxRRlUa1AXC+MoFrk7AYZgx
         lzP9g4lAqOxkSJUR7hvJ8/eq11IsI3xx4C0BzAkrM9+RRHdYoWaUImDBj1pCrbPz5a0D
         NSuLT9sBXyP/pe3Y6U+0f2BiqxAxyXdaorWb/tnQBFrce0lFAjAYR9bbmdZLu9Fk5yaK
         JH1Q==
X-Gm-Message-State: AJIora8uhyb3DJB+VbEswZYfRgIYMJa3Xnv9b6buPl80Jk+LTpDdZb7W
        in28+QHA4abdaOj1XKed8lbF4nmGepzfZlQXHMalSg==
X-Google-Smtp-Source: AGRyM1vXSF/CgiisBepoUdbqGMK1G70avpb5M7kcqEegWFWm9L/EdrvdapqcodHm0q1VzDBGk3UOcFlAe/HDnnYt2hE=
X-Received: by 2002:a0d:ca16:0:b0:31b:7adf:d91 with SMTP id
 m22-20020a0dca16000000b0031b7adf0d91mr21041838ywd.455.1656439793741; Tue, 28
 Jun 2022 11:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201121020232.908850-1-saravanak@google.com> <20201121020232.908850-14-saravanak@google.com>
 <YrmXpcU1NTYW6T/n@linaro.org> <CAGETcx8dwNcZFFzhhv=kMhpuQnyaEekrycpAmGusD-s+qfvA9g@mail.gmail.com>
 <YrskVLshWeps+NXw@linaro.org>
In-Reply-To: <YrskVLshWeps+NXw@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 28 Jun 2022 11:09:17 -0700
Message-ID: <CAGETcx8F0wP+RA0KpjOJeZfc=DVG-MbM_=SkRHD4UhD2ReL7Kw@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] driver core: Use device's fwnode to check if it
 is waiting for suppliers
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org
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

On Tue, Jun 28, 2022 at 8:55 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 22-06-27 15:30:25, Saravana Kannan wrote:
> > On Mon, Jun 27, 2022 at 4:42 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > On 20-11-20 18:02:28, Saravana Kannan wrote:
> > > > To check if a device is still waiting for its supplier devices to be
> > > > added, we used to check if the devices is in a global
> > > > waiting_for_suppliers list. Since the global list will be deleted in
> > > > subsequent patches, this patch stops using this check.
> > > >
> > > > Instead, this patch uses a more device specific check. It checks if the
> > > > device's fwnode has any fwnode links that haven't been converted to
> > > > device links yet.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/core.c | 18 ++++++++----------
> > > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 395dece1c83a..1873cecb0cc4 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
> > > >  static LIST_HEAD(deferred_sync);
> > > >  static unsigned int defer_sync_state_count = 1;
> > > >  static DEFINE_MUTEX(fwnode_link_lock);
> > > > +static bool fw_devlink_is_permissive(void);
> > > >
> > > >  /**
> > > >   * fwnode_link_add - Create a link between two fwnode_handles.
> > > > @@ -995,13 +996,13 @@ int device_links_check_suppliers(struct device *dev)
> > > >        * Device waiting for supplier to become available is not allowed to
> > > >        * probe.
> > > >        */
> > > > -     mutex_lock(&wfs_lock);
> > > > -     if (!list_empty(&dev->links.needs_suppliers) &&
> > > > -         dev->links.need_for_probe) {
> > > > -             mutex_unlock(&wfs_lock);
> > > > +     mutex_lock(&fwnode_link_lock);
> > > > +     if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> > > > +         !fw_devlink_is_permissive()) {
> > > > +             mutex_unlock(&fwnode_link_lock);
> > >
> > > Hi Saravana,
> > >
> > > First of, sorry for going back to this.
> >
> > No worries at all. If there's an issue with fw_devlink, I want to have it fixed.
> >
> > > There is a scenario where this check will not work and probably should
> > > work. It goes like this:
> > >
> > > A clock controller is not allowed to probe because it uses a clock from a child device of a
> > > consumer, like so:
> > >
> > >         dispcc: clock-controller@af00000 {
> > >                 clocks = <&dsi0_phy 0>;
> > >         };
> > >
> > >         mdss: mdss@ae00000 {
> > >                 clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
> > >
> > >                 dsi0_phy: dsi-phy@ae94400 {
> > >                         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> > >                 };
> > >         };
> > >
> > > This is a real scenario actually, but I stripped it down to the essentials.
> >
> > I'm well aware of this scenario and explicitly wrote code to address this :)
> >
>
> Actually, the problem seems to be when you have two dsi phys.
> Like so:
>
>          dispcc: clock-controller@af00000 {
>                  clocks = <&dsi0_phy 0>;
>                  clocks = <&dsi1_phy 0>;
>          };
>
>          mdss: mdss@ae00000 {
>                  clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
>
>                  dsi0_phy: dsi-phy@ae94400 {
>                          clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>                  };
>
>                  dsi1_phy: dsi-phy@ae64400 {
>                          clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>                  };
>          };
>
> And from what I've seen happening so far is that the device_is_dependent
> check for the parent of the supplier (if it also a consumer) seems to return
> false on second pass of the same link due to the DL_FLAG_SYNC_STATE_ONLY
> being set this time around.
>
> > See this comment in fw_devlink_create_devlink()
> >
> >        /*
> >          * If we can't find the supplier device from its fwnode, it might be
> >          * due to a cyclic dependency between fwnodes. Some of these cycles can
> >          * be broken by applying logic. Check for these types of cycles and
> >          * break them so that devices in the cycle probe properly.
> >          *
> >          * If the supplier's parent is dependent on the consumer, then the
> >          * consumer and supplier have a cyclic dependency. Since fw_devlink
> >          * can't tell which of the inferred dependencies are incorrect, don't
> >          * enforce probe ordering between any of the devices in this cyclic
> >          * dependency. Do this by relaxing all the fw_devlink device links in
> >          * this cycle and by treating the fwnode link between the consumer and
> >          * the supplier as an invalid dependency.
> >          */
> >
>
> So when this thing you mentioned above is happening for the second dsi
> phy (order doesn't matter), since the dsi phy itself cannot be found,
> the device_is_dependent is run for the same link: dispcc -> mdss
> (supplier -> consumer), but again, since it has the
> DL_FLAG_SYNC_STATE_ONLY this time around, it will skip that specific
> link.

Ugh... I knew there was this gap, but didn't expect it to be a real world issue.

There are different ways of addressing this and they all fall
somewhere within a spectrum of:
"stop enforcing very specific edges of the dependency graph when you
find a cycles"
To
"just don't enforce any dependency for devices in a cycle and let the
drivers figure out when to -EPROBE_DEFER".

And each of those are of varying complexity. Ideally I'd prefer to
relax specific edges, but I need to balance it out with the code
complexity. Let me soak this for a few weeks to decide on what option
to take.

Thanks for the report.

-Saravana

>
> > Applying this comment to your example, dispcc is the "consumer",
> > dsi0_phy is the "supplier" and mdss is the "supplier's parent".
> >
> > And because we can't guarantee the order of addition of these top
> > level devices is why I also have this piece of recursive call inside
> > __fw_devlink_link_to_suppliers():
> >
> >                 /*
> >                  * If a device link was successfully created to a supplier, we
> >                  * now need to try and link the supplier to all its suppliers.
> >                  *
> >                  * This is needed to detect and delete false dependencies in
> >                  * fwnode links that haven't been converted to a device link
> >                  * yet. See comments in fw_devlink_create_devlink() for more
> >                  * details on the false dependency.
> >                  *
> >                  * Without deleting these false dependencies, some devices will
> >                  * never probe because they'll keep waiting for their false
> >                  * dependency fwnode links to be converted to device links.
> >                  */
> >                 sup_dev = get_dev_from_fwnode(sup);
> >                 __fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
> >                 put_device(sup_dev);
> >
> > So when mdss gets added, we'll link it to dispcc and then check if
> > dispcc has any suppliers it needs to link to. And that's when the
> > logic will catch the cycle and fix it.
> >
> > Can you tell me why this wouldn't unblock the probing of dispcc? Are
> > you actually hitting this on a device? If so, can you please check why
> > this logic isn't sufficient to catch and undo the cycle?
> >
>
> This is happening on Qualcomm SDM845 with Linus's tree.
>
> > Thanks,
> > Saravana
> >
> > > So, the dsi0_phy will be "device_add'ed" (through of_platform_populate) by the mdss probe.
> > > The mdss will probe defer waiting for the DISP_CC_MDSS_MDP_CLK, while
> > > the dispcc will probe defer waiting for the dsi0_phy (supplier).
> > >
> > > Basically, this 'supplier availability check' does not work when a supplier might
> > > be populated by a consumer of the device that is currently trying to probe.
> > >
> > >
> > > Abel
> > >
> > >
> > > >               return -EPROBE_DEFER;
> > > >       }
> > > > -     mutex_unlock(&wfs_lock);
> > > > +     mutex_unlock(&fwnode_link_lock);
> > > >
> > > >       device_links_write_lock();
> > > >
> > > > @@ -1167,10 +1168,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
> > > >       bool val;
> > > >
> > > >       device_lock(dev);
> > > > -     mutex_lock(&wfs_lock);
> > > > -     val = !list_empty(&dev->links.needs_suppliers)
> > > > -           && dev->links.need_for_probe;
> > > > -     mutex_unlock(&wfs_lock);
> > > > +     val = !list_empty(&dev->fwnode->suppliers);
> > > >       device_unlock(dev);
> > > >       return sysfs_emit(buf, "%u\n", val);
> > > >  }
> > > > @@ -2202,7 +2200,7 @@ static int device_add_attrs(struct device *dev)
> > > >                       goto err_remove_dev_groups;
> > > >       }
> > > >
> > > > -     if (fw_devlink_flags && !fw_devlink_is_permissive()) {
> > > > +     if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
> > > >               error = device_create_file(dev, &dev_attr_waiting_for_supplier);
> > > >               if (error)
> > > >                       goto err_remove_dev_online;
> > > > --
> > > > 2.29.2.454.gaff20da3a2-goog
> > > >
> > > >
> >
