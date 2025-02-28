Return-Path: <linux-acpi+bounces-11628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25B4A49EB7
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A6A189ACA5
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67127293D;
	Fri, 28 Feb 2025 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE69j4AC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A272702C1;
	Fri, 28 Feb 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759893; cv=none; b=bOmLgQNmmfwHc61BhsgoixACs3yvWjS1EetwXfPRzwM/Udmcmoo7eMXM4BqEUZcS/sm80Fy2RJ9ewz/oBxoZjUi7+jAuqkGTc/QoKTbrkOmcDmUZ7VOqiWlMzeBaKy/PkPbHczOg1iIJ5vgNs+nq2ch5QvLMX68TAFmJPpwAtrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759893; c=relaxed/simple;
	bh=XnpZcUYfTLbgC6takHMxyC3KsGytUw76O4Bb/3klw4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+YCqfcQobxyOer0AR6UjReczs5FJR4cex0FJFVERuBY1gGuSdkoBXY3hOEWWn49t4FzIO/rUMkBBwihb7Zy4cff6upMJeDLvvE1De6OTwWT6p5BdKrBj2Em0SxGmjkeZhz+8coapJAbxMyckwIdjQ2HqqSSX4cCc6LCRix+tVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE69j4AC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f768e9be1aso33320567b3.0;
        Fri, 28 Feb 2025 08:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759891; x=1741364691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3ewd6MOD055VnfUmlVAPlmkIaMimMwbkJLyr3SEzLo=;
        b=DE69j4ACDJOluNm/FbZsnx7aTGaEYoGDYBlmEe8xJECxVjSa+Oc1hEvXC6X+kpZ7zB
         J6d8zwMsGmPuBGxin34jHmVnpPBLECU6Zt4rpmr82QwJahQ6CJsXDXL26LJP02xdE+xW
         egEbn6hR1roQPTlPmKsSlp3JWBn3YHUw/V16j/0uZkvIqsK1GbGcGA0xGJAoM4+rjtlc
         HJsK2mFOB8ajBnjGrIwMBl9DyWutsuNXQfmGvkengiL5HKIXDVBrZumSIPTgGSiG1Gc8
         gJ1BGxyq3VOlDizlW8UgfzavCn6E4wHrNkj98LxdCl5NAakbAfSYPtzl3rLimXW02+pA
         vbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759891; x=1741364691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3ewd6MOD055VnfUmlVAPlmkIaMimMwbkJLyr3SEzLo=;
        b=UhgcdHuWFjhiuQVPkfnzyq7qkzW4tk3O5+/cex86XkS3Ym+yuoL4GqYbct6qOPyHxA
         GLyMtx92BuftkXzAV87mLF62f40KSvB44jGdc32ZXSJmA3hia7smVlbHdSglPbYA5232
         WJqOynX8wiJ/t4uqtWCGQVCCNg91qNGJccywerfBRv1W710xT48+o1uDCwm1P7jw+r3E
         oIGdOQi00pfHOcryQ/lByUsNvwfrx+JYuf94KAexRmuU6qC9mfE3eNO/KmrHC7+1Y74m
         OITV01ZZVrgPIfyw7mlSZrV/wiTsRikw3GAIdVun9KLSLFsTisamQzgKakEKX7WfC9Cl
         +L1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV70E8oON5G70kR2vuwfw85QXM3Ht4A+lz3DFgqZOemJvaLDl1ZWH+2hGRvMemVXy/4C4jAwK4R8T5V@vger.kernel.org, AJvYcCVc2CIb2R9V9ylsGbNUWJvrqs2pcuhKbKSi16lXZGkTu+dyChkW7hYs6cpR6GnCDq0wxF6Vqbb3ts0cCh46@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsdKXam801bWlrQeKUUH0paJRgyQWChccCHcIgxTKvuQv0/8Y
	gs7wHhZBDOfHLlReZiFb6x26jkmSVoSjiWYo1JdK69CDP1XzzX0D
X-Gm-Gg: ASbGnctRMFm+sTlRJik69jiWsAvCngjehBAbKMNrok+OH/K5i1qAtqlfGeGA6uF0UCk
	7+GkuVlxafHTZ7iZgCrX25SilGPGBW1n4fESPx1cEw/+FvXPydpzARI8ZwT5HUQidV/r1YbZc9X
	beyvRjfQjNqg/Bp127vCqQLXZh/3nGmSzDpxavI69da9i+BWvWD6xD1baunWsx7ydv506196ozw
	aW3bVFDEGmCdABS/Lsh5cgfO+6WCC91tuE4kwBx1D1qTHS44Nq1bJRTEaO35QkrQCfMMzkyW5kw
	0w18dRx8uLOCwWSqG6mdcbRr
X-Google-Smtp-Source: AGHT+IEAM2QLaq1/TAY7na+Pdysw6rSoHZH4Mr0frspMuY5OQC0gIjx7djT9cTfNwuR3W8ueknFuuw==
X-Received: by 2002:a05:690c:4b86:b0:6fb:b38e:207e with SMTP id 00721157ae682-6fd4a23912dmr45573817b3.14.1740759890583;
        Fri, 28 Feb 2025 08:24:50 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca100b3sm7900267b3.13.2025.02.28.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:24:50 -0800 (PST)
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
Date: Fri, 28 Feb 2025 08:24:45 -0800
Message-ID: <20250228162447.3850305-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250228064016.1325-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Feb 2025 15:39:55 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

Hi Yunjeong, thank you for taking time to review my work!

> Hi, Joshua. 
> 
> First of all I accidentally sent the wrong email a few hours ago.
> Please disregard it. Sorry for the confusion.

No worries at all!

> On Wed, 26 Feb 2025 13:35:17 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> [...snip...]
> >  
> > +/*
> > + * Convert bandwidth values into weighted interleave weights.
> > + * Call with iw_table_lock.
> > + */
> > +static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
> > +{
> > +	u64 sum_bw = 0;
> > +	unsigned int cast_sum_bw, sum_iw = 0;
> > +	unsigned int scaling_factor = 1, iw_gcd = 1;
> > +	int nid;
> > +
> > +	/* Recalculate the bandwidth distribution given the new info */
> > +	for_each_node_state(nid, N_MEMORY)
> > +		sum_bw += bw[nid];
> > +
> > +	for (nid = 0; nid < nr_node_ids; nid++) {
> > +		/* Set memoryless nodes' weights to 1 to prevent div/0 later */
> > +		if (!node_state(nid, N_MEMORY)) {
> > +			new_iw[nid] = 1;
> > +			continue;
> > +		}
> > +
> > +		scaling_factor = 100 * bw[nid];
> > +
> > +		/*
> > +		 * Try not to perform 64-bit division.
> > +		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
> > +		 * If sum_bw > scaling_factor, then bw[nid] is less than
> > +		 * 1% of the total bandwidth. Round up to 1%.
> > +		 */
> > +		if (bw[nid] && sum_bw < scaling_factor) {
> > +			cast_sum_bw = (unsigned int)sum_bw;
> > +			new_iw[nid] = scaling_factor / cast_sum_bw;
> > +		} else {
> > +			new_iw[nid] = 1;
> > +		}
> > +		sum_iw += new_iw[nid];
> > +	}
> > +
> > +	/*
> > +	 * Scale each node's share of the total bandwidth from percentages
> > +	 * to whole numbers in the range [1, weightiness]
> > +	 */
> > +	for_each_node_state(nid, N_MEMORY) {
> > +		scaling_factor = weightiness * new_iw[nid];
> > +		new_iw[nid] = max(scaling_factor / sum_iw, 1);
> > +		if (nid == 0)
> > +			iw_gcd = new_iw[0];
> > +		iw_gcd = gcd(iw_gcd, new_iw[nid]);
> > +	}
> > +
> > +	/* 1:2 is strictly better than 16:32. Reduce by the weights' GCD. */
> > +	for_each_node_state(nid, N_MEMORY)
> > +		new_iw[nid] /= iw_gcd;
> > +}
> 
> In my understanding, new_iw[nid] values are scaled twice, first to 100 and then to a 
> weightines value of 32. I think this scaling can be done just once, directly 
> to weightness value as follows:

Yes,  you are correct. I want to provide a bit of context on how this
patch has changed over time: In the first few iterations of this patch, 
"weightiness" was actually exposed as a sysfs interface that users could
change to change how much they scaled for high numbers (better weight
accuracy, but worse page allocation distributon fairness) and small numbers
(bigger errors, but better local fairness).

The reason why this matters is that we use a heuristic of "round all
weights whose weights are less than 1% of the total weight sum to 1%".
So if we have bandwidth ratios of 100 : 1000 : 3000 : 4000 : 6000,
we have a sum total of 14100. Then 100/14100 is only ~0.7%, and we would
want to round it up to 1% before moving on (since weights that are too
small don't end up helping). This problem only gets worse for machines
with more nodes, and it becomes possible for a node to have something like
0.1% of the total bandwidth.

When users could set weightiness to be up to 255, this was problematic,
becuase scenarios where weights become 1:255:255:255:255... become possible,
where we allocate a single page from one node, then allocate 255 pages from
the remaining nr_node_ids - 1 nodes (which is of course, not ideal).
However, with weightiness fixed to 32, maybe this heuristic makes less sense,
since the worst-case-scenario looks like 1:32:32:32:32...

I think this proposed change makes a lot of sense. It does seem silly to
have to round twice, and without giving the users the ability to set thier
own weightiness value, rounding just once seems to be enough to prevent
the worst case scenario. I will incorporate this into a v7.

I'm also going to wait a bit for more feedback to come in for this version,
so it may be a little bit before I send v7 out : -)

Thanks again for your review and the proposed change. Have a great day!
Joshua

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 50cbb7c047fa..65a7e2baf161 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -176,47 +176,22 @@ static u8 get_il_weight(int node)
>  static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
>  {
> 	u64 sum_bw = 0;
> -	unsigned int cast_sum_bw, sum_iw = 0;
> -	unsigned int scaling_factor = 1, iw_gcd = 1;
> +	unsigned int scaling_factor = 1, iw_gcd = 0;
> 	int nid;
> 
> 	/* Recalculate the bandwidth distribution given the new info */
> 	for_each_node_state(nid, N_MEMORY)
> 		sum_bw += bw[nid];
> 
> -       for (nid = 0; nid < nr_node_ids; nid++) {
>  			[...snip...]
> -		/*
> -		 * Try not to perform 64-bit division.
> -		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
> -		 * If sum_bw > scaling_factor, then bw[nid] is less than
> -		 * 1% of the total bandwidth. Round up to 1%.
> -		 */
>  			[...snip...]
> -		sum_iw += new_iw[nid];
> -	}
> -
>      
> 	/*
> 	 * Scale each node's share of the total bandwidth from percentages
> 	 * to whole numbers in the range [1, weightiness]
> 	 */
> 	for_each_node_state(nid, N_MEMORY) {
> -		scaling_factor = weightiness * new_iw[nid];
> -		new_iw[nid] = max(scaling_factor / sum_iw, 1);
> -		if (nid == 0)
> -			iw_gcd = new_iw[0];
> +		scaling_factor = weightiness * bw[nid];
> +		new_iw[nid] = max(scaling_factor / sum_bw, 1);
> +		if (!iw_gcd)
> +			iw_gcd = new_iw[nid];
> 		iw_gcd = gcd(iw_gcd, new_iw[nid]);
> 	}
> 
> Please let me know how you think about this.
> 
> Best regards,
> Yunjeong

Sent using hkml (https://github.com/sjp38/hackermail)

