Return-Path: <linux-acpi+bounces-19525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9DCB1463
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 23:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8147730A1F24
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8172DF121;
	Tue,  9 Dec 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="FXCo6que"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013422C236B;
	Tue,  9 Dec 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765318466; cv=pass; b=Jb7BOwRkQrC3oBTsePN6k8XJFidCzq/ygNOXq8FrnyZTtZAEfMbQDsYEpDchJjkm/qwvlKTOIKMdNYVI2cwisLdGc6ffKJDBJ8WTh9pYQ8cJJch6/pmMhL7FZog0lDc79clAIDEoWHHV3GtL7ebqkeoM+K3A8xWYrpAdzOOHB98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765318466; c=relaxed/simple;
	bh=ZjyW0kT1tkEComy9pfyQTi7DlVMVtAfGEm5l1s4gGqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJYhL+907d74A0fjCbLrzVvVWB7C4N3ruufQOQvkONDbndvczBHK71vtJwZosKxOahvZfcHVkuOVJogaA1bpXFhH06CkOgeGOtB7iXGYA3yh4Pg4K/66vamqp9CSjLb2z7NQsHR94gC01W3Oa8FjRC+ujhIgUXb0WUlfhqVTlt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=FXCo6que; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765318434; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B1m3Eszbz+3tHdMyjTSgRcDzVdZBV6FrkiP2MmVYibeMzg2MKJtlgwmeuZYaiYZjIXutJ+IrwKcafZ3hHoBLBXLmZm7DZ7JcU/fRVJlSeSEO0vNW4hrNDSFQnQ/LIuSZsunox8KJqJcov3Ki3OyZwyIFh7DhyGFcwyUoz0u+WE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765318434; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wQdAWSkGZRVDZ/dUpzDBgDgRmc+jOeRLJeDqBxb7B4A=; 
	b=FPDNlGfC40ATxvWRzTjP5R/aa86PXJmL1Squ8puxDp6XFmruLAM/bQ8cYF7v8GMjvVoyH2Gl1UZfGAqmoqb7Y4lXLXEyHGMwky/EQCJrPUblEvQM9npxsaZFlYCxDjvwdsgyMcSvto4mphQQzD+K9i20Uzr77sMMowWZUhF0F8k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765318434;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wQdAWSkGZRVDZ/dUpzDBgDgRmc+jOeRLJeDqBxb7B4A=;
	b=FXCo6queHvIzhUMshag4qhinlim2IpSwMf0JbOAIUdXrX/diIPSmqRvGlRpfNKHV
	gVGxRAsNqEQS9XFf9wucCXfbzr1XYIVMZG9rxk7mBjJqVx7Q/6c0u9euqdfbyjWRBX8
	u9tOXOTXuBj2Hbq3mHgHOS2qafdPPY8GgGHE3uUY=
Received: by mx.zohomail.com with SMTPS id 1765318433302607.335555883667;
	Tue, 9 Dec 2025 14:13:53 -0800 (PST)
Message-ID: <9e663a52-691c-4387-85b7-73e7f51086de@collabora.com>
Date: Wed, 10 Dec 2025 01:13:47 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Antheas Kapenekakis <lkml@antheas.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
 <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
 <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
 <CAJZ5v0j3wNtqYQDsVr+74-Gn-WM9FDmoqxrLULVD+UJtfVgLtQ@mail.gmail.com>
 <CAGwozwEgfH+QRpBXNGhZG5hxNF28A3ALbrABGYJg7RuFKDrM0A@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGwozwEgfH+QRpBXNGhZG5hxNF28A3ALbrABGYJg7RuFKDrM0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

...
>> So let me repeat for extra clarity.
>>
>> The only change related to the LPS0 "screen off" and "screen on"
>> notifications that would be tentatively acceptable to me ATM, would be
>> to modify the suspend-to-idle flow to do the "screen off" notification
>> earlier (possibly even at the start of it) and the corresponding
>> "screen on" notification later (possibly at the end of it), provided
>> that one can convincingly argue that this should not introduce
>> regressions.
>>
> 
> From what I recall that was my original plan.
> 
> Yeah, it is a fair way forward. @Dmitry how would you like to approach
> this? SInce you re-started the discussion. What is your timeline/KPIs
> for this.
> 
> I could personally try to whip up a small series after the merge
> window by rewriting what I have[1]. I have more experience now in
> drafting this kind of thing and that series added some cruft to the pm
> core with multiple additions to platform_s2idle_ops
> 
> There is a _small_ quantitative difference due to moving the calls.
> Specifically, the power light responds a tad slower when waking a
> device. For the legion go (non-s) devices, Lenovo added a dummy 5
> second timer to resuming the controllers because of some Windows bugs,
> and moving the calls causes the timer to start later. But that's the
> OEM intended behavior...
> 
> Antheas
> 
> [1] https://github.com/bazzite-org/patchwork/commits/pm-bleeding/modern-standby/

Am I understanding correctly that the plan is to have a 2-stage freezer
for suspend-to-idle + standby mode? Rafael, could you please confirm
that you're fine with this 2-stage freezer part of the proposal from
Antheas?

What you expect to be a proper way of implementing a 2-stage freezer?
Would it be a new executable capability, a new syscall or extension of
existing one, a new cgroup type? How would you mark processes that
should not be frozen on the first stage? Or it would be only the process
that writes to /sysfs/power?

Thanks everyone for the very detailed input. It is all very productive,
helps a lot with adjusting my understanding of the modern suspend features.

Agree that the usefulness of the visual aspect of the Display
notification is questionable. Previously I thought this mode involves
power-limiting. The Sleep notification might be much more interesting then.

I'm heading to vacation till Jan. Antheas, I will be happy to review and
test your code if you'll have time to type a working prototype.
Otherwise, will continue after the Holidays and likely will use your
patches for the base.

-- 
Best regards,
Dmitry

