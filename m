Return-Path: <linux-acpi+bounces-15173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B7B06B34
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 03:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8A3564574
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500FE23D2AE;
	Wed, 16 Jul 2025 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W5WAA7a1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FDE2C18A;
	Wed, 16 Jul 2025 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629843; cv=none; b=XOqeffHqDKSvlzhLWt/0oQECF8hp+v09irr+QZEP5N06esMnSxMnBtVoDNNuNr69h+W6EgTPFJlP6mil5cyRTcIYCwkddayhK+05TMA6Tibu2o0qxI8rY44FGWHCagtGphfZ3QTMAYSbV9yEpcE1SdteTCsZ9nvNKsWJtPc4C58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629843; c=relaxed/simple;
	bh=ozEQhwCvRt2rz8EVBZhGA1DKY65cadqEQzqNBycY1gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ip05Mp3LYejzIjQOFblubpn9cbk8IEXzpEyucDSQ7wXlaW54z7W+3NSNJvb2y3+302cZUgI3ABfiORNEaYBaiu87toc6R5MpGGyGC0DScSaCLI+4dAZhopvKGBZKQabRW6oVfZ/WKFYpx6YSZ0KLEAQCWBg2a/gXQbKlr1MjMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W5WAA7a1; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752629830; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MqURQ0yF4jyjYrlUpXFPIf7iNWnZemZGCRCoAlY/F3g=;
	b=W5WAA7a1+51bCzSetXxZrFXYCGlZHfLIeU406eQC2Hgqx3LhwmZiQC88xmXOktl+O4B24h+jY9P+NS/Op1jvlKri2hE8e5uEZuraVyv8NTKipine22pKXGRx1z2tRRiya0UeHSaCc+tCFtE5dlHy5jYpy30MGxcE3Ip75xRAhzw=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj1wtCJ_1752629829 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 09:37:10 +0800
Message-ID: <998ca55d-13b5-4f10-819e-47d674ba3504@linux.alibaba.com>
Date: Wed, 16 Jul 2025 09:37:09 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: APEI: MAINTAINERS: Update reviewers for APEI
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <12722151.O9o76ZdvQC@rjwysocki.net>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <12722151.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/15 21:20, Rafael J. Wysocki 写道:
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
> 
> ---
>   MAINTAINERS |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -306,10 +306,11 @@
>   
>   ACPI APEI
>   M:	"Rafael J. Wysocki" <rafael@kernel.org>
> -R:	Len Brown <lenb@kernel.org>
> -R:	James Morse <james.morse@arm.com>
>   R:	Tony Luck <tony.luck@intel.com>
>   R:	Borislav Petkov <bp@alien8.de>
> +R:	Hanjun Guo <guohanjun@huawei.com>
> +R:	Mauro Carvalho Chehab <mchehab@kernel.org>
> +R:	Shuai Xue <xueshuai@linux.alibaba.com>
>   L:	linux-acpi@vger.kernel.org
>   F:	drivers/acpi/apei/
>   

Acked-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thank you!
Shuai


