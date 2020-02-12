Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43015A759
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 12:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgBLLFt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 06:05:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:41300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgBLLFt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 06:05:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 243ADAC6B;
        Wed, 12 Feb 2020 11:05:47 +0000 (UTC)
Date:   Wed, 12 Feb 2020 12:05:45 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: wdat_wdt: access width inconsistency
Message-ID: <20200212120545.56e8ec42@endymion>
In-Reply-To: <20200212104747.GR2667@lahna.fi.intel.com>
References: <20200210111638.64925c8e@endymion>
        <20200210112326.GP2667@lahna.fi.intel.com>
        <20200212113030.1c5c9524@endymion>
        <20200212104747.GR2667@lahna.fi.intel.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 12 Feb 2020 12:47:47 +0200, Mika Westerberg wrote:
> On Wed, Feb 12, 2020 at 11:30:30AM +0100, Jean Delvare wrote:
> > (The underlying question being: can I get rid of that ALIGN()
> > altogether while fixing the gas->access_width misuse bug?)  
> 
> I think the ALIGN() was there just because I did not realize that
> access_width is 3 and not 4 for 32-bit memory. So it is not needed.
> 
> I actually have a patch series that should fix this and the other issue
> you found (I found a couple of spare cycles in the morning) so if you
> don't mind I'll submit them soon.

Sure please do, I don't care about ownership, I only want these bugs to
be fixed. I got myself side-tracked by another issue at work this
morning.

I'll be happy to review your changes.

-- 
Jean Delvare
SUSE L3 Support
