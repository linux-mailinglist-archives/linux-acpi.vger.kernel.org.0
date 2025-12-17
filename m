Return-Path: <linux-acpi+bounces-19625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1598CC761E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93E83003FFC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6444B49659;
	Wed, 17 Dec 2025 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgkJUJJe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E0259CAF;
	Wed, 17 Dec 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971690; cv=none; b=gGVykpvF/AdSwbHoxE/a47/bFcs4lkSBdyD7n3wx6RfRxzxyKGzxBMDfrHYLWY8+AlMjiG+J8x1bVO9USNG30TvwKHhfdhT1pcHDU91lQgbo2fg12OyqhSU8a9VTSPInvETxV3+Xo9eX+TWFdt/loKN+DBxdOswKrsqOvYq8nUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971690; c=relaxed/simple;
	bh=QureFGhz+Rjaa7+iRO0a7okZDgRSIaqdEUA2PUeZ2+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhyscdyKiolCJYaXJuuIWlNaAuUu+00x4y/CoI4yJpvHxXMdmHD9fIE6/VuC+u9OMNRo8vBMy30tWd6SrJDG5R7+/Cinou0izkJJQE0o0zPScEQ3w7SLAUza1db8ACILM3qGuy19FQXGhk4G+kGJSqqA5BCbazMHPQv/djZQSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgkJUJJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E161C4CEF5;
	Wed, 17 Dec 2025 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765971689;
	bh=QureFGhz+Rjaa7+iRO0a7okZDgRSIaqdEUA2PUeZ2+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rgkJUJJeavzzA6Zd4VIHKmnMsfK5r/NGqBnqhpFApPQXqcWT3yMqr8Cj3AIz6ge1Z
	 0KSN1tj76FCMnrybq+qoTCQEbD9zLHhchKTW0qtyhfrN9plYZLACOBkVHIG6A0Agxg
	 26bbp9klTjMvQq+88v+OfOMjeCqYCp5DrzbkrCovU2CV5Zlej+QFoRzgldbNYS0onp
	 doDQpcDEmhmlN2StpdeGS+woTTldhTQjDKofpcibeATt/nP8Gfy/fiFWCTtHgAFp6t
	 f3kujRaryd48v6qxdJxaWWuki1JRhcGoAsYbMUcz7OsGwAnLLvp8yyFQP0qX2SmUYl
	 TIxsgbUX96jGg==
Message-ID: <cd04e23a-9523-4d25-8240-29a0dffa0e75@kernel.org>
Date: Wed, 17 Dec 2025 12:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] dt-bindings: ras: document estatus provider
To: Ahmed Tiba <ahmed.tiba@arm.com>, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: tony.luck@intel.com, bp@alien8.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com, Michael.Zhao2@arm.com
References: <20251217112845.1814119-1-ahmed.tiba@arm.com>
 <20251217112845.1814119-11-ahmed.tiba@arm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251217112845.1814119-11-ahmed.tiba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 12:28, Ahmed Tiba wrote:
> Add a binding for firmware-first CPER providers described via
> DeviceTree. It covers the shared status block, optional acknowledgment
> registers, interrupt versus polling modes and the SEA notification
> flag so non-ACPI platforms can describe their error sources.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  .../devicetree/bindings/ras/arm,ras-ffh.yaml  | 95 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml b/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
> new file mode 100644
> index 000000000000..0d2acbf8e8a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml

What is ras? There is no such directory so some description would be
useful. Usually you do not get your own directory per binding.

> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ras/arm,ras-ffh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm Firmware-First Handler (FFH) CPER provider
> +
> +maintainers:
> +  - Ahmed Tiba <ahmed.tiba@arm.com>
> +
> +description: |
> +  Some Arm platforms describe a firmware-first error handler that exposes a
> +  Common Platform Error Record (CPER) buffer directly via DeviceTree. The OS
> +  maps the buffer to consume the error records, and firmware signals that a new
> +  record is ready either by asserting an interrupt or by relying on a periodic
> +  poll. This binding describes the buffer and the associated notification

Do not describe what the binding does. Describe the hardware or firmware.

> +  signal. If firmware delivers the error via Synchronous External Abort (SEA),
> +  the optional sea-notify flag marks the source accordingly.
> +
> +properties:
> +  compatible:
> +    const: arm,ras-ffh

Again ras - what's that? Your patch or binding must explain that.

> +
> +  reg:
> +    minItems: 1

Why is this flexible?

> +    items:
> +      - description: CPER status block exposed by firmware
> +      - description:
> +          Optional 32- or 64-bit acknowledgment register. Firmware watches this
> +          register and expects bit 0 to be written to 1 once the OS consumes the
> +          status buffer so it can reuse the record.
> +
> +  reg-names:
> +    items:
> +      - const: status
> +      - const: ack

Does not match reg.

> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Optional interrupt used to signal that a new status record is ready. If
> +      omitted, the OS relies on the polling interval property.

What OS is doing should not really matter. Either you have the interrupt
or not.


> +
> +  poll-interval:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    description:
> +      Optional polling interval, in milliseconds, for platforms that cannot
> +      route an interrupt.

That's OS policy, not suitable for binding.

> +
> +  arm,sea-notify:
> +    type: boolean
> +    description:
> +      Set if the platform delivers these errors as Synchronous External Aborts.

This is implied by the compatible, no?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        poll-interval: false
> +    then:
> +      required:
> +        - interrupts
> +  - if:
> +      properties:
> +        interrupts: false
> +    then:
> +      required:
> +        - poll-interval
> +  - if:
> +      properties:
> +        reg:
> +          minItems: 2
> +    then:
> +      required:
> +        - reg-names

Drop all this.

> +
> +unevaluatedProperties: false

I do not see any schema referenced.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ras-ffh@fe800000 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

> +        compatible = "arm,ras-ffh";
> +        reg = <0xfe800000 0x1000>,
> +              <0xfe810000 0x4>;
> +        reg-names = "status", "ack";
> +        interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;

Use proper defines.

Best regards,
Krzysztof

