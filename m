Return-Path: <linux-acpi+bounces-11206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50571A37188
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Feb 2025 01:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E243D16F02C
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Feb 2025 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0101373;
	Sun, 16 Feb 2025 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h0VN5A0e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4BB7E1
	for <linux-acpi@vger.kernel.org>; Sun, 16 Feb 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739666457; cv=none; b=L4bbTv+XA7vVjNO9c8Fz3AByP4j/q8mBgGj87q8eabjSeJ8AxSn7CmP92PsZXc36R2GDbJlLp0NX9uEEhmAu6olTR0lHUF8A7qqw2awxMT2V36AFgqtdb7cSLWg+0NZJ/aQZ8w82sHGttwwZMM9owz6xsZJUWJMWNRYDtpog4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739666457; c=relaxed/simple;
	bh=S230ac+zGg8tEjQcSrrQt/49o0hNI4MRuwwJBGTUDY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGePyo7LTT750vAjo53XY6Ba2g/kuJRe4tDJHLbTmxqpzn/+jcqip8qgKHVFeUGWapouApVJL7LBqOinkNW6dMNJuWSP5FazthR2oDWFttbm3sRhOeLcwZpQdbtRqyEXwpD4v55mQEDClUpd0apJMjpgdMI4OM5KlhjCP5F/GG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h0VN5A0e; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739666445; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=sUXs3VgNZrKBSdXD9s6NX4ZAwm8NWwUce+uHnj7ZBLk=;
	b=h0VN5A0e/X1V27QpHx6dw9ufb4JVwXkfwBzxedHtnXMZal/L01IXIiiWuWLIk7UT/f/mEwgWfBU2oCdmlOXrby8ysvYmprWkWO3U1q55/Wa074Lrj5nzzgCZ3vYu1z4gR1CRFWppxaVW5TBkcZyKTvfqtYTlPzWccv69RMENKJQ=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WPVDkyP_1739666423 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Feb 2025 08:40:43 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net,  hyeonggon.yoo@sk.com,  honggyu.kim@sk.com,
  akpm@linux-foundation.org,  rafael@kernel.org,  lenb@kernel.org,
  gregkh@linuxfoundation.org,  rakie.kim@sk.com,  dan.j.williams@intel.com,
  Jonathan.Cameron@huawei.com,  dave.jiang@intel.com,
  horen.chuang@linux.dev,  hannes@cmpxchg.org,  linux-kernel@vger.org,
  linux-acpi@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
In-Reply-To: <20250214154557.329912-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Fri, 14 Feb 2025 07:45:48 -0800")
References: <20250214154557.329912-1-joshua.hahnjy@gmail.com>
Date: Sun, 16 Feb 2025 08:40:23 +0800
Message-ID: <87wmdq3eo8.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Thu, 13 Feb 2025 09:32:49 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 
>> > On Wed, 12 Feb 2025 10:49:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>> >
>> >> Hi, Joshua,
>> >> 
>
> [...snip...]
>
>> >> > +		weighted_interleave_auto = false;
>> >> > +		return count;
>> >> > +	} else if (!sysfs_streq(buf, "Y") && !sysfs_streq(buf, "1")) {
>> >> > +		return -EINVAL;
>> >> > +	}
>> >> > +
>> >> > +	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
>> >> > +	if (!new_iw)
>> >> > +		return -ENOMEM;
>> >> > +
>> >> > +	mutex_lock(&iw_table_lock);
>> >> > +	bw = node_bw_table;
>> >> > +
>> >> > +	if (!bw) {
>> >> > +		mutex_unlock(&iw_table_lock);
>> >> > +		kfree(new_iw);
>> >> > +		return -ENODEV;
>> >> > +	}
>> >> > +
>> >> > +	old_iw = rcu_dereference_protected(iw_table,
>> >> > +					   lockdep_is_held(&iw_table_lock));
>> >> > +
>> >> > +	reduce_interleave_weights(bw, new_iw);
>> >> > +	rcu_assign_pointer(iw_table, new_iw);
>> >> > +	mutex_unlock(&iw_table_lock);
>> >> > +
>> >> > +	synchronize_rcu();
>> >> > +	kfree(old_iw);
>> >> > +
>> >> > +	weighted_interleave_auto = true;
>> >> 
>> >> Why assign weighted_interleave_auto after synchronize_rcu()?  To reduce
>> >> the race window, it's better to change weighted_interleave_auto and
>> >> iw_table together?  Is it better to put them into a data structure and
>> >> change them together always?
>> >> 
>> >>         struct weighted_interleave_state {
>> >>                 bool weighted_interleave_auto;
>> >>                 u8 iw_table[0]
>> >>         };
>> >
>> > I see, I think your explanation makes sense. For the first question,
>> > I think your point makes sense, so I will move the updating to be
>> > inside the rcu section.
>> >
>> > As for the combined data structure, I think that this makes sense,
>> > but I have a few thoughts. First, there are some times when we don't
>> > update both of them, like moving from auto --> manual, and whenever
>> > we just update iw_table, we don't need to update the weighted_interleave
>> > auto field. I also have a concern that this might make the code a bit
>> > harder to read, but that is just my humble opinion.
>> 
>> I think the overhead is relatively small.  With that, we can avoid the
>> inconsistency between weighted_interleave_auto and iw_table[].
>> struct_size() or struct_size_t() family helpers can be used to manage
>> the flexible array at the end of the struct.
>
> That sounds good to me. I don't have any strong opinions about this
> change, so I am happy to combine them into a struct. I just want to
> make sure I am understanding your perspective correctly: what is the
> incosistency between weighted_interleave_auto and iw_table[]?
> If I move the weighted_interleave_auto = true statement inside the
> rcu section, will the inconsistency still be there?

Because weighted_interleave_auto and iw_table are 2 variables, you may
read new weighted_interleave_auto and old iw_table or vice versa.  If
we put them into one struct and write/read the pointer to the struct
with rcu_assign_pointer() / rcu_dereference(), we can avoid this.

> Just want to make sure so that I am not missing anything important!
>
> Thank you again for your great feedback. I hope you have a happy Friday!

Thanks!

---
Best Regards,
Huang, Ying

