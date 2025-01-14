Return-Path: <linux-acpi+bounces-10636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EC0A10DB8
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C984D1886BAB
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D71D47BB;
	Tue, 14 Jan 2025 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCqFYp99"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9714A609;
	Tue, 14 Jan 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875654; cv=none; b=svWPXGKv3S+hp/iQqu3nC0a8/uQrNZjcEn7ZOV0naWRFD7ME5rUQjBbsRoaDfTftmnxXAUJCmWZjQ3Ls4DjIeCGOB9uKqPvIl5fakirLeLWXnYgoU5B6VTvhez/325c901rsiXYnnTDJMxa/Gg83Hzyf/IFIF3lFDOc5vEG/TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875654; c=relaxed/simple;
	bh=CnEbcuQM23cewAOxXRn0fBKrOtRkCHRleBdpOu2SFFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK0SWvftye3uHQuP2aW02j+1RIYLaejKJ3GPKrdNqXnFHPYKcHdklxSDAPCO3gDiVdEmTqrZ6qDZ+U1m3HkhBbiVGNRsUwN31/UpxwKiECGYonPmNU3vtV++55rSqWG9O7jNS+t5E6dexuO3felmwxoyRRXCFtDxBkA6w+IZaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCqFYp99; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afe2f6cecdso3285200137.1;
        Tue, 14 Jan 2025 09:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736875650; x=1737480450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X3goD0eRnq9bX+x6uQW0zjC9LaqDjotChcZ7UsbZxrg=;
        b=JCqFYp99wxGivnfzLzB196lERGPQGEjh77nKzvb7Ooy3RNa9GODdJUakQYmL3Ts+TP
         08cPIAH12Lp9LfN73lGUgyMRXfA72Gh7Upf0Y9LzRYS5Dl3PlIKNPgWMYgg5rKSIOD9V
         cOoIoBvhHWCeYIHBeI/RgqeGTO6VpUKCj4Cm1Avul02v8yEj4H1npVYgdeUlwft+8x2f
         k8QQMV5H/i9f/KwTZUIwWM+Abi7Pd/lhyp3cvkGhbyWxyqX1XvJusNIGSwgOb/JUUqji
         7tlhyXYBJMQ9u/M5piRHyez9fdudeMOk0lhANXZiRwA4ERtQlIVO6uzcc8xIhRcEdrjW
         i/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736875650; x=1737480450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3goD0eRnq9bX+x6uQW0zjC9LaqDjotChcZ7UsbZxrg=;
        b=JUGnhJEpSyMEBmUBFOdvM7ciCGpewLGpvzAjikzzT1RBVkmS9vKLjIVdD0sYGIkh58
         rSwNPDy4p8TfaZ3Q+Qr6FB/iU3icLPD4DUwbuWXHkS/uppCOjpfaDSoeouQrIPQRrnxn
         AhPFHr1Hw9R+RRg83PeJoS3sZ6ottCOBsPCBl9fdRmTH5gXgRy4sxpxU/daJbYDUqaSP
         afM3JnzKmow1HBVV4J7akbGLk6Qe4xD7rhREy1PGdzFtLoa9ac0NuqVqED8Uc9GvYm91
         Ih5yZFa0IXvGTohBMkXPsRS5RuOI1zn3vbkAwcUWL+jnbm5lbpaUg1/eSatKbSyAFoqq
         aEZw==
X-Forwarded-Encrypted: i=1; AJvYcCVt4aDxFGhZYljMJfBFqY/uXepH2cjhU2WYSLkEsu1FHH7XVlrRzlj3moQ0s3foaugFwtz1CI4QZFxBFcbJ@vger.kernel.org, AJvYcCXj+9a9Akg6ZNx4RNpYmIiYBB/I7IIC5FJoHm43bDOH3Mw8Pqkg83sJL9AMoYOA7vaf2p5FVBfJhrKp@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkQzNfnfuiuRxd8YD8AaC+kd7sN9mKkQghvALoGe+v6+MQ4qR
	/FB+f0s9rcCLbHz3OBcSfPAEMRFegwD+iF0/g6hbLwyuuN1Z+BgY
X-Gm-Gg: ASbGncuk3a/jqyuKiluiitjVf1GEIedQ3lktv2DWVW9MeCK7O6xATwx7/w8C2HXXKJ1
	+Jyr6rQEnpOKc58TDkJJv2YMvZJNYvTZ6bpKLhe1LrslwEbpmmMJjj/zJ37rrf6oR4jQ/YG3iU6
	0dYca1s+U/W1t8V7cRjPGk6Mzv0AH1tT1TNV8c0kftlKVEsQOgoaZW8bhTqMWQFZ+Eu+yGuVDY8
	q5CsZ9eRh66KA3uPjNqmhGtj/Lo91jwOAqVuKb57u59vzH4ULhLgQ==
X-Google-Smtp-Source: AGHT+IGTlZ9ixw3vuDdV84ktQEMiQLOkkiJfcTwKVFzEgikBZGzAZc0BTtKSsskWn2pzCSr8xup2tA==
X-Received: by 2002:a67:e451:0:b0:4b5:b20d:9613 with SMTP id ada2fe7eead31-4b5b20d96d5mr15962194137.7.1736875649524;
        Tue, 14 Jan 2025 09:27:29 -0800 (PST)
Received: from alphacentauri ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86231362217sm5327657241.12.2025.01.14.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:27:29 -0800 (PST)
Date: Tue, 14 Jan 2025 12:27:25 -0500
From: Kurt Borja <kuurtb@gmail.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
	Ike Panhc <ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Alexis Belmonte <alexbelm48@gmail.com>, 
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
	ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 18/18] ACPI: platform_profile: Add documentation
Message-ID: <rsuje6dgxr7kb2w3creu5vvn23xrhhfoczb3m3ug4hkxha3xxy@x5xot73enmwa>
References: <20250114153726.11802-1-kuurtb@gmail.com>
 <20250114153726.11802-19-kuurtb@gmail.com>
 <0e10985e-2400-daee-00a9-3a6156214b3e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e10985e-2400-daee-00a9-3a6156214b3e@linux.intel.com>

On Tue, Jan 14, 2025 at 06:57:11PM +0200, Ilpo Järvinen wrote:
> On Tue, 14 Jan 2025, Kurt Borja wrote:
> 
> > Add kerneldoc and sysfs class documentation.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  .../ABI/testing/sysfs-class-platform-profile  | 44 +++++++++++++++++++
> >  drivers/acpi/platform_profile.c               | 33 ++++++++++++++
> >  include/linux/platform_profile.h              | 24 ++++++++++
> >  3 files changed, 101 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
> > new file mode 100644
> > index 000000000000..b5a3600080bc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> > @@ -0,0 +1,44 @@
> > +What:		/sys/class/platform-profile/platform-profile-X/name
> > +Date:		January 2025
> > +Description:	Name of the class device given by the driver.
> > +
> > +		RO
> > +
> > +What:		/sys/class/platform-profile/platform-profile-X/choices
> > +Date:		January 2025
> > +Description:	This file contains a space-separated list of profiles supported for this device.
> > +
> > +		Drivers must use the following standard profile-names:
> > +
> > +		====================	========================================
> > +		low-power		Low power consumption
> > +		cool			Cooler operation
> > +		quiet			Quieter operation
> > +		balanced		Balance between low power consumption
> > +					and performance
> > +		balanced-performance	Balance between performance and low
> > +					power consumption with a slight bias
> > +					towards performance
> > +		performance		High performance operation
> > +		custom			Driver defined custom profile
> > +		====================	========================================
> > +
> > +		RO
> > +
> > +What:		/sys/class/platform-profile/platform-profile-X/profile
> > +Date:		January 2025
> > +Description:	Reading this file gives the current selected profile for this
> > +		device. Writing this file with one of the strings from
> > +		platform_profile_choices changes the profile to the new value.
> > +
> > +		This file can be monitored for changes by polling for POLLPRI,
> > +		POLLPRI will be signaled on any changes, independent of those
> > +		changes coming from a userspace write; or coming from another
> > +		source such as e.g. a hotkey triggered profile change handled
> > +		either directly by the embedded-controller or fully handled
> > +		inside the kernel.
> > +
> > +		This file may also emit the string 'custom' to indicate
> > +		that the driver is using a driver defined custom profile.
> > +
> > +		RW
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> > index c44989801f8e..9caddac695b8 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -426,6 +426,10 @@ static const struct attribute_group platform_profile_group = {
> >  	.is_visible = profile_class_is_visible,
> >  };
> >  
> > +/**
> > + * platform_profile_notify - Notify class device and legacy sysfs interface
> > + * @dev: The class device
> > + */
> >  void platform_profile_notify(struct device *dev)
> >  {
> >  	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> > @@ -435,6 +439,11 @@ void platform_profile_notify(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_profile_notify);
> >  
> > +/**
> > + * platform_profile_cycle - Cycles profiles available on all registered class devices
> > + *
> > + * Return: 0 on success, -errno on failure
> > + */
> >  int platform_profile_cycle(void)
> >  {
> >  	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> > @@ -478,6 +487,15 @@ int platform_profile_cycle(void)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_profile_cycle);
> >  
> > +/**
> > + * platform_profile_register - Creates and registers a platform profile class device
> > + * @dev: Parent device
> > + * @name: Name of the class device
> > + * @drvdata: Driver data that will be attached to the class device
> > + * @ops: Platform profile's mandatory operations
> > + *
> > + * Return: pointer to the new class device on success, ERR_PTR on failure
> > + */
> >  struct device *platform_profile_register(struct device *dev, const char *name,
> >  					 void *drvdata,
> >  					 const struct platform_profile_ops *ops)
> > @@ -544,6 +562,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
> >  }
> >  EXPORT_SYMBOL_GPL(platform_profile_register);
> >  
> > +/**
> > + * platform_profile_remove - Unregisters a platform profile class device
> > + * @dev: Class device
> > + *
> > + * Return: 0
> > + */
> >  int platform_profile_remove(struct device *dev)
> >  {
> >  	struct platform_profile_handler *pprof = to_pprof_handler(dev);
> > @@ -569,6 +593,15 @@ static void devm_platform_profile_release(struct device *dev, void *res)
> >  	platform_profile_remove(*ppdev);
> >  }
> >  
> > +/**
> > + * devm_platform_profile_register - Device managed version of platform_profile_register
> > + * @dev: Parent device
> > + * @name: Name of the class device
> > + * @drvdata: Driver data that will be attached to the class device
> > + * @ops: Platform profile's mandatory operations
> > + *
> > + * Return: pointer to the new class device on success, ERR_PTR on failure
> > + */
> >  struct device *devm_platform_profile_register(struct device *dev, const char *name,
> >  					      void *drvdata,
> >  					      const struct platform_profile_ops *ops)
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> > index eea1daf85616..eb4dc85dc18c 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -28,6 +28,30 @@ enum platform_profile_option {
> >  	PLATFORM_PROFILE_LAST, /*must always be last */
> >  };
> >  
> > +/**
> > + * struct platform_profile_ops - platform profile operations
> > + * @probe:	Callback to setup choices available to the new class device.
> > + *		Parameters are:
> > + *		@drvdata: drvdata pointer passed to platform_profile_register.
> > + *		@choices: Empty choices bitmap which the driver has to manually
> > + *			  setup, by using set_bit() in bits corresponding to
> > + *			  platform_profile_option values. These values will only
> > + *			  be enforced when a new profile is selected from
> > + *			  user-space.
> > + * @profile_get: Callback that will be called when showing the current platform
> > + *		 profile.
> > + *		 Parameters are:
> > + *		 @dev: Class device.
> > + *		 @profile: Pointer to the profile which will be read from
> > + *			   user-space. Selected choices are not enforced when
> > + *			   modifying this value.
> > + * @profile_set: Callback that will be called when storing the new platform
> > + *		 profile.
> > + *		 Parameters are:
> > + *		 @dev: Class device.
> > + *		 @profile: New platform profile to be set. Guaranteed to be a
> > + *			   value selected in the @probe callback.
> 
> Does kerneldoc render this sensibly?

It does not!

That's my bad, I copied the pattern from hwmon.h which also does not
render correctly.

I'll fix it.

~ Kurt

> 
> > + */
> >  struct platform_profile_ops {
> >  	int (*probe)(void *drvdata, unsigned long *choices);
> >  	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
> > 
> 
> -- 
>  i.
> 

