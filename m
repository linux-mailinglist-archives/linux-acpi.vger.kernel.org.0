Return-Path: <linux-acpi+bounces-10778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47406A185DF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 20:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F74188A356
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 19:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A891F667C;
	Tue, 21 Jan 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eWIMbBaJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E41F4E50
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jan 2025 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489400; cv=none; b=uHOzo7NM7J8XrwH2ei0HaCqjyEKb96xf/JnGlHlCELmHriqqt4NUh+xiycOnSjewKNpjY8vd/cxWMeS1aSaYX4yhh1BxkFbg9+4M8cDhdEDXcxFKyY8NZvvK4hk+ybD6oXeR8fCREiQmBA7Lh920tJFrKYkwTMgEtWLhc4ytOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489400; c=relaxed/simple;
	bh=xkGydKeHiXMg0lmcYrqAr1I+0Ezkf+S30iuzkAUM5uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjkHreS8zc1Odl4sjGDVOxxi7JqYT3aF74Ym/Hd8qGBdx465BWB/1YNbmyiqy9SmrEMuvfmphoGLENHgxxkbxGY0izAuqPCiwQcjqzHBWt20hWaEh7/FZ8U3pLYkYkFlMpsojimeYPBzDilTnHvtt/GaSS1cz6J03NOdRwp4NJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eWIMbBaJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467838e75ffso77966101cf.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jan 2025 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1737489398; x=1738094198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WR0HzuP6V9ULwrxabg1I8UGOHmz7cdJQdGJq1+4Lkgc=;
        b=eWIMbBaJG5qiP5RYSibht7A9JmR5LQOpm52UaSangcrnsph8Zjl5j+jQi1n+dHxNmj
         FFckRmOEIp5jopBqZNvlTEuEj6Cd1sdKeGE9VzbpEVh67HQU5ZT3WQrTJkZjvdBaXgkQ
         SE91/J/1ome90RJW1RDMI0ye9XGmPQmsFfCZPMC315u03SgS95XRYxOynq0jEwbHWw27
         jghEbNOnVAT6pl3cIn/9nmnLpY8EKwqOyx5Xc74lbehrZ+9YwVULf7fTCNA82iJOduIg
         +nYRleDJ6fLdf7HxDp1MgzW0TmRgfTZSbAIqchjSX4k1iju2fwRQKKO9lasfyDRbDpZE
         xS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737489398; x=1738094198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR0HzuP6V9ULwrxabg1I8UGOHmz7cdJQdGJq1+4Lkgc=;
        b=GuCB15QoNio15b2iodW5ce1UOmshRfE32vrVZyzny2IX4tb67/griH0PTXXPbY/nfm
         cElShippdsy1o4/t8QNbN8rq3F0uOZiCaj3npndvjsTJL4pfJglhM6yVeDT2zeJ5e32p
         k+6Kttfv6ftYGYPP2/DNQ5YmIWxQOAj0OJj04GdNdGy92vif7yudbqCk9L5LW3ZOKdmg
         GzVa9Df6l/Zn6XVyYDMuNO1BM8tGNeqWSXcQUmJjpaW3m7l0pNBnUBxxZ/pNmFMOFgKU
         jI7ub1U4jciSsMv+3irGKaP7qtcqWZ4qDxhqwHfeKZ2gG5smYZZ7KZ6GavBRz++zDg39
         uBVw==
X-Forwarded-Encrypted: i=1; AJvYcCWFNY4jB+D1oEJfR8dTscaCQynto5+xVZXAIf79xPMZfmcYyKNGpbo0TyE9/ug5udLmqKo7+Ur6JALl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/uGjm7VQastD5P2yjBNP+UBN7/lwJ+HEL9WEouMGe2JoUPjB
	n59e5vysWHJuZLXkK0IgNyYuyfuzvUrMBWm89yQWdQxRfbkS5VgBhQqFyObEJA8=
X-Gm-Gg: ASbGncup6by1nMdn489eu00hd3P4kO5HrfszIjqveQ7gC5F1O+GH6YsHd0zT29EKBXO
	TXN6mC1ArPswGHtw3MAp7+/zQdXTswQKlw1gU5PMLHbBwek5navvrsUXN1MGq1F+aQmDdk8eLsX
	yW/aIl4pZX68C0IOIIHIgYBaS1sPAJqUzRamsVE3N7d4fo0SEikPyBcMM+Aa12F7pk1N8cIOh6R
	UQJ3g/rhyudUmH8LDIvpXSlUugqw/0ajAuwwQBq5n/vnnaV8V5YWIZfv5cJlgg8kfhfLm0BvsPM
	xXlMYKksmbkgDlD5HtsgtK1nzFsg2lZkK2WTo5q21r9hjQp0L9Bj
X-Google-Smtp-Source: AGHT+IEUBGtZeB0zPoK0184ForbdgGgUBRzk3gAp6IIGzLheJqxSlIo2Ba9hgZ9GxGBUK2gc5ulJcA==
X-Received: by 2002:ac8:5794:0:b0:466:8cc1:6221 with SMTP id d75a77b69052e-46e12bc6108mr319448961cf.50.1737489397892;
        Tue, 21 Jan 2025 11:56:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd59d6sm53752286d6.87.2025.01.21.11.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:56:37 -0800 (PST)
Date: Tue, 21 Jan 2025 14:56:35 -0500
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hyeonggon.yoo@sk.com,
	rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Message-ID: <Z4_782yoMKqIOfW5@gourry-fedora-PF4VCD3F>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
 <87ikq8h0w4.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikq8h0w4.fsf@DESKTOP-5N7EMDA>

On Tue, Jan 21, 2025 at 07:17:15PM +0800, Huang, Ying wrote:
... snip ...
> 
> Unless it's possible we will add more modes in the future, this is kind
> of overkill for me.  How about something simpler as below?
> 
> $ cat auto
> true
> $ echo 0 > auto
> $ cat auto
> false

We have discussed having a dynamic-mode where the weights might adjust
on the fly based on system-state, but i think this ends up being
controlled under mempolicy/dynamic_interleave or something.

So this seems reasonable.

> >  static u8 __rcu *iw_table;
> >  static DEFINE_MUTEX(iw_table_lock);
> > +static const int weightiness = 32;
> > +static bool weighted_interleave_auto = true;
> 
> I still prefer to use 2 iw_table, one is for default, the other is for
> manual.  The default one will be used if the manual one is NULL.  Both
> are protected by RCU.  The default one can be updated upon hotplug
> blindly.  This makes the whole model easier to be understood IMHO.
> 
> What do you think about that.
> 

only question is, lets say you have

`cat auto node0 node1` -> `true 5 1`
and you do
echo 0 > auto

what should a subsequent `cat auto node0 node1` output?

`false 5 1`
or
`false 1 1`

Then lets say we do
echo 7 > node0

what should
echo true > auto
result in?

`true 5 1`
or
`true 7 1`

The current code makes sure that when you switch modes from auto
to manual, it inherits the current state - instead of there being
some hidden state that suddenly takes precedence.

So I prefer to just have one IW array and no hidden state.

~Gregory

