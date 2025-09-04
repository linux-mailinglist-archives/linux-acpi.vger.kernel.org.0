Return-Path: <linux-acpi+bounces-16370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90823B44440
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566B01CC12B8
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6680292938;
	Thu,  4 Sep 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWEYquBJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294DEEAB
	for <linux-acpi@vger.kernel.org>; Thu,  4 Sep 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006753; cv=none; b=jDYNSfvjaSrOqyh7c3rGcnJNX5frv4EZfeex+9B8LMiBNdvaNwFhhmjqDMLtlv+uakhaq5QxIFPwtCu+cKYI56Xb1/1WTtYR5ihlKMJa/6YS7V3UER8G2l8xnyicrFfcTojSVoXFbMcbsHZFB2PjPizhGMnhDmXPS3VGjtVUCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006753; c=relaxed/simple;
	bh=uWbBIU4w3aLjzzZXHzzipzpYkmsV2qF93OFDrZU6U1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3lEZd3CeRUHk7u5igkxNEd5Xop9OwNu0FGahjGpGGyzpY9JtQnk0L2W95p8iqarvBReD0WB0qlPck+L3kcrBo+VtcvAZo/SermpX4iDrex+2N5dIpBiAHuF2wX1HInp0RMO3Om6rUpDwwLO8Y9IM3uPjybUGnrT5I7vf1FoPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWEYquBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD20C4CEF0;
	Thu,  4 Sep 2025 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006753;
	bh=uWbBIU4w3aLjzzZXHzzipzpYkmsV2qF93OFDrZU6U1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWEYquBJUUyxun9aoT8Xkk8GrFE84DTB7ULwGOwIkaN8Gd8yLTnmdMH2GnwXVvkLj
	 f5wEGhspBaXR++6faQCybvpWSNhJT5fDiNjYJMefAeJ/ouUHFfFTU9jBsRm6R/p/Nt
	 iryuEKioWEuS8rBewYZfxSNYooci3kZraESh1bWSmhRNfnsvaQ9YANTMpyiigPAyC7
	 JrlxXM9vsN4uKsIbWrzEX619YL1fZlvYJr3FGNH0nubG4xdGOWEGvi4rjw8bJeB9r2
	 faaGdNRVjbs8MMa7/jNPZJLLNPWOdFiFqJO0Z6xBX9OnVxrzFazfm267zWOQKLhVqv
	 JxjFbt9al15Zw==
Date: Thu, 4 Sep 2025 20:25:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, surenb@google.com,
	"Anderson, Russ" <russ.anderson@hpe.com>, osalvador@suse.de,
	nao.horiguchi@gmail.com, mhocko@suse.com,
	lorenzo.stoakes@oracle.com, linmiaohe@huawei.com,
	liam.howlett@oracle.com, jiaqiyan@google.com, jane.chu@oracle.com,
	david@redhat.com, bp@alien8.de, "Meyer, Kyle" <kyle.meyer@hpe.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
	linux-acpi@vger.kernel.org, Shawn Fan <shawn.fan@intel.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Message-ID: <aLnLlyrfNjY-hMuU@kernel.org>
References: <20250904155720.22149-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904155720.22149-1-tony.luck@intel.com>

On Thu, Sep 04, 2025 at 08:57:20AM -0700, Tony Luck wrote:
> BIOS can supply a GHES error record that reports that the corrected
> error threshold has been exceeded. Linux will attempt to soft offline
> the page in response.
> 
> But "exceeded threshold" has many interpretations. Some BIOS versions
> accumulate error counts per-rank, and then report threshold exceeded
> when the number of errors crosses a threshold for the rank. Taking
> a page offline in this case is unlikely to solve any problems. But
> losing a 4KB page will have little impact on the overall system.
> 
> On the other hand, taking a huge page offline will have significant
> impact (and still not solve any problems).
> 
> Check if the GHES record refers to a huge page. Skip the offline
> process if the page is huge.
> 
> Reported-by: Shawn Fan <shawn.fan@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index a0d54993edb3..bacfebdd4969 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -540,8 +540,16 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>  
>  	/* iff following two events can be handled properly by now */
>  	if (sec_sev == GHES_SEV_CORRECTED &&
> -	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED)) {
> +		unsigned long pfn = PHYS_PFN(mem_err->physical_addr);
> +		struct page *page = pfn_to_page(pfn);
> +		struct folio *folio = page_folio(page);

There's pfn_folio(), saves a line :)

> +
> +		if (folio_test_hugetlb(folio))
> +			return false;
> +
>  		flags = MF_SOFT_OFFLINE;
> +	}
>  	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>  		flags = sync ? MF_ACTION_REQUIRED : 0;
>  
> -- 
> 2.51.0
> 

-- 
Sincerely yours,
Mike.

