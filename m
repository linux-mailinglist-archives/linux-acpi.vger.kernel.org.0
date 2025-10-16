Return-Path: <linux-acpi+bounces-17844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A69BE58CA
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 23:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5339E420900
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B14E2E175F;
	Thu, 16 Oct 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv5XTbrp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F422DE6E9;
	Thu, 16 Oct 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649145; cv=none; b=AxZKSWdtyx8Wyq8ZA/hIWKtkbKG30jlALoDLwivP9dEJGoV0UweXvcCgki7zhiO9ODO5zq53VWKZvG34P6Umczv5gvo+o8T6Y3a1/RbUI+7xzIflAZMZC79T5mRvCAwfh/1LiS85KQUQuXyyf/pA9G39JFrqlepolgbX/RUzP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649145; c=relaxed/simple;
	bh=KHK7I670oRMrWGeBaFZ9Bw2rnLfggfRJoEkZ7ISt2A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkeA29F0PbcV3gAjRWpaK7PJYvyi6rDPInNHJM3gAb/sV4fUAjpJjyZj9kA6DTqS85p3PqUykiyzH4I2dmpYyMvhG24mYSPIW2inV4/VSJRlwjP5ILB/11aKgzepGHz9zUY1Gy9NaDgkiaOoyGcjJQN68hCrZSxLEEjjMWBF4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv5XTbrp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760649143; x=1792185143;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KHK7I670oRMrWGeBaFZ9Bw2rnLfggfRJoEkZ7ISt2A8=;
  b=bv5XTbrpeXEYIB9hfx4YG04CmUIXNY5u0+4CkKBu9HIc0OU+vKs2s8Ju
   cc/KOoEfMCDDSoD7CpfcQ3raN0+P3Wki7hQojm5ZehniWzI3SM9fkdMjc
   ghLzqFnv+OGBR7UmiHz5j3Ll2fJkLVbam+CKgjIl58cqK+NHtpIF21i/Y
   eTgMOVvzMJrrDQj2zaspj/DKYAJ+ZRv5h7n8PysLdJdiBNcHxACC1plZj
   M1iXNIDGUxTIZnZDxeCNJ7FKyVlGQWfBLEUB9ZtgpIOlbyRCw3eddixq9
   Fgz5uCvd4/HP+jyqr1KyN/FsHVyL2murRPf2MoLm/q5yJJ2DmvGy0NgcM
   w==;
X-CSE-ConnectionGUID: hiieLbcQQ7qSCIWfP7vgLA==
X-CSE-MsgGUID: q53KAjqKQom2K7xywQ4Tew==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66689174"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66689174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:12:23 -0700
X-CSE-ConnectionGUID: NCTAk1dzRqWAbp98wjTmFQ==
X-CSE-MsgGUID: d6GCJLmVTOeXPIe3tkWpbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="213143132"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.108.4]) ([10.125.108.4])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:12:23 -0700
Message-ID: <8c65e30c-5273-4098-ab63-cba51563c244@intel.com>
Date: Thu, 16 Oct 2025 14:12:21 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi/hmat: Fix lockdep warning for
 hmem_register_resource()
To: dan.j.williams@intel.com, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: vishal.l.verma@intel.com, ira.weiny@intel.com, rafael@kernel.org
References: <20251015162958.11249-1-dave.jiang@intel.com>
 <68f001e4e4a2c_2f8991001a@dwillia2-mobl4.notmuch>
 <32ca1961-5ed6-47b5-af0e-70e7e87bba96@intel.com>
 <68f1421f4320b_2a2b1004e@dwillia2-mobl4.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <68f1421f4320b_2a2b1004e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/25 12:06 PM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
> [..]
>>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>>> index 5a36d57289b4..9f9f09480765 100644
>>> --- a/drivers/acpi/numa/hmat.c
>>> +++ b/drivers/acpi/numa/hmat.c
>>> @@ -867,6 +867,9 @@ static void hmat_register_target_devices(struct memory_target *target)
>>>         if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
>>>                 return;
>>>  
>>> +       if (target->registered)
>>> +               return;
>>> +
>>
>> So this still triggers the lockdep warning. I don't think it's smart
>> enough to know that it gets around the issue. My changes with a new
>> flag does not trigger the lockdep.
> 
> You have a case where target->registered is false in the
> hmat_callback() path? How does that happen?

It seems the ELC nodes are not on CPU node and also not generic port nodes. This platform has socket 0 and 1 where the memory targets are registered. However, node 2 and 3 gets hot-plugged and does not target registered at hmat_callback() time. > 
> ...and the splat is the same hmem_resource lock entanglement?

yes

Yes.

