Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6235551D91E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 May 2022 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346972AbiEFNcF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 May 2022 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344414AbiEFNcF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2022 09:32:05 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38804140B2
        for <linux-acpi@vger.kernel.org>; Fri,  6 May 2022 06:28:22 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id w187so12876403ybe.2
        for <linux-acpi@vger.kernel.org>; Fri, 06 May 2022 06:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRsiKtw85NssjuiS/jSteKmhOvxG7HQ33WDlI2l0psI=;
        b=p8jOBBQ1D0527MOrrgd0QJ0XkHSUa95vnveGgKdJ7DrHdUcgpvqldkc1qPbvy/tibq
         FyqzcCjGCs/xR5syyfwE5uASzDa4+UTi9lsooAxhjX4qsqFOd/DL5pLWb9q3Zt0ky2Q8
         VhRM9vtWD/L81s08nqVx3LyeH9a7EpooHacdRduonncXh/3Y1ld7fSZA50lTR3OG4hvY
         3sg3tt0ova8LE0Ing0Ya4j1br9Kehe4wLFipKgbumh3Wk9e+jp6mJYFO8PmiAq1EWjad
         ZjHMmqQi0jPtZ7k1wTCxXQxvjgbn1AqFZ8Vs0GuRBN9I51mklo4jb5Bg7btOwt/U6TSc
         BRJg==
X-Gm-Message-State: AOAM532xechVT2fvJrq2Oj3FZ2WbcLKGAz/G80ykPYTbWwZaCj0ohjOf
        PtxHnaOPtBukDcs8zc5odhT+t0yoI1Msfedyna8=
X-Google-Smtp-Source: ABdhPJzhikwsgUpeZ14QxHi5tF2/fNWFJERni9CDkBgNaWU2LRlAIw5JXND/uJAyQSzwcrMJciU+FmgKz0d0f8DWGEE=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr2187668ybs.365.1651843701472; Fri, 06
 May 2022 06:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com> <20220506130025.984026-8-sakari.ailus@linux.intel.com>
In-Reply-To: <20220506130025.984026-8-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 15:28:10 +0200
Message-ID: <CAJZ5v0gQR+zFdWqst1D-XYkwwZJkNuBen1-acxFWRY=2Ty6Sdw@mail.gmail.com>
Subject: Re: [PATCH 07/11] ACPI: Initialise device child list early to access
 data nodes early
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 6, 2022 at 2:58 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> The properties, including data nodes, are initialised in
> acpi_init_device_object(). Traversing the data nodes also requires the
> device's child list to be initialised which happens much later in
> __acpi_device_add(). The function also makes the device visible in the
> system, so setting up its properties and nodes is too late by then.
>
> To address this, move the child list initialisation before
> acpi_init_properties() in acpi_init_device_object().
>
> Note that this is currently not an issue as the properties will only be
> accessed by drivers. In the near future accessing the properties will be
> done in the ACPI framework itself, and doing so requires this change.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

There is a problem with this that the children list is redundant and
not really safe to use and so it will be dropped.  I actually have a
series of patches to do that in the works.

I'm also unsure why it would be necessary to initialize the list of
the device's children earlier, because adding anything to that list
requires a child device object to be registered with cannot happen
before registering the parent itself.

> ---
>  drivers/acpi/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 762b61f67e6c6..86c4e9a473edc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -680,7 +680,6 @@ static int __acpi_device_add(struct acpi_device *device,
>          * -------
>          * Link this device to its parent and siblings.
>          */
> -       INIT_LIST_HEAD(&device->children);
>         INIT_LIST_HEAD(&device->node);
>         INIT_LIST_HEAD(&device->wakeup_list);
>         INIT_LIST_HEAD(&device->physical_node_list);
> @@ -1786,6 +1785,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
>         acpi_set_device_status(device, ACPI_STA_DEFAULT);
>         acpi_device_get_busid(device);
>         acpi_set_pnp_ids(handle, &device->pnp, type);
> +       INIT_LIST_HEAD(&device->children);
>         acpi_init_properties(device);
>         acpi_bus_get_flags(device);
>         device->flags.match_driver = false;
> --
> 2.30.2
>
