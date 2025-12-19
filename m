Return-Path: <linux-acpi+bounces-19715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66DCD0672
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90ECB3074AAD
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536CA32938D;
	Fri, 19 Dec 2025 14:49:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8230FC08;
	Fri, 19 Dec 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155795; cv=none; b=ovyAFPJkX5+28uqqlqxW4+nR834fyIJ00mvqjUATW+Ou5slmxu1tI7k6qu6DXfpLJzwJHR0nro18ruMlY/IJ2MmLbbL30IuPMFlZuBN9DmkgXAHVidMvgVkFo72YbeEyQgMgQbMOnsH1YQH9fJvf2q2QCzc2qt5b9j24Y4qu52A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155795; c=relaxed/simple;
	bh=GxCWED1lQ3xQHAfEzdEfYQo+mnCg8pklLKYy52Nrj2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivOQFHC0rEbZXLufVtP6yjmkmd5Ebcm8Fhn6SyCwyJEKaii9G0vUQ8/tHvOczAxtf0WlPew+3pqQanIrS8yIrxqpUzzG2pgWDJmfTCCTLT/YE1molTqLve9ax/pjTny1mgAFjEkNUasDPNTBYrTvnkx4ZSBOwuZRoP9HwroJGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30454FEC;
	Fri, 19 Dec 2025 06:49:45 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 588433F5CA;
	Fri, 19 Dec 2025 06:49:50 -0800 (PST)
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
Date: Fri, 19 Dec 2025 14:49:02 +0000
Message-ID: <20251219144943.2798169-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218170453.23be9049@foz.lan>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Dec 18, 2025 at 05:04:53PM +0100, Mauro Carvalho Chehab wrote:

>> Teach the estatus core how to walk CPER records and expose the vendor
>> record notification path. This adds the section iteration helpers,
>> the logging helpers that mirror the GHES behaviour, and the deferred
>> work used to hand vendor GUIDs to interested drivers. No users switch
>> over yet; this simply moves the common logic out of GHES so the next
>> patches can wire it up.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>
>...
>
>> +static bool estatus_handle_arm_hw_error(estatus_generic_data *gdata, int sev, bool sync)
>
> Huh?
>
> This is a CPER record from GHES. Why are you moving CPER code out
> of ghes.c, placing in a file named estatus.c? Doesn't make much
> sense on my eyes...
>
> Same applies to to other GHES CPER record types.

GHES still fills in the CPER record, but the parsing and logging logic is
shared with the new DeviceTree provider so I pulled those helpers into the
estatus core. Both providers already call into the same notifier chain and
memory-pool helpers; this patch just moves the generic CPER walking routines
next to the rest of the common code so the DT path doesn’t have to grow its
own copy. If you’d prefer a different file layout or naming to make that
intent clearer, I’m happy to adjust.


Thanks,
Ahmed

