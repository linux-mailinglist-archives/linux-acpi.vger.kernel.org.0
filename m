Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F67FCDA11
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2019 03:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfJGBMI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Oct 2019 21:12:08 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:33720 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbfJGBMI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Oct 2019 21:12:08 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Oct 2019 21:12:07 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 53DE81828A454;
        Mon,  7 Oct 2019 01:05:51 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4AF3A100E86C8;
        Mon,  7 Oct 2019 01:05:49 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 86,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2559:2564:2682:2685:2692:2859:2892:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:5007:6261:6742:7875:9025:10004:10400:10903:10967:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13161:13229:13255:13311:13357:13439:14096:14097:14181:14659:14721:14819:21080:21627:21811:21939:30029:30034:30054:30070:30075:30090:30091,0,RBL:66.24.58.225:@goodmis.org:.lbl8.mailshell.net-62.8.0.186 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:172,LUA_SUMMARY:none
X-HE-Tag: swim51_328f856470b47
X-Filterd-Recvd-Size: 3389
Received: from grimm.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (Authenticated sender: rostedt@goodmis.org)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 01:05:47 +0000 (UTC)
Date:   Tue, 10 Sep 2019 15:03:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        linux-trace-devel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v6 01/12] tools lib traceevent: Convert remaining %p[fF]
 users to %p[sS]
Message-ID: <20190910150303.5a0d3904@oasis.local.home>
In-Reply-To: <c458e734f5777561138b87228384808398547762.camel@perches.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
        <20190910084707.18380-2-sakari.ailus@linux.intel.com>
        <20190910071837.2e9110f8@oasis.local.home>
        <61a2b2ab4693535850306f396aac2a328e1d5a21.camel@perches.com>
        <20190910142621.0bec208d@oasis.local.home>
        <c458e734f5777561138b87228384808398547762.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 10 Sep 2019 11:42:06 -0700
Joe Perches <joe@perches.com> wrote:

> On Tue, 2019-09-10 at 14:26 -0400, Steven Rostedt wrote:
> > On Tue, 10 Sep 2019 10:18:44 -0700
> > Joe Perches <joe@perches.com> wrote:
> >   
> > > > It's not just for the lastest kernel. We must maintain backward
> > > > compatibility here too. If there use to be a usage of this, then we
> > > > must keep it until the kernels are no longer used (perhaps 7 years?)    
> > > 
> > > That argues for not using "%pfw" at all for some number of years.
> > > 
> > > Perhaps the '%pfw' should be '%pnfw' for 'name' and 'fwnode'  
> >
> >   -ENOCOMPREHENSION  
> 
> Perhaps you were not copied on the whole series.
> 
> https://lore.kernel.org/lkml/20190910084707.18380-1-sakari.ailus@linux.intel.com/

Thanks for the link.

> 
> As I understand it, Sakair Ailus is proposing to
> obsolete the current vsprintf "%p[Ff]" extension
> and replace the usage with a new "%pfw" extension
> which would emit the name of a pointer to "struct fwnode {}".
> 
> https://lore.kernel.org/lkml/20190910084707.18380-10-sakari.ailus@linux.intel.com/
> 
> If reusing "%pf<foo>" is a problem, then instead
> it might be reasonable to have a new "%pn<foo>" for
> that use instead.
> 
> btw:
> 
> Is there kernel version information available in
> trace output files?

Not really. This is just a library that parses the trace event formats,
there's not kernel versions passed in, but we do use variations in
formats and such to determine what is supported.

> 
> If so, it might be reasonable to change the tooling
> there instead.
> 

Actually, I think we could just look to see if "%pfw" is used and fall
to that, otherwise consider it an older kernel and do it the original
way.

-- Steve

