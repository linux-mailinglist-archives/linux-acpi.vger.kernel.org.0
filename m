Return-Path: <linux-acpi+bounces-11839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E7CA504F6
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C549F189986F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8859324E013;
	Wed,  5 Mar 2025 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEuqVQwS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60018CBE8;
	Wed,  5 Mar 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192117; cv=none; b=NlnHtDhHM095/9ZkGFDOi5LgpMTsO2JfpxAFRoszsaY5rHqhDctA/nwePc2vE/Lyf/EQb7vp+4IOT738Tp69tKoxPA17oNgZ6dMvTRKJpLVICcgcpIGpDGkft2O78cFeYELe9NgLt9czHfoIVS50g2BtBR3fd28i4s8KHlO86jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192117; c=relaxed/simple;
	bh=wMKn+PYDV6Ww/wN9tNFxfpwWpPdNOTDLOCM4D4iq2Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZWIdQjZHNPzGuercnmxabPTx9kzDDqq9LfLSi/9UCFwAIPuCUa0DRHDzpNWKxpDeiu8sAvH0H7bBKuqa/NViZW3zuf0C3/sDcn4+QuCvrF+VIuOEEY+XUilqZTp+Fj0G2YIOlRNyZGp7LWbrMSDK5A++u+YzU9lwO29mxG2+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEuqVQwS; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8efefec89so4196166d6.3;
        Wed, 05 Mar 2025 08:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741192113; x=1741796913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kXO6L+kuZ25c+P5TosdrwsFHxjeYxKmuRYQ7Ze4zvU=;
        b=bEuqVQwSocZRhMIx2ScSjbgdch9EMJblAt0CbKZCtYNp7FTn0t8UVZbsbQv3nhHUMT
         YKzqSVRpYwS1mPaCDB1F/Tcg1kIzTAYAQqG34TEgfnDxe/crHo0QQjKMoI349P0Dtu3I
         tHkAJFFtqotrrNcGpoR696HLBlJtR7nbMk21IhFZBc2rPM81nFZKDdakpUUHBuVevLLI
         hPpTh78kl7MIv90qxvjwf/xoX1zfjyvpcB0OMkJ2qd+BCekgJVNr+rmzmMzy5yALdVO9
         JuekG5ueyLPQeKUCN69kbv+L515xH5ATmn747T2PoA2rkIWjhOzdvwarD3JH/vn73TdW
         3vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192113; x=1741796913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kXO6L+kuZ25c+P5TosdrwsFHxjeYxKmuRYQ7Ze4zvU=;
        b=qMbbuvJ/Ct8Blg67KouALLvMfQV+OK1pEbgd1OgLFtQAYX4A9Yt/MACDb6M8T7/tk4
         lB8P9EkXie8J/ahmCyA1etvbZwZK2yfVPItSQdrZtCc8q6BD1yIt4qS/EOXL3aoX/Tf/
         vuAAXinrv2r1m1PX0SFAYL0Q62XtB4n/OkVrARidORjn6RvCb0lWclIb6J4uXTet7+24
         2mdlsq8mBDNiZDMMD802jZ6qRYBy1UUCpk7u2ZIa98Ie+4OjCcPRvTzNqFOjdWmpXMMj
         QXDe3oiAr4mLjktcnM5s3a5qqBuZvOVq7oSUnxYpgzW00xdLEjD4HTciWVkXW2N1kaYP
         R12w==
X-Forwarded-Encrypted: i=1; AJvYcCVT8pt9DM1nVthOUUbTdav15bx/WrP2mZcu2pNKsPiZO0Gx/95LjMoroRaqGf6Elsmv1kZvIyCcBzl9@vger.kernel.org, AJvYcCWunMHzj3wIm2zyf7Ro8mem40ZTemGrxwTP8Vpm9xkLsRwp24tgRUPklhP1lBzBhXzBN0WbVyoJass/nOzo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HcDN65jjmbMyOGA451vo3pyVGR1UB8s1S5+1X5H9NnOvaxQv
	SezWrGX00LM9qzd7KT0gadpT9j1hvDbcOsK2nSHqqkpq5DkDNi/D
X-Gm-Gg: ASbGnctM5r2SmmlhXyvTNw57QA8LKcxQ6TyugfhcEDus1NbIzBJ0SW3mXuzJp2ISamp
	+cN6Zdz2YBINNM7yRrQxc8N9UgeYTVxHkUAY1E/qf9BFP/9YFAbCVifnR6O+cgU2DQ72HEmaIQV
	+tLKaSAJfHMoBUZv+r7YhmuFXpR+Db4Ay4K7/wSlc8L0Z3eVofBcHbP/Dy3F1TUk6zorOjEX0iP
	E5Sycvc0NB2HKFWUz2e8/oSvj0kVSMszHE68nSWsXYxyuGZI7/4dgd8e6uBtyFpwk6WzMFzwHFN
	5n33x6OHeE4cbkS9kMDxPFRRCG09Pey+/KSTt388Tj7Nd5KUjiMzRkPpIT+4I+yqBqS9M14Kquz
	/+w==
X-Google-Smtp-Source: AGHT+IGITUNzs6gnChE+1sYvZx5Pu2AD6l1jML7iarWBxHik8iHbPlfbOGKzFOMTbsg6z5D70bG5tg==
X-Received: by 2002:a05:6214:e87:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6e8e6ccf943mr61318836d6.10.1741192113561;
        Wed, 05 Mar 2025 08:28:33 -0800 (PST)
Received: from joshuahahn-mbp.thefacebook.com ([2620:10d:c091:500::7:2424])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474febab252sm24470141cf.3.2025.03.05.08.28.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Mar 2025 08:28:32 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: honggyu.kim@sk.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	akpm@linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	kernel_team@skhynix.com
Subject: Re: [PATCH 1/2 v6] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Wed,  5 Mar 2025 11:28:29 -0500
Message-Id: <20250305162829.86650-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250305094918.968-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yunjeong,

On Wed,  5 Mar 2025 18:49:11 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> Hi Joshua, thanks for reviewing my patch and for your kind explanation.

[...snip...]

> > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > index 50cbb7c047fa..65a7e2baf161 100644
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -176,47 +176,22 @@ static u8 get_il_weight(int node)
> > > >  static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
> > > >  {
> > > > 	u64 sum_bw = 0;
> > > > -	unsigned int cast_sum_bw, sum_iw = 0;
> > > > -	unsigned int scaling_factor = 1, iw_gcd = 1;
> > > > +	unsigned int scaling_factor = 1, iw_gcd = 0;
> > > > 	int nid;
> > > > 
> > > > 	/* Recalculate the bandwidth distribution given the new info */
> > > > 	for_each_node_state(nid, N_MEMORY)
> > > > 		sum_bw += bw[nid];
> > > > 
> > > > -       for (nid = 0; nid < nr_node_ids; nid++) {
> > > >  			[...snip...]
> > 			^^^^^^^^^^^^
> > When I was originally writing the response, I missed reviewing the contents
> > inside this snipped section, which looks like this:
> > 		if (!node_state(nid, N_MEMORY)) {
> > 			new_iw[nid] = 1;
> > 			continue;
> > 		}
> > I introduced this check in v6 because without this, we end up with the
> > possibility of memoryless nodes having a 0 in the table, which can lead to some
> > problems down the line (e.g. div by 0 in alloc_pages_bulk_weighted_interleave).
> 
> To prevent division by 0 errors, how about setting new_iw to 1 when it is first 
> created, instead of setting it in the reduce function?

I think this makes sense. The original motivation for including it in
reduce_interleave_weights is because this function is usually called on newly
allocated tables, so I thought I would just combine the functionality of
initializing the table and reducing weights into one function. Howver, I now
see that there are actually a few spots when either a table is initialized
but this function isn't called, or when an already-initialized table is
given to this function.

The other rationale was that it seems a bit silly to go through and set all
weights to 1, and then immediately overwrite them with the reduced interleave
weights. With that said, none of this code is in any critical section, I'm
sure that going through one more iteration and setting the weights to 1 is
not unreasonable. 

[...snip...]

> > 
> > Respectfully, I would prefer to write my own version that takes your
> > suggestion, as opposed to applying this patch directly on top of mine so that
> > we do not introduce the build error or the potential div0. However, v7 will
> > include your suggestion, so it will go through only one loop as opposed to two.
> 
> Thanks for considering my suggestion. I look forward to the v7.
> 
> Best regards,
> Yunjeong

Thank you again for your suggestions, Yunjeong! I'll re-write the code
to incorporate them in v7. I hope you have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)

