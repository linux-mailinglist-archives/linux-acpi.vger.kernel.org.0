Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6760DFF1
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Oct 2022 13:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiJZLrY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Oct 2022 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiJZLq6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2022 07:46:58 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E001DD898
        for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2022 04:46:08 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id bb5so9611486qtb.11
        for <linux-acpi@vger.kernel.org>; Wed, 26 Oct 2022 04:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUH8BqzWUjJbOOxmErlK34OXLauv2M7RG16+2GIrCZU=;
        b=cD3yZXqBARgKxZGvXuYIL1c29zlil13b5Knl+DqJAuOIOv/pGR1Zl+ckpDNgJ+aj7W
         31n8nVzslInihkF1fiwZk+r0L7w3bLuVVGs56XAFVW684imWuyAZtInNzE5UXkUO2TbP
         uqpR8GoM8v99OncNzgHWTV4QJPLxx0GUBr2L3nIK7ssiNC3WRz7LHwyqfErm+w/YkGk+
         dek7e2SKgns76r6Zop52eKNPvOSjFQy3QdgNVzAFHvaSDh5MdU16aRM83vYkWpzRX/wU
         hNORPbj1G4tpPy3cSg9l1XuiSy3VQDOFQhBQCyv9/acIg/wb8Kz4FdJOjpyJf22Z6kMT
         KQng==
X-Gm-Message-State: ACrzQf0iIhP/18O3OQSHX6+0XKHMWDkSH9vXxwuue3hg1uZZg7bB9GIK
        /QI7tquWSCLinj7RFGqTj1paxjmn3vCiRgOYfE3Q+E2g
X-Google-Smtp-Source: AMsMyM784M55CY41sghYlddUPpmgm158J7sBaS0/R9EsQMXE8bH8igYH0JcKhwfwn8AoZSgdaqqYHXhwrm5fnWUs4As=
X-Received: by 2002:a05:622a:1750:b0:39a:82aa:f4ab with SMTP id
 l16-20020a05622a175000b0039a82aaf4abmr35969323qtk.411.1666784767928; Wed, 26
 Oct 2022 04:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221025121223.420680-1-hdegoede@redhat.com>
In-Reply-To: <20221025121223.420680-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Oct 2022 13:45:56 +0200
Message-ID: <CAJZ5v0in1=JLLgDZ-zdZ+Ar3D9duEppmsFFvGHp_fMFfwXtD+w@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Add LATT2021 to acpi_ignore_dep_ids[]
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 25, 2022 at 2:12 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some x86/ACPI laptops with MIPI cameras have a LATT2021 ACPI device
> in the _DEP dependency list of the ACPI devices for the camera-sensors
> (which have flags.honor_deps set).
>
> The _DDN for the LATT2021 device is "Lattice FW Update Client Driver",
> suggesting that this is used for firmware updates of something. There
> is no Linux driver for this and if Linux gets support for updates it
> will likely be in userspace through fwupd.
>
> For now add the LATT2021 HID to acpi_ignore_dep_ids[] so that
> acpi_dev_ready_for_enumeration() will return true once the other _DEP
> dependencies are met.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Improve the commit message a bit (some sentences were mangled a bit
>   during editing)
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 024cc373a197..b47e93a24a9a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -789,6 +789,7 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
>  static const char * const acpi_ignore_dep_ids[] = {
>         "PNP0D80", /* Windows-compatible System Power Management Controller */
>         "INT33BD", /* Intel Baytrail Mailbox Device */
> +       "LATT2021", /* Lattice FW Update Client Driver */
>         NULL
>  };
>
> --

Applied as 6.1-rc material, thanks!
