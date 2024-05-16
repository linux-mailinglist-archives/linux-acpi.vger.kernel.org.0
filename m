Return-Path: <linux-acpi+bounces-5859-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E698C7432
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0E01F24580
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6DC143872;
	Thu, 16 May 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgnxkSws"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1A14386C
	for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853305; cv=none; b=i0mdlJz/o1MOd8zRFKkMETQZprbJ3DmCzO6ckAdOrjfNljLLxoWlPTcYzNdA1bWEtdiAnmo/l18ByRBg1hFa8740m+BP++3KJrLy1fVraFb39DpVq2TEYMVia6FbnFKQbMVCFR5HUjY99u/vsBwPsR+fAfmC5MuJDRm4/NY3alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853305; c=relaxed/simple;
	bh=XwF9aQslGRS3Qj6N+bpXalGzW3AZ50RGxLLO3j7uIwo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qg9WuTFi+bCWdFzGkRDypcaKS3FvnFLMBwdPWedEz6avLdb1b/CwcFmYxQgcB3xteky+hVJI63cNzQ9tUiQqyNO6cR1m9YOlkfhGz+ye2dLQvsQuocFU0Y8k8PwdAdlbAIaSEuqG43KjfFpq5g2i7x+UVLZkldTsB0jhWittI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgnxkSws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715853302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCLlRn0O7TcoEywJNo4KTsygfUnn9t9neEyPiTqepkk=;
	b=UgnxkSwsUNbNRCdRYrmjZPQwFzXdmd+K8x3Pzsyc8FyP3n8hkwK6eH/0j48fzHqTSeXst1
	ak4RV89PNWhHk6/ktjv162RYbRgMLzpBlj5gbv/Y3P/KTB7vQpbQW8JerTHKiZ5IX61l1L
	EI4kLR+KSrM1HylzuVynFJaO9018uk8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-_UnHc3djOaWppzdWl7D7Lw-1; Thu, 16 May 2024 05:55:00 -0400
X-MC-Unique: _UnHc3djOaWppzdWl7D7Lw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51fdbd06c8so548658066b.3
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 02:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715853300; x=1716458100;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCLlRn0O7TcoEywJNo4KTsygfUnn9t9neEyPiTqepkk=;
        b=Ch0nQc39vl63bpsBXkGE82CdfZR/hvvtfbI/vUKJWO1S90mjUIenKYuiISiUatV+lS
         XhWMjyGE19RDkayZWXNuIloGgCVF80TG2xb8jPgzgYaHw7//6pK7yM6Aw6CGSYFmPAEj
         mj0Xiv+ibPC8pHJxPI+uZxB51lp2PSUchp+l7hWi6C5DfFqTQ2sdMD25bfhj8s0QvNNv
         pPXqls39zHVeycLcTpCjzO9TRtcyo/LA/Knwb0vlt2ghtjXUUOTnFlPtUB8xwnXMrg8R
         IMEzwPkvtx/yLLmno2EM27rXbOAG7VWSnqPQELkfDGvaRa3gojNXDnsjQAwWBREzMfUn
         OQDA==
X-Forwarded-Encrypted: i=1; AJvYcCU1QEXG2FKhLk7qWFqkM+0NGvnmUzOJJK8SYTOhXibQND8oDR9euXKEa8U9TEolwsk48sJuoR+LimEvHHuELG/u9TELiMa9qr5LwA==
X-Gm-Message-State: AOJu0YxBLSODkudM/4qYogY4xAyJ4f46s3NS+uwM5AnzAK2uidv8nRpI
	Zf0NfDpx699eQtgXvNf/5b/Bm4BrhooeIBL8ZywUA6gb3pe9/5d81vtZR/fsrBmfT7dAvYJgxcI
	A5E9QaJPkzC7BbXDfpONsj4wCXF9jPDqem0Ds5gk+Gs4nLgRkrQIos8Inhl8=
X-Received: by 2002:a17:906:5394:b0:a52:2441:99c with SMTP id a640c23a62f3a-a5a2d67f8c0mr1312589766b.69.1715853299876;
        Thu, 16 May 2024 02:54:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGAj7Y0Agk/yxlpgG6wGjr+FCkPj7ADMJB7nw62J/hGeL4ZAm5mAOCLdhW9sSlzNX6lSHAtw==
X-Received: by 2002:a17:906:5394:b0:a52:2441:99c with SMTP id a640c23a62f3a-a5a2d67f8c0mr1312588766b.69.1715853299499;
        Thu, 16 May 2024 02:54:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509a90101sm695433a12.79.2024.05.16.02.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 02:54:59 -0700 (PDT)
Message-ID: <74dc970b-32a1-4baf-b51e-80e766912ed9@redhat.com>
Date: Thu, 16 May 2024 11:54:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
From: Hans de Goede <hdegoede@redhat.com>
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
 <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 11:50 AM, Hans de Goede wrote:
> Hi,
> 
> On 5/16/24 10:37 AM, Rafael J. Wysocki wrote:
>> On Thu, May 16, 2024 at 10:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
>>>> Hi Everyone,
>>>>
>>>> This is an update of
>>>>
>>>> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
>>>>
>>>> which was a follow up for the discussion in:
>>>>
>>>> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
>>>>
>>>> Patch [1/2] has been updated to avoid possible issues related to
>>>> systems with defective platform firmware and patch [2/2] is a resend
>>>> with a couple of tags added.
>>>
>>> Thanks, the series looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> for the series.
>>>
>>> I assume you are going to send this in as a fix for 6.10 ?
>>
>> Yes, I am.
>>
>>> In that case feel free to merge both patches through the
>>> linux-pm tree.
>>
>> Thank you!
> 
> Hmm, I just realized that this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=c663b26972eae7d2a614f584c92a266fe9a2d44c
> 
> Is part of the main pdx86 pull-request for 6.10 which I'm going to
> send to Linus in the next 10 minutes or so. So that is going to
> conflict with your 2/2.
> 
> Options:
> 
> a) You only send 1/2 upstream as a fix and I'll then send a rebased
> 2/2 upstream as part of the first pdx86 pull-request.

That should be "as part of the first pdx86 fixes pull-request" (for 6.10).

> b) You merge the git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
> platform-drivers-x86-v6.10-1 tag (which is the tag for the pull-request
> I'm about to send to Linus) and rebase on top of that before sending
> a pull-request for both to Linus.
> 
> Either way works for me.

Regards,
 
Hans




