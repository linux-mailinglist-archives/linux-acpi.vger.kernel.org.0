Return-Path: <linux-acpi+bounces-21570-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONTdAaovr2nFPQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21570-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 21:38:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F2240F1D
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 21:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 832363045013
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E144F36C0BA;
	Mon,  9 Mar 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5F7PX9m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30336BCE4
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088529; cv=none; b=nGqi8EP8eZc93ikETog+o1/OxDEw0bzrTL7Zuz+SyYRe/hVddnPa6y89quQcpcZThnGG6OFqRKSUbRqkZY+v+Td9WI8Kdz2cQR34IJmVnX/0tQJX1lM/i3dQLqFbhPIHKHcKt7Aj+NzCjd+2j0SLgG+Zv+8QRfIztW0bhpgQU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088529; c=relaxed/simple;
	bh=7G2sQp2lrcvB+OSXiDf9UTaOS5oOPYSVueiPq/QGMeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMsy9LFrKyJ2ZjFwj2Ja8L3HeXLSGmfMbuWJx14qrMRe/VQ6nmsaZSTobBjcCG6dQBzB7qBrH/Ek3Ldoxq4OMRVPzW14DmJzCi5T6gyMVrArwl5SpFK29XJQMW5ip4uc8Rzbg897VhmqsdRaqj9cAken7d00BJpfvj8bVvdGGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5F7PX9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C4FC2BCB1
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773088529;
	bh=7G2sQp2lrcvB+OSXiDf9UTaOS5oOPYSVueiPq/QGMeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G5F7PX9mVgqbR6vNwApod1CNXOL15pLbpqp8TIPBdHZjlQ2tuV8cDCQin6jIZIoGx
	 x4GyrTBTT9Yxke+FL1Jh9nZrs6Taqb0yLvWoVn7VEHcTxcQSTPeZOR790odTpr/BCp
	 b9ZoE2Ffh9TkLIQW7qlniN/2sAUX/SiqTMHjW9CkT+vnnZkV0klHrUscB26E9T3wAs
	 FVaNN6g4aBFMDebMZOQ9hqxARm/uqVgmKDM0VUPQtjKII3/0ldblIO77wIbWSvRCKP
	 mycYdE8sjmLTOFJLp/UZ0i/p0lmXa7CfMrKCV+zgPwLhYNLuNW9siLcrmdQCb4YFj3
	 AhE0HFFMzYx/w==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4671119c1c0so698388b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 13:35:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoY8O1cRHKKuJHx2a29EvqZvo8WteJIu3QoIt5sBE61fuYXvUqaUM/3bATU+HPh/tafWj4boEbyNok@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XXrgRu5BSonTbZR5cJBMOqUBxj5EQLRY6BskwoZ6ICy7PBhR
	BMRR9InabLxbeTXGshhyOOBxs/oZ13655RAwt5unxZI+AydUXZA6nl4QI+tAE3yip8V/TCdWzI6
	C18CexkFYNT9xewZMmwSv4Uy6kpPCFQ4=
X-Received: by 2002:a05:6808:c289:b0:45e:a4c0:93b1 with SMTP id
 5614622812f47-466dcb0a137mr7713741b6e.31.1773088528527; Mon, 09 Mar 2026
 13:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com> <CAJZ5v0iNdTFExoupRmwJmdykdRJa1QUJXzsb+j4M1cpn1qALig@mail.gmail.com>
 <CAJZ5v0gR+-Y=XqNXoBrUpd9HtSRqGk2cSXBgXsp5YJRsdCTMTg@mail.gmail.com>
 <5982633.DvuYhMxLoT@rafael.j.wysocki> <a0211005-30d1-4faa-83b8-b2526b4e7dea@amd.com>
In-Reply-To: <a0211005-30d1-4faa-83b8-b2526b4e7dea@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 21:35:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j6kbcW+YkSPTCdqCadDyDcP7es7EB7SvvjBQD21qmXiw@mail.gmail.com>
X-Gm-Features: AaiRm52oYC_yenzvSb30b8n2MzdmZhGgB9mnTSQYf_2QixE274yBz9J6pJjZvH8
Message-ID: <CAJZ5v0j6kbcW+YkSPTCdqCadDyDcP7es7EB7SvvjBQD21qmXiw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: video: Switch over to auxiliary bus type
To: "Nirujogi, Pratap" <pnirujog@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Du, Bin" <bin.du@amd.com>, 
	Mario Limonciello <superm1@kernel.org>, W_Armin@gmx.de, benjamin.chan@amd.com, king.li@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6F2F2240F1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,amd.com,gmx.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21570-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,amd.com:email,intel.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:24=E2=80=AFPM Nirujogi, Pratap <pnirujog@amd.com> =
wrote:
>
>
>
> On 3/9/2026 12:01 PM, Rafael J. Wysocki wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > On Monday, March 9, 2026 1:23:35 PM CET Rafael J. Wysocki wrote:
> >> On Mon, Mar 9, 2026 at 12:58=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >>>
> >>> On Mon, Mar 9, 2026 at 9:11=E2=80=AFAM Du, Bin <bin.du@amd.com> wrote=
:
> >>>>
> >>>>
> >>>>
> >>>> On 3/9/2026 11:52 AM, Nirujogi, Pratap wrote:
> >>>>>
> >>>>>
> >>>>> On 3/6/2026 7:45 AM, Mario Limonciello wrote:
> >>>>>> Caution: This message originated from an External Source. Use prop=
er
> >>>>>> caution when opening attachments, clicking links, or responding.
> >>>>>>
> >>>>>>
> >>>>>> On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
> >>>>>>> On Fri, Mar 6, 2026 at 1:35=E2=80=AFAM Mario Limonciello (AMD) (k=
ernel.org)
> >>>>>>> <superm1@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
> >>>>>>>>> Hi Rafael,
> >>>>>>>>>
> >>>>>>>>> In kernel version 7.0-rc2, the AMDISP device reports the follow=
ing
> >>>>>>>>> errors when created via mfd_add_hotplug_devices.
> >>>>>>>>>
> >>>>>>>>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: ye=
s  rom:
> >>>>>>>>> no  post: no)
> >>>>>>>>> [    5.236744] input: Video Bus as /devices/
> >>>>>>>>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/inp=
ut/
> >>>>>>>>> input21
> >>>>>>>>> [    5.236779] acpi device:14: Error installing notify handler
> >>>>>>>>> [    5.236782] acpi device:15: Error installing notify handler
> >>>>>>>>> [    5.236783] acpi device:16: Error installing notify handler
> >>>>>>>>> [    5.236784] acpi device:17: Error installing notify handler
> >>>>>>>>> [    5.236785] acpi device:18: Error installing notify handler
> >>>>>>>>> [    5.236786] acpi device:19: Error installing notify handler
> >>>>>>>>> [    5.236786] acpi device:1a: Error installing notify handler
> >>>>>>>>> [    5.236787] acpi device:1b: Error installing notify handler
> >>>>>>>>> [    5.236788] acpi device:1c: Error installing notify handler
> >>>>>>>>>
> >>>>>>>>> These failures indicate AMDISP device is incorrectly detected a=
s ACPI
> >>>>>>>>> Video device while it is not.
> >>>>>>>>>
> >>>>>>>>> The seems like a regression caused by the change that converts =
the
> >>>>>>>>> ACPI
> >>>>>>>>> video device to a platform device (commit: 02c057ddefef5).
> >>>>>>>>>
> >>>>>>>>> Issue is not observed in 6.19-rc6, and also when this change is
> >>>>>>>>> reverted
> >>>>>>>>> in 7.0-rc2.
> >>>>>>>>>
> >>>>>>>>> I really appreciate your inputs on addressing this issue and
> >>>>>>>>> helping us
> >>>>>>>>> make progress on 7.0 rc2.
> >>>>>>>>>
> >>>>>>>>> Steps followed to reproduce the issue:
> >>>>>>>>>
> >>>>>>>>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
> >>>>>>>>> 2. Add NULL check for =E2=80=9Cdev->type=E2=80=9D in isp_genpd_=
add_device() [2] (to
> >>>>>>>>> avoid kernel panic found in v7.0-rc2)
> >>>>>>>>> 3. Build kernel with:
> >>>>>>>>>        - CONFIG_AMD_ISP_PLATFORM=3Dy
> >>>>>>>>>        - CONFIG_VIDEO_AMD_ISP4_CAPTURE=3Dm
> >>>>>>>>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1=
a)
> >>>>>>>>> 5. Boot system to see the failures
> >>>>>>>>>
> >>>>>>>>> [1] https://lore.kernel.org/all/20260302073020.148277-1-
> >>>>>>>>> Bin.Du@amd.com/
> >>>>>>>>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/d=
rm/amd/
> >>>>>>>>> amdgpu/isp_v4_1_1.c#L132
> >>>>>>>>>
> >>>>>>>>> Thanks,
> >>>>>>>>> Pratap
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> It's a bit weird to see it even probe in this path in the first =
place.
> >>>>>>>> acpi_video_bus_probe() getting called with the mfd device doesn'=
t seem
> >>>>>>>> right to me.
> >>>>>>>>
> >>>>>>>> I wonder if it's because ISP is an MFD device of GPU (and thus L=
NXVIDEO
> >>>>>>>> ends up matching).
> >>>>>>>>
> >>>>>>>> Would a sensible solution be to reject mfd device types in
> >>>>>>>> acpi_video_bus_probe()?
> >>>>>>>
> >>>>>>> Every platform device with LNXVIDEO in the device ID list will be
> >>>>>>> matched and so probed.
> >>>>>>>
> >>>>>>> I'm wondering how those devices get that ID though.
> >>>>>>
> >>>>>> Yeah me too.  I was surprised an MFD device got it.
> >>>>>>
> >>>>>> Pratap - can you figure this out before we go too far in this path=
?
> >>>>>>
> >>>>> yes, MFD child devices in this case have the device ID as that of p=
arent
> >>>>> (GPU) i.e. LNXVIDEO. Its because when no acpi_match is specified, t=
he
> >>>>> MFD child devices are inheriting the parent's ACPI companion device=
 and
> >>>>> this is resulting in having the same parent's ACPI device ID.
> >>>>>
> >>>>> device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> >>>>> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.=
c#L91
> >>>>>
> >>>>>> If they really shouldn't have LNXVIDEO fixing that may be a better
> >>>>>> solution.
> >>>>>>
> >>>>> AMD ISP related MFD devices are using the same LNXVIDEO device ID e=
ven
> >>>>> on 6.19-rc4, no issues observed earlier. I can confirm automatic AM=
D ISP
> >>>>> device probe works and also camera works on 7.0-rc2 if I avoid
> >>>>> inheriting ACPI companion of the parent (GPU) in the mfd-core.c
> >>>>>
> >>>>> // device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
> >>>>> https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.=
c#L91
> >>>>>
> >>>>> But why this is an issue on 7.0-rc2 while it works on 6.19-rc4 need=
s to
> >>>>> be root caused.
> >>>>>
> >>>>
> >>>> Possible cause may be.
> >>>> 1. On 6.x (without commit 02c057ddefef5), the ACPI video driver was
> >>>> registered as an acpi_driver (static struct acpi_driver acpi_video_b=
us)
> >>>> ,  it lives on the ACPI bus (acpi_bus_type). It only binds to struct
> >>>> acpi_device objects in the ACPI namespace. MFD children of GFX
> >>>> (amd_isp_capture, amd_isp_i2c_designware, amdisp-pinctrl) are platfo=
rm
> >>>> devices on the platform bus, they are completely invisible to
> >>>> acpi_driver, so there is no chance of the ACPI video driver matching=
 an
> >>>> MFD child.
> >>>> 2. On 7.0 (with commit 02c057ddefef5), the ACPI video driver was
> >>>> converted to a platform_driver (static struct platform_driver
> >>>> acpi_video_bus), it lives on the platform bus. When the kernel regis=
ters
> >>>> a new platform device, it checks ALL registered platform drivers to =
see
> >>>> if any match. The matching logic for acpi_match_table works like thi=
s:
> >>>> - Get the platform device's ACPI companion (ACPI_COMPANION(dev))
> >>>> - Check if the companion's HID/CID matches any entry in acpi_match_t=
able
> >>>> - If yes, the driver probes the device
> >>>
> >>> It does, but then the probe fails.  This is the problem that has been
> >>> reported to start with.
> >>
> >> I guess I know what's going on.
> >>
> >> Every device that shares an ACPI companion with the ACPI video bus
> >> device advertises itself as "LNXVIDEO", so udev looks for a module
> >> matching that device ID and since the ACPI video driver is loaded, it
> >> will not attempt to load anything else.
> >>
> >> It may be viable to use an auxiliary device for ACPI video bus device
> >> representation, let me have a look at that.
> >
> > So appended is a patch that works for me.
> >
> > Please test it and let me know if it helps.
> >
> Thanks Rafael. With your latest patch, acpi_video_bus_probe() is no
> longer called for ISP MFD child devices, which is good.
>
> Tested-by: pratap.nirujogi@amd.com

Thanks for the confirmation!

> However, automatic modprobe of ISP MFD devices is still an issue. This
> requires additional changes outside acpi driver (either in amdgpu or
> mfd-core) to fix it. We'll submit a separate patch to address this issue.

If you need help with this, please let me know.


> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v1] ACPI: video: Switch over to auxiliary bus type
> >
> > Commit 02c057ddefef ("ACPI: video: Convert the driver to a platform one=
")
> > switched over the ACPI video bus driver from an ACPI driver to a platfo=
rm
> > driver, but that change introduced an unwanted and unexpected side effe=
ct.
> > Namely, on some systems, the ACPI device object of the ACPI video bus
> > device is an ACPI companion of multiple platform devices and, after
> > adding video_device_ids[] as an acpi_match_table to the acpi_video_bus
> > platform driver, all of those devices started to match that driver and
> > its probe callback is invoked for all of them (it fails, but it leaves
> > confusing message in the log).  Moreover, the MODULE_DEVICE_TABLE()
> > of the ACPI video driver module matches all of the devices sharing the
> > ACPI companion with the ACPI video bus device, so registering them does
> > not cause any other modules to be loaded, so they are only probed
> > against the ACPI video bus platform driver.
> >
> > To address this, make the core ACPI device enumeration code create an
> > auxiliary device for the ACPI video bus device object instead of a
> > platform device and switch over the ACPI video bus driver (once again)
> > to an auxiliary driver.
> >
> > Auxiliary driver generally is a better match for ACPI video bus than
> > platform driver, among other things because the ACPI video bus device
> > does not require any resources to be allocated for it during
> > enumeration.  It also allows the ACPI video bus driver to stop abusing
> > device matching based on ACPI device IDs and it allows a special case
> > to be dropped from acpi_create_platform_device() because that function
> > need not worry about the ACPI video bus device any more.
> >
> > Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one=
")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/acpi_platform.c |    2 -
> >   drivers/acpi/acpi_video.c    |   45 ++++++++++++++++++++-------------=
--------
> >   drivers/acpi/scan.c          |   47 +++++++++++++++++++++++++++++++++=
++++++++++
> >   3 files changed, 70 insertions(+), 24 deletions(-)
> >
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -135,7 +135,7 @@ struct platform_device *acpi_create_plat
> >                  }
> >          }
> >
> > -       if (adev->device_type =3D=3D ACPI_BUS_TYPE_DEVICE && !adev->pnp=
.type.backlight) {
> > +       if (adev->device_type =3D=3D ACPI_BUS_TYPE_DEVICE) {
> >                  LIST_HEAD(resource_list);
> >
> >                  count =3D acpi_dev_get_resources(adev, &resource_list,=
 NULL, NULL);
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -9,6 +9,7 @@
> >
> >   #define pr_fmt(fmt) "ACPI: video: " fmt
> >
> > +#include <linux/auxiliary_bus.h>
> >   #include <linux/kernel.h>
> >   #include <linux/module.h>
> >   #include <linux/init.h>
> > @@ -21,7 +22,6 @@
> >   #include <linux/sort.h>
> >   #include <linux/pci.h>
> >   #include <linux/pci_ids.h>
> > -#include <linux/platform_device.h>
> >   #include <linux/slab.h>
> >   #include <linux/dmi.h>
> >   #include <linux/suspend.h>
> > @@ -77,8 +77,9 @@ static int register_count;
> >   static DEFINE_MUTEX(register_count_mutex);
> >   static DEFINE_MUTEX(video_list_lock);
> >   static LIST_HEAD(video_bus_head);
> > -static int acpi_video_bus_probe(struct platform_device *pdev);
> > -static void acpi_video_bus_remove(struct platform_device *pdev);
> > +static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
> > +                               const struct auxiliary_device_id *id);
> > +static void acpi_video_bus_remove(struct auxiliary_device *aux);
> >   static void acpi_video_bus_notify(acpi_handle handle, u32 event, void=
 *data);
> >
> >   /*
> > @@ -93,19 +94,16 @@ enum acpi_video_level_idx {
> >          ACPI_VIDEO_FIRST_LEVEL,         /* actual supported levels beg=
in here */
> >   };
> >
> > -static const struct acpi_device_id video_device_ids[] =3D {
> > -       {ACPI_VIDEO_HID, 0},
> > -       {"", 0},
> > +static const struct auxiliary_device_id video_bus_auxiliary_id_table[]=
 =3D {
> > +       { .name =3D "acpi.video_bus" },
> > +       {},
> >   };
> > -MODULE_DEVICE_TABLE(acpi, video_device_ids);
> > +MODULE_DEVICE_TABLE(auxiliary, video_bus_auxiliary_id_table);
> >
> > -static struct platform_driver acpi_video_bus =3D {
> > +static struct auxiliary_driver acpi_video_bus =3D {
> >          .probe =3D acpi_video_bus_probe,
> >          .remove =3D acpi_video_bus_remove,
> > -       .driver =3D {
> > -               .name =3D "acpi-video",
> > -               .acpi_match_table =3D video_device_ids,
> > -       },
> > +       .id_table =3D video_bus_auxiliary_id_table,
> >   };
> >
> >   struct acpi_video_bus_flags {
> > @@ -1885,7 +1883,7 @@ static void acpi_video_dev_add_notify_ha
> >   }
> >
> >   static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *v=
ideo,
> > -                                            struct platform_device *pd=
ev)
> > +                                            struct device *parent)
> >   {
> >          struct input_dev *input;
> >          struct acpi_video_device *dev;
> > @@ -1908,7 +1906,7 @@ static int acpi_video_bus_add_notify_han
> >          input->phys =3D video->phys;
> >          input->id.bustype =3D BUS_HOST;
> >          input->id.product =3D 0x06;
> > -       input->dev.parent =3D &pdev->dev;
> > +       input->dev.parent =3D parent;
> >          input->evbit[0] =3D BIT(EV_KEY);
> >          set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
> >          set_bit(KEY_VIDEO_NEXT, input->keybit);
> > @@ -1980,9 +1978,10 @@ static int acpi_video_bus_put_devices(st
> >
> >   static int instance;
> >
> > -static int acpi_video_bus_probe(struct platform_device *pdev)
> > +static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
> > +                               const struct auxiliary_device_id *id_un=
used)
> >   {
> > -       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> > +       struct acpi_device *device =3D ACPI_COMPANION(&aux_dev->dev);
> >          struct acpi_video_bus *video;
> >          bool auto_detect;
> >          int error;
> > @@ -2019,7 +2018,7 @@ static int acpi_video_bus_probe(struct p
> >                  instance++;
> >          }
> >
> > -       platform_set_drvdata(pdev, video);
> > +       auxiliary_set_drvdata(aux_dev, video);
> >
> >          video->device =3D device;
> >          strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> > @@ -2068,7 +2067,7 @@ static int acpi_video_bus_probe(struct p
> >              !auto_detect)
> >                  acpi_video_bus_register_backlight(video);
> >
> > -       error =3D acpi_video_bus_add_notify_handler(video, pdev);
> > +       error =3D acpi_video_bus_add_notify_handler(video, &aux_dev->de=
v);
> >          if (error)
> >                  goto err_del;
> >
> > @@ -2096,10 +2095,10 @@ err_free_video:
> >          return error;
> >   }
> >
> > -static void acpi_video_bus_remove(struct platform_device *pdev)
> > +static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
> >   {
> > -       struct acpi_video_bus *video =3D platform_get_drvdata(pdev);
> > -       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> > +       struct acpi_video_bus *video =3D auxiliary_get_drvdata(aux_dev)=
;
> > +       struct acpi_device *device =3D ACPI_COMPANION(&aux_dev->dev);
> >
> >          acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> >                                         acpi_video_bus_notify);
> > @@ -2163,7 +2162,7 @@ int acpi_video_register(void)
> >
> >          dmi_check_system(video_dmi_table);
> >
> > -       ret =3D platform_driver_register(&acpi_video_bus);
> > +       ret =3D auxiliary_driver_register(&acpi_video_bus);
> >          if (ret)
> >                  goto leave;
> >
> > @@ -2183,7 +2182,7 @@ void acpi_video_unregister(void)
> >   {
> >          mutex_lock(&register_count_mutex);
> >          if (register_count) {
> > -               platform_driver_unregister(&acpi_video_bus);
> > +               auxiliary_driver_unregister(&acpi_video_bus);
> >                  register_count =3D 0;
> >                  may_report_brightness_keys =3D false;
> >          }
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -6,6 +6,7 @@
> >   #define pr_fmt(fmt) "ACPI: " fmt
> >
> >   #include <linux/async.h>
> > +#include <linux/auxiliary_bus.h>
> >   #include <linux/module.h>
> >   #include <linux/init.h>
> >   #include <linux/slab.h>
> > @@ -2192,6 +2193,46 @@ static acpi_status acpi_bus_check_add_2(
> >          return acpi_bus_check_add(handle, false, (struct acpi_device *=
*)ret_p);
> >   }
> >
> > +static void acpi_video_bus_device_release(struct device *dev)
> > +{
> > +       struct auxiliary_device *aux_dev =3D to_auxiliary_dev(dev);
> > +
> > +       kfree(aux_dev);
> > +}
> > +
> > +static void acpi_create_video_bus_device(struct acpi_device *adev,
> > +                                        struct acpi_device *parent)
> > +{
> > +       struct auxiliary_device *aux_dev;
> > +       static unsigned int aux_dev_id;
> > +
> > +       aux_dev =3D kzalloc_obj(*aux_dev);
> > +       if (!aux_dev)
> > +               return;
> > +
> > +       aux_dev->id =3D aux_dev_id++;
> > +       aux_dev->name =3D "video_bus";
> > +       aux_dev->dev.parent =3D acpi_get_first_physical_node(parent);
> > +       if (!aux_dev->dev.parent)
> > +               goto err;
> > +
> > +       aux_dev->dev.release =3D acpi_video_bus_device_release;
> > +
> > +       if (auxiliary_device_init(aux_dev))
> > +               goto err;
> > +
> > +       ACPI_COMPANION_SET(&aux_dev->dev, adev);
> > +       if (__auxiliary_device_add(aux_dev, "acpi")) {
> > +               auxiliary_device_uninit(aux_dev);
> > +               goto err;
> > +       }
> > +
> > +       return;
> > +
> > +err:
> > +       kfree(aux_dev);
> > +}
> > +
> >   struct acpi_scan_system_dev {
> >          struct list_head node;
> >          struct acpi_device *adev;
> > @@ -2229,6 +2270,12 @@ static void acpi_default_enumeration(str
> >                          sd->adev =3D device;
> >                          list_add_tail(&sd->node, &acpi_scan_system_dev=
_list);
> >                  }
> > +       } else if (device->pnp.type.backlight) {
> > +               struct acpi_device *parent;
> > +
> > +               parent =3D acpi_dev_parent(device);
> > +               if (parent)
> > +                       acpi_create_video_bus_device(device, parent);
> >          } else {
> >                  /* For a regular device object, create a platform devi=
ce. */
> >                  acpi_create_platform_device(device, NULL);
> >
> >
> >
> >
>

