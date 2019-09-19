Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7930B751B
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2019 10:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfISI3k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Sep 2019 04:29:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:3648 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfISI3k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Sep 2019 04:29:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 01:29:39 -0700
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="181403511"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 01:29:37 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id B10542088F; Thu, 19 Sep 2019 11:29:34 +0300 (EEST)
Date:   Thu, 19 Sep 2019 11:29:34 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 00/13] Device property improvements, add %pfw format
 specifier
Message-ID: <20190919082934.GT5781@paasikivi.fi.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0iHv=-t3qA3VBfC6ryPOmC8QW9pxwFvEw6SQQZ3CwsScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iHv=-t3qA3VBfC6ryPOmC8QW9pxwFvEw6SQQZ3CwsScw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 19, 2019 at 10:00:08AM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 18, 2019 at 3:34 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi all,
> >
> > This set adds functionality into the device property API (counting a
> > node's parents as well as obtaining its name) in order to support printing
> > fwnode names using a new conversion specifier "%pfw". The names that are
> > produced are equivalent to its OF counterpart "%pOF" on OF systems for the
> > two supported modifiers ("f" and "P").
> >
> > Printing a node's name is something that's been available on OF for a long
> > time and if something is converted to device property API (such as the
> > V4L2 fwnode framework) it always got removed of a nice feature that was
> > sometimes essential in debugging. With this set, that no longer is the
> > case.
> >
> > Note: the set now depends on 2d44d165e939 ("scsi: lpfc: Convert existing
> > %pf users to %ps") that is expected from the linux-scsi tree. It is
> 
> OK, so I will be expecting a refresh of the series when the above
> commit appears in the mainline.

Works for me. I'll send v8 then, with Depends-on removed.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
