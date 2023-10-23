Return-Path: <linux-acpi+bounces-839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD817D3019
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE9B1C208AF
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2AB14A90
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RJf6lAwr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E010A09
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 08:48:13 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77F110;
	Mon, 23 Oct 2023 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LLAJ1nq21ZTnhrh8ZIS+thX2+YPOAC3uh7BNx3S3/K4=; b=RJf6lAwrPgbn53kZMA321NVbtj
	0Ks3SzBk30AugMzXMIwVHw9EiW2Pp6YnEDkow/Gr0/Oj5gpxeciu5pm9cxAMjFhJDinr7ueEHesEJ
	JHjDcWS8EscOrdST4BZAealHDBBTWdFWrgDA9wP2Voq3z4amaH0+I8EIjOcAzUjproiVcMEJGAReF
	IEftgvyWAiiy65PziiJt27kRV43C29OqPuDLOUKERo9CjbNtxsXoimqywk09n0NUFB7J9AG6rQcdV
	uzUt9Kn9Vq6E21W0GVhayz+8tdqlx1MuTvuZy/1M8Y82WkOaS/SopzbKr4q9bxBEW/+QCCj78pkDD
	3cBRvZTA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42934)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1quqbY-0002gh-0i;
	Mon, 23 Oct 2023 09:48:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1quqbZ-0004g9-3N; Mon, 23 Oct 2023 09:48:09 +0100
Date: Mon, 23 Oct 2023 09:48:09 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 25/35] LoongArch: Use the __weak version of
 arch_unregister_cpu()
Message-ID: <ZTYzSQw0iLlAKNCn@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-26-james.morse@arm.com>
 <20230914154111.0000189d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914154111.0000189d@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 14, 2023 at 03:41:11PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:13 +0000
> James Morse <james.morse@arm.com> wrote:
> 
> > LoongArch provides its own arch_unregister_cpu(). This clears the
> > hotpluggable flag, then unregisters the CPU.
> > 
> > It isn't necessary to clear the hotpluggable flag when unregistering
> > a cpu. unregister_cpu() writes NULL to the percpu cpu_sys_devices
> > pointer, meaning cpu_is_hotpluggable() will return false, as
> > get_cpu_device() has returned NULL.
> 
> Thought that looked odd earlier but didn't care enough to dig.
> Seem unlikely state would persist for an unregistered cpu.
> Great to see confirmation.

Would it make sense to move this immedaitely after "LoongArch: Switch
over to GENERIC_CPU_DEVICES" ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

