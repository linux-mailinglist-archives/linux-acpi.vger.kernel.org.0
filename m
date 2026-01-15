Return-Path: <linux-acpi+bounces-20355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D98D22DB6
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 08:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C99F302CF49
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 07:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97362749C1;
	Thu, 15 Jan 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvr0ZWXH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0717BA2
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462458; cv=none; b=poAmWS3YnAJqLnHmEg97ItUd0y9VBPZLsj4TL13ao+Ak0txh7L1ZwX8bCdpWCGLHc3hVYAeYCWrbNT+IHyIArn1aF8SFx3IhKXfDTpQsjNZ3pKw5T7OoN0AosPXUTzykaPkQecelwX3WZTsqnnp9yTkB7ztA/ImckQy4kkAun18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462458; c=relaxed/simple;
	bh=HtpktxwRJwaTEVCT4r0uk8HTyaHmsA/bfVVlgJM4rH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqwxQbHjOhyNWoWNl+KNoIIAgiDN6baM0/Y3SOT2CdyzawdtoxXHMNW4qp2jKDjah/PDdmYgvLe64gKPmlu76rnmBYLGXjJvxNU3NHq/fhMOxS/QFL79OlpRCvtpYCx+u2nnlEfnY89JShES3P+9JZpaNLbHO9khvF7kHWqTnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvr0ZWXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768462456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Acf5ftz2iPMsFNkl3X5gKYrMC5G/p2vaNMThgsq/6Gs=;
	b=fvr0ZWXHTPOd9wY39V5r8Q757Um4ES9/e0nRaHi8msyIoSHdSENuagIAlRytMdLzlaIEnu
	Razqw2onxkFfWI9pvMH/sfjSSya4xEZTydArBO1DYFCaFDqQVx1W1T5w4R/3EscUqL6tsC
	bbZZp93XCwm8P6lxh8s8h1MZPTF0A3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-AnXUil91Mvq8SQJ0PdgneA-1; Thu,
 15 Jan 2026 02:34:10 -0500
X-MC-Unique: AnXUil91Mvq8SQJ0PdgneA-1
X-Mimecast-MFC-AGG-ID: AnXUil91Mvq8SQJ0PdgneA_1768462449
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EEFC180044D;
	Thu, 15 Jan 2026 07:34:09 +0000 (UTC)
Received: from [10.44.32.221] (unknown [10.44.32.221])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2789E180066A;
	Thu, 15 Jan 2026 07:34:06 +0000 (UTC)
Message-ID: <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
Date: Thu, 15 Jan 2026 08:34:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Best practice for ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-acpi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
 <aWgAfsycBDc0mlFv@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aWgAfsycBDc0mlFv@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Andy,

thank you for the honest feedback. I suspect I might have described the 
topology poorly in my previous email, leading to a misunderstanding 
regarding the nature of the "pins".

On 1/14/26 9:45 PM, Andy Shevchenko wrote:
> On Wed, Jan 14, 2026 at 08:19:05PM +0100, Ivan Vecera wrote:
> 
>> I would like to ask for your opinion regarding an ACPI implementation
>> detail for a patch-set I currently have on the netdev mailing list [1].
>> ...
>> Question:
>> Is reusing the DT binding definitions within ACPI _DSD (to allow unified
>> fwnode property parsing) the recommended approach for this type of
>> device relationship?
> 
> TL;DR: Seems to me you are pretty much doing an ugly hack and yes, you violate
> the existing ACPI resources. More details below.
> 
>> Or should I define strictly ACPI-specific bindings/objects, considering
>> that the DT bindings for this feature are also new and currently under
>> review?
>>
>> I want to ensure I am not violating any ACPI abstraction layers by
>> relying too heavily on the DT-style representation in _DSD.
>>
>> Thanks for your guidance.
> 
> First of all, if I understood the HW topology right — it has an I²C muxer
> which has a channel connected to DPLL, which among other functions provides
> some kind of GPIO/pin muxing facility — (correct me, if I'm wrong), the
> irrelevant to ACPI hack is an avoidance of having proper GPIO controller
> driver / description provided with likely pin control and pin muxing
> flavours, which is missing (hence drivers/pinctrl/... should be and it should
> be described in DT).

This is not a GPIO or Pin Control scenario. The "pins" I am referring to 
are clock input/output pads dedicated to frequency synchronization 
(Synchronous Ethernet). They carry continuous clock signals (e.g., 
10MHz, 25MHz, or recovered network clock), not logic levels controllable 
via a GPIO subsystem.

The Hardware Setup:

Control Plane: A user configures the DPLL device (e.g., via I2C/SPI
managed by standard ACPI resources/drivers). This part is standard.

Data/Clock/Signal Plane (The issue at hand): There are physical clock
traces on the board connecting the Ethernet PHY directly to the DPLL.

PHY Output(s) -> DPLL Input Pin(s) (Recovered Clock)

DPLL Output Pin(s) -> PHY Input(s) (Clean Reference Clock)

Since these are purely clock signals between two peripheral devices (not
connected to the CPU's GPIO controller), standard ACPI _CRS resources
like GpioIo or PinFunction do not seem applicable here. To my knowledge,
ACPI does not have a native "Clock Resource" descriptor for inter-device
clock dependencies.

My intention with _DSD was to model this clock dependency graph, similar
to how clocks and clock-names are handled in Device Tree (or how camera
sensors often use _DSD to reference related components).

Does your objection regarding the "ugly hack" still stand, or is
modeling these clock dependencies via _DSD properties (referencing
sub-nodes) an acceptable approach in the absence of a dedicated ACPI
Clock Resource?

I can provide a simple ASCII diagram of the board layout if that helps 
clarify the signal flow.

> Second, ACPI provides the _CRS resources specifically for pin configuration,
> pin control (pin muxing as well). In case it's related those resources must
> be used. The caveat, however, the Linux kernel has not yet implemented the
> glue layer between ACPICA and pin control subsystem (see [5] for more).
> 
> It might be that I didn't get the picture correctly, but it smells badly to me.
> In any case, I would like to help you and I'm open to more details about this
> case.

Thanks for your willingness to help.

Regards,
Ivan


