Return-Path: <linux-acpi+bounces-3945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F088677E6
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 15:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B97290A38
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Feb 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1A1292D0;
	Mon, 26 Feb 2024 14:10:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22D1292D2;
	Mon, 26 Feb 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956633; cv=none; b=Fu9aa9QqGiYncH20nTozE966t76ouBdbBVLLdNqT0wA6XKSSBGxRTXdakvUOtuRExu1qW9VWJGlKmipiUzQZnTZ+4Ujic9Ou3QVIVS5IxtCju1u+oQPhhNrfy7FuuDRnf858rwzqysw9BeBe9qZg32R5t8K/ZTcde0+3BcnOlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956633; c=relaxed/simple;
	bh=Z19xIouIl+bCnizOctHJ7cIatm4j/vf898NH19suaAo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxCoTwnv/utRDSYKvUP1+BvL4v/foS1Ov8MmnBN/YlIKZFHrGYnKp2BB1F8iivGbOlByu+UnvT49tffSrBUg1q+gMYFa9sWIgde4KFfeCUZuIVUbEIDoNse/XM+wgnq7GVl2cbWRXamybHhnx433y8MhaSeHqCIQgvSP58TatWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk2VC6XJkz6K9N9;
	Mon, 26 Feb 2024 22:06:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 34279140DDB;
	Mon, 26 Feb 2024 22:10:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 14:10:26 +0000
Date: Mon, 26 Feb 2024 14:10:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix load failures due to single window
 creation failure
Message-ID: <20240226141025.00001acf@Huawei.com>
In-Reply-To: <65da43d38df20_2bca029483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com>
	<20240219124041.00002bda@Huawei.com>
	<65d6335ea74ac_6c745294a8@dwillia2-xfh.jf.intel.com.notmuch>
	<20240223132829.00007741@Huawei.com>
	<65d8eeaaeb302_2509b294f3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<65d987b04e98b_2509b294e4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<65da43d38df20_2bca029483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 24 Feb 2024 11:30:27 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Dan Williams wrote:
> > Dan Williams wrote:
> > [..]  
> > > > This is definitely not nice to read.  We are randomly setting an
> > > > apparently unrelated pointer to NULL.  At very least the __free
> > > > should operating on cxld then we can use  
> > 
> > So, how about this... I don't hate it:  
> 
> ...and the version that actually compiles, fixed up cxl_root_decoder
> declaration and dropped the BUILD_BUG_ON() since it will naturally fail
> to compile if more than the supported number of variables is passed to
> cond_no_free_ptr():
> 
> -- 8< --
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 1a3e6aafbdcc..5c1dc4adf80d 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -316,6 +316,8 @@ static const struct cxl_root_ops acpi_root_ops = {
>  	.qos_class = cxl_acpi_qos_class,
>  };
>  
> +DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  			     struct cxl_cfmws_context *ctx)
>  {
> @@ -323,21 +325,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,


>  	/* add to the local resource tracking to establish a sort order */
>  	rc = insert_resource(cxl_res, res);
> -	if (rc)
> -		goto err_insert;
> +	cond_no_free_ptr(rc == 0, return rc, res, name);

I'm not convinced this is that much clearer than
	rc = insert_resource(cxl_res, res);
	if (rc)
		return rc;
	no_check_no_free_ptrs(res);
	no_check_no_free_ptrs(name);

with better naming and with that being defined in similar way to your
__cond_no_free_ptrs()

Just keeping them in the same code block is probably enough to indicate
that these are there because of success of insert_resource()
+ no need to handle bigger and bigger sets of params in the future.


Rest looks good to me

Jonathan

 
	

...

> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..e156fed88f51 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -77,6 +77,28 @@ const volatile void * __must_check_fn(const volatile void *val)
>  
>  #define return_ptr(p)	return no_free_ptr(p)
>  
> +#define __cond_no_free_ptrs(p) ({__auto_type __always_unused __ptr = no_free_ptr(p);})

Nasty ;)

> +#define __cond_no_free_ptrs1(p, ...) __cond_no_free_ptrs(p)
> +#define __cond_no_free_ptrs2(p, ...) \
> +	__cond_no_free_ptrs(p), __cond_no_free_ptrs1(__VA_ARGS__)
> +#define __cond_no_free_ptrs3(p, ...) \
> +	__cond_no_free_ptrs(p), __cond_no_free_ptrs2(__VA_ARGS__)
> +
> +/*
> + * When an object is built up by an amalgamation of multiple allocations
> + * each of those need to be cleaned up on error, but there are occasions
> + * where once the object is registered all of those cleanups can be
> + * cancelled.  cond_no_free_ptr() arranges to call no_free_ptr() on all
> + * its arguments (up to 3) if @condition is true and runs @_fail
> + * otherwise (typically to return and trigger auto-cleanup).
> + */
> +#define cond_no_free_ptr(condition, _fail, ...)                           \
> +	if (condition) {                                                  \
> +		CONCATENATE(__cond_no_free_ptrs, COUNT_ARGS(__VA_ARGS__)) \
> +		(__VA_ARGS__);                                            \
> +	} else {                                                          \
> +		_fail;                                                    \
> +	}
>  
>  /*
>   * DEFINE_CLASS(name, type, exit, init, init_args...):


