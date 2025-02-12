Return-Path: <linux-acpi+bounces-11119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6EA329F5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F282188D101
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC2D21149C;
	Wed, 12 Feb 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgSfllkG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A812116ED
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373975; cv=none; b=fcaGvflpmAGSi0WvK9vbvtv5GPgzXI+LZ+GhqnQC+jejXyPJuSUOLmwVHpFDsOdJQ0X9wsdfyNAfzcKSxJ1KLH29Fb5BXfW93KxmbfsZEJ33nW3YXa0n/fVko70KCTh7teS5nO2t/J+iM79jbsozQ+Wr9y+CsbkQCMCZkZIbYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373975; c=relaxed/simple;
	bh=azNu5VMGZgVEyCVt5TIT2I+IDQCm2fTvNzRXKqwsbug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rlkpmv7pu6PQh39hyCzU05bKS0d4Fw5NwmhVGEWi41+sEy2naK56gK2WRQzVNLuSjN7dyoIirjzWkgkEopeQix3IU5P9jX/7qu3gViPRBdt/CeudX9dSW4A+4qVh1twn2QXs11NLD0u7mmR53CX7wF7XisQvXL7oAFm8JjTx3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgSfllkG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5b29779d74so6314748276.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739373972; x=1739978772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvjG9hNk6O6AhaG9ttlmUq7XexAhA5zfoCCpnbbsQD0=;
        b=FgSfllkGM+omkoCqCjkQTbdd1d8sWgCeI5thvEKICNQuXwGaU68Qzz/rZbEdILyQXd
         0c53XdwcRwFNkMwtJJofvlpmbj533G5GErKa02wW6mqKe5SnRLPO0Qh5ifz/CVab8mn7
         QxwGS7E58rKLWwiohNDIFgDENX08AsL2f2NT1iVUuNGb8qHI2RHD3jc8C+JEHZiUtnpv
         I8+O9M3uul5ZQElaBO2K2v1HUC+k+LfZGxpbts8AeGfEmLljbBb5O7G/le2J/6JI99/V
         ZA4DeWqU2xtDKhXm3WDcFrS4wsSI6cvDzIkn3gdtYFBxfXbGcxQtLHp7GQrzhF3RtVDx
         ogOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373972; x=1739978772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvjG9hNk6O6AhaG9ttlmUq7XexAhA5zfoCCpnbbsQD0=;
        b=hTPX/JIbgqn49gbw0vNigc9wzMMSartChd5hBTQUEcmbWBtZ1g3SwKVZek8GXONJMU
         8Y1beVB5PN4ZVV4mw9ndGyUxJ348O1tRwhBjSmyLiEDe0irZkJ0YYtYy7zgHqMWqf1gP
         WfvMkENt3DsqHFEdkqIpLAOuwLBeZxUdaEyv2zvqBzcWRdG33XjohlpLmXBrvJ4EwQrK
         WREgeuFFaEYz80pAuhfInQIC1o3q9pp4E6eLrg3sLVNV/JEEEYQPpKBIgmXIbt8irvBf
         7ZKgKwWfeNlsDh0tbSIA33HQj7Lc1px4Bv8c6RR3Rbz7ju24k/vzcbKPhCjC8I/zbMyV
         3QSw==
X-Forwarded-Encrypted: i=1; AJvYcCXGfp9THBnk9vcHUjkWj3jxUn0T1i3k5peHI/tBDZgA227gjFCXqSeVJoqQdxNm8oHndcQJXZ03cqtW@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDkiwiFBOTNmCMwcms/X0/4XxZ8ciAuHGM/FLPPmGDd255Z/z
	uOAJ+lxh4hDeJ9l2wXipzR4GPXXssxqSbBUM/wrl3dbD8aDs8iRQ
X-Gm-Gg: ASbGncsgIrUJIGp05eGHxkTTT9/G6DdtPs5SPLKQpWD1JSJe4acnNIyxFTaBt/Es2Aq
	bqK7Wxx4Aa5erc5IsiOwX5cq6vsYhi341vx9+zqxLu+ITfoOrhKRY31OAOml5JG55Sj/3XvPOcx
	Cf0LFedeBqVxyh4he4S9Fp2NZzqUGrXcYkd4tebJ7/ptad4NjB7po9o0tq40FDG/imSJhb8NSW6
	E17tqTB0EUzsCrnHNYReffvwTMx+wRKKVJsdFn0KjWkkvpWoEI1eg0W5pT0InzcQD5r4l5eDlPW
	h1DJL1YL9PNCQQ==
X-Google-Smtp-Source: AGHT+IHcrBpEb0spczFBp80Mc2HWlGMAuQNCOiCGtDzNfF22bnhupf1B3PDC9GMyDn7GT8NwB6XU5Q==
X-Received: by 2002:a05:6902:1442:b0:e5b:171c:35ee with SMTP id 3f1490d57ef6-e5d9f1862abmr3742646276.48.1739373972134;
        Wed, 12 Feb 2025 07:26:12 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a207eecsm4097722276.24.2025.02.12.07.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:26:11 -0800 (PST)
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
Date: Wed, 12 Feb 2025 07:26:08 -0800
Message-ID: <20250212152610.570427-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250211161752.64dd397e66a2754097ab8c2a@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Feb 2025 16:17:52 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri,  7 Feb 2025 21:06:04 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > On Fri, 7 Feb 2025 18:20:09 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > On Fri,  7 Feb 2025 12:13:35 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > > 
> > > > This patch introduces an auto-configuration mode for the interleave
> > > > weights that aims to balance the two goals of setting node weights to be
> > > > proportional to their bandwidths and keeping the weight values low.
> > > > In order to perform the weight re-scaling, we use an internal
> > > > "weightiness" value (fixed to 32) that defines interleave aggression.
> > > 
> > > Question please.  How does one determine whether a particular
> > > configuration is working well?  To determine whether
> > > manual-configuration-A is better than manual-configuration-B is better
> > > than auto-configuration?
> > > 
> > > Leading to... how do we know that this patch makes the kernel better?
> > 
> > Hello Andrew,
> > 
> > Thank you for your interest in this patch!
> > 
> > To answer your 1st question: I think that users can do some
> >
> > ...
> >
> 
> Interesting, thanks.
> 
> Have we adequately documented all these considerations for our users or
> can we add some additional words in an appropriate place?

Hello Andrew,

I have documented these thoughs on a private document, but I think that
it will be beneficial for weighted interleave users to have this
knowledge to reference in the future as well.

I can think of two places where this information will benefit users the
most: I can elaborate further the motivations & decisions Gregory
and I made for this patch within the patch commit message, and also
in the ABI documentation. As Oscar suggested, appropriate details in
the code should hopefully make the decisions clearer for future
maintainers and developers as well.

Thank you again for your insight! I will have a v6 drafted up, and
I think it makes sense to pull this patch out of mm-unstable for now.
Have a great day!

Joshua

