Return-Path: <linux-acpi+bounces-10904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B648A29EEE
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 03:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAD53A7D79
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 02:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD713A244;
	Thu,  6 Feb 2025 02:44:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FD17BA6;
	Thu,  6 Feb 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809865; cv=none; b=Rptjl0Cqg5XZjRcTzQPqH+/WMDzKwW0tCNuVqBkvYYijovu7lbr5yh26yGlTgsEo/Jwi8CJ6x1iC/WNERnvbcQk8aaHFpXCSxQs/COYyZC6CNdLHnmpeXWe4fUuQZ17gsanoy4HentddatzUZjhxnoFe3LkFuhNLnbmnIaA8hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809865; c=relaxed/simple;
	bh=oVZ8ib5G/4muhNqkQsOSyC8bwAKVThl22FUciEeie+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TQHDrTkIRPoJNQ8WAxI3dcvjjueoI2yFyww6eHjwtlOhfPV1F0NPpdHeQL6otptKgZGZEdC00UdEC/Q5FEX5RdSEM8vUOygbkPhJBEYk3MNbewXqwlgx/BQoXn0unILTLr4mqnGjQfyx4xslgs2P4uV7xkcluWca/sEE+oQPk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YpLxY1qrwz1JJdL;
	Thu,  6 Feb 2025 10:42:57 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id 8552A140118;
	Thu,  6 Feb 2025 10:44:13 +0800 (CST)
Received: from [10.67.121.188] (10.67.121.188) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 10:44:13 +0800
Message-ID: <07dd4187-6a62-0a32-d9b8-c2a6dacc9606@huawei.com>
Date: Thu, 6 Feb 2025 10:44:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] acpi: Fix HED module initialization order when it is
 built-in
To: Nathan Chancellor <nathan@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mchehab+huawei@kernel.org>, <roberto.sassu@huawei.com>,
	<shiju.jose@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
References: <20250117022957.25227-1-tanxiaofei@huawei.com>
 <20250120110417.00000a57@huawei.com>
 <58a450bb-55d1-5415-4b67-9d61603ce48e@huawei.com>
 <CAJZ5v0ihVJBX0bLqrL-61=LKVoZJOg3RpJykp80uOMf_7YcG+A@mail.gmail.com>
 <20250129043329.GA2344109@ax162>
From: Xiaofei Tan <tanxiaofei@huawei.com>
In-Reply-To: <20250129043329.GA2344109@ax162>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200009.china.huawei.com (7.185.36.246)

Hi Nathan,

在 2025/1/29 12:33, Nathan Chancellor 写道:
> On Thu, Jan 23, 2025 at 08:35:51PM +0100, Rafael J. Wysocki wrote:
>> On Tue, Jan 21, 2025 at 3:23 AM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>>>
>>> 在 2025/1/20 19:04, Jonathan Cameron 写道:
>>>> On Fri, 17 Jan 2025 10:29:57 +0800
>>>> Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>>>>
>>>>> When the module HED is built-in, the module HED init is behind EVGED
>>>>> as the driver are in the same initcall level, then the order is determined
>>>>> by Makefile order. That order violates expectations. Because RAS records
>>>>> can't be handled in the special time window that EVGED has initialized
>>>>> while HED not.
>>>>>
>>>>> If the number of such RAS records is more than the APEI HEST error source
>>>>> number, the HEST resources could be occupied all, and then could affect
>>>>> subsequent RAS error reporting.
>>>>>
>>>>> Change the initcall level of HED to subsys_init to fix the issue. If build
>>>>> HED as a module, the problem remains. To solve this problem completely,
>>>>> change the ACPI_HED from tristate to bool.
>>>>>
>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Given the change in approach (even though I reviewed this internally)
>>>> should probably have dropped my RB.   Anyhow, consider this me
>>>> giving it again on list.
>>> OK. thanks.
>> Applied as 6.14-rc material with a rewritten changelog and under a new
>> subject: "ACPI: HED: Always initialize before evged".
>>
>> Thanks!
> For what it's worth, I just bisected a new error message that I see when
> booting several x86_64 distribution configurations in QEMU to this
> change in -next as commit 19badc4e57c6 ("ACPI: HED: Always initialize
> before evged"):
>
>    $ curl -LSso .config https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/main/config
>
>    $ make -skj"$(nproc)" ARCH=x86_64 CROSS_COMPILE=x86_64-linux- olddefconfig bzImage
>
>    $ qemu-system-x86_64 \
>          -display none \
>          -nodefaults \
>          -M q35 \
>          -d unimp,guest_errors \
>          -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' \
>          -kernel arch/x86/boot/bzImage \
>          -initrd rootfs.cpio \
>          -cpu host \
>          -enable-kvm \
>          -m 512m \
>          -smp 8
>          -serial mon:stdio
>    ...
>    [    0.535126] Error: Driver 'hardware_error_device' is already registered, aborting...

It seems that the startup script of the test case loads some fixed ko, even when the bzImage changed.

If so, we could update the rootfs.cpio. This may introduce some adaptation work, if you want to roll

this patch to some distribution. I think we could do this when release new iso.


>    ...
>
> If there is any additional information I can provide or patches I can
> test, I am more than happy to do so. Apologies if this has already been
> reported or resolved, I did a search on the mailing list and I did not
> see anything.
>
> Cheers,
> Nathan
>
> # bad: [9a87ce288fe30f268b3a598422fe76af9bb2c2d2] Add linux-next specific files for 20250128
> # good: [805ba04cb7ccfc7d72e834ebd796e043142156ba] Merge tag 'mips_6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
> git bisect start '9a87ce288fe30f268b3a598422fe76af9bb2c2d2' '805ba04cb7ccfc7d72e834ebd796e043142156ba'
> # bad: [e317bfe93c72e10dc02caac8b8b4b064291c352e] Merge branch 'next' of git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> git bisect bad e317bfe93c72e10dc02caac8b8b4b064291c352e
> # good: [31d2d7cb6ca6c6159e22bf708c089b7af11f1585] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git
> git bisect good 31d2d7cb6ca6c6159e22bf708c089b7af11f1585
> # good: [bd19f1e807f92f27654e0bb2790fe31b6af58daf] Merge branch 'docs-next' of git://git.lwn.net/linux.git
> git bisect good bd19f1e807f92f27654e0bb2790fe31b6af58daf
> # bad: [1df2cdd95b5ca1e2d520e3df2b2b1a12bd31cb79] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
> git bisect bad 1df2cdd95b5ca1e2d520e3df2b2b1a12bd31cb79
> # bad: [f572a6cf38985ca5d4df4cae1e3e74464774d033] Merge branch 'drm-next' of https://gitlab.freedesktop.org/drm/kernel.git
> git bisect bad f572a6cf38985ca5d4df4cae1e3e74464774d033
> # bad: [e30de3809c23cc17c49c139e11e7180248381017] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> git bisect bad e30de3809c23cc17c49c139e11e7180248381017
> # good: [56ca981eec373ae4779e3114a3807cc15ad230f9] Merge branch 'pm-cpufreq' into linux-next
> git bisect good 56ca981eec373ae4779e3114a3807cc15ad230f9
> # bad: [ed752cc25bbd8ee26498a91ac7a63bcf50ea16f3] Merge branch 'cpufreq/arm/linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
> git bisect bad ed752cc25bbd8ee26498a91ac7a63bcf50ea16f3
> # bad: [39b6b3b09b32c7b4ed6b0e8e87f359c588fe19d6] Merge branches 'acpi-x86' and 'acpi-apei' into linux-next
> git bisect bad 39b6b3b09b32c7b4ed6b0e8e87f359c588fe19d6
> # good: [c881e66eb84a4f944df317294eedf6b2b2882214] Merge branches 'pm-sleep' and 'pm-powercap' into linux-next
> git bisect good c881e66eb84a4f944df317294eedf6b2b2882214
> # good: [8f62ca9c338aae4f73e9ce0221c3d4668359ddd8] ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V
> git bisect good 8f62ca9c338aae4f73e9ce0221c3d4668359ddd8
> # bad: [19badc4e57c6a5b87d3ce6eb6ec24bed62ec57ac] ACPI: HED: Always initialize before evged
> git bisect bad 19badc4e57c6a5b87d3ce6eb6ec24bed62ec57ac
> # first bad commit: [19badc4e57c6a5b87d3ce6eb6ec24bed62ec57ac] ACPI: HED: Always initialize before evged
>
> .

