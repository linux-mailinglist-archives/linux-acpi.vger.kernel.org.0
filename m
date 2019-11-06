Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB1F17D7
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 15:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfKFOBe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 09:01:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:46815 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbfKFOBe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 09:01:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 06:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="212778761"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2019 06:01:31 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Nov 2019 16:01:30 +0200
Date:   Wed, 6 Nov 2019 16:01:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add Terra Pad 1061 to the
 run_edge_events_on_boot_blacklist
Message-ID: <20191106140130.GV2552@lahna.fi.intel.com>
References: <20191106115109.119346-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106115109.119346-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 12:51:09PM +0100, Hans de Goede wrote:
> The Terra Pad 1061 has the usual micro-USB-B id-pin handler, but instead
> of controlling the actual micro-USB-B it turns the 5V boost for the
> tablet's USB-A connector and its keyboard-cover connector off.
> 
> The actual micro-USB-B connector on the tablet is wired for charging only,
> and its id pin is *not* connected to the GPIO which is used for the
> (broken) id-pin event handler in the DSDT.
> 
> While at it not only add a comment why the Terra Pad 1061 is on the
> blacklist, but also fix the missing comment for the Minix Neo Z83-4 entry.
> 
> Fixes: 61f7f7c8f978 ("gpiolib: acpi: Add gpiolib_acpi_run_edge_events_on_boot option and blacklist")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
