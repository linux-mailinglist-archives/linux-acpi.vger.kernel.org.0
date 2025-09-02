Return-Path: <linux-acpi+bounces-16301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9825B410A2
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 01:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81D3561CE1
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4111E9905;
	Tue,  2 Sep 2025 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx5HmeMM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10F23B0;
	Tue,  2 Sep 2025 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854999; cv=none; b=HNz946c2b4r/kS254h5QN127SDri4WSADisVTeI/2a7KSAaEDuEn64IRbt3XMkToXGS/pNMh+haTYJjnfe6i5BvdSu4Yl+hCiCoKPE7/gDfpVZdHqpWRHb+AMGBnbr7DNXyZVABT/aCgp17mrxn05eD2MZ9YZUfFc/hqR7I3x8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854999; c=relaxed/simple;
	bh=rKZ0Nh3RqLt7tI4TxWi0XsS1AUOFKimTgfg+6MXiFRk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rasbgZoRGbDLajD+Y/9n2ZGRqiujN+tbLtDe0iYKsMQES/A3n0ETyP6MyqYs2tB7S2smpsVxqjYrkVsKiQyNuLf5MEfp4hkx2aqyY8Su1682f8jO3o6gT2O5igQ0wRQYtQIebl9CyqfMvDtuuBLw0ngVk1mObfoejjGfiiBdZro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx5HmeMM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756854997; x=1788390997;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rKZ0Nh3RqLt7tI4TxWi0XsS1AUOFKimTgfg+6MXiFRk=;
  b=jx5HmeMMyM4IpPDDHYZ8oGFTbNjw4RIWIA7GAsF/bBn76rqtGOHE35+g
   6B707NRELTtIGyRT/+KM1mWRbiG5JUFD002XJgoRSqjKAUBPRFdDZjdaB
   DLEYZhmZjjRWM9RXQeyo4pKJwBvW3pLGNqN9j1Y8bRvuzhVtXzz8fuPJ7
   GcTv+n1eBhRkrau5Y2SCH8Qa99UH0JPGVMSWRXFWEykSXUHlA4DBTLxfm
   REIa5NlFsbHY9rdKYr4y2IawFaFMtablUGkLJ7mSEGkabv4mB7GV0PjBt
   /LHSUyzls1wpo8XCnnlMfn5zWtj8MT70pYDQMr0aJ4gZSKIusGqG7dZqd
   g==;
X-CSE-ConnectionGUID: A07RvFEkRISgXVJTBsr1BQ==
X-CSE-MsgGUID: FMftboe/SvKaJlkpm01EFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59069949"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59069949"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:16:36 -0700
X-CSE-ConnectionGUID: /TDJio1bRD65DbAqOEH9gQ==
X-CSE-MsgGUID: QFHtOfN1RP26sXgES81hZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="176712943"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.76]) ([10.247.118.76])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:16:28 -0700
Message-ID: <8212254f-2c2b-4a48-8238-eacabc5645f4@intel.com>
Date: Tue, 2 Sep 2025 16:16:23 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] cxl, acpi/hmat, node: Update CXL access
 coordinates to node directly
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org, david@redhat.com
References: <20250829222907.1290912-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250829222907.1290912-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 3:29 PM, Dave Jiang wrote:
> I plan to take this series through the CXL tree when all the necessary tags
> are received.
> 
> Rafael, please ack patches 3/4 and 4/4 if you are happy with the changes.
> 
> Thank you!

Rafael said Dan's review tag is sufficient.

Applied to cxl/next
02f6c6a3654911e286ae04e5dfd5deb0f39559b1

> 
> v3:
> - Fix grammar in comment. (DavidH)
> - Use nodemask instead of xarray. (Jonathan)
> 
> v2:
> - Use clearer comment from DavidH for 1/4. (DavidH)
> - Fix comment in 2/4. (DavidH)
> - Streamline code in 2/4. (DavidH)
> - Add description to observed issue. (Dan)
> - Add correct Fixes tag. (Dan)
> - Add cc to stable for fix patch. (Dan)
> - Add mechansim to only update on first region for the node. (Jonathan)
> 
> The series aim to clean up the current CXL memory region hotplug notifier by
> removing the update path through HMAT and updating the node access coordinates
> directly. With the existing implementation, the CXL memory hotplug notifier
> gets called first. It updates the HMAT target access coordinates. And then
> the HMAT notifier gets called and create the node sysfs attribs. The new
> implemenation flips the callback ordering and directly updates the sysfs
> attribs already created in the node and leaves HMAT data structures alone.
> 
> Dave Jiang (4):
>   mm/memory_hotplug: Update comment for hotplug memory callback
>     priorities
>   drivers/base/node: Add a helper function node_update_perf_attrs()
>   cxl, acpi/hmat: Update CXL access coordinates directly instead of
>     through HMAT
>   acpi/hmat: Remove now unused hmat_update_target_coordinates()
> 
>  drivers/acpi/numa/hmat.c  | 34 ----------------------------------
>  drivers/base/node.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/cdat.c   | 11 -----------
>  drivers/cxl/core/core.h   |  3 ---
>  drivers/cxl/core/region.c | 20 ++++++++++++--------
>  include/linux/acpi.h      | 12 ------------
>  include/linux/memory.h    |  6 +++---
>  include/linux/node.h      |  8 ++++++++
>  8 files changed, 61 insertions(+), 71 deletions(-)
> 
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585


