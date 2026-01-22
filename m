Return-Path: <linux-acpi+bounces-20542-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBuvCgEdcmnrbwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20542-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:50:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB366D77
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAD43721F99
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC3421A1E;
	Thu, 22 Jan 2026 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSgNyZv6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325C3ACA62
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082666; cv=none; b=U26Q2av8LpqS45JMqfGhd4bpIHPVAHbXYOix8DtgSQFarO8ALJxP5HjgA6+WkHfTjXWtH1HMPZi8TWIMQnA+MgskmPMMJRQLyFbpJox1EEzYBjCyXThtEsf5cHCABxpt9Fld6jQSXnCqzT+46AXTWr7jYY615tAqvGft+SjEZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082666; c=relaxed/simple;
	bh=3Pa1VnZ+BCbmLEI4m7Qgd5wGikTxBI+GTyVTu6C7AW4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gqo5ONIygHu1YJStJm52c2DONb5nD8h68OipctYvLEqPLOIS+iPv29fXuFvMpcg0aBpVx4JwAeMXC+LJE3R3n1RSOouUNY0yulb8fNZHTxKCA7LABuDGR4Vr8FHZsHBNfqeONv4PfwuQlDaZDzV8YuhYSoyIYZIj6cedYSaIjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSgNyZv6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769082663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TGblO5iXhT/s9b+tg5+0vYPJq6Re+s4kM0xTkCDf6M=;
	b=dSgNyZv6lU5NqDKqVTsz1e504Yhjif+AgJjHBEwmLWlprBZN+cw05tSukpqULWsPHJOXik
	foBCZcuD6/AfVRn929TJ1PfxFdxEQLcOVdiIMZFlhQLpi70XLmdXQOL3hrGSf9Fv3gAhOx
	eIay2HCauZo3mn/Ar/8oRvivkUqnk+Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-HQ6WwfY1N9-Zj_BLG4kPbw-1; Thu,
 22 Jan 2026 06:51:00 -0500
X-MC-Unique: HQ6WwfY1N9-Zj_BLG4kPbw-1
X-Mimecast-MFC-AGG-ID: HQ6WwfY1N9-Zj_BLG4kPbw_1769082658
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CC1419560AA;
	Thu, 22 Jan 2026 11:50:57 +0000 (UTC)
Received: from [10.44.32.135] (unknown [10.44.32.135])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95EC51800577;
	Thu, 22 Jan 2026 11:50:51 +0000 (UTC)
Message-ID: <c87cecdc-8ba5-4831-889f-0d903ae7b5ca@redhat.com>
Date: Thu, 22 Jan 2026 12:50:50 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ivan Vecera <ivecera@redhat.com>
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
Content-Language: en-US
In-Reply-To: <a6e64236-d164-40d1-85d3-caf7d27fc952@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-20542-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,ti.com:url,renesas.com:url]
X-Rspamd-Queue-Id: C5AB366D77
X-Rspamd-Action: no action

Hi Andrew,

(Adding Sakari Ailus to CC, who might have insights on modeling
  component topologies in ACPI).

On 1/22/26 1:09 AM, Andrew Lunn wrote:
>> * While the physical signals on these wires are indeed clocks (10MHz,
>>    etc.), from the OS driver perspective, this is not a "Clock Resource"
>>    issue. The NIC driver does not need to gate, rate-set, or power-manage
>>    these clocks (which is what _CRS/ClockInput implies).
> 
> Is this a peculiarity of the zl3073x? No gating, no rate-set, no power
> management?
> 
> I had a quick look at the Renesas 8V89307
> 
> https://www.renesas.com/en/document/dst/8v89307-final-data-sheet?r=177681
> 
> Two of the three inputs have an optional inverter. CCF has
> clk_set_phase(), which when passed 180 would be a good model for this.
> The inputs then have dividers which can be configured. I would
> probably model them using CCF clk-divider.c for that. There is then a
> mux, which clk-mux.c could model. After the DPLL there are more muxes
> to optionally route the output through an APLL. The output block then
> has yet more muxes and dividers.
> 
> All that could be described using a number of CCF parts chained
> together in a clock tree.
> 
> And what about the TI LMK05028
> 
> https://www.ti.com/product/LMK05028
> 
> It also has inverters and muxes, but no dividers.
> 
> Analog Devices ad9546 also has lots of internal components which could
> be described using CCF
> 
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad9546.pdf

I agree with you that the hardware itself (ZL3073x, Renesas 8V89307,
etc.) is complex and has internal structures (dividers, muxes) that
technically fit the CCF model.

However, I believe the distinction lies in how the inter-device topology
is used versus how the device is managed internally.

The kernel now uses the dedicated DPLL Subsystem (drivers/dpll) for
SyncE and similar applications. This subsystem was created because CCF
captures "rate and parent" well, but does not capture SyncE-specific
aspects like lock status, holdover, priority lists, and phase-slope
limiting.

In our architecture, the complex configuration you mentioned (dividers,
muxes) is managed via the DPLL Netlink ABI. The control logic largely
resides in userspace daemons (e.g., synce4l), which send Netlink
commands to the DPLL driver to configure those internal muxes/dividers
based on network conditions.

The NIC driver's role here is passive; it effectively operates in a
"bypass" mode regarding these signals. The NIC does not need to call
clk_set_rate() or clk_prepare_enable() on these pins to function. It
simply needs to report the physical wiring linkage: "My input / output
is wired to DPLL pin with index X."

If we use standard Clock bindings (CCF), we imply a functional
dependency where the NIC acts as a controller/consumer that actively
manages the clock's state. In reality, the NIC is just a conduit mapping
a local port to a remote pin index.

We are effectively modeling a graph linkage (similar to ports / remote-
endpoint in media graphs) rather than a functional resource (like
clocks=<&clk0> or regulators=<&some_reg>).

We are utilizing _DSD properties to model this topology edge, which is
consistent with how other subsystems (like Media) utilize firmware node
graphs in ACPI to describe complex non-resource connections.

This provides the NIC driver with the "remote endpoint ID" (the pin
index) it needs to populate the Netlink ABI, without forcing the driver
to import the complexity of a full Clock Tree that it has no intention
of managing.

Does this distinction—modelling the "topology graph" rather than
a "clock resource" make sense as a rationale for using _DSD here?

Regards,
Ivan

> So i do wounder if we are being short sighted by using the clock
> bindings but not Linux clocks.
> 
> 	Andrew
> 


