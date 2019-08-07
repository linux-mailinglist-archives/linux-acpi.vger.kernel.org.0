Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144DE8510D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2019 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfHGQ16 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Aug 2019 12:27:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:19068 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfHGQ16 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Aug 2019 12:27:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 09:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="192942726"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 07 Aug 2019 09:13:59 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 07 Aug 2019 19:13:59 +0300
Date:   Wed, 7 Aug 2019 19:13:59 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Yehezkel Bernat' <yehezkelshb@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 3/8] thunderbolt: Use 32-bit writes when writing ring
 producer/consumer
Message-ID: <20190807161359.GT2716@lahna.fi.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-4-mika.westerberg@linux.intel.com>
 <CA+CmpXtMBEtyh77fcrhX2BU8esiit56CWfZmey6LYEHZVUxf8A@mail.gmail.com>
 <0f3a47d8133945b181d623ea6e0d53f2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3a47d8133945b181d623ea6e0d53f2@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 05, 2019 at 04:04:19PM +0000, David Laight wrote:
> > Really a matter of taste, but maybe you want to consider having a single
> > function, with a 3rd parameter, bool is_tx.
> > The calls here will be unified to:
> >         ring_iowrite(ring, ring->head, ring->is_tx);
> > (No condition is needed here).
> > 
> > The implementation uses the new parameter to decide which part of the register
> > to mask, reducing the code duplication (in my eyes):
> > 
> >         val = ioread32(ring_desc_base(ring) + 8);
> >         if (is_tx) {
> >                 val &= 0x0000ffff;
> >                 val |= value << 16;
> >         } else {
> >                 val &= 0xffff0000;
> >                 val |= value;
> >         }
> >         iowrite32(val, ring_desc_base(ring) + 8);
> > 
> > I'm not sure if it improves the readability or makes it worse. Your call.
> 
> Gah, that is all horrid beyond belief.
> If a 32bit write is valid then the hardware must not be updating
> the other 16 bits.
> In which case the driver knows what they should be.
> So it can do a single 32bit write of the required value.

I'm not entirely sure I understand what you say above. Can you shed some
light on this by a concrete example how it should look like? :-)
