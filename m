Return-Path: <linux-acpi+bounces-10881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFE6A25EF9
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2025 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D92161245
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Feb 2025 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5DD209F35;
	Mon,  3 Feb 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GG2SN5Jc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA852080E6
	for <linux-acpi@vger.kernel.org>; Mon,  3 Feb 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597093; cv=none; b=AZRRmMxulbw/IFtRYHTj4zHHgzltP1/z3pK5Kv1PJxHbDPdJzUTsmeMO1I555U9711fQNSr1E4+vTmOtIWJBJ+4YJc93UfqufncSj/ndUjGXNWK9TTwLVbkbWcqq/79zQgb3gvd5HcIWUwrpFapS43dTBqFRmu8CYwsI1uxfU7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597093; c=relaxed/simple;
	bh=BTtjScOywshiwKWC0uOPF20eG3SQe1uCmleAuSjsoeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l202Dj8YSA9M4Q0pcQzzaoBPEWOHuGucphawdtq6fQ/s69omLcOIcPl/kTO+OZai2DNWS9dxXQPlvdI0Zd9CcsNLC4ROvQfmuDP0IwTSQXP1oM3hITVIRqE8Bi3mGcSwiP1tz01IknXpGaeQzBcbuaXPzoaGSMd9IKAWj2XKrlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GG2SN5Jc; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6eeff1fdfso412970285a.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Feb 2025 07:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738597090; x=1739201890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QutC4Bp0kBOkNqLV2m+TxVs5qOyu/Uk1tkI4OgwW1k=;
        b=GG2SN5JcJLCI7pDfO9fiV4FDdl/M6peoFmq6zrh79XjHLkGqe0AmLGzDfq2yJQReyr
         oMDA75/wsOU+aymP64dnkfl2u45A6OLrKWGQFGsbulp4353Cq0XX8YCdFNVtGH/g29fP
         kpPTkH3EQGc/UcSU7WkcyuskfYJFW2sebZKqG8BKD3XKImUIMNFNHTRa9gNqj72v42+W
         3ubbeszNZ958jw1U5g2lBoYytlAkB/74mTn5xMpKTVV9UHOIdZlxn14WUNSnMmqkeeol
         lFD0pDU5etLqBaf8JUW+MM2EGoqC9W0Zmmb/YPKIs0M4iTUwEYW+figWB5WxiHyrZDdT
         TbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738597090; x=1739201890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QutC4Bp0kBOkNqLV2m+TxVs5qOyu/Uk1tkI4OgwW1k=;
        b=bdtFVaGw0mKPI/0F+3DthhKUyKcVS9p/kcrUsWkPIoKEoJPHeqPsWaq+B/6RaR2LnN
         uWZwBV0Ncm6PJ0ZZRRJlZ8Ty0Y8WYMUS27oDen8Ma1EYlyIKput39AN0dQqZSMyrDTMj
         jGhz4hOuzOhzp6jgQL8JeJ7aFzqAOiepj0/CZdUGRvD/r2yEdNI0gOvW28+MkeN0XvrR
         2kpmFx6M0P/qoFqt2+ZlucWh9BW2jtsDRXvmNGVWzhDha+PYxAP66+ie2uPMxD4MYT1r
         QvHjU+vlWPrSgN5msDQ66qyYlTouWZDrgZjAK2i7KZ62a8I1lrGWrdcq0HZQmx5Mj/DV
         u7lA==
X-Forwarded-Encrypted: i=1; AJvYcCWUlID+MQsxo0R9ZsqRJF5yh0CFENYEWEHndxpMHGIZuTRbn4mL26T4N7VDQIFlRt8IKQTQyiP6NfyM@vger.kernel.org
X-Gm-Message-State: AOJu0YyoxbODoO35iS3VEfTdrA+mzluJw9cPC9Ar5HNMMNYj+/APcXme
	9LzhxCJEik4SlcEvy0MgweG3/KC+j9KyNZG47koA2ekByDHh6GR0rs9d6opqHBs=
X-Gm-Gg: ASbGncsytol4Bki340fyUgu5PUj+zkqHLhLlYb8XW+I5WMQKgEPHdw9XBC9qUjgwaYH
	yb75KC8evZS5Q3YZCAArwSYznJI7I/xtccsRht/z2ZjG5Nho+e2sHCNX6q5E6NNZuOKLn5/QWtL
	eJaIuXYycdwLWvLhsjPSHvFB1Ua01owQyjQ5e9IjlRgK9ITMuPekueYihZu4BNomJJ+g3QWEOQp
	vU5FhEprCl2BOleupqOWGEKGvfpZTxvobcR9OmJkZlIT7/+I5MMYgcvEQnIGx5SUM2ttcEyU5de
	+0nxFw6p14EewiV0lEyoE5Qrorhg9k1FEYgc96fr65hloNmAy8YaEMgWVwZcFq4ROFgSImbfVg=
	=
X-Google-Smtp-Source: AGHT+IGxWDdk+Y4hr1K+s/2L7RjMtvZ20ECCW0rUX0INQ/Bh4CjR5iJqI4t7BrTH3xZyekIHEtevZg==
X-Received: by 2002:a05:620a:2588:b0:7b6:deaa:3191 with SMTP id af79cd13be357-7bffcd9c454mr3554895485a.55.1738597090459;
        Mon, 03 Feb 2025 07:38:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d0573sm538247685a.37.2025.02.03.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:38:10 -0800 (PST)
Date: Mon, 3 Feb 2025 10:38:06 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, kernel_team@skhynix.com,
	ying.huang@linux.alibaba.com, rafael@kernel.org, lenb@kernel.org,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rakie.kim@sk.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, 42.hyeyoo@gmail.com,
	Honggyu Kim <honggyu.km@gmail.com>
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Message-ID: <Z6Di3oLQg64W0hAM@gourry-fedora-PF4VCD3F>
References: <20250202141247.2219681-1-joshua.hahnjy@gmail.com>
 <a2b428ed-212a-4e39-bcf7-5ab67249132d@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b428ed-212a-4e39-bcf7-5ab67249132d@sk.com>

On Mon, Feb 03, 2025 at 09:44:29PM +0900, Honggyu Kim wrote:
> Hi Joshua,
> 
> > A node offlining (or even onlining with no new bandwidth information)
> > will just mean that the node inherits whatever value is stored in
> > iw_table at that moment, whether that contains the default values
> > created on init or the last values that it had taken.
> 
> It looks the call sequence is as follows.
> 
>   cxl_region_perf_attrs_callback()
>   -> cxl_region_update_coordinates()
>   -> node_set_perf_attrs()
>   -> mempolicy_set_node_perf()
>   -> reduce_interleave_weights()
> 
> I haven't searched all the paths of cxl_region_perf_attrs_callback() via
> cxlr->memory_notifier.notifier_call callback pointer, but maybe this
> function is not called when a node is offlined, then I get node
> offlining doesn't trigger re-weight calculation.

This function is called any time a memory block status changes.

static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
                                          unsigned long action, void *arg)
{
...
        if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
                return NOTIFY_DONE;
...
}

But it doesn't do anything if it's not a call to online a memory block,
so the cached performance data in mempolicy won't change when blocks
are taken offline.

So the time the scenario you are proposing can arrise is when the device
does not provide performance information (missing CDAT).


If a user sets manual mode - they're on the hook to manage everything.

This is system-wide setting - not a per-task setting.  We've yet to see
any strong use-case for individual task weights. If there is a use case
for a task not being subject to system-wide weight changes then it's a
use case for task-local weights.

~Gregory

