Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3451E2CD2CB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 10:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgLCJqI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 04:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727757AbgLCJqF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 04:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606988677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l71kG2/emSMW2MJTKr4C/m32Hv/B6Cwhhtv5RWx2w5c=;
        b=auAIRFpSmz50/P77quOIdDZwKF+U9h9JSrKC4viCo3X0rxPNGoZKbhpP7G2TP47w+HrY+Z
        j3BwicwBTbPqSHuKA9NvBuGfK4WAcPvffCV95g3wJzFlMdpsjbV0CiR13nOgZl5lHCe2NP
        YTs/SWsZkGugTfeV5bKEvhErpZ/hWAs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551--XRBoCLcNhuCW4YGhiMAXA-1; Thu, 03 Dec 2020 04:44:36 -0500
X-MC-Unique: -XRBoCLcNhuCW4YGhiMAXA-1
Received: by mail-ed1-f72.google.com with SMTP id f20so711515edx.23
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2020 01:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l71kG2/emSMW2MJTKr4C/m32Hv/B6Cwhhtv5RWx2w5c=;
        b=pzKfd/4tTSn7kVLCsugDTuDlB/eUGIBGZiPREcLTo9xU1Tu6/5LUz6HkiuxU+W9Jns
         kJYuyPpi8n7w4eQZFFpF8n26DCUOTPl+GytN2r4PdHQZUdtcUOy3VS9sVAibA4nj8ZRm
         moHILJ8iTZRuJBIfBUxoDKI+30ujWU/bjgeagf7c0XKqJ4eRH4sROwI29SUXCEh1Oa8L
         tKB8lffuxh398p8GM7gpDpCp9X1EWnFtMW5MOTvsW/6eB8sZ+iMEq5Ma/i6xikc5B+6w
         klGNzVVvsi/oeWnNCYMxgVnykfCBFn/Ly8VPjH2mz5IbqH5+8XuDD/EIddE8QY5ePEgl
         T/vQ==
X-Gm-Message-State: AOAM533NXo9tFiE+K48P51hhqQjghSTpEBdC5eLHbRJqY0GxNt2Nv7/p
        kzQwcEmlFWHVOc/nZ0ccy7ljQ8IQ2V23Rtz7h1YEuLJtOUwMyiIzMQ8CqUWoyY6Au+hF4if/3fz
        jpZsKXvlSQoU6nG24AQuD9Q==
X-Received: by 2002:a17:906:b1c8:: with SMTP id bv8mr1764164ejb.208.1606988675260;
        Thu, 03 Dec 2020 01:44:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcV0FcgtFDwRu8ixdgsPerB8fVQqeXQMH02UYVxB9/H1pcCmOCrXynEqqIQc/HM5zFL+bHzg==
X-Received: by 2002:a17:906:b1c8:: with SMTP id bv8mr1764150ejb.208.1606988675067;
        Thu, 03 Dec 2020 01:44:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i13sm459474ejc.57.2020.12.03.01.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 01:44:34 -0800 (PST)
Subject: Re: [PATCH v5 1/3] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     mgross@linux.intel.com, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hadess@hadess.net,
        pobrn@protonmail.com, mario.limonciello@dell.com,
        eliadevito@gmail.com, bberg@redhat.com, dvhart@infradead.org
References: <markpearson@lenovo.com>
 <20201202171120.65269-1-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <74b6ef2c-ac13-bffe-edda-478512950d22@redhat.com>
Date:   Thu, 3 Dec 2020 10:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202171120.65269-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/2/20 6:11 PM, Mark Pearson wrote:
> On modern systems the platform performance, temperature, fan and other
> hardware related characteristics are often dynamically configurable. The
> profile is often automatically adjusted to the load by some
> automatic-mechanism (which may very well live outside the kernel).
> 
> These auto platform-adjustment mechanisms often can be configured with
> one of several 'platform-profiles', with either a bias towards low-power
> consumption or towards performance (and higher power consumption and
> thermals).
> 
> Introduce a new platform_profile sysfs API which offers a generic API for
> selecting the performance-profile of these automatic-mechanisms.
> 
> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thank you, patches 1 and 2 look good to me now, you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

To patch 2 (since I'm co-author of patch 1 it would be a bit weird
to add it there too).

Rafael, it would be great if you pick up patches 1 and 2 for merging
into 5.11 (assuming that you agree that they are ready) then I will merge
patch 3 once 5.11-rc1 is out.

Regards,

Hans



> ---
> Changes in v2:
>  - updated to rst format
> Changes in v3, v4 & v5:
>  - version bump along with rest of patch series
> 
>  .../ABI/testing/sysfs-platform_profile.rst    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile.rst
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile.rst b/Documentation/ABI/testing/sysfs-platform_profile.rst
> new file mode 100644
> index 000000000000..5f7b2a94409b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform_profile.rst
> @@ -0,0 +1,66 @@
> +=======================================================================
> + Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
> +=======================================================================
> +
> +
> +On modern systems the platform performance, temperature, fan and other
> +hardware related characteristics are often dynamically configurable. The
> +profile is often automatically adjusted to the load by some
> +automatic mechanism (which may very well live outside the kernel).
> +
> +These auto platform adjustment mechanisms often can be configured with
> +one of several platform profiles, with either a bias towards low power
> +operation or towards performance.
> +
> +The purpose of the platform_profile attribute is to offer a generic sysfs
> +API for selecting the platform profile of these automatic mechanisms.
> +
> +Note that this API is only for selecting the platform profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with device/vendor
> +specific tools such as e.g. turbostat.
> +
> +Specifically when selecting a high performance profile the actual achieved
> +performance may be limited by various factors such as: the heat generated
> +by other components, room temperature, free air flow at the bottom of a
> +laptop, etc. It is explicitly NOT a goal of this API to let userspace know
> +about any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers on their own cannot represent the multiple variables that a
> +profile will adjust (power consumption, heat generation, etc) this API
> +uses strings to describe the various profiles. To make sure that userspace
> +gets a consistent experience this API document defines a fixed set of
> +profile names. Drivers *must* map their internal profile representation
> +onto this fixed set.
> +
> +
> +If there is no good match when mapping then a new profile name may be
> +added. Drivers which wish to introduce new profile names must:
> +
> + 1. Explain why the existing profile names canot be used.
> + 2. Add the new profile name, along with a clear description of the
> +    expected behaviour, to the documentation.
> +
> +:What:        /sys/firmware/acpi/platform_profile_choices
> +:Date:        October 2020
> +:Contact:     Hans de Goede <hdegoede@redhat.com>
> +:Description: This file contains a space-separated list of profiles supported for this device.
> +
> +              Drivers must use the following standard profile-names::
> +
> +         		 low-power:     Low power consumption
> +         		 cool:          Cooler operation
> +		         quiet:         Quieter operation
> +		         balanced:      Balance between low power consumption and performance
> +		         performance:   High performance operation
> +
> +              Userspace may expect drivers to offer more than one of these
> +              standard profile names.
> +
> +:What:        /sys/firmware/acpi/platform_profile
> +:Date:        October 2020
> +:Contact:     Hans de Goede <hdegoede@redhat.com>
> +:Description: Reading this file gives the current selected profile for this
> +              device. Writing this file with one of the strings from
> +              available_profiles changes the profile to the new value.
> 

