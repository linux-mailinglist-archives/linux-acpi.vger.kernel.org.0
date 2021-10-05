Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3477F422095
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhJEIXt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 04:23:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:38245 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232478AbhJEIXs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 04:23:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="225626827"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="225626827"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 01:21:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="439429468"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 01:21:56 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mXfhx-008pT9-8B;
        Tue, 05 Oct 2021 11:21:53 +0300
Date:   Tue, 5 Oct 2021 11:21:53 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: linux 5.15-rc4: refcount underflow when unloading gpio-mockup
Message-ID: <YVwLIWrqY9TRLjwG@smile.fi.intel.com>
References: <20211004093416.GA2513199@sol>
 <YVrM8VdLKZUt0i8R@kroah.com>
 <20211004121942.GA3343713@sol>
 <YVrz86m3+7wDSYlh@kuha.fi.intel.com>
 <20211004124701.GA3418302@sol>
 <YVr/t7AbmP/h08GX@kuha.fi.intel.com>
 <20211004141754.GA3510607@sol>
 <20211004152844.GA3825382@sol>
 <CAHp75VeBc3AN+5f680LeK8V6NpiiaPUTgE14FFonUM1W-xrjNA@mail.gmail.com>
 <20211005004035.GA29779@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005004035.GA29779@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 05, 2021 at 08:40:35AM +0800, Kent Gibson wrote:
> On Mon, Oct 04, 2021 at 10:56:00PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 4, 2021 at 8:51 PM Kent Gibson <warthog618@gmail.com> wrote:

...

> > Here is debug prints of what happens
> > 
> > # modprobe gpio-mockup gpio_mockup_ranges=-1,10
> > [  212.850993]  (null): device_create_managed_software_node <<< 0
> > [  212.858177] platform gpio-mockup.0: software_node_notify 0 <<<
> > [  212.865264] platform gpio-mockup.0: software_node_notify 1 <<< 1
> > [  212.874159] gpio-mockup gpio-mockup.0: no of_node; not parsing pinctrl DT
> > [  212.882962] gpiochip_find_base: found new base at 840
> > [  212.889873] gpio gpiochip3: software_node_notify 0 <<<
> > [  212.896164] gpio gpiochip3: software_node_notify 1 <<< 1
> > [  212.905099] gpio gpiochip3: (gpio-mockup-A): added GPIO chardev (254:3)
> > [  212.913313] gpio gpiochip840: software_node_notify 0 <<<
> > [  212.920676] gpio gpiochip3: registered GPIOs 840 to 849 on gpio-mockup-A
> > [  212.935601] modprobe (185) used greatest stack depth: 12744 bytes left
> > 
> > As I read it the software node is created for gpio-mockup device and
> > then _shared_ with the GPIO device, since it's managed it's gone when
> > GPIO device gone followed by UAF when mockup (platform) device itself
> > gone. I.o.w. this software node mustn't be managed because it covers
> > the lifetime of two different objects. The correct fix is to create
> > manually software node and assign it to the pdev and manually free in
> > gpio_mockup_unregister_pdevs()/
> > 
> > Tl;DR: it's a bug in gpio-mockup.
> 
> So the bug is in the behaviour of gpio_mockup_register_chip()?

Not really. The utter root cause is the former API (device_add_properties()
et al) which Heikki is getting rid of in particular because of this issue,
i.e. when users blindly call it without fully understanding the picture of
the object lifetimes.

> That is out of my court, so I'll leave it to you and Bart to sort out.

I'll see what I can do about.

-- 
With Best Regards,
Andy Shevchenko


