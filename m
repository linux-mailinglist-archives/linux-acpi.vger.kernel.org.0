Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102042DA9E
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfE2K1v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 06:27:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:11797 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfE2K1v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 May 2019 06:27:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 03:27:49 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 29 May 2019 03:27:47 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 29 May 2019 13:27:47 +0300
Date:   Wed, 29 May 2019 13:27:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        rjw@rjwysocki.net, jarkko.nikula@linux.intel.com
Subject: Re: [RFC PATCH] gpio/acpi: set direction for ACPI OpRegion GPIOs
Message-ID: <20190529102747.GI2781@lahna.fi.intel.com>
References: <20190529101342.30673-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529101342.30673-1-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 29, 2019 at 12:13:42PM +0200, Ard Biesheuvel wrote:
> The ACPI GPIO OpRegion code never sets the direction for GPIOs that
> it configures from scratch, leaving unconfigured GPIOs to be left
> at the default direction, which is typically input not output.

The code does:

  enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio);

before it requests the GPIO. Isn't that sufficient?
