Return-Path: <linux-acpi+bounces-7157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8D942417
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 03:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9351C22559
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0034748F;
	Wed, 31 Jul 2024 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUvlHVRE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F98BE0;
	Wed, 31 Jul 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388437; cv=none; b=IMzQL1blVVMzstpCo2kW09kMYm2Y4pSTGisYIO3/t6VobpQzoMXp9SuYpQReQji1yAk++XiYZ3PDOZeK2miqllUyxNK8atrT1MrkXQjIWuXM/DFRDXvwUu7vnfbKGE79NBGofD/dSw3sFs7zYyQdLi3y/j/rF8Y5VB/MsUDV3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388437; c=relaxed/simple;
	bh=78yMmcZVlmd5TrKBTEgQshl8q07jNsjdTZNobhmCpJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C4CejOeYwe3r718cN3faEsK+ul1IaoYXLIsLiCTmx8qljM12P2YcLIMErDX5HUif/D2c9mCAK8r4zDpE2UwraU5k/JGV92cZCIsJAgncXkHJU9LxWH+6hx2d+lK4rLafkaaWGLTKmHq9U6JAxJgumDCz0cdVYabxTrNsIpU96yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUvlHVRE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722388436; x=1753924436;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=78yMmcZVlmd5TrKBTEgQshl8q07jNsjdTZNobhmCpJc=;
  b=VUvlHVREwEmZmAzCJ0byLTIyXG9daLQ8CLNzocZZiqiEkzjrt6kkKnh5
   4QZIJFoIW3vIo9EXD/qy4GDtzSf349bFEgA/FEXyoJC+1sJFvftpYwYj1
   Jul03nPvv5o3hYajpJvdgU3L6geO2klV+KEunfpcdoXShABCjlHtVeNRo
   Nj4KqwQcc/Y2YZeWOV0/FXO3+/CwEF13NIA5E51ZtIq3uBuQ85t++K8Kt
   FwYk7t6dO4qlvCMgkMIUM0G23RmXROxUASMaIAAGLSgQBe0m3kmP2zLPy
   qb7BxsC7S4oepg1kX4Tl+RBr1g6ucoNcMBXoeYXGunnRSHLD+dMMsMOvC
   g==;
X-CSE-ConnectionGUID: YBuZtQi7S22zy/KUDy9Rpw==
X-CSE-MsgGUID: XSEdjM0vTQuM5Mf1bMqxhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20397516"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="20397516"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 18:13:55 -0700
X-CSE-ConnectionGUID: 65vHl553Q8esf4wM6tUaew==
X-CSE-MsgGUID: vL7bv7S2RJuHoCdf/QA5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54561071"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 18:13:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  dave.jiang@intel.com,
  Jonathan.Cameron@huawei.com,  horenchuang@bytedance.com,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  dan.j.williams@intel.com,  lenb@kernel.org,  "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
In-Reply-To: <Zqh3-TWBkhyY5kPw@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Tue, 30 Jul 2024 01:19:53 -0400")
References: <20240726215548.10653-1-gourry@gourry.net>
	<87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
	<877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zqh3-TWBkhyY5kPw@PC2K9PVX.TheFacebook.com>
Date: Wed, 31 Jul 2024 09:10:19 +0800
Message-ID: <87h6c6pds4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Tue, Jul 30, 2024 at 09:12:55AM +0800, Huang, Ying wrote:
>> > Right now HMAT appears to be used prescriptively, this despite the fact
>> > that there was a clear intent to separate CPU-nodes and non-CPU-nodes in
>> > the memory-tier code. So this patch simply realizes this intent when the
>> > hints are not very reasonable.
>> 
>> If HMAT isn't available, it's hard to put memory devices to
>> appropriate memory tiers without other information.  In commit
>> 992bf77591cb ("mm/demotion: add support for explicit memory tiers"),
>> Aneesh pointed out that it doesn't work for his system to put
>> non-CPU-nodes in lower tier.
>> 
>
> Per Aneesh in 992bf77591cb - The code explicitly states the intent is
> to put non-CPU-nodes in a lower tier by default.
>
>
>     The current implementation puts all nodes with CPU into the highest
>     tier, and builds the tier hierarchy by establishing the per-node
>     demotion targets based on the distances between nodes.

This describe the behavior before the commit.  That is, to be changed in
the commit.  One of the most important issues he want to fix is,

    * The current tier initialization code always initializes each
      memory-only NUMA node into a lower tier.  But a memory-only NUMA node
      may have a high performance memory device (e.g.  a DRAM-backed
      memory-only node on a virtual machine) and that should be put into a
      higher tier.

> This is accurate for the current code
>
>
>     The current tier initialization code always initializes each
>     memory-only NUMA node into a lower tier.
>
> This is *broken* for the currently upstream code.
>
> This appears to be the result of the hmat adistance callback introduction
> (though it may have been broken before that).

No, this was changed in Aneesh's commit 992bf77591cb.

--
Best Regards,
Huang, Ying

