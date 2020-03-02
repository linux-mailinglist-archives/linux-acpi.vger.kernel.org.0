Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECAB175CEE
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCBOYw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 09:24:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:3867 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgCBOYw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Mar 2020 09:24:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 06:24:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="351551575"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 02 Mar 2020 06:24:46 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 02 Mar 2020 16:24:46 +0200
Date:   Mon, 2 Mar 2020 16:24:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/4] gpiolib: acpi: Rework honor_wakeup option into an
 ignore_wake option
Message-ID: <20200302142445.GE2667@lahna.fi.intel.com>
References: <20200302111225.6641-1-hdegoede@redhat.com>
 <20200302111225.6641-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302111225.6641-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 02, 2020 at 12:12:23PM +0100, Hans de Goede wrote:
> Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
> quirk mechanism") was added to deal with spurious wakeups on one specific
> model of the HP x2 10 series.
> 
> The approach taken there was to add a bool controlling wakeup support for
> all ACPI GPIO events. This was sufficient for the specific HP x2 10 model
> the commit was trying to fix, but in the mean time other models have
> turned up which need a similar workaround to avoid spurious wakeups from
> suspend, but only for one of the pins on which the ACPI tables request
> ACPI GPIO events.
> 
> Since the honor_wakeup option was added to be able to ignore wake events,
> the name was perhaps not the best, this commit renames it to ignore_wake
> and changes it to a string with the following format:
> gpiolib_acpi.ignore_wake=controller@pin[,controller@pin[,...]]
> 
> This allows working around spurious wakeup issues on a per pin basis.
> 
> This commit also reworks the existing quirk for the HP x2 10 so that
> it functions as before.
> 
> Note:
> -This removes the honor_wakeup parameter. This has only been upstream for
>  a short time and to the best of my knowledge there are no users using
>  this module parameter.
> 
> -The controller@pin[,controller@pin[,...]] syntax is based on an existing
>  kernel module parameter using the same controller@pin format. That version
>  uses ';' as separator, but in practice that is problematic because grub2
>  cannot handle this without taking special care to escape the ';', so here
>  we are using a ',' as separator instead which does not have this issue.
> 
> Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
