Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD74D67F5A5
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Jan 2023 08:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjA1HfS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 28 Jan 2023 02:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjA1HfJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jan 2023 02:35:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A803D911
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 23:34:57 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v3so4563784pgh.4
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2023 23:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSzzcrZHpCAhZ5ULfCoy554S0eFulAfOQZjabEFT0U8=;
        b=T6LKh5CR8Si1HhKOUOGGGtZ6+5L8QCDzffO83OhZP2wPlLcupyHUy8bxsfcm8v8cZ/
         j/3yaxzN8/IO3o6B/J2ZsXS3POXQlpJG5U9RkT8mKeAbGUGrJsmRBdHQ2xULA4UQhGqf
         zKLVdpZ1DrH+Ji4aokYjjs7mbouXc5esEsTOJ/ntzTKiT6IkydC8+bkHwec1Og+MUxr0
         hXNtqQGQVu8qI2xASbYOzyQVR63cGIoNL3Me9EcDqvlg2CkGQqU8vPcIbc6cvzwKo+70
         ZUFzjUxjTnxSefwef5FGjcIYJ5dpXAlOlag4Rt23C89TQdrXibm+UEG3fZfhVxtUazd9
         9bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSzzcrZHpCAhZ5ULfCoy554S0eFulAfOQZjabEFT0U8=;
        b=2PJ7qG2gc989jpEhUWk9kfPQpBtNzCTBOLeVMeSnZogO2vmQAGrZEFTJwH0+iti2Iu
         1k+LGWe+57pn1KSZocgEXTfzMUkWnncorFvpXE4d3wvZPvGwrFwT2w/ZKTpMSRfbj6bH
         z3QkrjYVW/heMw1ipCF9ldYWvwi199zwBlg9dfHXYk6V85aihr22WJr6Kcy1rNPrvHco
         J/YoCuDDdIrm0S004Y5Vxr/L9WmGROkSl1XYRNxagb0DMmTfGB1XnTA0Wk3uhuLMsas1
         t4gXqq4sHJBozKOY+c/Xn89niJZG7bL5fR6Hm69XKY64JpmO2tD9gsZsMDI+8rmMboh0
         gyVg==
X-Gm-Message-State: AFqh2koRLq8zYPCgZmhIxb/sqlxPE0A9oBA95UCvvZ37Qyawnoppw6nU
        VzxASEbE6ZjOHR2ktmJXj1O8VfBwGi7CP9Z9zxMGEw==
X-Google-Smtp-Source: AMrXdXswL1uNSyC4P6OZZsmWvEys2JlxAMsY9Dtx/ZhkSOaPgA1JW1DbGLOznM5iRN4ulYnMstMca6Cy78SGFhjnIGo=
X-Received: by 2002:aa7:820f:0:b0:58d:a713:d1dd with SMTP id
 k15-20020aa7820f000000b0058da713d1ddmr5316394pfi.59.1674891296202; Fri, 27
 Jan 2023 23:34:56 -0800 (PST)
MIME-Version: 1.0
References: <20230127001141.407071-1-saravanak@google.com> <20230127001141.407071-7-saravanak@google.com>
 <Y9OaaC806Ywg7rM9@smile.fi.intel.com>
In-Reply-To: <Y9OaaC806Ywg7rM9@smile.fi.intel.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 27 Jan 2023 23:34:19 -0800
Message-ID: <CAGETcx9XGq20kagmVXwEV6MF9mp9Ta5ra0+Ynhb7GiUKnxkWqg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] driver core: fw_devlink: Allow marking a fwnode
 link as being part of a cycle
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

On Fri, Jan 27, 2023 at 1:33 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 26, 2023 at 04:11:33PM -0800, Saravana Kannan wrote:
> > To improve detection and handling of dependency cycles, we need to be
> > able to mark fwnode links as being part of cycles. fwnode links marked
> > as being part of a cycle should not block their consumers from probing.
>
> ...
>
> > +     list_for_each_entry(link, &fwnode->suppliers, c_hook) {
> > +             if (link->flags & FWLINK_FLAG_CYCLE)
> > +                     continue;
> > +             return link->supplier;
>
> Hmm...

Thanks!

>
>                 if (!(link->flags & FWLINK_FLAG_CYCLE))
>                         return link->supplier;
>
> ?
>
> > +     }
> > +
> > +     return NULL;
>
> ...
>
> > -     if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> > -         !fw_devlink_is_permissive()) {
> > -             sup_fw = list_first_entry(&dev->fwnode->suppliers,
> > -                                       struct fwnode_link,
> > -                                       c_hook)->supplier;
> > +     sup_fw = fwnode_links_check_suppliers(dev->fwnode);
>
> dev_fwnode() ?
>
> ...
>
> > -     val = !list_empty(&dev->fwnode->suppliers);
> > +     mutex_lock(&fwnode_link_lock);
> > +     val = !!fwnode_links_check_suppliers(dev->fwnode);
>
> Ditto?

Similar response as Patch 1 and Patch 4.


-Saravana
