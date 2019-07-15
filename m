Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92004686EA
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2019 12:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfGOKRe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jul 2019 06:17:34 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36832 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOKRd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2019 06:17:33 -0400
Received: by mail-ua1-f66.google.com with SMTP id v20so6522497uao.3;
        Mon, 15 Jul 2019 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DgcIwiNdH47qmFy1UXoTt6v8pvUcjELhaZQ83WLJUic=;
        b=iarDya1JAIMHrCYlXI6PhMlRgc6ek150qGC+56H99xhylxo++Pt/kx+QSbRaq6vqkm
         AAj6I1B5aK7BALpIM6pGBbHhhzeqr+tGRbrjEwJwCzBN5ZzhJvHb2EVT2KBs4yfJLt+x
         Kz5X6u98oDRUAyzQL2fyexYQs3Bk/yZCAAYQk5tEIEc08MMJXAuoTyokqGiP/cJ5Yqqw
         c5s/pZ6g3Qtf1hvoAMcz8WpAmslz9BYLFO5YwiobETQhtf7Mex62LYxXS80fIt6Orf+g
         GXmNcj8KnoTqc3qxD7fpj0MsRdTvGnhn/qLiFxQqQ9NYXGCDnzn6MhghaJwkyhd+js4C
         rNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DgcIwiNdH47qmFy1UXoTt6v8pvUcjELhaZQ83WLJUic=;
        b=hROlFgx8cqFyTQIupauUd1zCNf/p/FiKWrvks7Y+s6ZeKcIQ9DS0BxWcxN5G5u21pR
         /RB+vUKMCCyTsE0yEqFAgozeF9tWYaQ88rLZ5i1sXQBOYdlFqPLEN1gwfxhUqgJPsEup
         ii64JOaKCqp7gcaHJstMt7CO9MgRNEOV22BB//vot2so/3bROJFFT7uFiV5RMBQZyLZb
         lCFizLqSSXssKdHHUsx33BVEp1Z9PEZYIAcfn10kDz49iWY0KArzl6+fOseImc1MvEk/
         pUUfnCp6mBN4AQuETTaqlWt8kwX/xhjKaL3CoA+bzBAVZSYwLmqUQznl5eVR/VXOYX/b
         cK0A==
X-Gm-Message-State: APjAAAUmnDE8QWas+sou/Dsny+Vz2jP06gv+wpUzh9+hhoMuKEGfMUe2
        GmAW53/mXc/Vz9ElHI4AvcFpXBCNpDb2HDaYxpo=
X-Google-Smtp-Source: APXvYqyuqhT1lnSacrPXMfkLjVFBLaZzAvCOeqLjDTCPBvjMQo1z5TTyM/ofDHL8m8ImMKvdq65hEER8t/Z5+SNC0Bw=
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr5615069uam.129.1563185852742;
 Mon, 15 Jul 2019 03:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190327164339.31205-1-heikki.krogerus@linux.intel.com> <20190327164339.31205-4-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190327164339.31205-4-heikki.krogerus@linux.intel.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Mon, 15 Jul 2019 18:17:21 +0800
Message-ID: <CAKgpwJXu1VP8Wq5OhUrThMR+63OiM9Lstn0ycijxSLBko_+pTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: typec: mux: Use the "compatible" property
 instead of a boolean property
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Heikki,

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E4=BA=8E2019=E5=B9=B43=
=E6=9C=8828=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:45=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Instead of searching for a boolean property, matching
> against the "compatible" property.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index 2ce54f3fc79c..9462b90f1c09 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -32,11 +32,7 @@ static void *typec_switch_match(struct device_connecti=
on *con, int ep,
>                 return ERR_PTR(-EPROBE_DEFER);
>         }
>
> -       /*
> -        * With OF graph the mux node must have a boolean device property=
 named
> -        * "orientation-switch".
> -        */
> -       if (con->id && !fwnode_property_present(con->fwnode, con->id))
> +       if (con->id && !fwnode_is_compatible(con->fwnode, con->id))

This is still the right approach for orientation switch match, right?

Li Jun
>                 return NULL;
>
>         list_for_each_entry(sw, &switch_list, entry)
> @@ -148,7 +144,7 @@ static void *typec_mux_match(struct device_connection=
 *con, int ep, void *data)
>
>         /* Accessory Mode muxes */
>         if (!desc) {
> -               match =3D fwnode_property_present(con->fwnode, "accessory=
");
> +               match =3D fwnode_is_compatible(con->fwnode, "accessory");
>                 if (match)
>                         goto find_mux;
>                 return NULL;
> --
> 2.20.1
>
