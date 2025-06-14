Return-Path: <linux-acpi+bounces-14376-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501AAD9DE1
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 16:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76C5172D71
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Jun 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C562E175B;
	Sat, 14 Jun 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnI0Y22c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0652E173A;
	Sat, 14 Jun 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749912830; cv=none; b=iUhT5Qp6BRNK/F1mA2o+5GoNSVUl8lh4rw673OkLD0XqFToZFN8MA2P+pt+UKMVtwa7DaK7IPUYSc60TzmYdjLicBa393AbULwMG0uIw4l7meyXZ+egYldAXMT0xCYVnqaCFCjVDLzflwfPiQQVUDS+tQcHsmishIVx7kuk8vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749912830; c=relaxed/simple;
	bh=DlFlJzNv80nRDL/Xe/my3vGEb1Z6bpP84mMcgDH9Kjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIW0zxn1tdFN91NTR0VpmY/rgcgS/XKuepQ4/YIWDKFH9zbQE15her472PTSNs2oZjap7mbmb3kbO2COP0naRoaRppMvR0Zv4OwtYlraomGAwPS5e3BCmKBcJSR24GCPyJTpnw8GMoKfH2KCbTHjCey5wEo6ya60O8Yq4PjmRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnI0Y22c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749912828; x=1781448828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DlFlJzNv80nRDL/Xe/my3vGEb1Z6bpP84mMcgDH9Kjk=;
  b=OnI0Y22c7th2q4EUX6CgtOYy8vtJLk6KdS9u5UMrzEK5pVTUAh3u3gG7
   /sCLp7ih/ZPjLHUo7obKsFZiZ3yyf5DcUwVJzNjlshdL1mshcCGSj468N
   WQGSCme/Dvl5Y+6aAjvqqesk6Rskdfs6sMeU/GLpKJ8bjXFyyBc6SAGkv
   BhmEMJGbIAA8xa9c1f+TqjcqF3nb6KXGTsWYwcwx8BmG7CdsE2BU/s0qk
   11IGwkrL+gUB/eclwVFccUcZ20PbDlFmgYlpW2quRgXyj+DlsZd0KZcLN
   5RCBAVDlTo7Vonn/ovjizDQNEdzErR8neW1c883w3rvxjHph+LSXLE9w9
   A==;
X-CSE-ConnectionGUID: BX9+dIvxRCW0IJpEB5/RCQ==
X-CSE-MsgGUID: xAD4GshdQaKO6Fq7p26j/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="63146225"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="63146225"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 07:53:48 -0700
X-CSE-ConnectionGUID: PZKN4sXTRz69UlaIazZEIw==
X-CSE-MsgGUID: nHSG7wIOS56x08KM67BjTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="148978611"
Received: from tcorban-mobl1.amr.corp.intel.com (HELO [10.125.34.69]) ([10.125.34.69])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 07:53:46 -0700
Message-ID: <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
Date: Sat, 14 Jun 2025 07:53:34 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
To: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Benjamin.Cheatham@amd.com, Jonathan.Cameron@huawei.com, dakr@kernel.org,
 dan.j.williams@intel.com, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, rafael@kernel.org, sudeep.holla@arm.com,
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <kees@kernel.org>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <2025061446-wriggle-modulator-f7f3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> the kernel relies on this not being "optimized away" by the compiler
> in many places.

I think "undefined behavior" is the more general topic, more important
than null pointer checks specifically?

> the kernel relies on the compiler to be sane :)

Undefined behavior is... insane by essence? I'm afraid a few custom
compiler options can never fully address that.  While we might get away
with -fno-delete-null-pointer-checks right here right now, who knows
what else could happen in some future compiler version or future
combination of flags. No one: that's why it's called "undefined"
behavior!

> If "tooling" trips over stuff like this, then we should fix the tooling

Because of its old age, many quirks and limitations, C needs and has a
pretty large number of external "tools": static and run-time analyzers,
coding rules (CERT, MISRA,...) and what not. It's not realistic to "fix"
them all so they all "support" undefined behaviors like this one. It's
already hard enough for them to agree on false positives with a somewhat
"standard" version of C. The kernel wields a massive influence but
I'm afraid its power is not big enough to impose its own C "flavor". It
has influence on gcc and a couple others but not on the language as a
whole. The alternative is for the kernel to stay incompatible by choice
with most C "tooling" available - and find fewer issues :-(

(For even more diverse language mess, take a look at the Safe C++
"standardization" attempt and at C++ "profiles". I digress)

> I see a similar case with discussion at:
> https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/

Thanks Miguel for these near-identical examples. While more verbose and more
error-prone, this can indeed be fixed with pre-C99, separate definitions
as it was done in multiple places there.

This is just moving one line of code a few lines down. I think there are
many more "interesting" and much more complex C flaws to waste time on :-)
My 2 cents.

