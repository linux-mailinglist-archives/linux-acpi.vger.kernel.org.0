Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40025F9D1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgIGLs4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:48:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:26050 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbgIGLsr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 07:48:47 -0400
IronPort-SDR: vLai4c0X6towIrb1+/Iqc+B3EQoxm7tp6BmDhSHWxTPpZC3jFxcxhXvZADHWaE4xJQjBStkF/h
 W5ib7I0KX0bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="137508004"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="137508004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 04:48:44 -0700
IronPort-SDR: 0zBgpsTw0cufd6Q64xwCLhA/+X/Ay4w6reVTb3zoIKdjiO+uU7qDrRNNuoQuaQywEl6rxBH1Bc
 RyWZdz+94YJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="333141923"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 07 Sep 2020 04:48:41 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFFdW-00EwHp-NR; Mon, 07 Sep 2020 14:48:38 +0300
Date:   Mon, 7 Sep 2020 14:48:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 13/23] gpio: mockup: pass the chip label as device
 property
Message-ID: <20200907114838.GX1891694@smile.fi.intel.com>
References: <20200904154547.3836-1-brgl@bgdev.pl>
 <20200904154547.3836-14-brgl@bgdev.pl>
 <20200904164820.GB1891694@smile.fi.intel.com>
 <CAMRc=Mea4pGbW+fY3mCWfNSSqo9ZwaJxx2C0JmstnQOc8eVrLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mea4pGbW+fY3mCWfNSSqo9ZwaJxx2C0JmstnQOc8eVrLg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 01:01:02PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 4, 2020 at 6:48 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Sep 04, 2020 at 05:45:37PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > While we do check the "chip-name" property in probe(), we never actually
> > > use it. Let's pass the chip label to the driver using device properties
> > > as we'll want to allow users to define their own once dynamically
> > > created chips are supported.
> > >
> > > The property is renamed to "chip-label" to not cause any confusion with
> > > the actual chip name which is of the form: "gpiochipX".
> > >
> > > If the "chip-label" property is missing, let's do what most devices in
> > > drivers/gpio/ do and use dev_name().
> >
> > Just wondering if we have a documentation in kernel how this mockup mechanism
> > works and what kind of properties it uses.
> >
> > Side note: moving to software nodes would make some advantages in future such
> > as visibility properties and their values (not yet implemented, but there is an
> > idea to move forward).
> 
> Seems like we're implicitly using software nodes already:
> fwnode_create_software_node() is called when adding device properties.

It's not the same APIs, though the former is called from the latter.
But maybe for now it's okay.

-- 
With Best Regards,
Andy Shevchenko


