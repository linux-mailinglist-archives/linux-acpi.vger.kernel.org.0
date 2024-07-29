Return-Path: <linux-acpi+bounces-7106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C293EA79
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 03:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E1F281584
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 01:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA142F25;
	Mon, 29 Jul 2024 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCLiyCzr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F181F;
	Mon, 29 Jul 2024 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722215171; cv=none; b=JHNa+KBmHIsH1CrPDCHYwc2Xg3BdDaR2qcTdXYiG5+zB/j2EqK4CLaZdbQfFd/TQyaiFABTTdbyiVqO0ZLmuTz08Jq5BteZjMIJx2J/xc9N0WS4bwx3z8slit0AK9Tw2LkpXv0DsQwoHl/duWkW8BXeAEwJLa9RdJYlbZ7gfU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722215171; c=relaxed/simple;
	bh=qOJ6RBRjTGLapV6xbEMAa8VeNCVtyRWlp19GF/AmzT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xp175mbIPD76S8G0jsNiZCgdpvVyyV2TGOER69zfF/tuhsQFrHYjFcbBbl2nRMeUu+X9QaQVaUeyl93ZwrP7927OxEoUpHnXFpF/Bk6hkQ9wwkjI13FZR/rfq82rpTJ/D2vHKnYRY4kdgjmFqX2PCAbkIAnephQwQctkcDR9twQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCLiyCzr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722215170; x=1753751170;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qOJ6RBRjTGLapV6xbEMAa8VeNCVtyRWlp19GF/AmzT4=;
  b=hCLiyCzrPyt/RSCLx8pC+iMdVUhJ/ihHtSzJn9yvDt5QZ5KWgVtc8rcE
   8Ha4TC7RAc/6WTqjbZTUKmYic2jOmG2/uW8N2IbK9v3JEiy1CkQ7bB3c3
   SuPmuUos64WfFhf05gI8yNKXYrd31SbPsy34mQJPLCkEjZtR9AOBQOe7G
   uVXVucKdCQU66sTDSfCdDUuAWn0qyyxEqw+/Qlnm7BRT5HN0xA0wx/OjH
   VRvuk1ciVrtNMwxsSHufHmSMPcnHI0Ls/rlmnBovWI5RHEvRFm2tVKt/D
   8mxvN5/7jY0Yq1aA4Q8YNDTDI3wiw59/ij9hUfYPCv7hD8bkWsy7tgokB
   A==;
X-CSE-ConnectionGUID: YkJNXAZQT6eVFXrz9uyBhA==
X-CSE-MsgGUID: XMnwzXxYSfaRMU+1nOtXzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="20066497"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="20066497"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 18:06:09 -0700
X-CSE-ConnectionGUID: +N6szT4ZR1SD+KwFnQsw5w==
X-CSE-MsgGUID: CSENE5+DSjyzmsJ3rI5SFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="53774562"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 18:06:07 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  dave.jiang@intel.com,
  Jonathan.Cameron@huawei.com,  horenchuang@bytedance.com,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  dan.j.williams@intel.com,  lenb@kernel.org
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
In-Reply-To: <20240726215548.10653-1-gourry@gourry.net> (Gregory Price's
	message of "Fri, 26 Jul 2024 17:55:48 -0400")
References: <20240726215548.10653-1-gourry@gourry.net>
Date: Mon, 29 Jul 2024 09:02:33 +0800
Message-ID: <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> In the event that hmat data is not available for the DRAM tier,
> or if it is invalid (bandwidth or latency is 0), we can still register
> a callback to calculate the abstract distance for non-cpu nodes
> and simply assign it a different tier manually.
>
> In the case where DRAM HMAT values are missing or not sane we
> manually assign adist=(MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE).
>
> If the HMAT data for the non-cpu tier is invalid (e.g. bw = 0), we
> cannot reasonable determine where to place the tier, so it will default
> to MEMTIER_ADISTANCE_DRAM (which is the existing behavior).

Why do we need this?  Do you have machines with broken HMAT table?  Can
you ask the vendor to fix the HMAT table?

--
Best Regards,
Huang, Ying

> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/acpi/numa/hmat.c |  6 ++++--
>  mm/memory-tiers.c        | 10 ++++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c8ccc91ebe6..1642d2bd83b5 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -1080,8 +1080,10 @@ static __init int hmat_init(void)
>  	if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
>  		goto out_put;
>  
> -	if (!hmat_set_default_dram_perf())
> -		register_mt_adistance_algorithm(&hmat_adist_nb);
> +	if (hmat_set_default_dram_perf())
> +		pr_notice("Failed to set default dram perf\n");
> +
> +	register_mt_adistance_algorithm(&hmat_adist_nb);
>  
>  	return 0;
>  out_put:
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 6632102bd5c9..43bd508938ae 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -765,8 +765,14 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  	    perf->read_bandwidth + perf->write_bandwidth == 0)
>  		return -EINVAL;
>  
> -	if (default_dram_perf_ref_nid == NUMA_NO_NODE)
> -		return -ENOENT;
> +	/*
> +	 * If the DRAM tier did not have valid HMAT data, we can instead just
> +	 * assume that the non-cpu numa nodes are 1 tier below cpu nodes
> +	 */
> +	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
> +		*adist = MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE;
> +		return 0;
> +	}
>  
>  	/*
>  	 * The abstract distance of a memory node is in direct proportion to

