Return-Path: <linux-acpi+bounces-9921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D19E46CB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 22:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9418DB252B7
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E717335C;
	Wed,  4 Dec 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CizoaqtZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B418C930;
	Wed,  4 Dec 2024 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345719; cv=none; b=YhEZbPaAXwJmGfJZy1ZzHIkJUxQhPO8NPOqPnjv1NBdIKE00DO8fa7TgYBiHW27yBWqvaqGSgZomunuqRHWh9flskR8O6egUmNKF2YYA/qGZXhdUA4sNQeyAmGm7tY2YLI8/GxAMPq6TpewgfBEed1DEc4F9fBTY0HXzkkQs97M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345719; c=relaxed/simple;
	bh=dS7ckHGtE5hCBAFxg01h3TzM6QYneUMd4g8shhdWLCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8FjItWtZzcOYqb+6Qme3+ErbXsixR1eNtNqubVR45kWh8H+4BMFpjViAUJSr4aqiJ8JGfnUjMRo42ENueRCFjGIH46NLfzqea85tpT/T8YrGuvTNHJNIZy3TRRIic59Gr33Ape6LTAdau1XqPH9v4t1Q08420STgED8a075h+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CizoaqtZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733345718; x=1764881718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dS7ckHGtE5hCBAFxg01h3TzM6QYneUMd4g8shhdWLCQ=;
  b=CizoaqtZOM6L24cIOiEf846OjWLrQtbwF7LhM74P9UU6BuPN5pMCk2UM
   +WyvoAQmM3PExIIV4nJczukbv4W6deE4jIvXl4rNLZOFH+pmZDsCI1rZT
   f2Pap31oiGLJ0QjkBOZiPLCp8RUHoy0/WzlpmKUoOLEPh49EdaT4SPSyi
   SU3ph7q7cesntTqG3wiOhDV7RMN6bAVJ9zxUBBe9l6FMchWTpQx+waGyK
   FBsLsnKlxC9/wyttak2SNgnvDlun8W449cmwBkOWXw3cFVAs5AMClmJp3
   KB5kmzrex7FfW+acTMEcINjyYuseBQVFGN4ZELp7VS8PeqYNDFSUfRkvM
   g==;
X-CSE-ConnectionGUID: u6octmNCSFOC+bdB5vsqcw==
X-CSE-MsgGUID: v+JXehx3TUe3UzuSHRpzEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33549488"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33549488"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 12:55:18 -0800
X-CSE-ConnectionGUID: II8p9UuMRny536qM9wuXng==
X-CSE-MsgGUID: 5fTGmjybSli+TkDvuFxg/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93726894"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.85]) ([10.125.108.85])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 12:55:16 -0800
Message-ID: <6ab6a115-531d-4dfc-a273-61311d27d9a2@intel.com>
Date: Wed, 4 Dec 2024 13:55:15 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/HMAT: Move HMAT messages to pr_debug()
To: Dan Williams <dan.j.williams@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Priya Autee <priya.v.autee@intel.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
 <CAJZ5v0gTc_FzwkSxPEa7izbDYz6BWqx72TzEXxHGd3MRR8EUFQ@mail.gmail.com>
 <0ca3dbc4-e791-404c-8058-2b2c24051f5e@nvidia.com>
 <48ee2dde-de1b-4af4-91c8-eebb4e15e191@nvidia.com>
 <c2c5a70b-8b8c-414b-813a-f0a82562f718@nvidia.com>
 <6750b7003ed08_2508129452@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6750b7003ed08_2508129452@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/4/24 1:09 PM, Dan Williams wrote:
> Kai-Heng Feng wrote:
>>
>>
>> On 2024/10/23 10:02 AM, Kai-Heng Feng wrote:
>>>
>>>
>>> On 2024/10/7 11:03 AM, Kai-Heng Feng wrote:
>>>> Hi Rafael,
>>>>
>>>> On 2024/1/31 7:54 PM, Rafael J. Wysocki wrote:
>>>>> On Wed, Jan 31, 2024 at 9:30 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>>>>>
>>>>>> The HMAT messages printed at boot, beyond being noisy, can also print
>>>>>> details for nodes that are not yet enabled. The primary method to
>>>>>> consume HMAT details is via sysfs, and the sysfs interface gates what is
>>>>>> emitted by whether the node is online or not. Hide the messages by
>>>>>> default by moving them from "info" to "debug" log level.
>>>>>>
>>>>>> Otherwise, these prints are just a pretty-print way to dump the ACPI
>>>>>> HMAT table. It has always been the case that post-analysis was required
>>>>>> for these messages to map proximity-domains to Linux NUMA nodes, and as
>>>>>> Priya points out that analysis also needs to consider whether the
>>>>>> proximity domain is marked "enabled" in the SRAT.
>>>>>>
>>>>>> Reported-by: Priya Autee <priya.v.autee@intel.com>
>>>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>>>
>>>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> This patch doesn't seem to be included in the tree.
>>>>
>>>> Is it possible to pick this up in the your tree? Thanks!
>>>
>>> A gentle ping...
>>
>> Another gentle ping...
> 
> Rafael acked it, so he probably expected me to take it through the CXL
> tree? In any event we can get this queued up in cxl.git unless Rafael
> beats me to it and applies it.
> 
I'll pick it up for cxl-next


