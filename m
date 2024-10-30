Return-Path: <linux-acpi+bounces-9143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92F9B7095
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 00:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663BD1C20316
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 23:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8B1D1E63;
	Wed, 30 Oct 2024 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2jWMTGw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061381CCB53;
	Wed, 30 Oct 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331467; cv=none; b=b/Oax8balQ/xFivj/17+c2t9AYL/6mjLJCn6GYmkV2oyMKLPZleUbVtrogCIq+j7KoElFSvezXaMk+syn58zk47HYSV854DGUjeJysyUYcDHxHtw7NNMgHGiyayK1WLF534tHa9sUoboouchwrnxIXGufg1eJ0boJrSV+TCCfJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331467; c=relaxed/simple;
	bh=G+pZ6voKXH7QPeAHSjwMmvLGMhzg97TUc5ZCYTm6kxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epRApgu7qqy4gCR3LmzccpfBjlCbSb7y5sufUrk/uC3GKW8GS2V57R6RZP6TONrzNhdtMfNV+vryyEoZJyUDBGsnUhTfScnm5RJRAlYGfFqRezwmOdfrTa9EYKA8Qd9MaLcyKBiPMsiY1SrrQfsUglQRHQRqMoED6ObWvamq2hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2jWMTGw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730331465; x=1761867465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G+pZ6voKXH7QPeAHSjwMmvLGMhzg97TUc5ZCYTm6kxY=;
  b=X2jWMTGwPz+dShr+GyW6NJiDTsBLsQnMT1qBnd3eGJ9jmzeysECQL2NE
   iEKJMzHLL5/iufu/LLYqi4zxzz+x7D5DyE11069mIAiaabmmDpW4u1jqi
   XYYfZpq7UNgNlzvIQjbiCpwq9VlYM56ZhzRzw8uPLrNhbVewIIrmNDX1C
   RXUmFQo+9GFtnFlWXGXGAUhVcKm9STCGMpXr/E5uy8Qw66nHWdVnpYWtM
   y+MstAugyd6nc3bvcGFr521FEldpye1WpNYPJiXYNlfx4bxxy/7w3cRfX
   1BHDEIllkNbvsoUQ3JsexFB0keh8gmYrWsykDdm2IdW4/39+/E+RO/edA
   w==;
X-CSE-ConnectionGUID: p2azaL6PSWKY8Tr2WAKNgA==
X-CSE-MsgGUID: HwFeXcZXSpSbLpLu69XL7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41156037"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41156037"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 16:37:44 -0700
X-CSE-ConnectionGUID: Ih9T5HSxQDO4FNXGTwvKQQ==
X-CSE-MsgGUID: De535YE6SKum6/2zJftpUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="82114624"
Received: from nnlnb-sb-019.ccr.corp.intel.com (HELO [10.125.108.160]) ([10.125.108.160])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 16:37:42 -0700
Message-ID: <3f0b1003-751d-4890-a045-854586eeda22@intel.com>
Date: Wed, 30 Oct 2024 16:37:41 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] cxl: Add mce notifier to emit aliased address for
 extended linear cache
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org,
 bp@alien8.de, dan.j.williams@intel.com, tony.luck@intel.com,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com
References: <20240927142108.1156362-1-dave.jiang@intel.com>
 <20240927142108.1156362-7-dave.jiang@intel.com>
 <20241017174058.000078bc@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241017174058.000078bc@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 9:40 AM, Jonathan Cameron wrote:
> On Fri, 27 Sep 2024 07:16:58 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Below is a setup with extended linear cache configuration with an example
>> layout of of memory region shown below presented as a single memory region
>> consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
>> The kernel sees a region of total 256G of system memory.
>>
>>               128G DRAM                          128G CXL memory
>> |-----------------------------------|-------------------------------------|
>>
>> Data resides in either DRAM or far memory (FM) with no replication. Hot data
>> is swapped into DRAM by the hardware behind the scenes. When error is detected
>> in one location, it is possible that error also resides in the aliased
>> location. Therefore when a memory location that is flagged by MCE is part of
>> the special region, the aliased memory location needs to be offlined as well.
>>
>> Add an mce notify callback to identify if the MCE address location is part of
>> an extended linear cache region and handle accordingly.
>>
>> Added symbol export to set_mce_nospec() in x86 code in order to call
>> set_mce_nospec() from the CXL MCE notify callback.
> 
> Whilst not commenting on whether any other implementation might exist,
> this code should be written to be arch independent at some level.

I did get a 0-day report on this with mce bits. But with asm/mce.h included, it seems to make other archs happy as well AFAICT.
> 
>>
>> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 


