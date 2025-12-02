Return-Path: <linux-acpi+bounces-19391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B193C9D38F
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 23:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B143C3A8E2F
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9842FBE1B;
	Tue,  2 Dec 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="C91jWlo4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302E2EB5A9;
	Tue,  2 Dec 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714957; cv=pass; b=TY2EqzsZvusNhtFHdrLiAlGcXAkC+MUyOvV5NHgbh+RutrVU+giwSjGzsTtVYH+aB7JUirWcWSVRchyqXAXgod31dynhsotebwRtqYqFizAnuo8szbAJXtn8440XzFfdsLHtIkFwYmM8Y4eu9BMmgW/JA0u6n2UMwVPMJWSwObU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714957; c=relaxed/simple;
	bh=K09nN1Dqtx6/W2OKQ+FRd3ib5btF+NhDcHo286Sr1sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWsQqcqU5LyzQKGU7YKEYnuoCqw/Z+GkeuArqkB55Zm77dN76r7tsEFiyN77qgyM71wKCrBXTxoaK2Jz08RWEt46pxcYZa/o9dHM42XLm62ONuV3ijRwtAu11CbSX6u1HjyaVdgSJi5uJX7KDoVAlro+ngHMJ+t1lzeCC2dWvyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=C91jWlo4; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764714930; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TpFG/1NF+mECyo6Lvd6szxWh1H6SDsb4fkon3OVyyFWoaQvd5nXm6A8t9kO49R2MoF8qEpdCDRDoJDGtARlI84O5AVaLsZQCQc9CdJ14imldzvDu3eeqlREAEG0AyyNmmfwQHUPse5XODe3IyQO4FOGUvVGsRVKPuOl/5UxVa9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764714930; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7Jbcg8PuEfKuZx6WSS6DzKUVdmvJnwiR4wLSD5DXy60=; 
	b=S6rwjPSluYibHPA3UX9tsAz/7fMX4xbVXjh5JTIKhLkSJ/6Q4s6EU4u4ijDt9izXYsr5zyn5QaJUdrQuatq+nNI5MPlcnjKjaqDj6fPel18mRhLt/xbBw7qze0wy0JHp3rO/lgMtpLHSWz/u+J95izheUSj3+aUz3uYEf8vjZCA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764714930;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7Jbcg8PuEfKuZx6WSS6DzKUVdmvJnwiR4wLSD5DXy60=;
	b=C91jWlo4cyCP0xyL0i4kerZNDHAcznWKbFrNFE8tX/+Qobs/invEe6eamoOliu0K
	rN2xkFVoj/1wQYfkzj8ZeDkg2p7xSt1LJal2pWWP0GwHCik+p78n+QBIQ5GBkfPctvB
	u7NqrhnOQx/ze2er1UdlutGCNwESnORaXi7i/ycY=
Received: by mx.zohomail.com with SMTPS id 1764714929825226.48371917700433;
	Tue, 2 Dec 2025 14:35:29 -0800 (PST)
Message-ID: <35f69c12-ecd4-4b21-bfb0-53bf57f0febf@collabora.com>
Date: Wed, 3 Dec 2025 01:35:24 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 Lennart Poettering <lennart@poettering.net>,
 Daniel Stone <daniels@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
 <c7760b2d-c8cb-40fa-b1b1-8715e97e5cf0@kernel.org>
 <CAGwozwHi_U_R3ueJaYDaR_Pa6JntNbEh1dpwwbZW7jtrs5mbQw@mail.gmail.com>
 <02103d95-7bca-4db0-81c6-ac36429ea0bb@kernel.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <02103d95-7bca-4db0-81c6-ac36429ea0bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/3/25 00:25, Mario Limonciello (AMD) (kernel.org) wrote:
>> An inhibitor process in logind can handle this gracefully very simply.
>> Involving the DRM subsystem just adds a lot of complexity and it is
>> not clear what the benefit would be. There are no known devices that
>> hook DRM components into that DSM.
>>
>>> By doing it this way userspace still has control, but it's not
>>> mandatory for userspace to be changed.
>>
>> On that note, the screen off calls/userspace implementations are
>> optional under both patch series. If userspace is not aware of them,
>> they are still called by the kernel when suspending.
> 
> With the proposal I mentioned you can get the LPS0 _DSM called on a
> handheld when the screen gets called without changing userspace.
> 
>>
>> Current userland also duplicates the functionality of the screen off
>> call, which is primarily turning off the keyboard backlight. So along
>> implementing this call, userspace software like powerdevil/upower
>> needs to be tweaked to avoid doing that if the screen off state is
>> available.
> 
> Sure Any hooking for turning off LEDs manually based off the screen off
> _DSM is totally feasible.

It's not that trivial to add screen on/off hooks to DRM, there is no one
central place for that from what I can tell. I'm seeing variant with DRM
hooks as unnecessary complexity that doesn't solve any practical problem.

A week ago in a private conversation, Daniel Stone gave an example of
laptop's lid-close handling that is done purely in userspace.
Technically, kernel could have DRM hooks for that too, but it doesn't.

Userspace would need to be taught about new power modes in any case.
Addition of DRM hooks should require a well-defined justification, which
is currently absent.

-- 
Best regards,
Dmitry

