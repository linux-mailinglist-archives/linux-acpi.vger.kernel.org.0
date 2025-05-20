Return-Path: <linux-acpi+bounces-13833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96B8ABE25B
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456B77AA153
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713DC276041;
	Tue, 20 May 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY/9Konu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED60262D29;
	Tue, 20 May 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764690; cv=none; b=G7Ww2vasxuqFpH0YW87bd0XhchgV5sGhdZBbIaL9BRR9l10N6lwHBQ2zUEPRb6JzKN21drXlwxxzqXvuALDHmTMi4FIegrANmE2DITwsMkVCToL4Hujmtzt4Dlbjyx0+Uwf7dQFhTPr+AdEaFfm/Bk6N8Bllm5J0VxVcMaTpFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764690; c=relaxed/simple;
	bh=twrW7/08eCVa9qptJqhegLazELCJFFEPNWRhDI8Zpxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWXdE2vme0JiKJ6gwXhsmN0WbZnYFOMvaeqFlqJTNdlYnh8yZB7dfpQDEFJkZQh69RtHz36R+/Dt9mCXybePa1e0cac7wXTjvx1/eAZTgSmNgmaDgDFDGcO0Br4Y139ymwkNU6aTVJk03S4abgX0R5RBWrqgyH2i76SjKz67oS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY/9Konu; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso5821491276.1;
        Tue, 20 May 2025 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747764688; x=1748369488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNiU/+iVtGg8iLaaH7gZuUjEVkcmluAtZKRN5PqnkdI=;
        b=IY/9KonuJBKdavDYRrDb6ZZJBb0/Zc4/XVpSv6q2+qmaIYFzgq2ezfLXYo5RLOYfNY
         66QkDOdGJ0rvM2WzBbo7hGRL8YX4s7ypAIfc6XoleakJREl7NEr3n3nPNLaok7bUaUXy
         Bw7aSkoGnyV7v0sXioxeWunA0A9zi0UzFGx3t8DWyhGaKIsIoIfhGHCwD5X4mtHgKIRb
         xtT9E1zv30I+NuQrBMY6NNo1WOqcxQHuxzRBeMRVF3ooqL7EvBvVO99To8QLjpnUVPqp
         IUIaCx116CReh16krsX70ZCjEyPLtKAsRwhJIbxa8eQ/YZD028Gtu80VoPUjqQqXRkOA
         vewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747764688; x=1748369488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNiU/+iVtGg8iLaaH7gZuUjEVkcmluAtZKRN5PqnkdI=;
        b=vViN4IuFD3aeCPIqxOmHaMvaBInoLbdmOyI91/wuDGeOiwFc8EmMvvCnihb+IsxpLl
         4AP/n+r7y0yAPVaNba0SU4XR8rLwJw7rSne9LdE/2NcWSCiAXqN5j8uHp2CNtaFK3tso
         sfhaK+oboVrylSR/gCy6EjioDX1OzszSu9mYYKdZWDBe6s9Uh2Mbhsr5GUhzwV3/WZIb
         kN3ZpFWr841HThyzD0kvgZ16+TZXIZPLdNY7Fe8yNjNRjofV8F8rMw8GFh4aHuyNGdYB
         eOQmvLVuHITb1tWG2aewDm3LNRpAL5M1RxIufx+Rq87PRMlnd9603UXrV2v9GfaDvFFR
         +2hw==
X-Forwarded-Encrypted: i=1; AJvYcCXBayz4/DBpGk2bNLS2vIRAds9IS0ZPWlanK0WGTgH9ojTTEXtraHdsO7pcSAmpLGSKFuXBBWSoGhkV@vger.kernel.org, AJvYcCXD46X2fxORIvKYuC3vYvMI2FR/bLZpr9OyjvxXi2uQViwnQfLhMGQ5pEQE5KEZnrES7Uab64GKq7iJEilD@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwIsJP5XFBIo58YtiFaoP6CN9gKm7BfhsKhOMr3AKUwQYIRZ8
	vbWOPukpJqnhzkyUV7DYtCkwwux/y41YCFjJ4WuWmkhtsPYXJL9IaF4J
X-Gm-Gg: ASbGncs+3kOY6cq8EgWcayilcy6CxKk6BmZvs+LBtFUq6K4D2fKC/Hyw4saUUKMpVWe
	mNI7VkZSQDj9rACtzUKg3bgzuVg/ywPR9h4jMx9pFv4ivqw7FEUJeU5XUu6pEkxToRLPh1aNyoi
	eu3tJ60miqon9nKDaP1Ewkr4r0zKarzPdmNHyMUDE0oPaMGVvrBAPQeEJ683xvS+fYRvWUEK9Sd
	KRGFoG4PRmfEut4sSLY1LkORH8PodkO8gCymA6RXqM7viMJtt10xyEaBBbHfBnGpUL9F0sTlurM
	TsbqcvESq/6YwD34xEC9qV33qK6i+MdEQe6chU3vkmL7xSwcGb4=
X-Google-Smtp-Source: AGHT+IF9qB2EDGLXol7oTFU3nKmNd6gAUjfzN+l8/6o4+MlEfJcVhohBDS8KzVMsF9an1hJiidQsLA==
X-Received: by 2002:a05:6902:478e:b0:e7b:9763:6697 with SMTP id 3f1490d57ef6-e7b97636a09mr14133727276.28.1747764687532;
        Tue, 20 May 2025 11:11:27 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b75568de3sm3303496276.3.2025.05.20.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 11:11:27 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: gourry@gourry.net,
	harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
	rakie.kim@sk.com,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com,
	horen.chuang@linux.dev,
	hannes@cmpxchg.org,
	osalvador@suse.de,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v9] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Tue, 20 May 2025 11:11:24 -0700
Message-ID: <20250520181125.4155631-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250520105319.99f3f2f980617e213db6be20@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 May 2025 10:53:19 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 20 May 2025 07:12:35 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > Changelog
> > v9:
> > - Code cleanups & wordsmithing
> > - Added tags for Honggyu and Ying
> 
> Honggyu's Reviewed-by is the only change I'm seeing between v8 and v9,
> which is unexpected?
> 

Hello Andrew,

The code cleanups & wordsmithing were part of the fixlets that I submitted,
so if you are diffing against the version of v8 with the fixlets already in,
all you should see as diffs are Honggyu's review and test tag, as well as
Ying's review tag.

I was not very familiar with the fixlet process, so I imagined that I needed
so submit a new fixlet to add the 3 tags. If that is not the case (and you
can just change the tags without adding a new fixlet) perhaps we can keep
v8, just with the additional tags so we can keep the patch in the unstable
branch?

Sorry for the confusion and the noise, I am happy with whatever decision
you make! Thank you for your help, as always.
Joshua

