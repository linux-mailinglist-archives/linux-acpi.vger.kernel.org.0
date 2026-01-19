Return-Path: <linux-acpi+bounces-20431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A32FD3B73B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 20:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8C7F3013BE7
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 19:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530829B8E0;
	Mon, 19 Jan 2026 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Giwc7bAI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD828136C
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768850623; cv=none; b=jJ7Vbn4/++ATPqiH7Z0Ko5e7Uw9h7wwM+Nw3MzDPzk5u2pzslrulNsOR11s5grI9Bml/WGLRaNG4UTNUEelEO+d5ML3GQUgN2tx2NJj0KLHCs720FAhWUvQQ6xh6B5YqewFizaEeBalx4i4ZHJfcE8qputpRvDZUCickqt8oaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768850623; c=relaxed/simple;
	bh=op3/P2MSJdQK6iBF+k3vH3PsFqSQVZQhP7I+Yu3NIyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldwyYxLoBeIODEsYoYPJ/5iH8OIgkV/LBCHHgvDJZT+1x0GQfd4OW+r+aZS5w9I6yEJk9qX0ZDsiYQ45q0+zvm+gwwTp2PLFIJHPe39ZZ/bIrMafxu5xWLkU4dSS8Nmezqok+2JX2lwsBI1cKkIdUQr0ZZs2DzKbc0Gryi5RsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Giwc7bAI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768850618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvZTzX7KrxWHCJ296wpwtuLfLlM/lLeZzlLJIDHWg7A=;
	b=Giwc7bAIMqrIZWxhqwxFlNmp6GPhTcGur0QgsJV4eK5UX0lzQ3V00csLsLJlLd/tqdFopE
	LKxB/02lHxCMtFefGLixkLAL81on/rEw7jwqEqZidg+9vvtpH+E7LavUiT9KXurqnL3xVV
	kF4tdTxUaq0pko8fxLX7Ol86GSPFsYs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-Ve4Z-nOvPqS9dPSA4JzqxQ-1; Mon,
 19 Jan 2026 14:23:35 -0500
X-MC-Unique: Ve4Z-nOvPqS9dPSA4JzqxQ-1
X-Mimecast-MFC-AGG-ID: Ve4Z-nOvPqS9dPSA4JzqxQ_1768850613
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C8A61800451;
	Mon, 19 Jan 2026 19:23:33 +0000 (UTC)
Received: from [10.44.32.102] (unknown [10.44.32.102])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF7F21800577;
	Mon, 19 Jan 2026 19:23:31 +0000 (UTC)
Message-ID: <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
Date: Mon, 19 Jan 2026 20:23:30 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Best practice for ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-acpi@vger.kernel.org
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com>
 <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
 <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com>
 <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aW5umnz8RdQiIzoi@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 1/19/26 6:49 PM, Andy Shevchenko wrote:
> On Mon, Jan 19, 2026 at 06:43:55PM +0100, Andrew Lunn wrote:
>>> P.S. Currently I can consider this as Plan B if we found no other better designs.
>>> However it would be nice to see some review from network people, such as
>>> Andrew Lunn and Vladimir Oltean. They know much more about networking HW
>>> topologies and they have an expertise in ACPI.
>>
>> I've been reviewing the DT parts. And the DT Maintainers are also
>> looking at the patches.
>>
>> But the question being addressed here is, do we want an ACPI binding,
>> following ACPI guidelines etc. Or is it OK to just stuff the DT
>> binding as is into ACPI tables?  No native ACPI binding?
> 
> It depends. If [6] was trying to address what [7] describes in the specification
> and if the current problem with clock fits into all this, perhaps we need to
> finalize the work started in [6].
> 
>> Putting DT into ACPI seems to be accepted when there is a long
>> established DT binding, but ACPI has nothing. Which is common for
>> networking with SoCs and Linux driving the hardware, not firmware. But
>> this is all new, its a new DT binding, should there also be a new ACPI
>> binding?
> 
> Yeah, I understood that point. Unfortunately I'm not so fluent in the Clock
> related parts in ACPI, and I remember that Niyas did something in the area
> while he was working for Linaro. Personally, I was interested only in pin
> control integration part, so I haven't ever looked into other (missing)
> parts he tried to develop.
> 

Hi all,
per Rob's advice, we should reuse existing clock bindings for the
relationship between DPLL device and network controller / phy.

SyncE typically involves one or more clock outputs from network device
connected to DPLL device and one output from DPLL routed back to the
network device. The net device sends a signal received from the ethernet
port to the DPLL. DPLL then locks on this signal, clears jitter and
provides phase-aligned output signal back to the network device.

This setup can be defined by this simplified DT example:

&dpll0 {
	...
	#clock-cells = <1>;
	clock-names = "ref0";
	clocks = <&ethernet0 0>;
	...
};
&ethernet0 {
	...
	#clock-cells = <0>;
	clock-names = "synce_ref";
	clocks = <&dpll0 5>;
	...
};

In this example ethernet0's output 0 (aka rclk) produces clock for
dpll0's input pin named "ref0" and dpll0's 5th output produces clock for
ethernet0's input labelled "synce_ref".

Based on [1] example this clock relationship can be represented by _DSD.
Is it correct?

Thanks,
Ivan

[1] 
https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#dsd-device-specific-data


