Return-Path: <linux-acpi+bounces-20566-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIXMDEBjcmnfjQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20566-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:49:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B66BAAB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 18:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B035302C65E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8243632AAA7;
	Thu, 22 Jan 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh9ijFU9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36434CFBA
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102219; cv=none; b=mHOFwRzrw04mzVRbgluM70xXjswmnOuaVh66JwJ+dbi0N+HXmxoOLWseiq2x5AjODpCz9vBL9Z8XHhtLsXShQnc9n5N9sBD4VFTLGE+tym5v6Zydq9g9eaPfr2whYpWMffBAIa6xtyguLnSbClk2UwisrJR79s+QFLC9R76W6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102219; c=relaxed/simple;
	bh=Zl0RUTM1nV5QFz0BZY4bIdqDQoq/b8UG1nXxY90TT5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsgyR3C0yG081U34m2N9ErT1hoKs0664GuO1J9GJUpEH556kLCs/ZKUdEdxsDFn8GP0d//64HjkI+eDku3xt+HMDaQ4ektgmJu+2m4JQ0SSm2F7cDfGotxsxrGCCZJ2W9lT9k4TvFQ8uy1UJRt9b/UpzqhnCFOu2dHi5iaL68H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nh9ijFU9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769102211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cACzRvskpdyNBFs9OalIVQcD+4BH5aPVPptqRGMMJ8=;
	b=Nh9ijFU9FuSjTFvOnrHjY2S/3NjNUtQPzgtf/tXipN28cNZpJIHV5EwAmbSdCYHaisakNz
	eGSclplM+RBLEpYmS75MHthTS/w+k47ebuwn2uZPonYElxfaH0fatPWpYdVGyE1bRaunxw
	wxYxXa7sRCiAnKOBoJLZfD/JcxVkkWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-K-gmX9ERP5mwXPuYZZmWgw-1; Thu,
 22 Jan 2026 12:16:48 -0500
X-MC-Unique: K-gmX9ERP5mwXPuYZZmWgw-1
X-Mimecast-MFC-AGG-ID: K-gmX9ERP5mwXPuYZZmWgw_1769102206
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC9C619775AC;
	Thu, 22 Jan 2026 17:16:45 +0000 (UTC)
Received: from [10.45.224.35] (unknown [10.45.224.35])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FB201956095;
	Thu, 22 Jan 2026 17:16:40 +0000 (UTC)
Message-ID: <c0de7c8b-8fea-4e76-bec4-6337153fc7a1@redhat.com>
Date: Thu, 22 Jan 2026 18:16:39 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
To: Andrew Lunn <andrew@lunn.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>,
 Jan Aleszczyk <jaleszcz@redhat.com>, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, linux-acpi@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
 <a6e64236-d164-40d1-85d3-caf7d27fc952@lunn.ch>
 <c87cecdc-8ba5-4831-889f-0d903ae7b5ca@redhat.com>
 <11ebf2de-bbd4-4aec-befa-cf0877cfa960@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <11ebf2de-bbd4-4aec-befa-cf0877cfa960@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-20566-lists,linux-acpi=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:url]
X-Rspamd-Queue-Id: 9F6B66BAAB
X-Rspamd-Action: no action

Hi Andrew,

I think there is a significant misunderstanding regarding the
architecture of the DPLL subsystem.

On 1/22/26 4:46 PM, Andrew Lunn wrote:
> On Thu, Jan 22, 2026 at 12:50:50PM +0100, Ivan Vecera wrote:
>> Hi Andrew,
>>
>> (Adding Sakari Ailus to CC, who might have insights on modeling
>>   component topologies in ACPI).
>>
>> On 1/22/26 1:09 AM, Andrew Lunn wrote:
>>>> * While the physical signals on these wires are indeed clocks (10MHz,
>>>>     etc.), from the OS driver perspective, this is not a "Clock Resource"
>>>>     issue. The NIC driver does not need to gate, rate-set, or power-manage
>>>>     these clocks (which is what _CRS/ClockInput implies).
>>>
>>> Is this a peculiarity of the zl3073x? No gating, no rate-set, no power
>>> management?
>>>
>>> I had a quick look at the Renesas 8V89307
>>>
>>> https://www.renesas.com/en/document/dst/8v89307-final-data-sheet?r=177681
>>>
>>> Two of the three inputs have an optional inverter. CCF has
>>> clk_set_phase(), which when passed 180 would be a good model for this.
>>> The inputs then have dividers which can be configured. I would
>>> probably model them using CCF clk-divider.c for that. There is then a
>>> mux, which clk-mux.c could model. After the DPLL there are more muxes
>>> to optionally route the output through an APLL. The output block then
>>> has yet more muxes and dividers.
>>>
>>> All that could be described using a number of CCF parts chained
>>> together in a clock tree.
>>>
>>> And what about the TI LMK05028
>>>
>>> https://www.ti.com/product/LMK05028
>>>
>>> It also has inverters and muxes, but no dividers.
>>>
>>> Analog Devices ad9546 also has lots of internal components which could
>>> be described using CCF
>>>
>>> https://www.analog.com/media/en/technical-documentation/data-sheets/ad9546.pdf
>>
>> I agree with you that the hardware itself (ZL3073x, Renesas 8V89307,
>> etc.) is complex and has internal structures (dividers, muxes) that
>> technically fit the CCF model.
>>
>> However, I believe the distinction lies in how the inter-device topology
>> is used versus how the device is managed internally.
>>
>> The kernel now uses the dedicated DPLL Subsystem (drivers/dpll) for
>> SyncE and similar applications. This subsystem was created because CCF
>> captures "rate and parent" well, but does not capture SyncE-specific
>> aspects like lock status, holdover, priority lists, and phase-slope
>> limiting.
>>
>> In our architecture, the complex configuration you mentioned (dividers,
>> muxes) is managed via the DPLL Netlink ABI. The control logic largely
>> resides in userspace daemons (e.g., synce4l), which send Netlink
>> commands to the DPLL driver to configure those internal muxes/dividers
>> based on network conditions.
> 
> So you are effectively doing user space drivers? You have a library of
> DPLL drivers, which gets linked to synce4l? The library can then poke
> registers in the device to configure all the muxes, inverters,
> dividers?

No, absolutely not. The drivers for these devices reside entirely in the
kernel. They handle all the low-level register access, mux config, and
hardware abstraction.

The userspace (e.g. synce4l daemon) is purely a Policy Engine. It uses
a  generic, hardware-agnostic Netlink API to send high-level commands
like "Lock to Pin 0" or "Set Priority 1". The in-kernel driver
translates these generic commands into the specific register writes
required for that chip (ZL3073x, etc.).

See DPLL docs:
https://docs.kernel.org/driver-api/dpll.html

> But doesn't that also require that synce4l/the library knows about
> every single board? It needs to know if the board requires the input
> clock to be inverted? The output clock needs to be inverted? It needs
> to know about the PHY, is it producing a 50Mhz clock, or 125MHz which
> some devices provide, so will need the divider to reduce it to 50MHz?
> Doesn't the library also need to know the clock driving the DPLL
> package? Some of these products allow you to apply dividers to that as
> well, and that clock is a board property.
>
> To me, it seems like there are a collection of board properties, and
> to make this scale, those need to be in DT/ACPI, not a user space
> library.
 >>
>> The NIC driver's role here is passive; it effectively operates in a
>> "bypass" mode regarding these signals. The NIC does not need to call
>> clk_set_rate() or clk_prepare_enable() on these pins to function. It
>> simply needs to report the physical wiring linkage: "My input / output
>> is wired to DPLL pin with index X."
> 
> I can understand this bit, although actually using
> clk_prepare_enable() would allow for runtime power management.
> 
> But i'm thinking more about these board properties. If i model the
> internals of the DPLL using CCF, CCF probably has all the needed
> control interfaces. The board properties then just set these controls.
> It then seems odd that i have a Linux standard description of the
> internals of the DPLL using CCF, i use the CCF binding to describe the
> external interconnects, but don't actually use CCF to implement these
> external interconnect?

But I don't use CCF bindings in this design, this design is about
representing an opaque wire between two devices.

What you are talking about is rather a possibility of implementing DPLL 
support in a CCF based clock driver.

>> If we use standard Clock bindings (CCF), we imply a functional
>> dependency where the NIC acts as a controller/consumer that actively
>> manages the clock's state. In reality, the NIC is just a conduit mapping
>> a local port to a remote pin index.
> 
> If you look at MAC drivers, all they really do is
> clk_prepare_enable(). Few do more than that. So i don't really see
> this as being a burden.

For SyncE where the NIC produces clock this would:
* require to implement clock provider in the NIC driver (clk_ops...)
* require to expose this clock source in ACPI

But why? For representing opaque wire between two devices?

This design is not a classic consumer/producer. The DPLL driver doesn't
care where its inputs and outputs are connected, it doesn't need to
know. And the NIC driver only cares where it is connected, but not from
resources perspective, but to inform the userspace about this fact.

Ivan


