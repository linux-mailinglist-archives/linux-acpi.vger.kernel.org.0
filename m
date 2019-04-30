Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D2F262
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2019 11:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfD3JA0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Apr 2019 05:00:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:62951 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3JA0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Apr 2019 05:00:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 02:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; 
   d="scan'208";a="169232126"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Apr 2019 02:00:21 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 30 Apr 2019 12:00:21 +0300
Date:   Tue, 30 Apr 2019 12:00:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     mh@mike.franken.de
Cc:     lukas@wunner.de, tiwai@suse.de, bhelgaas@google.com,
        ckellner@redhat.com, gregkh@linuxfoundation.org, jslaby@suse.cz,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Furquan Shaikh <furquan@google.com>, linux-acpi@vger.kernel.org
Subject: Re: [REGRESSION 5.0.8] Dell thunderbolt dock broken (xhci_hcd and
 thunderbolt)
Message-ID: <20190430090021.GF26516@lahna.fi.intel.com>
References: <s5hsgu0ihyg.wl-tiwai@suse.de>
 <EksOpJxc6GB@mike.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EksOpJxc6GB@mike.franken.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Rafael, Furquan and linux-acpi

(The original thread is here https://lore.kernel.org/lkml/s5hy33siofw.wl-tiwai@suse.de/T/#u)

On Tue, Apr 30, 2019 at 10:39:00AM +0200, Michael Hirmke wrote:
> Hi Takashi,
> 
> [...]
> >>> I also have XPS 9370 but not that particular dock. I will check tomorrow
> >>> if I can reproduce it as well.
> >>
> >> There aren't too many changes between 5.0.7 and 5.0.8 that touch
> >> PCI/ACPI. This is just a shot in the dark but could you try to revert:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi
> >>   t/commit/?h=linux-5.0.y&id=da6a87fb0ad43ae811519d2e0aa325c7f792b13a
> >>
> >> and see if it makes any difference?
> 
> >OK, I'm building a test kernel package with the revert in OBS
> >home:tiwai:bsc1133486 repo.  A new kernel will be
> >kernel-default-5.0.10-*g8edeab8:
> >  http://download.opensuse.org/repositories/home:/tiwai:/bsc1133486/standard/
> 
> >Michael, once when the new kernel is ready, please give it a try.
> 
> as far as I can see, state is back to normal with this kernel.
> No more error messages or crashing modules and all devices seem to work
> as expected.
> Only thing is, that the external devices connected to the Thunderbolt
> dock are coming up a little bit slower than with 5.0.7 - but this is
> nothing, I'd worry about.

Thanks for testing.

Rafael, it seems that commit c8b1917c8987 ("ACPICA: Clear status of GPEs
before enabling them") causes problem with Thunderbolt controllers if
you boot with device (dock) connected.

I think the reason is the same that got fixed in v4.14 with commit
ecc1165b8b74 ("ACPICA: Dispatch active GPEs at init time") which the
above commit essentially undoes if I understand it correctly.
