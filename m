Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F1068EEFE
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 13:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBHMc0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 07:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHMcZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 07:32:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084F46AD;
        Wed,  8 Feb 2023 04:32:24 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PBfRR3RSvz67y6K;
        Wed,  8 Feb 2023 20:28:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Feb
 2023 12:32:22 +0000
Date:   Wed, 8 Feb 2023 12:32:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        <dave.hansen@linux.intel.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 08/18] kernel/range: Uplevel the cxl subsystem's
 range_contains() helper
Message-ID: <20230208123221.0000516c@Huawei.com>
In-Reply-To: <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564539327.847146.788601375229324484.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 05 Feb 2023 17:03:13 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In support of the CXL subsystem's use of 'struct range' to track decode
> address ranges, add a common range_contains() implementation with
> identical semantics as resource_contains();
> 
> The existing 'range_contains()' in lib/stackinit_kunit.c is namespaced
> with a 'stackinit_' prefix.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c |    5 -----
>  include/linux/range.h  |    5 +++++
>  lib/stackinit_kunit.c  |    6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1d1492440287..9ed2120dbf8a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -214,11 +214,6 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
>  	return devm_add_action_or_reset(host, clear_mem_enable, cxlds);
>  }
>  
> -static bool range_contains(struct range *r1, struct range *r2)
> -{
> -	return r1->start <= r2->start && r1->end >= r2->end;
> -}
> -
>  /* require dvsec ranges to be covered by a locked platform window */
>  static int dvsec_range_allowed(struct device *dev, void *arg)
>  {
> diff --git a/include/linux/range.h b/include/linux/range.h
> index 274681cc3154..7efb6a9b069b 100644
> --- a/include/linux/range.h
> +++ b/include/linux/range.h
> @@ -13,6 +13,11 @@ static inline u64 range_len(const struct range *range)
>  	return range->end - range->start + 1;
>  }
>  
> +static inline bool range_contains(struct range *r1, struct range *r2)
> +{
> +	return r1->start <= r2->start && r1->end >= r2->end;
> +}
> +
>  int add_range(struct range *range, int az, int nr_range,
>  		u64 start, u64 end);
>  
> diff --git a/lib/stackinit_kunit.c b/lib/stackinit_kunit.c
> index 4591d6cf5e01..05947a2feb93 100644
> --- a/lib/stackinit_kunit.c
> +++ b/lib/stackinit_kunit.c
> @@ -31,8 +31,8 @@ static volatile u8 forced_mask = 0xff;
>  static void *fill_start, *target_start;
>  static size_t fill_size, target_size;
>  
> -static bool range_contains(char *haystack_start, size_t haystack_size,
> -			   char *needle_start, size_t needle_size)
> +static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
> +				     char *needle_start, size_t needle_size)
>  {
>  	if (needle_start >= haystack_start &&
>  	    needle_start + needle_size <= haystack_start + haystack_size)
> @@ -175,7 +175,7 @@ static noinline void test_ ## name (struct kunit *test)		\
>  								\
>  	/* Validate that compiler lined up fill and target. */	\
>  	KUNIT_ASSERT_TRUE_MSG(test,				\
> -		range_contains(fill_start, fill_size,		\
> +		stackinit_range_contains(fill_start, fill_size,	\
>  			    target_start, target_size),		\
>  		"stack fill missed target!? "			\
>  		"(fill %zu wide, target offset by %d)\n",	\
> 

