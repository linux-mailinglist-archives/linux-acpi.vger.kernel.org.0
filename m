Return-Path: <linux-acpi+bounces-18846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDEAC54AB6
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 23:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F3203429FB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5255D2E7177;
	Wed, 12 Nov 2025 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9zIBYgk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4942E8882;
	Wed, 12 Nov 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984831; cv=none; b=hrkYAQXq4nU4qdluopcD++Zp+9N7tIIzrLBbQgvt0B4Hf3HYvuuCBPIr8UWLcYMHlUm8XgdfDEi84DlUKhOEbGA81+NbLmrCmZqQkcdbEfd2WqCW0IsJkiKtkk7RVFfPPHBGi8WLl3s4ahv2uWvIfC21h5IzSFH3hOdRhJI8ivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984831; c=relaxed/simple;
	bh=8einiIsxxf5fs/897eHpXlG7SJuYV//MoIz2CoI8zJU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WbvB2f+VCi0KXJ+/nzWxreIFYbOrJCLsnmdKC7RVUA1Jq+4A6RcSnqKdHFPGGZdsOZV/INkZUqDLiYMcWtvfyYCsS7WvxbbQEmntS4AtwFbrSPXOS7atx/9QKUx2y7WZf+jfMKAI2LjgL7RnQFXkbuSNUsobFNbBjNOJJ0pIr74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9zIBYgk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762984828; x=1794520828;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8einiIsxxf5fs/897eHpXlG7SJuYV//MoIz2CoI8zJU=;
  b=l9zIBYgkv2O/hF3rR2dXdibBnQo1jDU5xpPVw5otEYteqDe5PhVdutXR
   qVMlsNi2n5YYX5ispM9jDr222/l71YKyI+qvOlU1CxwQw3yB2H6IT6K4Y
   yzWfyJ2CXDTWwL9thlApT6t28a7CJNbA5c4yXa2EXTRoaAINotw8eYFqq
   uVGLC5i/6Uo96SKp5y9nQpcwmveWe7kpeTqrXBiMD+88gHzzBc9MTI/LK
   W1y8EZPCfLOn8P2Ikkju6AvSPAvbDbtwykPaBVQmE2fpApoSvjDvvOdwC
   n43GF1CrlhnqqkKp+tCPkpDGnOd/p60MfXgO5lpMDSVeR3U/gVg9N1b3I
   A==;
X-CSE-ConnectionGUID: +A3EkGpjSiKsrBu26YHxgQ==
X-CSE-MsgGUID: TBIeXk7ETjiaV8zZaAmnig==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="90531634"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="90531634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 14:00:27 -0800
X-CSE-ConnectionGUID: 1QCUs/zCQK+XlTSS1RIXGQ==
X-CSE-MsgGUID: KYiiAINDSq+BzGWhFk8I1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="219985121"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 14:00:27 -0800
Message-ID: <74468bd1-4eed-4a4a-ac8c-ab01cac90f06@intel.com>
Date: Wed, 12 Nov 2025 15:00:26 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 1/2] acpi/hmat: Return when generic target is
 updated
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20251105235115.85062-1-dave.jiang@intel.com>
 <20251105235115.85062-2-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251105235115.85062-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 4:51 PM, Dave Jiang wrote:
> With the current code flow, once the generic target is updated
> target->registered is set and the remaining code is skipped.
> So return immediately instead of going through the checks and
> then skip.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
15e14267889bde30b7b82bc03432483222b4b42c

> ---
> no changes
> ---
>  drivers/acpi/numa/hmat.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 5a36d57289b4..1dc73d20d989 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -888,12 +888,13 @@ static void hmat_register_target(struct memory_target *target)
>  	 * Register generic port perf numbers. The nid may not be
>  	 * initialized and is still NUMA_NO_NODE.
>  	 */
> -	mutex_lock(&target_lock);
> -	if (*(u16 *)target->gen_port_device_handle) {
> -		hmat_update_generic_target(target);
> -		target->registered = true;
> +	scoped_guard(mutex, &target_lock) {
> +		if (*(u16 *)target->gen_port_device_handle) {
> +			hmat_update_generic_target(target);
> +			target->registered = true;
> +			return;
> +		}
>  	}
> -	mutex_unlock(&target_lock);
>  
>  	/*
>  	 * Skip offline nodes. This can happen when memory


