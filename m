Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7B219F85
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 14:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGIMB4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 08:01:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41371 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgGIMB4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 08:01:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id y22so1637967oie.8;
        Thu, 09 Jul 2020 05:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arGB3qPgvw7a+4/UTLYjhwxhE2h0cMITMWEpR/EppSw=;
        b=uBsTAjL0aPJAYww5WDd40Mr+Kb/BoFcsie8Swc9NxfoAJZOWypqKGuXWhP9+c/pbu6
         nAORn6sZlxeobItXKwsfxKu9BEv/f5svBcPkv5MIWIqtnZvgC1dFJOFPX/pALwdk9hE1
         zNAe/g13uAMmrNtlsVJuqMmtJCX5pkLvRZ4XwPQ0uu6I6yUGiVZLbE4zvBK6SWK6+AqO
         VOmI5sSLAfG1ZjVzRsCM6rVFGeKb6H6LveZRJDcVn+H3iT14ChjWGv1duWrWcjTOdp+/
         feSx378mjhOiQiFuUhWyZ1JJraCwkpy5bfJ3axinEtVjfIM3BWh4THT+U8weM5PJMYBG
         sFkA==
X-Gm-Message-State: AOAM530cJJVruX889HBaeiazC02MqS30HE/+rCvqQ1F8oiDbaMuHaWb4
        vMTLiMhFhzOAd6szaKh/vil35DmUXcIAhopj5FU=
X-Google-Smtp-Source: ABdhPJy6fX4MP9HJD0Gd7VfPZSItTZzRNbcG1ycT8hK+IFW7DY5nj7Y1e2OaWwINKmHEs44NyiS85mr4klvr/IAZcsM=
X-Received: by 2002:aca:4a89:: with SMTP id x131mr11350502oia.103.1594296115512;
 Thu, 09 Jul 2020 05:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com> <10490419.gsntqH5CaE@kreacher>
 <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
In-Reply-To: <4e7f8bf3-b72b-d418-ec95-e1f8c3d61261@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 14:01:43 +0200
Message-ID: <CAJZ5v0hH5MFRWuJX=UjevXo1rHh=ca=skHazasKiEZxOVUw1VA@mail.gmail.com>
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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

On Wed, Jun 10, 2020 at 11:21 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Rafael,
>
> Many thanks for your feedback. See my answers inline.
>
> On 5/6/20 13:17, Rafael J. Wysocki wrote:
> > On Tuesday, April 14, 2020 4:35:38 PM CEST Enric Balletbo i Serra wrote:
> >> Hi Rafael,
> >>
> >> On 13/4/20 22:41, Rafael J. Wysocki wrote:
> >>> On Mon, Apr 13, 2020 at 3:46 PM Enric Balletbo i Serra
> >>> <enric.balletbo@collabora.com> wrote:
> >>>>
> >>>> This driver attaches to the ChromeOS ACPI device and then exports the values
> >>>> reported by the ACPI in a sysfs directory. These values are not exported
> >>>> via the standard ACPI tables, hence a specific driver is needed to do
> >>>> it.
> >>>
> >>> So how exactly are they exported?
> >>>
> >>
> >> They are exported through sysfs.
> >>
> >>>> The ACPI values are presented in the string form (numbers as decimal
> >>>> values) or binary blobs, and can be accessed as the contents of the
> >>>> appropriate read only files in the standard ACPI devices sysfs directory tree.
> >>>
> >>> My understanding based on a cursory look at the patch is that there is
> >>> an ACPI device with _HID equal to "GGL0001"  and one or more special
> >>> methods under it that return values which you want to export over
> >>> sysfs as binary attributes.  They appear to be read-only.
> >>>
> >>
> >> Exactly, there is an ACPI device equal to "GGL0001" and one special method
> >> called MLST that returns a list of the other control methods supported by the
> >> Chrome OS hardware device. The driver calls the special MLST method and goes
> >> through the list.
> >>
> >>> I guess that these data are to be consubed by user space?
> >>>
> >>
> >> Yes, this is used by user space, to be more specific ChromeOS userspace uses it.
> >
> > Well, let me start over.
> >
> > The subject and changelog of this patch are not precise enough IMO and there is
> > not enough information in the latter.
> >
>
> Ok, I can improve that.

Please do.

> > It is not clear what "ACPI driver for ChromeOS" means.  There may be many ACPI
> > drivers in a Linux-based system as a rule.
> >
> > It is unclear what the ChromeOS ACPI device is and why it is there.  Is there
> > any documentation of it you can point me to?
> >
>
> I'm afraid, I don't think there is any documentation, I'll ask around.
>
> > It is unclear what you mean by "These values are not exported via the standard
> > ACPI tables".
> >
> > It looks like (but it is not actually documented in any way) the idea is to
> > get to the ACPI device object with _HID returning "GGL0001", evaluate the
> > MLST method under it and then evaluate the methods listed by it and export the
> > data returned by them via sysfs, under the "GGL0001" device on the "acpi" bus.
> > Is this correct?
> >
>
> Yes, this is correct.
>
> > If so, there is a couple of issues here.
> >
> > First off, GGL0001 is not a valid ACPI device ID, because the GGL prefix is not

[cut]

> > Next, device attributes in sysfs are part of the kernel ABI and once defined,
> > they cannot change (exceptions happen, but rarely), so you must guarantee
> > that whatever appears in there, will always be present for devices with the
> > given device ID in the future in the same format.
> >
> > Can you actually guarantee that?  If so, what is that guarantee based on?
> >
>
> Although is not really documented, can we say that this is a standard "de facto"
> assuming that there are lots of devices in the field and for a long time with
> that? Can this be a guarantee?

I would like the firmware interface to be documented in
Documentation/firmware-guide/acpi/ in the first place, given the lack
of any existing documentation of it that can be pointed to.

Thanks!
