Return-Path: <linux-acpi+bounces-9591-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BD39C8EEE
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 16:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878BE289683
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9DF13AD39;
	Thu, 14 Nov 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCLlFrDg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4E7DA66;
	Thu, 14 Nov 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599559; cv=none; b=mwt5AB2JiHsknb9rHRVXC6roXi7NjTApaDCZdaTgXsgNrtfNd+RbjDHSh08krb/8f9LYnNT7Whb59rkecazZJVanSNa+IQ8TSUKg/JQMyeCQY8iBJ+fLs/l1ON/SOLYcAJCtRE64cfZNRFyWjzMnIK2Ce00zzLv7qfh7d1lKsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599559; c=relaxed/simple;
	bh=e1ZQd5YARcU5Hvx35DjyE2bgdZJpyejVaDrJBO5aiOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9g4K0vsqNDdJTZaa3Hzn9KvQ4nQXVZbWzUSOjRO0tIqY0qTrMQ+eMJ3eOcATQy7dWEAo/Nrc0oN7n7PbuG9qAsIGafzDmL0zgasRrV0xrt7RegN6s03ajkhMY2iavzsxS7LnwCw0uFHqmuA0qgdDV8U5VU35z509qhquhg+UOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCLlFrDg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731599558; x=1763135558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1ZQd5YARcU5Hvx35DjyE2bgdZJpyejVaDrJBO5aiOA=;
  b=nCLlFrDgOWRzysy6tExZZg+3iF9hHdRRwHKKfBD+PXTSkNfVS6g+4I3C
   075bap5gmXLVOOFRmvqMT35OeUWhpwQe6nceGrYAlY6a0xmpoaVtIrAsO
   H+CgKJqyKIvpdBLfT9Akt51yite+MPH7OPm28kimauDP35GNlHgZlcZUx
   ARQP3ye4cz39cgvrxhtWOQb7GYQ2VD0da3jtfKOkLzgTfQfRAVPp6fCXe
   jyAlTARmcNIr6Ohv+vVWtutA6hJG4v2FZoqXZ8vai8DuvcWEbiwPByatE
   IuLkgOW9+1szMND/U8aYPMSkRc5U90A5bKKsconZ+nBejOSzDsGXAC+bH
   g==;
X-CSE-ConnectionGUID: dBabqjKKQa6tvKi1dPbbTA==
X-CSE-MsgGUID: FeO6JtvnRMitz90m5rS8mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="34408558"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="34408558"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 07:52:37 -0800
X-CSE-ConnectionGUID: umsSu1FIQ1KX3rp+SI0g7w==
X-CSE-MsgGUID: Usp726aQS2yHN322MdJmMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="93206310"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.62]) ([10.125.108.62])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 07:52:36 -0800
Message-ID: <86208fd4-2628-446c-bda5-fe3c79706f68@intel.com>
Date: Thu, 14 Nov 2024 08:52:35 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/5] cxl: Add mce notifier to emit aliased address
 for extended linear cache
To: Borislav Petkov <bp@alien8.de>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 dan.j.williams@intel.com, tony.luck@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com, ira.weiny@intel.com
References: <20241112221335.432583-1-dave.jiang@intel.com>
 <20241112221335.432583-6-dave.jiang@intel.com>
 <20241113081128.GAZzRfMIuLpzwHY_R7@fat_crate.local>
 <9cbccaa0-f83e-4e92-bfbd-65a7ec08b2bd@intel.com>
 <20241114093217.GBZzXDoVnBPiAhVOvJ@fat_crate.local>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241114093217.GBZzXDoVnBPiAhVOvJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/24 2:32 AM, Borislav Petkov wrote:
> On Wed, Nov 13, 2024 at 08:27:35AM -0700, Dave Jiang wrote:
>> I'm actually looking for recommendation on what the proper one is. The
>> handler is expected to offline the aliased address of the reported MCE if
>> there is one.
> 
> Well, MCE_PRIO_EARLY will emit a trace record so that if you have error events
> consumers like rasdaemon, it'll get that error record for reporting etc.
> 
> MCE_PRIO_UC calls memory_failure() on the error and thus offlines the page.
> Functionality which you're partly replicating in your notifier.
> 
> And since you wanna do the same thing, why are you even adding a new priority
> instead of using MCE_PRIO_UC? amdgpu_bad_page_notifier() uses that same prio
> because it does a similar thing.

Ok thanks for the explanation. I will use MCE_PRIO_UC. 
> 


