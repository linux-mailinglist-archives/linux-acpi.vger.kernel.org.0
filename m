Return-Path: <linux-acpi+bounces-19122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E35C70FBA
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 21:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 04AA82B6B7
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA61313273;
	Wed, 19 Nov 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTBWEzXT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001B31ED7E;
	Wed, 19 Nov 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582978; cv=none; b=oQLObUQ6lphzKaSSjGt/leihBSL74pktZ0AgO2Xff3cC93UJdcDDCico7DwQmEIO1eLJHqcEDuqTuRJvKhQT44KyA70NlS476/PJVuSiCm2w+QKuL6ZV7gfE4irAjZX7eC1SvuKpbBl1XU9nwgJFNq/ojx2NyrLrqhU4WklyMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582978; c=relaxed/simple;
	bh=csXQ3jv13Hi+tC+RGEzfEY46Xaln+wONRM6RuW7E20A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrn1kY/AFV3Jcv7qcYg3zamBaORr1PeIQpmEx7B0ObgTwcrUVxuzYCDx4OPHdNRc+jv/0K0kpDDmdhzzjX16IdhHCWYAVdx7wgOyBGzhQ6mQBzojUZ/Bdo9k51I4Ck2K8PCUpky9+f/dxdKLiSlAD4WbkbgxltsNoGo0ImBglpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTBWEzXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E56FC4CEF5;
	Wed, 19 Nov 2025 20:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763582976;
	bh=csXQ3jv13Hi+tC+RGEzfEY46Xaln+wONRM6RuW7E20A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTBWEzXTmeFGO55QIT6oupbvwDwUpgggVtpGnikSt82tZ2nUOKHkuqA3ISmqF8QcX
	 vYisBqwiuz0WEfjy6s/svnZWZTOzUOmXS5I53X6xI7LfO3Kd5OwCqa5lBFWPqDHE/3
	 cF/gdhvxAGXV04Xp4R5s4p8BFc0hkg6PrfY0NOqRrVOJ7jkPyorf0T4Bo36Ku4IxYD
	 Q4zVn5oBCcEYEA/Wld0ndgUyD0t2MTMR+uHwpKH58o0qxCE2jxoA0aIjzZUpluHPa9
	 yU23imw726vr3wqMMhrFFNOH3BlGeY+jDGVij9zix9bukjQ3LzjPpdgd1wVSBSvZlO
	 cdoSbAlY/iZ0A==
Date: Wed, 19 Nov 2025 12:09:34 -0800
From: Drew Fustini <fustini@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com,
	amitsinght@marvell.com, baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com, catalin.marinas@arm.com,
	dakr@kernel.org, dave.martin@arm.com, david@redhat.com,
	dfustini@baylibre.com, fenghuay@nvidia.com,
	gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
	jeremy.linton@arm.com, kobak@nvidia.com, lcherian@marvell.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org, peternewman@google.com,
	quic_jiles@quicinc.com, rafael@kernel.org, robh@kernel.org,
	rohit.mathew@arm.com, scott@os.amperecomputing.com,
	sdonthineni@nvidia.com, sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
Message-ID: <aR4j/pbRLQYdeA+K@x1>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <aRoG+UptQg9mix+7@x1>
 <753f4d26-efa9-4ffd-a820-7c2a53c0bc5f@arm.com>
 <aRz5S/gnT9mhqN+7@x1>
 <20251119100051.000018a0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119100051.000018a0@huawei.com>

On Wed, Nov 19, 2025 at 10:00:51AM +0000, Jonathan Cameron wrote:
> On Tue, 18 Nov 2025 14:55:07 -0800
> Drew Fustini <fustini@kernel.org> wrote:
> 
> > On Tue, Nov 18, 2025 at 02:11:31PM +0000, Ben Horgan wrote:
> > > Hi Drew,
> > > 
> > > On 11/16/25 17:16, Drew Fustini wrote:  
> > > > On Fri, Nov 07, 2025 at 12:34:17PM +0000, Ben Horgan wrote:  
> > > >> Hi all,  
> > > > [snip]  
> > > >> The rest of the driver can be found here: (no updated version - based on v3)
> > > >> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1  
> > > > 
> > > > Does anyone know of a hosting platform that offers ARM machines that
> > > > have MPAM?  
> > > 
> > > As far as I know there aren't any.
> > > 
> > > There is some MPAM support in the Orion Radxa board which is likely the
> > > cheapest option. The MPAM acpi table isn't in the firmware though so
> > > you'd need to load a custom table. James has this working.  
> > 
> > Thank you, I didn't realize that there was a dev board that supports
> > MPAM. I didn't want to the expense or noise of a rackable server :)
> > 
> > Drew
> > 
> Hi Drew,
> 
> Obvious not functional as such, but I did spin qemu emulation with a bunch
> of introspection so you could see what was configured.  Aim was to poke
> corner cases more easily than with real hardware. Did it's job at the time
> and shook out some bugs.
> 
> I haven't rebased it recently though.
> https://lore.kernel.org/qemu-devel/20230808115713.2613-1-Jonathan.Cameron@huawei.com/
> 
> https://gitlab.com/jic23/qemu/-/commits/mpam-2023-sept-01
> Has what looks to be a slightly more recent rebase.
> 
> No monitor support though.
> 
> I might bring this back to poke the rest of this series as it moves forwards
> (or if anyone else wants to they are welcome to do so)
> 
> FWIW we could in theory hook this up to the cache plugins to get some 'plausible'
> numbers, but I never bothered as we have hardware (as seen by tested-by's on this
> series).
> 
> Jonathan

Thanks for pointing out your series and the branch from James. Qemu is
the cheapest way for me to try MPAM :)

Drew

