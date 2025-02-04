Return-Path: <linux-acpi+bounces-10886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D9A26CD7
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 08:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B287A4839
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Feb 2025 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77122066D3;
	Tue,  4 Feb 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caigIazC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C062063F1;
	Tue,  4 Feb 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738655437; cv=none; b=XUpZuUZxhzprGV4qhGWUTM4j4SihqFNko74MSEw5jRVWAQfaZ3kHFVeCfYgAybk7ekgx4xG8k362shrCQbQl+/4RKCu8gEcgF5nYYQnYnIzTLk4JmhUWNvBs4RSS8bRFRbRE/7G8gDFE0WvjyP12wbM1Cs13bb3ydSRXNTvu3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738655437; c=relaxed/simple;
	bh=YW0UJaVAR2VwO4qOJ2bstH7GwHya+tpnrp20+zd8dSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKDSpZhZ9XtiIzLiA4Wj9VF3JXCNPPU6WJ9fWCuvmL4T5R6jgl4tyKLg3mfSddg4HaWMEZzf8FJMM4TbuX5nwUEiCBBLs/optqU8wMhUZLQUqXfZ7fJn1EUFhtnGzNlb9EP4jJSIMthDlhz5gENsu/W7LyXV9/2TKL+xm03XFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caigIazC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21680814d42so89579425ad.2;
        Mon, 03 Feb 2025 23:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738655435; x=1739260235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4QbTov9qjbzAGVZMQZfzMc51lM6YdjVO0Ci8uV4/vQ=;
        b=caigIazCTafIRfjk5gyPEffjVSk3z2Vk/fi9skvydZldTa+qCzKmXQdkmF6H3nXH5f
         +a0dmvNoOKoy7879ncxfTDGU/t6MDZ8ZLvcmr0vsC+ClUVNWn+6kzmL1+6lJYSS3NsiS
         jUlgVXcYZ7TASAIoa/c2XIT+LgYq+PKdeF+dXpK/h/4PIAKvmcQk7LNr4dq7IALYRDMa
         /svuBXnA0AqkGbxZcvheyFRuj6oGtojolOBKsmUZsKjt2hPgZPTE5Bxtl3wYs0eYUuw/
         1yasVoBRhAX03Og6IFx4ysgpkVx+QE8SVD1fCRtrvxsYQvIc9jHN51c2jEtcBqPMdgBp
         zkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738655435; x=1739260235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4QbTov9qjbzAGVZMQZfzMc51lM6YdjVO0Ci8uV4/vQ=;
        b=hA9IeHgBFgVv32Jokjinl1qHYo0pLf+rs1pxHXVgm/ME5FzviI3x6czY2ND9733vA+
         gOHmg9bnrV/SNNTJZKEYrCTas/ejLdSsh86Tz2qLz8sNQlToRLg9bOkIBE81WpVMcBaZ
         AU8f2xivQbOsqL7+di4hM+A23ose0NvFcldLE4MEKpKU3rsnAU6HIxwnoNhUAIQDdeuj
         KCqQrXSMLMBHms0wYK+IKucqXdYYbwyDE32BwQuakB7e6veF8+moa5X5pJKYYUh3ddJp
         +QmmFULkZQGoGqwftl30bYVdwJ5LoujMCyDFOo5O0zMEpnG2XurnBkMf8b2GMUmYdHjQ
         Nq/w==
X-Forwarded-Encrypted: i=1; AJvYcCWBYcUSHSWcLsn0kAGNkZUSGAgg0u46/WuzxuDVNxFq20QayrEdFaxnociaxeyoCysW5iDs14zqA39fgV8X@vger.kernel.org, AJvYcCXTuzQIGWbR3lzpDqAqkevQRCJ6w5QTxIwCsIg04C3OZ2xM1Yc/QNGM0pMpmkL+KSTDNKJu8aaEMFex@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNTqh53f7Q7v29LL9MiccqVAf6U31pDi3XWHW96I39QLgyu8T
	aOw1qLQebePU2tfuZ0xRuTlW5jgpNXSJTDpefNy3z6rbCkCpJeLr
X-Gm-Gg: ASbGncveQC6SWs21jqLeDuaxbTyRxmIpzTvP3LNu4A1XljokuON073r/NbbGd+7YMR3
	PU4TJK7mtTKdpo2rI89xJIvreIt2H0xU/JNkwo09Zjn7h8KYDzu0zwLB2gfklqmS28yuUImzF1z
	euB70hjxCZieelDTGeDUqppLaWEk0fnHBU8Gu2lcSPE1qqKYwKmOD5tzBmRJ5RdIGECll/gVCyl
	5LBCHPOFqsMwIU0SsmjRoyQzkIYLH2HenFaIJfS1iiLMVw5p+OEzds+ww/JTagFhpe3SyYYNbbZ
	v5T1HQMqzqj+2rG2uoeAvZdTrw==
X-Google-Smtp-Source: AGHT+IECrkqEYZxZRxAFlXAex36I+pmgFvIMWQpXSWrms6PPX16TKKsBaO2hBThkA0GN/qSWTc93Sw==
X-Received: by 2002:a05:6a00:91e0:b0:72f:f86f:f8d8 with SMTP id d2e1a72fcca58-72ff8700403mr19900543b3a.2.1738655434875;
        Mon, 03 Feb 2025 23:50:34 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6008bd8sm9682164b3a.0.2025.02.03.23.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 23:50:34 -0800 (PST)
Date: Tue, 4 Feb 2025 16:50:26 +0900
From: "Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net, hyeonggon.yoo@sk.com, ying.huang@linux.alibaba.com,
	rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Message-ID: <Z6HGwq731v+VX1CP@localhost.localdomain>
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>

On Tue, Jan 28, 2025 at 02:23:31PM -0800, Joshua Hahn wrote:
> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across nodes according to user-set ratios.
>
> Ideally, these weights should be proportional to their bandwidth, so
> that under bandwidth pressure, each node uses its maximal efficient
> bandwidth and prevents latency from increasing exponentially.
>
> At the same time, we want these weights to be as small as possible.
> Having ratios that involve large co-prime numbers like 7639:1345:7 leads
> to awkward and inefficient allocations, since the node with weight 7
> will remain mostly unused (and despite being proportional to bandwidth,
> will not aid in relieving the bandwidth pressure in the other two nodes).
>
> This patch introduces an auto-configuration mode for the interleave
> weights that aims to balance the two goals of setting node weights to be
> proportional to their bandwidths and keeping the weight values low.
> In order to perform the weight re-scaling, we use an internal
> "weightiness" value (fixed to 32) that defines interleave aggression.
>
> In this auto configuration mode, node weights are dynamically updated
> every time there is a hotplug event that introduces new bandwidth.
>
> Users can also enter manual mode by writing "N" or "0" to the new "auto"
> sysfs interface. When a user enters manual mode, the system stops
> dynamically updating any of the node weights, even during hotplug events
> that can shift the optimal weight distribution. The system also enters
> manual mode any time a user sets a node's weight directly by using the
> nodeN interface introduced in [1]. On the other hand, auto mode is
> only entered by explicitly writing "Y" or "1" to the auto interface.
>
> There is one functional change that this patch makes to the existing
> weighted_interleave ABI: previously, writing 0 directly to a nodeN
> interface was said to reset the weight to the system default. Before
> this patch, the default for all weights were 1, which meant that writing
> 0 and 1 were functionally equivalent.
>
> This patch introduces "real" defaults, but moves away from letting users
> use 0 as a "set to default" interface. Rather, users who want to use
> system defaults should use auto mode. This patch seems to be the
> appropriate place to make this change, since we would like to remove
> this usage before users begin to rely on the feature in userspace.
> Moreover, users will not be losing any functionality; they can still
> write 1 into a node if they want a weight of 1. Thus, we deprecate the
> "write zero to reset" feature in favor of returning an error, the same
> way we would return an error when the user writes any other invalid
> weight to the interface.
>
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Co-developed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

Hi Joshua,
I'm glad we're close to finalizing the interface.

I believe the author has successfully addressed major concerns
through the revisions. The interface and the code now look good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

With a few nits:

> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..c26879f59d5d 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -20,6 +20,34 @@ Description:	Weight configuration interface for nodeN

[...snip...]

> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
> +Date:		January 2025
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Auto-weighting configuration interface
> +
> +		Configuration mode for weighted interleave. A 'Y' indicates
> +		that the system is in auto mode, and a 'N' indicates that
> +		the system is in manual mode. All other values are invalid.
> +
> +		In auto mode, all node weights are re-calculated and overwritten
> +		(visible via the nodeN interfaces) whenever new bandwidth data
> +		is made available during either boot or hotplug events.
> +
> +		In manual mode, node weights can only be updated by the user.
> +		If a node is hotplugged while the user is in manual mode,
> +		the node will have a default weight of 1.
> +
> +		Modes can be changed by writing Y, N, 1, or 0 to the interface.
> +		All other strings will be ignored, and -EINVAL will be returned.
> +		If Y or 1 is written to the interface but the recalculation or
> +		updates fail at any point (-ENOMEM or -ENODEV), then the mode
> +		will remain in manual mode.

nit: the commit log describes that writing 'N' or '0' means
switching to manual mode and writing 1 means switching to auto mode,
but the Documentation does not explicitly states what '0' and '1' does?

> +		Writing a new weight to a node directly via the nodeN interface
> +		will also automatically update the system to manual mode.


> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 80a3481c0470..cc94cba112dd 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -20,6 +20,7 @@
>  #include <linux/list_sort.h>
>  #include <linux/memregion.h>
>  #include <linux/memory.h>
> +#include <linux/mempolicy.h>

nit: is this #include directive necessary?

--
Harry

