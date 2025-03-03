Return-Path: <linux-acpi+bounces-11738-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C23A4C700
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020101775DB
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04085229B35;
	Mon,  3 Mar 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SDIXkAym"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D81215789
	for <linux-acpi@vger.kernel.org>; Mon,  3 Mar 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018798; cv=none; b=D1wch8/JjfmHy3t7bwNR0YO323XQeRhNAgwhpYJAWUOQ1yTsoT18IKQlBBlvDborMaczo0B/PQbmCTgtXSpWKoGIWICvkowQ7xCEnDw1AuuA6r/4w5hsKTZzgrJHl4q92u79c1tNyNbAK7tX616CRQZ4O2RemuRnCJmR10IRCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018798; c=relaxed/simple;
	bh=KaGmUQu6vX9CGkW4/xHWmqzfNUCeiOrjklvyH7jHB5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga5mJpuH1VATuX4qhJ1RNv+EYN9CgaJc13rxQwju3+efeEeC3FZCuELT5d8xyqoTfP9K1dl10R/ZMHs+E8ic3eWo30hNqy2EzOrstT2IInri0gnpHLQUZBnZTcmRwG8bsBWWn8GEIEKuSy7FC+KNvxkGexaDhZSX35WuX7PLBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SDIXkAym; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e89ccbbaa9so31849306d6.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Mar 2025 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741018796; x=1741623596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npU4Q2NKzI8EHqsYS1IQDm8fptT5XAkaolwjBVod8c4=;
        b=SDIXkAym6QpvZf/ycYItY0gcvJ2Luwu0rESmvOBnp9L0IiAeeSIiqJo9LLXMytzrqY
         0o7mwgOzQgpovHsxfS4k6qgWya1xhKzN5xUXD9qrE9mIULvuzfbWkHpSPqrjrAyHh3c4
         vpPedX2t2QblzbEEXUNLQlNj/dqCEGdK0SuTQsR3CUW0ONRAehtsruj3Y3rPu+9CiCgM
         9J1hEqHR3T6/moJESIaxrzZap1Culj9UjTZQy5XnxxBDHBMoYy8k3TPeXY1kr+HUFu/F
         1bszyMRAFFG9WVT4jCnVZwC5anw7GMdc4Kj253fIplivOnch3FRaXDWevLEjGpk2seY1
         B4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741018796; x=1741623596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npU4Q2NKzI8EHqsYS1IQDm8fptT5XAkaolwjBVod8c4=;
        b=TWniDD7XutXt7ApXXJynY6nH2gOYESfXbiANI5JO0izBhtTKD62/2vHWCwTQmfDART
         /cPgiftvXOQdJczDJhX3F+Og7R96u4bOWvPOGngOp5GwzLedxM+AEOwiGEWhzHs4FBWq
         PfOtnZU6F2yl6lqwUD2J+6mpMUtUdG3Wr7Fk4sFbfYoTcWRqduHyiu/aT2ch9KaF4qgd
         MUDmEzqjSg2lKFttbmJ1UpSIEIZcpE5kLoy4nYl6dSK+X6cXQrP4YD3FtilVAWCoh3N3
         Vs42yqUXjm7IFtPkZUZ67GXFTtZPQBa3U/Up2PHtl0EpKs/IP3pZF4JEWm1Hgmh9fQrX
         qXzA==
X-Forwarded-Encrypted: i=1; AJvYcCVlk02mTE8bHrZewuMLUW3xDNOXywrz/G7fMNkie5+PKXOYvV0w05jspzJJv3clbyOR0UVYeMHbUxO5@vger.kernel.org
X-Gm-Message-State: AOJu0YygypyqfGcMMKC1qtZI6Oj4bHmjU+y7ZJhf3MlrdWSPECIPJCQT
	rzJOHbE5DLPm7Xbw/jEi8PBDUh/gxH7jt8Dlzp4sPUs204/wuSgIYpT//HjcuaA=
X-Gm-Gg: ASbGncv/7dWKNkHSynXWURroe80RPPyR6Ox2Be2BlcpGsnCD+Soe3zNEGUtPwYs0hdM
	LQO6FvtC4f4G8/C8pYOWc6/wWuB4eWt9++9xwQ9Igs0PB96Lc7a4Sv5wCXBJgh5DPveO6Z2M42m
	ulApNL9q60A9ays+S9Vss+zR1MKKXn7cdYspZYT6NQCyUPKOAmEIO6HrT7GY+UTSd0MtnNpAbqK
	qUOUjK5sVW0eSrUCXAN66mtLEMWNFOiXlMvkd26Eu2rpsTHznWak2AFfWl8nuGeo4EuKe4+Jlr4
	5TM5ewCSeuei8vpBc8VioCIYa0pivj/uwFEkpA5HMYmke0hkzNdbVAxqfU0IP5ZaFwancNRMH8R
	YCxXPaghKvVOBl8ZTK0jJFjF7rIs=
X-Google-Smtp-Source: AGHT+IFrkNQWQ1CiJuDWkCSRKag4xlr1szBO39O50NkgwvocW88WS9f8hGcizY9NgWfP7fb3nWp2Qw==
X-Received: by 2002:a0c:c387:0:b0:6e8:adee:2e6a with SMTP id 6a1803df08f44-6e8adee2f29mr134420576d6.36.1741018796194;
        Mon, 03 Mar 2025 08:19:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec0f8sm54776936d6.120.2025.03.03.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:19:55 -0800 (PST)
Date: Mon, 3 Mar 2025 11:19:53 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, harry.yoo@oracle.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	gregkh@linuxfoundation.org, rakie.kim@sk.com,
	akpm@linux-foundation.org, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 2/2 v6] mm/mempolicy: Don't create weight sysfs for
 memoryless nodes
Message-ID: <Z8XWqQdPC7245FA2@gourry-fedora-PF4VCD3F>
References: <20250226213518.767670-1-joshua.hahnjy@gmail.com>
 <20250226213518.767670-2-joshua.hahnjy@gmail.com>
 <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com>

On Thu, Feb 27, 2025 at 11:32:26AM +0900, Honggyu Kim wrote:
> 
> But using N_MEMORY doesn't fix this problem and it hides the entire CXL
> memory nodes in our system because the CXL memory isn't detected at this
> point of creating node*.  Maybe there is some difference when multiple
> CXL memory is detected as a single node.
> 

Hm, well, the node is "created" during early boot when ACPI tables are
read and the CFMW are discovered - but they aren't necessarily "online"
at the time they're created.

There is no true concept of a "Hotplug NUMA Node" - as the node must be
created at boot time. (tl;dr: N_POSSIBLE will never change).

This patch may have been a bit overzealous of us, I forgot to ask
whether N_MEMORY is set for nodes created but not onlined at boot. So
this is a good observation.

It also doesn't help that this may introduce a subtle race condition.

If a node exists (N_POSSIBLE) but hasn't been onlined (!N_MEMORY) and
bandwidth information is reported - then we store the bandwidth info
but don't include the node in the reduction.  Then if the node comes
online later, we don't re-trigger reduction.

Joshua we should just drop this patch for now and work with Honggyu and
friends separately on this issue.  In the meantime we can stick with
N_POSSIBLE.

There are more problems in this space - namely how to handle a system
whereby 8 CXL nodes are "possible" but the user only configures 2 (as
described by Hyonggye here).  We will probably need to introduce
hotplug/node on/offline callbacks to re-configure weights.

~Gregory

