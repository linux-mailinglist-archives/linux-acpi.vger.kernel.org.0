Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353B1A5AFF
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfIBQBr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 12:01:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:5541 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfIBQBr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 12:01:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 09:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="357510056"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2019 09:01:42 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4olv-0004WG-EM; Mon, 02 Sep 2019 19:01:39 +0300
Date:   Mon, 2 Sep 2019 19:01:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        linux-trace-devel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 07/11] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
Message-ID: <20190902160139.GQ2680@smile.fi.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
 <20190902083240.20367-8-sakari.ailus@linux.intel.com>
 <20190902143935.xtd44jdvhjuc2wxe@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902143935.xtd44jdvhjuc2wxe@pathway.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 04:39:35PM +0200, Petr Mladek wrote:
> On Mon 2019-09-02 11:32:36, Sakari Ailus wrote:
> > %pS and %ps are now the preferred conversion specifiers to print function
> > names. The functionality is equivalent; remove the old, deprecated %pF
> > and %pf support.
> 
> Hmm, I see the following in master:
> 
> $> git grep %pF
> tools/lib/traceevent/Documentation/libtraceevent-func_apis.txt:or events have "%pF" or "%pS" parameter in its format string. It is common to
> 
> $> git grep %pf
> tools/lib/traceevent/event-parse.c:             if (asprintf(&format, "%%pf: (NO FORMAT FOUND at %llx)\n", addr) < 0)
> tools/lib/traceevent/event-parse.c:     if (asprintf(&format, "%s: %s", "%pf", printk->printk) < 0)
> 
> I wonder how this is related to printk(). In each case, it seems

It's going thru binary printf() I suppose. The fist stage just saves the format
string and argument addresses or so and prints in later on when user is looking
for human-readable output.

> that libtraceevent somehow implements the non-standard kernel
> %p mofifiers. It looks error-prone to keep another %pf user
> with the old semantic around.
> 
> I am adding some tracing people into CC.

-- 
With Best Regards,
Andy Shevchenko


