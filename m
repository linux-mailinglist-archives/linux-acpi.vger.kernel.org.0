Return-Path: <linux-acpi+bounces-14237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB330AD1B69
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BCD164304
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B54C224FA;
	Mon,  9 Jun 2025 10:20:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231818A6A5;
	Mon,  9 Jun 2025 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749464404; cv=none; b=Rw/Heb7XEQgtZURuRj8Fv1hKHjQDEBh+mCB5Y57mOASu2pHjqdTOYWahh0igRdfREKQfQRONpnBDEswkGH7q3z65Wc0wPW5Yq8e5oeOoelZPMFoecSclxSX1HBX9dyZhRhW+3mc/8NGJ7clvX3oHJAaaqJR/sQxB+UmribZUFic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749464404; c=relaxed/simple;
	bh=1AjF9LFBXWqKPuuY0B87ZfGFsx9X4vC+AcRCRR/1ECQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tam9haSarHv1jc4zxajn63s85qRbRhInFQB6F96uD1oyTZ80R5t/WNI/Agb7mmRWTgR7NzD1sMPl1fq4qpiKsnk0qWmOCQ+SoDRFXDPUoX64BNBg55fBvOYxxCREoKNEnL+rMI3oCdogbXALkH9leBCX2QFbvOoLWwQw32z2wMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bG79H7570z6L5Gy;
	Mon,  9 Jun 2025 18:15:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F2AA14038F;
	Mon,  9 Jun 2025 18:19:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 12:19:59 +0200
Date: Mon, 9 Jun 2025 11:19:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 1/3] driver core: faux: Suppress bind attributes
Message-ID: <20250609111957.00003c07@huawei.com>
In-Reply-To: <20250607033228.1475625-2-dan.j.williams@intel.com>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
	<20250607033228.1475625-2-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 6 Jun 2025 20:32:26 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> faux_device_create() is almost a suitable candidate to replace
> platform_driver_probe() if not for the fact that faux_device_create()
> supports dynamic attach/detach of the driver.
> 
> Drop the bind attributes with the expectation that simple faux devices can
> always assume that the device is permanently bound at create, and only
> unbound at 'destroy'.
> 
> The acpi-einj driver depends on static bind.
> 
> Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems like a fair assumption that these should never be used so
we might as well hide the.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/base/faux.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index 9054d346bd7f..934da77ca48b 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -86,6 +86,7 @@ static struct device_driver faux_driver = {
>  	.name		= "faux_driver",
>  	.bus		= &faux_bus_type,
>  	.probe_type	= PROBE_FORCE_SYNCHRONOUS,
> +	.suppress_bind_attrs = true,
>  };
>  
>  static void faux_device_release(struct device *dev)


