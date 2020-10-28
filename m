Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10FE29E11E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 02:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgJ2Bxq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 21:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728691AbgJ1V5Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 17:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603922242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7H6fn0sflmDKqkVqjVyUYl4il+uaeJMTU2fENiZAfKY=;
        b=IlxD5ZvqfCZoDxG9JOCWsutMIdqX+kmawcmefVRWlopzX12/hJ78op/prNT3vZY5pIyX+5
        tky7C/SbEdEBuUy3MbTcdqdV7+voJK3eetmSEPHfvAAbpRlPr2dJm9JXJNKUVL6eprbkdb
        DnrzHXDpTOVCc/qk0sEQcvU10y8QHcc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-W-niQg97NiyFMV1veTnNyg-1; Wed, 28 Oct 2020 07:54:44 -0400
X-MC-Unique: W-niQg97NiyFMV1veTnNyg-1
Received: by mail-ej1-f70.google.com with SMTP id lf18so2057760ejb.13
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2020 04:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7H6fn0sflmDKqkVqjVyUYl4il+uaeJMTU2fENiZAfKY=;
        b=pFAdGKa/HUiw1RQpx24H2fPPQ73Q2qSaNYP/qtONR37pFu6hYI4X7bOCIN2VB1yDgY
         YD+ieKjECRXMDr41kLaPo+GidapvEKVkkqy1RlyD7UuTZD6RojpzBbSPfuDda57V48i6
         GIOf1kBV9QuZO1PqtbD20brxyxDrLYCxr8P9eEKER75HvYK58Vhdz1jjQ7Pk8cxuB+lh
         Uc7oUiTOwCIsaXg9Z8W8xVFoXreJ321DHFBe0gWwca0yDbOmi+qn6J72rXx4YpVTjJEF
         I0lyGhxHwZvMcgpTU6/jm5RtgoU5HaCJALM8oxxl2XvMTdQ1Xrj8C5TwjLtkdROiZxo+
         FAbA==
X-Gm-Message-State: AOAM5319B2JXt4el8ffNc589m7TuOIQmaQ/EVJ6juuwC/iqYYYYaOMlL
        Hw/4qsIlNdO5NEOekt4tAly5yy0gFFUTx0fVQWIkCjD5jNlGshYppE7W+TmIkpGVZrX3dAPA/Ib
        G/ZAXo+my73B4qMws1dIqSw==
X-Received: by 2002:a17:906:3290:: with SMTP id 16mr7055816ejw.308.1603886082961;
        Wed, 28 Oct 2020 04:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyki7zPz1WgRhVvswcqc8DYrUa2nHa46FuIilVQLasUTTavgZEBiFJ8BDY2RERDV8wGBbiebg==
X-Received: by 2002:a17:906:3290:: with SMTP id 16mr7055799ejw.308.1603886082717;
        Wed, 28 Oct 2020 04:54:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id r3sm2768715edw.42.2020.10.28.04.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 04:54:42 -0700 (PDT)
Subject: Re: [PATCH] Documentation: Add documentation for new platform_profile
 sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com,
        hadess@hadess.net, bberg@redhat.com, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201027164219.868839-1-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8749d17c-4d0b-5c29-a8c9-4a6704b422d6@redhat.com>
Date:   Wed, 28 Oct 2020 12:54:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027164219.868839-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

A few minor nitpicks below, mostly stuff which I missed before, sorry.

I suggest you make v2 part of the series where you actually add the
drivers/acpi/... and the thinkpad_acpi.c bits to implement this.

On 10/27/20 5:42 PM, Mark Pearson wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> On modern systems the platform performance, temperature, fan and other
> hardware related characteristics are often dynamically configurable. The
> profile is often automatically adjusted to the load by somei

s/somei/some/

> automatic-mechanism (which may very well live outside the kernel).
> 
> These auto platform-adjustment mechanisms often can be configured with
> one of several 'platform-profiles', with either a bias towards low-power
> consumption or towards performance (and higher power consumption and
> thermals).

I think it is better to also drop the " (and higher power consumption and
thermals)" bit here (and below) like you did for the cool and quiet parts.

Regards,

Hans

> Introduce a new platform_profile sysfs API which offers a generic API for
> selecting the performance-profile of these automatic-mechanisms.
> 
> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in V1:
>  - Moved from RFC to proposed patch
>  - Added cool profile as requested
>  - removed extra-profiles as no longer relevant
> 
>  .../ABI/testing/sysfs-platform_profile        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
> new file mode 100644
> index 000000000000..240bd3d7532b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -0,0 +1,66 @@
> +Platform-profile selection (e.g. /sys/firmware/acpi/platform_profile)
> +
> +On modern systems the platform performance, temperature, fan and other
> +hardware related characteristics are often dynamically configurable. The
> +profile is often automatically adjusted to the load by some
> +automatic-mechanism (which may very well live outside the kernel).
> +
> +These auto platform-adjustment mechanisms often can be configured with
> +one of several 'platform-profiles', with either a bias towards low-power
> +consumption or towards performance (and higher power consumption and
> +thermals).
> +
> +The purpose of the platform_profile attribute is to offer a generic sysfs
> +API for selecting the platform-profile of these automatic-mechanisms.
> +
> +Note that this API is only for selecting the platform-profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with device/vendor
> +specific tools such as e.g. turbostat.
> +
> +Specifically when selecting a high-performance profile the actual achieved
> +performance may be limited by various factors such as: the heat generated
> +by other components, room temperature, free air flow at the bottom of a
> +laptop, etc. It is explicitly NOT a goal of this API to let userspace know
> +about any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe platform-profiles
> +this API uses strings to describe the various profiles. To make sure that
> +userspace gets a consistent experience when using this API this API
> +document defines a fixed set of profile-names. Drivers *must* map their
> +internal profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new profile-name
> +may be added. Drivers which wish to introduce new profile-names must:
> +1. Have very good reasons to do so.
> +2. Add the new profile-name to this document, so that future drivers which also
> +   have a similar problem can use the same name.
> +
> +What:		/sys/firmware/acpi/platform_profile_choices
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives a space separated list of profiles
> +		supported for this device.
> +
> +		Drivers must use the following standard profile-names:
> +
> +		low-power:		Emphasises low power consumption
> +		cool:			Emphasises cooler operation
> +		quiet:			Emphasises quieter operation
> +		balanced:		Balance between low power consumption
> +					and performance
> +		performance:		Emphasises performance (and may lead to
> +					higher temperatures and fan speeds)
> +
> +		Userspace may expect drivers to offer at least several of these
> +		standard profile-names.
> +
> +What:		/sys/firmware/acpi/platform_profile
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		available_profiles changes the profile to the new value.
> 

