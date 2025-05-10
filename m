Return-Path: <linux-acpi+bounces-13671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496ACAB2513
	for <lists+linux-acpi@lfdr.de>; Sat, 10 May 2025 20:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55233B988F
	for <lists+linux-acpi@lfdr.de>; Sat, 10 May 2025 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14D280318;
	Sat, 10 May 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP97Z4vc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64F14901B;
	Sat, 10 May 2025 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746903115; cv=none; b=c4nOuy7iu2e1NPdKxxLyDB9ipyyXjDR9p3+NZhb0AOSuauwQu8abfPq/NRJxHe9XYH39WH3ReJNCoeXsuY+meUNmUZEMtG5m2esabrZb0O9vViCWypbJpD/LYl6UpPHzCPB66DmthVeYgyBgQfK9BFS+7gmR9Q8m2wu8JSK5L+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746903115; c=relaxed/simple;
	bh=M6DROtz26daHIavufafJSq474ClezUxXHOfbt1wFEsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DL5JzcSe51+o7aG+nXbrQvcpUBaGqH/9P0e922mvXm8993sp7CzuMPTHODlqzCNpQvcFGelL5WoJizS4Bwu3wcI7bO8eQwfZiDvEWQaaH5sY1neMAO+2a4J7ZCNA91m9FCw29i+1S9hSyY2tgwOnHYZbHr9VqVx5VZ64O6AJfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP97Z4vc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7329792c6eso2729820276.1;
        Sat, 10 May 2025 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746903112; x=1747507912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajISBZKVOwFL0mVE+DS2D0tb1au8A8XUlLnEI2/dhuU=;
        b=nP97Z4vcSYQB+94NsJs1S3zDrr9m6v/8bjqKCteyOlIDhY9NJLUI3z7AGiQOdR5oAF
         RSbqfMOZ91fRAYjS5n1tyCBm3mngqQZd+g1IBvIM3pZO8oCNGUFSMk8u4/2KfS5leCt7
         IQqI2P2me9rENKgmB1S9mq1gHJe6T0RrKV6IpkIreUawFrYoNo7Oqk2DioneG1oKGvOp
         /rGhm36Q861l4rj4jb964yYhKYOx0533GtUJ7SYdy4Ndu3N3aqjTWWDqmeF/gqNoWZwu
         ZfwNMrPFnu0R3ghq3khlFoWzn5ImnkR17cGv7MBU5t8rbWI5sVXR7fK+G9S3ptVw/VIQ
         Oo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746903112; x=1747507912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajISBZKVOwFL0mVE+DS2D0tb1au8A8XUlLnEI2/dhuU=;
        b=H+4718fXr5+TJhMLkpOPpxLtYiRJhtWIc7DO1FuIBVlF1kLYt2dLlCDrGFOlreB5CH
         NGEFQq8UMH28HHfJO92iaJqSwaZd4NrRjnN7fMpG6w5Kumo3c4DX2FUfoxTgQl1ykmTB
         L1b6J1ChqpurZJYCsPM3CwF9QuvMzVwYVJWX0uhysyWl9v6ExcyOn6Xglg7uQLs9H4u6
         5D0FNYu5dJ95oiAqNDXjaHXQlJ0jZhUi5XeMdk5EGt4npXZeK5hjoFG6BrXHqN6de9iI
         cZ8CqmRMKVdJhGjkCWQkdhYLhEDdW/L2gQ3a9U6WanqMUq+S8p/Ak4Gmr9FO1TyRQ6Dw
         TIYw==
X-Forwarded-Encrypted: i=1; AJvYcCVGbZKj40ZIucrtHAGuxdkM9TXCYSald6aQ6gNsaqq7hYQ7azYrKfrtfCKDXs2rhM+vSMYXdUp1P+TN@vger.kernel.org, AJvYcCX7HGjUv4gmsklFNHcRZ4NTTE24nanB+Jg1H+jXLHee/rI0BnnxP/AM/XRDTnKXntp0ix929x7ASexIFwny@vger.kernel.org
X-Gm-Message-State: AOJu0YxthozQ6DJRo7r5kDf/v74Ue1MJUafaymN0x+QWu+hKc1kXkTlq
	Fz4O4uPhdO0317ltZlfvCLy+IqVDTxToYt+UudO5uRI0hBM7SSg9
X-Gm-Gg: ASbGncuLDT5O99SRGUhxzD57es3+2Ud9+RZIYu4jaDrf91B92cgs9X9L4tOMcYP1G0F
	OPHHcGZcel0JXEplV4c+6j75US0MJp1ovy6M1o7gKdBUdpeChYd93Fq/Ngnc5tCxuEnov+dBD78
	ZNr+G5V8P7GLTJb8MjUplV0v8CcSVH9V+CAfJOomGa6pEK5TUVO3pery14ItyeoCZo0O7OeUvke
	Kywwp/I3u+4YF7V/vA7xtIOQbg+qAYXiWfp48+TXOlB6l/GjWCr+7YTa2sugQxTZFXHB+8Clp8b
	FcOYT2++LNzPYK8/UOsU3hq5Lj7TrLLOBRG92hYbcXjseeVO7A==
X-Google-Smtp-Source: AGHT+IGhodSte6+0hre33mKZAplqwN7/ZYX5FkaNb/0QiiejR145pODTSd2jiNxbF9YyFT1jpNULRw==
X-Received: by 2002:a05:6902:2601:b0:e78:ed64:c495 with SMTP id 3f1490d57ef6-e78fdb83f7dmr10370707276.6.1746903112283;
        Sat, 10 May 2025 11:51:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd651a24sm1230871276.38.2025.05.10.11.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:51:51 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: gourry@gourry.net,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Sat, 10 May 2025 11:51:50 -0700
Message-ID: <20250510185150.4078843-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <87h61t11gz.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 10 May 2025 13:25:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

Hi Ying,
Thank you for reviewing my patch, as always!

> Hi, Joshua,
> 
> Thank you for updated version!  And sorry for late reply.
> 
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:

[...snip...]

> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > index 0b7972de04e9..ec13382c606f 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > @@ -20,6 +20,35 @@ Description:	Weight configuration interface for nodeN
> >  		Minimum weight: 1
> >  		Maximum weight: 255
> >  
> > -		Writing an empty string or `0` will reset the weight to the
> > -		system default. The system default may be set by the kernel
> > -		or drivers at boot or during hotplug events.
> > +		Writing invalid values (i.e. any values not in [1,255],
> > +		empty string, ...) will return -EINVAL.
> > +
> > +		Changing the weight to a valid value will automatically
> > +		update the system to manual mode as well.
> 
> s/update/switch/ ?
> 
> But my English is poor, please keep your version if you think that it's
> better.

I have no particular preference here, whatever will make it easiest for the
users to understand what is happening. I'll take your suggestion!

[...snip...]

> > +/*
> > + * A null weighted_interleave_state is interpted as having .mode = "auto",
> > + * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
> > + */
> 
> Better to move the comments to above "wi_state" definition?
> 
> > +struct weighted_interleave_state {
> > +	bool mode_auto;
> > +	u8 iw_table[];
> > +};
> > +
> 
> Why do you put the type definition in mempolicy.h instead of
> mempolicy.c?  I don't find other users except mempolicy.c.

Good point, I'll move the definition to mempolicy.c and move the comment
to the wi_state definition as well.

[...snip...]

> > @@ -3450,31 +3555,104 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  			  const char *buf, size_t count)
> >  {
> > +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> >  	struct iw_node_attr *node_attr;
> > -	u8 *new;
> > -	u8 *old;
> >  	u8 weight = 0;
> > +	int i;
> >  
> >  	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
> >  	if (count == 0 || sysfs_streq(buf, ""))
> >  		weight = 0;
> 
> According to revised ABI, we should return -EINVAL here?

Great catch, I completely ignored the ABI description that I wrote...
I'll go ahead and just return -EINVAL here!

[...snip...]

> > +static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> > +	unsigned int *bw;
> > +	bool input;
> > +	int i;
> > +
> > +	if (kstrtobool(buf, &input))
> > +		return -EINVAL;
> > +
> > +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> > +			       GFP_KERNEL);
> > +	if (!new_wi_state)
> > +		return -ENOMEM;
> > +	for (i = 0; i < nr_node_ids; i++)
> > +		new_wi_state->iw_table[i] = 1;
> > +
> > +	mutex_lock(&wi_state_lock);
> > +	if (!input) {
> 
> If input == old_wi_state->mode_auto, we can return directly?

Yes, that makes sense to me.

> >  static void wi_cleanup(void) {
> > +	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> 
> Why not just
> 
> 	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
> 
> ?

Also makes sense!!

> ---
> Best Regards,
> Huang, Ying

Thank you for your great feedback Ying, I'll make changes based on
your suggestions and shortly send up a v9. I hope you have a great day!
Joshua

