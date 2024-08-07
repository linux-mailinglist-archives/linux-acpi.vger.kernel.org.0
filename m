Return-Path: <linux-acpi+bounces-7427-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0B94A558
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 12:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE3C1F2149B
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3131DD3A4;
	Wed,  7 Aug 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYngykoS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443721DD39C
	for <linux-acpi@vger.kernel.org>; Wed,  7 Aug 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026313; cv=none; b=umeaAs2gcLnOlfbbWAEDqgu5q0c6ZxZ/GO3+ZPtbK7owkYh5Mo6RI4+ZoyvX2jwd+KdfIHJkHGShL87d6A86HcBss2B7E0hFX8w0MA/EzdfQT+HCCVNaPei0LuEyAONkXwNCZB6Q2g2spLrcHvMkOAOFa4XOnCiOebsa7vadM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026313; c=relaxed/simple;
	bh=hOCZ+GOo8ddJAc837ZmiCPmlPJQZfhv/jg3HcXSwZJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XStTBo+In0rBaBMC0lw1FZ5oPlpCRiwV9R0l0B05nmm7RvYEa7skNd34yhUlsCpVEQ7+J6DRLfFM/3aifzzC/gV5TJroyo9w9HBhm1cUfj01rPOHZFBebtg3B2lpHv9NGE9TmCE+Sl9AKib8Ym6WBHfEq/n3FzD3d+S9/mpaPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYngykoS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723026310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKr5o03hOgeY5mMH9I+zX5gWnfZedpywYbJmmdN0XrU=;
	b=JYngykoSLJQniC5zblbzjzLA5SEFkf/nYJg9T8xDCacwpu+yD61/J8Xz/uZwfrVTpNw6Xc
	LPvpnN3JLkeg/e1t56T3W2ZbmKLelXya5BSGsWBp1pl2HsVQVj9VTKVPZxCY6qiG02u3GA
	iIt4ip+jAWNyqjFQcKwvyyJX/lcuIc8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-aAoqSzd4MHWJoYr3Un47jA-1; Wed, 07 Aug 2024 06:25:08 -0400
X-MC-Unique: aAoqSzd4MHWJoYr3Un47jA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a113d5cd1eso702176a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 Aug 2024 03:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723026307; x=1723631107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKr5o03hOgeY5mMH9I+zX5gWnfZedpywYbJmmdN0XrU=;
        b=Vc3qLY2iA4T+qNT0yr4qauoIAWj5PL1XLHyEaDJm+Jc2KUiTGOM72NgxAlpLEuSjZL
         ltXNHF78qvUDOd5uHzBm570Jpibi6airyWDin+kmFJOAvKOVx1RqN3KkC9pi+oSwUEm4
         /XXATxwtoMMZ3dz2jtHVpfhCz74Gg4oZOLwB0wDjW3uZK7sK/SEWwwhf1WNEI+PbG41A
         gATZKTJe/xN04RYXz7u3QA4EE1cUoo+p3iUcG7j3s7LaVY6mdxaW9s6UjEpcvoAHe2TB
         PvduiVvjnTybm/v2GtebBGVsFOYaBYUh9/iZKQVGvGH2G1/6LGzkDRb9VX3lmBfe0dct
         2/SA==
X-Gm-Message-State: AOJu0YyHMVZeO19/F6HR7cRwa05lV+IOMiYCuvQ7L/SvFk928mD/t6ko
	EYN8eR3MIerdC0UA6fwijvIt7vonZj9bnsZ8AXzxPuPt8zDBnlR2k8YDphhUW2gxUzn4rjd0Kr+
	YK84H0bnqC6t0GnF3UX8CX35KGNEHjb4MAGOzsXSdotyJKQnYGLM8As6vhzaXHJp9UEA0KA==
X-Received: by 2002:a05:6402:40c5:b0:5b9:462d:c53c with SMTP id 4fb4d7f45d1cf-5b9462dcf53mr15779396a12.6.1723026307203;
        Wed, 07 Aug 2024 03:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKU5pngRUkJ93655Cskv4fXvNSoHRSaMMNyZsujYLi/pNlxeqKlTnLCO41rUMJegB040lfFA==
X-Received: by 2002:a05:6402:40c5:b0:5b9:462d:c53c with SMTP id 4fb4d7f45d1cf-5b9462dcf53mr15779364a12.6.1723026306697;
        Wed, 07 Aug 2024 03:25:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf38fafsm6781109a12.80.2024.08.07.03.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:25:06 -0700 (PDT)
Message-ID: <5145dd51-d095-4185-920e-eafb33219e07@redhat.com>
Date: Wed, 7 Aug 2024 12:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi video: force native for Apple MacbookPro9,2
To: Esther Shimanovich <eshimanovich@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806-acpi-video-quirk-v1-1-369d8f7abc59@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240806-acpi-video-quirk-v1-1-369d8f7abc59@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/6/24 10:08 PM, Esther Shimanovich wrote:
> It used to be that the MacbookPro9,2 used its native intel backlight
> device until the following commit was introduced:
> commit b1d36e73cc1c ("drm/i915: Don't register backlight when another
> backlight should be used (v2)")
> This commit forced this model to use its firmware acpi_video backlight
> device instead.
> 
> That worked fine until an additional commit was added:
> commit 92714006eb4d ("drm/i915/backlight: Do not bump min brightness
> to max on enable")
> That commit uncovered a bug in the MacbookPro 9,2's acpi_video
> backlight firmware; the backlight does not come back up after resume.
> 
> Add DMI quirk to select the working native intel interface instead
> so that the backlight successfully comes back up after resume.
> 
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index c11cbe5b6eaa..2d377414f873 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -547,6 +547,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
>  		},
>  	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Apple MacBook Pro 9,2 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
> +		},
> +	},
>  	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
>  	 .callback = video_detect_force_native,
> 
> ---
> base-commit: d9ef02e56f0fd3668b6d7cb17f9399ea53f12edd
> change-id: 20240806-acpi-video-quirk-f1c9f01f07d9
> 
> Best regards,


