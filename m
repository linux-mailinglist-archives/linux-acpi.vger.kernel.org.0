Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8135E3626E2
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Apr 2021 19:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbhDPRe3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Apr 2021 13:34:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:37573 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242750AbhDPRe3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Apr 2021 13:34:29 -0400
IronPort-SDR: kT8fvSO23NneSoNx033pmcixx9HOJuOcpWyqlGHS+ZULOA5DL98BSDI9CDPzY65KXZwIyh6kyW
 rTcWsCVU5aZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="195101020"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="195101020"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:34:00 -0700
IronPort-SDR: tQrUzqzEe3V356yqOX8dVKzGb6oKF+Dpyp4L/dGsykNQFKvpC6rCseUSSOQKMjSHKIaMDLo+Fk
 6DHuR+ZeKZYA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="425668212"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:33:58 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lXSLr-004iQM-GJ; Fri, 16 Apr 2021 20:33:55 +0300
Date:   Fri, 16 Apr 2021 20:33:55 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
Message-ID: <YHnKg4MHkZ4QIBHR@smile.fi.intel.com>
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
 <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
 <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
 <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 16, 2021 at 09:15:34AM -0700, Dan Williams wrote:
> On Fri, Apr 16, 2021 at 1:58 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Strictly speaking the comparison between guid_t and raw buffer
> > > > is not correct. Import GUID to variable of guid_t type and then
> > > > compare.
> > >
> > > Hmm, what about something like the following instead, because it adds
> > > safety. Any concerns about evaluating x twice in a macro should be
> > > alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> > > not an array.
> >
> > ARRAY_SIZE doesn't check type.
> 
> See __must_be_array.
> 
> > I don't like hiding ugly casts like this.
> 
> See PTR_ERR, ERR_PTR, ERR_CAST.

It's special, i.e. error pointer case. We don't handle such here.

> There's nothing broken about the way the code currently stands, so I'd
> rather try to find something to move the implementation forward than
> sideways.

Submit a patch then. I rest my case b/c I consider that ugly castings worse
than additional API call, although it's not ideal.

-- 
With Best Regards,
Andy Shevchenko


