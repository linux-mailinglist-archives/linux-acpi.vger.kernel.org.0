Return-Path: <linux-acpi+bounces-11798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C48A4E87B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 18:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CEC3BD7D0
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A808429C328;
	Tue,  4 Mar 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UNO9JsI2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9F298CD5
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105792; cv=none; b=T6KTowxbvah3EPGgLMba//9TS/58j7ClSoF3/8N3bWJc91k1Z8/GbSLugWI9EJU1++mCLiknYuKqK+p65nzm6gQ8CRF4RN5HnyEUaJHZUGSZUu0aUiyGgRITz2VTK3gyTUmY5b7ko/J4+0wQROqdd7yxKkUmsX1Y14oLZHryd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105792; c=relaxed/simple;
	bh=kiv6AaqSpJxAijF0/1SHB3o+7J9EXmFBMjz6bN80ws4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqoPCFzm5mNRIJemPXsijlKelV/zfna8L+4W7biemSFsOnwcCzubShfqMGoF7U7sM/n5ByK8LFzCzMvVHZktOkIE5EJ60sfPIsMhhsyp70V9OAF06Bc2S78UXvvVkQLo3TO/FY8ShbqqoknictiF4UKMUeyne3+7pH3CzWe+kUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UNO9JsI2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd1962a75bso46078256d6.3
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2025 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741105789; x=1741710589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UWPCN4uO5+hoNKPd6bzLCSnzU/reuMIMfkocTwKPZQ=;
        b=UNO9JsI2ekO7uia3Q2AxFQvfoaTlJ2yb9sa8+ARAA78Zgio3x3nQuwsGVmzwEEsfFZ
         sZNcSCZNgOYtvFN+m38sIvG4cP046vGXjQPdzKCUhnZyNTd96+h2sxXoepbixbHO6umu
         /Os6Jfb3s5u92wBu3vCO1TfzBYcLfIbNWkjHGDn+BCBlHVZ4e0IjaQWBlix7nmwKPUob
         1CpvglWlP9RzrUwj/2JdwvygUoFvP0tYBJw7+cIYPrhWzvc0LuhgZQK3wlUGUNRUNh6D
         RdjOU/eHVKHeBNOs8b5ZXykilLBh81QNhtVnKYgzfmRYgzwMB09NwjEWDxl7b3JKA7bZ
         DR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105789; x=1741710589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UWPCN4uO5+hoNKPd6bzLCSnzU/reuMIMfkocTwKPZQ=;
        b=hiIqOItXSDQeHaWOn6F7tNFGkdFzaOL5IrGf0jXBdT5sv5wMbzckHS5q2VimcIMfKv
         VSQiWTB0ekZynSrEAUW5rboZgouRiveLflQWZUVcAwMPKbHyLubhIqGj9iaGPPD21Un9
         xtQCCnCvBcdtzORn9KCuKMMiCjiK+9PKKGLKZ1i1WiOgeySopWAdfQEDcbWDzfQXiQdS
         wAHcTbJJyNaWI0FBuDgaRCCZpM3ZzRg4wOvyK/7WFjJmrCDHZtE0U39x3AxAA989vkkG
         KczIsZnNNVTz04T9d8/Rk2LZZLviSySNQZtQYsEAGn950g/gPMumJ4yfGVMDfCJteaOT
         6acg==
X-Forwarded-Encrypted: i=1; AJvYcCUBw01Es4Z/UV5Nwnbssau5hCWUS6Ov/aB59E8vzHtkp9YZNHVePW8ra2AEGMuzxZHEsk5J9dayBLcM@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSwv5j81oysdhY4AayMEMAim5dwhjWOsw/n1x6RcdOrlmG9Fw
	hjUTXwHN8VEbfNX3Kg9YJsYMGBsUNKuDOD2v37pJTiG9aZX07qMrixdrDiBhilo=
X-Gm-Gg: ASbGncsEvlu0HpqhrVDTdsBQ5rvRdUtnPegQU3vn8zWfH77QjCzTOp/sHs6/sPQHfdO
	LEIesYF1xwWlBFcGxjbTsjsAj7hY0/+tOzS4orX19cZjqWLLAI6WIz8qwSOVMkdI+MIvUoQNzvn
	tPwepPBHrcEMWp2NV7TFtFp0bixHV7EbPJx4RZnZIUPc2eRSIxuDawLlvlh8/h/4LgVtoPENo0K
	tOJ1yscTdrEOsoqSUgOSzigdO9hPJDkad0Cnh1NXbeROFfpxIDOVvW0BfRd6mBePBP38hE3NuA1
	DlXht0n0CfzA5SbUpNx+KmQDFurvSrWY1F3Pi/WihPblfsfvAXOjc1ZpuxvEUR/FZsw62oA7imx
	UbIgD6//gnxm9TMtMVvreabKKlws=
X-Google-Smtp-Source: AGHT+IG9pNkV8/om2bZpdkllwH5Qnrkj8fkgcns8KwfxMTIBktUTXJgujzar75xsqgH+g9ThSEfa3Q==
X-Received: by 2002:a05:6214:19cd:b0:6d8:b371:6a0f with SMTP id 6a1803df08f44-6e8a0d8f94fmr290391966d6.31.1741105789533;
        Tue, 04 Mar 2025 08:29:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8b0af29ebsm43033196d6.89.2025.03.04.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:29:49 -0800 (PST)
Date: Tue, 4 Mar 2025 11:29:47 -0500
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
Message-ID: <Z8cqe3BCdobsV4-2@gourry-fedora-PF4VCD3F>
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
> Actually, we're aware of this issue and currently trying to fix this.
> In our system, we've attached 4ch of CXL memory for each socket as
> follows.
> 
>         node0             node1
>       +-------+   UPI   +-------+
>       | CPU 0 |-+-----+-| CPU 1 |
>       +-------+         +-------+
>       | DRAM0 |         | DRAM1 |
>       +---+---+         +---+---+
>           |                 |
>       +---+---+         +---+---+
>       | CXL 0 |         | CXL 4 |
>       +---+---+         +---+---+
>       | CXL 1 |         | CXL 5 |
>       +---+---+         +---+---+
>       | CXL 2 |         | CXL 6 |
>       +---+---+         +---+---+
>       | CXL 3 |         | CXL 7 |
>       +---+---+         +---+---+
>         node2             node3
> 
> The 4ch of CXL memory are detected as a single NUMA node in each socket,
> but it shows as follows with the current N_POSSIBLE loop.
> 
> $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
> node0 node1 node2 node3 node4 node5
> node6 node7 node8 node9 node10 node11

This is insufficient information for me to assess the correctness of the
configuration. Can you please show the contents of your CEDT/CFMWS and
SRAT/Memory Affinity structures?

mkdir acpi_data && cd acpi_data
acpidump -b
iasl -d *
cat cedt.dsl  <- find all CFMWS entries
cat srat.dsl  <- find all Memory Affinity entries

Basically I need to know:
1) Is each CXL device on a dedicated Host Bridge?
2) Is inter-host-bridge interleaving configured?
3) Is intra-host-bridge interleaving configured?
4) Do SRAT entries exist for all nodes?
5) Why are there 12 nodes but only 10 sources? Are there additional
   devices left out of your diagram? Are there 2 CFMWS but and 8 Memory
   Affinity records - resulting in 10 nodes? This is strange.

By default, Linux creates a node for each proximity domain ("PXM")
detected in the SRAT Memory Affinity tables. If SRAT entries for a
memory region described in a CFMWS is absent, it will also create an
node for that CFMWS.

Your reported configuration and results lead me to believe you have
a combination of CFMWS/SRAT configurations that are unexpected.

~Gregory

