Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A02EF51D
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 16:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbhAHPuX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 10:50:23 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34904 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhAHPuW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 10:50:22 -0500
Received: by mail-ot1-f51.google.com with SMTP id i6so10060218otr.2;
        Fri, 08 Jan 2021 07:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fA2nnIzJ/uq/MJ6l1MulASkOUQ1R/EZA8/Cttt4YQUE=;
        b=mUS4kmmCIlNVWuWL73FUftipLprPOEhaa6l2AWsUnDFfP0qU+DqjeaOlSdI5xZ+Y+b
         K3ZrumK9RQ/z2RFpNnN31Cd5BABPAkgv03tWhQv2J0RC3IqIN5ut87cbAvBt9BDscgJ9
         pXrO139JXSaxl95Qme7qmA0VTq8nJjOjK5GegrQBC4ogtx62WMxRYaiCWxQ/j3eejqcQ
         5UOaFrAYIqd/MEQ0nAA112KI27QeZZ/dFcd/fIDW0CKF4RlpVQALP+PZYZ7JAX/g2JtK
         gSxM1bSz0LPwQ/697co7GCdGZNVi34m6GtTkFmllSvFuZvDbjpNkflxRi/IQ5huQCdRv
         K7iQ==
X-Gm-Message-State: AOAM5330/BRKuM2W17bng6ZDxKduA1XyWtd6Jyi2E6X/AwdceRBw/2Fc
        rIOOyvKBk3iL6+iKsl9MbdIKWBJg18tAQHZedXo=
X-Google-Smtp-Source: ABdhPJzyV8OFJPz2/HTlwHjG/t1VVwXZS6b8DMmLNa8DO2xRyfbDYxAtDsrTSQ7rXz4W3pzCukHYufCt5qCzbmpChw8=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr2979437ota.260.1610120980429;
 Fri, 08 Jan 2021 07:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20201201213019.1558738-1-furquan@google.com>
In-Reply-To: <20201201213019.1558738-1-furquan@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jan 2021 16:49:29 +0100
Message-ID: <CAJZ5v0iJ-yN91KJAaTkBVVKmuL0EmeUE=VqYPdZZfmcQm8oc1w@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on shutdown
To:     Furquan Shaikh <furquan@google.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 1, 2020 at 10:30 PM Furquan Shaikh <furquan@google.com> wrote:
>
> When the system is powered off or rebooted, devices are not detached
> from their PM domain. This results in ACPI PM not being invoked and
> hence PowerResouce _OFF method not being invoked for any of the
> devices. Because the ACPI power resources are not turned off in case
> of poweroff and reboot, it violates the power sequencing requirements
> which impacts the reliability of the devices over the lifetime of the
> platform. This is currently observed on all Chromebooks using ACPI.
>
> In order to solve the above problem, this change detaches a device
> from its PM domain whenever it is shutdown. This action is basically
> analogous to ->remove() from driver model perspective. Detaching the
> device from its PM domain ensures that the ACPI PM gets a chance to
> turn off the power resources for the device thus complying with its
> power sequencing requirements.
>
> Signed-off-by: Furquan Shaikh <furquan@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d661ada1518f..5823f1d719e1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_device.h>
>  #include <linux/genhd.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/netdevice.h>
>  #include <linux/sched/signal.h>
> @@ -4057,6 +4058,8 @@ void device_shutdown(void)
>                         dev->driver->shutdown(dev);
>                 }
>
> +               dev_pm_domain_detach(dev, true);
> +
>                 device_unlock(dev);
>                 if (parent)
>                         device_unlock(parent);
> --
> 2.29.2.454.gaff20da3a2-goog
>
