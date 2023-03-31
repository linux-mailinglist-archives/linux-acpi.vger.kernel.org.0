Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869E86D15B3
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Mar 2023 04:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjCaCkc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Mar 2023 22:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCaCkb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Mar 2023 22:40:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811FCDD4
        for <linux-acpi@vger.kernel.org>; Thu, 30 Mar 2023 19:40:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d22so8148890iow.12
        for <linux-acpi@vger.kernel.org>; Thu, 30 Mar 2023 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680230428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQrwpcibujJqlmTEza2DfA5ZE4Qe7gVkHrwLff0ClFU=;
        b=IhgmJV7RavCOET87gb8RKOmKoudDGEX2zj6gR3iopZl0Bmv6IfgQ/ibbPL0KU83UY6
         gJkL4k45v6qA2nWZ6nxnZsOhRjtw9g4wyhYzTZWpXAq0BejD8cnPw2qIAdUUuPjrZivI
         Y/I1ZTDnRWEIGguWztnIYSiIY2DfpQzgRrEjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680230428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQrwpcibujJqlmTEza2DfA5ZE4Qe7gVkHrwLff0ClFU=;
        b=6ifJEUSiM8l9UvX1vdQIwt9XOJGZk8ImTzUaSR//PcRN4cIpI/9ks2hz63uOWrd7EU
         zDyxDXCfyvBVF2uy/C0Q/8kX2BSDfe6dDvQhlw2zxD87nfM/7VOiwfypfNvtz8tgJM/z
         VQijjyuJcPDMMrdSM0VjtoGKnTT09NAQxs8n5sO+46XsYCAiZIJIDl97T/oK6Q75nXy7
         MtIuuI2qRGzjTw4uGLSndNG+w7kXvxNKmI8YPIVdhJtx0mucJFCRJS1CVkYni4M5m4xO
         rIu8GW+df2c+h1VT/KKTAgHvJ2uOXAaQMlRHFxiN/XSxwdVr0zjYI2QxrVXb4EwHMqUn
         wDRA==
X-Gm-Message-State: AO0yUKWXiXghnbI1Vye+xz2j1FxuZtLUAESQkFsTtSjtng3GLpra4UoJ
        mun6FQbP3BPwPw8fIJlhwlroQf0IExNTFYxTOIPf/A==
X-Google-Smtp-Source: AK7set8PW/rmF4EecdA4hthe2v5SIisdg/Q+7FqP3P4IiAKgrK1r/tfAbNqXZZ9Oi0/saOdscwawRnNnF6Dkwgcrc7k=
X-Received: by 2002:a5e:d60b:0:b0:752:cba8:a2fa with SMTP id
 w11-20020a5ed60b000000b00752cba8a2famr9398024iom.2.1680230428034; Thu, 30 Mar
 2023 19:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-4-treapking@chromium.org> <CAA8EJpqFuhAtTaTJNMmfaQoYaKF_t6N2QMgbOS1c9XVey8Jf3w@mail.gmail.com>
In-Reply-To: <CAA8EJpqFuhAtTaTJNMmfaQoYaKF_t6N2QMgbOS1c9XVey8Jf3w@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 31 Mar 2023 11:40:16 +0900
Message-ID: <CAEXTbpfML_V=m5=F0yVac=vo=1Lipc+7cquZjgexitJHHrr-eA@mail.gmail.com>
Subject: Re: [PATCH v14 03/10] drm/display: Add Type-C switch helpers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, dri-devel@lists.freedesktop.org,
        Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Dmitry,

Thanks for the review.

On Thu, Mar 23, 2023 at 7:39=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 22 Mar 2023 at 12:47, Pin-yen Lin <treapking@chromium.org> wrote:
> >
> > Add helpers to register and unregister Type-C "switches" for bridges
> > capable of switching their output between two downstream devices.
> >
> > The helper registers USB Type-C mode switches when the "mode-switch"
> > and the "reg" properties are available in Device Tree.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v14:
> > - Introduce a new Kconfig becuase it didn't build when CONFIG_TYPEC=3Dm
> > - Add comments about devm_* usage
> > - Fix style issues
> >
> > Changes in v13:
> > - Add typec_mode_switch_node_count helper
> > - Fix style issues
> >
> > Changes in v12:
> > - Add fwnode_for_each_typec_mode_switch macro
> > - Remove a duplicated dmesg in the helper
> > - Used IS_REACHABLE instead to guard the function signatures
> >
> > Changes in v11:
> > - Use fwnode helpers instead of DT
> > - Moved the helpers to a new file
> > - Use "reg" instead of "data-lanes" to determine the port number
> > - Dropped collected tags due to new changes
> >
> > Changes in v10:
> > - Collected Reviewed-by and Tested-by tags
> > - Replaced "void *" with "typec_mux_set_fn_t" for mux_set callbacks
> > - Print out the node name when errors on parsing DT
> > - Use dev_dbg instead of dev_warn when no Type-C switch nodes available
> > - Made the return path of drm_dp_register_mode_switch clearer
> >
> > Changes in v8:
> > - Fixed the build issue when CONFIG_TYPEC=3Dm
> > - Fixed some style issues
> >
> > Changes in v7:
> > - Extracted the common codes to a helper function
> > - New in v7
> >
> >  drivers/gpu/drm/display/Kconfig               |   8 ++
> >  drivers/gpu/drm/display/Makefile              |   2 +
> >  drivers/gpu/drm/display/drm_dp_typec_helper.c | 105 ++++++++++++++++++
> >  include/drm/display/drm_dp_helper.h           |  46 ++++++++
> >  4 files changed, 161 insertions(+)
> >  create mode 100644 drivers/gpu/drm/display/drm_dp_typec_helper.c
> >
> > diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/=
Kconfig
> > index 09712b88a5b8..d61076947a1c 100644
> > --- a/drivers/gpu/drm/display/Kconfig
> > +++ b/drivers/gpu/drm/display/Kconfig
> > @@ -29,6 +29,14 @@ config DRM_DISPLAY_HDMI_HELPER
> >         help
> >           DRM display helpers for HDMI.
> >
> > +config DRM_DISPLAY_DP_TYPEC_HELPER
> > +       bool
> > +       default y
> > +       depends on DRM_DISPLAY_HELPER
> > +       depends on DRM_DISPLAY_HELPER=3DTYPEC || TYPEC=3Dy
>
> If it is a select'able option, it doesn't make sense to use "depends"
> here. Select will override depends.
>
I'm not very familiar with the practices of Kconfigs, but I'll keep
this in the next version per Andy's comment.

> > +       help
> > +         DRM display helpers for USB Type-C Displayport Alternate mode=
.
> > +
> >  config DRM_DP_AUX_CHARDEV
> >         bool "DRM DP AUX Interface"
> >         depends on DRM && DRM_DISPLAY_HELPER
> > diff --git a/drivers/gpu/drm/display/Makefile b/drivers/gpu/drm/display=
/Makefile
> > index 17ac4a1006a8..2202a6aea38e 100644
> > --- a/drivers/gpu/drm/display/Makefile
> > +++ b/drivers/gpu/drm/display/Makefile
> > @@ -8,6 +8,8 @@ drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_HELPER) +=3D=
 \
> >         drm_dp_helper.o \
> >         drm_dp_mst_topology.o \
> >         drm_dsc_helper.o
> > +drm_display_helper-$(CONFIG_DRM_DISPLAY_DP_TYPEC_HELPER) +=3D \
> > +       drm_dp_typec_helper.o
> >  drm_display_helper-$(CONFIG_DRM_DISPLAY_HDCP_HELPER) +=3D drm_hdcp_hel=
per.o
> >  drm_display_helper-$(CONFIG_DRM_DISPLAY_HDMI_HELPER) +=3D \
> >         drm_hdmi_helper.o \
> > diff --git a/drivers/gpu/drm/display/drm_dp_typec_helper.c b/drivers/gp=
u/drm/display/drm_dp_typec_helper.c
> > new file mode 100644
> > index 000000000000..1562a9ccdaf2
> > --- /dev/null
> > +++ b/drivers/gpu/drm/display/drm_dp_typec_helper.c
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/usb/typec_mux.h>
> > +#include <drm/display/drm_dp_helper.h>
> > +
> > +static int drm_dp_register_mode_switch(struct device *dev,
> > +                                      struct fwnode_handle *fwnode,
> > +                                      struct drm_dp_typec_switch_desc =
*switch_desc,
> > +                                      void *data, typec_mux_set_fn_t m=
ux_set)
> > +{
> > +       struct drm_dp_typec_port_data *port_data;
> > +       struct typec_mux_desc mux_desc =3D {};
> > +       char name[32];
>
> Why 32?

This is just a random length that is probably sufficiently large. I
see other users use the pointer from `fwnode_get_name` directly, but
we want to append the port number to ensure the names are unique.
>
> > +       u32 port_num;
> > +       int ret;
> > +
> > +       ret =3D fwnode_property_read_u32(fwnode, "reg", &port_num);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to read reg property: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       port_data =3D &switch_desc->typec_ports[port_num];
> > +       port_data->data =3D data;
> > +       port_data->port_num =3D port_num;
> > +       port_data->fwnode =3D fwnode;
> > +       mux_desc.fwnode =3D fwnode;
> > +       mux_desc.drvdata =3D port_data;
> > +       snprintf(name, sizeof(name), "%pfwP-%u", fwnode, port_num);
>
> I think it makes more sense to use dev_name here instead of fwnode.

Thanks for the suggestions. I'll update this in the next version.
>
> > +       mux_desc.name =3D name;
> > +       mux_desc.set =3D mux_set;
> > +
> > +       port_data->typec_mux =3D typec_mux_register(dev, &mux_desc);
> > +       ret =3D PTR_ERR_OR_ZERO(port_data->typec_mux);
> > +       if (ret)
> > +               dev_err(dev, "Mode switch register for port %d failed: =
%d\n",
> > +                       port_num, ret);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * drm_dp_register_typec_switches() - register Type-C switches
> > + * @dev: Device that registers Type-C switches
> > + * @port: Device node for the switch
> > + * @switch_desc: A Type-C switch descriptor
> > + * @data: Private data for the switches
> > + * @mux_set: Callback function for typec_mux_set
> > + *
> > + * This function registers USB Type-C switches for DP bridges that can=
 switch
> > + * the output signal between their output pins. This function uses dev=
m_kcalloc
> > + * to allocate memory, so it is expected to only call this in the driv=
er probe
> > + * functions.
> > + *
> > + * Currently only mode switches are implemented, and the function assu=
mes the
> > + * given @port device node has endpoints with "mode-switch" property.
> > + * The port number is determined by the "reg" property of the endpoint=
.
> > + */
> > +int drm_dp_register_typec_switches(struct device *dev, struct fwnode_h=
andle *port,
> > +                                  struct drm_dp_typec_switch_desc *swi=
tch_desc,
> > +                                  void *data, typec_mux_set_fn_t mux_s=
et)
> > +{
> > +       struct fwnode_handle *sw;
> > +       int ret;
> > +
> > +       switch_desc->num_typec_switches =3D typec_mode_switch_node_coun=
t(port);
> > +       if (!switch_desc->num_typec_switches) {
> > +               dev_dbg(dev, "No Type-C switches node found\n");
> > +               return 0;
> > +       }
> > +
> > +       switch_desc->typec_ports =3D devm_kcalloc(dev, switch_desc->num=
_typec_switches,
> > +                                               sizeof(struct drm_dp_ty=
pec_port_data),
> > +                                               GFP_KERNEL);
> > +       if (!switch_desc->typec_ports)
> > +               return -ENOMEM;
> > +
> > +       /* Register switches for each connector. */
> > +       for_each_typec_mode_switch_node(port, sw) {
> > +               ret =3D drm_dp_register_mode_switch(dev, sw, switch_des=
c, data, mux_set);
> > +               if (ret)
> > +                       goto err_unregister_typec_switches;
> > +       }
> > +
> > +       return 0;
> > +
> > +err_unregister_typec_switches:
> > +       fwnode_handle_put(sw);
> > +       drm_dp_unregister_typec_switches(switch_desc);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(drm_dp_register_typec_switches);
> > +
> > +/**
> > + * drm_dp_unregister_typec_switches() - unregister Type-C switches
> > + * @switch_desc: A Type-C switch descriptor
> > + */
> > +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc =
*switch_desc)
> > +{
> > +       unsigned int i;
> > +
> > +       for (i =3D 0; i < switch_desc->num_typec_switches; i++)
> > +               typec_mux_unregister(switch_desc->typec_ports[i].typec_=
mux);
> > +}
> > +EXPORT_SYMBOL(drm_dp_unregister_typec_switches);
> > diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/=
drm_dp_helper.h
> > index ab55453f2d2c..0fe56586d7bc 100644
> > --- a/include/drm/display/drm_dp_helper.h
> > +++ b/include/drm/display/drm_dp_helper.h
> > @@ -25,6 +25,7 @@
> >
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/usb/typec_mux.h>
> >
> >  #include <drm/display/drm_dp.h>
> >  #include <drm/drm_connector.h>
> > @@ -763,4 +764,49 @@ bool drm_dp_downstream_rgb_to_ycbcr_conversion(con=
st u8 dpcd[DP_RECEIVER_CAP_SIZ
> >                                                const u8 port_cap[4], u8=
 color_spc);
> >  int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_=
spc);
> >
> > +struct drm_dp_typec_port_data {
> > +       struct typec_mux_dev *typec_mux;
> > +       int port_num;
> > +       struct fwnode_handle *fwnode;
> > +       void *data;
> > +};
> > +
> > +struct drm_dp_typec_switch_desc {
> > +       int num_typec_switches;
> > +       struct drm_dp_typec_port_data *typec_ports;
> > +};
> > +
> > +#define for_each_typec_mode_switch_node(port, sw)      \
> > +       fwnode_for_each_child_node((port), (sw))        \
> > +               for_each_if(fwnode_property_present((sw), "mode-switch"=
))
> > +
> > +static inline unsigned int typec_mode_switch_node_count(struct fwnode_=
handle *port)
> > +{
> > +       struct fwnode_handle *sw;
> > +       unsigned int count =3D 0;
> > +
> > +       for_each_typec_mode_switch_node(port, sw)
> > +               count++;
> > +
> > +       return count;
> > +}
> > +
> > +#ifdef CONFIG_DRM_DISPLAY_DP_TYPEC_HELPER
> > +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc =
*switch_desc);
> > +int drm_dp_register_typec_switches(struct device *dev, struct fwnode_h=
andle *port,
> > +                                  struct drm_dp_typec_switch_desc *swi=
tch_desc,
> > +                                  void *data, typec_mux_set_fn_t mux_s=
et);
> > +#else
> > +static inline void drm_dp_unregister_typec_switches(struct drm_dp_type=
c_switch_desc *switch_desc)
> > +{
> > +}
> > +static inline int drm_dp_register_typec_switches(
> > +               struct device *dev, struct fwnode_handle *port,
> > +               struct drm_dp_typec_switch_desc *switch_desc, void *dat=
a,
> > +               typec_mux_set_fn_t mux_set)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> >  #endif /* _DRM_DP_HELPER_H_ */
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
>
>
> --
> With best wishes
> Dmitry

Best regards,
Pin-yen
