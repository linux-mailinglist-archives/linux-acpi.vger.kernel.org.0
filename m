Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D435595F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhDFQkk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 12:40:40 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43005 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDFQkj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2021 12:40:39 -0400
Received: by mail-ot1-f52.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so14732422otr.9;
        Tue, 06 Apr 2021 09:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4Pxz8eQS4z/anoMDxcMYg0CMeoybJwFEHBQkyZRVlE=;
        b=NwYB8bwFibQ/UYGVbUE/O/mvbtvU5btwU3L+XamuX9svgHuFzjpTypDjzNCyeeKZE+
         q0A+qpUYfgzOsbvojvlJphisJDSF/EAkT4JnClzYgLp/ypccSP27/sD2FK5X3O0T+pFx
         u5KWxmD2Mg/OqUaVV1ypZyYzfLmY/w5MXai9nX+7OEmCqHJiJjNmpyo8dYKp6KDDxrej
         l766rIE56uUi+7seu1ltnwRMEcvOrNdotdsEAfJdQ4qP0pGInxDpvOY8xGrnuauOa5k0
         Lc0nYpGlPMTe/uIEhKlx6miXFwrNVlZHQDjGrtc07910HJQZkYL+rt1H/fpr3auK9gAO
         AOXQ==
X-Gm-Message-State: AOAM530B9N8OI7ERSo8zPFJhJ9TkO9iVEyMf+Wr7JvpTSrfCvXXX1mqv
        AIq9paHOJxoCG2ETSSZXNX5c1FpYAsVjnaNWUS4oBLth52E=
X-Google-Smtp-Source: ABdhPJzjEv/CKKmsBVnQ65Xz+D9PLnMYm7r3nNWaEx1H8YNdxV21Xq53ss1IQWbN/qP75roRv7aKZn34lTyfVfwdyiQ=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr28273387otf.206.1617727230873;
 Tue, 06 Apr 2021 09:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <845f6ef8-d2a7-e491-8405-9526e4ba277a@huawei.com>
In-Reply-To: <845f6ef8-d2a7-e491-8405-9526e4ba277a@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Apr 2021 18:40:19 +0200
Message-ID: <CAJZ5v0gRm+jsd1KtLtSgT=4pc9oab=EtW=zqBuKjHLJ=ZcUkiA@mail.gmail.com>
Subject: Re: [bug report] Memory leak from acpi_ev_install_space_handler()
To:     John Garry <john.garry@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 6, 2021 at 5:51 PM John Garry <john.garry@huawei.com> wrote:
>
> Hi guys,
>
> On next-20210406, I enabled CONFIG_DEBUG_KMEMLEAK and
> CONFIG_DEBUG_TEST_DRIVER_REMOVE for my arm64 system, and see this:

Why exactly do you think that acpi_ev_install_space_handler() leaks memory?

> root@debian:/home/john# more /sys/kernel/debug/kmemleak
> unreferenced object 0xffff202803c11f00 (size 128):
> comm "swapper/0", pid 1, jiffies 4294894325 (age 337.524s)
> hex dump (first 32 bytes):
> 00 00 00 00 02 00 00 00 08 1f c1 03 28 20 ff ff............( ..
> 08 1f c1 03 28 20 ff ff 00 00 00 00 00 00 00 00....( ..........
> backtrace:
> [<00000000670a0938>] slab_post_alloc_hook+0x9c/0x2f8
> [<00000000a3f47b39>] kmem_cache_alloc+0x198/0x2a8
> [<000000002bdba864>] acpi_os_create_semaphore+0x54/0xe0
> [<00000000bcd513fe>] acpi_ev_install_space_handler+0x24c/0x300
> [<0000000002e116e2>] acpi_install_address_space_handler+0x64/0xb0
> [<00000000ba00abc5>] i2c_acpi_install_space_handler+0xd4/0x138
> [<000000008da42058>] i2c_register_adapter+0x368/0x910
> [<00000000c03f7142>] i2c_add_adapter+0x9c/0x100
> [<0000000000ba2fcf>] i2c_add_numbered_adapter+0x44/0x58
> [<000000007df22d67>] i2c_dw_probe_master+0x68c/0x900
> [<00000000682dfc98>] dw_i2c_plat_probe+0x460/0x640
> [<00000000ad2dd3ee>] platform_probe+0x8c/0x108
> [<00000000dd183e3f>] really_probe+0x190/0x670
> [<0000000066017341>] driver_probe_device+0x8c/0xf8
> [<00000000c441e843>] device_driver_attach+0x9c/0xa8
> [<00000000f91dc709>] __driver_attach+0x88/0x138
> unreferenced object 0xffff00280452c100 (size 128):
> comm "swapper/0", pid 1, jiffies 4294894558 (age 336.604s)
> hex dump (first 32 bytes):
> 00 00 00 00 02 00 00 00 08 c1 52 04 28 00 ff ff..........R.(...
> 08 c1 52 04 28 00 ff ff 00 00 00 00 00 00 00 00..R.(...........
> backtrace:
> [<00000000670a0938>] slab_post_alloc_hook+0x9c/0x2f8
> [<00000000a3f47b39>] kmem_cache_alloc+0x198/0x2a8
> [<000000002bdba864>] acpi_os_create_semaphore+0x54/0xe0
> [<00000000bcd513fe>] acpi_ev_install_space_handler+0x24c/0x300
> [<0000000002e116e2>] acpi_install_address_space_handler+0x64/0xb0
> [<00000000988d4f61>] acpi_gpiochip_add+0x20c/0x4a0
> [<0000000073d4faab>] gpiochip_add_data_with_key+0xd10/0x1680
> [<000000001d50b98a>] devm_gpiochip_add_data_with_key+0x30/0x78
> [<00000000fc3e7eaf>] dwapb_gpio_probe+0x828/0xb28
> [<00000000ad2dd3ee>] platform_probe+0x8c/0x108
> [<00000000dd183e3f>] really_probe+0x190/0x670
> [<0000000066017341>] driver_probe_device+0x8c/0xf8
> [<00000000c441e843>] device_driver_attach+0x9c/0xa8
> [<00000000f91dc709>] __driver_attach+0x88/0x138
> [<00000000d330caed>] bus_for_each_dev+0xec/0x160
> [<00000000eebc5f04>] driver_attach+0x34/0x48
> root@debian:/home/john#
>
> Thanks,
> John
