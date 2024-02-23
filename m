Return-Path: <linux-acpi+bounces-3896-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC688612BE
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 14:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC061C21370
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Feb 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D427EEEF;
	Fri, 23 Feb 2024 13:28:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633384A22;
	Fri, 23 Feb 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694918; cv=none; b=T8ZW9gB6H17aF4ffuilYp/T0w45Qm50/uD1xx1GlvPLRs+95x3oZZVd5mibIvt/cVEK5L0oAPhaiC0aDJdXmIdk/WgZQVbwv+1TXsxZk4Dx46VB0QlV4YCsMJglAEB9pZvZVxCrJ2zkJflgTOWSC9hb8BTdkXPLz4Iuw0c9kQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694918; c=relaxed/simple;
	bh=k5IcJFYe2Oj28CekmCm67SBOC9vQRXLSFbrluz6aVMc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICuvr91Sj7z+gBxurXOQvP0UgZGUIfWXDusKNfE2wfqtNoKUruRG5c/cMWfnMg36vTenXw00Z79nVFrR9V3k6jk0xhKvxhZZTgDsO01z6NO5K7KqJCTPYFjgVNyVkLX0/2INYRzVanSsIPC/0d9dtFFPG+2HlfHBXczO+YqjfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th9hk391Cz67ZPP;
	Fri, 23 Feb 2024 21:24:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 97A93140119;
	Fri, 23 Feb 2024 21:28:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 13:28:31 +0000
Date: Fri, 23 Feb 2024 13:28:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <20240223132829.00007741@Huawei.com>
In-Reply-To: <65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
	<20240219124041.00002bda@Huawei.com>
	<65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
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

On Wed, 21 Feb 2024 09:31:10 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Sat, 17 Feb 2024 12:29:32 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > The expectation is that cxl_parse_cfwms() continues in the face the of
> > > failure as evidenced by code like:
> > > 
> > >     cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
> > >     if (IS_ERR(cxlrd))
> > >     	return 0;
> > > 
> > > There are other error paths in that function which mistakenly follow
> > > idiomatic expectations and return an error when they should not. Most of
> > > those mistakes are innocuous checks that hardly ever fail in practice.
> > > However, a recent change succeed in making the implementation more
> > > fragile by applying an idiomatic, but still wrong "fix" [1]. In this
> > > failure case the kernel reports:
> > > 
> > >     cxl root0: Failed to populate active decoder targets
> > >     cxl_acpi ACPI0017:00: Failed to add decode range: [mem 0x00000000-0x7fffffff flags 0x200]
> > > 
> > > ...which is a real issue with that one window (to be fixed separately),
> > > but ends up failing the entirety of cxl_acpi_probe().
> > > 
> > > Undo that recent breakage while also removing the confusion about
> > > ignoring errors. Update all exits paths to return an error per typical
> > > expectations and let an outer wrapper function handle dropping the
> > > error.
> > > 
> > > Fixes: 91019b5bc7c2 ("cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()") [1]
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Breno Leitao <leitao@debian.org>
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > General idea makes a lot of sense to me.
> > 
> > A few comments on specific implementation inline
> >   
> > > ---
> > >  drivers/cxl/acpi.c |   45 +++++++++++++++++++++++++++------------------
> > >  1 file changed, 27 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index dcf2b39e1048..53d2dff0c7a3 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -316,31 +316,27 @@ static const struct cxl_root_ops acpi_root_ops = {
> > >  	.qos_class = cxl_acpi_qos_class,
> > >  };
> > >  
> > > -static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > > -			   const unsigned long end)
> > > +static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> > > +			     struct cxl_cfmws_context *ctx)
> > >  {
> > >  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> > > -	struct cxl_cfmws_context *ctx = arg;
> > >  	struct cxl_port *root_port = ctx->root_port;
> > >  	struct resource *cxl_res = ctx->cxl_res;
> > >  	struct cxl_cxims_context cxims_ctx;
> > >  	struct cxl_root_decoder *cxlrd;
> > >  	struct device *dev = ctx->dev;
> > > -	struct acpi_cedt_cfmws *cfmws;
> > >  	cxl_calc_hb_fn cxl_calc_hb;
> > >  	struct cxl_decoder *cxld;
> > >  	unsigned int ways, i, ig;
> > >  	struct resource *res;
> > >  	int rc;
> > >  
> > > -	cfmws = (struct acpi_cedt_cfmws *) header;
> > > -
> > >  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> > >  	if (rc) {
> > >  		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> > >  			cfmws->base_hpa,
> > >  			cfmws->base_hpa + cfmws->window_size - 1);  
> > 
> > Why keep this error print?  
> 
> True, that can go.
> 
> > > -		return 0;
> > > +		return rc;
> > >  	}
> > >  
> > >  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
> > > @@ -376,7 +372,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > >  
> > >  	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
> > >  	if (IS_ERR(cxlrd))
> > > -		return 0;
> > > +		return PTR_ERR(cxlrd);
> > >  
> > >  	cxld = &cxlrd->cxlsd.cxld;
> > >  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> > > @@ -420,16 +416,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > >  		put_device(&cxld->dev);
> > >  	else
> > >  		rc = cxl_decoder_autoremove(dev, cxld);
> > > -	if (rc) {
> > > -		dev_err(dev, "Failed to add decode range: %pr", res);
> > > -		return rc;  
> > 
> > As no longer sharing this message. Might be neater to have this lot as
> > 	rc = cxl_decoder_add(cxld, target_map);
> > err_xormap:
> > 	if (rc) {
> > 		put_device(&cxld->dev);
> > 		return rc;
> > 	}
> > 
> > 	return cxl_decoder_autoremove(dev, cxld);
> > 
> > or a second error exit path.
> > 
> > 	rc = cxl_decoder_add(cxld, target_map);
> > 	if (rc)
> > 		goto err_put_devie;
> > 
> > 	return cxl_decoder_autoremove(dev, cxld;
> > 
> > err_put_device;
> > 	put_device(&cxld->dev);
> > 	return rc;
> > 
> > err_insert:
> > 	kfree(res->name); ...  
> 
> True, there's enough here to do an even deeper cleanup... below.
> 
> > 
> >   
> > > -	}
> > > -	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> > > -		dev_name(&cxld->dev),
> > > -		phys_to_target_node(cxld->hpa_range.start),
> > > -		cxld->hpa_range.start, cxld->hpa_range.end);
> > > -
> > > -	return 0;
> > > +	return rc;
> > >  
> > >  err_insert:
> > >  	kfree(res->name);
> > > @@ -438,6 +425,28 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > >  	return -ENOMEM;
> > >  }
> > >  
> > > +static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> > > +			   const unsigned long end)
> > > +{
> > > +	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
> > > +	struct cxl_cfmws_context *ctx = arg;
> > > +	struct device *dev = ctx->dev;
> > > +	int rc;
> > > +
> > > +	dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
> > > +		phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
> > > +		cfmws->base_hpa + cfmws->window_size - 1);  
> > 
> > Could maybe put this in an else below?
> >   
> > > +	rc = __cxl_parse_cfmws(cfmws, ctx);
> > > +	if (rc)
> > > +		dev_err(dev,
> > > +			"Failed to add decode range: [%#llx - %#llx] (%d)\n",
> > > +			cfmws->base_hpa,
> > > +			cfmws->base_hpa + cfmws->window_size - 1, rc);
> > > +  
> > else 
> > 	dev_dbg();
> > 
> > so we only give the dbg version on success?  
> 
> Yeah, I will switch to this since the previous state was also skipping
> the debug messages on success.
> 
> Follow-on cleanup:
> 
> -- 8< --
> From e30c267c0b69d5e4531d8f65ec86e4fa32d72340 Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Tue, 20 Feb 2024 22:44:34 -0800
> Subject: [PATCH] cxl/acpi: Cleanup __cxl_parse_cfmws() error exits
> 
> As a follow on to the recent rework of __cxl_parse_cfmws() to always
> return errors, use cleanup.h helpers to remove goto and other cleanups
> now that logging is moved to the cxl_parse_cfmws() wrapper.

This runs into the question of where the declarations should be for
cleanup.h changes.  I can dig out the Linus comment on this but
I'm feeling lazy ;)

In general I like this stuff, but in this case I think it's ended
up harder to read than the original code.

> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20240219124041.00002bda@Huawei.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c | 45 +++++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 1a3e6aafbdcc..b1ea2d152c65 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -319,25 +319,23 @@ static const struct cxl_root_ops acpi_root_ops = {
>  static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  			     struct cxl_cfmws_context *ctx)
>  {
> +	struct device *cxld_dev __free(put_device) = NULL;
>  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
>  	struct cxl_port *root_port = ctx->root_port;
> +	struct resource *res __free(kfree) = NULL;
>  	struct resource *cxl_res = ctx->cxl_res;
> +	const char *name __free(kfree) = NULL;

Linus has expressed that he prefers these done inline
so the allocation and clearing are obviously associated - there
is an ordering related factor as well as they will unwind
in the reverse of declaration order, not allocation order.


>  	struct cxl_cxims_context cxims_ctx;
>  	struct cxl_root_decoder *cxlrd;
>  	struct device *dev = ctx->dev;
>  	cxl_calc_hb_fn cxl_calc_hb;
>  	struct cxl_decoder *cxld;
>  	unsigned int ways, i, ig;
> -	struct resource *res;
>  	int rc;
>  
>  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> -	if (rc) {
> -		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> -			cfmws->base_hpa,
> -			cfmws->base_hpa + cfmws->window_size - 1);
> +	if (rc)
>  		return rc;
> -	}
>  
>  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
>  	if (rc)
> @@ -352,10 +350,11 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	if (!res)
>  		return -ENOMEM;
>  
> -	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
> -	if (!res->name)
> -		goto err_name;

const char *name __free(kfree) = kasprintf(...);

same for the others.
> +	name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
> +	if (!name)
> +		return -ENOMEM;
>  
> +	res->name = name;
>  	res->start = cfmws->base_hpa;
>  	res->end = cfmws->base_hpa + cfmws->window_size - 1;
>  	res->flags = IORESOURCE_MEM;
> @@ -363,7 +362,9 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	/* add to the local resource tracking to establish a sort order */
>  	rc = insert_resource(cxl_res, res);
>  	if (rc)
> -		goto err_insert;
> +		return rc;
> +	name = NULL;

I guess we'll get used to this.  Kind of annoying that no_free_ptr() is
defined as __must_check. Otherwise would be good to use that to document
the 'why' of these are being set to NULL.

> +	res = NULL;
>  
>  	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_MODULO)
>  		cxl_calc_hb = cxl_hb_modulo;
> @@ -375,11 +376,12 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  		return PTR_ERR(cxlrd);
>  
>  	cxld = &cxlrd->cxlsd.cxld;
> +	cxld_dev = &cxld->dev;

This I find odd, there is no allocation as such in here so the matching of
the unwind and the allocation isn't clear. 

>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
> -		.start = res->start,
> -		.end = res->end,
> +		.start = cfmws->base_hpa,
> +		.end = cfmws->base_hpa + cfmws->window_size - 1,
>  	};
>  	cxld->interleave_ways = ways;
>  	/*
> @@ -399,11 +401,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CXIMS,
>  						   cxl_parse_cxims, &cxims_ctx);
>  			if (rc < 0)
> -				goto err_xormap;
> +				return rc;
>  			if (!cxlrd->platform_data) {
>  				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
> -				rc = -EINVAL;
> -				goto err_xormap;
> +				return -EINVAL;
>  			}
>  		}
>  	}
> @@ -411,18 +412,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	cxlrd->qos_class = cfmws->qtg_id;
>  
>  	rc = cxl_decoder_add(cxld, target_map);
> -err_xormap:
>  	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(dev, cxld);
> -	return rc;
> -
> -err_insert:
> -	kfree(res->name);
> -err_name:
> -	kfree(res);
> -	return -ENOMEM;
> +		return rc;
> +	cxld_dev = NULL;

This is definitely not nice to read.  We are randomly setting an
apparently unrelated pointer to NULL.  At very least the __free
should operating on cxld then we can use

return cxl_decoder_autoremove(dev, no_free_ptr(cxld));

But the get was burred in cxl_root_decoder_alloc() so even that
is non obvious.  You could do the magic to make

struct cxl_root_decoder *cxld __free(cxlroot_put) = 
	cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);

return cxl_decoder_autoremove(dev, &no_free_ptr(cxlrd)->cxlsd.cxld);

Is it worth it? Just about, maybe...


> +	return cxl_decoder_autoremove(dev, cxld);
>  }
>  
>  static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,


