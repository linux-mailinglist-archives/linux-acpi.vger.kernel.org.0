Return-Path: <linux-acpi+bounces-10946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDCA2D3F5
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 06:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123D016B7E0
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Feb 2025 05:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85065192593;
	Sat,  8 Feb 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTXdpRsU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E70188938
	for <linux-acpi@vger.kernel.org>; Sat,  8 Feb 2025 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738991172; cv=none; b=jO7vVfFiGC4otDY48Tq+jHm/G87yrG01gaJQ3Fge3+yOPnyLkmTXjzh1dgIL6Jz16pbg1fa+o2YYvjpyXA0Q1bl+YUNQdYgNvXJPZnWkq+PoQ9QgOV3Rhlj/y++/eZu4I4oqc4AUOn7HuQC/c/yeWdWtpR/3+EphjtU4Xa+XZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738991172; c=relaxed/simple;
	bh=SmCcIPXQv0e+lU8mHia4Ov+TILvfEvieYNZHpzBdtAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxOzfaxnzscY18t8DYWPaM5Njr4BECMCI+oKTHGfKIWPVoMi+eI2jhHWQaQWfA3nojAThn86Iz5EehB/K+DoksZ876QJOvMRzeMp9J8ie9ktvz3Xav9ak9LNxKCdrvSEnod5FeG1RA/b5LIV6Rb15xG9flCK5BHcEt+LA0+0Gak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTXdpRsU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2646009276.1
        for <linux-acpi@vger.kernel.org>; Fri, 07 Feb 2025 21:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738991170; x=1739595970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRG2Qi00mFeU6EAR49fnOvSup+6EjAplRe9HZkIAyc8=;
        b=TTXdpRsUO/LDAgQ2ASfjyZEgRwOX2UESjlZxVbnFTTk0cgkc2DCKEFdxb1R9ehoXXl
         yX2jHb9zzXByFO2T6esoyDm2dKOiCk07zQJlDxRcH/xiWNa12ztLlzoTMly5lHHIz8jT
         GNSfPOL45TfAfjvhMmkYyr9hR6KsfT7hn7zOwT9PLq7BET9zkkVp4CXMZCUpkZh9gvKG
         3vvDApjhU8ticJwl2z5DeT9ZDtv3sUUXD18j7pNWlA8HkJCcNyo2yVuuCvYArY5A60fO
         dGWn5NPWsPvZq03/3AJQt2T4MxlR9nnav3WcgQk+QcafYiaKgj4wo1U0ihWoTJoyZgJy
         BrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738991170; x=1739595970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRG2Qi00mFeU6EAR49fnOvSup+6EjAplRe9HZkIAyc8=;
        b=I/vglLNC2QwEzOkbZuFfBvQzzoEGMK8oFSRW66ncMB51fMz+Pw2qj9dDVBTNul5v1m
         /kIPb7qFvhjKKhz90Yy27b0wndh1bEzkQ1he9uj/k6cX0LeO2W76atKV5igmnVaWJSNv
         ckOPoMKs90XyO11wHxD4Lzpmd/QE1+tQPQtQC7XBYxfG3mRBpByFghv/NFVycQuSuDH7
         AktXB1zmcJ1FGtJvnhpmJW8g2lI0Ir7EyQB8Eet5Hpm/aIxNnMfZ2HgG+3oikDsspuQi
         qn504El06p+4OkgfjRkz9XX8c58DXAx+SYzSbtbT1NSfgsyI2AVIEntfnoWoFPm7U/ey
         xX5A==
X-Forwarded-Encrypted: i=1; AJvYcCUTUczZFuYZY1gUnh1A8HD8bXp5Js7n1MGwqzS7LY7oLNfpvx2vG+8YXFL0QMEVwu83BMxHVt3lLB2x@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwQ0F8cHScdg0t1ODbbq/HXap/EBlwxurA+OElCAeJpbKCDM1
	wsNv+8VNkmYdEWw3u5TsFY1JdOoOsrpB7IV97oAMocMZnuryLPIH
X-Gm-Gg: ASbGnct0xEvXCEi1ERRyzaGAqlVbVOejlI7BzDvBXnuODmi34e7asLHlY8nFHSiQsvF
	qAa3aGHaXkuiFejBIoJy+co+tOPQwtbSqGUjNqwwk9uAMGhCaAHKuS0ScNiCrNYH+w/YQ4PA5iG
	I72hNN1AW7d1Tlz6Zlhn5YKtVSVDVnY/oSq0XOujFLA2zsHqxHZ50YIOmksnDxb1JnaEuO7qmRf
	H1lVK+AtIqmwYAaaSiWgUgdHahHqrB7LiunxPexgh+ABgzjp9QURKTWaSpKG75qUYH/o3cebwcp
	1t0ETb2+aSYYOw==
X-Google-Smtp-Source: AGHT+IGhnserk8LdwS6kdvXs+W5KoO3op4C5IpMkH1t/iBSftmI0GHRkpf3xyKvbGW6NMgWl0qNziA==
X-Received: by 2002:a05:6902:1586:b0:e5b:1dda:8f6e with SMTP id 3f1490d57ef6-e5b4626c608mr5851213276.39.1738991169649;
        Fri, 07 Feb 2025 21:06:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a4898dcsm1189184276.47.2025.02.07.21.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 21:06:08 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: gourry@gourry.net,
	hyeonggon.yoo@sk.com,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com,
	rafael@kernel.org,
	lenb@kernel.org,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	linux-kernel@vger.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Fri,  7 Feb 2025 21:06:04 -0800
Message-ID: <20250208050606.800498-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250207182009.7fc099c3074ad00338f25e0a@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 7 Feb 2025 18:20:09 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri,  7 Feb 2025 12:13:35 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > This patch introduces an auto-configuration mode for the interleave
> > weights that aims to balance the two goals of setting node weights to be
> > proportional to their bandwidths and keeping the weight values low.
> > In order to perform the weight re-scaling, we use an internal
> > "weightiness" value (fixed to 32) that defines interleave aggression.
> 
> Question please.  How does one determine whether a particular
> configuration is working well?  To determine whether
> manual-configuration-A is better than manual-configuration-B is better
> than auto-configuration?
> 
> Leading to... how do we know that this patch makes the kernel better?

Hello Andrew,

Thank you for your interest in this patch!

To answer your 1st question: I think that users can do some
experimentation with the specific workloads they expect to be running
with. In particular, since the weights that provide the best results
are workload-specific, it might make sense to compare the results across
a variety of workloads that the users might be expecting and comparing
what settings provide the least amount of throttling. 

With that said, this patch introduces defaults that will hopefully help
those who are either unable or uninterested in setting weights themselves.
For users who already have already been using weighted interleave and
know what specific weights they should use, the auto settings might not
give as much impact as someone who is unsure what the best weights are
(and would rather defer the decision-making to the system).

As for measuring the accuracy of the default weights generated:
The auto mode works by taking nodes' bandwidth data and trying to use
small numbers (between 1 and 255) to approximate those bandwidth values.
For instance, [19000, 4000, 7000] might be converted to something like
[4:1:2], since of course we don't want to be allocating from the second
node only after 19000 pages have already been allocated from the first.

But simultaneously... 4:1:2 is not the same ratio as 19000:4000:7000.
So there is a tradeoff between trying to get accurate weight values,
while keeping them small as to not have unbalanced distributions. This
is where we chose the value of 32 to be the magic "weightiness" value.

Gregory and I spent quite some time modeling this behavior, trying
different reduction algorithms and weightiness to see what could give
us the most accurate bandwidth data while using the most reasonably
small numbers possible, and ended up with 32. (Earlier versions of
this patch also exposed the weightiness parameter as a sysfs knob,
but it was removed for simplicity's sake.)

We've gotten some nice results (under reasonable conditions) after
running exhaustive tests for a wide array of bandwidth configurations,
which is why we were confident with selecting 32 as the default value.

As for the 2nd question and how this patch makes the kernel better : -)
Like I mentioned above, this patch might not have a large impact to
those already using weighted interleave to see performance gains and
know what weights work the best. However, we believe there are users
out there who (1) have nodes with varying bandwidths (CXL),
(2) have workloads that are bandwidth-bound, and (3) would like to
take advantage of weighted interleave but do not have the capacity
or are not willing to manually change the weights. For these folks,
having defaults that make sense (as opposed to the previous defaults
in weighted interleave, which would make it functionally the same
as unweighted interleave) can provide more options and performance
gains to those who wish to opt-in.

I apologize for the long explanation, but I hope that this answers
your question. Please let me know if there is anything else I can do!

Thank you again for your interest. I hope you have a great day!
Joshua

