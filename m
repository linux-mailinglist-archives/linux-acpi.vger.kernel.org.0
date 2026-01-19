Return-Path: <linux-acpi+bounces-20433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC38D3B7C3
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF8373001C9C
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 19:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3264B28FFE7;
	Mon, 19 Jan 2026 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GySi6gXP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA825CC40
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852551; cv=none; b=d50llbBMTKqLft7P/V2pD74wO7Ig0kZ4gJuBUXVQmpMaMdw0fNsugR8Dg5EjuRM2iqRcZvW4UUIcaO8rwddQD7WxWp+Ot2laJX0LtpsfmEVD5bl7lv473EdB757J+WUbwAuuv7mBY2os996QxR1bHitqoS8H6v9lc5YZBvrq/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852551; c=relaxed/simple;
	bh=MONv0u4I7E3Ytyyk5bWnW7iBlgcBnzVsB47eUfBvEG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpmI7davkYaWXL3kcxYQ+gzqbs4NPvAm5sOP0yLXstM6VeDHW9Vx4HAO6obBCYT37uyj8PbvL8i9i3NcnPl7d5qqYbcQHhA0NWt6h3h57h8O1oV6MZvFKNZvjqjE93wqiKkhJy440WzrK603gGTEchBaeTJN5E7WkeGbEEjVqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GySi6gXP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768852548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eT97ergogINxzsLg/PPDXHQ79iKICtlMeKRa3wB8uk=;
	b=GySi6gXPM/fz/9SuytqokFgKpSMG0/JqFbOie+0EdI0a4PnOAA7JPamWSv3VEERgIOMZDI
	aE266EoEeP4STnmJOlfv3doomtp7AVScWL+nlLBZiamfy+ZmPZxlqABjjR9MQFTsC1iVnJ
	pH/u41HSQfsMmBgDeRNIYoqt2Ln9jpU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-bRvbk93YNwKgNuCn4rGCTg-1; Mon,
 19 Jan 2026 14:55:46 -0500
X-MC-Unique: bRvbk93YNwKgNuCn4rGCTg-1
X-Mimecast-MFC-AGG-ID: bRvbk93YNwKgNuCn4rGCTg_1768852544
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 942731800342;
	Mon, 19 Jan 2026 19:55:44 +0000 (UTC)
Received: from [10.44.32.102] (unknown [10.44.32.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 851711800665;
	Mon, 19 Jan 2026 19:55:42 +0000 (UTC)
Message-ID: <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
Date: Mon, 19 Jan 2026 20:55:40 +0100
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
Cc: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
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
 <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
 <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 1/19/26 8:42 PM, Andy Shevchenko wrote:
> On Mon, Jan 19, 2026 at 08:23:30PM +0100, Ivan Vecera wrote:
>> On 1/19/26 6:49 PM, Andy Shevchenko wrote:
>>> On Mon, Jan 19, 2026 at 06:43:55PM +0100, Andrew Lunn wrote:
> 
> ...
> 
>>>>> P.S. Currently I can consider this as Plan B if we found no other better designs.
>>>>> However it would be nice to see some review from network people, such as
>>>>> Andrew Lunn and Vladimir Oltean. They know much more about networking HW
>>>>> topologies and they have an expertise in ACPI.
>>>>
>>>> I've been reviewing the DT parts. And the DT Maintainers are also
>>>> looking at the patches.
>>>>
>>>> But the question being addressed here is, do we want an ACPI binding,
>>>> following ACPI guidelines etc. Or is it OK to just stuff the DT
>>>> binding as is into ACPI tables?  No native ACPI binding?
>>>
>>> It depends. If [6] was trying to address what [7] describes in the specification
>>> and if the current problem with clock fits into all this, perhaps we need to
>>> finalize the work started in [6].
>>>
>>>> Putting DT into ACPI seems to be accepted when there is a long
>>>> established DT binding, but ACPI has nothing. Which is common for
>>>> networking with SoCs and Linux driving the hardware, not firmware. But
>>>> this is all new, its a new DT binding, should there also be a new ACPI
>>>> binding?
>>>
>>> Yeah, I understood that point. Unfortunately I'm not so fluent in the Clock
>>> related parts in ACPI, and I remember that Niyas did something in the area
>>> while he was working for Linaro. Personally, I was interested only in pin
>>> control integration part, so I haven't ever looked into other (missing)
>>> parts he tried to develop.
>>
>> Hi all,
>> per Rob's advice, we should reuse existing clock bindings for the
>> relationship between DPLL device and network controller / phy.
> 
> Why? If ACPI gains proper concept of clocks, the usage of DT bindings will be
> a hack.

I have been wanting to propose a new consumer / supplier schema for
dpll-pins [1] but it was advised to use existing clock-binding schema to
represent this relationships.

>> SyncE typically involves one or more clock outputs from network device
>> connected to DPLL device and one output from DPLL routed back to the
>> network device. The net device sends a signal received from the ethernet
>> port to the DPLL. DPLL then locks on this signal, clears jitter and
>> provides phase-aligned output signal back to the network device.
>>
>> This setup can be defined by this simplified DT example:
>>
>> &dpll0 {
>> 	...
>> 	#clock-cells = <1>;
>> 	clock-names = "ref0";
>> 	clocks = <&ethernet0 0>;
>> 	...
>> };
>> &ethernet0 {
>> 	...
>> 	#clock-cells = <0>;
>> 	clock-names = "synce_ref";
>> 	clocks = <&dpll0 5>;
>> 	...
>> };
>>
>> In this example ethernet0's output 0 (aka rclk) produces clock for
>> dpll0's input pin named "ref0" and dpll0's 5th output produces clock for
>> ethernet0's input labelled "synce_ref".
>>
>> Based on [1] example this clock relationship can be represented by _DSD.
>> Is it correct?
> 
> I didn't really get, is this a clock provider-consumer relations or pin
> connections? If this is a pin connections, why there is no pin mux driver
> for it?

In fact this should be dpll provider-consumer schema. Consumer (e.g.
net device, phy...) uses (consumes) DPLL service (frequency
synchronization, ...) and DPLL device provides such service.

Note that the pin in this context is DPLL pin not pin related to pinctrl
or so...

Thanks,
Ivan


