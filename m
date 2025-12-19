Return-Path: <linux-acpi+bounces-19727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62469CD1635
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 19:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C0A30D5553
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA834845C;
	Fri, 19 Dec 2025 18:12:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B62346E51;
	Fri, 19 Dec 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167966; cv=none; b=dd5JwNMj5bjeSzyf8ymWLU8J8IKvEv28kaw5ZSrSFAybNzK19+GYDI9eDxpXMaW4jKTm1pD3wbv0Gzn9SJqJC0gZRLWfL9w5zvly0niMOAO0pfHgFfu848+7ypRImORe/55lbsTXBc3lYnogNlVvRjvPT2pQsOjM4sZuwGM2LX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167966; c=relaxed/simple;
	bh=YeMY+B0Q44lIJGztxvKNv0YHzaENYYbek8WIV+DQ3D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOObBzDvhr6Q9ST+mhH6uAOVX88IWh0Qn7uRrewzs1Bt4zJ6l9esM0Norhajrf7OaJge+KlQd+NDx+wFkHhtNjSdc54IRkGxJdz4z0/uXnOyVJmZd579xjO6V8/iJJPpWXTY5RoeWV/exO2nA4IVVqybSngFQKyATCV+HR3D/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B3421684;
	Fri, 19 Dec 2025 10:12:35 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E093F7BD;
	Fri, 19 Dec 2025 10:12:40 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	Ahmed.Tiba@arm.com
Subject: Re: [PATCH 03/12] ras: add estatus vendor handling and processing
Date: Fri, 19 Dec 2025 18:11:54 +0000
Message-ID: <20251219181226.2859763-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <euhams5heiuaawxq4e5ty7iijuvwt5gvdx3flsm4npligjeulq@lv3cwekyb2o2>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Fri, Dec 19, 2025 at 04:30:40PM +0100, Mauro Carvalho Chehab wrote:
>On Fri, Dec 19, 2025 at 02:49:02PM +0000, Ahmed Tiba wrote:
>>
>> On Wed, Dec 18, 2025 at 05:04:53PM +0100, Mauro Carvalho Chehab wrote:
>>
>> >> Teach the estatus core how to walk CPER records and expose the vendor
>> >> record notification path. This adds the section iteration helpers,
>> >> the logging helpers that mirror the GHES behaviour, and the deferred
>> >> work used to hand vendor GUIDs to interested drivers. No users switch
>> >> over yet; this simply moves the common logic out of GHES so the next
>> >> patches can wire it up.
>> >>
>> >> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> >
>> >...
>> >
>> >> +static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bool sync)
>> >
>> > Huh?
>> >
>> > This is a CPER record from GHES. Why are you moving CPER code out
>> > of ghes.c, placing in a file named estatus.c? Doesn't make much
>> > sense on my eyes...
>> >
>> > Same applies to to other GHES CPER record types.
>>
>> GHES still fills in the CPER record, but the parsing and logging logic is
>> shared with the new DeviceTree provider so I pulled those helpers into the
>> estatus core.
>
> I see, but this is not really estatus core. Instead, it is part of GHES CPER
> handling logic, which is defined at ACPI and UEFI specs. moving it to estatus
> sounds odd, at least on my eyes.
> 
> Perhaps I'm failing to see where at ACPI/UEFI specs how CPER would be
> integrated with an OpenFirmware approach to handle CPER without GHES.
> Care to point to the relevant specs, if any?

ACPI/APEI (via GHES) defines how CPER records are discovered and notified on ACPI systems,
but there is no ACPI or UEFI-defined equivalent for OpenFirmware/DeviceTree platforms.
UEFI standardises the CPER record format itself, not the transport or discovery mechanism.

On non-ACPI systems we still receive the same UEFI-defined CPER payload
from firmware, but Linux needs a different, platform-specific contract
to locate and acknowledge it. The DT binding is a Linux-side description
of that contract rather than something defined by ACPI/UEFI.

>> Both providers already call into the same notifier chain and
>> memory-pool helpers; this patch just moves the generic CPER walking routines
>> next to the rest of the common code so the DT path doesn’t have to grow its
>> own copy. If you’d prefer a different file layout or naming to make that
>> intent clearer, I’m happy to adjust.

> Moving the code from ghes.c to estatus.c or to elsewhere shouldn't make any
> difference, as the DT handling logic could simply be calling the functions
> from ghes.c (or estatus.c). I fail to see why they need to be moved.

The motivation is to provide a shared implementation for non-ACPI providers,
so that the DT path does not depend on ACPI/APEI.

While the helpers currently live in ghes.c, they are CPER-specific and do not rely on ACPI tables,
APEI infrastructure, or GHES notification semantics. Keeping them there effectively makes GHES
the only place those helpers can live, even though the logic itself is provider-agnostic.

By moving the CPER parsing and logging pieces into a common location,
both GHES and the DT provider can reuse the same implementation,
while the ACPI-specific discovery and notification code remains under drivers/acpi/apei/.
This avoids having the DT provider reach into GHES internals or duplicate CPER handling code.

If the current naming or file layout makes that separation unclear, I’m happy to adjust it.

Thanks,
Ahmed

