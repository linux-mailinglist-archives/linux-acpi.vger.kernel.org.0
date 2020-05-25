Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03321E0E4E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbgEYMVk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 08:21:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:61729 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390492AbgEYMVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 08:21:40 -0400
IronPort-SDR: 6Dk/Ku8y43EvWd+C2foT8a3rnUBUcwYR3Vb0na3y2/eIX5k/NQJnUWpBCotkdLbLyndT56SKUU
 b+4RfKlc10hg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 05:21:39 -0700
IronPort-SDR: iKYvWKIiNTV7MhfeH6NCb4l5ZjsyaXr72Ns2w0hTOsz7qnbIFmoAcI8sumCSf68rb237qNP8v8
 1yJhHzO+xCYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="375421070"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 May 2020 05:21:36 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 May 2020 15:21:36 +0300
Date:   Mon, 25 May 2020 15:21:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 5/5] gpio: pca953x: Override GpioInt() pin for Intel
 Galileo Gen 2
Message-ID: <20200525122136.GV247495@lahna.fi.intel.com>
References: <20200520211916.25727-1-andriy.shevchenko@linux.intel.com>
 <20200520211916.25727-5-andriy.shevchenko@linux.intel.com>
 <20200525092028.GQ247495@lahna.fi.intel.com>
 <20200525093150.GL1634618@smile.fi.intel.com>
 <20200525094553.GR247495@lahna.fi.intel.com>
 <20200525101335.GN1634618@smile.fi.intel.com>
 <20200525110556.GT247495@lahna.fi.intel.com>
 <20200525113551.GR1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525113551.GR1634618@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 25, 2020 at 02:35:51PM +0300, Andy Shevchenko wrote:
> On Mon, May 25, 2020 at 02:05:56PM +0300, Mika Westerberg wrote:
> > On Mon, May 25, 2020 at 01:13:35PM +0300, Andy Shevchenko wrote:
> > > Due to parsing of ACPI tables. I don't want to copy'n'paste 25% of
> > > gpiolib-acpi.c in here. I think provided solution is cleaner and (more)
> > > flexible in terms of maintenance.
> > 
> > Hmm, you seem to pass a hard-coded pin number (1) to the core that then
> > passes it back to the driver. Why you can't simple use that number here
> > directly? You don't need to parse anything. What I'm missing? :-)
> 
> Okay, so, AFAIU you are proposing something like this:
> 
> 1) find a GPIO controller by the ACPI path (somehow, I guess by finding a
>    handle followed by physical device behind it); 2) somehow to request a
>    pin from that device by number;
> 3) convert to IRQ and use.
> 
> Is it correct?

Well, no. In the first patch you do this:

  pin = lookup->info.quirks_data;

and this essentially becomes 1 so you know the pin number upfront in the
driver. Why not simply get GPIO number 1 in the driver and use it as an
interrupt? You know already that this particular board with the matching
DMI identifier always uses the this number anyway.
