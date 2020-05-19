Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF931D9EB5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 20:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgESSD1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 14:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgESSD0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 14:03:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC23C08C5C2
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 11:03:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d7so248162ote.6
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2020 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEF6JImDlZtl9dd5DwbZ+u4aD5H341Tlf4Pwdu0TU+o=;
        b=O1wfisRulz9CoxDrv6qokmb34hMkANCg3EhTpEf3NEqJsA+ZmZJ07dbKmng/EfVA5D
         nPT8mgLwfSarEywarGM6h7tCVITUVt6DRqsNgjllMir5/afeMJnLOgnY337B3AXwz9SM
         Oqgm9lj4hVV5LnGx8wH/rUDprVWwc1s/cDChVMODcwiEvaLfzQGEhhbY16/Cg4wgngUm
         ndYmyZYcCHsrOp+OB43ftulrbAR7pz1+EE7oaLNr5bVmm01rJ3rxaiza1wagWBVUHjIa
         ivZDSdmBIw007YKAB/RKld1rA8gbmnVxP+OVzwaWng1zxA7ML9r4l0C7sDpccbFUdTfv
         iImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEF6JImDlZtl9dd5DwbZ+u4aD5H341Tlf4Pwdu0TU+o=;
        b=Pq28mPNvAptKZsQbPimcuM/AJqikoKXqdwFP3uEaH12YVgu9p2jt4i9oReMrDruCAG
         +TS+ArdxYy8UkTUgJY5yssPdhQVCN9nuuQt6x1FrB5vC49rhY4AzpHnpGX56cJGuOTYw
         H+eTWXTyEdgaHWY8UlapazYQMElwYFPbeBmRbTeCpoSJ1SOwb/7Ntt9ZVQfqHN6BAPnj
         4p/7wdsPEmE24egkXpSjWlLy2v+LslYuPrU5s0f5RbD6wEHa2YxosdbpW+EkRCApKk6f
         ZT+0ORR+gIUOQcM+YfkUaEjqrMZDubLye9ULKKJtYWhKvU0uYkkJ/lZu3aTMYQsxrghA
         TK+w==
X-Gm-Message-State: AOAM532eNAJqad98uKfLnCOSlluE9YBlj1UUnJZ/g+5V2rX+84V/oxJb
        ykAJPWTPbNxF6V5IkE7rb/XJDTl841V6KTrCVE64Eg==
X-Google-Smtp-Source: ABdhPJxDZS36lbikLWNWNKsGTyaSjkhcXB1D0+SUJ5UbhDsdbvvhGykFD+NnS2G+8jChrXraoEPEk7x1IBlfu/Qlymg=
X-Received: by 2002:a05:6830:1e45:: with SMTP id e5mr214825otj.236.1589911405140;
 Tue, 19 May 2020 11:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <CGME20200519062510eucas1p27bc59da66e1b77534855103a27f87452@eucas1p2.samsung.com>
 <20200515053500.215929-5-saravanak@google.com> <e0f9211d-9cf6-a12d-eb63-df06910920ed@samsung.com>
 <CAGETcx_FOGgHdaNY8Dd-4rgT28U7_OHYeLsazbUE-1hyuatRSg@mail.gmail.com>
 <18332705-dd61-9a0e-d931-ae610c8fb600@samsung.com> <8dd9ecc2-0c61-49b7-d485-b169eb721712@samsung.com>
In-Reply-To: <8dd9ecc2-0c61-49b7-d485-b169eb721712@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 May 2020 11:02:49 -0700
Message-ID: <CAGETcx_VtJXCqih4ZadZ0dFVJwKOBEQnnrr9JxxmGNh7HX_vNQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 19, 2020 at 3:32 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi
>
> On 19.05.2020 09:11, Marek Szyprowski wrote:
> > On 19.05.2020 08:48, Saravana Kannan wrote:
> >> On Mon, May 18, 2020 at 11:25 PM Marek Szyprowski
> >> <m.szyprowski@samsung.com> wrote:
> >>> On 15.05.2020 07:35, Saravana Kannan wrote:
> >>>> The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> >>>> parsing of the device tree nodes when a lot of devices are added. This
> >>>> will significantly cut down parsing time (as much a 1 second on some
> >>>> systems). So, use them when adding devices for all the top level
> >>>> device
> >>>> tree nodes in a system.
> >>>>
> >>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>> This patch recently landed in linux-next 20200518. Sadly, it causes
> >>> regression on Samsung Exynos5433-based TM2e board:
> >>>
> >>> ...
> >>>
> >>> Both issues, the lack of DMA for SPI device and Synchronous abort in
> >>> I2S
> >>> probe are new after applying this patch. I'm trying to investigate
> >>> which
> >>> resources are missing and why. The latter issue means typically that
> >>> the
> >>> registers for the given device has been accessed without enabling the
> >>> needed clocks or power domains.
> >> Did you try this copy-pasta fix that I sent later?
> >> https://lore.kernel.org/lkml/20200517173453.157703-1-saravanak@google.com/
> >>
> >>
> >> Not every system would need it (my test setup didn't), but it helps
> >> some cases.
> >>
> >> If that fix doesn't help, then some tips for debugging the failing
> >> drivers.
> >> What this pause/resume patch effectively (not explicitly) does is:
> >> 1. Doesn't immediately probe the devices as they are added in
> >> of_platform_default_populate_init()
> >> 2. Adds them in order to the deferred probe list.
> >> 3. Then kicks off deferred probe on them in the order they were added.
> >>
> >> These drivers are just not handling -EPROBE_DEFER correctly or
> >> assuming probe order and that's causing these issues.
> >>
> >> So, we can either fix that or you can try adding some code to flush
> >> the deferred probe workqueue at the end of fw_devlink_resume().
> >>
> >> Let me know how it goes.
> >
> > So far it looks that your patch revealed a hidden issue in exynos5433
> > clocks configuration, because adding clk_ignore_unused parameter to
> > kernel command line fixes the boot. I'm still investigating it, so
> > probable you can ignore my regression report. I will let you know asap
> > I finish checking it.
> >
> Okay, I confirm that the issue is in the Exynos I2S driver and
> Exynos5433 clock provider. I've posted a quick workaround. I'm sorry for
> the noise, your patch is fine.

Thanks for debugging and finding the real issue. I tried finding your
patches, but couldn't. Can you point me to a lore.kernel.org link? I'm
just curious to see what the issue was.

I'm guessing you didn't need to pick up this one?
https://lore.kernel.org/lkml/20200517173453.157703-1-saravanak@google.com/

-Saravana
