Return-Path: <linux-acpi+bounces-9231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA7C9B90CA
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 12:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A20281EFE
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C1D19925B;
	Fri,  1 Nov 2024 11:56:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05581990A8;
	Fri,  1 Nov 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462209; cv=none; b=goowytoscdDwuGB+CPFtd52zb7oUFbM6XC4p5J0C4z8LkrpCAHWxnEoqRKRvZ+f6kKkVyzOLnHDXH5kM+V9Aa8nokm1GNSSEhX8UR4QhxpsPHeGl9L2gTaOAAm8cXm94uwIzn7IJep/uNFl72ZIfUjqzceEwZkbbPMuyuQlFZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462209; c=relaxed/simple;
	bh=HDH6Le6Nd9Y+trNLwTMXuT0phkwNA0RZW0jTTClExUc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntW7FWsuUZmvLnUL6oJ6yN9vtz8xhqjL2owd+7ePZzIGySz9ek9JSevX4dReGQDHlltILTS0Z1RVAqNSuyRF0hag7R4SaYJVaIeGEJhLehtU81ZmCT715gM9vWD468GLB0JEfR1VMw1QS6Fg12rhG81ghr7hBIkKzEAFQFWHcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xfzjd1sdXz6LD1d;
	Fri,  1 Nov 2024 19:51:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 41913140C72;
	Fri,  1 Nov 2024 19:56:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 1 Nov
 2024 12:56:42 +0100
Date: Fri, 1 Nov 2024 11:56:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide
 extended linear cache translation
Message-ID: <20241101115640.00006491@Huawei.com>
In-Reply-To: <773c3a60-22eb-4719-84dd-64d642926230@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-5-dave.jiang@intel.com>
	<20241017173326.0000191a@Huawei.com>
	<773c3a60-22eb-4719-84dd-64d642926230@intel.com>
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
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Oct 2024 15:53:20 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/17/24 9:33 AM, Jonathan Cameron wrote:
> > On Fri, 27 Sep 2024 07:16:56 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> Add helper functions to help do address translation for either the address
> >> of the extended linear cache or its alias address. The translation function
> >> attempt to detect an I/O hole in the proximity domain and adjusts the address
> >> if the hole impacts the aliasing of the address. The range of the I/O hole
> >> is retrieved by walking through the associated memory target resources.  
> > 
> > What does the I/O hole correspond to in the system?
> >   
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>  drivers/acpi/numa/hmat.c | 136 +++++++++++++++++++++++++++++++++++++++
> >>  include/linux/acpi.h     |  14 ++++
> >>  2 files changed, 150 insertions(+)
> >>
> >> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> >> index d299f8d7af8c..834314582f4c 100644
> >> --- a/drivers/acpi/numa/hmat.c
> >> +++ b/drivers/acpi/numa/hmat.c
> >> @@ -152,6 +152,142 @@ int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
> >>  
> >> +static int alias_address_find_iohole(struct memory_target *target,
> >> +				     u64 address, u64 alias, struct range *hole)
> >> +{
> >> +	struct resource *alias_res = NULL;
> >> +	struct resource *res, *prev;
> >> +
> >> +	*hole = (struct range) {
> >> +		.start = 0,
> >> +		.end = -1,
> >> +	};
> >> +
> >> +	/* First find the resource that the address is in */
> >> +	prev = target->memregions.child;
> >> +	for (res = target->memregions.child; res; res = res->sibling) {
> >> +		if (alias >= res->start && alias <= res->end) {
> >> +			alias_res = res;
> >> +			break;
> >> +		}
> >> +		prev = res;
> >> +	}
> >> +	if (!alias_res)  
> > 
> > 	if (!res) and you can just use res instead of alias_res for the following
> > as you exit the loop with it set to the right value.
> >  
> Ok will do that
>  
> > 
> >   
> >> +		return -EINVAL;
> >> +
> >> +	/* No memory hole */
> >> +	if (alias_res == prev)
> >> +		return 0;
> >> +
> >> +	/* If address is within the current resource, no need to deal with memory hole */
> >> +	if (address >= alias_res->start)
> >> +		return 0;
> >> +
> >> +	*hole = (struct range) {
> >> +		.start = prev->end + 1,
> >> +		.end = alias_res->start - 1,
> >> +	};  
> > Ordering assumption should be avoided in such a generic
> > sounding function.  Can the hole be first?  
> 
> Do you mean if the address mapping starts out with an MMIO range and then memory range? I'm not sure if such an implementation exists in the x86 world. And if the hole is behind all the ranges, then it shouldn't impact the address calculations. 
> 
That was me not really understanding what the hole was.
Tony filled in that gap.

> > 
> > or rename the function to include preceding_hole or something like that.  
> >> +
> >> +	return 0;
> >> +}

> 


