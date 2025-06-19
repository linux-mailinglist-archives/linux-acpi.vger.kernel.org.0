Return-Path: <linux-acpi+bounces-14459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCABADFBE6
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 05:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8AB189A617
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 03:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE02224AF9;
	Thu, 19 Jun 2025 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Da52rxAb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BB634;
	Thu, 19 Jun 2025 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750304024; cv=none; b=O6/oaMHaVOTCaIaZeytCGbwqUAyA1PnDetaZjS5ATC4XjNUf9ytYWM3UQI3Rq6F/962r81fpQtYI8/UXRN3Rlf/gtSPWvzXXS3cW0wURGjtLj8AF1XAHzZkPVZi37PaL2fsK5H5KDMfJS9X2y7uhTRB341fG2E6cBVpVifzZS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750304024; c=relaxed/simple;
	bh=VatJFwdK+oTSEVzkU8kANDMP8jA+C/mWMvxwEtQsTj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCa+l/L/A32tjKth/Twwj8AP9j4p+ccc1kTSHYDnUfXbzY+yYzlZY9DNdSBy4g9QPsZ9O9EpKbRqUtwHg50HXgRyKVq0Zx+SbXpwakrGVQ0yGW/MLIejrbHESHzz2SpPYpqYMYyKdspNvc7ZjDhJail0nfk8SBna2h72RxTmR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Da52rxAb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750304023; x=1781840023;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VatJFwdK+oTSEVzkU8kANDMP8jA+C/mWMvxwEtQsTj0=;
  b=Da52rxAb4uCtHERgOofrQa9BSxn3tCR680yfVb8dQHieu0AqDffJugXn
   cyEjcaHzYFK541wSf4BP3mFO6elvKy+LOC1jTv8ePDTlscAGFiExVozWg
   MLv7YRFrh4wkA9JHfCMXlPK5Fs/qJHuUKhfS5hxllS2pjudzdzJGKEa5j
   Wj7FZDGRHIrRXeUcjjQmIx7ZTXjl7mIdYp21DT9J8rnhiIZ5Opymt8Gu/
   uzNfAykYGFt/8jGkRMbKueA0D4PEM6PTZLgzfji8qpzsOmv7VQ/uSQmmY
   vZk8PQyG8jAYjP2lTy9nbyGZBW90pq4IvaOTmS5TWI15sU6V148YIQEc8
   g==;
X-CSE-ConnectionGUID: OYiV/hToQwqlsJQuUStFsA==
X-CSE-MsgGUID: Eo1VoLBqTQOGMlrjrFQqVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="75074045"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="75074045"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 20:33:37 -0700
X-CSE-ConnectionGUID: uhuOvPNMSwGHN3ni0tTthg==
X-CSE-MsgGUID: EV/Ke+aDR5qXBbuoNT3jIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181338574"
Received: from tcorban-mobl1.amr.corp.intel.com (HELO [10.125.34.69]) ([10.125.34.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 20:33:35 -0700
Message-ID: <206ebae8-4e2d-4e04-8872-fa3a56b3e398@linux.intel.com>
Date: Wed, 18 Jun 2025 20:33:27 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
To: Dan Williams <dan.j.williams@intel.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Benjamin.Cheatham@amd.com,
 Jonathan.Cameron@huawei.com, dakr@kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, rafael@kernel.org, sudeep.holla@arm.com,
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <kees@kernel.org>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
 <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
 <bcd3848d-54dd-453e-b0b5-91cb72160645@linux.intel.com>
 <6853586e9d366_1f9e10087@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <6853586e9d366_1f9e10087@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




On 2025-06-18 17:23, Dan Williams wrote:
> Marc Herbert wrote:
> [..]
>> In other words, by turning this off unconditionally at the global level,
>> the kernel could actually lose (surprise!) some performance.
> 
> I expect the answer is that any compiler that does fail to convert this
> to defined behavior is not suitable for compiling the kernel.
> 
> The issue is not "oh hey, this fixup in this case is tiny", it is
> "changing this precedent implicates a large flag day audit". I am
> certain this is one of many optimizations that the kernel is willing to
> sacrifice.

None of these ideas crossed my mind:
- dropping -fno-delete-null-pointer-checks
- anything "large" like a "flag day audit" or any large cleanup/refactoring/etc.

Sorry for the confusion.

During the discussion, some seemed to perceive
-fno-delete-null-pointer-checks as a "performance-neutral" choice. So I
just tried to correct that impression "in passing", but please do _not_
read too much into it.


What I was really interested in:

1. Is it acceptable to swap two lines to _locally_ get rid of C Fear,
   Uncertainty and Doubt and time-consuming consultations with language
   lawyers. On a _case-by-case_ basis.

2. Are C99 declarations acceptable.

3. Do tooling and "convergence" with other C projects matter.

Note "acceptable" != mandatory; _allowing_ C99 declarations does NOT
imply scanning existing code and systematically reducing variable scope
everywhere possible. Same as every other "new" C feature.

I think these were valid "policy" questions, that this "poster child"
was an efficient way to ask all of them with a ridiculously small amount
of code and I think I got loud and clear answers. Case closed, moving on!


> Otherwise, the massive effort to remove undefined behavior from the
> kernel and allow for complier optimzations around that removal is called
> the "Rust for Linux" project.

Nice one!


On 2025-06-18 19:35, Dan Carpenter wrote:

> But, again, this is a totally different thing from what the patch does.
> The faux_device_destroy() code is not doing a dereference, it's doing
> pointer math.

pointer math is what we _want_ the code to do. But if that relies on
some undefined behavior(s) then the bets are off again. Check
https://stackoverflow.com/questions/26906621/does-struct-name-null-b-cause-undefined-behaviour-in-c11
where offsetof() is a suggested alternative.
Spoiler alert: more language lawyers. Do not click ;-)



