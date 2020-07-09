Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8095D219F69
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgGIL6N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 07:58:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38341 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgGIL6N (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 07:58:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id t18so1496429otq.5;
        Thu, 09 Jul 2020 04:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRGv8i1NLqF5y2cs67EYKyYOieD8C2J3kdBQDbuxrSI=;
        b=pAUWclLshRVyqEbv0JlwPDmuho7COzzOulHdseu51BTzo3+s0qhRNSXI8EtjNi1S3S
         qGO/zbHghsnOaL0ABAWW/BAjK/3CLqe43sgOCpkNyUqJE7wAZscyA4krAgFrvMTE9/kI
         89Zz7OJsqCWYoXQSS2BUGPiUlHBejdzO8lAJcSZNLai4rlj2P0ZvKQJ+fnrfFXevm+RC
         qIQSbo3Ego1l+nTKaPQu58gRNOprm9k58UB+kuWCjkewW9WwEUqYvezMQMsYa0Y243mM
         Rnf0ozoFh/S6nlneOM4n4LN1ecpPh+CzI8C3c92X7504hQsnubybUwujedf7CceECG61
         RT5A==
X-Gm-Message-State: AOAM530w0vr0tQ+UfKBuBs+qEoHNFGnmB78DyCJiAHsAe/leIVJaM2id
        0F9xGWsji8Bs/OWSVz6pFPVKQ2Gc0xeKp9lp/dY=
X-Google-Smtp-Source: ABdhPJxXX40XCYqyYoXnFPXuGC6w2vY526oEHE9rnBiN6/5mfIiE0GqaHMVLu8jaKzIOCRf+RJf4vBQmtnBeafw4MzU=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr17093644oth.262.1594295891970;
 Thu, 09 Jul 2020 04:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com> <10490419.gsntqH5CaE@kreacher>
 <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com> <59771d3689da41a5bbc67541aa6f4777@AUSX13MPC105.AMER.DELL.COM>
 <20200610214033.GB248110@dtor-ws> <adf9daaf08f1464684e48ec203194fe9@AUSX13MPC105.AMER.DELL.COM>
 <20200610224305.GC248110@dtor-ws> <1e32b7db-5457-e0cf-5e5e-36f21d5a91eb@collabora.com>
 <b9e46ec7-c362-da76-a532-8d380b16d915@collabora.com>
In-Reply-To: <b9e46ec7-c362-da76-a532-8d380b16d915@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 13:57:59 +0200
Message-ID: <CAJZ5v0gSRZnSfQ-c3md+1O+0zzpde=btzKMBijGRa2WgvhW7iw@mail.gmail.com>
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 9, 2020 at 11:31 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Rafael,
>
> On 11/6/20 13:06, Enric Balletbo i Serra wrote:
> > Hi,
> >
> > On 11/6/20 0:43, Dmitry Torokhov wrote:
> >> On Wed, Jun 10, 2020 at 09:52:12PM +0000, Mario.Limonciello@dell.com wrote:
> >>>> -----Original Message-----
> >>>> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>>> Sent: Wednesday, June 10, 2020 4:41 PM
> >>>> To: Limonciello, Mario
> >>>> Cc: enric.balletbo@collabora.com; rjw@rjwysocki.net; rafael@kernel.org;
> >>>> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; lenb@kernel.org;
> >>>> kernel@collabora.com; groeck@chromium.org; bleung@chromium.org;
> >>>> dtor@chromium.org; gwendal@chromium.org; vbendeb@chromium.org;
> >>>> andy@infradead.org; ayman.bagabas@gmail.com; benjamin.tissoires@redhat.com;
> >>>> blaz@mxxn.io; dvhart@infradead.org; gregkh@linuxfoundation.org;
> >>>> hdegoede@redhat.com; jeremy@system76.com; 2pi@mok.nu;
> >>>> mchehab+samsung@kernel.org; rajatja@google.com;
> >>>> srinivas.pandruvada@linux.intel.com; platform-driver-x86@vger.kernel.org
> >>>> Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
> >>>>
> >>>>
> >>>> [EXTERNAL EMAIL]
> >>>>
> >>>> On Wed, Jun 10, 2020 at 09:28:36PM +0000, Mario.Limonciello@dell.com wrote:
> >>>>>>
> >>>>>> To give you some references, if I'm not wrong, this prefix is used in
> >>>> all
> >>>>>> or
> >>>>>> almost all Intel Chromebook devices (auron, cyan, eve, fizz, hatch,
> >>>>>> octopus,
> >>>>>> poppy, strago ...) The ACPI source for this device can be found here
> >>>> [1],
> >>>>>> and,
> >>>>>> if not all, almost all Intel based Chromebooks are shipped with the
> >>>>>> firmware
> >>>>>> that supports this.
> >>>>>
> >>>>> You can potentially carry a small patch in your downstream kernel for the
> >>>>> legacy stuff until it reaches EOL.  At least for the new stuff you could
> >>>>> enact a process that properly reserves unique numbers and changes the
> >>>> driver
> >>>>> when the interface provided by the ACPI device has changed.
> >>>>
> >>>> If we use this prefix for hatch EOL is ~7 years from now.
> >>>>
> >>>
> >>> Isn't the whole point of the ACPI registry and choosing an ID?  You know internally
> >>> if you need to change the interface that a new ID is needed and a new driver will
> >>> be needed that comprehends that ID change.  So if you can't guarantee that 0001 is
> >>> the same driver interface in every firmware implementation google used then that is
> >>> where this falls apart.
> >>>
> >
> > As far as I know GGL0001 has the same driver interface in every firmware
> > implementation Google used. But I'll ask to make sure.
> >
> >>> I know there is a long support lifecycle but you're talking about rebasing
> >>> to new LTS kernels a handful of times between now and then.  If the interface really
> >>> is stable the patch should be small and it shouldn't be a large amount of technical
> >>> debt to carry downstream until EOL.
> >>
> >> I think we are talking about different things actually. Let's forget
> >> about Chrome OS and downstream kernels. We have devices that have
> >> already been shipped and in hands of users. Some of them are old, some
> >> of them are new. We can't not enforce that firmware for these devices
> >> will be either released or updated. Therefore, if we want expose this
> >> device in mainline kernel, we need to have it handle "GGL0001" HID in
> >> addition to whatever proper HID we may select for it.
> >>
> >
> > FWIW, after investigate a bit more, although GGL is not in the ACPI ID list it
> > is in the PNP ID list [1]. So as far as I understand GGL0001 is valid ID. I know
> > that PNP ID is the legacy identifier but since this was here for long time and
> > will be here also for long time, I am wondering if we can take that as an
> > argument to have GGL0001 as a valid device to be exposed in the kernel.
> >
>
> So, as the GGL prefix is a valid ID in the PNP ID list, is this a valid argument
> to take in consideration this patch and resolves your concern regarding the ID?

Yes, it does, thanks!
