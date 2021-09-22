Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042AE41448D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 11:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhIVJLg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Sep 2021 05:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233741AbhIVJLf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Sep 2021 05:11:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F59B6135F;
        Wed, 22 Sep 2021 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632301805;
        bh=Tw+H/INKA6hDKy06eVpzDJMeg1TfBCvc9vMYRHvPtJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTDBPIJ5vHvIVJSA22cSleYy4BbTCoJXrAMQ2zY1Rke6IWXw4/Dy3MZfBAqO8ppes
         HxYHqKCYt3AZQ4PZOwktrStQTvH1VrNppkjw4kPhFzp44dnhIhBf/cA4F8qkppFX/o
         nLSqk9liTju3ThlNwlUbMAlF1PKwROa3CuWD0u1I=
Date:   Wed, 22 Sep 2021 11:10:02 +0200
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
Message-ID: <YUry6tzScXMD007X@kroah.com>
References: <cover.1631802162.git.yu.c.chen@intel.com>
 <90d270c031401430445cb2c4ba1b9b0c265cf9d4.1631802163.git.yu.c.chen@intel.com>
 <YUoBSRrAyaHOCNHb@kroah.com>
 <20210922090442.GA16963@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922090442.GA16963@chenyu5-mobl1>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 22, 2021 at 05:04:42PM +0800, Chen Yu wrote:
> Hi Greg,
> On Tue, Sep 21, 2021 at 05:59:05PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 17, 2021 at 12:02:18AM +0800, Chen Yu wrote:
> > > Introduce the pfru_update driver which can be used for Platform Firmware
> > > Runtime code injection and driver update. The user is expected to provide
> > > the update firmware in the form of capsule file, and pass it to the driver
> > > via ioctl. Then the driver would hand this capsule file to the Platform
> > > Firmware Runtime Update via the ACPI device _DSM method. At last the low
> > > level Management Mode would do the firmware update.
> > > 
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > 
> > Where is the userspace code that uses this ioctl and has tested it out
> > to verify it works properly?  A link to that in the changelog would be
> > great to have.
> > 
> The patch [5/5] is a self testing tool to test the whole feature. I'll send a
> new version and Cc you too.

That tests it, but does not answer the question of who will actually use
this.  What userspace tool needs this new api?

> > > +static void dump_update_result(struct pfru_updated_result *result)
> > > +{
> > > +	pr_debug("Update result:\n");
> > > +	pr_debug("Status:%d\n", result->status);
> > > +	pr_debug("Extended Status:%d\n", result->ext_status);
> > > +	pr_debug("Authentication Time Low:%lld\n", result->low_auth_time);
> > > +	pr_debug("Authentication Time High:%lld\n", result->high_auth_time);
> > > +	pr_debug("Execution Time Low:%lld\n", result->low_exec_time);
> > > +	pr_debug("Execution Time High:%lld\n", result->high_exec_time);
> > 
> > Why not dev_dbg()?  Same for all pr_* calls in this "driver".
> > 
> >
> Ok, I'll switch to dev_dbg() in next version. 
> > > +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > +{
> > > +	void __user *p;
> > > +	int ret = 0, rev;
> > > +
> > > +	p = (void __user *)arg;
> > > +
> > > +	switch (cmd) {
> > > +	case PFRU_IOC_SET_REV:
> > > +		if (copy_from_user(&rev, p, sizeof(unsigned int)))
> > > +			return -EFAULT;
> > > +		if (!pfru_valid_revid(rev))
> > > +			return -EFAULT;
> > > +		pfru_dev->rev_id = rev;
> > > +		break;
> > > +	case PFRU_IOC_STAGE:
> > > +		ret = start_acpi_update(START_STAGE);
> > > +		break;
> > > +	case PFRU_IOC_ACTIVATE:
> > > +		ret = start_acpi_update(START_ACTIVATE);
> > > +		break;
> > > +	case PFRU_IOC_STAGE_ACTIVATE:
> > > +		ret = start_acpi_update(START_STAGE_ACTIVATE);
> > > +		break;
> > > +	default:
> > > +		ret = -ENOIOCTLCMD;
> > 
> > Wrong value :(
> Previously I thought that ENOIOCTLCMD stands for 'invalid ioctl command'.
> After checking the lkml discussion, it seems that ENOIOCTLCMD should not
> be returned to user space. ENOTTY might be more suitible if I understand
> correctly.
> http://lkml.iu.edu/hypermail/linux/kernel/0105.1/0734.html

Yes, ENOTTY is correct.


> > > +		break;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +#ifdef CONFIG_COMPAT
> > > +static long compat_pfru_ioctl(struct file *filep, unsigned int cmd,
> > > +			      unsigned long arg)
> > > +{
> > > +	return pfru_ioctl(filep, cmd, arg);
> > > +}
> > > +#endif
> > 
> > Why is this compat ioctl needed at all?
> > 
> We can not control if the user space tool would be compiled as 32bit.

Then create your ioctl so that a compat ioctl is not needed at all.
There is no need to ever use this for new ioctl commands these days.

> But I realize that a compat_ptr() was missing. Will fix it in next version.
> > > +static struct miscdevice pfru_misc_dev = {
> > > +	.minor = MISC_DYNAMIC_MINOR,
> > > +	.name = "pfru_update",
> > > +	.nodename = "pfru/update",
> > 
> > Why is this in a subdirectory?  What requires this?  Why not just
> > "pfru"?
> > 
> The pfru directory might be reused for pfru_telemetry device, whose driver
> is in 4/5 patch, I'll Cc you with the whole patch set in next version.

"might be" is not a valid reason.  Why does this simple driver deserve a
whole /dev/ subdirectory?

thanks,

greg k-h
