Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BD414F0F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhIVR36 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Sep 2021 13:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236781AbhIVR36 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Sep 2021 13:29:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FB0B60F6E;
        Wed, 22 Sep 2021 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632331707;
        bh=qxovthTWLhunV065wb5c2FjpbJJiZfXE4TdmvsvSDMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQcu/pDhXL13HNpmyzQqZTcSJ2/6tD4xoWby1IDx6WkYy/HNINa13EjrrebrKg8UE
         oLbnjsUYWbhTtTeq1wDfKapMrX5x8BLN0g99OM7YibV/gsG0xhk6Smi0cQGY8Xe0nn
         Jo4Z7MbPAaLLSS7BiwRSQ/ZDI3kzhVJWycxSsRVk=
Date:   Wed, 22 Sep 2021 19:28:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 3/5] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YUtnuW22MH97p7+G@kroah.com>
References: <cover.1631802162.git.yu.c.chen@intel.com>
 <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
 <YUoBSRrAyaHOCNHb@kroah.com>
 <20210922090442.GA16963@chenyu5-mobl1>
 <YUry6tzScXMD007X@kroah.com>
 <20210922163321.GA31068@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922163321.GA31068@chenyu5-mobl1>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 23, 2021 at 12:33:21AM +0800, Chen Yu wrote:
> On Wed, Sep 22, 2021 at 11:10:02AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 22, 2021 at 05:04:42PM +0800, Chen Yu wrote:
> > > Hi Greg,
> > > On Tue, Sep 21, 2021 at 05:59:05PM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Sep 17, 2021 at 12:02:18AM +0800, Chen Yu wrote:
> > > > > Introduce the pfru_update driver which can be used for Platform Firmware
> > > > > Runtime code injection and driver update. The user is expected to provide
> > > > > the update firmware in the form of capsule file, and pass it to the driver
> > > > > via ioctl. Then the driver would hand this capsule file to the Platform
> > > > > Firmware Runtime Update via the ACPI device _DSM method. At last the low
> > > > > level Management Mode would do the firmware update.
> > > > > 
> > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > 
> > > > Where is the userspace code that uses this ioctl and has tested it out
> > > > to verify it works properly?  A link to that in the changelog would be
> > > > great to have.
> > > > 
> > > The patch [5/5] is a self testing tool to test the whole feature. I'll send a
> > > new version and Cc you too.
> > 
> > That tests it, but does not answer the question of who will actually use
> > this.  What userspace tool needs this new api?
> >
> One end user is the cloud user.

What exactly do you mean by "cloud user"?

> Currently there is no dedicated userspace tool developed to use this
> feature AFAIK.

Wonderful, then it is not needed to be added to the kernel :)

> It was expected that the end users
> could refer to the self test tool to customize their tools. I'm not sure if
> this is the proper way to propose the feature, may I have your suggestion on
> this, should I create a separate git repository for this tool, or put it in
> tools/selftestings as it is now?

No, do not add this to the kernel unless you have a real need and user
for this.


> > > > > +static struct miscdevice pfru_misc_dev = {
> > > > > +	.minor = MISC_DYNAMIC_MINOR,
> > > > > +	.name = "pfru_update",
> > > > > +	.nodename = "pfru/update",
> > > > 
> > > > Why is this in a subdirectory?  What requires this?  Why not just
> > > > "pfru"?
> > > > 
> > > The pfru directory might be reused for pfru_telemetry device, whose driver
> > > is in 4/5 patch, I'll Cc you with the whole patch set in next version.
> > 
> > "might be" is not a valid reason.  Why does this simple driver deserve a
> > whole /dev/ subdirectory?
> > 
> There are pfru_update and pfru_telemetry in the patch, and there is plan to
> add a pfru_prm device in the future, which stands for "Platform Runtime Mechanism".
> I'll move them to /dev/ in next version.

That is a very generic name for a very platform specific and arch
specific interface.  As this is an ACPI interface, why not use that name
prefix?

thanks,

greg k-h
