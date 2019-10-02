Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7AC87EA
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2019 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJBMGp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Oct 2019 08:06:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:20322 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfJBMGp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Oct 2019 08:06:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:06:45 -0700
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="275338254"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:06:42 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 6496020976; Wed,  2 Oct 2019 15:06:40 +0300 (EEST)
Date:   Wed, 2 Oct 2019 15:06:40 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 08/13] lib/vsprintf: Remove support for %pF and %pf in
 favour of %pS and %ps
Message-ID: <20191002120640.GG972@paasikivi.fi.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-9-sakari.ailus@linux.intel.com>
 <20190924103829.uk4mr3z23hwhqdpe@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924103829.uk4mr3z23hwhqdpe@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Petr,

Thank you for the review.

On Tue, Sep 24, 2019 at 12:38:29PM +0200, Petr Mladek wrote:
> On Wed 2019-09-18 16:34:14, Sakari Ailus wrote:
> > %pS and %ps are now the preferred conversion specifiers to print function
> > names. The functionality is equivalent; remove the old, deprecated %pF
> > and %pf support.
> > 
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -909,7 +909,7 @@ char *symbol_string(char *buf, char *end, void *ptr,
> >  #ifdef CONFIG_KALLSYMS
> >  	if (*fmt == 'B')
> >  		sprint_backtrace(sym, value);
> > -	else if (*fmt != 'f' && *fmt != 's')
> > +	else if (*fmt != 's')
> >  		sprint_symbol(sym, value);
> >  	else
> >  		sprint_symbol_no_offset(sym, value);
> > @@ -2007,9 +2007,7 @@ static char *kobject_string(char *buf, char *end, void *ptr,
> >   *
> >   * - 'S' For symbolic direct pointers (or function descriptors) with offset
> >   * - 's' For symbolic direct pointers (or function descriptors) without offset
> > - * - 'F' Same as 'S'
> > - * - 'f' Same as 's'
> > - * - '[FfSs]R' as above with __builtin_extract_return_addr() translation
> > + * - '[Ss]R' as above with __builtin_extract_return_addr() translation
> >   * - 'B' For backtraced symbolic direct pointers with offset
> >   * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
> >   * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
> > @@ -2112,8 +2110,6 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
> >  	      struct printf_spec spec)
> >  {
> >  	switch (*fmt) {
> > -	case 'F':
> > -	case 'f':
> >  	case 'S':
> >  	case 's':
> >  		ptr = dereference_symbol_descriptor(ptr);
> 
> IMHO, we should do the same also in vbin_printf().
> 
> The compatibility with traceevent tools was discussed in the thread
> https://lkml.kernel.org/r/20190910084707.18380-2-sakari.ailus@linux.intel.com
> 
> If I understand it correctly the tools should be able to handle stored
> 'f' and 'F' modifiers because they might be produced by
> older kernels. But new kernels should not longer produce them.

Agreed.

> 
> Otherwise the patch looks good to me. I am getting used to the fact
> that we will remove the obsolete specifiers completely.

I'll address this in v8 soon.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
