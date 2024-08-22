Return-Path: <linux-acpi+bounces-7791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438B395BDF5
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C53FB27BE1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D21D0482;
	Thu, 22 Aug 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6/XB5Oy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3F1CF29E
	for <linux-acpi@vger.kernel.org>; Thu, 22 Aug 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349897; cv=none; b=LTAJ6IF0HkpuKKtdFepIDMLzyQY+TMrN3T3gUNWywn96v5ZVei3xRB7BsSB26xs88VUyRGeLmiENXgXsy+YVetRHsk2WU/f75mvHpuH0qb1Kig57bs3SbVbeSKHnyg7+Ayw5XowVG+jk9ZLMHwVCL5QjOdwUq0GTIjF3+9t+rFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349897; c=relaxed/simple;
	bh=22LkK5Q1Veaz9Mb1zYBbVIj2dXiCPlbXlwB1IfPgj7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niP4e2xe8gUXTppVl8+iEFSrQWDIhMjv96CkgJJVHNu0R/ltXx7ljbGwTpEjT12briP9xF4aTnLQkuaVePensitY//SApNqxdo0+Ckan5jdJ/NFAJnUVKYBEseZhrW3vJXbGcP9HG/a09hrMp0RAfKV5IHMDMyDCHdRWElWFNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6/XB5Oy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724349892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEQT24HTH/UP2orz6Wh0q+3NPw1eci4EU9RHhKZFX2g=;
	b=c6/XB5Oy59Wwk9AZsR8gN1/g1ZyyMf4N618HD4/yJM6AuQtCKfEOGtYn56DZLTeUin7bJC
	MVq30djR/MJacC77jr364Go7jtt7ja1A+AOaVbyJSabCRVEZXu6zCxj3eX3WCfOk/sAPvP
	mPHGDyQ20P4u2+F+/nEarTMx4DaBg4s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-KCW0-_laNE25z_fDXkpcaA-1; Thu, 22 Aug 2024 14:04:47 -0400
X-MC-Unique: KCW0-_laNE25z_fDXkpcaA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42820af1106so8316915e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 22 Aug 2024 11:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349886; x=1724954686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEQT24HTH/UP2orz6Wh0q+3NPw1eci4EU9RHhKZFX2g=;
        b=TgT1X6qWgG8Bc+LCOHFs26i18mY5dN6qhBOOoWA1hTRmTEQmte94hudGrcWXNVUINY
         eY7CyL1T7cDG+QDBtyMhjm0NAR2adSzITVvdneCishnfYQpfz0qIY9SCVUplmWVUycSh
         +aH0GKi/R/6Xx7ydRm3AwDvlzvx71Pkc2fdcDzcZKENQCAxf0fW5FpdoUFoKv999BeW9
         MHEAerRpNdME/NR5WoGZFnC4RWKZnfUE3Ijtdv9wXXS4Bug0uytFSLBNO1GPpwbJ0c56
         pbiF7FT59onn/gr/IbTaggFmHiszwhRVLJl5wR3Qs+yTOPjBn9tnBzpHuwABVXCmx1lj
         Nz0A==
X-Forwarded-Encrypted: i=1; AJvYcCVTppz5UKnBj79gfQUbKRyFsLtxsXUUV52wNfsOzHjpXeXD26qANjFxhH8wKvZTidiUbK47BFTFnQAr@vger.kernel.org
X-Gm-Message-State: AOJu0YzOH1OFlZ1hYqjT23sewJoYXDJC7BYXlksuZgxhcERrmDetmDSW
	EIOmz0ZIKqfvVCip5N/HXXCsSv53WMsg9UjUFFJvOpYDlbnHwI1UBtVqdrhJsnh5n0K933q9Pq+
	qV6o1sS/PW0nFsA4W4mUfo3YOcg/FwRXmVS3U4Lk9vkAn0k58aawpAcXSKdne1fLrJOk=
X-Received: by 2002:adf:f24d:0:b0:367:9088:fecd with SMTP id ffacd0b85a97d-37308c08c62mr1716037f8f.7.1724349886331;
        Thu, 22 Aug 2024 11:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6SUIKLE1JQjtqs6HrdTaFyqHHZmF+U8ofr6ynQWzY+vpqwb/HUy6nOYotftRU637wSsXYJg==
X-Received: by 2002:adf:f24d:0:b0:367:9088:fecd with SMTP id ffacd0b85a97d-37308c08c62mr1716018f8f.7.1724349885823;
        Thu, 22 Aug 2024 11:04:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c9064sm1152586a12.73.2024.08.22.11.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 11:04:45 -0700 (PDT)
Message-ID: <f3baa8c0-3363-4f0c-be86-83be2ec4d373@redhat.com>
Date: Thu, 22 Aug 2024 20:04:44 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] platform/x86: wmi: Pass event data directly to legacy
 notify handlers
To: Armin Wolf <W_Armin@gmx.de>, james@equiv.tech, jlee@suse.com,
 corentin.chary@gmail.com, luke@ljones.dev, matan@svgalib.org,
 coproscefalo@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: ilpo.jarvinen@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240822173810.11090-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240822173810.11090-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/24 7:38 PM, Armin Wolf wrote:
> The current legacy WMI handlers are susceptible to picking up wrong
> WMI event data on systems where different WMI devices share some
> notification IDs.
> 
> Prevent this by letting the WMI driver core taking care of retrieving
> the event data. This also simplifies the legacy WMI handlers and their
> implementation inside the WMI driver core.
> 
> The first patch converts all legacy WMI notify handlers to stop using
> wmi_get_event_data() and instead use the new event data provided by
> the WMI driver core.
> The second patch fixes a minor issue discovered inside the
> hp-wmi-sensors driver, and the remaining patches perform some cleanups.
> 
> The patch series was tested on a Dell Inspiron 3505 and a Acer Aspire
> E1-731 and appears to work.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Guenter / Jean may I have your ack for merging the small
drivers/hwmon/hp-wmi-sensors.c changes through the pdx86
tree ?

Regards,

Hans


> 
> Armin Wolf (5):
>   platform/x86: wmi: Pass event data directly to legacy notify handlers
>   hwmon: (hp-wmi-sensors) Check if WMI event data exists
>   platform/x86: wmi: Remove wmi_get_event_data()
>   platform/x86: wmi: Merge get_event_data() with wmi_get_notify_data()
>   platform/x86: wmi: Call both legacy and WMI driver notify handlers
> 
>  drivers/hwmon/hp-wmi-sensors.c           |  20 +---
>  drivers/platform/x86/acer-wmi.c          |  16 +--
>  drivers/platform/x86/asus-wmi.c          |  19 +--
>  drivers/platform/x86/dell/dell-wmi-aio.c |  13 +--
>  drivers/platform/x86/hp/hp-wmi.c         |  16 +--
>  drivers/platform/x86/huawei-wmi.c        |  14 +--
>  drivers/platform/x86/lg-laptop.c         |  13 +--
>  drivers/platform/x86/msi-wmi.c           |  20 +---
>  drivers/platform/x86/toshiba-wmi.c       |  15 +--
>  drivers/platform/x86/wmi.c               | 143 ++++++-----------------
>  include/linux/acpi.h                     |   3 +-
>  11 files changed, 53 insertions(+), 239 deletions(-)
> 
> --
> 2.39.2
> 


