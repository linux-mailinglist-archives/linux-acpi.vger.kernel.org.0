Return-Path: <linux-acpi+bounces-13789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5578ABB304
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 03:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1097A4726
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 01:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DB61B042E;
	Mon, 19 May 2025 01:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvXgDzPD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E111185;
	Mon, 19 May 2025 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747619772; cv=none; b=o1I+LTdWpCQLnarqDlvGEfprHl5FWktyKGpaknOK40TsW3+GtzLHk1tPlsoJ6N3MbN/7sEfjX9lXgjRqEmaHzANxA3IcJC+kaaiCKaQ7rqbINlr4v66FNGxtbOHU/OwKyVfFDmUzHezZknLjZfLCcxWREJQSiASarkKNJDbKjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747619772; c=relaxed/simple;
	bh=cb+d/DwEk3yRnKOKUSPKMNBhhmU40NcChrRFuyGKSec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXL8O472S76e1Yxj7EcXb0DyI9ZXbKeB6/CqH7qQX/tofCnS5vmAVwhjI8LZjcnrskq+9ls0eVL2nim4eDCV79tlo4eEBwIzmSxL0P9eQZqopwGaUkVQ1pUI1SihwXIjF+Ka7Pl5aOloAobSdzUsNXnxgP/1b37uVe9ivfnpXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvXgDzPD; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7b97c6159aso547335276.1;
        Sun, 18 May 2025 18:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747619770; x=1748224570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DQgWIwpKftDflC835+KBihfO87t9DUCdy0HWOf1jK8=;
        b=BvXgDzPDkTKxTSxtw1YVBKKrnioCJg7gbxVRpBLtiY7SHvdvRsKn8H7BydKO3tyhmM
         WaQqosggKK0IztYkTB2BXck8wx+37zaSXeDNnadUcWe1jK8a3M016jIbArAUxNI4qgT7
         MBEbPCmPTzB6Lu5+yTu9UyHLr5OCjDe9Dz2qVFS33P0fsQYw//FYh0/2fTb7tpg4cJih
         1lGqR8m1TrhIjioaP7ybTirfyQjH1zX4EZNW+pymiL5mRKKz2UcU+U3hdyaqWCH7Azwj
         JjXcQeqMTDrG4W64xukFK6XxyPXL7vd4EanjGb+TlCFkHppOlEOx2pW7LoI8grUGGm21
         0sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747619770; x=1748224570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DQgWIwpKftDflC835+KBihfO87t9DUCdy0HWOf1jK8=;
        b=tUc9P8rR5vluWmlWXEkpLWl5Y9kHT/CEFLYfQkUFNYMBhcxvd3aJttiIWHQpOp2l2l
         AU7IWz7CaxARUaG5FUtWBF6xrOO0s8geDbLU59eIOoymF3FqjBkVASAkDGQU54sItaNj
         pd8/KHBk7Jkmx7xWgw77dM8a4UJDb6/iCRtyqdJaOYkRmKpYIRblmX3G2zyegLdTmBEv
         cYb5IE0QviqXm64niJVvnT25W+6XuuiQSgIf+rk9p5n0lFPDCQLM42vJZlokixQeaI08
         joWR328V7uOFbsAtk0vpMrxtIBFkxiyMIEMWutHccEjSO7+4FhgD+Ge3/WfPtdMiimSf
         +i0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe1NUyW6ZRqQmZnqQfuPAEMmHZK7bZ/hlh17hSUHsvfchaRQSgJCbErV8hsMBIYzTE6WsBmPXZliOd@vger.kernel.org, AJvYcCWwldJEnNGySeDcCbvgDXibMGphBPCpuDBiLoXI0ODIHf6VKtzpFJSakmwgMxgzmDxtrxmMLLP7hH16pVwg@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgVOX9WEAICW8lUf5fnMTDUuf8xfAVFXGx7E0znZDmnFN5e9H
	iv6OdbQerheMUgFJV9y0mQv9IEGKZL1nJCw7LeeLNJ4YxA9otEfjJX6y
X-Gm-Gg: ASbGncsM+ivVGsoYK5uQRu/O77G0e4xtbtx1qK0j9ME5YoAP49mX/H4jDGATbo3lAxN
	nWu34JcEGg+QQImST1iP+774p1kCxvo68iM9lWT93oupOyPx1rXCG5IybOyUqU6Z/givN9UXoXt
	RJqnYUjAMj6MiIkCj/Hb2jvOI0myqFUYGyFE+rpnaZAnK+LuXRQUoe3WsiO6EcFyTwhneEDqwv7
	5hvBDaIAoXaxr4GWRT46J7d8OV+j7k/QGt3s2num0uMppjFA3eS9wetxVYL/0dUC+6NWxzJLz73
	Pq7tvvdvXeoGjIjxj6b4YMiODZAmGe491WjPcvTDXIlvLbCmUA==
X-Google-Smtp-Source: AGHT+IGAszD8bTKPIxGwCxe0ZUbm32eYI5M+akiUC4Ga9sKQDswHwHV2jvKw35mT6laDiCm2+HhJag==
X-Received: by 2002:a05:6902:20c7:b0:e79:1e9:59f6 with SMTP id 3f1490d57ef6-e7b6b1bace5mr14392212276.17.1747619769610;
        Sun, 18 May 2025 18:56:09 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6ac68338sm2367815276.12.2025.05.18.18.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 18:56:08 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gregkh@linuxfoundation.org,
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
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
Date: Sun, 18 May 2025 18:56:06 -0700
Message-ID: <20250519015606.378475-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505182328.4148265-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Andrew,

Perhaps at this point it is best to just send a v9? : -)
The v9 will include: 2 code fixlets, as suggested by Ying Huang
And adding tags from both Honggyu and Ying.

I just thought it would be difficult to track 4 fixlets, but please let me
know whatever works best for you! Thank you always for your help. I hope you
have a great day!
Joshua

On Mon,  5 May 2025 11:23:28 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across nodes according to user-set ratios.
> 
> Ideally, these weights should be proportional to their bandwidth, so
> that under bandwidth pressure, each node uses its maximal efficient
> bandwidth and prevents latency from increasing exponentially.
> 
> Previously, weighted interleave's default weights were just 1s -- which
> would be equivalent to the (unweighted) interleave mempolicy, which goes
> through the nodes in a round-robin fashion, ignoring bandwidth information.
> 
> This patch has two main goals:
> First, it makes weighted interleave easier to use for users who wish to
> relieve bandwidth pressure when using nodes with varying bandwidth (CXL).
> By providing a set of "real" default weights that just work out of the
> box, users who might not have the capability (or wish to) perform
> experimentation to find the most optimal weights for their system can
> still take advantage of bandwidth-informed weighted interleave.
> 
> Second, it allows for weighted interleave to dynamically adjust to
> hotplugged memory with new bandwidth information. Instead of manually
> updating node weights every time new bandwidth information is reported
> or taken off, weighted interleave adjusts and provides a new set of
> default weights for weighted interleave to use when there is a change
> in bandwidth information.
> 
> To meet these goals, this patch introduces an auto-configuration mode
> for the interleave weights that provides a reasonable set of default
> weights, calculated using bandwidth data reported by the system. In auto
> mode, weights are dynamically adjusted based on whatever the current
> bandwidth information reports (and responds to hotplug events).
> 
> This patch still supports users manually writing weights into the nodeN
> sysfs interface by entering into manual mode. When a user enters manual
> mode, the system stops dynamically updating any of the node weights,
> even during hotplug events that shift the optimal weight distribution.
> 
> A new sysfs interface "auto" is introduced, which allows users to switch
> between the auto (writing 1 or Y) and manual (writing 0 or N) modes. The
> system also automatically enters manual mode when a nodeN interface is
> manually written to.
> 
> There is one functional change that this patch makes to the existing
> weighted_interleave ABI: previously, writing 0 directly to a nodeN
> interface was said to reset the weight to the system default. Before
> this patch, the default for all weights were 1, which meant that writing
> 0 and 1 were functionally equivalent. With this patch, writing 0 is invalid.
> 
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
> 
> Suggested-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Co-developed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---

