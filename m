Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B96D8A6C
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 10:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbfJPIC2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 04:02:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:4761 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730874AbfJPIC2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 04:02:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 01:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="186079660"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2019 01:02:25 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKeGG-0006Wq-9i; Wed, 16 Oct 2019 11:02:24 +0300
Date:   Wed, 16 Oct 2019 11:02:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 00/14] software node: add support for reference
 properties
Message-ID: <20191016080224.GR32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191014073837.GI32742@smile.fi.intel.com>
 <20191014235747.GA105649@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014235747.GA105649@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 14, 2019 at 04:57:47PM -0700, Dmitry Torokhov wrote:
> On Mon, Oct 14, 2019 at 10:38:37AM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2019 at 04:07:07PM -0700, Dmitry Torokhov wrote:
> > > These series implement "references" properties for software nodes as true
> > > properties, instead of managing them completely separately.
> > > 
> > > The first 10 patches are generic cleanups and consolidation and
> > > unification of the existing code; patch #11 implements moving of small
> > > properties inline when copying property entries; patch #12 implements
> > > PROPERTY_ENTRY_REF() and friends; patch #13 converts the user of
> > > references to the property syntax, and patch #14 removes the remains of
> > > references as entities that are managed separately.
> > 
> > Can we get some test cases?
> 
> Something like this? (I'll beef it up if we decide KUnit is OK for
> this).

As a starter, yes.

-- 
With Best Regards,
Andy Shevchenko


