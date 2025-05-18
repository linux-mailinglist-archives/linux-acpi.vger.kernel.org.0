Return-Path: <linux-acpi+bounces-13777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D8ABAF09
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 11:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3AED1896916
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A6204866;
	Sun, 18 May 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="0ql6zCdL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CoGUsFc+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA11DE8B2;
	Sun, 18 May 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747561442; cv=none; b=mJnUYz5p+HZNTPJIU60ra4ITO4m7E+IMtfifF3VFaP8vNOZ8pcVINP629xROc84xLTrEsvO4LJv4UZqMmkF+/TlzSuhLy2XYeWqorFA1tZU4lUfqxp0ER95JmqXmscaguUBrD/HUIjUoaYLB673aU8F7H6op3c6EzmX7iMefRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747561442; c=relaxed/simple;
	bh=2P/HKlAxwqWfxzHc5s7b2DFW22bc2WeSuuYhz5j00P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2PO57sNelAohfzkVrbuB2KhczjvUNObdn4NIE8wOPhjMkqTOFoR0DkPlq8iSBdPPp1yPbUGHtNXSMpKsVMXdpymLm8CHxMK6Et1Pk7f87QDwg4KSInsydrBclH40rRTGg9u2zjzFEm1lbeC2ptoKq72PorgxztBFe6byRVHIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=0ql6zCdL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CoGUsFc+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B23911400A4;
	Sun, 18 May 2025 05:43:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 18 May 2025 05:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747561436; x=1747647836; bh=MSavexikK5
	fDEI4HRccPPwtA5Xn8rC2JBmt1ihwm3wQ=; b=0ql6zCdLaiZeByCPAdPf3+vGpd
	mWKcNrirWMxVKOjt+fDqObAyhAUC8HdemUPKraofj7PdunwNl/963OmTgI90H5wT
	kzYhsnUugelqhtP8ECaCT517Wq4l5yubsOOFTOecSVvPA7rFzTzGEuPOnPwLDdba
	Z3mPg5NghCvzOn+gXIB7BP88rZqZiAsupBp8RRRPTCmg8jg0u+cxr3hOlhBl6CmN
	1fq8CzIimvdWwra+GnheozVUBQz4OXaDaWBhSzJslWlXK6GqXniKf4lzm3O25Ppm
	dIUtlxUKJ7q7TeXK/RuOUadS4e2baiEXisi1lzyXpANoDKruSHPgf53gH5sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747561436; x=1747647836; bh=MSavexikK5fDEI4HRccPPwtA5Xn8rC2JBmt
	1ihwm3wQ=; b=CoGUsFc+NfLq8PUIw0F1sKF0YoaqgjYSE78IjMI00zBfuB8xFKm
	D6FCjr4AybEeTWu4RbWhg+Iu4eOG3ZxvtyIQb/rI52nG+fYxftamoSSAkZps4lmD
	5NEVT2r3zVYKfKvr9VisF6oW40utPTonJW8pJY880IfK4abxJ7Zf0bt+y6JMT+4H
	YGzxHZPrK9sjn2Nul0KrG6usul9w8iAqupAuhUJG5EgDPZWyuGW7KV9u1+8lCzZD
	BlX70utPC+rG9GoNq0cI16sV9xb9AejgYIvLF42UPSnhEeReHgj7WK5BRavV2Blz
	iuIazv7PUOl6awkT979kd3+T+OMxSTtV8Sw==
X-ME-Sender: <xms:3KspaKpcL2Daq-gs2AYff_TGmLBY-ZhmyepM9PidzUPiT4Ta2RonFA>
    <xme:3KspaIpMGaKKtx4gcifLqHG40PI9P4RoPlyyiB2iE1DpB8rqsT1lBJUANsPLMznRb
    hq1q2lPahsIQKJMGr0>
X-ME-Received: <xmr:3KspaPPqIfIts7ALR2u0FS4GLyAQTLqd33xYSsC051HMpZ5GgvclXoJ3ImL20uyb3QSDKafcUwbackdJJHtbxh_a3rAyr9vl-5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomheplfgrnhhnvgcuifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpefgvdffveelgedujeeffeehheekheelheefgfejffeftedu
    geethfeuudefheefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvgdprhgtph
    htthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhshhhnuhhotghvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlvghnsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhise
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3KspaJ7HbijASqkyh1PPRS7W0r-To2s_ezSIElD9CO2B_FCnrOLn1w>
    <xmx:3KspaJ62bgSEiI_VHshu2bZG89o3_lFdnAYensCmIOFCDFf6ZoHGBg>
    <xmx:3KspaJhRxDm3U8lVhsHWKOgKa5b5fFAviJnhWaaTLekO5UcQQVPcSw>
    <xmx:3KspaD7fonQie-S8lsgmJA1MLKLkK1U5E-32PyRp40x7TkzzzOimrw>
    <xmx:3KspaOrUOH2KZI6EVooDAnVXwtXSTft6_ZZLvg6F1u_0HZ42qV3KhZWk>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 May 2025 05:43:55 -0400 (EDT)
Date: Sun, 18 May 2025 11:43:53 +0200
From: Janne Grunau <j@jannau.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Vishnu Sankar <vishnuocv@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: Unbreak USB/BT keyboards on non-ACPI
 platforms
Message-ID: <20250518094353.GB1556976@robin.jannau.net>
References: <20250512-hid_lenovo_unbreak_non_acpi-v1-1-e9e37ecbfbfe@jannau.net>
 <b77edae0-50bd-4039-9487-15bb69389c6c@gmx.de>
 <20250515230537.GA1556976@robin.jannau.net>
 <b3536162-44aa-40af-861e-07371497ef30@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3536162-44aa-40af-861e-07371497ef30@gmx.de>

Hej,

On Sat, May 17, 2025 at 05:58:24PM +0200, Armin Wolf wrote:
> Am 16.05.25 um 01:05 schrieb Janne Grunau:
> 
> > On Fri, May 16, 2025 at 12:05:11AM +0200, Armin Wolf wrote:
> >> Am 12.05.25 um 23:55 schrieb Janne Grunau via B4 Relay:
> >>
> >>> From: Janne Grunau <j@jannau.net>
> >>>
> >>> Commit 84c9d2a968c8 ("HID: lenovo: Support for ThinkPad-X12-TAB-1/2 Kbd
> >>> Fn keys") added a dependency on ACPI_PLATFORM_PROFILE to cycle through
> >>> power profiles. This breaks USB and Bluetooth keyboards on non-ACPI
> >>> platforms since platform_profile_init() fails. See the warning below for
> >>> the visible symptom but cause is the dependency on the platform_profile
> >>> module.

[...]

> >> i think we can fix that. We just have to skip the compat stuff if acpi_kobj is NULL (means that ACPI is not used).
> >> The modern platform profile interface is generic enough to also work on non-ACPI systems.
> >>
> >> Can you test a patch?
> > I can easily test patches
> 
> Nice, i attached the necessary patch. Please keep in mind that this patch is compile-tested only.
> 
> From: Armin Wolf <W_Armin@gmx.de>
> Date: Sat, 17 May 2025 17:45:09 +0200
> Subject: [PATCH] ACPI: platform_profile: Add support for non-ACPI platforms
> 
> Currently the platform profile subsystem assumes that all supported
> (i.e. ACPI-capable) platforms always run with ACPI being enabled.
> However some ARM64 notebooks do not support ACPI and are instead
> using devicetree for booting.
> 
> Do not register the legacy sysfs interface on such devices as it
> depends on the acpi_kobj (/sys/firmware/acpi/) being present. Users
> are encouraged to use the new platform-profile class interface
> instead.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/platform_profile.c | 68 ++++++++++++++++++++++++++-------
>  1 file changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index ffbfd32f4cf1..c5a5da7d03f1 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -190,6 +190,20 @@ static ssize_t profile_show(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", profile_names[profile]);
>  }
>  
> +/**
> + * profile_notify_legacy - Notify the legacy sysfs interface
> + *
> + * This wrapper takes care of only notifying the legacy sysfs interface
> + * if it was registered during module initialization.
> + */
> +static void profile_notify_legacy(void)
> +{
> +	if (!acpi_kobj)
> +		return;
> +
> +	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +}
> +
>  /**
>   * profile_store - Set the profile for a class device
>   * @dev: The device
> @@ -215,7 +229,7 @@ static ssize_t profile_store(struct device *dev,
>  			return ret;
>  	}
>  
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	profile_notify_legacy();
>  
>  	return count;
>  }
> @@ -435,7 +449,7 @@ static ssize_t platform_profile_store(struct kobject *kobj,
>  			return ret;
>  	}
>  
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	profile_notify_legacy();
>  
>  	return count;
>  }
> @@ -472,6 +486,22 @@ static const struct attribute_group platform_profile_group = {
>  	.is_visible = profile_class_is_visible,
>  };
>  
> +/**
> + * profile_update_legacy - Update the legacy sysfs interface
> + *
> + * This wrapper takes care of only updating the legacy sysfs interface
> + * if it was registered during module initialization.
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int profile_update_legacy(void)
> +{
> +	if (!acpi_kobj)
> +		return 0;
> +
> +	return sysfs_update_group(acpi_kobj, &platform_profile_group);
> +}
> +
>  /**
>   * platform_profile_notify - Notify class device and legacy sysfs interface
>   * @dev: The class device
> @@ -481,7 +511,7 @@ void platform_profile_notify(struct device *dev)
>  	scoped_cond_guard(mutex_intr, return, &profile_lock) {
>  		_notify_class_profile(dev, NULL);
>  	}
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	profile_notify_legacy();
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);
>  
> @@ -529,7 +559,7 @@ int platform_profile_cycle(void)
>  			return err;
>  	}
>  
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	profile_notify_legacy();
>  
>  	return 0;
>  }
> @@ -603,9 +633,9 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>  		goto cleanup_ida;
>  	}
>  
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +	profile_notify_legacy();
>  
> -	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
> +	err = profile_update_legacy();
>  	if (err)
>  		goto cleanup_cur;
>  
> @@ -639,8 +669,8 @@ void platform_profile_remove(struct device *dev)
>  	ida_free(&platform_profile_ida, pprof->minor);
>  	device_unregister(&pprof->dev);
>  
> -	sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -	sysfs_update_group(acpi_kobj, &platform_profile_group);
> +	profile_notify_legacy();
> +	profile_update_legacy();
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>  
> @@ -692,16 +722,28 @@ static int __init platform_profile_init(void)
>  	if (err)
>  		return err;
>  
> -	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err)
> -		class_unregister(&platform_profile_class);
> +	/*
> +	 * The ACPI kobject can be missing if ACPI was disabled during booting.
> +	 * We thus skip the initialization of the legacy sysfs interface in such
> +	 * cases to allow the platform profile class to work on ARM64 notebooks
> +	 * without ACPI support.

I wouldn't say work as I'd expect that there are 0 registered
platform_profile class devices.

> +	 */
> +	if (acpi_kobj) {
> +		err = sysfs_create_group(acpi_kobj, &platform_profile_group);
> +		if (err < 0) {
> +			class_unregister(&platform_profile_class);
> +			return err;
> +		}
> +	}
>  
> -	return err;
> +	return 0;
>  }
>  
>  static void __exit platform_profile_exit(void)
>  {
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	if (acpi_kobj)
> +		sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +
>  	class_unregister(&platform_profile_class);
>  }
>  module_init(platform_profile_init);

thanks, patch works on the affected system and the HID device for the
Lenovo keyboard probes successfully. We still need to stub
platform_profile_cycle() to get rid of the ACPI Kconfig dependency. I'll
send that out separately.

Reviewed-by: Janne Grunau <j@jannau.net>
Tested-by: Janne Grunau <j@jannau.net>


