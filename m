Return-Path: <linux-acpi+bounces-7113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B025893F7FB
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D2C1C21B15
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC3190040;
	Mon, 29 Jul 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q9r9NFG5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525818FDCD
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262989; cv=none; b=GbFiTI/B2Shhtfk9Ukk7JKRuippcLBP9i3cYKCZHizqLxizoPlIZTUcClHJxcUqDKjLgyWw2rw5Ef5fjr9pWaJaaZWohX5K5i87lbX+WH2iMenysxD9BhSi5lM5WvXFe1ZtVqBuenhoX/h8MEeVqS8DV0HAqcmyF4/O4HGSH7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262989; c=relaxed/simple;
	bh=+FndQvliZxQtM6btRXMk7tSQbXJiUxwffq+ZuJfIpC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayPhB/o3skWjH4WhA2RupPtVK3R7n87obLumSVrW3xWGUkvNGpRGW42QvkIPXZe6Z56iZALlofMXDthTsuiR3lp4JDR+rCV/FjKl2NLX0z+w9JXF/mFnI1czpm3n7y/M4NTb2PjMlQeuF/PF3vzhTb6yoIfNMiK72sROKmLa+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q9r9NFG5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7092dd03223so675924a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1722262986; x=1722867786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LXNIPi3GQ0yATRS1VEygNKstEkvEbJ00GT3K3Vkj5U=;
        b=q9r9NFG54XuP1iqPBjNMcStHic65LrkbQUuLwXhqjU/Y4vqfFgLK6oQt5hoREEqtkK
         1vCZ+7lIT0wPzFvYQKH1trE9nlcd9ApcdWW127AMqJNCUyZh6foJYFpzQLZd8W0Rng0n
         O7AdUFH98U0y1Db9FNGNzm/IBVf73xv0rBlhKRJcn7pjXI4jLdtbyy2z2kEZ8AYiymww
         Uce/Z7X15pFCFgeTFjlGLHh0w0osXsUt9LNglQFIqwLTQmhaISrQ/vJAMiBtFaXZ28C8
         8Vhi+UnTd1RKOykm7Xawi/uVUqMEqQXBQjDHKYWk45/yKq01OHeuBfc9WMT9WRjzu6BA
         NnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262986; x=1722867786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LXNIPi3GQ0yATRS1VEygNKstEkvEbJ00GT3K3Vkj5U=;
        b=v9Rod41V+Y/18n51gVaiRTAv6V4Yu7xfiA0v1PbOvjloM1s06ChYzhDBvJVbXFfVGC
         Se4sqoox9eu2CpyMebap0ZY271kmu8O1EpZsw3VwfmaZZYAs9ZgjDALD/fr1SdcZhvYV
         fuZbkAgEpVycgbuHxzX48FDNPMEhw2v+xE8SJBwoY+Q1LzkyM2FaiLFzP/0m/6Tg+YDA
         nr/bRYn1+AFlt6tEmtVGOTBLEl4EMdY1v64kMOjOtOKCvMcFX6HfpL1DKPhfvukRrEWT
         5xfKHeiyg3nd8SibHtXFUHrueFYXzBgNOi6+eWlpLbD0UAc7au7T77ePXW0P5Ry9b3I9
         yDBw==
X-Forwarded-Encrypted: i=1; AJvYcCXW995N91wldjSn/jecBxlBzO2bEhMkQNdYK6QklqteTpW+t+rl1/d3NNk9iUtSNKnQQ9kQFY+qL3UqkMxmjweZGQuLBBBR+wr1TQ==
X-Gm-Message-State: AOJu0Yxx0dPCIl7QkpXOrUAH9h+13+5l72jSlIztzgCwT1jrWrp9riyn
	EQynndSFo5EOPv9BvqRDz/j+h4wh69q/huUF1fBUm5+IvfKy7Rs/QIB8IXtPEzc=
X-Google-Smtp-Source: AGHT+IE4Uc9GN+gfcvZXZsg6oZ02yCqpJXlwIS5AqIAosbUfh5gO+aYR2YPZRWJiMcCTq/IvQzqNNg==
X-Received: by 2002:a05:6830:730d:b0:703:6ec7:64e1 with SMTP id 46e09a7af769-70940ba1bd2mr6431952a34.0.1722262986486;
        Mon, 29 Jul 2024 07:23:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1fa4462adsm39342685a.100.2024.07.29.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:23:06 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:22:52 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, horenchuang@bytedance.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	dan.j.williams@intel.com, lenb@kernel.org
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
Message-ID: <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
References: <20240726215548.10653-1-gourry@gourry.net>
 <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Mon, Jul 29, 2024 at 09:02:33AM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > In the event that hmat data is not available for the DRAM tier,
> > or if it is invalid (bandwidth or latency is 0), we can still register
> > a callback to calculate the abstract distance for non-cpu nodes
> > and simply assign it a different tier manually.
> >
> > In the case where DRAM HMAT values are missing or not sane we
> > manually assign adist=(MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE).
> >
> > If the HMAT data for the non-cpu tier is invalid (e.g. bw = 0), we
> > cannot reasonable determine where to place the tier, so it will default
> > to MEMTIER_ADISTANCE_DRAM (which is the existing behavior).
> 
> Why do we need this?  Do you have machines with broken HMAT table?  Can
> you ask the vendor to fix the HMAT table?
>

It's a little unclear from the ACPI specification whether HMAT is
technically optional or not (given that the kernel handles missing HMAT
gracefully, it certainly seems optional). In one scenario I have seen
incorrect data, and in another scenario I have seen the HMAT omitted
entirely. In another scenario I have seen the HMAT-SLLBI omitted while
the CDAT is present.

In all scenarios the result is the same: all nodes in the same tier.


The HMAT is explicitly described as "A hint" in the ACPI spec.

ACPI 5.2.28.1 HMAT Overview

"The software is expected to use this information as a hint for
optimization, or when the system has heterogeneous memory"

If something is "a hint", then it should not be used prescriptively.

Right now HMAT appears to be used prescriptively, this despite the fact
that there was a clear intent to separate CPU-nodes and non-CPU-nodes in
the memory-tier code. So this patch simply realizes this intent when the
hints are not very reasonable.

~Gregory

