Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA916C17B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 13:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgBYM5B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 07:57:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:35498 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYM5B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Feb 2020 07:57:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 04:57:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="237664636"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2020 04:56:58 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j6Zlk-004esL-O0; Tue, 25 Feb 2020 14:57:00 +0200
Date:   Tue, 25 Feb 2020 14:57:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH resend 2/3] gpiolib: acpi: Rename honor_wakeup option to
 ignore_wake, add extra quirk
Message-ID: <20200225125700.GL10400@smile.fi.intel.com>
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <20200225102753.8351-3-hdegoede@redhat.com>
 <20200225105437.GG10400@smile.fi.intel.com>
 <e0c39a89-bcac-4315-d764-5853eb77537d@redhat.com>
 <20200225123425.GK10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225123425.GK10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 25, 2020 at 02:34:25PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 25, 2020 at 12:26:04PM +0100, Hans de Goede wrote:

> Let's do it as a list of pairs, but in slightly different format (I see some
> potential to derive a generic parser, based on users described in
> Documentation/admin-guide/kernel-parameters.txt), i.e.
> 
> 	ignore_wake=pin:controller[,pin:controller[,...]]

Another possible format

	ignore_wake=controller@pin[;controller@pin[;...]]

The second one, while having less users, can be extended to have list of pins
of the same controller, like

	ignore_wake=controller@pin[:pin2:pin3][;controller@pin[:...][;...]]

(colon to match existing user, but can be, of course, changed)

-- 
With Best Regards,
Andy Shevchenko


