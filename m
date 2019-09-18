Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B176B6614
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfIRO3H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 10:29:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:25585 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbfIRO3H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 10:29:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 07:29:06 -0700
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="338344444"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 07:29:03 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 4B5C02075A; Wed, 18 Sep 2019 17:29:01 +0300 (EEST)
Date:   Wed, 18 Sep 2019 17:29:01 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 09/13] lib/vsprintf: Add a note on re-using %pf or %pF
Message-ID: <20190918142901.GS5781@paasikivi.fi.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-10-sakari.ailus@linux.intel.com>
 <20190918100023.078e3b8e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918100023.078e3b8e@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 18, 2019 at 10:00:23AM -0400, Steven Rostedt wrote:
> On Wed, 18 Sep 2019 16:34:15 +0300
> Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > Add a note warning of re-use of obsolete %pf or %pF extensions.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Yes, I'll add that for v8.

> 
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
> 
>  "Obsolete and now"?

Fixed.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
