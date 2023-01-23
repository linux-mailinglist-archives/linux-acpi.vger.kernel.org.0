Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7379E67819E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 17:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAWQiA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 11:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjAWQh7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 11:37:59 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD3420D;
        Mon, 23 Jan 2023 08:37:58 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id x5so10095472qti.3;
        Mon, 23 Jan 2023 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Un6j84Aq5B2YVIzsvjfTdmzyQzWTAnCkNbOGaJGvxho=;
        b=bZHagwl2EY/HXvei+d3RKzviJR776Uywe5bej8X9WeLHiIEiaHrxZMDqXeN1XjzkNC
         0AWt0WYqUOEF6atvwfD4M/jS/vnwie+7blhLgAaUjC0M7ohJUo7II1ADvbOPQgNHJKS6
         7HhtdoHFs6wjMwNajN/pPUdJiB9ulIHVmTbQflnU7hejQDJ78Sl4LQoyjSzD7Q/15Bqv
         iKJPOjp2OY8H6ZnK4KcSvYjE5wtcA/wFzW8pvwSdXjlsO9aJ9p/vaJWBzoOgXan187EJ
         0nJDCXxgIYdxMFaL4lt9+vZKjL12biD5zRHhja8E36MgnZC0ttum+U8HXJhxYmIerHUW
         u5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Un6j84Aq5B2YVIzsvjfTdmzyQzWTAnCkNbOGaJGvxho=;
        b=e1oWokzMPz5UHbwUlLGdFHx1a5LDKnuD/dWJczVcEyhZdmoDePwBlqLKzztIKvu3qM
         J3Xuon9KtJnL3EhGyQ+o9flnnm+SHGnj8BVBPpQTtV2IIG/awW5PKjWG4MQXaDgH24mL
         zfjQelmiOfhw7qFQ6pkdnNb5JYdvYlHMTK1nLQijb2riSauj2MkP5qWuBH4XIotULdNn
         3onncT0JnjWNkQE2ERXB66CblLd2sdOxc8nEk/IIKQT4VRKrEDue7ht/e7/2HYWu5VSO
         wADlQqgOCK10nu1pwZtSRHDaSO8pfok4BqZ8tG6ozgn4M4SQ07bz+jG7IrZiTne5d6VO
         EKIw==
X-Gm-Message-State: AFqh2kqpJueHcWGlhGdCazoDOPJP/Cm9RlWfrYdUUZvzft+o2HLRXg3T
        dUpm21gQpg2Q0pRp+L6UdPVM1s4+WyZj1AK17OE=
X-Google-Smtp-Source: AMrXdXvAv+Ncw2av8f7LAh2K7NA6Na83mn/i7JR7DN7EnjDEJh797mWrMn/iI+26oZQK4lnKukAzLnG121OosoBu/Y0=
X-Received: by 2002:ac8:7455:0:b0:3b6:2b38:e076 with SMTP id
 h21-20020ac87455000000b003b62b38e076mr1285233qtr.384.1674491877333; Mon, 23
 Jan 2023 08:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20230123113750.462144-1-hdegoede@redhat.com> <20230123113750.462144-4-hdegoede@redhat.com>
In-Reply-To: <20230123113750.462144-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Jan 2023 18:37:21 +0200
Message-ID: <CAHp75VeKfVVxfcWkiz1oHigryNNAy1PZYbbfh+OycViODV-jHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: video: Fix apple gmux detection
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Mark Gross <mgross@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 1:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Some apple laptop models have an ACPI device with a HID of APP000B
> and that device has an IO resource (so it does not describe the new
> unsupported MMIO based gmux type), but there actually is no gmux
> in the laptop at all.
>
> The gmux_probe() function of the actual apple-gmux driver has code
> to detect this, this code has been factored out into a new
> apple_gmux_detect() helper in apple-gmux.h.
>
> Use this new function to fix acpi_video_get_backlight_type() wrongly
> returning apple_gmux as type on these new laptops.

...

> -static bool apple_gmux_backlight_present(void)
> -{
> -       struct acpi_device *adev;
> -       struct device *dev;
> -
> -       adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
> -       if (!adev)
> -               return false;
> -
> -       dev = acpi_get_first_physical_node(adev);
> -       if (!dev)
> -               return false;
> -
> -       /*
> -        * drivers/platform/x86/apple-gmux.c only supports old style
> -        * Apple GMUX with an IO-resource.
> -        */
> -       return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
> -}

Oh, the leak is already somewhere... Lemme cook a patch...

-- 
With Best Regards,
Andy Shevchenko
