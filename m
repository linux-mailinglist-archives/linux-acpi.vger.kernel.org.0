Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF352A7CA
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 18:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347553AbiEQQV6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350852AbiEQQV5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 12:21:57 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A13B023
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2022 09:21:56 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id o130so17734002ybc.8
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2022 09:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvleERSawxplffshiaVSIMQjlXqAyLMjM5BckhxYrjw=;
        b=ivbZioX+GDtLybg2fffHi70EGKC36b4r6+/ofhHpgK71P4JJyidQf2xU0mH6v9IQ9f
         775oAswGosfhBj/y3/8YEleJhImA9DjgKml0DS9oVVt9tq2pfIjSohkfkHxnwtQATvY9
         oJ855TSo63ZMBKrvhUo2k6thmJMQj2zpwA6PgRNW4/wQ5VmDnCDREhB4WTO0xBK31hdE
         GMQkMoA8gvgEkJlDoApA1l25t6Vq34KIPi7VyuehwIM26raldajbd3PqNc0tr+s8RBdR
         ACpgOmJDCyy2v04AQ/XB6XVos6VPspq5fSoMjCaYz2bQkqv/i6FP0kYGfZ/QeTH4s7BX
         NqaA==
X-Gm-Message-State: AOAM531asMESYBAJ9CegBQBOHEsKqhdUBBXe3B6fxRCtOR/vYDJJhR9v
        VikQCFGFY6CBM4e5bdtQEd7zouY+wUyyKub8abo=
X-Google-Smtp-Source: ABdhPJxqzvO/ig6U0TVqK+YipaVTNsi1Wa9RbZ7pgC5o9XQnAL74qBTZciWm62RfXpygQvd9wJHwmUVCkGHaDntiAQ4=
X-Received: by 2002:a25:c6:0:b0:64d:8a54:d45c with SMTP id 189-20020a2500c6000000b0064d8a54d45cmr13677345yba.153.1652804515824;
 Tue, 17 May 2022 09:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com> <20220506130025.984026-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20220506130025.984026-3-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 May 2022 18:21:44 +0200
Message-ID: <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
Subject: Re: [PATCH 02/11] ACPI: acpica: Constify pathname argument for acpi_get_handle()
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
> acpi_get_handle() uses the pathname argument to find a handle related to
> that pathname but it does not need to modify it. Make it const, in order
> to be able to pass const pathname to it.
>
> Cc: "Moore, Robert" <robert.moore@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Which patches in the rest of the series depend on this one?

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
> 2.30.2
>
