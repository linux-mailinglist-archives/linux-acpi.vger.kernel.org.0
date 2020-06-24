Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1195209727
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jun 2020 01:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbgFXXXX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Jun 2020 19:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbgFXXXT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2020 19:23:19 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC600C061796
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2020 16:23:17 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so3335938oic.8
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2020 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGipXZ9X17I+u12oD4DZ2rzNuQVhucODHVNdBawnSmI=;
        b=M1wwfU36UoerE5HtEt7AEffn18uiUdtoM8XXl0AWGojXJGk3IpAdJ2M0usNyP93xIJ
         C4K+tOo4fi/6g4LDkLfnGygf2naXQEjHsl+hfIdob42HpSMDH+RoiClBIpgTZBx++Gwz
         F071ruwPJDr/lHuDqNMAs+amwuavPxIJt1JaWWxFc3xFISohL1QELXY5uKA9Dywb7DaN
         A20RNPw7+ZloQGbS1jfx4jB/8WXiwu33UjOTyKHHu0VlWpJLIrtQtLaEzmdXeT9EE5GB
         owoWOoO1ON0J7TmZDzZtNI5C/NRXNrd0BXcvAjC8iei4HAH1VMd+PspPMOJfibAazSDi
         2QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGipXZ9X17I+u12oD4DZ2rzNuQVhucODHVNdBawnSmI=;
        b=STS6onuHgz7Qgw9NWp5y/LEATblHGJ/igJdzaNoHoacUd9SBDoOTWNPt9QP6rPIF87
         QCO8bzCDZ2Ij3Kd2U7Ki0UJbpn62uVmwjagmV6ID4u10WZTsrimq3QuwQfQXvMqB7znr
         XtJ8afHTWn9X++F6H7R+Cbxn4sPLoxQag2F6fW0qX1SxvBmaz9+WCC61yqZasCBCootT
         lyNnmLpdlMdJ9T8FADQVIRFUsIQwdu8J3h/UZnQyo1ykLHBQuL0megwlg9ir8LTYDYq1
         gjmNUAXGCde7iR8UovXWvmDxIJUMYy+vnO0AYFqd5a9zoZzvR41kkVG0ra6kzZXOJ/Gz
         9NYg==
X-Gm-Message-State: AOAM531by6L2Muz03ykV2Lax50J3mepF0orhQfJD+SVdnyhrZnd+BI53
        krEKs/U/hlhruj2R69y+D6wIQ0EFTBpoCmiuS8JsbA==
X-Google-Smtp-Source: ABdhPJx5V5Rup3zninLm3/4nlfZ5WpzvvNUIwQf1nRP1tGt6s55UEoBgS6WnEaNkB6yHnFN0OU4E08/nB8eF6a04daw=
X-Received: by 2002:aca:6208:: with SMTP id w8mr126619oib.69.1593040996906;
 Wed, 24 Jun 2020 16:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
 <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com>
 <CAMuHMdU2gF=aTeVxRvtzAMLGY=GyBDfBwrYZxoRkL1tV7dL56g@mail.gmail.com>
 <CAGETcx-rHFthf-aLb_S-ST6Evozvgis5XX5u0LNxyvfMoJOLKQ@mail.gmail.com>
 <CAMuHMdXW0jM-A5cvYtFVcgc1Gm3tKkvr0+kWpeJqpJDzNOuYeA@mail.gmail.com>
 <CAGETcx8W96KAw-d_siTX4qHB_-7ddk0miYRDQeHE6E0_8qx-6Q@mail.gmail.com>
 <CAGETcx87JNfKEu4brQ3S-9wObv=OwXkAoDBSREQH5dAD68TPsA@mail.gmail.com> <CAMuHMdUsWAQ3XUGh1Jg_Y3LWz4G5aaZfHqL8JjNZv3DrW3TjvQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUsWAQ3XUGh1Jg_Y3LWz4G5aaZfHqL8JjNZv3DrW3TjvQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 24 Jun 2020 16:22:40 -0700
Message-ID: <CAGETcx_gOQWbxUAS6joxEgLDx_wuXwn3AFqDuio_42XeeG++PQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Mon, Jun 22, 2020 at 8:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Sat, Jun 20, 2020 at 4:33 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Fri, Jun 19, 2020 at 1:07 PM Saravana Kannan <saravanak@google.com> wrote:
> > > I think instead of deferred_probe_work_func() moving the device to the
> > > end of the dpm_list, I think the device probing successfully is what
> > > should move it to the end of the dpm_list. That way, the dpm_list is
> > > actually ordered by when the devices become functional and not the
> > > random order in DT or random probe order which can get pretty
> > > convoluted with multiple deferred probes. This feels right and will
> > > make suspend/resume more robust against DT ordering -- but I'm not
> > > sure what other wide ranging impact this has for other platforms.
> >
> > If you want to play around with a potential fix to test my hypothesis,
> > I think it's just adding this one line to driver_bound():
> > ============
> > klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
> > device_links_driver_bound(dev);
> > +device_pm_move_to_tail(dev);
> >
> > device_pm_check_callbacks(dev);
> > ============
>
> Thanks, that seems to fix the issue for me, on both affected systems!
> Note that this has quite some impact on the order devices are suspended,
> but this seems harmless.
>
> Will try on more systems later...

Thanks for testing. Maybe I should just send that change as a patch
and see what Greg/Rafael have to say to that.

It's a general fix anyway. So, might as well send it out.

-Saravana
