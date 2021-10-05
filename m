Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BBB421D20
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Oct 2021 06:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhJEEKc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Oct 2021 00:10:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:5183 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhJEEKb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Oct 2021 00:10:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206462198"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="206462198"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 21:08:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="487835896"
Received: from yilai-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.172.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 21:08:35 -0700
Date:   Tue, 5 Oct 2021 12:08:31 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211005040831.GA7134@chenyu5-mobl1>
References: <cover.1631802162.git.yu.c.chen@intel.com>
 <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
 <YUoBSRrAyaHOCNHb@kroah.com>
 <20210922090442.GA16963@chenyu5-mobl1>
 <YUry6tzScXMD007X@kroah.com>
 <20210922163321.GA31068@chenyu5-mobl1>
 <YUtnuW22MH97p7+G@kroah.com>
 <CAJZ5v0gDHA34a+4pO7Pb8=wc7FPiMvDj9k7WrO0Cc8mcMNzMxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gDHA34a+4pO7Pb8=wc7FPiMvDj9k7WrO0Cc8mcMNzMxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 27, 2021 at 07:40:39PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 22, 2021 at 7:28 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 23, 2021 at 12:33:21AM +0800, Chen Yu wrote:
> > > On Wed, Sep 22, 2021 at 11:10:02AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 22, 2021 at 05:04:42PM +0800, Chen Yu wrote:
> > > > > Hi Greg,
> > > > > On Tue, Sep 21, 2021 at 05:59:05PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Fri, Sep 17, 2021 at 12:02:18AM +0800, Chen Yu wrote:
> > > > > > > Introduce the pfru_update driver which can be used for Platform Firmware
> > > > > > > Runtime code injection and driver update. The user is expected to provide
> > > > > > > the update firmware in the form of capsule file, and pass it to the driver
> > > > > > > via ioctl. Then the driver would hand this capsule file to the Platform
> > > > > > > Firmware Runtime Update via the ACPI device _DSM method. At last the low
> > > > > > > level Management Mode would do the firmware update.
> > > > > > >
> > > > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > > >
> > > > > > Where is the userspace code that uses this ioctl and has tested it out
> > > > > > to verify it works properly?  A link to that in the changelog would be
> > > > > > great to have.
> > > > > >
> > > > > The patch [5/5] is a self testing tool to test the whole feature. I'll send a
> > > > > new version and Cc you too.
> > > >
> > > > That tests it, but does not answer the question of who will actually use
> > > > this.  What userspace tool needs this new api?
> > > >
> > > Currently there is no dedicated userspace tool developed to use this
> > > feature AFAIK.
> >
> > Wonderful, then it is not needed to be added to the kernel :)
> >
[snip]
> > > It was expected that the end users
> > > could refer to the self test tool to customize their tools. I'm not sure if
> > > this is the proper way to propose the feature, may I have your suggestion on
> > > this, should I create a separate git repository for this tool, or put it in
> > > tools/selftestings as it is now?
> >
> > No, do not add this to the kernel unless you have a real need and user
> > for this.
After revisiting this patch set, I'll revise it to better describe the background
and usage model, and also propose the user space tool to fully demonstrate how to
use this feature.

thanks,
Chenyu
