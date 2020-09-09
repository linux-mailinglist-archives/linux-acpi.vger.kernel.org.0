Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C640B262B42
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIIJDh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 05:03:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:39217 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgIIJDh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Sep 2020 05:03:37 -0400
IronPort-SDR: 4H6APNKFa5jSPQ0m6EGOFNjIB2xuyYKsRi2hVbg1h3OXu4MxSOyY13c3f5lOkWicXdDw1wGgOg
 Gok4UPyPOljQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155772991"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155772991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:03:37 -0700
IronPort-SDR: AOfyUaHLr1O2qBJmTNelHYciWWPTM5B1h9YceWqrhR6+GLQMpVoQtduygzljnKaONgwIfXqeTD
 Bdts65VciNzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="407393247"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 09 Sep 2020 02:03:34 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 09 Sep 2020 12:03:33 +0300
Date:   Wed, 9 Sep 2020 12:03:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/3] gpiolib: generalize GPIO line names property
Message-ID: <20200909090333.GK2495@lahna.fi.intel.com>
References: <20200909085426.19862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909085426.19862-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 09, 2020 at 10:54:23AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> I initially sent this as part of the gpio-mockup overhaul but since
> these patches are indepentent and the work on gpio-mockup may become
> more complicated - I'm sending these separately.
> 
> The only change is adding additional property helpers to count strings
> in array.
> 
> v1 -> v2:
> - actually remove the previous devprop source file in patch 3
> - rename the string counting functions to something more explicit
> 
> Bartosz Golaszewski (3):
>   device: property: add helpers to count items in string arrays
>   gpiolib: generalize devprop_gpiochip_set_names() for device properties
>   gpiolib: unexport devprop_gpiochip_set_names()

The series looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
