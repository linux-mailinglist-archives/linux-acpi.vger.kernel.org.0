Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FDA205512
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jun 2020 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbgFWOrG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jun 2020 10:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgFWOrG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2020 10:47:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56670C061573;
        Tue, 23 Jun 2020 07:47:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 46FA62601D1
Subject: Re: [PATCH v4] platform: x86: Add ACPI driver for ChromeOS
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
References: <20200413134611.478441-1-enric.balletbo@collabora.com>
 <CAJZ5v0gWZ27_DwWQadsJOUxLo4a0rAMe45d4AWXS2gHJZfgfKg@mail.gmail.com>
 <a2953d50-da22-279a-f1e4-faa796d815b1@collabora.com>
 <10490419.gsntqH5CaE@kreacher> <20200606180435.GQ89269@dtor-ws>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cb138300-6063-f345-f358-512193a9574c@collabora.com>
Date:   Tue, 23 Jun 2020 16:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200606180435.GQ89269@dtor-ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 6/6/20 20:04, Dmitry Torokhov wrote:
> Hi Rafael,
> 
> On Fri, Jun 05, 2020 at 01:17:15PM +0200, Rafael J. Wysocki wrote:
>>
>> First off, GGL0001 is not a valid ACPI device ID, because the GGL prefix is not
>> present in the list at https://uefi.org/acpi_id_list
>>

True, this device ID is not in the ACPI id list, but it is in the legacy PNP id
list at https://uefi.org/pnp_id_list

Even is a legacy one, this device has been here a long time, just that Google
had an out-of-tree patch to support that we would like to upstream.

So, I'm wondering if PNP id's are still valid?

>> There are two ways to address that.  One would be to take the GOOG prefix
>> (present in the list above), append a proper unique number (if I were to
>> guess, I would say that 0001 had been reserved already) to it and then
>> put the resulting device ID into the firmware, to be returned _HID for the
>> device in question (you can add a _CID returning "GGL0001" so it can be
>> found by the old invalid ID at least from the kernel).
> 
> This is not going to happen, as there are devices in the wild with such
> firmware (i.e. Samus - Google Pixel 2 - was shipped in 2015). Even if
> Google were to release updated firmware (which is quite unlikely), it
> does not mean that users who are not using Chrome OS would apply updated
> firmware.
> 
>> The other one would
>> be to properly register the GGL prefix for Google and establish a process for
>> allocating IDs with that prefix internally.
> 
> I think it depends on whether there are more instances of "GGL" prefix.
> I thought we mostly used GOOG for everything.
> 

I only see one instance using GGL, GGL0001 which I think is present on all
ACPI-based Chromebooks, and I'd think that the PNP id GGL is a proper valid
prefix for Google. However is true that then Google mostly used GOOG.

[1]
https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/refs/heads/chromeos-2016.05/src/vendorcode/google/chromeos/acpi/chromeos.asl

Thanks,
 Enric

> Thanks.
> 
