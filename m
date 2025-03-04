Return-Path: <linux-acpi+bounces-11789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA858A4E40B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3C48A38C6
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318BD2862B7;
	Tue,  4 Mar 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6cIJ/ic"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836032857F7;
	Tue,  4 Mar 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101887; cv=none; b=Um2n30CBOkX16uR4mWgkwlnOiqag+UvDao8qSReMmHM0YnAGp5LlrJYvJCUfgLNTvkaGfFhqGidDQCOtLuqVXJd/E4E2dLp/BxJJ6FuKZiVoihxyZhOWUid9r5JWKnw+Ov3WmIYOe8DUdFu7tloM5XcLLPqjvFA5ihK2KOx2s1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101887; c=relaxed/simple;
	bh=ABsY5XgRcgeEP6+FXmOJWUnUDTS6uiYJHqYyliIEXx4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l5sOCfPW13m5K3W/u78xRu7M9uMnU+K5mPRq+nr2WmdeIjnAS2rKRGgbm7+nrziRIUmVyTxtLQMTOwK8rQHIS4NIwf56eFKZ6KPsY4ClpRK5PGRu50nbAoWRw/Sz6iL40DpUMkvuWTboGM0MJOdnAvrB9YDZaYl1zEqNxTCVRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6cIJ/ic; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223378e2b0dso84507635ad.0;
        Tue, 04 Mar 2025 07:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741101885; x=1741706685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LbqxPGR12fcL9QYAK4wiktOpz1xvQ8QwMI4lirCtmzs=;
        b=U6cIJ/icYUWQ07l3I5e4WVoatX8sN0Z0KNf22PImlUEfV7rWzIUKaHDXlC7Knz4lGT
         OK7regS4Ug7h5VrlBh+hL/gZfQc3/kwG71F95zZwQ23v4kJCXlyZnIp/XabebFrL0S6/
         ds9KKHiE3nbl/gpa8jMvWfCP5EEOFaWdCPgh4SiOm5RyPsm/39aw9mJfsO2LHxQQoTtr
         Utfc1395gV8ZvB+7vlJdq8SGb8ab35JQY643ve+9Z53899R4TuTHwNsNNXSRMhhZpYj6
         Sbbpgd0JqdNfX+BdwMTcreTlQe5d5xN10LXDwPPmtJpQNE3ASj/5tVlECQZkEZ7+5smY
         HfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101885; x=1741706685;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbqxPGR12fcL9QYAK4wiktOpz1xvQ8QwMI4lirCtmzs=;
        b=h09HqPp9ILX3eJJQCaAa7BvG+rmiQVDMZGjABOBqNZuFWSgk2OIjMThKMZFXvHfHX3
         YMc61bwdVPIogwQdpWGm0Oh1DFGSUd79RbJyZj7S4Z5vOvh5Sv2MH+6LWVxZWCH0BzGy
         kpH649GjK6K4d9Eudll+XQT9TjYZIu2PRuB4abQtdBgXSJirxBSEX5ELJ4u/EiOBVN/1
         q7cF32Jktu+gPFRXr09jQLMspxWXB/7pguKN3xoGc8m+EV+rklNm2EECGIt/fdZvInWt
         ALhvHcFe0EqIOLnJcdZM6o2LiWMktnHb/U0zwBcw/oq3TU9D/k6cDKC8Mb8jdMzW/fEG
         46ow==
X-Forwarded-Encrypted: i=1; AJvYcCUehYcv7d/LTKaRGZgA8hP0GlLhnReJXJE22o6mBnUNyBpvgTl0ha2vq30zZ8GylVRbyKlN070kojC9PkEB@vger.kernel.org, AJvYcCUkBsSzqri1EtBiP2aG24lVZiyHpiEC4aEqCQlU4VxqtmqBQXjdTdVnsrQEheemy7Ro1L9f/fcEt6gD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1h12R+6F/NmxIgYbf9u7Kl+giNeY3VNmj3vh0apLLiZ3w12wx
	bG159epKP6qO8UyQf8eLpmfqWJ8F1htu+yyHKOMiATCs4oa6Xj24
X-Gm-Gg: ASbGncthCrfE+WzomroeJz9lX3WUp9ZrGPTWjpzRqrGAB5v1MYLpuNGVeqeac7FypkC
	SXgtc1S90ws5qKmmQrqcq10udrdRLaQBapbObA51K3M+9Y8m7/FWzAstCM7cU0dzbEgZ8bDrgOP
	OEycWsJXxq3O88xtqZfTtxUAUnflMdzITWfHW2HqkN1xUehyBiZyqn3JwKb6k0p0xOBdd239fTG
	5cGNWdwTH5XX50StJnKwgHcqeVZxKvyPyFWFN+QMrPTXTTuP4BkrKH5jhPimEbylL7BS2Ex6kfE
	w8dvSGu4trQVXBlZLvLVQSJipEqCvyOeryOsX302raH1cRVAhV2c
X-Google-Smtp-Source: AGHT+IEJkVOFKokXwRAO1g/Ggmz6uxvxks/eteYAlfwhMO6Hk77pkPer6+CJnEHd2si0nxiQ8+XeZg==
X-Received: by 2002:a05:6a20:72a8:b0:1f2:f1aa:3322 with SMTP id adf61e73a8af0-1f2f4c9c65amr31672259637.1.1741101884671;
        Tue, 04 Mar 2025 07:24:44 -0800 (PST)
Received: from ?IPv6:::1? ([2607:fb90:8f63:4381:ad2:b852:51e2:f9da])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003dcedsm11014911b3a.125.2025.03.04.07.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:24:44 -0800 (PST)
Date: Tue, 04 Mar 2025 07:24:40 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Mario Limonciello <superm1@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>
CC: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Antheas Kapenekakis <lkml@antheas.dev>,
 me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_ACPI=3A_platform=5Fprof?=
 =?US-ASCII?Q?ile=3A_Treat_quiet_and_low_power_the_same?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250304064745.1073770-2-superm1@kernel.org>
References: <20250304064745.1073770-1-superm1@kernel.org> <20250304064745.1073770-2-superm1@kernel.org>
Message-ID: <CA379804-AD18-4B93-A5D3-2BA4A799D33F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 3, 2025 10:47:45 PM PST, Mario Limonciello <superm1@kernel=2Eorg>=
 wrote:
>From: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>
>
>When two drivers don't support all the same profiles the legacy interface
>only exports the common profiles=2E
>
>This causes problems for cases where one driver uses low-power but anothe=
r
>uses quiet because the result is that neither is exported to sysfs=2E
>ion yet
>If one platform profile handler supports quiet and the other
>supports low power treat them as the same for the purpose of
>the sysfs interface=2E

Hi Mario,

I haven't tested this version yet but from an initial glance I do have som=
e concerns=2E In v1 there was handling of balanaced_perfomance, and that is=
n't present here, which would affect my in progress driver=2E This also doe=
sn't cover the cool -> low_power option (though I'm not sure where/if that =
is an actual concern in any drivers at the moment)=2E I'm concerned that if=
 we take the v2 approach that we'll eventually be aliasing a majority of th=
e profiles, further adding ambiguity on what each one actually means=2E=20

In my driver balanced_perfomance is closer to amd_pmf's performance, if sh=
own, whereas in others it might be closer to balanced=2E Since that is esse=
ntially implementation specific I currently am doubtful there is a clean un=
iversal approach to aliasing=2E

The real issue appears to me at that the enabled profiles need to be conte=
xt aware=2E Because of that I think something closer to v1 and the hidden o=
ptions method provides a better way to implement those aliases within any s=
pecific driver, allowing the maintainers to determine the "best alias" so t=
o speak=2E If we put the control into the "primary" driver of how those ali=
ases work and somehow provide context to amd_pmf of the "best match", we ca=
n then allow amd_pmf to present all options when more than one low end prof=
ile is valid, or only the matching ones if they are just aliased=2E

- Derek

>Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
>Reported-by: Antheas Kapenekakis <lkml@antheas=2Edev>
>Closes: https://lore=2Ekernel=2Eorg/platform-driver-x86/e64b771e-3255-42a=
d-9257-5b8fc6c24ac9@gmx=2Ede/T/#mc068042dd29df36c16c8af92664860fc4763974b
>Signed-off-by: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>
>---
> drivers/acpi/platform_profile=2Ec | 38 ++++++++++++++++++++++++++++++---
> 1 file changed, 35 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/acpi/platform_profile=2Ec b/drivers/acpi/platform_pr=
ofile=2Ec
>index 2ad53cc6aae53=2E=2Ed9a7cc5891734 100644
>--- a/drivers/acpi/platform_profile=2Ec
>+++ b/drivers/acpi/platform_profile=2Ec
>@@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, vo=
id *data)
>=20
> 	lockdep_assert_held(&profile_lock);
> 	handler =3D to_pprof_handler(dev);
>-	if (!test_bit(*bit, handler->choices))
>-		return -EOPNOTSUPP;
>+	if (!test_bit(*bit, handler->choices)) {
>+		switch (*bit) {
>+		case PLATFORM_PROFILE_QUIET:
>+			*bit =3D PLATFORM_PROFILE_LOW_POWER;
>+			break;
>+		case PLATFORM_PROFILE_LOW_POWER:
>+			*bit =3D PLATFORM_PROFILE_QUIET;
>+			break;
>+		default:
>+			return -EOPNOTSUPP;
>+		}
>+		if (!test_bit(*bit, handler->choices))
>+			return -EOPNOTSUPP;
>+	}
>=20
> 	return handler->ops->profile_set(dev, *bit);
> }
>@@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, vo=
id *data)
> 	handler =3D to_pprof_handler(dev);
> 	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> 		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
>-	else
>+	else {
>+		/* treat quiet and low power the same for aggregation purposes */
>+		if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
>+		    test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
>+			set_bit(PLATFORM_PROFILE_QUIET, aggregate);
>+		else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
>+			 test_bit(PLATFORM_PROFILE_QUIET, aggregate))
>+			set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
> 		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LA=
ST);
>+	}
>=20
> 	return 0;
> }
>@@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev, v=
oid *data)
> 	if (err)
> 		return err;
>=20
>+	/* treat low-power and quiet as the same */
>+	if ((*profile =3D=3D PLATFORM_PROFILE_LOW_POWER &&
>+	     val =3D=3D PLATFORM_PROFILE_QUIET) ||
>+	    (*profile =3D=3D PLATFORM_PROFILE_QUIET &&
>+	     val =3D=3D PLATFORM_PROFILE_LOW_POWER))
>+		*profile =3D val;
>+
> 	if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D val)
> 		*profile =3D PLATFORM_PROFILE_CUSTOM;
> 	else
>@@ -531,6 +558,11 @@ struct device *platform_profile_register(struct devi=
ce *dev, const char *name,
> 		dev_err(dev, "Failed to register platform_profile class device with em=
pty choices\n");
> 		return ERR_PTR(-EINVAL);
> 	}
>+	if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
>+	    test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
>+		dev_err(dev, "Failed to register platform_profile class device with bo=
th quiet and low-power\n");
>+		return ERR_PTR(-EINVAL);
>+	}
>=20
> 	guard(mutex)(&profile_lock);
>=20

- Derek

