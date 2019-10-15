Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E69D75D9
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 14:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfJOMJy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 08:09:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:12934 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJOMJy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 08:09:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 05:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,299,1566889200"; 
   d="scan'208";a="396790405"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2019 05:09:50 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKLe9-0007Wl-R7; Tue, 15 Oct 2019 15:09:49 +0300
Date:   Tue, 15 Oct 2019 15:09:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 06/14] software node: get rid of property_set_pointer()
Message-ID: <20191015120949.GH32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-7-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-7-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:13PM -0700, Dmitry Torokhov wrote:
> Instead of explicitly setting values of integer types when copying
> property entries lets just copy entire value union when processing
> non-array values.
> 
> For value arrays we no longer use union of pointers, but rather a single
> void pointer, which allows us to remove property_set_pointer().
> 
> In property_get_pointer() we do not need to handle each data type
> separately, we can simply return either the pointer or pointer to values
> union.
> 
> We are not losing anything from removing typed pointer union because the
> upper layers do their accesses through void pointers anyway, and we
> trust the "type" of the property when interpret the data. We rely on
> users of property entries on using PROPERTY_ENTRY_XXX() macros to
> properly initialize entries instead of poking in the instances directly.

I'm not sure about this change since the struct definition is still available
to use. If we would change it to be opaque pointer, it will be possible to get
rid of the type differentiation in cleaner way.

Anyway, perhaps somebody else can look at this.

-- 
With Best Regards,
Andy Shevchenko


