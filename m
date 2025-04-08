Return-Path: <linux-acpi+bounces-12862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4633A80F7F
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 17:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496908A403B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01FC22A4D6;
	Tue,  8 Apr 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z6TsN5TX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7C1DA612;
	Tue,  8 Apr 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125026; cv=none; b=DrSHqY0sTcYDZHEXA29fqq5lgKWuK/qXUgU1jqfccCGQaSeX6jx8D2o0nwgCy0lW+HF6Bc1XhOk157SXtBpDYVfdKIu6UZBAtZ38w32Bn5JOHsD+0wMhw+qYre0780tP6Bmpfenr+QWvzmu+MwdaFO33hTP2MMxAEumW6sOjf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125026; c=relaxed/simple;
	bh=GudziAjvRjhdTl3T1GFT2vjHAMhpb5UxWzvHyhPg32U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axwAURVro/HDmgsBdJhN4eIeKWKjVQ1/guhdQyCBGBmFGE7P1J9Ue6p3ARPJJrBiM7kbFXnAzJ7FmoBYoF+QDOIzyvQ6hmEFXQPt9X8n21KsOCzqrsSk9cti6FX47inL2qpKH7AqjAG/A6oB+fE+1teiWFgTSOceWvdZaPES2/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z6TsN5TX; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73faa3c8-70b9-4c95-b42a-5932249881e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744125020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4XCug/ybuLX9M5/EBwxp5KiEtgoov6beXctF05fO7o=;
	b=Z6TsN5TXUZpLuZqqmNh9SZXNkgo3yaezRlUh/ImoVbMAO0eqYoGnAKYx1/p2+iT6QjcFz0
	gKzIcfBmhBf3qCtoZCNtE22cCRDwwZAbfPwkfqYJ35cT9UaYfmcw3MHjxDhcjHYQQc1OJh
	WFT/4dCbmuR0pd9P6JKp9m1eaAItijc=
Date: Tue, 8 Apr 2025 11:10:15 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] device property: Add
 fwnode_property_get_reference_optional_args
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-3-sean.anderson@linux.dev>
 <Z_Tg1v0rlrnjs0mt@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <Z_Tg1v0rlrnjs0mt@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/8/25 04:39, Andy Shevchenko wrote:
> On Mon, Apr 07, 2025 at 06:37:14PM -0400, Sean Anderson wrote:
>> Add a fwnode variant of of_parse_phandle_with_optional_args to allow
>> nargs_prop to be absent from the referenced node. This improves
>> compatibility for references where the devicetree might not always have
>> nargs_prop.
> 
> ...
> 
>> +/**
>> + * fwnode_property_get_reference_optional_args() - Find a reference with optional arguments
>> + * @fwnode:	Firmware node where to look for the reference
>> + * @prop:	The name of the property
>> + * @nargs_prop:	The name of the property telling the number of
> 
> Use space instead of TAB as it's already too long to make it aligned with the
> rest.
> 
>> + *		arguments in the referred node.
>> + * @index:	Index of the reference, from zero onwards.
>> + * @args:	Result structure with reference and integer arguments.
>> + *		May be NULL.
>> + *
>> + * Obtain a reference based on a named property in an fwnode, with
>> + * integer arguments. If @nargs_prop is absent from the referenced node, then
>> + * number of arguments is be assumed to be 0.
>> + *
>> + * The caller is responsible for calling fwnode_handle_put() on the returned
>> + * @args->fwnode pointer.
>> + *
>> + * Return: %0 on success
>> + *	    %-ENOENT when the index is out of bounds, the index has an empty
>> + *		     reference or the property was not found
>> + *	    %-EINVAL on parse error
>> + */
>> +int fwnode_property_get_reference_optional_args(const struct fwnode_handle *fwnode,
>> +						const char *prop,
>> +						const char *nargs_prop,
>> +						unsigned int index,
>> +						struct fwnode_reference_args *args)
>> +{
>> +	int ret;
> 
>> +	if (IS_ERR_OR_NULL(fwnode))
>> +		return -ENOENT;
> 
> This is incorrect most likely, see below.
> 
>> +	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
>> +				 0, index, args);
>> +	if (ret == 0)
>> +		return ret;
>> +
>> +	if (IS_ERR_OR_NULL(fwnode->secondary))
>> +		return ret;
> 
> Here no such error code shadowing, and TBH I do not like the shadowing without
> real need.

I don't understand the objection. First, this logic is identical to
fwnode_property_get_reference_args. Second, the process seems clear to
me:

- If we have a primary fwnode, try it otherwise return -ENOENT
- If we have a secondary fwnode and the first failed, try it otherwise
  return the original error code

The purpose of a secondary fwnode is to allow supplying missing
properties absent from the primary fwnode. Which part of the above do
you dislike?

--Sean

