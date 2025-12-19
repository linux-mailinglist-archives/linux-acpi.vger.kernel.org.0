Return-Path: <linux-acpi+bounces-19729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A057CCD1E19
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 21:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D29C3070C01
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 20:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C9B33B6D2;
	Fri, 19 Dec 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="fHLo7h2x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDA2E0402;
	Fri, 19 Dec 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177739; cv=none; b=p1zyvRP34xQLSnOkp6imLY5Ta09L7wjrffoisc0JX5eSBhdMQEeKYBiuUbIUES9odmbMsHwCnXCcXi4w80k/3tYUb4w+PW9UPezNxKXwoK178rGvBLov4SYABScQZCqOgMuheYMr7xdj8cSxIWneqOEmx1GjqNdrpMP+7fwW/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177739; c=relaxed/simple;
	bh=902N7+vSq4ZtgNz/0oajexrC3xsamP0KPKTs2JdrpEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyTwj9r/X1cM2L6G6zgGA6nJTogM8hMFyHBZqo3nnKy1RS63rzo7CvQ6yaFE40ju/e2JprpXqQwg2TFUoEejPtKXdbMESB1mOLI8eDjHCkHe7sJI4SOTrH09VP2d3RJgOQXH/KNoD4+wikVOdzbWrosEmnss2iio5EVZRvUC0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=fHLo7h2x; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.123.3] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4dY0DN36Ldz4SSl;
	Fri, 19 Dec 2025 15:55:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1766177735; bh=902N7+vSq4ZtgNz/0oajexrC3xsamP0KPKTs2JdrpEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fHLo7h2xpB/TslaDr47UJ2ca80htNrHviXZyT/1DLKooZSuUCvGY1HXciWIqZR2C1
	 loy01eHGMtYjPwOTp7qJn28lI3Z2ai9XgIQ1PVHSCIRJy/oR9XETe6zbJ44ZJoXDvz
	 dujiFZ8pZPqFY2eNsRSgvwGzGza5nRXFEuhRkTjc=
Message-ID: <48b94c22-c1ca-4220-b184-f38e22544b9d@panix.com>
Date: Fri, 19 Dec 2025 12:55:30 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] software node: Also support referencing non-constant
 software nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, linux-acpi@vger.kernel.org,
 linux-media@vger.kernel.org, johannes.goede@oss.qualcomm.com,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
 <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Apparently last to the party :) but:

Tested-By: Kenneth R. Crudup <kenny@panix.com>

-K

On 12/19/25 00:36, Sakari Ailus wrote:
> Fwnode references are be implemented differently if referenced node is a
> software node. _Generic() is used to differentiate between the two cases
> but only const software nodes were present in the selection. Also add
> non-const software nodes.
> 
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/all/af773b82-bef2-4209-baaf-526d4661b7fc@panix.com/
> Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Kenneth,
> 
> Many thanks for reporting the issue and bisecting the offending patch!
> Could you confirm whether this fixes the issue (it does for me)?
> 
> - Sakari
> 
>   include/linux/property.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 272bfbdea7bf..e30ef23a9af3 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -371,6 +371,7 @@ struct software_node_ref_args {
>   (const struct software_node_ref_args) {				\
>   	.swnode = _Generic(_ref_,				\
>   			   const struct software_node *: _ref_,	\
> +			   struct software_node *: _ref_,	\
>   			   default: NULL),			\
>   	.fwnode = _Generic(_ref_,				\
>   			   struct fwnode_handle *: _ref_,	\

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


