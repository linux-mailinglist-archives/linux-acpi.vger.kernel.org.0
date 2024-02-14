Return-Path: <linux-acpi+bounces-3487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE83C8550AF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B73BB27157
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8F48662C;
	Wed, 14 Feb 2024 17:46:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C787C086;
	Wed, 14 Feb 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932809; cv=none; b=LQKJFNiiaT58UWrkaWaQ2a6VCvGYNGggyeUcmtpDXID1ck+1lJBbBHUG/aVlZELBVkpkSMowIr1K7qdHo1uuioIP7Gh5FPpROAOVkRgF0QJ08cMwEbqX5eouv+st3+yZTmXFzWktquwzstd0PsRWkFtcyDQZoZ825og5uP2ay7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932809; c=relaxed/simple;
	bh=S4hCFjijhtZg2TSPM1wryhLLA6baKq9lg+OqRu1GsM8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jurhtFsUWPDB4XFf0Us84laTitEzF1Y4fjfm1OQa/wHb7SVb24UNEB+28wIzG+O9zex2A2BtUdBBzGw9lUGkkyC1bNqWhboXDGhxWCBd7Zd1QWkhrFk0cTbyjVKS4a4IN/ssaV+T6GqngwabxH24EqXKkD8/zew894UlaiZW77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZls06LZHz6JB0Y;
	Thu, 15 Feb 2024 01:42:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 04679141194;
	Thu, 15 Feb 2024 01:46:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 17:46:44 +0000
Date: Wed, 14 Feb 2024 17:46:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <20240214174643.00004caf@Huawei.com>
In-Reply-To: <dd996549-dd52-4181-ba62-a1a8a2a18a35@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
	<20240208200042.432958-4-Benjamin.Cheatham@amd.com>
	<20240214152759.000076ec@Huawei.com>
	<dd996549-dd52-4181-ba62-a1a8a2a18a35@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 10:41:00 -0600
Ben Cheatham <benjamin.cheatham@amd.com> wrote:

> On 2/14/24 9:27 AM, Jonathan Cameron wrote:
> > On Thu, 8 Feb 2024 14:00:41 -0600
> > Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> >   
> >> Implement CXL helper functions in the EINJ module for getting/injecting
> >> available CXL protocol error types and export them to sysfs under
> >> kernel/debug/cxl.
> >>
> >> The kernel/debug/cxl/einj_types file will print the available CXL
> >> protocol errors in the same format as the available_error_types
> >> file provided by the EINJ module. The
> >> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> >> error_type and error_inject files provided by the EINJ module, i.e.:
> >> writing an error type into $dport_dev/einj_inject will inject said error
> >> type into the CXL dport represented by $dport_dev.
> >>
> >> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>  
> > Hi Ben,
> > 
> > Sorry I've not looked at this sooner.
> > 
> > Anyhow, some comments inline. Mostly looks good to me.
> > 
> > Jonathan
> >   
> >> ---
> >>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
> >>  MAINTAINERS                           |   1 +
> >>  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
> >>  drivers/cxl/core/port.c               |  39 +++++++
> >>  include/linux/einj-cxl.h              |  45 ++++++++
> >>  5 files changed, 255 insertions(+), 10 deletions(-)
> >>  create mode 100644 include/linux/einj-cxl.h
> >>
> >> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> >> index fe61d372e3fa..bcd985cca66a 100644
> >> --- a/Documentation/ABI/testing/debugfs-cxl
> >> +++ b/Documentation/ABI/testing/debugfs-cxl
> >> @@ -33,3 +33,25 @@ Description:
> >>  		device cannot clear poison from the address, -ENXIO is returned.
> >>  		The clear_poison attribute is only visible for devices
> >>  		supporting the capability.
> >> +
> >> +What:		/sys/kernel/debug/cxl/einj_types
> >> +Date:		January, 2024
> >> +KernelVersion:	v6.9
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(RO) Prints the CXL protocol error types made available by
> >> +		the platform in the format "0x<error number>	<error type>".
> >> +		The <error number> can be written to einj_inject to inject
> >> +		<error type> into a chosen dport.  
> > 
> > I think it's a limited set, so docs could include what the error_type values can
> > be?  From this description it's not obvious they are human readable strings.
> >   
> 
> It is a limited set, but that set has 6 variants. It may make the description
> a bit long to include all of them, but I could include an example string instead?
> If length isn't an issue then I can add them all in.

Example works.

> 
> >> +
> >> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
> >> +Date:		January, 2024
> >> +KernelVersion:	v6.9
> >> +Contact:	linux-cxl@vger.kernel.org
> >> +Description:
> >> +		(WO) Writing an integer to this file injects the corresponding
> >> +		CXL protocol error into $dport_dev ($dport_dev will be a device
> >> +		name from /sys/bus/pci/devices). The integer to type mapping for
> >> +		injection can be found by reading from einj_types. If the dport
> >> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
> >> +		a CXL 2.0 error is injected.
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 9104430e148e..02d7feb2ed1f 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
> >>  S:	Maintained
> >>  F:	drivers/cxl/
> >>  F:	include/uapi/linux/cxl_mem.h
> >> +F:  include/linux/einj-cxl.h
> >>  F:	tools/testing/cxl/
> >>  
> >>  COMPUTE EXPRESS LINK PMU (CPMU)
> >> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> >> index 73dde21d3e89..9137cc01f791 100644
> >> --- a/drivers/acpi/apei/einj.c
> >> +++ b/drivers/acpi/apei/einj.c
> >> @@ -21,6 +21,7 @@
> >>  #include <linux/nmi.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/mm.h>
> >> +#include <linux/einj-cxl.h>
> >>  #include <linux/platform_device.h>
> >>  #include <asm/unaligned.h>
> >>  
> >> @@ -37,6 +38,20 @@
> >>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
> >>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> >>  				ACPI_EINJ_MEMORY_FATAL)
> >> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
> >> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
> >> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
> >> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
> >> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
> >> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
> >> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
> >> +#endif
> >> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
> >> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
> >> +				ACPI_EINJ_CXL_CACHE_FATAL | \
> >> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
> >> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
> >> +				ACPI_EINJ_CXL_MEM_FATAL)
> >>  
> >>  /*
> >>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
> >> @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> >>  	if (type & ACPI5_VENDOR_BIT) {
> >>  		if (vendor_flags != SETWA_FLAGS_MEM)
> >>  			goto inject;
> >> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
> >> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
> >>  		goto inject;
> >> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
> >> +		goto inject;
> >> +	}
> >>  
> >>  	/*
> >>  	 * Disallow crazy address masks that give BIOS leeway to pick
> >> @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
> >>  	"0x00000200\tPlatform Correctable\n",
> >>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
> >>  	"0x00000800\tPlatform Uncorrectable fatal\n",
> >> +};
> >> +
> >> +static const char * const einj_cxl_error_type_string[] = {
> >>  	"0x00001000\tCXL.cache Protocol Correctable\n",
> >>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
> >>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
> >> @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
> >>  
> >>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
> >>  
> >> -static int error_type_get(void *data, u64 *val)
> >> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> >>  {
> >> -	*val = error_type;
> >> +	int cxl_err, rc;
> >> +	u32 available_error_type = 0;
> >> +
> >> +	if (!einj_initialized)
> >> +		return -ENXIO;
> >> +
> >> +	rc = einj_get_available_error_type(&available_error_type);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {  
> > 
> > Trivial so feel free to ignore but, I'd stick to local styles and have pos
> > declared in more traditional c style.
> >   
> 
> Will do.
> 
> >> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;  
> > 
> > Maybe clearer as
> > 		cxl_err = FIELD_PREP(CXL_ERROR_MASK, BIT(pos));
> >   
> 
> I'll think about it. I think I agree with you, but I've seen a good amount of
> people who aren't familiar with the FIELD_* macros in which case it isn't much clearer.

Lets teach them ;)


