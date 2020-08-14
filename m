Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE8244C37
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHNPiE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 11:38:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:2113 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHNPiB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Aug 2020 11:38:01 -0400
IronPort-SDR: n4LcJ6In7V93k8QtXWM91UYJOYlS4kmIx8hlif0lftjVUQPbiVmW3Ig2eBa3m5gF7IbzXZALAm
 K7iPtghz6ZvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="239256633"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="239256633"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:37:58 -0700
IronPort-SDR: rAo4S2W6dOr4MXmlm81hY+LgtQPiRmy88DFC3q2cLA9m5Iv2xw87mRczZnJFiWCzBdW5w0ChdO
 Kn8oFOKkeNMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="325754466"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 08:37:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6bmG-008g7G-9o; Fri, 14 Aug 2020 18:37:56 +0300
Date:   Fri, 14 Aug 2020 18:37:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 2/7] resource: Group resource_overlaps() with other
 inline helpers
Message-ID: <20200814153756.GR1891694@smile.fi.intel.com>
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <20200813175729.15088-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gsE6fwdkZdmgucUD7mt=BWDh-C8LagDSCTm8Awz-ddfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gsE6fwdkZdmgucUD7mt=BWDh-C8LagDSCTm8Awz-ddfw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 14, 2020 at 05:18:33PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > For better maintenance group resource_overlaps() with other inline helpers.

...

> > +/* True if any part of r1 overlaps r2 */
> > +static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
> > +{
> > +       return (r1->start <= r2->end && r1->end >= r2->start);
> 
> The redundant parens can be dropped while at it.

Okay, will do!

> > +}

-- 
With Best Regards,
Andy Shevchenko


