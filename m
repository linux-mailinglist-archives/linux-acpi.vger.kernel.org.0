Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516B6B641A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfIRNLN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 09:11:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:19830 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfIRNLN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 09:11:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:11:12 -0700
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="181117768"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:11:09 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id A55462075A; Wed, 18 Sep 2019 16:11:07 +0300 (EEST)
Date:   Wed, 18 Sep 2019 16:11:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v6 11/12] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190918131107.GR5781@paasikivi.fi.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
 <20190910084707.18380-12-sakari.ailus@linux.intel.com>
 <ef57a3fc72b548b7daf9257aacc596d57004199d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef57a3fc72b548b7daf9257aacc596d57004199d.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Joe,

On Tue, Sep 10, 2019 at 03:21:26AM -0700, Joe Perches wrote:
> > @@ -5988,14 +5988,17 @@ sub process {
> >  		        for (my $count = $linenr; $count <= $lc; $count++) {
> >  				my $specifier;
> >  				my $extension;
> > +				my $qualifier;
> >  				my $bad_specifier = "";
> >  				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
> >  				$fmt =~ s/%%//g;
> >  
> > -				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> > +				while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w?))/g) {
> 
> This is not generic enough to allow all possible qualifiers
> to be captured.
> 
> This should be something like:
> 
> 			while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w*))/g) {
> 	
> >  					$specifier = $1;
> >  					$extension = $2;
> > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > +					$qualifier = $3;
> > +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> > +					    ($extension eq "f" && $qualifier ne "w")) {
> 
> 
> And this should likely test
> 					    (defined $qualifier &&
> 					     $extension eq 'f' && $qualifier =~ /^w/))
> 
> >  						$bad_specifier = $specifier;
> >  						last;
> >  					}
> 
> And here the 'f' isn't really a bad $specifier,
> it does not have the correct 'w' $extension.
> 
> The valid extensions may change in the future and
> this code isn't particularly manageable, so I
> think the $specifier/$extension pair should likely
> have some additional testing after validating
> the $specifier.

There are certainly possibilities of having qualifiers that aren't
supported but extensions are also allowed to be followed by any other
characters, so this is a bit grey area.

I'll make the qualifier one or more letters for v7 as you suggested.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
