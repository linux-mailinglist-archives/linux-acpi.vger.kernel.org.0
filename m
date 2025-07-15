Return-Path: <linux-acpi+bounces-15169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DEB06250
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 17:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB91162DAF
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175A1F463F;
	Tue, 15 Jul 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQR/fHM/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF111E832A;
	Tue, 15 Jul 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591693; cv=none; b=b54ua9pu9HLdaLkuUNOGPiMJz4yfqDqccn44GUE+rV6480AyVejGh/FYnqqWgyQZbjT20XOYUKuUORrUneefyzwQl6FhXU69s3ln3MR0d9p9h/LdHkwdzDtJSwcqzn0O20xnHmAa4ZwISKQPwLOYyLYsB4OWfJRIm+H228LuIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591693; c=relaxed/simple;
	bh=XH/AW8IuB6WHnZRb+68eRm2f51rCkpUYnaW7UaCegS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElMFbKMQ5NuMAoH2iPEPdH1zNgMFxPrZXyJutBRG1YLclLC33J6L0D8T4U5IpMMYW59YfkqwW5co55qwz/gv5vA47HpSA3/yI3vffDwGOLKJwXZG6UFWs7jaHdF1CUJovG16Ur0fpqTJ3m9mNM3EOixAb60/zTULV0V40ndmgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQR/fHM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30B7C4CEE3;
	Tue, 15 Jul 2025 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591692;
	bh=XH/AW8IuB6WHnZRb+68eRm2f51rCkpUYnaW7UaCegS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KQR/fHM/COm1lR2vJTc/bGlHtyHjrRZwex/S3202RAGIwYzZsEger3orp4ChSy6+d
	 TIgJpudcnql8++ss4mcAnNAzr2fwuZtJlWtcWzNpgJKA+8Pe9ADsEkLsgyYXOBNY0a
	 wDHZgOspj0baG+KHe4hVKv++3I1n5Cv3X+DIdgBJExH/+Gjvl6YRgI5IYATS1QskM7
	 AV8o7G1aY50YlIfZFbQREHw/OGSw2KZBMOqJUWdzCUcVXzkElagZC3qGib/+aYnNsF
	 dfntVidNrhP7JERxYcs8FitK65Kn1ZmCb7T1Zj7+A+kENf+l3jUhjL7/N5fvolHhP4
	 8M06EkPvrjmIw==
Date: Tue, 15 Jul 2025 17:01:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Len Brown
 <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, James Morse
 <james.morse@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v1] ACPI: APEI: MAINTAINERS: Update reviewers for APEI
Message-ID: <20250715170125.7ec70752@sal.lan>
In-Reply-To: <12722151.O9o76ZdvQC@rjwysocki.net>
References: <12722151.O9o76ZdvQC@rjwysocki.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 15 Jul 2025 15:20:21 +0200
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Update the ACPI APEI entry in MAINTAINERS by dropping the reviewers
> who have not been responsive for over a year and adding a list of
> new reviewers.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The new people in the new APEI reviewers list, please send your ACKs for this
> change, thanks!

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> 
> ---
>  MAINTAINERS |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -306,10 +306,11 @@
>  
>  ACPI APEI
>  M:	"Rafael J. Wysocki" <rafael@kernel.org>
> -R:	Len Brown <lenb@kernel.org>
> -R:	James Morse <james.morse@arm.com>
>  R:	Tony Luck <tony.luck@intel.com>
>  R:	Borislav Petkov <bp@alien8.de>
> +R:	Hanjun Guo <guohanjun@huawei.com>
> +R:	Mauro Carvalho Chehab <mchehab@kernel.org>
> +R:	Shuai Xue <xueshuai@linux.alibaba.com>
>  L:	linux-acpi@vger.kernel.org
>  F:	drivers/acpi/apei/
>  
> 
> 
> 

