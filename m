Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6D68F497
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 18:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjBHRb5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 12:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjBHRbz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 12:31:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CE5193E3;
        Wed,  8 Feb 2023 09:31:53 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PBn4z2DpZz6J64s;
        Thu,  9 Feb 2023 01:27:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Feb
 2023 17:31:50 +0000
Date:   Wed, 8 Feb 2023 17:31:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 12/18] tools/testing/cxl: Define a fixed volatile
 configuration to parse
Message-ID: <20230208173149.000043a2@Huawei.com>
In-Reply-To: <167564541523.847146.12199636368812381475.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
        <167564541523.847146.12199636368812381475.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Sun, 05 Feb 2023 17:03:35 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Take two endpoints attached to the first switch on the first host-bridge
> in the cxl_test topology and define a pre-initialized region. This is a
> x2 interleave underneath a x1 CXL Window.
> 
> $ modprobe cxl_test
> $ # cxl list -Ru
> {
>   "region":"region3",
>   "resource":"0xf010000000",
>   "size":"512.00 MiB (536.87 MB)",
>   "interleave_ways":2,
>   "interleave_granularity":4096,
>   "decode_state":"commit"
> }
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/core.h      |    3 -
>  drivers/cxl/core/hdm.c       |    3 +
>  drivers/cxl/core/port.c      |    4 +
>  drivers/cxl/cxl.h            |    4 +
>  drivers/cxl/cxlmem.h         |    3 +
>  tools/testing/cxl/test/cxl.c |  146 +++++++++++++++++++++++++++++++++++++++---
>  6 files changed, 148 insertions(+), 15 deletions(-)
> 

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8130430ffbcf..8d0895cbae93 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -458,6 +458,7 @@ bool is_switch_decoder(struct device *dev)
>  {
>  	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
>  }
> +EXPORT_SYMBOL_NS_GPL(is_switch_decoder, CXL);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev)
>  {
> @@ -485,6 +486,7 @@ struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
>  		return NULL;
>  	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, CXL);
>  
>  static void cxl_ep_release(struct cxl_ep *ep)
>  {
> @@ -528,7 +530,7 @@ static const struct device_type cxl_port_type = {
>  
>  bool is_cxl_port(struct device *dev)
>  {
> -	return dev->type == &cxl_port_type;
> +	return dev && dev->type == &cxl_port_type;

Adding that protection just for mocking seems a bit nasty.
Could you push the sanity check out to the caller or am I missing something?
Perhaps worth calling out the reason we'd call this on a NULL dev with a comment
or similar.


>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_port, CXL);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b3765c5c81a..4c6ee6c96f23 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -452,6 +452,7 @@ struct cxl_region_params {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> + * @fixed: At least one decoder in this region was locked down at init
>   * @mode: Endpoint decoder allocation / access mode
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> @@ -462,6 +463,7 @@ struct cxl_region_params {
>  struct cxl_region {
>  	struct device dev;
>  	int id;
> +	bool fixed;

I was wondering why a mocking patch was changing the region state structure...
It isn't - this isn't used that I can find.

>  	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;

