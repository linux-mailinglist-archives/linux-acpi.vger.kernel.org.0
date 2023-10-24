Return-Path: <linux-acpi+bounces-886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D04897D5437
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55048B20A36
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69230F9C
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D129437
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 14:07:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B981EA3
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 07:07:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93AC02F4;
	Tue, 24 Oct 2023 07:08:32 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DDBA3F762;
	Tue, 24 Oct 2023 07:07:50 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:07:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Marc Zyngier <maz@kernel.org>, Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled
 check into a helper
Message-ID: <ZTfPsyUbWCB0u96R@bogus>
References: <E1quv5D-00AeNJ-U8@rmk-PC.armlinux.org.uk>
 <CAJZ5v0j+h9M4qhcdRW7_sOxbwdVqjyyrZWw14JsM1h1JoUL5+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j+h9M4qhcdRW7_sOxbwdVqjyyrZWw14JsM1h1JoUL5+Q@mail.gmail.com>

On Tue, Oct 24, 2023 at 02:06:55PM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 23, 2023 at 3:35 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > ACPI, irqchip and the architecture code all inspect the MADT
> > enabled bit for a GICC entry in the MADT.
> >
> > The addition of an 'online capable' bit means all these sites need
> > updating.
> >
> > Move the current checks behind a helper to make future updates easier.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the generic ACPI changes in this patch, but it is knod of
> ARM-specific, so I'd prefer ARM64 to pick it up (CC Sudeep).

Thanks Rafael.

The changes looks good to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Catalin,

Can you please up this patch for v6.7 if not too late ? It is simple
refactoring and must not have too much impact.

-- 
Regards,
Sudeep

