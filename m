Return-Path: <linux-acpi+bounces-13685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3062AB3A35
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 16:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1347E19E0377
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868A1E3DD0;
	Mon, 12 May 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/BJgBpu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801A1E4110;
	Mon, 12 May 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747059258; cv=none; b=neZIAT/ERYz51GFwRow3u/35UvuIqhb1P6ezJQmpUhfr6A1hYNBFbbHka+ad4Ev8hLpXj3cfZ76UpwCxHqx1zAdNqBFiDu/e856AUeEpqIs5+njssX/VQ2i5+bpt1eF3bDpckpith8pZDc15pUnZ6pz5AgstH2LkvLcRH8aLAjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747059258; c=relaxed/simple;
	bh=a4QaV8MjAB0gz1tyUrxaz0iEsgQJJ4GZ5hV8mrIRIK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACOdsUay1gd+06IZ9QinjYuKMTEwp502wTgVz8P/pOHfU6zOHNpXSfzTCajA7H7pKKJCNFT17ci4HYURGpd87johADBY2tes8ELiQ3xboGir7a9DfVromuDcyOS+PW88pJplbJYeL8sqvD7JoOk0g8T5ckNbWRUlR1//q1+CYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/BJgBpu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e740a09eae0so4051612276.1;
        Mon, 12 May 2025 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747059255; x=1747664055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLMJ71c2dzKPX20nCpHU00lcLyc+0oXcOaqjf4y3tFU=;
        b=Y/BJgBpudpfEbF4tIOLQiWUWxDD5TDxw/gIaWiwDsXmKASl+gS1JtMbl9Okr67Ogsf
         /+lfdF+hNm4TrlomQ3gujLxLy+GDM/hg/09ihwA0xOFGoRpriFgsVHewVWPHTt8BtDcN
         FyGPnACh1xkljGJENaa85yEIFOMlSfhImczkgyHcOluvymawtomvFHZ7kM7qBMrhjIu7
         7UrDKOk2rUoYBCa+OixO+9iMxIwxDtSKxdIYwxXzCFsm+5g9h7qHJmx+KBRRZFLZ63Ry
         pjcnhkLyL4XkzX+Fzn2kdLvI23EYFIhrxqrTDCi4QS9sDwBVghQ2oNfN/0z6m23mCXGW
         eF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747059255; x=1747664055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLMJ71c2dzKPX20nCpHU00lcLyc+0oXcOaqjf4y3tFU=;
        b=JXDsfwpo/gL5QjtRyaGard64CBgw56T9KCJ9rpTZgrlpMwYx7FtQMVU8bSt953FQRD
         uitP8OC5Z+nGOyr8OwYBbXG/MRZgp2VY4FIEJ329/S4J3TDSV4FScjfUSce5J50MW9fy
         tSHusSCnoPlY0jtMwluLdnFKLYodItSUffgAeGGEHJQYVpfx1y55xnRJXLnWpJTHetXE
         ZpE8Frd6PYkC1u+Uthl1TJCZZ+nODNK909/lBlYw5t+FKsig6P02ieCxgOZLbZZhitEr
         PICoeOQXTpfc7he1t7YxwPjG5cMz9IyX1nZJ4xO77UPEtECQDMtSYI/BtmSTgIMbwjz7
         g9pw==
X-Forwarded-Encrypted: i=1; AJvYcCUnCgdlT2+7yhQeajMBSfRoMV+UkSdCPnqZWP1odZ0SrFV7YQKe6YFXDXa9lFkyBKTlzUDiDL4YLFBedNRk@vger.kernel.org, AJvYcCW2YUjd6aZiDXC7FSim2ZSNTHR8O993Fl+blhpEoZFiWoTI0ryy3xBBav2M005bi4xX0i92vmIl11tY@vger.kernel.org
X-Gm-Message-State: AOJu0YwznhM+xySiCFmydnMGa2PKlvkTu0QsdlUi0+wTGJXvUbaC+f4N
	SGylT9NQ2xiSOQcNp7z3HMFtVO0Do/aO/A6UyniNzHniNM8VCWCI
X-Gm-Gg: ASbGncusxSoun4qQfHMFg6SWlS7lIRNzHycY/q32hkrqV3p+z/roOI4u05dMzV0yp34
	xQMsI2Z6TdxKlhXWYNAfjHNkjIHk3ISs0f094mGQ8DuyEFg29V6Fxx2NU0DC/EjFPpo2ZLnW4YI
	uHmutJLH/pJhVJ3z+emeEQgC78HwXnjGlh57LXCHDOy8H/KcUJamgDD3VFTSJsO1PN2ULR/exuG
	hIoRGKAq0Dly6+lia/qOkDr7ZNPsVs9CYK5xx215hevQwoQfgNf2O4hcocIQIfOxX8hV1t+hRO6
	LEtCobzXI+42U7y0ZkisZahjNLCQgMjJ86ohkqQ6lvF2QUXOQQ==
X-Google-Smtp-Source: AGHT+IHjDqzivQqgRJLVu4GNkjokOZb4ORWM1bq7SBTyXEQQYnYWJZR5erICaS3dhy7pWKIZzBJsWA==
X-Received: by 2002:a05:6902:845:b0:e7a:f768:43d0 with SMTP id 3f1490d57ef6-e7af768440emr560169276.8.1747059254519;
        Mon, 12 May 2025 07:14:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd651b3asm2113880276.40.2025.05.12.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:14:14 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	kernel_team@skhynix.com,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	gourry@gourry.net,
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
Date: Mon, 12 May 2025 07:14:12 -0700
Message-ID: <20250512141412.3792050-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2e030edd-b3e4-4b79-9e1d-1be0c6b0d0b5@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honggyu, thank you for reviewing & testing my patch (again)!

On Sun, 11 May 2025 21:56:20 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi Joshua,
> 
> Thanks for the update this patch and it looks good to me.
> 
> I've applied your v8 patch with your fixup here together, then tested it in my
> server, which has 8ch of DRAM with 4ch of CXL memory in each socket.
> 
> I can confirm that it shows decent ratio with this auto weight configuration as
> follows.
> 
>    $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
>    auto  node0  node1  node2  node3
> 
>    $ cat /sys/kernel/mm/mempolicy/weighted_interleave/*
>    true
>    3
>    3
>    2
>    2
> 
> Hi Andrew,
> 
> I'm not sure if Joshua is better to post v9, but if you want to fold and update,
> then could you please add my tags as follows when you fold this change?
> 
>    Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
>    Tested-by: Honggyu Kim <honggyu.kim@sk.com>
> 
> I added the same tags in v7 but not included in v8 somehow.
> https://lore.kernel.org/linux-mm/5fdd7db9-96fb-49ea-9803-977158cb0132@sk.com

I must have missed including these tags. Sorry about the confusion --
hopefully we can incorporate them into v8!

> Thanks,
> Honggyu
> 
> On 5/11/2025 11:58 AM, Joshua Hahn wrote:
> > Hello Andrew,
> > 
> > I was hoping to fold this fixlet in with the patch this belongs to. It includes
> > some wordsmithing changes, some code simplification/cleanups, and makes sure
> > that the code behavior matches that of the ABI I described. I've kept the
> > original message below as well, where Ying suggested the changes present in
> > this fixlet.
> > 
> > Please let me know if this fixlet is too big, and you would rather prefer a
> > new version instead. Thank you as always for your patience and support!
> > Joshua
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > index ec13382c606f..649c0e9b895c 100644
> > --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > @@ -24,7 +24,7 @@ Description:	Weight configuration interface for nodeN
> >   		empty string, ...) will return -EINVAL.
> > 
> >   		Changing the weight to a valid value will automatically
> > -		update the system to manual mode as well.
> > +		switch the system to manual mode as well.
> > 
> >   What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
> >   Date:		May 2025
> > diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> > index 3e8da8ba1146..0fe96f3ab3ef 100644
> > --- a/include/linux/mempolicy.h
> > +++ b/include/linux/mempolicy.h
> > @@ -57,15 +57,6 @@ struct mempolicy {
> >   	} w;
> >   };
> > 
> > -/*
> > - * A null weighted_interleave_state is interpted as having .mode = "auto",
> > - * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
> > - */
> > -struct weighted_interleave_state {
> > -	bool mode_auto;
> > -	u8 iw_table[];
> > -};
> > -
> >   /*
> >    * Support for managing mempolicy data objects (clone, copy, destroy)
> >    * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index f542691b7123..0624d735a2e7 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -148,6 +148,14 @@ static struct mempolicy preferred_node_policy[MAX_NUMNODES];
> >    */
> >   static const int weightiness = 32;
> > 
> > +/*
> > + * A null weighted_interleave_state is interpreted as having .mode="auto",
> > + * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
> > + */
> > +struct weighted_interleave_state {
> > +	bool mode_auto;
> > +	u8 iw_table[];
> > +};
> >   static struct weighted_interleave_state __rcu *wi_state;
> >   static unsigned int *node_bw_table;
> > 
> > @@ -3561,9 +3569,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >   	int i;
> > 
> >   	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
> > -	if (count == 0 || sysfs_streq(buf, ""))
> > -		weight = 0;
> > -	else if (kstrtou8(buf, 0, &weight) || weight == 0)
> > +	if (count == 0 || sysfs_streq(buf, "") ||
> > +	    kstrtou8(buf, 0, &weight) || weight == 0)
> >   		return -EINVAL;
> > 
> >   	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> > @@ -3630,9 +3637,15 @@ static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
> >   	if (!input) {
> >   		old_wi_state = rcu_dereference_protected(wi_state,
> >   					lockdep_is_held(&wi_state_lock));
> > -		if (old_wi_state)
> > -			memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
> > -					nr_node_ids * sizeof(u8));
> > +		if (!old_wi_state)
> > +			goto update_wi_state;
> > +		if (input == old_wi_state->mode_auto) {
> > +			mutex_unlock(&wi_state_lock);
> > +			return count;
> > +		}
> > +
> > +		memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
> > +					       nr_node_ids * sizeof(u8));
> >   		goto update_wi_state;
> >   	}
> > 
> > @@ -3707,8 +3720,12 @@ static void wi_state_free(void)
> >   	kfree(&wi_group->wi_kobj);
> >   }
> > 
> > +static struct kobj_attribute wi_auto_attr =
> > +	__ATTR(auto, 0664, weighted_interleave_auto_show,
> > +			   weighted_interleave_auto_store);
> > +
> >   static void wi_cleanup(void) {
> > -	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> > +	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
> >   	sysfs_wi_node_delete_all();
> >   	wi_state_free();
> >   }
> > @@ -3798,10 +3815,6 @@ static int wi_node_notifier(struct notifier_block *nb,
> >   	return NOTIFY_OK;
> >   }
> > 
> > -static struct kobj_attribute wi_auto_attr =
> > -	__ATTR(auto, 0664, weighted_interleave_auto_show,
> > -			   weighted_interleave_auto_store);
> > -
> >   static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
> >   {
> >   	int nid, err;
> > 
> > 
> > On Sat, 10 May 2025 11:51:50 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > 
> >> On Sat, 10 May 2025 13:25:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> >>
> >> Hi Ying,
> >> Thank you for reviewing my patch, as always!
> >>
> >>> Hi, Joshua,
> >>>
> >>> Thank you for updated version!  And sorry for late reply.
> >>>
> >>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >>
> >> [...snip...]
> >>
> >>>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> >>>> index 0b7972de04e9..ec13382c606f 100644
> >>>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> >>>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> >>>> @@ -20,6 +20,35 @@ Description:	Weight configuration interface for nodeN
> >>>>   		Minimum weight: 1
> >>>>   		Maximum weight: 255
> >>>>   
> >>>> -		Writing an empty string or `0` will reset the weight to the
> >>>> -		system default. The system default may be set by the kernel
> >>>> -		or drivers at boot or during hotplug events.
> >>>> +		Writing invalid values (i.e. any values not in [1,255],
> >>>> +		empty string, ...) will return -EINVAL.
> >>>> +
> >>>> +		Changing the weight to a valid value will automatically
> >>>> +		update the system to manual mode as well.
> >>>
> >>> s/update/switch/ ?
> >>>
> >>> But my English is poor, please keep your version if you think that it's
> >>> better.
> >>
> >> I have no particular preference here, whatever will make it easiest for the
> >> users to understand what is happening. I'll take your suggestion!
> >>
> >> [...snip...]
> >>
> >>>> +/*
> >>>> + * A null weighted_interleave_state is interpted as having .mode = "auto",
> >>>> + * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
> >>>> + */
> >>>
> >>> Better to move the comments to above "wi_state" definition?
> >>>
> >>>> +struct weighted_interleave_state {
> >>>> +	bool mode_auto;
> >>>> +	u8 iw_table[];
> >>>> +};
> >>>> +
> >>>
> >>> Why do you put the type definition in mempolicy.h instead of
> >>> mempolicy.c?  I don't find other users except mempolicy.c.
> >>
> >> Good point, I'll move the definition to mempolicy.c and move the comment
> >> to the wi_state definition as well.
> >>
> >> [...snip...]
> >>
> >>>> @@ -3450,31 +3555,104 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> >>>>   static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >>>>   			  const char *buf, size_t count)
> >>>>   {
> >>>> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> >>>>   	struct iw_node_attr *node_attr;
> >>>> -	u8 *new;
> >>>> -	u8 *old;
> >>>>   	u8 weight = 0;
> >>>> +	int i;
> >>>>   
> >>>>   	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
> >>>>   	if (count == 0 || sysfs_streq(buf, ""))
> >>>>   		weight = 0;
> >>>
> >>> According to revised ABI, we should return -EINVAL here?
> >>
> >> Great catch, I completely ignored the ABI description that I wrote...
> >> I'll go ahead and just return -EINVAL here!
> >>
> >> [...snip...]
> >>
> >>>> +static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
> >>>> +		struct kobj_attribute *attr, const char *buf, size_t count)
> >>>> +{
> >>>> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> >>>> +	unsigned int *bw;
> >>>> +	bool input;
> >>>> +	int i;
> >>>> +
> >>>> +	if (kstrtobool(buf, &input))
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> >>>> +			       GFP_KERNEL);
> >>>> +	if (!new_wi_state)
> >>>> +		return -ENOMEM;
> >>>> +	for (i = 0; i < nr_node_ids; i++)
> >>>> +		new_wi_state->iw_table[i] = 1;
> >>>> +
> >>>> +	mutex_lock(&wi_state_lock);
> >>>> +	if (!input) {
> >>>
> >>> If input == old_wi_state->mode_auto, we can return directly?
> >>
> >> Yes, that makes sense to me.
> >>
> >>>>   static void wi_cleanup(void) {
> >>>> +	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> >>>
> >>> Why not just
> >>>
> >>> 	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
> >>>
> >>> ?
> >>
> >> Also makes sense!!
> >>
> >>> ---
> >>> Best Regards,
> >>> Huang, Ying
> >>
> >> Thank you for your great feedback Ying, I'll make changes based on
> >> your suggestions and shortly send up a v9. I hope you have a great day!
> >> Joshua
> >>
> 
> 

