Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EA434648
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTH4W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 03:56:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:36141 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTH4W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 03:56:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="228990377"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="228990377"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 00:54:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="444262151"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 00:53:59 -0700
Date:   Wed, 20 Oct 2021 16:00:40 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211020080040.GA43094@chenyu-desktop>
References: <cover.1634310710.git.yu.c.chen@intel.com>
 <eadc25933400c71a52e7d176880df09a147a39b9.1634310710.git.yu.c.chen@intel.com>
 <YWrswQ+ETMthZZVk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWrswQ+ETMthZZVk@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 16, 2021 at 05:16:17PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 16, 2021 at 06:40:51PM +0800, Chen Yu wrote:
> > Introduce the pfru_update driver which can be used for Platform Firmware
> > Runtime code injection and driver update[1]. The user is expected to
> > provide the update firmware in the form of capsule file, and pass it to
> > the driver via ioctl. Then the driver would hand this capsule file to the
> > Platform Firmware Runtime Update via the ACPI device _DSM method. At last
> > the low level Management Mode would do the firmware update.
> > 
> > [1] https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf
> > 
[snip...]
> 
> Do we normally describe ioctl interfaces in Documentation/ABI/?  Why not
> just add this to the kernel doc with the structures you are creating?
> Wouldn't that be easier?
> 
Ok, will move these comments into kernel doc in pfru.h.
> Or are other acpi ioctl interfaces documented here already?
> 
No other acpi ioctl interfaces, but there are some non-acpi
ioctl interfaces, such as rtc-cdev.
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 2e8134059c87..6e5a82fff408 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -365,6 +365,7 @@ Code  Seq#    Include File                                           Comments
> >                                                                       <mailto:aherrman@de.ibm.com>
> >  0xE5  00-3F  linux/fuse.h
> >  0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
> > +0xEE  00-1F  uapi/linux/pfru.h                                       Platform Firmware Runtime Update and Telemetry
> 
> You are not using all of those values, right?
> 
Not using all of them, will shrink the range to 8 in next
version.
> >  0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
> >
[snip...]                                                                       <mailto:thomas@winischhofer.net>
> > +
> > +struct pfru_device {
> > +	guid_t uuid, code_uuid, drv_uuid;
> > +	int rev_id;
> > +	struct device *dev;
> > +};
> > +
> > +static struct pfru_device *pfru_dev;
> 
> Why is this a single variable?  Shouldn't this be per-device as the bus
> provides it to you?
>
[snip...] 
> > +
> > +static int acpi_pfru_probe(struct platform_device *pdev)
> > +{
> > +	acpi_handle handle;
> > +	int ret;
> > +
> > +	/* Only one instance is allowed. */
> > +	if (pfru_dev)
> > +		return 0;
> 
> Why is only one instance allowed?  Why add extra work to do this when it
> really is not needed at all?  It is simpler and less code to make it so
> that there is no restriction like this at all.
> 
> Also, the return value is incorrect, so your implementaion of trying to
> keep only one instance does not work properly :(
> 
Ok, I'll change it to per-device in next version. And the motivation of
using a single variable was that:
There would be only one instance of PFRU ACPI object and one PFRU Telemetry
ACPI object provided by BIOS, otherwise it is regarded as a BIOS bug for now.
But since per-device variable is more acceptable and scalable, will change
it to per-device in next version.
[snip...]
> > +};
> > +
[snip...]
> > +static int __init pfru_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = misc_register(&pfru_misc_dev);
> > +	if (ret)
> > +		return ret;
> > +
> 
> Why register this here, BEFORE you have a real device?  That looks like
> a big race condition here :(
> 
> Register it per device you have in the system please.
>
Ok.
Previously the pfru_misc_dev is shared between the PFRU device and
PFRU Telemetry device, so that the PFRU device is accessed via
pfru_misc_dev.write() and PFRU device is accessed via pfru_misc_dev.read().
The benefit of doing this is that, the user only deals with one misc_dev node
rather than two. Changing this to per-device scope would generate two misc_dev
nodes, and the user needs to deal with them respectively, but with better
scalability and less race condition. I'll revise it in next version.

Thanks,
Chenyu
> thanks,
> 
> greg k-h
