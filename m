Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0589299568
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 19:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789866AbgJZSdf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 14:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1789769AbgJZSde (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 14:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603737212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rzN8xtO7O+TraWbLdrWrZIHELIhUQEP4fjr6CDKufA=;
        b=Rcqff6T6/Ehf8oNhPWoc2CIeWJw8DhPMBbEYg5MYl5NhW50RZkUuQb+Pc5Gb817vi9cpLX
        vpLBhUwaEuy0jAy1ropQmRxBEmhInPhKvMDy7O1bndlXrCweb3hBDDXK0LY4o4wVKQxRUV
        CjCpV1g35keiKD9LDs/CDfDsQcF9lWc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-3tgId-gMN-mikwpI1mRI4g-1; Mon, 26 Oct 2020 14:33:30 -0400
X-MC-Unique: 3tgId-gMN-mikwpI1mRI4g-1
Received: by mail-ej1-f69.google.com with SMTP id c10so5762482ejm.15
        for <linux-acpi@vger.kernel.org>; Mon, 26 Oct 2020 11:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rzN8xtO7O+TraWbLdrWrZIHELIhUQEP4fjr6CDKufA=;
        b=SAt307R44T6bcoCBp49Xn8RH0mfjpnfUaWgpiOI/QndfSJhNiScvYdFuNa+vdqmdPO
         3V9pUkTcRp1EA6pqnuLfT2R0JgaRYp7dMdAhYPj4TDkRvNRD8Xczq2YZpc+H3hjbPp5/
         nWSK+G9K75Wr4TP/BbyERguGPZbMkQP/8n4cvKasUJXo4wjKNaQ6Nmv2ut2G6ifRpUar
         c0YSm6IiJpsQzuO8iEKdxaZTeJzsPeLwvLuouG0/VT4yD4dNQ+UtoBUr5B9SApIpGtpk
         WDK7tDirMzoMuJPK7vfm6MJK9PTGMMG7NXazFG7CIwKIkOmz6wVpAZo3uki2O0iK5ssd
         1CWA==
X-Gm-Message-State: AOAM5312A/rJ+FmnESUsDOMnjKm61CWXGCleGFDmxzYfSHPT3qhHsRes
        inCQoVfzQRS1SITfuoZ02fcd2TX3I1Lqi9DUNXNu4RcKrP/B6nXzm07bbuwJOnKlx08EVv8VH6w
        BVtnU3jzkGGQnlIm/Vya0QQ==
X-Received: by 2002:aa7:c4cc:: with SMTP id p12mr384468edr.77.1603737209494;
        Mon, 26 Oct 2020 11:33:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc7yieirk6V4fyLFmVp4QgXtXwAqn7MqgB2uT437fmfWnfpIjeCn56kJSZr7QmP/n7KXA+vg==
X-Received: by 2002:aa7:c4cc:: with SMTP id p12mr384438edr.77.1603737209193;
        Mon, 26 Oct 2020 11:33:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id b25sm5625353eds.66.2020.10.26.11.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:33:28 -0700 (PDT)
Subject: Re: [PATCH] [RFC] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com,
        hadess@hadess.net, bberg@redhat.com, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201026174444.866545-1-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <23f52638-274d-b474-1fd7-38c75760e35e@redhat.com>
Date:   Mon, 26 Oct 2020 19:33:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026174444.866545-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mark,

Thank you for this new version.

On 10/26/20 6:44 PM, Mark Pearson wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> On modern systems the platform performance, temperature, fan and other
> hardware related characteristics are often dynamically configurable. The
> profile is often automatically adjusted to the load by somei
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
> ---
>  .../ABI/testing/sysfs-platform_profile        | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
> new file mode 100644
> index 000000000000..37cb6275946c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -0,0 +1,85 @@
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
> +   have a similar problem can use the same new.

s/same new/same name/

> + Usually new profile-names will
> +   be added to the "extra profile-names" section of this document. But in some
> +   cases the set of standard profile-names may be extended.

With the change from a more generic API to this new one more targeted towards DPTF
I would drop this part.


> +
> +What:		/sys/firmware/acpi/platform_profile_choices
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives a space separated list of profiles
> +		supported for this device.
> +
> +		Drivers must use the following standard profile-names whenever
> +		possible:
> +
> +		low-power:		Emphasises low power consumption
> +		quiet:			Offers quieter operation (lower fan
> +					speed but with higher performance and
> +					temperatures then seen in low-power

I think the description here is a bit too specific, this may cause userspace
to have expectations which are not necessary true. I would describe this as
just:

		quiet:			Emphasises quieter operation

> +		balanced:		Balance between low power consumption
> +					and performance
> +		performance:		Emphasises performance (and may lead to
> +					higher temperatures and fan speeds)
> +
> +		Userspace may expect drivers to offer at least several of these
> +		standard profile-names! If none of the above are a good match
> +		for some of the drivers profiles, then drivers may use one of
> +		these extra profile-names:
> +		<reserved for future use>
> +
> +What:		/sys/firmware/acpi/platform_profile
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		available_profiles changes the profile to the new value.

The part about custom profiles below may be dropped. That was intended for use
with e.g. GPUs but since this now strictly is a system-level profile API, the
part below can be dropped now.


> +
> +		Reading this file may also return "custom". This is intended for
> +		drivers which have and export multiple knobs. Such drivers may
> +		very well still want to offer a set of profiles for easy of use
> +		and to be able to offer a consistent standard API (this API) to
> +		userspace for configuring their performance. The "custom" value
> +		is intended for when ai user has directly configured the knobs
> +		(through e.g. some advanced control-panel for a GPU) and the
> +		knob values do not match any of the presets represented by the
> +		platform-profiles. In this case writing this file will
> +		override the modifications and restore the selected presets.
> +
> 

Regards,

Hans

