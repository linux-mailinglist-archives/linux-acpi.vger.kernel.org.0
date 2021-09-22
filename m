Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0C41447A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhIVJG0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Sep 2021 05:06:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:35756 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234071AbhIVJG0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Sep 2021 05:06:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="284563479"
X-IronPort-AV: E=Sophos;i="5.85,313,1624345200"; 
   d="scan'208";a="284563479"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 02:04:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,313,1624345200"; 
   d="scan'208";a="550173400"
Received: from liaol-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.173.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 02:04:46 -0700
Date:   Wed, 22 Sep 2021 17:04:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20210922090442.GA16963@chenyu5-mobl1>
References: <cover.1631802162.git.yu.c.chen@intel.com>
 <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
 <YUoBSRrAyaHOCNHb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUoBSRrAyaHOCNHb@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Greg,
On Tue, Sep 21, 2021 at 05:59:05PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 17, 2021 at 12:02:18AM +0800, Chen Yu wrote:
> > Introduce the pfru_update driver which can be used for Platform Firmware
> > Runtime code injection and driver update. The user is expected to provide
> > the update firmware in the form of capsule file, and pass it to the driver
> > via ioctl. Then the driver would hand this capsule file to the Platform
> > Firmware Runtime Update via the ACPI device _DSM method. At last the low
> > level Management Mode would do the firmware update.
> > 
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> Where is the userspace code that uses this ioctl and has tested it out
> to verify it works properly?  A link to that in the changelog would be
> great to have.
> 
The patch [5/5] is a self testing tool to test the whole feature. I'll send a
new version and Cc you too.
> > +static void dump_update_result(struct pfru_updated_result *result)
> > +{
> > +	pr_debug("Update result:\n");
> > +	pr_debug("Status:%d\n", result->status);
> > +	pr_debug("Extended Status:%d\n", result->ext_status);
> > +	pr_debug("Authentication Time Low:%lld\n", result->low_auth_time);
> > +	pr_debug("Authentication Time High:%lld\n", result->high_auth_time);
> > +	pr_debug("Execution Time Low:%lld\n", result->low_exec_time);
> > +	pr_debug("Execution Time High:%lld\n", result->high_exec_time);
> 
> Why not dev_dbg()?  Same for all pr_* calls in this "driver".
> 
>
Ok, I'll switch to dev_dbg() in next version. 
> > +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +	void __user *p;
> > +	int ret = 0, rev;
> > +
> > +	p = (void __user *)arg;
> > +
> > +	switch (cmd) {
> > +	case PFRU_IOC_SET_REV:
> > +		if (copy_from_user(&rev, p, sizeof(unsigned int)))
> > +			return -EFAULT;
> > +		if (!pfru_valid_revid(rev))
> > +			return -EFAULT;
> > +		pfru_dev->rev_id = rev;
> > +		break;
> > +	case PFRU_IOC_STAGE:
> > +		ret = start_acpi_update(START_STAGE);
> > +		break;
> > +	case PFRU_IOC_ACTIVATE:
> > +		ret = start_acpi_update(START_ACTIVATE);
> > +		break;
> > +	case PFRU_IOC_STAGE_ACTIVATE:
> > +		ret = start_acpi_update(START_STAGE_ACTIVATE);
> > +		break;
> > +	default:
> > +		ret = -ENOIOCTLCMD;
> 
> Wrong value :(
Previously I thought that ENOIOCTLCMD stands for 'invalid ioctl command'.
After checking the lkml discussion, it seems that ENOIOCTLCMD should not
be returned to user space. ENOTTY might be more suitible if I understand
correctly.
http://lkml.iu.edu/hypermail/linux/kernel/0105.1/0734.html
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +#ifdef CONFIG_COMPAT
> > +static long compat_pfru_ioctl(struct file *filep, unsigned int cmd,
> > +			      unsigned long arg)
> > +{
> > +	return pfru_ioctl(filep, cmd, arg);
> > +}
> > +#endif
> 
> Why is this compat ioctl needed at all?
> 
We can not control if the user space tool would be compiled as 32bit.
But I realize that a compat_ptr() was missing. Will fix it in next version.
> > +static struct miscdevice pfru_misc_dev = {
> > +	.minor = MISC_DYNAMIC_MINOR,
> > +	.name = "pfru_update",
> > +	.nodename = "pfru/update",
> 
> Why is this in a subdirectory?  What requires this?  Why not just
> "pfru"?
> 
The pfru directory might be reused for pfru_telemetry device, whose driver
is in 4/5 patch, I'll Cc you with the whole patch set in next version.

Thanks,
Chenyu
