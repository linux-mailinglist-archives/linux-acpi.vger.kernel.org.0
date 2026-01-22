Return-Path: <linux-acpi+bounces-20551-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KcLIeg0cmmadwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20551-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:32:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00267F83
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0415778AB8E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A130C61C;
	Thu, 22 Jan 2026 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="oZiGLPff"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-37.ptr.blmpb.com (sg-1-37.ptr.blmpb.com [118.26.132.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89452309F0B
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087674; cv=none; b=YBDZ6vqN3cIpCvcottUxfmWvkgF1eNvGWEnrka9MwUMNhkYv3PCzkd3npCCcOGxDRi84vdQ4I8H+rHnz9VnBDTIsauv9Wf0TWGMOq9m215ZLtsXTE/U+9YpPeEx9SuS+sP16ron+YigyAtMWA9h9ihk9jUfKCQ4rqyqdzkZ+0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087674; c=relaxed/simple;
	bh=xFu9IJGJvfJaDz1nN+8EIaaj6zxzd9g0Lwz/hjNPo8Q=;
	h=References:To:Mime-Version:Cc:Subject:Message-Id:In-Reply-To:From:
	 Date:Content-Type; b=LZWS/nJudxVxLy1GkvJF5u5tvEO2/iUz0dCQ9K7J0U1H1YsLpaZNWrnzvbyOW5d3cSVZXChkn1MN8BuFcKd2n6EgXjtoSSU8lTtkVkyc/da0vuhGxiWu3/G8FM1vYs7Jo6de+PxHiZDFUaGr8Bt19ZZ7MlWmr4Pf4rxxniQQ8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=oZiGLPff; arc=none smtp.client-ip=118.26.132.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769087549;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=f7QYobkxi6HcZ0Aps3gy5GVXa+QXQrVxnQUGcneSwxc=;
 b=oZiGLPffnq3E/D/EjZA7jE+924XdtEg+DMIoKEvlmgqcCS5qj7mTiMcqY4W48TBP4m8skK
 Grct+NxX7NdewmLBwcvHl5fyjQ3NauV2j1SsrwHFjbKauRmxRC4jLNHr4TQhc+xH2thioS
 m2PRBntRsKDkA8xOVUebGaVKyVWKcZGvCZaZVH88hYrQzLBIJlel5mzQeEmiroBeU1Zz4V
 2zAMDCsb+ifLv63RaIv+F3Pavro+fpfHpK7faaAOzzzYTZCyauz6blHMrIGUO1rxB6iTUF
 Lhbf3/L7SbR8er6JPQ6JJGtMhCdbxozO+hEvLrknyb7nGfDyHFzOnSIVrg2SQQ==
Content-Transfer-Encoding: 7bit
References: <20260122073446.45628-1-yang.yicong@picoheart.com> <20260122073446.45628-3-yang.yicong@picoheart.com> <2026012217-opium-grit-2295@gregkh>
To: "Greg KH" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [172.16.153.176] ([58.250.122.114]) by smtp.feishu.cn with ESMTPS; Thu, 22 Jan 2026 21:12:27 +0800
Content-Language: en-US
X-Lms-Return-Path: <lba+26972223b+8892a2+vger.kernel.org+yang.yicong@picoheart.com>
Cc: <yang.yicong@picoheart.com>, <rafael@kernel.org>, <lenb@kernel.org>, 
	<tglx@kernel.org>, <dakr@kernel.org>, <akpm@linux-foundation.org>, 
	<apatel@ventanamicro.com>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <geshijian@picoheart.com>, 
	<weidong.wd@picoheart.com>, <linux-acpi@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/2] init: Move console_on_rootfs after async_synchronize_full
Message-Id: <6969336d-3c26-4a21-ac44-d620b549f278@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <2026012217-opium-grit-2295@gregkh>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Date: Thu, 22 Jan 2026 21:12:24 +0800
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[picoheart.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-20551-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+]
X-Rspamd-Queue-Id: 2B00267F83
X-Rspamd-Action: no action

On 1/22/26 6:27 PM, Greg KH wrote:
> On Thu, Jan 22, 2026 at 03:34:46PM +0800, Yicong Yang wrote:
>> Currently the console_on_rootfs() is called before
>> async_synchronize_full(), the console initialization
>> could be still in process in theory due to async
>> probe, etc. Make it after the async_synchronize_full()
>> to make sure the initialization work is done.
> 
> Please wrap at 72 columns.
> 
>>
>> Log the error code as well if we failed to open the console.
>>
>> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
>> ---
>>  init/main.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/init/main.c b/init/main.c
>> index b84818ad9685..c37ba5f89b96 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -1578,6 +1578,7 @@ static int __ref kernel_init(void *unused)
>>  	kernel_init_freeable();
>>  	/* need to finish all async __init code before freeing the memory */
>>  	async_synchronize_full();
>> +	console_on_rootfs();
> 
> Are you sure this is ok?  Messing around with init levels and order is
> _VERY_ tricky.
> 

It's previously in kernel_init_freeable() after do_basic_setup() (where
initcalls invoked). So moving it here the init levels and order is
unchanged (still after the do_basic_setup).

Tested with initrd (ramdisk) and initramfs made by busybox and works fine
(hope no other scenarios missed).


> Your console should NOT be on an async probe path, if you really need
> it, then do not do that at all.  Make it sync, and then it should be ok.
> 

not for my console. it's a theoretical issue during the last discussion but
I did try to make this happened (by make the probe async and add some delay
in the probe to simulate a slow initialization).

since indeed no real problem I met and if consider it should never happen in
real case, should we just leave it as is?

>>  
>>  	system_state = SYSTEM_FREEING_INITMEM;
>>  	kprobe_free_init_mem();
>> @@ -1647,7 +1648,7 @@ void __init console_on_rootfs(void)
>>  	struct file *file = filp_open("/dev/console", O_RDWR, 0);
>>  
>>  	if (IS_ERR(file)) {
>> -		pr_err("Warning: unable to open an initial console.\n");
>> +		pr_err("Warning: unable to open an initial console, err = %ld\n", PTR_ERR(file));
> 
> Why is this changed?
> 

This is a trivial change so I didn't make a separate patch. I suppose it's
useful since I did see different errors (ENOENT, ENODEV) when make cases
for testing this patch and we've already have the err code returned here.

>>  		return;
>>  	}
>>  	init_dup(file);
>> @@ -1690,7 +1691,6 @@ static noinline void __init kernel_init_freeable(void)
>>  	kunit_run_all_tests();
>>  
>>  	wait_for_initramfs();
>> -	console_on_rootfs();
> 
> You just delayed the console output for many (i.e. most) systems out
> there, are you sure that is acceptable to them?
> 

IIUC, console_on_rootfs() will open /dev/console for userspace's
stdout/stdin/stderr and kernel log (printk, etc) won't be affected
by its order.

Thanks.

