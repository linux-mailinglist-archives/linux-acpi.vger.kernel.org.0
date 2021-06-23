Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA90A3B1F64
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFWR3Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Jun 2021 13:29:16 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:36711 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWR3Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jun 2021 13:29:16 -0400
Received: by mail-ot1-f49.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so2710235otl.3;
        Wed, 23 Jun 2021 10:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hySmmm64dClZ27jhI5Y3Yqw9/VnJejZB+aX0WgljZo=;
        b=frIz+liIfQdvSSdOuLOaIF3gc61MrkMLQS84L1I/AOBMTZnYJ8kLbeALoFzZVkP4Tk
         340bEbAEyGsM7hlYCIK8c6r8hzjADf9Do++p8FlILKjw4UHQxUyEnw2+nCYKaTOH16Hw
         K8mKP4guTUXdIpQKVuNjesyemxOhIIQUcFQtWfoEsq4VSOz2bpLPzIjJqJ64QmHvapZb
         PZgjsDFV/A67Hkv0JRspLqmE5MV/bvtYfTPv8wbMqQW8okB6xlh4dpqJ4gk1NFqCIF5F
         fFSHlDOGnG6jtK9WNNjRVkDMS5kyax5IB30DvmngDxhZ2Pd+hC4Ih1jnz/B6Hu054kDo
         NHhA==
X-Gm-Message-State: AOAM531roeO88OXGJYZr7RzQZxNeLXzkQJ6zoRZey5YK3vpV4nm37K4S
        pncFjVfwibdrATzvUZxebo0kn2rx0nHXdyeS8is=
X-Google-Smtp-Source: ABdhPJzkF7/upEQ0DXTViC2+CRwHDgP1sncfDiZNpUaMQ9+qPTqxDk54Cn8doVYTp3AChJatHfu6kUXRf/O6y//YYOo=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr893919otm.260.1624469218068;
 Wed, 23 Jun 2021 10:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210623131421.15159-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20210623131421.15159-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jun 2021 19:26:46 +0200
Message-ID: <CAJZ5v0hEj5e_4RwfCZxnV+zpw92YyYV55Qu6iheVkjrUYorXkg@mail.gmail.com>
Subject: Re: [PATCH] software node: Handle software node injection to an
 existing device properly
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 23, 2021 at 3:14 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The function software_node_notify() - the function that creates
> and removes the symlinks between the node and the device - was
> called unconditionally in device_add_software_node() and
> device_remove_software_node(), but it needs to be called in
> those functions only in the special case where the node is
> added to a device that has already been registered.
>
> This fixes NULL pointer dereference that happens if
> device_remove_software_node() is used with device that was
> never registered.
>
> Fixes: b622b24519f5 ("software node: Allow node addition to already existing device")
> Reported-and-tested-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Applied, thanks!

It may not make it into 5.13 though due to the timing.

> ---
>  drivers/base/swnode.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 3cc11b813f28c..d1f1a82401207 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -1045,7 +1045,15 @@ int device_add_software_node(struct device *dev, const struct software_node *nod
>         }
>
>         set_secondary_fwnode(dev, &swnode->fwnode);
> -       software_node_notify(dev, KOBJ_ADD);
> +
> +       /*
> +        * If the device has been fully registered by the time this function is
> +        * called, software_node_notify() must be called separately so that the
> +        * symlinks get created and the reference count of the node is kept in
> +        * balance.
> +        */
> +       if (device_is_registered(dev))
> +               software_node_notify(dev, KOBJ_ADD);
>
>         return 0;
>  }
> @@ -1065,7 +1073,8 @@ void device_remove_software_node(struct device *dev)
>         if (!swnode)
>                 return;
>
> -       software_node_notify(dev, KOBJ_REMOVE);
> +       if (device_is_registered(dev))
> +               software_node_notify(dev, KOBJ_REMOVE);
>         set_secondary_fwnode(dev, NULL);
>         kobject_put(&swnode->kobj);
>  }
> @@ -1119,8 +1128,7 @@ int software_node_notify(struct device *dev, unsigned long action)
>
>         switch (action) {
>         case KOBJ_ADD:
> -               ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
> -                                              "software_node");
> +               ret = sysfs_create_link(&dev->kobj, &swnode->kobj, "software_node");
>                 if (ret)
>                         break;
>
> --
> 2.30.2
>
