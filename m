Return-Path: <linux-acpi+bounces-2276-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12780CB4C
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E72281D63
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DC3FE2E;
	Mon, 11 Dec 2023 13:45:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8288AD;
	Mon, 11 Dec 2023 05:45:08 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6da06c505ccso470126a34.1;
        Mon, 11 Dec 2023 05:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702302308; x=1702907108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuMgu00NLAwah5dEifMlDlKfcOMiONZuqYgJcIiGOM8=;
        b=i+iRV5V6qyTFUIOc4PMslxyJAy+OSs2yBAcLez0WBYLvDItzVs79T3W36VxNe0jOXw
         Xls/vjH+aqV+e/LGYQJO6C3afCf3rg6TaUNmT7BaETe4oHH3KxPnoIQGWLq6qyg7qzTt
         vOcsb1ygdjozEDkpuc73lFzisQUfqqgA0Eb7rhhYhf9v80aLtgTJyQKY60loI0r0sLQ2
         63magvwBUUm7N8BxeJ4AMnTP2AUs0Tc2bAgreEWaS74jSsQenYBooig2qkwVnaNLF4mO
         OCk6I8lpYO4QOMzp6pAVdqXgcwPi3RYDxhTD27bqL/S2h0GsUX6/yKz3RZfo3xdhA9jc
         fXbA==
X-Gm-Message-State: AOJu0Yxaubv0EP4fZ8nxcdAVhoDmk8qCBbdYfrGYtXjMBSaADU83ApgR
	dtUIMYWCU5Dnugnzq51ZbKOZQhn9mRhE4kKBIIA=
X-Google-Smtp-Source: AGHT+IGpVo/RGKXFZCViZPQ7IBpVlFW6xo6IlTjrh3Sd3P8kFOK+vhAun4TccGy7fygLfPuC+ozfhofEy7Ae0nR8fXs=
X-Received: by 2002:a05:6870:9607:b0:1fb:23ec:3318 with SMTP id
 d7-20020a056870960700b001fb23ec3318mr8409458oaq.0.1702302308012; Mon, 11 Dec
 2023 05:45:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1880915.tdWV9SEqCh@kreacher> <a317fd5b-85df-409f-96e2-8123eea6ca73@arm.com>
In-Reply-To: <a317fd5b-85df-409f-96e2-8123eea6ca73@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Dec 2023 14:44:51 +0100
Message-ID: <CAJZ5v0g3exHkX6FLsmbYUcOJHstWOfVf_QnEnm8KmqoYCYwdjA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal: core: Remove thermal zones during unregistration
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Mon, Dec 11, 2023 at 2:37=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Rafael,
>
> On 12/8/23 19:11, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This patch series adds a mechanism to guarantee that
> > thermal_zone_device_unregister() will not return until all of the activ=
e
> > references to the thermal zone device object in question have been drop=
ped
> > and it has been deleted (patch [1/3]).
> >
> > This supersedes the approach used so far in which all thermal zone sysf=
s
> > attribute callbacks check if the zone device is still registered under =
the
> > zone lock, so as to return early if that is not the case, as it means t=
hat
> > device_del() has been called for the thermal zone in question (and retu=
rned).
> > It is not necessary to do that any more after patch [1/3], so patch [2/=
3]
> > removes those checks from the code and drops zone locking that is not
> > necessary any more either.
> >
> > Patch [3/3] uses the observation that the thermal subsystem does not ne=
ed to
> > check if a thermal zone device is registered at all, because it can use=
 its
> > own data to determine whether or not the thermal zone is going away and=
 so
> > it may not be worth updating it, for example.
> >
> > Please refer to the patch changelogs for details.
> >
> > The series depends on new thermal material in linux-next, but it should=
 not
> > substantially depend on any changes that have not made it into linux-ne=
xt yet.
> >
> > Thanks!
> >
> >
> >
>
> I like the concept with completion thing for this.
> I have tired to stress test these patches with my mock
> thermal zone module load/unload and it works good.
>
> The test was doing the these bits:
> for i in $(seq 1 1000000) ; do cat
> /sys/class/thermal/thermal_zone2/trip_point_0_temp > /dev/null 2>&1 ; don=
e &
> for i in $(seq 1 10000) ; do insmod /data/selftest_ipa.ko ; rmmod
> selftest_ipa ; done &
>
> I couldn't trigger any issues in reading from this
> trip temp file in background, which should go now w/o the
> locking. I thought it would be nice test, since we have
> direct call to trips array 'tz->trips[trip_id].temperature'.
> Let me know if you think about other scenario for stress testing it.
> (I have also checked the 'temp' sysfs read, where the mutex for
> tz is used - also no issues).
>
> Feel free to add to all patches:
>
> Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!

