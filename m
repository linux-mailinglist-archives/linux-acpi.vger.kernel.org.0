Return-Path: <linux-acpi+bounces-19662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5019CCB65D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 11:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A61C03064483
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A833321BA;
	Thu, 18 Dec 2025 10:31:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7DB274B42;
	Thu, 18 Dec 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053907; cv=none; b=cG7lCqT5zLinNLSQw0/vqwZXE0Ku624qOBaFuXZs3O5pG+JDWx2zIfZ6fVP8Su2s9rT7BrS3xFCbSnNKE20ELy6dsEejZZEZ9vy6dQqK7bu5PWxHFksOAvpFXCMIpN9jttmSU3Db1lQcCx2ElydaHhGRRqee2pv7GLM9PX3de/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053907; c=relaxed/simple;
	bh=7K8OmFDgXbe1S/Y5wRV1wgqbOhB82D/IUz47Vm1mZo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvg9leqI2iGC+AiK8GrQ9yR/2YkfhmYa2lP1YWLByxmgun9Fiq+vt8UXH7etwvn4O6fqN6G8owSYYXw9G6ZCzgqOXZ2Q/6ql261vhLEPB0KgV3leUSn34SIlQddgCmX3pVX7UbgeAsYXfDwWtJZlmcI0GTOuOLO4RzwotJT5upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B88AFEC;
	Thu, 18 Dec 2025 02:31:37 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3A8C3F73F;
	Thu, 18 Dec 2025 02:31:42 -0800 (PST)
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
Date: Thu, 18 Dec 2025 10:31:38 +0000
Message-ID: <20251218103139.2238844-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2a2baef6-c294-4c31-bec2-10fbaa3f7941@kernel.org>
References: <2a2baef6-c294-4c31-bec2-10fbaa3f7941@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 17/12/2025 12:41, Krzysztof Kozlowski wrote:
>> Add a binding for firmware-first CPER providers described via
>> DeviceTree. It covers the shared status block, optional acknowledgment
>> registers, interrupt versus polling modes and the SEA notification
>> flag so non-ACPI platforms can describe their error sources.
>>
>> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
>> ---
>>  .../devicetree/bindings/ras/arm,ras-ffh.yaml  | 95 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 96 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml b/Documentation/devicetree/>bindings/ras/arm,ras-ffh.yaml
>> new file mode 100644
>> index 000000000000..0d2acbf8e8a8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
>
> What is ras? There is no such directory so some description would be
> useful. Usually you do not get your own directory per binding.

For the next revision I will move the schema under
`Documentation/devicetree/bindings/firmware/` and expand the description to
spell out that Arm Reliability, Availability and Serviceability (RAS) firmware
exposes this FFH CPER provider.

>> @@ -0,0 +1,95 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/ras/arm,ras-ffh.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Arm Firmware-First Handler (FFH) CPER provider
>> +
>> +maintainers:
>> +  - Ahmed Tiba <ahmed.tiba@arm.com>
>> +
>> +description: |
>> +  Some Arm platforms describe a firmware-first error handler that exposes a
>> +  Common Platform Error Record (CPER) buffer directly via DeviceTree. The OS
>> +  maps the buffer to consume the error records, and firmware signals that a new
>> +  record is ready either by asserting an interrupt or by relying on a periodic
>> +  poll. This binding describes the buffer and the associated notification
>
> Do not describe what the binding does. Describe the hardware or firmware.

I'll reword the description so it focuses on the firmware-managed CPER buffer,
optional doorbell register and optional interrupt rather than describing how
the binding is consumed.

>> +  signal. If firmware delivers the error via Synchronous External Abort (SEA),
>> +  the optional sea-notify flag marks the source accordingly.
>> +
>> +properties:
>> +  compatible:
>> +    const: arm,ras-ffh
>
> Again ras - what's that? Your patch or binding must explain that.

That updated description will explicitly expand the Arm RAS acronym so the
compatible string is self-explanatory.

>> +
>> +  reg:
>> +    minItems: 1
>
> Why is this flexible?

I'll keep `reg` describing the CPER status buffer, cap it at two entries, and
document the second entry as the optional doorbell register that some firmware
requires before reusing the buffer.

>> +    items:
>> +      - description: CPER status block exposed by firmware
>> +      - description:
>> +          Optional 32- or 64-bit acknowledgment register. Firmware watches this
>> +          register and expects bit 0 to be written to 1 once the OS consumes the
>> +          status buffer so it can reuse the record.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: status
>> +      - const: ack
>
> Does not match reg.

`reg-names` will remain optional, but when provided the first entry will be
restricted to `"status"` and the second (if present) to `"ack"`, matching the
single optional region permitted in `reg`.

>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      Optional interrupt used to signal that a new status record is ready. If
>> +      omitted, the OS relies on the polling interval property.
>
> What OS is doing should not really matter. Either you have the interrupt
> or not.

I'll trim the wording so it just states that firmware may assert an interrupt
when a new record is ready.

>> +
>> +  poll-interval:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    description:
>> +      Optional polling interval, in milliseconds, for platforms that cannot
>> +      route an interrupt.
>
> That's OS policy, not suitable for binding.

I'll drop `poll-interval` from the binding so the driver can fall back to its
fixed interval when no interrupt is wired.

>> +
>> +  arm,sea-notify:
>> +    type: boolean
>> +    description:
>> +      Set if the platform delivers these errors as Synchronous External Aborts.
>
> This is implied by the compatible, no?

I'll drop `arm,sea-notify` so the compatible alone defines the behaviour.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        poll-interval: false
>> +    then:
>> +      required:
>> +        - interrupts
>> +  - if:
>> +      properties:
>> +        interrupts: false
>> +    then:
>> +      required:
>> +        - poll-interval
>> +  - if:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +    then:
>> +      required:
>> +        - reg-names
>
>Drop all this.

I'll drop this block entirely.

>> +
>> +unevaluatedProperties: false
>
> I do not see any schema referenced.

I'll switch to `additionalProperties: false` so we rely solely on the schema
referenced by `$schema` while still rejecting unknown properties.

>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    ras-ffh@fe800000 {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.> html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).

I'll rename the example node to the generic `error-handler@fe800000` so it
describes the shared error-status block instead of the driver name.

>> +        compatible = "arm,ras-ffh";
>> +        reg = <0xfe800000 0x1000>,
>> +              <0xfe810000 0x4>;
>> +        reg-names = "status", "ack";
>> +        interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>;
>
> Use proper defines.

I'll also switch the example interrupt listing to `GIC_SPI` and `IRQ_TYPE_*`
macros.



Best regards,
Ahmed

