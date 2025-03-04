Return-Path: <linux-acpi+bounces-11815-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0BA4EF9E
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 22:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC8616F2F2
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2F2255250;
	Tue,  4 Mar 2025 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3tAP7/z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCF1DB125;
	Tue,  4 Mar 2025 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125377; cv=none; b=A+zMhvHz8ey2xJ9GYDr7BvvijraHSqyZ3qDL284BS7V611TQfjzG/05V8nx/RFPml9TFCg1y6y8PmLp6y/4vBv/v6Ls2wHVWPgpiyLb6UGcVV20KtHaJtYiud+ODrWekGimLqRqAoc5swWEqP6rYyF39AbBeFzHjIY5CymkwYyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125377; c=relaxed/simple;
	bh=GIHoQb4e/wM6yzc/MFg2nRMdug/Wq/hFUNR67QGnCQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYvmBfd+m16xNuZmhQVH/GTl5DecwLk8PgdshttMSWlLInUI8fwdhTqQ3n0d1XKjSI1TIsjlaRGUwEqqvXSaCk9CitOXsVYJRAFJdfthewMKmJD3D+YiXC27TwMjd5I3e2A1ZX/yeNb6fFHJAwV9VWvRRzKlBI2laPTDH8P3xAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3tAP7/z; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fd80f30ba5so21128827b3.3;
        Tue, 04 Mar 2025 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741125374; x=1741730174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqo7WHkn5qvaYp/5nGnkilk7ahoFs2Qeg8hSvE1kPD0=;
        b=e3tAP7/zof4+BnlFfg3ap374f48YIc1FuLXPOyplJG4jHnY576VMgQZF9dpYfmuR6A
         KveFQhPpglcSSOwNr92JD7GWx9wEmD2Qfcyb2Rz4PMDJe2rgkw5aPYu9K2Y05wHFGNcs
         PYBG5HT2mFI2VPnbnaXpqEUFdWxheO/7lqDrxeGISvOOTJCBnUld18UGc84B6zeJ2jnm
         Y+AKFWHA1qYP6rJSimOGrUvhESVvqNw+yYH1NmSLOrcQgPk81r3LvKy+HPj33689qTjI
         aQfjSuFWspplyMCpyqs4zLqofVAsio5oM23NDvmry5CDtbTSPQFN2iAuS0PRu6SUNJ25
         brKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741125374; x=1741730174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqo7WHkn5qvaYp/5nGnkilk7ahoFs2Qeg8hSvE1kPD0=;
        b=aVyPUYRp4DyOsc9cpDuUHaaFr0s6mnWyhBfgKI+FwrDq4YYtsqXKemT9wwK0LLHTJg
         7IHBy2tAV8QL9+u1wL74zmqTl/XgWAIFo21v3bAm/2FO15EBv4/5jYioyv0P+mV2kCes
         LhgjPJ5b549MCmJufqHdfxPJd4ILrbRTOerH0PYMLDf/K2thGLTNKQktCFisxtXzitiD
         3WOF3uO6+rnSgCyDnxf3/tWKBWireRMtviVCbFxjyI9YcXfOvzdsRIT3J+7f6SX/a5B8
         RgT0gsDrp/JR1AEA3QWw2j/WaMvoXI5sN98TFTX9Gn7JzLKe/i/Lx2YO5/0O/ObvgfQT
         cWeA==
X-Forwarded-Encrypted: i=1; AJvYcCU7lQ8x5W425c0KDIpf6ZLyAM+EFrVA2hhutFzh8ZSaA21s5/kF2wICvNWIV88J1xOnqrybtnRNn9ZnN/Gk@vger.kernel.org, AJvYcCWP9/gE/MfZnLwicmjPRuDbdYyvoo9zP05cgv7qwXS3LFmQy5KDDT9NK0ntBPPyL4/VGk0x0b0z1/cQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73iG9t+xiezWMM557nc2eNHmHsApbqeYzfqw8H07Hmh+siHXP
	r655kneNJwyhofTzaueF4f+DJXfS0rEiBhryLH8DSAPscW1dYf2Z
X-Gm-Gg: ASbGncsN5dGfiXD+JDhf0HkjxIloOAv+ESVNE4FM24CigmhTCvX3qt3kJvBxrXWxO9P
	TTO+lDyE3yqzwbhpxhV6MmvrScgzTGe3LZv1hEcVLjkPeG8HTV3ZbWqnotnnaTxk6yOdO2gZGWd
	NPT37jEGtKc4VSW6TQw6O9hyWeTaCBU7Zf8skwJvMWzLmdJN+lEQ362D5axsRioezdeHc9adiRk
	J4vyxGCwAHpsagiqW0JHFa/qe4UcpG1x2o3TxUfQ9vmt3dXiqgFdiQBV7cpJd3BFILt87+zg1Kx
	ZyFAPH6TMIXcV/S1uvEWh8nbFCnnOA8l5F4ijoWgWO95
X-Google-Smtp-Source: AGHT+IEeQJYGRrqQ8QbpBdsu5obZ4Hbxp5jaq8xeATA4YQ1k2g9OwZJ0dBmJqIK2m8RXqeZxpkHz3g==
X-Received: by 2002:a05:690c:6913:b0:6fb:968b:d8f5 with SMTP id 00721157ae682-6fda308309dmr14791647b3.36.1741125374446;
        Tue, 04 Mar 2025 13:56:14 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb9dac4sm26341017b3.102.2025.03.04.13.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:56:13 -0800 (PST)
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
Date: Tue,  4 Mar 2025 13:56:11 -0800
Message-ID: <20250304215612.3668139-1-joshua.hahnjy@gmail.com>
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

Hi Yunjeong,

While applying your patch, I realized that it re-introduces a build error
that was fixed in v6, which I am noting below. 

> Hi, Joshua. 

[...snip...]
 
> In my understanding, new_iw[nid] values are scaled twice, first to 100 and then to a 
> weightines value of 32. I think this scaling can be done just once, directly 
> to weightness value as follows:
> 
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

We cannot remove this part here, since this is what allows us to divide
in the next for loop below. sum_bw is a u64, so performing division
by this value will create a build error for 32-bit machines. I've gone and
re-added this comment and parts to the bottom part; the logic should not
change at all from the patch that you proposed (except for the build error).

It's not a big deal, but I just wanted to note that this patch was not applied
in its entirety in the v7 of my patch, in case you look at v7 and see
that the code looks different from your branch.

Honggyu also suggested that I add a Co-developed-by tag, which I am happy
to do. However, this requires a subsequent Signed-off-by tag as well, as
per the kerneldoc on patches [1]. I just wanted to have your explicit
signed-off-by so that I could add it to the patch.

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
						 ^^^^^^^^
						This causes a build error for
						32 bit machines

[...snip...]

> Please let me know how you think about this.
> 
> Best regards,
> Yunjeong

Thanks again Yunjeong, I hope you have a great day!
Joshua

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Sent using hkml (https://github.com/sjp38/hackermail)


