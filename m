Return-Path: <linux-acpi+bounces-20439-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A3D3BEDE
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 06:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34FD44ED843
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9135CB9B;
	Tue, 20 Jan 2026 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA37WpYx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69C22A1E1
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jan 2026 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768887586; cv=none; b=Oj70A9enFNGtibtL+//mDEAseQUs8/Cw0WtC27B7iPV87QHx5ilboObl3OHpIL5b57qis9MXuz04MLvWutv0UHbfPSSO0FaC9+7BmidCY+T/t2wEWe8fUDy2TO24nwbVKTtJaBH0dwLnD8GLxKwKrPS0e80kIj0p54/2fYXD2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768887586; c=relaxed/simple;
	bh=OqyhRfp6fGgjv8Cj/5UdYA2bOSNSi5OPAeShMCWBK58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXpq9nSrypYa+kgt171tq6VK5ax02LsnENcaVXNsD62VMIJy9Gz8tfUSBaKGFgfU6Jvp5SLHWpaPnlpZL7MV8nE8LKm3pakZ9Rzgd3nm+36oSPTCDBWRy2dL68xSxedaFFytbauzm4y2a4RT/6GiRMNnNj1hFfZdV0XoxOwjTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA37WpYx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768887583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIEtfRaqrAySH6qZhU4wqCRXW/8XpuyhgSHVkq0Vp9Q=;
	b=KA37WpYx/s7mJiEyzJtQPrgUEHM4VDwaGzm4btLRCiXb46J/egseem8ggjVVXNE0sTc6JI
	vP2o2hnpfJlbbP2T5FETRigrzIpjMYWm8+Ri9/2w57meXBB/Mk8GFH1GjNTx5caqxueQ9X
	f/8qM8yXLhw5kxHNBJYR4ngT9X2wycw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-Zvi6DkXsMhWDTN_U3A-aDw-1; Tue,
 20 Jan 2026 00:39:37 -0500
X-MC-Unique: Zvi6DkXsMhWDTN_U3A-aDw-1
X-Mimecast-MFC-AGG-ID: Zvi6DkXsMhWDTN_U3A-aDw_1768887576
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9887195609D;
	Tue, 20 Jan 2026 05:39:35 +0000 (UTC)
Received: from [10.44.32.102] (unknown [10.44.32.102])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AF681800665;
	Tue, 20 Jan 2026 05:39:32 +0000 (UTC)
Message-ID: <9861f9da-5f5e-4b2a-ab3f-6ac1a3faebdd@redhat.com>
Date: Tue, 20 Jan 2026 06:39:31 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Best practice for ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Linus Walleij <linusw@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-acpi@vger.kernel.org
References: <aWgAfsycBDc0mlFv@smile.fi.intel.com>
 <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com>
 <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com>
 <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com>
 <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
 <aW6JNDr0ZoBjHMeS@smile.fi.intel.com>
 <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
 <aW6UBBvFHP_gEg-V@smile.fi.intel.com>
 <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 1/20/26 12:34 AM, Linus Walleij wrote:
> On Mon, Jan 19, 2026 at 9:28 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> (...)
>>>>> Based on [1] example this clock relationship can be represented by _DSD.
>>>>> Is it correct?
>>>>
>>>> I didn't really get, is this a clock provider-consumer relations or pin
>>>> connections? If this is a pin connections, why there is no pin mux driver
>>>> for it?
>>>
>>> In fact this should be dpll provider-consumer schema. Consumer (e.g.
>>> net device, phy...) uses (consumes) DPLL service (frequency
>>> synchronization, ...) and DPLL device provides such service.
>>>
>>> Note that the pin in this context is DPLL pin not pin related to pinctrl
>>> or so...
>>
>> Right, so these are pins with special functions, which are not GPIO like.
>> But pin mux is not only about GPIO, that's the nice part of it.
>>
>> +Cc: Linus for his view on this issue.
> 
> In theory a pin controller can be instantiated in any random driver that
> controls a few pins of its own to the outside world, just like we have a few
> few-pin GPIO chips here and there such as for USB serial adapters.
> 
> In practice nobody does this, they have some driver-local way of handling
> pins and mux them around for their special use case.
> 
> Graphic cards or audio would be an example. Much custom muxing
> happening there I think.
> 
> I have no strong opinion on the subject, it's up to the driver author I think.
> 
> ACPI aspects I can't talk about because I don't understand them...
> 
> Hope this helps!
> 
> Yours,
> Linus Walleij

Hi all,
I think we might be getting sidetracked by the specific subsystems
(pinctrl/GPIO/Clock).

The core problem I am trying to solve is modeling the linkage between
the two devices. The NIC acts as a consumer that needs to "know" about
the DPLL (the supplier) in the ACPI table.

We need a way to tell the NIC driver: "Here is a handle to the DPLL
device you are connected to, and here are the specific resource IDs
(pins) you are wired to. So a user (userspace) can monitor/configure
such DPLL inputs and outputs using DPLL Netlink API."

Regardless of whether the underlying signal is a clock or a logic level, 
the immediate requirement is simply resolving this cross-device 
dependency so the NIC can identify these resources and report their IDs
into userspace.

Thanks,
Ivan


