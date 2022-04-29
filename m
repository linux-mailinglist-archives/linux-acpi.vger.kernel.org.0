Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105D3515920
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Apr 2022 01:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiD2XtY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Apr 2022 19:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381657AbiD2XtX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Apr 2022 19:49:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B049AE6C
        for <linux-acpi@vger.kernel.org>; Fri, 29 Apr 2022 16:46:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kq17so18122528ejb.4
        for <linux-acpi@vger.kernel.org>; Fri, 29 Apr 2022 16:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLnQzeeY+30Hbm9Yw7xfSR/sboSsBplmCvkRsDvNapQ=;
        b=aaMlNIz+kvjrqzRA+TmMPrr9z/agjC6uZDS/7LzDLGLKOi4ApEf1uA0dLxxujTYIg2
         k4csVTi1/t6S9EQJ3MIRmwGXdjodr4WNvGYWb19StfFpvduYW0wOVdmF/rnYnGBpmY5I
         u6UNjR+DrO8IcvxvoMkhAexM4ekx78OnlEKgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLnQzeeY+30Hbm9Yw7xfSR/sboSsBplmCvkRsDvNapQ=;
        b=7VXa4qf27C6PCof6UaTKaZXGiutBMmVhyF9lT7znQst1NI7+qIES8tAd+h3dGI5tHC
         bVPfjv+JXi0alvDzqG8N4Z+ODe0lB8KiVP5iSA/ZjNFsz5zcNDZT4SSKwOF4dFAcfr5q
         nz1Rhw1bOUlLgoNjPAwgDR0Zp2IN+3toNmnAgZO1UPjHzXikvmYPzZjYLEUhOnMb7mV3
         oaSdkEAOF9niI6A7AZCFAgfdtV2MvRhWnVPJtpOnqA4zf11Hn1tCNmeyws3564BZ2Yad
         /Vq289HyRP/JIyLeKbBAt6iQv18MrGvqZnUwSAxgF7acgz19wWlZvBJRKHuGE1DnJnGc
         wR4A==
X-Gm-Message-State: AOAM5313Lsl5QiDt53oYKFstW3z12r6S0w3cENK6JaegCGOHhDHdQ1Fn
        9+IvfLDxBRceoP7B3uc82b/Y+CdXtdWjfoOe
X-Google-Smtp-Source: ABdhPJzbR5sn+pauwqX3OIGb4tGbJ93Ek3WL15sh2o2LWXC4F11LneVmfaEMBThmV9y7hFf7oOIo7w==
X-Received: by 2002:a17:907:60cc:b0:6da:9616:ecec with SMTP id hv12-20020a17090760cc00b006da9616ececmr1693182ejc.298.1651275961410;
        Fri, 29 Apr 2022 16:46:01 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0042617ba6396sm3502882edr.32.2022.04.29.16.46.00
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 16:46:00 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id e2so12602963wrh.7
        for <linux-acpi@vger.kernel.org>; Fri, 29 Apr 2022 16:46:00 -0700 (PDT)
X-Received: by 2002:a5d:64eb:0:b0:20a:ecf8:ac9f with SMTP id
 g11-20020a5d64eb000000b0020aecf8ac9fmr1038404wri.342.1651275960111; Fri, 29
 Apr 2022 16:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com> <20220408184844.22829-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220408184844.22829-2-andriy.shevchenko@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Apr 2022 16:45:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UqGw3mQHXZvxwtJ4n085s3gXNKwaPeOiKVuMqRTyO0Lw@mail.gmail.com>
Message-ID: <CAD=FV=UqGw3mQHXZvxwtJ4n085s3gXNKwaPeOiKVuMqRTyO0Lw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] device property: Introduce fwnode_for_each_parent_node()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Fri, Apr 8, 2022 at 11:50 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In a few cases the functionality of fwnode_for_each_parent_node()
> is already in use. Introduce a common helper macro for it.
>
> It may be used by others as well in the future.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> v6: added tag (Sakari)
>  drivers/base/property.c  | 56 +++++++++++++++++++++-------------------
>  include/linux/property.h |  9 +++++--
>  2 files changed, 36 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 6ecc1398b0ba..f0ac31d28798 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -596,17 +596,17 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
>   */
>  struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
>  {
> +       struct fwnode_handle *parent;
>         struct device *dev;
>
> -       fwnode_handle_get(fwnode);
> -       do {
> -               fwnode = fwnode_get_next_parent(fwnode);
> -               if (!fwnode)
> -                       return NULL;
> +       fwnode_for_each_parent_node(fwnode, parent) {
>                 dev = get_dev_from_fwnode(fwnode);

Breadcrumbs in case anyone else ends up at this patch due to a bisect,
like I just did. The above should have been changed to
"get_dev_from_fwnode(parent);" in this patch. Fix posted at:

https://lore.kernel.org/r/20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid
