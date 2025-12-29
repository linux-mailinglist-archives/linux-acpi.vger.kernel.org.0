Return-Path: <linux-acpi+bounces-19880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 251AFCE69CC
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 12:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAE1B3006F78
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C762E2D97A2;
	Mon, 29 Dec 2025 11:54:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F352C11CB;
	Mon, 29 Dec 2025 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767009290; cv=none; b=BuClhbgF0luEV5Ck7nxl9IcRVt7J6gzcpJj7fQfO2H3kDq3BKmG4harshPST8PsBpjSlELHt484R03cyD3/ZDSIyuirGpW7WqQ/NP9mAUsU/MpBvdXGXpxrytOyPzxSvT4dI8zUS77eU7OfkpeKucZVDnBcC1UVyshJ3fO5qqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767009290; c=relaxed/simple;
	bh=rg8882HN0q5dZbaB2j0JJtAmaocpdTyq8yU2ZyxrdTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX+5mUXjwCtkrArfWW5iiEas+XYzmqxoNSN7zadJiMg0EvPUzVwqM/rglXDPZFQmHpCYwkgDP+HCJuOIUnnl6Hal9lVv99OeiHT5o7vlB6kyDBJCEn+ZY9iEZ8WX2CieDUSqUmB5EBMcrNNnY3du6WBSHYQOxZhtrmRQfiWfjXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9B3339;
	Mon, 29 Dec 2025 03:54:38 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2A1B3F63F;
	Mon, 29 Dec 2025 03:54:43 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	tony.luck@intel.com,
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
Subject: Re: [PATCH 00/12] ras: share firmware-first estatus handling
Date: Mon, 29 Dec 2025 11:54:36 +0000
Message-ID: <20251229115440.2734800-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251221013534.GAaUdO5vWqMWAdbWbd@renoirsky.local>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Dec 21, 2025 at 02:35:34 +0100, Borislav Petkov wrote:
> On Wed, Dec 17, 2025 at 11:28:33AM +0000, Ahmed Tiba wrote:
>> Platforms that rely on firmware-first RAS today only get the full Linux
>> handling pipeline when the records arrive through ACPI/APEI GHES. This
>> series lifts the generic parts of GHES into a reusable estatus core, wires
>
> Why is this thing called "error status"?

By “error status” I’m referring to the UEFI CPER Generic Error Status block,
which is the standard firmware-produced error payload that Linux already
consumes via GHES on ACPI systems. I’m not introducing a new error model
here; the intent is to reuse the existing CPER decoding and handling once
that payload exists.

> Why is error status so significant so that you need to call it a thing,
> much less a "core"?

The reason this shows up as a separate “core” is that CPER parsing,
logging, and vendor dispatch are provider-agnostic once a Generic Error
Status block exists, independent of how it was discovered or notified.

> It looks like you basically want to dump error records from a system
> which doesn't support GHES into the common path so they get decoded?
>
> I mean, I'm only guessing because I don't get any wiser from this text.
>
> So how about you give the high-level, practical use spiel first? What's
> the use case?

The practical use case is firmware-first RAS platforms that emit CPER
records but do not use ACPI/APEI GHES for discovery or notification. Today,
those platforms either have to duplicate CPER parsing logic or miss out on
the common Linux RAS handling (standard logging, memory failure flow,
vendor notification paths). As a result, the full firmware-first RAS
pipeline effectively only works when CPER arrives through GHES.

GHES remains one transport for delivering CPER records, but this
series separates the transport from the decoding so that other firmware-
first providers can reuse the same handling without duplicating code or
depending on ACPI/APEI internals.

As far as I can tell from the scope of https://uefi.org/specifications,
the UEFI specifications don’t define a notification mechanism for
DeviceTree systems—only the ACPI/APEI path is spelled out. Right now the DT
transport is described solely by the binding in patch 9/12. If there’s a
better place to document or name this, I’d appreciate guidance
so it’s clear how firmware-first notification happens on DT outside ACPI.

Thanks,
Ahmed

