Return-Path: <linux-acpi+bounces-20434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19BDD3B7FA
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 21:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 915C5301BCC4
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 20:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD82E8DEA;
	Mon, 19 Jan 2026 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxrwEByn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiRm9fi1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98C26CE25
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768853254; cv=none; b=MHK7yUs6wG3zTosER+nktuo7JRaHAOyXXSx6Xl1OvYuyrtYgOnv2EgQhA8G0dbDklZuIK1QEl3vMYmZFM4llw+h8a7IrPjCXlKKbUDYNifpAKtuPmOk1eFmH7v2c5ZbY6+qcf5XwOXTY3kv5Q3p/2fTgRIyVZ4rJ79m8gAzg3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768853254; c=relaxed/simple;
	bh=fJfGlrTmI4nPmYol9AEbdEArAAgnYw2a2KvxHfcp3Bo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l4fz9TG5+muLAh2Y0NeTBJvs82/GksXASov8HnxH+bBRK5mbmUe3QVFEP1glzr0mFQ00im3mLbmB6rOPS7iYLYu+lE/1tWrEpGRYJFhqkQ7SAg5BmKm9birgZAY6sq9vLkfCbhj/520h+KstveSHdYSbPW7nvHd+IcXKBfAEyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxrwEByn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiRm9fi1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768853251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QBDXEhoXvSCk7gsBzkNU4jJIbw3vbPAlNSPQk5d3rg=;
	b=MxrwEByngNx1t40fdEZ6y3CUN1tqIAnkBTXXHdhUFffQmOyTJUeMJ6ayp4MPPMxdCrG5xt
	J4popNryIcAm/H3Abrfs3VC21TO/+zuu/M6uBE8YbzO5x6UjHZ9Tz+EagnMr1F7rOf2hdr
	ijwSOaHKam+xzqXjigvY799JBTZEb24=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-9N7lpsPIOoyHLjh3Gfk0sg-1; Mon, 19 Jan 2026 15:07:30 -0500
X-MC-Unique: 9N7lpsPIOoyHLjh3Gfk0sg-1
X-Mimecast-MFC-AGG-ID: 9N7lpsPIOoyHLjh3Gfk0sg_1768853249
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so42935935e9.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768853249; x=1769458049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QBDXEhoXvSCk7gsBzkNU4jJIbw3vbPAlNSPQk5d3rg=;
        b=WiRm9fi1kPpTDd2fpda4tEI1uFcfzfBK/o1xNzMDKHPwU/dLWyUgY11Ts+yRM7oysL
         KJUtzfdxDvomFgSFmz9s2lccCunzSM9M1vMZ57cWraPlKthEMDZLgEJ61J9FgM3QNJ6u
         XC5UqwwMNEvwxP0I03x5OaXy1CGQSkEI++KQrXy/9tMAzQwaA7y8kUpW49HDLWk47oZ3
         vk6UpexyyhQt6uZlR3dzBMHIbOPuwVJW2XXHAqUS3PDUDiD6QQz/5JV+gm7v97N+0eQv
         QvTXhg9VOFLF70qB5t2bvxAIzWeqNCm+KvGz3dpHMNZ7s4/nNleG9bBc5oqVA5JcwCIe
         PTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768853249; x=1769458049;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QBDXEhoXvSCk7gsBzkNU4jJIbw3vbPAlNSPQk5d3rg=;
        b=tltbnAouWY3RiLClGcT0CXed8OmCELjExbuO2qrIEraaDA56ZEC267mM6JFKXbRlvx
         tGj4JGDrxWu9tq8PrjJPajn6eoI+xvoXIzz+lYievx7mpb04DZ4xyDsAQfg8EpGXfUIS
         z7OOmHGWas74gXmQdk32gWEHP0Ucd3siepZGg8hfwDK3U++2D7wOwf1yfhSn+CVqcMN1
         vLcTPSv3/T32OH/kp3lC642t/MuPjeh2xSkt0r81gxGZGjbVyJk9LDzBrypUl/d+MlNJ
         W602zs+MT08boYyE8ibiOXlCj7CK1DgGvUB89EUSnFTmc/5V6yURnt5ytOoJIMMuzhdZ
         0kCg==
X-Forwarded-Encrypted: i=1; AJvYcCXF9Uk4C+2kwMnXkUHs5LOfNxBf4HHBXK7wM/hPSebJgijrOY4i3tNYTPIMqhvTsnVvcJhB2RRtKJB5@vger.kernel.org
X-Gm-Message-State: AOJu0YxWec8Kf1s/Z8kU6c3a9ZPyc/7Wb7hn1aI8M94eablYBUMZgop3
	05/IpQYTYdpLueBg1xKZ2sXC+bUa2Z/zvvMzn05SHMRTLpHv/7nBjJmJGxbfh7coY/deGgNNYD3
	SXIkCWo5U3XmIBXPsANhM25AzgZxVT2T9jvwWKnx3zkAkdodfBNQsAcHXRSym7Kc0WpJYZyo=
X-Gm-Gg: AY/fxX42hfiDtMVrWxiN1mucKb2ZxvqajTlCi1MDJBfXUlEUo5FBybQ0wAz8nkmbCeA
	3bcSqKvdv60JSxvkz6ss7XsanKbUaYYHuO02ocnoizSGLBMiokE27tpyJK0Gp1wUpczAdRoMy6t
	oGFx7FZeL/LfgQ6rrOhhnZ9fgm5Em0v9B/Fv133lu4t0fz/KTGOEFldum4/v1rcHhJH3Wx1kE1n
	/pF7e46VfYTQQNFpSdtYGf6mFcC9YJImj+o4JplF8gC6ws6hwdcEpElYAPx769nQKvp3Md9cr/M
	+d1jqOLOgQXzOMp/gH6FFKlB7aYZhA3HnvCCJvbpuObP2geIi+5ejj/H+8oJ3TWtRBxmdNXm5f8
	HmN4ObOqADJXmC+whMA==
X-Received: by 2002:a05:600c:8288:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-4801e33a8fcmr141604765e9.19.1768853249220;
        Mon, 19 Jan 2026 12:07:29 -0800 (PST)
X-Received: by 2002:a05:600c:8288:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-4801e33a8fcmr141604465e9.19.1768853248757;
        Mon, 19 Jan 2026 12:07:28 -0800 (PST)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:c10e:e5a7:3777:7841])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8caceesm207791655e9.13.2026.01.19.12.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 12:07:28 -0800 (PST)
Date: Mon, 19 Jan 2026 21:07:26 +0100
From: Ivan Vecera <ivecera@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Andrew Lunn <andrew@lunn.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-acpi@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BQuestion=5D_Best_practice_for_ACPI_represe?=
 =?US-ASCII?Q?ntation_of_DPLL/Ethernet_dependencies_=28SyncE=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
References: <3bf214b9-8691-44f7-aa13-8169276a6c2b@redhat.com> <aWgAfsycBDc0mlFv@smile.fi.intel.com> <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com> <aWjpQhGyHXXjsx2b@smile.fi.intel.com> <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com> <aW5mn9pXYOU-3djd@smile.fi.intel.com> <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch> <aW5umnz8RdQiIzoi@smile.fi.intel.com> <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com> <aW6JNDr0ZoBjHMeS@smile.fi.intel.com> <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
Message-ID: <BBB31EB1-FC59-477D-BF9D-5633F78776FA@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 19, 2026 8:55:40 PM GMT+01:00, Ivan Vecera <ivecera@redhat=2Eco=
m> wrote:
>On 1/19/26 8:42 PM, Andy Shevchenko wrote:
>> On Mon, Jan 19, 2026 at 08:23:30PM +0100, Ivan Vecera wrote:
>>> On 1/19/26 6:49 PM, Andy Shevchenko wrote:
>>>> On Mon, Jan 19, 2026 at 06:43:55PM +0100, Andrew Lunn wrote:
>>=20
>> =2E=2E=2E
>>=20
>>>>>> P=2ES=2E Currently I can consider this as Plan B if we found no oth=
er better designs=2E
>>>>>> However it would be nice to see some review from network people, su=
ch as
>>>>>> Andrew Lunn and Vladimir Oltean=2E They know much more about networ=
king HW
>>>>>> topologies and they have an expertise in ACPI=2E
>>>>>=20
>>>>> I've been reviewing the DT parts=2E And the DT Maintainers are also
>>>>> looking at the patches=2E
>>>>>=20
>>>>> But the question being addressed here is, do we want an ACPI binding=
,
>>>>> following ACPI guidelines etc=2E Or is it OK to just stuff the DT
>>>>> binding as is into ACPI tables?  No native ACPI binding?
>>>>=20
>>>> It depends=2E If [6] was trying to address what [7] describes in the =
specification
>>>> and if the current problem with clock fits into all this, perhaps we =
need to
>>>> finalize the work started in [6]=2E
>>>>=20
>>>>> Putting DT into ACPI seems to be accepted when there is a long
>>>>> established DT binding, but ACPI has nothing=2E Which is common for
>>>>> networking with SoCs and Linux driving the hardware, not firmware=2E=
 But
>>>>> this is all new, its a new DT binding, should there also be a new AC=
PI
>>>>> binding?
>>>>=20
>>>> Yeah, I understood that point=2E Unfortunately I'm not so fluent in t=
he Clock
>>>> related parts in ACPI, and I remember that Niyas did something in the=
 area
>>>> while he was working for Linaro=2E Personally, I was interested only =
in pin
>>>> control integration part, so I haven't ever looked into other (missin=
g)
>>>> parts he tried to develop=2E
>>>=20
>>> Hi all,
>>> per Rob's advice, we should reuse existing clock bindings for the
>>> relationship between DPLL device and network controller / phy=2E
>>=20
>> Why? If ACPI gains proper concept of clocks, the usage of DT bindings w=
ill be
>> a hack=2E
>
>I have been wanting to propose a new consumer / supplier schema for
>dpll-pins [1] but it was advised to use existing clock-binding schema to
>represent this relationships=2E


Sorry, I forgot to add [1] link

<https://github=2Ecom/devicetree-org/dt-schema/pull/183>

Ivan


