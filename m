Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7568D3BF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 11:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBGKLg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Feb 2023 05:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjBGKLc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2023 05:11:32 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B796A57
        for <linux-acpi@vger.kernel.org>; Tue,  7 Feb 2023 02:11:29 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w13so5812028ilv.3
        for <linux-acpi@vger.kernel.org>; Tue, 07 Feb 2023 02:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGLVt33QptT1V9qlTmndDyVUdkEPlh9MnwGhnG7S+Dw=;
        b=DdPR3zQi3FaRq/0DUytEr3pdQZJXEYAcVrcD7V59G77SlXPd4u49tC+gyGBwFJPFYy
         67/fa4FaZDJ7/nKp9i2do2fWQFcMfJbHpGPfUq6HvZUZF4UBEooUGXVzWBqMFMEnYZwN
         rAaICWHuS5XF+Lo2bO8pVyMaqko727E+MSi7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGLVt33QptT1V9qlTmndDyVUdkEPlh9MnwGhnG7S+Dw=;
        b=srjz2IH93RCoYO2JIXFfABNnCH6pxqY6AFMeyaB4UGHD3zb5f3b9WzG4llPAE6SCEB
         O4CtV2OmpeF+6ZQNE5xuTI+WtJpWVry5lb/GoN0ASWVLsFBZ6R+xU1kiGae0KxifyPT/
         BU/qatJYmAjerX8O9b2pbuIoXUPXPyqeEDJ80BztsjK10fMVSOlvDkcl1OV732sbGM+f
         HwVszaw/t+ZCBYQPkHrC+6vTC2XFkF7kw6lHfudcQ67k1nBddA4ppLrU9pCZPL4Vmonc
         In29pkJn3iXDbAoAdPYi4A9UXpozQ5qGiet1e5hvL9g6wtccFHVej8UD0q1pDaIDJmGx
         PwOg==
X-Gm-Message-State: AO0yUKUEuq9q0muggjr6CuYXy6o6joJSwV0DIKFIqXWNEE3Tige8N6c8
        vnpwRIzeO5uUnlTYXU4PkRB2GFOUKSya+Nr4WWU8cA==
X-Google-Smtp-Source: AK7set+p9iSJUXF22CkwOZYUk1RTPFJALAKMX1xeE+pdWvWYe6DHfPcl7VfcfJVnxubu8xcpOm0LxJ22zFQvIXxeTUg=
X-Received: by 2002:a92:4412:0:b0:310:fd95:6d81 with SMTP id
 r18-20020a924412000000b00310fd956d81mr1835895ila.42.1675764689078; Tue, 07
 Feb 2023 02:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20230109084101.265664-1-treapking@chromium.org> <e620862840bcac9dcd46dd63e247966424af060f.camel@redhat.com>
In-Reply-To: <e620862840bcac9dcd46dd63e247966424af060f.camel@redhat.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Tue, 7 Feb 2023 18:11:18 +0800
Message-ID: <CAEXTbpcEo1O3YYWjdYKMEotir8KoDEvsRtcD4SOvjGB08vhZ_Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] Register Type-C mode-switch in DP bridge endpoints
To:     Lyude Paul <lyude@redhat.com>
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xin Ji <xji@analogixsemi.com>, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Lyude,

Thanks for letting me know!

I just sent out a v11 and already received some review comments, but
reviews are always welcomed if you have time to take a look.

Regards,
Pin-yen

On Tue, Jan 31, 2023 at 7:10 AM Lyude Paul <lyude@redhat.com> wrote:
>
> Don't know if this still needs reviews from me (feel free to respond if i=
t
> does!), but I wanted to say nice work! This is something I've wanted to s=
ee
> added to DRM for a while =E2=99=A5
>
>
> On Mon, 2023-01-09 at 16:40 +0800, Pin-yen Lin wrote:
> > This series introduces bindings for anx7625/it6505 to register Type-C
> > mode-switch in their output endpoints, and use data-lanes property to
> > describe the pin connections.
> >
> > The first two patch modifies fwnode_graph_devcon_matches and
> > cros_typec_init_ports to enable the registration of the switches.
> >
> > Patch 4~6 introduce the bindings for anx7625 and the corresponding driv=
er
> > modifications.
> >
> > Patch 7~9 add similar bindings and driver changes for it6505.
> >
> > v7: https://lore.kernel.org/all/20230105132457.4125372-1-treapking@chro=
mium.org/
> > v6: https://lore.kernel.org/all/20221124102056.393220-1-treapking@chrom=
ium.org/
> > v5: https://lore.kernel.org/linux-usb/20220622173605.1168416-1-pmalani@=
chromium.org/
> >
> > Changes in v9:
> > - Collected Reviewed-by tag
> > - Fixed subject prefix again
> > - Changed the naming of the example node for it6505
> >
> > Changes in v8:
> > - Fixed the build issue when CONFIG_TYPEC=3Dm
> > - Fixed some style issues
> > - Fixed the subject prefixes for the bindings patch
> > - Fixed the bindings for data-lanes properties
> >
> > Changes in v7:
> > - Fix the long comment lines
> > - Extracted the common codes to a helper function
> > - Fixed style issues in anx7625 driver
> > - Removed DT property validation in anx7625 driver.
> > - Fixed style issues in it6505 driver
> > - Removed the redundant sleep in it6505 driver
> > - Removed DT property validation in it6505 driver
> > - Rebased to drm-misc-next
> > - Fixed indentations in bindings patches
> > - Added a new patch to fix indentations in Kconfig
> >
> > Changes in v6:
> > - Changed it6505_typec_mux_set callback function to accommodate with
> >   the latest drm-misc patches
> > - Changed the driver implementation to accommodate with the new binding
> > - Dropped typec-switch binding and use endpoints and data-lanes propert=
ies
> >   to describe the pin connections
> > - Added new patches (patch 1,2,4) to fix probing issues
> > - Changed the bindings of it6505/anx7625 and modified the drivers
> >   accordingly
> > - Merged it6505/anx7625 driver changes into a single patch
> >
> > Pin-yen Lin (7):
> >   drm/display: Add Type-C switch helpers
> >   dt-bindings: display: bridge: anx7625: Add mode-switch support
> >   drm/bridge: anx7625: Check for Type-C during panel registration
> >   drm/bridge: anx7625: Register Type C mode switches
> >   dt-bindings: display: bridge: it6505: Add mode-switch support
> >   drm/bridge: it6505: Fix Kconfig indentation
> >   drm/bridge: it6505: Register Type C mode switches
> >
> > Prashant Malani (2):
> >   device property: Add remote endpoint to devcon matcher
> >   platform/chrome: cros_ec_typec: Purge blocking switch devlinks
> >
> >  .../display/bridge/analogix,anx7625.yaml      |  99 ++++++++++++-
> >  .../bindings/display/bridge/ite,it6505.yaml   |  93 ++++++++++--
> >  drivers/base/property.c                       |  15 ++
> >  drivers/gpu/drm/bridge/Kconfig                |  21 +--
> >  drivers/gpu/drm/bridge/analogix/Kconfig       |   1 +
> >  drivers/gpu/drm/bridge/analogix/anx7625.c     | 101 +++++++++++++-
> >  drivers/gpu/drm/bridge/analogix/anx7625.h     |  13 ++
> >  drivers/gpu/drm/bridge/ite-it6505.c           | 119 +++++++++++++++-
> >  drivers/gpu/drm/display/drm_dp_helper.c       | 132 ++++++++++++++++++
> >  drivers/platform/chrome/cros_ec_typec.c       |  10 ++
> >  include/drm/display/drm_dp_helper.h           |  16 +++
> >  11 files changed, 591 insertions(+), 29 deletions(-)
> >
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>
