Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA24347AB
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJTJMj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 05:12:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:21276 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTJMj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 05:12:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="208835428"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="208835428"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 02:10:25 -0700
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="483642339"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.176])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 02:10:22 -0700
Date:   Wed, 20 Oct 2021 17:17:03 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH v4 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <20211020091703.GA47337@chenyu-desktop>
References: <cover.1634310710.git.yu.c.chen@intel.com>
 <838245e376c7e6fd0fe1ef55d004ed53763846a2.1634310710.git.yu.c.chen@intel.com>
 <YWrrYWeW7uaiJ51u@kroah.com>
 <20211020082939.GA44221@chenyu-desktop>
 <YW/S8N9vR46/wSJY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/S8N9vR46/wSJY@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 20, 2021 at 10:27:28AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 20, 2021 at 04:29:39PM +0800, Chen Yu wrote:
> > > > +ssize_t pfru_log_read(struct file *filp, char __user *ubuf,
> > > > +		      size_t size, loff_t *off)
> > > > +{
> > > > +	struct pfru_log_data_info info;
> > > > +	phys_addr_t base_addr;
> > > > +	int buf_size, ret;
> > > > +	char *buf_ptr;
> > > > +
> > > > +	if (!pfru_log_dev)
> > > > +		return -ENODEV;
> > > > +
> > > > +	if (*off < 0)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ret = get_pfru_log_data_info(&info, pfru_log_dev->info.log_type);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	base_addr = (phys_addr_t)(info.chunk2_addr_lo | (info.chunk2_addr_hi << 32));
> > > > +	/* pfru update has not been launched yet.*/
> > > > +	if (!base_addr)
> > > > +		return -EBUSY;
> > > > +
> > > > +	buf_size = info.max_data_size;
> > > > +	if (*off >= buf_size)
> > > > +		return 0;
> > > > +
> > > > +	buf_ptr = memremap(base_addr, buf_size, MEMREMAP_WB);
> > > > +	if (IS_ERR(buf_ptr))
> > > > +		return PTR_ERR(buf_ptr);
> > > > +
> > > > +	size = min_t(size_t, size, buf_size - *off);
> > > > +	if (copy_to_user(ubuf, buf_ptr + *off, size))
> > > > +		ret = -EFAULT;
> > > > +	else
> > > > +		ret = 0;
> > > 
> > > As all you are doing is mapping some memory and reading from it, why do
> > > you need a read() file operation at all?  Why not just use mmap?
> > > 
> > In the beginning mmap() interface was provided to the user. Then it was
> > realized that there is no guarantee in the spec that, the physical address
> > provided by the BIOS would remain unchanged. So instead of asking the user
> > to mmap the file each time before reading the log, the read() is leveraged
> > here to always memremap() the latest address.
> 
> So you are forced to memremap on _EVERY_ read call because the BIOS can
> change things underneath us without the kernel knowing about it?  How
> does the chunk2_addr_lo and _hi values change while the system is
> running?  Where does that happen, and isn't this going to be a very slow
> and expensive read call all the time?
>
It was not documented in the spec whether the chunk address will change or not,
for safety I changed it from mmap() to read(). I'll try to reach the spec designer
and check if the address will change or not.

thanks,
Chenyu
 
> thanks,
> 
> greg k-h
