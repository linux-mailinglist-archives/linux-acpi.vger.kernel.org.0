Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 528DF1595E4
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 18:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBKRDf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 12:03:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:42104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbgBKRDf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Feb 2020 12:03:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC517BA00;
        Tue, 11 Feb 2020 17:03:32 +0000 (UTC)
Date:   Tue, 11 Feb 2020 18:03:31 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200211180331.11dbe525@endymion>
In-Reply-To: <20200211163753.GK2667@lahna.fi.intel.com>
References: <20200210111638.64925c8e@endymion>
        <20200210112326.GP2667@lahna.fi.intel.com>
        <20200211141147.20bad275@endymion>
        <20200211135944.GF2667@lahna.fi.intel.com>
        <20200211172533.08b27181@endymion>
        <20200211163753.GK2667@lahna.fi.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 11 Feb 2020 18:37:53 +0200, Mika Westerberg wrote:
> On Tue, Feb 11, 2020 at 05:25:33PM +0100, Jean Delvare wrote:
> > On Tue, 11 Feb 2020 15:59:44 +0200, Mika Westerberg wrote:  
> > > If the default timeout is short then that might happen but I think WDAT
> > > spec had some "reasonable" lower limit.  
> > 
> > Could you please point me to the WDAT specification? Somehow my web
> > search failed to spot it.  
> 
> You can find it here:
> 
>   http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
> 
> Most of the ACPI related documents not part of the spec itself are
> listed in the following page:
> 
>   https://uefi.org/acpi

Great, thanks for the info.

As I read the specification, it is mandatory to have a timeout >= 5
minutes *if* the watchdog is enabled at boot time. Otherwise the 5
minutes is only a recommendation. I wouldn't be surprised if some
hardware vendors do not initialize the timeout value and assume the OS
will do it for them. Odds are that Windows does that.

Thanks again,
-- 
Jean Delvare
SUSE L3 Support
