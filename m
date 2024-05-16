Return-Path: <linux-acpi+bounces-5858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B808C7425
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 11:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F58B24D9A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8414293;
	Thu, 16 May 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmvQyYLe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CD143898
	for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853036; cv=none; b=UV5HwdWXOgFkJU5xJWo05c+1wK410p8xIMJGeoP34AAgT0b/CgnwPWoZBKo8+BYdzvpBoyPPO89ljBZtXjQeJbl2PXM5Qe6z9JLstkhPoC8jz438oxku/9S04AKHI8cJaWfDb3mpLaMYY1oESvCWtR5Y1L7ieIvqOPqlsVEbvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853036; c=relaxed/simple;
	bh=+c9zEl/36759rGYjhFBs08AUR/oGKkHXxRFbeAzSvp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJtncKpPrpPRw8O7aOm3ctxBBqzIXE5qvJCAe/Fr/rDGkzWmD+RAYmr5gTjLwpIj8QtISDtWUGF6Z/APmSbE6TFNoHiDq/Yz1SY9P/NnK0s8o/qzSjgUD6yMYwRIZTi2WHnKahapYO257QQS5WwXp96tAWRySmLy2BUQCCSgofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmvQyYLe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715853033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl6N2tbUpUF77oaAK8NDMvwl17/nKyPOpGl6BqbhhJs=;
	b=TmvQyYLeU7cWU9ZSxvopOxpE5GzrdzI7qrbzDAi3Rk2T5ll1nKWhFfYpG1wPzCM/7S/DFh
	K+F5eOP0Pi8gtMbVZbOkHBqcZnigadrZA1N7KBh3Wjm7PIMXJTu2yW0oIXqpy0gm2U/JBc
	JyUBlnkdkhM8Gqykqv16JEomnu5I3XU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-1UUQfG0LNB2LTn_z0wf4fw-1; Thu, 16 May 2024 05:50:16 -0400
X-MC-Unique: 1UUQfG0LNB2LTn_z0wf4fw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7f79f3a064bso3064862241.0
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 02:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715853016; x=1716457816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rl6N2tbUpUF77oaAK8NDMvwl17/nKyPOpGl6BqbhhJs=;
        b=M0qNR98DmY/sJdre6vu1GDZ/bSWK8OQqMszk7SOcQrpp0IHQF0LF05QJEr/tIkQtp2
         sg5WIS3xvx0H+hnWgJ4nTRd/MtHtnSdOjMNDN2yTjImBLvRgpZK+MA8TQOr4TGWR09Si
         8Fr4B/m/yZO00DUOj6pCEoYgzEGRKjqX/xfeEERUS5ngvguh6KCHo5Wr5IwuBPWxDW4J
         F+eZ6dXd9yPCqMDCe2UodGFuOv9I30ZHAZ+ZaWwYrPHqIyzYE//SDtvl4U8OwpWTivrI
         y/24ZdH4WKGj/hmNjzCMWW8D/U9Ka5DXJGZz89kpdhzMBfF7c8v1eYVY/NSoNcSjrFXS
         Yduw==
X-Forwarded-Encrypted: i=1; AJvYcCVA2yj6TKukB/m4GnmSFOEo6/EIYY6coEp/Ey6IWXXmO75Ygh+3QcgiiHkZq11fhKRlBicL6BM/ednWz6zzwHG7zThUjezC3P13rw==
X-Gm-Message-State: AOJu0YxVmoht7f/HJT4nGKPjy5l+v9VYeg37yNNg8GfAyyov3hFryYXO
	G9dSZGS7S4q5pJopLgFenY31yrEBFi92VAvLMoGDtTlWF2OrcC3QokqpiiIC1SRlTJ1JSd2qki2
	H8LQHgdUnQ7hBpfoIVyN3U+2Fu/gXZZjPmaftLYdooIZSBHVezd/sdRwkbNU=
X-Received: by 2002:a05:6102:3ec5:b0:47c:3033:5faa with SMTP id ada2fe7eead31-48077e11330mr16512968137.20.1715853016180;
        Thu, 16 May 2024 02:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrupqXLSlZxhBgu7VznMtN7QkxOtPnyduO1KffkCGw4xFFHzWHqltbKZmcWq+K/8y2wqFi7g==
X-Received: by 2002:a05:6102:3ec5:b0:47c:3033:5faa with SMTP id ada2fe7eead31-48077e11330mr16512951137.20.1715853015787;
        Thu, 16 May 2024 02:50:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb3b783sm2089833137.9.2024.05.16.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 02:50:15 -0700 (PDT)
Message-ID: <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
Date: Thu, 16 May 2024 11:50:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
 <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
 <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 10:37 AM, Rafael J. Wysocki wrote:
> On Thu, May 16, 2024 at 10:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
>>> Hi Everyone,
>>>
>>> This is an update of
>>>
>>> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
>>>
>>> which was a follow up for the discussion in:
>>>
>>> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
>>>
>>> Patch [1/2] has been updated to avoid possible issues related to
>>> systems with defective platform firmware and patch [2/2] is a resend
>>> with a couple of tags added.
>>
>> Thanks, the series looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> for the series.
>>
>> I assume you are going to send this in as a fix for 6.10 ?
> 
> Yes, I am.
> 
>> In that case feel free to merge both patches through the
>> linux-pm tree.
> 
> Thank you!

Hmm, I just realized that this:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=c663b26972eae7d2a614f584c92a266fe9a2d44c

Is part of the main pdx86 pull-request for 6.10 which I'm going to
send to Linus in the next 10 minutes or so. So that is going to
conflict with your 2/2.

Options:

a) You only send 1/2 upstream as a fix and I'll then send a rebased
2/2 upstream as part of the first pdx86 pull-request.

b) You merge the git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
platform-drivers-x86-v6.10-1 tag (which is the tag for the pull-request
I'm about to send to Linus) and rebase on top of that before sending
a pull-request for both to Linus.

Either way works for me.

Regards,

Hans



