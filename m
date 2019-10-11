Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A0BD3F4D
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 14:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfJKMOu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 08:14:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:18740 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfJKMOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Oct 2019 08:14:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 05:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="207416820"
Received: from oham-mobl1.amr.corp.intel.com (HELO caravaggio) ([10.252.27.40])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2019 05:14:47 -0700
Date:   Fri, 11 Oct 2019 14:14:47 +0200
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] acpi: Fail GED probe when not on hardware-reduced
Message-ID: <20191011121447.GA4256@caravaggio>
References: <20191009130433.29134-1-sameo@linux.intel.com>
 <20191009130433.29134-2-sameo@linux.intel.com>
 <CAJZ5v0ioC6XnC+sFpRJmm40T+YCnqoaHhJ+_Pmk7rvvC8UPT9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ioC6XnC+sFpRJmm40T+YCnqoaHhJ+_Pmk7rvvC8UPT9w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 12:38:49PM +0200, Rafael J. Wysocki wrote:
> On Wed, Oct 9, 2019 at 3:04 PM Samuel Ortiz <sameo@linux.intel.com> wrote:
> >
> > The Generic Event Device (GED) is a hardware-reduced platform device.
> 
> No, it is not AFAICS.
It's a little confusing, I was not sure what's the common understanding
and tried to be safe by not having non HW-reduced machines getting a
new device that they've never seen so far.


> The spec doesn't say that GED cannot be used on platforms that aren't
> HW-reduced
I agree.

>  and if evged.c is going to be built in unconditionally, the
> kernel will be able to handle GED regardless.
Ok, perfect then. Does that mean you're ok with the 2nd patch but are
going to drop this one?

Cheers,
Samuel.
