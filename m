Return-Path: <linux-acpi+bounces-14250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E1AAD21FF
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 17:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882CD1895B38
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05E215F4B;
	Mon,  9 Jun 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iv2tTttW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711122144A2;
	Mon,  9 Jun 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481480; cv=none; b=p7K3Gju5Uf2YEReuwwtvASpw/Ku90grgS5GeByUPnRrNFBSJ+K2Va3HefxI5kf4xg7YMUQyOMJC6IBOWPs4ptcx2OWhrCBLe/iQrS8J80dTV7UDM0hso3w0/P3HtzXKqVXxCd35mCZ0AYYoM3qI7brP6lLMECAfVxNYjWnLM+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481480; c=relaxed/simple;
	bh=V2PN5JsXooSqcaGIvoztdatOOtrQfmNHfS85eSZtJ/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGEU/O+bOeaSGFeIEDjsJnbgvQC1rjFE5mywYSiSaXQBD47S8qVdJsUp2Riph1HOZOGRhXi8fffLFPypmckRXlE14BJ3EJq+lfZIJk0hZ3CFoGUgYnoyMa4dpSEt36MYcSQHEfz5Xfn8RFdL316sKKOgvL9Fbl9V+R4Dl7Qi0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iv2tTttW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749481479; x=1781017479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V2PN5JsXooSqcaGIvoztdatOOtrQfmNHfS85eSZtJ/k=;
  b=iv2tTttWHOjg9NJq9dURQiOkj+RJWMEHj8M0qF0p82aSBDtzzRotlDNN
   C831M+W/5QxrNExNhOhh4nOdnUszpAYxpi+gF88DEPIbTunm5/aprUrTE
   BA0c7WlPUd0jv/IRGyC1c3H5HMjlATByVwdFb7pKEw0ll3VOE5VnTBiAu
   IVk8zHwjHqNLJxv7QmOKCOshU/hh1Sbjz9d84K6TYLv+NkHAvafvrO1+E
   8jZjhaJ8icnfuva6OCVaNtBl67JNK/+ncaVewwzBY3SjGAR2cknJgNg1h
   hOcVgMQBPCCCSlh2gv4wKRFhhNflSsvRciHPaNFK2iSjwBnWbyLYR7ulL
   A==;
X-CSE-ConnectionGUID: g6vy237vSdSQh5cABFLv1g==
X-CSE-MsgGUID: 8BrqfbK/RJaKoaZ4HcGeBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62174421"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="62174421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 08:04:32 -0700
X-CSE-ConnectionGUID: a3UHTwhURdOC/DPbnZXwWw==
X-CSE-MsgGUID: kkAolnScSZuy+jStCwfN3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="146411213"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 08:04:31 -0700
Message-ID: <2af31ff8-eee0-4868-8f97-2a390910f9ed@intel.com>
Date: Mon, 9 Jun 2025 08:04:27 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL: ACPI: faux: Fix cxl_core.ko module load
 regression
To: Dan Williams <dan.j.williams@intel.com>, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ben Cheatham <Benjamin.Cheatham@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250607033228.1475625-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/25 8:32 PM, Dan Williams wrote:
> git bisect flags:
> 
> 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> 
> ...as the reason basic CXL unit tests are failing on latest mainline. In
> addition to the fix to einj-core.c, this also needs some updates to
> faux_device to make it behave more like platform_driver_probe(). Details
> in the individual patches.
> 
> Dan Williams (3):
>   driver core: faux: Suppress bind attributes
>   driver core: faux: Quiet probe failures
>   ACPI: APEI: EINJ: Do not fail einj_init() on faux_device_create()
>     failure

LGTM
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
>  drivers/acpi/apei/einj-core.c | 9 +++------
>  drivers/base/faux.c           | 3 ++-
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> 
> base-commit: a9dfb7db96f7bc1f30feae673aab7fdbfbc94e9c


