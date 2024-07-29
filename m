Return-Path: <linux-acpi+bounces-7110-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270E93F409
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 13:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85781B2206C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF2B1465BF;
	Mon, 29 Jul 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnXt1K5A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7313DDAA
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252550; cv=none; b=jIdaeJg0HinM3Bu8o1Z+F289JlByW7jMu7RhNfhBpl/5fRfuRigoJ4IsYISyQFTPFXwEiQLvPVst2IdumY5oMmT3jjRF7BXM7bGUNb0SGd1t0JuxPyMR6HJTwJK2DykmYbE76RT6MV/spUSl08zkLei9BhPHdwzED6q+MHv0hQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252550; c=relaxed/simple;
	bh=qYWSE1T4OBkLx7jwsi3jWq3ShUlk9INK4xekTHpkkbU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RpF4CdmyB89FZV/ycLOllLZ/blAePKGT8BAloIcMFL9BQYPgarIR2f6MqLSA/rdx5JVaHaL4TlRh/5fYm2pWmlMsputGYQIWVs5GKnFI7b1jiTzMSlbEKGRE3UTDYssQpa0yTc6JGWBaVanPUfRm5bP8PvmM1MUvNwBvUwv1hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnXt1K5A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722252548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMq90GYpH1w883EFsoCIgFl+8puUpsurnUBvwbbFdtM=;
	b=RnXt1K5AfkjBxigTNGqseouT4Rdr7mfmeitFiZxG0nq+R7hC7pZIhd83wF3rSWT5LkjYf8
	YxhP5/CLqm+MyhqSr5eey0hbG5qV0XiWQIv66Sv2nMCfAcqh8weshWR3V+PIlDVzUjFAx0
	vBQMlk3s5qor9lv3mBOvEIT16rXRcSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-1bEZyh8KMyC3Sy2--p1cSw-1; Mon, 29 Jul 2024 07:29:06 -0400
X-MC-Unique: 1bEZyh8KMyC3Sy2--p1cSw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280f233115so17355675e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 04:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722252545; x=1722857345;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMq90GYpH1w883EFsoCIgFl+8puUpsurnUBvwbbFdtM=;
        b=ZxgviGx9hMr752Bd5u92KlY8Mde/TXDo5YM5YwfBLnRfjLfpFECoZWnDOQaGVi8gFV
         bbYCrHoCrI4e+ggOTnqf0Pxxevzl10Nmw5MD/zQ3VG3Y/LIhnW4iB1lI3U+Ef1uJ+Cfz
         TN7qj71lybkYKv2chufmin18syXgp11bJTMdD/iAp3Yg9/9MXU37xz8Q22IwKDWaQJx6
         Ouz/xtRS18TUo/Z7bsN9XkkmyO0JduGrxWg970F8mgy4IOT6yjEghyPoiftbjD0xgaCa
         1kwLxYDH9xiFqj2RvZV1rHFsSr7g4DgvI2DDUnicMWqvlYuklGSAxniHt/eMv0eKGigS
         qCCw==
X-Gm-Message-State: AOJu0YxrCod82hJSm97PrJWBzk4HU038aba210tYjJOIHJkfsWM8scmT
	V+CUYoJI2MWc5B3j+Bxd+CPIfpjT5dq580SMBE/tcW3NAfqfcdwRbESzXAEp+HGGwX/0zoVG3VR
	i0mZ0zM/q4WMr5PyUa6s9zqvUIMPIkG1FplfEiSeE/OX9N0d7ArOUM8AUmNasoFxT5Ww=
X-Received: by 2002:a05:600c:4511:b0:426:654e:16da with SMTP id 5b1f17b1804b1-42811a981f0mr53879325e9.0.1722252545029;
        Mon, 29 Jul 2024 04:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvBNd4+PjxKxyIgrrj3CfqIvBo5mB5Ex061clj9S8DmQ/Nirwq8/TPtoP9T7jJbhPmF6P5IQ==
X-Received: by 2002:a05:600c:4511:b0:426:654e:16da with SMTP id 5b1f17b1804b1-42811a981f0mr53879125e9.0.1722252544559;
        Mon, 29 Jul 2024 04:29:04 -0700 (PDT)
Received: from [172.18.228.53] (ip-185-104-138-47.ptr.icomera.net. [185.104.138.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fc95707esm149366595e9.0.2024.07.29.04.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 04:29:03 -0700 (PDT)
Message-ID: <6dfb58d7-0b36-4414-bc01-75697077fd27@redhat.com>
Date: Mon, 29 Jul 2024 13:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
Content-Language: en-US
In-Reply-To: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/29/24 1:15 PM, Hans de Goede wrote:
> Hi Rafael,
> 
> There are 2 bug reports:
> 
> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
> 
> 2. EC related ACPI errors and bad performance:
> https://bugzilla.redhat.com/show_bug.cgi?id=2298938
> 
> Both of which started with 6.9.7 which has the 2 commits related to "EC: Install
> address space handler at the namespace root" from 6.10 backported:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/acpi?h=v6.9.7&id=2b2b0ac1533d790690d6d28899f01a2924d54d4d
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/acpi?h=v6.9.7&id=9750135f2f326879889ed60ccd68b96572dfa6ee
> 
> i have build a test 6.9.9 kernel with these 2 reverted and 1. is confirmed to be fixed
> by reverting these 2 commits. Although the user does report an IRQ storm on the ACPI IRQ
> (IRQ 9) related to thunderbolt after this.
> 
> I have not yet got confirmation that the second bug is also resolved by the commits.

... resolved by *reverting* the commits.

> Either way it looks like we need to dig into this and figure out what is causing
> these EC related regressions.

I'm wondering if maybe this is also somewhat related to commit e2ffcda16290 ("ACPI: OSL:
Allow Notify () handlers to run on all CPUs") ?

I guess not though since this started in 6.9.7 and 6.9.6 is fine.

I did recently submit an unrelated fix caused by e2ffcda16290:

https://lore.kernel.org/platform-driver-x86/20240729110030.8016-1-hdegoede@redhat.com/

Regards,

Hans


