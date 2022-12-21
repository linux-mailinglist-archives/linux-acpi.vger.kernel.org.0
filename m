Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13AB6531F4
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Dec 2022 14:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiLUNoY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Dec 2022 08:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiLUNoC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2022 08:44:02 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7E205C6
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 05:44:01 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id h21so965556qta.12
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 05:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6V6MFF4GuQ6vkVyBo2yDS0+z86doJi/2sZ+scXoSYe0=;
        b=bDWBiDYZsguTp9YpnfVW6Wm01b3p7ZPZ7F55a0eKqz+USm3Hml57Z4bnstxyOTiDls
         wMGwibeQCxmXduyEDTeFe9I/RFZNWRuZKWP6CmbxTY01e6qUlmwoHB4gDx9BDSsvz19d
         6hEEzm5guUinJWBGfIMIrCNbCFQS5M/KpA2cGepsM5OD3AG5xPH3pTJ7Yn3V7qGlZnRV
         RJCe7mUx5Q950GJZ5JaNG5W4l9ylMOLUHIC1rr3P0/xul8lQBc/FbC3CfnWI07eN67VF
         KDbEEDoThcvL7/FVSSOdxoJ/A9zGMY38/SpO0lQoKU3Y+LlAyPqlQFkkpLdo5qe1DDKM
         MSfg==
X-Gm-Message-State: AFqh2kqGE09lSPaP69vt7Wn+W8Vh5U12Pt6GT/9u733lw35pSrjfYvBg
        jIaRVcRiLIwa7DDTUIH2f0m8Et3y3m0GCZlM94f8h/iZ
X-Google-Smtp-Source: AMrXdXv2kXti4tp1VwGO+7z4kBpB1JiEpEco3+LA9PnAFnrmLI9XguI9pz/EY2qQ2tiuOHD6vjaMENj6r2OrOQ4dvPw=
X-Received: by 2002:a05:622a:4d98:b0:3a8:10c3:2b2d with SMTP id
 ff24-20020a05622a4d9800b003a810c32b2dmr35748qtb.357.1671630240659; Wed, 21
 Dec 2022 05:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20221220150126.1624988-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20221220150126.1624988-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Dec 2022 14:43:47 +0100
Message-ID: <CAJZ5v0gdFdPjAc-aLZBDJAkZ1jjGdigBjX9RzWwTdokH_sCwhw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: acpica: Constify pathname argument for acpi_get_handle()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Moore, Robert" <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 20, 2022 at 4:01 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> acpi_get_handle() uses the pathname argument to find a handle related to
> that pathname but it does not need to modify it. Make it const, in order
> to be able to pass const pathname to it.
>
> Cc: "Moore, Robert" <robert.moore@intel.com>
> Link: https://github.com/acpica/acpica/pull/773
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/acpica/nsxfname.c | 2 +-
>  include/acpi/acpixf.h          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
> index b2cfdfef31947..a0592d15dd37c 100644
> --- a/drivers/acpi/acpica/nsxfname.c
> +++ b/drivers/acpi/acpica/nsxfname.c
> @@ -44,7 +44,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
>
>  acpi_status
>  acpi_get_handle(acpi_handle parent,
> -               acpi_string pathname, acpi_handle *ret_handle)
> +               const char *pathname, acpi_handle *ret_handle)
>  {
>         acpi_status status;
>         struct acpi_namespace_node *node = NULL;
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 67c0b9e734b64..085f23d833349 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -526,7 +526,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>                                            struct acpi_buffer *ret_path_ptr))
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>                              acpi_get_handle(acpi_handle parent,
> -                                            acpi_string pathname,
> +                                            const char *pathname,
>                                              acpi_handle *ret_handle))
>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>                              acpi_attach_data(acpi_handle object,
> --

I'll queue up this one for 6.3 early next week, thanks!
