Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216C2A8975
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfIDPSD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 11:18:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:57739 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfIDPSD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 11:18:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 08:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="185146723"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2019 08:18:00 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i5X2l-0002xo-8t; Wed, 04 Sep 2019 18:17:59 +0300
Date:   Wed, 4 Sep 2019 18:17:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 10/11] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190904151759.GS2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-11-sakari.ailus@linux.intel.com>
 <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
 <20190904150413.GU5475@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904150413.GU5475@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 04, 2019 at 06:04:13PM +0300, Sakari Ailus wrote:
> On Tue, Sep 03, 2019 at 03:06:07PM +0200, Petr Mladek wrote:
> > On Mon 2019-09-02 11:32:39, Sakari Ailus wrote:
> > > Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> > > support printing full path of the node, including its name ("f") and only
> > > the node's name ("P") in the printk family of functions. The two flags
> > > have equivalent functionality to existing %pOF with the same two modifiers
> > > ("f" and "P") on OF based systems. The ability to do the same on ACPI
> > > based systems is added by this patch.

> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -5995,7 +5995,8 @@ sub process {
> > >  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> > >  					$specifier = $1;
> > >  					$extension = $2;
> > > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > > +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> > > +					    $extension =~ /^f[^w]/) {
> > 
> > This does not work. $extension seems to have only one character.
> 
> Good catch. \w indeed matches a single letter; I'll change that to \w+ and
> change the other uses accordingly.

It's weird. \w stands for word matching. How can it match one letter only?

-- 
With Best Regards,
Andy Shevchenko


