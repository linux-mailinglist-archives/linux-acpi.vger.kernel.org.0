Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD2A8C12
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfIDQJM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 12:09:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:26190 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732095AbfIDQJL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Sep 2019 12:09:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:09:11 -0700
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="182536037"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 09:09:08 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 810DE204A6; Wed,  4 Sep 2019 19:09:06 +0300 (EEST)
Date:   Wed, 4 Sep 2019 19:09:06 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 10/11] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190904160906.GW5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-11-sakari.ailus@linux.intel.com>
 <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
 <20190904150413.GU5475@paasikivi.fi.intel.com>
 <78ccab5e0f07b3acaade1dec1ca3241938ab298f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ccab5e0f07b3acaade1dec1ca3241938ab298f.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Joe,

On Wed, Sep 04, 2019 at 08:37:08AM -0700, Joe Perches wrote:
> On Wed, 2019-09-04 at 18:04 +0300, Sakari Ailus wrote:
> > On Tue, Sep 03, 2019 at 03:06:07PM +0200, Petr Mladek wrote:
> > > On Mon 2019-09-02 11:32:39, Sakari Ailus wrote:
> []
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > > > @@ -5995,7 +5995,8 @@ sub process {
> > > >  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> > > >  					$specifier = $1;
> > > >  					$extension = $2;
> > > > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > > > +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> > > > +					    $extension =~ /^f[^w]/) {
> > > 
> > > This does not work. $extension seems to have only one character.
> > 
> > Good catch. \w indeed matches a single letter; I'll change that to \w+ and
> > change the other uses accordingly.
> 
> If you want to make changes to checkpatch, please
> send patches to the checkpatch maintainers.
> 
> Don't break other parsing of $2/#extension.
> 
> If you really need to know whatever follows the specific
> extension letter use another capture group.
> 
> 			while ($fmt =~  /(\%[\*\d\.]*p(\w)(\w*))/g) {
> 				$specifier = $1;
> 				$extension = $2;
> 				$qualifier = $3;
> 
> etc...
> 
> Then verify $qualifier or $3 is not undef if necessary

There are just a couple of users, but indeed, the extension handlers work
based on a single letter as well so this way it's better aligned with the
kernel implementation. Forks for me.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
