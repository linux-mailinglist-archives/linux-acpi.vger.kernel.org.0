Return-Path: <linux-acpi+bounces-19693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46922CCF78C
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62A230081B7
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E226A1CF;
	Fri, 19 Dec 2025 10:48:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94074BE1;
	Fri, 19 Dec 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141292; cv=none; b=uzsoicJF60cjoynCqayxeBekAZXwisdwzIEr86XWlWd5SU+hmNZNYMx/HmjHsl2S3VQCOsf1eZIwSOodwAQHo+syyRR8reIRzTdmh5ub1GsFyD+bjCxdQRSezD5lyc1DiLOODBPUCMRu7rhhFaE1jyGg+hu1ATouSi+93TjqdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141292; c=relaxed/simple;
	bh=mGsn0FM6mPE/Zvdf2Mf1taBhL3tfR6lmIzngSQM89TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmfBxIw7+ch+ax3SPCzj4qXqc+A5RyibSYvX5Hqzynh+yj+nfO0kpNc+CnMVIAhtWztL7CZ0n8dNOIn8F/zG+56+mus6iFW7DlwoHtZAG6OA9xhZX+J5CpwmoYd11VqEQaa3gp4V4okMIqDoJbxIe/rsAP0sqK+dlsh5ZFuJyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B75DFEC;
	Fri, 19 Dec 2025 02:48:03 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD0803F5CA;
	Fri, 19 Dec 2025 02:48:08 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
	Ahmed.Tiba@arm.com
Subject: Re: [PATCH 10/12] dt-bindings: ras: document estatus provider
Date: Fri, 19 Dec 2025 10:47:53 +0000
Message-ID: <20251219104759.2726164-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <57772b40-e4d9-4152-9709-04ba897608d0@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 19/12/2025 10:53, Krzysztof Kozlowski wrote:
>> On 17/12/2025 12:41, Krzysztof Kozlowski wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    const: arm,ras-ffh
>>>
>>> Again ras - what's that? Your patch or binding must explain that.
>>
>> That updated description will explicitly expand the Arm RAS acronym so the
>> compatible string is self-explanatory.
>>
>>>> +
>>>> +  reg:
>>>> +    minItems: 1
>>>
>>> Why is this flexible?
>>
>> I'll keep `reg` describing the CPER status buffer, cap it at two entries, and
>> document the second entry as the optional doorbell register that some firmware
>> requires before reusing the buffer.
>
> I still do not understand why this is flexible or in other words - why
> second address space appears and disappears.

The second address space is only present for firmware that exposes an ACK register.
Not all platforms require this extra handshake so that address shows up only
when the extra handshake exists. I’ll say that clearly in the binding
so it’s obvious the region is optional.

>>
>>>> +    items:
>>>> +      - description: CPER status block exposed by firmware
>>>> +      - description:
>>>> +          Optional 32- or 64-bit acknowledgment register. Firmware watches this
>>>> +          register and expects bit 0 to be written to 1 once the OS consumes the
>>>> +          status buffer so it can reuse the record.
>>>> +


Best regards,
Ahmed

