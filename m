Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AC6B213D
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Mar 2023 11:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCIKVu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Mar 2023 05:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCIKVa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2023 05:21:30 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809CD73AE0
        for <linux-acpi@vger.kernel.org>; Thu,  9 Mar 2023 02:20:55 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id t129so487943iof.12
        for <linux-acpi@vger.kernel.org>; Thu, 09 Mar 2023 02:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678357255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIU3HMuVNTJJMDhnoEUvCOuAE75z3O7Qyl1/k3U1zyU=;
        b=BVW4T3AssvDhpzvR5OQ1nO3YwRaVAGkl6KA4fAJ7wye5I5nb4s/ipZO3wq7VlN/S6l
         aR82jJKHvaE12XBrcriVHD2/jAUxNDABHtALxwu0o95JAOJqZyzGJomUAh/iHfj7AZMj
         VVy8FM3OW+YzvBVfjTY9lglRcnfPOYKRuVtFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIU3HMuVNTJJMDhnoEUvCOuAE75z3O7Qyl1/k3U1zyU=;
        b=gqR5juMf156juA7zDotnlN2xCe3LfIn2vGZtjWNLwsT9iezfhd4O3zOSj+m9IrBJ62
         emBt4R8W/efHEGW4CqYEP3JoDBJNFTVa5pbUarTalAZPO0GMmuxc/tFveKfIwYb7B1T/
         qNqfsDjvCDhmJnM+eC+IBtqzy0gl9dmdZVtoFHRIFQaOQ3iiui6+IrvJLvnc0OAhxuGu
         vB8sV7okXFGWDUCEsdIPe76pIdtd7YnX5fituQxZErhJsxZ2YT7TiYnYW2XyqUhXX2cK
         LELUQpqJwxMe5CCWh0Vs8VW19d+y7kHrA6mjHEPXDh6dnbkYu3h7QmhJ/YPqsra/+4nJ
         qTkQ==
X-Gm-Message-State: AO0yUKVyxU8YZk6Fe0rJEfTwa3Z6QJD/udshqCq6lF5Ph/7ovtZVmV0g
        5f2z6NBlz7qXpDxlKvJ0PqVmgDu7pNNiO26zFxP51w==
X-Google-Smtp-Source: AK7set8yQOFHurTiJsdWOlEy9y+Eh5psaAfvl621J543EP4BUiv7QH2QzIQMnElcHbQnb2xLNM/JQ9lkCoOlRDsgqQk=
X-Received: by 2002:a02:7310:0:b0:3ca:61cc:4bbc with SMTP id
 y16-20020a027310000000b003ca61cc4bbcmr10772903jab.2.1678357254876; Thu, 09
 Mar 2023 02:20:54 -0800 (PST)
MIME-Version: 1.0
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-4-treapking@chromium.org> <ZAXTVCAQpHvSj+6C@smile.fi.intel.com>
 <CAEXTbpf4zM+70BCef6rdfz35TQnQ+ozaXAvOaEZVnqqe6MDOOg@mail.gmail.com> <ZAiptm03HzQila0M@smile.fi.intel.com>
In-Reply-To: <ZAiptm03HzQila0M@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 9 Mar 2023 18:20:44 +0800
Message-ID: <CAEXTbpfQTGsZVy4m0MXQ0AK-N66F3OHwFmT_kNThMPxZFVP6ow@mail.gmail.com>
Subject: Re: [PATCH v13 03/10] drm/display: Add Type-C switch helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
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
        Xin Ji <xji@analogixsemi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, Mar 8, 2023 at 11:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 08, 2023 at 06:20:14PM +0800, Pin-yen Lin wrote:
> > On Mon, Mar 6, 2023 at 7:49=E2=80=AFPM Andy Shevchenko
> > > On Fri, Mar 03, 2023 at 10:33:43PM +0800, Pin-yen Lin wrote:
>
> ...
>
> > > > +     switch_desc->typec_ports =3D devm_kcalloc(dev, switch_desc->n=
um_typec_switches,
> > > > +                                             sizeof(struct drm_dp_=
typec_port_data),
> > > > +                                             GFP_KERNEL);
> > > > +     if (!switch_desc->typec_ports)
> > > > +             return -ENOMEM;
> > >
> > > How often this function _can_ be called during the runtime?
> > > If it's _possible_ to call it infinite times, consider *not* using de=
vm.
> >
> > I would expect this function to be only called during driver probing,
> > and this is the case for the current users in this series. So I think
> > this is only called once if EPROBDE_DEFER doesn't count.
>
> No, deferred probe is not counted.
>
> Can you add a word somewhere in the comment(?) to make this clear?

Sure. I'll add some note in the comments about this.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Thanks and regards,
Pin-yen
