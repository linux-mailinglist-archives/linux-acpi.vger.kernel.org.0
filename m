Return-Path: <linux-acpi+bounces-10133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 912539F172C
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 21:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9041885DDB
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 20:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E219068E;
	Fri, 13 Dec 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e85JrnZX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3518FDBE;
	Fri, 13 Dec 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120205; cv=none; b=u4Bo0il20dOh0yuzhF8AhplfqhcxyuS49nhSHhHPGtAYctdTwr+T/RG1fHMA2B0AdkhEszVCTrZaBXVitYZShrrJRRiosoSxZAfOvgA4/DiV78HYv1WpKIwCdwGzTZ+bz70aGMAq66tlteuA2FWjxbNNPeBtqi7qFvMVWbfQeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120205; c=relaxed/simple;
	bh=tjV5osgjbyI+MX10wauZ2+arKLioidveGO3lL2YGsbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpAgT08uUrzlZ06WpL/AK7VtAcjhI7r4a/PoA2fbPjW63qdIpLn8YjWtSdcpoEnB83rh8TmnG1ABYwn0IYJex4RXOF/26+MRtTtDhoLMLFez1G7b9ParsrePsUBUb7yYTQHXu7f5SkHDnR/O479nkryqemQyvUhfKN4qA+YEP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e85JrnZX; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f33ad7d6faso21850eaf.0;
        Fri, 13 Dec 2024 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734120203; x=1734725003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSxjdSUDfHmzmkE1Ayo7U0AvrT2yhA3Ltr1QPBiYLK0=;
        b=e85JrnZX/buEwMthJ5/wgm4nPO9bPD0h4Gyw9F+h/6oY3PSJ0zwCZIeeRZJonsky/m
         tqJz4HbklvTB6VZyZT3wod6292Me2UOf6n9uCn6oWHAkK3mL6vSSuIF+yYj2iW2jfOgm
         Ta0YyrLhJAehQ8mMdxSLtgoo9Y4NnlXVOLDqqzyf2klvgjCKLiu5OW622dYVP2hc4F8O
         N3vpxAaVRQ30adfT6MYoA/qjTKwEsXe+Fx/HLAvbOJyRzVD7D/GK4LZC4BNQAxeq3uJs
         cL8AJ1OyaJC4CDLS/013Mykqib4tF2myILmgqSMBFC5G4gJ+Ny7L3P2NQtZ4xb9TV4/U
         1gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120203; x=1734725003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSxjdSUDfHmzmkE1Ayo7U0AvrT2yhA3Ltr1QPBiYLK0=;
        b=XIxX46dvSbZ+FG1v6x5p0hWoJtRv+Og8Mc+xfg/M4hdzcj15jOjDgQ45TUFWgRCMZq
         ZT4X7Pnk52hrHBjwOPhzni7hi60oOpLoHDz3iVo623QuHXR27+yMiSdMWkyLTQw3PoGG
         DAPXWdhTR2AAKQgk802ouOWEe0yy3jG6yQRiFHYZj4wKcWU433euouvFEFPAPPRIjlGm
         x0R0l5ZOKP8BkVT5NuNlshEfa4wXMwC9bBTn1UOJXmbq6W1aTbyddR019iboQocWOLsr
         KjjtWy7m4b8RttKHA1M2PZHJB/rVIc/xT2khqPcCmkqthdhKs25UklQzBpwJuaa2zQUF
         pEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1RgFHo2231IJiFxZu3Uvl63BizX2Pl3NNsqCwnqZzLATJN/8dv7QIsh6+AvHqSsNXD0rr0CiUoYEh@vger.kernel.org, AJvYcCVFfXd3ojdRGN9Ru6k5bCCjdfckGHMIfIlrtaA6o88tU+TCpT8gpE37MkVeqUYvWYb0hyf9nEmyH6Jf5BQT@vger.kernel.org
X-Gm-Message-State: AOJu0YxjC2TLwO8a3+pjjdbC9NF3Kt8RSU2Tbj+E3hEfx09YqIcaFhgV
	bm22Dib+DA4h2x/E155mvWBgluHszpJcSkUQgpOAQEKkggEu2mshCMEqvSUg
X-Gm-Gg: ASbGnctPCRrRJsDgzJPXSxZVRoxWlfJCUMOPnxXYpQ3n8Ghkbi3wbloCvhQ8H+TWt9p
	77lRunr0vyjYwk0zvia2Qdp0kttkbgBsKDdd141vc8xBSgr3Jclae5pJa9rx5PU/flSh5YQEFMn
	yjYwnI6OK3pU44yA3kwyR9TD9EJ3zJ51zjJQK8m70gHX3xmnOgxyjbnnqOj00Y/+juMsvGM8Yk8
	2CL/Cfu0rGSkp9WgJfXoiukSkLEP5Swg5r3O5f+i85ndIB8W+Q4XvDywzM4L0A2DNAAt7T//FF/
	ycAmcIxC+sQXrGfF
X-Google-Smtp-Source: AGHT+IHS/4vG0XdSp0prcXAlpEvsdSuF07y6AmAofYdTggMqlAhkijuk0JcmF7UBkvKs9T+bdO/kMg==
X-Received: by 2002:a05:6902:a87:b0:e38:1b17:8980 with SMTP id 3f1490d57ef6-e43492f57famr3483416276.4.1734119878971;
        Fri, 13 Dec 2024 11:57:58 -0800 (PST)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e47024dc3f2sm57344276.5.2024.12.13.11.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:57:58 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: hyeonggon.yoo@sk.com
Cc: "gourry@gourry.net" <gourry@gourry.net>,
	kernel_team@skhynix.com,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?UTF-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKSBTeXN0ZW0gU1c=?= <honggyu.kim@sk.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	=?UTF-8?B?6rmA65296riwKEtJTSBSQUtJRSkgU3lzdGVtIFNX?= <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave auto-tuning
Date: Fri, 13 Dec 2024 11:57:31 -0800
Message-ID: <20241213195754.2676135-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
References: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 13 Dec 2024 15:19:20 +0900 Hyeonggon Yoo <hyeonggon.yoo@sk.com> wrote:

> On 2024-12-11 06:54 AM, Joshua Hahn wrote:
> > This patch introduces an auto-configuration for the interleave weights
> > that aims to balance the two goals of setting node weights to be
> > proportional to their bandwidths and keeping the weight values low.
> > This balance is controlled by a value max_node_weight, which defines the
> > maximum weight a single node can take.
> 
> Hi Joshua,
> 
> I am wondering how this is going to work for host memory + CXL memory 
> interleaving. I guess by "the ACPI table" you mean the ACPI HMAT or CXL 
> CDAT, both of which does not provide the bandwidth of host memory.
> If this feature does not consider the bandwidth of host memory, manual 
> configuration will be inevitable anyway.

Hi Hyeonggon,

Thank you for reviewing my patch! As Gregory showed in his reply,
I think it would be possible to get host bandwidth information
using the ACPI HMAT.

[-----8<-----]

> > +What:		/sys/kernel/mm/mempolicy/weighted_interleave/max_node_weight
> > +Date:		December 2024
> > +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> > +Description:	Weight limiting / scaling interface
> > +
> > +		The maximum interleave weight for a memory node. When it is
> > +		updated, any previous changes to interleave weights (i.e. via
> > +		the nodeN sysfs interfaces) are ignored, and new weights are
> > +		calculated using ACPI-reported bandwidths and scaled.
> > +
> 
> At first this paragraph sounded like "previously stored weights are 
> discarded after setting max_node_weight", but I think you mean
> "User can override the default values, but defaults values are 
> calculated regardless of the values set by the user". Right?

In the implementation, the first way you interpreted is the correct
description. That is, if a user manually changes a ndoe weight,
then updates the max_node_weight, the previous manual change will
be overwritten by the newly scaled values.

Does this behavior make sense? Perhaps it makes sense to ignore
user-changed values when doing the re-scaling if a user decides to
change the max_node_weight value themselves. 

Regardless of what implementation makes sense, I can re-write the
description so that there is no ambiguity when it comes to the
expected behavior of the code. Thank you for pointing this out!

> [...snip...]
> 
> > +int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
> > +{
> > +	unsigned long *old_bw, *new_bw;
> > +	unsigned long bw_val;
> > +	u8 *old_iw, *new_iw;
> > +
> > +	/*
> > +	 * Bandwidths above this limit causes rounding errors when reducing
> > +	 * weights. This value is ~16 exabytes, which is unreasonable anyways.
> > +	 */
> > +	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
> > +	if (bw_val > (U64_MAX / 10))
> > +		return -EINVAL;
> > +
> > +	new_bw = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
> > +	if (!new_bw)
> > +		return -ENOMEM;
> > +
> > +	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
> 
> I think kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL); will be more readable.

I see, thank you for your input. I will make this change in a v2.

> > @@ -2012,11 +2105,12 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
> >   
> >   	rcu_read_lock();
> >   	table = rcu_dereference(iw_table);
> > +	defaults = rcu_dereference(iw_table);
> 
> Probably you intended rcu_dereference(default_iw_table)?

Yes -- thank you for the catch. I will also make this change.

> >   static struct iw_node_attr **node_attrs;
> > +static struct kobj_attribute *max_nw_attr;
> 
> Where is max_nw_attr initialized?

Oh thank you for this catch! You are correct, max_nw_attr is never
initalized. Actually, there is a typo in which I never use
max_nw_attr, I accidentally rename a different sysfs interface
to act as the intended max_nw_attr. I will make this change as well
and post a v2. 
 
> Best,
> Hyeonggon

Thank you for your input, I will make the changes that you mentioned
regardnig readability & typos. I hope to hear from you regarding the
thoughts on the behavior of re-scaling all node weights when users
update max_node_weight, and whether that should overwrite manually
set node weights.

Have a great day!
Joshua

