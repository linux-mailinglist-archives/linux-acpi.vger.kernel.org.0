Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7E6B2145
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Mar 2023 11:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCIKWP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Mar 2023 05:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjCIKWC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2023 05:22:02 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DF762FC5
        for <linux-acpi@vger.kernel.org>; Thu,  9 Mar 2023 02:22:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id t1so754930iln.8
        for <linux-acpi@vger.kernel.org>; Thu, 09 Mar 2023 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678357319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ah1TtdVxfPgfmW7zrYGGBKwFiIK5NMV4NPzf8pIYnM=;
        b=B72T8/xcJkjQz7mlADugAXF75gmsMItZFaKG06Dg/eKa38XtjEmB5TesT6Tgp6ASVa
         y7A4CQ+1SKnIFvNYlOo3PnP0nSTd+8rsz+m7vcdsxyqsxg5jUheyJ7M22oT4FGRUwJFe
         UlqCyzjG+7geAfz15PsLpJSOKheBGW/Vk39Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ah1TtdVxfPgfmW7zrYGGBKwFiIK5NMV4NPzf8pIYnM=;
        b=0eNKmR7xZizqgy4M9GxVSjjjzUP607LnEqGi9VwitbibqXekmBRXzWHTKyCmI8IiIq
         bdd8WE8a/laC9VvJnnV57GdDPMlotq6bNtVglBfsTYiJlU/xr8FnaoyjSaM8o4GxLFQm
         QjlgIbG1TOzBO9c7kwyQJS2zO5JxPi0Hfg+lKJJTfCj0dD+U9XT1qgCbFOnwN79yHuzd
         8FrqWTH7oSeYh2W0ycjDNC9a4b5co5yyVy1MObZauxbI+n0rw4SbSM6hCoyjz6W4LgCc
         EvVo6WReuxpuKP/Zko2VEeCZWToECrBLbMctR0bhqxCk5PD1oXOlgYfQYYW2iqbbDl/l
         eQdA==
X-Gm-Message-State: AO0yUKWCpj6ObYG6zcWXTEdTe31okCd1iAovy+s48X6v+sveWLN+Lr1u
        R54EjWt3alxDb3WbTGxnOKYArwkPF4l6lt90wYJfGw==
X-Google-Smtp-Source: AK7set/8LE04Zm+2ShiPru3Ucvo7TBxa+dRVhoQ8TlB/lSr0SCiXxU6ZSWYbEzWNlrck7ayKIPUPGHnsRZrsJ3nY8As=
X-Received: by 2002:a92:b512:0:b0:30f:543d:e52c with SMTP id
 f18-20020a92b512000000b0030f543de52cmr10301852ile.2.1678357319507; Thu, 09
 Mar 2023 02:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20230303143350.815623-1-treapking@chromium.org>
 <20230303143350.815623-11-treapking@chromium.org> <ZAXWbkq4oLfrWUR7@smile.fi.intel.com>
 <CAEXTbpe=e1iA7cnzuTtcsyFxpG37YCWSK_SqZb2A8hxcyCnJBg@mail.gmail.com> <ZAiqPIm6O1JCPF7f@smile.fi.intel.com>
In-Reply-To: <ZAiqPIm6O1JCPF7f@smile.fi.intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 9 Mar 2023 18:21:48 +0800
Message-ID: <CAEXTbpcQAJ1HiF0eGbBFzFU2K-K7vnEEyqGtqJFHbUOxWGG3iA@mail.gmail.com>
Subject: Re: [PATCH v13 10/10] drm/bridge: it6505: Register Type C mode switches
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, Mar 8, 2023 at 11:31=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 08, 2023 at 09:51:19PM +0800, Pin-yen Lin wrote:
> > On Mon, Mar 6, 2023 at 8:03=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Mar 03, 2023 at 10:33:50PM +0800, Pin-yen Lin wrote:
>
> ...
>
> > > > +             it6505->port_data[i].lane_swap =3D (dp_lanes[0] / 2 =
=3D=3D 1);
> > >
> > > ' % 2 =3D=3D 0' ?
> > >
> > Per another patch, I'll update this into `< 2`
>
> But here it should be >=3D 2 then, no?
>
Yes it should be >=3D 2 here. I wasn't really using my brain when I
replied to the mail....
> --
> With Best Regards,
> Andy Shevchenko
>
>
Best regards,
Pin-yen
