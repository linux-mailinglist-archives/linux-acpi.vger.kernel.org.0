Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C7129C605
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 19:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825613AbgJ0SMD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 14:12:03 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:41144 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825610AbgJ0SMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2020 14:12:01 -0400
Received: by mail-ej1-f66.google.com with SMTP id s15so3561428ejf.8;
        Tue, 27 Oct 2020 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+QwCJaXCPvUM/NJPq7e7lq/Xt5tTU8EStNpjKh1NUA=;
        b=hQCVs6p0LKbTCY7DsTZRnffqeCThDRKsG5kMgr17NA+33i+s71KRCBQePPTg2SjNFd
         C8Nr3swnguyyrqutB7zZZxrDDCJjC+1IwRYSJ3lTc3mW9KDS5rvaaG9mdnH+Gn+9ddkA
         6VepBD8lN6lWuz+UHmhNquWZlPMwH3kdq/lXqxhGWw4ydd70+iWmZrDsxLJ+IH62ztPl
         F232IhDGaraBW4IQNckvHZQu1+I7bVrea/YplgyLNVDKjtSaovQzQG6adBnHTqI3odgK
         SFmhcVqccWA0ZYpAskg4cSEf3RAmGsfgEEOB67JgAiK6ZwZR/t/wpfqqh4bWYXl5YBeM
         1aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+QwCJaXCPvUM/NJPq7e7lq/Xt5tTU8EStNpjKh1NUA=;
        b=YW+eda6CEZRraqk8ytQp1Mpz5A6ZY4ulohRx3KEd8htkgosIrrRb0god7zdQtahS8h
         KB8oDL9omkw2AIm9gRADXS5a8S+kIn1S2ftZdarjROj8nUJl+Qi224m4d6/OLPlocvUS
         4HyrLZXtGNfyhTfMD7+61bC4r/JgmrYpmUbfY0T/WdA3KWAybGmsYRlSa1+K9xV4FZ9A
         Qc/gV/gr2h6xJekNygjm50XgSCYqh1yfHwrZEqSDUZ/pcxY1rJCpRRK0E7MVE5r9KQAY
         8LW1T660AC7MbjQIvIdXFWexd9IaeNyvTP33bbJUzeWPxv6qgVZ+RAhxsEeWVqJfzoq/
         3aoQ==
X-Gm-Message-State: AOAM531zuEdyx2u1NA/GDuxiFlB+YrGEc9J10LPtaMW4lf8NDWeoKUnd
        8xx4x+lp5Qb9qxzkDmLFu2Y=
X-Google-Smtp-Source: ABdhPJweJPF6eEu3UsJ7mwptZ0e/+bndw18/+QzcId2TT5lSkFzF+bGSph4EwFUdqwBV1XJg0WZLjQ==
X-Received: by 2002:a17:906:e103:: with SMTP id gj3mr3564877ejb.442.1603822318747;
        Tue, 27 Oct 2020 11:11:58 -0700 (PDT)
Received: from pce.localnet (host-95-249-217-124.retail.telecomitalia.it. [95.249.217.124])
        by smtp.gmail.com with ESMTPSA id g8sm1472472ejp.73.2020.10.27.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:11:58 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
To:     markpearson@lenovo.com, Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, hadess@hadess.net, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Tue, 27 Oct 2020 19:11:55 +0100
Message-ID: <2177500.ElGaqSPkdT@pce>
In-Reply-To: <20201027164219.868839-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com> <20201027164219.868839-1-markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi to all,

In data marted=EC 27 ottobre 2020 17:42:19 CET, Mark Pearson ha scritto:
> From: Hans de Goede <hdegoede@redhat.com>
>=20
> On modern systems the platform performance, temperature, fan and other
> hardware related characteristics are often dynamically configurable. The
> profile is often automatically adjusted to the load by somei
> automatic-mechanism (which may very well live outside the kernel).
>=20
> These auto platform-adjustment mechanisms often can be configured with
> one of several 'platform-profiles', with either a bias towards low-power
> consumption or towards performance (and higher power consumption and
> thermals).
>=20
> Introduce a new platform_profile sysfs API which offers a generic API for
> selecting the performance-profile of these automatic-mechanisms.
>=20
> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in V1:
>  - Moved from RFC to proposed patch
>  - Added cool profile as requested
>  - removed extra-profiles as no longer relevant
>=20
>  .../ABI/testing/sysfs-platform_profile        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile
> b/Documentation/ABI/testing/sysfs-platform_profile new file mode 100644
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
> +Specifically when selecting a high-performance profile the actual achiev=
ed
> +performance may be limited by various factors such as: the heat generated
> +by other components, room temperature, free air flow at the bottom of a
> +laptop, etc. It is explicitly NOT a goal of this API to let userspace kn=
ow
> +about any sub-optimal conditions which are impeding reaching the request=
ed
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe platform-profiles
> +this API uses strings to describe the various profiles. To make sure that
> +userspace gets a consistent experience when using this API this API
> +document defines a fixed set of profile-names. Drivers *must* map their
> +internal profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new
> profile-name +may be added. Drivers which wish to introduce new
> profile-names must: +1. Have very good reasons to do so.
> +2. Add the new profile-name to this document, so that future drivers whi=
ch
> also +   have a similar problem can use the same name.
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
> +		cool:			Emphasises cooler=20
operation
> +		quiet:			Emphasises quieter=20
operation
> +		balanced:		Balance between low power=20
consumption
> +					and performance
> +		performance:		Emphasises performance=20
(and may lead to
> +					higher temperatures and=20
fan speeds)
> +
> +		Userspace may expect drivers to offer at least several of=20
these
> +		standard profile-names.
> +
> +What:		/sys/firmware/acpi/platform_profile
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives the current selected profile for=20
this
> +		device. Writing this file with one of the strings from
> +		available_profiles changes the profile to the new value.
> --
> 2.28.0

=46rom my perspective now is perfect, thanks to all for the work.

Regards
Elia



