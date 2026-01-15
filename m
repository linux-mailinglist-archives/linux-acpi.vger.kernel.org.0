Return-Path: <linux-acpi+bounces-20385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293BD24E17
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 15:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F3193007F21
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9339E6C1;
	Thu, 15 Jan 2026 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bgz1pXux"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA63D76
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486204; cv=none; b=Apc8WvS04dAGwU9Aewy01u94xtjtTNAUcYmfOOiq4Z041HMB/gKiFUj9Zdih2HXcW2qoudWT/G5+Svq/DzIMII1gaHtvMjIWfqQi8kO6kTfFyMMeDMJ36XuE4foTXZrbUOacUQBOHJ3UJzI6CCd0VOwj6ID4ntd1NZzXZ/sYOLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486204; c=relaxed/simple;
	bh=l8PNP8+6WN4D8Rx0AFV0Ef7/d8iW1K9efRnfAIUin9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/5J4xak1BoXdwX0E+dFwiDvV6LrSpaLdttn3jIp638opxnllRRFGTbElI8kFi87IZZb80ZqOMe6CFrawcPTPbtqHjrTLXdA5DGCFI47kigy2c+gfVqiu7nz41EOFtxkROn6QM6JWVL5erlk1mKDW1rz13O46whgFgZFkp629Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bgz1pXux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768486201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K09KIp098APlOjOLX4y2c8awmDIy3ult3Fh85hd1C8Y=;
	b=Bgz1pXuxvycmBGqjxFfDHlgIMI8olfe0qiXEnmG9wtowW/IsMFhWTsBk1s/WSpzNZUfaPn
	b1Ql/83nnwuw400siJ7Jses/pui3+p+UIpY8p0RbxU1MmLt+aYKik2/GYkXncKsMrahruG
	dOTaVUsNkyuaFRSvv5pvHziW9oHx/pk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-qqbggV_tM1mCFjHVRlFugg-1; Thu,
 15 Jan 2026 09:09:58 -0500
X-MC-Unique: qqbggV_tM1mCFjHVRlFugg-1
X-Mimecast-MFC-AGG-ID: qqbggV_tM1mCFjHVRlFugg_1768486197
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B40651954B14;
	Thu, 15 Jan 2026 14:09:56 +0000 (UTC)
Received: from [10.44.32.221] (unknown [10.44.32.221])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74FE518004D8;
	Thu, 15 Jan 2026 14:09:54 +0000 (UTC)
Message-ID: <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
Date: Thu, 15 Jan 2026 15:09:53 +0100
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
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 1/15/26 2:18 PM, Andy Shevchenko wrote:
> On Thu, Jan 15, 2026 at 08:34:05AM +0100, Ivan Vecera wrote:
> 
>> thank you for the honest feedback.
> 
> You're welcome!
> 
>> I suspect I might have described the
>> topology poorly in my previous email, leading to a misunderstanding
>> regarding the nature of the "pins".
> 
> Quite possible.
> 
>> On 1/14/26 9:45 PM, Andy Shevchenko wrote:
>>> On Wed, Jan 14, 2026 at 08:19:05PM +0100, Ivan Vecera wrote:
>> ...
>> This is not a GPIO or Pin Control scenario. The "pins" I am referring to are
>> clock input/output pads dedicated to frequency synchronization (Synchronous
>> Ethernet). They carry continuous clock signals (e.g., 10MHz, 25MHz, or
>> recovered network clock), not logic levels controllable via a GPIO
>> subsystem.
>>
>> The Hardware Setup:
>>
>> Control Plane: A user configures the DPLL device (e.g., via I2C/SPI
>> managed by standard ACPI resources/drivers). This part is standard.
>>
>> Data/Clock/Signal Plane (The issue at hand): There are physical clock
>> traces on the board connecting the Ethernet PHY directly to the DPLL.
>>
>> PHY Output(s) -> DPLL Input Pin(s) (Recovered Clock)
>>
>> DPLL Output Pin(s) -> PHY Input(s) (Clean Reference Clock)
>>
>> Since these are purely clock signals between two peripheral devices (not
>> connected to the CPU's GPIO controller), standard ACPI _CRS resources
>> like GpioIo or PinFunction do not seem applicable here. To my knowledge,
>> ACPI does not have a native "Clock Resource" descriptor for inter-device
>> clock dependencies.
>>
>> My intention with _DSD was to model this clock dependency graph, similar
>> to how clocks and clock-names are handled in Device Tree (or how camera
>> sensors often use _DSD to reference related components).
>>
>> Does your objection regarding the "ugly hack" still stand, or is
>> modeling these clock dependencies via _DSD properties (referencing
>> sub-nodes) an acceptable approach in the absence of a dedicated ACPI
>> Clock Resource?
> 
> Now my "ugly hack" is irrelevant, but still sounds not good.
> I hope you have researched what has been done before [6].
> 
> (Please, return links to the our emails, as it helps to understand the
>   discussion.)
Returned.

> I.o.w. there was an attempt a few years ago to fill the gaps, one of which
> you are mentioning here. Note that the ACPI specification gains something
> related (but I don't remember from top of my head what exactly, please
> refer to it directly [7]).
> 
>> I can provide a simple ASCII diagram of the board layout if that helps
>> clarify the signal flow.
> 
> Yes, please.

In SyncE (Synchronous Ethernet) scenarios, an Ethernet controller or PHY
is typically connected to a DPLL device that provides frequency
synchronization, holdover, and jitter filtering.

A SyncE-capable Ethernet PHY (or controller) usually has:
Output(s): Recovered clock signal connected to a DPLL input pin.
Input(s): Connected to a DPLL output pin.

Example:
      ETH controller or PHY
     +--------------------+
+---| rclk0              |
|+--| rclk1    synce_ref |<-+
||  +--------------------+  |
||                          |
||           DPLL           |
||  +--------------------+  |
|+->| ref1n              |  |
+-->| ref3n        out1p |--+
     +--------------------+

In DT this could look like:
   ...
   &dpll0 {
     ...
     input-pins {
       pin@3 {
         ...
       };
       pin@5 {
         ...
       };
     };
     output-pins {
       pin@2 {
         ...
       };
     };
   };
   &phy2 {
     ...
     dpll-pin-names = "rclk0", "rclk1", "synce_ref";
     dpll-pins = <&dpll0 3 DPLL_PIN_INPUT>,
                 <&dpll0 5 DPLL_PIN_INPUT>,
                 <&dpll0 2 DPLL_PIN_OUTPUT>;
     ...
   };

For ACPI I have followed [8][9][10] to create ASL code for the following
system (Intel GNR-D):
1. There is an I2C Mux (pca9546) connected to system SMBus
2. On the 3rd channel there is a I2C DPLL device (ZL30732) at address
    0x70
3. There is 4-port NIC (E825C) on PCIe bus

[3] is sample SSDT that adds the I2C mux and the DPLL device
[4] is sample SSDT that adds to the NICs 'dpll-pins' and
     'dpll-pin-names' properties to 2 NICs.

The goal of the patch-set [1] is that NIC driver (ice) will be able to
check what DPLL pins are used for its recovered clock outputs and what
DPLL pin provides the cleaned/synchronized signal for its input.
If so the NIC driver can report these DPLL pin IDs to the userspace
and a user can configure/monitor these pins accordingly.

Thank you,
Ivan

Links:
[1]
https://patchwork.kernel.org/project/netdevbpf/list/?series=1040080&state=*
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dpll
[3] https://github.com/ivecera/zl3073x-acpi/blob/main/sample1.asl
[4] https://github.com/ivecera/zl3073x-acpi/blob/main/dpllnic.asl
[5] https://lore.kernel.org/r/20221130164027.682898-1-niyas.sait@linaro.org
[6] https://linaro.atlassian.net/wiki/spaces/CLIENTPC/overview
[7] https://uefi.org/specs/ACPI/6.6/
[8] https://github.com/UEFI/DSD-Guide/blob/main/dsd-guide.pdf
[9] https://docs.kernel.org/firmware-guide/acpi/i2c-muxes.html
[10] 
https://docs.kernel.org/firmware-guide/acpi/dsd/data-node-references.html


