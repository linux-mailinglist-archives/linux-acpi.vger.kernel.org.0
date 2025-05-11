Return-Path: <linux-acpi+bounces-13673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B503AB2646
	for <lists+linux-acpi@lfdr.de>; Sun, 11 May 2025 04:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92011896379
	for <lists+linux-acpi@lfdr.de>; Sun, 11 May 2025 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB63A1B6;
	Sun, 11 May 2025 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT8PQ3js"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956828FD;
	Sun, 11 May 2025 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746932327; cv=none; b=h6xmDkEgHiZhAEFl8XSzEwo3kNLYQJPewW995ow/QajZxM3msl9e2+0VRj5ztvZVcVSdPfjuK5xn5ealbyQbROSi9XW0Qhaf8jpsZN4M/Enqvvk2eWk/nuFPOtidCuCxsF9swcTyVU89LyuXBd4wvd421qx8Lo+fLqqJ0dQPzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746932327; c=relaxed/simple;
	bh=xSya/cD7Vro2FPZNZdbVXjzZfM4ndp/BPgCVgVemJfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAGectz+u3OtNDoliPpd0e78KCQLx+e9hgcj67+qP7QM1/ijn1dglgHDhdwRHtXmhet/ZCAfSiI4GK0gwTf7/ZgqpS/N0iFVFDC69wku3XrffqX8PpedsL0pdU3N+EB/SKIcw59m4YmxmXL8mvyWiU31dFrXWVQly9ocCxXpPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT8PQ3js; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7082ad1355bso28498617b3.1;
        Sat, 10 May 2025 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746932323; x=1747537123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rIqno4q3SZ3Qt2EV0P6akhqys5m6oT2jaLjH6WpTDE=;
        b=iT8PQ3jsMo0fAPqYciXcwr4eD4xbxYIRmyLNXMBK+fe4M5zdzpP9LPyGKZef+x8KPP
         H2ECCDo0nGAvLT9IqRjPPndEXgyuTwiQvf0jcrYgnQszqDXOgQ3H3CNMaKqTvR+xKIFa
         CUabmuvecBRCKc5a+keAQ8CTZRa8+rywu7+zi6Cq+Cqfgqizn9SjjLU7KJ39Y1NSiVPh
         z55Y3bLbxaViCCEKNMJYvIQgIWT/XX6Sf6I/BHd88tC/mOWdl1IKfzyipilpnOntYpUJ
         aIEvjP6+wu7DJ5tCpFvup67SrxPBNazQDMLKdXzXJMEXpyO0TzDIPcd00bQ7zfcvJxJ/
         P99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746932323; x=1747537123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rIqno4q3SZ3Qt2EV0P6akhqys5m6oT2jaLjH6WpTDE=;
        b=js+cpziyul0IOu5A/1BJUM6lwRinJWpcXhETCPH+FsIn+pfNm7o3bsRTg8CwX9IKur
         p4IK9V2r7oNTbyM5Gi9ONT1VD2AhhMh9PPl+K9RggUWlwU45tJUyaZS17z5b1iDAgAXi
         yXm4yuY5UnqaaicFFj/Ogt7xbIbLZ5jfay7R3hZnslJ082cLuZI0+/B64S2FSSrv6scl
         mEr2mdkBNkWaeJdmwuvDzQHUrSYU9aGh9qOj941IdxeiCUHmJV1FY469G0wA92WfPIrT
         Y1ezHEqxQc3WvDgdVvCAWIgz8RR8q/FUR35odGZ/AtjNDkHtA7svjNSvV1XhJgvtclgX
         t9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUTaRRtW5+HI3F7PToSTzD/YCtTGXYvr4YdEYjunwyF39xKQ7Mn6V8EIBFtFEWFEQdWtmw/MfzcxbHgTBtg@vger.kernel.org, AJvYcCXK033cQvHtSs9PvRJNdgNbZfx2BRDnq4jhkZl+RQKsLfkMfezjSnFbudnQO2bhndZxgDsTkBtE8Yrr@vger.kernel.org
X-Gm-Message-State: AOJu0YwwhPfn2jZswexPVlsgJsd3MYmukU4KVKZXt+Om9OEu1aEzdch0
	6VJo3q5ZHSALKTyzD4uVjPj2Fs1t7Vg2kAGnjNpjidVcN8j54b4MaXuSUA==
X-Gm-Gg: ASbGncv6xFoFsryrev47anHugS2q5Gg1HTsGaM/3zIcotKCqQ3IwlF0TytUKqLhk1Qo
	7gOdlPYXhSBBevEcwLjUugdza9LZU0kL3fvi/RSlRRBqZ71QqKHuo+WEGnidPOElHaSNluO2MT0
	J5kU2h1qnewIak4mMFO77K2hiP4gSCgkoTLxeMo1n2lbkkSjZ2UBnAXBfOMWZQdTtXcRL7pMc7V
	lDPrT4qkaLEaAfo4QsKUt+jdAxeoY9kBZ6ud6uBgKpShn2NgPLcmqk54j3XQuLiKTgt1vKeXNah
	krKUyGovoAqezZcZlIpOZAL3ZHQp7JbbNUDIUfJPb6jVqVt2vQ==
X-Google-Smtp-Source: AGHT+IHzJNRE1nE1qbW2MZGxQNyfCfDoJdMT84okbgjoRCuPxSjJvjYiOEtbzvisFV9KGgOn7dPL7Q==
X-Received: by 2002:a05:690c:6c07:b0:6fd:33a5:59a with SMTP id 00721157ae682-70a3fa3df25mr129045327b3.18.1746932322631;
        Sat, 10 May 2025 19:58:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d9cb39esm13386787b3.72.2025.05.10.19.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 19:58:41 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	gourry@gourry.net,
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
Date: Sat, 10 May 2025 19:58:39 -0700
Message-ID: <20250511025840.2410154-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250510185150.4078843-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Andrew,

I was hoping to fold this fixlet in with the patch this belongs to. It includes
some wordsmithing changes, some code simplification/cleanups, and makes sure
that the code behavior matches that of the ABI I described. I've kept the
original message below as well, where Ying suggested the changes present in
this fixlet.

Please let me know if this fixlet is too big, and you would rather prefer a
new version instead. Thank you as always for your patience and support!
Joshua

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
index ec13382c606f..649c0e9b895c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
@@ -24,7 +24,7 @@ Description:	Weight configuration interface for nodeN
 		empty string, ...) will return -EINVAL.

 		Changing the weight to a valid value will automatically
-		update the system to manual mode as well.
+		switch the system to manual mode as well.

 What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
 Date:		May 2025
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 3e8da8ba1146..0fe96f3ab3ef 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -57,15 +57,6 @@ struct mempolicy {
 	} w;
 };

-/*
- * A null weighted_interleave_state is interpted as having .mode = "auto",
- * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
- */
-struct weighted_interleave_state {
-	bool mode_auto;
-	u8 iw_table[];
-};
-
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f542691b7123..0624d735a2e7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -148,6 +148,14 @@ static struct mempolicy preferred_node_policy[MAX_NUMNODES];
  */
 static const int weightiness = 32;

+/*
+ * A null weighted_interleave_state is interpreted as having .mode="auto",
+ * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
+ */
+struct weighted_interleave_state {
+	bool mode_auto;
+	u8 iw_table[];
+};
 static struct weighted_interleave_state __rcu *wi_state;
 static unsigned int *node_bw_table;

@@ -3561,9 +3569,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 	int i;

 	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
-	if (count == 0 || sysfs_streq(buf, ""))
-		weight = 0;
-	else if (kstrtou8(buf, 0, &weight) || weight == 0)
+	if (count == 0 || sysfs_streq(buf, "") ||
+	    kstrtou8(buf, 0, &weight) || weight == 0)
 		return -EINVAL;

 	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
@@ -3630,9 +3637,15 @@ static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
 	if (!input) {
 		old_wi_state = rcu_dereference_protected(wi_state,
 					lockdep_is_held(&wi_state_lock));
-		if (old_wi_state)
-			memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
-					nr_node_ids * sizeof(u8));
+		if (!old_wi_state)
+			goto update_wi_state;
+		if (input == old_wi_state->mode_auto) {
+			mutex_unlock(&wi_state_lock);
+			return count;
+		}
+
+		memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
+					       nr_node_ids * sizeof(u8));
 		goto update_wi_state;
 	}

@@ -3707,8 +3720,12 @@ static void wi_state_free(void)
 	kfree(&wi_group->wi_kobj);
 }

+static struct kobj_attribute wi_auto_attr =
+	__ATTR(auto, 0664, weighted_interleave_auto_show,
+			   weighted_interleave_auto_store);
+
 static void wi_cleanup(void) {
-	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
+	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
 	sysfs_wi_node_delete_all();
 	wi_state_free();
 }
@@ -3798,10 +3815,6 @@ static int wi_node_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }

-static struct kobj_attribute wi_auto_attr =
-	__ATTR(auto, 0664, weighted_interleave_auto_show,
-			   weighted_interleave_auto_store);
-
 static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 {
 	int nid, err;


On Sat, 10 May 2025 11:51:50 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Sat, 10 May 2025 13:25:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
> 
> Hi Ying,
> Thank you for reviewing my patch, as always!
> 
> > Hi, Joshua,
> > 
> > Thank you for updated version!  And sorry for late reply.
> > 
> > Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> [...snip...]
> 
> > > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > > index 0b7972de04e9..ec13382c606f 100644
> > > --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> > > @@ -20,6 +20,35 @@ Description:	Weight configuration interface for nodeN
> > >  		Minimum weight: 1
> > >  		Maximum weight: 255
> > >  
> > > -		Writing an empty string or `0` will reset the weight to the
> > > -		system default. The system default may be set by the kernel
> > > -		or drivers at boot or during hotplug events.
> > > +		Writing invalid values (i.e. any values not in [1,255],
> > > +		empty string, ...) will return -EINVAL.
> > > +
> > > +		Changing the weight to a valid value will automatically
> > > +		update the system to manual mode as well.
> > 
> > s/update/switch/ ?
> > 
> > But my English is poor, please keep your version if you think that it's
> > better.
> 
> I have no particular preference here, whatever will make it easiest for the
> users to understand what is happening. I'll take your suggestion!
> 
> [...snip...]
> 
> > > +/*
> > > + * A null weighted_interleave_state is interpted as having .mode = "auto",
> > > + * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
> > > + */
> > 
> > Better to move the comments to above "wi_state" definition?
> > 
> > > +struct weighted_interleave_state {
> > > +	bool mode_auto;
> > > +	u8 iw_table[];
> > > +};
> > > +
> > 
> > Why do you put the type definition in mempolicy.h instead of
> > mempolicy.c?  I don't find other users except mempolicy.c.
> 
> Good point, I'll move the definition to mempolicy.c and move the comment
> to the wi_state definition as well.
> 
> [...snip...]
> 
> > > @@ -3450,31 +3555,104 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> > >  static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >  			  const char *buf, size_t count)
> > >  {
> > > +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> > >  	struct iw_node_attr *node_attr;
> > > -	u8 *new;
> > > -	u8 *old;
> > >  	u8 weight = 0;
> > > +	int i;
> > >  
> > >  	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
> > >  	if (count == 0 || sysfs_streq(buf, ""))
> > >  		weight = 0;
> > 
> > According to revised ABI, we should return -EINVAL here?
> 
> Great catch, I completely ignored the ABI description that I wrote...
> I'll go ahead and just return -EINVAL here!
> 
> [...snip...]
> 
> > > +static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
> > > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > > +{
> > > +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> > > +	unsigned int *bw;
> > > +	bool input;
> > > +	int i;
> > > +
> > > +	if (kstrtobool(buf, &input))
> > > +		return -EINVAL;
> > > +
> > > +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> > > +			       GFP_KERNEL);
> > > +	if (!new_wi_state)
> > > +		return -ENOMEM;
> > > +	for (i = 0; i < nr_node_ids; i++)
> > > +		new_wi_state->iw_table[i] = 1;
> > > +
> > > +	mutex_lock(&wi_state_lock);
> > > +	if (!input) {
> > 
> > If input == old_wi_state->mode_auto, we can return directly?
> 
> Yes, that makes sense to me.
> 
> > >  static void wi_cleanup(void) {
> > > +	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> > 
> > Why not just
> > 
> > 	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
> > 
> > ?
> 
> Also makes sense!!
> 
> > ---
> > Best Regards,
> > Huang, Ying
> 
> Thank you for your great feedback Ying, I'll make changes based on
> your suggestions and shortly send up a v9. I hope you have a great day!
> Joshua
> 

