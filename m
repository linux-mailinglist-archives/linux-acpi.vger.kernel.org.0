Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC08143479F
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJTJJQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 05:09:16 -0400
Received: from out2.migadu.com ([188.165.223.204]:45555 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTJJQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 05:09:16 -0400
Date:   Wed, 20 Oct 2021 18:06:48 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634720819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tGGXBZ9nlftRplzRbnEZFgw5OfzmeC3UbiQRyY/SD4g=;
        b=iyyaGvxKReDsgdxRk0A/KeITXndpJQs1eMSQ8Kz/gyvZjZqUlZkqtcl78GxDndmrjgz3Cm
        fkL4mzmIsSBMdamZj0cvOcH84FAcajsUrjWPjWbOqyUOUEz+0QVqD3nORC8Cb8rZN/4+69
        SblbdQh4QvbeVd1hCaLkHTylL16wMYA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v10 5/7] x86/sgx: Hook arch_memory_failure() into
 mainline code
Message-ID: <20211020090648.GA2339043@u2004>
References: <20211011185924.374213-1-tony.luck@intel.com>
 <20211018202542.584115-1-tony.luck@intel.com>
 <20211018202542.584115-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211018202542.584115-6-tony.luck@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 18, 2021 at 01:25:40PM -0700, Tony Luck wrote:
> Add a call inside memory_failure() to call the arch specific code
> to check if the address is an SGX EPC page and handle it.
> 
> Note the SGX EPC pages do not have a "struct page" entry, so the hook
> goes in at the same point as the device mapping hook.
> 
> Pull the call to acquire the mutex earlier so the SGX errors are also
> protected.
> 
> Make set_mce_nospec() skip SGX pages when trying to adjust
> the 1:1 map.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
...
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a52aba448f..62b199ed5ec6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3284,5 +3284,19 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +#ifndef arch_memory_failure
> +static inline int arch_memory_failure(unsigned long pfn, int flags)
> +{
> +	return -ENXIO;
> +}
> +#endif
> +
> +#ifndef arch_is_platform_page
> +static inline bool arch_is_platform_page(u64 paddr)
> +{
> +	return false;
> +}
> +#endif
> +

How about putting these definitions near the other related functions
in the same file (like below)?

  ...
  extern void shake_page(struct page *p);
  extern atomic_long_t num_poisoned_pages __read_mostly;
  extern int soft_offline_page(unsigned long pfn, int flags);
  
  // here?
  
  /*
   * Error handlers for various types of pages.
   */
  enum mf_result {

Otherwise, the patch looks good to me.

Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks,
Naoya Horiguchi
