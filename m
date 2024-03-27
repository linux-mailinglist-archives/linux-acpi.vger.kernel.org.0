Return-Path: <linux-acpi+bounces-4476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCFA88D60E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 06:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BD72A54D3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D851CA87;
	Wed, 27 Mar 2024 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PT+Fg3NF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6861AACA;
	Wed, 27 Mar 2024 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518605; cv=none; b=LqO0pfw3MtYGwSrh/aepuZQ4mpUOGxCNDx80E+Hqz1w2qfZgw1RnPU6sFQSDb0jNk3mQFDSdYZ7BuNjp4mvxWECZCw+L0dCKhZ/2ZexwNJ4nrokc0UVIdHEmqS9ji80G9KFBJjC+1426Y8jSgXUy13iS+ABeWKDr9k3I0dZSZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518605; c=relaxed/simple;
	bh=NGhsAu+sz1EG8a0MGs6ihEvAoXlJ1KKzmRjwQND6aHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7i8q0/gjgb+sQblwWDfp6gBCZpo1y9WtTLnjyFYufnC6N1zryLZVUq5sO4Mz2bCWx7L/VKMSrdSCc+OvNXwqgf0EQq5Kq7Za2j0d+G27zDo8+c++7dQuO41U+3OspZFxV3J0w2lJTYzcVrYazFEwax0Mm6Ac55X9pM17PjiC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PT+Fg3NF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711518602; x=1743054602;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGhsAu+sz1EG8a0MGs6ihEvAoXlJ1KKzmRjwQND6aHU=;
  b=PT+Fg3NF0C7oH+QLXjD+oLG2Fngukc7N2cQ+dlTxE5VMxxep7qXstjQK
   CEWTgDTOcrvW8t395o249MaTB0+IxEKntOAIQtcehK0eU985B1i+ktF2p
   rBP+YnZRsn3+mJNXi1dAlrkFS9W9bfkjXN95if3qtinaxFEHPIF2RiZRP
   nXyUA2a63aBJP92We17G+gs1279X9u/xqMadcL33laFi86I2Ue6oA8Je6
   1h+D8Ty6QBiUvjqby3Kh8ZWSX5BrJGJDTucBHmOA4l1nZat2Nh2rVJ+2z
   5zLpSOECZCKgJdjxTYjIdLdDvtJEbQ8PLuvxMnv/AXYDN0ArH+DSMOCSk
   w==;
X-CSE-ConnectionGUID: XHH7WMu/R9uxxPYKNzoA1Q==
X-CSE-MsgGUID: 8+PGB8ZtR2WGWhsPswjYyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9563591"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="9563591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16833210"
Received: from xuezengd-mobl.amr.corp.intel.com (HELO [10.209.17.216]) ([10.209.17.216])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 22:50:01 -0700
Message-ID: <3cad4f7f-382e-4898-8867-d48340a2ed01@linux.intel.com>
Date: Tue, 26 Mar 2024 22:50:00 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] ACPI: scan: A few ad-hoc cleanups
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/25/24 5:32 AM, Andy Shevchenko wrote:
> While looking for something else in the scan.c I noticed the room
> of improvement. Hence this series. Also bus.c patches, which some
> how were related to my research, but I think are independent from
> the scan.c improvements.

Changes looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Andy Shevchenko (7):
>   ACPI: bus: Make container_of() no-op where it makes sense
>   ACPI: bus: Don't use "proxy" headers
>   ACPI: scan: Replace infinite for-loop with finite while-loop
>   ACPI: scan: Use list_first_entry_or_null() in acpi_device_hid()
>   ACPI: scan: Move misleading comment to acpi_dma_configure_id()
>   ACPI: scan: Use standard error checking pattern
>   ACPI: scan: Introduce typedef:s for struct acpi_hotplug_context
>     members
>
>  drivers/acpi/dock.c     | 48 +++++++++++++++--------------------------
>  drivers/acpi/scan.c     | 42 +++++++++++++++++-------------------
>  include/acpi/acpi_bus.h | 28 +++++++++++++++---------
>  3 files changed, 55 insertions(+), 63 deletions(-)
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


