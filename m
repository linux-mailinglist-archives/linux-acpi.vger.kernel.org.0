Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDB6B09B0
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Mar 2023 14:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCHNqH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Mar 2023 08:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjCHNpp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2023 08:45:45 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFE61040C
        for <linux-acpi@vger.kernel.org>; Wed,  8 Mar 2023 05:45:10 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d12so6767452ioe.10
        for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2023 05:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678283110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gz/Fal0kRuGQs4te+QLHZr2SvmaC9a9yoIN2O4rmEs=;
        b=FzOehmgGzILhkooEFO0biilFd7kiTA0NZcKrhcfEw83BGlvb/DRX3HApX0gd0asQu+
         zXYldxA3v4VRudBB014jDadWTIgo79RaVquXI8m+ip2DXj5WS98GeAQOpgEvrX+7tpbU
         SWqY8TrecDN3LvK2tWghCzQbSw+b/IEJKg1ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Gz/Fal0kRuGQs4te+QLHZr2SvmaC9a9yoIN2O4rmEs=;
        b=ZkT7nbVNFAq2KwDQ7AofVeCmApBg15/8NjWfeSokplsSW5rdNcb2W3ypj9gOW+5GDF
         f71oN84SKUTOR7Tf/vFy9zuMsiWBBtZf0g+2FByspXDN6CxZJ37QDV3v6Xe2wv6N84qj
         PY/ih7ULx5hrAL5W9DA7IJyx8WjrKLN43RwS5D3pQMqkcbNKn2sYwF4J0FX00o+tb5sK
         bykbQOeEsNDNuLH6go0063iOxE+S6NX96KC8AgEJ5DEc93hZhTsE+rjljYAP5qjqVjex
         piZclCpMIwo+ebrvme35TMc20PvNeYLKlRl5YHFGNxmIqCJSu77B51HM8KvVIyxvgghf
         yNjw==
X-Gm-Message-State: AO0yUKVEm00K8cR5IYU7xDTrcVYyBn6J0MRYol9Hm8ORUajYIdHH5KFq
        xtOV/UFSwdNgDWc1RS4iHs/ZVJLEWre2+qlI0NlUGQ==
X-Google-Smtp-Source: AK7set9vEwKu1Idu63ibGwE2iFEiZ7o1hncWOqoEWkYY6ycvzgr26jaWtmtsgD0Zy8mBVQpsXMl2fE6U84RedlItoHs=
X-Received: by 2002:a05:6602:4287:b0:745:50e5:c861 with SMTP id
 cd7-20020a056602428700b0074550e5c861mr8454903iob.4.1678283109499; Wed, 08 Mar
 2023 05:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-8-treapking@chromium.org> <ZAXUrJDtHmm7+50H@smile.fi.intel.com>
In-Reply-To: <ZAXUrJDtHmm7+50H@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 8 Mar 2023 21:44:58 +0800
Message-ID: <CAEXTbpftCVFBQK0bNiWvF0NnbNoMoF=dFStHy1HXOq8LvWYjsA@mail.gmail.com>
Subject: Re: [PATCH v13 07/10] drm/bridge: anx7625: Register Type C mode switches
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
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thanks for the review.

On Mon, Mar 6, 2023 at 7:55=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Mar 03, 2023 at 10:33:47PM +0800, Pin-yen Lin wrote:
> > Register USB Type-C mode switches when the "mode-switch" property and
> > relevant ports are available in Device Tree. Configure the crosspoint
> > switch based on the entered alternate mode for a specific Type-C
> > connector.
> >
> > Crosspoint switch can also be used for switching the output signal for
> > different orientations of a single USB Type-C connector, but the
> > orientation switch is not implemented yet. A TODO is added for this.
>
> ...
>
> > +     ctx->port_data =3D devm_kcalloc(
> > +             dev, switch_desc->num_typec_switches,
> > +             sizeof(struct anx7625_typec_port_data), GFP_KERNEL);
>
> I believe I have commented on this (indentation)...
>
> > +
>
> ...and this (blank line).

Sorry for missing this one. I'll fix this in v14.
>
> > +     if (!ctx->port_data) {
> > +             ret =3D -ENOMEM;
> > +             goto unregister_mux;
> > +     }
>
> ...
>
> > +             ctx->port_data[i].orientation =3D (dp_lanes[0] / 2 =3D=3D=
 0) ?
> > +                     TYPEC_ORIENTATION_REVERSE : TYPEC_ORIENTATION_NOR=
MAL;
>
> I believe that this is an error prone check, you should rather do the opp=
osite,
> i.e.  ' % 2  =3D=3D 0'.
>
The orientation should be TYPEC_ORIENTATION_REVERSE when the
data-lanes value is 0/1, so ` / 2` is what I meant here.

Though, after second thought, I think it would be clearer if I use
`dp_lanes[0] < 2`. I'll update this in v14 as well.
> --
> With Best Regards,
> Andy Shevchenko
>
>
Best regards,
Pin-yen
