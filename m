Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E70203B79
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgFVPtZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 11:49:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42264 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgFVPtZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 11:49:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id t6so13408054otk.9;
        Mon, 22 Jun 2020 08:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukHKRXuBbPQ+hCHp8ZkdpCwZxoKqRm4bkB6SlAMSyts=;
        b=INgfEx/Ox65qHBF2f2NKQt1uc/q5M9MQyJEXraXilxZsnR2p63v95aQDFUg2lt4BOe
         wsVUgsYQihmF5uVltxwEpzEX7kmV12CrsxaVatYko5nZk+g1WRhfF/kBycqXDhEYB1gw
         XhPdnD6a6mXHZOQdbXbG7rMpkj2edullhoN0KdWB4T0DcxXfT5feK8GtvW6u+yzHROtF
         cTk0q1zyt9mLiuHgkubaajG16nftVdM4gqhC9lj/WU+Tx/OfvBlieZX6NilOlDIKgw6q
         Wv9ASm+62Iw2FcRFVvfRBy8tHLh7yn9W8EMvZh6W+uegbMglLVFAFOPpua2faISK0HRP
         UiVg==
X-Gm-Message-State: AOAM5302uTANwsXB1tjuT+A7/FS3CtcSetVQO3zxZAshistlTalWjFRs
        +U9GHRwMeWIu6iHr0k7r2g1ctvpNS6v8oezAp/E=
X-Google-Smtp-Source: ABdhPJyVUFz/In4cnlLRHIolL4alEhLcXovuLEA210Edp2UfV5x+qTGIiJivAxU9OTkdQkDrFPDlwe46o1wzUgjWtl4=
X-Received: by 2002:a9d:62c2:: with SMTP id z2mr14189823otk.145.1592840964455;
 Mon, 22 Jun 2020 08:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
 <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
 <CAMuHMdU2gF=aTeVxRvtzAMLGY=GyBDfBwrYZxoRkL1tV7dL56g@mail.gmail.com>
 <CAGETcx-rHFthf-aLb_S-ST6Evozvgis5XX5u0LNxyvfMoJOLKQ@mail.gmail.com>
 <CAMuHMdXW0jM-A5cvYtFVcgc1Gm3tKkvr0+kWpeJqpJDzNOuYeA@mail.gmail.com>
 <CAGETcx8W96KAw-d_siTX4qHB_-7ddk0miYRDQeHE6E0_8qx-6Q@mail.gmail.com> <CAGETcx87JNfKEu4brQ3S-9wObv=OwXkAoDBSREQH5dAD68TPsA@mail.gmail.com>
In-Reply-To: <CAGETcx87JNfKEu4brQ3S-9wObv=OwXkAoDBSREQH5dAD68TPsA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Jun 2020 17:49:13 +0200
Message-ID: <CAMuHMdUsWAQ3XUGh1Jg_Y3LWz4G5aaZfHqL8JjNZv3DrW3TjvQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On Sat, Jun 20, 2020 at 4:33 AM Saravana Kannan <saravanak@google.com> wrote:
> On Fri, Jun 19, 2020 at 1:07 PM Saravana Kannan <saravanak@google.com> wrote:
> > I think instead of deferred_probe_work_func() moving the device to the
> > end of the dpm_list, I think the device probing successfully is what
> > should move it to the end of the dpm_list. That way, the dpm_list is
> > actually ordered by when the devices become functional and not the
> > random order in DT or random probe order which can get pretty
> > convoluted with multiple deferred probes. This feels right and will
> > make suspend/resume more robust against DT ordering -- but I'm not
> > sure what other wide ranging impact this has for other platforms.
>
> If you want to play around with a potential fix to test my hypothesis,
> I think it's just adding this one line to driver_bound():
> ============
> klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
> device_links_driver_bound(dev);
> +device_pm_move_to_tail(dev);
>
> device_pm_check_callbacks(dev);
> ============

Thanks, that seems to fix the issue for me, on both affected systems!
Note that this has quite some impact on the order devices are suspended,
but this seems harmless.

Will try on more systems later...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
