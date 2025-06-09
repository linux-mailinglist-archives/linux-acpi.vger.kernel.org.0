Return-Path: <linux-acpi+bounces-14236-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 153F5AD1B66
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14E9188DD54
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4525393A;
	Mon,  9 Jun 2025 10:19:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D371C5496;
	Mon,  9 Jun 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749464361; cv=none; b=aVCP1ENASJyBcumMScyFWJ3q92LghIq2alTugKUiLBZiwp6AZOLJpJnQZyZaTFVGew0wLvCVgjhOQhQdwyVLRcWouIFsHHAaFpSmiUGIHOgaVGWW4iy8Y0MdUZFqijdpWkOPQ33jJ3nYExEQn6DMzkrEDE1ugi/iF95aw/k+Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749464361; c=relaxed/simple;
	bh=fq8K6smQ/CVkRgzVd9QcuGINgKmkXn3+4nwfLv4+DNs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqNeYI7kkgPX09pxHyeO9/a4VRf7vFZAOdxTaP1RsJ4qLBAUqHs3Bstd5UR7yucGbokBOWONEHuisVhyTBd4v5+Yhv3ZqN7Tcc1GEjkaEvryRKk+FNPq/yUyCLSILE53JJ6T6JdgynN7wXjI1MtsegfY7x7LyV+n4wvAm5otQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bG7CG6BJjz6L4sT;
	Mon,  9 Jun 2025 18:17:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 779F714038F;
	Mon,  9 Jun 2025 18:19:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 12:19:17 +0200
Date: Mon, 9 Jun 2025 11:19:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 2/3] driver core: faux: Quiet probe failures
Message-ID: <20250609111915.000011a1@huawei.com>
In-Reply-To: <20250607033228.1475625-3-dan.j.williams@intel.com>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
	<20250607033228.1475625-3-dan.j.williams@intel.com>
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

On Fri, 6 Jun 2025 20:32:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The acpi-einj conversion to faux_device_create() leads to a noisy error
> message when the error injection facility is disabled. Quiet the error as
> CXL error injection via ACPI expects the module to stay loaded even if the
> error injection facility is disabled.
> 
> This situation arose because CXL knows proper kernel named objects to
> trigger errors against, but acpi-einj knows how to perform the error
> injection. The injection mechanism is shared with non-CXL use cases. The
> result is CXL now has a module dependency on einj-core.ko, and init/probe
> failures are handled at runtime.
> 
> Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I guess this is fair enough. 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/base/faux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index 934da77ca48b..f5fbda0a9a44 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -170,7 +170,7 @@ struct faux_device *faux_device_create_with_groups(const char *name,
>  	 * successful is almost impossible to determine by the caller.
>  	 */
>  	if (!dev->driver) {
> -		dev_err(dev, "probe did not succeed, tearing down the device\n");
> +		dev_dbg(dev, "probe did not succeed, tearing down the device\n");
>  		faux_device_destroy(faux_dev);
>  		faux_dev = NULL;
>  	}


