Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FAC87BB
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2019 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfJBMCo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Oct 2019 08:02:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:33592 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfJBMCo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Oct 2019 08:02:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:02:26 -0700
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="343311408"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:02:22 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 7993E20976; Wed,  2 Oct 2019 15:02:20 +0300 (EEST)
Date:   Wed, 2 Oct 2019 15:02:20 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 09/13] lib/vsprintf: Add a note on re-using %pf or %pF
Message-ID: <20191002120220.GF972@paasikivi.fi.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-10-sakari.ailus@linux.intel.com>
 <20190924104549.qiayzhr7zikja7sp@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924104549.qiayzhr7zikja7sp@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2019 at 12:45:49PM +0200, Petr Mladek wrote:
> On Wed 2019-09-18 16:34:15, Sakari Ailus wrote:
> > Add a note warning of re-use of obsolete %pf or %pF extensions.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  lib/vsprintf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index b00b57f9f911f..df59818537b52 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -2008,6 +2008,8 @@ static char *kobject_string(char *buf, char *end, void *ptr,
> >   * - 'S' For symbolic direct pointers (or function descriptors) with offset
> >   * - 's' For symbolic direct pointers (or function descriptors) without offset
> >   * - '[Ss]R' as above with __builtin_extract_return_addr() translation
> > + * - '[Ff]' Obsolete an now unsupported extension for printing direct pointers
> > + *	    or function descriptors. Be careful when re-using %pf or %pF!
> 
> I am not a native speaker but the sentence is hard to parse to me.
> Also I miss the word 'symbolic'. IMHO, it described that the output
> was a symbol name.
> 
> What about something like?
> 
>   * - '[Ff]' %pf and %pF were obsoleted and later removed in favor of
>   *	    %ps and %pS. Be careful when re-using these specifiers.

Yes, I'll use this in v8.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
