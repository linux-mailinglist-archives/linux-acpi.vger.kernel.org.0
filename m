Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D286FCD3F
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjEISGq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 9 May 2023 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjEISGn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 14:06:43 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5073E5278;
        Tue,  9 May 2023 11:06:41 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-504d149839bso1579662a12.1;
        Tue, 09 May 2023 11:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655600; x=1686247600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uAV8/8elWuBoFp2U6X37MYwrNK4FwAxcuWNLFk3654=;
        b=L7ioIEmXHnMM+pRFUsPUQT8380qSVMZ9WDmnAwmYol4bJDavzN0ki8186/Hj/+0Ink
         FENSvnKssE241dpyig1u/CF8S4H1AwKj5leZDLzV9+ZN1bXff0p6NTUB5GsxosU4XfNP
         qcsUZIEcyg8uJo2TVe0ta519QT/pjCRs22tnaXTv27znhUk44dg+ShjWenTr03YagZns
         4dOZk95v2/AaFzPZ2E6XJuivM4C3toE4OaMwnLkzyo1jhEpqcrqKka1fN2/GZ370vejU
         zTL/+gdALRaImg53ZbO0+sZv9+152p7Klo/t6IA0m76AGpQebLAk02STgLkqFNrK/fO0
         881w==
X-Gm-Message-State: AC+VfDxwC563z9u5AVmnKaPScA5N/A/6YABa3J0Prnxn3/nY+gAQXAk0
        l+w0RLYs58tsuZn3lf9UFKPa3KpGMmqq+KvNky7reMTcFwU=
X-Google-Smtp-Source: ACHHUZ7dviQaJKE0zW3tnd2UvNT94P6kLYAxdblfOnapWxLnxdwt3C0ee0UDfEQmCiQFnVyYQe6y+AMUzBW5eQS36yI=
X-Received: by 2002:a17:906:64cd:b0:965:a6c1:9b96 with SMTP id
 p13-20020a17090664cd00b00965a6c19b96mr12226804ejn.2.1683655599579; Tue, 09
 May 2023 11:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com> <20230329100951.1522322-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20230329100951.1522322-2-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 May 2023 20:06:28 +0200
Message-ID: <CAJZ5v0gzSjDS16Sq9oAs_9BSEgmM6VPPFF4vrd2cyK++UP7=_w@mail.gmail.com>
Subject: Re: [PATCH v8 01/10] ACPI: scan: Remove the second DSDT traversal
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Collect the devices with _DEP into a list and continue processing them
> after a full traversal, instead of doing a full second traversal of the
> tree.
>
> This makes the second DSDT traversal pass unnecessary as we already have
> the nodes we're interested in in a linked list.

The second traversal of the ACPI namespace (it may not be just the
DSDT at that point to be precise) is not really about _DEP handling.
In fact, the latter has been added on top of it.

It is about the PCI enumeration.  Namely, when acpi_pci_root_add()
runs for the PCI host bridge object in the ACPI namespace, the entire
device hierarchy below it is walked and all of the ACPI device objects
corresponding to the PCI devices on the bus are assumed to be present.
This means that all of the ACPI device objects need to be created in
the first walk, without binding any ACPI drivers or scan handlers to
them, and the second walk is to find out what is actually represented
by those objects.

It cannot be eliminated in any simple way.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/scan.c | 125 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 92 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0c6f06abe3f4..280d12e0aa2f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2029,10 +2029,52 @@ static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
>         return count;
>  }
>
> -static bool acpi_bus_scan_second_pass;
> +/**
> + * struct acpi_postponed_handle - A postponed ACPI handle
> + * @list: Entry in a postponed list
> + * @handle: The postponed handle
> + *
> + * One such entry represents an ACPI handle the scanning of which has been
> + * postponed.
> + */
> +struct acpi_postponed_handle {
> +       struct list_head list;
> +       acpi_handle handle;
> +};
> +
> +/**
> + * struct acpi_scan_context - Context for scanning ACPI devices
> + * @postponed_head: The list head of the postponed ACPI handles
> + * @device: The first encountered device, typically the root of the scanned tree
> + */
> +struct acpi_scan_context {
> +       struct list_head postponed_head;
> +       struct acpi_device *device;
> +};
> +
> +/**
> + * acpi_bus_handle_postpone - Add an ACPI handle to a given postponed list
> + * @handle: The ACPI handle
> + * @head: Postponed list head
> + *
> + * Add a given ACPI handle to a list of ACPI objects for which the creation
> + * of the device objects is to be postponed.
> + */
> +static void acpi_bus_handle_postpone(acpi_handle handle,
> +                                    struct list_head *head)
> +{
> +       struct acpi_postponed_handle *ph;
> +
> +       ph = kzalloc(sizeof(*ph), GFP_KERNEL);
> +       if (!ph)
> +               return;
> +
> +       ph->handle = handle;
> +       list_add(&ph->list, head);
> +}
>
>  static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
> -                                     struct acpi_device **adev_p)
> +                                     struct acpi_scan_context *ctx)
>  {
>         struct acpi_device *device = acpi_fetch_acpi_dev(handle);
>         acpi_object_type acpi_type;
> @@ -2051,7 +2093,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>
>                 /* Bail out if there are dependencies. */
>                 if (acpi_scan_check_dep(handle, check_dep) > 0) {
> -                       acpi_bus_scan_second_pass = true;
> +                       acpi_bus_handle_postpone(handle, &ctx->postponed_head);
>                         return AE_CTRL_DEPTH;
>                 }
>
> @@ -2086,22 +2128,22 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>         acpi_scan_init_hotplug(device);
>
>  out:
> -       if (!*adev_p)
> -               *adev_p = device;
> +       if (!ctx->device)
> +               ctx->device = device;
>
>         return AE_OK;
>  }
>
>  static acpi_status acpi_bus_check_add_1(acpi_handle handle, u32 lvl_not_used,
> -                                       void *not_used, void **ret_p)
> +                                       void *ctx, void **unused)
>  {
> -       return acpi_bus_check_add(handle, true, (struct acpi_device **)ret_p);
> +       return acpi_bus_check_add(handle, true, (struct acpi_scan_context *)ctx);
>  }
>
>  static acpi_status acpi_bus_check_add_2(acpi_handle handle, u32 lvl_not_used,
> -                                       void *not_used, void **ret_p)
> +                                       void *ctx, void **device)
>  {
> -       return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
> +       return acpi_bus_check_add(handle, false, (struct acpi_scan_context *)ctx);
>  }
>
>  static void acpi_default_enumeration(struct acpi_device *device)
> @@ -2422,37 +2464,54 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
>   */
>  int acpi_bus_scan(acpi_handle handle)
>  {
> -       struct acpi_device *device = NULL;
> -
> -       acpi_bus_scan_second_pass = false;
> -
> -       /* Pass 1: Avoid enumerating devices with missing dependencies. */
> +       struct acpi_scan_context ctx = {
> +               .postponed_head = LIST_HEAD_INIT(ctx.postponed_head),
> +       };
> +       struct acpi_postponed_handle *ph, *tmp_ph;
> +       int ret = 0;
>
> -       if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &device)))
> +       if (ACPI_SUCCESS(acpi_bus_check_add(handle, true, &ctx)))
>                 acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> -                                   acpi_bus_check_add_1, NULL, NULL,
> -                                   (void **)&device);
> -
> -       if (!device)
> -               return -ENODEV;
> -
> -       acpi_bus_attach(device, (void *)true);
> +                                   acpi_bus_check_add_1, NULL, (void *)&ctx,
> +                                   NULL);
>
> -       if (!acpi_bus_scan_second_pass)
> -               return 0;
> -
> -       /* Pass 2: Enumerate all of the remaining devices. */
> +       if (!ctx.device) {
> +               ret = -ENODEV;
> +               goto out_release;
> +       }
>
> -       device = NULL;
> +       acpi_bus_attach(ctx.device, (void *)true);
>
> -       if (ACPI_SUCCESS(acpi_bus_check_add(handle, false, &device)))
> -               acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> -                                   acpi_bus_check_add_2, NULL, NULL,
> -                                   (void **)&device);
> +       /*
> +        * Proceed to register ACPI devices that were postponed due to _DEP
> +        * objects during the namespace walk.
> +        */
> +       list_for_each_entry_safe(ph, tmp_ph, &ctx.postponed_head, list) {
> +               list_del(&ph->list);
> +               /* Set device NULL here to obtain the root for this sub-tree. */
> +               ctx.device = NULL;
> +               /*
> +                * Do this manually, as the namespace walk will only include
> +                * sub-nodes, not the node itself. ctx.device is set to the
> +                * ACPI device corresponding ph->handle.
> +                */
> +               acpi_bus_check_add_2(ph->handle, 0, &ctx, NULL);
> +               /* Walk the rest of the sub-namespace. */
> +               acpi_walk_namespace(ACPI_TYPE_ANY, ph->handle, ACPI_UINT32_MAX,
> +                                   acpi_bus_check_add_2, NULL, (void *)&ctx,
> +                                   NULL);
> +               if (ctx.device)
> +                       acpi_bus_attach(ctx.device, NULL);
> +               kfree(ph);
> +       }
>
> -       acpi_bus_attach(device, NULL);
> +out_release:
> +       list_for_each_entry_safe(ph, tmp_ph, &ctx.postponed_head, list) {
> +               list_del(&ph->list);
> +               kfree(ph);
> +       }
>
> -       return 0;
> +       return ret;
>  }
>  EXPORT_SYMBOL(acpi_bus_scan);
>
> --
> 2.30.2
>
