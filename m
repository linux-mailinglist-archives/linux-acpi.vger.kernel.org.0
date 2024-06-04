Return-Path: <linux-acpi+bounces-6167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9398FAE4F
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D036B1F21731
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A91428F5;
	Tue,  4 Jun 2024 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtKnAfY7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE600652;
	Tue,  4 Jun 2024 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492055; cv=none; b=NVX+G/X4ndqQLGy94uPybEKuVIIrnfq6qIl29H2KJjnc0fVK9EC56ojEcNMPJyILTlygEA8Hj2gR2NgQdx9aPF7AEgZTTRsvZkSbGl8fZfo72mvwjFPzdWixeofWr8nzbZocpVt9h60RDA204EUAdnkmlZTEJpwDNuYIfoXUPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492055; c=relaxed/simple;
	bh=Xg+xyBVglqm1CDvE9OvKFmymdQyuCmkD8Qc5BsZZmqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tae0r0/3o58Xnqf+nxwI2AsjDX4R1elUHeuoNiLez/a3cj7GViMA/fxkE2v3eCMgdw5/Mwyt5TgtpQby8NsO9HQ9wyt1SD3EVa77n6hjdGhZaDif4981db4H/TCxcgSSGXu7JD7nVKaZ+ElZoqkpwvAGFge+6/8VsvFQFhBlXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtKnAfY7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717492054; x=1749028054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xg+xyBVglqm1CDvE9OvKFmymdQyuCmkD8Qc5BsZZmqo=;
  b=DtKnAfY7uS84740fj2Pdgooegm2knAhu6zO740OgB4c7vPqGU0kuzJWi
   PT1FQFtbMJ9Xvb4Xnw/5G37FE2ckcqM2N6tfA+IuTXOX9uHRcuBzeTr7k
   D7vZ4aC1OYcEQU1ifIq92O0u8HXJholracShDg9pGgfIlltANd2dI8IXK
   jGYMv0Hwmi3ED0R1WmNhr/pQxasxOZPS8LzeLvRsrqEkh01Rj5r89uMjn
   FDZoJiFdfSdGQmgc79yZgB6RfMdTbPHzQ+/rpfpDzrrsMbPK4efAQM7Yd
   ocHePyd8aGYLUvNzbdOCwu3Wh6j2RlKejs6Tpf6TJ8QarPoAUzZODYj+5
   A==;
X-CSE-ConnectionGUID: VBKfi6UPTIKfvnJi35Fonw==
X-CSE-MsgGUID: jxgqsRKWS9q5j2/BYWIRVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24600606"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="24600606"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:07:33 -0700
X-CSE-ConnectionGUID: uuTM2SaRRe2OTeCP2tTjtw==
X-CSE-MsgGUID: 9meULxaPT2+BQa75AqeKYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="41720067"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:07:31 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7292411FA4A;
	Tue,  4 Jun 2024 12:07:28 +0300 (EEST)
Date: Tue, 4 Jun 2024 09:07:28 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Wentong Wu <wentong.wu@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, Kate Hsuan <hpa@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: vsc: Fix wrong invocation of ACPI SID method
Message-ID: <Zl7ZUOOj12zkDSik@kekkonen.localdomain>
References: <20240603205050.505389-1-hdegoede@redhat.com>
 <Zl42vYs40MJiPxl7@kekkonen.localdomain>
 <77625f15-e183-49e8-8496-b12002cc7dbb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77625f15-e183-49e8-8496-b12002cc7dbb@redhat.com>

Hi Hans,

On Tue, Jun 04, 2024 at 11:00:10AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/3/24 11:33 PM, Sakari Ailus wrote:
> > Hi Hans,
> > 
> > Thanks for the patch.
> > 
> > On Mon, Jun 03, 2024 at 10:50:50PM +0200, Hans de Goede wrote:
> >> When using an initializer for a union only one of the union members
> >> must be initialized. The initializer for the acpi_object union variable
> >> passed as argument to the SID ACPI method was initializing both
> >> the type and the integer members of the union.
> >>
> >> Unfortunately rather then complaining about this gcc simply ignores
> >> the first initializer and only used the second integer.value = 1
> >> initializer. Leaving type set to 0 which leads to the argument being
> >> skipped by acpi acpi_ns_evaluate() resulting in:
> >>
> >> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments -
> >> Caller passed 0, method requires 1 (20240322/nsarguments-232)
> >>
> >> Fix this by initializing only the integer struct part of the union
> >> and initializing both members of the integer struct.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Even though this is a one-liner, figuring out what was actually going
> >> wrong here took quite a while.
> > 
> > I was wondering this with Wentong, too...!
> > 
> >> ---
> >>  drivers/misc/mei/vsc-fw-loader.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
> >> index ffa4ccd96a10..596a9d695dfc 100644
> >> --- a/drivers/misc/mei/vsc-fw-loader.c
> >> +++ b/drivers/misc/mei/vsc-fw-loader.c
> >> @@ -252,7 +252,7 @@ static int vsc_get_sensor_name(struct vsc_fw_loader *fw_loader,
> >>  {
> >>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER };
> >>  	union acpi_object obj = {
> >> -		.type = ACPI_TYPE_INTEGER,
> >> +		.integer.type = ACPI_TYPE_INTEGER,
> >>  		.integer.value = 1,
> > 
> > I guess initialising integer.value implies that all integer fields are set
> > to zero (and so zeroing type set the line above)?
> 
> Yes I was thinking that might be happening too.
> 
> > Maybe moving setting type
> > below setting integer.value might do the trick as well? ;-)
> 
> I was wondering the same thing, but that seems error-prone /
> something which may break with different compiler versions.

Yes, I didn't actually mean to suggest this.

> 
> Actually most code using union acpi_object variables simply
> does not initialize them at declaration time.
> 
> So I was also considering to maybe change the code like this:
> 
>         struct acpi_object_list arg_list;
>         union acpi_object *ret_obj;
>         union acpi_object param;
> 
> 	...
> 
>         param.type = ACPI_TYPE_INTEGER;
>         param.integer.value = 1;
> 
>         arg_list.count = 1;
>         arg_list.pointer = &param;
> 
>         status = acpi_evaluate_object(handle, "SID", &arg_list, &buffer);
> 
> Slightly more verbose, but this is basically what all other
> callers of acpi_evaluate_object() (with a non NULL arg_list) do.

I prefer your current patch actually, it's good as-is.

> 
> > It'd be useful to be warned by the compiler in such a case. There are much
> > less useful warnings out there.
> 
> Ack.
> 
> > Excellent finding indeed.
> > 
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > 
> > This could be cc'd to stable, this warning will display for a lot of
> > systems. I.e. I think:
> > 
> > Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> > Cc: stable@vger.kernel.org # for 6.8 and later
> 
> Ack.

-- 
Kind regards,

Sakari Ailus

