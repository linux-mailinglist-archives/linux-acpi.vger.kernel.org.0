Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5236EA8997
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2019 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfIDPhM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Sep 2019 11:37:12 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:48652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729773AbfIDPhM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Sep 2019 11:37:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B7BBF180A68D8;
        Wed,  4 Sep 2019 15:37:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:2915:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3871:3873:3874:4321:5007:6119:6120:8957:10004:10400:10848:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14181:14659:21080:21221:21451:21505:21611:21627:21740:30030:30054:30069:30070:30083:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: tiger34_3e76a9afc5644
X-Filterd-Recvd-Size: 2411
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Sep 2019 15:37:09 +0000 (UTC)
Message-ID: <78ccab5e0f07b3acaade1dec1ca3241938ab298f.camel@perches.com>
Subject: Re: [PATCH v4 10/11] lib/vsprintf: Add %pfw conversion specifier
 for printing fwnode names
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Wed, 04 Sep 2019 08:37:08 -0700
In-Reply-To: <20190904150413.GU5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
         <20190902083240.20367-11-sakari.ailus@linux.intel.com>
         <20190903130607.cf2qv3s3evobbd5g@pathway.suse.cz>
         <20190904150413.GU5475@paasikivi.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2019-09-04 at 18:04 +0300, Sakari Ailus wrote:
> On Tue, Sep 03, 2019 at 03:06:07PM +0200, Petr Mladek wrote:
> > On Mon 2019-09-02 11:32:39, Sakari Ailus wrote:
[]
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
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

If you want to make changes to checkpatch, please
send patches to the checkpatch maintainers.

Don't break other parsing of $2/#extension.

If you really need to know whatever follows the specific
extension letter use another capture group.

			while ($fmt =~  /(\%[\*\d\.]*p(\w)(\w*))/g) {
				$specifier = $1;
				$extension = $2;
				$qualifier = $3;

etc...

Then verify $qualifier or $3 is not undef if necessary


