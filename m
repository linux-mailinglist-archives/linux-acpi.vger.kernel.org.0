Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72287101D32
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 09:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfKSI0r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 03:26:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:38416 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKSI0r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 03:26:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 00:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="215489239"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 19 Nov 2019 00:26:42 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 19 Nov 2019 10:26:42 +0200
Date:   Tue, 19 Nov 2019 10:26:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / button: Add DMI quirk for Acer Switch 10 SW5-032
 lid-switch
Message-ID: <20191119082642.GF11621@lahna.fi.intel.com>
References: <20191118153556.28751-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118153556.28751-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 18, 2019 at 04:35:56PM +0100, Hans de Goede wrote:
> The Acer Switch 10 SW5-032 _LID method is quite broken, it looks like this:
> 
>             Method (_LID, 0, NotSerialized)  // _LID: Lid Status
>             {
>                 If ((STAS & One))
>                 {
>                     Local0 = One
>                     PBCG |= 0x05000000
>                     HMCG |= 0x05000000
>                 }
>                 Else
>                 {
>                     Local0 = Zero
>                     PBCG &= 0xF0FFFFFF
>                     HMCG &= 0xF0FFFFFF
>                 }
> 
>                 ^^PCI0.GFX0.CLID = Local0
>                 Return (Local0)
>             }
> 
> The problem here is the accesses to the PBCG and HMCG, these are the
> pinconf0 registers for the power, resp. the home button GPIO,
> e.g. PBCG is declared as:
> 
>             OperationRegion (PWBT, SystemMemory, 0xFED0E080, 0x10)
>             Field (PWBT, DWordAcc, NoLock, Preserve)
>             {
>                 PBCG,   32,
>                 PBV1,   32,
>                 PBSA,   32,
>                 PBV2,   32
>             }
> 
> Where 0xFED0E000 is the base address of the GPO2 device and 0x80 is
> the offset for the pin used for the powerbutton.
> 
> The problem here is this line in _LID:
>                     PBCG |= 0x05000000
> 
> This changes the trigger flags of the GPIO, changing when it generates
> interrupts. Note it does not clear the original flags. Linux uses an
> edge triggered interrupt on both positive and negative edges. This |=
> adds the BYT_TRIG_LVL flag to this, so now it is turned into a level
> interrupt which fires both when low and high, iow it simply always
> fires leading to an interrupt storm, the tablet immediately waking up
> from suspend again, etc.

Hmm, does it work in Windows?

> There is nothing we can do to fix this, except for a DSDT override,
> which the user needs to do manually. The only thing we can do is
> never call _LID, which requires disabling the lid-switch functionality
> altogether.
> 
> This commit adds a quirk for this, as no lid-switch function is better
> then the interrupt storm. A user manually applying a DSDT override can
> also override the quirk on the kernel cmdline.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
