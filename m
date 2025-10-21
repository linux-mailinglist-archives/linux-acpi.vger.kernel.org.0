Return-Path: <linux-acpi+bounces-18043-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 314EABF740E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 17:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14C74FB4EF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD41342CA3;
	Tue, 21 Oct 2025 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYknvFXf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E417342C96;
	Tue, 21 Oct 2025 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059174; cv=none; b=tbcyDxclxIYAr8Jj/NPmkg1fnSmJnMv7KnkRnG1GIx57lYBU6rlONYHVrYXjy5ErliK7oeUA9FZ9zUTFgDfIH9N7lRY+2mGXRjwmawPkIS1k4SkPTKpqFi4face+z0RBg2NBeWTIpFxqdlDFZGSYnAz9FhkTNJS58oE0x19X550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059174; c=relaxed/simple;
	bh=XvTwGNFuSfbqy6vW3WT4GVwL8451owX3V6vI14/b4+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt+n7FO6hg2vPRfZXbJ6bFFcvxBFD1aMSd2EM7qHYYD1LIFlHHQlLqL8TgZe6GXznZ0Ps3VsDAyF32k4s1pnuikJolnhnn+hhc0iF8Bnhj7h+Og+eh08Baxjvwr/PnxQk6aVPxSQXoFS0rV1DKV/9/I/qb9D9VhpAN7fh7CGObI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYknvFXf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761059173; x=1792595173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XvTwGNFuSfbqy6vW3WT4GVwL8451owX3V6vI14/b4+M=;
  b=aYknvFXf3KxFpfpYo5p/QXXge8C+31gS7jsGXW/0Rh6Od7mSyD043Tvk
   uZ/NgqNVJw9zZPhbB35Aws4t3kyY/dOl4tCvh9hg9o8OznH8tCowieG5X
   X8pOaQLHjF6F40qqWtAemuR/h52XwmMcN+7LvmcqMyLbb5bFhd9/nE41H
   gmpmVbME+4rmu78EbKIe8NV9LRk6OV1LWEs2IPzIjgRKY+zrjiRiOAsZl
   8NG2onoAiNq5VihSSKX8s4jF2bKrXY/hfptyFSHy6tvSCApdkF6ZhuMlD
   V4WxPKL102VoXsD+5Pil/Mu3/VquiK+HZARFOESimmBG05h+KhZbqk9AK
   A==;
X-CSE-ConnectionGUID: sVK8fyeVSQm2D7yjB7pshA==
X-CSE-MsgGUID: t/FL3wN9TTuq7sUpiJJLVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63096641"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="63096641"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:12 -0700
X-CSE-ConnectionGUID: hPdaPEAhRSSL3lr8QNk2Bw==
X-CSE-MsgGUID: 5dPLaha8S0Obp9mkoJFipA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="188016523"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.169]) ([10.125.108.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:10 -0700
Message-ID: <2ee6c734-7a6e-4888-b00f-17de1c0f5e5a@intel.com>
Date: Tue, 21 Oct 2025 08:06:09 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lenb@kernel.org, robert.moore@intel.com, andrew@kernel.org,
 bfaccini@nvidia.com, eahariha@linux.microsoft.com, dan.j.williams@intel.com,
 thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
 <20250915093549.00006109@huawei.com>
 <45d5e6a9-d561-4df9-96d4-285f2ca12888@linux.alibaba.com>
 <CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/21/25 6:30 AM, Rafael J. Wysocki wrote:
> On Tue, Oct 21, 2025 at 8:55 AM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2025/9/15 16:35, Jonathan Cameron 写道:
>>> On Sat, 13 Sep 2025 10:32:24 +0800
>>> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>>>
>>>> The Generic Initiator Affinity Structure in SRAT table uses device
>>>> handle type field to indicate the device type. According to ACPI
>>>> specification, the device handle type value of 1 represents PCI device,
>>>> not 0.
>>>>
>>>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>>>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>
>>> Thanks!
>>>
>>>> ---
>>>> changes since v1: drop changes in actbl3.h to make it easy to progress per Jonathan
>>>> ---
>>
>>
>> Hi, Rafael,
>>
>> Gentle ping.
>>
>> Are you happy to pick this bugfix up in this cycle?
> 
> drives/acpi/numa/ is maintained by Dave.

Applied to cxl/fixes
7c3643f204edf1


