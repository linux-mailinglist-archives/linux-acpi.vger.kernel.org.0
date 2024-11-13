Return-Path: <linux-acpi+bounces-9548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0229C7808
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 16:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A10B43C40
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A5815AAC1;
	Wed, 13 Nov 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkphiJbs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5513C00;
	Wed, 13 Nov 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511659; cv=none; b=p7XZPfTB304k2Sm/1o/O4qVBUEZpd04Lq9MKqTfXv/Mfuogxr4qpaAM/HK11WxqtiNzqsjKvxWjiAP0lGDQU5f6x8G1TJ7lLvGBwkOiBdpgGN0VRIfnzG1fapY/ukt57VQ1ivgO94iwNM9KtpTB34WWsFS2FTBNVSYQOdThH9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511659; c=relaxed/simple;
	bh=vFV2zH8OTQhkKGREuVETATmsNwww76f8xeHVS01JFVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3PyHAGzDk9rUE4wpgIVP8jaGQRcSVOxI+SdCugRIfuB+tyvhmNsh+AkZSb2G1CD0OXEE5iud93isMUkj5k+AuTuunoLxVe7a/yFFhto6nvkk9qGYE9XWztJJNqUF1kbJNsMQteankvZzYMMMRCwExQzimLEyLSl5CNjhiKHNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkphiJbs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511659; x=1763047659;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vFV2zH8OTQhkKGREuVETATmsNwww76f8xeHVS01JFVw=;
  b=BkphiJbspQhakucmodaFS548N4552eiVIxlcAg4oAdaaG47CRApAxHQb
   Vwk9nI0/Z15xwfJGV68850UVwCbLpaP4PvlZp9eAXVeZ4FzJ8GVcJJNko
   CqOgEB5I2+ZKW0unY//SS2eAh7nJfONeQ/M0VSHNoEamZYy6qE1EtR31Z
   9puX7hpYUYGF2Vph8/1vF+UVCq6dhTULypWxU0GQpgBJS14YCFOWMPWTU
   kkW3eZiAbexeAGRGLWCZKWjarLWaXYH1l9kKKiOQGQnYvTUsRzvNmPPop
   BAfGQkaul2sDz/CjeD+R/8r2dcm92rOdb5uSPm4/BHYOBBWh8nV2bnuzP
   A==;
X-CSE-ConnectionGUID: VRnZm4wzRSu4VqkiQYVGKw==
X-CSE-MsgGUID: uNs9wQEBTg6wWlkVBwLJ8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48861236"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48861236"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:27:38 -0800
X-CSE-ConnectionGUID: oQDa5SiYS823eKjDw8gYIA==
X-CSE-MsgGUID: Ytmp4ZN5TJipgPEwvimvig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92677371"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.237]) ([10.125.111.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:27:36 -0800
Message-ID: <9cbccaa0-f83e-4e92-bfbd-65a7ec08b2bd@intel.com>
Date: Wed, 13 Nov 2024 08:27:35 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241113081128.GAZzRfMIuLpzwHY_R7@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/24 1:11 AM, Borislav Petkov wrote:
> On Tue, Nov 12, 2024 at 03:12:37PM -0700, Dave Jiang wrote:
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>> index 3b9970117a0f..a8ad140d5692 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>>  	MCE_PRIO_NFIT,
>>  	MCE_PRIO_EXTLOG,
>>  	MCE_PRIO_UC,
>> +	MCE_PRIO_CXL,
>>  	MCE_PRIO_EARLY,
>>  	MCE_PRIO_CEC,
>>  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
> 
> Why this priority exactly?

Hi Boris,
I'm actually looking for recommendation on what the proper one is. The handler is expected to offline the aliased address of the reported MCE if there is one.

> 


