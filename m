Return-Path: <linux-acpi+bounces-16384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2BB44B2F
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 03:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420987A3854
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 01:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA41B5EC8;
	Fri,  5 Sep 2025 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pQdYAhOw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015910E3;
	Fri,  5 Sep 2025 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757035180; cv=none; b=YCUWqbK4IpKY7qqAXItBc1+Och+OtCx2oRpHJtrz2D8WlTMP/yinKlr9zrZAV2gonCrpMTDF/KDzLNYILbjyXRwXFER3vqgvhtZ9hmTF4jcHsU8HN41obj7FMzn2rjIg49ExQuaGJQDP1g4rbQPBUw6OEPddTx9F08kgRMqVMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757035180; c=relaxed/simple;
	bh=V5bycZE/LAMoOIwbQ8mtG5Ms7G54zGYvzc2iwUQubiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTfjDMf6i77bTvpB6U4Pm/sO8NB1b4Uul8ssfJ9nqtDrkajMw53iu4bDDPp5J3f09AtZMdVZJRgQpxfjmdnC0C81KKKGRmelOW+Ipatzi6PWlnn5Dl/QelRpTTTyEAFGPE7uUC1/cEm1EIKFt3iUo8Daz16Uiz5pOSuu8d69bXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pQdYAhOw; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757035174; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=U9OrYRT7HW2PbhutrRaBBDPr+fp0gvFrhgkxReSt6t4=;
	b=pQdYAhOwLejmfw1drdKnjVfkXesAT/VTJaiu4tmuQAGwFvOkvUbYMe6vQOCcl05RKCMm7wLkF+pOv8lLeGXB8KmmPljeetE6nWRkA2hZhCjADBGHm9qKNhww9D9EZZdw+JmJHay0+EjHoqJ49m7k9tu6pyezayNUsY44p/C6aQE=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WnIfnK0_1757035173 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 09:19:33 +0800
Message-ID: <7c0ea575-7682-4601-8922-49684d929374@linux.alibaba.com>
Date: Fri, 5 Sep 2025 09:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: Remove redundant assignments in
 erst_dbg_{ioctl|write}()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903224913.242928-2-thorsten.blum@linux.dev>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250903224913.242928-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/4 06:49, Thorsten Blum 写道:
> Use the result of copy_from_user() directly instead of assigning it to
> the local variable 'rc' and then overwriting it in erst_dbg_write() or
> immediately returning from erst_dbg_ioctl().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/acpi/apei/erst-dbg.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
> index 246076341e8c..ff0e8bf8e97a 100644
> --- a/drivers/acpi/apei/erst-dbg.c
> +++ b/drivers/acpi/apei/erst-dbg.c
> @@ -60,9 +60,8 @@ static long erst_dbg_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>   
>   	switch (cmd) {
>   	case APEI_ERST_CLEAR_RECORD:
> -		rc = copy_from_user(&record_id, (void __user *)arg,
> -				    sizeof(record_id));
> -		if (rc)
> +		if (copy_from_user(&record_id, (void __user *)arg,
> +				   sizeof(record_id)))
>   			return -EFAULT;
>   		return erst_clear(record_id);
>   	case APEI_ERST_GET_RECORD_COUNT:
> @@ -175,8 +174,7 @@ static ssize_t erst_dbg_write(struct file *filp, const char __user *ubuf,
>   		erst_dbg_buf = p;
>   		erst_dbg_buf_len = usize;
>   	}
> -	rc = copy_from_user(erst_dbg_buf, ubuf, usize);
> -	if (rc) {
> +	if (copy_from_user(erst_dbg_buf, ubuf, usize)) {
>   		rc = -EFAULT;
>   		goto out;
>   	}

Hi Thorsten,
Thanks for the patch.

The changes look good to me.

Since this is a code cleanup with no functional changes, could you
please mention "no functional change" or similar wording in the commit
message to make it clear?

With that addressed:
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks,
Shuai

