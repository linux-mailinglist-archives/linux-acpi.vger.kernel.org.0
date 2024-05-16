Return-Path: <linux-acpi+bounces-5871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2400A8C791D
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B8D1C21B4E
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888614B973;
	Thu, 16 May 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LetnUTAp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CC14884E
	for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872615; cv=none; b=jjlLqwLqhMOanvIj5tPV97uzOAsWM6a9yJ29k56DiW97I+0Fau/h5aCZaYOViXYUCoEnnbEVHTRd0pOePeHYCPll/tLwBUqz9pC3w/Irdmt5nwrz5v31UEZpJzufw3t5T00znztF/4CuikTyit2ADns6Uct75+76b3X+ZwN8iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872615; c=relaxed/simple;
	bh=IaLO8A8eOYs5s/2/cuHYZ/9daRCUlFtjjAcRYjoYHbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CerhluSA1skvGpnTKqB4v34VgGbTwgGNj2NGWipehqu/R9wsZ1vCEagC/pi9qYxwVO6o9XOMSy9z4lZLgzsETMkehC0scQlEbVzqc3WW7tW3q9fhIrKSYl47U3aXlOjJM0Z4b0N2ZwKdQH4/16NK/jF4IpJhklETADYJ1CGvFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LetnUTAp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715872613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iOgbS6qeObzrg8GE2s02mcHzXvs1fEJ62WhOsFVoik=;
	b=LetnUTApS9rOMinRA9PPN1FMqHsQVFOK3UQV1W/gtEN1pacN5tMikYZGHdbDvkpCOTCvm/
	z5WcrdBvVNiUaf1wKWNWw4mg/Uf8qzlmCLr9lHb6NCUgdUFYdvpqX+jj0JGDm2Dul4sAbs
	wKOeBW/oYzi9OQAp9BmAyy4+7D5+laQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-scCRfpB8M6u3hsjKj708hg-1; Thu, 16 May 2024 11:16:51 -0400
X-MC-Unique: scCRfpB8M6u3hsjKj708hg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5222c9b6fd4so6263463e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 08:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872610; x=1716477410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iOgbS6qeObzrg8GE2s02mcHzXvs1fEJ62WhOsFVoik=;
        b=HSs15neQUCfndx4jyD6S2/L3Fu9obzL8oW+b6o+aSPGAEylGOTJXTmQFecjRrE3NWZ
         veUK8QHPNJlQFGRYd1m49sLllmdZdfD3CwZczqt/kG9faFDpwpiDemesx0lI7/B8w+Zw
         nnJZQ3GnXGpdGdU8nqmP+sOOAkScG1sW0MamfoCkJ7AUnDWp95vhVSpxwNT1V1FofvB6
         YNpNMgmJipME5L3RxM0A99tvdOlfMOYLFQA8/oYJ/S2v+a7ItAGuMsbbgy1JM1cno22E
         H8XuamT5akgm6ZyXqI21LDdFSOATNfS/YHSzMin2FmsQqWdEnys+J2odKIBVA7HtDnOH
         aWsA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0Yl8y7MXzFYmkKz+3n3L/cWKBFNu4sLR1E0rrPtFoKojXBugSF8/OttCw8chEaDGo3PzhShNSlfPYtmYQX8gZH6kJFq8AuMs6g==
X-Gm-Message-State: AOJu0Yy33zIdCTIX9CmzM1xVaMEjVPHbYXQcOYBZ4TjEvT4CSG7SipBc
	EeiNG+zAVGshvDShmWd3FyTgt9tG+t23gkHbNwR7ChYfPoefvJXUVyqX13OUoSo0iOx+6Gtrbhw
	OKkupWesN0SNFgfefGh0cJGsSRoqtImR0O7vR9/wrrkshuXRJEuDVI7TcgaY=
X-Received: by 2002:a05:6512:444:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5220fd7c6bdmr16656962e87.16.1715872609952;
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn+FVB1tK34ViV8+agUiDomeCaRnMnSEIgSm4pt/ya2IBcjeS4X3/vaKP4GVA4MVD2ub1n+A==
X-Received: by 2002:a05:6512:444:b0:51f:3e0c:ace3 with SMTP id 2adb3069b0e04-5220fd7c6bdmr16656944e87.16.1715872609565;
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a60eabd3csm596814866b.108.2024.05.16.08.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:16:49 -0700 (PDT)
Message-ID: <b9a5068c-8760-4f92-8a1b-bd276532109d@redhat.com>
Date: Thu, 16 May 2024 17:16:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Fix name collision with architecture's
 video.o
To: Thomas Zimmermann <tzimmermann@suse.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, arnd@arndb.de, chaitanya.kumar.borah@intel.com,
 suresh.kumar.kurmi@intel.com, jani.saarinen@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240516124317.710-1-tzimmermann@suse.de>
 <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
 <1850b44d-e468-44db-82b7-f57e77fe49ba@redhat.com>
 <82731e7d-e34f-46c4-8f54-c5d7d3d60b5a@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <82731e7d-e34f-46c4-8f54-c5d7d3d60b5a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 5:11 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 16.05.24 um 17:03 schrieb Hans de Goede:
>> Hi,
>>
>> On 5/16/24 3:04 PM, Rafael J. Wysocki wrote:
>>> CC Hans who has been doing the majority of the ACPI video work.
>>>
>>> On Thu, May 16, 2024 at 2:43 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
>>>> renames the video source files under arch/ such that they does not
>>>> refer to fbdev any longer. The new files named video.o conflict with
>>>> ACPI's video.ko module.
>>> And surely nobody knew or was unable to check upfront that there was a
>>> video.ko already in the kernel.
>> Sorry, but nack for this change. I very deliberately kept the module-name
>> as video when renaming the actual .c file from video.c to acpi_video.c
>> because many people pass drivers/video/acpi_video.c module arguments
>> on the kernel commandline using video.param=val .
>>
>> Try e.g. doing a duckduckgo search for 1 off:
>>
>> "video.only_lcd"
>> "video.allow_duplicates"
>> "video.brightness_switch_enabled"
> 
> Ok, that makes sense. I'll rename the other files.

Great, thank you.

Regards,

Hans



