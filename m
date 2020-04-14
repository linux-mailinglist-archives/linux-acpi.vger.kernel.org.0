Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A241A7FE7
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Apr 2020 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbgDNOfs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Apr 2020 10:35:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44320 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390985AbgDNOfr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Apr 2020 10:35:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DCC392A00DF
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, vbendeb@chromium.org,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Platform Driver <"platform- driver-x86"@vger.kernel.org>
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
Date:   Tue, 14 Apr 2020 16:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 13/4/20 22:41, Rafael J. Wysocki wrote:
> On Mon, Apr 13, 2020 at 3:46 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> This driver attaches to the ChromeOS ACPI device and then exports the values
>> reported by the ACPI in a sysfs directory. These values are not exported
>> via the standard ACPI tables, hence a specific driver is needed to do
>> it.
> 
> So how exactly are they exported?
> 

They are exported through sysfs.

>> The ACPI values are presented in the string form (numbers as decimal
>> values) or binary blobs, and can be accessed as the contents of the
>> appropriate read only files in the standard ACPI devices sysfs directory tree.
> 
> My understanding based on a cursory look at the patch is that there is
> an ACPI device with _HID equal to "GGL0001"  and one or more special
> methods under it that return values which you want to export over
> sysfs as binary attributes.  They appear to be read-only.
> 

Exactly, there is an ACPI device equal to "GGL0001" and one special method
called MLST that returns a list of the other control methods supported by the
Chrome OS hardware device. The driver calls the special MLST method and goes
through the list.

> I guess that these data are to be consubed by user space?
> 

Yes, this is used by user space, to be more specific ChromeOS userspace uses it.

