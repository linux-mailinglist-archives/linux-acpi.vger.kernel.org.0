Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C331EAF15E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2019 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfIJTDL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Sep 2019 15:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfIJTDK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Sep 2019 15:03:10 -0400
Received: from oasis.local.home (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DED721479;
        Tue, 10 Sep 2019 19:03:05 +0000 (UTC)
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

