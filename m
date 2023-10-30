Return-Path: <linux-acpi+bounces-1100-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA147DBFE4
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AEBB209FF
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50719BAF
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Oct 2023 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="01c617rJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6CAD262;
	Mon, 30 Oct 2023 17:51:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A412B4;
	Mon, 30 Oct 2023 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ni1GPgCl8w8Lwh/aSdbo/ks9Sgjz4jtglOS0ql7XSO4=; b=01c617rJlquZVt2QBAZvsxfiUn
	We9Aa2YJR/FiIGF2DchKsF4HTzXH4x13XmbhOFjuOjjTLrSvKEbbIiIVeMQu4u7PR8HN2WFJmMyfQ
	C6J8t3czF4AKG2F9u13+0fCagYzgASIqbySFKQ8DbW1a5cFRQtx6yrNueDmBMUQgJ3HEoQfA/tW2Y
	6zKGiVKt5ORIV3bWGHSyvSBoiOH7RlM0U2llB7+2OXH2TD8iVukcZ8K6w4/w+3LY6bhMz5YBBMP6H
	5M32zkEld5QtXKRKatFhDhrcgT9/IEWXaX/fsQh6kfxMZP7g104aTS23og0hO0W/VM5RGC4DF0bOO
	lTqzoc7Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50422)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qxWPr-0001wo-2E;
	Mon, 30 Oct 2023 17:51:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qxWPn-0004Co-Sm; Mon, 30 Oct 2023 17:51:03 +0000
Date: Mon, 30 Oct 2023 17:51:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>,
	"acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	"jianyong.wu@arm.com" <jianyong.wu@arm.com>,
	"justin.he@arm.com" <justin.he@arm.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual
 cpuhotplug
Message-ID: <ZT/tB0ykr8JJd+E4@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <C2C5C292-AD2C-4D98-8225-39ABE68C5395@oracle.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2C5C292-AD2C-4D98-8225-39ABE68C5395@oracle.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Oct 30, 2023 at 04:41:19PM +0000, Miguel Luis wrote:
> Hi Russell,
> 
> Tested on QEMU, based on Salil's RFC v2 [1], running with KVM.
> - boot
> - hotplug up to 'maxcpus'
> - hotunplug down to the number of boot cpus
> - hotplug vcpus and migrate with vcpus offline
> - hotplug vcpus and migrate with vcpus online
> - hotplug vcpus then unplug vcpus then migrate
> - successive live migrations (up until 6)
> 
> Feel free to add:
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> 
> Thank you
> Miguel
> 
> [1] https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com/

That's good news, thanks for testing!

I've pushed out an updated series against v6.6 earlier today in case
anyone wants something specifically against v6.6, but I don't think
there is any pressing reason to re-test. The only ACPI change
between the two is:

9b311b7313d6 ACPI: NFIT: Install Notify() handler before getting NFIT table

and the only arm64 changes are in dts files. Nothing significant in
kernel/ and nothing in drivers/base/.

So I think at this point, I will pause waiting for 6.7-rc1 (which
I'll do an updated patch set, since it will include changes queued
up) and hopefully followed by Rafael's comments. Maybe James will
also have some time to work on this again.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

