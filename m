Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC615353D7
	for <lists+linux-acpi@lfdr.de>; Thu, 26 May 2022 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348704AbiEZTTb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 May 2022 15:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348719AbiEZTTa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 May 2022 15:19:30 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F72980C
        for <linux-acpi@vger.kernel.org>; Thu, 26 May 2022 12:19:29 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ef5380669cso25763227b3.9
        for <linux-acpi@vger.kernel.org>; Thu, 26 May 2022 12:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgXAO40gBIUu1WUEitfXKOQleyYY2QlsEz9jRKAKfEM=;
        b=31idHmDXSJWh+qJuLyiI+tUVS8SgEGWnuQDiZK+7qUYqWq5E/+sNsOiGROvxGW4DSA
         egsLCmmu443+o8QpgTX16y5oRCsJwSMmfclrRL7JZEvBXvvgbNeyWC6joFaMRU4Mrnfi
         29/eutgdd/Mg/bmVamF/fCRWrADt8q2bO9TTcr7FfTEIPXB5MtoP48vDfR5Kjc2Q7Ll7
         PyegcIw7zXvtHCpDQRpECnVYeOdFQeYJFSTHxX/+JTP2eNBYeHAviOWe8tynVgmOh0Dg
         d6duyfhg6sTNV0P04DCFasKE9upRkBzzXBB1LJVNWTMDGfXUeoFPHTReMNyhr8a7kfZX
         OOHg==
X-Gm-Message-State: AOAM531L3PZexiyPJNvFgltgtXGZMXPtHqXXC+bpAHY55aEXRXf2UW0p
        QRE4PFHgSt1FPpXTQ0bWuKh/Xa3ETrQ7eSTnQtzwurOD
X-Google-Smtp-Source: ABdhPJyStcz0BCiDJHyEn6Fd9ODy2pVez1ESnH1qgNfaBLGtUgvxQnV374PGU3VqeTMztgwbbjznN39ASx+f/NZbrnc=
X-Received: by 2002:a0d:c442:0:b0:2fe:beab:1fef with SMTP id
 g63-20020a0dc442000000b002febeab1fefmr41387396ywd.196.1653592769022; Thu, 26
 May 2022 12:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com> <20220525130123.767410-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20220525130123.767410-3-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 May 2022 21:19:17 +0200
Message-ID: <CAJZ5v0jrFQk2aH78Fg=W+6KAzhony3yZ+NjYy8ki5atKoaPwLw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] ACPI: property: Tie data nodes to acpi handles
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

On Wed, May 25, 2022 at 3:01 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> ACPICA allows associating additional information (i.e. pointers with
> specific tag) to acpi_handles. The acpi_device's are associated to
> acpi_handle's in acpi_tie_acpi_dev() in scan.c, do the same here for the
> _DSD data nodes.
>
> This allows direct data node references in properties, implemented later on
> in the series.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 42 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index bc9a645f8bb77..f8c83ee6c8d59 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -340,6 +340,43 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
>         return props;
>  }
>
> +static void acpi_nondev_subnode_tag(acpi_handle handle, void *context)
> +{
> +}
> +
> +static void acpi_untie_nondev_subnodes(struct acpi_device_data *data)
> +{
> +       struct acpi_data_node *dn;
> +
> +       list_for_each_entry(dn, &data->subnodes, sibling) {
> +               acpi_detach_data(dn->handle, acpi_nondev_subnode_tag);
> +
> +               acpi_untie_nondev_subnodes(&dn->data);
> +       }
> +}
> +
> +static int acpi_tie_nondev_subnodes(struct acpi_device_data *data)
> +{
> +       struct acpi_data_node *dn;
> +
> +       list_for_each_entry(dn, &data->subnodes, sibling) {
> +               acpi_status status;
> +               int ret;
> +
> +               status = acpi_attach_data(dn->handle, acpi_nondev_subnode_tag, dn);
> +               if (ACPI_FAILURE(status)) {
> +                       acpi_handle_err(dn->handle, "Can't tag data node\n");
> +                       return 0;
> +               }
> +
> +               ret = acpi_tie_nondev_subnodes(&dn->data);
> +               if (ret)
> +                       return ret;

Is it actually possible that this returns anything different from 0?

> +       }
> +
> +       return 0;
> +}
> +
>  static bool acpi_extract_properties(const union acpi_object *desc,
>                                     struct acpi_device_data *data)
>  {
> @@ -419,7 +456,9 @@ void acpi_init_properties(struct acpi_device *adev)
>                                         &adev->data, acpi_fwnode_handle(adev)))
>                 adev->data.pointer = buf.pointer;
>
> -       if (!adev->data.pointer) {
> +       if (!adev->data.pointer ||
> +           acpi_tie_nondev_subnodes(&adev->data) < 0) {
> +               acpi_untie_nondev_subnodes(&adev->data);
>                 acpi_handle_debug(adev->handle, "Invalid _DSD data, skipping\n");
>                 ACPI_FREE(buf.pointer);
>         }
> @@ -462,6 +501,7 @@ static void acpi_destroy_nondev_subnodes(struct list_head *list)
>
>  void acpi_free_properties(struct acpi_device *adev)
>  {
> +       acpi_untie_nondev_subnodes(&adev->data);
>         acpi_destroy_nondev_subnodes(&adev->data.subnodes);
>         ACPI_FREE((void *)adev->data.pointer);
>         adev->data.of_compatible = NULL;
> --
> 2.30.2
>
