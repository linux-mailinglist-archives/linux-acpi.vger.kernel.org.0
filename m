Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19C4B6411
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfIRNIo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 09:08:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:17819 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfIRNIn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 09:08:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:08:42 -0700
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="187761706"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:08:39 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 38DF22075A; Wed, 18 Sep 2019 16:08:37 +0300 (EEST)
Date:   Wed, 18 Sep 2019 16:08:37 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
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
Message-ID: <20190918130837.GQ5781@paasikivi.fi.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
 <20190910084707.18380-2-sakari.ailus@linux.intel.com>
 <20190910071837.2e9110f8@oasis.local.home>
 <61a2b2ab4693535850306f396aac2a328e1d5a21.camel@perches.com>
 <20190910142621.0bec208d@oasis.local.home>
 <c458e734f5777561138b87228384808398547762.camel@perches.com>
 <20190910150303.5a0d3904@oasis.local.home>
 <c90c33b421c0fa0db5182d0f58c6ba6e86cf1622.camel@perches.com>
 <20190916114158.GN5781@paasikivi.fi.intel.com>
 <20190916103755.4c19eda9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916103755.4c19eda9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Steven,

On Mon, Sep 16, 2019 at 10:37:55AM -0400, Steven Rostedt wrote:
> > If you think that's an issue, I'll opt for another extension than %pfw,
> > which I chose originally since it's memorable --- fw for fwnode (names,
> > paths, and probably more in the future).
> > 
> 
> I'm fine with the switch, as long as newer tools know how to handle it.
> 
> Make sure we also add a comment in the Linux kernel code that states
> that older kernels use to have 'f' and 'F' and that new tools look for
> 'fw' to denote that this isn't an older kernel. This way, people will
> hopefully not add another 'fX' pointer name.

Good point. I'll add a comment on this to make_bprint_args() in
tools/lib/traceevent/event-parse.c as well as in vsprintf.c.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
