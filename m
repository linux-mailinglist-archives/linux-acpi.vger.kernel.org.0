Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A476F28365A
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgJENN4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Oct 2020 09:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJENN4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2020 09:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601903633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4VL1MEEuuTzlv3OtMiMiuynTRHitiP7+NpypISX0XU=;
        b=Q5sp0LoJzvjtpowJ/lwJmzUfNOFVlkLCU+WrytxwIKkwSzdJTxfxDcQ5XDhe9r3D5H15Hn
        xJ5liZoHYaM9NigQYJN7huL+RdzJa0Jma5CI/miQjiMyE2/ePaoOHlJYES1LHS0DnkU1zU
        V8Jy72X5daKElnagJEOoubsZwhXpd9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-0-KxV1iKPI2llu6r8Bg2vQ-1; Mon, 05 Oct 2020 09:13:51 -0400
X-MC-Unique: 0-KxV1iKPI2llu6r8Bg2vQ-1
Received: by mail-wr1-f72.google.com with SMTP id y3so3984002wrl.21
        for <linux-acpi@vger.kernel.org>; Mon, 05 Oct 2020 06:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=t4VL1MEEuuTzlv3OtMiMiuynTRHitiP7+NpypISX0XU=;
        b=c2JWaowgP2FaLnRCTVgvqFrqxnWD1xJvMaXABq1g0acgWR25T9dmRzzeGofW2EwMFr
         0ttIjFaB28cAroFjD7pQ3/b0lsjm6m+2lbf/oiX1EluPcTWzK++J+TqLreB/ya9Bhap9
         pzoQplNJn63u945wxsF1ZdePdd7TEFyfH/U6RjnVn7dTExWYchE9SN4ie2Ds8XNshjh+
         Scq/KC4Pe2fp+aJKDB7zJhYY1PpjmsRlSb4yeSXetGo9LiVGH1h/ZOwf6U5UpC4h2deo
         OEZIFMZAaW4wDzhWjFEgFHAAKbwN11nu9y3xkcMM1N/sLHopF/ZXpNQZSU0m+YCqhjBW
         voPQ==
X-Gm-Message-State: AOAM532FGXRnGK8Ny6WBkV3/z+U0lv/P9v9Xaz4p+NcvP95BHL+4W2oT
        9stW5/wbF/mDGdLRrqmynzdns9IJ4Je/SyXxk+V28u4JRsfNfetd3u1e8YHBwHdPvJxP6t1uwNJ
        nHjJOnWHp0gCnqI9i/4Nnsw==
X-Received: by 2002:a1c:3d86:: with SMTP id k128mr7993365wma.153.1601903630528;
        Mon, 05 Oct 2020 06:13:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo7xZAJkhs7rHAQq9clCZ1xHcYwyUObh7KuD01F13Ea/arxO9CoVLR5ei2pdY90CFoTX8eQA==
X-Received: by 2002:a1c:3d86:: with SMTP id k128mr7993341wma.153.1601903630279;
        Mon, 05 Oct 2020 06:13:50 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id y14sm12216958wma.48.2020.10.05.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:13:49 -0700 (PDT)
Message-ID: <c464996fb3e0e23958c01196fe45f79cafce6cf4.camel@redhat.com>
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
From:   Benjamin Berg <bberg@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>
Date:   Mon, 05 Oct 2020 15:13:44 +0200
In-Reply-To: <20201003131938.9426-2-hdegoede@redhat.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
         <20201003131938.9426-2-hdegoede@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Nk6pXwAOo7kN93a0M/eJ"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


--=-Nk6pXwAOo7kN93a0M/eJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

seems reasonable to me. Quite simple, but likely good enough as we are
sticking to only use well known names.

Just found a small typo.

Benjamin

On Sat, 2020-10-03 at 15:19 +0200, Hans de Goede wrote:
> On modern systems CPU/GPU/... performance is often dynamically configurab=
le
> in the form of e.g. variable clock-speeds and TPD. The performance is oft=
en
> automatically adjusted to the load by some automatic-mechanism (which may
> very well live outside the kernel).
>=20
> These auto performance-adjustment mechanisms often can be configured with
> one of several performance-profiles, with either a bias towards low-power
> consumption (and cool and quiet) or towards performance (and higher power
> consumption and thermals).
>=20
> Introduce a new performance_profile class/sysfs API which offers a generi=
c
> API for selecting the performance-profile of these automatic-mechanisms.
>=20
> Cc: Mark Pearson <markpearson@lenovo.com>
> Cc: Elia Devito <eliadevito@gmail.com>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: Benjamin Berg <bberg@redhat.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-performance_pro=
file
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile b/=
Documentation/ABI/testing/sysfs-class-performance_profile
> new file mode 100644
> index 000000000000..9c67cae39600
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-performance_profile
> @@ -0,0 +1,104 @@
> +Performance-profile selection (e.g. /sys/class/performance_profile/think=
pad_acpi/)
> +
> +On modern systems CPU/GPU/... performance is often dynamically configura=
ble
> +in the form of e.g. variable clock-speeds and TPD. The performance is of=
ten
> +automatically adjusted to the load by some automatic-mechanism (which ma=
y
> +very well live outside the kernel).
> +
> +These auto performance-adjustment mechanisms often can be configured wit=
h
> +one of several performance-profiles, with either a bias towards low-powe=
r
> +consumption (and cool and quiet) or towards performance (and higher powe=
r
> +consumption and thermals).
> +
> +The purpose of the performance_profile class is to offer a generic sysfs
> +API for selecting the performance-profile of these automatic-mechanisms.
> +
> +Note that this API is only for selecting the performance-profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with device/vendor
> +specific tools such as e.g. turbostat.
> +
> +Specifically when selecting a high-performance profile the actual achiev=
ed
> +performance may be limited by various factors such as: the heat generate=
d by
> +other components, room temperature, free air flow at the bottom of a lap=
top,
> +etc. It is explicitly NOT a goal of this API to let userspace know about
> +any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe performance-profi=
les
> +this API uses strings to describe the various profiles. To make sure tha=
t
> +userspace gets a consistent experience when using this API this API docu=
ment
> +defines a fixed set of profile-names. Drivers *must* map their internal
> +profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new profil=
e-name
> +may be added. Drivers which wish to introduce new profile-names must:
> +1. Have very good reasons to do so.
> +2. Add the new profile-name to this document, so that future drivers whi=
ch also
> +   have a similar problem can use the same new. Usually new profile-name=
s will

Typo, "new" -> "name" I suppose.

> +   be added to the "extra profile-names" section of this document. But i=
n some
> +   cases the set of standard profile-names may be extended.
> +
> +What:		/sys/class/performance_profile/<device>/available_profiles
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
> +					(and also cool and quiet)
> +		balanced-low-power:	Balances between low power consumption
> +					and performance with a slight bias
> +					towards low power
> +		balanced:		Balance between low power consumption
> +					and performance
> +		balanced-performance:	Balances between performance and low
> +					power consumption with a slight bias
> +					towards performance
> +		performance:		Emphasises performance (and may lead to
> +					higher temperatures and fan speeds)
> +
> +		Userspace may expect drivers to offer at least several of these
> +		standard profile-names! If none of the above are a good match
> +		for some of the drivers profiles, then drivers may use one of
> +		these extra profile-names:
> +		<reserved for future use>
> +
> +What:		/sys/class/performance_profile/<device>/current_profile
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		available_profiles changes the profile to the new value.
> +
> +		Reading this file may also return "custom". This is intended for
> +		drivers which have and export multiple knobs influencing
> +		performance. Such drivers may very well still want to offer a
> +		set of profiles for easy of use and to be able to offer a
> +		consistent standard API (this API) to userspace for configuring
> +		their performance. The "custom" value is intended for when a
> +		user has directly configured the knobs (through e.g. some
> +		advanced control-panel for a GPU) and the knob values do not
> +		match any of the presets represented by the
> +		performance-profiles. In this case writing this file will
> +		override the modifications and restore the selected presets.
> +
> +What:		/sys/class/performance_profile/<device>/type
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Performance-profiles may be system-wide, or for a specific
> +		device (e.g. CPU / GPU). System-wide profiles are typically
> +		used on devices where where a single cooling solution is
> +		shared between all components, such as laptops and NUCs.
> +
> +		Reading this file indicates the type of the device for which
> +		the thermal-profile is being configured.
> +
> +		Valid values: "system"
> +		Reserved for future use values: "cpu", "gpu"

--=-Nk6pXwAOo7kN93a0M/eJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl97HAgACgkQq6ZWhpmF
Y3BsDA/+Iulk4C1Tf7Kebw3CCDbOVzLReZF6jWEQjSbRMArRTVZRG6IFlfvbVujn
iOCaoOmf4/PMT5B4fCeztS1ueqYWQ29O26qhwqOaT84s7ibRu8oedpB4Q+RjQgKW
wl8TCWRE3s8p2aO4GHQCAJqMSGsUXklUZVQDvF08j+tPFgMbEpe/F4R/H+kAxmNj
g4w6mNd8ooTRmrmfaQ8PdvMiSjSd1B5RfRtleT08xqEDnhbvtTxvWFRaxWD0Id34
fhrD3nWcuDmnYgspZ6+DgDQcBTo13E6bT+Hfp16frixGbwzeIO0VwKxKF07tKxFG
AIdVH/h92hSTnTAkzpXsOe/lWD+MXsx/4rx+v8ULhb75/WJqCrYDRWi7sl+q74ml
c+oEST9T8MCP+naCDKpVi+PhmObpPv1RbgwT2nnVLUm4SUk1x8rV4CtU5kOQ776A
Kjau7ljBRJq2R7sa51KVkf5Z47xyudtBF1q58mei2oKSye/lwgR2ZF6Gal1Gk6/M
pJBpasVT18UgBy7byhO2XVu0LuEGJyGo9glFWhE4RyoALmKG0+BuXkF6MUV6Fi31
lgWKGQR9PzmjdNUdM5JHYV5c8lYrx3ID4+edpz9mDt5WjTfHpbQv//yvg9py/CHW
1f18J7CtxBAYF4dZF3dN76tNFMN1Zfw8mKvxTXFOtfcTx7uRtT0=
=NyNa
-----END PGP SIGNATURE-----

--=-Nk6pXwAOo7kN93a0M/eJ--

