Return-Path: <linux-acpi+bounces-14873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41525AEEADE
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 01:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97627A3D30
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54525C6E7;
	Mon, 30 Jun 2025 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W11XVlA3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F078F39;
	Mon, 30 Jun 2025 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751325896; cv=none; b=udCwJSXJgxggstOXDo7+pRL/UlvpyKuKdVKQHccSBhFEoweJR+pON2E37dSWfsZYTj+YfR9iOhhmfDk1vR0coa0KSk2vnK/mD3AeAHP5o5nmr7jzNCSNpD0qBvyG+el2fuaPqwi/6zRcemZXytlZMmFqPAA2QvchsxyGizRGNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751325896; c=relaxed/simple;
	bh=OSVCA5D4jrahb3F584m0Qii4idTEbxrHmmdzdwhZcY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=as+sRE9uEx3fJX/1arIx+kfBClyKuhq4xOpJKHj43DYXov4gf3D72iDXNCshFT125ANBB+HbyzJvKikYd8E4ltkr8HMYNMYCc+boa+NJ0nV7+u4ZwtNPrJq39xj+Wh2t1lAr+BKn4XWS537qR706p08WMyFx9FGyb0fIBLJkRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W11XVlA3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751325895; x=1782861895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OSVCA5D4jrahb3F584m0Qii4idTEbxrHmmdzdwhZcY8=;
  b=W11XVlA3//84DznInzAdEgzkMDMNgY6IB3cx5bBLX0ler4H2Fk6nAnwj
   9R+X+VoSy402he4ufmHo0nH+QMFuIEz4NqpTj++Wjr2+AgrA0roUKOQfy
   6BcV+RE8//amllS3OPdO9kwFM7EzRTfaShH4lMx91H7AR2NaFYSGJ783a
   uBrvbaeKTh4BLeNPe2x6zLw4DXqxLQeqfiZtDG7c7egenMvvAagvRdMkf
   YLnPauDXeSpGneV2fbA2MWemX6WLKZZM9dWMATI4P/Y+L2Dx+Av6Y9iM/
   oAnERicmB0ezvRTYZxlS4ACRc3GA9kTfXwP4UmTrbIQtSDjfvmSLmYBpF
   w==;
X-CSE-ConnectionGUID: +dnh7BZ+TvGepCPE9Mi3Ow==
X-CSE-MsgGUID: FY6Sd4qZT6+kXEKky/ZSKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="56188517"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="56188517"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 16:24:46 -0700
X-CSE-ConnectionGUID: i2xyQgECRQykHPPQIJq1IQ==
X-CSE-MsgGUID: zJjClD91S7+bAgtlIpA9AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="159102654"
Received: from yosephda-mobl.amr.corp.intel.com (HELO [10.125.210.206]) ([10.125.210.206])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 16:24:34 -0700
Message-ID: <fe282f58-1627-480b-8f01-71d0effd5da8@linux.intel.com>
Date: Mon, 30 Jun 2025 16:24:26 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Benjamin.Cheatham@amd.com, Jonathan.Cameron@huawei.com, dakr@kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, rafael@kernel.org,
 sudeep.holla@arm.com, Dan Carpenter <dan.carpenter@linaro.org>,
 Kees Cook <kees@kernel.org>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
 <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
 <bcd3848d-54dd-453e-b0b5-91cb72160645@linux.intel.com>
 <6853586e9d366_1f9e10087@dwillia2-xfh.jf.intel.com.notmuch>
 <206ebae8-4e2d-4e04-8872-fa3a56b3e398@linux.intel.com>
 <p66tblbusj2uw4q35nytnangb7z5ziyrkenl67hjgfsatw3fdj@odgdtnzk7at6>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <p66tblbusj2uw4q35nytnangb7z5ziyrkenl67hjgfsatw3fdj@odgdtnzk7at6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-06-25 17:55, Kent Overstreet wrote:
> the big con:
> - they interact badly with gotos, you can get undefined behaviour from
>   using a variable that wasn't actually defined _and the compiler will
>   not warn you_
> [...]
> But the issue with gotos is worth highlighting. Be careful when using
> them in code that hasn't been converted to __cleanup.

Thanks Kent for sharing this.

I got curious and found that clang -Wall is actually able to warn,
at least in simple cases:

int goto_uninitialized_C99(int *ptr)
{
  if (!ptr)
    goto cleanup;
  const int i = 42;

cleanup:
  // clang warning, no gcc warning
  printf("fin: i=%d\n", i);


warning: variable 'i' is used uninitialized whenever 'if' condition
   is true [-Wsometimes-uninitialized]


gcc -Wall -Wextra does not say anything.
Tested with clang version 18.1.3 and gcc 13.3.0


Interestingly, there is no warning difference between C89 and C99 code
for such a simple example. gcc warns for neither C89 code nor C99 code
and clang warns for both.

int goto_uninitialized_C89(int *ptr)
{
  int i;
  if (!ptr)
    goto cleanup;
  i = 42

cleanup:
  /* clang warning, no gcc warning */
  printf("fin: i=%d\n", i);


(finally getting rid of gotos is one of the main purposes of RAII)

