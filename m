Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFDA6AB7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2019 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfICOEY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Sep 2019 10:04:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:43958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfICOEX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Sep 2019 10:04:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 034A1B117;
        Tue,  3 Sep 2019 14:04:21 +0000 (UTC)
Date:   Tue, 3 Sep 2019 16:04:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>, rafael@kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH v4 07/11] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
Message-ID: <20190903140420.kmb42cwr3scrfd3e@pathway.suse.cz>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-8-sakari.ailus@linux.intel.com>
 <20190902143935.xtd44jdvhjuc2wxe@pathway.suse.cz>
 <20190902160139.GQ2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902160139.GQ2680@smile.fi.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon 2019-09-02 19:01:39, Andy Shevchenko wrote:
> On Mon, Sep 02, 2019 at 04:39:35PM +0200, Petr Mladek wrote:
> > On Mon 2019-09-02 11:32:36, Sakari Ailus wrote:
> > > %pS and %ps are now the preferred conversion specifiers to print function
> > > names. The functionality is equivalent; remove the old, deprecated %pF
> > > and %pf support.
> > 
> > Hmm, I see the following in master:
> > 
> > $> git grep %pF
> > tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt:or events have "%pF" or "%pS" parameter in its format string. It is common to
> > 
> > $> git grep %pf
> > tools/lib/traceevent/event-parse.c:             if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
> > tools/lib/traceevent/event-parse.c:     if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)
> > 
> > I wonder how this is related to printk(). In each case, it seems
> 
> It's going thru binary printf() I suppose. The fist stage just saves the format
> string and argument addresses or so and prints in later on when user is looking
> for human-readable output.

It seems that vbin_printf() still thinks that %pf and %pF
handle function pointers. If I get it correctly, it just
stores the binary data and the formating is done when
tracing log is read. The idea is the function pointers
will stay the same.

We need to fix/obsolete this path as well.

Best Regards,
Petr
