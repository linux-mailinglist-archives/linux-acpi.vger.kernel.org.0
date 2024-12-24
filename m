Return-Path: <linux-acpi+bounces-10301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1589FC2E3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 00:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DB1188364E
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 23:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D91B87FF;
	Tue, 24 Dec 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e/qjZZvI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717C8BFF;
	Tue, 24 Dec 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735084132; cv=none; b=HBBunho0gu03dnmYBYu/NOaF4V7E/3RDqMdAF2YX9mbKYFaJVOZpTZQVXVdyHafaSnPIrGQx2A84ZZqt4ZbWbXA/taljqtacoZMpzCrOCzHbk12oeH7ZXSNi5rqsuJZ0kIZoFqA9dRq+F/6Ne0aYV7SV6m5PXt78mHuCI8xukbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735084132; c=relaxed/simple;
	bh=h9jfdjju27KvlVZ6XfuVsuCs1r92celUHxGn2RMhSdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ibWtoORkUmsgTqNieV3TEJ1xIonYV48mKTUiImS1WLRhb4O9l4lKo273S8SxOrt8MDyqjh/KZc/dWa5GJ5cHBmV6ons2yHavMk5TObESVQIxXmN7WGFM9VU/Z5Yc5cuoI6aKXX46OfanZ678wNnsQkryKsHV50W1+gwkT13CZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e/qjZZvI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735084120; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=IWOt90lynNL0xLBlX/5fzb0ZLmhgA/zMlV5D1Uv2jLM=;
	b=e/qjZZvIswuGE4wtdh0D93X6hWPY9ltPvHhJS9Ecg4Ue7oyfcfkQLj0w4RohmUqInf1eLZBV98RVY4RqOXq8bSa2vJoVXIbllYU6qqdm9xVVNEXpBpNy2nPv2kLx07Po7nPqCskSckk2Jeg7gCs7LMkKgyA/1k06NdARCHx7OKA=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WMD4lv7_1735084117 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Dec 2024 07:48:38 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Gregory Price <gourry@gourry.net>
Cc: Hyeonggon Yoo <hyeonggon.yoo@sk.com>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  kernel_team@skhynix.com,  42.hyeyoo@gmail.com,
  "rafael@kernel.org" <rafael@kernel.org>,  "lenb@kernel.org"
 <lenb@kernel.org>,  "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  Honggyu Kim <honggyu.kim@sk.com>,  Rakie Kim
 <rakie.kim@sk.com>,  "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>,  "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>,  "dave.jiang@intel.com"
 <dave.jiang@intel.com>,  "horen.chuang@linux.dev"
 <horen.chuang@linux.dev>,  "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
  "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH v2] Weighted interleave auto-tuning
In-Reply-To: <Z2hGWoqZqwxJC4gM@gourry-fedora-PF4VCD3F> (Gregory Price's
	message of "Sun, 22 Dec 2024 12:03:22 -0500")
References: <20241219191845.3506370-1-joshua.hahnjy@gmail.com>
	<3682b9cf-213c-497d-ab81-f70e1a785716@sk.com>
	<87r060i3nn.fsf@DESKTOP-5N7EMDA>
	<Z2hGWoqZqwxJC4gM@gourry-fedora-PF4VCD3F>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 25 Dec 2024 07:48:36 +0800
Message-ID: <87ikr8abhn.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Sun, Dec 22, 2024 at 03:21:32PM +0800, Huang, Ying wrote:
>> Hyeonggon Yoo <hyeonggon.yoo@sk.com> writes:
>> 
>> > On this server, ideally weighted interleaving should be configured
>> > within a socket (e.g. local NUMA node + local CXL node) because
>> > weighted interleaving does not consider the bandwidth when accessed
>> > from a remote socket.
>> 
>> If multiple sockets are considered, what is the best behavior?
>> 
>> The process may be cross-socket too.  So, we will need to use
>> set_mempolicy() to bind tasks to sockets firstly.  Then, it may be
>> better to use per-task weights.
>>
>
> If we want to revisit this, we might be able to make task-local weights
> work without a new syscall, but the use case was not clear enough which
> is why it was soft-nak'd originally.

Yes.  That is doable.  However, the challenge is lacking use cases.  I
guess that we can wait for more use cases?

> vma-local weights are arguably more usable, but require the task to be
> numa-aware and probably require a new mempolicy syscall because mbind
> has no remaining arguments.
>
> recall my original testing results from stream:
> https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
>
> Stream Benchmark (vs DRAM, 1 Socket + 1 CXL Device)
> Default interleave : -78% (slower than DRAM)
> Global weighting   : -6% to +4% (workload dependant)
> Targeted weights   : +2.5% to +4% (consistently better than DRAM)

---
Best Regards,
Huang, Ying

