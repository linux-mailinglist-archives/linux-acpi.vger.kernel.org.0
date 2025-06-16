Return-Path: <linux-acpi+bounces-14395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5335AADB823
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98B316FF6B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D615288532;
	Mon, 16 Jun 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="gpYq4SO4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C361287512;
	Mon, 16 Jun 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096348; cv=none; b=GG0YT2SPsy8aXvowU09sRhSSdqjZ3ZsUeNeIe11ZDCYyAznfKtLjuYLYWZEhWTUfjQ11gCo2IYFfonyxziN7W9z+7PLGpIxHTyNSOHrMEcwZpcr/Enu1zfzq19z5QFy1FGfckHZnB2uVaQcmK0a1SBTxh6lRQp7tgmY+F/ODFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096348; c=relaxed/simple;
	bh=g+HwPP9ZIb15NvMhIr+CPbozu6dGSLfBz7OsV9vYGrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1+JmCWY8NyqxmBycR3EvFque0hUQ+x7fSVgGM9KNzG26/sDCpq7FTVff5oX3t/+qLH+zzwEMM8RulsKA99qgzM0ZZLDED9CfLTo7NdssTwoIXofbYRHm84GbmWOhWPQEkRyZvGwj6FE9cxMERQa2PkH7NcGARnxEkj+trmIW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=gpYq4SO4; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bLcyq33LHz9tSG;
	Mon, 16 Jun 2025 19:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750096339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U80w8z7BB4L7OCfBpTuzF9uuk8qIENMB0ofD4rcuGa0=;
	b=gpYq4SO4iiyKNpezJWHa+j/YfswRSZbwFLtuhYuTL3DP9NhfuBwXl3rBauMFpBYWKoXaLy
	6EWbnFUwLZABQotOqFCr5fJAX1YKX4/whhZNQJz8KixNPQtbKMLbIIsFAUrywRY/ig+8mn
	7nPcH0k2Qm13BpQ9W/bpd9vcsMUXZQV2WRQXZvdd313tLCmSYFFXVUPdpyXLcPLx6TIZIy
	ej64GXidw4LGDQ+nbLWPofbWRq3YKhiVO8DWBjJ5Zoz6Uuh8xCgY7+tlvYvn0FPGzNHnRE
	mC0UF1J5ka9vOSfygWyvj1xUEO3xaw/EvtqY8mJihqr++3CsbSIXOX4GciKUyw==
Date: Mon, 16 Jun 2025 23:22:15 +0530
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	lv.zheng@intel.com
Subject: Re: [RFC PATCH] ACPI / sysfs: Replace deprecated strcpy() with
 strscpy()
Message-ID: <4euirck7yxqxlnzfwus7xfhpxre5q7ck5nhumvj7vdw2ha35mm@dtrhqeyl5tob>
References: <20250616174748.2799-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616174748.2799-1-listout@listout.xyz>
X-Rspamd-Queue-Id: 4bLcyq33LHz9tSG

On 16.06.2025 23:17, Brahmajit Das wrote:
...
> ---
>  drivers/acpi/sysfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a48ebbf768f9..4005c9faf14f 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -181,10 +181,9 @@ static int param_set_trace_method_name(const char *val,
>  
>  	/* This is a hack.  We can't kmalloc in early boot. */
>  	if (is_abs_path)
> -		strcpy(trace_method_name, val);
> +		strscpy(trace_method_name, val);
>  	else {
> -		trace_method_name[0] = '\\';
> -		strcpy(trace_method_name+1, val);
> +		scnprintf(trace_method_name, sizeof(trace_method_name), "%c%s", '\\', val);

Maybe something like would be better
 -		trace_method_name[0] = '\\';
 -		strcpy(trace_method_name+1, val);
 +		scnprintf(trace_method_name, sizeof(trace_method_name+1), "%c%s", '\\', val);

-- 
Regards,
listout

