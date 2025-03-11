Return-Path: <linux-acpi+bounces-12069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C1A5BCE0
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E6F18846EA
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98022DFA3;
	Tue, 11 Mar 2025 09:54:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83A1E7C2B;
	Tue, 11 Mar 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686848; cv=none; b=ntT4JcnlYu6txBRVz+tk6WGoqMTM1/tF7TeYPRqOKAV1jCEqfsXJbguXYNpHLgE8qsDxF3aqDN2HOqOukd6weZPN6dSfJon3JAzm6QEupYR8Kf3JGPCjuxtEafYCQ7BytEWKclqR2eY6b+D7Ux9Bn/0AaoVsmmsxh8aNCF2jHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686848; c=relaxed/simple;
	bh=BKwuIabL6hA3rJeXW3i7+lr90P9mVDKBMdTsalYV8pU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXCHv0v3LQqF2Y9wcPSVa/0xD43VZP2zvv3zRgtu1eCYpytgKM4QlY5U2lMr/yzG+Vj8yCacq8y+MYYEjh3WIZU7hlmPVHYr9R1aKZZC31wBvAsgo+lAa6Bhd03JQMwYA7dCGFINsAwq6yevWvXhtVVvahZr9GCNQjrmb6KTvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBpts0Kzgz6K9PR;
	Tue, 11 Mar 2025 17:51:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2273614034E;
	Tue, 11 Mar 2025 17:54:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 10:54:04 +0100
Date: Tue, 11 Mar 2025 09:54:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rob Herring (Arm)"
	<robh@kernel.org>, Markus Elfring <elfring@users.sourceforge.net>, "Jakob
 Riepler" <jakob+lkml@paranoidlabs.org>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>, "Sakari
 Ailus" <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Lee Jones
	<lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Matti Vaittinen
	<mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 3/4] leds: ncp5623: Use fwnode_get_child_node_count()
Message-ID: <20250311095402.00002845@huawei.com>
In-Reply-To: <20250310150835.3139322-4-andriy.shevchenko@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
	<20250310150835.3139322-4-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 10 Mar 2025 16:54:53 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since fwnode_get_child_node_count() was split from its device property
> counterpart, we may utilise it in the driver and drop custom implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/leds/rgb/leds-ncp5623.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
> index f18156683375..7c7d44623a9e 100644
> --- a/drivers/leds/rgb/leds-ncp5623.c
> +++ b/drivers/leds/rgb/leds-ncp5623.c
> @@ -155,9 +155,9 @@ static int ncp5623_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct fwnode_handle *mc_node, *led_node;
>  	struct led_init_data init_data = { };
> -	int num_subleds = 0;
>  	struct ncp5623 *ncp;
>  	struct mc_subled *subled_info;
> +	unsigned int num_subleds;
I have no idea what the scheme is for ordering here. My gut
feeling would have been to leave it in original location but it's
not something I feel strongly about.


Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  	u32 color_index;
>  	u32 reg;
>  	int ret;
> @@ -172,8 +172,7 @@ static int ncp5623_probe(struct i2c_client *client)
>  	if (!mc_node)
>  		return -EINVAL;
>  
> -	fwnode_for_each_child_node(mc_node, led_node)
> -		num_subleds++;
> +	num_subleds = fwnode_get_child_node_count(mc_node);
>  
>  	subled_info = devm_kcalloc(dev, num_subleds, sizeof(*subled_info), GFP_KERNEL);
>  	if (!subled_info) {


