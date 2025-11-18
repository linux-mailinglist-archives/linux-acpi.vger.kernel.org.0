Return-Path: <linux-acpi+bounces-19031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A217C6AC30
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 17:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE93A445B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD536C596;
	Tue, 18 Nov 2025 16:45:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D19C34B402;
	Tue, 18 Nov 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484354; cv=none; b=rtY43Ra8VP6ftZZBkkgtcFeiY1Uy75B8tqg3UM+GKW4pswxURIZuL2c3k12+JvkID6ys0MY0e4JgVQdUaV6pSi92OcNZMd8sxnl6XlFYA2eym2vtsViRStjse5lA/uj8T1+jRJjp5UVUKcPLHDbD4jEVhfN1XN4HAEDykzEfT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484354; c=relaxed/simple;
	bh=OLo/dVic+VGMInOF6wQSVWrpZObz+9U7rG/Q/RMvexw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqWIl34QE3BtlhFhdGDINQZrkbgNan1h+H7tAMpqoFjkgXPsuTyLIBFdIxcqLgAca43Rc5yaKlt9skk660VviPOCMkv2lem+j0I+rFNj/t7hkOBAkBmqH6oewPsryA5VDXRoriCFE3J6+jUdNHB2oG//8+Kyaww0XFVQNBSLSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02446497;
	Tue, 18 Nov 2025 08:45:44 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392483F740;
	Tue, 18 Nov 2025 08:45:46 -0800 (PST)
Date: Tue, 18 Nov 2025 16:45:43 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com,
	amitsinght@marvell.com, baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com, dakr@kernel.org, dave.martin@arm.com,
	david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com,
	gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
	jeremy.linton@arm.com, jonathan.cameron@huawei.com,
	kobak@nvidia.com, lcherian@marvell.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lpieralisi@kernel.org,
	peternewman@google.com, quic_jiles@quicinc.com, robh@kernel.org,
	rohit.mathew@arm.com, scott@os.amperecomputing.com,
	sdonthineni@nvidia.com, sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: Re: [PATCH v5 08/34] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
Message-ID: <aRyit16Mrth-jjjg@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-9-ben.horgan@arm.com>
 <CAJZ5v0hAPoE96C7=ynR=Ex4huPP3b896sBRNdBiLe=3Q9vKwHQ@mail.gmail.com>
 <aRybF5PV_N2ODeiZ@arm.com>
 <CAJZ5v0jA5vWi3JFRcCMFmvpWSu8jFT-jOWvSNLt59FeqKEk3iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jA5vWi3JFRcCMFmvpWSu8jFT-jOWvSNLt59FeqKEk3iA@mail.gmail.com>

On Tue, Nov 18, 2025 at 05:21:07PM +0100, Rafael J. Wysocki wrote:
> Hi Catalin,
> 
> On Tue, Nov 18, 2025 at 5:13 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Nov 17, 2025 at 08:46:52PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Nov 17, 2025 at 6:01 PM Ben Horgan <ben.horgan@arm.com> wrote:
> > > > +static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
> > >
> > > Maybe call this acpi_get_table_pointer() ?
> >
> > Would you have time to look at the other ACPI patches in the series? If
> > you are ok with them, happy to go in via the arm64 tree? Or we can put
> > them on a common branch if there are conflicts with your tree.
> 
> I think that this is the only one touching ACPI code outside the MPAM
> and PPTT parsers, and the other patches in the series are fine with
> me.
> 
> Please feel free to take the entire lot.

Thanks!

-- 
Catalin

