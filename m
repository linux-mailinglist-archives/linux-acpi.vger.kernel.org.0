Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24761028E3
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 17:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfKSQIQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 11:08:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:57742 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfKSQIQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 11:08:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 08:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,218,1571727600"; 
   d="scan'208";a="215567147"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2019 08:07:57 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 19 Nov 2019 18:07:56 +0200
Date:   Tue, 19 Nov 2019 18:07:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / button: Add DMI quirk for Acer Switch 10 SW5-032
 lid-switch
Message-ID: <20191119160756.GL11621@lahna.fi.intel.com>
References: <20191118153556.28751-1-hdegoede@redhat.com>
 <20191119082642.GF11621@lahna.fi.intel.com>
 <7a2ac981-1c28-5abb-0599-68da44675bdc@redhat.com>
 <20191119124411.GF32742@smile.fi.intel.com>
 <20191119125757.GJ11621@lahna.fi.intel.com>
 <84e0ce18-500e-b45a-c77a-ad4cc35b1533@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84e0ce18-500e-b45a-c77a-ad4cc35b1533@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 04:38:52PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 19-11-2019 13:57, Mika Westerberg wrote:
> > On Tue, Nov 19, 2019 at 02:44:11PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 19, 2019 at 12:12:35PM +0100, Hans de Goede wrote:
> > > > On 19-11-2019 09:26, Mika Westerberg wrote:
> > > > > On Mon, Nov 18, 2019 at 04:35:56PM +0100, Hans de Goede wrote:
> > > 
> > > > Working around this is not impossible, but it will be quite ugly and given
> > > > the age of the machine IMHO not worth it. I've also found out that I need a
> > > > DSDT override to be able to control the LCD backlight, this is controlled by
> > > > the 1st PWM controller in the SoC LPSS block, which is normally enumerated
> > > > through ACPI but the entire Device (PWM1) {} block is missing from the
> > > > DSDT :|  Adding it from similar hardware fixes things and makes the backlight
> > > > controllable. TL;DR: it seems that this is one of the rare cased where
> > > > people who want to run Linux will need to do a manual DSDT override :|
> > > 
> > > If it's missing it's easy to inject entire block from EFI variable or using
> > > ConfigFS (see meta-acpi project [1] for details).
> > > 
> > > > When they do that override they can also fix the _LID method and
> > > > then re-enable LID functionality on the kernel commandline overriding
> > > > this DMI quirk.
> > > 
> > > Yes, if you override entire DSDT it can be fixed for many bugs at once.
> > > 
> > > > I will probably do a blog post on this (some people have asked me
> > > > to do some blogposts about how to analyze DSDT-s, this will be a nice
> > > > example) and add a link to the DSDT override to the blogpost, I believe
> > > > that this is the best we can do for users of this device.
> > > 
> > > Perhaps above mentioned project somehow can be extended to keep DSDT ASL code
> > > for overriding? Mika?
> > > 
> > > [1]: https://github.com/westeri/meta-acpi/
> > 
> > No objections.
> > 
> > Maybe we should have a mechanism in the kernel that allows you to have
> > ACPI table quirks like this for multiple different systems (based on DMI
> > indentifiers perhaps) inside a single initrd and the kernel then loads
> > tables only matching the running system. That would allow distros to
> > ship these for broken systems.
> 
> I would love to have something like this, but I'm afraid that the distros
> cannot just distribute modified DSDT's. I know we ask people to upload
> acpidump's to bugzilla, etc. all the time. But one can reasonably argue
> that that is fair-use (IANAL, TINLA). OTOH for something to be distributed
> by distros we are going to need something a lot less handwavy wrt
> re-dsitribution of these files, which AFAIK is impossible to get.

Good point.

> I had a discussion about this a while ago at my local hackerspace (*),
> and someone there suggested to distribute patch files and have some
> scripts which automatically generate an overlay by doing acpidump +
> acpixtract + iasl -d + apply-patch + iasl -ta. This would then automatically
> run at boot so that the next boot will have a fixed DSDT. Which is an
> interesting concept if anyone is willing to work on it ...

Indeed interesting idea. Not volunteering to work on it though ;-)
