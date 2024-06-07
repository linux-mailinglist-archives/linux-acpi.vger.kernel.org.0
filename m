Return-Path: <linux-acpi+bounces-6252-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4F8FFD51
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 09:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90031C2139D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918C155C8F;
	Fri,  7 Jun 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp+6yHWe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96D154C17;
	Fri,  7 Jun 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745960; cv=none; b=iGFcaBP2qOH8iERKcqmCmqv9erUWvZ3ai/VaruBDlF3xMbWh87qMIGou23YJxUhs5H+LvYq5fX1GF/Of6nY3OJWOGOkBvbaALDTcE4Kj2WaHPtXWDafUBWPJjTRXeSIMsLL3K6qUF8z1eQhtfrcTgCkmvhr0u5zkl0hQhrJXsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745960; c=relaxed/simple;
	bh=cxQgyRpe0a+r33Y9Gsfzi5kKfomgFXGen/DnlgZBPzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkkmIacaAMBOp7ASf955nhLqmENiKDWhBmFmb/YJTr9QrLGh+o5LmUUbFQjev8itPjad0wIRIQvRPQFQhJPYnzs0spJe+aG28ryWS/AWPSn41kWydYv+sKOQuHE2ihsmKag0Fw6chYbrprTPsCik6rJjj7c7MuJM9y+EGTb5mGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp+6yHWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73376C2BBFC;
	Fri,  7 Jun 2024 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717745960;
	bh=cxQgyRpe0a+r33Y9Gsfzi5kKfomgFXGen/DnlgZBPzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dp+6yHWecDsCEcjUuXHbyHKCEjHXXmsCx+FkD3YjJlcaa1Qgf9HjtwL5kjg5rLXKe
	 qzP3vsDuwNPQeMGsU94zMXbKuYUbhr63t3u7PpMFsUKu1U19k15MT5i/QEZJmAZbpp
	 scO+5jxJOyC/xektgykwQBrlCP2xI8OKp2bB3ss9Ua4q/k6Z5vjP4Bf+A20uDvNZWi
	 Tbg6PYcBHiLT+8rMT2mIkNS0uJY5jgOUnW45xJF1Uk9wmJAXK+YyixXzsQIn4GHZVE
	 JUfmS+1cFrf58VabtYyx7NZ5AZkyD1u/8dVZ2j+h4a/cLT/6VyNzyq+a7f8OEOYB75
	 sdoI1Ao9y+fRg==
Date: Fri, 7 Jun 2024 09:39:14 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v6 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
Message-ID: <ZmK5Ilk37GyJ4QEa@lpieralisi>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240606094238.757649-1-lpieralisi@kernel.org>
 <20240606094238.757649-2-lpieralisi@kernel.org>
 <f901fd06-3b6b-4444-a3da-2b75c59059d3@marvell.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f901fd06-3b6b-4444-a3da-2b75c59059d3@marvell.com>

On Fri, Jun 07, 2024 at 12:21:54AM +0530, Amit Singh Tomar wrote:

[...]

> > diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> > index b203cfe28550..915713c0e9b7 100644
> > --- a/drivers/acpi/processor_core.c
> > +++ b/drivers/acpi/processor_core.c
> > @@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
> >   	return rv;
> >   }
> > +int __init acpi_get_madt_revision(void)
> 
> Wondering, if we can have a generic function (acpi_get_tbl_revision) to
> obtain the revision number for any ACPI table, not just specific to MADT?

We could - I don't think there would be users other than code in this
patch though so I thought it would not be necessary.

Lorenzo

