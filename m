Return-Path: <linux-acpi+bounces-21492-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHUZMQbQqmnVXQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21492-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:00:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944542213A5
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F1C31E36C4
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08647390209;
	Fri,  6 Mar 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A03hPHiJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DC38F654
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801382; cv=none; b=anpthRfedjbC4vTGz+ncIsMxqLp1e3AENyhrzduFSBOV7m8pMzf1bFJ3bCMEBSPiExQSdZkAbHeHTUAScOBKO1dwG4rEzXHzIxTOqjmjapRtiW9yo3Gr9Kpljeg4Ohja0xrC5tyntLqqWo/KthEK4QwQF53zg3XgXv1HeBIO4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801382; c=relaxed/simple;
	bh=Fh+NyZlau2OdSQ/JKx9wPVCt/2AfUUmAUxF4YrxlwOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcSMU9hiAkqiU6SE2nnO+nHsRDl6DnsXUkqVw5nhWabG9OPx+aVi/3Qtwv2jcsTUlIxK1lIyoxFXZrQ7DBEN/NKBpQ6pNETaUBruws6mk5MXA8hHkUIwd2tQ81lw9TTWu1TJVMw5kJY7ZltDFTeSNF4+MHQ+wvmgEkNHKbDK3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A03hPHiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B152C2BC87
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772801382;
	bh=Fh+NyZlau2OdSQ/JKx9wPVCt/2AfUUmAUxF4YrxlwOs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A03hPHiJqHYOMYWJaGW+9GgNts7Id8nyZd997ggw5zBwfxIu3ebI8QEA3djxNiWig
	 EYO0JMn+Kz99xJmgUTFhBfGpetMsdQ71lkbKejyMsyrE5ON4QbtlKenbyiFFxeUrFY
	 WUGVQzyeIBycBOjlTSKJw+pvjVBwaGjDIwL4bCs107H8YRvtBSN+N+rcAdfmutFpQ9
	 uFnfM+ow9cxASHGicrPOvUM6LB7z0BT+5A76HwF4USD+E/0wIEgSPf3uSJ7TVtElPW
	 5P1Agz1f37wOb6DwKRXe/hpfZv4PYyEeWUF/vhAc1+GulJjZYOAk6XsBEAgd2TtCwE
	 C7NULaFRfcPMA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40efc77933fso2813011fac.3
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 04:49:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw0RkKOWbSvsYtD40t/okxWFDJe68yWNDVjvi10Ek5d9MaLx9nQ8OaLcObMZR3IT/OYYA96RjBUh04@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/LbJ3IxJkDuJDg8zZm2xwLVBxoeR354q3KkS6yflPiPuPHVI
	hRMYV2P8jlPLzPHo5hfXA5wnwZZh08JYSgReg/muhpf/yofjiuoYdGQBCtMWumOEhWamahL/hN4
	6VgR0Znak1SNkViitiUs+v5UgK1QSnO8=
X-Received: by 2002:a05:6871:783:b0:3e8:5127:e75b with SMTP id
 586e51a60fabf-416e42a565fmr1215531fac.30.1772801381700; Fri, 06 Mar 2026
 04:49:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4505861.ejJDZkT8p0@rafael.j.wysocki> <2787819.X9hSmTKtgW@rafael.j.wysocki>
 <ba409fad-7b2e-6fb1-eeee-8d9cacf4cb74@linux.intel.com>
In-Reply-To: <ba409fad-7b2e-6fb1-eeee-8d9cacf4cb74@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 13:49:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jKwerODDUO1YB1rvyWe65RNUcB4kOdoEn5Ced=n70VxQ@mail.gmail.com>
X-Gm-Features: AaiRm53acXR3cVXZ-K6nItG1yCmOj6dnDpCyj2HRDbgUvCO4DHhrgFDpuDjvGQ0
Message-ID: <CAJZ5v0jKwerODDUO1YB1rvyWe65RNUcB4kOdoEn5Ced=n70VxQ@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] ACPI: AC: Define ACPI_AC_CLASS in one place
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 944542213A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[rafael.j.wysocki.intel.com:query timed out];
	TAGGED_FROM(0.00)[bounces-21492-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 1:44=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 5 Mar 2026, Rafael J. Wysocki wrote:
>
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The ACPI_AC_CLASS symbol is defined in several places in the same way
> > which is rather unfortunate.
> >
> > Instead, define it in one common header file (acpi_bus.h) that is
> > already included by all of its users.
>
> It's a bit misleading to say it like that as acpi_bus.h is included only
> through another include (at least acpi/acpi.h) for most of the
> cases.

Well, I've cut a corner here. :-)

I can say "that will cause it to be accessible to all of its users" instead=
.

> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks!

> --
>  i.
>
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/ac.c                         |    1 -
> >  drivers/acpi/sbs.c                        |    1 -
> >  drivers/gpu/drm/amd/include/amd_acpi.h    |    2 --
> >  drivers/gpu/drm/radeon/radeon_acpi.c      |    2 --
> >  drivers/platform/x86/hp/hp-wmi.c          |    2 --
> >  drivers/platform/x86/lenovo/wmi-capdata.c |    1 -
> >  include/acpi/acpi_bus.h                   |    2 ++
> >  7 files changed, 2 insertions(+), 9 deletions(-)
> >
> > --- a/drivers/acpi/ac.c
> > +++ b/drivers/acpi/ac.c
> > @@ -21,7 +21,6 @@
> >  #include <linux/acpi.h>
> >  #include <acpi/battery.h>
> >
> > -#define ACPI_AC_CLASS                        "ac_adapter"
> >  #define ACPI_AC_FILE_STATE           "state"
> >  #define ACPI_AC_NOTIFY_STATUS                0x80
> >  #define ACPI_AC_STATUS_OFFLINE               0x00
> > --- a/drivers/acpi/sbs.c
> > +++ b/drivers/acpi/sbs.c
> > @@ -26,7 +26,6 @@
> >
> >  #include "sbshc.h"
> >
> > -#define ACPI_AC_CLASS                        "ac_adapter"
> >  #define ACPI_SBS_DEVICE_NAME         "Smart Battery System"
> >  #define ACPI_BATTERY_DIR_NAME                "BAT%i"
> >  #define ACPI_AC_DIR_NAME             "AC0"
> > --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> > +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> > @@ -26,8 +26,6 @@
> >
> >  #include <linux/types.h>
> >
> > -#define ACPI_AC_CLASS           "ac_adapter"
> > -
> >  struct atif_verify_interface {
> >       u16 size;               /* structure size in bytes (includes size=
 field) */
> >       u16 version;            /* version */
> > --- a/drivers/gpu/drm/radeon/radeon_acpi.c
> > +++ b/drivers/gpu/drm/radeon/radeon_acpi.c
> > @@ -44,8 +44,6 @@ bool radeon_atpx_dgpu_req_power_for_disp
> >  static inline bool radeon_atpx_dgpu_req_power_for_displays(void) { ret=
urn false; }
> >  #endif
> >
> > -#define ACPI_AC_CLASS           "ac_adapter"
> > -
> >  struct atif_verify_interface {
> >       u16 size;               /* structure size in bytes (includes size=
 field) */
> >       u16 version;            /* version */
> > --- a/drivers/platform/x86/hp/hp-wmi.c
> > +++ b/drivers/platform/x86/hp/hp-wmi.c
> > @@ -58,8 +58,6 @@ enum hp_ec_offsets {
> >  #define HP_POWER_LIMIT_DEFAULT        0x00
> >  #define HP_POWER_LIMIT_NO_CHANGE 0xFF
> >
> > -#define ACPI_AC_CLASS "ac_adapter"
> > -
> >  #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use wh=
en zero insize is required
> >
> >  enum hp_thermal_profile_omen_v0 {
> > --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> > +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> > @@ -53,7 +53,6 @@
> >  #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE=
018154"
> >  #define LENOVO_FAN_TEST_DATA_GUID "B642801B-3D21-45DE-90AE-6E86F164FB2=
1"
> >
> > -#define ACPI_AC_CLASS "ac_adapter"
> >  #define ACPI_AC_NOTIFY_STATUS 0x80
> >
> >  #define LWMI_FEATURE_ID_FAN_TEST 0x05
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -613,6 +613,8 @@ struct acpi_bus_event {
> >       u32 data;
> >  };
> >
> > +#define ACPI_AC_CLASS        "ac_adapter"
> > +
> >  extern struct kobject *acpi_kobj;
> >  extern int acpi_bus_generate_netlink_event(const char*, const char*, u=
8, int);
> >  void acpi_bus_private_data_handler(acpi_handle, void *);

