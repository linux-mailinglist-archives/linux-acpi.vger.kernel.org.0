Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3743997A
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 16:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhJYPBv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 11:01:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233721AbhJYPBu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 11:01:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F53460C4A;
        Mon, 25 Oct 2021 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635173967;
        bh=0DRdwtlDxptpTVIUjrdp6jdjBzHEdY7f29OSOi6wnyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqNGRa1clU2ffRDdfraZXkY8BMhC5lhoqnVhGyp04+tM/sQqWApkbPaawpb0mM9RX
         5xEv/jMWA5KrcOFmpKgDX0o5OgjazqPt51ocqyxZ++GK617SQmpExaUSGgHPXK+oZh
         ybf1JBAjherNroZBF0MNaopT6Ww3PACpvDysQ7NU=
Date:   Mon, 25 Oct 2021 16:59:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YXbGTS6cLmuNuJiR@kroah.com>
References: <cover.1635140590.git.yu.c.chen@intel.com>
 <6d4a9bc38c1efd2b10955f64629d194c050fdae1.1635140590.git.yu.c.chen@intel.com>
 <YXZTDp3xB9hZdcuY@kroah.com>
 <20211025141111.GA8602@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025141111.GA8602@chenyu5-mobl1>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 25, 2021 at 10:11:11PM +0800, Chen Yu wrote:
> > > +module_init(pfru_init);
> > > +module_exit(pfru_exit);
> > 
> > module_platform_driver()?
> >
> Currently there are two platform drivers in this file, one is this
> platform driver, another one will be introduced in the subsequent
> patch for telemetry. Since the two platform drivers are treated
> as a whole, they are put into one file. Should I split them
> into two files?

If they bind to different hardware devices, then yes, they should be
separate files as they are not sharing any common code here.

thanks,

greg k-h
