Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E503D8A52
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbfJPHxG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 03:53:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:2771 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfJPHxG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 03:53:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 00:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="194765822"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2019 00:53:01 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKe7A-0006HQ-Vb; Wed, 16 Oct 2019 10:53:00 +0300
Date:   Wed, 16 Oct 2019 10:53:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 05/14] software node: clean up
 property_copy_string_array()
Message-ID: <20191016075300.GO32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-6-dmitry.torokhov@gmail.com>
 <20191015120726.GG32742@smile.fi.intel.com>
 <20191015181211.GD105649@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015181211.GD105649@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2019 at 11:12:11AM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 15, 2019 at 03:07:26PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2019 at 04:07:12PM -0700, Dmitry Torokhov wrote:
> > > Because property_copy_string_array() stores the newly allocated pointer in the
> > > destination property, we have an awkward code in property_entry_copy_data()
> > > where we fetch the new pointer from dst.
> > 
> > I don't see a problem in this function.
> > 
> > Rather 'awkward code' is a result of use property_set_pointer() which relies on
> > data type.
> 
> No, the awkwardness is that we set the pointer once in
> property_copy_string_array(), then fetch it in
> property_entry_copy_data() only to set it again via
> property_set_pointer().

Yes, since property_set_pointer is called independently
on the type of the value.


> This is confising and awkward and I believe it
> is cleaner for property_copy_string_array() to give a pointer to a copy
> of a string array, and then property_entry_copy_data() use it when
> handling the destination structure.

We probably need a 3rd opinion here.

-- 
With Best Regards,
Andy Shevchenko


