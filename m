Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF6260330
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgIGRp6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgIGRoF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 13:44:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3CC061575
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 10:44:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so15028818wme.5
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtLg9Y4dgEBmAcytToxU0LrQsMgfNF7OgoEHJZ2Q+vw=;
        b=A0Stn/cyvojbDX7w3lzbvMIO7gTwe43sZAGbFpuAEdS5sHSClH8/IZ2AifZ+YY+VOX
         UVwM/aA+6tWtgJSEoCDO1PW617SUSIQB8k6b0bPqqeB7dxfGKJQUxNBeFtcQo9e3Ascw
         6zhcNnrpuccjT086HR4puL61ghnrcI3EOoQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtLg9Y4dgEBmAcytToxU0LrQsMgfNF7OgoEHJZ2Q+vw=;
        b=FBb5IKegYTFJ9Lcje/uvoJL2xcKGlLMB/kxDkDq4q7sHhsi9zWQlTKe9Zhwic2aJQC
         LTzZ4SgLjnHmlK4bMEDdXnOTFX9vNEb47My0eOMTkgus95OSH8yOFg8Ni1rGHV799pCj
         ulVOGYc03dSe5o/J/ItRLfGpE5x6N+Kh+gZSQtO32RjJ2U+hc2YqJqKrct/SYfVz8Xmp
         Yuan1wWAOK5SUiSbMjH4fitEaJgXSgjKfLjF0pr9NY+BsQHG0v5a6jS4Mu412JHYRd+4
         G50g4qj1Zv/KZNfHc7EtlVDfI1DhhgpTbrSuH61xXKt6sIBIwRDpIgvq94d1yoGqwXn+
         vq2Q==
X-Gm-Message-State: AOAM53278GWWstQHrC9YoI+Xxd2NykCZhEVnOT00qPxXdGID8uz4CDvp
        2zIV+T2SFQBlvhwlJyGReYEbqJZnMlLKnYRrTiauAA==
X-Google-Smtp-Source: ABdhPJyNQsBm1Y3/ieHSfjO664M9CBhnY/ZnuJjayy1tYR+ob0ku/Wpd26F5nf8H2/xl9/84D4TcAGvzrj4IPjrxwfU=
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr408820wmf.111.1599500642170;
 Mon, 07 Sep 2020 10:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <b19bc982-a0c4-c6ff-d8f5-650f2b3a83c8@gmail.com> <20200827063517.GA4637@lst.de>
 <CA+-6iNy3U9pO0Bykzgvb9n9fcsBi6FiatLdpA1s0HgQNWZ49mg@mail.gmail.com> <20200907091649.GA6428@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200907091649.GA6428@e121166-lin.cambridge.arm.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 7 Sep 2020 13:43:23 -0400
Message-ID: <CA+-6iNzoz3pM2pJksXogeuou6wB9W-59rN-amCLERFLuY5zLMg@mail.gmail.com>
Subject: Re: [PATCH v11 00/11] PCI: brcmstb: enable PCIe for STB chips
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Julien Grall <julien.grall@arm.com>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 7, 2020 at 5:16 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Aug 27, 2020 at 09:29:59AM -0400, Jim Quinlan wrote:
> > On Thu, Aug 27, 2020 at 2:35 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Aug 25, 2020 at 10:40:27AM -0700, Florian Fainelli wrote:
> > > > Hi,
> > > >
> > > > On 8/24/2020 12:30 PM, Jim Quinlan wrote:
> > > >>
> > > >> Patchset Summary:
> > > >>    Enhance a PCIe host controller driver.  Because of its unusual design
> > > >>    we are foced to change dev->dma_pfn_offset into a more general role
> > > >>    allowing multiple offsets.  See the 'v1' notes below for more info.
> > > >
> > > > We are version 11 and counting, and it is not clear to me whether there is
> > > > any chance of getting these patches reviewed and hopefully merged for the
> > > > 5.10 merge window.
> > > >
> > > > There are a lot of different files being touched, so what would be the
> > > > ideal way of routing those changes towards inclusion?
> > >
> > > FYI, I offered to take the dma-mapping bits through the dma-mapping tree.
> > > I have a bit of a backlog, but plan to review and if Jim is ok with that
> > > apply the current version.
> > Sounds good to me.
>
> Hi Jim,
>
> is the dependency now solved ? Should we review/take this series as
> is for v5.10 through the PCI tree ?
Hello Lorenzo,

We are still working out a regression with the DMA offset commit on
the RaspberryPi.  Nicolas has found the root cause and we are now
devising a solution.

Thanks,
Jim Quinlan
Broadcom STB

>
> Thanks,
> Lorenzo
