Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394354F44D1
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 00:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiDEOqr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiDEOE4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 10:04:56 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2190A154726;
        Tue,  5 Apr 2022 05:58:02 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id z33so18674800ybh.5;
        Tue, 05 Apr 2022 05:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVilzoYkYhuS9NBlsNW/Rf3/19+leGlmmW3jKbu7CMg=;
        b=xoTG0BxWqaPSnsSv1Q1C+jhuzJllNGsSDaO26oVqHyuw/9I1od8h8STMOVebCKweXC
         VjIuZ0Qcpfql+4AqLFXRCOUOGFSWbNFTlGLH/B2+Odmj3AqtPnd4OOJYzGQjSCjFLQTT
         y1AsGzgO397Csrel/MaPG7+KtW7ezvhfwCYBLGOwPNGHYtn7w4m6PShCGQJv8TyZrgzu
         jw4JnvDzjvDRjpOFJQiDsOv75YuqmQ/NStSNkVfLZ7lFDp92lGwt8C22eXmXkPa1sF+1
         r38tkNN+SDhY1kT0nUSJs9kvucq7+W794HAtBHI5ISUUvSCEvQ5axSVPz/5yeP5BsUDo
         DKUQ==
X-Gm-Message-State: AOAM5337DrgKQqSUW81UnwsHzUSSW/mIlrg4CtMEigQLBuGIVmYsx/3p
        YQ5uqW1Q8CsBHRDLOSyzpYj+grFfMpcXEfrdGLA=
X-Google-Smtp-Source: ABdhPJwj3BR3DyOHkLyQZUaC2qStkhHS6hJ6c81qhNVQfk7N3KCMY4XnGE1YnzyKRRMV1QCHr6Ukb1fMl1Infj6TkgY=
X-Received: by 2002:a25:9d8a:0:b0:633:9668:c48a with SMTP id
 v10-20020a259d8a000000b006339668c48amr2488266ybp.153.1649163481315; Tue, 05
 Apr 2022 05:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220327161344.50477-1-djrscally@gmail.com> <20220327161344.50477-2-djrscally@gmail.com>
In-Reply-To: <20220327161344.50477-2-djrscally@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 14:57:50 +0200
Message-ID: <CAJZ5v0i2ciLHP-=8eQcZc0v0xCzhKHKpxLC=Kgv6W5E_5=HQJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ACPI: scan: Add acpi_dev_get_next_consumer_dev()
To:     Daniel Scally <djrscally@gmail.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Robert Moore <robert.moore@intel.com>
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

On Sun, Mar 27, 2022 at 6:13 PM Daniel Scally <djrscally@gmail.com> wrote:
>
> In commit b83e2b306736 ("ACPI: scan: Add function to fetch dependent
> of ACPI device") we added a means of fetching the first device to
> declare itself dependent on another ACPI device in the _DEP method.
> One assumption in that patch was that there would only be a single
> consuming device, but this has not held.
>
> Replace that function with a new function that fetches the next consumer
> of a supplier device. Where no "previous" consumer is passed in, it
> behaves identically to the original function.
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>
> ---
> Changes in v2:
>
>         - Removed acpi_dev_get_first_consumer_dev() entirely
>
>  drivers/acpi/scan.c                         | 37 +++++++++++++++------
>  drivers/platform/x86/intel/int3472/common.c |  2 +-
>  include/acpi/acpi_bus.h                     |  4 ++-
>  3 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 010ef0b28374..8797e4a33674 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2215,9 +2215,21 @@ static void acpi_bus_attach(struct acpi_device *device, bool first_pass)
>                 device->handler->hotplug.notify_online(device);
>  }
>
> -static int acpi_dev_get_first_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
> +static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *data)
>  {
> -       struct acpi_device *adev;
> +       struct acpi_device *adev = *(struct acpi_device **)data;

I would prefer

struct acpi_device **adev_p = data;
struct acpi_device *adev = *adev_p;

> +
> +       /*
> +        * If we're passed a 'previous' consumer device then we need to skip
> +        * any consumers until we meet the previous one, and then NULL @data
> +        * so the next one can be returned.
> +        */
> +       if (adev) {
> +               if (dep->consumer == adev->handle)
> +                       *(struct acpi_device **)data = NULL;

                      *adev_p = NULL;

> +
> +               return 0;
> +       }
>
>         adev = acpi_bus_get_acpi_device(dep->consumer);
>         if (adev) {
> @@ -2348,25 +2360,28 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>
>  /**
> - * acpi_dev_get_first_consumer_dev - Return ACPI device dependent on @supplier
> + * acpi_dev_get_next_consumer_dev - Return the next adev dependent on @supplier
>   * @supplier: Pointer to the dependee device
> + * @start: Pointer to the current dependent device
>   *
> - * Returns the first &struct acpi_device which declares itself dependent on
> + * Returns the next &struct acpi_device which declares itself dependent on
>   * @supplier via the _DEP buffer, parsed from the acpi_dep_list.
>   *
> - * The caller is responsible for putting the reference to adev when it is no
> - * longer needed.
> + * If the returned adev is not passed as @start to this function, the caller is
> + * responsible for putting the reference to adev when it is no longer needed.
>   */
> -struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier)
> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
> +                                                  struct acpi_device *start)
>  {
> -       struct acpi_device *adev = NULL;
> +       struct acpi_device *adev = start;
>
>         acpi_walk_dep_device_list(supplier->handle,
> -                                 acpi_dev_get_first_consumer_dev_cb, &adev);
> +                                 acpi_dev_get_next_consumer_dev_cb, &adev);
>
> -       return adev;
> +       acpi_dev_put(start);
> +       return adev == start ? NULL : adev;

And here

if (adev == start)
        return NULL;

return adev;

>  }
> -EXPORT_SYMBOL_GPL(acpi_dev_get_first_consumer_dev);
> +EXPORT_SYMBOL_GPL(acpi_dev_get_next_consumer_dev);
>
>  /**
>   * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
> diff --git a/drivers/platform/x86/intel/int3472/common.c b/drivers/platform/x86/intel/int3472/common.c
> index 77cf058e4168..9db2bb0bbba4 100644
> --- a/drivers/platform/x86/intel/int3472/common.c
> +++ b/drivers/platform/x86/intel/int3472/common.c
> @@ -62,7 +62,7 @@ int skl_int3472_get_sensor_adev_and_name(struct device *dev,
>         struct acpi_device *sensor;
>         int ret = 0;
>
> -       sensor = acpi_dev_get_first_consumer_dev(adev);
> +       sensor = acpi_dev_get_next_consumer_dev(adev, NULL);
>         if (!sensor) {
>                 dev_err(dev, "INT3472 seems to have no dependents.\n");
>                 return -ENODEV;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 2f93ecf05dac..cdc726d251b6 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -696,7 +696,9 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const ch
>
>  void acpi_dev_clear_dependencies(struct acpi_device *supplier);
>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
> -struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
> +struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
> +                                                  struct acpi_device *start);
> +
>  struct acpi_device *
>  acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
>  struct acpi_device *
> --
> 2.25.1
>
