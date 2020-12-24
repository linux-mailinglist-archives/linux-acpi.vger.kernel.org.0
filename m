Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB752E26CA
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 13:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgLXMSE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 07:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgLXMSE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 07:18:04 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E5C06179C;
        Thu, 24 Dec 2020 04:17:24 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q4so1222957plr.7;
        Thu, 24 Dec 2020 04:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+3EQC8mVZjXYO5oCcx/CV2SQScU+vZuWt0oU084DsQ=;
        b=X1G2cjOPZibLvgI8OKxwYxP6vWy5F5iXoBkuG4Qb6M9ul/8ucQ6xB/4XTq4+4mE77x
         vlkbOqn3u78ruMVlq1C9nWxPcJMqWf4nQIba7kQi8Wr/1jsEJ58k8UBTS88c7RHMLOUp
         RNS2XzF1abdemm4JzpcHOaYppKECCtOuE3R5vTuRqMQ9PDTb2X2fV0+JDM1CTSo80klh
         IaZkPIaWC9jpPHtydxF14IXyCwGrKmxoXLKBhZuOLadjzL0HhXxg7iEFbtSHkYK0/D2N
         WbvYbHnTy6DxbVIamBGiIhc+mPEUOLLvyzmLIMejMfDQiJINYtbDpFWp087c+FIa4IiU
         04RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+3EQC8mVZjXYO5oCcx/CV2SQScU+vZuWt0oU084DsQ=;
        b=AGqQeFoyADFDSLf6pWtcwR0JlKtMPeJPwtvvGFwKiZ7/h6f09TeWVwHhfNWHKHbeDc
         AA8s8e404tRaSRQHDtb82QkJJT4wmorpFCykJDwk1oND5fOS0ofxqisk2kz4cVURNWsF
         RHcShR0atDRamT0dDwEjppMV0iflbOrQminfmFsot3xQ9qgQnZ6+jzpW7cicjq/jz1Xp
         UNUDkaUds5WZiwe5Q6+eLpUXzHcTCzHb7C5c3Ofm1QVgndB9azfEstnbROtB+MlEGqWB
         9gTl2OHELWbZwFBiWXAEWUGS4ktG5TUY7X6jzuwxYeGxmCY9xx1y0wp+DRRhlb94PCIg
         qiEA==
X-Gm-Message-State: AOAM531AqE6Uk6Z8kjjPrW6df8nLY2aeQF2SLOS8BchtPrfWk7oU6Qzn
        W6/8p86ZQ8PVD/TixqUb+4DN3khOYNvybzG8xVA=
X-Google-Smtp-Source: ABdhPJxCfxiRoyKI7QX4cx2zw6Wq58lpHia/hOQbyEuGs75ZIk1ZD/CEauMYOaK3uiUuiyh2ota7OvdtAw6r6GVxYPQ=
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr4222362pjt.228.1608812243836;
 Thu, 24 Dec 2020 04:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20201224010907.263125-1-djrscally@gmail.com> <20201224010907.263125-7-djrscally@gmail.com>
In-Reply-To: <20201224010907.263125-7-djrscally@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Dec 2020 14:17:07 +0200
Message-ID: <CAHp75Ve8YRygEn3wcbmnSPthG+R_-9hhkAdMLk7jgiPi=jnJ5Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] include: fwnode.h: Define format macros for
 ports and endpoints
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally <djrscally@gmail.com> wrote:
>
> OF, ACPI and software_nodes all implement graphs including nodes for ports
> and endpoints. These are all intended to be named with a common schema,
> as "port@n" and "endpoint@n" where n is an unsigned int representing the
> index of the node. To ensure commonality across the subsystems, provide a
> set of macros to define the format.

Nitpicks below, but in general that's what I meant, thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(after addressing nitpicks)

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v3
>         - Patch introduced
>
>  include/linux/fwnode.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9506f8ec0974..52889efceb7d 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -32,6 +32,19 @@ struct fwnode_endpoint {
>         const struct fwnode_handle *local_fwnode;
>  };
>
> +/*
> + * ports and endpoints defined in OF, ACPI and as software_nodes should all
> + * follow a common naming scheme; use these macros to ensure commonality across
> + * the subsystems.
> + *
> + * The *PREFIX_LEN macros refer to the length of the "port@" and "endpoint@"

*PREFIX_LEN -> *_PREFIX_LEN

> + * sections of the naming scheme.
> + */
> +#define FWNODE_GRAPH_PORT_NAME_FORMAT          "port@%u"
> +#define FWNODE_GRAPH_PORT_NAME_PREFIX_LEN      5
> +#define FWNODE_GRAPH_ENDPOINT_NAME_FORMAT      "endpoint@%u"
> +#define FWNODE_GRAPH_ENDPOINT_PREFIX_LEN       9

_FORMAT -> _FMT (however, V4L2 guys may correct me, because IIRC _FMT
suffix is also used for other things in v4l2.

>  #define NR_FWNODE_REFERENCE_ARGS       8
>
>  /**

-- 
With Best Regards,
Andy Shevchenko
