Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB129E632
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 09:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgJ2IRC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 04:17:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:16023 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgJ2IRB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 04:17:01 -0400
IronPort-SDR: Z8Bvg9N0QT8fZBxhyLpUXPYgUsvv5u0PoDbQrhnlsq3oSJZMUzw/U2Dq2pYRYg4Lq3qkxom8a+
 kgeq8Ok1jnYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="167615046"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="167615046"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:17:01 -0700
IronPort-SDR: UwFC0FXri9LEqKTHloaDK3T3g+WG06cRg0eE7w8vva1GADv2/MhiJI20slE7qNA0/5LkaP5mA7
 cQU2T6U5ZV9Q==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="318890002"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 01:16:58 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 29 Oct 2020 10:16:56 +0200
Date:   Thu, 29 Oct 2020 10:16:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 3/3] Documentation: firmware-guide: gpio-properties:
 Clarify initial output state
Message-ID: <20201029081656.GQ2495@lahna.fi.intel.com>
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201028205101.47583-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028205101.47583-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 28, 2020 at 10:51:01PM +0200, Andy Shevchenko wrote:
> GpioIo() doesn't provide an explicit state for an output pin.
> Linux tries to be smart and uses a common sense based on other
> parameters. Document how it looks like in the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
