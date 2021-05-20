Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5336F38B6E3
	for <lists+linux-acpi@lfdr.de>; Thu, 20 May 2021 21:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhETTPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 May 2021 15:15:12 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42831 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbhETTPJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2021 15:15:09 -0400
Received: by mail-oi1-f175.google.com with SMTP id c196so9223341oib.9;
        Thu, 20 May 2021 12:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8clB6TpIVCho94JnVEq2KjWI71LnxqVBb8WHhQLjztY=;
        b=aDcEqrqwJRjem8UTJUdeImTvhaTiNy/kjgwnW+oMNIRoRgOZtmxXNAPDQEb2SsYclq
         o/lTYvbTomRFAxJwHzCUod9aP+PftJnbtNWlYKEEoUptbAVRZ4W9eeKWe1Va4evCJy2f
         EiouwYzA3TisTwltDFlC50frclXwhSeFiAiLpmDU2VNIaihxAMXQeIarUfnygSH58COM
         Wxn1rT+Ld/qLiMcBAaBeGSANkvh308vhZE27W470R7fTavcVvb5O0gTVlaDihB07pins
         tWZ3vWr4+cxlQFItAsHyHWGDiEtt18HeZNRSw65bqamOrfJodL1x7G0MuE+qz1QsiDTm
         BVuQ==
X-Gm-Message-State: AOAM530IWdOQ/PiUVgrz++3cSCFRCGJ21z/aDKRZ9cjRK74skor0VR1w
        lDcTEcxuVsqa7FAPsAyynYv6rlmYrRk17+C+S+w=
X-Google-Smtp-Source: ABdhPJzR2IDcCbVrUe2qyMRRXhFKtU5QzQLchWh+Q6eTtGKEBvB1s/MT5NhCnUIeIhPUC4pL2HbJM1ILhZWMi4V6nKE=
X-Received: by 2002:aca:1910:: with SMTP id l16mr4152216oii.69.1621538027288;
 Thu, 20 May 2021 12:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210519210253.3578025-1-andy.shevchenko@gmail.com>
In-Reply-To: <20210519210253.3578025-1-andy.shevchenko@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 May 2021 21:13:36 +0200
Message-ID: <CAJZ5v0in=qEtVULLF=RwBTiFqiRK-DyPfD4F6uUAqeUfPFB8QQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 19, 2021 at 11:19 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Currently it's possible to iterate over the dangling pointer in case the device
> suddenly disappears. This may happen becase callers put it at the end of a loop.
>
> Instead, let's move that call inside acpi_dev_get_next_match_dev().

Not really.

> Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver")
> Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
> Cc: Daniel Scally <djrscally@gmail.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/acpi/utils.c                       | 5 +----
>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 8 +++-----
>  include/acpi/acpi_bus.h                    | 5 -----
>  3 files changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 3b54b8fd7396..ccfc484dbffd 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -846,10 +846,6 @@ EXPORT_SYMBOL(acpi_dev_present);
>   * Return the next match of ACPI device if another matching device was present
>   * at the moment of invocation, or NULL otherwise.
>   *
> - * FIXME: The function does not tolerate the sudden disappearance of @adev, e.g.
> - * in the case of a hotplug event. That said, the caller should ensure that
> - * this will never happen.
> - *
>   * The caller is responsible for invoking acpi_dev_put() on the returned device.
>   *
>   * See additional information in acpi_dev_present() as well.
> @@ -866,6 +862,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
>         match.hrv = hrv;
>
>         dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
> +       acpi_dev_put(adev);

What's the point?

The caller may as well put it after this returns, can't it?

And what if the caller still wants to do something with adev after this returns?

>         return dev ? to_acpi_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(acpi_dev_get_next_match_dev);

The original changelog is somewhat unclear.  It should say that it is
required to reference-count the start-point device before passing it
to this function, but beyond that I don't see a bug here.

> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> index e8511787c1e4..477417261b6e 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -178,13 +178,11 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>
>                 if (bridge->n_sensors >= CIO2_NUM_PORTS) {
>                         dev_err(&cio2->dev, "Exceeded available CIO2 ports\n");
> -                       cio2_bridge_unregister_sensors(bridge);
>                         ret = -EINVAL;
> -                       goto err_out;
> +                       goto err_put_adev;
>                 }
>
>                 sensor = &bridge->sensors[bridge->n_sensors];
> -               sensor->adev = adev;
>                 strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
>
>                 ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
> @@ -214,6 +212,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>                         goto err_free_swnodes;
>                 }
>
> +               sensor->adev = acpi_dev_get(adev);
>                 adev->fwnode.secondary = fwnode;
>
>                 dev_info(&cio2->dev, "Found supported sensor %s\n",
> @@ -227,8 +226,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>  err_free_swnodes:
>         software_node_unregister_nodes(sensor->swnodes);
>  err_put_adev:
> -       acpi_dev_put(sensor->adev);
> -err_out:
> +       acpi_dev_put(adev);
>         return ret;
>  }
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..bff6a11bb21f 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -698,11 +698,6 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
>   * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
>   *
>   * The caller is responsible for invoking acpi_dev_put() on the returned device.
> - *
> - * FIXME: Due to above requirement there is a window that may invalidate @adev
> - * and next iteration will use a dangling pointer, e.g. in the case of a
> - * hotplug event. That said, the caller should ensure that this will never
> - * happen.
>   */
>  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                   \
>         for (adev = acpi_dev_get_first_match_dev(hid, uid, hrv);        \
> --
> 2.31.1
>
