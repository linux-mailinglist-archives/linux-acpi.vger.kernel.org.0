Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44568CAB3
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 00:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBFXlx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 18:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBFXlv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 18:41:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6524125;
        Mon,  6 Feb 2023 15:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675726910; x=1707262910;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=efYutd2gsnNzH297fwifRvRlt/qqZtH/7DxCoPKBvbo=;
  b=mJf5Y0KvPdKUcMoieZRpJSI3wrFUzrYqO52hoLaG/r41UfmZXlsgkZMz
   RQhG40O6eAqxTnDSW4Wb2pInFSBM2n2cXjvyNmWYOxjgrn7BWXaGV/YQc
   je+QYzowH+O5SHhboXrbk2TKCJJsqfWLW+ktmdN4+8mxD9Lmy+uqqCHAX
   odaM3y+bFaLxiS3Wb4ZfjVLa2eypaNn/l2qUJaxI8yGjLwp+mR1SjPKsX
   KkOM0NSIln8jlrzI77CpGgH6s04WL4l8pq0wdMwImuX03VWVBeUKEeF6A
   M/QJCqTxqXUqnx4rJyJh2+amgQZgAPtlU7m5VyQClrtx3A0KD266X8tsp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393946001"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393946001"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 15:41:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="660001013"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="660001013"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.111.195]) ([10.212.111.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 15:41:48 -0800
Message-ID: <081043d0-d8c5-d86a-8515-aaf1ed7ba47e@intel.com>
Date:   Mon, 6 Feb 2023 16:41:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/5/23 6:03 PM, Dan Williams wrote:
> In support of the CXL subsystem's use of 'struct range' to track decode
> address ranges, add a common range_contains() implementation with
> identical semantics as resource_contains();
> 
> The existing 'range_contains()' in lib/stackinit_kunit.c is namespaced
> with a 'stackinit_' prefix.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I can use this in my QTG series for DPA matching.
> ---
>   drivers/cxl/core/pci.c |    5 -----
>   include/linux/range.h  |    5 +++++
>   lib/stackinit_kunit.c  |    6 +++---
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1d1492440287..9ed2120dbf8a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -214,11 +214,6 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
>   	return devm_add_action_or_reset(host, clear_mem_enable, cxlds);
>   }
>   
> -static bool range_contains(struct range *r1, struct range *r2)
> -{
> -	return r1->start <= r2->start && r1->end >= r2->end;
> -}
> -
>   /* require dvsec ranges to be covered by a locked platform window */
>   static int dvsec_range_allowed(struct device *dev, void *arg)
>   {
> diff --git a/include/linux/range.h b/include/linux/range.h
> index 274681cc3154..7efb6a9b069b 100644
> --- a/include/linux/range.h
> +++ b/include/linux/range.h
> @@ -13,6 +13,11 @@ static inline u64 range_len(const struct range *range)
>   	return range->end - range->start + 1;
>   }
>   
> +static inline bool range_contains(struct range *r1, struct range *r2)
> +{
> +	return r1->start <= r2->start && r1->end >= r2->end;
> +}
> +
>   int add_range(struct range *range, int az, int nr_range,
>   		u64 start, u64 end);
>   
> diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
> index 4591d6cf5e01..05947a2feb93 100644
> --- a/lib/stackinit_kunit.c
> +++ b/lib/stackinit_kunit.c
> @@ -31,8 +31,8 @@ static volatile u8 forced_mask = 0xff;
>   static void *fill_start, *target_start;
>   static size_t fill_size, target_size;
>   
> -static bool range_contains(char *haystack_start, size_t haystack_size,
> -			   char *needle_start, size_t needle_size)
> +static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
> +				     char *needle_start, size_t needle_size)
>   {
>   	if (needle_start >= haystack_start &&
>   	    needle_start + needle_size <= haystack_start + haystack_size)
> @@ -175,7 +175,7 @@ static noinline void test_ ## name (struct kunit *test)		\
>   								\
>   	/* Validate that compiler lined up fill and target. */	\
>   	KUNIT_ASSERT_TRUE_MSG(test,				\
> -		range_contains(fill_start, fill_size,		\
> +		stackinit_range_contains(fill_start, fill_size,	\
>   			    target_start, target_size),		\
>   		"stack fill missed target!? "			\
>   		"(fill %zu wide, target offset by %d)\n",	\
> 
