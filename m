Return-Path: <linux-acpi+bounces-6188-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF278FC6C2
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 10:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8F228144B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D901946C0;
	Wed,  5 Jun 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8Ol6eQ8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35EC1946AD;
	Wed,  5 Jun 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576837; cv=none; b=RQtbxKCXygHkK1G2wK7QnpBw23JfZuSuwAQVGDe4B8CvnAa5m3UhL7mXKJPoFVWXfCHKzlIox/Smv65o3gzUoVLqMfURp9jBRT0I68Ch07zzPrxTXPpGgudM25AwHTgTLbEQFi4SbEDDp2A7thVk6w6RgelbXLqV0S7gGcWOdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576837; c=relaxed/simple;
	bh=SSuUeQbO2I34BDzHIPG6kv2UTPDB/m4P39TM9c87s7U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gFr4KAVAo69vEJEsk1kc4/rCvbYj2Awxg1pybNS+YrXKxVu2d03MBICfRVkNgAFVQvb2IlMC3hHbWMiLQhGyqN3Udrc80eSz1IDLvLXpNbQtWOWUhk/BWww5scBRf+tXzifGGWNorWsfjqiGskz8Jy9jGIgGLFYnkzmYgPCY5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8Ol6eQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6F8C4AF07;
	Wed,  5 Jun 2024 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717576836;
	bh=SSuUeQbO2I34BDzHIPG6kv2UTPDB/m4P39TM9c87s7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8Ol6eQ8uwNDtxC0NQ5T5LtnOoyj9T/kgJ15LXylZws9yVCogCgIqt1iRnAu70HqR
	 EKgizvqOq80Myld4yIAl2s2Qc3lBefOF0J+opuYC/n2F3LB+uM7GER6A3GSLZsFEFq
	 GL0BcmY1L79oanQSiOMW3z6Y655VQCxMElhWuH+ctMhXdj7cAzzeVsvc54z9WxTsT/
	 8GxqXFvo6yzQKV7qYAa0y7xP4v1RbLnYbRyCcikOuuZcvlZrqTsmXwcCDE3LD2VHsD
	 DEf3GYbh7jo0TmM/Hq2dZwwo4K3lLH0r6xS5cbaOmhnEfdVL7xpnkeqY7Zqj9Euoft
	 2ED/w2eiEXVSA==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sEmCA-000r52-Af;
	Wed, 05 Jun 2024 09:40:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Jun 2024 09:40:34 +0100
From: Marc Zyngier <maz@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, Fang Xiang <fangxiang3@xiaomi.com>, Robert
 Moore <robert.moore@intel.com>
Subject: Re: [PATCH v5 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
In-Reply-To: <ZmAQQVR+inUJpJ7z@lpieralisi>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240123110332.112797-2-lpieralisi@kernel.org>
 <ZiYi64/VBWkfM2E2@lpieralisi> <ZmAQQVR+inUJpJ7z@lpieralisi>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <eefc3a76d6cfb3400a3d6e39e8887177@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: lpieralisi@kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, robin.murphy@arm.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, fangxiang3@xiaomi.com, robert.moore@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2024-06-05 08:14, Lorenzo Pieralisi wrote:
> On Mon, Apr 22, 2024 at 10:42:19AM +0200, Lorenzo Pieralisi wrote:
>> On Tue, Jan 23, 2024 at 12:03:32PM +0100, Lorenzo Pieralisi wrote:
>> > The GIC architecture specification defines a set of registers for
>> > redistributors and ITSes that control the sharebility and cacheability
>> > attributes of redistributors/ITSes initiator ports on the interconnect
>> > (GICR_[V]PROPBASER, GICR_[V]PENDBASER, GITS_BASER<n>).
>> >
>> > Architecturally the GIC provides a means to drive shareability and
>> > cacheability attributes signals but it is not mandatory for designs to
>> > wire up the corresponding interconnect signals that control the
>> > cacheability/shareability of transactions.
>> >
>> > Redistributors and ITSes interconnect ports can be connected to
>> > non-coherent interconnects that are not able to manage the
>> > shareability/cacheability attributes; this implicitly makes the
>> > redistributors and ITSes non-coherent observers.
>> >
>> > To enable non-coherent GIC designs on ACPI based systems, parse the MADT
>> > GICC/GICR/ITS subtables non-coherent flags to determine whether the
>> > respective components are non-coherent observers and force the
>> > shareability attributes to be programmed into the redistributors and
>> > ITSes registers.
>> >
>> > An ACPI global function (acpi_get_madt_revision()) is added to retrieve
>> > the MADT revision, in that it is essential to check the MADT revision
>> > before checking for flags that were added with MADT revision 7 so that
>> > if the kernel is booted with an ACPI MADT table with revision < 7 it
>> > skips parsing the newly added flags (that should be zeroed reserved
>> > values for MADT versions < 7 but they could turn out to be buggy and
>> > should be ignored).
>> >
>> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> > Cc: Robin Murphy <robin.murphy@arm.com>
>> > Cc: Mark Rutland <mark.rutland@arm.com>
>> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> > Cc: Marc Zyngier <maz@kernel.org>
>> > ---
>> >  drivers/acpi/processor_core.c    | 15 +++++++++++++++
>> >  drivers/irqchip/irq-gic-v3-its.c |  4 ++++
>> >  drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
>> >  include/linux/acpi.h             |  3 +++
>> >  4 files changed, 31 insertions(+)
>> 
>> Hi Marc, Rafael,
>> 
>> I would kindly ask you please what to do with this patch, it still
>> applies to v6.9-rc5 - I can resend it if needed, ACPICA changes
>> are already merged as-per the cover letter.
> 
> Hi Marc, Rafael,
> 
> I would kindly ask please what to do with this patch, rebased to 
> v6.10-rc1,
> I can resend it if that's preferred, please let me know.

Please resend it with my:

Acked-by: Marc Zyngier <maz@kernel.org>

and Cc'ing Thomas Gleixner.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

