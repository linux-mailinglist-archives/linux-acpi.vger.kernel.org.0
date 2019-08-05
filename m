Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2981B89
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2019 15:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfHENPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Aug 2019 09:15:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:34149 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbfHENPM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Aug 2019 09:15:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 06:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="192418160"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 06:15:08 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 16:15:07 +0300
Date:   Mon, 5 Aug 2019 16:15:07 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario.Limonciello@dell.com
Cc:     yehezkelshb@gmail.com, linux-kernel@vger.kernel.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        rjw@rjwysocki.net, lenb@kernel.org, lukas@wunner.de,
        anthony.wong@canonical.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/8] thunderbolt: Move NVM upgrade support flag to struct
 icm
Message-ID: <20190805131507.GR2640@lahna.fi.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-3-mika.westerberg@linux.intel.com>
 <CA+CmpXt5q93e2TQJzfY4afSEMPWijPU+Ks+cgrVDVqUM4=y3Cw@mail.gmail.com>
 <20190705105815.GT2640@lahna.fi.intel.com>
 <23cca57934d24eb6b897ebf00f852128@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23cca57934d24eb6b897ebf00f852128@AUSX13MPC105.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 09, 2019 at 03:11:15PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Friday, July 5, 2019 5:58 AM
> > To: Yehezkel Bernat
> > Cc: LKML; Andreas Noever; Michael Jamet; Rafael J . Wysocki; Len Brown; Lukas
> > Wunner; Limonciello, Mario; Anthony Wong; linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH 2/8] thunderbolt: Move NVM upgrade support flag to struct
> > icm
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Fri, Jul 05, 2019 at 01:52:49PM +0300, Yehezkel Bernat wrote:
> > > > @@ -2054,6 +2059,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
> > > >         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
> > > >         case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
> > > >                 icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
> > > > +               icm->can_upgrade_nvm = true;
> > >
> > > Shouldn't this be also !x86_apple_machine just like AR?
> > > (For FR, we don't use ICM on Apple machines, as much as I remember, so it's fine
> > > to enable it there unconditionally for ICM code path.)
> > 
> > Yes, good point. I'll fix it up.
> 
> Another thought - does the TR or AR ID's setting can_upgrade_nvm to !x86_apple_machine
> show up in anything like a dock or is it only host controllers?  If it's in docks, then it might be worth
> only blocking on apple if it's a host.

It affects only hosts so on Apple system you can't upgrade host NVM but
docks and other devices you can.
