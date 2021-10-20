Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C3B4346D8
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJTI3p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 04:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhJTI3o (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 04:29:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EC7861183;
        Wed, 20 Oct 2021 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634718451;
        bh=tjJaMT06OgqJgZOqhhTYFFfdNV2/IZCCyibymMKlwKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhqiJqs4BrlBYOvw79caWmgWe7IJYDqZ0SakTJvXfACSYVk43ygWpU5a2oj4oStof
         puxDOmyPBtcZ9auy/X20yuSHYVATqPf0zDECSwZ5Te7xdOPwLtOiY1Z/CgI2TuGF69
         BA7MnTq81dBj85t14jl/ic6hvcIroUHxT40EZ1QI=
Date:   Wed, 20 Oct 2021 10:27:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH v4 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <YW/S8N9vR46/wSJY@kroah.com>
References: <cover.1634310710.git.yu.c.chen@intel.com>
 <838245e376c7e6fd0fe1ef55d004ed53763846a2.1634310710.git.yu.c.chen@intel.com>
 <YWrrYWeW7uaiJ51u@kroah.com>
 <20211020082939.GA44221@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020082939.GA44221@chenyu-desktop>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 20, 2021 at 04:29:39PM +0800, Chen Yu wrote:
> > > +ssize_t pfru_log_read(struct file *filp, char __user *ubuf,
> > > +		      size_t size, loff_t *off)
> > > +{
> > > +	struct pfru_log_data_info info;
> > > +	phys_addr_t base_addr;
> > > +	int buf_size, ret;
> > > +	char *buf_ptr;
> > > +
> > > +	if (!pfru_log_dev)
> > > +		return -ENODEV;
> > > +
> > > +	if (*off < 0)
> > > +		return -EINVAL;
> > > +
> > > +	ret = get_pfru_log_data_info(&info, pfru_log_dev->info.log_type);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	base_addr = (phys_addr_t)(info.chunk2_addr_lo | (info.chunk2_addr_hi << 32));
> > > +	/* pfru update has not been launched yet.*/
> > > +	if (!base_addr)
> > > +		return -EBUSY;
> > > +
> > > +	buf_size = info.max_data_size;
> > > +	if (*off >= buf_size)
> > > +		return 0;
> > > +
> > > +	buf_ptr = memremap(base_addr, buf_size, MEMREMAP_WB);
> > > +	if (IS_ERR(buf_ptr))
> > > +		return PTR_ERR(buf_ptr);
> > > +
> > > +	size = min_t(size_t, size, buf_size - *off);
> > > +	if (copy_to_user(ubuf, buf_ptr + *off, size))
> > > +		ret = -EFAULT;
> > > +	else
> > > +		ret = 0;
> > 
> > As all you are doing is mapping some memory and reading from it, why do
> > you need a read() file operation at all?  Why not just use mmap?
> > 
> In the beginning mmap() interface was provided to the user. Then it was
> realized that there is no guarantee in the spec that, the physical address
> provided by the BIOS would remain unchanged. So instead of asking the user
> to mmap the file each time before reading the log, the read() is leveraged
> here to always memremap() the latest address.

So you are forced to memremap on _EVERY_ read call because the BIOS can
change things underneath us without the kernel knowing about it?  How
does the chunk2_addr_lo and _hi values change while the system is
running?  Where does that happen, and isn't this going to be a very slow
and expensive read call all the time?

thanks,

greg k-h
