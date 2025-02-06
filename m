Return-Path: <linux-acpi+bounces-10919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B70A2AE1E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 17:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CE018832D7
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB723537A;
	Thu,  6 Feb 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMMu1uVL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCE23536E;
	Thu,  6 Feb 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860598; cv=none; b=RgoZDmxX1EzxTLr3dmymFtdw/76YBzVxsudkAhJBMquZ3WdWhVHiEFuP75fzMQkC0vh8nYdTCcqv9ahBfBMVhIpJc3ziKgj7rmoPWAx8epUKVRfvcixn0SMI5JAZyN/wRlKiPOZiIx+dcfXs1bkRJn0/czU4HH2GDInlsxF/Bl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860598; c=relaxed/simple;
	bh=j3FroCLQS9G/TBoEWUPAACAsumiBdvLwh/CVGusffo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssj1Zob29jNcrS7mAcHbtoBKiVF/Fc9+e+y7eVtjOwrRIUNViZbfM8St9UF/UyzfZ2p/K6pd1R+NTZX8UXkQ8sJbtkh9jg4QqD/tKRJBncAvhpfF53kQGs1ooUQrnuagRRBuHPlt8QpxvkFxyRr8W9ieyDEgNjULACU96A2BeN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMMu1uVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AF5C4CEDD;
	Thu,  6 Feb 2025 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738860598;
	bh=j3FroCLQS9G/TBoEWUPAACAsumiBdvLwh/CVGusffo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMMu1uVLA2mXPr2CH5I21YK1Nf4pmr9kQu3ugPUIccf4PCL8uDHQwPbrqy4i2/7C5
	 aBGTv0yTm/cVMpv011C5NUmA7pLhFwSz0OOW3UgfipokcslX8hgb3rxmITQTcP8SL0
	 H2guLeZ5s/qxMdM4655yVHPlI9WRkBfjm+iU7QOktNtbpl1yexqlovkmc9K6CgtkY5
	 Y6/6PMvR54HbwLqMUTZpiMy7Lt6JJmbRH9enUdoDEuFgkcxmGuijKX2/v2hgvXglOO
	 LufUXxRcWtxK/RMmBo5l5BvXRrdCKGLRRqG2auU3d25wGZFFTQifVNdlND+Q/yvpHf
	 zCP+FP+0/cV+w==
Date: Thu, 6 Feb 2025 09:49:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab+huawei@kernel.org, roberto.sassu@huawei.com,
	shiju.jose@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v3] acpi: Fix HED module initialization order when it is
 built-in
Message-ID: <20250206164953.GC180182@ax162>
References: <20250117022957.25227-1-tanxiaofei@huawei.com>
 <20250120110417.00000a57@huawei.com>
 <58a450bb-55d1-5415-4b67-9d61603ce48e@huawei.com>
 <CAJZ5v0ihVJBX0bLqrL-61=LKVoZJOg3RpJykp80uOMf_7YcG+A@mail.gmail.com>
 <20250129043329.GA2344109@ax162>
 <07dd4187-6a62-0a32-d9b8-c2a6dacc9606@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07dd4187-6a62-0a32-d9b8-c2a6dacc9606@huawei.com>

Hi Xiaofei,

On Thu, Feb 06, 2025 at 10:44:13AM +0800, Xiaofei Tan wrote:
> 在 2025/1/29 12:33, Nathan Chancellor 写道:
> > On Thu, Jan 23, 2025 at 08:35:51PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Jan 21, 2025 at 3:23 AM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
> > > > 
> > > > 在 2025/1/20 19:04, Jonathan Cameron 写道:
> > > > > On Fri, 17 Jan 2025 10:29:57 +0800
> > > > > Xiaofei Tan <tanxiaofei@huawei.com> wrote:
> > > > > 
> > > > > > When the module HED is built-in, the module HED init is behind EVGED
> > > > > > as the driver are in the same initcall level, then the order is determined
> > > > > > by Makefile order. That order violates expectations. Because RAS records
> > > > > > can't be handled in the special time window that EVGED has initialized
> > > > > > while HED not.
> > > > > > 
> > > > > > If the number of such RAS records is more than the APEI HEST error source
> > > > > > number, the HEST resources could be occupied all, and then could affect
> > > > > > subsequent RAS error reporting.
> > > > > > 
> > > > > > Change the initcall level of HED to subsys_init to fix the issue. If build
> > > > > > HED as a module, the problem remains. To solve this problem completely,
> > > > > > change the ACPI_HED from tristate to bool.
> > > > > > 
> > > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Given the change in approach (even though I reviewed this internally)
> > > > > should probably have dropped my RB.   Anyhow, consider this me
> > > > > giving it again on list.
> > > > OK. thanks.
> > > Applied as 6.14-rc material with a rewritten changelog and under a new
> > > subject: "ACPI: HED: Always initialize before evged".
> > > 
> > > Thanks!
> > For what it's worth, I just bisected a new error message that I see when
> > booting several x86_64 distribution configurations in QEMU to this
> > change in -next as commit 19badc4e57c6 ("ACPI: HED: Always initialize
> > before evged"):
> > 
> >    $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config
> > 
> >    $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- olddefconfig bzImage
> > 
> >    $ qemu-system-x86_64 \
> >          -display none \
> >          -nodefaults \
> >          -M q35 \
> >          -d unimp,guest_errors \
> >          -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
> >          -kernel arch/x86/boot/bzImage \
> >          -initrd rootfs.cpio \
> >          -cpu host \
> >          -enable-kvm \
> >          -m 512m \
> >          -smp 8
> >          -serial mon:stdio
> >    ...
> >    [    0.535126] Error: Driver 'hardware_error_device' is already registered, aborting...
> 
> It seems that the startup script of the test case loads some fixed ko, even when the bzImage changed.
> 
> If so, we could update the rootfs.cpio. This may introduce some adaptation work, if you want to roll
> 
> this patch to some distribution. I think we could do this when release new iso.

I am confused, this issue is technically reproducible without a rootfs?
Removing the '-initrd rootfs.cpio' from the QEMU command I provided
above does not hide the error.

> > If there is any additional information I can provide or patches I can
> > test, I am more than happy to do so. Apologies if this has already been
> > reported or resolved, I did a search on the mailing list and I did not
> > see anything.
> > 
> > Cheers,
> > Nathan
> > 
> > # bad: [9a87ce288fe30f268b3a598422fe76af9bb2c2d2] Add linux-next specific files for 20250128
> > # good: [805ba04cb7ccfc7d72e834ebd796e043142156ba] Merge tag 'mips_6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
> > git bisect start '9a87ce288fe30f268b3a598422fe76af9bb2c2d2' '805ba04cb7ccfc7d72e834ebd796e043142156ba'
> > # bad: [e317bfe93c72e10dc02caac8b8b4b064291c352e] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> > git bisect bad e317bfe93c72e10dc02caac8b8b4b064291c352e
> > # good: [31d2d7cb6ca6c6159e22bf708c089b7af11f1585] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
> > git bisect good 31d2d7cb6ca6c6159e22bf708c089b7af11f1585
> > # good: [bd19f1e807f92f27654e0bb2790fe31b6af58daf] Merge branch 'docs-next' of git://git.lwn.net/linux.git
> > git bisect good bd19f1e807f92f27654e0bb2790fe31b6af58daf
> > # bad: [1df2cdd95b5ca1e2d520e3df2b2b1a12bd31cb79] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
> > git bisect bad 1df2cdd95b5ca1e2d520e3df2b2b1a12bd31cb79
> > # bad: [f572a6cf38985ca5d4df4cae1e3e74464774d033] Merge branch 'drm-next' of https://gitlab.freedesktop.org/drm/kernel.git
> > git bisect bad f572a6cf38985ca5d4df4cae1e3e74464774d033
> > # bad: [e30de3809c23cc17c49c139e11e7180248381017] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> > git bisect bad e30de3809c23cc17c49c139e11e7180248381017
> > # good: [56ca981eec373ae4779e3114a3807cc15ad230f9] Merge branch 'pm-cpufreq' into linux-next
> > git bisect good 56ca981eec373ae4779e3114a3807cc15ad230f9
> > # bad: [ed752cc25bbd8ee26498a91ac7a63bcf50ea16f3] Merge branch 'cpufreq/arm/linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
> > git bisect bad ed752cc25bbd8ee26498a91ac7a63bcf50ea16f3
> > # bad: [39b6b3b09b32c7b4ed6b0e8e87f359c588fe19d6] Merge branches 'acpi-x86' and 'acpi-apei' into linux-next
> > git bisect bad 39b6b3b09b32c7b4ed6b0e8e87f359c588fe19d6
> > # good: [c881e66eb84a4f944df317294eedf6b2b2882214] Merge branches 'pm-sleep' and 'pm-powercap' into linux-next
> > git bisect good c881e66eb84a4f944df317294eedf6b2b2882214
> > # good: [8f62ca9c338aae4f73e9ce0221c3d4668359ddd8] ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
> > git bisect good 8f62ca9c338aae4f73e9ce0221c3d4668359ddd8
> > # bad: [19badc4e57c6a5b87d3ce6eb6ec24bed62ec57ac] ACPI: HED: Always initialize before evged
> > git bisect bad 19badc4e57c6a5b87d3ce6eb6ec24bed62ec57ac
> > # first bad commit: [19badc4e57c6a5b87d3ce6eb6ec24bed62ec57ac] ACPI: HED: Always initialize before evged
> > 
> > .

