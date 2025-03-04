Return-Path: <linux-acpi+bounces-11816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC6A4F01C
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3E81717B4
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 22:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02FA24EAAA;
	Tue,  4 Mar 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDZiEpVY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035702E3369;
	Tue,  4 Mar 2025 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126977; cv=none; b=e6Q1Be11dtckQuTIjM8VdRGsfdH4yALjzHCkAg3Up4l4DqftSOv50ILnQ/ZevIneOSIH04oNfX6emzS45mvSyhRarTUSCMlduPIXjmNqObRi/xxeODFcsaTM6EpoUq/uDS5bkdAp6+FSRDCiazCjIBqlRut5miJLtrU5FkOwtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126977; c=relaxed/simple;
	bh=xLQsRHJKKJbF7MCv+1vlUz+sgpip327+ecWrE/qhDbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STV/W4Mxea44f0mAi+PSmAEHoz396/sSsfWBaKtxqRJhWMtY8+8mdtRbxRTj1XYPcWf3bettn8AeNVKneCC9I8Q88S58zytB5J4s3Bds0/MsoiPTycRW9hYqXVohq+Hn8F6DqMRJTbVE6hfZr1Gq2GhYgbM7MXeD7XIyahHePek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDZiEpVY; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fd47dfe76cso46003457b3.3;
        Tue, 04 Mar 2025 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741126975; x=1741731775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/dqG0WQcNNVPDMrdPEeD/M/SnPUgM/AMQtXMXaVRVI=;
        b=ZDZiEpVYcEArcYwGgrT2JrWgS8r/7bYUlwWjbsQ5AsF2hE8c4EIBPH8OUMgvNEfcyM
         QSELRmkyaFUEcw9GuwhEjU1aJEWf4q426HxyQQg9tuhxZhEKyci7r0zbWFHh3CV2yZSb
         tCAXtmUs+aUrafcl7mn/+of+eR3xvFWyMePQACDpSVFqMSutVDAarJJ4FOwhanxBG2yG
         iyEQ1jkKWxvWnjnLPuWVHKGm5EMkRSWqX9Ql5VgVVceyJ46l0tnLL27YV2mF1MiZAwLQ
         GuDkFTAtpfROoGcU2OEwHvJfPzpaYzBdCjboBmnUKhPKzjOxuFd/J8JRVIdmyXXsgbGv
         SN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126975; x=1741731775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/dqG0WQcNNVPDMrdPEeD/M/SnPUgM/AMQtXMXaVRVI=;
        b=gblMDjmXwXXO3OUKPzLVQ36aws8uR54idNyfAIyzjoRRULRE+mmTTW1O/l1Qp+nr+e
         bbosh9DvoIWp90uOAhivNMZsgab/6tqJTBRFBXbW8pXx9RmQshWAytJcmPQy+Rkdmaw2
         e7ZuARxkgBoOokqfdujV5aBeqlnlo1RYUlcvwnlC9fq/WpO698D8vd4hFHtF4Lz+L7Wq
         WdkZI43fWwNbGyrr/7yNKFFxypGDqGMsMB8NuHRVkpKytN1+q23JczhKKXS39TdUPHMX
         uxxaNYcWsPLbDLfJnuiQd9tlb7kWOgrYumkyEzTIcLLJbJaOh+f64yLRAGVnydaA4rFt
         PDKg==
X-Forwarded-Encrypted: i=1; AJvYcCUJqotLecBJpUUAhoYSRkdUeKZfCIzBROgiHudedYFGh+JnDm6uY0UjB036kniMbr9UTKH3mAjzm1KP@vger.kernel.org, AJvYcCW7iPT16jBFZslG1Bp1cjCFYxSdwzbYl6EVFSSbV3oRbkVkNqx0WNsQXkj1b3YdZL8AGg3HxH1ECWY3+vU6@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMj6+ifqatMLNmFR/x5cI560Mx38eZgJp/4DfKF1C9LPFEkfD
	yG5ur/mXvtlgMhVQlVpTAjgJa6X4YkHM/76x66p4/+UQda6hRgvA
X-Gm-Gg: ASbGncu9ybGEaOsjmqk7VAd3QqL4K07eEfR3JY4mjzf5mW1BjJuBiQU8y3ejEEnWvl9
	IMQ/ngj1EWiR3hgYh90Qb6R1+xCPGUi1negHaQhthTEYF9A+aJrb2nWAPtFtrNDc8zD6RviYoO4
	MNG8cG8k3jAU1RKJcRurUAL2K+KfXH5NzZkwHYMZ9LAzD/0WDLFVLzJtSTOUprdFJDG+HLSRjgF
	TI0DnkB//CEc36Z/A7A5zrnMURlOEVLfiTWwfonMZasFyMTc54LbkW1RvwRPI2mHDHxP7mh7YwT
	Br9UweiCNC/35x86AwwTYbTbSRpuSYoepgVKsfsA6nxX
X-Google-Smtp-Source: AGHT+IHbOkZ4mJr426bT+N9RXY/lw+J15pEjEGFgtsk0V0Mv3ydbsN22C3hyZ3WsuaYehFxZ8wZ/7Q==
X-Received: by 2002:a05:690c:74c6:b0:6fd:a12f:2702 with SMTP id 00721157ae682-6fda3094e44mr15281367b3.25.1741126974853;
        Tue, 04 Mar 2025 14:22:54 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:7c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd6a1a1733sm16377917b3.48.2025.03.04.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:22:54 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Yunjeong Mun <yunjeong.mun@sk.com>,
	honggyu.kim@sk.com,
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
Date: Tue,  4 Mar 2025 14:22:51 -0800
Message-ID: <20250304222252.3805581-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250304215612.3668139-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yunjeong, sorry for the noise, but I have discovered another potential
concern that your patch introduces, which I have explained below. 

On Tue,  4 Mar 2025 13:56:11 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Fri, 28 Feb 2025 15:39:55 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> Hi Yunjeong,
> 
> While applying your patch, I realized that it re-introduces a build error
> that was fixed in v6, which I am noting below. 
> 
> > Hi, Joshua. 
> 
> [...snip...]
>  
> > In my understanding, new_iw[nid] values are scaled twice, first to 100 and then to a 
> > weightines value of 32. I think this scaling can be done just once, directly 
> > to weightness value as follows:
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 50cbb7c047fa..65a7e2baf161 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -176,47 +176,22 @@ static u8 get_il_weight(int node)
> >  static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
> >  {
> > 	u64 sum_bw = 0;
> > -	unsigned int cast_sum_bw, sum_iw = 0;
> > -	unsigned int scaling_factor = 1, iw_gcd = 1;
> > +	unsigned int scaling_factor = 1, iw_gcd = 0;
> > 	int nid;
> > 
> > 	/* Recalculate the bandwidth distribution given the new info */
> > 	for_each_node_state(nid, N_MEMORY)
> > 		sum_bw += bw[nid];
> > 
> > -       for (nid = 0; nid < nr_node_ids; nid++) {
> >  			[...snip...]
			^^^^^^^^^^^^
When I was originally writing the response, I missed reviewing the contents
inside this snipped section, which looks like this:
		if (!node_state(nid, N_MEMORY)) {
			new_iw[nid] = 1;
			continue;
		}
I introduced this check in v6 because without this, we end up with the
possibility of memoryless nodes having a 0 in the table, which can lead to some
problems down the line (e.g. div by 0 in alloc_pages_bulk_weighted_interleave).

Respectfully, I would prefer to write my own version that takes your
suggestion, as opposed to applying this patch directly on top of mine so that
we do not introduce the build error or the potential div0. However, v7 will
include your suggestion, so it will go through only one loop as opposed to two.

Thank you for your feedback again. I hope you have a great day!
Joshua

> > -		/*
> > -		 * Try not to perform 64-bit division.
> > -		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
> > -		 * If sum_bw > scaling_factor, then bw[nid] is less than
> > -		 * 1% of the total bandwidth. Round up to 1%.
> > -		 */
> >  			[...snip...]
> 
> We cannot remove this part here, since this is what allows us to divide
> in the next for loop below. sum_bw is a u64, so performing division
> by this value will create a build error for 32-bit machines. I've gone and
> re-added this comment and parts to the bottom part; the logic should not
> change at all from the patch that you proposed (except for the build error).

[...snip...]

Sent using hkml (https://github.com/sjp38/hackermail)


