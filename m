Return-Path: <linux-acpi+bounces-12558-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A6A7667C
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B351887E47
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F018820FA9E;
	Mon, 31 Mar 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekvieKhs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44412136352
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426241; cv=none; b=InjI1n+zfJV9cCGQclZ/Q7gH0mUQ+wohWXvWxbWk9t30MN+7YgrgrP3iQP6TZrAIEkWQYo5qShk0c7USm2h85ifzDw7+My+VKEapnrq7b0oCXHLCI+SnoFg09FzAZDozX/V27Lcb6OMnUSVa7ETmGGNerYir/vLxXFf0WAMFy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426241; c=relaxed/simple;
	bh=JM0yFVV2gv6n/A3pkUNaiyk3zDx/Ky/NmhjO2NCizdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrvYQDb4Uyd8BrMHtMRY9TGndDdiEXCNhNeYfo1srRHUXuEmYfPHDpEpEHxcnmFl6FqK69XuomS+cwm0EMdRbPdv9hzOC8gCPpJreXuL9xtOvQQrZFaOxt3yduWYbAISopsqKmo4Khf8115odkCTbi2iFuzlLTq6F5mVfGd1UrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekvieKhs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743426239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4culuXjcgmXNKuzg57/s8f15AmqI9BMZ7nG6QaACzLE=;
	b=ekvieKhshM5QnKI6JreNxq68sd+bY+K7UAva6iGLv1KT9NTN0say6OYeOhFn/72B4GI2jF
	JaFtycbuviivTwtfUsxB038W2yiUk46fSqvFqfef7yQKH2ICQVGvFPVp2Y+179qVac9WA6
	jd3Wz2d1ytuIT6JoMaR1Iv1Y+C27iM0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-bADbBOa4NeGaYTory29ndA-1; Mon, 31 Mar 2025 09:03:56 -0400
X-MC-Unique: bADbBOa4NeGaYTory29ndA-1
X-Mimecast-MFC-AGG-ID: bADbBOa4NeGaYTory29ndA_1743426236
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5bde483cdso4156695a12.1
        for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 06:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743426236; x=1744031036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4culuXjcgmXNKuzg57/s8f15AmqI9BMZ7nG6QaACzLE=;
        b=w9CUjNQqJJfJzzDvlpJ7oEGDCtTBxPYJbehqzPEhPia6hplwZFv6pBCGkQA7qFLOvr
         8FQEYaCLgNdpqY3tnpkLQi5PEZxNSE6taHsW0yNGinUCdea8IRvoRECn5wQFU6Vuo6LD
         YfUrTdQC6oI4PkXhJLrnZjV2YwWbWutyvyqgjRa0uE/Gq3cVBKJlj+5S4j0Mz78UUp4b
         IOfolhTXNBEKUDNkEIjBv3Utl7dOUBiykjcNAuIOk+5RVuBHUB+bSxL1zO6Q6SwP6W8S
         JeCuF3LjioBgBcIcDtbRikAARj554eaaSD5ORzr9697RpmduwFyPKlWcuMxDKApsUk9s
         SkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbhkvzC/60qIacOK09MiWhdQ0Auc6qXrKLeGJ9tswInd0ppD27pBqZ8bdqyd4gMChZXmur6DFqMC0B@vger.kernel.org
X-Gm-Message-State: AOJu0YwgaR7wNce6dFk4ZbpXZrhqeT0A0nWXf+SjoS3K/bqh5Ya4Q1dx
	NKvIdkidSrUHvDmHsbtpvJxe3xeGmWSwEyTfbORCOY2cwHUfI4qGZq54NTquX1C3VtC7nnGqdDk
	/DproTL3jlU69HEgsUBLjzKt4+mODNjLbas1tvTviapttNkV+Yn5OIBkZgeg=
X-Gm-Gg: ASbGnct8FsRheo5inbRvOhyy5UfQ9u/V08SyoBhgxwNA8Cm6VuCygp922mOqTs9hFty
	a6rYaRDxTGHLAL35fJmCWfdRXMxN5D5WA3984y17xoohuRBGhNYLx9OGlsMg4ZOeoG2RmeKxdIp
	DV5HOZRTo65gqEkxAibYKGoU8zzVFyELeZMyKliMh2V02URvF1RvB9Bpuk5AJfojlbfIZ4oj5dt
	X4gR5dtjhzjQJPz7ZO5DKjIDUkDo0WCijaMxs3ZPIpkheAL5N7K/B2Nve9Cj4B/HdFEfNy0X4fP
	z3Q5G0rQ8VClDkusBzIX3eJ2hUYzIb6viuaX4iItmNl29YKruehneh+N0vpoJu4/vYujRVtWWqv
	baJET8Wdub3McA085AlMzy9HT33XFn1CSIry7aSQx2ictdm6N5jg2BqahrwVOSslo/w==
X-Received: by 2002:a05:6402:2811:b0:5dc:9589:9f64 with SMTP id 4fb4d7f45d1cf-5edfceacc98mr8444253a12.13.1743426235565;
        Mon, 31 Mar 2025 06:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAeVVOke/LS4lE00zJMWgP3UdiPgSf/VxY+uNdgJT2WpOp2xnEI7her8oYxikVPibhMjwtDQ==
X-Received: by 2002:a05:6402:2811:b0:5dc:9589:9f64 with SMTP id 4fb4d7f45d1cf-5edfceacc98mr8444194a12.13.1743426235114;
        Mon, 31 Mar 2025 06:03:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edcaac38f4sm4949440a12.10.2025.03.31.06.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 06:03:54 -0700 (PDT)
Message-ID: <d3dfe61a-1d4d-4aa6-870c-61249799e6da@redhat.com>
Date: Mon, 31 Mar 2025 15:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: "Rafael J. Wysocki" <rafael@kernel.org>, Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
 <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 31-Mar-25 1:46 PM, Rafael J. Wysocki wrote:
> On Fri, Mar 28, 2025 at 10:09 PM Gergo Koteles <soyer@irl.hu> wrote:
>>
>> The _DDC method should return a buffer, or an integer in case of an error.
>> But some Lenovo laptops incorrectly return EDID as buffer in ACPI package.
>>
>> Calling _DDC generates this ACPI Warning:
>> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
>> found Package, expected Integer/Buffer (20240827/nspredef-254)
>>
>> Use the first element of the package to get the EDID buffer.
>>
>> The DSDT:
>>
>> Name (AUOP, Package (0x01)
>> {
>>         Buffer (0x80)
>>         {
>>         ...
>>         }
>> })
>>
>> ...
>>
>> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
>> {
>>         If ((PAID == AUID))
>>         {
>>                 Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
>>         }
>>         ElseIf ((PAID == IVID))
>>         {
>>                 Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
>>         }
>>         ElseIf ((PAID == BOID))
>>         {
>>                 Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
>>         }
>>         ElseIf ((PAID == SAID))
>>         {
>>                 Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
>>         }
>>
>>         Return (Zero)
>> }
>>
>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
>> Cc: stable@vger.kernel.org
>> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
>> Changes in v2:
>>  - Added comment
>>  - Improved commit message
>>  - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu/
> 
> Hans, any concerns here?

No the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
>>  drivers/acpi/acpi_video.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index efdadc74e3f4..103f29661576 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -649,6 +649,13 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>
>>         obj = buffer.pointer;
>>
>> +       /*
>> +        * Some buggy implementations incorrectly return the EDID buffer in an ACPI package.
>> +        * In this case, extract the buffer from the package.
>> +        */
>> +       if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 1)
>> +               obj = &obj->package.elements[0];
>> +
>>         if (obj && obj->type == ACPI_TYPE_BUFFER) {
>>                 *edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
>>                 ret = *edid ? obj->buffer.length : -ENOMEM;
>> @@ -658,7 +665,7 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>                 ret = -EFAULT;
>>         }
>>
>> -       kfree(obj);
>> +       kfree(buffer.pointer);
>>         return ret;
>>  }
>>
>> --
>> 2.49.0
>>
> 


