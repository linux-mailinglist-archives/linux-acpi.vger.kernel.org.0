Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC8523B9B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 May 2022 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbiEKRd5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 May 2022 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345615AbiEKRd4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 May 2022 13:33:56 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5922317DB
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2022 10:33:53 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ebf4b91212so29448567b3.8
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2022 10:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7dm0GWjyiUWg2YyOf5WSae0ZFK+iyo6HqeiZX7Afdo=;
        b=RueWfiYw2WS5adp9B4gKGaFsHGpMJPYIDAHmr3aXGTs2IF4PS4anNUAAay6b38taqn
         sLnhUnowSLnEYKt3O8MYg72PDdOHWc3XmAi0QBCLtvn4hb2jCcGpfL+3adX+wFjryRNU
         aRCrkBNhAE7U8qWmR0tLEh6mia5b0vfJYkzFkF6LCCPy9Ec0r8QXFiVkCHbFTvMou+td
         H4ieiWWAZp8qrkiH/M85x/YTmeJesWVh+wCr3bqwfq6IP6uV9CF5Ei+vKO3jjjaAAJFf
         whUNNWfA9HyRsz2WTzvHqzrJBkzival9FOFSYEdfQOlE/kW8U/Yg/4fdLXc3521U0KAu
         XK+g==
X-Gm-Message-State: AOAM531cQgfDKs+xbBmqNCisFU0t/lFiTKwHqtWyo+6i8ItjuC338EIV
        nn84Osepbbnv63865OoO4Kuasr14/pZ43iZNV8o=
X-Google-Smtp-Source: ABdhPJwC2HWZWDnGGlj8RCDMDuR0yuTJYzJ+ubInszp2qDe2DHtqGk36h1l/fpsGkQmHxT6fCdeUyd3Rh+x55IvMyhg=
X-Received: by 2002:a0d:e645:0:b0:2f4:dbd6:261e with SMTP id
 p66-20020a0de645000000b002f4dbd6261emr26341879ywe.7.1652290433039; Wed, 11
 May 2022 10:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220511171754.avfrrqg6eihku55s@bsd-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220511171754.avfrrqg6eihku55s@bsd-mbp.dhcp.thefacebook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:33:42 +0200
Message-ID: <CAJZ5v0jHDNBqCfmgyLUOs7yUZaEjQ96m5HVZKHP3x7_uamH5zQ@mail.gmail.com>
Subject: Re: [PATCH]: Revert "ACPI: Remove side effect of partly creating a
 node in acpi_get_node()"
To:     Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Len Brown <lenb@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-team@fb.com
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

On Wed, May 11, 2022 at 7:24 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
>
> This reverts commit a62d07e0006a3a3ce77041ca07f3c488ec880790.
>
> The change calls pxm_to_node(), which ends up returning -1
> (NUMA_NO_NODE) on some systems for the pci bus, as opposed
> to the prior call to acpi_map_pxm_to_node(), which returns 0.
>
> The default numa node is then inherited by all pci devices, and is
> visible in /sys/bus/pci/devices/*/numa_node
>
> The prior behavior shows:
>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
>      122 0
>
> While the new behavior has:
>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
>        1 0
>      121 -1
>
> While arguably NUMA_NO_NODE is correct on single-socket systems which
> have only one numa domain, this breaks scripts that attempt to read the
> NIC numa_node and pass that to numactl in order to pin memory allocation
> when running applications (like iperf).  E.g.:
>
>   # numactl -p -1 iperf3
>   libnuma: Warning: node argument -1 is out of range
>   <-1> is invalid
>
> Reverting this change restores the prior behavior.

Well, that's not a recent commit and it fixed a real and serious issue.

Isn't there a way to fix this other than reverting it?

>
> Signed-off-by: Jonathan Lemon <jonathan.lemon@gmail.com>
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 3b818ab186be..f150c5c1d0a8 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -564,6 +564,6 @@ int acpi_get_node(acpi_handle handle)
>
>         pxm = acpi_get_pxm(handle);
>
> -       return pxm_to_node(pxm);
> +       return acpi_map_pxm_to_node(pxm);
>  }
>  EXPORT_SYMBOL(acpi_get_node);
> --
> 2.30.2
>
