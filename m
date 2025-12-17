Return-Path: <linux-acpi+bounces-19638-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E1CC9217
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B8A3039973
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92535CB62;
	Wed, 17 Dec 2025 17:49:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02B35C1A9;
	Wed, 17 Dec 2025 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993783; cv=none; b=TtuIKAUIF7wFK80X+tKmFEX8tWHfMY25q2rjhkanaT+K4gljed9E4PR9nVqN0Byn86atlbiyx86sww+ZtynolBLhV+sQI9YvGeblWGtqkzKMFfVHywt9f4YZ6p2ifpmBjXGIX3wzL9x6nTLALwmKqkMJ3HE7MSfnKv9ImjC6A0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993783; c=relaxed/simple;
	bh=pe1xhCfBGTHof4k+PvXrA2skCjTZw9Qyy+YRETzkeG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT5t5KVl8zyqDS4MTGAvfBvWgOoPbWM7z6JoYglb/3oQNqYxaXzwwhLyErS7N4gVEqN1HBbcLI9WmcvDCwtjcAefWg/8whvT0pKA5r/+XMk9yafFY81f3uykAkpaEJRYlbVJdGZsThPHpfHTOWneLWP1H0OEu/zFNXtxdfjVAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B156F339;
	Wed, 17 Dec 2025 09:49:31 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC7783F73F;
	Wed, 17 Dec 2025 09:49:36 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: krzk@kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
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
	ahmed.tiba@arm.com
Subject: Re: [PATCH 10/12] dt-bindings: ras: document estatus provider
Date: Wed, 17 Dec 2025 17:49:27 +0000
Message-ID: <20251217174933.1938909-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cd04e23a-9523-4d25-8240-29a0dffa0e75@kernel.org>
References: <cd04e23a-9523-4d25-8240-29a0dffa0e75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/12/2025 12:41, Krzysztof Kozlowski wrote:
> What is ras? There is no such directory so some description would be
> useful. Usually you do not get your own directory per binding.

Would it make sense to move it under `Documentation/devicetree/bindings/firmware`
and expand the description so it spells out that
Arm RAS refers to reliability, availability and serviceability firmware.

> Do not describe what the binding does. Describe the hardware or firmware.

I'll reword that section.

> Again ras - what's that? Your patch or binding must explain that.

I'll add that explanation to the description.

> Why is this flexible?

Some platforms only expose the CPER status buffer, while others also expose a
doorbell that firmware expects to toggle before writing the next record.
I'll keep `reg` at 1-2 entries but make the description clear about which
region is optional.

> Does not match reg.

`reg-names` will only be allowed when both regions are present,
and in that case it must list `"status", "ack"`
so the entries line up with `reg`.
If only the status buffer exists, the property stays omitted.


> What OS is doing should not really matter. Either you have the interrupt
> or not.

I’ll trim the wording so it just states that firmware
may assert an interrupt when a new record is ready.


> That's OS policy, not suitable for binding.

I’ll drop `poll-interval` from the binding and let the driver fall back
to a fixed polling interval when no interrupt is wired.

> This is implied by the compatible, no?

I’ll drop `arm,sea-notify` so the compatible alone defines the behaviour.

> Drop all this.

I’ll delete the `allOf` clauses once the policy properties are gone.

> I do not see any schema referenced.

I’ll switch from `unevaluatedProperties` to `additionalProperties: false`.

> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).

I’ll rename the example node to `estatus@fe800000`
so it describes the firmware error-status block rather than using the driver name.

> Use proper defines.

I’ll update the example to use `GIC_SPI` and the `IRQ_TYPE_*` macros for the interrupt specifier.

Best regards,
Ahmed

