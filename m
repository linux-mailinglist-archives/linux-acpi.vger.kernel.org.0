Return-Path: <linux-acpi+bounces-7333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FC94854F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 00:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A772B22404
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 22:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9416C696;
	Mon,  5 Aug 2024 22:10:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from sxb1plsmtpa01-05.prod.sxb1.secureserver.net (sxb1plsmtpa01-05.prod.sxb1.secureserver.net [188.121.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C11155351
	for <linux-acpi@vger.kernel.org>; Mon,  5 Aug 2024 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895844; cv=none; b=aCFumtYJUKEPp1NYDpr5cWCA/KAAS0sfl+bWXfMQ/DEo2lbDw0tHVI1NQX3r7fLgGBFPPAK8TAg79wluJ7wjlgF1YajvN5aT6ctozJzFcvP1dw9g6ApD124NeHohIlkHBlRX+84DqOrezUlPO6J7JwMA1vfMGQ4ekl3g4enGosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895844; c=relaxed/simple;
	bh=TtLcqYXwVhu+R2JWp+iyvK/c1zI8jIP13UtKKstNsgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6CZ9SsCcaGZwGXf1xycJgepeT8ZlzRyoD96Xwql4Iq89W0q+ZJDkxhJ4xL/gmrgA4onRfYFZahl5Q1aMnlaNkYAvIFvcMjzwOycy2tOx3928vgZC8KeUcKrzW5TzGGQxb9xHmO7eAnZRcYmhDYXQg8T3J59HopbkBOhqD0kGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from [192.168.1.27] ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id b5c7sufgD5nw9b5c9sKsOA; Mon, 05 Aug 2024 14:51:38 -0700
X-CMAE-Analysis: v=2.4 cv=NqsacNdJ c=1 sm=1 tr=0 ts=66b1496b
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=JXrB-i05ymQu8u1lf2kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: peter@piie.net
Message-ID: <1bfbbae5-42b0-4c7d-9544-e98855715294@piie.net>
Date: Mon, 5 Aug 2024 23:51:35 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/17] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Peter Kaestle <peter@piie.net>, platform-driver-x86@vger.kernel.org
References: <1922131.tdWV9SEqCh@rjwysocki.net>
 <2242500.C4sosBPzcN@rjwysocki.net>
 <a0c639d1-4f21-47f1-bb66-92f185e828a9@gmail.com>
 <CAJZ5v0jDQLJWGCj73DXQe3+k+Zaq9Z71LJbFSvRjcuE85+J+mQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Peter_K=C3=A4stle?= <peter@piie.net>
In-Reply-To: <CAJZ5v0jDQLJWGCj73DXQe3+k+Zaq9Z71LJbFSvRjcuE85+J+mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJWPR2+yiOWfZF1NN1S8YQgNKg47YkfBXB1nfxoLS0fZ3rnhmIi6a5t1zj9QzI4OACJP2WuBqRdHHFEjn4wK14uS9dO/T/x2eLlOv5L1sVMFzEhcP5IU
 hIn/yHFJYo1svGlnqYa9TkcDG55epHQmXWg36d91MYfdBW0ZLODWbvUJ94qiEMvJmNWFyeERLrmC44A4xTj3DOuWRv1dRItHK9QRicWnosSJslsxnPlXFwRw
 QUxlszm5dv0kty+bc7+WllK/j+k/mnF8gsxKOOG5GKwaqlAodwTv/8xyK5tovV5CAf5Y6AJwmr7Wt2g4BHrVNszQZTdPAwPog1sQjPbXGlMGRyQPT55LX8Up
 aPFUMcyS5fG1dCOM4C1So+FLOgx5/6WEY+MoAn493VwP941dKCVQWCOhVNEjUIiiBbtHIqa33yXUgURRMAwcoPXa+uQaqZ5vh00klOOM6wbQQNmi70oeHpKI
 8dl8xK69f5gZ9HFWEp8DiQc3PnHuIsKdZoM1OQ==

Hi Rafael,

On 01.08.24 12:14, Rafael J. Wysocki wrote:
> Hi Peter,
> 
> On Wed, Jul 31, 2024 at 10:50 PM Peter Kästle <xypiie@gmail.com> wrote:
>>
>> Hi Rafael,
>>
>> On 30.07.24 20:33, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make the acerhdf driver use the .should_bind() thermal zone
>>> callback to provide the thermal core with the information on whether or
>>> not to bind the given cooling device to the given trip point in the
>>> given thermal zone.  If it returns 'true', the thermal core will bind
>>> the cooling device to the trip and the corresponding unbinding will be
>>> taken care of automatically by the core on the removal of the involved
>>> thermal zone or cooling device.
>>>
>>> The previously existing acerhdf_bind() function bound cooling devices
>>> to thermal trip point 0 only, so the new callback needs to return 'true'
>>> for trip point 0.  However, it is straightforward to observe that trip
>>> point 0 is an active trip point and the only other trip point in the
>>> driver's thermal zone is a critical one, so it is sufficient to return
>>> 'true' from that callback if the type of the given trip point is
>>> THERMAL_TRIP_ACTIVE.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Thanks for including me on the review.
>> I'm working on it, but unfortunately the refactoring of the thermal layer
>> around gov_bang_bang.c earlier this year broke acerhdf.
> 
> Well, sorry about that.

I already fixed the main problem, which caused full malfunction of acerhdf:

The new functionality of .trip_crossed in the gov_bang_bang is missing an
initial check, whether the temperature is below the fanoff temperature
(trip_point.temperature - hysteresis) and by that it did not turn the
fan off.  This then caused that the system will never heat up as much to
cross the upper temperature. As a consequence it could never cross the
lower temperature to turn the fan off. -> Fan was locked always on.
And that's obviously not what we want.
As I didn't find any API call, to ask the governor doing that for me, I
added an "acerhdf_init_fan()" functionality into acerhdf init function right
after registering the thermal zone (and on resume from suspend) which turns
the fan off if the temperature is lower than the fanoff parameter.
Probably not the nicest solution, but maybe the most pragmatic one without
touching the thermal layer.

>> This needs some debugging and refactoring.  I think I can finish it on
>> upcoming weekend.
> 
> Thank you!

I'll need some more time to check why other features of acerhdf broke:
* interval cannot be changed to longer than one second.
   No idea yet, do you have any idea?  Maybe I'll simply drop this
   functionality, as there's no big overhead by polling every second.
* changing /sys/module/acerhdf/parameters/{fanon,fanoff} at runtime
   to change the trip point settings stopped working.  This needs some
   restructuring using module_param_cb callbacks.

> I'll be offline next week, so I'll go back to this material in two
> weeks or so anyway.

I still need some time to fix the remaining part anyhow.  Once this is
done, I'll check your latest patch series and send my acerhdf rework for
review / submission.

-- 
regards,
--peter;

