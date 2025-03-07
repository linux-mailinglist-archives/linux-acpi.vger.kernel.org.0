Return-Path: <linux-acpi+bounces-11934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A119A56F9F
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 18:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FA4189ACBC
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6924110F;
	Fri,  7 Mar 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sTMNuu3y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C423F413
	for <linux-acpi@vger.kernel.org>; Fri,  7 Mar 2025 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369880; cv=none; b=Ye+ZOQw+wXhZMSD6Tyx8wSztb5PcAlr4D/2qPMvkjHxKff9lv2PMx9XwqHWLfkAWumzv2zrVM75TBU25zmCNs/FiQin3TAMEEOkD/k09v4kb2jXXoEaeharu0EzTfG4CDovQuBbt6in4nyF5JEJ/2+lHeEMdzq4g1L3nCuAp/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369880; c=relaxed/simple;
	bh=4eYoVXz9byhRWXUVeCRZzyjBpS2VnJ3o4+kQ06tRzgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjmAebt5tF7rLIk5M7ZJf5DEZgVpiOadhm1uZnwlA2yesCuDVyIYdOF1SGyDWS4e+pCg7AoJ3HNbza4dvHgcw8K6SSbCYwL/CFIbT2UDP6DrYTlVQYY+7kzouyW+rOeNck0+8fXiiKYV9bQOTUTtrcdSofQcMTy5s3JPbAqhBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sTMNuu3y; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3be0d212fso312479585a.2
        for <linux-acpi@vger.kernel.org>; Fri, 07 Mar 2025 09:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741369878; x=1741974678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10uJGrqMsFBItujH17O3D7mXz4AwXzBXZFwQYXseYww=;
        b=sTMNuu3yRDp4vKTkPNX3jWOUOrlYb1O48y1b7VGIR83XwcVGkI7TOyg8L2YslPhdfH
         QEylZq7Wru5jNpe+1/Zsk34iLky04gKdKF0H31Qu6GgYk+zbPMVIE68JBWcofpItYnlh
         28su6lh0uIZ2xKdxEDwaFr+16jLxyq9KlYm0UaK6lexN69dw8D2HPsbF2N4aimjcFb5f
         6Op3l9a13EfslWyKhMJpagzFt+p375xD8+jppwPS16CqZwpHZnpVETd2SDiFK9C19HVg
         /Zk5gI32yT+7DuxRSd7jdwKoby1Msm2e1l6QDPmfcICHO1gGyTaww0Frmw7C9PHzG2GC
         whlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369878; x=1741974678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10uJGrqMsFBItujH17O3D7mXz4AwXzBXZFwQYXseYww=;
        b=qLD3K0YPRmsEAb3d+XbS/L1J1rY8rWnUOf3c5OsH519FhsYU2FhPX5ZYZxKnIVj1D6
         JpWMxfst4okTAZE2BAXUZvrmwJMhIQmkEx6dUPSbx3BSg9TIcBFksa4/8rhveNfA1x30
         q7tB1awD9Z41+J4vx669b8sf9DyT9NMCtHNGcpFmnO4JyWN08y47bMpfQhpN1Rmi7KGY
         CIAvBeHoJAdkAoTbVYFAzogrjVvgvgnnuHN+oLiFLEpyHTF5rXpIoCGvEfEWJ1XfNF2W
         qnysu7q236kGiIw8W4yQCs4qliy29xI1ZZB8pP4N85lzyqfNBg24OQ9DZUcDdz7iOBRp
         7wuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN1X1KO+bVEMKrpO0dN8fk6TW9Bw4GkVKTqBWoeXo1IUeuwV5BLVxqZ9z1bx0HrwsQCAx6LtreZvIP@vger.kernel.org
X-Gm-Message-State: AOJu0YzWN95XHMAZfgkP8aoNcGoFenOkwOfMrvLQYJhOJLNziO0Brcf+
	55ldaKkMNb56d7sNdJNgxwcYRYBH+fPzZLTvJMkkH63dx+aBPsifadXlRusORGI=
X-Gm-Gg: ASbGncvB571jvcb4BLwy+s4CrZLJyZJqWpVrZUQRwAZ9aO/C4/7+6kHk6YOupKQDfQD
	FHRMSw3baKLuB8zW1Q4NIz/tyGvpcbOfTZZhBv6EWwkct2MzthSUC0HF6fduY4iRJLECupysNmk
	86Y0tYs3mNK4MXBY04F6LzFbNL8wm6lOYu1WtM5RgqlzRBaFtK/QrFsauQmISe8DUsxz2YEBdSn
	REEI5rxeMs7o38B19m4G8G/3Rh9m/BRPORsyPtM4kS0HNRRXT8karzrfdXK+H13yqiGBjfAstte
	uX8uDqVwrMLsmuhCTeNbA0ep/96EOT6CL7ZFI76ypvOGVkInAphjKQLw08REbjoGgn/Ch4RNOHn
	G0/9JRM4+zOyFP42PxJmQEC4enjM=
X-Google-Smtp-Source: AGHT+IERTGeaFD6Oo8MeSWNHRrnPOT/UcHdFepnkS2d57xd8PUhjt0HaOYtF9qIzkGsUGgvoWm3nJg==
X-Received: by 2002:a05:620a:8905:b0:7c0:b0eb:4fa9 with SMTP id af79cd13be357-7c4e16781f3mr735549585a.5.1741369877806;
        Fri, 07 Mar 2025 09:51:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511c63sm267058185a.113.2025.03.07.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:51:17 -0800 (PST)
Date: Fri, 7 Mar 2025 12:51:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com, Joshua Hahn <joshua.hahnjy@gmail.com>,
	harry.yoo@oracle.com, ying.huang@linux.alibaba.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8syE7l5H35pk9T5@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
 <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
 <f64819e2-8dc6-4907-b8bf-faec66eecd0e@sk.com>
 <Z8ncOp2H54WE4C5s@gourry-fedora-PF4VCD3F>
 <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0d8aa8-cac7-4679-aece-af88e8129345@sk.com>

On Fri, Mar 07, 2025 at 08:46:46PM +0900, Honggyu Kim wrote:
> You can see more info below.
> 
>   $ cd /sys/devices/system/node
> 
>   $ ls -d node*
>   node0  node1  node2  node3
> 
>   $ cat possible
>   0-11

We're split across two threads now, but i'll add this context

I'm basically asking whether there should be 12 nodes possible. It seems
like there should only be 4 nodes possible - 2 for sockets, 2 for host
bridges.

Unless I'm misunderstanding, it should be the case that a given physical
address can only be hosted by 1 numa node (proximity domain).

So it *should* be the case that you either have 4 nodes possible or 10
nodes possible, not 12.  But I could be missing a piece of context.

> Which command do we need for this info specifically?  My output doesn't
> provide some useful info for that.
> 
>   $ acpidump -b
>   $ iasl -d *
>   $ cat cedt.dsl
>       ...
>   **** Unknown ACPI table signature [CEDT]
>

You probably have an old version of acpidump here, you might need to get
a newer version that knows about the CEDT.

You'll also want to get all the Memory Affinity entries from srat.dsl

> Not sure about it.  This must be fixed ASAP because current kernel is
> broken on this issue and the fix should go into hotfix tree first.
>

I agree something is broken, I'm not convinced what is broken.

> If you can think this is just a bandaid, but leaving it bleeding as is
> not the right approach.
>

This affects userland, we shouldn't thrash on this. Lets get it right.

~Gregory

