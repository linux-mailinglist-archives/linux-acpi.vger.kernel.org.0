Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449F41758C4
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 11:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgCBK5Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 05:57:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:53948 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCBK5Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Mar 2020 05:57:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 02:57:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="239603529"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 02 Mar 2020 02:57:22 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8ilI-0066zk-T2; Mon, 02 Mar 2020 12:57:24 +0200
Date:   Mon, 2 Mar 2020 12:57:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
Message-ID: <20200302105724.GQ1224808@smile.fi.intel.com>
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
 <20200225123425.GK10400@smile.fi.intel.com>
 <20200225125700.GL10400@smile.fi.intel.com>
 <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
 <ac38ee83-5edf-2ee0-8cec-a0b4367054a8@redhat.com>
 <20200302093038.GN1224808@smile.fi.intel.com>
 <c187c90b-fe02-8dee-c37c-80d06feba566@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c187c90b-fe02-8dee-c37c-80d06feba566@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 02, 2020 at 10:46:57AM +0100, Hans de Goede wrote:
> On 3/2/20 10:30 AM, Andy Shevchenko wrote:
> > On Sat, Feb 29, 2020 at 09:57:52PM +0100, Hans de Goede wrote:
> > > On 2/28/20 12:22 PM, Hans de Goede wrote:
> > > > On 2/25/20 1:57 PM, Andy Shevchenko wrote:
> > > > > On Tue, Feb 25, 2020 at 02:34:25PM +0200, Andy Shevchenko wrote:
> > > > > > On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:
> > > > > 
> > > > > > Let's do it as a list of pairs, but in slightly different format (I see some
> > > > > > potential to derive a generic parser, based on users described in
> > > > > > Documentation/admin-guide/kernel-parameters.txt), i.e.
> > > > > > 
> > > > > >      ignore_wake=pin:controller[,pin:controller[,...]]
> > > > > 
> > > > > Another possible format
> > > > > 
> > > > >      ignore_wake=controller@pin[;controller@pin[;...]]
> > > > 
> > > > I like this one, the other one with the pin first feels wrong, the pin is
> > > > part of the controller, not the other way around.
> > > > 
> > > > I will rework the patch series to use the ignore_wake=controller@pin format.
> > > 
> > > Just a quick note. I've changed the separator from ; to , for some reason
> > > grub, at least as used in Fedora with Fedora's grub2 BLS (boot loader spec)
> > > implementation does not like it when there is a ; in the kernel commandline.
> > 
> > Hmm... I think it would be harder then to have less possible formats in the
> > command line. Do you really need right now several pins to be listed?
> 
> Yes, the existing quirk for the HP X2 10 with Cherry Trail SoC + TI PMIC,
> which currently ignores wakeups on all pins needs to ignore wakeup on 2 pins.

Ouch.

> > If it's about testing, perhaps we may do it with other means.
> 
> Well it is possible to pass the ; by putting quotes around it, so we could
> go with the ; if you insist, but it really makes life harder for
> 
> > > I will also send an email about this to Fedora grub maintainer, but for
> > > now it is easiest to just avoid the problem.
> > 
> > It's definitely bug in Grub due to existing kernel users with such format.
> > It means Grub is unable to support kernel command line in full.
> 
> So I discussed this with the Fedora Grub maintainer, he says the problem
> exists in upstream grub2 too, grub2 uses a shell like command syntax
> both in its config file and in interactive mode, so if you do e.g.:
> 
> linux /boot/vmlinuz root=/dev/sda1 gpiolib_acpi.ignore_wake=INT33FF:01@0;INT0002:00@2
> 
> Then grub will see the INT0002:00@2 as a new separate commaond, this should
> work:
> 
> linux /boot/vmlinuz root=/dev/sda1 gpiolib_acpi.ignore_wake="INT33FF:01@0;INT0002:00@2"
> 
> But the recommended way to edit the cmdline is by editing /etc/default/grub and
> then re-running grub2-mkconfig, which clears the quotes unless we escape them
> and since grub2-mkconfig is shell script inside shell script inside shell script
> I don't even want to think about how many times I need to escape the quotes.

So, bug is still there...

> TL;DR: Using ; in kernel commandline options makes life much harder for users
> and as such is something which we should try to avoid.
> 
> I appreciate that you are trying to come up with a format for the option which
> looks like existing options and I like the @ use, but using ; really is not a
> good example to follow and IMHO that (not a good example / idea) trumps keeping
> the syntax identical to an existing option.

I see. Since we have to fix real problem, go ahead with comma, but please put
few words in the commit message why this format is being chosen.

-- 
With Best Regards,
Andy Shevchenko


