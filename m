Return-Path: <linux-acpi+bounces-10264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C085E9FA480
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 08:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693041656D6
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Dec 2024 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E665156960;
	Sun, 22 Dec 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MzUIV5+8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A8646;
	Sun, 22 Dec 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852106; cv=none; b=HSbCJz1C4PzaO/fxKA+DkEbjZ/ihzJzdhauuTMecEuVkRfu7O/Os11KkLUnjhyhkitbVqTCG4y4BSHXgyrcYD6el+BiSXl93wMPHdde1iqGEVRVm/guTlsu7qkOw4CfrmwrKJ+0JtJTHpIH/JTH8FtQxxCsXI/DbPIs/DUHw8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852106; c=relaxed/simple;
	bh=qbI5A9iuI+dKAbv+U/IcRqV4hJYbjHkDm51G6/G3BnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MvjT5mUYkCNhR+FSrzlTS+CGfc10BpNvONrXQ8UNtAIU0IempMSeyfD2Q9Vx2q2FrRq57G1QBJlkDMbgZ2BNAv/+ni/FMY0zKZnFUSD0tIMDPMchLbdNwaW0vfCD4vCnI5JHo5ihpcBxsWrfgr30eghFx6mgwcpDpBG4qfV51Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MzUIV5+8; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734852095; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=SbGmiwWnfjUy06RsJhi7C/4y9GNOaXoragBrl+X4c+8=;
	b=MzUIV5+8ik8ECsbPZisENGUvzb/QKQfqVcdLokWmbfJg9hf63TYbab6cQKj5eLu3MlQ6HwsJJ6sludmgW4ygiVCFntGKpsjPmpWm3OcDTE3Je6Kf28pdbU2QjD6MvHd5U9acsMHP93px2BnDa3McBzpI+SWEyzjbvxgZ+FJYqqo=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WLyCFA-_1734852092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Dec 2024 15:21:33 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,  "gourry@gourry.net"
 <gourry@gourry.net>,  kernel_team@skhynix.com,  42.hyeyoo@gmail.com,
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
In-Reply-To: <3682b9cf-213c-497d-ab81-f70e1a785716@sk.com> (Hyeonggon Yoo's
	message of "Fri, 20 Dec 2024 17:25:28 +0900")
References: <20241219191845.3506370-1-joshua.hahnjy@gmail.com>
	<3682b9cf-213c-497d-ab81-f70e1a785716@sk.com>
Date: Sun, 22 Dec 2024 15:21:32 +0800
Message-ID: <87r060i3nn.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hyeonggon Yoo <hyeonggon.yoo@sk.com> writes:

> On 2024-12-20 4:18 AM, Joshua Hahn wrote:

[snip]

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

If multiple sockets are considered, what is the best behavior?

The process may be cross-socket too.  So, we will need to use
set_mempolicy() to bind tasks to sockets firstly.  Then, it may be
better to use per-task weights.

> So, the question is: On systems with multiple sockets (and CXL mem
> attached to each socket), do you always assume the admin must bind to
> a specific socket for optimal performance or is there any plan to
> mitigate this problem without binding tasks to a socket?
>

[snip]

---
Best Regards,
Huang, Ying


