Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621133CBB14
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhGPRZ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhGPRZ1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 13:25:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA95C061760
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 10:22:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id oz7so12443311ejc.2
        for <linux-acpi@vger.kernel.org>; Fri, 16 Jul 2021 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c+sIMooxtvDJVn8odY5JLFWl/IcyMyFIVxI67a4xSE=;
        b=C/KEm8SY1qRUq8mfvLz7OVdGBiu3jZv76CDgZzY2pjAN2b4Wx2YLbSoRxo4KrQ5Ing
         oZLQNbWqO67GD4pM9c8sevTAv4rCOm8nYLVIMxZNr5pXR0ma9pIFlzYXMaXh6Drv4FG5
         H5a2NqUUia2w9A2+QMZ/tduTd4VTxtqYjqr66pTRe4Mxy26VP86vCKTDcbyt142T9DJ5
         RCoMmd7r1+su12GBNvh6fUs2U0H38lW+rzaVVRq/yrqNQ4Yx3cTygD8KvO1iiPhc655M
         7eD+aBBT3gaDqt/N0TCshI6/k3C3WIE4uRjhQtYg0liO5sY/sUFXER+PDXhBpsbBVSTq
         o4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c+sIMooxtvDJVn8odY5JLFWl/IcyMyFIVxI67a4xSE=;
        b=iK0OYkfafPr73Eg72nHdhnuavGjS4yKuD3pwOMgHa0ggsfQRgUMa8UDlPeqnQnQDeW
         7ycxvvEwkpz2FuZYwbqgSXfQ/XkkSDgmTeZBAs1VTZUyHA0cRf+Mkt3QLdRPrXUdrIPC
         HkkoXT53obl3bE0b2Gl4eeH2+MvTShMIUsdrbQoJAJrrAClXCG2zdkjXTIIycb9DQfFa
         cCHlNBQ2r4yPYvGdKVKpPa9FOe9snhpRRwnrJoFoarJj5j9WZWUZtGpGZaXkUeUB8C3n
         ynuWdxoIvMTucX0h4aoL2OrDxJBUxLxq6G4ACtfXw0nx+xbor/qoA/dchVJTgkfN6LGG
         +Ziw==
X-Gm-Message-State: AOAM532zcGPCjuEKnszCYAymR6EXoBF5YMwV/AuL/qwlK74R1uIdu2Ka
        o3dKGSGvvToXgnX0ap8bVNsZtIV0jcCyu0NWIKqUPw==
X-Google-Smtp-Source: ABdhPJyLuAxVHnqK+wx3ejq+Fn8StY+eDIP0EU5IEIZdhxkZCMlzyXAdlFLhmjA8wtQaIy15/WQq4RqPdOpMXdZWDIU=
X-Received: by 2002:a17:906:3699:: with SMTP id a25mr12875173ejc.452.1626456150821;
 Fri, 16 Jul 2021 10:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com> <YPF40t5bhgTFM2wK@smile.fi.intel.com>
In-Reply-To: <YPF40t5bhgTFM2wK@smile.fi.intel.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Fri, 16 Jul 2021 19:21:53 +0200
Message-ID: <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> > software nodes, thus leading to underflow errors. Balance the refcount by
> > bumping it in the device_create_managed_software_node() function.
> >
> > The error [1] was encountered after adding a .shutdown() op to our
> > fsl-mc-bus driver.
>
> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
> later on), I can tell that probably something is wrong in the ->shutdown()
> method itself.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Isn't the other alternative to just remove the second kobject_put from
KOBJ_REMOVE ?

@@ -1149,7 +1147,6 @@ int software_node_notify(struct device *dev,
unsigned long action)

                if (swnode->managed) {
                        set_secondary_fwnode(dev, NULL);
-                       kobject_put(&swnode->kobj);
                }
                break;
        default:

If we aren't being incremented in device_create_managed_software_node() then
should we be decremented here?

-Jon
