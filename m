Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76E5752BBB
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jul 2023 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjGMUf5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jul 2023 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjGMUfz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2023 16:35:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC152127
        for <linux-acpi@vger.kernel.org>; Thu, 13 Jul 2023 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689280554; x=1720816554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AK8EGyXuC8LhczGSHhQ5MxyAISKNC7yNcGgKWvZ4M0c=;
  b=XZDcLHuCyVOJZopfCcliKaB57B93liS/QqXN8O4e4Czy6eXrQAFL8aEz
   b4gs5y00R7Bc8BaBEWjzmQ5/ujWjl2ExR9kVcuwR1zs58Hjohbfu+5qLA
   P4eVAyiV5uN9/9fczJ881DVTI86xLxt50iRZDfAcxTxL9CZDEO8bOhxz6
   tDInM5D65SonTwPLLdED4btGZqhFjVMmzvbosjYiO0fnpVa2zFof20GrV
   13UcpAGg+S7xlckQuYyyzewdPl7p9Fl+LGxCQhUdZTnt4dPTfNTbfqXP3
   i1YR/2FCxfdNjPmITpacZJCKX1W5RtUdvwtc/fxAr5VIDvY7o2qpLGUph
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362773218"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="362773218"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 13:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725438653"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="725438653"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.243.201])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 13:35:53 -0700
Date:   Thu, 13 Jul 2023 13:35:51 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NFIT: add helper to_nfit_mem() to take device
 to nfit_mem
Message-ID: <ZLBgJ07vFre9VymJ@aschofie-mobl2>
References: <20230712120810.21282-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712120810.21282-1-ben.dooks@codethink.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jul 12, 2023 at 01:08:10PM +0100, Ben Dooks wrote:
> Add a quick helper to just do struct device to the struct nfit_mem
> field it should be referencing. This reduces the number of code
> lines in some of the following code as it removes the intermediate
> struct nvdimm.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
> v2:
>   - fix typo of follwoing
>   - add blank line in to_nfit_mem()
> ---
>  drivers/acpi/nfit/core.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 0fcc247fdfac..b04c8a41380a 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1361,18 +1361,23 @@ static const struct attribute_group *acpi_nfit_attribute_groups[] = {
>  	NULL,
>  };
>  
> -static struct acpi_nfit_memory_map *to_nfit_memdev(struct device *dev)
> +static struct nfit_mem *to_nfit_mem(struct device *dev)
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +
> +	return nvdimm_provider_data(nvdimm);
> +}
> +
> +static struct acpi_nfit_memory_map *to_nfit_memdev(struct device *dev)
> +{
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  
>  	return __to_nfit_memdev(nfit_mem);
>  }
>  
>  static struct acpi_nfit_control_region *to_nfit_dcr(struct device *dev)
>  {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  
>  	return nfit_mem->dcr;
>  }
> @@ -1531,8 +1536,7 @@ static DEVICE_ATTR_RO(serial);
>  static ssize_t family_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  
>  	if (nfit_mem->family < 0)
>  		return -ENXIO;
> @@ -1543,8 +1547,7 @@ static DEVICE_ATTR_RO(family);
>  static ssize_t dsm_mask_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  
>  	if (nfit_mem->family < 0)
>  		return -ENXIO;
> @@ -1555,8 +1558,7 @@ static DEVICE_ATTR_RO(dsm_mask);
>  static ssize_t flags_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  	u16 flags = __to_nfit_memdev(nfit_mem)->flags;
>  
>  	if (test_bit(NFIT_MEM_DIRTY, &nfit_mem->flags))
> @@ -1576,8 +1578,7 @@ static DEVICE_ATTR_RO(flags);
>  static ssize_t id_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  
>  	return sprintf(buf, "%s\n", nfit_mem->id);
>  }
> @@ -1586,8 +1587,7 @@ static DEVICE_ATTR_RO(id);
>  static ssize_t dirty_shutdown_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> -	struct nvdimm *nvdimm = to_nvdimm(dev);
> -	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
> +	struct nfit_mem *nfit_mem = to_nfit_mem(dev);
>  
>  	return sprintf(buf, "%d\n", nfit_mem->dirty_shutdown);
>  }
> -- 
> 2.40.1
> 
> 
