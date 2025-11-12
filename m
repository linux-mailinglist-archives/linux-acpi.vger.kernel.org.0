Return-Path: <linux-acpi+bounces-18832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E99C53FB0
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E8734FB190
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019434029C;
	Wed, 12 Nov 2025 18:35:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFD347FEC;
	Wed, 12 Nov 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972553; cv=none; b=UGBaqOslGP0l48F9y3i7ItdmuMwJgDtsynOmr9yFgcevRyd6pHCnbLkOBrrv2+qjfY7wyiUCCf1VpKLGZXsjE+9F1bcxM0FqO84s3wqNcv0EnDO7ARVhzy7314OcX327ISi7spJHxovghEuexwIsC0SPkmAkmnEvZtKORpQkImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972553; c=relaxed/simple;
	bh=lTTH2q4IQAG/2gfIewSm233aboRaQYp1bRfnwGmLZmU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap8xzmDbvCb9rIJaqp5gR14NzWWlsDEAv5PTQ7X/ZOp5yf2tglq4e6drwDHDFQ1903oXczZRa+snA5xu1wCqLgiiDMlyH2RrRkiZhV4o7IZT+N8sotwv+LnqWMmTIqhXifK10T50we/atCGFjBk2gRXtGw9AE7tlf9KnaRlkqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6Bss2p2yzHnGj1;
	Thu, 13 Nov 2025 02:35:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E58931402F5;
	Thu, 13 Nov 2025 02:35:48 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 18:35:47 +0000
Date: Wed, 12 Nov 2025 18:35:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Mark
 Rutland" <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
	<j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
	<james.clark@linaro.org>, Jinjie Ruan <ruanjinjie@huawei.com>, "Alexandru
 Elisei" <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 25/26] irqdomain: Kill of_node_to_fwnode() helper
Message-ID: <20251112183546.00005dda@huawei.com>
In-Reply-To: <20251020122944.3074811-26-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
	<20251020122944.3074811-26-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 20 Oct 2025 13:29:42 +0100
Marc Zyngier <maz@kernel.org> wrote:

> There is no in-tree users of this helper since b13b41cc3dc18 ("misc:
> ti_fpc202: Switch to of_fwnode_handle()"), and is replaced with
> of_fwnode_handle().
> 
> Get rid of it.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
I didn't bother checking all the other removal patches but didn't see
anything wrong with them!  Ripping code out is (usually) uncontroversial.


> ---
>  include/linux/irqdomain.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 9d6a5e99394fa..5907baf6099d9 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -730,12 +730,6 @@ static inline void msi_device_domain_free_wired(struct irq_domain *domain, unsig
>  }
>  #endif
>  
> -/* Deprecated functions. Will be removed in the merge window */
> -static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
> -{
> -	return node ? &node->fwnode : NULL;
> -}
> -
>  static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
>  						     const struct irq_domain_ops *ops,
>  						     void *host_data)


