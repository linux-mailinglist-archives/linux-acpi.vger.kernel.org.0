Return-Path: <linux-acpi+bounces-6494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56890D70A
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69899285543
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467C47A6A;
	Tue, 18 Jun 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArDhdieG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754D6BFB0;
	Tue, 18 Jun 2024 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723911; cv=none; b=UR3e7Fnzns5C+6WF5YiSSL9A28B1/0yI0pPZsm48wz96rFiWwgHBe0vKRyey5tLNGL8L6OmqXaEcBui2mtF19NIJgaQYNW5T9b/pNWGesT/t62yM3rVKSlQl8fBPAou/gf4itt2L/5TyHsEq/GB+d11Omyawnr3ct8p/qfudbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723911; c=relaxed/simple;
	bh=oD3IpixnZRA6VJNpe277ZbDs/y+e0fqqwZSUwflrg8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcH6gQODt6yxEn88uwALwqG1HrRiqP9hENjRUGQ2oUf88crquWLg1RNZNiDXZ6sNSs/89npQJhxCa7AjQvmWqTdEAqhW5cyCJyAOtI8Xo9K4T2yLZihTxyK1CgcIuHlGor6tIQfV5sFxIyTg/Kv2KVjLzC+Uf93RKqW3Oxm4ZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArDhdieG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8937C3277B;
	Tue, 18 Jun 2024 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723911;
	bh=oD3IpixnZRA6VJNpe277ZbDs/y+e0fqqwZSUwflrg8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArDhdieGvgt/FJJG8gyMkxVPlgmkx9RZYaYFNEIljcOTSvBFowjbLwZi+jv/YEC+T
	 dLKKXodefJKbY9Cr2AhIbCzmim7GSlkUbjc5mei8D6pNFRJTo7Qlf05gQqzY/LXbhd
	 KSLFGHaD76TIq8faXQHQsuLY/MAeaI0tU8Eg6TOWEHmtoXqRKF+7Sl+tN2k8bLaCJ5
	 1ViZiZRdGEb0i4hrWKJQb6v8cs18JOgsQcMLm2lDrDa6CfjevnfSECX9QNvvvpK1s+
	 Zdb5Io5eizzadhl/rUCwq+2E+Pq6toSbc5B6rXa479OV/UIbcaI/ibPedPM3r598Qm
	 Y5uYAwxiDZJ8w==
Date: Tue, 18 Jun 2024 16:18:20 +0100
From: Will Deacon <will@kernel.org>
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, sunilvl@ventanamicro.com, arnd@arndb.de,
	ajones@ventanamicro.com, Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Charlie Jenkins <charlie@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Zhao Ke <ke.zhao@shingroup.cn>, Andy Chiu <andy.chiu@sifive.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Robert Richter <rrichter@amd.com>, Yuntao Wang <ytcoode@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ACPI: NUMA: change the ACPI_NUMA to a hidden
 option
Message-ID: <20240618151820.GA2354@willie-the-truck>
References: <cover.1718268003.git.haibo1.xu@intel.com>
 <f1f96377b8ecd6e3183f28abf5c9ac21cb9855ea.1718268003.git.haibo1.xu@intel.com>
 <CAJve8o=8thBhU3NyTaS6sE9rQ1VR_Qf4O8FkAxpmp1q8P-6VaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8o=8thBhU3NyTaS6sE9rQ1VR_Qf4O8FkAxpmp1q8P-6VaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jun 17, 2024 at 09:34:18PM +0800, Haibo Xu wrote:
> @Catalin Marinas @Huacai Chen
> 
> Could you please have a look at this patch for the ACPI_NUMA config on
> ARM64 and LOONGARCH respectively.
> 
> Thanks!
> 
> On Thu, Jun 13, 2024 at 4:37 PM Haibo Xu <haibo1.xu@intel.com> wrote:
> >
> > x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> > would do the same thing, so change it to a hidden option and the
> > select statements except for the X86_64_ACPI_NUMA can also go away.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/arm64/Kconfig        | 1 -
> >  arch/loongarch/Kconfig    | 1 -
> >  drivers/acpi/numa/Kconfig | 5 +----
> >  3 files changed, 1 insertion(+), 6 deletions(-)

This looks fine from an arm64 perspective:

Acked-by: Will Deacon <will@kernel.org>

Will

