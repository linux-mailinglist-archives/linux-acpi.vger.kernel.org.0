Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D63B654D
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfIROA0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 10:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfIROAZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 10:00:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640E421907;
        Wed, 18 Sep 2019 14:00:24 +0000 (UTC)
Date:   Wed, 18 Sep 2019 10:00:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 09/13] lib/vsprintf: Add a note on re-using %pf or
 %pF
Message-ID: <20190918100023.078e3b8e@gandalf.local.home>
In-Reply-To: <20190918133419.7969-10-sakari.ailus@linux.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
        <20190918133419.7969-10-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 18 Sep 2019 16:34:15 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Add a note warning of re-use of obsolete %pf or %pF extensions.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

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

 "Obsolete and now"?

-- Steve

> + *	    or function descriptors. Be careful when re-using %pf or %pF!
>   * - 'B' For backtraced symbolic direct pointers with offset
>   * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
>   * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]

