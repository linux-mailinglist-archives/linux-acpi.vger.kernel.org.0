Return-Path: <linux-acpi+bounces-10212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6034A9F9405
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CEC7A1C55
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3C215786;
	Fri, 20 Dec 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IGxyHyF7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11D21577A
	for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704035; cv=none; b=ftppl6/XjD2kGFdZCuEfMfhfy5noZnYw8dnnQoFHU6Avk1/rQrluowKRYh5BKZan8VBNLdxqfQvr72N9fjU0p4glYkHY+suF9cM/q1947voHFI4VmPQ4ff1+U8GESfsz5/8mlWGTBrAEU4YUB3ahMm6yJdFl25GBeKNkW24aI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704035; c=relaxed/simple;
	bh=6CHp5J82eGmUQRtFFOtuQHNV5+uXQByl45MBL9tceoI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pG2wBKOg0g4aoIISJpDhxXEgBJeZ2itRWhX4Bcm307t1qUT9xscEMrGRwtuJ3UPYrA/K6c1ZEwJzBW22JmTTTG6gxL8Hh5TjrJ8ongiRHqKlM4ilJQ+xqqHC6LSDWyRo++qW5cJjYPlviymxT28FHxsBjkbwTbJPno8AcyL75bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IGxyHyF7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d8e773ad77so15080636d6.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2024 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734704033; x=1735308833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3v08MX0QjC5F8LYMz3jdkKlxnmqui017XpkGCbWdww=;
        b=IGxyHyF7vEgfO84LmddIHe5MmHDOZsZAMTrJqS7coymSwO2qGQ/4m8W8yvOiZ7x9Sn
         KtTIVqAeVJZAc6LLkwhFnXLX1Mk/ho0WAOX6wCSriJT7RcHpKjR7O7i5ayiNrgNMnsMH
         UjvTfWc3qU+tUQMH2WPBvL50yETm2Yh0RZY1A8zc/dVxCIcTBWrQQh/t+m/VJPRdZOi/
         /HCGSE6gKQ1k769yk6v0jjc5ZSBlkteIrtjY+6YftHjt8NneCp6gF+FOemqazV5ltcR2
         s4KniwDXGLZZo0Wl64Zaawsss0Mq/vil7LlJltSNtTrMvWD6kppbagNIM9AIKUu5J4TP
         oH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704033; x=1735308833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3v08MX0QjC5F8LYMz3jdkKlxnmqui017XpkGCbWdww=;
        b=WUpviGvGZrY8bzYsh4j1Pk+u47QrVVP/bWQct2BijJwTPdaS+b5tXqP/sC48ivtx/P
         gfAv4OhXIeULqP4GxQH+JTLG1whiQaqpJDKv+LazVsNsqAZZzmIe7NDJoUqyitmDUDpM
         VgXecoa/RiwHlhiuHzIQ7KZ37fjFqlBPv2bWeyq7PLqYtObUnc4nKJCDv5cHaP0QcOsS
         G/d/MyUxV/L+uPdUwHhB8zOTqw6vrAfqaWKMISBIwNJ1QS9xD3zkwgSq0YbUjofpGEy6
         fUfMGLTrXhVqI7PcjRXI9lmGMPYPuQN3By6vnpDPXd0pC+DxeMvMDGV7SLh7NNIAo7xb
         qT3g==
X-Forwarded-Encrypted: i=1; AJvYcCXAorudZXTkMRg71nsT/GhIbwnWsJsbGeV7AfJ7T95APqeQzqLnVZuqyYffjRWEPz2j0/yWtUMFHT/y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsz5iFJcO+hM3gFOK3VQkCvn/YyGs8+KvLL1pCC3mfgfBlydWJ
	n+uo9APp5S9GZ/7pc4YRvK7dbKgVlTvINdJBEqxAUNDJjfbIJfHktaav1IDW6bU=
X-Gm-Gg: ASbGnctyXC4xeepEY2+mVqmhJyp0t3XzzC94+2aNMKv64Fj+KussDICaUKt6TBcwDHQ
	24ntQDoL1skPUDpz1Uo9JkP+lbQfZI0J/AuB2+/8pubHFc2GM6wYQVI/tEDhsVRKGaJb0qsgHV8
	UDZAU9/Wdg5q1EYkXWtxNMogsBLOvgAquVr43HskDQA41aAbnL4AMihzSAP/WW8gsNlx4AI1nPM
	v3mL0KL9m1DbKV8l5KsjNgiZHpg54eC2GX5avcyoITVOSRjq5Tw0mtFQMOpcn/a0vQ5nyF7nkPh
	f/G/KthQ4hrpYcJkFWh2yA73L8P8j6eiAWAPeD4b7oNLxVnekkNBt+w=
X-Google-Smtp-Source: AGHT+IF07FueLvr+EH96oSAOT59/93jJUqPV2Yol4ROXZ7UazU1CvYitUGtxot3syd768RDJFTPvpw==
X-Received: by 2002:a05:6214:2242:b0:6d8:fa8a:af7e with SMTP id 6a1803df08f44-6dd23337bc0mr46854986d6.12.1734704032954;
        Fri, 20 Dec 2024 06:13:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810ec4asm17148286d6.50.2024.12.20.06.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:13:52 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
X-Google-Original-From: Gregory Price <gourry@gourry-fedora-pf4vcd3f>
Date: Fri, 20 Dec 2024 09:13:50 -0500
To: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	"gourry@gourry.net" <gourry@gourry.net>, kernel_team@skhynix.com,
	42.hyeyoo@gmail.com, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	Rakie Kim <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH v2] Weighted interleave auto-tuning
Message-ID: <Z2V7ngtLXH99LqLe@gourry-fedora-PF4VCD3F>
References: <20241219191845.3506370-1-joshua.hahnjy@gmail.com>
 <3682b9cf-213c-497d-ab81-f70e1a785716@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3682b9cf-213c-497d-ab81-f70e1a785716@sk.com>

On Fri, Dec 20, 2024 at 05:25:28PM +0900, Hyeonggon Yoo wrote:
> On 2024-12-20 4:18 AM, Joshua Hahn wrote:
... snip ...
> 
> By the way, this might be out of scope, but let me ask for my own
> learning.
> 
> We have a server with 2 sockets, each attached with local DRAM and CXL
> memory (and thus 4 NUMA nodes). When accessing remote socket's memory
> (either CXL or not), the bandwidth is limited by the interconnect's
> bandwidth.
> 
> On this server, ideally weighted interleaving should be configured
> within a socket (e.g. local NUMA node + local CXL node) because
> weighted interleaving does not consider the bandwidth when accessed
> from a remote socket.
> 
> So, the question is: On systems with multiple sockets (and CXL mem
> attached to each socket), do you always assume the admin must bind to
> a specific socket for optimal performance or is there any plan to
> mitigate this problem without binding tasks to a socket?
>

There was a long discussion about this when initially implementing the
weighted interleave mechanism.

The answer is basically that interleave/weighted-interleave is
suboptimal for this scenario for a few reasons.

1) The "effective bandwidth" of a given node is relative *to the task*

   Imagine:
          A----B
          |    |
          C    D

   Task 1 on A has a different effective bandwidth from A->D than
   Task 2 running on B.  There's no good way for us to capture this
   information in global weights because...

2) We initially explored implementing a matrix of weights (cpu-relative)
   This had little support - so it was simplied to a single array.

3) We also explored task-local weights to allow capturing this info. 
   This required new syscalls, and likewise had little support.

4) It's unclear how we can actually acquire cross-connect bandwidth
   information anyway, and it's further unclear how this would be used
   in an automated fashion to do "something reasonable" for the user.

5) The actual use cases for weighted-interleave on multi-socket systems
   was questionable due to the above - so we more or less discarded the
   idea as untennable at best (or at least in need of much more thought)

So in short, yes, if the admin wants to be good use of (weighted)
interleave, they should bind to one socket and its attached CXL memory
only - otherwise the hidden chokepoint of the cross-socket interconnect
may bite them.

For now the best we can do is create global-relative weights, which
mathematically reduce according to bandwidth within a nodemask if the
task binds itself to a single socket.

~Gregory

