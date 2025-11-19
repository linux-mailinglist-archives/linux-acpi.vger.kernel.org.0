Return-Path: <linux-acpi+bounces-19072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D24C6DDB7
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 11:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 450622DE61
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDD933C522;
	Wed, 19 Nov 2025 10:01:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F2329C7C;
	Wed, 19 Nov 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546460; cv=none; b=iOPJ0elVOQIswTg0nPEzWTfEijmUmQz3IN/cDEYNf2HW4bInX5ijm1jM74PUOvp1PmSh2bvZu2zx1LPHBd80E/rLfkkCwvDjj1kA9kBMXWzX11ogNwjqZkw7u9X+KWKNIsSK75RxICPNA6tInqZn0bogfVOar1hx9EVMyBGxIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546460; c=relaxed/simple;
	bh=7bPlwgIBBdtIQHHWoI7EnSculCS8P0Y4e3k0uNVXk0k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRvXDbpipSdxikJvH9PE/veN6iV3JsCAb6q+OPRKO2tYQ7PHOuyln3fz/zHx2Bne6CzqE3TN3ELODZn+fgIQW1o0ISWQQCDgHPeXiVTBFxq2bhgIL3UydLvwq+SD1iDYH2kWWBBghI0dlcQa2bKOslSRqZlVLZ98EHYxJsDcRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBH6G0VxxzHnH5T;
	Wed, 19 Nov 2025 18:00:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B1071401DC;
	Wed, 19 Nov 2025 18:00:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 19 Nov
 2025 10:00:53 +0000
Date: Wed, 19 Nov 2025 10:00:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Drew Fustini <fustini@kernel.org>
CC: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>,
	<amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<guohanjun@huawei.com>, <jeremy.linton@arm.com>, <kobak@nvidia.com>,
	<lcherian@marvell.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
Message-ID: <20251119100051.000018a0@huawei.com>
In-Reply-To: <aRz5S/gnT9mhqN+7@x1>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<aRoG+UptQg9mix+7@x1>
	<753f4d26-efa9-4ffd-a820-7c2a53c0bc5f@arm.com>
	<aRz5S/gnT9mhqN+7@x1>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 18 Nov 2025 14:55:07 -0800
Drew Fustini <fustini@kernel.org> wrote:

> On Tue, Nov 18, 2025 at 02:11:31PM +0000, Ben Horgan wrote:
> > Hi Drew,
> > 
> > On 11/16/25 17:16, Drew Fustini wrote:  
> > > On Fri, Nov 07, 2025 at 12:34:17PM +0000, Ben Horgan wrote:  
> > >> Hi all,  
> > > [snip]  
> > >> The rest of the driver can be found here: (no updated version - based on v3)
> > >> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1  
> > > 
> > > Does anyone know of a hosting platform that offers ARM machines that
> > > have MPAM?  
> > 
> > As far as I know there aren't any.
> > 
> > There is some MPAM support in the Orion Radxa board which is likely the
> > cheapest option. The MPAM acpi table isn't in the firmware though so
> > you'd need to load a custom table. James has this working.  
> 
> Thank you, I didn't realize that there was a dev board that supports
> MPAM. I didn't want to the expense or noise of a rackable server :)
> 
> Drew
> 
Hi Drew,

Obvious not functional as such, but I did spin qemu emulation with a bunch
of introspection so you could see what was configured.  Aim was to poke
corner cases more easily than with real hardware. Did it's job at the time
and shook out some bugs.

I haven't rebased it recently though.
https://lore.kernel.org/qemu-devel/20230808115713.2613-1-Jonathan.Cameron@huawei.com/

https://gitlab.com/jic23/qemu/-/commits/mpam-2023-sept-01
Has what looks to be a slightly more recent rebase.

No monitor support though.

I might bring this back to poke the rest of this series as it moves forwards
(or if anyone else wants to they are welcome to do so)

FWIW we could in theory hook this up to the cache plugins to get some 'plausible'
numbers, but I never bothered as we have hardware (as seen by tested-by's on this
series).

Jonathan

