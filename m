Return-Path: <linux-acpi+bounces-5855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C398C72F2
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5301B22392
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FB1420A8;
	Thu, 16 May 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KC3Be1Lm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E4141981
	for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848548; cv=none; b=hU0BtkwxjfMNdc2Z3nlsLpqIyk/C9+q23AW7OaPBqHvZAZEgQnTslLsO77GYfLFIjFA4z6SS++C54eGBATQWAJSNDyIi72jEjH7fyTSpdwiJmlHd8pSPE2hFR1rtYA7vK/zOh4dG0PK96ivz2wK5y95+zVbjSX3EywQ66eIngQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848548; c=relaxed/simple;
	bh=oo8O8Dcaaijl0P4hmnJdYe/yUNgFhAJcyi9f3JA3zPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRKORmmR816uIQvNHtdeWvN4K8TVo6DPP2EpHpKYTfwk4PicO/8rKnAtcgCk3Z3v1dnFoxgGGahYtwFhRtlWG1amB39MYNWVhxNZ1mY+Xbexsk8oaL/tnXFtrLCrqyqknJWWymjgch7MxUmsg2esRdxaQRuo/kbE0X/EBqOyPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KC3Be1Lm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715848545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYmuujxXBhD2mn7on4bQ5dzfou146JwBEZ+r/yhSuTg=;
	b=KC3Be1LmD03smnweZOlYb900nFTbp2IdrLLHwdrfZCSA6ccW0L3waeV3XamniHqWbDAoca
	jh542r+X8GCCA+vpGnj8jV90kMWydVXYoLS/k0+I1XRmXZCK5Yto3l99JN07+aOSwpBE8I
	lmOdcFG0EmpRIBuo9MsZl69c+ft2qvA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-0Nc0AZTTOKSPduE6_PtYEw-1; Thu, 16 May 2024 04:35:30 -0400
X-MC-Unique: 0Nc0AZTTOKSPduE6_PtYEw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-523936877a3so1759851e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2024 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715848529; x=1716453329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYmuujxXBhD2mn7on4bQ5dzfou146JwBEZ+r/yhSuTg=;
        b=Pr+aaH1ptA0OM2si/J8A14XOfJUCE1ugXpa18IH9h9/LJDLQ+pYpCXRkxSO7gip7E4
         33AjVB4wrykRqrNvngqq3imyK35kwqZ9GfNXQkTiDNj7DjA/H9TnjZnrLvjn4hAgOUGN
         3JhmYYffXHLIlWsOPFNxRbfVH+YpxjhuaJXO7F2vP78pEelRnPwrTHnBzOLeuCjw5uMs
         Mb4+eJ/M502A8/Cd4WCgJBRnrQnva3FsVd5ZR5HtAP+k9L+cvuV0Yh8wyhNmAQPPtk9x
         H42AwEVwLv5GupLWvJ42C/x0Cne4LpHf84HdsSkAU/mFFWIjv3WpoPt2QpZAzY8+V5zB
         exTg==
X-Forwarded-Encrypted: i=1; AJvYcCWvF/ILqtPb0L2sN/OkqZw/bGczqCtWMpaNvDwOSPvPXtrs7QSZrQretdxT6dOQHMmkg9EMAGcTkJ2KxJM6rjgsu9EKUVlqGLVSGA==
X-Gm-Message-State: AOJu0YyskMAgWeQmaIu/bspgbY9duvPUlBfqb8daVxjFLeYgs31C0Uev
	iKB9IwWmqM86+lOrdoOmh62No+LpvBV9Kxh/aX6yAjKF33L3H85snk08We9f5f/pEJe19zj7dhT
	ei0LpckPbi69Zo4l+Rk/pPVZgxdbPuE4HWr7+fJXK/Eyhmv0T3IcUwjGSPA0=
X-Received: by 2002:a05:6512:158d:b0:519:5df9:d945 with SMTP id 2adb3069b0e04-5220fb77429mr16542549e87.4.1715848529086;
        Thu, 16 May 2024 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj3vDyFOlnPaeCzyl328j8BfErkTQsUgK6I5x9aUnU3vXkenCsOHvyVEAgMrpq3mhh9Pl7lA==
X-Received: by 2002:a05:6512:158d:b0:519:5df9:d945 with SMTP id 2adb3069b0e04-5220fb77429mr16542526e87.4.1715848528671;
        Thu, 16 May 2024 01:35:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed72bbsm10232486a12.57.2024.05.16.01.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 01:35:28 -0700 (PDT)
Message-ID: <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
Date: Thu, 16 May 2024 10:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <12437901.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
> 
> which was a follow up for the discussion in:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> 
> Patch [1/2] has been updated to avoid possible issues related to
> systems with defective platform firmware and patch [2/2] is a resend
> with a couple of tags added.

Thanks, the series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

I assume you are going to send this in as a fix for 6.10 ?

In that case feel free to merge both patches through the
linux-pm tree.

Regards,

Hans




