Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535856383A3
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Nov 2022 06:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKYFww (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Nov 2022 00:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKYFwu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Nov 2022 00:52:50 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FCD11154
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 21:52:49 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s5so4957460edc.12
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 21:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RzN4h3qOAvIsS9Ytm8ViCV9LTXDRNYxBOrbT9kwa+z4=;
        b=oEaPYaoWVwjCvCRl0HhYzkfATCZulKO7O6FroIlJirLXfGB0mUMNQ1vzzo0lRHG88h
         cNaSmIx/Wju99aMFImQwYB8ffU35MFqJyO6o81ePWIivDyODyXWsv9bQogJMB23kCZrX
         ZuFBm7OSJUcNIYbcpI9E72DmIeVVa15mZVqnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzN4h3qOAvIsS9Ytm8ViCV9LTXDRNYxBOrbT9kwa+z4=;
        b=gPktRRSjuFzox1XfW2991fak+qvjUZFwB/Av9kh70GeO7yh2CR/GpxTVGPliBMHbvP
         DtHsBxRzGqVKPwAvW7609kZ/wzfn6ad05NBbdw8Bn681I4x+q+Uh9d9SpbIrCztfQhSF
         n2Hy/UJA3foSKHBmooraXXUYNmHbr+9ERKB3TQasbKZjx058o+FDLwzt71fQDrdvZDu6
         EM8dz6ZpNgykCwfJXaMhfrzMKa0Obh4xt1rC/Wp6P+SuO8BidM4yJje3qpD5a4uMzIJS
         4SWEErbDVPlMRjI8cG/RDyGj+o9QQdKAfv31ekJKpWYS1gWPA/3sr26NXncrFMZBK997
         OoZw==
X-Gm-Message-State: ANoB5pliYFl51B3WjWkrZjeOrL1aT73Y12aQIVnpPO3RA9NcELMlua7c
        +fA0QND27WQjlJDdpIhHtYZYwmSTCki6+C6Ow7/MXw==
X-Google-Smtp-Source: AA0mqf4swfPzjKVkl1scJTqiUbIDnuAEsouyb52592fG1trV+h5bVVpbQlj0dZBKZjpXqLgzGBJ89YmbylZKTLb1eqs=
X-Received: by 2002:a05:6402:1397:b0:467:78f2:d81f with SMTP id
 b23-20020a056402139700b0046778f2d81fmr16227783edv.88.1669355567575; Thu, 24
 Nov 2022 21:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-3-treapking@chromium.org> <Y39ikbcqx5/pEc64@smile.fi.intel.com>
In-Reply-To: <Y39ikbcqx5/pEc64@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 25 Nov 2022 13:52:36 +0800
Message-ID: <CAEXTbpcbQEyYfuCssENiFQxwe3t11HtHnpJHgjq+=GziNfUk-g@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] platform/chrome: cros_ec_typec: Purge blocking
 switch devlinks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Thu, Nov 24, 2022 at 8:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 24, 2022 at 06:20:51PM +0800, Pin-yen Lin wrote:
> > From: Prashant Malani <pmalani@chromium.org>
> >
> > When using OF graph, the fw_devlink code will create links between the
> > individual port driver (cros-ec-typec here) and the parent device for
> > a Type-C switch (like mode-switch). Since the mode-switch will in turn
> > have the usb-c-connector (i.e the child of the port driver) as a
> > supplier, fw_devlink will not be able to resolve the cyclic dependency
> > correctly.
> >
> > As a result, the mode-switch driver probe() never runs, so mode-switches
> > are never registered. Because of that, the port driver probe constantly
> > fails with -EPROBE_DEFER, because the Type-C connector class requires all
> > switch devices to be registered prior to port registration.
> >
> > To break this deadlock and allow the mode-switch registration to occur,
> > purge all the usb-c-connector nodes' absent suppliers. This eliminates
> > the connector as a supplier for a switch and allows it to be probed.
>
> ...
>
> > +     /*
> > +      * OF graph may have set up some device links with switches, since connectors have their
> > +      * own compatible. Purge these to avoid a deadlock in switch probe (the switch mistakenly
> > +      * assumes the connector is a supplier).
> > +      */
>
> A bit too long lines...

I'll fix this in v7.

>
> > +     if (dev->of_node)
>
> Why do you need this check?

We use this check to make sure only platforms using OF have their
links purged. I'm not sure if this should also be done on x86
platforms.

Best regards,
Pin-yen

>
> > +             device_for_each_child_node(dev, fwnode)
> > +                     fw_devlink_purge_absent_suppliers(fwnode);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
