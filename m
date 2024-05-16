Return-Path: <linux-acpi+bounces-5869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C78C78E5
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06E81F213B0
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75C14D430;
	Thu, 16 May 2024 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJq+xr18"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758714D2A5
	for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871818; cv=none; b=iyqQBOMRwfoshaB03o6OWCxtgIfHCw8YxhCLSwdi8lcvwu3/qEvI6OWsbliEUB8vyXQGCMhlwvD4JkyihvTGXU6Ss0xY2pEhqZJYt0Yo96lbsS16cel8KwDJ0lR52E/NWPJD5p89cuU0ewdFYP8pc7L9YEjA51ppGi9Qt8SIBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871818; c=relaxed/simple;
	bh=Barrt/8/lO9wErCh7pOsz/xbkBpqA22b9Ik53PIZbjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNyTP+mu1GPmlIftOamtkKvDnbwetRdNElOl5oOUoSM+aJpIElR/aB7B+2BSeaQNHF9mQu2dg7yQZMIvuGA098weieSqgBv8wGng1sDQmLLN3wkhttW4vLTUI+hxyFUgX053OyKWDk5tRjICMnvvWvMGR1LMGQjQpoWZXKv5Amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJq+xr18; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715871814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKBUSAzkxF9Zs4eRSjZEOq3e8C2Kq3MU7w45eIpOnW4=;
	b=eJq+xr18Yg8k1zoDMjsd8+AT9vTzzLWykxIX4Ya/Ke5UjeWhEhSXYVOW1fhptX/z579pjI
	/I3YuvCPrCbnvLZ/gwciJ3T7nD0QQqY5OHcu5FwSLu7uduT9fuwkKU3q0hI/9lSW3wuc/g
	YVSfEZwkFGo19/r4uCtIUC44Qk5Jtk0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-FrtVh0rBM5qUwn8HrjO41Q-1; Thu, 16 May 2024 11:03:32 -0400
X-MC-Unique: FrtVh0rBM5qUwn8HrjO41Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-572cd3a3687so1703582a12.1
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 08:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871807; x=1716476607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKBUSAzkxF9Zs4eRSjZEOq3e8C2Kq3MU7w45eIpOnW4=;
        b=e4XJb96Is0vX+hWV1estzN/QSS/3spRvgMWWMpf0hhBR92axZb1NvjvH4/2jcz/ieq
         j2Da0NhnzS7+GBjIGZhSQqtCoz4BYcDgPGOLFjMHVfv0nus3dzJKy5uT90+YII1rQPyd
         3mSS6wEOJyv9QkwoOqLYEiZPPXcfIC0aNBCASBiroQkQbgkKlz2jx1+mhUP2FOzjEqfx
         eVK2lPxhaZufiZytVdhKKMViKR+OuHSpl8JLl8yk5py8Vj4Wuv1TZOTIMr+PzugELHHZ
         9vRLyuPOcRX7TyJyETZx3Xb36B94RpM6sbOPix7aGx5mT33aPu8gVIgYLuz+NSZpjT/F
         SPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZqAmadpmtHK/anWma8+IKTUCUiVeCno7uxiA4ECyrf+3RRDRP6gJB53LFOp1DRk8Mqy49UQmsKd/Da4dDYgF9lqLlomUBTL2scw==
X-Gm-Message-State: AOJu0YyYbG3yVNGFw0Xp3hmfO4u/8izclLbWONC2T5IqixKHxAxloHFT
	hXOuDg/GAcNzdQxivIMetARcwmT+WHkiNBztV6/kVR2RYf/xScAHNclK+VfS1f6NIQXFxNxPQia
	ydcRRhG1Zo9jIX1ob7SVgvlYPvahcr3H8N50PCqHbnNQkGBFjJHSqCW7Aycc=
X-Received: by 2002:a50:d583:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-5734d5f48b1mr19637053a12.21.1715871807586;
        Thu, 16 May 2024 08:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgvrzhNOwipq4x4p3Hw4REcPng/U01BJKv87Sp+Z20QuaHZ/2tw+/vdsLUK4lIsDrkAAHqdA==
X-Received: by 2002:a50:d583:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-5734d5f48b1mr19637027a12.21.1715871807208;
        Thu, 16 May 2024 08:03:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm2749663a12.82.2024.05.16.08.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:03:26 -0700 (PDT)
Message-ID: <1850b44d-e468-44db-82b7-f57e77fe49ba@redhat.com>
Date: Thu, 16 May 2024 17:03:25 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Fix name collision with architecture's
 video.o
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: lenb@kernel.org, arnd@arndb.de, chaitanya.kumar.borah@intel.com,
 suresh.kumar.kurmi@intel.com, jani.saarinen@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240516124317.710-1-tzimmermann@suse.de>
 <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gw620SLfxM66FfVeWMTN=dSZZtpH-=mFT_0HsumT3SsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 3:04 PM, Rafael J. Wysocki wrote:
> CC Hans who has been doing the majority of the ACPI video work.
> 
> On Thu, May 16, 2024 at 2:43 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
>> renames the video source files under arch/ such that they does not
>> refer to fbdev any longer. The new files named video.o conflict with
>> ACPI's video.ko module.
> 
> And surely nobody knew or was unable to check upfront that there was a
> video.ko already in the kernel.

Sorry, but nack for this change. I very deliberately kept the module-name
as video when renaming the actual .c file from video.c to acpi_video.c
because many people pass drivers/video/acpi_video.c module arguments
on the kernel commandline using video.param=val .

Try e.g. doing a duckduckgo search for 1 off:

"video.only_lcd"
"video.allow_duplicates"
"video.brightness_switch_enabled"

And you will find a lot of hits. The last one is even documented as
being "video.brightness_switch_enabled" in the main kernel-parameters.txt
as well as separately:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n39
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n7152
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/firmware-guide/acpi/video_extension.rst#n118

https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon#Brightness_control

If you rename this module then peoples config will break for
a whole lot of users.

So lets not do that and lets rename the new module which is causing
the conflict in the first place instead.

Regards,

Hans


