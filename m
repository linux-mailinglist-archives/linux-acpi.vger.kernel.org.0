Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382FBBC5C9
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Sep 2019 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409527AbfIXKpw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Sep 2019 06:45:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409506AbfIXKpw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Sep 2019 06:45:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52C51AF26;
        Tue, 24 Sep 2019 10:45:50 +0000 (UTC)
Date:   Tue, 24 Sep 2019 12:45:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 09/13] lib/vsprintf: Add a note on re-using %pf or %pF
Message-ID: <20190924104549.qiayzhr7zikja7sp@pathway.suse.cz>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
 <20190918133419.7969-10-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918133419.7969-10-sakari.ailus@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 2019-09-18 16:34:15, Sakari Ailus wrote:
> Add a note warning of re-use of obsolete %pf or %pF extensions.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  lib/vsprintf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index b00b57f9f911f..df59818537b52 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2008,6 +2008,8 @@ static char *kobject_string(char *buf, char *end, void *ptr,
>   * - 'S' For symbolic direct pointers (or function descriptors) with offset
>   * - 's' For symbolic direct pointers (or function descriptors) without offset
>   * - '[Ss]R' as above with __builtin_extract_return_addr() translation
> + * - '[Ff]' Obsolete an now unsupported extension for printing direct pointers
> + *	    or function descriptors. Be careful when re-using %pf or %pF!

I am not a native speaker but the sentence is hard to parse to me.
Also I miss the word 'symbolic'. IMHO, it described that the output
was a symbol name.

What about something like?

  * - '[Ff]' %pf and %pF were obsoleted and later removed in favor of
  *	    %ps and %pS. Be careful when re-using these specifiers.

Best Regards,
Petr
