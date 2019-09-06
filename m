Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FEDAB2B1
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 08:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbfIFG7V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 02:59:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:44127 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403977AbfIFG7V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Sep 2019 02:59:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 23:59:20 -0700
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="185704237"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 23:59:11 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 7014E2051A; Fri,  6 Sep 2019 09:59:07 +0300 (EEST)
Date:   Fri, 6 Sep 2019 09:59:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>, rafael@kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH v4 07/11] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
Message-ID: <20190906065907.GH5475@paasikivi.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-8-sakari.ailus@linux.intel.com>
 <20190902143935.xtd44jdvhjuc2wxe@pathway.suse.cz>
 <20190902160139.GQ2680@smile.fi.intel.com>
 <20190903140420.kmb42cwr3scrfd3e@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903140420.kmb42cwr3scrfd3e@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 03, 2019 at 04:04:20PM +0200, Petr Mladek wrote:
> On Mon 2019-09-02 19:01:39, Andy Shevchenko wrote:
> > On Mon, Sep 02, 2019 at 04:39:35PM +0200, Petr Mladek wrote:
> > > On Mon 2019-09-02 11:32:36, Sakari Ailus wrote:
> > > > %pS and %ps are now the preferred conversion specifiers to print function
> > > > names. The functionality is equivalent; remove the old, deprecated %pF
> > > > and %pf support.
> > > 
> > > Hmm, I see the following in master:
> > > 
> > > $> git grep %pF
> > > tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt:or events have "%pF" or "%pS" parameter in its format string. It is common to
> > > 
> > > $> git grep %pf
> > > tools/lib/traceevent/event-parse.c:             if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
> > > tools/lib/traceevent/event-parse.c:     if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)
> > > 
> > > I wonder how this is related to printk(). In each case, it seems
> > 
> > It's going thru binary printf() I suppose. The fist stage just saves the format
> > string and argument addresses or so and prints in later on when user is looking
> > for human-readable output.
> 
> It seems that vbin_printf() still thinks that %pf and %pF
> handle function pointers. If I get it correctly, it just
> stores the binary data and the formating is done when
> tracing log is read. The idea is the function pointers
> will stay the same.
> 
> We need to fix/obsolete this path as well.

Agreed. I'll include a patch to do that in v6.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
