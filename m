Return-Path: <linux-acpi+bounces-933-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE77D5902
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E18CB2051F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813603B293
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jem4Xr0M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790338F92;
	Tue, 24 Oct 2023 16:05:52 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6206783;
	Tue, 24 Oct 2023 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AeUCwFyYTQcTT6ch132eQcfBZRX+bCc7/V0DsvmSMbU=; b=Jem4Xr0MuEmgPQKcRUsvQA06Ae
	4KTpY1w0KQDNMUuGCJvn4vEzXXO4EA9Cd+lWQhIPj++cDEEI9o7Lel5Ig3IRsiTLPY+ogt2PpQoPO
	hejHQO1VropWoTxGLx7LgX888GdonKtLsn7/Z50NFa1ibB0WJxo8XMavW7seuTf40VtN3nwXqjDMc
	5oIb/knNNgEy1zOuwtJGEgv183tRDP1PvW7Ol0WRNS4w9Wp5Ei4e9zVHvCZkGvRSJd3r7Z6jC4Lhg
	5UFDuW04m+3yzFObpswJkyCZNtGWqJmfJ6bkd7OhCo8Gq0xxKWcfux49gmXW6jZlXQujxpl3T8sN+
	J9i46lOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55354)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qvJuY-0004cs-1H;
	Tue, 24 Oct 2023 17:05:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qvJuW-00062N-QM; Tue, 24 Oct 2023 17:05:40 +0100
Date: Tue, 24 Oct 2023 17:05:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 38/39] cpumask: Add enabled cpumask for present CPUs that
 can be brought online
Message-ID: <ZTfrVMuCNrwxxj62@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <E1qvJBk-00AqSW-R8@rmk-PC.armlinux.org.uk>
 <2023102411-ascent-plot-04fd@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102411-ascent-plot-04fd@gregkh>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 24, 2023 at 06:02:30PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 24, 2023 at 04:19:24PM +0100, Russell King wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > The 'offline' file in sysfs shows all offline CPUs, including those
> > that aren't present. User-space is expected to remove not-present CPUs
> > from this list to learn which CPUs could be brought online.
> > 
> > CPUs can be present but not-enabled. These CPUs can't be brought online
> > until the firmware policy changes, which comes with an ACPI notification
> > that will register the CPUs.
> > 
> > With only the offline and present files, user-space is unable to
> > determine which CPUs it can try to bring online. Add a new CPU mask
> > that shows this based on all the registered CPUs.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  drivers/base/cpu.c      | 10 ++++++++++
> >  include/linux/cpumask.h | 25 +++++++++++++++++++++++++
> >  kernel/cpu.c            |  3 +++
> >  3 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 2b9cb2667654..f8bf1d4c7d71 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -95,6 +95,7 @@ void unregister_cpu(struct cpu *cpu)
> >  {
> >  	int logical_cpu = cpu->dev.id;
> >  
> > +	set_cpu_enabled(logical_cpu, false);
> >  	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
> >  
> >  	device_unregister(&cpu->dev);
> > @@ -273,6 +274,13 @@ static ssize_t print_cpus_offline(struct device *dev,
> >  }
> >  static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
> >  
> > +static ssize_t print_cpus_enabled(struct device *dev,
> > +				  struct device_attribute *attr, char *buf)
> > +{
> > +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_enabled_mask));
> > +}
> > +static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);
> 
> This needs to be documented somewhere in Documentation/ABI/ did I miss
> that patch?

Thanks for pointing that out, no you missed the patch as nothing
touches Documentation/ABI/ in this patch series. I'll add some blurb
for it for the next iteration.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

