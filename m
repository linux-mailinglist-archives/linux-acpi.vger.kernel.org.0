Return-Path: <linux-acpi+bounces-13692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AF4AB48DF
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 03:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E8D19E7665
	for <lists+linux-acpi@lfdr.de>; Tue, 13 May 2025 01:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD317ADF8;
	Tue, 13 May 2025 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P4HKo9M+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B464A923;
	Tue, 13 May 2025 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100484; cv=none; b=JG9sb/Vi4iLvR8Sm5yzL6cSBUTXWBLr8K6hsKuSE1m2btRGhBBa784To5Fb63alsd1WrpGjFmCDzNghO6vfJEtMfQK6gcK2DxiZRKqy2aLTV2RXI5Ikd1TLGE9V3WbApaO/rQ7s+ko1sqKLn8hYlMN6Li6Y69L3l+aVW9Manc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100484; c=relaxed/simple;
	bh=dTi1OJsXKn+RWZzaAkqrmIf45nyc6dVT45jEOUSgZcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PEzLrGy+9bz2NM24YgGiRiL9G9cvYMWJSsEFrWZQzL6iG+3gdTOiF/O7/xG4wLYqq24YERogLf2TiRH5vLR4kZiY1tkucBjAvzZt1l5IyCRWaLWnS2luHwpjzqeSa5m6UmgjzPhjZ7uFUmG/XR6huXCH6lI8j16lD0fAO4SwwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P4HKo9M+; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747100472; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=LRpiP2bt97CwKundx+6bXZICHtp/Usmu8g4owh1FF6A=;
	b=P4HKo9M+22VeTQsgTfUaehytEDls1AQWoJzb2LXSf+ilrJfGR4QstDqBEoiA2RaZSVHG/hBlKyMe5caXZBxraaCO7a/e9bzKOCBPB6VWmBUE6ypCgRVTaXaprErvJLa+5ZfPolhKo3/+qk+IOtCbXlu621HccKebRJK9v/EmtTo=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WaQDtSb_1747100469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 May 2025 09:41:10 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  gourry@gourry.net,
  honggyu.kim@sk.com,  yunjeong.mun@sk.com,  gregkh@linuxfoundation.org,
  rafael@kernel.org,  lenb@kernel.org,  dan.j.williams@intel.com,
  Jonathan.Cameron@huawei.com,  dave.jiang@intel.com,
  horen.chuang@linux.dev,  hannes@cmpxchg.org,  osalvador@suse.de,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
In-Reply-To: <20250512142511.3959833-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Mon, 12 May 2025 07:25:10 -0700")
References: <20250512142511.3959833-1-joshua.hahnjy@gmail.com>
Date: Tue, 13 May 2025 09:41:10 +0800
Message-ID: <87tt5puw21.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Mon, 12 May 2025 09:35:16 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Hi, Joshua,
>> 
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 
>> [snip]
>> 
>> > @@ -3707,8 +3720,12 @@ static void wi_state_free(void)
>> >  	kfree(&wi_group->wi_kobj);
>> >  }
>> >
>> > +static struct kobj_attribute wi_auto_attr =
>> > +	__ATTR(auto, 0664, weighted_interleave_auto_show,
>> > +			   weighted_interleave_auto_store);
>> > +
>> >  static void wi_cleanup(void) {
>> > -	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
>> > +	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
>> 
>> If we use wi_auto_attr directly here, we can remove auto_kobj_attr field
>> from struct sysfs_wi_group?
>
> Hi Ying, thank you for this comment. I should have caught it as well.
> Removing the last users / setters doesn't seem complicated.
>
> Andrew, I'm very sorry -- do you think you can fold this fixlet in as well?
> This is a minor change that removes the only users of this variable.
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d5ae36d2eda8..8581cc861945 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3543,7 +3543,6 @@ struct iw_node_attr {
>  struct sysfs_wi_group {
>         struct kobject wi_kobj;
>         struct mutex kobj_lock;
> -       struct kobj_attribute auto_kobj_attr;
>         struct iw_node_attr *nattrs[];
>  };
>
> @@ -3833,7 +3832,6 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>         err = sysfs_create_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
>         if (err)
>                 goto err_put_kobj;
> -       wi_group->auto_kobj_attr = wi_auto_attr
>
>         for_each_online_node(nid) {
>                 if (!node_state(nid, N_MEMORY))
>
> Thank you both, I hope you have a great day!

Thanks!  LGTM, please feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

---
Best Regards,
Huang, Ying

