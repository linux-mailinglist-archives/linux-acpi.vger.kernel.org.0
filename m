Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64F11EF654
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFELRU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 07:17:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53692 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgFELRU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 07:17:20 -0400
Received: from 89-64-83-87.dynamic.chello.pl (89.64.83.87) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 01eedc837bead76a; Fri, 5 Jun 2020 13:17:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
Date:   Fri, 05 Jun 2020 13:17:15 +0200
Message-ID: <10490419.gsntqH5CaE@kreacher>
In-Reply-To: <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
References: <20200413134611.478441-1-enric.balletbo@collabora.com> <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com> <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, April 14, 2020 4:35:38 PM CEST Enric Balletbo i Serra wrote:
> Hi Rafael,
> 
> On 13/4/20 22:41, Rafael J. Wysocki wrote:
> > On Mon, Apr 13, 2020 at 3:46 PM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> This driver attaches to the ChromeOS ACPI device and then exports the values
> >> reported by the ACPI in a sysfs directory. These values are not exported
> >> via the standard ACPI tables, hence a specific driver is needed to do
> >> it.
> > 
> > So how exactly are they exported?
> > 
> 
> They are exported through sysfs.
> 
> >> The ACPI values are presented in the string form (numbers as decimal
> >> values) or binary blobs, and can be accessed as the contents of the
> >> appropriate read only files in the standard ACPI devices sysfs directory tree.
> > 
> > My understanding based on a cursory look at the patch is that there is
> > an ACPI device with _HID equal to "GGL0001"  and one or more special
> > methods under it that return values which you want to export over
> > sysfs as binary attributes.  They appear to be read-only.
> > 
> 
> Exactly, there is an ACPI device equal to "GGL0001" and one special method
> called MLST that returns a list of the other control methods supported by the
> Chrome OS hardware device. The driver calls the special MLST method and goes
> through the list.
> 
> > I guess that these data are to be consubed by user space?
> > 
> 
> Yes, this is used by user space, to be more specific ChromeOS userspace uses it.

Well, let me start over.

The subject and changelog of this patch are not precise enough IMO and there is
not enough information in the latter.

It is not clear what "ACPI driver for ChromeOS" means.  There may be many ACPI
drivers in a Linux-based system as a rule.

It is unclear what the ChromeOS ACPI device is and why it is there.  Is there
any documentation of it you can point me to?

It is unclear what you mean by "These values are not exported via the standard
ACPI tables".

It looks like (but it is not actually documented in any way) the idea is to
get to the ACPI device object with _HID returning "GGL0001", evaluate the
MLST method under it and then evaluate the methods listed by it and export the
data returned by them via sysfs, under the "GGL0001" device on the "acpi" bus.
Is this correct?

If so, there is a couple of issues here.

First off, GGL0001 is not a valid ACPI device ID, because the GGL prefix is not
present in the list at https://uefi.org/acpi_id_list

There are two ways to address that.  One would be to take the GOOG prefix
(present in the list above), append a proper unique number (if I were to
guess, I would say that 0001 had been reserved already) to it and then
put the resulting device ID into the firmware, to be returned _HID for the
device in question (you can add a _CID returning "GGL0001" so it can be
found by the old invalid ID at least from the kernel).  The other one would
be to properly register the GGL prefix for Google and establish a process for
allocating IDs with that prefix internally.

Next, device attributes in sysfs are part of the kernel ABI and once defined,
they cannot change (exceptions happen, but rarely), so you must guarantee
that whatever appears in there, will always be present for devices with the
given device ID in the future in the same format.

Can you actually guarantee that?  If so, what is that guarantee based on?

Thanks!



