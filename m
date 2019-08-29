Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5CA2158
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfH2QvP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 12:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfH2QvP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Aug 2019 12:51:15 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C399D23404;
        Thu, 29 Aug 2019 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567097473;
        bh=pq0GhKU46RrXmGHvJIz30TT4pz3IJZ1TJm+ViEdFWA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o6/1mtIqrrR6T7me9poL5iZetsESqc4Cbf6otJ0M/FH05hzqbNryL3rqW1SDMUu/U
         PmoXbLr0xiHT3i8hqyYZo3GtC1NXe4LJNBXBonfjgJyxzFG2Pdgkv2s0i2otFDvFd7
         FkpyVzxayL5cOiyg57xqutd8+dWy3DP6oarqEEyQ=
Received: by mail-qt1-f178.google.com with SMTP id u34so4445387qte.2;
        Thu, 29 Aug 2019 09:51:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXkkakvyiy3nuSP3c534mO7cBnskrW9WDFIxLAzO5FaepO5lWjP
        9Nfb/kvIyi6WRnPjVklazeqelbKTyVhrcYysHA==
X-Google-Smtp-Source: APXvYqx88vkppzQVgopkkJErHz6eK6IxHyPQD9TerBYZiF/oFpGMsL3uvtJP05UlabXYWftjosC0xsv140FrEy7XrwU=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr10808259qtc.143.1567097472930;
 Thu, 29 Aug 2019 09:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190829074603.70424-1-saravanak@google.com> <20190829074603.70424-3-saravanak@google.com>
In-Reply-To: <20190829074603.70424-3-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Aug 2019 11:51:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ7U-kXZ9zYY+Appkh_D76oU+qzUOGz-2Zq05r3nZtCBw@mail.gmail.com>
Message-ID: <CAL_JsqJ7U-kXZ9zYY+Appkh_D76oU+qzUOGz-2Zq05r3nZtCBw@mail.gmail.com>
Subject: Re: [PATCH v10 2/7] of: property: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 29, 2019 at 2:46 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Add device links after the devices are created (but before they are
> probed) by looking at common DT bindings like clocks and
> interconnects.
>
> Automatically adding device links for functional dependencies at the
> framework level provides the following benefits:
>
> - Optimizes device probe order and avoids the useless work of
>   attempting probes of devices that will not probe successfully
>   (because their suppliers aren't present or haven't probed yet).
>
>   For example, in a commonly available mobile SoC, registering just
>   one consumer device's driver at an initcall level earlier than the
>   supplier device's driver causes 11 failed probe attempts before the
>   consumer device probes successfully. This was with a kernel with all
>   the drivers statically compiled in. This problem gets a lot worse if
>   all the drivers are loaded as modules without direct symbol
>   dependencies.
>
> - Supplier devices like clock providers, interconnect providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.
>
>   Some frameworks (Eg: regulator) handle this today by turning off
>   "unused" resources at late_initcall_sync and hoping all the devices
>   have probed by then. This is not a valid assumption for systems with
>   loadable modules. Other frameworks (Eg: clock) just don't handle
>   this due to the lack of a clear signal for when they can turn off
>   resources. This leads to downstream hacks to handle cases like this
>   that can easily be solved in the upstream kernel.
>
>   By linking devices before they are probed, we give suppliers a clear
>   count of the number of dependent consumers. Once all of the
>   consumers are active, the suppliers can turn off the unused
>   resources without making assumptions about the number of consumers.
>
> By default we just add device-links to track "driver presence" (probe
> succeeded) of the supplier device. If any other functionality provided
> by device-links are needed, it is left to the consumer/supplier
> devices to change the link when they probe.
>
> kbuild test robot reported clang error about missing const
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../admin-guide/kernel-parameters.rst         |   1 +
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  drivers/of/property.c                         | 241 ++++++++++++++++++
>  3 files changed, 248 insertions(+)


> +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> +{
> +       struct platform_device *sup_dev;
> +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> +       int ret = 0;
> +       struct device_node *tmp_np = sup_np;
> +
> +       of_node_get(sup_np);
> +       /*
> +        * Find the device node that contains the supplier phandle.  It may be
> +        * @sup_np or it may be an ancestor of @sup_np.
> +        */
> +       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> +               sup_np = of_get_next_parent(sup_np);
> +       if (!sup_np) {
> +               dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * Don't allow linking a device node as a consumer of one of its
> +        * descendant nodes. By definition, a child node can't be a functional
> +        * dependency for the parent node.
> +        */
> +       if (!of_is_ancestor_of(dev->of_node, sup_np)) {
> +               dev_dbg(dev, "Not linking to %pOFP - is descendant\n", sup_np);
> +               of_node_put(sup_np);
> +               return -EINVAL;
> +       }
> +       sup_dev = of_find_device_by_node(sup_np);

What if the supplier isn't a platform_device? A regulator supply is
quite likely not.

Rob
