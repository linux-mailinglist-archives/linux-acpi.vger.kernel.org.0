Return-Path: <linux-acpi+bounces-4167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B787527A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 15:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8576B22C20
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761B125D5;
	Thu,  7 Mar 2024 14:55:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB11E896;
	Thu,  7 Mar 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823314; cv=none; b=jHlYs6dY5YWF2WoYjtA4vrjuYMHt5X6YfXf4xVevUpKEG3ax+6U8WIpVYJbg0Ib+V9OPrblnS0/c4UGvwkl0VMAYQKvu1lNYhEGCAVi/+eG03j6umsCsfipEWks+Ag58MV7ozirqGPNVhbuiOvQC0SHT5VYnvMWARV+9XkMirXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823314; c=relaxed/simple;
	bh=qRmZG0OqEq4XmIobjTZv8B1h1Xuq3eK1TEO3aGbbkx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFFQ19RdAR8RF888RghaWEHxH1ozGqk+PTYNo9hNvlj8BzzsYiTNFyWNRg7nyJm4wCjeY4ZHE41VOL+JN/bXGRUZWbMds8eiNeKCGWwZEpyAxsq1cXRsSeL05z+PgX/5mPLI0sl85cu2QnW2KLQtJqIGAMjrXfgdgyJoK9NEup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrC0n1M0Tz6K9JC;
	Thu,  7 Mar 2024 22:51:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A25AD140FB7;
	Thu,  7 Mar 2024 22:55:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 14:55:03 +0000
Date: Thu, 7 Mar 2024 14:55:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Message-ID: <20240307145502.00000ba6@Huawei.com>
In-Reply-To: <77533c2f-99c0-4281-bc1b-cc970957510a@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
	<20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
	<20240307120918.00003c56@Huawei.com>
	<77533c2f-99c0-4281-bc1b-cc970957510a@amd.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 7 Mar 2024 08:46:49 -0600
Ben Cheatham <benjamin.cheatham@amd.com> wrote:

> Hey Jonathan, thanks for taking a look!
> 
> On 3/7/24 6:09 AM, Jonathan Cameron wrote:
> > On Mon, 26 Feb 2024 16:27:02 -0600
> > Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> >   
> >> Remove CXL protocol error types from the EINJ module and move them to
> >> a new einj_cxl module. The einj_cxl module implements the necessary
> >> handling for CXL protocol error injection and exposes an API for the
> >> CXL core to use said functionality. Because the CXL error types
> >> require special handling, only allow them to be injected through the
> >> einj_cxl module and return an error when attempting to inject through
> >> "regular" EINJ.
> >>
> >> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>  
> > Hi Ben,
> > 
> > Some minor comments inline given you are doing a v15 (yikes!)
> >   
> 
> Yeah I know :(.
> 
With headers tidied up.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> > 
> >   
> >> +	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
> >> +	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
> >> +	{ BIT(15), "CXL.mem Protocol Correctable" },
> >> +	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
> >> +	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
> >> +};
> >> +
> >> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> >> +{
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
> >> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;  
> > Hmm. This is a little ugly.
> > Could do something like the following bit it's of similar level of ugly
> > so up to you.
> > 
> > 	int bit_pos = ACPI_EINJ_CXL_CACHE_CORRECTABLE;
> > 	for_each_bit_set_bit_from(bit_pos, &available_error_type,
> > 			     ARRAY_SIZE(einj_cxl_error_type_string)) {
> > 		int pos = bit_pos - ACPI_EINJ_CXL_CACHE_CORRECTABLE;
> > 	  
> 
> I agree it's ugly. I think this version has the added benfit of parity
> with einj_available_error_type_show() in einj-core.c, so I think it's
> better to keep it this way if it's the same to you.
> 
Sure. We can always (maybe) tidy them both up later :)

J

