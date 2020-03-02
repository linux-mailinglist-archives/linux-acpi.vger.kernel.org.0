Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E116A17571D
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgCBJak (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 04:30:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:49847 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgCBJak (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Mar 2020 04:30:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 01:30:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; 
   d="scan'208";a="228354851"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2020 01:30:36 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8hPK-00660e-6X; Mon, 02 Mar 2020 11:30:38 +0200
Date:   Mon, 2 Mar 2020 11:30:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
Message-ID: <20200302093038.GN1224808@smile.fi.intel.com>
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
 <20200225123425.GK10400@smile.fi.intel.com>
 <20200225125700.GL10400@smile.fi.intel.com>
 <44cc5510-571c-21c4-1855-f3141f72eaa3@redhat.com>
 <ac38ee83-5edf-2ee0-8cec-a0b4367054a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac38ee83-5edf-2ee0-8cec-a0b4367054a8@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 29, 2020 at 09:57:52PM +0100, Hans de Goede wrote:
> On 2/28/20 12:22 PM, Hans de Goede wrote:
> > On 2/25/20 1:57 PM, Andy Shevchenko wrote:
> > > On Tue, Feb 25, 2020 at 02:34:25PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:
> > > 
> > > > Let's do it as a list of pairs, but in slightly different format (I see some
> > > > potential to derive a generic parser, based on users described in
> > > > Documentation/admin-guide/kernel-parameters.txt), i.e.
> > > > 
> > > >     ignore_wake=pin:controller[,pin:controller[,...]]
> > > 
> > > Another possible format
> > > 
> > >     ignore_wake=controller@pin[;controller@pin[;...]]
> > 
> > I like this one, the other one with the pin first feels wrong, the pin is
> > part of the controller, not the other way around.
> > 
> > I will rework the patch series to use the ignore_wake=controller@pin format.
> 
> Just a quick note. I've changed the separator from ; to , for some reason
> grub, at least as used in Fedora with Fedora's grub2 BLS (boot loader spec)
> implementation does not like it when there is a ; in the kernel commandline.

Hmm... I think it would be harder then to have less possible formats in the
command line. Do you really need right now several pins to be listed?

If it's about testing, perhaps we may do it with other means.

> I will also send an email about this to Fedora grub maintainer, but for
> now it is easiest to just avoid the problem.

It's definitely bug in Grub due to existing kernel users with such format.
It means Grub is unable to support kernel command line in full.

-- 
With Best Regards,
Andy Shevchenko


