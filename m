Return-Path: <linux-acpi+bounces-6012-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404218D0E88
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 22:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0FF280EC2
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 20:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80BD22318;
	Mon, 27 May 2024 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iynXkjA6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB852FC12;
	Mon, 27 May 2024 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716840943; cv=none; b=VjIhgwF2+B+H17L32YRXIgm9IrkFSPiGmsVh4nCY0YlWsBvUfxdQupEFS5sW+i5fhteuYTYB/aYNHrTC0ms27hGrY1bCejvtkf9GHe47aivARf90vWQ347/kIa3LuMwMTTE0Cxdt3jdECJ5GSk9GjzTiz7A7x+jMx+gCJO/cc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716840943; c=relaxed/simple;
	bh=clAc0glAG+FdzsTbysKZU8GdPk0PzethWuZGkjC7mjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRv9LTxUwkShPGUfYuwSvODiPs13THLscofxZD69mAzRfeZyLV8/aLCQM+ymkB85B+cBkh4uFUGmtBvjZPt+BAxfgX0QE5WJI0JLewyS49j/HhD3+L8xbQ5gVaDyDyKFYZ3OklPRffX4k8uT7h5doH9MOzwyytyYSip3Zv0Il9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iynXkjA6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716840942; x=1748376942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=clAc0glAG+FdzsTbysKZU8GdPk0PzethWuZGkjC7mjw=;
  b=iynXkjA69Q1twfd0AE1UijUXw7rt73xHxlBuopgOlUJiNLQEwfoc+Z7g
   Uwi4iBUHuV7c13G4UtSxbFGYoYCihUBtobvgJq1T1Sd3R1X/7+K6InNmF
   A/9crJQ9BVQupF8Cj+r//eZSnj8BIdTmE4B/HiY7UqUM/DCjikKZVwI2M
   DLmjsc2AzlrvdY+gSVjjAhxP2aPaBr31yLoy4xVQyADQOjW8FuDVnVmV6
   60pJSwHFYH8kqEcGpnkCmdhKp2XAPd4x1sO5ltTJijINvGqJjAM/MxJLO
   n0/OKVyiwVg2o7s8UK+PVyMB1Jrkd0ERcI2f4fTaF0nXc9DU/Fe7WY2qh
   w==;
X-CSE-ConnectionGUID: zw0w8ujrR3qd7tHaCF28uw==
X-CSE-MsgGUID: /MoLDLMURwyHHAxnwl7LnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13293960"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13293960"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 13:15:41 -0700
X-CSE-ConnectionGUID: 5rdLFS3LRSGQVhJ1wldX1Q==
X-CSE-MsgGUID: nV82EXoASdKMiCik2rxfcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35340224"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 13:15:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1sBgko-0000000BMVg-203o;
	Mon, 27 May 2024 23:15:34 +0300
Date: Mon, 27 May 2024 23:15:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Woody Suwalski <terraluna977@gmail.com>
Cc: Guanbing Huang <albanhuang@outlook.com>, gregkh@linuxfoundation.org,
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
	tony@atomide.com, john.ogness@linutronix.de,
	yangyicong@hisilicon.com, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn, albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: Re: Kernel 6.10-rc1 b,Build error with [PATCH v5 2/3] serial: port:
 Add support of PNP IRQ
Message-ID: <ZlTp5lGiT3pNF_di@smile.fi.intel.com>
References: <cover.1712472167.git.albanhuang@tencent.com>
 <PSAPR06MB4952C4112E75D882AC61CA5EC9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
 <cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 27, 2024 at 03:44:42PM -0400, Woody Suwalski wrote:
> Guanbing Huang wrote:
> > From: Guanbing Huang <albanhuang@tencent.com>
> > 
> > The function __uart_read_properties doesn't cover PNP devices, so add IRQ
> > processing for PNP devices in the branch.

...

> >   #include <linux/property.h>
> >   #include <linux/serial_core.h>
> >   #include <linux/spinlock.h>
> > @@ -221,7 +222,11 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
> >   	if (dev_is_platform(dev))
> >   		ret = platform_get_irq(to_platform_device(dev), 0);
> > -	else
> > +	else if (dev_is_pnp(dev)) {
> > +		ret = pnp_irq(to_pnp_dev(dev), 0);
> > +		if (ret < 0)
> > +			ret = -ENXIO;
> > +	} else
> >   		ret = fwnode_irq_get(dev_fwnode(dev), 0);
> >   	if (ret == -EPROBE_DEFER)
> >   		return ret;
> 
> Hello all, trying to build 6.10-rc1 fails for me in serial_base.o:
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC [M]  drivers/tty/serial/serial_port.o
>   LD [M]  drivers/tty/serial/serial_base.o
>   MODPOST Module.symvers
> ERROR: modpost: "pnp_bus_type" [drivers/tty/serial/serial_base.ko]
> undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: ***
> [/woody/src/kernels/linux-6.10-pingu/work/linux-6.10/Makefile:1892: modpost]
> Error 2
> make: *** [Makefile:246: __sub-make] Error 2
> 
> Reversing the patch "fixes" the problem :-(
> I am building on a Debian bookworm system, gcc 12.2
> 
> Any suggestions  how to make it work?

Yes, I will send a patch soon. Thanks for the report!

-- 
With Best Regards,
Andy Shevchenko



