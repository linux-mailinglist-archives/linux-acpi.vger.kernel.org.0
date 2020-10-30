Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3702A02CA
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJ3K1H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 06:27:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:26523 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgJ3K1H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 06:27:07 -0400
IronPort-SDR: +Ct9FnS1yy80eJmATBXWTCWgCa+dpE+mz4iz+Qq48VqhG2X+ajxRG9jhM5vPpMZQu76hofzmof
 a4vQolQzo/Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="155561955"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="155561955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 03:27:06 -0700
IronPort-SDR: CT4FJJUbTUHOk1Y8VUb34jR9aa2OXnzu43+bz8SyWYkmZaQbVG4U2NH+Nq20uYPaB9JfIXFhc4
 ew7ToGlln5yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="425313417"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2020 03:27:03 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 30 Oct 2020 12:27:02 +0200
Date:   Fri, 30 Oct 2020 12:27:02 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCHv2 1/3] software node: Power management operations for
 software nodes
Message-ID: <20201030102702.GA2333887@kuha.fi.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
 <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0gc6ihoNuh5eR4MW+uf9CBH=qoRjGeeOHxgvjmUnorPCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gc6ihoNuh5eR4MW+uf9CBH=qoRjGeeOHxgvjmUnorPCg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Thu, Oct 29, 2020 at 06:10:59PM +0100, Rafael J. Wysocki wrote:
> Well, this basically implements a wrapper PM domain that is somewhat
> more generic, as a concept, then software nodes PM.
> 
> At least it is not specific to software nodes, so I'd prefer it to be
> defined generically.

I don't think we should generalize it like that. I do not think the
power domains should have any links between each other at the general
level (just like we probable should not link fwnodes together anymore
like we do now with the "secondary" fwnode). That is why I have
confined this to software nodes only for now.

I think ideally devices could belong to multiple power domains. That
would be the general solution. I did not think that trying to figure
out how to do that would be reasonable as the first approach (maybe I
should have done exactly that?). But would it be acceptable to allow
devices to belong to multiple power domains?

> Moreover, IIUC, this breaks if the "primary" PM domain callbacks try
> to get to the original PM domain via the dev->pm_domain pointer, which
> the genpd callbacks do.

Ouch, that is true.

> Do we want to wrap the ACPI PM domain only, by any chance?  If so, it
> may be more straightforward to invoke swnode callbacks directly from
> there, if any.

The software node can still be the only "primary" fwnode. I don't
think we should limit this to only platforms (and kernels) that
support ACPI.


thanks,

-- 
heikki
