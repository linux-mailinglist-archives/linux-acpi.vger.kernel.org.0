Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5814FD8A31
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 09:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390357AbfJPHtB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 03:49:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:18037 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfJPHtB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 03:49:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 00:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="370725073"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2019 00:48:58 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iKe3F-0006FL-Fl; Wed, 16 Oct 2019 10:48:57 +0300
Date:   Wed, 16 Oct 2019 10:48:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 11/14] software node: move small properties inline
 when copying
Message-ID: <20191016074857.GN32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
 <20191011230721.206646-12-dmitry.torokhov@gmail.com>
 <20191015122028.GI32742@smile.fi.intel.com>
 <20191015182553.GG105649@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015182553.GG105649@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 15, 2019 at 11:25:53AM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 15, 2019 at 03:20:28PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2019 at 04:07:18PM -0700, Dmitry Torokhov wrote:
> > > When copying/duplicating set of properties, move smaller properties that
> > > were stored separately directly inside property entry structures. We can
> > > move:
> > > 
> > > - up to 8 bytes from U8 arrays
> > > - up to 4 words
> > > - up to 2 double words
> > > - one U64 value
> > > - one or 2 strings.
> > 
> > Can you show where you extract such values?
> 
> the "value" union's largest member is u64, which is 8 bytes. Strings are
> pointers, so on 32-bit arches you can stuff 2 pointers into 8 bytes,
> while on 64-bits you have space for only one.
> 
> > 
> > > +	if (!dst->is_inline && dst->length <= sizeof(dst->value)) {
> > > +		/* We have an opportunity to move the data inline */
> > > +		const void *tmp = dst->pointer;
> > > +
> > 
> > > +		memcpy(&dst->value, tmp, dst->length);
> > 
> > ...because this is strange trick.
> 
> Not sure what is so strange about it. You just take data that is stored
> separately and move it into the structure, provided that it is not too
> big (i.e. it does not exceed sizeof(value union) size).

You store a value as union, but going to read as a member of union?
I'm pretty sure it breaks standard rules.

-- 
With Best Regards,
Andy Shevchenko


