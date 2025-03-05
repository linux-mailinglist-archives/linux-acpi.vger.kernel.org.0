Return-Path: <linux-acpi+bounces-11827-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F33A4FA94
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 10:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E343A6639
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28F204873;
	Wed,  5 Mar 2025 09:49:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818F21FDA89;
	Wed,  5 Mar 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168169; cv=none; b=d1+DilOfpqb/e64oyDr14WIND4N/h37CZpKiGbHgFamTIIRMLXO+Da/vM2NvJXL3buupxrKj10a6ezu6rPgD/WpxRsDbJ9QSvQX+uP03ZqGetDgkhwpxXZ3NtUAbCOqxCOuL0xBmGLw78OIUbpmLPsbNWveIYiGvcp1EoyybduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168169; c=relaxed/simple;
	bh=Ymdcw4KQcFPIRedKH+oPy1rkKOVqH6QgEneB1FD+r9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijCt3gIuwsChOrS8TLoQMXQHU5OB73S/hoST3QW0+9J4A0HIyVqD4kgGcC71HmhgqSv8Oxeub2YsC+WgwxZMSNmdUSdNBM0xZhGkGtP2SZCyp41qv0vlAbrVZ+G6XqE68fGjY/6XPJ+KpfE7zo8XESkBQ30zlLIumJUQAyVOBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-66-67c81e2012fe
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
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
Date: Wed,  5 Mar 2025 18:49:11 +0900
Message-ID: <20250305094918.968-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250304222252.3805581-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsXC9ZZnoa6C3Il0g79L1C3mrF/DZjF96gVG
	ixM3G9ksmhevZ7NYvcnX4nb/OVaLVQuvsVkc3zqP3WLfRaCynQ/fslks39fPaHF51xw2i3tr
	/rNazP0yldmBz+Pwm/fMHjtn3WX3aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweCxumMnvs
	n7uG3ePcxQqPz5vkArijuGxSUnMyy1KL9O0SuDJ27HrKUnBPumLf3uesDYwLRbsYOTkkBEwk
	NkyewtrFyAFm33/BCBJmE9CQOHjoJDOILSKgKXGidRKQzcXBLDCdWaLxwUZWkISwgKdE25GV
	jCC9LAKqEkfuiYCEeQXMJJ437GaFGK8p0XDpHhOIzSlgL7H+zAQWEFtIgEfi1Yb9jBD1ghIn
	Zz4BizMLyEs0b50NtktCoJ9dYvfFHcwQgyQlDq64wTKBkX8Wkp5ZSHoWMDKtYhTKzCvLTczM
	MdHLqMzLrNBLzs/dxAiMlWW1f6J3MH66EHyIUYCDUYmHN+DnsXQh1sSy4srcQ4wSHMxKIryv
	Tx1PF+JNSaysSi3Kjy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDY6phT
	d/XtLL6TNYvfF+o05vYtvetlKasS1Hc6IUP1+ptTMomemlbF/H+Z11YlBx5rzelOv7u4ZEPT
	A5EdazjYp381v3HwRtPNhs2Vd2tezTF/UB33o0jMLGaXx7azRkdF7a6e8BVZeWvh1OKl31O1
	d08/+N9c86HlRKtg4wAWf3GnnXvSlJcosRRnJBpqMRcVJwIAREFuWJECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsXCNUNWR1dB7kS6wc1ecYs569ewWUyfeoHR
	4sTNRjaL5sXr2SxWb/K1+PzsNbPF7f5zrBarFl5jszi+dR67xb6LQLWH555ktdj58C2bxfJ9
	/YwWl3fNYbO4t+Y/q8XcL1OZLQ5de87qIOhx+M17Zo+ds+6ye7QcecvqsXjPSyaPTas62Tw2
	fZrE7nFixm8Wj4UNU5k99s9dw+5x7mKFx7fbHh6LX3xg8vi8SS6AN4rLJiU1J7MstUjfLoEr
	Y8eupywF96Qr9u19ztrAuFC0i5GDQ0LAROL+C8YuRk4ONgENiYOHTjKD2CICmhInWicB2Vwc
	zALTmSUaH2xkBUkIC3hKtB1ZyQjSyyKgKnHknghImFfATOJ5w26wEgmg3oZL95hAbE4Be4n1
	ZyawgNhCAjwSrzbsZ4SoF5Q4OfMJWJxZQF6ieets5gmMPLOQpGYhSS1gZFrFKJKZV5abmJlj
	qlecnVGZl1mhl5yfu4kRGBXLav9M3MH45bL7IUYBDkYlHt6An8fShVgTy4orcw8xSnAwK4nw
	vj51PF2INyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBUfzh
	3hmsOsqHfncsvrRAYP6JH5PXebVP32S8orPM953JGvmNlevTHsbcq8u72rO85+H+W4k6p+T/
	TPgy4Xjjy8x5Om91pky+slbw1z2hhdd1F/WeytwSvl4v1HFleG/8P0FLMa+CjIfvDtpYmF3m
	SFz4QP5OtMqHkEvZkVNqtykvDHDL+GT2+qoSS3FGoqEWc1FxIgCS39kfhgIAAA==
X-CFilter-Loop: Reflected

Hi Joshua, thanks for reviewing my patch and for your kind explanation.

On Tue,  4 Mar 2025 14:22:51 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> Hi Yunjeong, sorry for the noise, but I have discovered another potential
> concern that your patch introduces, which I have explained below. 
> 
> On Tue,  4 Mar 2025 13:56:11 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > On Fri, 28 Feb 2025 15:39:55 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> > 
> > Hi Yunjeong,
> > 
> > While applying your patch, I realized that it re-introduces a build error
> > that was fixed in v6, which I am noting below. 
> > 
> > > Hi, Joshua. 
> > 
> > [...snip...]
> >  
> > > In my understanding, new_iw[nid] values are scaled twice, first to 100 and then to a 
> > > weightines value of 32. I think this scaling can be done just once, directly 
> > > to weightness value as follows:
> > > 
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 50cbb7c047fa..65a7e2baf161 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -176,47 +176,22 @@ static u8 get_il_weight(int node)
> > >  static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
> > >  {
> > > 	u64 sum_bw = 0;
> > > -	unsigned int cast_sum_bw, sum_iw = 0;
> > > -	unsigned int scaling_factor = 1, iw_gcd = 1;
> > > +	unsigned int scaling_factor = 1, iw_gcd = 0;
> > > 	int nid;
> > > 
> > > 	/* Recalculate the bandwidth distribution given the new info */
> > > 	for_each_node_state(nid, N_MEMORY)
> > > 		sum_bw += bw[nid];
> > > 
> > > -       for (nid = 0; nid < nr_node_ids; nid++) {
> > >  			[...snip...]
> 			^^^^^^^^^^^^
> When I was originally writing the response, I missed reviewing the contents
> inside this snipped section, which looks like this:
> 		if (!node_state(nid, N_MEMORY)) {
> 			new_iw[nid] = 1;
> 			continue;
> 		}
> I introduced this check in v6 because without this, we end up with the
> possibility of memoryless nodes having a 0 in the table, which can lead to some
> problems down the line (e.g. div by 0 in alloc_pages_bulk_weighted_interleave).

To prevent division by 0 errors, how about setting new_iw to 1 when it is first 
created, instead of setting it in the reduce function?

> 
> Respectfully, I would prefer to write my own version that takes your
> suggestion, as opposed to applying this patch directly on top of mine so that
> we do not introduce the build error or the potential div0. However, v7 will
> include your suggestion, so it will go through only one loop as opposed to two.

Thanks for considering my suggestion. I look forward to the v7.

Best regards,
Yunjeong
> 
> Thank you for your feedback again. I hope you have a great day!
> Joshua
> 
> > > -		/*
> > > -		 * Try not to perform 64-bit division.
> > > -		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
> > > -		 * If sum_bw > scaling_factor, then bw[nid] is less than
> > > -		 * 1% of the total bandwidth. Round up to 1%.
> > > -		 */
> > >  			[...snip...]
> > 
> > We cannot remove this part here, since this is what allows us to divide
> > in the next for loop below. sum_bw is a u64, so performing division
> > by this value will create a build error for 32-bit machines. I've gone and
> > re-added this comment and parts to the bottom part; the logic should not
> > change at all from the patch that you proposed (except for the build error).
> 
> [...snip...]
> 
> Sent using hkml (https://github.com/sjp38/hackermail)
> 
> 

