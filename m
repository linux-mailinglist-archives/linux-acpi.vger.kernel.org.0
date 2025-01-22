Return-Path: <linux-acpi+bounces-10788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3CA195F4
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 16:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8CA3AAD8C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FC9214A8C;
	Wed, 22 Jan 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbEZ1g8+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA821480B;
	Wed, 22 Jan 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561580; cv=none; b=I6BTZj30bfXcLpjsO2x7hdsIO6ix+ryeAjMk9oDWGkHUAZsHVCO2S5BwFZUXLfRx5T2d80IpiM/RNYAeb0r4gwIe+2EXb03eb0DCORlcxgaOQFjPPWmQ6gEYeL0j8nDrIQbI9L/2PC5uzbILseqLNXhpY5UUpqC5cVeY4EBceMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561580; c=relaxed/simple;
	bh=QbmirPmGsNCQN7OOqYFGXglHbvEZkd1Psarh4OTy/cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX6le6CiNcZSAZ53TMOnEeqhux0j69qVnQGjiX+rJiRYtxhr0ol/LITFfc9oRrXjUYisblRXi5NPQVxURkqugKG6Zvq1hcRtUSFLdcUCZXqAIU+BlFd2YZ1+DKpWQDHa5ua+0mlAVUqPM6lKBWdDUyWv6H5NjSU+ZKDS+UpTPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbEZ1g8+; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3a1cfeb711so10470262276.0;
        Wed, 22 Jan 2025 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737561577; x=1738166377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVFr/Kd+y56MHCAVrQFvOJkjt8uO/hZsG3DvF4rttc4=;
        b=XbEZ1g8+wPkMbF4uox6G8pfB772XRY672rveUwqu5KfsfQUKgUoZ0Qqa9lkUEe7+pN
         eWWKOAHYe7CcntiA7WlQYCQP2V1+7KKnFfr+4OWKgyu/ziz6R7VXnOfG3WN6/0tp1Yq0
         unxLI6v1vYETI6RJsrA29uWBIGmMwI8hz2aBhlD5B7IIQVPYPVpDAiGz+HEyH83BdDJi
         y3+3JJPd+v19rM1FlBByMWUxv7ZXskBF/IgWkIU3QtinmFRo3oZ5w0fvk7SZp3TIJXX5
         6gxXSJUPsrnCkCeUHtr/V6Lx5y//ZBBfLVwoZR6p+IAIAh22yyPBNeFWI2E+PxQNOOcG
         TXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737561577; x=1738166377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVFr/Kd+y56MHCAVrQFvOJkjt8uO/hZsG3DvF4rttc4=;
        b=BXV+iB7wTrDpS3RTDhfyM4OFIe/VNlfk6EvlrduVgPFjEOq+hgMB00fPr/AXKpe65u
         tpSi1t1ileVZfyA3G5nfK8vjMXSo6DW12ZoPnUUJCmDqWHP5UJhxoeQ+RgVhoAA793SE
         j1EFOYm07Od2/3bChFBXkHag4LbPtrYkjXqgGlATKt9PIITDaw4FXR8Vtqa6xvMFY0kQ
         r+dKHj3eaeI51/Kv2yjXZYVWh+LbwnB4ucYLdYNNscXiua0CQKeXWJCCPGqKRTHecFqy
         wS2qPqT5GVXV5gSMrvv8sMyJqxHy5/6GXGNs1JaoXrG8FGoJtK+MERuiBuuSfgK2dwMj
         kA+w==
X-Forwarded-Encrypted: i=1; AJvYcCW1EzEP5aZDm/MzXQmbZ/hX5af2FcMZhhjBBPdOcsYHUgjOgGvmPPgLGpPv3S//aq5GvkYsIUV/ubQa@vger.kernel.org, AJvYcCX1pMisj6vbil6czzsVi75EpEyJMsPn4PazMMA1oVXnn+dXPPrejXHSqUz6w/pPBwdOE82gnjmFS0Nnr1+L@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgu5Z6UCdeAO1pWMo73mO9LGVvCMve2APGJeE4c/f/oLbp8Jg
	vUBhkgXFIHHdABjYWr0xfdXyTl4+G0rdT3VXMwkzsWRwKJNCrs19
X-Gm-Gg: ASbGnctBtKzKXqIbQd+ybv9ct2G/bSdc9VBHdezYtbLAVmTo1meGU82FPAXzN/EDdSt
	EwPd7u2pxKAoZTd52WADqFFzNIOdIQ3FqVNBbkFQRBTWkKDUvp+5sQAoBh0H3HSNQ9VNDKSmAJ1
	f2TOgeFCEq6ryjEahsMvdAEFL5vDSpVlTJEOwSnHrgKWXYrPOpPjZ+R2FkXV7FLyGAjn87ww7J8
	JQe+q8cMtCAJF2ZSQiaMJgSuX+8xVzWtc0AkyH2L7q2/JSYDpD+rysVJ8O35RrORbq7
X-Google-Smtp-Source: AGHT+IEWfZo5EURfw62UUgGMK8Ad/eJOfQApkVZS8mrN7GFmmCq2u/q3+aJvOZGNF/swbGrCD6lBSQ==
X-Received: by 2002:a05:690c:6812:b0:6ef:e39f:bb1 with SMTP id 00721157ae682-6f6eb905af5mr181841207b3.27.1737561577576;
        Wed, 22 Jan 2025 07:59:37 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e670b187sm20665747b3.124.2025.01.22.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:59:37 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Gregory Price <gourry@gourry.net>,
	hyeonggon.yoo@sk.com,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	honggyu.kim@sk.com,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Date: Wed, 22 Jan 2025 07:59:34 -0800
Message-ID: <20250122155935.1282897-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <8734hbiq7j.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 22 Jan 2025 09:37:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

Hi Gregory and Ying, thank you both for your insights!

[...snip...]

> >> I still prefer to use 2 iw_table, one is for default, the other is for
> >> manual.  The default one will be used if the manual one is NULL.  Both
> >> are protected by RCU.  The default one can be updated upon hotplug
> >> blindly.  This makes the whole model easier to be understood IMHO.
> > `cat auto node0 node1` -> `true 5 1`
> > and you do
> > echo 0 > auto

I think that when initially developing this patch, this was the intent
that I had as well (in the v1 of this RFC patch, there was an iw_table
and a separate default_iw_table). However, I think that the ideas of
having a "default" and "manual" table made less sense over time, given
that they behaved more like a "default" and "visible" table instead.
That is, the visible layer is directly manipulable by the user, but
does not necessarily only contain manually-set values; rather, most of
the time, it probably still has a lot of auto-generated weights.

I think that this analysis runs the risk of being a bit too semantically
nit-picky, but as I'll explain below, I think both the 1-layer approach
that I implemented in this RFC and the expected 2-layer behavior that
you outline below are essentially the same, functionally. In other
words, I think we agree on what the expected behavior should be : -)
We just have to agree on what presentation would make the most sense
for the user.

> > what should a subsequent `cat auto node0 node1` output?
> >
> > `false 5 1`
> > or
> > `false 1 1`
> 
> IMO, it should be
> 
> `false 5 1`
> 
> That is, we copy auto-generated weights to manual weights atomically and
> use it.
> 
> > Then lets say we do
> > echo 7 > node0
> 
> Now, `cat auto node0 node1` outputs,
> 
> `false 7 1`
> 
> That is, we delete manual weights and use the auto-generated ones.
> 
> > what should
> > echo true > auto
> > result in?
> >
> > `true 5 1`
> > or
> > `true 7 1`
> 
> It should be
> 
> `true 5 1`

I see, so I think we actually agree on what the behavior for this is.
Then there is no real "hidden state", it's either just using the
default weights, or turning that off and being able to edit the
states.
 
> > The current code makes sure that when you switch modes from auto
> > to manual, it inherits the current state - instead of there being
> > some hidden state that suddenly takes precedence.
> 
> I think that we can do that with two weight arrays.
> 
> > So I prefer to just have one IW array and no hidden state.
> 
> Then, when we switch from manual to auto mode, where to find
> auto-generated weights?  Re-calculate them?

Even in manual mode, incoming bandwidth data is continuously stored.
This way, when a user does decide to switch back to auto mode later,
the system doesn't have to retrieve the bandwidth data all over again.
As for the auto-generated weights, they are re-calculated based solely
on the bandwidth data available. (I will note that re-calculating
the weights are very quick, see reduce_interleave_weights)

Based on your description of the expected behavior, everything you
listed out is actually what currently happens in the one-layer system.
Switching from auto --> manual inherits the auto-generated weights, and
switching from manual --> auto wipes all previous user-stored data.

At this point, I think that I am happy with either option. I wrote and
re-wrote this a bunch of times, and came to the conclusion that now
that we agree on the behavior of the interface, I have no strong
opinion on whether we have a "hidden" default layer or a phantom
default layer that is just generated every time a user needs it : -)

Please let me know if I missed anything as well! Thank you all for
your continued feedback and interest! Have a great day,
Joshua

