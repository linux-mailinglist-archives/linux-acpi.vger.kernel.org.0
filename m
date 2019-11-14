Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A27FC473
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 11:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKNKmg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 05:42:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:16312 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfKNKmf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 05:42:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 02:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="214520090"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 14 Nov 2019 02:42:32 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 14 Nov 2019 12:42:31 +0200
Date:   Thu, 14 Nov 2019 12:42:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] gpiolib: acpi: Make acpi_gpiochip_alloc_event
 always return AE_OK
Message-ID: <20191114104231.GK34425@lahna.fi.intel.com>
References: <20191114102600.34558-1-hdegoede@redhat.com>
 <20191114102600.34558-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114102600.34558-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 11:26:00AM +0100, Hans de Goede wrote:
> acpi_gpiochip_alloc_event is used to loop over all _AEI resources, if
> we fail to bind an event handler to one of them, that is not a reason to
> not try the other resources.
> 
> This commit modifies acpi_gpiochip_alloc_event to always return AE_OK,
> so that we will always try to add an event handler for all _AEI resources.

Makes sense.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
