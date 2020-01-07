Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23BF132935
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2020 15:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgAGOqp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jan 2020 09:46:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:58373 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgAGOqp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 Jan 2020 09:46:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 06:46:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; 
   d="scan'208";a="245980264"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jan 2020 06:46:43 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ioq83-0005s7-UK; Tue, 07 Jan 2020 16:46:43 +0200
Date:   Tue, 7 Jan 2020 16:46:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: baytrail: Do not clear IRQ flags on direct-irq
 enabled pins
Message-ID: <20200107144643.GH32742@smile.fi.intel.com>
References: <20191227230447.32458-1-hdegoede@redhat.com>
 <CACRpkdaR4vFp=huuqvsnZTFnAmKNJmjpwM8sPpVX2aERp-LogA@mail.gmail.com>
 <20200107123841.GE32742@smile.fi.intel.com>
 <CACRpkdb5viFXj9S9nVU-p9ZFva1bFns83FrpXdFJHsnJMtomuA@mail.gmail.com>
 <CACRpkdavg8xbnM5-RC2m_nadk9++sbBEtTYLXAoyvxPwO1bSrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdavg8xbnM5-RC2m_nadk9++sbBEtTYLXAoyvxPwO1bSrA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 07, 2020 at 01:57:02PM +0100, Linus Walleij wrote:
> On Tue, Jan 7, 2020 at 1:55 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Jan 7, 2020 at 1:38 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Jan 07, 2020 at 11:35:17AM +0100, Linus Walleij wrote:
> >
> > > > Patch applied as non-critical fix for v5.6 with Mika's ACK.
> > > > (Tell me if it's critical.)
> > >
> > > Can we collect it in our tree (what we are consider a proper for this) and
> > > submit a PR?
> >
> > Sure that's true, I dropped the patch from my tree.
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I also dropped the other Baytrail patch I shouldn't have picked up.
> (Replace WARN...)
> 
> I blame coming back from vacation for misremembering how things
> work...

It means you truly relaxed now!

Thanks!

-- 
With Best Regards,
Andy Shevchenko


