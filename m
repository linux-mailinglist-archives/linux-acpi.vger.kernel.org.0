Return-Path: <linux-acpi+bounces-11143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEDCA334BC
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 02:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A77A16504E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 01:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5E073451;
	Thu, 13 Feb 2025 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ML9y+oNR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400B1A29A
	for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2025 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410379; cv=none; b=jKUHyPCVJrHevQS6b2/LWFOcLWVEDexmSZEDJ5cKjr4tv8BlnBrdRBo4+Zm5mJ9+7iXcyCvGL+YKf0yPZTvuXll4q/xSu8dnOC1vOiLreZ1JpH7g20etqo/9oy9WI37yKWMlRI7Vguoq7GTrYnOlc5j001EwQ9ar5fS3fjOPAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410379; c=relaxed/simple;
	bh=GTJN4LErwaX0slM9eExYZlenI+bg6sHjSXxXmMOvQ1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAjfeeYUMqG74SseKUkGgnXWtGml2+L5njS70EVmgsyqAiPd2Umx6DpOD1Q9y3WYImXht+FM/6ZLtPxdXCZquaM569IyO3nXNgkHrMBiYwkcwVwfnuIuU8L4KEZQK6PaX8DgmH/GswDxRRULRjMgCaheCtwwsMZ1lLrJEKaAIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ML9y+oNR; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739410373; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=Sf4lxMxbRNIuQuKh4DRNiD6dS8R5PiKaGlbqvYykW5g=;
	b=ML9y+oNRrDmSPvHHBBFNYdARoD+3iiatAD0Uz+YSw16ZiuUk/KpKsVkUPcVhQ3rF1eSdy3OQMw0yIZm0HQ2uOfZM3U09M4cG9tmb82auLKjJqabfBpaiCckYadzI9aFRgdLhx83tz1CeRV+r4tkzaZJR6QMv/9Cy3AJNSPx875c=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WPLZXLb_1739410370 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Feb 2025 09:32:51 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net,  hyeonggon.yoo@sk.com,  honggyu.kim@sk.com,
  akpm@linux-foundation.org,  rafael@kernel.org,  lenb@kernel.org,
  gregkh@linuxfoundation.org,  rakie.kim@sk.com,  dan.j.williams@intel.com,
  Jonathan.Cameron@huawei.com,  dave.jiang@intel.com,
  horen.chuang@linux.dev,  hannes@cmpxchg.org,  linux-kernel@vger.org,
  linux-acpi@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
In-Reply-To: <20250212170645.1080771-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Wed, 12 Feb 2025 09:06:40 -0800")
References: <20250212170645.1080771-1-joshua.hahnjy@gmail.com>
Date: Thu, 13 Feb 2025 09:32:49 +0800
Message-ID: <87tt8y1vem.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Wed, 12 Feb 2025 10:49:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Hi, Joshua,
>> 
>> Thanks for your patch and sorry for late reply.
>
> Hi Ying, no worries! Thank you for taking time to review this patch.
>
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:

[snip]

>> > +
>> > +static ssize_t weighted_interleave_mode_store(struct kobject *kobj,
>> > +		struct kobj_attribute *attr, const char *buf, size_t count)
>> > +{
>> > +	uint64_t *bw;
>> > +	u8 *old_iw, *new_iw;
>> > +
>> > +	if (count == 0)
>> > +		return -EINVAL;
>> > +
>> > +	if (sysfs_streq(buf, "N") || sysfs_streq(buf, "0")) {
>> 
>> kstrtobool() can be used here.  It can deal with 'count == 0' case too.
>
> These kernel string tools are very helpful, thank you for bringing
> them to my attention : -)
>
>> > +		weighted_interleave_auto = false;
>> > +		return count;
>> > +	} else if (!sysfs_streq(buf, "Y") && !sysfs_streq(buf, "1")) {
>> > +		return -EINVAL;
>> > +	}
>> > +
>> > +	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
>> > +	if (!new_iw)
>> > +		return -ENOMEM;
>> > +
>> > +	mutex_lock(&iw_table_lock);
>> > +	bw = node_bw_table;
>> > +
>> > +	if (!bw) {
>> > +		mutex_unlock(&iw_table_lock);
>> > +		kfree(new_iw);
>> > +		return -ENODEV;
>> > +	}
>> > +
>> > +	old_iw = rcu_dereference_protected(iw_table,
>> > +					   lockdep_is_held(&iw_table_lock));
>> > +
>> > +	reduce_interleave_weights(bw, new_iw);
>> > +	rcu_assign_pointer(iw_table, new_iw);
>> > +	mutex_unlock(&iw_table_lock);
>> > +
>> > +	synchronize_rcu();
>> > +	kfree(old_iw);
>> > +
>> > +	weighted_interleave_auto = true;
>> 
>> Why assign weighted_interleave_auto after synchronize_rcu()?  To reduce
>> the race window, it's better to change weighted_interleave_auto and
>> iw_table together?  Is it better to put them into a data structure and
>> change them together always?
>> 
>>         struct weighted_interleave_state {
>>                 bool weighted_interleave_auto;
>>                 u8 iw_table[0]
>>         };
>
> I see, I think your explanation makes sense. For the first question,
> I think your point makes sense, so I will move the updating to be
> inside the rcu section.
>
> As for the combined data structure, I think that this makes sense,
> but I have a few thoughts. First, there are some times when we don't
> update both of them, like moving from auto --> manual, and whenever
> we just update iw_table, we don't need to update the weighted_interleave
> auto field. I also have a concern that this might make the code a bit
> harder to read, but that is just my humble opinion.

I think the overhead is relatively small.  With that, we can avoid the
inconsistency between weighted_interleave_auto and iw_table[].
struct_size() or struct_size_t() family helpers can be used to manage
the flexible array at the end of the struct.

---
Best Regards,
Huang, Ying

