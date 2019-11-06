Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF6F1CC0
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbfKFRsD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 12:48:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:16412 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbfKFRsD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Nov 2019 12:48:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 09:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="212821379"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2019 09:48:00 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Nov 2019 19:47:59 +0200
Date:   Wed, 6 Nov 2019 19:47:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
Message-ID: <20191106174759.GB2552@lahna.fi.intel.com>
References: <20191106154715.155596-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106154715.155596-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 06, 2019 at 04:47:12PM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of my series for Cherry Trail devices to pass the irqchip when
> adding the gpiochip instead of registering it separately. Similar to how
> this is done for Bay Trail devices in Andy's recent series:
> "[RESEND][PATCH v2 0/7] gpiolib: fix GPIO <-> pin mapping registration".
> 
> Note this series depends on that series as well as on the cherryview changes
> currently queued in pinctrl/intel.git/for-next .
> 
> Changes in v2:
> - Add kerndoc comments for new chv_pinctrl struct members

The series looks good to me now. Thanks!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
