Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6095F2DA741
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 05:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgLOE5r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 23:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgLOE5r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2020 23:57:47 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B9C06179C
        for <linux-acpi@vger.kernel.org>; Mon, 14 Dec 2020 20:57:06 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id o11so18167427ote.4
        for <linux-acpi@vger.kernel.org>; Mon, 14 Dec 2020 20:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2CzDzHRfMNSnqgic5nqeErM22D3QpmpZZFW910ZYos=;
        b=O/ep66pZSJZh3lkMCUmfcxmr5xb8x65TJMHfkvoXh16IpCJHWXaNwZW+VJkyg5U5M5
         8hYeVyjThTt6B0SMzEnmcr9LbpCfY7rWuyHTyV1+Yngf17i1IJtvyTb9ebPNpvASThf+
         x0EsIQVnsqCgLrroc2cllx/fH5tHUvO5ej/V1HeEawhEaB1ty+vdfw08TDpn202qRD7K
         lgHKa/BupgUdEw3Whqsh0FED6ifaJEckxs7ycGUwDhW6URMUO7Mt09HiRxBXvrUGwj60
         22r3nWdqDSSomEllkMYsj2o9zFn0oAFzKXnhFjtYMG5lmUBetQYOLr+UvSRd52uRsStM
         1FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2CzDzHRfMNSnqgic5nqeErM22D3QpmpZZFW910ZYos=;
        b=s7VxVJ+RAgNtYGmjjyc5E8xJNrrlDVSHz1SVPOPkH7fAVIeozYy8be0l699QXvW7nV
         Y/BD580IwoACiIa/wXU+z+dJ724/EJq/h3MGn0NMBprWjxDM4E0HKGJltvSSRYnbUZwC
         Hc0eRFMLYn3Ox2OwGFrRcvl0+wNWfOxDdxtF5OpwyqnpICgW9tmvLZbw/b8T1QK3uvVt
         fAB1/0aR+fsEF2pl5ybWdWythr2XCRtRM2oMLHmytvaZdePmVtdB2SVX8RCUdfE7KQu0
         jFtsjfwBu0zpsuEgaeN6htsJ+CLHO3edCU8oulPQXJ0k9/6b/12UdZ2qx4mRx1FC7IE3
         KS7A==
X-Gm-Message-State: AOAM5333oPT8GBx1R6XX7qsMZxboQSnGVDjaTdMHkfByECh3C6mdinjt
        nuVy7JD3adIxMLLZk6oQalQivQrr+VEtFNZtH9L49g==
X-Google-Smtp-Source: ABdhPJyUL9Q3xcu4a2fiLvGFfl5XNFEYQDO0yMccZOvTDYIQt4bsP2haDoZV9j7gsurgjmincBo4UMsaxXNA97fOddE=
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr21271486otc.368.1608008225706;
 Mon, 14 Dec 2020 20:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20201201213019.1558738-1-furquan@google.com>
In-Reply-To: <20201201213019.1558738-1-furquan@google.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Mon, 14 Dec 2020 20:56:48 -0800
Message-ID: <CAEGmHFGZM0mADs-Eiz780RHzyf3emJinSAMT6ipRMpOvb+HGjg@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on shutdown
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 1, 2020 at 1:30 PM Furquan Shaikh <furquan@google.com> wrote:
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

Hello,

Gentle ping. Just checking if there are any comments.

Thanks,
Furquan
