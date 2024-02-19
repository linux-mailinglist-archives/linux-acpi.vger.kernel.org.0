Return-Path: <linux-acpi+bounces-3691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AE185A3A5
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Feb 2024 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45D8B23409
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Feb 2024 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8882E65B;
	Mon, 19 Feb 2024 12:40:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BC2E620;
	Mon, 19 Feb 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346449; cv=none; b=bAgso+ISCGmvphOfm9aboz2Z6NXIs2dZkd0znSDqjWMYllV4llexruvQ+QAAMB0NVo8ubsmlvW9XZIyAp/OGheBBilWULUwG6+jOPk1TeLKC7BrlG1S22ecOxe6vW739BrpjWxmvttvrxnbWY5fOI2dHhR5BGcoR+lG/xl1KLgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346449; c=relaxed/simple;
	bh=jvIBOHvW4iia/dVjgd0VDba5pMWJ3SplI/eTcMxuo/U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRn0Jh3vqTJlmNuuhiLtNiKHvrqUo4Gu+62pHtATmuko5TkJtXUc51P7JjFEIlYO7OzRGge9/FFEHPybPbnZ33D8j/q4La2OB/Sun4ywhpo2NN9tOMDNrz+1d2FmXcBXvZMc/IT/TEzd9VIOF+sZy1C7bYelTSCkPQL7IB0F3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdhqd74cbz6K69r;
	Mon, 19 Feb 2024 20:36:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 661B5141071;
	Mon, 19 Feb 2024 20:40:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 12:40:42 +0000
Date: Mon, 19 Feb 2024 12:40:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <20240219124041.00002bda@Huawei.com>
In-Reply-To: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 17 Feb 2024 12:29:32 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The expectation is that cxl_parse_cfwms() continues in the face the of
> failure as evidenced by code like:
> 
>     cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
>     if (IS_ERR(cxlrd))
>     	return 0;
> 
> There are other error paths in that function which mistakenly follow
> idiomatic expectations and return an error when they should not. Most of
> those mistakes are innocuous checks that hardly ever fail in practice.
> However, a recent change succeed in making the implementation more
> fragile by applying an idiomatic, but still wrong "fix" [1]. In this
> failure case the kernel reports:
> 
>     cxl root0: Failed to populate active decoder targets
>     cxl_acpi ACPI0017:00: Failed to add decode range: [mem 0x00000000-0x7fffffff flags 0x200]
> 
> ...which is a real issue with that one window (to be fixed separately),
> but ends up failing the entirety of cxl_acpi_probe().
> 
> Undo that recent breakage while also removing the confusion about
> ignoring errors. Update all exits paths to return an error per typical
> expectations and let an outer wrapper function handle dropping the
> error.
> 
> Fixes: 91019b5bc7c2 ("cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()") [1]
> Cc: <stable@vger.kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

General idea makes a lot of sense to me.

A few comments on specific implementation inline

> ---
>  drivers/cxl/acpi.c |   45 +++++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index dcf2b39e1048..53d2dff0c7a3 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -316,31 +316,27 @@ static const struct cxl_root_ops acpi_root_ops = {
>  	.qos_class = cxl_acpi_qos_class,
>  };
>  
> -static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> -			   const unsigned long end)
> +static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> +			     struct cxl_cfmws_context *ctx)
>  {
>  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> -	struct cxl_cfmws_context *ctx = arg;
>  	struct cxl_port *root_port = ctx->root_port;
>  	struct resource *cxl_res = ctx->cxl_res;
>  	struct cxl_cxims_context cxims_ctx;
>  	struct cxl_root_decoder *cxlrd;
>  	struct device *dev = ctx->dev;
> -	struct acpi_cedt_cfmws *cfmws;
>  	cxl_calc_hb_fn cxl_calc_hb;
>  	struct cxl_decoder *cxld;
>  	unsigned int ways, i, ig;
>  	struct resource *res;
>  	int rc;
>  
> -	cfmws = (struct acpi_cedt_cfmws *) header;
> -
>  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
>  	if (rc) {
>  		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
>  			cfmws->base_hpa,
>  			cfmws->base_hpa + cfmws->window_size - 1);

Why keep this error print?

> -		return 0;
> +		return rc;
>  	}
>  
>  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
> @@ -376,7 +372,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  
>  	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
>  	if (IS_ERR(cxlrd))
> -		return 0;
> +		return PTR_ERR(cxlrd);
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> @@ -420,16 +416,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		put_device(&cxld->dev);
>  	else
>  		rc = cxl_decoder_autoremove(dev, cxld);
> -	if (rc) {
> -		dev_err(dev, "Failed to add decode range: %pr", res);
> -		return rc;

As no longer sharing this message. Might be neater to have this lot as
	rc = cxl_decoder_add(cxld, target_map);
err_xormap:
	if (rc) {
		put_device(&cxld->dev);
		return rc;
	}

	return cxl_decoder_autoremove(dev, cxld);

or a second error exit path.

	rc = cxl_decoder_add(cxld, target_map);
	if (rc)
		goto err_put_devie;

	return cxl_decoder_autoremove(dev, cxld;

err_put_device;
	put_device(&cxld->dev);
	return rc;

err_insert:
	kfree(res->name); ...


> -	}
> -	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> -		dev_name(&cxld->dev),
> -		phys_to_target_node(cxld->hpa_range.start),
> -		cxld->hpa_range.start, cxld->hpa_range.end);
> -
> -	return 0;
> +	return rc;
>  
>  err_insert:
>  	kfree(res->name);
> @@ -438,6 +425,28 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	return -ENOMEM;
>  }
>  
> +static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> +			   const unsigned long end)
> +{
> +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> +	struct cxl_cfmws_context *ctx = arg;
> +	struct device *dev = ctx->dev;
> +	int rc;
> +
> +	dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
> +		phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
> +		cfmws->base_hpa + cfmws->window_size - 1);

Could maybe put this in an else below?

> +	rc = __cxl_parse_cfmws(cfmws, ctx);
> +	if (rc)
> +		dev_err(dev,
> +			"Failed to add decode range: [%#llx - %#llx] (%d)\n",
> +			cfmws->base_hpa,
> +			cfmws->base_hpa + cfmws->window_size - 1, rc);
> +
else 
	dev_dbg();

so we only give the dbg version on success?

> +	/* never fail cxl_acpi load for a single window failure */
> +	return 0;
> +}
> +
>  __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
>  					      struct device *dev)
>  {
> 
> 


