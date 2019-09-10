Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64BAE7E2
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2019 12:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfIJKVb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Sep 2019 06:21:31 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:57175 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbfIJKVb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Sep 2019 06:21:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 735C1180A8123;
        Tue, 10 Sep 2019 10:21:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:69:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2197:2198:2199:2200:2201:2393:2553:2559:2562:2828:2892:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:4250:4321:4605:5007:6117:6119:6120:7875:7903:7904:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12295:12297:12438:12555:12740:12760:12895:12986:13019:13149:13161:13229:13230:13255:13439:14181:14659:14721:21080:21221:21433:21505:21627:21774:30003:30012:30029:30030:30054:30056:30070:30075:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: quilt67_8134ff3330428
X-Filterd-Recvd-Size: 3861
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Sep 2019 10:21:27 +0000 (UTC)
Message-ID: <ef57a3fc72b548b7daf9257aacc596d57004199d.camel@perches.com>
Subject: Re: [PATCH v6 11/12] lib/vsprintf: Add %pfw conversion specifier
 for printing fwnode names
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Tue, 10 Sep 2019 03:21:26 -0700
In-Reply-To: <20190910084707.18380-12-sakari.ailus@linux.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
         <20190910084707.18380-12-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2019-09-10 at 11:47 +0300, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.

checkpatch comment below:
   A. 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
[]
> @@ -418,6 +418,30 @@ Examples::
>  
>  Passed by reference.
>  
> +Fwnode handles
> +--------------
> +
> +::
> +
> +	%pfw[fP]
> +
> +For printing information on fwnode handles. The default is to print the full
> +node name, including the path. The modifiers are functionally equivalent to
> +%pOF above.
> +
> +	- f - full name of the node, including the path
> +	- P - the name of the node including an address (if there is one)
> +
> +Examples (ACPI)::
> +
> +	%pfwf	\_SB.PCI0.CIO2.port@1.endpoint@0	- Full node name
> +	%pfwP	endpoint@0				- Node name
> +
> +Examples (OF)::
> +
> +	%pfwf	/ocp@68000000/i2c@48072000/camera@10/port/endpoint - Full name
> +	%pfwP	endpoint				- Node name
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5988,14 +5988,17 @@ sub process {
>  		        for (my $count = $linenr; $count <= $lc; $count++) {
>  				my $specifier;
>  				my $extension;
> +				my $qualifier;
>  				my $bad_specifier = "";
>  				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
>  				$fmt =~ s/%%//g;
>  
> -				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> +				while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w?))/g) {

This is not generic enough to allow all possible qualifiers
to be captured.

This should be something like:

			while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w*))/g) {
	
>  					$specifier = $1;
>  					$extension = $2;
> -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> +					$qualifier = $3;
> +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> +					    ($extension eq "f" && $qualifier ne "w")) {


And this should likely test
					    (defined $qualifier &&
					     $extension eq 'f' && $qualifier =~ /^w/))

>  						$bad_specifier = $specifier;
>  						last;
>  					}

And here the 'f' isn't really a bad $specifier,
it does not have the correct 'w' $extension.

The valid extensions may change in the future and
this code isn't particularly manageable, so I
think the $specifier/$extension pair should likely
have some additional testing after validating
the $specifier.



