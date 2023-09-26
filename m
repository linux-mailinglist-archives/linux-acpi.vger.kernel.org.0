Return-Path: <linux-acpi+bounces-171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE47AF76E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 02:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1F20D281B96
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039921855
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 00:31:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F47547C91
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 23:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD1EC433C7;
	Tue, 26 Sep 2023 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695769369;
	bh=je6g4sK4peKsh1qGI9bWWT/XBfOKZh3dIb4/VXqVR94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EAvZ3vNy2vbk5wk/qfuZFLTEzYgxPC0IYYVZYNR1ywjJCc/PknMAGU9l9YgkeUC0D
	 IuCC0cbREtDSWvQO/d+8xxXF+rvW+7sIJh4gkPkycF0XSKWoHqOd8kzk10XbDgzylE
	 y6loJllN6SBw6Lqj3JNsIraIOGu+Q1prRZTdWYcFyEXnYtiHcGW/Nbdv9wpENKYprW
	 3Zt76Rn69EOBuO3S/HiKtmJg9qR2z4o6HsIVeHe3BhsCs8hvQWo1SEXbnScSnTsI0w
	 bLtk+MvKaBJqKNx4vERctWe0Lk/crpGPtb3oigWZknhckvTcDY3fmVO5ShaLZpfJxG
	 5z1iuIuI0PrsA==
Date: Tue, 26 Sep 2023 18:02:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
	"wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
	Miaohe Lin <linmiaohe@huawei.com>, gregkh@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	mahesh@linux.ibm.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Linux PCI <linux-pci@vger.kernel.org>, bhelgaas@google.com,
	"james.morse@arm.com" <james.morse@arm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
Message-ID: <20230926230247.GA429368@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc7a4ee-250f-7ec8-ca15-32cbd480bd3e@linux.alibaba.com>

On Fri, Sep 22, 2023 at 10:46:36AM +0800, Shuai Xue wrote:
> ...

> Actually, this is a question from my colleague from firmware team.
> The original question is that:
> 
>     "Should I set CPER_SEV_FATAL for Generic Error Status Block when a
>     PCIe fatal error is detected? If set, kernel will always panic.
>     Otherwise, kernel will always not panic."
> 
> So I pull a question about desired behavior of Linux kernel first :)
> From the perspective of the kernel, CPER_SEV_FATAL for Generic Error
> Status Block is not reasonable. The kernel will attempt to recover
> Fatal errors, although recovery may fail.

I don't know the semantics of CPER_SEV_FATAL or why it's there.
With CPER, we have *two* error severities: a "native" one defined by
the PCIe spec and another defined by the platform via CPER.

I speculate that the reason for the CPER severity could be to provide
a severity for error sources that don't have a "native" severity like
AER does, or for the vendor to force the OS to restart (for
CPER_SEV_FATAL, anyway) in cases where it might not otherwise.

In the native case, we only have the PCIe severity and don't have the
CPER severity at all, and I suspect that unless there's uncontained
data corruption, we would rather handle even the most severe PCIe
fatal error by disabling the specific device(s) instead of panicking
and restarting the whole machine.

So for PCIe errors, I'm not sure setting CPER_SEV_FATAL is beneficial
unless the platform wants to force the OS to panic, e.g., maybe the
platform knows about data corruption and/or the vendor wants the OS to
panic as part of a reliability story.

Presumably the platform has already logged the error, and I assume the
platform *could* restart without even returning to the OS, but maybe
it wants the OS to do a crashdump or shutdown in a more orderly way.

Bjorn

