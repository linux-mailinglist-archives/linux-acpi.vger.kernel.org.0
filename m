Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C238FD8A5D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 09:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbfJPH7o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 03:59:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:7916 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfJPH7o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 03:59:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 00:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="186078791"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2019 00:59:41 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKeDc-0006UQ-Gk; Wed, 16 Oct 2019 10:59:40 +0300
Date:   Wed, 16 Oct 2019 10:59:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 10/14] software node: rename is_array to is_inline
Message-ID: <20191016075940.GP32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-11-dmitry.torokhov@gmail.com>
 <20191014073720.GH32742@smile.fi.intel.com>
 <20191015182206.GF105649@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015182206.GF105649@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2019 at 11:22:06AM -0700, Dmitry Torokhov wrote:
> On Mon, Oct 14, 2019 at 10:37:20AM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2019 at 04:07:17PM -0700, Dmitry Torokhov wrote:
> > > We do not need a special flag to know if we are dealing with an array,
> > > as we can get that data from ratio between element length and the data
> > > size, however we do need a flag to know whether the data is stored
> > > directly inside property_entry or separately.
> > 
> > > -	if (prop->is_array)
> > > +	if (!prop->is_inline)
> > 
> > > -	if (p->is_array) {
> > > +	if (!p->is_inline) {
> > 
> > > -	if (src->is_array) {
> > > +	if (!src->is_inline) {
> > 
> > May we have positive conditionals instead?
> 
> I was trying to limit the context churn. I can definitely change
> property_get_pointer(), but the other 2 I think are better in the
> current form.
> 
> > 
> > > + * @is_inline: True when the property value is stored directly in
> > 
> > I think word 'directly' is superfluous here.
> > Or, perhaps, 'stored directly' -> 'embedded'
> 
> I'm OK with "embedded".
> 
> > 
> > > + *     &struct property_entry instance.
> > 
> > > + * @pointer: Pointer to the property when it is stored separately from
> > > + *     the &struct property_entry instance.
> > 
> > 'separately from' -> 'outside' ?
> 
> Umm, I think I prefer "separately" actually.
> 
> > 
> > > + * @value: Value of the property when it is stored inline.
> > 
> > 'stored inline' -> 'embedded in the &struct...' ?
> 
> I was trying to have a link "stored inline" -> "is_inline".
> 
> Do we want to change the flag to be "is_embedded"?

In dictionaries I have

embedded <-> unilateral
inline <-> ???

Perhaps native speaker can jump in and help here.

My point is to be consistent in the terms we are using.

-- 
With Best Regards,
Andy Shevchenko


