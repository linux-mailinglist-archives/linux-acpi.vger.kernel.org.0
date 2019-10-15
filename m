Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8826CD75C7
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2019 14:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfJOMHa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 08:07:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:25440 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJOMHa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Oct 2019 08:07:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 05:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,299,1566889200"; 
   d="scan'208";a="347055145"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 15 Oct 2019 05:07:27 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKLbq-0007Un-7c; Tue, 15 Oct 2019 15:07:26 +0300
Date:   Tue, 15 Oct 2019 15:07:26 +0300
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
Message-ID: <20191015120726.GG32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-6-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-6-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:12PM -0700, Dmitry Torokhov wrote:
> Because property_copy_string_array() stores the newly allocated pointer in the
> destination property, we have an awkward code in property_entry_copy_data()
> where we fetch the new pointer from dst.

I don't see a problem in this function.

Rather 'awkward code' is a result of use property_set_pointer() which relies on
data type.

> Let's change property_copy_string_array() to return pointer and rely on the
> common path in property_entry_copy_data() to store it in destination structure.

-- 
With Best Regards,
Andy Shevchenko


