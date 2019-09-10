Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45496AF05C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2019 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437039AbfIJRSt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Sep 2019 13:18:49 -0400
Received: from smtprelay0028.hostedemail.com ([216.40.44.28]:45751 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387907AbfIJRSt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Sep 2019 13:18:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BB5D9182CED34;
        Tue, 10 Sep 2019 17:18:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6742:8603:10004:10400:10848:10967:11026:11232:11658:11914:12043:12297:12740:12760:12895:13019:13069:13255:13311:13357:13439:14181:14659:14721:21080:21433:21627:30029:30034:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:36,LUA_SUMMARY:none
X-HE-Tag: force61_86aba8a95f343
X-Filterd-Recvd-Size: 2385
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Sep 2019 17:18:45 +0000 (UTC)
Message-ID: <61a2b2ab4693535850306f396aac2a328e1d5a21.camel@perches.com>
Subject: Re: [PATCH v6 01/12] tools lib traceevent: Convert remaining %p[fF]
 users to %p[sS]
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        linux-trace-devel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Sep 2019 10:18:44 -0700
In-Reply-To: <20190910071837.2e9110f8@oasis.local.home>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
         <20190910084707.18380-2-sakari.ailus@linux.intel.com>
         <20190910071837.2e9110f8@oasis.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2019-09-10 at 07:18 -0400, Steven Rostedt wrote:
> On Tue, 10 Sep 2019 11:46:56 +0300
> Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > There are no in-kernel %p[fF] users left. Convert the traceevent tool,
> > too, to align with the kernel.
[]
> > diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
[]
> > @@ -4335,8 +4335,6 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
> >  					switch (*ptr) {
> >  					case 's':
> >  					case 'S':
> > -					case 'f':
> > -					case 'F':
> 
> This file is used to parse output from older kernels, so remove this hunk.
> 
> It's not just for the lastest kernel. We must maintain backward
> compatibility here too. If there use to be a usage of this, then we
> must keep it until the kernels are no longer used (perhaps 7 years?)

That argues for not using "%pfw" at all for some number of years.

Perhaps the '%pfw' should be '%pnfw' for 'name' and 'fwnode'



